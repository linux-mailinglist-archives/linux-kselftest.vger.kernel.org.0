Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2B52219D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242155AbiEJQtu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347645AbiEJQts (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:49:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22946275FF
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:45:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC330B81DF7
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 16:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBEBC385CC;
        Tue, 10 May 2022 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652201146;
        bh=JdUSFlmAMJMiTXobkuC/AlKO+jPpDo6M4+rYKVDk2Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPzTYr+WVV2y1oJqvW80ygBmKoAop6d3D2u/BkYnLL7PHUScWDMhVMJnQXsHu1dv5
         TDBA9gJZvbdadKemkhDUYxy+FgwcUHQeAZE7tqxoR3VRaKzys9mao8NHuWwMhhev2D
         TCOvMMnDD2rC3YeUBAJPdvW+4DNR8jNXsQx578T7DqZkQh8t4uayoGfw4nuZUN0xyN
         xhhWu45mVGOHGQZP7NS1+CUvwEDI3Hlt0otl5xhbqvCJnbSoZ26psgRaJXBaVIWDJP
         DYb8WknGNhCc6STvWOar7+krJsyh9qohfsPSb8sr01oOw2EOlDDZpU63YDkYeBZUKO
         2IV+JJnOsIeJg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/5] selftests/arm64: Remove casts to/from void in check_tags_inclusion
Date:   Tue, 10 May 2022 17:45:19 +0100
Message-Id: <20220510164520.768783-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510164520.768783-1-broonie@kernel.org>
References: <20220510164520.768783-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5393; h=from:subject; bh=JdUSFlmAMJMiTXobkuC/AlKO+jPpDo6M4+rYKVDk2Yo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiepaeCzI2vR3Tz8922+7B6ZA0MGW9qigOMqDYzLf5 4AmiuZaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYnqWngAKCRAk1otyXVSH0MmJB/ sHjyiHXljNYCoYvAftRh5NlOi+l8olqXD8uTq7m9TZTov3ZK9GyjXKBRIgVMjfjtkXeo77MxnmpSnK F/LDG5dqUdE3ZkOiUMCp0PYreuPJZVJ8jxNdnIeoL4CzBDYbclwmceoVKbDEl9ceg3SuisFbp++Ulk 5goWIEhCptytI282QOEbhWkUTXeCnsv7I5KsjHZ6xDehrASdpMQLMu25CMRvsn0oxQKhxXI08WbXTV qJF235n486Ax0ShYHb9in36+Ut2wjqHh9qiJGFRg/elf+7MxiHP0/K2YspLBsYARa6rzU5papwY067 qNUQXCJajEtDTBLPm1bseDyQ7ryz3x
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Void pointers may be freely used with other pointer types in C, any casts
between void * and other pointer types serve no purpose other than to
mask potential warnings. Drop such casts from check_tags_inclusion to
help with future review of the code.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/mte/check_tags_inclusion.c          | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
index d180ba3df990..2b1425b92b69 100644
--- a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
+++ b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
@@ -23,7 +23,7 @@ static int verify_mte_pointer_validity(char *ptr, int mode)
 {
 	mte_initialize_current_context(mode, (uintptr_t)ptr, BUFFER_SIZE);
 	/* Check the validity of the tagged pointer */
-	memset((void *)ptr, '1', BUFFER_SIZE);
+	memset(ptr, '1', BUFFER_SIZE);
 	mte_wait_after_trig();
 	if (cur_mte_cxt.fault_valid) {
 		ksft_print_msg("Unexpected fault recorded for %p-%p in mode %x\n",
@@ -51,7 +51,7 @@ static int check_single_included_tags(int mem_type, int mode)
 	char *ptr;
 	int tag, run, ret, result = KSFT_PASS;
 
-	ptr = (char *)mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
+	ptr = mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
 	if (check_allocated_memory(ptr, BUFFER_SIZE + MT_GRANULE_SIZE,
 				   mem_type, false) != KSFT_PASS)
 		return KSFT_FAIL;
@@ -62,7 +62,7 @@ static int check_single_included_tags(int mem_type, int mode)
 			result = KSFT_FAIL;
 		/* Try to catch a excluded tag by a number of tries. */
 		for (run = 0; (run < RUNS) && (result == KSFT_PASS); run++) {
-			ptr = (char *)mte_insert_tags(ptr, BUFFER_SIZE);
+			ptr = mte_insert_tags(ptr, BUFFER_SIZE);
 			/* Check tag value */
 			if (MT_FETCH_TAG((uintptr_t)ptr) == tag) {
 				ksft_print_msg("FAIL: wrong tag = 0x%x with include mask=0x%x\n",
@@ -74,7 +74,7 @@ static int check_single_included_tags(int mem_type, int mode)
 			result = verify_mte_pointer_validity(ptr, mode);
 		}
 	}
-	mte_free_memory_tag_range((void *)ptr, BUFFER_SIZE, mem_type, 0, MT_GRANULE_SIZE);
+	mte_free_memory_tag_range(ptr, BUFFER_SIZE, mem_type, 0, MT_GRANULE_SIZE);
 	return result;
 }
 
@@ -84,7 +84,7 @@ static int check_multiple_included_tags(int mem_type, int mode)
 	int tag, run, result = KSFT_PASS;
 	unsigned long excl_mask = 0;
 
-	ptr = (char *)mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
+	ptr = mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
 	if (check_allocated_memory(ptr, BUFFER_SIZE + MT_GRANULE_SIZE,
 				   mem_type, false) != KSFT_PASS)
 		return KSFT_FAIL;
@@ -94,7 +94,7 @@ static int check_multiple_included_tags(int mem_type, int mode)
 		mte_switch_mode(mode, MT_INCLUDE_VALID_TAGS(excl_mask));
 		/* Try to catch a excluded tag by a number of tries. */
 		for (run = 0; (run < RUNS) && (result == KSFT_PASS); run++) {
-			ptr = (char *)mte_insert_tags(ptr, BUFFER_SIZE);
+			ptr = mte_insert_tags(ptr, BUFFER_SIZE);
 			/* Check tag value */
 			if (MT_FETCH_TAG((uintptr_t)ptr) < tag) {
 				ksft_print_msg("FAIL: wrong tag = 0x%x with include mask=0x%x\n",
@@ -106,7 +106,7 @@ static int check_multiple_included_tags(int mem_type, int mode)
 			result = verify_mte_pointer_validity(ptr, mode);
 		}
 	}
-	mte_free_memory_tag_range((void *)ptr, BUFFER_SIZE, mem_type, 0, MT_GRANULE_SIZE);
+	mte_free_memory_tag_range(ptr, BUFFER_SIZE, mem_type, 0, MT_GRANULE_SIZE);
 	return result;
 }
 
@@ -115,7 +115,7 @@ static int check_all_included_tags(int mem_type, int mode)
 	char *ptr;
 	int run, ret, result = KSFT_PASS;
 
-	ptr = (char *)mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
+	ptr = mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
 	if (check_allocated_memory(ptr, BUFFER_SIZE + MT_GRANULE_SIZE,
 				   mem_type, false) != KSFT_PASS)
 		return KSFT_FAIL;
@@ -132,7 +132,7 @@ static int check_all_included_tags(int mem_type, int mode)
 		 */
 		result = verify_mte_pointer_validity(ptr, mode);
 	}
-	mte_free_memory_tag_range((void *)ptr, BUFFER_SIZE, mem_type, 0, MT_GRANULE_SIZE);
+	mte_free_memory_tag_range(ptr, BUFFER_SIZE, mem_type, 0, MT_GRANULE_SIZE);
 	return result;
 }
 
@@ -141,7 +141,7 @@ static int check_none_included_tags(int mem_type, int mode)
 	char *ptr;
 	int run, ret;
 
-	ptr = (char *)mte_allocate_memory(BUFFER_SIZE, mem_type, 0, false);
+	ptr = mte_allocate_memory(BUFFER_SIZE, mem_type, 0, false);
 	if (check_allocated_memory(ptr, BUFFER_SIZE, mem_type, false) != KSFT_PASS)
 		return KSFT_FAIL;
 
@@ -159,12 +159,12 @@ static int check_none_included_tags(int mem_type, int mode)
 		}
 		mte_initialize_current_context(mode, (uintptr_t)ptr, BUFFER_SIZE);
 		/* Check the write validity of the untagged pointer */
-		memset((void *)ptr, '1', BUFFER_SIZE);
+		memset(ptr, '1', BUFFER_SIZE);
 		mte_wait_after_trig();
 		if (cur_mte_cxt.fault_valid)
 			break;
 	}
-	mte_free_memory((void *)ptr, BUFFER_SIZE, mem_type, false);
+	mte_free_memory(ptr, BUFFER_SIZE, mem_type, false);
 	if (cur_mte_cxt.fault_valid)
 		return KSFT_FAIL;
 	else
-- 
2.30.2

