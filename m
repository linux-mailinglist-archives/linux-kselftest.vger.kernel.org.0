Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2867F65C5B9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jan 2023 19:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbjACSIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Jan 2023 13:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbjACSIG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Jan 2023 13:08:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31F12AF3;
        Tue,  3 Jan 2023 10:08:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9347614C1;
        Tue,  3 Jan 2023 18:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C127C433D2;
        Tue,  3 Jan 2023 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769283;
        bh=HXJVGMAig61Rl2c9fmWXXVWFfrgH+bBD0PfuPFy7re4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8CfNMuD+129Mx3/HkUI0vGb+ciq16uT60rJEmst5gEIb89ZicTa9UpwJU3w82BMe
         UckJ03sdJxWGzwwY6FzmM97ca7iM8EVS7ftHnJ2jV9xp/cyS+Oe5N7u+YfnChqfJ5g
         lMrK2dFu71XQggzecGlcTnmKQnb+ConZmqS7TZYBTsT7/0gYgicAC/wn8RY8y7tvby
         RGuMZoblIAjj+1KwXoqCckd6LvJk6PpdR9UIVdObTKjn91Jaq3EKVXZZeCIwLO2Ce5
         jiRZCWrlsmEHIt9x6SkPb9JFvQ714MwlbMUzEX76DNFHyGQShsDaDuteXC/jXOtdho
         LOQK+Z4nNeZfA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] selftests/vm: rename selftets/vm to selftests/mm
Date:   Tue,  3 Jan 2023 18:07:53 +0000
Message-Id: <20230103180754.129637-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103180754.129637-1-sj@kernel.org>
References: <20230103180754.129637-1-sj@kernel.org>
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

Rename selftets/vm to selftests/mm for being more consistent with the
code, documentation, and tools directories, and won't be confused with
virtual machines.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/hugetlbpage.rst                | 6 +++---
 Documentation/core-api/pin_user_pages.rst                   | 2 +-
 MAINTAINERS                                                 | 4 ++--
 mm/Kconfig                                                  | 2 +-
 tools/testing/selftests/{vm => mm}/.gitignore               | 0
 tools/testing/selftests/{vm => mm}/Makefile                 | 0
 .../testing/selftests/{vm => mm}/charge_reserved_hugetlb.sh | 0
 tools/testing/selftests/{vm => mm}/check_config.sh          | 0
 tools/testing/selftests/{vm => mm}/compaction_test.c        | 0
 tools/testing/selftests/{vm => mm}/config                   | 0
 tools/testing/selftests/{vm => mm}/cow.c                    | 0
 tools/testing/selftests/{vm => mm}/gup_test.c               | 0
 tools/testing/selftests/{vm => mm}/hmm-tests.c              | 0
 tools/testing/selftests/{vm => mm}/hugepage-mmap.c          | 0
 tools/testing/selftests/{vm => mm}/hugepage-mremap.c        | 0
 tools/testing/selftests/{vm => mm}/hugepage-shm.c           | 0
 tools/testing/selftests/{vm => mm}/hugepage-vmemmap.c       | 0
 tools/testing/selftests/{vm => mm}/hugetlb-madvise.c        | 0
 .../selftests/{vm => mm}/hugetlb_reparenting_test.sh        | 0
 tools/testing/selftests/{vm => mm}/khugepaged.c             | 0
 tools/testing/selftests/{vm => mm}/ksm_functional_tests.c   | 0
 tools/testing/selftests/{vm => mm}/ksm_tests.c              | 0
 tools/testing/selftests/{vm => mm}/madv_populate.c          | 0
 tools/testing/selftests/{vm => mm}/map_fixed_noreplace.c    | 0
 tools/testing/selftests/{vm => mm}/map_hugetlb.c            | 0
 tools/testing/selftests/{vm => mm}/map_populate.c           | 0
 tools/testing/selftests/{vm => mm}/memfd_secret.c           | 0
 tools/testing/selftests/{vm => mm}/migration.c              | 0
 tools/testing/selftests/{vm => mm}/mlock-random-test.c      | 0
 tools/testing/selftests/{vm => mm}/mlock2-tests.c           | 0
 tools/testing/selftests/{vm => mm}/mlock2.h                 | 0
 tools/testing/selftests/{vm => mm}/mrelease_test.c          | 0
 tools/testing/selftests/{vm => mm}/mremap_dontunmap.c       | 0
 tools/testing/selftests/{vm => mm}/mremap_test.c            | 0
 tools/testing/selftests/{vm => mm}/on-fault-limit.c         | 0
 tools/testing/selftests/{vm => mm}/pkey-helpers.h           | 0
 tools/testing/selftests/{vm => mm}/pkey-powerpc.h           | 0
 tools/testing/selftests/{vm => mm}/pkey-x86.h               | 0
 tools/testing/selftests/{vm => mm}/protection_keys.c        | 0
 tools/testing/selftests/{vm => mm}/run_vmtests.sh           | 0
 tools/testing/selftests/{vm => mm}/settings                 | 0
 tools/testing/selftests/{vm => mm}/soft-dirty.c             | 0
 tools/testing/selftests/{vm => mm}/split_huge_page_test.c   | 0
 tools/testing/selftests/{vm => mm}/test_hmm.sh              | 0
 tools/testing/selftests/{vm => mm}/test_vmalloc.sh          | 0
 tools/testing/selftests/{vm => mm}/thuge-gen.c              | 0
 tools/testing/selftests/{vm => mm}/transhuge-stress.c       | 0
 tools/testing/selftests/{vm => mm}/userfaultfd.c            | 0
 tools/testing/selftests/{vm => mm}/util.h                   | 0
 tools/testing/selftests/{vm => mm}/va_128TBswitch.c         | 0
 tools/testing/selftests/{vm => mm}/va_128TBswitch.sh        | 0
 tools/testing/selftests/{vm => mm}/virtual_address_range.c  | 0
 tools/testing/selftests/{vm => mm}/vm_util.c                | 0
 tools/testing/selftests/{vm => mm}/vm_util.h                | 0
 tools/testing/selftests/{vm => mm}/write_hugetlb_memory.sh  | 0
 tools/testing/selftests/{vm => mm}/write_to_hugetlbfs.c     | 0
 56 files changed, 7 insertions(+), 7 deletions(-)
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

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 19f27c0d92e0..a969a2c742b2 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -461,13 +461,13 @@ Examples
 .. _map_hugetlb:
 
 ``map_hugetlb``
-	see tools/testing/selftests/vm/map_hugetlb.c
+	see tools/testing/selftests/mm/map_hugetlb.c
 
 ``hugepage-shm``
-	see tools/testing/selftests/vm/hugepage-shm.c
+	see tools/testing/selftests/mm/hugepage-shm.c
 
 ``hugepage-mmap``
-	see tools/testing/selftests/vm/hugepage-mmap.c
+	see tools/testing/selftests/mm/hugepage-mmap.c
 
 The `libhugetlbfs`_  library provides a wide range of userspace tools
 to help with huge page usability, environment setup, and control.
diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
index b18416f4500f..facafbdecb95 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -221,7 +221,7 @@ Unit testing
 ============
 This file::
 
- tools/testing/selftests/vm/gup_test.c
+ tools/testing/selftests/mm/gup_test.c
 
 has the following new calls to exercise the new pin*() wrapper functions:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 65426446f09a..ba0a8d292f2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9466,7 +9466,7 @@ F:	Documentation/mm/hmm.rst
 F:	include/linux/hmm*
 F:	lib/test_hmm*
 F:	mm/hmm*
-F:	tools/testing/selftests/vm/*hmm*
+F:	tools/testing/selftests/mm/*hmm*
 
 HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
@@ -13484,7 +13484,7 @@ F:	include/linux/mmzone.h
 F:	include/linux/pagewalk.h
 F:	mm/
 F:	tools/mm/
-F:	tools/testing/selftests/vm/
+F:	tools/testing/selftests/mm/
 
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec05..39df30dcabe3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1073,7 +1073,7 @@ config GUP_TEST
 	  pin_user_pages*(), or pinned via get_user_pages*(), as specified
 	  by other command line arguments.
 
-	  See tools/testing/selftests/vm/gup_test.c
+	  See tools/testing/selftests/mm/gup_test.c
 
 comment "GUP_TEST needs to have DEBUG_FS enabled"
 	depends on !GUP_TEST && !DEBUG_FS
diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/mm/.gitignore
similarity index 100%
rename from tools/testing/selftests/vm/.gitignore
rename to tools/testing/selftests/mm/.gitignore
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/mm/Makefile
similarity index 100%
rename from tools/testing/selftests/vm/Makefile
rename to tools/testing/selftests/mm/Makefile
diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
similarity index 100%
rename from tools/testing/selftests/vm/charge_reserved_hugetlb.sh
rename to tools/testing/selftests/mm/charge_reserved_hugetlb.sh
diff --git a/tools/testing/selftests/vm/check_config.sh b/tools/testing/selftests/mm/check_config.sh
similarity index 100%
rename from tools/testing/selftests/vm/check_config.sh
rename to tools/testing/selftests/mm/check_config.sh
diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
similarity index 100%
rename from tools/testing/selftests/vm/compaction_test.c
rename to tools/testing/selftests/mm/compaction_test.c
diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/mm/config
similarity index 100%
rename from tools/testing/selftests/vm/config
rename to tools/testing/selftests/mm/config
diff --git a/tools/testing/selftests/vm/cow.c b/tools/testing/selftests/mm/cow.c
similarity index 100%
rename from tools/testing/selftests/vm/cow.c
rename to tools/testing/selftests/mm/cow.c
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
similarity index 100%
rename from tools/testing/selftests/vm/gup_test.c
rename to tools/testing/selftests/mm/gup_test.c
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
similarity index 100%
rename from tools/testing/selftests/vm/hmm-tests.c
rename to tools/testing/selftests/mm/hmm-tests.c
diff --git a/tools/testing/selftests/vm/hugepage-mmap.c b/tools/testing/selftests/mm/hugepage-mmap.c
similarity index 100%
rename from tools/testing/selftests/vm/hugepage-mmap.c
rename to tools/testing/selftests/mm/hugepage-mmap.c
diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
similarity index 100%
rename from tools/testing/selftests/vm/hugepage-mremap.c
rename to tools/testing/selftests/mm/hugepage-mremap.c
diff --git a/tools/testing/selftests/vm/hugepage-shm.c b/tools/testing/selftests/mm/hugepage-shm.c
similarity index 100%
rename from tools/testing/selftests/vm/hugepage-shm.c
rename to tools/testing/selftests/mm/hugepage-shm.c
diff --git a/tools/testing/selftests/vm/hugepage-vmemmap.c b/tools/testing/selftests/mm/hugepage-vmemmap.c
similarity index 100%
rename from tools/testing/selftests/vm/hugepage-vmemmap.c
rename to tools/testing/selftests/mm/hugepage-vmemmap.c
diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
similarity index 100%
rename from tools/testing/selftests/vm/hugetlb-madvise.c
rename to tools/testing/selftests/mm/hugetlb-madvise.c
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
similarity index 100%
rename from tools/testing/selftests/vm/hugetlb_reparenting_test.sh
rename to tools/testing/selftests/mm/hugetlb_reparenting_test.sh
diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
similarity index 100%
rename from tools/testing/selftests/vm/khugepaged.c
rename to tools/testing/selftests/mm/khugepaged.c
diff --git a/tools/testing/selftests/vm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
similarity index 100%
rename from tools/testing/selftests/vm/ksm_functional_tests.c
rename to tools/testing/selftests/mm/ksm_functional_tests.c
diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
similarity index 100%
rename from tools/testing/selftests/vm/ksm_tests.c
rename to tools/testing/selftests/mm/ksm_tests.c
diff --git a/tools/testing/selftests/vm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
similarity index 100%
rename from tools/testing/selftests/vm/madv_populate.c
rename to tools/testing/selftests/mm/madv_populate.c
diff --git a/tools/testing/selftests/vm/map_fixed_noreplace.c b/tools/testing/selftests/mm/map_fixed_noreplace.c
similarity index 100%
rename from tools/testing/selftests/vm/map_fixed_noreplace.c
rename to tools/testing/selftests/mm/map_fixed_noreplace.c
diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/mm/map_hugetlb.c
similarity index 100%
rename from tools/testing/selftests/vm/map_hugetlb.c
rename to tools/testing/selftests/mm/map_hugetlb.c
diff --git a/tools/testing/selftests/vm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
similarity index 100%
rename from tools/testing/selftests/vm/map_populate.c
rename to tools/testing/selftests/mm/map_populate.c
diff --git a/tools/testing/selftests/vm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
similarity index 100%
rename from tools/testing/selftests/vm/memfd_secret.c
rename to tools/testing/selftests/mm/memfd_secret.c
diff --git a/tools/testing/selftests/vm/migration.c b/tools/testing/selftests/mm/migration.c
similarity index 100%
rename from tools/testing/selftests/vm/migration.c
rename to tools/testing/selftests/mm/migration.c
diff --git a/tools/testing/selftests/vm/mlock-random-test.c b/tools/testing/selftests/mm/mlock-random-test.c
similarity index 100%
rename from tools/testing/selftests/vm/mlock-random-test.c
rename to tools/testing/selftests/mm/mlock-random-test.c
diff --git a/tools/testing/selftests/vm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
similarity index 100%
rename from tools/testing/selftests/vm/mlock2-tests.c
rename to tools/testing/selftests/mm/mlock2-tests.c
diff --git a/tools/testing/selftests/vm/mlock2.h b/tools/testing/selftests/mm/mlock2.h
similarity index 100%
rename from tools/testing/selftests/vm/mlock2.h
rename to tools/testing/selftests/mm/mlock2.h
diff --git a/tools/testing/selftests/vm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
similarity index 100%
rename from tools/testing/selftests/vm/mrelease_test.c
rename to tools/testing/selftests/mm/mrelease_test.c
diff --git a/tools/testing/selftests/vm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
similarity index 100%
rename from tools/testing/selftests/vm/mremap_dontunmap.c
rename to tools/testing/selftests/mm/mremap_dontunmap.c
diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
similarity index 100%
rename from tools/testing/selftests/vm/mremap_test.c
rename to tools/testing/selftests/mm/mremap_test.c
diff --git a/tools/testing/selftests/vm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
similarity index 100%
rename from tools/testing/selftests/vm/on-fault-limit.c
rename to tools/testing/selftests/mm/on-fault-limit.c
diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
similarity index 100%
rename from tools/testing/selftests/vm/pkey-helpers.h
rename to tools/testing/selftests/mm/pkey-helpers.h
diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
similarity index 100%
rename from tools/testing/selftests/vm/pkey-powerpc.h
rename to tools/testing/selftests/mm/pkey-powerpc.h
diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
similarity index 100%
rename from tools/testing/selftests/vm/pkey-x86.h
rename to tools/testing/selftests/mm/pkey-x86.h
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
similarity index 100%
rename from tools/testing/selftests/vm/protection_keys.c
rename to tools/testing/selftests/mm/protection_keys.c
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
similarity index 100%
rename from tools/testing/selftests/vm/run_vmtests.sh
rename to tools/testing/selftests/mm/run_vmtests.sh
diff --git a/tools/testing/selftests/vm/settings b/tools/testing/selftests/mm/settings
similarity index 100%
rename from tools/testing/selftests/vm/settings
rename to tools/testing/selftests/mm/settings
diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
similarity index 100%
rename from tools/testing/selftests/vm/soft-dirty.c
rename to tools/testing/selftests/mm/soft-dirty.c
diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
similarity index 100%
rename from tools/testing/selftests/vm/split_huge_page_test.c
rename to tools/testing/selftests/mm/split_huge_page_test.c
diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/mm/test_hmm.sh
similarity index 100%
rename from tools/testing/selftests/vm/test_hmm.sh
rename to tools/testing/selftests/mm/test_hmm.sh
diff --git a/tools/testing/selftests/vm/test_vmalloc.sh b/tools/testing/selftests/mm/test_vmalloc.sh
similarity index 100%
rename from tools/testing/selftests/vm/test_vmalloc.sh
rename to tools/testing/selftests/mm/test_vmalloc.sh
diff --git a/tools/testing/selftests/vm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
similarity index 100%
rename from tools/testing/selftests/vm/thuge-gen.c
rename to tools/testing/selftests/mm/thuge-gen.c
diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/mm/transhuge-stress.c
similarity index 100%
rename from tools/testing/selftests/vm/transhuge-stress.c
rename to tools/testing/selftests/mm/transhuge-stress.c
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
similarity index 100%
rename from tools/testing/selftests/vm/userfaultfd.c
rename to tools/testing/selftests/mm/userfaultfd.c
diff --git a/tools/testing/selftests/vm/util.h b/tools/testing/selftests/mm/util.h
similarity index 100%
rename from tools/testing/selftests/vm/util.h
rename to tools/testing/selftests/mm/util.h
diff --git a/tools/testing/selftests/vm/va_128TBswitch.c b/tools/testing/selftests/mm/va_128TBswitch.c
similarity index 100%
rename from tools/testing/selftests/vm/va_128TBswitch.c
rename to tools/testing/selftests/mm/va_128TBswitch.c
diff --git a/tools/testing/selftests/vm/va_128TBswitch.sh b/tools/testing/selftests/mm/va_128TBswitch.sh
similarity index 100%
rename from tools/testing/selftests/vm/va_128TBswitch.sh
rename to tools/testing/selftests/mm/va_128TBswitch.sh
diff --git a/tools/testing/selftests/vm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
similarity index 100%
rename from tools/testing/selftests/vm/virtual_address_range.c
rename to tools/testing/selftests/mm/virtual_address_range.c
diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
similarity index 100%
rename from tools/testing/selftests/vm/vm_util.c
rename to tools/testing/selftests/mm/vm_util.c
diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
similarity index 100%
rename from tools/testing/selftests/vm/vm_util.h
rename to tools/testing/selftests/mm/vm_util.h
diff --git a/tools/testing/selftests/vm/write_hugetlb_memory.sh b/tools/testing/selftests/mm/write_hugetlb_memory.sh
similarity index 100%
rename from tools/testing/selftests/vm/write_hugetlb_memory.sh
rename to tools/testing/selftests/mm/write_hugetlb_memory.sh
diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/testing/selftests/mm/write_to_hugetlbfs.c
similarity index 100%
rename from tools/testing/selftests/vm/write_to_hugetlbfs.c
rename to tools/testing/selftests/mm/write_to_hugetlbfs.c
-- 
2.25.1

