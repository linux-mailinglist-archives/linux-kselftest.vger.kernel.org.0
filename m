Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13354789ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhLQLcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:32:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhLQLcK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ojr8pILBieJPmYrEJ8OpH4OqC9kBZPEcUzsnw4SNZEQ=;
        b=TRpQzDCflbtBwOsJLSqEgPQEz+PhjZlGfXUFYLKs9yhr/Cct7U1o5R/cNhjVdCjtWR5qbP
        7iKPMTYH4qKb91Cl6l+4EFc20XUPgmMiyt1aPyBbuaHKR76EulB6M62QBX6CM8GtdEtvW9
        7mmCYGz/nZJxVuxxgnAO2ggZs/iC5Ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-fJjbPIw_Nougc3pPp5Um4w-1; Fri, 17 Dec 2021 06:32:06 -0500
X-MC-Unique: fJjbPIw_Nougc3pPp5Um4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4713881CCB5;
        Fri, 17 Dec 2021 11:32:02 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F307792FA7;
        Fri, 17 Dec 2021 11:30:50 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v1 00/11] mm: COW fixes part 1: fix the COW security issue for THP and hugetlb
Date:   Fri, 17 Dec 2021 12:30:38 +0100
Message-Id: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi everybody,

as discussed in the linux-mm alignment session on Wednesday, this is part 1
of the COW fixes: fix the COW security issue using GUP-triggered
unsharing of shared anonymous pages (ordinary, THP, hugetlb). In the
meeting slides, this approach was referred to as "Copy On Read". If anybody
wants to have access to the slides, please feel free to reach out.


The patches are based on v5.16-rc5 and available at:
  https://github.com/davidhildenbrand/linux/pull/new/unshare_v1


It is currently again possible for a child process to observe modifications
of anonymous pages performed by the parent process after fork() in some
cases, which is not only a violation of the POSIX semantics of MAP_PRIVATE,
but more importantly a real security issue.

This issue, including other related COW issues, has been summarized at [1]:
"
  1. Observing Memory Modifications of Private Pages From A Child Process
  
  Long story short: process-private memory might not be as private as you
  think once you fork(): successive modifications of private memory
  regions in the parent process can still be observed by the child
  process, for example, by smart use of vmsplice()+munmap().
  
  The core problem is that pinning pages readable in a child process, such
  as done via the vmsplice system call, can result in a child process
  observing memory modifications done in the parent process the child is
  not supposed to observe. [1] contains an excellent summary and [2]
  contains further details. This issue was assigned CVE-2020-29374 [9].
  
  For this to trigger, it's required to use a fork() without subsequent
  exec(), for example, as used under Android zygote. Without further
  details about an application that forks less-privileged child processes,
  one cannot really say what's actually affected and what's not -- see the
  details section the end of this mail for a short sshd/openssh analysis.
  
  While commit 17839856fd58 ("gup: document and work around "COW can break
  either way" issue") fixed this issue and resulted in other problems
  (e.g., ptrace on pmem), commit 09854ba94c6a ("mm: do_wp_page()
  simplification") re-introduced part of the problem unfortunately.
  
  The original reproducer can be modified quite easily to use THP [3] and
  make the issue appear again on upstream kernels. I modified it to use
  hugetlb [4] and it triggers as well. The problem is certainly less
  severe with hugetlb than with THP; it merely highlights that we still
  have plenty of open holes we should be closing/fixing.
  
  Regarding vmsplice(), the only known workaround is to disallow the
  vmsplice() system call ... or disable THP and hugetlb. But who knows
  what else is affected (RDMA? O_DIRECT?) to achieve the same goal -- in
  the end, it's a more generic issue.
"

This security issue was first reported by Jann Horn on 27 May 2020 and it
currently affects anonymous THP and hugetlb again. The "security issue"
part for hugetlb might be less important than for THP. However, with this
approach it's just easy to get the MAP_PRIVATE semantics of any anonymous
pages in that regard and avoid any such information leaks without much
added complexity.

Ordinary anonymous pages are currently not affected, because the COW logic
was changed in commit 09854ba94c6a ("mm: do_wp_page() simplification")
for them to COW on "page_count() != 1" instead of "mapcount > 1", which
unfortunately results in other COW issues, some of them documented in [1]
as well.

To fix this COW issue once and for all, introduce GUP-triggered unsharing
that can be conditionally triggered via FAULT_FLAG_UNSHARE. In contrast to
traditional COW, unsharing will leave the copied page mapped
write-protected in the page table, not having the semantics of a write
fault.

Logically, unsharing is triggered "early", as soon as GUP performs the
action that could result in a COW getting missed later and the security
issue triggering: however, unsharing is not triggered as before via a
write fault with undesired side effects.

Long story short, GUP triggers unsharing if all of the following conditions
are met:
* The page is mapped R/O
* We have an anonymous page, excluding KSM
* We want to read (!FOLL_WRITE)
* Unsharing is not disabled (!FOLL_NOUNSHARE)
* We want to take a reference (FOLL_GET or FOLL_PIN)
* The page is a shared anonymous page: mapcount > 1

To reliably detect shared anonymous THP without heavy locking, introduce
a mapcount_seqcount seqlock that protects the mapcount of a THP and can
be used to read an atomic mapcount value. The mapcount_seqlock is stored
inside the memmap of the compound page -- to keep it simple, factor out
a raw_seqlock_t from the seqlock_t.

As this patch series introduces the same unsharing logic for any
anonymous pages, it also paves the way to fix other COW issues, e.g.,
documented in [1], without reintroducing the security issue or
reintroducing other issues we observed in the past (e.g., broken ptrace on
pmem).

All reproducers for this COW issue have been consolidated in the selftest
included in this series. Hopefully we'll get this fixed for good.

Future work:

* get_user_pages_fast_only() can currently spin on the mapcount_seqcount
  when reading the mapcount, which might be a rare event. While this is
  fine even when done from get_user_pages_fast_only() in IRQ context, we
  might want to just fail fast in get_user_pages_fast_only(). We already
  have patches prepared that add page_anon_maybe_shared() and
  page_trans_huge_anon_maybe_shared() that will return "true" in case
  spinning would be required and make get_user_pages_fast_only() fail fast.
  I'm excluding them for simplicity.

  ... even better would be finding a way to just not need the
  mapcount_seqcount, but THP splitting and PageDoubleMap() gives us a
  hard time -- but maybe we'll eventually find a way someday :)

* Part 2 will tackle the other user-space visible breakages / COW issues
  raised in [1]. This series is the basis for adjusting the COW logic once
  again without re-introducing the COW issue fixed in this series and
  without reintroducing the issues we saw with the original CVE fix
  (e.g., breaking ptrace on pmem). There might be further parts to improve
  the GUP long-term <-> MM synchronicity and to optimize some things
  around that.


The idea is by Andrea and some patches are rewritten versions of prototype
patches by Andrea. I cross-compiled and tested as good as possible.

I'll CC locking+selftest folks only on the relevant patch and the cover
letter to minimze the noise. I'll put everyone on CC who was either
involved with the COW issues in the past or attended the linux-mm alignment
session on Wednesday. Appologies if I forget anyone :)

[1] https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com


David Hildenbrand (11):
  seqlock: provide lockdep-free raw_seqcount_t variant
  mm: thp: consolidate mapcount logic on THP split
  mm: simplify hugetlb and file-THP handling in __page_mapcount()
  mm: thp: simlify total_mapcount()
  mm: thp: allow for reading the THP mapcount atomically via a
    raw_seqlock_t
  mm: support GUP-triggered unsharing via FAULT_FLAG_UNSHARE (!hugetlb)
  mm: gup: trigger unsharing via FAULT_FLAG_UNSHARE when required
    (!hugetlb)
  mm: hugetlb: support GUP-triggered unsharing via FAULT_FLAG_UNSHARE
  mm: gup: trigger unsharing via FAULT_FLAG_UNSHARE when required
    (hugetlb)
  mm: thp: introduce and use page_trans_huge_anon_shared()
  selftests/vm: add tests for the known COW security issues

 Documentation/locking/seqlock.rst         |  50 ++++
 include/linux/huge_mm.h                   |  72 +++++
 include/linux/mm.h                        |  14 +
 include/linux/mm_types.h                  |   9 +
 include/linux/seqlock.h                   | 145 +++++++---
 mm/gup.c                                  |  89 +++++-
 mm/huge_memory.c                          | 120 +++++++--
 mm/hugetlb.c                              | 129 +++++++--
 mm/memory.c                               | 136 ++++++++--
 mm/rmap.c                                 |  40 +--
 mm/swapfile.c                             |  35 ++-
 mm/util.c                                 |  24 +-
 tools/testing/selftests/vm/Makefile       |   1 +
 tools/testing/selftests/vm/gup_cow.c      | 312 ++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh |  16 ++
 15 files changed, 1044 insertions(+), 148 deletions(-)
 create mode 100644 tools/testing/selftests/vm/gup_cow.c

-- 
2.31.1

