Return-Path: <linux-kselftest+bounces-46754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7F7C94ED6
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 12:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24E2034409F
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 11:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C8261B9B;
	Sun, 30 Nov 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUtziVFw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A940221577;
	Sun, 30 Nov 2025 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764501502; cv=none; b=qb1DlisCfWIamMtvdcWn88MvU2d0n5bp4nFfTa/6+/4k3tc4xoKkahW1+/Uq0E1tKB4TGJ3eEHiU3lRyv5S+8/nHzeJlSD6AtnP9rWPAB7PaydkocoVK0Vwk99VkqTEm5weRvwaitNBSQu0BwbDYdL1SxPyBGxBwPd6hQ17IegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764501502; c=relaxed/simple;
	bh=QWyCUWNr5EiAGbEinbC1SqyvrF+pTj5s8nlr0+kSaV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzCYaf4ASxhGtVcwktikTDDGAEOUY5Toal+1qmbmJDf8cNAySTgipffrzBvWPFlwCj33Q3ZmpQvpPDieJKUPcKDhrSm3dBIx0VhlrgUf6AtmrUgBnEruXKR2pyWsZEumhuImafoqD9U7ldj9DvKcIbVmjhzl8TcDZ33IvdLh5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUtziVFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E7C4CEF8;
	Sun, 30 Nov 2025 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764501500;
	bh=QWyCUWNr5EiAGbEinbC1SqyvrF+pTj5s8nlr0+kSaV4=;
	h=From:To:Cc:Subject:Date:From;
	b=XUtziVFwxT+NlKvaS6WSYT+hiz0mrSRU2i7WVNjkPJridMQi1gJVaxfwESV5hKMLG
	 BN3/0ZxZ/2DXLu6KtyIAMR3OGP+BuHSB7mPzKRRbzKyPqJR8YmW7n/weFmExIqYmtd
	 7S3JsaPSzIUgMK9FlfeSl9MJQo32lLw65KrX4tiLtUyULE/RclDDkSu7WAu6Tv55J3
	 gf46siqJ5aWDVA7l8SrR6snvp0GwbHKUcRBMPamwN8p8iGNLcKkG/4XQ1p0ZejStcH
	 jf9uLE+kQcOwTjd9m8m1xzWcw4fqekafIhmzyolIu/YVxYX02l2rPQaNJa9U1vNIoc
	 pL0mfDDnUxd0A==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/5] mm, kvm: add guest_memfd support for uffd minor faults
Date: Sun, 30 Nov 2025 13:18:07 +0200
Message-ID: <20251130111812.699259-1-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These patches allow guest_memfd to notify userspace about minor page
faults using userfaultfd and let userspace to resolve these page faults
using UFFDIO_CONTINUE.

To allow UFFDIO_CONTINUE outside of the core mm I added a
get_folio_noalloc() callback to vm_ops that allows an address space
backing a VMA to return a folio that exists in it's page cache (patch 2)

In order for guest_memfd to notify userspace about page faults, there is a
new VM_FAULT_UFFD_MINOR that a ->fault() handler can return to inform the
page fault handler that it needs to call handle_userfault() to complete the
fault (patch 3).
 
Patch 4 plumbs these new goodies into guest_memfd.

This series is the minimal change I've been able to come up with to allow
integration of guest_memfd with uffd and while refactoring uffd and making
mfill_atomic() flow more linear would have been a nice improvement, it's
way out of the scope of enabling uffd with guest_memfd.

v3 changes:
* rename ->get_folio() to ->get_folio_noalloc()
* fix build errors reported by kbuild
* pull handling of UFFD_MINOR out of hotpath in __do_fault()
* update guest_memfs changes so its ->fault() and ->get_folio_noalloc()
  follow the same semantics as shmem and hugetlb.
* s/MISSING/MINOR/g in changelogs
* added review tags

v2: https://lore.kernel.org/all/20251125183840.2368510-1-rppt@kernel.org
* rename ->get_shared_folio() to ->get_folio()
* hardwire VM_FAULF_UFFD_MINOR to 0 when CONFIG_USERFAULTFD=n

v1: https://patch.msgid.link/20251123102707.559422-1-rppt@kernel.org
* Introduce VM_FAULF_UFFD_MINOR to avoid exporting handle_userfault()
* Simplify vma_can_mfill_atomic()
* Rename get_pagecache_folio() to get_shared_folio() and use inode
  instead of vma as its argument

rfc: https://patch.msgid.link/20251117114631.2029447-1-rppt@kernel.org

Mike Rapoport (Microsoft) (4):
  userfaultfd: move vma_can_userfault out of line
  userfaultfd, shmem: use a VMA callback to handle UFFDIO_CONTINUE
  mm: introduce VM_FAULT_UFFD_MINOR fault reason
  guest_memfd: add support for userfaultfd minor mode

Nikita Kalyazin (1):
  KVM: selftests: test userfaultfd minor for guest_memfd

 include/linux/mm.h                            |  9 ++
 include/linux/mm_types.h                      | 10 +-
 include/linux/userfaultfd_k.h                 | 36 +------
 mm/memory.c                                   |  5 +-
 mm/shmem.c                                    | 20 +++-
 mm/userfaultfd.c                              | 80 ++++++++++++---
 .../testing/selftests/kvm/guest_memfd_test.c  | 97 +++++++++++++++++++
 virt/kvm/guest_memfd.c                        | 33 ++++++-
 8 files changed, 236 insertions(+), 54 deletions(-)


base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
-- 
2.51.0


