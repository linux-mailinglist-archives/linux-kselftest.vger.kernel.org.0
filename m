Return-Path: <linux-kselftest+bounces-22966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982029E8A7E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 05:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5926E28126D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 04:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014521917E9;
	Mon,  9 Dec 2024 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBAX98FP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B11531F0;
	Mon,  9 Dec 2024 04:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733719544; cv=none; b=aRAY+nPKmyRD+ih/RV6na93Jguv3Xs0tXTL+tCkAbQB7V6+6Gw8Z+yx9WqlkjyDBoKC4t91RWHi7Yt8gmHIwu/N/4Z0VkT4eRBp0R2FFkBNB/+Vf1PuwfokmxZU9wHey3vSyUV8t08/Is0sV4bbSZBj/q7XY/81lkHJLrgbzT84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733719544; c=relaxed/simple;
	bh=AzHA/hMClI3MRWClxdhjCeAlhT69zRbOOw0yN3/YVe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaziNpbV8PUXUIflO7SqmHoJ15qzDGNVYDXaCqO0FCyGbPyujNm255mcUh6ZxTWHD6Tz63Y6XkG3wzOsuFoKKb657MPj2oD4XTj+uCdpMkCsRJhkpXiuyDOBUhA/5+EJWJ/HWT1W1d3txr//R5YyCWdsEeq1SaTLYCQMD2f+9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBAX98FP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733719543; x=1765255543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AzHA/hMClI3MRWClxdhjCeAlhT69zRbOOw0yN3/YVe4=;
  b=eBAX98FPJtvW6CMJdaORlkWOqWOXX5rshtenD+e6L/+EtpLMRbbRskLx
   a5VIzcDUtL0VRXqG6/DWUy9T30OMv9lDOsKc8Lpcp1RRRpCrdgj5bDkvO
   3QE19gGcJjIaLrv6AWJ1L19fMfDVP7DchUNW64P3l06c284Tc+RNseby+
   DTgrCG7eZZsipAeZc/tZckfV1uHhDX3Hs46+Iz94TIjQ2A3DloZVBGYhG
   mg2y8mEEbqCpMVH11f52pD49guvpwqLWGM12X6jiWW72alNHCqR34+9Tl
   aNW4odjsenOfCDTANItFhKEwn4ZBVeJWhWzijCsnsj0OTF0x9XLMDFWx8
   A==;
X-CSE-ConnectionGUID: +FiFFFC4QF2iwS7GY6vIFw==
X-CSE-MsgGUID: nMmGVbjaSjiWajgfSKzhtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="56484236"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="56484236"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:45:42 -0800
X-CSE-ConnectionGUID: oUByNaDNQkSJFp3APZlZ3w==
X-CSE-MsgGUID: FhysvzurSaKKgZ295Irfgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="100012724"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Dec 2024 20:45:39 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVeK-0003ub-21;
	Mon, 09 Dec 2024 04:45:36 +0000
Date: Mon, 9 Dec 2024 12:45:15 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v13 07/22] ovpn: implement basic TX path (UDP)
Message-ID: <202412081739.56GeY9xL-lkp@intel.com>
References: <20241206-b4-ovpn-v13-7-67fb4be666e2@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-b4-ovpn-v13-7-67fb4be666e2@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build errors:

[auto build test ERROR on 152d00a913969514967ad3f962b3b1c8983eb2d7]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/net-introduce-OpenVPN-Data-Channel-Offload-ovpn/20241207-054712
base:   152d00a913969514967ad3f962b3b1c8983eb2d7
patch link:    https://lore.kernel.org/r/20241206-b4-ovpn-v13-7-67fb4be666e2%40openvpn.net
patch subject: [PATCH net-next v13 07/22] ovpn: implement basic TX path (UDP)
config: nios2-randconfig-r131-20241208 (https://download.01.org/0day-ci/archive/20241208/202412081739.56GeY9xL-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241208/202412081739.56GeY9xL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412081739.56GeY9xL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ovpn/io.c:18:
   drivers/net/ovpn/skb.h: In function 'ovpn_ip_check_protocol':
>> drivers/net/ovpn/skb.h:46:56: error: invalid application of 'sizeof' to incomplete type 'struct ipv6hdr'
      46 |                 if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
         |                                                        ^~~~~~


vim +46 drivers/net/ovpn/skb.h

    29	
    30	/* Return IP protocol version from skb header.
    31	 * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
    32	 */
    33	static inline __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
    34	{
    35		__be16 proto = 0;
    36	
    37		/* skb could be non-linear,
    38		 * make sure IP header is in non-fragmented part
    39		 */
    40		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
    41			return 0;
    42	
    43		if (ip_hdr(skb)->version == 4) {
    44			proto = htons(ETH_P_IP);
    45		} else if (ip_hdr(skb)->version == 6) {
  > 46			if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
    47				return 0;
    48			proto = htons(ETH_P_IPV6);
    49		}
    50	
    51		return proto;
    52	}
    53	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

