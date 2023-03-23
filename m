Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F10F6C65C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjCWKxy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjCWKxb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:53:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A340F30CB;
        Thu, 23 Mar 2023 03:52:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E85ECAD7;
        Thu, 23 Mar 2023 03:53:42 -0700 (PDT)
Received: from a077209.blr.arm.com (a077209.arm.com [10.162.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6323E3F766;
        Thu, 23 Mar 2023 03:52:56 -0700 (PDT)
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/5] selftests/mm: Add support for arm64 platform on va switch
Date:   Thu, 23 Mar 2023 16:22:39 +0530
Message-Id: <20230323105243.2807166-2-chaitanyas.prakash@arm.com>
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

Arm64 platforms have the ability to support 64kb pagesize, 512MB default
hugepage size and up to 4PB of virtual address space. The address switch
occurs at 256TB as opposed to 128TB. Hence, the necessary support has
been added.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org 
Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/testing/selftests/mm/va_128TBswitch.c | 26 +++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/va_128TBswitch.c b/tools/testing/selftests/mm/va_128TBswitch.c
index 1d2068989883..6679213effed 100644
--- a/tools/testing/selftests/mm/va_128TBswitch.c
+++ b/tools/testing/selftests/mm/va_128TBswitch.c
@@ -17,6 +17,13 @@
  * This will work with 16M and 2M hugepage size
  */
 #define HUGETLB_SIZE	(16 << 20)
+#elif __aarch64__
+/*
+ * The default hugepage size for 64k base pagesize
+ * is 512MB.
+ */
+#define PAGE_SIZE	(64 << 10)
+#define HUGETLB_SIZE	(512 << 20)
 #else
 #define PAGE_SIZE	(4 << 10)
 #define HUGETLB_SIZE	(2 << 20)
@@ -26,9 +33,22 @@
  * >= 128TB is the hint addr value we used to select
  * large address space.
  */
-#define ADDR_SWITCH_HINT (1UL << 47)
+
+#define ADDR_MARK_128TB	(1UL << 47)
+#define ADDR_MARK_256TB	(1UL << 48)
+
+#define HIGH_ADDR_128TB	((void *) (1UL << 48))
+#define HIGH_ADDR_256TB	((void *) (1UL << 49))
+
 #define LOW_ADDR	((void *) (1UL << 30))
-#define HIGH_ADDR	((void *) (1UL << 48))
+
+#ifdef __aarch64__
+#define ADDR_SWITCH_HINT ADDR_MARK_256TB
+#define HIGH_ADDR	 HIGH_ADDR_256TB
+#else
+#define ADDR_SWITCH_HINT ADDR_MARK_128TB
+#define HIGH_ADDR	 HIGH_ADDR_128TB
+#endif
 
 struct testcase {
 	void *addr;
@@ -270,6 +290,8 @@ static int supported_arch(void)
 	return 1;
 #elif defined(__x86_64__)
 	return 1;
+#elif defined(__aarch64__)
+	return 1;
 #else
 	return 0;
 #endif
-- 
2.30.2

