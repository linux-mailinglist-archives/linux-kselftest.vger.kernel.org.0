Return-Path: <linux-kselftest+bounces-17713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1120974AB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317F6B24EDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4213B58C;
	Wed, 11 Sep 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AN/ryQoc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75112C484
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037795; cv=none; b=Mu1OfJ5yLWSYdhDgus+dgJ30O6Mdz7BUU6d9s22t2o9k+4n7nA92MRVP+erVCi8Uju5+UGSTyWsTW1Vn8cBh43cnotMuiibNKgxhIRaSUtAY/UE50uF6s2r6YwW2r1TYWz1jHi0iu7WuKVpYIFKKScnx6BLYA3K7JqrAN1o0Rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037795; c=relaxed/simple;
	bh=S/codWSFiZMhnOnoWjGa1OpUf7W3ix2sgsp6ciOX+iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIHDgU9+Exu+fgbsE2UegOI8bxLXohi0WpJTrBIOfKCVjo8iPRqLgUQCHOpyRZITwQEUAIEnICl5/tf9wJICmf2JGpqv+TbT9BAuVFbSKwbRX+v6ia/Nn8O72J8siICHtDY2ggBlssULnvTDYuTOuUNSSiVR0C5t0cYezIamlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AN/ryQoc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so22384555e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726037791; x=1726642591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2W/6yqc36Yx5JYfTAvZPPQFKX/7iJh9OIgOV9O+ITC4=;
        b=AN/ryQocA8TWIsAJdE78w4wqqt1GNiHJ+sU9agzvk75wcwN0LGYP97E5LVzrkLlffU
         4C7P2xa5RzrjoXkE5BTlJufenXLic/qramLvdelhM10hn76KwbPHlWaJSVa+CjjO9O6l
         wP0miWnkFYks8hPTStA1MXRnVrBgsvVvZrSAiONlvihoW5P3X2PAHWofZVwVX579QCVV
         F1fnBXZAOqPpYjMsis2q/ntcY1Ihf2khkLQHyp0HBFmZw8tlsi2gniYfIk9NkT0wW6UF
         +jfQ/pz03SOrkAj6SuuIYA/7Hgfe9eg5Pt59T9CI7o0WGZYhL9kPEx4XHfYaOqB9R79F
         iZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726037791; x=1726642591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W/6yqc36Yx5JYfTAvZPPQFKX/7iJh9OIgOV9O+ITC4=;
        b=qFbl/8cCn1bfYcbeiHpC8JaUMYuXMO5nvApXDEzAUUUFpP3qvl+hjmUT7KAumsUfAL
         3CJeJcSUspWR3djpYXbOgxBhNxcpW6VukbdOl/eVOfUs+cAuEN8emnBJp8wVqdcgGLJd
         gwcJoP4p3r7AXP1SS/j01/FH3UHGJ9mQY4Oag0eDrj7sN2DdXlHB0cdRgvYuq3rLdEZ2
         Vl6WBAQZZTzGcwKf5xCAOYXFrotPR/kyrYh+3UkDEcNfzX8/27JM3EDS/VmanREC86XT
         6kSNHrxjkILy8RP596SZT6KhxSJMRU0dW3b4G77cTEKnxI5lJN83IctGz71bVHq03xtY
         jnNg==
X-Forwarded-Encrypted: i=1; AJvYcCXGXIBb0uIg7iNK5FVsbSR22QfNI/ADZUxMO5P/bb//h5ujGmjZNMqqACjqcmbNP1hDmEX5yS71JmZG+YfDIgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+piWvNoFPVU+tbqymIk6/N1FJysq03y1ndM+YJj018Y3vCVM
	ORm0fi0b3tWzPxTaiTJKbQdkUdNXcymYFJ/EsJLs8ZZ6Rc1alNdKILyl00hOu2s=
X-Google-Smtp-Source: AGHT+IGV6renJvHaBCc1TWVIVsopoWasW9VIRFmjUsSDpFXThDJPoqGDaKj88scjdQNxgZQvl7GeCg==
X-Received: by 2002:adf:e3c9:0:b0:368:74c0:6721 with SMTP id ffacd0b85a97d-37889674a48mr9587261f8f.38.1726037790728;
        Tue, 10 Sep 2024 23:56:30 -0700 (PDT)
Received: from localhost (109-81-83-158.rct.o2.cz. [109.81.83.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a68sm132660525e9.8.2024.09.10.23.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 23:56:30 -0700 (PDT)
Date: Wed, 11 Sep 2024 08:56:29 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com,
	rientjes@google.com, fvdl@google.com, jthoughton@google.com,
	seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com,
	fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com,
	muchun.song@linux.dev, mike.kravetz@oracle.com,
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com,
	pgonda@google.com, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-fsdevel@kvack.org, Oscar Salvador <OSalvador@suse.com>
Subject: Re: [RFC PATCH 00/39] 1G page support for guest_memfd
Message-ID: <ZuE_Haaz8M6ENprE@tiehlicka>
References: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>

Cc Oscar for awareness

On Tue 10-09-24 23:43:31, Ackerley Tng wrote:
> Hello,
> 
> This patchset is our exploration of how to support 1G pages in guest_memfd, and
> how the pages will be used in Confidential VMs.
> 
> The patchset covers:
> 
> + How to get 1G pages
> + Allowing mmap() of guest_memfd to userspace so that both private and shared
>   memory can use the same physical pages
> + Splitting and reconstructing pages to support conversions and mmap()
> + How the VM, userspace and guest_memfd interact to support conversions
> + Selftests to test all the above
>     + Selftests also demonstrate the conversion flow between VM, userspace and
>       guest_memfd.
> 
> Why 1G pages in guest memfd?
> 
> Bring guest_memfd to performance and memory savings parity with VMs that are
> backed by HugeTLBfs.
> 
> + Performance is improved with 1G pages by more TLB hits and faster page walks
>   on TLB misses.
> + Memory savings from 1G pages comes from HugeTLB Vmemmap Optimization (HVO).
> 
> Options for 1G page support:
> 
> 1. HugeTLB
> 2. Contiguous Memory Allocator (CMA)
> 3. Other suggestions are welcome!
> 
> Comparison between options:
> 
> 1. HugeTLB
>     + Refactor HugeTLB to separate allocator from the rest of HugeTLB
>     + Pro: Graceful transition for VMs backed with HugeTLB to guest_memfd
>         + Near term: Allows co-tenancy of HugeTLB and guest_memfd backed VMs
>     + Pro: Can provide iterative steps toward new future allocator
>         + Unexplored: Managing userspace-visible changes
>             + e.g. HugeTLB's free_hugepages will decrease if HugeTLB is used,
>               but not when future allocator is used
> 2. CMA
>     + Port some HugeTLB features to be applied on CMA
>     + Pro: Clean slate
> 
> What would refactoring HugeTLB involve?
> 
> (Some refactoring was done in this RFC, more can be done.)
> 
> 1. Broadly involves separating the HugeTLB allocator from the rest of HugeTLB
>     + Brings more modularity to HugeTLB
>     + No functionality change intended
>     + Likely step towards HugeTLB's integration into core-mm
> 2. guest_memfd will use just the allocator component of HugeTLB, not including
>    the complex parts of HugeTLB like
>     + Userspace reservations (resv_map)
>     + Shared PMD mappings
>     + Special page walkers
> 
> What features would need to be ported to CMA?
> 
> + Improved allocation guarantees
>     + Per NUMA node pool of huge pages
>     + Subpools per guest_memfd
> + Memory savings
>     + Something like HugeTLB Vmemmap Optimization
> + Configuration/reporting features
>     + Configuration of number of pages available (and per NUMA node) at and
>       after host boot
>     + Reporting of memory usage/availability statistics at runtime
> 
> HugeTLB was picked as the source of 1G pages for this RFC because it allows a
> graceful transition, and retains memory savings from HVO.
> 
> To illustrate this, if a host machine uses HugeTLBfs to back VMs, and a
> confidential VM were to be scheduled on that host, some HugeTLBfs pages would
> have to be given up and returned to CMA for guest_memfd pages to be rebuilt from
> that memory. This requires memory to be reserved for HVO to be removed and
> reapplied on the new guest_memfd memory. This not only slows down memory
> allocation but also trims the benefits of HVO. Memory would have to be reserved
> on the host to facilitate these transitions.
> 
> Improving how guest_memfd uses the allocator in a future revision of this RFC:
> 
> To provide an easier transition away from HugeTLB, guest_memfd's use of HugeTLB
> should be limited to these allocator functions:
> 
> + reserve(node, page_size, num_pages) => opaque handle
>     + Used when a guest_memfd inode is created to reserve memory from backend
>       allocator
> + allocate(handle, mempolicy, page_size) => folio
>     + To allocate a folio from guest_memfd's reservation
> + split(handle, folio, target_page_size) => void
>     + To take a huge folio, and split it to smaller folios, restore to filemap
> + reconstruct(handle, first_folio, nr_pages) => void
>     + To take a folio, and reconstruct a huge folio out of nr_pages from the
>       first_folio
> + free(handle, folio) => void
>     + To return folio to guest_memfd's reservation
> + error(handle, folio) => void
>     + To handle memory errors
> + unreserve(handle) => void
>     + To return guest_memfd's reservation to allocator backend
> 
> Userspace should only provide a page size when creating a guest_memfd and should
> not have to specify HugeTLB.
> 
> Overview of patches:
> 
> + Patches 01-12
>     + Many small changes to HugeTLB, mostly to separate HugeTLBfs concepts from
>       HugeTLB, and to expose HugeTLB functions.
> + Patches 13-16
>     + Letting guest_memfd use HugeTLB
>     + Creation of each guest_memfd reserves pages from HugeTLB's global hstate
>       and puts it into the guest_memfd inode's subpool
>     + Each folio allocation takes a page from the guest_memfd inode's subpool
> + Patches 17-21
>     + Selftests for new HugeTLB features in guest_memfd
> + Patches 22-24
>     + More small changes on the HugeTLB side to expose functions needed by
>       guest_memfd
> + Patch 25:
>     + Uses the newly available functions from patches 22-24 to split HugeTLB
>       pages. In this patch, HugeTLB folios are always split to 4K before any
>       usage, private or shared.
> + Patches 26-28
>     + Allow mmap() in guest_memfd and faulting in shared pages
> + Patch 29
>     + Enables conversion between private/shared pages
> + Patch 30
>     + Required to zero folios after conversions to avoid leaking initialized
>       kernel memory
> + Patch 31-38
>     + Add selftests to test mapping pages to userspace, guest/host memory
>       sharing and update conversions tests
>     + Patch 33 illustrates the conversion flow between VM/userspace/guest_memfd
> + Patch 39
>     + Dynamically split and reconstruct HugeTLB pages instead of always
>       splitting before use. All earlier selftests are expected to still pass.
> 
> TODOs:
> 
> + Add logic to wait for safe_refcount [1]
> + Look into lazy splitting/reconstruction of pages
>     + Currently, when the KVM_SET_MEMORY_ATTRIBUTES is invoked, not only is the
>       mem_attr_array and faultability updated, the pages in the requested range
>       are also split/reconstructed as necessary. We want to look into delaying
>       splitting/reconstruction to fault time.
> + Solve race between folios being faulted in and being truncated
>     + When running private_mem_conversions_test with more than 1 vCPU, a folio
>       getting truncated may get faulted in by another process, causing elevated
>       mapcounts when the folio is freed (VM_BUG_ON_FOLIO).
> + Add intermediate splits (1G should first split to 2M and not split directly to
>   4K)
> + Use guest's lock instead of hugetlb_lock
> + Use multi-index xarray/replace xarray with some other data struct for
>   faultability flag
> + Refactor HugeTLB better, present generic allocator interface
> 
> Please let us know your thoughts on:
> 
> + HugeTLB as the choice of transitional allocator backend
> + Refactoring HugeTLB to provide generic allocator interface
> + Shared/private conversion flow
>     + Requiring user to request kernel to unmap pages from userspace using
>       madvise(MADV_DONTNEED)
>     + Failing conversion on elevated mapcounts/pincounts/refcounts
> + Process of splitting/reconstructing page
> + Anything else!
> 
> [1] https://lore.kernel.org/all/20240829-guest-memfd-lib-v2-0-b9afc1ff3656@quicinc.com/T/
> 
> Ackerley Tng (37):
>   mm: hugetlb: Simplify logic in dequeue_hugetlb_folio_vma()
>   mm: hugetlb: Refactor vma_has_reserves() to should_use_hstate_resv()
>   mm: hugetlb: Remove unnecessary check for avoid_reserve
>   mm: mempolicy: Refactor out policy_node_nodemask()
>   mm: hugetlb: Refactor alloc_buddy_hugetlb_folio_with_mpol() to
>     interpret mempolicy instead of vma
>   mm: hugetlb: Refactor dequeue_hugetlb_folio_vma() to use mpol
>   mm: hugetlb: Refactor out hugetlb_alloc_folio
>   mm: truncate: Expose preparation steps for truncate_inode_pages_final
>   mm: hugetlb: Expose hugetlb_subpool_{get,put}_pages()
>   mm: hugetlb: Add option to create new subpool without using surplus
>   mm: hugetlb: Expose hugetlb_acct_memory()
>   mm: hugetlb: Move and expose hugetlb_zero_partial_page()
>   KVM: guest_memfd: Make guest mem use guest mem inodes instead of
>     anonymous inodes
>   KVM: guest_memfd: hugetlb: initialization and cleanup
>   KVM: guest_memfd: hugetlb: allocate and truncate from hugetlb
>   KVM: guest_memfd: Add page alignment check for hugetlb guest_memfd
>   KVM: selftests: Add basic selftests for hugetlb-backed guest_memfd
>   KVM: selftests: Support various types of backing sources for private
>     memory
>   KVM: selftests: Update test for various private memory backing source
>     types
>   KVM: selftests: Add private_mem_conversions_test.sh
>   KVM: selftests: Test that guest_memfd usage is reported via hugetlb
>   mm: hugetlb: Expose vmemmap optimization functions
>   mm: hugetlb: Expose HugeTLB functions for promoting/demoting pages
>   mm: hugetlb: Add functions to add/move/remove from hugetlb lists
>   KVM: guest_memfd: Track faultability within a struct kvm_gmem_private
>   KVM: guest_memfd: Allow mmapping guest_memfd files
>   KVM: guest_memfd: Use vm_type to determine default faultability
>   KVM: Handle conversions in the SET_MEMORY_ATTRIBUTES ioctl
>   KVM: guest_memfd: Handle folio preparation for guest_memfd mmap
>   KVM: selftests: Allow vm_set_memory_attributes to be used without
>     asserting return value of 0
>   KVM: selftests: Test using guest_memfd memory from userspace
>   KVM: selftests: Test guest_memfd memory sharing between guest and host
>   KVM: selftests: Add notes in private_mem_kvm_exits_test for mmap-able
>     guest_memfd
>   KVM: selftests: Test that pinned pages block KVM from setting memory
>     attributes to PRIVATE
>   KVM: selftests: Refactor vm_mem_add to be more flexible
>   KVM: selftests: Add helper to perform madvise by memslots
>   KVM: selftests: Update private_mem_conversions_test for mmap()able
>     guest_memfd
> 
> Vishal Annapurve (2):
>   KVM: guest_memfd: Split HugeTLB pages for guest_memfd use
>   KVM: guest_memfd: Dynamically split/reconstruct HugeTLB page
> 
>  fs/hugetlbfs/inode.c                          |   35 +-
>  include/linux/hugetlb.h                       |   54 +-
>  include/linux/kvm_host.h                      |    1 +
>  include/linux/mempolicy.h                     |    2 +
>  include/linux/mm.h                            |    1 +
>  include/uapi/linux/kvm.h                      |   26 +
>  include/uapi/linux/magic.h                    |    1 +
>  mm/hugetlb.c                                  |  346 ++--
>  mm/hugetlb_vmemmap.h                          |   11 -
>  mm/mempolicy.c                                |   36 +-
>  mm/truncate.c                                 |   26 +-
>  tools/include/linux/kernel.h                  |    4 +-
>  tools/testing/selftests/kvm/Makefile          |    3 +
>  .../kvm/guest_memfd_hugetlb_reporting_test.c  |  222 +++
>  .../selftests/kvm/guest_memfd_pin_test.c      |  104 ++
>  .../selftests/kvm/guest_memfd_sharing_test.c  |  160 ++
>  .../testing/selftests/kvm/guest_memfd_test.c  |  238 ++-
>  .../testing/selftests/kvm/include/kvm_util.h  |   45 +-
>  .../testing/selftests/kvm/include/test_util.h |   18 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  443 +++--
>  tools/testing/selftests/kvm/lib/test_util.c   |   99 ++
>  .../kvm/x86_64/private_mem_conversions_test.c |  158 +-
>  .../x86_64/private_mem_conversions_test.sh    |   91 +
>  .../kvm/x86_64/private_mem_kvm_exits_test.c   |   11 +-
>  virt/kvm/guest_memfd.c                        | 1563 ++++++++++++++++-
>  virt/kvm/kvm_main.c                           |   17 +
>  virt/kvm/kvm_mm.h                             |   16 +
>  27 files changed, 3288 insertions(+), 443 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c
>  create mode 100644 tools/testing/selftests/kvm/guest_memfd_pin_test.c
>  create mode 100644 tools/testing/selftests/kvm/guest_memfd_sharing_test.c
>  create mode 100755 tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.sh
> 
> --
> 2.46.0.598.g6f2099f65c-goog

-- 
Michal Hocko
SUSE Labs

