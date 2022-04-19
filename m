Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58E6506A41
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiDSL1W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiDSL1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:27:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4545F98
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8F8AB81851
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285FEC385A8;
        Tue, 19 Apr 2022 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367477;
        bh=IgQmCXJBE2ycdQoQEp6rpnOwcUiocLTkhM4XALt/TLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NipyCTm6aOhDxlULTGm5DiNJYlv/O9yw2ymObb6K/6ie9NqGDhIXw7vrvW4zTXu7r
         BUMjSUcefjxG4W+pxQ30zVfcGhuE8F9GdaQyWBgCzVw6ffO/sKz/WFaWgtvRPQNhrd
         lGHoocjf6ZfmmMNazL0j5B+ZQ0FpIw5weFg6C/AXr6YlSPJR71U0rbrSF6o4+S0uHc
         1TznWNQ8kxWUF3GPMMqh83utEkjXDOUZmm3rfsj7am1uUsLnL7UYF8zb7T6QibJnHN
         iOAMyqhH80u05m2KTIEMy0qUKEWa0iN1ag389TBeLTHlrza2dRiCFI7Cp1yhDw8UBB
         dWvmdSUicRQ0A==
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
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v14 17/39] arm64/sme: Disable ZA and streaming mode when handling signals
Date:   Tue, 19 Apr 2022 12:22:25 +0100
Message-Id: <20220419112247.711548-18-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; h=from:subject; bh=IgQmCXJBE2ycdQoQEp6rpnOwcUiocLTkhM4XALt/TLE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXpt1NGzbGwQFros5j+TYXHHtF3i8QyvzP5YLP2js TRShsaKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bdQAKCRAk1otyXVSH0Fx5CA CFOdMEDMidXxyCWrnDbnkd6gNtPvdnJIP8qJ6nHTq1zLgcbCU0RrXA8u2X/g2a3KYcUtwFdqQGFgni JV4jTDo5tUFcNH1f6GUVw6C5VGEfkkMGBS4cEohT6J9AGcz+8xheLP0ap+/BB8HRzYzlkIK8lkO/A5 D/+OpwHkhPqiOmVqe9lBYNJ4CjkaPwLV6vg24n1Pj6EfwDcsSqYHCoQ3bzfCrTsXvYo34ra+704cfH cFntoDFR06VnVe5qxg5IaeuI41DQqcy4Y8SZJsuQ+sMbkeiazCw25L/YSN0iTStv+meabk2vVBk/YF WS89rMfbrz7TsXz3ONjCYYLkZdtSw7
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

The ABI requires that streaming mode and ZA are disabled when invoking
signal handlers, do this in setup_return() when we prepare the task state
for the signal handler.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/signal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 4a4122ef6f39..42efa464e46e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -759,6 +759,13 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
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

