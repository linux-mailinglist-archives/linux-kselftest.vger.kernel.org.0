Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4A26B898B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 05:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCNEYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 00:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCNEYI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 00:24:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8444D1E5C8;
        Mon, 13 Mar 2023 21:24:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7A751063;
        Mon, 13 Mar 2023 21:24:50 -0700 (PDT)
Received: from a077209.blr.arm.com (a077209.arm.com [10.162.42.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC0BF3F71A;
        Mon, 13 Mar 2023 21:24:04 -0700 (PDT)
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/3] selftests: Change MAP_CHUNK_SIZE
Date:   Tue, 14 Mar 2023 09:53:49 +0530
Message-Id: <20230314042351.13134-2-chaitanyas.prakash@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314042351.13134-1-chaitanyas.prakash@arm.com>
References: <20230314042351.13134-1-chaitanyas.prakash@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

mmap() fails to allocate 16GB virtual space chunk, skipping both low and
high VA range iterations. Hence, reduce MAP_CHUNK_SIZE to 1GB and update
relevant macros as required.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index c0592646ed93..50564512c5ee 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -15,11 +15,15 @@
 
 /*
  * Maximum address range mapped with a single mmap()
- * call is little bit more than 16GB. Hence 16GB is
+ * call is little bit more than 1GB. Hence 1GB is
  * chosen as the single chunk size for address space
  * mapping.
  */
-#define MAP_CHUNK_SIZE   17179869184UL /* 16GB */
+
+#define SZ_1GB	(1024 * 1024 * 1024UL)
+#define SZ_1TB	(1024 * 1024 * 1024 * 1024UL)
+
+#define MAP_CHUNK_SIZE	SZ_1GB
 
 /*
  * Address space till 128TB is mapped without any hint
@@ -36,7 +40,7 @@
  * are supported so far.
  */
 
-#define NR_CHUNKS_128TB   8192UL /* Number of 16GB chunks for 128TB */
+#define NR_CHUNKS_128TB   ((128 * SZ_1TB) / MAP_CHUNK_SIZE) /* Number of chunks for 128TB */
 #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
 #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
 
-- 
2.30.2

