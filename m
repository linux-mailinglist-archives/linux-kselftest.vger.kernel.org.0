Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D34B6B898C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 05:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCNEYQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 00:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCNEYN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 00:24:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A77418B1A;
        Mon, 13 Mar 2023 21:24:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5F7E4B3;
        Mon, 13 Mar 2023 21:24:54 -0700 (PDT)
Received: from a077209.blr.arm.com (a077209.arm.com [10.162.42.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 032E73F71A;
        Mon, 13 Mar 2023 21:24:07 -0700 (PDT)
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/3] selftests: Change NR_CHUNKS_HIGH for aarch64
Date:   Tue, 14 Mar 2023 09:53:50 +0530
Message-Id: <20230314042351.13134-3-chaitanyas.prakash@arm.com>
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

Although there is a provision for 52 bit VA on arm64 platform, it remains
unutilised and higher addresses are not allocated. In order to accommodate
4PB [2^52] virtual address space where supported, NR_CHUNKS_HIGH is changed
accordingly.

Array holding addresses is changed from static allocation to dynamic
allocation to accommodate its voluminous nature which otherwise might
overflow the stack.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 50564512c5ee..bae0ceaf95b1 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -36,13 +36,15 @@
  * till it reaches 512TB. One with size 128TB and the
  * other being 384TB.
  *
- * On Arm64 the address space is 256TB and no high mappings
- * are supported so far.
+ * On Arm64 the address space is 256TB and support for
+ * high mappings up to 4PB virtual address space has
+ * been added.
  */
 
 #define NR_CHUNKS_128TB   ((128 * SZ_1TB) / MAP_CHUNK_SIZE) /* Number of chunks for 128TB */
 #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
 #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
+#define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
 
 #define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
 #define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
@@ -51,7 +53,7 @@
 #define HIGH_ADDR_MARK  ADDR_MARK_256TB
 #define HIGH_ADDR_SHIFT 49
 #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
-#define NR_CHUNKS_HIGH  0
+#define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
 #else
 #define HIGH_ADDR_MARK  ADDR_MARK_128TB
 #define HIGH_ADDR_SHIFT 48
@@ -101,7 +103,7 @@ static int validate_lower_address_hint(void)
 int main(int argc, char *argv[])
 {
 	char *ptr[NR_CHUNKS_LOW];
-	char *hptr[NR_CHUNKS_HIGH];
+	char **hptr;
 	char *hint;
 	unsigned long i, lchunks, hchunks;
 
@@ -119,6 +121,9 @@ int main(int argc, char *argv[])
 			return 1;
 	}
 	lchunks = i;
+	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
+	if (hptr == NULL)
+		return 1;
 
 	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
 		hint = hind_addr();
@@ -139,5 +144,6 @@ int main(int argc, char *argv[])
 	for (i = 0; i < hchunks; i++)
 		munmap(hptr[i], MAP_CHUNK_SIZE);
 
+	free(hptr);
 	return 0;
 }
-- 
2.30.2

