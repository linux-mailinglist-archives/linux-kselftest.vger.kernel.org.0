Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A549A51A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3409059AbiAYAYr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:24:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51450 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2374002AbiAYAPv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 19:15:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B1961496
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B264AC340E9;
        Tue, 25 Jan 2022 00:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069750;
        bh=7/Oa9k998PDiOFMxgdIu7xgaFQQVXei2+n36FomJgfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxzUtY0eF+O8x2qvMhHqZmptzA09F7cNAbHBL+sYO27EsvQUB8Itti6zGYj+2Anvp
         Od5zmPkdCGeOImetsICcMNRPlaJndb3s0CKpZZfqSfOP5Wn2rJEBqWJNZeYuuJ7MAK
         2OIqsBtVDu6jQrvyxtEirnJ1bNhDPwI7yF960hYjN9/D/qgBaXNtlo3GW0DQ2ZMIYb
         msV0MF9PVIsyomIF/M2AC9h5u1XVGCLExk73AhXeXp54bxfDQNulkIxc0JrzICEVba
         BTXMPHAgNtn8VVDIQ9HPoL3qMIReLCM11aEwgr/WW+lXu8u/9TjGHV2fhtDeUIQMne
         h6Dk+bd5V23jA==
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
Subject: [PATCH v8 07/38] arm64/sme: Early CPU setup for SME
Date:   Tue, 25 Jan 2022 00:10:43 +0000
Message-Id: <20220125001114.193425-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3313; h=from:subject; bh=7/Oa9k998PDiOFMxgdIu7xgaFQQVXei2+n36FomJgfI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70AGUGJWblcr9U8MMGDz3Irp0zzx1NQZxFGcRbMc 0sniAxaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9ABgAKCRAk1otyXVSH0DMQB/ 0QmNNICnqrYiIBVCnAHWKoTCCgz0umTS4qCJ1PqF1hwGQvV7Vx/VjT7lzvWyrNW9qhJN1E9Qid01a+ EeD4OVaKwSjEXd52CiBA2Agg7xGo9dJnNFWpmMsR/uXPqbEBWT9PAaLOwDp5n59O7EdBq9y65DipX2 ghKKB24wVLS3BMfdUT0NTWwazazBoRs+x3SQsUrxjCQ4wmdApuSgVnekgkvInqYtsxsrpsWlXVcxsq sLXEUvo37N4hjDkK5y3Ni5DP2L4hVbDu3HcvmavTMuzhsbNs8J817uOtl88gEFyulPEi2qS1mCjBO3 nusP2mrCPLQz1AQ6dv9kwPzHuI0G8v
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
 arch/arm64/include/asm/el2_setup.h | 64 ++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 3198acb2aad8..0e68b478bd94 100644
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
@@ -153,15 +197,26 @@
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x1, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
 	cmp	x1, #3
-	b.lt	.Lset_fgt_\@
+	b.lt	.Lset_debug_fgt_\@
 	/* Disable PMSNEVFR_EL1 read and write traps */
 	orr	x0, x0, #(1 << 62)
 
-.Lset_fgt_\@:
+.Lset_debug_fgt_\@:
 	msr_s	SYS_HDFGRTR_EL2, x0
 	msr_s	SYS_HDFGWTR_EL2, x0
-	msr_s	SYS_HFGRTR_EL2, xzr
-	msr_s	SYS_HFGWTR_EL2, xzr
+
+	mov	x0, xzr
+	mrs	x1, id_aa64pfr1_el1
+	ubfx	x1, x1, #ID_AA64PFR1_SME_SHIFT, #4
+	cbz	x1, .Lset_fgt_\@
+
+	/* Disable nVHE traps of TPIDR2 and SMPRI */
+	orr	x0, x0, #HFGxTR_EL2_nSMPRI_EL1_MASK
+	orr	x0, x0, #HFGxTR_EL2_nTPIDR_EL0_MASK
+
+.Lset_fgt_\@:
+	msr_s	SYS_HFGRTR_EL2, x0
+	msr_s	SYS_HFGWTR_EL2, x0
 	msr_s	SYS_HFGITR_EL2, xzr
 
 	mrs	x1, id_aa64pfr0_el1		// AMU traps UNDEF without AMU
@@ -196,6 +251,7 @@
 	__init_el2_nvhe_idregs
 	__init_el2_nvhe_cptr
 	__init_el2_nvhe_sve
+	__init_el2_nvhe_sme
 	__init_el2_fgt
 	__init_el2_nvhe_prepare_eret
 .endm
-- 
2.30.2

