Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463BD31BECC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhBOQSi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 11:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhBOQOd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 11:14:33 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E59CC0613D6
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:13:52 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id r77so6774894qka.12
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgOcbWVlXEaTgKR2YO46uJEZBiJ6ZIhzWJFxuAbweaw=;
        b=cLqsFxDnVUK7Y9ck/9he2hDj69MH1f8OnnYTThtorOSvC+8klrQ4URYBDdvymVIvl2
         hERmNfmVceoEMVPp1G2KkiT/VCrvoDAxz5FT/DAcUoVpLUdkr5MqD12G+3BfwNEZCjOJ
         Cx+sSKpWKQubyXLM0wqECyXmo3Wo8qno269R73OwnnTUQo1ucJZxeEXgONvLB3jt/1dY
         etUFBRiRPGsWvGbOgqI1I5wE0H7oGpxrMlcWMzCBHakPIhyDn0uE5/qHRkMaDlpSlU65
         q0LTXG44zleaLM2brFtYb3WRlE0JBl8F6B4kXkm6eqGRDgFGa7ilWGpdS8qj3kPBWgrm
         eBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgOcbWVlXEaTgKR2YO46uJEZBiJ6ZIhzWJFxuAbweaw=;
        b=R8EGD95MjAZRxodeKg8Eg5alsPyHbma1Ip1K+pl4SyNvsFt6e8LGvNxmjBYHlrbw5n
         qh4tjHh4Feoa9Tci8M69tLUcaypf2ONnVS5Ldl4EOPQvcq45XwaWiGLQ1GranqNUGbHL
         ffDNK8XN97G0A/1AYWiQYHueCtDNTL0ogIcSAX1QvGiMGj7kANMmgjQ8qC+QPfbbHFVJ
         0H4kT/DKgBHMTDvhC37Q0f+3SeXozesOFS8L/WFEJ171E5z9OnxzvAYTnGZndejNWAIt
         figOuBdmZpGExhSAIszW6PcyI7XIPJvJexGZKt30gn1Ymwos0vOk5kdWKd+IOOaUIJIN
         oQUA==
X-Gm-Message-State: AOAM530qFuQtsO0GOr43za4kah3OPVWdR6OJuJfnwZ2zI/dWMR3JUAwn
        JDvWsN/lQcUpOAddpvGgRyXtMQ==
X-Google-Smtp-Source: ABdhPJxcFlGOXp1G4eLBqTJDnimeoLjm6V7Zt5zCfBSYhgAGdK3sw96DHL1ley2e0Eb8rfmhWqxFJA==
X-Received: by 2002:a37:a191:: with SMTP id k139mr14960124qke.61.1613405631689;
        Mon, 15 Feb 2021 08:13:51 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:13:50 -0800 (PST)
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
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v11 00/14] prohibit pinning pages in ZONE_MOVABLE
Date:   Mon, 15 Feb 2021 11:13:35 -0500
Message-Id: <20210215161349.246722-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog
---------
v11
- Another build fix reported by robot on i386: moved is_pinnable_page()
  below set_page_section() in linux/mm.h

v10
- Fixed !CONFIG_MMU compiler issues by adding is_zero_pfn() stub.

v9
- Renamed gpf_to_alloc_flags() to gfp_to_alloc_flags_cma(); thanks Lecopzer
  Chen for noticing.
- Fixed warning reported scripts/checkpatch.pl:
  "Logical continuations should be on the previous line"

v8
- Added reviewed by's from John Hubbard
- Fixed subjects for selftests patches
- Moved zero page check inside is_pinnable_page() as requested by Jason
  Gunthorpe.

v7
- Added reviewed-by's
- Fixed a compile bug on non-mmu builds reported by robot

v6
  Small update, but I wanted to send it out quicker, as it removes a
  controversial patch and replaces it with something sane.
- Removed forcing FOLL_WRITE for longterm gup, instead added a patch to
  skip zero pages during migration.
- Added reviewed-by's and minor log changes.

v5
- Added the following patches to the beginning of series, which are fixes
   to the other existing problems with CMA migration code:
	mm/gup: check every subpage of a compound page during isolation
	mm/gup: return an error on migration failure
	mm/gup: check for isolation errors also at the beginning of series
	mm/gup: do not allow zero page for pinned pages
- remove .gfp_mask/.reclaim_idx changes from mm/vmscan.c
- update movable zone header comment in patch 8 instead of patch 3, fix
  the comment
- Added acked, sign-offs
- Updated commit logs based on feedback
- Addressed issues reported by Michal and Jason.
- Remove:
	#define PINNABLE_MIGRATE_MAX	10
	#define PINNABLE_ISOLATE_MAX	100
   Instead: fail on the first migration failure, and retry isolation
   forever as their failures are transient.

- In self-set addressed some of the comments from John Hubbard, updated
  commit logs, and added comments. Renamed gup->flags with gup->test_flags.

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
v5
https://lore.kernel.org/lkml/20210119043920.155044-1-pasha.tatashin@soleen.com
v6
https://lore.kernel.org/lkml/20210120014333.222547-1-pasha.tatashin@soleen.com
v7
https://lore.kernel.org/lkml/20210122033748.924330-1-pasha.tatashin@soleen.com
v8
https://lore.kernel.org/lkml/20210125194751.1275316-1-pasha.tatashin@soleen.com
v9
https://lore.kernel.org/lkml/20210201153827.444374-1-pasha.tatashin@soleen.com
v10
https://lore.kernel.org/lkml/20210211162427.618913-1-pasha.tatashin@soleen.com

Pavel Tatashin (14):
  mm/gup: don't pin migrated cma pages in movable zone
  mm/gup: check every subpage of a compound page during isolation
  mm/gup: return an error on migration failure
  mm/gup: check for isolation errors
  mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN
  mm: apply per-task gfp constraints in fast path
  mm: honor PF_MEMALLOC_PIN for all movable pages
  mm/gup: do not migrate zero page
  mm/gup: migrate pinned pages out of movable zone
  memory-hotplug.rst: add a note about ZONE_MOVABLE and page pinning
  mm/gup: change index type to long as it counts pages
  mm/gup: longterm pin migration cleanup
  selftests/vm: gup_test: fix test flag
  selftests/vm: gup_test: test faulting in kernel, and verify pinnable
    pages

 .../admin-guide/mm/memory-hotplug.rst         |   9 +
 include/linux/migrate.h                       |   1 +
 include/linux/mm.h                            |  19 ++
 include/linux/mmzone.h                        |  13 +-
 include/linux/pgtable.h                       |  12 ++
 include/linux/sched.h                         |   2 +-
 include/linux/sched/mm.h                      |  27 +--
 include/trace/events/migrate.h                |   3 +-
 mm/gup.c                                      | 174 ++++++++----------
 mm/gup_test.c                                 |  29 +--
 mm/gup_test.h                                 |   3 +-
 mm/hugetlb.c                                  |   4 +-
 mm/page_alloc.c                               |  33 ++--
 tools/testing/selftests/vm/gup_test.c         |  36 +++-
 14 files changed, 208 insertions(+), 157 deletions(-)

-- 
2.25.1

