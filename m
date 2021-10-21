Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702FA436A1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhJUSKl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhJUSKl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:10:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C042561B00;
        Thu, 21 Oct 2021 18:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839705;
        bh=W+84tHLcOZAWN5BwW6ZZUK9hQFjUbMrqnIca5VlL5Q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMcTij8CQdEXv7JHb/5Ms7WwE7ylYBjvM5kalx06rrFDDvf/mkZNdnsuJ5AGD68fn
         X97wBy4loAyHmnS3fFqV9wLtddwylvIyRqGRvpMHZU4fCygaz0vAd6I2vrsor+D2Q3
         Ic9LKvJO+mehgIt8FaznsIbJIuxQL1pTWF0UutbMffdMjCfkvaV7w4/p4ZvtTFI10q
         Zm5liEx/euOKUwGrDTBdZuC64X4bwry2yaj9k5LMYXR2BBkA/LOsBAsOmYFEG95YWU
         Se5t6GJPqrVisBg3yXOD1m8uQW5G62MYRmnMbENTPtkh9og34B/k1yZTxIfJCkTJ6x
         O3nYM69rg23mQ==
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
Subject: [PATCH v4 09/33] arm64/sme: Early CPU setup for SME
Date:   Thu, 21 Oct 2021 19:06:58 +0100
Message-Id: <20211021180722.3699248-10-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; h=from:subject; bh=W+84tHLcOZAWN5BwW6ZZUK9hQFjUbMrqnIca5VlL5Q0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxFQ9ixCcPG5zz09jsii37p/28yPJYGMTr1NVDA EpqAXkWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsRQAKCRAk1otyXVSH0KY0B/ 9WZ+W76RyjcXpQZSCtdmlQUPDpTnP/zpA3NpWk9J4kuefPvUO5MldwKT4LMVXIxeYWi8JDSoM9DBQ/ OP1gF12/wfTZW5gseVMguJw7bPd8c1GSIPJZtsZ5t88Dxes5sDguUbqlIqg08TaW7YvBajHwDb/N3M 3USmDSY79VFjcvXA8HgdTVXVNBBphxDtYt2sP2Nm2whaHxUqNbTQTzOFBERNgMwad/WzP8o9ptha0E 3alh4rJfmgJXIczty56MGjjmo/ztCuL0S8X48XyRO+j5L1xQuUKTJpRQqqUgWTAKJ05o2zVxoaayVX abDw+9IrhiJrnMF7zDsAq1G6BcaaDb
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

