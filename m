Return-Path: <linux-kselftest+bounces-20210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0609A533C
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 11:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A84E1C20A23
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1480603;
	Sun, 20 Oct 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecqblAWR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30E17BA9;
	Sun, 20 Oct 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416099; cv=none; b=ph45Fx6U+HzofsUfprkUsqk00eoswGunQGVFhu/DaJAHt7eQjCJfbUHs4yZ+Fj+6VZ7rNTPZF4cKbAuAVuKlDLMNgmWzBnddtW9kE6tl0cHby7W+7tyVp/9IEjAbKX6n4hLkkFXV85U8rm3bxpfJNvsBolj/UoNXe/U6AXtl1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416099; c=relaxed/simple;
	bh=5Ez5yxwcYXssvPQZU8ZzXuZN34JeHSKPfpOXJy0mTDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTf/FfQ7tUtEJBCuC+OSDLd1JCsNGA70uJq9KZLSi5gPDKb9kKG9/9NzRoEjzpZAOotvY8/TPns3g7zVN+p6omjZwWQKrH5QRE7DNXp1IB3bgrFLhiZFuss8PFA9bn1sLpbnCW64y8dswRP8lVxfwij+gOqyTs3OQYU4v7CLUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecqblAWR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729416097; x=1760952097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Ez5yxwcYXssvPQZU8ZzXuZN34JeHSKPfpOXJy0mTDw=;
  b=ecqblAWRsMJF44GWDH2OvLmarWfOtee8emFP+6LMLbsiPeUvC9YK6Df1
   eDfQOd70jSwKtzgUOE6WmqMI4fSS+5nmEfS63zRZluJqv0qc3o9TQ11BU
   +nfxWDCYZkWapThycS9WTOqfTolMJGcQCs6ROPCPcR5YanXAR7PbMOIPn
   xRNhLQvkwLQzYw0EaJvsvcK5ANVyviW5z/XsxnlIyxfWKM0G+72GpaLWi
   hrt6vwZdl6lLBnJETv7NBCFqLenDwAdG4+2itVElgGRJPVDkjNEI8g2+Z
   NXF9uaa9hRssJSI+GQ9qz+trOO8ibA+xywMcQqQunvSWvybcK2Vq7azb8
   w==;
X-CSE-ConnectionGUID: SA1oXYX7Rk6gjrwVO0iAUQ==
X-CSE-MsgGUID: 3cBgAWr5SiC2+uZdQF4eKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="39528695"
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="39528695"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 02:21:36 -0700
X-CSE-ConnectionGUID: DGH5La/ySNOwfpyxY8+Lqg==
X-CSE-MsgGUID: rk7Y5pOyQCaXLKX+BhfWCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="79183516"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Oct 2024 02:21:30 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2S7r-000Q99-2M;
	Sun, 20 Oct 2024 09:21:27 +0000
Date: Sun, 20 Oct 2024 17:20:39 +0800
From: kernel test robot <lkp@intel.com>
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	corbet@lwn.net, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Cc: oe-kbuild-all@lists.linux.dev, jeffxu@google.com, jorgelo@chromium.org,
	groeck@chromium.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	jannh@google.com, sroettger@google.com, pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org, willy@infradead.org,
	gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com,
	merimus@google.com, rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when
 sealed
Message-ID: <202410201611.Xd6J8QCm-lkp@intel.com>
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
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20241020/202410201611.Xd6J8QCm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201611.Xd6J8QCm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201611.Xd6J8QCm-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/mprotect.c: In function 'do_mprotect_pkey':
>> mm/mprotect.c:825:37: error: 'VM_WASWRITE' undeclared (first use in this function); did you mean 'VM_MAYWRITE'?
     825 |                         newflags |= VM_WASWRITE;
         |                                     ^~~~~~~~~~~
         |                                     VM_MAYWRITE
   mm/mprotect.c:825:37: note: each undeclared identifier is reported only once for each function it appears in


vim +825 mm/mprotect.c

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

