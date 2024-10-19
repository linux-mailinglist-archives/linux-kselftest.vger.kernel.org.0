Return-Path: <linux-kselftest+bounces-20192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24C9A4D28
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 13:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0D0281DFF
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 11:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041D71E0091;
	Sat, 19 Oct 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KjJ65Mgr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD11DFD8A;
	Sat, 19 Oct 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729337917; cv=none; b=f2IgTm7N+T41rRhDNkWEi4cFNNFEDCCY5hncsE75A24Cov7qvSqDk5MZMElLeD7ndvFx7rs/STjsaSYI/ZZKGIoXTncTiIpelJpsZi+4yreRuE4H7VYuUx0xilaw+b8/+1DSYyMY3RhJaRjcLdspdEPaMkHOLPQniXauUtnndkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729337917; c=relaxed/simple;
	bh=xliTeRKq8Ubg/8gWFk66TUUJKGg3G+7WxNX6IRvq7qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCdI11XR/TJU13Qv8m3VkzICPkRrWyY89y6eaninFaxlE9JwIml/UOdqYJzy4sJA1LxIt9pSN0X8CjIsMuoGgb2binjARWCwA8E0dZHuhKNEXORNO52d7XYX5L48ceSOPRU/3qBXPgq9vt08uaaSyJMfUmO/iVxISbe3QcsVD+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KjJ65Mgr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729337915; x=1760873915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xliTeRKq8Ubg/8gWFk66TUUJKGg3G+7WxNX6IRvq7qc=;
  b=KjJ65MgrXPuKxIj/QG3WvCQVzlYWtgqxWLEsN1ff23b8CpsLm+IIrgFz
   a5SQTgWtU4P1E4h/G76liZyfO1fqNsIQhlyv3zs3QfxP9OwENdG6MVV3v
   i4Mz+An52ouuUIewhrcN6WACcAUrQ+xhRb82iceooawd38eHEyLa1/Nie
   WnJztP4QlFmmJphbWgjDu+dY/5TC6kUDY8Ud9C2Gf8cq/4HJqqMmBjl2r
   D5D7+gNW7CojXNe8cIkRPolGvVPxjbr38KKubrb3K/Wx/O/GAGPO1FkhF
   Pdb/oww9svrAKa/XT3oVScy9xH1LwnMgdhPlrojU7A4kWMg3/bGwLhMv4
   w==;
X-CSE-ConnectionGUID: 6SQePbhlSd66NpBWVH2PJA==
X-CSE-MsgGUID: Pud+/K0BTRSPjWTjKjw+3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="40262594"
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="40262594"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 04:38:34 -0700
X-CSE-ConnectionGUID: U4X/UXW+T2qVHBo2wlcC8g==
X-CSE-MsgGUID: BiRAVVjCTzC4QrZJdDJmDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="83890979"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Oct 2024 04:38:30 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t27mu-000OwL-0Y;
	Sat, 19 Oct 2024 11:38:28 +0000
Date: Sat, 19 Oct 2024 19:38:01 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, openvpn-devel@lists.sourceforge.net,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 11/23] ovpn: store tunnel and transport
 statistics
Message-ID: <202410191934.uhcv7iPs-lkp@intel.com>
References: <20241016-b4-ovpn-v9-11-aabe9d225ad5@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-b4-ovpn-v9-11-aabe9d225ad5@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6d858708d465669ba7de17e9c5691eb4019166e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/netlink-add-NLA_POLICY_MAX_LEN-macro/20241016-092722
base:   6d858708d465669ba7de17e9c5691eb4019166e8
patch link:    https://lore.kernel.org/r/20241016-b4-ovpn-v9-11-aabe9d225ad5%40openvpn.net
patch subject: [PATCH net-next v9 11/23] ovpn: store tunnel and transport statistics
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410191934.uhcv7iPs-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/net/ovpn/io.c: socket.h is included more than once.

vim +25 drivers/net/ovpn/io.c

    16	
    17	#include "ovpnstruct.h"
    18	#include "peer.h"
    19	#include "io.h"
    20	#include "bind.h"
    21	#include "crypto.h"
    22	#include "crypto_aead.h"
    23	#include "netlink.h"
    24	#include "proto.h"
  > 25	#include "socket.h"
    26	#include "udp.h"
    27	#include "skb.h"
  > 28	#include "socket.h"
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

