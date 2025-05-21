Return-Path: <linux-kselftest+bounces-33487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06751ABFDCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 22:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9993A1764DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 20:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7274F28FA97;
	Wed, 21 May 2025 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WbNNJ0DR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65228F933;
	Wed, 21 May 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858997; cv=none; b=Vc3KlT967CwLuOhOXfW3m4FGGrUIOTBLV0s7m9AB/09KqJV7fVqjXpMjrNvJbDorhpitySwimVXgxx2l3t1+j0ZcgOiETMOMcSmzdl0Smc8vDclKU96EDod9pkBJz0umT5OlA2Kc9GH6HeIVhr+7ujnZxfHSMaMRRoovTjQdUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858997; c=relaxed/simple;
	bh=K/2pXTpvDQfBZ0ep8HpGFETI5nYmsq+WiQ0VjG+uwy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQTPQxraxD0tzT4tDhzSFj1zDji4URTRvioicQ3qSFt+nY+bAIoGfta8/sQJlRgaQPxf5t/c1NdAi9gxeQYTaEb2w8nfTpjnaJ9t6aVJ9VE0Vgm0pEe2dJ1CxieDt3GSwS/vmCJOg1iEIi3he2lsYb8eOJ9NWXehfHGA8VRlqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WbNNJ0DR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747858996; x=1779394996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=K/2pXTpvDQfBZ0ep8HpGFETI5nYmsq+WiQ0VjG+uwy8=;
  b=WbNNJ0DRRm2l4mREAkcnZV3iK0UGQxiBTNQj7mxLJLkou5OEcHWfqRJ2
   Jmc498cXBvh3SHq2BN+6Rrzvw0NSCqkATIdwbcJs9xWHCWtYXpM5x9e+0
   Wz5HOuyRHvpg/EHgApAULWfvm63+kE3+xByFSHwx3zfWsTw1WVwEa4f4q
   r8Sb7F3Vs0K6gxWoB9FK4rVgtCTF2a7ZkBAac+9xutGqC2k+0ZqoGiPZZ
   8nHxabkeUQijbKZPi9CKC1YEyis4vUV1+NY2YCuuWsq4J6kcKcePw+P0R
   wNHE+/pWu1Gq1g6+I0tiZXTAPp8od+9bwT2XvOSBhd63nmRuR7FmxskvB
   g==;
X-CSE-ConnectionGUID: bcLCS7rBSEKVu7N71KNfoQ==
X-CSE-MsgGUID: xK1hrQlTRcCQqw0kc321Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49845372"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49845372"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:23:15 -0700
X-CSE-ConnectionGUID: x4VnkjI8Sgqy8LNgJw13Gw==
X-CSE-MsgGUID: RB6n9MKzQwedhiImKbruyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="171103030"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 May 2025 13:23:12 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHpy1-000OaS-0R;
	Wed, 21 May 2025 20:23:09 +0000
Date: Thu, 22 May 2025 04:23:02 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v4 5/7] futex: Wire up set_robust_list2 syscall
Message-ID: <202505220350.ZektmdF0-lkp@intel.com>
References: <20250520-tonyk-robust_futex-v4-5-1123093e59de@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250520-tonyk-robust_futex-v4-5-1123093e59de@igalia.com>

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3ee84e3dd88e39b55b534e17a7b9a181f1d46809]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/selftests-futex-Add-ASSERT_-macros/20250521-045231
base:   3ee84e3dd88e39b55b534e17a7b9a181f1d46809
patch link:    https://lore.kernel.org/r/20250520-tonyk-robust_futex-v4-5-1123093e59de%40igalia.com
patch subject: [PATCH v4 5/7] futex: Wire up set_robust_list2 syscall
config: arc-randconfig-001-20250521 (https://download.01.org/0day-ci/archive/20250522/202505220350.ZektmdF0-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250522/202505220350.ZektmdF0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505220350.ZektmdF0-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:460:1: note: in expansion of macro '__SYSCALL'
     460 | __SYSCALL(459, sys_lsm_get_self_attr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:461:1: note: in expansion of macro '__SYSCALL'
     461 | __SYSCALL(460, sys_lsm_set_self_attr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[460]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:461:1: note: in expansion of macro '__SYSCALL'
     461 | __SYSCALL(460, sys_lsm_set_self_attr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:462:1: note: in expansion of macro '__SYSCALL'
     462 | __SYSCALL(461, sys_lsm_list_modules)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[461]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:462:1: note: in expansion of macro '__SYSCALL'
     462 | __SYSCALL(461, sys_lsm_list_modules)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:463:1: note: in expansion of macro '__SYSCALL'
     463 | __SYSCALL(462, sys_mseal)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[462]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:463:1: note: in expansion of macro '__SYSCALL'
     463 | __SYSCALL(462, sys_mseal)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:464:1: note: in expansion of macro '__SYSCALL'
     464 | __SYSCALL(463, sys_setxattrat)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[463]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:464:1: note: in expansion of macro '__SYSCALL'
     464 | __SYSCALL(463, sys_setxattrat)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:465:1: note: in expansion of macro '__SYSCALL'
     465 | __SYSCALL(464, sys_getxattrat)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[464]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:465:1: note: in expansion of macro '__SYSCALL'
     465 | __SYSCALL(464, sys_getxattrat)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:466:1: note: in expansion of macro '__SYSCALL'
     466 | __SYSCALL(465, sys_listxattrat)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[465]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:466:1: note: in expansion of macro '__SYSCALL'
     466 | __SYSCALL(465, sys_listxattrat)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:467:1: note: in expansion of macro '__SYSCALL'
     467 | __SYSCALL(466, sys_removexattrat)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[466]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:467:1: note: in expansion of macro '__SYSCALL'
     467 | __SYSCALL(466, sys_removexattrat)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:468:1: note: in expansion of macro '__SYSCALL'
     468 | __SYSCALL(467, sys_open_tree_attr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[467]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:468:1: note: in expansion of macro '__SYSCALL'
     468 | __SYSCALL(467, sys_open_tree_attr)
         | ^~~~~~~~~
>> ./arch/arc/include/generated/asm/syscall_table_32.h:469:16: error: 'sys_set_robust_list2' undeclared here (not in a function); did you mean 'sys_set_robust_list'?
     469 | __SYSCALL(468, sys_set_robust_list2)
         |                ^~~~~~~~~~~~~~~~~~~~
   arch/arc/kernel/sys.c:13:37: note: in definition of macro '__SYSCALL'
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                     ^~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

