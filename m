Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3465432736
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRTNG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRTNG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:13:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 480306128E;
        Mon, 18 Oct 2021 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584254;
        bh=W+84tHLcOZAWN5BwW6ZZUK9hQFjUbMrqnIca5VlL5Q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcmiviF9T76l5hnPZdt7QEA3vrkdo4p+udcHcyJB9ywUs+J7egjyaOb8dwcbhc2Qg
         960MbgTvVEjQlJ+yeWj8G7OK+PHIwBTsOgmV9d1XQfs2BvtHeKZvkeU8OvKtRO/Qkn
         dssXwCCgMYF2qHWtVzzdR7M18fRpTmlVS3ANqpxdyRC4gw9UEPPuwG8J1NBG+L5W//
         fyxnERljxreRWvL8IXNDq+2rM8l3WidY6H6S6iONWZm8ogXoPZfiIUxOjhI/koxFO1
         UvJVbNPNxeYAXCaTqe8xie4Q0J5gILpqfrh7OKgXVEt1Rw8YZRS/wKzOYFNfv2iQQb
         4Kn0LsJ2ETM7A==
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
Subject: [PATCH v2 18/42] arm64/sme: Early CPU setup for SME
Date:   Mon, 18 Oct 2021 20:08:34 +0100
Message-Id: <20211018190858.2119209-19-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; h=from:subject; bh=W+84tHLcOZAWN5BwW6ZZUK9hQFjUbMrqnIca5VlL5Q0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcY1Q9ixCcPG5zz09jsii37p/28yPJYGMTr1NVDA EpqAXkWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GNQAKCRAk1otyXVSH0IrUB/ 0f6njAkPfDH7r8U82Yy0V6uKNarO27+7L3OsyrmcmZDshoZTQhYiNbTAMkzgbTEg924Qa6l7y1M2gg fqsHbwNeReftgtYSBtfTCiYLNyTU9ooKOWpVBXngwu0Kvx4hkoTu9Nm9OEoGd4OlC/x7GiBTsG6BlW a6wu3EmYKg4XxbQ1ua0/c4DdL97tlnnxDE7urv2o++UXRUabxEYAQL2niItQihCGovcwR+WPwaCJw3 mwxDg8p36a+H497p+9LlLWYqYuQMT9p89jlBjv4uar3rBFfWi63B5PfQB8483unhxk1oIIRsNaWiOd oqix8eTnfNbnoROYrr6LDuwmVU0Oz5
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

