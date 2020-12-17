Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5332DD8C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgLQSx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgLQSx1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:53:27 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA1DC0617B0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:52:47 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c14so20861684qtn.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJmQJk/qnnNK+45hsQuVraY9kUpro35/zVkofbDgVLE=;
        b=dMpnxe+kBujUiyNXSWWljlcdba5/4EI/Xn7Nhij8kkGR8Gwk/dLkR2ZpRbRLNxOTAA
         ARdOJ21zIOBIB5dtZUYXCz3NVZsBgCTh1OS/ZNZNxkWoAIrPFf3E0+xZgzSHMjFrmaPP
         /Y+AwjLRJzqpt4s9l3nxH0yhG1pnhAz9V6Uc5NAdWbPLkDZh0T5gqMPkn+uSjeQCGwkT
         dr/MoFTQBFoEsd6TuHPQ/6F11msiOmekseRjbh5UzigP365AWAZZO/MA547MhyKUMFqV
         xCznKAmryRMAFlhcA5zrrUI4Sd/WqJtMqWv7hst7bTd8V4lPIImq/wWXvPRQhSaNWtHz
         953w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJmQJk/qnnNK+45hsQuVraY9kUpro35/zVkofbDgVLE=;
        b=VFQ4VOX7egoR8OTIJGQro2ieQDSb2hr067HAB7UeiF9mPVacCrQX+J6bRJzs1WS0TW
         JcG9gutrHXkprIcEBbbsxcm2z2TuYKqKZz9EG5kNFui6GNLiEs9OJVGibfY1W+q3cj8M
         X3id1FJ5BJAZLBjOOZCZdfvtFScxloH0MySh38RFWAcvARuCofnRXpzUQsejBzlgp37E
         sSzNE012uLR0R+PPcj7kvgRbHkuPXqTNboeRxOYhf+FLP0HFwBsact+KmxRdgAgB19cd
         S/MJ0gfZ8iy+DSWmBfV68O30x62SOV8H+snUzkkXAdAEGnqqUtysvic2zmU3EHTjitV2
         a5OA==
X-Gm-Message-State: AOAM532+AHmczHWVQYu8fzGiYKpjxgyRriXAqEafiMmLgP5yrzv9ohmu
        GbtjG7DumNMnxsBq8Cp+dSZoqA==
X-Google-Smtp-Source: ABdhPJx7muuv9wAqAS2WPTPk5ZAJcl+rC1wm26NAoz2/eM7fsJUO8cqs4X+rODk6Tc8u/+MpKEUsfw==
X-Received: by 2002:ac8:396d:: with SMTP id t42mr121955qtb.273.1608231166390;
        Thu, 17 Dec 2020 10:52:46 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m8sm4127434qkn.41.2020.12.17.10.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 10:52:45 -0800 (PST)
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
Subject: [PATCH v4 00/10] prohibit pinning pages in ZONE_MOVABLE
Date:   Thu, 17 Dec 2020 13:52:33 -0500
Message-Id: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog
---------
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

Pavel Tatashin (10):
  mm/gup: don't pin migrated cma pages in movable zone
  mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN
  mm: apply per-task gfp constraints in fast path
  mm: honor PF_MEMALLOC_PIN for all movable pages
  mm/gup: migrate pinned pages out of movable zone
  memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
  mm/gup: change index type to long as it counts pages
  mm/gup: limit number of gup migration failures, honor failures
  selftests/vm: test flag is broken
  selftests/vm: test faulting in kernel, and verify pinnable pages

 .../admin-guide/mm/memory-hotplug.rst         |   9 +
 include/linux/migrate.h                       |   1 +
 include/linux/mm.h                            |  11 +
 include/linux/mmzone.h                        |  11 +-
 include/linux/sched.h                         |   2 +-
 include/linux/sched/mm.h                      |  27 +--
 include/trace/events/migrate.h                |   3 +-
 mm/gup.c                                      | 217 ++++++++++--------
 mm/gup_test.c                                 |  15 +-
 mm/gup_test.h                                 |   1 +
 mm/hugetlb.c                                  |   4 +-
 mm/page_alloc.c                               |  33 ++-
 mm/vmscan.c                                   |  10 +-
 tools/testing/selftests/vm/gup_test.c         |  26 ++-
 14 files changed, 221 insertions(+), 149 deletions(-)

-- 
2.25.1

