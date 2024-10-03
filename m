Return-Path: <linux-kselftest+bounces-18958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB098EC2F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 11:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504811C21FDD
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C3145B24;
	Thu,  3 Oct 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYeT56/o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8113D278;
	Thu,  3 Oct 2024 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947229; cv=none; b=AHDn/O1dhxwGvR6pLLOO13ZoindEOGX3reBJuVe0hHSLIj+lL0kyGzfHXz5ebiK8pAbZRWbRZagRKITLxMhovkz+hHRN0sNzMykJgyFbFVn8cUwFbHDwn2dOslNqsncQl+JEXLPNBSDx8nwYEeZr+Y40ze9PntPhBnXAg02CjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947229; c=relaxed/simple;
	bh=tTDRklkGF5x7+WvdFjigFQJ/HlYIBUwlCPvUqdTlD2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3BX2Oj43i33bAj47zMI+a3ZzQOnPl6v+yJofy4W2JZL/SGglm3wxFdHK0tFAit0KQjcgksZc30LMsVXXAHAIDm8MX5vV4CkYOBJ0ETnhXiSOcmpGtSI4pN2nX2QeI1KCJnZIzqW8gHk/xHDHoTSXnBD50mcblFKdKOfh1BVxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYeT56/o; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727947226; x=1759483226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tTDRklkGF5x7+WvdFjigFQJ/HlYIBUwlCPvUqdTlD2E=;
  b=TYeT56/oEk3UCNSI6d570SJy14oy+4WBEcqEPBEKlobdx1coW+I4pN17
   hJmVaL03hOozTPvGK1GAwD9TD4LmP8fXLY7A3TgJQvgmYXt77TmNaB2Z/
   6x+Jw2+FSq81HYjWw97qBBOMqXrT2RyoRQpUWT8850JoS+7Cjf6jCeXAG
   UyiwVxVTjzeskgZLkpdAdC6zjWAJoASdhbxcQOhn8+CZTLoD4Ktsb4rzV
   4IOq7z3QB39bip54lr/znvY547zE+Uxy8wdYwvBBlRBWVwnFN1ifM5MaB
   vkbih/FB+aaxv+aF4AJcaitZINau9xX5nqAZaaKX0Sc1ELGE7pYWkRsc6
   A==;
X-CSE-ConnectionGUID: KXj4kGVDTKu8Or3icE51+A==
X-CSE-MsgGUID: XFB0Fs01S+CmyvyfCWCiuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26643232"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="26643232"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:20:25 -0700
X-CSE-ConnectionGUID: 2YM40r5wSkaSqsZcod7V7g==
X-CSE-MsgGUID: s5IMEn58RRSWeW1MmkI/Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="79259642"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Oct 2024 02:20:23 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swI0R-0000E7-35;
	Thu, 03 Oct 2024 09:20:19 +0000
Date: Thu, 3 Oct 2024 17:20:09 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sd@queasysnail.net, ryazanov.s.a@gmail.com
Subject: Re: [PATCH net-next v8 12/24] ovpn: store tunnel and transport
 statistics
Message-ID: <202410031618.Cvko8Ujs-lkp@intel.com>
References: <20241002-b4-ovpn-v8-12-37ceffcffbde@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-b4-ovpn-v8-12-37ceffcffbde@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 44badc908f2c85711cb18e45e13119c10ad3a05f]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/netlink-add-NLA_POLICY_MAX_LEN-macro/20241002-172734
base:   44badc908f2c85711cb18e45e13119c10ad3a05f
patch link:    https://lore.kernel.org/r/20241002-b4-ovpn-v8-12-37ceffcffbde%40openvpn.net
patch subject: [PATCH net-next v8 12/24] ovpn: store tunnel and transport statistics
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410031618.Cvko8Ujs-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/net/ovpn/peer.h: uapi/linux/ovpn.h is included more than once.
>> drivers/net/ovpn/peer.h: net/dst_cache.h is included more than once.

vim +14 drivers/net/ovpn/peer.h

    12	
    13	#include <net/dst_cache.h>
  > 14	#include <uapi/linux/ovpn.h>
    15	
    16	#include "bind.h"
    17	#include "pktid.h"
    18	#include "crypto.h"
    19	#include "socket.h"
    20	#include "stats.h"
    21	
    22	#include <net/dst_cache.h>
  > 23	#include <uapi/linux/ovpn.h>
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

