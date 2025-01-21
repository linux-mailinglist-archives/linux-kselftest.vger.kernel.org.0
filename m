Return-Path: <linux-kselftest+bounces-24887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3867A180AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B205C3A3676
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E71F428D;
	Tue, 21 Jan 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIEhO50T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB11F3D50;
	Tue, 21 Jan 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737471970; cv=none; b=MPZf+MlzXK8mSoN8RUmGuUSNF6P7wRn6uBL8d8qw00T/m6ZqI5E6l1S5vt5/VVH5FO08ClEeKlXxuiBMQw8z1EF0PF++tfL27Te9FsebJjU5O0vDkRt8NcDrHcDSk8o9RGx3VptnjhhSPov6IAf7P7T8Q/yUJiOXszrD6YpENM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737471970; c=relaxed/simple;
	bh=S3o4xpq8tYTaMjstzCaN30PnGEnKrBktJhCmmKimQcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg0xEIb0kqUFWoVQN79MukL8gT9/PNNBwUN48RJt4ELz8HVu+yTEhOAnl+zzr8aHvmvXC3TOgNssJ2XMEKqqpZ4QJwVfW62gik4evVVkYFqLBGe4An2RbK1Wk5PQBawm7aswuU8O9d/RDGvhFzA85VOcy70XueNajCwhcqQ1hkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIEhO50T; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737471969; x=1769007969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S3o4xpq8tYTaMjstzCaN30PnGEnKrBktJhCmmKimQcw=;
  b=jIEhO50TWXIamqTHy9zo0Qb59pOuPzMQZgeMHKNTOxCH8f41emsIbyUq
   9QPG/qMrzSET1ymc5mg8NOsZubZnav4QDRQG+tCyHeX6w1YW3sxliSepL
   8VGGpj3gU0l/2JTspizM+/ycxZ54z9RzU7SXBm4g3pDjc2mZcoeg7YuYy
   g9za+bKDE5np/RmmzC9rdxWX9XMk0eLOr3MCSisjsvocFisvYJ5WyTxPe
   sZvRNNV6oTZr5+WOA90gv9xxEOU6WtIizGUWsysY2VNvE1aLaGwDFc4Kk
   vztCzJKg3bEKFy6yrIycek6h6w0XXv9cuPTCRWf2yhv4jY/qOthF/CmUh
   w==;
X-CSE-ConnectionGUID: WzIfvOzxQPKHJQ2G+TNkYA==
X-CSE-MsgGUID: 2Dy2jhMVSjuhO60d9hfOMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38052840"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="38052840"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 07:05:51 -0800
X-CSE-ConnectionGUID: 5NiWJB7UTkymc2FPHxSDkw==
X-CSE-MsgGUID: P+6iTQlFReOnqbu/LWYeVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="106948955"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 21 Jan 2025 07:05:46 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1taFp2-000YC7-1C;
	Tue, 21 Jan 2025 15:05:44 +0000
Date: Tue, 21 Jan 2025 23:05:42 +0800
From: kernel test robot <lkp@intel.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>, ajones@ventanamicro.com,
	alexghiti@rivosinc.com, andybnac@gmail.com, aou@eecs.berkeley.edu,
	charlie@rivosinc.com, cleger@rivosinc.com,
	conor.dooley@microchip.com, conor@kernel.org, corbet@lwn.net,
	evan@rivosinc.com, jesse@rivosinc.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, samuel.holland@sifive.com,
	shuah@kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 2/3] RISC-V: hwprobe: Expose Zicbom extension and its
 block size
Message-ID: <202501212220.5GHTtuF7-lkp@intel.com>
References: <20250115024024.84365-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115024024.84365-3-cuiyunhui@bytedance.com>

Hi Yunhui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v6.13 next-20250121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunhui-Cui/RISC-V-Enable-cbo-clean-flush-in-usermode/20250115-104456
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20250115024024.84365-3-cuiyunhui%40bytedance.com
patch subject: [PATCH v5 2/3] RISC-V: hwprobe: Expose Zicbom extension and its block size
config: riscv-randconfig-r133-20250121 (https://download.01.org/0day-ci/archive/20250121/202501212220.5GHTtuF7-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project c23f2417dc5f6dc371afb07af5627ec2a9d373a0)
reproduce: (https://download.01.org/0day-ci/archive/20250121/202501212220.5GHTtuF7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501212220.5GHTtuF7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/sys_hwprobe.c:284:30: warning: implicit conversion from 'unsigned long long' to 'unsigned long' changes value from 1125899906842624 to 0 [-Wconstant-conversion]
     284 |                 if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
         |                     ~~~~~~~~~~~~~~~~       ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/uapi/asm/hwprobe.h:76:41: note: expanded from macro 'RISCV_HWPROBE_EXT_ZICBOM'
      76 | #define         RISCV_HWPROBE_EXT_ZICBOM        (1ULL << 50)
         |                                                  ~~~~~^~~~~
   1 warning generated.


vim +284 arch/riscv/kernel/sys_hwprobe.c

   244	
   245	static void hwprobe_one_pair(struct riscv_hwprobe *pair,
   246				     const struct cpumask *cpus)
   247	{
   248		switch (pair->key) {
   249		case RISCV_HWPROBE_KEY_MVENDORID:
   250		case RISCV_HWPROBE_KEY_MARCHID:
   251		case RISCV_HWPROBE_KEY_MIMPID:
   252			hwprobe_arch_id(pair, cpus);
   253			break;
   254		/*
   255		 * The kernel already assumes that the base single-letter ISA
   256		 * extensions are supported on all harts, and only supports the
   257		 * IMA base, so just cheat a bit here and tell that to
   258		 * userspace.
   259		 */
   260		case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
   261			pair->value = RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
   262			break;
   263	
   264		case RISCV_HWPROBE_KEY_IMA_EXT_0:
   265			hwprobe_isa_ext0(pair, cpus);
   266			break;
   267	
   268		case RISCV_HWPROBE_KEY_CPUPERF_0:
   269		case RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF:
   270			pair->value = hwprobe_misaligned(cpus);
   271			break;
   272	
   273		case RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF:
   274			pair->value = hwprobe_vec_misaligned(cpus);
   275			break;
   276	
   277		case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
   278			pair->value = 0;
   279			if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
   280				pair->value = riscv_cboz_block_size;
   281			break;
   282		case RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE:
   283			pair->value = 0;
 > 284			if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
   285				pair->value = riscv_cbom_block_size;
   286			break;
   287		case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
   288			pair->value = user_max_virt_addr();
   289			break;
   290	
   291		case RISCV_HWPROBE_KEY_TIME_CSR_FREQ:
   292			pair->value = riscv_timebase;
   293			break;
   294	
   295		/*
   296		 * For forward compatibility, unknown keys don't fail the whole
   297		 * call, but get their element key set to -1 and value set to 0
   298		 * indicating they're unrecognized.
   299		 */
   300		default:
   301			pair->key = -1;
   302			pair->value = 0;
   303			break;
   304		}
   305	}
   306	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

