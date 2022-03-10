Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C14D4C5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 16:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbiCJOzf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 09:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346864AbiCJOuI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 09:50:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925FA18BA6A
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 06:45:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D19961015
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 14:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22C5C340F5;
        Thu, 10 Mar 2022 14:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646923502;
        bh=c/QRjRg/RfwQM4QUDJCU9l2+mRZW/DETr9jPGJCCKNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJ0L6EbPauPZB0q34twBFXLII9o/MMCYB5geKNxlvHpGz1LJ9iTlrs1shbEx4ZWr/
         OPi1eYsghPGz0AuxM5oubIxmWrgblMeVOi6zVkocMuqVKxnIP4tMR9BvMSBxuAXljk
         78VvkUs1QiqVecSnDqddt0sTse/tXOri8sgCZi1VMQABoAqvB30pXNHFMZA/5Fg7jf
         d9QcYsTwolaPpRM5F4hCmcakVLuksqmWSGZ3QHBSCb8xAXjHV/zwnxrxGPW/lDmJBI
         yrYsPrelfDBUhdC8uGKijW0N9qJ6DY7oHIxFTmOFuUpbnzXJ6a2F0PbMTTeJoOByzY
         GjkA4Mr+9voKw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/4] kselftest/arm64: Refactor parameter checking in mte_switch_mode()
Date:   Thu, 10 Mar 2022 14:43:34 +0000
Message-Id: <20220310144335.2097457-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220310144335.2097457-1-broonie@kernel.org>
References: <20220310144335.2097457-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416; h=from:subject; bh=c/QRjRg/RfwQM4QUDJCU9l2+mRZW/DETr9jPGJCCKNs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiKg6UYO4Htw/wuc9XIZMUYMqZqBKEuEUSqdMjqtv3 2RBeeHWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYioOlAAKCRAk1otyXVSH0At8CA CGZMB/JMIYdKaUu3+UDmuyL/istCbmwuTNUd3Jsm0BZDkCJNDxSyRPD6TBaLjIfcOBJFn6z1m/htaA RwqnXQS6gtul5J6Idy3yFrAvupx9QfPxFik8po7AFekE6RV3xyimSqST3yoxbx74Sz/3q55GvYXvlJ BlYQtQHJsbI41jNonuxaJyK4J3mWCixl0AulokASI0yhlsMKEEaSNW66jCWPdTaJKBQyLIYIFBPBiz u4ZrCf6JrSMBeCwfMy4jQKtbuX5Khbq9reKtk8NmDgwai+02vXqDSlIrQOyvhQDyWJhE/+mhf+uRcv 3dq621gY2FnTG0STAq5y/iAwo9+vGF
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
---
 .../testing/selftests/arm64/mte/mte_common_util.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 24b0c14203cb..9b4529ef2b29 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -271,9 +271,18 @@ int mte_switch_mode(int mte_option, unsigned long incl_mask)
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

