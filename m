Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB9D6263D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiKKVva (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiKKVvO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B3F6B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10C47620F1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F4AC433D7;
        Fri, 11 Nov 2022 21:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203472;
        bh=80VeZpDH/AvqQz/7ZP/vlFhjGhDxdTuyQv5vjnhwMFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMnl+6LLDrNzJEq7VcLgaZJLeH9c4TjDBMT5lDDHY6ExfBHmhm9ga3qPxr3/DMXw1
         Xs3K8HDUh07LEWOdyz8UUfbpAGdg66rAdSo+E37CypmE7vzsTCQJVliMSSOjtRgB9v
         lxf2Navq57EwqSeUTbTQKiVQAHftqt/hA0Ec/rmZ/H0BM6/4I8oQAqWZcFtndruNhw
         F85dI/3J5L3iN4ZpiQ7MvXzBOW8r962OI1E2oXmLCAincLQRD1nLtAtUUsHOjjE7fp
         tFsrvCLHpwVBYIaZgXIniz4vbkEo6ElytwLQy1tfSi8XRiLfC2c87kwaemtE481Hua
         8oHwibZsMrIYg==
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
Subject: [PATCH v3 07/21] arm64/sme: Enable host kernel to access ZT0
Date:   Fri, 11 Nov 2022 21:50:12 +0000
Message-Id: <20221111215026.813348-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=broonie@kernel.org; h=from:subject; bh=80VeZpDH/AvqQz/7ZP/vlFhjGhDxdTuyQv5vjnhwMFE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOTTbTmxCe8blM8BdTbg1P7SUXU+9mP/xRn2HGD MAaKabeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DkwAKCRAk1otyXVSH0DbEB/ 9RbYH+yGIFzOdNLUoS8Wxgz2E5srCF8moLJ9jRoA1c3cEBdkpTxT2d5RECOEPS7hFuv3o/eZjE+m1m PkMXuCiOGj4v/rPRH6G0dzhQYma/Pb8odi8dmo7JJcMXR+aWndLSeMVuhpkTSD79mGiAFW0BIq3dwX lPSZpmwsPMUGhX9GMo05bsYjzTHezHfX6CoLXq6LWlQ8ulaxuAY8ClacBAeddEfHHMNgetFOmHTMWt UNUAyefGAWVZ7o3H2LRbMvgSSYTlvKExL4FXFAaUwsPzTdWwZg6f2uLf7KFay9qjPY6eu+kEiJymvH kVCHzXVaFWgYf6SmXLotBzocDEE8pY
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

