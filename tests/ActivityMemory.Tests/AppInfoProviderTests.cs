using ActivityMemory.Core;
using Xunit;

namespace ActivityMemory.Tests;

public class AppInfoProviderTests
{
    [Fact]
    public void GetAppInfo_ReturnsExpectedName()
    {
        var provider = new AppInfoProvider();

        var info = provider.GetAppInfo();

        Assert.Equal("ActivityMemory", info.Name);
    }

    [Fact]
    public void GetAppInfo_ReturnsVersion()
    {
        var provider = new AppInfoProvider();

        var info = provider.GetAppInfo();

        Assert.False(string.IsNullOrWhiteSpace(info.Version));
    }
}
