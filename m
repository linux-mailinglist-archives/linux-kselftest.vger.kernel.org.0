Return-Path: <linux-kselftest+bounces-24300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9842A0A6C1
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jan 2025 01:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D71167565
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jan 2025 00:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EC946B5;
	Sun, 12 Jan 2025 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuI9OEt9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149A322E;
	Sun, 12 Jan 2025 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736642549; cv=none; b=uH9FdOk1Io+vX0xF/r5jDIVrx9GozFwpV3ywpBZCAvV9NDHgqzHm7V6S1+UVs4gHQ3hJPeho8jNaBacyPgIEuqxBoR1qh6ihSsQkqVOXdiAAfJRcEOwoLd8YiqyD8Zj+92xFiUabFjUnJGnbiCZBHWcRiqGeX6XC/c3V7nFX8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736642549; c=relaxed/simple;
	bh=2hw8x15vz3gDOIuHxdjpI6U5c7+8Id0aR3k0Vb1hLpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olOjfWop4gl0FgX4iYHRoCLUraoBjjF/gsyw//0xDmlQlwa4O+4aQ8OeL/Zt6UkrwIODkGX2N/98I5D4zc69xvmZNFJOjaX8yTJPQW6AsWsTXK7EQ7tYcxQzyMIYfBWVPe7m6ef+cITeTEU6psQblieMY92s1S0gYXORL/JWv94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuI9OEt9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736642546; x=1768178546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2hw8x15vz3gDOIuHxdjpI6U5c7+8Id0aR3k0Vb1hLpo=;
  b=MuI9OEt99+y0wxAd9Ed4CluUx/2femVvyHSEBoZ+vDyIqjigOIE3jb3h
   hY/Ow4N5FRpoHpmhwLY7/lkHkS15CXYwgmDabWRCk0x2LNaulhHqDqVan
   Iwu+BmGNSKmQ3iMU+SRrHq7m1aUCOLJEyda7ZvZAf5LQfolcDjaStqc8B
   Epy01Iks8PB5TfCZV+KeHrGeQTBhDnJSF8enZtcXc1rdWXsqF9oeonQNv
   lgETJriXzbanQAk2gB+RwsdLI1W631BMBMeXjpPtgXRkc3AlGoDhGEjlz
   o6vKSq8jBUhMObYdz/+iVDZSThP/X1pawZB2ATLa82cTjOVkkANKNG21q
   w==;
X-CSE-ConnectionGUID: cpA94qEVQ8impGH9+WTyxg==
X-CSE-MsgGUID: PZ25xw0cThiHJAx8hn5Dgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="36786115"
X-IronPort-AV: E=Sophos;i="6.12,308,1728975600"; 
   d="scan'208";a="36786115"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 16:42:25 -0800
X-CSE-ConnectionGUID: t0NPAh6CTLKjgisEWbEpuQ==
X-CSE-MsgGUID: G37i+zwXSN275U4ielvNeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104947087"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Jan 2025 16:42:21 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWm3X-000LN1-0X;
	Sun, 12 Jan 2025 00:42:19 +0000
Date: Sun, 12 Jan 2025 08:41:23 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v17 02/25] ovpn: add basic netlink support
Message-ID: <202501120844.1dosuV3x-lkp@intel.com>
References: <20250110-b4-ovpn-v17-2-47b2377e5613@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-b4-ovpn-v17-2-47b2377e5613@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7b24f164cf005b9649138ef6de94aaac49c9f3d1]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/net-introduce-OpenVPN-Data-Channel-Offload-ovpn/20250111-064544
base:   7b24f164cf005b9649138ef6de94aaac49c9f3d1
patch link:    https://lore.kernel.org/r/20250110-b4-ovpn-v17-2-47b2377e5613%40openvpn.net
patch subject: [PATCH net-next v17 02/25] ovpn: add basic netlink support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250112/202501120844.1dosuV3x-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501120844.1dosuV3x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501120844.1dosuV3x-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ovpn/netlink.c: In function 'ovpn_nl_post_doit':
>> drivers/net/ovpn/netlink.c:85:37: error: invalid initializer
      85 |         netdevice_tracker tracker = info->user_ptr[1];
         |                                     ^~~~


vim +85 drivers/net/ovpn/netlink.c

    81	
    82	void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
    83			       struct genl_info *info)
    84	{
  > 85		netdevice_tracker tracker = info->user_ptr[1];
    86		struct ovpn_priv *ovpn = info->user_ptr[0];
    87	
    88		if (ovpn)
    89			netdev_put(ovpn->dev, &tracker);
    90	}
    91	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

