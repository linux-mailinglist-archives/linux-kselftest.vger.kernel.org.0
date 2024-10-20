Return-Path: <linux-kselftest+bounces-20211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A62E9A533F
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 11:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05C82824F3
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9DD13DDB8;
	Sun, 20 Oct 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFdnxIB6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0B84E0A;
	Sun, 20 Oct 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416101; cv=none; b=Cl2/FypmQFunsqjkjsGfTYQ0wtXXTqVn4itASg+RWUVDzd2w+5fXEMwhh/Zu4682tN6zLmkofH61B5zJKsffftmc+76CFE60F5hzyl2xFwDqFrvK67//NvSy5Tmcf3REijGbGFdAMOZBijOlm4vjYZxaC4U+ok2mt493YNyYiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416101; c=relaxed/simple;
	bh=0FjaOJikJqwtGL+Y9iaV7osiQQ6qFUvD/z2eON8YtPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alv9HYZvCkWwYIctfQx1FfNT43xQ1/5p2+KPe783Ik4MYArmK5fefTcEqrmqywUNDAOVT65QW9tAh4BKv4f/6nC5Je600L/CXIYz2NOS4jOsskFnytetKmX/Qgsj9ifzpboLq0Zi8SlF0ru/Z43eRgFJ7/tWygzHY30XhLK0DCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFdnxIB6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729416100; x=1760952100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0FjaOJikJqwtGL+Y9iaV7osiQQ6qFUvD/z2eON8YtPE=;
  b=OFdnxIB6dQT5B3f4Osh4G1881zHIJexQl0HwsKnOfL9O0azBpb49tbL5
   I7VwqRlhfBoBgBsppPyn5ofvu276/nKq3OsfjrZHNhvSKAuK+Oif58pnl
   gNBypY8aFOXiy79rtbcRQntYcMnn8uPZXvp08Nd3VJJCrNke2raQ6H0es
   5+42ADgjs2xKtnbskjmJVX8yZFJ1PJzQL88FA1TuOiElqKDkKppGMMAuE
   1WjhPNla7hoi1Sp3rFB/JTRmnozBir4t4jNPuYmkgJ2ssSmYhzjNn86T0
   mjMMEcBVYSAUTQ9d9hrH1Le+kJVI4X9BZ4eHuP4V2Z+4ojOM1xjzEHy3V
   g==;
X-CSE-ConnectionGUID: WP4d/s5IQaesapM3pU6f9A==
X-CSE-MsgGUID: cJqNOoXFQ92BLjV5A0CSaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="39528708"
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="39528708"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 02:21:36 -0700
X-CSE-ConnectionGUID: S96oavzKT2aa8bDdJHdbug==
X-CSE-MsgGUID: ISIQzx7HTDKxdHRiAqcjcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="79183515"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Oct 2024 02:21:30 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2S7r-000Q9C-2Q;
	Sun, 20 Oct 2024 09:21:27 +0000
Date: Sun, 20 Oct 2024 17:20:40 +0800
From: kernel test robot <lkp@intel.com>
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	corbet@lwn.net, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jeffxu@google.com,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, jannh@google.com, sroettger@google.com,
	pedro.falcato@gmail.com, linux-hardening@vger.kernel.org,
	willy@infradead.org, gregkh@linuxfoundation.org,
	deraadt@openbsd.org, surenb@google.com, merimus@google.com,
	rdunlap@infradead.org, Jeff Xu <jeffxu@chromium.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when
 sealed
Message-ID: <202410201724.kKCsANsw-lkp@intel.com>
References: <20241017005105.3047458-2-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017005105.3047458-2-jeffxu@chromium.org>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.12-rc3 next-20241018]
[cannot apply to kees/for-next/pstore kees/for-next/kspp linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jeffxu-chromium-org/mseal-Two-fixes-for-madvise-MADV_DONTNEED-when-sealed/20241017-085203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241017005105.3047458-2-jeffxu%40chromium.org
patch subject: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when sealed
config: i386-defconfig (https://download.01.org/0day-ci/archive/20241020/202410201724.kKCsANsw-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201724.kKCsANsw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201724.kKCsANsw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/mprotect.c:825:16: error: use of undeclared identifier 'VM_WASWRITE'
     825 |                         newflags |= VM_WASWRITE;
         |                                     ^
   1 error generated.


vim +/VM_WASWRITE +825 mm/mprotect.c

   705	
   706	/*
   707	 * pkey==-1 when doing a legacy mprotect()
   708	 */
   709	static int do_mprotect_pkey(unsigned long start, size_t len,
   710			unsigned long prot, int pkey)
   711	{
   712		unsigned long nstart, end, tmp, reqprot;
   713		struct vm_area_struct *vma, *prev;
   714		int error;
   715		const int grows = prot & (PROT_GROWSDOWN|PROT_GROWSUP);
   716		const bool rier = (current->personality & READ_IMPLIES_EXEC) &&
   717					(prot & PROT_READ);
   718		struct mmu_gather tlb;
   719		struct vma_iterator vmi;
   720	
   721		start = untagged_addr(start);
   722	
   723		prot &= ~(PROT_GROWSDOWN|PROT_GROWSUP);
   724		if (grows == (PROT_GROWSDOWN|PROT_GROWSUP)) /* can't be both */
   725			return -EINVAL;
   726	
   727		if (start & ~PAGE_MASK)
   728			return -EINVAL;
   729		if (!len)
   730			return 0;
   731		len = PAGE_ALIGN(len);
   732		end = start + len;
   733		if (end <= start)
   734			return -ENOMEM;
   735		if (!arch_validate_prot(prot, start))
   736			return -EINVAL;
   737	
   738		reqprot = prot;
   739	
   740		if (mmap_write_lock_killable(current->mm))
   741			return -EINTR;
   742	
   743		/*
   744		 * If userspace did not allocate the pkey, do not let
   745		 * them use it here.
   746		 */
   747		error = -EINVAL;
   748		if ((pkey != -1) && !mm_pkey_is_allocated(current->mm, pkey))
   749			goto out;
   750	
   751		vma_iter_init(&vmi, current->mm, start);
   752		vma = vma_find(&vmi, end);
   753		error = -ENOMEM;
   754		if (!vma)
   755			goto out;
   756	
   757		if (unlikely(grows & PROT_GROWSDOWN)) {
   758			if (vma->vm_start >= end)
   759				goto out;
   760			start = vma->vm_start;
   761			error = -EINVAL;
   762			if (!(vma->vm_flags & VM_GROWSDOWN))
   763				goto out;
   764		} else {
   765			if (vma->vm_start > start)
   766				goto out;
   767			if (unlikely(grows & PROT_GROWSUP)) {
   768				end = vma->vm_end;
   769				error = -EINVAL;
   770				if (!(vma->vm_flags & VM_GROWSUP))
   771					goto out;
   772			}
   773		}
   774	
   775		prev = vma_prev(&vmi);
   776		if (start > vma->vm_start)
   777			prev = vma;
   778	
   779		tlb_gather_mmu(&tlb, current->mm);
   780		nstart = start;
   781		tmp = vma->vm_start;
   782		for_each_vma_range(vmi, vma, end) {
   783			unsigned long mask_off_old_flags;
   784			unsigned long newflags;
   785			int new_vma_pkey;
   786	
   787			if (vma->vm_start != tmp) {
   788				error = -ENOMEM;
   789				break;
   790			}
   791	
   792			/* Does the application expect PROT_READ to imply PROT_EXEC */
   793			if (rier && (vma->vm_flags & VM_MAYEXEC))
   794				prot |= PROT_EXEC;
   795	
   796			/*
   797			 * Each mprotect() call explicitly passes r/w/x permissions.
   798			 * If a permission is not passed to mprotect(), it must be
   799			 * cleared from the VMA.
   800			 */
   801			mask_off_old_flags = VM_ACCESS_FLAGS | VM_FLAGS_CLEAR;
   802	
   803			new_vma_pkey = arch_override_mprotect_pkey(vma, prot, pkey);
   804			newflags = calc_vm_prot_bits(prot, new_vma_pkey);
   805			newflags |= (vma->vm_flags & ~mask_off_old_flags);
   806	
   807			/* newflags >> 4 shift VM_MAY% in place of VM_% */
   808			if ((newflags & ~(newflags >> 4)) & VM_ACCESS_FLAGS) {
   809				error = -EACCES;
   810				break;
   811			}
   812	
   813			if (map_deny_write_exec(vma, newflags)) {
   814				error = -EACCES;
   815				break;
   816			}
   817	
   818			/* Allow architectures to sanity-check the new flags */
   819			if (!arch_validate_flags(newflags)) {
   820				error = -EINVAL;
   821				break;
   822			}
   823	
   824			if ((vma->vm_flags & VM_WRITE) && !(newflags & VM_WRITE))
 > 825				newflags |= VM_WASWRITE;
   826	
   827			error = security_file_mprotect(vma, reqprot, prot);
   828			if (error)
   829				break;
   830	
   831			tmp = vma->vm_end;
   832			if (tmp > end)
   833				tmp = end;
   834	
   835			if (vma->vm_ops && vma->vm_ops->mprotect) {
   836				error = vma->vm_ops->mprotect(vma, nstart, tmp, newflags);
   837				if (error)
   838					break;
   839			}
   840	
   841			error = mprotect_fixup(&vmi, &tlb, vma, &prev, nstart, tmp, newflags);
   842			if (error)
   843				break;
   844	
   845			tmp = vma_iter_end(&vmi);
   846			nstart = tmp;
   847			prot = reqprot;
   848		}
   849		tlb_finish_mmu(&tlb);
   850	
   851		if (!error && tmp < end)
   852			error = -ENOMEM;
   853	
   854	out:
   855		mmap_write_unlock(current->mm);
   856		return error;
   857	}
   858	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

