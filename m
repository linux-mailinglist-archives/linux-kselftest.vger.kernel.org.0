Return-Path: <linux-kselftest+bounces-36549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C81AF925D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02538564769
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18122D5C8B;
	Fri,  4 Jul 2025 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODWJAbWo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B129226CF8;
	Fri,  4 Jul 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751631475; cv=none; b=rDFJ6NDfOrbPOXBBRvhGjh32OlcHfuZmD/Wcyb9uo/BFvD6ac/zHCeFjvvVfCBmyQ2+/BuombI9L8lwWPvw9rj7geKBHLRqWFpszyfyOUqeFQi9Yb/sobWirFhY4sDB+JX7B4isteEp/azSJot9gzhGa7ThwZtn7C053rkEVIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751631475; c=relaxed/simple;
	bh=v+85yg2C2UzcM3/q41A27+OqPOceyBE3B71jGq3SiMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBOL956ZjwEPPsbMDFChU9NyAn4/DuvOYWdC6/2DxjhpA6i2S0DyGZihXWQe56rODRtuGnPiwgXmNGOuGv4N8GQM4d0luavZKMHhjJRi7pyOzqAs3hBUNjG2wzpUY7DsBF0+OBrVhQsgP48LohJ8SUJdet3kQjpUC+hev1AzTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODWJAbWo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751631474; x=1783167474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v+85yg2C2UzcM3/q41A27+OqPOceyBE3B71jGq3SiMg=;
  b=ODWJAbWoUA322Qq+W8zz8fiYjBSAWbuA6odc0CjwTvvxOYBcsuezmaVr
   V5gi6r/ZyNKWa0byUkZ99fAWFa6ldv1UDnnNNKkEBvfaWZtUW65YDTkaL
   6D0El4jkng1ozgEjz3FMh/vekvgPbvRFXzIlZrq5g8T9CJJeDOVe/LmQS
   SXqKBlO7fuJX0YPvLYxZXZdD4Vg3sfkoB1a+mBwC1RhkLmnS9MHzOX0BO
   n6lS4Wr/NAQbk6/f/YewdQegoOypUURATgwah5AaMoPjyLs+gJnn0yOqX
   /XDapFXHw8z4M+tV91WyCTSO3XJJ69YvaBPed1EcbyvbzWO4Uzjbpv5Sf
   g==;
X-CSE-ConnectionGUID: nCWz7/WwQgagrG+3hl1sfA==
X-CSE-MsgGUID: ftscQASIRIuma2f8SBLo6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64566932"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="64566932"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 05:17:54 -0700
X-CSE-ConnectionGUID: tzq80C+0S4elQw0iuct3zw==
X-CSE-MsgGUID: rf1mevPzQ56YiCStLTdnKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="160305463"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 Jul 2025 05:17:49 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXfMQ-0003gd-2m;
	Fri, 04 Jul 2025 12:17:46 +0000
Date: Fri, 4 Jul 2025 20:17:04 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: netdevsim: Add PHY support in netdevsim
Message-ID: <202507041906.JXjAtVqe-lkp@intel.com>
References: <20250702082806.706973-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702082806.706973-2-maxime.chevallier@bootlin.com>

Hi Maxime,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/net-netdevsim-Add-PHY-support-in-netdevsim/20250702-163058
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250702082806.706973-2-maxime.chevallier%40bootlin.com
patch subject: [PATCH net-next 1/3] net: netdevsim: Add PHY support in netdevsim
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20250704/202507041906.JXjAtVqe-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507041906.JXjAtVqe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507041906.JXjAtVqe-lkp@intel.com/

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/net/netdevsim/phy.o: in function `phy_module_exit':
>> phy.o:(.exit.text+0x0): multiple definition of `cleanup_module'; drivers/net/netdevsim/netdev.o:netdev.o:(.exit.text+0x0): first defined here
   microblaze-linux-ld: drivers/net/netdevsim/phy.o: in function `phy_module_init':
>> phy.o:(.init.text+0x0): multiple definition of `init_module'; drivers/net/netdevsim/netdev.o:netdev.o:(.init.text+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

