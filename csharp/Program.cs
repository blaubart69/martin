using System;
using System.IO;
using System.Linq;

namespace csharp
{
    class Program
    {
        static void Main(string[] args)
        {
            var result = File.ReadLines(args[0])
            .Select( line => line.Split(';') )
            .SelectMany( records => records )
            .Where( line => ! String.IsNullOrEmpty(line) )
            .Select( record => {
                var a = record.Split(' ');
                string versionWithoutSuffix = a[1].Split('+')[0];
                return new {
                    Name    = a[0].ToUpper(),
                    Version = a[1],
                    VersionSortable = String.Join(String.Empty, 
                        versionWithoutSuffix
                        .Split('.')
                        .Select( t => t.PadLeft(5,'0')))
                }; })
            .OrderBy         ( r => r.Name)
            .ThenByDescending( r => r.VersionSortable)
            .GroupBy         ( r => r.Name );
            
            foreach ( var r in result)
            {
                Console.WriteLine($"{r.Key,-40}\t{r.First().Version}");
            }
        }
    }
}
