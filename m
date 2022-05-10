Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1481552219B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347599AbiEJQtt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347634AbiEJQtm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:49:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBF025EB
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D80E0B81E21
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 16:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF950C385C2;
        Tue, 10 May 2022 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652201140;
        bh=bBHuZB3zULNvaFpsWT5fr9FYDtOLi0zeAPokTzmjfqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q0kH0KjY7YmTJqcLEqtzoV6mQ7/6HsHcrGuQ0cFFhrPh4lWuvdJADQP/JM1XuBH3B
         aefboBw3QNsZSUcYLdImZhDjWMxZg3mA2YoSYLLUQCDHyiLa/JGtvKQI/7KTfWhIFA
         a2An9p1L+a1AH/V6E7j9w8tnTgIaHs52kgbhCSJik97U5OoSRyOwuAbWEiwhyzkJ96
         ADt5I1b+hX/FMDJnSU/FT282UnS/wmVyhBR1sO3yt4SPgiL8hdYdqhFlM9dpZe3UML
         bxpS6RwOQoROr7jhBKNRsW8YNpZVvjxxEq01AgCxlpwmmpOA4ThrxR7O9yS9qHcTfc
         1BIMjEvOn9uOg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/5] selftests/arm64: Log errors in verify_mte_pointer_validity()
Date:   Tue, 10 May 2022 17:45:16 +0100
Message-Id: <20220510164520.768783-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510164520.768783-1-broonie@kernel.org>
References: <20220510164520.768783-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; h=from:subject; bh=bBHuZB3zULNvaFpsWT5fr9FYDtOLi0zeAPokTzmjfqA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiepac0Qgac1/NPxTWgAvIWHQ7dB/Ha+LUV0+zx+lD hB9kdGGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYnqWnAAKCRAk1otyXVSH0HqvB/ 9r00srnCW5vRnGS7RGk9uO6oewU+8+jGFd3VY+5pUq/uW6fjtW/meoNm2InIiWmW6dVxjnYMktXPo7 hv28YH+RxRVtkrG2cS4YYHKHkh9nD77sN3IvkQVLl2bqUMPVFqyzrqSMnXd08dZmJsinvhHZ8UHX3I Pndjzlp5sz6ltQT6lszV8iIxQaVSOnf6VE0ZWvWrhwMW3wsrpycb08O9His9QUmq+4vs4o9BSKIwUs 5hwDgxKEHssNyRteQQdykimeLF/96XmAfv7G8qrH4wTphvVgLyWz6Zqy1AWr/8Ef+4DJE/rUMzltpZ o0Vu1ITbiyQgaocMVEOG48V4pZ42m/
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

When we detect a problem in verify_mte_pointer_validity() while checking
tags we don't log what the problem was which makes debugging harder. Add
some diagnostics.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/mte/check_tags_inclusion.c       | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
index deaef1f61076..b906914997ce 100644
--- a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
+++ b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
@@ -25,8 +25,11 @@ static int verify_mte_pointer_validity(char *ptr, int mode)
 	/* Check the validity of the tagged pointer */
 	memset((void *)ptr, '1', BUFFER_SIZE);
 	mte_wait_after_trig();
-	if (cur_mte_cxt.fault_valid)
+	if (cur_mte_cxt.fault_valid) {
+		ksft_print_msg("Unexpected fault recorded for %p-%p in mode %x\n",
+			       ptr, ptr + BUFFER_SIZE, mode);
 		return KSFT_FAIL;
+	}
 	/* Proceed further for nonzero tags */
 	if (!MT_FETCH_TAG((uintptr_t)ptr))
 		return KSFT_PASS;
@@ -34,10 +37,13 @@ static int verify_mte_pointer_validity(char *ptr, int mode)
 	/* Check the validity outside the range */
 	ptr[BUFFER_SIZE] = '2';
 	mte_wait_after_trig();
-	if (!cur_mte_cxt.fault_valid)
+	if (!cur_mte_cxt.fault_valid) {
+		ksft_print_msg("No valid fault recorded for %p in mode %x\n",
+			       ptr, mode);
 		return KSFT_FAIL;
-	else
+	} else {
 		return KSFT_PASS;
+	}
 }
 
 static int check_single_included_tags(int mem_type, int mode)
-- 
2.30.2

