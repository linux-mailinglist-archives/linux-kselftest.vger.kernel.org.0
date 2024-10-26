Return-Path: <linux-kselftest+bounces-20759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6E9B1A6B
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 20:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2ACF1F21C7C
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EDB1D3628;
	Sat, 26 Oct 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DstOY00J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5A742AB1;
	Sat, 26 Oct 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729968565; cv=none; b=IWW2LaQcpcrQKufLs5++hggeTmphS1737+mCW8WzUdf8xwiYoXJ9+L/R4WvCRkXAihUnoVPfKmEvRU8RR7grgzb37Q/k+tGVQ4EuQgqsRyFgcQugPixHW1mZ9WeLePuE/e07wgzVCQ/zxIvl2hstpY6FsTIASwazKqyb+fR/y9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729968565; c=relaxed/simple;
	bh=f227XmjmFRp2rdRZxT4QQtBDRnYffqNL5/dd1t92FFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3LFCykvjnG4HVB0bctMChpGkk8OwicR+EfPZX1yz+dTCsIdvlwUUzJXrJtmz9G8fvSwv1eyBGrt8YAPq39cZNvV7mORpjK/XZFIvFvTUTuwvq9CC8p9XFEl6EIQZnG5iNYgBH4Oe+EUV9my29jgoVgYgL7OymPHw7bq/mpTH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DstOY00J; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729968561; x=1761504561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f227XmjmFRp2rdRZxT4QQtBDRnYffqNL5/dd1t92FFE=;
  b=DstOY00Ju/dQfsxhwajzhAE3wf5QwAsvkzDqauRb1c/pgRjaA/tN/k6j
   Iv+CGjwMvIvkBf/thQEchvyQP+Y9gy0E3nQXCNAB0ACil5hrAYTOW7jKy
   +j/Y4exBR+g9V55CkcM8SE3xLcLpp+kmriVOSeuD5CzijPn5xIstwAzYg
   zxNNuyEoYQms/ua1/fSzY1o3tOB/eJ/PJgVkHle9qEYn4pigHsaK8ydDe
   y3jWyidmPOMwT1nnYb8jV+a8UvxVFZqijgvCPjS6YZZBJ8GkMLgk6mSMo
   D+q71rxBsXVhaEmYLut8yKShm23HW1qtD6xYx3DWSvx9K7eitHJWKLhOD
   A==;
X-CSE-ConnectionGUID: 0qhbn8IJRcWDwLD5U5yRXw==
X-CSE-MsgGUID: AP+rUEYtQPSsTad4ORB9IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29479230"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29479230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 11:49:21 -0700
X-CSE-ConnectionGUID: lq2g8Zf2SIydrU+Rx2uB1g==
X-CSE-MsgGUID: R/XJUF5yQeOKtMAlUYlplA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="104545167"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Oct 2024 11:49:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4lqd-000Zwg-0T;
	Sat, 26 Oct 2024 18:49:15 +0000
Date: Sun, 27 Oct 2024 02:49:08 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 09/23] ovpn: implement basic RX path (UDP)
Message-ID: <202410270433.eQTW7j8W-lkp@intel.com>
References: <20241025-b4-ovpn-v10-9-b87530777be7@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-b4-ovpn-v10-9-b87530777be7@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build errors:

[auto build test ERROR on 03fc07a24735e0be8646563913abf5f5cb71ad19]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/netlink-add-NLA_POLICY_MAX_LEN-macro/20241025-173611
base:   03fc07a24735e0be8646563913abf5f5cb71ad19
patch link:    https://lore.kernel.org/r/20241025-b4-ovpn-v10-9-b87530777be7%40openvpn.net
patch subject: [PATCH net-next v10 09/23] ovpn: implement basic RX path (UDP)
config: m68k-randconfig-r072-20241027 (https://download.01.org/0day-ci/archive/20241027/202410270433.eQTW7j8W-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241027/202410270433.eQTW7j8W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410270433.eQTW7j8W-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/random.h:6,
                    from include/linux/net.h:18,
                    from drivers/net/ovpn/socket.c:10:
   drivers/net/ovpn/socket.c: In function 'ovpn_from_udp_sock':
>> drivers/net/ovpn/socket.c:84:32: error: implicit declaration of function 'udp_sk' [-Wimplicit-function-declaration]
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ^~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:505:9: note: in expansion of macro '__compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/socket.c:84:22: note: in expansion of macro 'READ_ONCE'
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                      ^~~~~~~~~
>> drivers/net/ovpn/socket.c:84:42: error: invalid type argument of '->' (have 'int')
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                          ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:505:9: note: in expansion of macro '__compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/socket.c:84:22: note: in expansion of macro 'READ_ONCE'
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                      ^~~~~~~~~
>> drivers/net/ovpn/socket.c:84:42: error: invalid type argument of '->' (have 'int')
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                          ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:505:9: note: in expansion of macro '__compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/socket.c:84:22: note: in expansion of macro 'READ_ONCE'
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                      ^~~~~~~~~
>> drivers/net/ovpn/socket.c:84:42: error: invalid type argument of '->' (have 'int')
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                          ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:505:9: note: in expansion of macro '__compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/socket.c:84:22: note: in expansion of macro 'READ_ONCE'
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                      ^~~~~~~~~
>> drivers/net/ovpn/socket.c:84:42: error: invalid type argument of '->' (have 'int')
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                          ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:505:9: note: in expansion of macro '__compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/socket.c:84:22: note: in expansion of macro 'READ_ONCE'
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                      ^~~~~~~~~
>> drivers/net/ovpn/socket.c:84:42: error: invalid type argument of '->' (have 'int')
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                          ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/compiler_types.h:505:9: note: in expansion of macro '__compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ovpn/socket.c:84:22: note: in expansion of macro 'READ_ONCE'
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                      ^~~~~~~~~
>> drivers/net/ovpn/socket.c:84:42: error: invalid type argument of '->' (have 'int')
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                          ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/asm-generic/rwonce.h:44:43: note: in expansion of macro '__unqual_scalar_typeof'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   drivers/net/ovpn/socket.c:84:22: note: in expansion of macro 'READ_ONCE'
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                      ^~~~~~~~~
>> drivers/net/ovpn/socket.c:84:42: error: invalid type argument of '->' (have 'int')
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                          ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   drivers/net/ovpn/socket.c:84:22: note: in expansion of macro 'READ_ONCE'
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                      ^~~~~~~~~
>> drivers/net/ovpn/socket.c:84:59: error: 'UDP_ENCAP_OVPNINUDP' undeclared (first use in this function)
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                                           ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   drivers/net/ovpn/socket.c:84:59: note: each undeclared identifier is reported only once for each function it appears in
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                                           ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^


vim +/udp_sk +84 drivers/net/ovpn/socket.c

    76	
    77	/* Retrieve the corresponding ovpn object from a UDP socket
    78	 * rcu_read_lock must be held on entry
    79	 */
    80	struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
    81	{
    82		struct ovpn_socket *ovpn_sock;
    83	
  > 84		if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
    85			return NULL;
    86	
    87		ovpn_sock = rcu_dereference_sk_user_data(sk);
    88		if (unlikely(!ovpn_sock))
    89			return NULL;
    90	
    91		/* make sure that sk matches our stored transport socket */
    92		if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
    93			return NULL;
    94	
    95		return ovpn_sock->ovpn;
    96	}
    97	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

