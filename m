Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DFD614CD1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiKAOjf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiKAOje (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC1013F9A
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A966615ED
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE89C433C1;
        Tue,  1 Nov 2022 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313572;
        bh=80VeZpDH/AvqQz/7ZP/vlFhjGhDxdTuyQv5vjnhwMFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeQjAS6Zwx/JwgO7i2KG7oPesOigwURaa43dNteZA0X5Luq/HEs80ZYvOoN27jzvM
         fRFN9g83MC2v+DImNQXMRSrZ+n+V7A5C7sCAWAuPMM9lioB/XpqVhn5jEiXSpjAftM
         TN5/BhnBJHKGkc6IsnSM0+Iyv7CQoKpFzQyz3AVhYcIl+L0kdxhf8rvhnwA/XhTRr6
         iK+8eceLKr0g6ofpESuuk9cOH2/v4xenRGp/iYpZe+uyVZu779FBJbAMl/Q6naFWq3
         0hlrvCnEhPyLTll9K/QkNS4DKbTBiKxeNrH/iiEweKbj2iLL6bUJ23YXZgzo0hJLEC
         zmB6AE6eUvwBQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 07/21] arm64/sme: Enable host kernel to access ZT0
Date:   Tue,  1 Nov 2022 14:33:22 +0000
Message-Id: <20221101143336.254445-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=broonie@kernel.org; h=from:subject; bh=80VeZpDH/AvqQz/7ZP/vlFhjGhDxdTuyQv5vjnhwMFE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4wTbTmxCe8blM8BdTbg1P7SUXU+9mP/xRn2HGD MAaKabeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuMAAKCRAk1otyXVSH0I7rB/ wLDuDyOPDInUuWeKBFciC6J4cJ4wIux/bFPEoPkc1AQKjuqpCPJLn9Rev4BQr32fIa7un3ZlqfTyht CTFMos5iQPUMaEJhDi2f1m6/hKCpgIGjPpherBVNGH/yTa7fSZA7iO4WsGWr+pG7Y1GH+EoRIFBrT7 Z5Bxq8C9XtYsiGyBgd+12yHThZzzOBy7vXDKhWLCtFDQFeO+J4qRXuE5SrnCTghGjg+3rvkTxXgDHu yfXiiv6e5sonTKTY+/o59dE0lpV7VS63kecBcduPO5S4jdL8o2/469vmBPVGZDR44qJFPRZxXEExt/ 99EPG4ZWSIeEIeYbANSlIEBBGWZ0y9
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The new register ZT0 introduced by SME2 comes with a new trap, disable it
for the host kernel so that we can implement support for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/hyp-stub.S       | 6 ++++++
 arch/arm64/kernel/idreg-override.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 2ee18c860f2a..d31d1acb170d 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -132,6 +132,12 @@ SYM_CODE_START_LOCAL(__finalise_el2)
 	orr	x0, x0, SMCR_ELx_FA64_MASK
 .Lskip_sme_fa64:
 
+	// ZT0 available?
+	__check_override id_aa64smfr0 ID_AA64SMFR0_EL1_SMEver_SHIFT 4 .Linit_sme_zt0 .Lskip_sme_zt0
+.Linit_sme_zt0:
+	orr	x0, x0, SMCR_ELx_EZT0_MASK
+.Lskip_sme_zt0:
+
 	orr	x0, x0, #SMCR_ELx_LEN_MASK	// Enable full SME vector
 	msr_s	SYS_SMCR_EL2, x0		// length for EL1.
 
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 95133765ed29..d833d78a7f31 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -131,6 +131,7 @@ static const struct ftr_set_desc smfr0 __initconst = {
 	.name		= "id_aa64smfr0",
 	.override	= &id_aa64smfr0_override,
 	.fields		= {
+		FIELD("smever", ID_AA64SMFR0_EL1_SMEver_SHIFT, NULL),
 		/* FA64 is a one bit field... :-/ */
 		{ "fa64", ID_AA64SMFR0_EL1_FA64_SHIFT, 1, },
 		{}
-- 
2.30.2

