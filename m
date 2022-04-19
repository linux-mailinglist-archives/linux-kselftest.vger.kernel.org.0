Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04425068C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350714AbiDSKbL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 06:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350693AbiDSKbE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 06:31:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DAD2898F
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 03:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C455CB816A9
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA753C385AD;
        Tue, 19 Apr 2022 10:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650364098;
        bh=kEQALFvVnF2JUNgXMicTSPE1AfxRggwyPGzRYL7rWak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVUUa4pu9E6mwdXErABgjCbVsHFBIf+lqXnDu8aV3tWuL3+7wt26XyA3o9UjO8o1C
         G+dpHwoTpJ1CIaqQuma+B6JWqUkEaUMJ5kZCyyBEuMg4gLckXqlbWDLn8pfjvyEB3l
         IfhKfOuiWsi1YxI6NefzjW/xJMTq2rVvh0ChuL53JooUJ0y7jXOfkCVGE8fFijmvvG
         K1lM0p9PUW9lO13ekPku2Z/PbsH5Qp+NOqB+nrCEeKc/acLdF/wBYu2jYrbEECGX3g
         hDHuMR6DIEUf6nnP/IOOE+6kI3R763oFXttSIE6pIxnunxG2w2BKTKx+9mTmupCMkJ
         zZ9JmBA5Rv8Ug==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        inux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 2/4] kselftest/arm64: Log unexpected asynchronous MTE faults
Date:   Tue, 19 Apr 2022 11:28:06 +0100
Message-Id: <20220419102808.24522-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419102808.24522-1-broonie@kernel.org>
References: <20220419102808.24522-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; h=from:subject; bh=kEQALFvVnF2JUNgXMicTSPE1AfxRggwyPGzRYL7rWak=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXo6zoXEdRQ7/5KuVtfTwYvHv3UfBHnjTUblpso4O pdkhaOOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6OswAKCRAk1otyXVSH0CYsB/ 4yg3XLQWrKNXRYskaKjqaughEIXjxKjXRlZ3Tbye6UQGVa5W0djBpbJWhNfTfsjHYHPBhxrFAB4NK1 8/xa9Oa6jdRYdLfhYz/aOId99aUfEiPo0bDUHp68MjNJ9jCFDUx2GBp88IuaZs952ezj8u2KuiUtO7 t5iT60TttMnncnIxp5YoYJIr1kY8G21TgEwxSKHd0SE0ESpaYFgteg1onqYVjfoE99TK++DxabiqDr pzaodhf/AwOR6aHb8JZ15BmqsJ3IgoJEoK1B7mWYnb0nPnX+VvPKQ4znu7o+g77Tn3UM2us/wwmrim 7Z2iYj2NHVx59r9Sh5EkKb/tdp4/ca
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

Help people figure out problems by printing a diagnostic when we get an
unexpected asynchronous fault.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 0328a1e08f65..5327aa958171 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -37,6 +37,10 @@ void mte_default_handler(int signum, siginfo_t *si, void *uc)
 		if (si->si_code == SEGV_MTEAERR) {
 			if (cur_mte_cxt.trig_si_code == si->si_code)
 				cur_mte_cxt.fault_valid = true;
+			else
+				ksft_print_msg("Got unexpected SEGV_MTEAERR at pc=$lx, fault addr=%lx\n",
+					       ((ucontext_t *)uc)->uc_mcontext.pc,
+					       addr);
 			return;
 		}
 		/* Compare the context for precise error */
-- 
2.30.2

