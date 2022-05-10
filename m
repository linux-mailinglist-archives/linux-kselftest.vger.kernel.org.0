Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16852219F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiEJQtw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347637AbiEJQtu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:49:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD624831B
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19E1AB81E21
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 16:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DA0C385CD;
        Tue, 10 May 2022 16:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652201148;
        bh=R622QNQB1UYRuVab/g4J3gyNgxnjsl8J4yUUXh33U/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7CYpwXS3jfS0d7gemUqeyuF8U3fNPphpvuReMYYWUO0I2sGrq9XbWMV5cQF6Dj1E
         PN7dU6Er9D4FCN32zqQaMNUEEv33rZ3kLtIHCdy3BMDjBeiOVsXCOx92vARvdreSye
         JYwRJVy6Tt4gCz8b0InsW7/K17nHsU4D07Xi+1Qi0kGEL0poSh6PbJxHNNxM8pay80
         3Zo2BylLcmHmtw03FBwMf+wetaO1POs8sfNKzJRQJPmGSWyL6M8LX4FYtIbPRzsvYq
         vSSdBpjWq4ZDbq4NwM+ifXTF1txUNvfTwz2oIBrUHNTAw2PDV0nf7VwNdqyfjQPsZs
         WpCbw3MY7iUUw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 5/5] selftests/arm64: Use switch statements in mte_common_util.c
Date:   Tue, 10 May 2022 17:45:20 +0100
Message-Id: <20220510164520.768783-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510164520.768783-1-broonie@kernel.org>
References: <20220510164520.768783-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; h=from:subject; bh=R622QNQB1UYRuVab/g4J3gyNgxnjsl8J4yUUXh33U/4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiepaflTvsXvbJC2100hDgI34fuA/jH3a/HV8aCd5v odizu02JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYnqWnwAKCRAk1otyXVSH0OIOB/ 4yTHQ+colx7wXK5q6ceUvpKz1T4+RTtShuDdu01immHnc+jgu9pQBPM/QqzvyST4sKQ018VU1xNw3P 8SXJnvS9d7SNz7FQF2MCmE50IGXoQGXY7A4BPp+GjJYnSc1qCzcr9gYif0aUZ88U8G3Uh1MorumUN4 CWupBedZyfC/SpR45J1aCKJJLL2j1D6mrthSMKvjxF11qi7lLoPIaQms13mov2ISXdh1ICJGUAGhrT eZgjlJZ4H/5zjM4nUXaz8/aNjfmityeLBQQoRnG5BLV7UzydElFd/F01V7rHQmVReZMuQ6L1UAhvrC TffbYIzCKF3UjICmBT79IxpFPW3vJg
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

In the MTE tests there are several places where we use chains of if
statements to open code what could be written as switch statements, move
over to switch statements to make the idiom clearer.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/mte/mte_common_util.c     | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 6ff4c4bcbff1..00ffd34c66d3 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -128,13 +128,16 @@ static void *__mte_allocate_memory_range(size_t size, int mem_type, int mapping,
 	int prot_flag, map_flag;
 	size_t entire_size = size + range_before + range_after;
 
-	if (mem_type != USE_MALLOC && mem_type != USE_MMAP &&
-	    mem_type != USE_MPROTECT) {
+	switch (mem_type) {
+	case USE_MALLOC:
+		return malloc(entire_size) + range_before;
+	case USE_MMAP:
+	case USE_MPROTECT:
+		break;
+	default:
 		ksft_print_msg("FAIL: Invalid allocate request\n");
 		return NULL;
 	}
-	if (mem_type == USE_MALLOC)
-		return malloc(entire_size) + range_before;
 
 	prot_flag = PROT_READ | PROT_WRITE;
 	if (mem_type == USE_MMAP)
@@ -287,13 +290,19 @@ int mte_switch_mode(int mte_option, unsigned long incl_mask)
 		ksft_print_msg("FAIL: Invalid incl_mask %lx\n", incl_mask);
 		return -EINVAL;
 	}
+
 	en = PR_TAGGED_ADDR_ENABLE;
-	if (mte_option == MTE_SYNC_ERR)
+	switch (mte_option) {
+	case MTE_SYNC_ERR:
 		en |= PR_MTE_TCF_SYNC;
-	else if (mte_option == MTE_ASYNC_ERR)
+		break;
+	case MTE_ASYNC_ERR:
 		en |= PR_MTE_TCF_ASYNC;
-	else if (mte_option == MTE_NONE_ERR)
+		break;
+	case MTE_NONE_ERR:
 		en |= PR_MTE_TCF_NONE;
+		break;
+	}
 
 	en |= (incl_mask << PR_MTE_TAG_SHIFT);
 	/* Enable address tagging ABI, mte error reporting mode and tag inclusion mask. */
-- 
2.30.2

