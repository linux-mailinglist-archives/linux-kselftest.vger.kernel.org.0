Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB5A2FAFA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 05:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbhASEnW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 23:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbhASEkE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 23:40:04 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA204C061573
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 20:39:23 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id e15so12884789qte.9
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 20:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I8esbi1Mx4J8IdOq6n4ofQCTgaRlztGeZtwqoeCWczo=;
        b=Yv69/o5cvqCBTABqLZs9p1t/3TLh9bv+0w5Y9PKDnkyNKgtjzlS7A3rUbgTnJO/Ay3
         UhN1+Z7Lne30j3dgRdbv7a8bNyniMD2z91FiDTMB91FVs8Stv/0iFlvGU/CaC9EJkhK6
         hEMEp7fNsGfFovYJdGXlnIyi2xVRJxr13Xodf0F1mKqVuhxTzOiR1Z3g8LWRCi9+F/Z/
         1l7s2n63gYeVWeqvVJDznvZUeem+b5lr3nbKk+ZdZZ8eaTZ3Cudv6wmvkDRwa3BfvTVD
         AZk409FzOrU562MVLVD2ydzvIQ2K26Fzh4T6d2US2CrBwztxVxZU+hZjQOAfpJ2A0TFf
         rFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I8esbi1Mx4J8IdOq6n4ofQCTgaRlztGeZtwqoeCWczo=;
        b=p3q8/nrKHpkQDzWLBzmpTmTXYFio16G7esT4VKFm1h+VUDiPAHornwybxnvI4eRGTh
         tYWVRaf5/eV6iUvL5fD5+KxJpaOltmpRoozZnZTRiHwbPMSN8LRSTuKXhgqa67wIyHkW
         rqmErXSAufkk26aKlOJMCNm1CidXzBt+5hvB1RwBLcAupQ6w3BNHwHT2T9TEouXsK3oZ
         uOTWf0PgjyeF3k/tJJgmXL2bmON+Y2reZeKy3soLY+dpnie5Rw6+x94keIeHJQoXNtsT
         nXYGdc45/nUOHjDRY3Zzlfk4kGAEM4e1IBYlo0QEltncF470TTeIoTAvgm6VC25Ajp+p
         mHQg==
X-Gm-Message-State: AOAM53362Ky8UYQ8y1qqATNYiboh6Bm/FgmIxC8u/gUHGmFI+XmSbOJu
        Zbwb7h92aRNWjoQgSdGjTHVN3w==
X-Google-Smtp-Source: ABdhPJw9TiVm74D4hybB87XquFGGpJFw+ROPRyG8VTFzz3IeI7FyzoNv+6Ei9Eu1azikyTYgAD2g+A==
X-Received: by 2002:aed:3064:: with SMTP id 91mr2681138qte.151.1611031162738;
        Mon, 18 Jan 2021 20:39:22 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z20sm11934536qkz.37.2021.01.18.20.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 20:39:22 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v5 00/14] prohibit pinning pages in ZONE_MOVABLE
Date:   Mon, 18 Jan 2021 23:39:06 -0500
Message-Id: <20210119043920.155044-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog
---------
v5
- Added the following patches to the beginning of series, which are fixes
   to the other existing problems with CMA migration code:
	mm/gup: check every subpage of a compound page during isolation
	mm/gup: return an error on migration failure
	mm/gup: check for isolation errors also at the beginning of series
	mm/gup: do not allow zero page for pinned pages
- remove .gfp_mask/.reclaim_idx changes from mm/vmscan.c
- update movable zone header comment in patch 8 instead of patch 3, fix the comment
- Added acked, sign-offs
- Updated commit logs based on feedback
- Addressed issues reported by Michal and Jason.
- Remove:
	#define PINNABLE_MIGRATE_MAX	10
	#define PINNABLE_ISOLATE_MAX	100
   Instead: fail on the first migration failure, and retry isolation forever as their
   failures are transient.

- In self-set addressed some of the comments from John Hubbard, updated commit logs,
  and added comments. Renamed gup->flags with gup->test_flags.

v4
- Address page migration comments. New patch:
  mm/gup: limit number of gup migration failures, honor failures
  Implements the limiting number of retries for migration failures, and
  also check for isolation failures.
  Added a test case into gup_test to verify that pages never long-term
  pinned in a movable zone, and also added tests to fault both in kernel
  and in userland.
v3
- Merged with linux-next, which contains clean-up patch from Jason,
  therefore this series is reduced by two patches which did the same
  thing.
v2
- Addressed all review comments
- Added Reviewed-by's.
- Renamed PF_MEMALLOC_NOMOVABLE to PF_MEMALLOC_PIN
- Added is_pinnable_page() to check if page can be longterm pinned
- Fixed gup fast path by checking is_in_pinnable_zone()
- rename cma_page_list to movable_page_list
- add a admin-guide note about handling pinned pages in ZONE_MOVABLE,
  updated caveat about pinned pages from linux/mmzone.h
- Move current_gfp_context() to fast-path

---------
When page is pinned it cannot be moved and its physical address stays
the same until pages is unpinned.

This is useful functionality to allows userland to implementation DMA
access. For example, it is used by vfio in vfio_pin_pages().

However, this functionality breaks memory hotplug/hotremove assumptions
that pages in ZONE_MOVABLE can always be migrated.

This patch series fixes this issue by forcing new allocations during
page pinning to omit ZONE_MOVABLE, and also to migrate any existing
pages from ZONE_MOVABLE during pinning.

It uses the same scheme logic that is currently used by CMA, and extends
the functionality for all allocations.

For more information read the discussion [1] about this problem.
[1] https://lore.kernel.org/lkml/CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com

Previous versions:
v1
https://lore.kernel.org/lkml/20201202052330.474592-1-pasha.tatashin@soleen.com
v2
https://lore.kernel.org/lkml/20201210004335.64634-1-pasha.tatashin@soleen.com
v3
https://lore.kernel.org/lkml/20201211202140.396852-1-pasha.tatashin@soleen.com
v4
https://lore.kernel.org/lkml/20201217185243.3288048-1-pasha.tatashin@soleen.com

Pavel Tatashin (14):
  mm/gup: don't pin migrated cma pages in movable zone
  mm/gup: check every subpage of a compound page during isolation
  mm/gup: return an error on migration failure
  mm/gup: check for isolation errors
  mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN
  mm: apply per-task gfp constraints in fast path
  mm: honor PF_MEMALLOC_PIN for all movable pages
  mm/gup: do not allow zero page for pinned pages
  mm/gup: migrate pinned pages out of movable zone
  memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
  mm/gup: change index type to long as it counts pages
  mm/gup: longterm pin migration cleaup
  selftests/vm: test flag is broken
  selftests/vm: test faulting in kernel, and verify pinnable pages

 .../admin-guide/mm/memory-hotplug.rst         |   9 +
 include/linux/migrate.h                       |   1 +
 include/linux/mm.h                            |  11 ++
 include/linux/mmzone.h                        |   9 +-
 include/linux/sched.h                         |   2 +-
 include/linux/sched/mm.h                      |  27 +--
 include/trace/events/migrate.h                |   3 +-
 mm/gup.c                                      | 178 ++++++++----------
 mm/gup_test.c                                 |  29 +--
 mm/gup_test.h                                 |   3 +-
 mm/hugetlb.c                                  |   4 +-
 mm/page_alloc.c                               |  33 ++--
 tools/testing/selftests/vm/gup_test.c         |  36 +++-
 13 files changed, 185 insertions(+), 160 deletions(-)

-- 
2.25.1

