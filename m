Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8825068C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 12:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350739AbiDSKbR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 06:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350712AbiDSKbK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 06:31:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641832CCA4
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 03:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5C91ECE1763
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F64C385A7;
        Tue, 19 Apr 2022 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650364100;
        bh=34rEfnqbjHz3xCdTv2DILwIPZbwZa5CKK5iLFEGhXK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrjQ4UMyn44dOJoChwWt+queZWuyg4hKc04nI10qVUJ7s2pwwvB4sQbFAj7Vdlno3
         G6uePOVgPET57kA8gVT/GgMmzo56bfB7EttO9EN4DAAbpADx9U6ZjX/BcCBG9rBU94
         nGfAhNPYdVW8gAecaEBKqC+eike84408vjQxmmTtRd+L1+BbNRQi2iqsufFaUmSAXD
         3+QTcx6F06hZipWOSzv1lv0gio0YorGiWboshC/HxSdpH+UV8wg1CrnBQxAWnt4VdN
         6r+A46xi6VURdD+dfsgPxSnwiB7HhKCPiS3HqH5Ckt/RWSqYPiCJPrK1FKS0cHE4QK
         JzL/Ya6Ql8Y7w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        inux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 3/4] kselftest/arm64: Refactor parameter checking in mte_switch_mode()
Date:   Tue, 19 Apr 2022 11:28:07 +0100
Message-Id: <20220419102808.24522-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419102808.24522-1-broonie@kernel.org>
References: <20220419102808.24522-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; h=from:subject; bh=34rEfnqbjHz3xCdTv2DILwIPZbwZa5CKK5iLFEGhXK0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXo60sgCHfdzOtIithI78zwesLOJSNsoRWIPM1F1x xF8GIpOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6OtAAKCRAk1otyXVSH0GWeB/ 90cd8aj3BhHopt+I9pf2QwuwwI0Tv6iESeWMq6Qp1vohcv5jovPT2/aOFWm5YghRbw0+jq8RtIs4Rb ZO+SYFOjMEb+zSh1u/bJrRWD+MPzz3xFF9ZS485OX5X53QXSKTQJWzWex8iVmwKNK5kQcSQeyUYt9Y iXhNY/sT0+G+BwZ+BZNmKlDbJwnvdxX3WWVC/9YTbajJMK1XVNeaRRfTbfa4I6pzcCXDOJf1en2Ab3 Nychhdazn8zYwGY5At9femnGXwfu1RUEb5NMVZXJofrG/rHUh/9Wbq+gidEpACMtan7fVkO7Vl2PTU aQVbSCPAbDIYdumIHAfd094z+CHtY8
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

