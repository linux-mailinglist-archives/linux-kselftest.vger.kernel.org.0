Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8975A50AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiH2PvF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiH2PvE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656AC8B2FE
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65D2961045
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C17C4347C;
        Mon, 29 Aug 2022 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661788260;
        bh=gJAqGnSzNPHzgfUKu3akdS0hlaIcDTOFmkXW09ngPF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4hqrmATWU8kBMFSfgKqiIu4fAz8tRElmKgABYZJSivtdeqVIuctiLPPY80bC11Qt
         GfpEoPFx4IxXCx3FCJcpJfHRjl0DBc4HmR6pZNqsVEW2iQffUOEoK3KRkY19+cO8BB
         hS3XZ5s/AoMfjN9A1KnvlLtCtKnVYB6HDVph03lXsLWUfz0LKuUg9rzNWA34NRXyUN
         bYoeEHtgdLlf5QwzgxU4QWQa2P+3wbluugc1VnX3VEMCttWvP+qaVAvsW76D0pET39
         XheCZTgx9iQUU/A9DMqnLAiRw+Yq4qABQlzk0ZW9SrwwU9JGT+CKyzqCl+tE4olxe9
         x6RgYlIUcIjdw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 3/4] arm64/ptrace: Support access to TPIDR2_EL0
Date:   Mon, 29 Aug 2022 16:49:20 +0100
Message-Id: <20220829154921.837871-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829154921.837871-1-broonie@kernel.org>
References: <20220829154921.837871-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2582; i=broonie@kernel.org; h=from:subject; bh=gJAqGnSzNPHzgfUKu3akdS0hlaIcDTOFmkXW09ngPF0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDN//jpOq9XhtCpO1DkpQmkKgvQqtHf6mMYVbUR1u hW3edBSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzf/wAKCRAk1otyXVSH0LN1B/ 472QY7+WHrjp4Ey82HmTM/nXPjzE3f7R/T1c8e7xaQYForswQjTQ7zK1HMQXKcpo9awwCVXKYvsKyO 3lGuRJD6UD5uw3mqKu+wNrPLKf3Z2RI5L+o1b00twy6+FsbmoBX5VGF3vsbWUAt/6xkNl1GFl9ilZ/ OVHgEUmt8rj0yfkZq5sUzxjUZQxKSCromDzKmsPa1QmiVlXLuIgHrJlDMr7pwussxo4Aeb8dK7gfy/ 0YoHGPRALb+FTXZJujtbd8rSANIXLJq+Z5Fs8wfDTn8Ta5x+jT1bmPvqrA4TOYS28nJq9SOSznSuW6 sm1R0nQYZUpC2qUe7DzdsYVHmuuY65
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index eb7c08dfb834..0e9764f73d61 100644
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

