Return-Path: <linux-kselftest+bounces-26603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AED7A353E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811493ABC46
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 01:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08778F2D;
	Fri, 14 Feb 2025 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3iFwDLO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F319A39FD9;
	Fri, 14 Feb 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739497805; cv=none; b=kI4465k/88E1PmgJvHUl5GlVd21C74T4rYUSGSHUHT9FAK8mkUH8lyDfcltTnzDh7enniS6vNNgsLhvUmD/W193Lid2nvd3X/OUSLhrehDRkWXD3WmpaI4EyPloTSp0LhjAlmdUjB7+WTtPBUEpNDr9RcvpJBSaK/MupRzTknm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739497805; c=relaxed/simple;
	bh=tAKNyOlQTMBreUsREPJPiap5PtOjHv98jrz/BHLWjLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+OHx+BSbLi1GQ+6AqL2sxU5+UXxeuaQNuPj1nupcROwO7XpqNk7w97WPNtplwxDccwv30gdUn3DoTPHC4/UMqvxSh90Sz4k1xmVK4YuPm+79isnVPz/DdCsxFvUj2H8aaUSOP8xlGv+gU+W6LQv4940PxzdH+RqkuX2BbuZBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3iFwDLO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739497802; x=1771033802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tAKNyOlQTMBreUsREPJPiap5PtOjHv98jrz/BHLWjLU=;
  b=Q3iFwDLO87q0fQx0LHhAmaIqT0+NJCRjYoFmEB2euhK37S4orag0o/lx
   rT/wMxyELtuCyixOrcMD0tLiqzgR3Bv5JCf0GBGrjfTUgZ8g47mLiaRja
   RGijbR2UsoyS168dB9elghkgOuUexgZvTRCa3qgaAW+G1FspdVcmKoUEV
   pK3J2ZpBh58qwnWPSYat0RjDuI8dfCKNcWrlE5DctOiBDpP9wpR9jkuu5
   Q1nQ9xkWE2ciZihuT56YvLRdjEWOBSGxLBTgsCHv2/hGtU/G4uDAVJjKC
   EEsXJZ6qSBf74P+tWR7xZ7LjnzLiNxm9fhrP1f27gxqdx7wpvL317vIAj
   Q==;
X-CSE-ConnectionGUID: PbexeIm8S9iQWtJoqs5gaw==
X-CSE-MsgGUID: 47DphMCHTnKO9P97vAW+DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39938716"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="39938716"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 17:50:01 -0800
X-CSE-ConnectionGUID: djmLcVFBReeKH6zbq8jLjA==
X-CSE-MsgGUID: 4VRIRRE4QDSDD/MBc0+2bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113807948"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Feb 2025 17:49:58 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tikq3-0018wN-2B;
	Fri, 14 Feb 2025 01:49:55 +0000
Date: Fri, 14 Feb 2025 09:49:51 +0800
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
Subject: Re: [PATCH net-next v19 25/26] testing/selftests: add test tool and
 scripts for ovpn module
Message-ID: <202502140935.xgPsoRr6-lkp@intel.com>
References: <20250211-b4-ovpn-v19-25-86d5daf2a47a@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-b4-ovpn-v19-25-86d5daf2a47a@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build errors:

[auto build test ERROR on 39f54262ba499d862420a97719d2f0eea0cbd394]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/net-introduce-OpenVPN-Data-Channel-Offload-ovpn/20250211-091029
base:   39f54262ba499d862420a97719d2f0eea0cbd394
patch link:    https://lore.kernel.org/r/20250211-b4-ovpn-v19-25-86d5daf2a47a%40openvpn.net
patch subject: [PATCH net-next v19 25/26] testing/selftests: add test tool and scripts for ovpn module
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502140935.xgPsoRr6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502140935.xgPsoRr6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ovpn-cli.c:30:10: fatal error: 'mbedtls/base64.h' file not found
      30 | #include <mbedtls/base64.h>
         |          ^~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

