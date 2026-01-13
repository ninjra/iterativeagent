namespace ActivityMemory.Core;

public sealed record AppInfo(string Name, string Version);

public interface IAppInfoProvider
{
    AppInfo GetAppInfo();
}

public sealed class AppInfoProvider : IAppInfoProvider
{
    public AppInfo GetAppInfo() => new("ActivityMemory", "0.1.0");
}
