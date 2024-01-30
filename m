Return-Path: <linux-kselftest+bounces-3774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DCA842F6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 23:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DFA1C22331
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 22:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DE17D40A;
	Tue, 30 Jan 2024 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBWaUsRs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311EC7D402;
	Tue, 30 Jan 2024 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652764; cv=none; b=uJ/vn11O8Txto3Jo2pC4odixfYdJ5aI8K9mS51k4CUhiCR7AcqhL+I4pFlLakaG0cZm81MQzdFcgMfqEH9B7ZxQsBDMXcWb3lHgxenA2OGZsMGCf5YqaRtopAWjYwqOiF2IZAvZA+2fTrVjQyl8xlh6viJTFUN/FDW/GPvh7hQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652764; c=relaxed/simple;
	bh=SdLU3sGcmj4oZljBiGm2nYM+yKHs1TV50H1uosJASlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7jgMADJ+EyT3cspD8QPwIHkpHqeBS+DRDVFd99e5eaG+UTDgP/O0KiZuRMC4MowxWouIai9zRUQIjWCxw5B/su9Z8i34DyB1oBrNBjcv2De2kMkPi0Ot9rGlW0IVfIYD/EjxTKJN5WD5zWbXJ5BpGfc2CFCXZBrVihJlSNUfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBWaUsRs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706652763; x=1738188763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SdLU3sGcmj4oZljBiGm2nYM+yKHs1TV50H1uosJASlU=;
  b=mBWaUsRsIeJczFFsdSlxEzBj+cklkUgXoJ3WhX4rQW6AYJieU1xo9QsD
   xMJgk/rZ+DlJgCajHIG2jADIUYXg1p+3UxeL2qdmKN5Bp5vdONHPy6W+p
   VgBipJGmTV6Z4HutFCLv2BBiO+65mlwF0eiCbRa/5LVBsZEhCrcp4ihDw
   41j8isoukHxKArQk1YhT2lxD4gaC8eekDsprxNWRXu0AyWMBUo1lqM/Db
   TC6azlJDuJEHdTjIjTji5T7YbMrifOZDHLp9BySJ7jOJB6smI9nW2iXjD
   M523pUa4DTsvdCfohExusi9pNxBdGwBWkPESCYztWm1ycxf7JYiHF0PIa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10802454"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10802454"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3848620"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 30 Jan 2024 14:12:38 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUwLL-0000s1-2r;
	Tue, 30 Jan 2024 22:12:35 +0000
Date: Wed, 31 Jan 2024 06:12:22 +0800
From: kernel test robot <lkp@intel.com>
To: Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Yangyu Chen <cyy@cyyself.name>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH 1/3] riscv: mm: Use hint address in mmap if available
Message-ID: <202401310513.lub8Ilwm-lkp@intel.com>
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
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20240131/202401310513.lub8Ilwm-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project fdac7d0b6f74f919d319b31a0680c77f66732586)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401310513.lub8Ilwm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401310513.lub8Ilwm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/mmap.c:1703:33: error: expected expression
    1703 |         const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
         |                                        ^
   arch/riscv/include/asm/processor.h:28:2: note: expanded from macro 'arch_get_mmap_end'
      28 |         else                                                    \
         |         ^
   mm/mmap.c:1751:33: error: expected expression
    1751 |         const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
         |                                        ^
   arch/riscv/include/asm/processor.h:28:2: note: expanded from macro 'arch_get_mmap_end'
      28 |         else                                                    \
         |         ^
   2 errors generated.


vim +1703 mm/mmap.c

f6795053dac8d4d Steve Capper           2018-12-06  1683  
^1da177e4c3f415 Linus Torvalds         2005-04-16  1684  /* Get an address range which is currently unmapped.
^1da177e4c3f415 Linus Torvalds         2005-04-16  1685   * For shmat() with addr=0.
^1da177e4c3f415 Linus Torvalds         2005-04-16  1686   *
^1da177e4c3f415 Linus Torvalds         2005-04-16  1687   * Ugly calling convention alert:
^1da177e4c3f415 Linus Torvalds         2005-04-16  1688   * Return value with the low bits set means error value,
^1da177e4c3f415 Linus Torvalds         2005-04-16  1689   * ie
^1da177e4c3f415 Linus Torvalds         2005-04-16  1690   *	if (ret & ~PAGE_MASK)
^1da177e4c3f415 Linus Torvalds         2005-04-16  1691   *		error = ret;
^1da177e4c3f415 Linus Torvalds         2005-04-16  1692   *
^1da177e4c3f415 Linus Torvalds         2005-04-16  1693   * This function "knows" that -ENOMEM has the bits set.
^1da177e4c3f415 Linus Torvalds         2005-04-16  1694   */
^1da177e4c3f415 Linus Torvalds         2005-04-16  1695  unsigned long
4b439e25e29ec33 Christophe Leroy       2022-04-09  1696  generic_get_unmapped_area(struct file *filp, unsigned long addr,
4b439e25e29ec33 Christophe Leroy       2022-04-09  1697  			  unsigned long len, unsigned long pgoff,
4b439e25e29ec33 Christophe Leroy       2022-04-09  1698  			  unsigned long flags)
^1da177e4c3f415 Linus Torvalds         2005-04-16  1699  {
^1da177e4c3f415 Linus Torvalds         2005-04-16  1700  	struct mm_struct *mm = current->mm;
1be7107fbe18eed Hugh Dickins           2017-06-19  1701  	struct vm_area_struct *vma, *prev;
db4fbfb9523c935 Michel Lespinasse      2012-12-11  1702  	struct vm_unmapped_area_info info;
2cb4de085f383cb Christophe Leroy       2022-04-09 @1703  	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
^1da177e4c3f415 Linus Torvalds         2005-04-16  1704  
f6795053dac8d4d Steve Capper           2018-12-06  1705  	if (len > mmap_end - mmap_min_addr)
^1da177e4c3f415 Linus Torvalds         2005-04-16  1706  		return -ENOMEM;
^1da177e4c3f415 Linus Torvalds         2005-04-16  1707  
06abdfb47ee745a Benjamin Herrenschmidt 2007-05-06  1708  	if (flags & MAP_FIXED)
06abdfb47ee745a Benjamin Herrenschmidt 2007-05-06  1709  		return addr;
06abdfb47ee745a Benjamin Herrenschmidt 2007-05-06  1710  
^1da177e4c3f415 Linus Torvalds         2005-04-16  1711  	if (addr) {
^1da177e4c3f415 Linus Torvalds         2005-04-16  1712  		addr = PAGE_ALIGN(addr);
1be7107fbe18eed Hugh Dickins           2017-06-19  1713  		vma = find_vma_prev(mm, addr, &prev);
f6795053dac8d4d Steve Capper           2018-12-06  1714  		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
1be7107fbe18eed Hugh Dickins           2017-06-19  1715  		    (!vma || addr + len <= vm_start_gap(vma)) &&
1be7107fbe18eed Hugh Dickins           2017-06-19  1716  		    (!prev || addr >= vm_end_gap(prev)))
^1da177e4c3f415 Linus Torvalds         2005-04-16  1717  			return addr;
^1da177e4c3f415 Linus Torvalds         2005-04-16  1718  	}
^1da177e4c3f415 Linus Torvalds         2005-04-16  1719  
db4fbfb9523c935 Michel Lespinasse      2012-12-11  1720  	info.flags = 0;
db4fbfb9523c935 Michel Lespinasse      2012-12-11  1721  	info.length = len;
4e99b02131b280b Heiko Carstens         2013-11-12  1722  	info.low_limit = mm->mmap_base;
f6795053dac8d4d Steve Capper           2018-12-06  1723  	info.high_limit = mmap_end;
db4fbfb9523c935 Michel Lespinasse      2012-12-11  1724  	info.align_mask = 0;
09ef5283fd96ac4 Jaewon Kim             2020-04-10  1725  	info.align_offset = 0;
db4fbfb9523c935 Michel Lespinasse      2012-12-11  1726  	return vm_unmapped_area(&info);
^1da177e4c3f415 Linus Torvalds         2005-04-16  1727  }
4b439e25e29ec33 Christophe Leroy       2022-04-09  1728  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

