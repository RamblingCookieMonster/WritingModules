# Writing PowerShell Modules

## Materials

* [Modules PowerPoint](modules.pptx)
* [Plaster template](ModulePracticesExample)
* [Use the Plaster template](Demo.ps1)

An important note:  The content of this session made implicit assumptions, for better or worse.  For example, _It should be available on the PowerShell Gallery_ (or an internal repository) requires that you use a proper module manifest

## References

These references were directly mentioned or used in coming up with the _Writing PowerShell Modules: Tips, Tools, and Best Practices_ session at the 2017 PowerShell + DevOps Global Summit, or just related to the topic : )

### Interesting Community Module Designs

* [SampleModule](https://github.com/gaelcolas/SampleModule) - Still in development, but watch for a Plaster template
* [PoshBot](https://github.com/poshbotio/PoshBot)
* [Posh-Teamviewer](https://github.com/gerane/Posh-Teamviewer)
* [PSDeploy](https://github.com/RamblingCookieMonster/PSDeploy)

And many more.  Poke around other community modules to see what folks are doing!

### Module Building Tools

* [Plaster](https://github.com/PowerShell/Plaster) - Microsoft's module - I'd recommend this module building tool over any others going forward
* [PSModuleBuild](https://github.com/zloeber/PSModuleBuild)
* [ConvertTo-Module](https://github.com/martin9700/ConvertTo-Module)

### Tools and References

Getting and publishing modules:

* [PowerShellGet, PackageManagement](https://www.powershellgallery.com/)
* [NuGet](https://dist.nuget.org/index.html)
* [PSDepend](https://github.com/RamblingCookieMonster/PSDepend)
* [PSDeploy](https://github.com/RamblingCookieMonster/PSDeploy)

Package repositories:

* [PSPrivateGallery](https://github.com/PowerShell/PSPrivateGallery) - Internal PowerShell Gallery.  Not production ready...
* [ProGet](https://inedo.com/proget)
* [Artifactory](https://www.jfrog.com/artifactory/)
* [Chocolatey.Server](https://chocolatey.org/docs/how-to-host-feed) - link includes other examples

Source control and related tooling:

* [GitHub](https://github.com/) - Recommended for public projects.  Many folks have auth, many tools integrate, PowerShell team uses it
* [GitLab](https://about.gitlab.com/products/) - Community edition is fantastic, enables CI
* [VSTS](https://www.visualstudio.com/team-services/) - If you already paid for it.  Personally not a fan of build systems that aren't defined in code

Example tools that integrate with GitHub:

* [Gitter](https://gitter.im) - chat specifically for a project, allows GitHub auth
* [ZenHub](https://www.zenhub.com/), [Waffle.io](https://waffle.io/), etc.
* [Octotree](https://github.com/buunguyen/octotree)

Avoid fun with maml, xml:

* [Platyps](https://github.com/PowerShell/platyPS) - Generate documentation from markdown, and vice versa
* [EZOut](https://github.com/StartAutomating/EZOut) - Simplify writing format files.  Alternatively, just poke around other folks' psm1xml

Mentioned during tips on functions, and making it feel PowerShell-y:

* [Monad Manifesto](www.jsnover.com/Docs/MonadManifesto.pdf) - Just read it
* [Building PowerShell Functions - Best Practices](https://ramblingcookiemonster.wordpress.com/2013/12/08/building-powershell-functions-best-practices/) - Includes a number of references on writing functions

Discussions on module design:

* [PowerShellPracticeAndStyle issue #22](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/22)
* [PowerShellPracticeAndStyle issue #59](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/59)
* [Plaster issue #2](https://github.com/PowerShell/Plaster/issues/2)
* [Twitter discussion on dot sourcing](https://twitter.com/bielawb/status/831266955889872898)

Linting and testing:

* [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) - Linting, I guess?  Static code checker
* [Pester](https://github.com/pester/Pester)
* [Poshspec](https://github.com/Ticketmaster/poshspec)

CI/CD - Run your tests, among other things:

* [AppVeyor](https://www.appveyor.com/) - Free, perfect for public PowerShell modules
* [GitLab CE CI](https://docs.gitlab.com/ce/ci/)
* [Jenkins](https://jenkins.io/)
* [VSTS](https://www.visualstudio.com/team-services/) - If you already paid for it.  Maybe.  Personally not a fan of build systems that aren't defined in code
* [Invoke-Build](https://github.com/nightroman/Invoke-Build)Used in an example of non-PowerShelly authoring.  Awesome for users, harder for contributors
* [Psake](https://github.com/psake/psake) - Not as much functionality as Invoke-Build, and was dead, but this might change...

On module and function design, among other things:

* [Module Design Rules](https://github.com/RamblingCookieMonster/RamblingCookieMonster.github.io/blob/master/images/module/PSSummit2014-Freiheit-ModuleDesignRules.pptx?raw=true) - This is from the 2014 PowerShell Summit, thanks to Kirk Freiheit
* [Writing about_help topics](http://info.sapien.com/index.php/scripting/scripting-help/how-to-write-about-help-for-your-module)
* [Further Down the Rabbit Hole: PowerShell Modules and Encapsulation](https://www.simple-talk.com/dotnet/.net-tools/further-down-the-rabbit-hole-powershell-modules-and-encapsulation/)
* [How to Write a Module Manifest](https://msdn.microsoft.com/en-us/library/dd878297)
* [Understanding a Windows PowerShell Module](https://msdn.microsoft.com/en-us/library/dd878324.aspx)
* [about_Modules](https://msdn.microsoft.com/powershell/reference/5.1/Microsoft.PowerShell.Core/about/about_Modules) (swap out 5.1 with 3.0 or up)
* [Learn PowerShell Toolmaking in a Month of Lunches](https://www.manning.com/books/learn-powershell-toolmaking-in-a-month-of-lunches)
* [The PowerShell Scripting and Toolmaking Book](https://leanpub.com/powershell-scripting-toolmaking)
* [Free eBook on PowerShell Advanced Functions](http://mikefrobbins.com/2015/04/17/free-ebook-on-powershell-advanced-functions/)
* [The PowerShell Best Practices and Style Guide](https://github.com/PoshCode/PowerShellPracticeAndStyle) - issues like [#22](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/22) and [#59](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/59)
* Plaster issues, including [#2](https://github.com/PowerShell/Plaster/issues/2)
* [Building a PowerShell Module](http://ramblingcookiemonster.github.io/Building-A-PowerShell-Module/) - A practical example

Misc:

* [Semantic Versioning](http://semver.org/)
* [Choose A License](https://choosealicense.com/)
