Return-Path: <linux-kselftest+bounces-28829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85AEA5E20F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 17:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228351624BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC72451C3;
	Wed, 12 Mar 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNyzO1jj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A623C8D8;
	Wed, 12 Mar 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798391; cv=none; b=M91By3FJ/2bLszQd0+HDz6yESU+2+72OPFF/OoKOrc/vTb9bZuXVUomq7xnE8qNF/PFkVEYSG9d21mSl/5wvWyFA4z5ekUT11/z0dhJW3R7GKaC6KCZe/+ymQ1t/q4bbxKAz2edBjKr0e1z7le+rHy/fukNe11r97GU4qKognMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798391; c=relaxed/simple;
	bh=Rafds1S3QkKEajqTbOL/+tj3SV1csF1Cnk6XrXNWmtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvEOuBREwxUF0MAU4bChVyWK8/aQ+QcluQf77x4JGuIpfBBPGFpNG/zk+1z0nfLc790LssjJG/JtkTJtt5I/jo+3tCwt0uB83eJ9Au1zJZvQyPzg3THIq+qwLxylXiMKMXOw9RUqe4gQjB6Gwyq2I1YYswgxRhROyRXwfwnixjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNyzO1jj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741798390; x=1773334390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rafds1S3QkKEajqTbOL/+tj3SV1csF1Cnk6XrXNWmtQ=;
  b=bNyzO1jjvvdcJcK6nYlQkNkMwTR9if/0CbZvorv11UhoBVXn35Q8EigJ
   MXDd3ziY7logt3oaU8wzwavhyrIU0inFAJymjOlfNAOq7gYYSMYzW2X6s
   Vta9tEpDYzcV5OFLNIb1Vin/nOritDwf+ts30IizAtZRuRHP8fzK9zcTD
   fsBc1rekwm81J9BjvkjreL8rZL1ZM+GqyjEjmryxHH60ppfkL7x2oMGRp
   +xIrCshettJfyFcfwKQjHMgUlga7S2VtQeY66Sti5K/zh1dvQ1lJ6G/Od
   9BIsN5xJ9fNA4+hGL2ske+MXB99Z40Qs9E6xLaWMBsm70+hCObJxrl6RK
   w==;
X-CSE-ConnectionGUID: IT/6gMzOQmGDBmJxgAslgA==
X-CSE-MsgGUID: nOwV3z93SomUhrEBmonY+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="45665239"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="45665239"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 09:53:09 -0700
X-CSE-ConnectionGUID: zyxy6B8hTM+qrbY2kgBgsQ==
X-CSE-MsgGUID: HFOG3QH1QfmjPMWslolYtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125756446"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 12 Mar 2025 09:53:05 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsPKI-0008jw-30;
	Wed, 12 Mar 2025 16:53:02 +0000
Date: Thu, 13 Mar 2025 00:52:34 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v22 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <202503130050.cIMoMcyw-lkp@intel.com>
References: <20250311-b4-ovpn-v22-18-2b7b02155412@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-b4-ovpn-v22-18-2b7b02155412@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 40587f749df216889163dd6e02d88ad53e759e66]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/net-introduce-OpenVPN-Data-Channel-Offload-ovpn/20250311-202334
base:   40587f749df216889163dd6e02d88ad53e759e66
patch link:    https://lore.kernel.org/r/20250311-b4-ovpn-v22-18-2b7b02155412%40openvpn.net
patch subject: [PATCH net-next v22 18/23] ovpn: implement peer add/get/dump/delete via netlink
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250313/202503130050.cIMoMcyw-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503130050.cIMoMcyw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503130050.cIMoMcyw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ovpn/peer.c:10:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ovpn/peer.c:152:6: warning: variable 'ip_len' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     152 |         if (local_ip) {
         |             ^~~~~~~~
   drivers/net/ovpn/peer.c:166:33: note: uninitialized use occurs here
     166 |         memcpy(&bind->local, local_ip, ip_len);
         |                                        ^~~~~~
   include/linux/fortify-string.h:690:53: note: expanded from macro 'memcpy'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                                                     ^
   include/linux/fortify-string.h:627:41: note: expanded from macro '__fortify_memcpy_chk'
     627 |         const size_t __fortify_size = (size_t)(size);                   \
         |                                                ^~~~
   drivers/net/ovpn/peer.c:152:2: note: remove the 'if' if its condition is always true
     152 |         if (local_ip) {
         |         ^~~~~~~~~~~~~
   drivers/net/ovpn/peer.c:143:15: note: initialize the variable 'ip_len' to silence this warning
     143 |         size_t ip_len;
         |                      ^
         |                       = 0
   4 warnings generated.


vim +152 drivers/net/ovpn/peer.c

   129	
   130	/**
   131	 * ovpn_peer_reset_sockaddr - recreate binding for peer
   132	 * @peer: peer to recreate the binding for
   133	 * @ss: sockaddr to use as remote endpoint for the binding
   134	 * @local_ip: local IP for the binding
   135	 *
   136	 * Return: 0 on success or a negative error code otherwise
   137	 */
   138	int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
   139				     const struct sockaddr_storage *ss,
   140				     const void *local_ip)
   141	{
   142		struct ovpn_bind *bind;
   143		size_t ip_len;
   144	
   145		lockdep_assert_held(&peer->lock);
   146	
   147		/* create new ovpn_bind object */
   148		bind = ovpn_bind_from_sockaddr(ss);
   149		if (IS_ERR(bind))
   150			return PTR_ERR(bind);
   151	
 > 152		if (local_ip) {
   153			if (ss->ss_family == AF_INET) {
   154				ip_len = sizeof(struct in_addr);
   155			} else if (ss->ss_family == AF_INET6) {
   156				ip_len = sizeof(struct in6_addr);
   157			} else {
   158				net_dbg_ratelimited("%s: invalid family %u for remote endpoint for peer %u\n",
   159						    netdev_name(peer->ovpn->dev),
   160						    ss->ss_family, peer->id);
   161				kfree(bind);
   162				return -EINVAL;
   163			}
   164		}
   165	
   166		memcpy(&bind->local, local_ip, ip_len);
   167	
   168		/* set binding */
   169		ovpn_bind_reset(peer, bind);
   170	
   171		return 0;
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

