import sbt._

val projectName = "blaze-product-merge-spark-jobs"
name := projectName

scalaVersion := "2.11.12"

ivyScala := ivyScala.value map {
  _.copy(overrideScalaVersion = true)
}

resolvers += Resolver.bintrayRepo("cakesolutions", "maven")
resolvers += Resolver.sonatypeRepo("releases")
resolvers += "Spark metrics" at "https://raw.github.com/banzaicloud/spark-metrics/master/maven-repo/releases"

addCompilerPlugin("org.scalamacros" % "paradise" % "2.1.1" cross CrossVersion.full)
addCompilerPlugin("org.spire-math" %% "kind-projector" % "0.9.8")

scalacOptions := Seq(
  "-unchecked",
  "-deprecation",
  "-encoding", "utf8",
  "-target:jvm-1.8",
  "-feature",
  "-language:_",
  "-Xlint",
  "-Ywarn-dead-code",
  "-Yno-adapted-args",
  "-Ywarn-numeric-widen",
  "-Ywarn-value-discard",
  "-Xlog-reflective-calls",
  "-Xfuture"
)

val sparkVersion = "2.3.1"
val jacksonVersion = "2.9.5"
val catsVersion = "1.3.1"
val framelessVersion = "0.6.1"

val sparkCoreDep = "org.apache.spark" %% "spark-core" % sparkVersion % Provided
val sparkSql = "org.apache.spark" %% "spark-sql" % sparkVersion % Provided
val sparkKafka = "org.apache.spark" %% "spark-sql-kafka-0-10" % sparkVersion % Provided

val scoptDep = "com.github.scopt" %% "scopt" % "3.7.0"

val scalaTest = "org.scalatest" %% "scalatest" % "3.0.5" % Test
val scalaMock = "org.scalamock" %% "scalamock" % "4.1.0" % Test
val swayDb = "io.swaydb" %% "swaydb" % "0.6" % Test
val dockerIt = "com.rfs" %% "blaze-lib-docker-it" % "4.0.1" % Test exclude("com.datastax.cassandra", "cassandra-driver-core")

val simpleClient = "io.prometheus" % "simpleclient" % "0.5.0"
val simpleClientDw = "io.prometheus" % "simpleclient_dropwizard" % "0.5.0"
val simpleClientPush = "io.prometheus" % "simpleclient_pushgateway" % "0.5.0"
val catsEffect = "org.typelevel" %% "cats-effect" % "1.0.0"

val lz4 = "org.lz4" % "lz4-java" % "1.4.0"
val catsCore = "org.typelevel" %% "cats-core" % catsVersion

val simulacrum = "com.github.mpilquist" %% "simulacrum" % "0.14.0" % Compile
val oslib = "com.lihaoyi" %% "os-lib" % "0.2.2"

val sprayJson = "io.spray" %% "spray-json" % "1.3.5"
dependencyOverrides += "com.fasterxml.jackson.core" % "jackson-core" % jacksonVersion
dependencyOverrides += "com.fasterxml.jackson.core" % "jackson-databind" % jacksonVersion
dependencyOverrides += "com.fasterxml.jackson.module" % "jackson-module-scala_2.11" % jacksonVersion
dependencyOverrides += lz4


libraryDependencies ++= Seq(
  sparkCoreDep,
  sparkKafka,
  sparkSql,
  scoptDep,
  scalaTest,
  dockerIt,
  simpleClient,
  simpleClientDw,
  simpleClientPush,
  lz4,
  catsCore,
  catsEffect,
  simulacrum,
  swayDb,
  oslib,
  sprayJson
)

testOptions in Test += Tests.Setup(classLoader =>
  try {
    classLoader
      .loadClass("org.slf4j.LoggerFactory")
      .getMethod("getLogger", classLoader.loadClass("java.lang.String"))
      .invoke(null, "ROOT")
  } catch {
    case e: Exception =>
  }
)

dependencyDotFile := file("dependencies.dot")

parallelExecution in Test := false

val debug = Seq("-Dkamon.auto-start=true", "-Xdebug", "-Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=127.0.0.1:9999")
// Run things in a forked JVM, so we can set the options below.
fork in run := true
fork in Test := true
javaOptions in Test := debug

version in assembly := "dirty"

mainClass in Compile := Some("rfs.blaze.files.processor.cmd.Job")

enablePlugins(blaze.sbt.service.BuildInfoPlugin/*, BlazeLibPlugin*/)

addArtifact(Artifact(projectName, "assembly"), sbtassembly.AssemblyKeys.assembly)

assemblyMergeStrategy in assembly := {
  case PathList("META-INF", xs@_*) => MergeStrategy.discard
  case _                           => MergeStrategy.last
}

run in Compile := Defaults.runTask(fullClasspath in Compile, mainClass in(Compile, run), runner in(Compile, run)).evaluated

assemblyShadeRules in assembly := Seq(
  ShadeRule.rename("io.prometheus.client.**" -> "build_simpleclient.@1").inAll,
  ShadeRule.rename("com.fasterxml.jackson.**" -> "build_jackson.@1").inAll
)

coverageHighlighting := false

coverageExcludedPackages := "<empty>;.*\\.Job"
test in assembly := {}
