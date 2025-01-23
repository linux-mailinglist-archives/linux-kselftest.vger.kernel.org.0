Return-Path: <linux-kselftest+bounces-24976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE5A19E85
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 07:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9D4188B6F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 06:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A561C1AB4;
	Thu, 23 Jan 2025 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7bh4qhc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785929B0;
	Thu, 23 Jan 2025 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737614640; cv=none; b=irrXlojQyFFUT140MSvOBt1jhkRD8M3IUyhnZFJOHRyMwk8cKcBigPIJLhKsR4SxwBFxyqdoKFTgttoSvGoO6qI8XaS7VYJ8gWnfcjd4X845Mo0HV7uRMZsEewDOdmKUqrr5+6bEb9Onb5XaKju7boEWivH5yEPrkCGNyrBxcAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737614640; c=relaxed/simple;
	bh=JktmtjqieTPQYIl1v06VLfluuGdkKBGUSRhw3p37YK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi+WXb6jip6O/0F7uyHq/RdeZa6AxHuRrGf9oJXqAcIp2HuBL08Pj690/PDQWUKLRSKASuB3UWJCrWc5llrIY6DI7t2GmRFaUNRsNqD0rsCmse/lth5tfvILX4aZ6Rj5XRTGcvvdzuKDIi+nYA2ASlYGH4G14fk2lBh8CNpAuik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7bh4qhc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737614638; x=1769150638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JktmtjqieTPQYIl1v06VLfluuGdkKBGUSRhw3p37YK0=;
  b=O7bh4qhcq3A4TG8sEpWn2fVj40C02ffQ2iSkNXivdW50pWh+3frStA5e
   6AfIPVNqxMseQrkS4nY2S1PR/pr5yNR0f4gPD8rfUB4QzA9Zp7e5AyuPP
   5qQT2H9I1s3A+BaYuH37qzjwluN8pSUpSj1rpt7WfLccL/YAzuagTXYBY
   NO3bJN41at1TZQKjEYsK/64UqwqVwZkaPzPZj6opiqcY3AoSfl8VOBsDY
   K/zVIfY4P9oWD70XaD8Q5cU1Ii4JcZKF69TA2YZ2Voo7CFALDiFWQirnz
   JO2Q5dFoGnxrYoNv4x08lmaJKpxWDvkPW4u4ucTPo9Py6wZD6uas3G9Zq
   g==;
X-CSE-ConnectionGUID: cxosbnVqRGKo0Wkvv0OyzQ==
X-CSE-MsgGUID: fPRkA9KbTOOjhUAvEaQczw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="25699354"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="25699354"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:43:57 -0800
X-CSE-ConnectionGUID: F9FmDasxQgqi/8cbU9OU/w==
X-CSE-MsgGUID: Q0VSwLxLRluQdw7gRhNw9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="107365151"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:43:54 -0800
Date: Thu, 23 Jan 2025 07:40:29 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	syzbot+2e5de9e3ab986b71d2bf@syzkaller.appspotmail.com,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] net: netdevsim: try to close UDP port harness races
Message-ID: <Z5HkXdx3w9aMsozu@mev-dev.igk.intel.com>
References: <20250122224503.762705-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122224503.762705-1-kuba@kernel.org>

On Wed, Jan 22, 2025 at 02:45:03PM -0800, Jakub Kicinski wrote:
> syzbot discovered that we remove the debugfs files after we free
> the netdev. Try to clean up the relevant dir while the device
> is still around.
> 
> Reported-by: syzbot+2e5de9e3ab986b71d2bf@syzkaller.appspotmail.com
> Fixes: 424be63ad831 ("netdevsim: add UDP tunnel port offload support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  drivers/net/netdevsim/netdevsim.h             |  1 +
>  drivers/net/netdevsim/udp_tunnels.c           | 23 +++++++++++--------
>  .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 16 ++++++-------
>  3 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index dcf073bc4802..96d54c08043d 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -134,6 +134,7 @@ struct netdevsim {
>  		u32 sleep;
>  		u32 __ports[2][NSIM_UDP_TUNNEL_N_PORTS];
>  		u32 (*ports)[NSIM_UDP_TUNNEL_N_PORTS];
> +		struct dentry *ddir;
>  		struct debugfs_u32_array dfs_ports[2];
>  	} udp_ports;
>  
> diff --git a/drivers/net/netdevsim/udp_tunnels.c b/drivers/net/netdevsim/udp_tunnels.c
> index 02dc3123eb6c..640b4983a9a0 100644
> --- a/drivers/net/netdevsim/udp_tunnels.c
> +++ b/drivers/net/netdevsim/udp_tunnels.c
> @@ -112,9 +112,11 @@ nsim_udp_tunnels_info_reset_write(struct file *file, const char __user *data,
>  	struct net_device *dev = file->private_data;
>  	struct netdevsim *ns = netdev_priv(dev);
>  
> -	memset(ns->udp_ports.ports, 0, sizeof(ns->udp_ports.__ports));
>  	rtnl_lock();
> -	udp_tunnel_nic_reset_ntf(dev);
> +	if (dev->reg_state == NETREG_REGISTERED) {
> +		memset(ns->udp_ports.ports, 0, sizeof(ns->udp_ports.__ports));
> +		udp_tunnel_nic_reset_ntf(dev);
> +	}
>  	rtnl_unlock();
>  
>  	return count;
> @@ -144,23 +146,23 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
>  	else
>  		ns->udp_ports.ports = nsim_dev->udp_ports.__ports;
>  
> -	debugfs_create_u32("udp_ports_inject_error", 0600,
> -			   ns->nsim_dev_port->ddir,
> +	ns->udp_ports.ddir = debugfs_create_dir("udp_ports",
> +						ns->nsim_dev_port->ddir);
> +
> +	debugfs_create_u32("inject_error", 0600, ns->udp_ports.ddir,
>  			   &ns->udp_ports.inject_error);
>  
>  	ns->udp_ports.dfs_ports[0].array = ns->udp_ports.ports[0];
>  	ns->udp_ports.dfs_ports[0].n_elements = NSIM_UDP_TUNNEL_N_PORTS;
> -	debugfs_create_u32_array("udp_ports_table0", 0400,
> -				 ns->nsim_dev_port->ddir,
> +	debugfs_create_u32_array("table0", 0400, ns->udp_ports.ddir,
>  				 &ns->udp_ports.dfs_ports[0]);
>  
>  	ns->udp_ports.dfs_ports[1].array = ns->udp_ports.ports[1];
>  	ns->udp_ports.dfs_ports[1].n_elements = NSIM_UDP_TUNNEL_N_PORTS;
> -	debugfs_create_u32_array("udp_ports_table1", 0400,
> -				 ns->nsim_dev_port->ddir,
> +	debugfs_create_u32_array("table1", 0400, ns->udp_ports.ddir,
>  				 &ns->udp_ports.dfs_ports[1]);
>  
> -	debugfs_create_file("udp_ports_reset", 0200, ns->nsim_dev_port->ddir,
> +	debugfs_create_file("reset", 0200, ns->udp_ports.ddir,
>  			    dev, &nsim_udp_tunnels_info_reset_fops);
>  
>  	/* Note: it's not normal to allocate the info struct like this!
> @@ -196,6 +198,9 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
>  
>  void nsim_udp_tunnels_info_destroy(struct net_device *dev)
>  {
> +	struct netdevsim *ns = netdev_priv(dev);
> +
> +	debugfs_remove_recursive(ns->udp_ports.ddir);
>  	kfree(dev->udp_tunnel_nic_info);
>  	dev->udp_tunnel_nic_info = NULL;
>  }
> diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
> index 384cfa3d38a6..92c2f0376c08 100755
> --- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
> +++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
> @@ -142,7 +142,7 @@ function pre_ethtool {
>  }
>  
>  function check_table {
> -    local path=$NSIM_DEV_DFS/ports/$port/udp_ports_table$1
> +    local path=$NSIM_DEV_DFS/ports/$port/udp_ports/table$1
>      local -n expected=$2
>      local last=$3
>  
> @@ -212,7 +212,7 @@ function check_tables {
>  }
>  
>  function print_table {
> -    local path=$NSIM_DEV_DFS/ports/$port/udp_ports_table$1
> +    local path=$NSIM_DEV_DFS/ports/$port/udp_ports/table$1
>      read -a have < $path
>  
>      tree $NSIM_DEV_DFS/
> @@ -641,7 +641,7 @@ for port in 0 1; do
>      NSIM_NETDEV=`get_netdev_name old_netdevs`
>      ip link set dev $NSIM_NETDEV up
>  
> -    echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
> +    echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports/inject_error
>  
>      msg="1 - create VxLANs v6"
>      exp0=( 0 0 0 0 )
> @@ -663,7 +663,7 @@ for port in 0 1; do
>      new_geneve gnv0 20000
>  
>      msg="2 - destroy GENEVE"
> -    echo 2 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
> +    echo 2 > $NSIM_DEV_DFS/ports/$port/udp_ports/inject_error
>      exp1=( `mke 20000 2` 0 0 0 )
>      del_dev gnv0
>  
> @@ -764,7 +764,7 @@ for port in 0 1; do
>      msg="create VxLANs v4"
>      new_vxlan vxlan0 10000 $NSIM_NETDEV
>  
> -    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
> +    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
>      check_tables
>  
>      msg="NIC device goes down"
> @@ -775,7 +775,7 @@ for port in 0 1; do
>      fi
>      check_tables
>  
> -    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
> +    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
>      check_tables
>  
>      msg="NIC device goes up again"
> @@ -789,7 +789,7 @@ for port in 0 1; do
>      del_dev vxlan0
>      check_tables
>  
> -    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
> +    echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
>      check_tables
>  
>      msg="destroy NIC"
> @@ -896,7 +896,7 @@ msg="vacate VxLAN in overflow table"
>  exp0=( `mke 10000 1` `mke 10004 1` 0 `mke 10003 1` )
>  del_dev vxlan2
>  
> -echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports_reset
> +echo 1 > $NSIM_DEV_DFS/ports/$port/udp_ports/reset
>  check_tables
>  
>  msg="tunnels destroyed 2"

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.48.1

