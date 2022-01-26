Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8EB49CD83
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbiAZPMt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:12:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41410 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242606AbiAZPMs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:12:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FD65B81EA4
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7F4C340EC;
        Wed, 26 Jan 2022 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643209966;
        bh=CyYorHNQCHBoqo8xQvMZzI3T4+46kiWpXhSL8tXeuog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBJGyYqHXEDMMPBM35xpXoLDbMRV3iLQYMg4PV0e5tgtMEx8xbNZBl8GtBW5MquN7
         paUhmkKeR7UWd2s509KXZauZizDUqNXAdmrv13SaHofPz+Z+ysD6Uw7Whcv45Nfevm
         6L1joTjGY+iX/GEZmqTss1wqDqwZMoNUXgUVVubYFjcnddvx/hIQT7C2reot4I0JMw
         mh8b+R1BaRkMkd9MXnejxKyE0bLHF28fb0cJlX9PAiPWYPEATEhKsICqcd9dcWrmL4
         98l0NegA/SWmrNQy2OkjAJWQaTMTJPd1ARnd5g7pX/QMecNUymtGaBYEgU1qSO8h87
         rC7GA0ZoMAZbg==
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
Subject: [PATCH v9 18/40] arm64/sme: Disable ZA and streaming mode when handling signals
Date:   Wed, 26 Jan 2022 15:10:58 +0000
Message-Id: <20220126151120.3811248-19-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; h=from:subject; bh=CyYorHNQCHBoqo8xQvMZzI3T4+46kiWpXhSL8tXeuog=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WSEGMK5oeSY6nFUOtibYupakncbZg936OSHhw4h 4O/+R66JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFkhAAKCRAk1otyXVSH0KamB/ 4pimLKdBRbJEaraXrVBKJqymrEQxdZ5oq/4KXqblXFnvx+vGJORilrgkGRLOvqolv/1hpAeVXtLB08 ok52z/hFl1XAu0jGpKB9HCAz5PrgYPzBTNS6p980JcUxj2ukwqFLAyM1nB5EpkOgsd687CFX8W9GSi //p6dsi28vGQbCKnW74bHAKWfhFGnMzGURAc1L/QfUzf43YamYSarYbxlpMJsLnXgr9N1en2Euhd8O mFlTjYcVXoEerrKMTidrmf8q7uGmWlGE9wKpQHxEZnzAUKw4ziqjf/UQ5/lDnIICEXInAjCyWJZUks VtyzDDRnHdq9JjUXDGdbMW5LZY86Wj
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

