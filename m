Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE249A527
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3409086AbiAYAYz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:24:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51858 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2374219AbiAYAQc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 19:16:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BC2561544
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED39C340E7;
        Tue, 25 Jan 2022 00:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069788;
        bh=CyYorHNQCHBoqo8xQvMZzI3T4+46kiWpXhSL8tXeuog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dR98lk/evzo95/oTdTavZiiy+tUM5d1x2DQdwu0dBZ/jdSmHMVSqvY/jYb+BgZva9
         Yr5ya2gJUOPosc93CMHSijafFHEp0v9NkHULmff3z0LRX473yq9mID8pia4nutxFxk
         e8TCMiv9w954wxIOLF4eDsfUhH1g2fjlxKBeJBAf2AfG82MDUCCRCh5cvA93/tLTYM
         c2M0ypysct4NTRjdTY0MhXm7jkGXIKQcB0vE+s3IfZQvTfcY+iFykvsu6AKXcoxSmV
         qBDLvZHeQgPtok0xuQnCPgG57qtbwzB961dKnTjjXEneoQic5qzOPlRBNY/oSkFhJL
         V54G6xbv7m45A==
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
Subject: [PATCH v8 17/38] arm64/sme: Disable ZA and streaming mode when handling signals
Date:   Tue, 25 Jan 2022 00:10:53 +0000
Message-Id: <20220125001114.193425-18-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; h=from:subject; bh=CyYorHNQCHBoqo8xQvMZzI3T4+46kiWpXhSL8tXeuog=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70AOGMK5oeSY6nFUOtibYupakncbZg936OSHhw4h 4O/+R66JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9ADgAKCRAk1otyXVSH0IkWB/ 41nuo+z75dcDfO4+NfLkmOvY6Mt8MdU1fEcMLWAic06ZsyScts/NroUedOCsQ80E/nN5chRCGjEQdK rq9L3XYI47Eqr/4vWM29mP04s+bRdBUHXzPHDe+LHyWMDh7UgVubC+SrAiUfhDD58WsnataTGoQz09 pyZiOcqDFZy0XPCCVdCBl2r7+DiRDF2k0xUkwpBDOWEUOFrztDJ7SZkeUD2Wi0mM7n8u5/yY6p+Aja jaeB7mctWB7b7OLmQ5wgMWodm56LiqOTxYMVQbjMK9QDAeL/WVGjVr13FZ0ni+kW2/1FAjP+uknIBY 54s3+/d1ii0jelQCiDugZ4eLY9T7t9
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

