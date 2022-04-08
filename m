Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7574F94C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiDHL6c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiDHL62 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D927DE39
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A5A62068
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DF8C385A3;
        Fri,  8 Apr 2022 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649418983;
        bh=IgQmCXJBE2ycdQoQEp6rpnOwcUiocLTkhM4XALt/TLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9yXSip+T+rwF0geLqmnSBEhw+LCiazFF+dgKT08KCU41j19JN+45qBbnIFs1JAHK
         JOoOYYZTXw8aswy0aV3Ez63JwNojzv7AS9rOg7rOrCU1Ge/JBrulEgnE+q5CK/uEsK
         9Llr66GXzCQXWcBNqjrhF+lDmlUbrjbT+Ro3DClIz/QjyHTGqJ+XstxVJq3TvQXm6n
         THESjugbcj6uap7c7BD45fye3nijBwlZo+yf3amgzaGWEE1BRAFGNxLTQrCuD07QWs
         1KjFM8OF8kRiNcNC8OS+rTtVgKq/XcPrrJYNj4UEFOORVUhf+tJ0cTkiqk1LK4fpd2
         rLT3C8D/2SUMw==
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
Subject: [PATCH v13 17/39] arm64/sme: Disable ZA and streaming mode when handling signals
Date:   Fri,  8 Apr 2022 12:43:06 +0100
Message-Id: <20220408114328.1401034-18-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; h=from:subject; bh=IgQmCXJBE2ycdQoQEp6rpnOwcUiocLTkhM4XALt/TLE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/MNGzbGwQFros5j+TYXHHtF3i8QyvzP5YLP2js TRShsaKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAfzAAKCRAk1otyXVSH0DR/CA CF/lS7py2hHrn3w+TGcIG2waMCPpXXtaw5A3PWm8shZgXJKLmDDspNsvxvmRmIYQzp0iAFDQaLlz1a NBhO9Q9rUd32XfGSa2o12gt0my8bLZt3MYuMZAKm1EhB7wy6+NVBvhaM1grXU4nw0ZQh28AgnZ4kSa hY5jEU7FPK69LoO5QyYOj8B0LxcDNWuG2GHeetXAZxR3bRqzL++R4FuotgZRRYooE2ipmjHQtfuYR7 2rKivu72y3+8k19kakrat3KnSUM7lKE0MrL3xVRFbFjYd8fBxmHHWD9JvikmQ7bRjn+wDLNkObSek3 Uen/EUIpk03hZAO5VwuJGFotoPfZC7
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

