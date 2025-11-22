Return-Path: <linux-kselftest+bounces-46311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5E3C7C989
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 08:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C4C3A7EDB
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018F25A642;
	Sat, 22 Nov 2025 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sjlk1t9Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCDD14A91;
	Sat, 22 Nov 2025 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763796767; cv=none; b=YrijXbxmTlshNa3sNUT75Q7yb9ubWBNXBiRAwcX8WQBPYdim1d/D2AAi55FBfh29eLeL7LBWAE+F2QLvo7HM2n3+DiirpoZ6jGQeF6CK5fKPWsPSwB0sC7C8JAixSmX8RCkEZh+QH5FwFEGuoEggyO0VYBlSXfS/WKZjnbzEvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763796767; c=relaxed/simple;
	bh=Nudo/f7ZBUHU5m8nUj5tqJU4nh7GKa/O9Gl8IzWCC8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9Vu6zqxWN4ZXARDRSy/HCXUYD7I8u9Gdzdum/nydQvaPBf7roYpgI62cU5j/E2iirJ6nHCjmFadRE/rWwzpslLZ0bqNzDQP/+bKNQHj8Ye+dxndwbwEV9PcaFgX1w8vSW2gTcNbUnPCXbMX5kJPfhTC3vNZv4LV6pJeAl74+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sjlk1t9Q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763796766; x=1795332766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Nudo/f7ZBUHU5m8nUj5tqJU4nh7GKa/O9Gl8IzWCC8A=;
  b=Sjlk1t9QhYmEzbuUli+pmutnDynCFSIaPZkFHPes7IaLt9EUaoYs+1KW
   BccA28gJc2Pn7uOjNWrbR8O3OWQ4yvhqk0ApErXH2NYPiID2XO4x0CH/p
   DVwYxYrOPHPkg26uchRft+1iNYSovro0vm82d4L8Y1TqhZbn0W0O8I5Oh
   cj/9AY3hlMkT86+Mu0n4eaFfE2wp+mi+W195L/dKwJ3x7ewWmuvWSYUp6
   9Q/PNWvMEtHwESxw5An7w/QcOMxXVKBEsHpw/ccRZ+RbYmmT1RG4lWO5I
   3LfMQ7NaTSYzVYENdDqMZRpLnMM1I9is/pX/Nwvx2JjzhDF342NU0PH8k
   Q==;
X-CSE-ConnectionGUID: HweW9bXIRHStprFOaJILpA==
X-CSE-MsgGUID: orFgIt9SSByDzuWKlFqFhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="68483068"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="68483068"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 23:32:45 -0800
X-CSE-ConnectionGUID: dPMFGBKlQgCOV4KbcqCW3A==
X-CSE-MsgGUID: qZMDcbbCTH2n8xMnZ9luDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="222515263"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2025 23:32:42 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMi6o-0007Fz-2c;
	Sat, 22 Nov 2025 07:32:38 +0000
Date: Sat, 22 Nov 2025 15:32:11 +0800
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
Subject: Re: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
Message-ID: <202511221516.vYMzvSVO-lkp@intel.com>
References: <20251122-tonyk-robust_futex-v6-6-05fea005a0fd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122-tonyk-robust_futex-v6-6-05fea005a0fd@igalia.com>

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on c42ba5a87bdccbca11403b7ca8bad1a57b833732]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/futex-Use-explicit-sizes-for-compat_robust_list-structs/20251122-135406
base:   c42ba5a87bdccbca11403b7ca8bad1a57b833732
patch link:    https://lore.kernel.org/r/20251122-tonyk-robust_futex-v6-6-05fea005a0fd%40igalia.com
patch subject: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20251122/202511221516.vYMzvSVO-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511221516.vYMzvSVO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511221516.vYMzvSVO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: arch/powerpc/kernel/syscalls/syscall.tbl: syscall table is not sorted or duplicates the same syscall number
   make[3]: *** [arch/powerpc/kernel/syscalls/Makefile:31: arch/powerpc/include/generated/asm/syscall_table_64.h] Error 1
   make[3]: *** Deleting file 'arch/powerpc/include/generated/asm/syscall_table_64.h'
>> error: arch/powerpc/kernel/syscalls/syscall.tbl: syscall table is not sorted or duplicates the same syscall number
   make[3]: *** [arch/powerpc/kernel/syscalls/Makefile:35: arch/powerpc/include/generated/asm/syscall_table_spu.h] Error 1
   make[3]: *** Deleting file 'arch/powerpc/include/generated/asm/syscall_table_spu.h'
>> error: arch/powerpc/kernel/syscalls/syscall.tbl: syscall table is not sorted or duplicates the same syscall number
   make[3]: *** [arch/powerpc/kernel/syscalls/Makefile:27: arch/powerpc/include/generated/asm/syscall_table_32.h] Error 1
   make[3]: *** Deleting file 'arch/powerpc/include/generated/asm/syscall_table_32.h'
   make[3]: Target 'all' not remade because of errors.
   make[2]: *** [arch/powerpc/Makefile:397: archheaders] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

