Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698426C65C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjCWKx6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjCWKxe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:53:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 547EF59D0;
        Thu, 23 Mar 2023 03:53:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E6C1570;
        Thu, 23 Mar 2023 03:53:46 -0700 (PDT)
Received: from a077209.blr.arm.com (a077209.arm.com [10.162.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7776A3F766;
        Thu, 23 Mar 2023 03:52:59 -0700 (PDT)
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/5] selftests/mm: Rename va_128TBswitch to va_high_addr_switch
Date:   Thu, 23 Mar 2023 16:22:40 +0530
Message-Id: <20230323105243.2807166-3-chaitanyas.prakash@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
References: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As the initial selftest only took into consideration PowperPC and x86
architectures, on adding support for arm64, a platform independent
naming convention is chosen.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org 
Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/testing/selftests/mm/Makefile                           | 4 ++--
 tools/testing/selftests/mm/run_vmtests.sh                     | 2 +-
 .../selftests/mm/{va_128TBswitch.c => va_high_addr_switch.c}  | 0
 .../mm/{va_128TBswitch.sh => va_high_addr_switch.sh}          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/mm/{va_128TBswitch.c => va_high_addr_switch.c} (100%)
 rename tools/testing/selftests/mm/{va_128TBswitch.sh => va_high_addr_switch.sh} (98%)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index c31d952cff68..1246552d4b86 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -91,7 +91,7 @@ endif
 endif
 
 ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
-TEST_GEN_FILES += va_128TBswitch
+TEST_GEN_FILES += va_high_addr_switch
 TEST_GEN_FILES += virtual_address_range
 TEST_GEN_FILES += write_to_hugetlbfs
 endif
@@ -100,7 +100,7 @@ TEST_PROGS := run_vmtests.sh
 
 TEST_FILES := test_vmalloc.sh
 TEST_FILES += test_hmm.sh
-TEST_FILES += va_128TBswitch.sh
+TEST_FILES += va_high_addr_switch.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 8984e0bb58c7..eb9823a6959a 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -223,7 +223,7 @@ if [ $VADDR64 -ne 0 ]; then
 	CATEGORY="hugevm" run_test ./virtual_address_range
 
 	# virtual address 128TB switch test
-	CATEGORY="hugevm" run_test ./va_128TBswitch.sh
+	CATEGORY="hugevm" run_test ./va_high_addr_switch.sh
 fi # VADDR64
 
 # vmalloc stability smoke test
diff --git a/tools/testing/selftests/mm/va_128TBswitch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
similarity index 100%
rename from tools/testing/selftests/mm/va_128TBswitch.c
rename to tools/testing/selftests/mm/va_high_addr_switch.c
diff --git a/tools/testing/selftests/mm/va_128TBswitch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
similarity index 98%
rename from tools/testing/selftests/mm/va_128TBswitch.sh
rename to tools/testing/selftests/mm/va_high_addr_switch.sh
index 41580751dc51..3056788a27ac 100644
--- a/tools/testing/selftests/mm/va_128TBswitch.sh
+++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
@@ -51,4 +51,4 @@ check_test_requirements()
 }
 
 check_test_requirements
-./va_128TBswitch
+./va_high_addr_switch
-- 
2.30.2

