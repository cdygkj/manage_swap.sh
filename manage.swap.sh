#!/bin/bash

# 检查是否以root权限运行
if [ "$EUID" -ne 0 ]; then
  echo "请以root权限运行此脚本"
  exit 1
fi

# 检查系统中是否已存在Swap
if grep -q "swap" /etc/fstab; then
  echo "系统中已存在Swap分区。"
  echo "1. 删除现有Swap分区"
  echo "2. 退出"
  read -p "请选择要执行的操作 [1/2]: " choice

  case $choice in
    1)
      # 删除现有Swap
      swapoff -a
      sed -i '/swap/d' /etc/fstab
      echo "现有Swap已删除。"
      ;;
    2)
      echo "未进行任何操作。"
      ;;
    *)
      echo "无效的选项。"
      ;;
  esac
else
  # 提示用户输入要创建的Swap文件大小（以MB为单位）
  read -p "请输入要创建的Swap文件大小（以MB为单位）: " swap_size

  # 创建Swap文件
  dd if=/dev/zero of=/swapfile bs=1M count=$swap_size

  # 设置文件权限
  chmod 600 /swapfile

  # 创建Swap文件系统
  mkswap /swapfile

  # 启用Swap
  swapon /swapfile

  # 更新/etc/fstab，以确保系统在启动时自动启用Swap
  echo "/swapfile none swap sw 0 0" >> /etc/fstab

  echo "Swap文件创建成功，大小为 ${swap_size}MB。"
fi

# 显示当前Swap信息
free -h

echo "脚本执行完毕。"
