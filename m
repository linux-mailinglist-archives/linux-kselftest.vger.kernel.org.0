Return-Path: <linux-kselftest+bounces-22426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A39D54ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 22:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030B91F214EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 21:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C341DDC3D;
	Thu, 21 Nov 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNFcApkC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C71DBB19;
	Thu, 21 Nov 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225505; cv=none; b=R33sdyZoXyCKDyPFYavTW9tUrhzKtcIj3NC7HACs1Jdae7o7+WQYbYfIkJC0AjlP+hDcwgm7VUjwNMkOe1gwHKa6m0L4VkANTYEtITtImU0UT3zgOXd90rISlyKgh5YNQ2DQgqtWySgAYoAdIfzmAZXfLTFElKUr4J0/+rONMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225505; c=relaxed/simple;
	bh=NIUcN6+T+wki60rCRnwepyQ8KRF0PBbMkb47VLXLqKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVjNpgzoCzoV3P1SY4M70VTAZDlaKb1VAwsEM1ItD1jSqnZ8oEk4WbA4Yunuk6z/XrGBwY98cbCOG6yyN8Y5LUwzUJUxn2ke5vVrTyBL2hpXx5sUPfyED/Yex9E+kuvhjlDku0JhfrIeEnH7gxMJTIFYcRdTDLF3XzpUc0yYB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNFcApkC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732225504; x=1763761504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIUcN6+T+wki60rCRnwepyQ8KRF0PBbMkb47VLXLqKM=;
  b=BNFcApkCceVM9sS7dM7XHFFI8lIuy0mmm3XqLpRVhM+3qy5qt7P8kU4T
   f/8rIOxMJXlnwqnAi+F/DijxT8xYFwtyGKOLXSj+8Tb23nEbIwvBWQewe
   cFUuZd92N6PDupXXYMyNHL+GuBAQExGC+OITiX7sY8pwYweFr45jgh2p1
   6ArBuuiGy1vRY6YcTCdIeuNsjVizmxfhe0ZtF/V4MN5DveTlaWvScF5Rt
   7m/pbMhsNuxyC8wQ256oABy1O6lp+x9sVy6QFMHLOSQ6sVLGvcLzF0T5B
   nDnRm8CHu7/JpKQSCWQzAva8/7hLpyH4mPx+Efl2AhMNXL47O4aZBD7+8
   w==;
X-CSE-ConnectionGUID: UGYcYd7LRrqR+VMlrOAW0g==
X-CSE-MsgGUID: oCnwJEQ7Rc6PzIy/7uIaPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32514204"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32514204"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:45:01 -0800
X-CSE-ConnectionGUID: xdpPO1RmQrC72kpFCsgzmg==
X-CSE-MsgGUID: zhZedUIBSeupQFYJAgkZ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90753178"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 Nov 2024 13:44:56 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEEyr-0003O1-1A;
	Thu, 21 Nov 2024 21:44:53 +0000
Date: Fri, 22 Nov 2024 05:43:56 +0800
From: kernel test robot <lkp@intel.com>
To: Xiao Liang <shaw.leon@gmail.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/5] rtnetlink: Decouple net namespaces in
 rtnl_newlink_create()
Message-ID: <202411220516.rokej98E-lkp@intel.com>
References: <20241118143244.1773-4-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118143244.1773-4-shaw.leon@gmail.com>

Hi Xiao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiao-Liang/net-ip_tunnel-Build-flow-in-underlay-net-namespace/20241121-112705
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241118143244.1773-4-shaw.leon%40gmail.com
patch subject: [PATCH net-next v4 3/5] rtnetlink: Decouple net namespaces in rtnl_newlink_create()
config: arc-randconfig-002-20241122 (https://download.01.org/0day-ci/archive/20241122/202411220516.rokej98E-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220516.rokej98E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220516.rokej98E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/batman-adv/soft-interface.c:1075: warning: Function parameter or struct member 'params' not described in 'batadv_softif_newlink'
>> net/batman-adv/soft-interface.c:1075: warning: Excess function parameter 'nets' description in 'batadv_softif_newlink'
>> net/batman-adv/soft-interface.c:1075: warning: Excess function parameter 'dev' description in 'batadv_softif_newlink'
>> net/batman-adv/soft-interface.c:1075: warning: Excess function parameter 'tb' description in 'batadv_softif_newlink'
>> net/batman-adv/soft-interface.c:1075: warning: Excess function parameter 'data' description in 'batadv_softif_newlink'
>> net/batman-adv/soft-interface.c:1075: warning: Excess function parameter 'extack' description in 'batadv_softif_newlink'


vim +1075 net/batman-adv/soft-interface.c

128254ceea6ffe Sven Eckelmann 2020-10-11  1063  
128254ceea6ffe Sven Eckelmann 2020-10-11  1064  /**
128254ceea6ffe Sven Eckelmann 2020-10-11  1065   * batadv_softif_newlink() - pre-initialize and register new batadv link
c19808cb1d05d1 Xiao Liang     2024-11-18  1066   * @nets: the applicable net namespaces
128254ceea6ffe Sven Eckelmann 2020-10-11  1067   * @dev: network device to register
128254ceea6ffe Sven Eckelmann 2020-10-11  1068   * @tb: IFLA_INFO_DATA netlink attributes
128254ceea6ffe Sven Eckelmann 2020-10-11  1069   * @data: enum batadv_ifla_attrs attributes
128254ceea6ffe Sven Eckelmann 2020-10-11  1070   * @extack: extended ACK report struct
128254ceea6ffe Sven Eckelmann 2020-10-11  1071   *
128254ceea6ffe Sven Eckelmann 2020-10-11  1072   * Return: 0 if successful or error otherwise.
128254ceea6ffe Sven Eckelmann 2020-10-11  1073   */
c19808cb1d05d1 Xiao Liang     2024-11-18  1074  static int batadv_softif_newlink(struct rtnl_newlink_params *params)
128254ceea6ffe Sven Eckelmann 2020-10-11 @1075  {
c19808cb1d05d1 Xiao Liang     2024-11-18  1076  	struct net_device *dev = params->dev;
c19808cb1d05d1 Xiao Liang     2024-11-18  1077  	struct nlattr **data = params->data;
a5ad457eea41ef Sven Eckelmann 2020-10-11  1078  	struct batadv_priv *bat_priv = netdev_priv(dev);
a5ad457eea41ef Sven Eckelmann 2020-10-11  1079  	const char *algo_name;
a5ad457eea41ef Sven Eckelmann 2020-10-11  1080  	int err;
a5ad457eea41ef Sven Eckelmann 2020-10-11  1081  
a5ad457eea41ef Sven Eckelmann 2020-10-11  1082  	if (data && data[IFLA_BATADV_ALGO_NAME]) {
a5ad457eea41ef Sven Eckelmann 2020-10-11  1083  		algo_name = nla_data(data[IFLA_BATADV_ALGO_NAME]);
a5ad457eea41ef Sven Eckelmann 2020-10-11  1084  		err = batadv_algo_select(bat_priv, algo_name);
a5ad457eea41ef Sven Eckelmann 2020-10-11  1085  		if (err)
a5ad457eea41ef Sven Eckelmann 2020-10-11  1086  			return -EINVAL;
a5ad457eea41ef Sven Eckelmann 2020-10-11  1087  	}
a5ad457eea41ef Sven Eckelmann 2020-10-11  1088  
128254ceea6ffe Sven Eckelmann 2020-10-11  1089  	return register_netdevice(dev);
128254ceea6ffe Sven Eckelmann 2020-10-11  1090  }
128254ceea6ffe Sven Eckelmann 2020-10-11  1091  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

