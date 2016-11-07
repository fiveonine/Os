$dir=$args[0]

(Get-ChildItem $dir -Recurse | Where-Object {$_.name -match '[a-zA-ZÆØÅזרו]'}).name