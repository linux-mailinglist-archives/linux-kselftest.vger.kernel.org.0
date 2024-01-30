Return-Path: <linux-kselftest+bounces-3769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D9842E5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 22:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6A31F248EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0B71B5C;
	Tue, 30 Jan 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W00wxUZ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08866E2A5;
	Tue, 30 Jan 2024 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648802; cv=none; b=eDbCPC3Zk1kuKULJbSVa3Iv8pOT8UpQJ9X049Y/9Wp2SnZyjhy8+Te9umxMJECaHzMNUbA3znY6hPJRKcTHL30NcfyE1Hbv6bt52NW4dHAZUmr46Ho0q49Qgr02s72CectUvvi6V6BUNxe3IOkGRoaEjbQzH2FtWFILpvIKrfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648802; c=relaxed/simple;
	bh=gM2k755jodQt1/XCCpHAG09gohkbqOUKelwFkZoypLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvbKtJjRL1iPGUPK+MvozCX261Bt+PogCdvh+fM902yskNChfdz0zbZW6W4zTxfTwhLiFTkckNUOR4iRgIRaadQGSj5+quO7v25Vfr5vhBaTXYnPdeIZnT3uE4YzcvXrSu6vzYfnBxZxb+BDCxJHnufUWlbsgEYorMQfblrAz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W00wxUZ6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706648800; x=1738184800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gM2k755jodQt1/XCCpHAG09gohkbqOUKelwFkZoypLo=;
  b=W00wxUZ6CDDbI7gZ+ySkygkrRg/MjygtQn+EZMQ7zCwQvWmL/rTDA6HF
   kGlUYWXFRAti1QFdD/jSRcxUo3Cx7KxtlEqTZ+ju9Lh4pK2cvmLtFZbdN
   dLCzY9B2vzk98YRkDLO9s1uZsta5YBOHfrZ6vS2U4bYzIgmN7ClgeYH+d
   YfpX9UVLcqdw1wzAqZRCo2hhIQCix+RdvGm7Fjo2lV5qthLEA6D8ZYhhL
   crDDxQSGxZ32q6PA8lnGF2JFc7U3LUUM+tR7oKGqyJQBdYpPdit8Oloqc
   ezNjaAVGopwgE6eNkWSd35psxx9T00VGgg7nyLBUFKU+u9UDYIBi5Hi8p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10788275"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10788275"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 13:06:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="911559025"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="911559025"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2024 13:06:34 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUvJQ-0000pY-1M;
	Tue, 30 Jan 2024 21:06:32 +0000
Date: Wed, 31 Jan 2024 05:05:35 +0800
From: kernel test robot <lkp@intel.com>
To: Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Yangyu Chen <cyy@cyyself.name>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH 1/3] riscv: mm: Use hint address in mmap if available
Message-ID: <202401310404.eNJvHoC9-lkp@intel.com>
References: <20240129-use_mmap_hint_address-v1-1-4c74da813ba1@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-use_mmap_hint_address-v1-1-4c74da813ba1@rivosinc.com>

Hi Charlie,

kernel test robot noticed the following build errors:

[auto build test ERROR on 556e2d17cae620d549c5474b1ece053430cd50bc]

url:    https://github.com/intel-lab-lkp/linux/commits/Charlie-Jenkins/riscv-mm-Use-hint-address-in-mmap-if-available/20240130-084208
base:   556e2d17cae620d549c5474b1ece053430cd50bc
patch link:    https://lore.kernel.org/r/20240129-use_mmap_hint_address-v1-1-4c74da813ba1%40rivosinc.com
patch subject: [PATCH 1/3] riscv: mm: Use hint address in mmap if available
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240131/202401310404.eNJvHoC9-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401310404.eNJvHoC9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401310404.eNJvHoC9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/irqflags.h:10,
                    from include/linux/irqflags.h:18,
                    from arch/riscv/include/asm/bitops.h:14,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from mm/mmap.c:12:
   mm/mmap.c: In function 'generic_get_unmapped_area':
>> arch/riscv/include/asm/processor.h:28:9: error: expected expression before 'else'
      28 |         else                                                    \
         |         ^~~~
   mm/mmap.c:1703:40: note: in expansion of macro 'arch_get_mmap_end'
    1703 |         const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
         |                                        ^~~~~~~~~~~~~~~~~
   mm/mmap.c: In function 'generic_get_unmapped_area_topdown':
>> arch/riscv/include/asm/processor.h:28:9: error: expected expression before 'else'
      28 |         else                                                    \
         |         ^~~~
   mm/mmap.c:1751:40: note: in expansion of macro 'arch_get_mmap_end'
    1751 |         const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
         |                                        ^~~~~~~~~~~~~~~~~
--
   In file included from arch/riscv/include/asm/irqflags.h:10,
                    from include/linux/irqflags.h:18,
                    from arch/riscv/include/asm/bitops.h:14,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from fs/hugetlbfs/inode.c:12:
   fs/hugetlbfs/inode.c: In function 'hugetlb_get_unmapped_area_bottomup':
>> arch/riscv/include/asm/processor.h:28:9: error: expected expression before 'else'
      28 |         else                                                    \
         |         ^~~~
   fs/hugetlbfs/inode.c:173:27: note: in expansion of macro 'arch_get_mmap_end'
     173 |         info.high_limit = arch_get_mmap_end(addr, len, flags);
         |                           ^~~~~~~~~~~~~~~~~
   fs/hugetlbfs/inode.c: In function 'hugetlb_get_unmapped_area_topdown':
>> arch/riscv/include/asm/processor.h:28:9: error: expected expression before 'else'
      28 |         else                                                    \
         |         ^~~~
   fs/hugetlbfs/inode.c:204:35: note: in expansion of macro 'arch_get_mmap_end'
     204 |                 info.high_limit = arch_get_mmap_end(addr, len, flags);
         |                                   ^~~~~~~~~~~~~~~~~
   fs/hugetlbfs/inode.c: In function 'generic_hugetlb_get_unmapped_area':
>> arch/riscv/include/asm/processor.h:28:9: error: expected expression before 'else'
      28 |         else                                                    \
         |         ^~~~
   fs/hugetlbfs/inode.c:219:40: note: in expansion of macro 'arch_get_mmap_end'
     219 |         const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
         |                                        ^~~~~~~~~~~~~~~~~


vim +/else +28 arch/riscv/include/asm/processor.h

add2cc6b6515f7 Charlie Jenkins 2023-08-09  20  
add2cc6b6515f7 Charlie Jenkins 2023-08-09  21  #define arch_get_mmap_end(addr, len, flags)			\
add2cc6b6515f7 Charlie Jenkins 2023-08-09  22  ({								\
add2cc6b6515f7 Charlie Jenkins 2023-08-09  23  	unsigned long mmap_end;					\
add2cc6b6515f7 Charlie Jenkins 2023-08-09  24  	typeof(addr) _addr = (addr);				\
c5712238cfe3f5 Charlie Jenkins 2024-01-29  25  	if ((_addr) == 0 ||					\
c5712238cfe3f5 Charlie Jenkins 2024-01-29  26  		(IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
c5712238cfe3f5 Charlie Jenkins 2024-01-29  27  		((_addr + len) > BIT(VA_BITS - 1)))		\
add2cc6b6515f7 Charlie Jenkins 2023-08-09 @28  	else							\
c5712238cfe3f5 Charlie Jenkins 2024-01-29  29  		mmap_end = (_addr + len);			\
add2cc6b6515f7 Charlie Jenkins 2023-08-09  30  	mmap_end;						\
add2cc6b6515f7 Charlie Jenkins 2023-08-09  31  })
add2cc6b6515f7 Charlie Jenkins 2023-08-09  32  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

