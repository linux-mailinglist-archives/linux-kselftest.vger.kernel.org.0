Return-Path: <linux-kselftest+bounces-46340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84449C7DCBD
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 08:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B673A9D44
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE1C269B1C;
	Sun, 23 Nov 2025 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OczPVNPs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC2190477;
	Sun, 23 Nov 2025 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882228; cv=none; b=iQeupuHPf02EPwfALFdlSu5du/sT6Q3PA+ANPwCKcEt5adbzINhLNivIQk7dYegCdXZNe7KtSerHsAh1bs0kqgQwCMMC8v4oroyIa08+zig2GZoiC4anzsR8kPWpOR2TGD5Qpd0/FaMUWDHidPeJqPgyOSRingu4dS9fnygQYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882228; c=relaxed/simple;
	bh=klFGhZfdHv04LnhdgSwnQdGRqyMzvXSSnw/qSN1752Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffIpSGxIXP7n3OIm+jIV7euMmHQcyCN68ypVWacmIhwM1P+82GGrzO1Ima9fHFR/9VAavcmZ84CyfmKxNhRmdYbyksuM1Ld/F56uZo6f4e5I5QaHfzI/uWcFfNqgHUmgYi2Qc8k9elKdFql7QGIf1mC7lJzAj2/lCcqBYKtX28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OczPVNPs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763882227; x=1795418227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=klFGhZfdHv04LnhdgSwnQdGRqyMzvXSSnw/qSN1752Q=;
  b=OczPVNPsDKhnzL0Gw5UaPRVOLXlO7rXysgx7Ywb2ruUW6GzWNYLgg9vM
   0mjLoP6de/P7g+GDEjghK5j0WXzemNh0CnkF7nFdWOllb6OcxBWpM6NCx
   +hjbVkJMVKmvkw0FXvfgqsTETZHkuyYLDHcyQNdeo70kNqa+fOsbeAuEr
   tW8/l2xCfaN+r3UCrjPvIcE6FZbcT0dtaBgEG8xkqKGtZUN5mU6IVUEdN
   QdV5ds6BCZSTOxeoajCcLABg6BlqCrPkjOXsFcwZRW6CIYFf+33Rkjm94
   RmoND/HdJ4N/Lp8EvUxvNjp5Mv3qaCQXRsKtxK66GBTsi5qwEbnHvreUy
   Q==;
X-CSE-ConnectionGUID: 6pRC0fpkRR2W74eRscCZfQ==
X-CSE-MsgGUID: Bz/1NsQ0R7Cg8C9wS/V65g==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="68512367"
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; 
   d="scan'208";a="68512367"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 23:17:06 -0800
X-CSE-ConnectionGUID: G7MWCOqHR1Sy8LPd3BiM/g==
X-CSE-MsgGUID: FE/EBXUKSXiCwGtdZg1bpw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 22 Nov 2025 23:17:03 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vN4LE-00087P-30;
	Sun, 23 Nov 2025 07:17:00 +0000
Date: Sun, 23 Nov 2025 15:16:41 +0800
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
Message-ID: <202511231423.O6KdcL8r-lkp@intel.com>
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
config: i386-randconfig-063-20251123 (https://download.01.org/0day-ci/archive/20251123/202511231423.O6KdcL8r-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251123/202511231423.O6KdcL8r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511231423.O6KdcL8r-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/futex/syscalls.c:200:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct robust_list_head *head @@     got struct robust_list_head [noderef] __user * @@
   kernel/futex/syscalls.c:200:22: sparse:     expected struct robust_list_head *head
   kernel/futex/syscalls.c:200:22: sparse:     got struct robust_list_head [noderef] __user *
>> kernel/futex/syscalls.c:202:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *__x @@     got struct robust_list_head *head @@
   kernel/futex/syscalls.c:202:24: sparse:     expected void [noderef] __user *__x
   kernel/futex/syscalls.c:202:24: sparse:     got struct robust_list_head *head

vim +200 kernel/futex/syscalls.c

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

