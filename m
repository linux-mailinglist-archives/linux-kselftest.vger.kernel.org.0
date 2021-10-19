Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F340433D55
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhJSR0k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233580AbhJSR0j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF95B61355;
        Tue, 19 Oct 2021 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664266;
        bh=W+84tHLcOZAWN5BwW6ZZUK9hQFjUbMrqnIca5VlL5Q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nT2rPw1kxIRthMmqHdIKS01miRoEUgX8ZXuiNEMbQTHJM/I5tx6/xcTQ1i+vG26JE
         1FhOATqVZo+ndnByDq9/mM2p0roqhTt5UeJ1AVrOs6cSu6b8mX+M1VEnMZufWK4HFM
         uHEpL+USx99TwM0ZP65YD5edmadSjPmgx7NXN9SzigwiipcCWC0R6yHWGa3mPLsSs6
         lkGgD6V5iEWBwg7d0zY8/VArULc+IPwjSbN8Ul8C2EtZZtfl+oSWyUmI/F0L1Q0uuI
         HN6S/YjKzaEE8WiRJrxNTP/hs7V90W99vgbz0KYJDFL064uTQtKQxvk41VzFw21u1m
         8vUfcriMHqMOw==
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
Subject: [PATCH v3 18/42] arm64/sme: Early CPU setup for SME
Date:   Tue, 19 Oct 2021 18:22:23 +0100
Message-Id: <20211019172247.3045838-19-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; h=from:subject; bh=W+84tHLcOZAWN5BwW6ZZUK9hQFjUbMrqnIca5VlL5Q0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7RQ9ixCcPG5zz09jsii37p/28yPJYGMTr1NVDA EpqAXkWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+0QAKCRAk1otyXVSH0BiVB/ 9Ks3jddE0qtlnvrL3jNBKY/XUYAdVLGlmBJi26nvXASOZS+xo4YWxrE4kjG0ykrGJavdz8cs50tB9Y iWiiIETIFtOwtND+mzw0+WhKPQVqIygh8Eme57Za+paMNqX/XdScZz+wGwTFTMOHDVvY8H9A+EqeUy lRGD0Vo6xSlKChK2SN5WtoU1pOKZEAJOTeNOi15vLZGGjjpOwmCH/QC9g4omRicbSOH7Oegz+0NEy5 sn05uZvWavtwJW6tVZwbkcxoCxUxxOGrBnefNjbolS4X2iEVqpKI80Ku8hNsSxYMPb0WwiCBZA+L7W OR834X/7GXqkK68KymoMR7pgS4UZhc
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
 arch/arm64/include/asm/el2_setup.h | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 3198acb2aad8..895a27a1dcb5 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -143,6 +143,41 @@
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
+	mov	x1, #SMCR_ELx_LEN_MASK		// Enable full SME vector
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
@@ -196,6 +231,7 @@
 	__init_el2_nvhe_idregs
 	__init_el2_nvhe_cptr
 	__init_el2_nvhe_sve
+	__init_el2_nvhe_sme
 	__init_el2_fgt
 	__init_el2_nvhe_prepare_eret
 .endm
-- 
2.30.2

