# manage_swap.sh
1. 它可以让您一键添加或删除Swap虚拟内存，具体取决于您选择的操作。这个脚本将检查当前系统上是否已存在Swap，如果存在，则允许您删除它；如果不存在，则允许您创建并启用Swap。在运行脚本之前，请确保以管理员权限登录到系统。
2. 如果系统中已存在Swap分区，脚本将允许您选择删除它。
3. 如果系统中不存在Swap分区，脚本将提示您输入要创建的Swap文件大小（以MB为单位）。
4. 脚本将创建Swap文件、设置文件权限、创建Swap文件系统、启用Swap，并在 /etc/fstab 中添加条目以确保系统在启动时自动启用Swap。
5. 请注意，Swap的大小取决于您的系统性能和需求，不要过度使用Swap，以免影响性能。
```bash
curl -sS -O https://raw.githubusercontent.com/cdygkj/manage_swap.sh/main/manage.swap.sh && chmod +x manage.swap.sh && ./manage.swap.sh
```
