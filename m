Return-Path: <linux-kselftest+bounces-46342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBB2C7DF78
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 11:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6FAB4E1E41
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ABB2C08C2;
	Sun, 23 Nov 2025 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miOLm7bo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6242820A4;
	Sun, 23 Nov 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763893637; cv=none; b=aMPCSXrLUCfk9OWUcyFYXtAQJ0A+aWSGMolSn9I/E0IXnquI/HhdfxIIjzNoal+LfYizGsaCeVxGsrqZybCNN25n0eFfzGvSSSU6RrnHcQPKRGScAcEWmpl9MAmokPmAZv2zRyglmriRm7ZIsxuwgCJ0XWeYcikIFmXPPSB27jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763893637; c=relaxed/simple;
	bh=uQ+XNRc47lHfiREiaIwuPCqXlDMz96Y+Ua7eszfUoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llBowd9+opYXemxdlDL/APQVe/D/qiSl0WrHmowqfF974OtCkoef5QonafR/Vkm/Fpeu56XXTqFBfvoyWmPV7LLv9huiOxPb3cZjScxizsmIcINz+A2PY43v6M/YsvTqQ7OqnBACGnAGiqpOmQ6yGKmWfMr/vmpTPmIdKs+0W5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miOLm7bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254B9C113D0;
	Sun, 23 Nov 2025 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763893636;
	bh=uQ+XNRc47lHfiREiaIwuPCqXlDMz96Y+Ua7eszfUoWw=;
	h=From:To:Cc:Subject:Date:From;
	b=miOLm7boejNLZkZWl7MecUiBUNqyViv6anj+8bxooagNb3kdikR5sNpE/yUgJ2OeH
	 LOxKOzOxo+XdaqrY81kTYt5phmRtUbIqvbTj8/ytq4XGAu/bwVOtY6iqyr34WINb42
	 rTtculAEvWMXO36PnaApcYiJF4kYrM+LiBbq/y/YHeh5RZ4wvWG4JhZmSPVvZTC/y3
	 JPtMO7WwXssH5azIRYZ+l7z7Nopi7xlVVWLRWXfA9gZU0zAAqq6BbEecaBNL0kJZK4
	 rjSc5qQhpyQkvTVGUuxCC8aRYwVcSOVyei0hy7xwXcU2ht25mTlFMsVaZ0tkQPhMIW
	 r8fJUHurTqBLg==
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
Subject: [PATCH 0/5] mm, kvm: add guest_memfd support for uffd minor faults
Date: Sun, 23 Nov 2025 12:27:02 +0200
Message-ID: <20251123102707.559422-1-rppt@kernel.org>
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
* Introduce VM_FAULF_UFFD_MINOR to avoid exporting handle_userfault()
* Simplify vma_can_mfill_atomic()
* Rename get_pagecache_folio() to get_shared_folio() and use inode
instead of vma as its argument

v1: https://lore.kernel.org/all/20251117114631.2029447-1-rppt@kernel.org

Mike Rapoport (Microsoft) (4):
  userfaultfd: move vma_can_userfault out of line
  userfaultfd, shmem: use a VMA callback to handle UFFDIO_CONTINUE
  mm: introduce VM_FAULT_UFFD_MINOR fault reason
  guest_memfd: add support for userfaultfd minor mode

Nikita Kalyazin (1):
  KVM: selftests: test userfaultfd minor for guest_memfd

 include/linux/mm.h                            |   9 ++
 include/linux/mm_types.h                      |   3 +
 include/linux/userfaultfd_k.h                 |  36 +-----
 mm/memory.c                                   |   2 +
 mm/shmem.c                                    |  21 +++-
 mm/userfaultfd.c                              |  80 +++++++++++---
 .../testing/selftests/kvm/guest_memfd_test.c  | 103 ++++++++++++++++++
 virt/kvm/guest_memfd.c                        |  29 +++++
 8 files changed, 232 insertions(+), 51 deletions(-)


base-commit: 6a23ae0a96a600d1d12557add110e0bb6e32730c
-- 
2.50.1


