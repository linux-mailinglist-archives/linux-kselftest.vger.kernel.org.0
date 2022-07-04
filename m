Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8266F565D6C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiGDSPB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiGDSPA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 14:15:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0010637C
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 11:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE67EB811FC
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 18:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D69AC341CB;
        Mon,  4 Jul 2022 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656958497;
        bh=2FRY03mI0lys9sGvaqOL1d+m6IEPqOMSpUOGBSMSQvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bq6Cyt751EBE6fDRLDS9+LW0OiaO7MEDxggL6h28jZUq7pOKMDiaLT76XUYMhbo8M
         pBQAAwuXjonrmBGvWvznEjgu4aC7dRZGI+ppotUasPUF9FaU+gsqDwNBXIbjEE5Ybr
         mxGleaHFeAmiGACnv6265Wc3r7lppylfRls5F4/P73n/zhfhpCg7jWYGBKOXZC/tyW
         sTAfoOJpbD1gF2etRoM/i+M5mAhXLZDGny2ejc+dEelPs+5U087IsD8hc30Snu4e6+
         U7h0jtU21QnXPH9EUdp3SPE2VxjxNdLCnYuU2b8JhlJcjhPSAfYdiUJhoy9TN3rdNz
         DMWML9vTFUo0A==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/4] arm64/ptrace: Support access to TPIDR2_EL0
Date:   Mon,  4 Jul 2022 19:13:31 +0100
Message-Id: <20220704181332.3318214-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704181332.3318214-1-broonie@kernel.org>
References: <20220704181332.3318214-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2582; h=from:subject; bh=2FRY03mI0lys9sGvaqOL1d+m6IEPqOMSpUOGBSMSQvQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiwy3K7HF509PjAusm21vbxp1Var0V8oRiJCuMprVH mcWqdQ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYsMtygAKCRAk1otyXVSH0BbjB/ 0eWCDoTfarmX7ufAfxHEIyGJ/6LJQxFKDB4sud8sMYQGw4rvk9In6tlP+kbNoYqiKVU82Otgu4BE0A 8zZNvZibU+HAfRXtsiGPcmXN4RB7EhOi6d1gx1yCp5Lh0pkqhXg4IDWzeMG3FjUbHDOlxMWJvrpX9i x7xxjl4XRtCt000cLrLTlsO1WFbvByy7jaFcO2982oOz3U4gBXNAoKs1M5+IhpCYgAPstnezXPbbXX 0ZycbYQKVXn6Alm8S2POFlIgspTOgEPxL/FMqZBEUBzz+TljagP+xJUU5HiT5mcycNsL6bMLgmovx3 he3c+wWpUSbBxE6uQQUm7lBc2qCqp3
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SME introduces an additional EL0 register, TPIDR2_EL0, intended for use
by userspace as part of the SME. Provide ptrace access to it through the
existing NT_ARM_TLS regset used for TPIDR_EL0 by expanding it to two
registers with TPIDR2_EL0 being the second one.

Existing programs that query the size of the register set will be able
to observe the increased size of the register set. Programs that assume
the register set is single register will see no change. On systems that
do not support SME TPIDR2_EL0 will read as 0 and writes will be ignored,
support for SME should be queried via hwcaps as normal.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/ptrace.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 21da83187a60..82feabba3911 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -666,10 +666,18 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 static int tls_get(struct task_struct *target, const struct user_regset *regset,
 		   struct membuf to)
 {
+	int ret;
+
 	if (target == current)
 		tls_preserve_current_state();
 
-	return membuf_store(&to, target->thread.uw.tp_value);
+	ret = membuf_store(&to, target->thread.uw.tp_value);
+	if (system_supports_tpidr2())
+		ret = membuf_store(&to, target->thread.tpidr2_el0);
+	else
+		ret = membuf_zero(&to, sizeof(u64));
+
+	return ret;
 }
 
 static int tls_set(struct task_struct *target, const struct user_regset *regset,
@@ -677,13 +685,20 @@ static int tls_set(struct task_struct *target, const struct user_regset *regset,
 		   const void *kbuf, const void __user *ubuf)
 {
 	int ret;
-	unsigned long tls = target->thread.uw.tp_value;
+	unsigned long tls[2];
 
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &tls, 0, -1);
+	tls[0] = target->thread.uw.tp_value;
+	if (system_supports_sme())
+		tls[1] = target->thread.tpidr2_el0;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, tls, 0, count);
 	if (ret)
 		return ret;
 
-	target->thread.uw.tp_value = tls;
+	target->thread.uw.tp_value = tls[0];
+	if (system_supports_sme())
+		target->thread.tpidr2_el0 = tls[1];
+
 	return ret;
 }
 
@@ -1392,7 +1407,7 @@ static const struct user_regset aarch64_regsets[] = {
 	},
 	[REGSET_TLS] = {
 		.core_note_type = NT_ARM_TLS,
-		.n = 1,
+		.n = 2,
 		.size = sizeof(void *),
 		.align = sizeof(void *),
 		.regset_get = tls_get,
-- 
2.30.2

