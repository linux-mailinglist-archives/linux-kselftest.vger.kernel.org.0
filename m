Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D10C52219E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347636AbiEJQtv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiEJQtr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:49:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FF71CFF2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00FAFB81DA5
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 16:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F87C385C2;
        Tue, 10 May 2022 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652201144;
        bh=0cKVUWis1xhOjJJFymdC0c8pQI3TwhTLrNfwGP0ncPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UocCC2nU0PdRxUuAvT6yNqsEVksAAEv4xrdq2mppRbBz+i8sn/aX8nlzyI9dt93gh
         /i0RbSFrfN58yBCtjxfXPkhOJLJpz++GibfJ1de+z5eWAhpXVVyN4qBxfZ5yscGtnC
         DUz/BhFkMFOPoAo8cInnBwOO3BKxfPslSJ2b55SvavDctRphAh80qfA31qlKJw+D61
         JFXQmk8l6qaFyHMn3zT6EEmp1g49nyHDVBb1qh5vnjhgiyFOF2knyNqjafxmGTGxq3
         ZsU/4MXJoCzEWWJskl6rAPw2nzteDNWvjLCACKa3QBEZUF6tO3tXgd9M+Nnl2q4jlK
         nE8ZIoL+eMitQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/5] selftests/arm64: Check failures to set tags in check_tags_inclusion
Date:   Tue, 10 May 2022 17:45:18 +0100
Message-Id: <20220510164520.768783-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510164520.768783-1-broonie@kernel.org>
References: <20220510164520.768783-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3100; h=from:subject; bh=0cKVUWis1xhOjJJFymdC0c8pQI3TwhTLrNfwGP0ncPY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiepadwcjCghw03u2C4QRkkECWrCYPmnlFG2cD9N9q Ff1j56+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYnqWnQAKCRAk1otyXVSH0JzvCA CF//KO+GghYYk75IIFjElDQUSOjNqaeluflcV2C0mLiL0D77v06fjAXe4Wgu9lTvNXsIXQ8G9X5vPr uXJ4rqxBGPsMVKWSwVFSdq61/3iPB+o0HWEY+/kmvq/+mjk/2tTN4kGOtAR9mdmxjIGCyq8FPmWaxp 1VAhXnDqLBPMb/XMqZGrXYSbOlL5jCd36vDHDm1Qrvyf3E51psieYP0MO29ZudKKbOgsOleTJ+J2F3 DGMbrItfzsPpVTOWW2shWWE0u/E+it3wDrUZ7Qe7GzTPHp7/mcN/7AQ7a2totTAfPWukoJZfPxG+ml yz1tE64iWPTJ4lunVl2rz+GsnlyaFd
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

The MTE check_tags_inclusion test uses the mte_switch_mode() helper but
ignores the return values it generates meaning we might not be testing
the things we're trying to test, fail the test if it reports an error.
The helper will log any errors it returns.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/mte/check_tags_inclusion.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
index b906914997ce..d180ba3df990 100644
--- a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
+++ b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
@@ -49,7 +49,7 @@ static int verify_mte_pointer_validity(char *ptr, int mode)
 static int check_single_included_tags(int mem_type, int mode)
 {
 	char *ptr;
-	int tag, run, result = KSFT_PASS;
+	int tag, run, ret, result = KSFT_PASS;
 
 	ptr = (char *)mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
 	if (check_allocated_memory(ptr, BUFFER_SIZE + MT_GRANULE_SIZE,
@@ -57,7 +57,9 @@ static int check_single_included_tags(int mem_type, int mode)
 		return KSFT_FAIL;
 
 	for (tag = 0; (tag < MT_TAG_COUNT) && (result == KSFT_PASS); tag++) {
-		mte_switch_mode(mode, MT_INCLUDE_VALID_TAG(tag));
+		ret = mte_switch_mode(mode, MT_INCLUDE_VALID_TAG(tag));
+		if (ret != 0)
+			result = KSFT_FAIL;
 		/* Try to catch a excluded tag by a number of tries. */
 		for (run = 0; (run < RUNS) && (result == KSFT_PASS); run++) {
 			ptr = (char *)mte_insert_tags(ptr, BUFFER_SIZE);
@@ -111,14 +113,16 @@ static int check_multiple_included_tags(int mem_type, int mode)
 static int check_all_included_tags(int mem_type, int mode)
 {
 	char *ptr;
-	int run, result = KSFT_PASS;
+	int run, ret, result = KSFT_PASS;
 
 	ptr = (char *)mte_allocate_memory(BUFFER_SIZE + MT_GRANULE_SIZE, mem_type, 0, false);
 	if (check_allocated_memory(ptr, BUFFER_SIZE + MT_GRANULE_SIZE,
 				   mem_type, false) != KSFT_PASS)
 		return KSFT_FAIL;
 
-	mte_switch_mode(mode, MT_INCLUDE_TAG_MASK);
+	ret = mte_switch_mode(mode, MT_INCLUDE_TAG_MASK);
+	if (ret != 0)
+		return KSFT_FAIL;
 	/* Try to catch a excluded tag by a number of tries. */
 	for (run = 0; (run < RUNS) && (result == KSFT_PASS); run++) {
 		ptr = (char *)mte_insert_tags(ptr, BUFFER_SIZE);
@@ -135,13 +139,15 @@ static int check_all_included_tags(int mem_type, int mode)
 static int check_none_included_tags(int mem_type, int mode)
 {
 	char *ptr;
-	int run;
+	int run, ret;
 
 	ptr = (char *)mte_allocate_memory(BUFFER_SIZE, mem_type, 0, false);
 	if (check_allocated_memory(ptr, BUFFER_SIZE, mem_type, false) != KSFT_PASS)
 		return KSFT_FAIL;
 
-	mte_switch_mode(mode, MT_EXCLUDE_TAG_MASK);
+	ret = mte_switch_mode(mode, MT_EXCLUDE_TAG_MASK);
+	if (ret != 0)
+		return KSFT_FAIL;
 	/* Try to catch a excluded tag by a number of tries. */
 	for (run = 0; run < RUNS; run++) {
 		ptr = (char *)mte_insert_tags(ptr, BUFFER_SIZE);
-- 
2.30.2

