Return-Path: <linux-kselftest+bounces-42003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A2B8CABF
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 16:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C9017BB99
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6572F548E;
	Sat, 20 Sep 2025 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBVyzSzL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD141E2858;
	Sat, 20 Sep 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379938; cv=none; b=nOqhxQgGJsATa3CtW25nW4D3YjQvuk2jGiNph8zsH6FIowHAV/rC+1aVGSODaZsQs9Xu2KnBd6hn2Pu50U3B4SXm9SirkiTL+kcTlKtd37ZjVOIoMahNX9wZR+9iGVI0b7h45mNPh8ph8wgw4tZFIJ+YqBZlyqGMBzTaO81De+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379938; c=relaxed/simple;
	bh=UUc100DiH5QSCSSktpUYXl2/8ztlxI58qE2abR1pwAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPRB/KlMb+d2jBDluAjbnxwW7ZkEgOQuVLs6SJ9bQLolIxC8jIiUObDdGwvXgbANzhtqGIFYzdFaycMKinfk9k6pVbI5QaMTW1V7lTr4dreNoNyZfYXZn6Y8d63zaiLYMbYIIZFK3wR4J390tc1vN5maloxJqnqWU9BJzoePiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBVyzSzL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758379935; x=1789915935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UUc100DiH5QSCSSktpUYXl2/8ztlxI58qE2abR1pwAo=;
  b=EBVyzSzL7OZRvlfpLWzjc40ZRm9vd52VSOXmR6w0ArUMAz5ra9vaxIt2
   XOVU1Ub8pB2kjuawM0Mygyv3yPHAnKmLKkrhNjHI5IKzzYSNI4IEXlC1z
   lzFmijzFzJdjW5J+5hOv1YJuSiGI1tSChS1+3z4O3mQGVIX72Cr0+8jQ3
   5/ggXotsLOPrRkWZDgT9Rgif0I3BRzFRr7eg941TjLgj+PvqO0+ADRcVV
   dGqw6Bd5MzjtSGNbBhL8foxUuV1tc0cKZHUvUQPsr850lBDcOHCrGrKp6
   VnaDwugKDI3W2yDH4eNqJiF9VzojOwzWPILpfHjrlqUsy2VPRNaz8sCIB
   w==;
X-CSE-ConnectionGUID: RffmTo3YQ+KHBLQ99tb99g==
X-CSE-MsgGUID: hgL6a3/WStaSlGrAjKHSuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="64342008"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="64342008"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 07:52:13 -0700
X-CSE-ConnectionGUID: 6OvbacEKTU2c8vyfRuSxaQ==
X-CSE-MsgGUID: 1lrjLAWUTZmK37vpom/sQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="181236519"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Sep 2025 07:52:08 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzywX-0005ON-01;
	Sat, 20 Sep 2025 14:52:05 +0000
Date: Sat, 20 Sep 2025 22:52:01 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Lu <luxu.kernel@bytedance.com>, corbet@lwn.net, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	mark.rutland@arm.com, parri.andrea@gmail.com,
	ajones@ventanamicro.com, brs@rivosinc.com, anup@brainfault.org,
	atish.patra@linux.dev, pbonzini@redhat.com, shuah@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: Re: [PATCH v3 6/8] riscv: Apply acquire/release semantics to
 arch_xchg/arch_cmpxchg operations
Message-ID: <202509202249.rOR3GJbT-lkp@intel.com>
References: <20250919073714.83063-7-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919073714.83063-7-luxu.kernel@bytedance.com>

Hi Xu,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on kvm/queue kvm/next linus/master v6.17-rc6]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Lu/riscv-add-ISA-extension-parsing-for-Zalasr/20250919-154304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250919073714.83063-7-luxu.kernel%40bytedance.com
patch subject: [PATCH v3 6/8] riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
config: riscv-randconfig-002-20250920 (https://download.01.org/0day-ci/archive/20250920/202509202249.rOR3GJbT-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509202249.rOR3GJbT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509202249.rOR3GJbT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/objpool.c:3:
>> include/linux/objpool.h:156:7: error: invalid .org offset '1528' (at offset '1532')
     156 |                 if (try_cmpxchg_release(&slot->head, &head, head + 1))
         |                     ^
   include/linux/atomic/atomic-instrumented.h:4899:2: note: expanded from macro 'try_cmpxchg_release'
    4899 |         raw_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:228:9: note: expanded from macro 'raw_try_cmpxchg_release'
     228 |         ___r = raw_cmpxchg_release((_ptr), ___o, (_new)); \
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
   In file included from lib/objpool.c:3:
>> include/linux/objpool.h:156:7: error: invalid .org offset '1528' (at offset '1532')
     156 |                 if (try_cmpxchg_release(&slot->head, &head, head + 1))
         |                     ^
   include/linux/atomic/atomic-instrumented.h:4899:2: note: expanded from macro 'try_cmpxchg_release'
    4899 |         raw_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:228:9: note: expanded from macro 'raw_try_cmpxchg_release'
     228 |         ___r = raw_cmpxchg_release((_ptr), ___o, (_new)); \
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
   2 errors generated.
--
>> lib/generic-radix-tree.c:53:12: error: invalid .org offset '1850' (at offset '1854')
      53 |                 if ((v = cmpxchg_release(&radix->root, r, new_root)) == r) {
         |                          ^
   include/linux/atomic/atomic-instrumented.h:4803:2: note: expanded from macro 'cmpxchg_release'
    4803 |         raw_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:265:2: note: expanded from macro 'arch_cmpxchg_release'
     265 |         _arch_cmpxchg((ptr), (o), (n),                                  \
         |         ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
   lib/generic-radix-tree.c:74:14: error: invalid .org offset '1862' (at offset '1866')
      74 |                         if (!(n = cmpxchg_release(p, NULL, new_node)))
         |                                   ^
   include/linux/atomic/atomic-instrumented.h:4803:2: note: expanded from macro 'cmpxchg_release'
    4803 |         raw_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:265:2: note: expanded from macro 'arch_cmpxchg_release'
     265 |         _arch_cmpxchg((ptr), (o), (n),                                  \
         |         ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
>> lib/generic-radix-tree.c:53:12: error: invalid .org offset '1850' (at offset '1854')
      53 |                 if ((v = cmpxchg_release(&radix->root, r, new_root)) == r) {
         |                          ^
   include/linux/atomic/atomic-instrumented.h:4803:2: note: expanded from macro 'cmpxchg_release'
    4803 |         raw_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:265:2: note: expanded from macro 'arch_cmpxchg_release'
     265 |         _arch_cmpxchg((ptr), (o), (n),                                  \
         |         ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
   lib/generic-radix-tree.c:74:14: error: invalid .org offset '1862' (at offset '1866')
      74 |                         if (!(n = cmpxchg_release(p, NULL, new_node)))
         |                                   ^
   include/linux/atomic/atomic-instrumented.h:4803:2: note: expanded from macro 'cmpxchg_release'
    4803 |         raw_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:265:2: note: expanded from macro 'arch_cmpxchg_release'
     265 |         _arch_cmpxchg((ptr), (o), (n),                                  \
         |         ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
   4 errors generated.
--
   In file included from lib/refcount.c:6:
   In file included from include/linux/mutex.h:17:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:2083:9: error: invalid .org offset '528' (at offset '532')
    2083 |         return raw_cmpxchg_release(&v->counter, old, new);
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:265:2: note: expanded from macro 'arch_cmpxchg_release'
     265 |         _arch_cmpxchg((ptr), (o), (n),                                  \
         |         ^
   arch/riscv/include/asm/cmpxchg.h:238:3: note: expanded from macro '_arch_cmpxchg'
     238 |                 __arch_cmpxchg(".w" lr_sfx, ".w" sc_sfx, ".w" cas_sfx,  \
         |                 ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
   In file included from lib/refcount.c:6:
   In file included from include/linux/mutex.h:17:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:2083:9: error: invalid .org offset '540' (at offset '544')
    2083 |         return raw_cmpxchg_release(&v->counter, old, new);
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:265:2: note: expanded from macro 'arch_cmpxchg_release'
     265 |         _arch_cmpxchg((ptr), (o), (n),                                  \
         |         ^
   arch/riscv/include/asm/cmpxchg.h:238:3: note: expanded from macro '_arch_cmpxchg'
     238 |                 __arch_cmpxchg(".w" lr_sfx, ".w" sc_sfx, ".w" cas_sfx,  \
         |                 ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
   In file included from lib/refcount.c:6:
   In file included from include/linux/mutex.h:17:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:2083:9: error: invalid .org offset '528' (at offset '532')
    2083 |         return raw_cmpxchg_release(&v->counter, old, new);
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:265:2: note: expanded from macro 'arch_cmpxchg_release'
     265 |         _arch_cmpxchg((ptr), (o), (n),                                  \
         |         ^
   arch/riscv/include/asm/cmpxchg.h:238:3: note: expanded from macro '_arch_cmpxchg'
     238 |                 __arch_cmpxchg(".w" lr_sfx, ".w" sc_sfx, ".w" cas_sfx,  \
         |                 ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
   In file included from lib/refcount.c:6:
   In file included from include/linux/mutex.h:17:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:14:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:2083:9: error: invalid .org offset '540' (at offset '544')
    2083 |         return raw_cmpxchg_release(&v->counter, old, new);
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:265:2: note: expanded from macro 'arch_cmpxchg_release'
     265 |         _arch_cmpxchg((ptr), (o), (n),                                  \
         |         ^
   arch/riscv/include/asm/cmpxchg.h:238:3: note: expanded from macro '_arch_cmpxchg'
     238 |                 __arch_cmpxchg(".w" lr_sfx, ".w" sc_sfx, ".w" cas_sfx,  \
         |                 ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
   4 errors generated.
--
>> fs/overlayfs/file.c:147:10: error: invalid .org offset '3640' (at offset '3644')
     147 |                         old = cmpxchg_release(&of->upperfile, NULL, upperfile);
         |                               ^
   include/linux/atomic/atomic-instrumented.h:4803:2: note: expanded from macro 'cmpxchg_release'
    4803 |         raw_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:265:2: note: expanded from macro 'arch_cmpxchg_release'
     265 |         _arch_cmpxchg((ptr), (o), (n),                                  \
         |         ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
>> fs/overlayfs/file.c:147:10: error: invalid .org offset '3640' (at offset '3644')
     147 |                         old = cmpxchg_release(&of->upperfile, NULL, upperfile);
         |                               ^
   include/linux/atomic/atomic-instrumented.h:4803:2: note: expanded from macro 'cmpxchg_release'
    4803 |         raw_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^
   arch/riscv/include/asm/cmpxchg.h:265:2: note: expanded from macro 'arch_cmpxchg_release'
     265 |         _arch_cmpxchg((ptr), (o), (n),                                  \
         |         ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/riscv/include/asm/alternative-macros.h:104:2: note: expanded from macro '_ALTERNATIVE_CFG'
     104 |         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, patch_id, IS_ENABLED(CONFIG_k))
         |         ^
   arch/riscv/include/asm/alternative-macros.h:94:2: note: expanded from macro '__ALTERNATIVE_CFG'
      94 |         ALT_NEW_CONTENT(vendor_id, patch_id, enable, new_c)
         |         ^
   arch/riscv/include/asm/alternative-macros.h:81:3: note: expanded from macro 'ALT_NEW_CONTENT'
      81 |         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
         |          ^
   <inline asm>:27:6: note: instantiated into assembly here
      27 | .org    . - (887b - 886b) + (889b - 888b)
         |         ^
   2 errors generated.
..


vim +156 include/linux/objpool.h

b4edb8d2d4647a wuqiang.matt    2023-10-17  100  
b4edb8d2d4647a wuqiang.matt    2023-10-17  101  /**
b4edb8d2d4647a wuqiang.matt    2023-10-17  102   * objpool_init() - initialize objpool and pre-allocated objects
b4edb8d2d4647a wuqiang.matt    2023-10-17  103   * @pool:    the object pool to be initialized, declared by caller
b4edb8d2d4647a wuqiang.matt    2023-10-17  104   * @nr_objs: total objects to be pre-allocated by this object pool
b4edb8d2d4647a wuqiang.matt    2023-10-17  105   * @object_size: size of an object (should be > 0)
b4edb8d2d4647a wuqiang.matt    2023-10-17  106   * @gfp:     flags for memory allocation (via kmalloc or vmalloc)
b4edb8d2d4647a wuqiang.matt    2023-10-17  107   * @context: user context for object initialization callback
b4edb8d2d4647a wuqiang.matt    2023-10-17  108   * @objinit: object initialization callback for extra setup
b4edb8d2d4647a wuqiang.matt    2023-10-17  109   * @release: cleanup callback for extra cleanup task
b4edb8d2d4647a wuqiang.matt    2023-10-17  110   *
b4edb8d2d4647a wuqiang.matt    2023-10-17  111   * return value: 0 for success, otherwise error code
b4edb8d2d4647a wuqiang.matt    2023-10-17  112   *
b4edb8d2d4647a wuqiang.matt    2023-10-17  113   * All pre-allocated objects are to be zeroed after memory allocation.
b4edb8d2d4647a wuqiang.matt    2023-10-17  114   * Caller could do extra initialization in objinit callback. objinit()
b4edb8d2d4647a wuqiang.matt    2023-10-17  115   * will be called just after slot allocation and called only once for
b4edb8d2d4647a wuqiang.matt    2023-10-17  116   * each object. After that the objpool won't touch any content of the
b4edb8d2d4647a wuqiang.matt    2023-10-17  117   * objects. It's caller's duty to perform reinitialization after each
b4edb8d2d4647a wuqiang.matt    2023-10-17  118   * pop (object allocation) or do clearance before each push (object
b4edb8d2d4647a wuqiang.matt    2023-10-17  119   * reclamation).
b4edb8d2d4647a wuqiang.matt    2023-10-17  120   */
b4edb8d2d4647a wuqiang.matt    2023-10-17  121  int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
b4edb8d2d4647a wuqiang.matt    2023-10-17  122  		 gfp_t gfp, void *context, objpool_init_obj_cb objinit,
b4edb8d2d4647a wuqiang.matt    2023-10-17  123  		 objpool_fini_cb release);
b4edb8d2d4647a wuqiang.matt    2023-10-17  124  
a3b00f10da808b Andrii Nakryiko 2024-04-24  125  /* try to retrieve object from slot */
a3b00f10da808b Andrii Nakryiko 2024-04-24  126  static inline void *__objpool_try_get_slot(struct objpool_head *pool, int cpu)
a3b00f10da808b Andrii Nakryiko 2024-04-24  127  {
a3b00f10da808b Andrii Nakryiko 2024-04-24  128  	struct objpool_slot *slot = pool->cpu_slots[cpu];
a3b00f10da808b Andrii Nakryiko 2024-04-24  129  	/* load head snapshot, other cpus may change it */
a3b00f10da808b Andrii Nakryiko 2024-04-24  130  	uint32_t head = smp_load_acquire(&slot->head);
a3b00f10da808b Andrii Nakryiko 2024-04-24  131  
a3b00f10da808b Andrii Nakryiko 2024-04-24  132  	while (head != READ_ONCE(slot->last)) {
a3b00f10da808b Andrii Nakryiko 2024-04-24  133  		void *obj;
a3b00f10da808b Andrii Nakryiko 2024-04-24  134  
a3b00f10da808b Andrii Nakryiko 2024-04-24  135  		/*
a3b00f10da808b Andrii Nakryiko 2024-04-24  136  		 * data visibility of 'last' and 'head' could be out of
a3b00f10da808b Andrii Nakryiko 2024-04-24  137  		 * order since memory updating of 'last' and 'head' are
a3b00f10da808b Andrii Nakryiko 2024-04-24  138  		 * performed in push() and pop() independently
a3b00f10da808b Andrii Nakryiko 2024-04-24  139  		 *
a3b00f10da808b Andrii Nakryiko 2024-04-24  140  		 * before any retrieving attempts, pop() must guarantee
a3b00f10da808b Andrii Nakryiko 2024-04-24  141  		 * 'last' is behind 'head', that is to say, there must
a3b00f10da808b Andrii Nakryiko 2024-04-24  142  		 * be available objects in slot, which could be ensured
a3b00f10da808b Andrii Nakryiko 2024-04-24  143  		 * by condition 'last != head && last - head <= nr_objs'
a3b00f10da808b Andrii Nakryiko 2024-04-24  144  		 * that is equivalent to 'last - head - 1 < nr_objs' as
a3b00f10da808b Andrii Nakryiko 2024-04-24  145  		 * 'last' and 'head' are both unsigned int32
a3b00f10da808b Andrii Nakryiko 2024-04-24  146  		 */
a3b00f10da808b Andrii Nakryiko 2024-04-24  147  		if (READ_ONCE(slot->last) - head - 1 >= pool->nr_objs) {
a3b00f10da808b Andrii Nakryiko 2024-04-24  148  			head = READ_ONCE(slot->head);
a3b00f10da808b Andrii Nakryiko 2024-04-24  149  			continue;
a3b00f10da808b Andrii Nakryiko 2024-04-24  150  		}
a3b00f10da808b Andrii Nakryiko 2024-04-24  151  
a3b00f10da808b Andrii Nakryiko 2024-04-24  152  		/* obj must be retrieved before moving forward head */
a3b00f10da808b Andrii Nakryiko 2024-04-24  153  		obj = READ_ONCE(slot->entries[head & slot->mask]);
a3b00f10da808b Andrii Nakryiko 2024-04-24  154  
a3b00f10da808b Andrii Nakryiko 2024-04-24  155  		/* move head forward to mark it's consumption */
a3b00f10da808b Andrii Nakryiko 2024-04-24 @156  		if (try_cmpxchg_release(&slot->head, &head, head + 1))
a3b00f10da808b Andrii Nakryiko 2024-04-24  157  			return obj;
a3b00f10da808b Andrii Nakryiko 2024-04-24  158  	}
a3b00f10da808b Andrii Nakryiko 2024-04-24  159  
a3b00f10da808b Andrii Nakryiko 2024-04-24  160  	return NULL;
a3b00f10da808b Andrii Nakryiko 2024-04-24  161  }
a3b00f10da808b Andrii Nakryiko 2024-04-24  162  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

