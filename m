Return-Path: <linux-kselftest+bounces-26495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A17A33410
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 01:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2817A1B15
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 00:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C39E4085D;
	Thu, 13 Feb 2025 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mn0UlOHS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A635961;
	Thu, 13 Feb 2025 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407032; cv=none; b=iK0dNHMe5lqs2O/LX2MWJgndmZuwM9LKQ7R0XVvAw0Vfoqu5HdTLmrFIQFd0lYw6QwgaZ2r7BdO/+KLmqAh4fmlZoube+jBZNgD40KR0ogoUzh3mqRe3rxHU6ySVEbv2tAJ3dNDqGK7n1ee4LWBrxHv4XzC4xorMSSU6e2TtXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407032; c=relaxed/simple;
	bh=E2fjXwpvBdCKqSYATA8n3S9IoDEl8bBan/TcWeppdmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVEC5bUkwnDG/GscRjNl7rmref3icmCHOuLtNDsM2mFrXQf8QCPzBS1ZHZ8yuq2U58Dkv4P3z6VBMGY+JEvLJ8pi9Ancc8Xla+++uUCDoMqgeOmmWLlNCtWO56HmuAXe1iBYPA4MGEPWNgy/kj2h2dmj9JdhoGBPZ9nt17UhAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mn0UlOHS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739407029; x=1770943029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E2fjXwpvBdCKqSYATA8n3S9IoDEl8bBan/TcWeppdmA=;
  b=mn0UlOHSr3shjwZq8ceWLl1SB1pcpsUj6fhr18JM9aQTqu8Uxts2nnlV
   ZmKHdoS3FekU9HmGb19BQLAyTGozq76UJvFF8Z09Sbr655Fkb2Elz9cuh
   9EbrPIJeuIC/0lxkvdkvl0Z5RuKoeztDBEGlWvt8n0/UE7qPpb52LbKzc
   BkdXAuVh449BkRoC75ZU0nNA1w6zrd2snoAEe8AEg9fMg6pduCuagsOpe
   LzvTuT/Yu6Q4uKMvHLmZiSlf3y2wHQx1xAUPJo7iYr4GOy8JJDtcb3Wct
   MrUN0qw20L52s7jK2X3zppmGv+naqS7uVFhNjWHuoUtOa55ZiSn5Mcgu1
   g==;
X-CSE-ConnectionGUID: GKFzkna9SEaTI7UXxB1kXg==
X-CSE-MsgGUID: 3VWFU0DJSAqgAKCUM9K7Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="42929355"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="42929355"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 16:37:08 -0800
X-CSE-ConnectionGUID: chKLIZkaTEyZs2B2cAI9HQ==
X-CSE-MsgGUID: FDXpyJCoRkq1ieHRMQXSGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117606348"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Feb 2025 16:37:04 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiNDy-0016Jn-2g;
	Thu, 13 Feb 2025 00:37:02 +0000
Date: Thu, 13 Feb 2025 08:36:59 +0800
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
Message-ID: <202502130811.Rjp0u75v-lkp@intel.com>
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
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502130811.Rjp0u75v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502130811.Rjp0u75v-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ovpn-cli.c:30:10: fatal error: mbedtls/base64.h: No such file or directory
      30 | #include <mbedtls/base64.h>
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

