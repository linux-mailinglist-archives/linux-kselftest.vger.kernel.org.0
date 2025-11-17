Return-Path: <linux-kselftest+bounces-45734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5593C63E5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 12:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 16F6428A2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC232B994;
	Mon, 17 Nov 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcATjcN+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D032939C;
	Mon, 17 Nov 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763380000; cv=none; b=omtqq5c3vQYbBfsOHjTxeTo4hDqB2XCXZ4ucoJAR8NkLVsuAg0MYDNb7Nxy9WbhL1RzSa2gwtI2yb1/pnFNq1iZ/tRWyRT4XHOHHq0RgZAHMTi5t8R9HIRFAwguA3vnt5/tBr1WzNXTZyTgr7ha6B+rDZcAxkEfJCgauS6Pc9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763380000; c=relaxed/simple;
	bh=OK5ygqxzdiotqq5cLz9n/2U+IWjx65elS/OUqG7ov5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCMrR3ZIYusV5iDWjCgZEVDrls1j/DZxcsSaqeO2wDCt04ISfiamXA25coibtOnliU/M3XjPeGMbxmoyR2vYAZo8hIWSASaWwqez4PgNLOrR381CC76W9Gtl0kqub3k92PaoyJb60lySL9RAW23bI8zCeplvAo04vfBxD1tyklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcATjcN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA51C4CEF5;
	Mon, 17 Nov 2025 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763380000;
	bh=OK5ygqxzdiotqq5cLz9n/2U+IWjx65elS/OUqG7ov5g=;
	h=From:To:Cc:Subject:Date:From;
	b=rcATjcN+iuAISKl4OnTLnlAd5/bHbRBxnHEgJhCvLwjUEWn9lSdRTL8vTVIy5Q+77
	 4b90DdLwSGv5KWZ3um2LjzQo8SuRQ8x0bL0j44Rc+wadMo7fT5q3niEw6gjlaFD5wl
	 fAlbtcFN3Sk6jzrfsRbm6TH4WUAP0FAosPJgb1zn6jaeoQbsgffZIOIDSarPmT/8Pu
	 FWlR/ARZaxrvBLhHCBbkco9pw+oD3v74RG1KOqLtmAjOT2e6Hwcb9KoBn+TcScCHid
	 wDeaBHn7AueWPh8+zTkJZ+daPjt/kJXdkW1Cx1V+wvPf6t+r2+BKVnE/VQY4i2Nzfx
	 O+U3Hb2SFkIoA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
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
Subject: [RFC PATCH 0/4] mm, kvm: add guest_memfd support for uffd minor faults
Date: Mon, 17 Nov 2025 13:46:27 +0200
Message-ID: <20251117114631.2029447-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
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
get_pagecache_folio() callback to vm_ops that allows an address space
backing a VMA to return a folio that exists in it's page cache (patch 2)

In order for guest_memfd to notify userspace about page faults, it has to
call handle_userfault() and since guest_memfd may be a part of kvm module,
handle_userfault() is exported for kvm module (patch 3).

Note that patch 3 changelog does not provide motivation for enabling uffd
in guest_memfd, mainly because I can't say I understand why is that
required :)
Would be great to hear from KVM folks about it.

This series is the minimal change I've been able to come up with to allow
integration of guest_memfd with uffd and while refactoring uffd and making
mfill_atomic() flow more linear would have been a nice improvement, it's
way out of the scope of enabling uffd with guest_memfd.

Mike Rapoport (Microsoft) (3):
  userfaultfd: move vma_can_userfault out of line
  userfaultfd, shmem: use a VMA callback to handle UFFDIO_CONTINUE
  userfaultfd, guest_memfd: support userfault minor mode in guest_memfd

Nikita Kalyazin (1):
  KVM: selftests: test userfaultfd minor for guest_memfd

 fs/userfaultfd.c                              |   4 +-
 include/linux/mm.h                            |   9 ++
 include/linux/userfaultfd_k.h                 |  36 +-----
 include/uapi/linux/userfaultfd.h              |   8 +-
 mm/shmem.c                                    |  20 ++++
 mm/userfaultfd.c                              |  88 ++++++++++++---
 .../testing/selftests/kvm/guest_memfd_test.c  | 103 ++++++++++++++++++
 virt/kvm/guest_memfd.c                        |  30 +++++
 8 files changed, 245 insertions(+), 53 deletions(-)


base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
-- 
2.50.1


