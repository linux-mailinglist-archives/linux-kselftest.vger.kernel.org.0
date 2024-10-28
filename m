Return-Path: <linux-kselftest+bounces-20786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91199B23F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 05:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394681F21DE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 04:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B4518BC36;
	Mon, 28 Oct 2024 04:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2ZbdPkn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988E171658;
	Mon, 28 Oct 2024 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730091317; cv=none; b=QsflY7/Q6Oc3JN0DYmqVRvAU7e4asJ32E0lvLUXN+N4q7v/nbq2a1btgu7jpdiKsKyb7lystX53Op2/Ceh75dX/Dpg86d9YhCrfxEH99dk++ER8sWcFxf/xe0alTAycemwEZKAe2yJtwIE0Gjtd2RdP9mzk1Nhsvn4kh3p8xgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730091317; c=relaxed/simple;
	bh=iRHL8XKfHxqoDYgz3WooPtySrWMOp6WF3ds0fcqiVxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUeSu7xVp548aU8vQ6JORQXC5IVQVujGHFgCOE+X9aQJxMZYZ+aVxITBXOlRCsYGCJ/vDugL3Cwpwr3Qx4TVZNFsuLqQMVN2e2YkZBuJJqtCF+w0aKo2zvGZgdle1Kw178b+shnV97Oe3/Pr5dC+eAMcKn7XPbqQUoXI5BD7DJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2ZbdPkn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730091314; x=1761627314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iRHL8XKfHxqoDYgz3WooPtySrWMOp6WF3ds0fcqiVxY=;
  b=A2ZbdPknWKNiB8zZDkxrihINQz8YDf89pc/ijn3+XZrG4fV4KbI2Vidv
   CEt7pHAej/XotfQ6KnIbQu0AHfX9nax7ZmBoViwSgmk+ODWo1QNF0/cvl
   7MEXWrSjKXi1HLLs2x2wjfNmq4SAGgYtmzIteyVZ6Ynxz2LSXhQwlsfWD
   pckFBf/GJbsUSbD5RNK/eCEAf0tKXzK4SfDFI8arBTRnjNfoO9PXgjZ7U
   OYqKzPtSBUhWUyltEnN4x3VarqC/6UHSDHICM58Mc1yH8Hd9bQnP7X1uL
   WA1yvjB9//KRfJWzc9o9+0O0mKzUHOFUooJsCmyTdGY/jODvSUwIPIQMo
   Q==;
X-CSE-ConnectionGUID: 9h7yOQzcT7GmSdI3ORnljA==
X-CSE-MsgGUID: zVNJp431SJKnZaZlj5nLqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40297136"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40297136"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 21:55:13 -0700
X-CSE-ConnectionGUID: eV6AvVw2RPG4ddqrjwWtdA==
X-CSE-MsgGUID: hwCniIgKRnmSheukQrgWdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="85445722"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Oct 2024 21:55:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5HmV-000bGa-33;
	Mon, 28 Oct 2024 04:55:07 +0000
Date: Mon, 28 Oct 2024 12:54:15 +0800
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
Message-ID: <202410281248.ZHbto77a-lkp@intel.com>
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
config: powerpc-randconfig-r064-20241028 (https://download.01.org/0day-ci/archive/20241028/202410281248.ZHbto77a-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241028/202410281248.ZHbto77a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410281248.ZHbto77a-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ovpn/socket.c:84:25: error: call to undeclared function 'udp_sk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ^
>> drivers/net/ovpn/socket.c:84:37: error: member reference type 'int' is not a pointer
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:484:10: note: expanded from macro '__native_word'
     484 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                 ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:505:23: note: expanded from macro '_compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:497:9: note: expanded from macro '__compiletime_assert'
     497 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/net/ovpn/socket.c:84:37: error: member reference type 'int' is not a pointer
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:484:39: note: expanded from macro '__native_word'
     484 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                              ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:505:23: note: expanded from macro '_compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:497:9: note: expanded from macro '__compiletime_assert'
     497 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/net/ovpn/socket.c:84:37: error: member reference type 'int' is not a pointer
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:485:10: note: expanded from macro '__native_word'
     485 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                 ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:505:23: note: expanded from macro '_compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:497:9: note: expanded from macro '__compiletime_assert'
     497 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/net/ovpn/socket.c:84:37: error: member reference type 'int' is not a pointer
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:485:38: note: expanded from macro '__native_word'
     485 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                             ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:505:23: note: expanded from macro '_compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:497:9: note: expanded from macro '__compiletime_assert'
     497 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/net/ovpn/socket.c:84:37: error: member reference type 'int' is not a pointer
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:48: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                                       ^
   include/linux/compiler_types.h:517:22: note: expanded from macro 'compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:505:23: note: expanded from macro '_compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:497:9: note: expanded from macro '__compiletime_assert'
     497 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/net/ovpn/socket.c:84:25: error: call to undeclared function 'udp_sk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ^
>> drivers/net/ovpn/socket.c:84:37: error: member reference type 'int' is not a pointer
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:473:13: note: expanded from macro '__unqual_scalar_typeof'
     473 |                 _Generic((x),                                           \
         |                           ^
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/net/ovpn/socket.c:84:37: error: member reference type 'int' is not a pointer
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:480:15: note: expanded from macro '__unqual_scalar_typeof'
     480 |                          default: (x)))
         |                                    ^
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/net/ovpn/socket.c:84:37: error: member reference type 'int' is not a pointer
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                ~~~~~~~~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/net/ovpn/socket.c:84:52: error: use of undeclared identifier 'UDP_ENCAP_OVPNINUDP'
      84 |         if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
         |                                                           ^
   11 errors generated.


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

