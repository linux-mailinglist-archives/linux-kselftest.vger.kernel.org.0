Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB794D629F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 14:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348989AbiCKNxR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 08:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348974AbiCKNxP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 08:53:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ADB1C57CB
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 05:52:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AA3761E8C
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 13:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6519C36AE5;
        Fri, 11 Mar 2022 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647006725;
        bh=34rEfnqbjHz3xCdTv2DILwIPZbwZa5CKK5iLFEGhXK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2hk9tdIESLa9AZHLELfrLv9ATrCaW2qFph/9lir0wazDRL+YLrP06OY8xV5+1Nzr
         aNZ2/+vZRjmCPRBkQnpRhH7XZc5z1y+3T8ZvSO2dKWQ3+BiXLlUqyxeEVlJK97Pa5c
         /bC3lE0K8pmlhrtwO1btivRyindDgDcCVUYkgUl6tA1rpv/y71diPpDlAJvbPrimBP
         OxKtkKbC6YRf6bSoMwqeJuIMIrsrhYT8B41NNuuWNxhI8Q56GtFTBPS4Lf42QP+Yxl
         Rnw8hN8dzzr9Mn89tRuGxbqNhxidggURQg1878JBWCFh4xHVD4wgIrhMPTUC55HTQB
         WX7riggLgwjIg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 3/4] kselftest/arm64: Refactor parameter checking in mte_switch_mode()
Date:   Fri, 11 Mar 2022 13:51:47 +0000
Message-Id: <20220311135148.410366-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311135148.410366-1-broonie@kernel.org>
References: <20220311135148.410366-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; h=from:subject; bh=34rEfnqbjHz3xCdTv2DILwIPZbwZa5CKK5iLFEGhXK0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiK1PxsgCHfdzOtIithI78zwesLOJSNsoRWIPM1F1x xF8GIpOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYitT8QAKCRAk1otyXVSH0MuiB/ 9bfvfiR5fUneWwgBTuIfPd7UYkCjB3zA8puBcxG9CeFKwPiS7k+HfDeIBijS/4C7H2cckItR2+IyEU VgX9PyOsNp0li1X7Ew9qCnvOFHMUo7Ed+2riKMXiw3gyuoDUfxFt6GE9FrmdLGQ/TnFm6ISHE4sTpT 4UY00O25sHm3XJgfgHKTZmhGXMiR+hkjaZhfwkoY2kNeoWbeeWkXZdLhQk5E3JeoB+rKBjv7bE3lPl AWkGeyQqZnRR2TuPgglfB9+GCkT7uwo7fXM+t9oMSRA01OJC1NF8dBw2t250oqUBm11EWugORIBGKL w7X+vHCtRA1Hnc7HNZJWy+9cle5E6R
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently we just have a big if statement with a non-specific diagnostic
checking both the mode and the tag. Since we'll need to dynamically check
for asymmetric mode support in the system and to improve debugability split
these checks out.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../testing/selftests/arm64/mte/mte_common_util.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 5327aa958171..260206f4dce0 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -273,9 +273,18 @@ int mte_switch_mode(int mte_option, unsigned long incl_mask)
 {
 	unsigned long en = 0;
 
-	if (!(mte_option == MTE_SYNC_ERR || mte_option == MTE_ASYNC_ERR ||
-	      mte_option == MTE_NONE_ERR || incl_mask <= MTE_ALLOW_NON_ZERO_TAG)) {
-		ksft_print_msg("FAIL: Invalid mte config option\n");
+	switch (mte_option) {
+	case MTE_NONE_ERR:
+	case MTE_SYNC_ERR:
+	case MTE_ASYNC_ERR:
+		break;
+	default:
+		ksft_print_msg("FAIL: Invalid MTE option %x\n", mte_option);
+		return -EINVAL;
+	}
+
+	if (!(incl_mask <= MTE_ALLOW_NON_ZERO_TAG)) {
+		ksft_print_msg("FAIL: Invalid incl_mask %lx\n", incl_mask);
 		return -EINVAL;
 	}
 	en = PR_TAGGED_ADDR_ENABLE;
-- 
2.30.2

