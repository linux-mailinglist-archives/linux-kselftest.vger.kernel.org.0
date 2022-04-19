Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83FE5068D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 12:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiDSKfj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 06:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiDSKfh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 06:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F9429CB2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 03:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C15A61236
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324B6C385AD;
        Tue, 19 Apr 2022 10:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650364375;
        bh=34rEfnqbjHz3xCdTv2DILwIPZbwZa5CKK5iLFEGhXK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TN6F69ep3sxDSelops6IMXtD3K6ro5R6vvzU9cysIXM06q3IoWxm6tXA3EVjzjbRC
         /jiBc3OTZKJWs7/h8GA1+mdsKxn0hzAj7FKQe9JZEw6ybIPtcJZuGyZpZYwRCLvXdh
         cX4GE4IEiZGfldCPm5QICj/0FFKyRFRMEk7FYIl+NaauFZWZHx+mxkjusWfQ8v5Ieq
         UFuPLA6ZS6RYpRHeJAx5JeEbqF8c1mGdQPnwQBlYoJDnYhJDcZhinHxhmdAJzn5/+h
         YAEyo9UYIpbcp9DSM5CzJanU9pPFFqy4Hr5tQJyyT+MD76RQuMJNNNcVXc6f9gBreB
         QUUluL5ZRx32Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 3/4] kselftest/arm64: Refactor parameter checking in mte_switch_mode()
Date:   Tue, 19 Apr 2022 11:32:42 +0100
Message-Id: <20220419103243.24774-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419103243.24774-1-broonie@kernel.org>
References: <20220419103243.24774-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; h=from:subject; bh=34rEfnqbjHz3xCdTv2DILwIPZbwZa5CKK5iLFEGhXK0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXo/JsgCHfdzOtIithI78zwesLOJSNsoRWIPM1F1x xF8GIpOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6PyQAKCRAk1otyXVSH0N8XB/ 9GdPjAg9Y40vLk/QufgPZGAAI6mHXzK7z6KwFxs4Gt5AGxKeikKuPcqoqmE/HNJolXx4Uj2TvddnT5 WMxX3yu0T/s3SQHJdSh49Lf6wRNz7wedRzgQk0Flgkz+b/NQ7aiXiqrweN/lVn01tFguEaaG7yOAs0 WHgMz6SyXsu0UMPne58IbTC5XHP5L0c2+JirQd1m1MJSoX8onQvVz8xBTwAABHhDrIq+DLUdJ/w97h xESFZMQAESp2LLoRpqmFKYoM2SHFmZThDzpecZmnKT4VmaxqF90ZTW08/T22ma7+33xa3NJNPYpKPM /mHmB5FWuaCnHJiBjXgxLRKgjVJFwL
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

