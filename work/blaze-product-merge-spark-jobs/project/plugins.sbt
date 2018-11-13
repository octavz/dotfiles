resolvers += Resolver.url("blaze-plugin-releases", url("https://dl.bintray.com/blaze-plugins/releases"))(Resolver.ivyStylePatterns)

logLevel := Level.Warn

addSbtPlugin("rfs.blaze" %% "sbt-blaze" % "1.5.3")

addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.3")

addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.8.2")

addSbtPlugin("org.scalastyle" %% "scalastyle-sbt-plugin" % "0.7.0")

addSbtPlugin("de.heikoseeberger" % "sbt-header" % "1.5.0")

