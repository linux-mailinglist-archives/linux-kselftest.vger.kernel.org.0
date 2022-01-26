Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836A849CE5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbiAZPbe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbiAZPbe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:31:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBADEC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:31:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B274618CD
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66039C340E8;
        Wed, 26 Jan 2022 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211092;
        bh=CyYorHNQCHBoqo8xQvMZzI3T4+46kiWpXhSL8tXeuog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZXdfsDT9WiY1UZzgcSPIx9Va18TNaEQIQJNSUV9vSgosHibcXKUSZOiPArSnvwpP
         pydP7nLmdw+Q1vZ08Q1CQLtF5ke5RuewdkUl6vjC38Miuq8GNiK7KahXGAq+g03rfl
         cYbN8M9c9F0MAlZlhOr98wrAfRKNEkrq6iMGQEhWDdI2w03+HbLZMPik0qqXks6AEz
         MCAe7RgfqPvcvudftmdmkWONwfhXg7DoM1vphK39QaBaLhfuGaXZyHpQgy2fxJKha6
         FBlmpYaY+3plFIFFgbVwliBeLOHhoSyXkLloFPlcmBOrHw9a8EgjtXHLnGx4VbI98z
         Z3EiEwFVf1IXA==
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
Subject: [PATCH v10 18/39] arm64/sme: Disable ZA and streaming mode when handling signals
Date:   Wed, 26 Jan 2022 15:27:28 +0000
Message-Id: <20220126152749.233712-19-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; h=from:subject; bh=CyYorHNQCHBoqo8xQvMZzI3T4+46kiWpXhSL8tXeuog=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhhGMK5oeSY6nFUOtibYupakncbZg936OSHhw4h 4O/+R66JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFoYQAKCRAk1otyXVSH0FkUB/ 4ym6g7Ev1cXCryxHS2KyEAH6kmBXphdlEzxZ8YHtlOVXjICfwsAtce703mKDpkQzfOVzPlmlOljk/V f74Noam+eIVQFm2yVXm2wtPbyjGNqKkqzHXaFhnAqyXO1lkzMicdWuyShqKqHZBs7MWGc5gJJ9vjkr hmOXo3P4mJoSUMzLcpxe3GoysmZ3nG0zZRITMd8GvC0jsdDxOvGnKpSz5feUtNdPpeVW4Js74j9i7f SMI2DXhqrBuWoT6ugBJY9Eg/0bZmpI8TnveeLIsbaT2pLyqw4v02kF8N7Vj9KUCkP8Z0suRFicA4XO x4pv1rPWQ9L9j/J6mhehkwqJApW8FB
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The ABI requires that streaming mode and ZA are disabled when invoking
signal handlers, do this in setup_return() when we prepare the task state
for the signal handler.

Signed-off-by: Mark Brown <broonie@kernel.org>
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

