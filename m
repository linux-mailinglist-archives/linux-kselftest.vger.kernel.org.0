Return-Path: <linux-kselftest+bounces-46458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47270C86AAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 19:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD37E3B018E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDBA3321AA;
	Tue, 25 Nov 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFbfUd4W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED442D97A4;
	Tue, 25 Nov 2025 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095930; cv=none; b=MnScnTAW96rXkXQnUhRztuNFT9ZEHUKxPl/CfzWAypOmxK5Uzh9ugU46PN/H7f+RFb3uTiwUND8GgXVI3t0+GmRkuFuhDG5mGJUCxiu5ut79ikRKLwcfBtY5mKreYq2/hZCpPOCspcSPERMnVPzGW+UX3rkHy3ZMtTvqaESzSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095930; c=relaxed/simple;
	bh=rWudt7B1tB5QYi97/yII2g+5R+2VjlqdXJtZwSgAGQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eq8GyRtoW73gKNyJz4NjlRI/6DzB5JgjYZI66ivbTqMPXtvDa+XoVD7oCwKHd39y3DPR86vRtZICN+FQbS8fIrnFPrp4yu+DHXE4LEJF2d/ZX1NboTFLppWqjsZS8b6D4B2I9zzum9lHWI2cudZ0b25IJnTH4uoMNOMF9qHPWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFbfUd4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75691C4CEF1;
	Tue, 25 Nov 2025 18:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764095929;
	bh=rWudt7B1tB5QYi97/yII2g+5R+2VjlqdXJtZwSgAGQc=;
	h=From:To:Cc:Subject:Date:From;
	b=eFbfUd4W8t5SYla89AonVE6qfu9YF5+7CRm35LEhJB4Ikan/rfMCWcR7mhNLJeBDN
	 0C/ul7ZztYy+gyI2m2WGHvgGtWSUlxyGEXnR11maVQjbyVWPK63NuqZ/qCel8GTR3L
	 lQsCIRYMVVDYF37ETz7+Znh4pQq/oNO4n8xcHeF4h17fvJk+DWbeO4x2cr/YeFzjIz
	 JJn/f+MbzgDHOPJ+4PLtMm/c0sCSfW8dCXiKT83+1T3jX7FF0RHN2aoOxz3/LSAmCY
	 eAd82I2/jODtfeYzxfIqf6qd8rINpJuRO9UZPXKjG7MQomeUyiZMZIWMxvNRp27/fX
	 nEIbnvbJ7TE6w==
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
Subject: [PATCH v2 0/5] mm, kvm: add guest_memfd support for uffd minor faults
Date: Tue, 25 Nov 2025 20:38:35 +0200
Message-ID: <20251125183840.2368510-1-rppt@kernel.org>
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

To allow UFFDIO_CONTINUE outside of the core mm I added a get_shmem_folio()
callback to vm_ops that allows an address space backing a VMA to return a
folio that exists in it's page cache (patch 2)

In order for guest_memfd to notify userspace about page faults, there is a
new VM_FAULT_UFFD_MINOR that a ->fault() handler can return to inform the
page fault handler that it needs to call handle_userfault() to complete the
fault (patch 3).
 
Patch 4 plumbs these new goodies into guest_memfd.

This series is the minimal change I've been able to come up with to allow
integration of guest_memfd with uffd and while refactoring uffd and making
mfill_atomic() flow more linear would have been a nice improvement, it's
way out of the scope of enabling uffd with guest_memfd.

v2 changes:
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

 include/linux/mm.h                            |   9 ++
 include/linux/mm_types.h                      |  10 +-
 include/linux/userfaultfd_k.h                 |  36 +-----
 mm/memory.c                                   |   2 +
 mm/shmem.c                                    |  20 +++-
 mm/userfaultfd.c                              |  80 +++++++++++---
 .../testing/selftests/kvm/guest_memfd_test.c  | 103 ++++++++++++++++++
 virt/kvm/guest_memfd.c                        |  28 +++++
 8 files changed, 236 insertions(+), 52 deletions(-)


base-commit: 6a23ae0a96a600d1d12557add110e0bb6e32730c
-- 
2.50.1


