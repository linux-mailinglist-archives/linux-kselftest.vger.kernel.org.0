Return-Path: <linux-kselftest+bounces-30412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6F0A824F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7C41742BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 12:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993425F991;
	Wed,  9 Apr 2025 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOim4KV8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A72253E4;
	Wed,  9 Apr 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201923; cv=none; b=Lpbr7GV6VnK5dtOQPdZP4wk+40whSu1BIZmhW9OQBhW0HM6haYnd4/NQV28rnagj5qLC+xEtHwT2po1FZ5lcOMJXXKraxW/ZJpPOLo5OECkj3NCQM2XLgYcxVYbu5FilPM7tK9wgktSJZJBNq5mqgRqBNp8jdIolkEkkZZlsseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201923; c=relaxed/simple;
	bh=hZ2Cj07yjlGkf6hkH99p9jg7xI/7m73szSaYkSGKZLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txU2uKm93U38k4buP7GjBarwbYWgeJufb/0ARj5xclwnWByr1UaypReHILSZ93T4lyC42dYEmcsOTTa2TslOfY7Ol+YsmNaHNmhju4qdrF7AgQXpPnofLlYV6ftxG9UdYZjop2k+ebm79CavAYzPd9R0plLo03ZLn7aHLiqXwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOim4KV8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744201921; x=1775737921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hZ2Cj07yjlGkf6hkH99p9jg7xI/7m73szSaYkSGKZLs=;
  b=DOim4KV8cGvZNjXEOSEtmmJEO+rWV1ieJ8R4R5jptcxHdn2VVRL5bEUm
   LWnHZWDuBSi6xTIwrzGDRH+UnQNUrfVpuluXAAERhsrhsUx536v+qlDN3
   BrkzPgkgxtIFATUYTsUEsWt3xEU6/VmHMSmkLcr89oU/v1vMnLkfFLsjd
   8YqNV8IzGHs9/g7he/xFQQZKNNab2zxXv8Z/zukWrZQvq0Ah20WuCf8Zo
   A353b+s3I7Ju2Ubn/s+1TvIK5RbMmDwTnAg3SbGEG/rtsmCp/dhZ4iaC2
   1uHuzqZNgX5nifTCs4r5KYOvsDYAX0Y/N9972hbVgydv/sefcKuiUTtI6
   w==;
X-CSE-ConnectionGUID: Mojx1zMkQmqqv8GHKgC9hg==
X-CSE-MsgGUID: nQqzHAM5RSqGhG2Ao/bF6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45796276"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45796276"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 05:32:00 -0700
X-CSE-ConnectionGUID: oE7fIlqHTEiwSYiaGl51pA==
X-CSE-MsgGUID: xvIeo7DsRmC+oDpG0e+a5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129530604"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Apr 2025 05:31:54 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2Uat-0008q7-1n;
	Wed, 09 Apr 2025 12:31:51 +0000
Date: Wed, 9 Apr 2025 20:30:52 +0800
From: kernel test robot <lkp@intel.com>
To: Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Louis Peens <louis.peens@corigine.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/6] xfrm: Add explicit dev to
 .xdo_dev_state_{add,delete,free}
Message-ID: <202504091346.cvaZAxVI-lkp@intel.com>
References: <20250407133542.2668491-5-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407133542.2668491-5-cratiu@nvidia.com>

Hi Cosmin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Cosmin-Ratiu/net-mlx5-Avoid-using-xso-real_dev-unnecessarily/20250407-214239
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250407133542.2668491-5-cratiu%40nvidia.com
patch subject: [PATCH net-next 4/6] xfrm: Add explicit dev to .xdo_dev_state_{add,delete,free}
config: hexagon-randconfig-002-20250408 (https://download.01.org/0day-ci/archive/20250409/202504091346.cvaZAxVI-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 92c93f5286b9ff33f27ff694d2dc33da1c07afdd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250409/202504091346.cvaZAxVI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504091346.cvaZAxVI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/bonding/bond_main.c:462: warning: Function parameter or struct member 'bond_dev' not described in 'bond_ipsec_add_sa'
>> drivers/net/bonding/bond_main.c:559: warning: Function parameter or struct member 'bond_dev' not described in 'bond_ipsec_del_sa'


vim +462 drivers/net/bonding/bond_main.c

1ddec5d0eec4b7 Hangbin Liu     2024-09-04  453  
18cb261afd7bf5 Jarod Wilson    2020-06-19  454  /**
18cb261afd7bf5 Jarod Wilson    2020-06-19  455   * bond_ipsec_add_sa - program device with a security association
18cb261afd7bf5 Jarod Wilson    2020-06-19  456   * @xs: pointer to transformer state struct
7681a4f58fb9c3 Leon Romanovsky 2023-01-24  457   * @extack: extack point to fill failure reason
18cb261afd7bf5 Jarod Wilson    2020-06-19  458   **/
1e4d9370eb7223 Cosmin Ratiu    2025-04-07  459  static int bond_ipsec_add_sa(struct net_device *bond_dev,
1e4d9370eb7223 Cosmin Ratiu    2025-04-07  460  			     struct xfrm_state *xs,
7681a4f58fb9c3 Leon Romanovsky 2023-01-24  461  			     struct netlink_ext_ack *extack)
18cb261afd7bf5 Jarod Wilson    2020-06-19 @462  {
907ed83a7583e8 Jianbo Liu      2024-08-23  463  	struct net_device *real_dev;
2aeeef906d5a52 Jianbo Liu      2024-08-23  464  	netdevice_tracker tracker;
9a5605505d9c7d Taehee Yoo      2021-07-05  465  	struct bond_ipsec *ipsec;
5cd24cbe7dca62 Jarod Wilson    2020-07-08  466  	struct bonding *bond;
5cd24cbe7dca62 Jarod Wilson    2020-07-08  467  	struct slave *slave;
b648eba4c69e58 Taehee Yoo      2021-07-05  468  	int err;
5cd24cbe7dca62 Jarod Wilson    2020-07-08  469  
5cd24cbe7dca62 Jarod Wilson    2020-07-08  470  	if (!bond_dev)
5cd24cbe7dca62 Jarod Wilson    2020-07-08  471  		return -EINVAL;
18cb261afd7bf5 Jarod Wilson    2020-06-19  472  
b648eba4c69e58 Taehee Yoo      2021-07-05  473  	rcu_read_lock();
5cd24cbe7dca62 Jarod Wilson    2020-07-08  474  	bond = netdev_priv(bond_dev);
f548a476268d62 Jarod Wilson    2020-07-08  475  	slave = rcu_dereference(bond->curr_active_slave);
2aeeef906d5a52 Jianbo Liu      2024-08-23  476  	real_dev = slave ? slave->dev : NULL;
2aeeef906d5a52 Jianbo Liu      2024-08-23  477  	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
105cd17a866017 Taehee Yoo      2021-07-05  478  	rcu_read_unlock();
2aeeef906d5a52 Jianbo Liu      2024-08-23  479  	if (!real_dev) {
2aeeef906d5a52 Jianbo Liu      2024-08-23  480  		err = -ENODEV;
2aeeef906d5a52 Jianbo Liu      2024-08-23  481  		goto out;
105cd17a866017 Taehee Yoo      2021-07-05  482  	}
105cd17a866017 Taehee Yoo      2021-07-05  483  
907ed83a7583e8 Jianbo Liu      2024-08-23  484  	if (!real_dev->xfrmdev_ops ||
907ed83a7583e8 Jianbo Liu      2024-08-23  485  	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
907ed83a7583e8 Jianbo Liu      2024-08-23  486  	    netif_is_bond_master(real_dev)) {
3fe57986271aee Leon Romanovsky 2023-01-24  487  		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
2aeeef906d5a52 Jianbo Liu      2024-08-23  488  		err = -EINVAL;
2aeeef906d5a52 Jianbo Liu      2024-08-23  489  		goto out;
18cb261afd7bf5 Jarod Wilson    2020-06-19  490  	}
18cb261afd7bf5 Jarod Wilson    2020-06-19  491  
2aeeef906d5a52 Jianbo Liu      2024-08-23  492  	ipsec = kmalloc(sizeof(*ipsec), GFP_KERNEL);
9a5605505d9c7d Taehee Yoo      2021-07-05  493  	if (!ipsec) {
2aeeef906d5a52 Jianbo Liu      2024-08-23  494  		err = -ENOMEM;
2aeeef906d5a52 Jianbo Liu      2024-08-23  495  		goto out;
9a5605505d9c7d Taehee Yoo      2021-07-05  496  	}
9a5605505d9c7d Taehee Yoo      2021-07-05  497  
907ed83a7583e8 Jianbo Liu      2024-08-23  498  	xs->xso.real_dev = real_dev;
1e4d9370eb7223 Cosmin Ratiu    2025-04-07  499  	err = real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs, extack);
9a5605505d9c7d Taehee Yoo      2021-07-05  500  	if (!err) {
9a5605505d9c7d Taehee Yoo      2021-07-05  501  		ipsec->xs = xs;
9a5605505d9c7d Taehee Yoo      2021-07-05  502  		INIT_LIST_HEAD(&ipsec->list);
2aeeef906d5a52 Jianbo Liu      2024-08-23  503  		mutex_lock(&bond->ipsec_lock);
9a5605505d9c7d Taehee Yoo      2021-07-05  504  		list_add(&ipsec->list, &bond->ipsec_list);
2aeeef906d5a52 Jianbo Liu      2024-08-23  505  		mutex_unlock(&bond->ipsec_lock);
9a5605505d9c7d Taehee Yoo      2021-07-05  506  	} else {
9a5605505d9c7d Taehee Yoo      2021-07-05  507  		kfree(ipsec);
9a5605505d9c7d Taehee Yoo      2021-07-05  508  	}
2aeeef906d5a52 Jianbo Liu      2024-08-23  509  out:
2aeeef906d5a52 Jianbo Liu      2024-08-23  510  	netdev_put(real_dev, &tracker);
b648eba4c69e58 Taehee Yoo      2021-07-05  511  	return err;
18cb261afd7bf5 Jarod Wilson    2020-06-19  512  }
18cb261afd7bf5 Jarod Wilson    2020-06-19  513  
9a5605505d9c7d Taehee Yoo      2021-07-05  514  static void bond_ipsec_add_sa_all(struct bonding *bond)
9a5605505d9c7d Taehee Yoo      2021-07-05  515  {
9a5605505d9c7d Taehee Yoo      2021-07-05  516  	struct net_device *bond_dev = bond->dev;
907ed83a7583e8 Jianbo Liu      2024-08-23  517  	struct net_device *real_dev;
9a5605505d9c7d Taehee Yoo      2021-07-05  518  	struct bond_ipsec *ipsec;
9a5605505d9c7d Taehee Yoo      2021-07-05  519  	struct slave *slave;
9a5605505d9c7d Taehee Yoo      2021-07-05  520  
2aeeef906d5a52 Jianbo Liu      2024-08-23  521  	slave = rtnl_dereference(bond->curr_active_slave);
2aeeef906d5a52 Jianbo Liu      2024-08-23  522  	real_dev = slave ? slave->dev : NULL;
2aeeef906d5a52 Jianbo Liu      2024-08-23  523  	if (!real_dev)
2aeeef906d5a52 Jianbo Liu      2024-08-23  524  		return;
9a5605505d9c7d Taehee Yoo      2021-07-05  525  
2aeeef906d5a52 Jianbo Liu      2024-08-23  526  	mutex_lock(&bond->ipsec_lock);
907ed83a7583e8 Jianbo Liu      2024-08-23  527  	if (!real_dev->xfrmdev_ops ||
907ed83a7583e8 Jianbo Liu      2024-08-23  528  	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
907ed83a7583e8 Jianbo Liu      2024-08-23  529  	    netif_is_bond_master(real_dev)) {
9a5605505d9c7d Taehee Yoo      2021-07-05  530  		if (!list_empty(&bond->ipsec_list))
907ed83a7583e8 Jianbo Liu      2024-08-23  531  			slave_warn(bond_dev, real_dev,
9a5605505d9c7d Taehee Yoo      2021-07-05  532  				   "%s: no slave xdo_dev_state_add\n",
9a5605505d9c7d Taehee Yoo      2021-07-05  533  				   __func__);
9a5605505d9c7d Taehee Yoo      2021-07-05  534  		goto out;
9a5605505d9c7d Taehee Yoo      2021-07-05  535  	}
9a5605505d9c7d Taehee Yoo      2021-07-05  536  
9a5605505d9c7d Taehee Yoo      2021-07-05  537  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
2aeeef906d5a52 Jianbo Liu      2024-08-23  538  		/* If new state is added before ipsec_lock acquired */
2aeeef906d5a52 Jianbo Liu      2024-08-23  539  		if (ipsec->xs->xso.real_dev == real_dev)
2aeeef906d5a52 Jianbo Liu      2024-08-23  540  			continue;
2aeeef906d5a52 Jianbo Liu      2024-08-23  541  
907ed83a7583e8 Jianbo Liu      2024-08-23  542  		ipsec->xs->xso.real_dev = real_dev;
1e4d9370eb7223 Cosmin Ratiu    2025-04-07  543  		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
1e4d9370eb7223 Cosmin Ratiu    2025-04-07  544  							     ipsec->xs, NULL)) {
907ed83a7583e8 Jianbo Liu      2024-08-23  545  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
9a5605505d9c7d Taehee Yoo      2021-07-05  546  			ipsec->xs->xso.real_dev = NULL;
9a5605505d9c7d Taehee Yoo      2021-07-05  547  		}
9a5605505d9c7d Taehee Yoo      2021-07-05  548  	}
9a5605505d9c7d Taehee Yoo      2021-07-05  549  out:
2aeeef906d5a52 Jianbo Liu      2024-08-23  550  	mutex_unlock(&bond->ipsec_lock);
9a5605505d9c7d Taehee Yoo      2021-07-05  551  }
9a5605505d9c7d Taehee Yoo      2021-07-05  552  
18cb261afd7bf5 Jarod Wilson    2020-06-19  553  /**
18cb261afd7bf5 Jarod Wilson    2020-06-19  554   * bond_ipsec_del_sa - clear out this specific SA
18cb261afd7bf5 Jarod Wilson    2020-06-19  555   * @xs: pointer to transformer state struct
18cb261afd7bf5 Jarod Wilson    2020-06-19  556   **/
1e4d9370eb7223 Cosmin Ratiu    2025-04-07  557  static void bond_ipsec_del_sa(struct net_device *bond_dev,
1e4d9370eb7223 Cosmin Ratiu    2025-04-07  558  			      struct xfrm_state *xs)
18cb261afd7bf5 Jarod Wilson    2020-06-19 @559  {
907ed83a7583e8 Jianbo Liu      2024-08-23  560  	struct net_device *real_dev;
2aeeef906d5a52 Jianbo Liu      2024-08-23  561  	netdevice_tracker tracker;
9a5605505d9c7d Taehee Yoo      2021-07-05  562  	struct bond_ipsec *ipsec;
5cd24cbe7dca62 Jarod Wilson    2020-07-08  563  	struct bonding *bond;
5cd24cbe7dca62 Jarod Wilson    2020-07-08  564  	struct slave *slave;
5cd24cbe7dca62 Jarod Wilson    2020-07-08  565  
5cd24cbe7dca62 Jarod Wilson    2020-07-08  566  	if (!bond_dev)
5cd24cbe7dca62 Jarod Wilson    2020-07-08  567  		return;
5cd24cbe7dca62 Jarod Wilson    2020-07-08  568  
a22c39b831a081 Taehee Yoo      2021-07-05  569  	rcu_read_lock();
5cd24cbe7dca62 Jarod Wilson    2020-07-08  570  	bond = netdev_priv(bond_dev);
f548a476268d62 Jarod Wilson    2020-07-08  571  	slave = rcu_dereference(bond->curr_active_slave);
2aeeef906d5a52 Jianbo Liu      2024-08-23  572  	real_dev = slave ? slave->dev : NULL;
2aeeef906d5a52 Jianbo Liu      2024-08-23  573  	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
2aeeef906d5a52 Jianbo Liu      2024-08-23  574  	rcu_read_unlock();
18cb261afd7bf5 Jarod Wilson    2020-06-19  575  
18cb261afd7bf5 Jarod Wilson    2020-06-19  576  	if (!slave)
a22c39b831a081 Taehee Yoo      2021-07-05  577  		goto out;
18cb261afd7bf5 Jarod Wilson    2020-06-19  578  
9a5605505d9c7d Taehee Yoo      2021-07-05  579  	if (!xs->xso.real_dev)
9a5605505d9c7d Taehee Yoo      2021-07-05  580  		goto out;
9a5605505d9c7d Taehee Yoo      2021-07-05  581  
907ed83a7583e8 Jianbo Liu      2024-08-23  582  	WARN_ON(xs->xso.real_dev != real_dev);
18cb261afd7bf5 Jarod Wilson    2020-06-19  583  
907ed83a7583e8 Jianbo Liu      2024-08-23  584  	if (!real_dev->xfrmdev_ops ||
907ed83a7583e8 Jianbo Liu      2024-08-23  585  	    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
907ed83a7583e8 Jianbo Liu      2024-08-23  586  	    netif_is_bond_master(real_dev)) {
907ed83a7583e8 Jianbo Liu      2024-08-23  587  		slave_warn(bond_dev, real_dev, "%s: no slave xdo_dev_state_delete\n", __func__);
a22c39b831a081 Taehee Yoo      2021-07-05  588  		goto out;
18cb261afd7bf5 Jarod Wilson    2020-06-19  589  	}
18cb261afd7bf5 Jarod Wilson    2020-06-19  590  
1e4d9370eb7223 Cosmin Ratiu    2025-04-07  591  	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
a22c39b831a081 Taehee Yoo      2021-07-05  592  out:
2aeeef906d5a52 Jianbo Liu      2024-08-23  593  	netdev_put(real_dev, &tracker);
2aeeef906d5a52 Jianbo Liu      2024-08-23  594  	mutex_lock(&bond->ipsec_lock);
9a5605505d9c7d Taehee Yoo      2021-07-05  595  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
9a5605505d9c7d Taehee Yoo      2021-07-05  596  		if (ipsec->xs == xs) {
9a5605505d9c7d Taehee Yoo      2021-07-05  597  			list_del(&ipsec->list);
9a5605505d9c7d Taehee Yoo      2021-07-05  598  			kfree(ipsec);
9a5605505d9c7d Taehee Yoo      2021-07-05  599  			break;
9a5605505d9c7d Taehee Yoo      2021-07-05  600  		}
9a5605505d9c7d Taehee Yoo      2021-07-05  601  	}
2aeeef906d5a52 Jianbo Liu      2024-08-23  602  	mutex_unlock(&bond->ipsec_lock);
9a5605505d9c7d Taehee Yoo      2021-07-05  603  }
9a5605505d9c7d Taehee Yoo      2021-07-05  604  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

