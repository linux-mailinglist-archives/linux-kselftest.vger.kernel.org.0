Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F8F4C4C6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbiBYRgL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240739AbiBYRgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8AA1B511E
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:35:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E7961DC3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A03BC340F3;
        Fri, 25 Feb 2022 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810536;
        bh=InKrBD2vMdmkBp7Q0QxHEgxWxIqiXPP3qW3BD5lYOp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bN1i3Zfkf8YaU7r7q09nJVDuZIk3ooQOxjydYMUxZoNCptATJxvntfZM7QoF0xeAE
         17+j5LWzM9dV2NYHxN2RVsx/zSwsyANGo4qCtmMd+wv3ZUbTYSGiYx6B8G9Jek3jJp
         L1w9SwnL+idt19tc0xeXFEi1fzsgj4KAN9rVgqmoKklGrEWxz4F1OFVsx9XOtBVD3g
         deZZxzFY/HqBjeKMYdgAcW35TikvYdthApyWsJrHRJVOoc5sbgqE/5GpXLu5d4cSOj
         nyBgfgivwbXlCjTYb6NAxwxYuzgbMJupic0y05BLproVz0dxy42fa8mdZbdlZqbutR
         o0RhEyIbgDSsQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v12 19/40] arm64/sme: Disable ZA and streaming mode when handling signals
Date:   Fri, 25 Feb 2022 16:59:02 +0000
Message-Id: <20220225165923.1474372-20-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; h=from:subject; bh=InKrBD2vMdmkBp7Q0QxHEgxWxIqiXPP3qW3BD5lYOp4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQrZMkiujPktFI/rEXtS+3UDJnROtLYonJUy0xWx PrTzAz+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkK2QAKCRAk1otyXVSH0A1AB/ 9+3TU9k7VOwcoKeIx5YqG/HH1svo0g15RO/5LovV/phRjfdQjixZQKcrG4lV8OGw1KtVZr0Gk9+j6j CDDHIrQMG5JK+Ww+JYvClYZCHktZErlcZVD5wfv8U0UcIcyEIYMV8uuxtLUTdGKy6tbRiY/m85vmv6 sQ+UZwWP7tebnjNAGQF2Zs+koThWeFNy2AEq6le44B5aXezx9U2yUUzPro5CADgWhpOWvHp2mEMdnB EHzEuaCA/VAAz1SQHYSfhlJTaoJplaF7yyrMyiyKScz/3FURwdekuuyZh2ZdenC/g70CiVAEA9tlhz xxnHsJFSGZIBH9d9DnqAlVh0Z2Udq4
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

The ABI requires that streaming mode and ZA are disabled when invoking
signal handlers, do this in setup_return() when we prepare the task state
for the signal handler.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/signal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index d8aaf4b6f432..cda04fd73333 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -758,6 +758,13 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	/* TCO (Tag Check Override) always cleared for signal handlers */
 	regs->pstate &= ~PSR_TCO_BIT;
 
+	/* Signal handlers are invoked with ZA and streaming mode disabled */
+	if (system_supports_sme()) {
+		current->thread.svcr &= ~(SYS_SVCR_EL0_ZA_MASK |
+					  SYS_SVCR_EL0_SM_MASK);
+		sme_smstop();
+	}
+
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
 	else
-- 
2.30.2

