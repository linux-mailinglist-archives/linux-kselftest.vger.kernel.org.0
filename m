Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABD86C65C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCWKyA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCWKxh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:53:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E97630E4;
        Thu, 23 Mar 2023 03:53:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 176A94B3;
        Thu, 23 Mar 2023 03:53:49 -0700 (PDT)
Received: from a077209.blr.arm.com (a077209.arm.com [10.162.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8756B3F766;
        Thu, 23 Mar 2023 03:53:02 -0700 (PDT)
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 3/5] selftests/mm: Add platform independent in code comments
Date:   Thu, 23 Mar 2023 16:22:41 +0530
Message-Id: <20230323105243.2807166-4-chaitanyas.prakash@arm.com>
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

The in code comments for the selftest were made on the basis of 128TB
switch, an architecture feature specific to PowerPc and x86 platforms.
Keeping in mind the support added for arm64 platforms which implements
a 256TB switch, a more generic explanation has been provided.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org 
Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/testing/selftests/mm/va_high_addr_switch.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
index 6679213effed..7cfaf4a74c57 100644
--- a/tools/testing/selftests/mm/va_high_addr_switch.c
+++ b/tools/testing/selftests/mm/va_high_addr_switch.c
@@ -30,8 +30,8 @@
 #endif
 
 /*
- * >= 128TB is the hint addr value we used to select
- * large address space.
+ * The hint addr value is used to allocate addresses
+ * beyond the high address switch boundary.
  */
 
 #define ADDR_MARK_128TB	(1UL << 47)
@@ -73,9 +73,10 @@ static struct testcase testcases[] = {
 	},
 	{
 		/*
-		 * We should never allocate at the requested address or above it
-		 * The len cross the 128TB boundary. Without MAP_FIXED
-		 * we will always search in the lower address space.
+		 * Unless MAP_FIXED is specified, allocation based on hint
+		 * addr is never at requested address or above it, which is
+		 * beyond high address switch boundary in this case. Instead,
+		 * a suitable allocation is found in lower address space.
 		 */
 		.addr = ((void *)(ADDR_SWITCH_HINT - PAGE_SIZE)),
 		.size = 2 * PAGE_SIZE,
@@ -85,8 +86,8 @@ static struct testcase testcases[] = {
 	},
 	{
 		/*
-		 * Exact mapping at 128TB, the area is free we should get that
-		 * even without MAP_FIXED.
+		 * Exact mapping at high address switch boundary, should
+		 * be obtained even without MAP_FIXED as area is free.
 		 */
 		.addr = ((void *)(ADDR_SWITCH_HINT)),
 		.size = PAGE_SIZE,
-- 
2.30.2

