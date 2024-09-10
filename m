Return-Path: <linux-kselftest+bounces-17662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6967097467F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFC91F2684C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB91AC431;
	Tue, 10 Sep 2024 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4F0F+1o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5A1AC8A7
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011876; cv=none; b=sHH5VI3YObp7eImM7XwxXQv12WbdCZpI4SOA80uUu0vvGubGvK/Fv2X5iNF52n0xVncU/Knn10hN6itTwfEcPDZpmPhsrIisH4ncSCvWh/Dhs9K8TT16KIRg9sDadgaxzLOJMWt1MxG9oHe7YZHcChcEjG9qERlvt+EeaWTdhbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011876; c=relaxed/simple;
	bh=+EbGtDkpQ2coil/ibgjMlt8jazuwNra5Uh4AebgyUb4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lJLS+Y6Tb9AyLUX+bbtboRcWYjkcR+9RAdonhqfUCvdEZu56lc2MtuKw46BuI5UTbyVKaq5/djfbfDeq0eD5RY6pESGSj/MiSU6tC/svtVBCN/4ngeiLnZi4YbHkiC5nkvg/0d4by28opy0AiIapNOM7uNipMY1SAqgNVA+oSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4F0F+1o; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035949cc4eso12727629276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011873; x=1726616673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ueaflVniPe+ANzZXO+tSUnwiFzFEa5y6xmq4I85N4RU=;
        b=y4F0F+1o5wxHTqMmDP83X1BtCLcAFUNLfiBmVZdhW5bd85s05RzF2zf3ZF2O0Hb5PV
         hlWLFrD90slOfvyPWhD/NyXzCPkIxKm96Ew+S3t8SihsuKI0zc8pRVX5hzRasO04VjTS
         KI+IduLr7TtJtenWjXe0HyaRlsAwvWUnL/qczgPJNmkiBvZthC+tXaWujZK6u2NLXhdR
         au6qXv0allS/mv/lnYA7pH0ZoM4NiRZ8GlnwGyQjli8tbnYoalaXaTpdZ7LEqqfhVJPw
         geQUOlM93xAuqC2jR0wgmBk9mwlUlatYHTiKD+r3SWX0KAwa2H5eG8xM/MsTxc7CRr2m
         Uh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011873; x=1726616673;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ueaflVniPe+ANzZXO+tSUnwiFzFEa5y6xmq4I85N4RU=;
        b=D4Rsz0rXLhNYN7heAkSdB0dTRVjN0E5S0be1XX+tdB4wpsK8ZEWalC+jZurVqEe5Ov
         BMeHLG7U/sswcPzwqLU07HQCBsXmPeWp4/GCWeuckRygTq0uqM6a9ton0TGDEgX4TYlC
         a5Wxkeod6EvD5NE1qNftlEOfsJBN5wgOXS3DIA51hnjxSTCxd9mv5EbbM36HHFkibUmV
         crmZOLa2HVakPAeprk4xezRrY7hSOqWQWgq4/IVsZz7en7dD6J26/Tv8dh2wh06rLEwN
         mczfMzL5TjIvQ1+ygJqTcOVXXuJGXPH30X8F/1gkKe36hHFoVIbcDSrkXGedq+FeApTk
         IBSA==
X-Forwarded-Encrypted: i=1; AJvYcCX37BjH4TN4Wf4Mr6FTzdbLTgLlqqU0ErqT4b8oG6ZT5n1Y5t4syP5DqpOabLs+Ytm269vK+0k7A8lzvkOMFxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQcSx+KkgC1tsnkEWUbw6RfyQYZJUxoBU2PWk2eMbpTTSmClK
	Bsb4IkZE9Nq3CbEKgd5YgOq14C2LnYPwSvMcN0TQqry97DrbFR2wsOjsyqkb4xyQOCnNrlEjuAW
	0NjyDIyo2Iv+m2MRz0amEfw==
X-Google-Smtp-Source: AGHT+IEJhPxC7lkuYeVyOxTdq1kGN0PDw8/GViWp8RN54dQACow5TVDqUv3NC1ekZ6EnQcbV78IKOfhQlFT7fEX0Hw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:680b:0:b0:e0b:958a:3344 with SMTP
 id 3f1490d57ef6-e1d34a3abb7mr41731276.10.1726011873598; Tue, 10 Sep 2024
 16:44:33 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:31 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <cover.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 00/39] 1G page support for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hello,

This patchset is our exploration of how to support 1G pages in guest_memfd, and
how the pages will be used in Confidential VMs.

The patchset covers:

+ How to get 1G pages
+ Allowing mmap() of guest_memfd to userspace so that both private and shared
  memory can use the same physical pages
+ Splitting and reconstructing pages to support conversions and mmap()
+ How the VM, userspace and guest_memfd interact to support conversions
+ Selftests to test all the above
    + Selftests also demonstrate the conversion flow between VM, userspace and
      guest_memfd.

Why 1G pages in guest memfd?

Bring guest_memfd to performance and memory savings parity with VMs that are
backed by HugeTLBfs.

+ Performance is improved with 1G pages by more TLB hits and faster page walks
  on TLB misses.
+ Memory savings from 1G pages comes from HugeTLB Vmemmap Optimization (HVO).

Options for 1G page support:

1. HugeTLB
2. Contiguous Memory Allocator (CMA)
3. Other suggestions are welcome!

Comparison between options:

1. HugeTLB
    + Refactor HugeTLB to separate allocator from the rest of HugeTLB
    + Pro: Graceful transition for VMs backed with HugeTLB to guest_memfd
        + Near term: Allows co-tenancy of HugeTLB and guest_memfd backed VMs
    + Pro: Can provide iterative steps toward new future allocator
        + Unexplored: Managing userspace-visible changes
            + e.g. HugeTLB's free_hugepages will decrease if HugeTLB is used,
              but not when future allocator is used
2. CMA
    + Port some HugeTLB features to be applied on CMA
    + Pro: Clean slate

What would refactoring HugeTLB involve?

(Some refactoring was done in this RFC, more can be done.)

1. Broadly involves separating the HugeTLB allocator from the rest of HugeTLB
    + Brings more modularity to HugeTLB
    + No functionality change intended
    + Likely step towards HugeTLB's integration into core-mm
2. guest_memfd will use just the allocator component of HugeTLB, not including
   the complex parts of HugeTLB like
    + Userspace reservations (resv_map)
    + Shared PMD mappings
    + Special page walkers

What features would need to be ported to CMA?

+ Improved allocation guarantees
    + Per NUMA node pool of huge pages
    + Subpools per guest_memfd
+ Memory savings
    + Something like HugeTLB Vmemmap Optimization
+ Configuration/reporting features
    + Configuration of number of pages available (and per NUMA node) at and
      after host boot
    + Reporting of memory usage/availability statistics at runtime

HugeTLB was picked as the source of 1G pages for this RFC because it allows a
graceful transition, and retains memory savings from HVO.

To illustrate this, if a host machine uses HugeTLBfs to back VMs, and a
confidential VM were to be scheduled on that host, some HugeTLBfs pages would
have to be given up and returned to CMA for guest_memfd pages to be rebuilt from
that memory. This requires memory to be reserved for HVO to be removed and
reapplied on the new guest_memfd memory. This not only slows down memory
allocation but also trims the benefits of HVO. Memory would have to be reserved
on the host to facilitate these transitions.

Improving how guest_memfd uses the allocator in a future revision of this RFC:

To provide an easier transition away from HugeTLB, guest_memfd's use of HugeTLB
should be limited to these allocator functions:

+ reserve(node, page_size, num_pages) => opaque handle
    + Used when a guest_memfd inode is created to reserve memory from backend
      allocator
+ allocate(handle, mempolicy, page_size) => folio
    + To allocate a folio from guest_memfd's reservation
+ split(handle, folio, target_page_size) => void
    + To take a huge folio, and split it to smaller folios, restore to filemap
+ reconstruct(handle, first_folio, nr_pages) => void
    + To take a folio, and reconstruct a huge folio out of nr_pages from the
      first_folio
+ free(handle, folio) => void
    + To return folio to guest_memfd's reservation
+ error(handle, folio) => void
    + To handle memory errors
+ unreserve(handle) => void
    + To return guest_memfd's reservation to allocator backend

Userspace should only provide a page size when creating a guest_memfd and should
not have to specify HugeTLB.

Overview of patches:

+ Patches 01-12
    + Many small changes to HugeTLB, mostly to separate HugeTLBfs concepts from
      HugeTLB, and to expose HugeTLB functions.
+ Patches 13-16
    + Letting guest_memfd use HugeTLB
    + Creation of each guest_memfd reserves pages from HugeTLB's global hstate
      and puts it into the guest_memfd inode's subpool
    + Each folio allocation takes a page from the guest_memfd inode's subpool
+ Patches 17-21
    + Selftests for new HugeTLB features in guest_memfd
+ Patches 22-24
    + More small changes on the HugeTLB side to expose functions needed by
      guest_memfd
+ Patch 25:
    + Uses the newly available functions from patches 22-24 to split HugeTLB
      pages. In this patch, HugeTLB folios are always split to 4K before any
      usage, private or shared.
+ Patches 26-28
    + Allow mmap() in guest_memfd and faulting in shared pages
+ Patch 29
    + Enables conversion between private/shared pages
+ Patch 30
    + Required to zero folios after conversions to avoid leaking initialized
      kernel memory
+ Patch 31-38
    + Add selftests to test mapping pages to userspace, guest/host memory
      sharing and update conversions tests
    + Patch 33 illustrates the conversion flow between VM/userspace/guest_memfd
+ Patch 39
    + Dynamically split and reconstruct HugeTLB pages instead of always
      splitting before use. All earlier selftests are expected to still pass.

TODOs:

+ Add logic to wait for safe_refcount [1]
+ Look into lazy splitting/reconstruction of pages
    + Currently, when the KVM_SET_MEMORY_ATTRIBUTES is invoked, not only is the
      mem_attr_array and faultability updated, the pages in the requested range
      are also split/reconstructed as necessary. We want to look into delaying
      splitting/reconstruction to fault time.
+ Solve race between folios being faulted in and being truncated
    + When running private_mem_conversions_test with more than 1 vCPU, a folio
      getting truncated may get faulted in by another process, causing elevated
      mapcounts when the folio is freed (VM_BUG_ON_FOLIO).
+ Add intermediate splits (1G should first split to 2M and not split directly to
  4K)
+ Use guest's lock instead of hugetlb_lock
+ Use multi-index xarray/replace xarray with some other data struct for
  faultability flag
+ Refactor HugeTLB better, present generic allocator interface

Please let us know your thoughts on:

+ HugeTLB as the choice of transitional allocator backend
+ Refactoring HugeTLB to provide generic allocator interface
+ Shared/private conversion flow
    + Requiring user to request kernel to unmap pages from userspace using
      madvise(MADV_DONTNEED)
    + Failing conversion on elevated mapcounts/pincounts/refcounts
+ Process of splitting/reconstructing page
+ Anything else!

[1] https://lore.kernel.org/all/20240829-guest-memfd-lib-v2-0-b9afc1ff3656@quicinc.com/T/

Ackerley Tng (37):
  mm: hugetlb: Simplify logic in dequeue_hugetlb_folio_vma()
  mm: hugetlb: Refactor vma_has_reserves() to should_use_hstate_resv()
  mm: hugetlb: Remove unnecessary check for avoid_reserve
  mm: mempolicy: Refactor out policy_node_nodemask()
  mm: hugetlb: Refactor alloc_buddy_hugetlb_folio_with_mpol() to
    interpret mempolicy instead of vma
  mm: hugetlb: Refactor dequeue_hugetlb_folio_vma() to use mpol
  mm: hugetlb: Refactor out hugetlb_alloc_folio
  mm: truncate: Expose preparation steps for truncate_inode_pages_final
  mm: hugetlb: Expose hugetlb_subpool_{get,put}_pages()
  mm: hugetlb: Add option to create new subpool without using surplus
  mm: hugetlb: Expose hugetlb_acct_memory()
  mm: hugetlb: Move and expose hugetlb_zero_partial_page()
  KVM: guest_memfd: Make guest mem use guest mem inodes instead of
    anonymous inodes
  KVM: guest_memfd: hugetlb: initialization and cleanup
  KVM: guest_memfd: hugetlb: allocate and truncate from hugetlb
  KVM: guest_memfd: Add page alignment check for hugetlb guest_memfd
  KVM: selftests: Add basic selftests for hugetlb-backed guest_memfd
  KVM: selftests: Support various types of backing sources for private
    memory
  KVM: selftests: Update test for various private memory backing source
    types
  KVM: selftests: Add private_mem_conversions_test.sh
  KVM: selftests: Test that guest_memfd usage is reported via hugetlb
  mm: hugetlb: Expose vmemmap optimization functions
  mm: hugetlb: Expose HugeTLB functions for promoting/demoting pages
  mm: hugetlb: Add functions to add/move/remove from hugetlb lists
  KVM: guest_memfd: Track faultability within a struct kvm_gmem_private
  KVM: guest_memfd: Allow mmapping guest_memfd files
  KVM: guest_memfd: Use vm_type to determine default faultability
  KVM: Handle conversions in the SET_MEMORY_ATTRIBUTES ioctl
  KVM: guest_memfd: Handle folio preparation for guest_memfd mmap
  KVM: selftests: Allow vm_set_memory_attributes to be used without
    asserting return value of 0
  KVM: selftests: Test using guest_memfd memory from userspace
  KVM: selftests: Test guest_memfd memory sharing between guest and host
  KVM: selftests: Add notes in private_mem_kvm_exits_test for mmap-able
    guest_memfd
  KVM: selftests: Test that pinned pages block KVM from setting memory
    attributes to PRIVATE
  KVM: selftests: Refactor vm_mem_add to be more flexible
  KVM: selftests: Add helper to perform madvise by memslots
  KVM: selftests: Update private_mem_conversions_test for mmap()able
    guest_memfd

Vishal Annapurve (2):
  KVM: guest_memfd: Split HugeTLB pages for guest_memfd use
  KVM: guest_memfd: Dynamically split/reconstruct HugeTLB page

 fs/hugetlbfs/inode.c                          |   35 +-
 include/linux/hugetlb.h                       |   54 +-
 include/linux/kvm_host.h                      |    1 +
 include/linux/mempolicy.h                     |    2 +
 include/linux/mm.h                            |    1 +
 include/uapi/linux/kvm.h                      |   26 +
 include/uapi/linux/magic.h                    |    1 +
 mm/hugetlb.c                                  |  346 ++--
 mm/hugetlb_vmemmap.h                          |   11 -
 mm/mempolicy.c                                |   36 +-
 mm/truncate.c                                 |   26 +-
 tools/include/linux/kernel.h                  |    4 +-
 tools/testing/selftests/kvm/Makefile          |    3 +
 .../kvm/guest_memfd_hugetlb_reporting_test.c  |  222 +++
 .../selftests/kvm/guest_memfd_pin_test.c      |  104 ++
 .../selftests/kvm/guest_memfd_sharing_test.c  |  160 ++
 .../testing/selftests/kvm/guest_memfd_test.c  |  238 ++-
 .../testing/selftests/kvm/include/kvm_util.h  |   45 +-
 .../testing/selftests/kvm/include/test_util.h |   18 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  443 +++--
 tools/testing/selftests/kvm/lib/test_util.c   |   99 ++
 .../kvm/x86_64/private_mem_conversions_test.c |  158 +-
 .../x86_64/private_mem_conversions_test.sh    |   91 +
 .../kvm/x86_64/private_mem_kvm_exits_test.c   |   11 +-
 virt/kvm/guest_memfd.c                        | 1563 ++++++++++++++++-
 virt/kvm/kvm_main.c                           |   17 +
 virt/kvm/kvm_mm.h                             |   16 +
 27 files changed, 3288 insertions(+), 443 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_hugetlb_reporting_test.c
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_pin_test.c
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_sharing_test.c
 create mode 100755 tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.sh

--
2.46.0.598.g6f2099f65c-goog

