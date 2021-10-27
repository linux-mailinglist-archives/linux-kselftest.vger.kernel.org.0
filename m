Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3C43D11D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbhJ0Sx4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240445AbhJ0Sx4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:53:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 051A9610CF;
        Wed, 27 Oct 2021 18:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360690;
        bh=hGpG8Ecn+fUBYk7jzxhxs/HLYdIhbVwbCQFcqoaHYxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbRyi3SWphcLWQksmgHumINuAH0riL12ru9FK547ojv6Nh/mwAtLBpcB80Pz2XEZh
         O2W0pTN3nwjvEieBT0n6LMuImB4Ck58JwETai7OyPnT1qAvSCW/BXV7g0B5dqMcz9F
         VFVMgX5ySmjEoWwSMTfBmtKG2VKxZ0m19J+24PzjWeYbfzeh6mlbv+7q/do1YQN9CR
         4m/fOS7UkUuYvB+PICyAA51z6Bu9ZF0E9s2VoF7Yam9FPNCrJiqhZy63ybXMusgjVr
         AgZsMKc83DksZ0pLJYO/LG4aPOIBcWwLLJQBf5lMtyDOcPoevGw50qWfkIbEzavLSD
         FKMl1qnUeECvg==
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
Subject: [PATCH v5 13/38] arm64/sme: Early CPU setup for SME
Date:   Wed, 27 Oct 2021 19:43:59 +0100
Message-Id: <20211027184424.166237-14-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; h=from:subject; bh=hGpG8Ecn+fUBYk7jzxhxs/HLYdIhbVwbCQFcqoaHYxE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ3wyLv2zpnBGtW8BWzvZn6mB1Qgl6PW4FK9CnpW RlSAmYuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd8AAKCRAk1otyXVSH0KnJB/ 48m7N6hB1JXdRSyMmpPqmNzeinoyIzE5mNFVqnxsalMWS4sh1YgIqDq/jSB0d+9Jk6OtMX8mxfOEcP lrzqu93nYMvh/Rl4h3ucjgWTH5EBhbIA0/gyn+MO+n0ktHwVYrH3Sa3JIE6KsOVr9ZQpb04mGgdO3C ef3Vt5VZi3/SBtPJ4uYLzWRTRsMQkJJgcvh6wbGDrxP9WI1+YkG5iTMsIpPebaDMIl0KNOCE944FFY +HOPDRHQnWkRZji/eMU+1zUpr198u6pNSCEMwY12m4lCqFyXzHMdQCee1umhQ9bnHLZ4sxeFBR26cA hJBpWINwyulG/0AugHbzqJz9+lLwqS
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

