Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2104AC3E4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 16:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiBGPfL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 10:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354118AbiBGPY0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 10:24:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08995C0401C9
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 07:24:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAB69B815B0
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F28C340F0;
        Mon,  7 Feb 2022 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644247463;
        bh=CyYorHNQCHBoqo8xQvMZzI3T4+46kiWpXhSL8tXeuog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvLfVWvDfmYSuyjXYex1xBQ9gPyeht5ydOaTKISojTjjKGHIG9295GdPG82prp482
         9jqBoMxoubjef/He2tMmwoB7IXLZTRgBLeJcdJf/pxND91R1Pnr55aOBVKUToJeiij
         Zep6I5WuQx+f5t7ktJB4PuysR5qGvxLT7H7l9LiKrPbRoYAfuuWXHf8NIR1TjeFUXe
         3LPAoB7EEaZxKaG0xaIfPW2I94lXsWvlJat6aDW1KAri9qLChHf2dH42t1xMpdTN5i
         du4rwWlt6CdsB2JMdnMgdhC+C7GNbEVZ+LYZoh6SkBZTzBRbHerHmM9qbWFJHcXxwy
         a55OHGBDrFhyA==
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
Subject: [PATCH v11 19/40] arm64/sme: Disable ZA and streaming mode when handling signals
Date:   Mon,  7 Feb 2022 15:20:48 +0000
Message-Id: <20220207152109.197566-20-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; h=from:subject; bh=CyYorHNQCHBoqo8xQvMZzI3T4+46kiWpXhSL8tXeuog=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiATjTGMK5oeSY6nFUOtibYupakncbZg936OSHhw4h 4O/+R66JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYgE40wAKCRAk1otyXVSH0LxCB/ 454egnpD5PCrECVP5HSHQwc34prahK5O2UeOwYA8GKdzCWm2CQUxKv/NwgfNrghmSTESgeQcb78Nt1 Iugdh2d/83YioKoWfNCnIUQQuH4Nj0DngdM8SC9Sf7CXng/Q94n2Qv0+44OgPPAO4VoT4wiztIVfvf CNA/QwZt8h4JGo22d3V8V+KPLvJ/lbFKmHQRwNrhw3BBokC4CclEnhsUlr+0AxBsIlZAGIgakJupCO 2dlQMxBu7dF8kvjLWXiQ9JaEObM/ppG34Ecppd+VYT54p03wKwaUEed6Qsh9FnBkGSB9vrdcIKNX51 TIKRbx9TMvAYBh1gZ2sZFJFS81obBO
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

