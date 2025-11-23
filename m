Return-Path: <linux-kselftest+bounces-46341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFCEC7DF42
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D159C4E1207
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679432C17A1;
	Sun, 23 Nov 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLK5i3hk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53C284671;
	Sun, 23 Nov 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763892208; cv=none; b=V5so3KkpkvdiywnSUWwghkHd3nBFdkC0UNBNxsjwj3iD35gw1ndo5gE1ZwHinfTNb7uKDkbTlRgUmpKzKkPXEWR+pdkA0Ny6Yh6ttvirDGrJHmQmLpFGsP4H+VXmXAmGegApqo0u/WXLjNiqDMlv/QYV3IY8ZX3lT3R8RVj6gI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763892208; c=relaxed/simple;
	bh=jFKfTL/uXLSHK4D2ba807qGe+7TJsj3L75BOS82YIks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0edESl6uUmh5uXglLmpEii32eKJOsFMdVhAAFUVdieaEtTcGw07VMA5SyxCfxAjyFKCybSj06V0/6pdkYO6KIj3yk8HFqPCJj9K8x2BV8yH/x4UQK1BIa3OUKLeipUsUD7TfmvmjzYaEkH/rk+PCLniKXr78BzZXL+1eNO9gNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLK5i3hk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763892206; x=1795428206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jFKfTL/uXLSHK4D2ba807qGe+7TJsj3L75BOS82YIks=;
  b=LLK5i3hkGq3Bb1ihIMK0ElVm/e5HobZLUHcO0WjX8lzBnjRgvZ0qWizT
   azV+AtVO9o/DLWPV0GOgWrTZN2h4+T6KAOKsKNQ2fZY56geT4j3iVO1ia
   p7t5/Yrd5cSM5+rV7BA3kivtsddGqEQcZiS/+y40yYV7wQkyjrA850Put
   LHRFLhka02uswoAjIUjx1UMFTnKIXsmyRkFJeS7hC91Zfc1Nd3aGd72oX
   UUP6qyoYw6/Ma5GABFKs9Wt9o7EPKWq0O8MOSf6w7UCqBNVLiexMhneyQ
   7/a7f9ASSWf9cvj7wXv2LXEU/EmN0mRh+NCH23umKf6Gp4QOsjfhpBAED
   A==;
X-CSE-ConnectionGUID: 94HGKpFxSjCHxpKRYIuahw==
X-CSE-MsgGUID: Ol+PJbTjRu2nD+mqnAeQvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="69783863"
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; 
   d="scan'208";a="69783863"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 02:03:25 -0800
X-CSE-ConnectionGUID: 1cIWax1SSPaT4SxTtSztig==
X-CSE-MsgGUID: G1akFP29SMOi2nlN4xDIIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; 
   d="scan'208";a="229369575"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Nov 2025 02:03:21 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vN6w7-0008Cd-0N;
	Sun, 23 Nov 2025 10:03:15 +0000
Date: Sun, 23 Nov 2025 18:02:52 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Ryan Houdek <Sonicadvance1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	kernel-dev@igalia.com,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v6 4/9] futex: Create get_robust_list2() syscall
Message-ID: <202511231703.YmF7ihi0-lkp@intel.com>
References: <20251122-tonyk-robust_futex-v6-4-05fea005a0fd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122-tonyk-robust_futex-v6-4-05fea005a0fd@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c42ba5a87bdccbca11403b7ca8bad1a57b833732]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/futex-Use-explicit-sizes-for-compat_robust_list-structs/20251122-135406
base:   c42ba5a87bdccbca11403b7ca8bad1a57b833732
patch link:    https://lore.kernel.org/r/20251122-tonyk-robust_futex-v6-4-05fea005a0fd%40igalia.com
patch subject: [PATCH v6 4/9] futex: Create get_robust_list2() syscall
config: loongarch-randconfig-r122-20251123 (https://download.01.org/0day-ci/archive/20251123/202511231703.YmF7ihi0-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251123/202511231703.YmF7ihi0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511231703.YmF7ihi0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/futex/syscalls.c:200:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct robust_list_head *head @@     got struct robust_list_head [noderef] __user * @@
   kernel/futex/syscalls.c:200:22: sparse:     expected struct robust_list_head *head
   kernel/futex/syscalls.c:200:22: sparse:     got struct robust_list_head [noderef] __user *
>> kernel/futex/syscalls.c:202:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__pu_val @@     got struct robust_list_head *head @@
   kernel/futex/syscalls.c:202:24: sparse:     expected void [noderef] __user *__pu_val
   kernel/futex/syscalls.c:202:24: sparse:     got struct robust_list_head *head

vim +202 kernel/futex/syscalls.c

   160	
   161	SYSCALL_DEFINE4(get_robust_list2, int, pid,
   162			void __user * __user *, head_ptr,
   163			unsigned int, index, unsigned int, flags)
   164	{
   165		void __user *entry_ptr;
   166		uintptr_t entry;
   167	
   168		if (index >= FUTEX_ROBUST_LISTS_PER_USER)
   169			return -EINVAL;
   170	
   171		if (flags)
   172			return -EINVAL;
   173	
   174		/*
   175		 * The first two indexes are reserved for the kernel to be used with the
   176		 * legacy syscall, so we hide them from userspace.
   177		 *
   178		 * We map [0, FUTEX_ROBUST_LISTS_PER_USER) to
   179		 *  [FUTEX_ROBUST_LIST2_IDX, FUTEX_ROBUST_LIST2_MAX_IDX)
   180		 */
   181		index += FUTEX_ROBUST_LIST2_IDX;
   182	
   183		entry_ptr = futex_get_robust_list_common(pid, false, index);
   184		if (IS_ERR(entry_ptr))
   185			return PTR_ERR(entry_ptr);
   186	
   187		entry = (uintptr_t) entry_ptr;
   188	
   189		if (entry & FUTEX_ROBUST_LIST_ENTRY_32BIT) {
   190			entry &= FUTEX_ROBUST_LIST_ENTRY_MASK;
   191	
   192			if (copy_to_user(head_ptr, &entry, sizeof(u32)))
   193				return -EFAULT;
   194	
   195			return 0;
   196		} else {
   197			struct robust_list_head *head;
   198	
   199			entry &= FUTEX_ROBUST_LIST_ENTRY_MASK;
 > 200			head = (__force struct robust_list_head __user *)entry;
   201	
 > 202			return put_user(head, head_ptr);
   203		}
   204	}
   205	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

