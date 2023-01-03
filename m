Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364F965C5B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jan 2023 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjACSIE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Jan 2023 13:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbjACSID (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Jan 2023 13:08:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A51144C;
        Tue,  3 Jan 2023 10:08:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36184614B8;
        Tue,  3 Jan 2023 18:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41AEC433D2;
        Tue,  3 Jan 2023 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769280;
        bh=9suXfmiqocIsILLpWpch1Pzb2obTsSehLWnKP4pUSq8=;
        h=From:To:Cc:Subject:Date:From;
        b=Iagw3/KdJOIwv3Gew//1r1gitcYAupBDObUgG+hOHeJHHafhJeJufqMC9xIxGj0H9
         IJy15l9i6ZGcgpvWANvuLTNbSkSYQbYPJGolAn2Xpl+Arm2YH6uqrLJ715g9O9K3PV
         2TVYay9k0M3tTXndu7NB2GbQd7VYMOE3+EoBy/G9RSYOYMouXY72QRnkAAE31hLi+l
         lewvMhqHP+GuUxrUqu6Ac8esHXsG/A/C8L5nZAr3k0jevBBfDbZWkRHjYn7B1acq+s
         LpHgXH3DGz2w/BcHQPJ2m7Emt4I4j/9U2zM6kz4CgyNF7CqZe9Fce/We7q3MY012+L
         F3OpnSB/7Wfmg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: 
Date:   Tue,  3 Jan 2023 18:07:49 +0000
Message-Id: <20230103180754.129637-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Date: Tue, 3 Jan 2023 18:00:52 +0000
Subject: [PATCH 0/5] mm: trivial fixups

This patchset is for trivial fixups of mm stuff on MAINTAINERS, tools/
selftests, and docs.

SeongJae Park (5):
  MAINTAINERS: add types to akpm/mm git trees entries
  MAINTAINERS/MEMORY MANAGEMENT: Add tools/vm/ as managed files
  tools/vm: rename tools/vm to tools/mm
  selftests/vm: rename selftets/vm to selftests/mm
  Docs/admin-guide/mm/numaperf: increase depth of subsections

 Documentation/admin-guide/mm/hugetlbpage.rst             | 6 +++---
 Documentation/admin-guide/mm/idle_page_tracking.rst      | 2 +-
 Documentation/admin-guide/mm/numaperf.rst                | 8 ++++----
 Documentation/admin-guide/mm/pagemap.rst                 | 4 ++--
 Documentation/core-api/pin_user_pages.rst                | 2 +-
 Documentation/mm/page_owner.rst                          | 2 +-
 Documentation/mm/slub.rst                                | 2 +-
 Documentation/translations/zh_CN/mm/page_owner.rst       | 2 +-
 MAINTAINERS                                              | 9 +++++----
 mm/Kconfig                                               | 2 +-
 mm/Kconfig.debug                                         | 2 +-
 mm/memory-failure.c                                      | 2 +-
 tools/{vm => mm}/.gitignore                              | 0
 tools/{vm => mm}/Makefile                                | 0
 tools/{vm => mm}/page-types.c                            | 0
 tools/{vm => mm}/page_owner_sort.c                       | 0
 tools/{vm => mm}/slabinfo-gnuplot.sh                     | 0
 tools/{vm => mm}/slabinfo.c                              | 0
 tools/testing/selftests/{vm => mm}/.gitignore            | 0
 tools/testing/selftests/{vm => mm}/Makefile              | 0
 .../selftests/{vm => mm}/charge_reserved_hugetlb.sh      | 0
 tools/testing/selftests/{vm => mm}/check_config.sh       | 0
 tools/testing/selftests/{vm => mm}/compaction_test.c     | 0
 tools/testing/selftests/{vm => mm}/config                | 0
 tools/testing/selftests/{vm => mm}/cow.c                 | 0
 tools/testing/selftests/{vm => mm}/gup_test.c            | 0
 tools/testing/selftests/{vm => mm}/hmm-tests.c           | 0
 tools/testing/selftests/{vm => mm}/hugepage-mmap.c       | 0
 tools/testing/selftests/{vm => mm}/hugepage-mremap.c     | 0
 tools/testing/selftests/{vm => mm}/hugepage-shm.c        | 0
 tools/testing/selftests/{vm => mm}/hugepage-vmemmap.c    | 0
 tools/testing/selftests/{vm => mm}/hugetlb-madvise.c     | 0
 .../selftests/{vm => mm}/hugetlb_reparenting_test.sh     | 0
 tools/testing/selftests/{vm => mm}/khugepaged.c          | 0
 .../testing/selftests/{vm => mm}/ksm_functional_tests.c  | 0
 tools/testing/selftests/{vm => mm}/ksm_tests.c           | 0
 tools/testing/selftests/{vm => mm}/madv_populate.c       | 0
 tools/testing/selftests/{vm => mm}/map_fixed_noreplace.c | 0
 tools/testing/selftests/{vm => mm}/map_hugetlb.c         | 0
 tools/testing/selftests/{vm => mm}/map_populate.c        | 0
 tools/testing/selftests/{vm => mm}/memfd_secret.c        | 0
 tools/testing/selftests/{vm => mm}/migration.c           | 0
 tools/testing/selftests/{vm => mm}/mlock-random-test.c   | 0
 tools/testing/selftests/{vm => mm}/mlock2-tests.c        | 0
 tools/testing/selftests/{vm => mm}/mlock2.h              | 0
 tools/testing/selftests/{vm => mm}/mrelease_test.c       | 0
 tools/testing/selftests/{vm => mm}/mremap_dontunmap.c    | 0
 tools/testing/selftests/{vm => mm}/mremap_test.c         | 0
 tools/testing/selftests/{vm => mm}/on-fault-limit.c      | 0
 tools/testing/selftests/{vm => mm}/pkey-helpers.h        | 0
 tools/testing/selftests/{vm => mm}/pkey-powerpc.h        | 0
 tools/testing/selftests/{vm => mm}/pkey-x86.h            | 0
 tools/testing/selftests/{vm => mm}/protection_keys.c     | 0
 tools/testing/selftests/{vm => mm}/run_vmtests.sh        | 0
 tools/testing/selftests/{vm => mm}/settings              | 0
 tools/testing/selftests/{vm => mm}/soft-dirty.c          | 0
 .../testing/selftests/{vm => mm}/split_huge_page_test.c  | 0
 tools/testing/selftests/{vm => mm}/test_hmm.sh           | 0
 tools/testing/selftests/{vm => mm}/test_vmalloc.sh       | 0
 tools/testing/selftests/{vm => mm}/thuge-gen.c           | 0
 tools/testing/selftests/{vm => mm}/transhuge-stress.c    | 0
 tools/testing/selftests/{vm => mm}/userfaultfd.c         | 0
 tools/testing/selftests/{vm => mm}/util.h                | 0
 tools/testing/selftests/{vm => mm}/va_128TBswitch.c      | 0
 tools/testing/selftests/{vm => mm}/va_128TBswitch.sh     | 0
 .../testing/selftests/{vm => mm}/virtual_address_range.c | 0
 tools/testing/selftests/{vm => mm}/vm_util.c             | 0
 tools/testing/selftests/{vm => mm}/vm_util.h             | 0
 .../testing/selftests/{vm => mm}/write_hugetlb_memory.sh | 0
 tools/testing/selftests/{vm => mm}/write_to_hugetlbfs.c  | 0
 70 files changed, 22 insertions(+), 21 deletions(-)
 rename tools/{vm => mm}/.gitignore (100%)
 rename tools/{vm => mm}/Makefile (100%)
 rename tools/{vm => mm}/page-types.c (100%)
 rename tools/{vm => mm}/page_owner_sort.c (100%)
 rename tools/{vm => mm}/slabinfo-gnuplot.sh (100%)
 rename tools/{vm => mm}/slabinfo.c (100%)
 rename tools/testing/selftests/{vm => mm}/.gitignore (100%)
 rename tools/testing/selftests/{vm => mm}/Makefile (100%)
 rename tools/testing/selftests/{vm => mm}/charge_reserved_hugetlb.sh (100%)
 rename tools/testing/selftests/{vm => mm}/check_config.sh (100%)
 rename tools/testing/selftests/{vm => mm}/compaction_test.c (100%)
 rename tools/testing/selftests/{vm => mm}/config (100%)
 rename tools/testing/selftests/{vm => mm}/cow.c (100%)
 rename tools/testing/selftests/{vm => mm}/gup_test.c (100%)
 rename tools/testing/selftests/{vm => mm}/hmm-tests.c (100%)
 rename tools/testing/selftests/{vm => mm}/hugepage-mmap.c (100%)
 rename tools/testing/selftests/{vm => mm}/hugepage-mremap.c (100%)
 rename tools/testing/selftests/{vm => mm}/hugepage-shm.c (100%)
 rename tools/testing/selftests/{vm => mm}/hugepage-vmemmap.c (100%)
 rename tools/testing/selftests/{vm => mm}/hugetlb-madvise.c (100%)
 rename tools/testing/selftests/{vm => mm}/hugetlb_reparenting_test.sh (100%)
 rename tools/testing/selftests/{vm => mm}/khugepaged.c (100%)
 rename tools/testing/selftests/{vm => mm}/ksm_functional_tests.c (100%)
 rename tools/testing/selftests/{vm => mm}/ksm_tests.c (100%)
 rename tools/testing/selftests/{vm => mm}/madv_populate.c (100%)
 rename tools/testing/selftests/{vm => mm}/map_fixed_noreplace.c (100%)
 rename tools/testing/selftests/{vm => mm}/map_hugetlb.c (100%)
 rename tools/testing/selftests/{vm => mm}/map_populate.c (100%)
 rename tools/testing/selftests/{vm => mm}/memfd_secret.c (100%)
 rename tools/testing/selftests/{vm => mm}/migration.c (100%)
 rename tools/testing/selftests/{vm => mm}/mlock-random-test.c (100%)
 rename tools/testing/selftests/{vm => mm}/mlock2-tests.c (100%)
 rename tools/testing/selftests/{vm => mm}/mlock2.h (100%)
 rename tools/testing/selftests/{vm => mm}/mrelease_test.c (100%)
 rename tools/testing/selftests/{vm => mm}/mremap_dontunmap.c (100%)
 rename tools/testing/selftests/{vm => mm}/mremap_test.c (100%)
 rename tools/testing/selftests/{vm => mm}/on-fault-limit.c (100%)
 rename tools/testing/selftests/{vm => mm}/pkey-helpers.h (100%)
 rename tools/testing/selftests/{vm => mm}/pkey-powerpc.h (100%)
 rename tools/testing/selftests/{vm => mm}/pkey-x86.h (100%)
 rename tools/testing/selftests/{vm => mm}/protection_keys.c (100%)
 rename tools/testing/selftests/{vm => mm}/run_vmtests.sh (100%)
 rename tools/testing/selftests/{vm => mm}/settings (100%)
 rename tools/testing/selftests/{vm => mm}/soft-dirty.c (100%)
 rename tools/testing/selftests/{vm => mm}/split_huge_page_test.c (100%)
 rename tools/testing/selftests/{vm => mm}/test_hmm.sh (100%)
 rename tools/testing/selftests/{vm => mm}/test_vmalloc.sh (100%)
 rename tools/testing/selftests/{vm => mm}/thuge-gen.c (100%)
 rename tools/testing/selftests/{vm => mm}/transhuge-stress.c (100%)
 rename tools/testing/selftests/{vm => mm}/userfaultfd.c (100%)
 rename tools/testing/selftests/{vm => mm}/util.h (100%)
 rename tools/testing/selftests/{vm => mm}/va_128TBswitch.c (100%)
 rename tools/testing/selftests/{vm => mm}/va_128TBswitch.sh (100%)
 rename tools/testing/selftests/{vm => mm}/virtual_address_range.c (100%)
 rename tools/testing/selftests/{vm => mm}/vm_util.c (100%)
 rename tools/testing/selftests/{vm => mm}/vm_util.h (100%)
 rename tools/testing/selftests/{vm => mm}/write_hugetlb_memory.sh (100%)
 rename tools/testing/selftests/{vm => mm}/write_to_hugetlbfs.c (100%)

-- 
2.25.1

