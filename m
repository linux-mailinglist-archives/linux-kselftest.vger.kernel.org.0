Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F0F47091C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245524AbhLJSru (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47502 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSru (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 44187CE2C8D
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5ADC341CE;
        Fri, 10 Dec 2021 18:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161851;
        bh=hGpG8Ecn+fUBYk7jzxhxs/HLYdIhbVwbCQFcqoaHYxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUF36ONM81eaPr8AaIhuTFWYp6uMqlskUl5rIhnbgdhI0Gdkc5h0uzImfP+iAr3KD
         88ERpCfnG5p/w8IHW83MTqMlCmp7MrWoElrWJ5HG1sevZddvv92ktAe3J/t7Bzt0za
         h+y9lKtqyCZUvhvBF9hQJJrje/mwiMFXCc9+UZ4B4Btu4tdSvsJuQKd2ZjeqA6Nppm
         cbWY++R560X2HbD0mh8StANCiE+SK83fuTH7vFXy0HNfPOWh5Z1J2ns5jB1z4a5OYC
         MxEiHUgPbL91cElp1YGYoESHBamLX8suU9rXD15mmDDXUe35u6rPhw52tjYwXF9eHV
         dTKIOlQyLXuEg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v7 12/37] arm64/sme: Early CPU setup for SME
Date:   Fri, 10 Dec 2021 18:41:08 +0000
Message-Id: <20211210184133.320748-13-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; h=from:subject; bh=hGpG8Ecn+fUBYk7jzxhxs/HLYdIhbVwbCQFcqoaHYxE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59HyLv2zpnBGtW8BWzvZn6mB1Qgl6PW4FK9CnpW RlSAmYuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfRwAKCRAk1otyXVSH0E+AB/ 4/QCLM/Jt1Ft6+L3vqGmeT72Jr1m8r2AqWrM0owenryfX4e/lAWJ7+vSy+mTqBHszyHWvNijHSlU7q tXjew6DVFG0KHL4j7xE+v3nYifHZTRdAkr28rmnhuqxYIyAyM9Qqm7E26EpV//OtO2JYP0Xd2ALcbG /232BFskNs34J8FKg7BhsAV4vEArs7DRBNQc6bfahnggmmokG9gjotGRhhOd0OeJceWaLKFJF8t8vO 2Zlg0E9pAS5aD4lgT+ETMKDWSEKdvE99flXPuhb8BFVE9pfObITsJHCPUE1w+M54z2yuF99YbiHcSz F/X/Us7qFrGGH2jzSkyXrBASuv9jYL
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SME requires similar setup to that for SVE: disable traps to EL2 and
make sure that the maximum vector length is available to EL1, for SME we
have two traps - one for SME itself and one for TPIDR2.

In addition since we currently make no active use of priority control
for SCMUs we map all SME priorities lower ELs may configure to 0, the
architecture specified minimum priority, to ensure that nothing we
manage is able to configure itself to consume excessive resources.  This
will need to be revisited should there be a need to manage SME
priorities at runtime.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 3198acb2aad8..ea13041a2392 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -143,6 +143,50 @@
 .Lskip_sve_\@:
 .endm
 
+/* SME register access and priority mapping */
+.macro __init_el2_nvhe_sme
+	mrs	x1, id_aa64pfr1_el1
+	ubfx	x1, x1, #ID_AA64PFR1_SME_SHIFT, #4
+	cbz	x1, .Lskip_sme_\@
+
+	bic	x0, x0, #CPTR_EL2_TSM		// Also disable SME traps
+	msr	cptr_el2, x0			// Disable copro. traps to EL2
+	isb
+
+	mrs	x1, sctlr_el2
+	orr	x1, x1, #SCTLR_ELx_ENTP2	// Disable TPIDR2 traps
+	msr	sctlr_el2, x1
+	isb
+
+	mov	x1, #0				// SMCR controls
+
+	mrs_s	x2, SYS_ID_AA64SMFR0_EL1
+	ubfx	x2, x2, #ID_AA64SMFR0_FA64_SHIFT, #1 // Full FP in SM?
+	cbz	x2, .Lskip_sme_fa64_\@
+
+	orr	x1, x1, SMCR_ELx_FA64_MASK
+.Lskip_sme_fa64_\@:
+
+	orr	x1, x1, #SMCR_ELx_LEN_MASK	// Enable full SME vector
+	msr_s	SYS_SMCR_EL2, x1		// length for EL1.
+
+	mrs_s	x1, SYS_SMIDR_EL1		// Priority mapping supported?
+	ubfx    x1, x1, #SYS_SMIDR_EL1_SMPS_SHIFT, #1
+	cbz     x1, .Lskip_sme_\@
+
+	msr_s	SYS_SMPRIMAP_EL2, xzr		// Make all priorities equal
+
+	mrs	x1, id_aa64mmfr1_el1		// HCRX_EL2 present?
+	ubfx	x1, x1, #ID_AA64MMFR1_HCX_SHIFT, #4
+	cbz	x1, .Lskip_sme_\@
+
+	mrs_s	x1, SYS_HCRX_EL2
+	orr	x1, x1, #HCRX_EL2_SMPME_MASK	// Enable priority mapping
+	msr_s	SYS_HCRX_EL2, x1
+
+.Lskip_sme_\@:
+.endm
+
 /* Disable any fine grained traps */
 .macro __init_el2_fgt
 	mrs	x1, id_aa64mmfr0_el1
@@ -196,6 +240,7 @@
 	__init_el2_nvhe_idregs
 	__init_el2_nvhe_cptr
 	__init_el2_nvhe_sve
+	__init_el2_nvhe_sme
 	__init_el2_fgt
 	__init_el2_nvhe_prepare_eret
 .endm
-- 
2.30.2

