Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89649CD6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbiAZPMD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242593AbiAZPMD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:12:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E89AC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:12:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 952C561446
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97690C340E3;
        Wed, 26 Jan 2022 15:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643209922;
        bh=HMQHyHN36InZca7SOj753D+ZgRaa/ByOBuanPgEEWxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRLyk0RrQZ9+rVxuLB43zvOt07MPsgCQBUE7dZPvO4cvnNEDq/XAgma57E3oPcwjI
         lQZohNIpW99WsTLFmrznfH/ahZHq4tOWNdrhWZpEDp19zYNiNoqJ2NpWUvYst2v818
         kEdPDvFjIFv5qsJhUFiil1tqF/dOeiGsI5If6u+fmtKD9w8bAIpsF1LRH+CBeSCNEK
         Vz4U6HoVqS7t9oRKA3p38IvLJsGWhKg+EovTS6VB5faOUv/e7n3qm0Sqs/V7wRen+L
         UaiVxOv4pqG517lIMoCD9XltWugEfHPUFdmBZHVuUlupge9iUz5MxxIDy2WTvmXF2K
         wOuO6qY441fYg==
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
Subject: [PATCH v9 07/40] arm64/sme: Manually encode SME instructions
Date:   Wed, 26 Jan 2022 15:10:47 +0000
Message-Id: <20220126151120.3811248-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3671; h=from:subject; bh=HMQHyHN36InZca7SOj753D+ZgRaa/ByOBuanPgEEWxc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WR8U4t0P2TtzTYSd2s2Hen3CRw27ngQIyNfDOJC 4/nuJxWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFkfAAKCRAk1otyXVSH0GdlB/ 4oKS5E36UbMS2Gr5pcNTJpXfJKqNG/OPJe3K15rM24irlgMZ2rIfRL5Q5aReW/TThySCO815QyK+Zi nQGq9yfvtqmALqMrms2vo6v0yjQxtUthedws3zD4Pi36fOfozGq5G3w1QPYW8poy+axo3FRZIejym2 sLzC1KEHE5TUKkSqGrkzRgjNGigcA4Oa4RZS7DYaFqwYhjNYBPIucUp+TpiqPQh/YuL0U48y88+HCx SScW/qZdtqVZbtj1PDkvXJqkByTLRMb6AjIB0eyHB09JDH6Y42hGDbtazCI1Ic9Wn6AtF0LE+EcM61 KrUWravhZRowxo95x84tVdWXqth6B5
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As with SVE rather than impose ambitious toolchain requirements for SME
we manually encode the few instructions which we require in order to
perform the work the kernel needs to do. The instructions used to save
and restore context are provided as assembler macros while those for
entering and leaving streaming mode are done in asm volatile blocks
since they are expected to be used from C.

We could do the SMSTART and SMSTOP operations with read/modify/write
cycles on SVCR but using the aliases provided for individual field
accesses should be slightly faster. These instructions are aliases for
MSR but since our minimum toolchain requirements are old enough to mean
that we can't use the sX_X_cX_cX_X form and they always use xzr rather
than taking a value like write_sysreg_s() wants we just use .inst.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h       | 25 +++++++++++++
 arch/arm64/include/asm/fpsimdmacros.h | 53 +++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index cb24385e3632..c90f7f99a768 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -249,6 +249,31 @@ static inline void sve_setup(void) { }
 
 #endif /* ! CONFIG_ARM64_SVE */
 
+#ifdef CONFIG_ARM64_SME
+
+static inline void sme_smstart_sm(void)
+{
+	asm volatile(".inst 0xd503437f");
+}
+
+static inline void sme_smstop_sm(void)
+{
+	asm volatile(".inst 0xd503427f");
+}
+
+static inline void sme_smstop(void)
+{
+	asm volatile(".inst 0xd503467f");
+}
+
+#else
+
+static inline void sme_smstart_sm(void) { }
+static inline void sme_smstop_sm(void) { }
+static inline void sme_smstop(void) { }
+
+#endif /* ! CONFIG_ARM64_SME */
+
 /* For use by EFI runtime services calls only */
 extern void __efi_fpsimd_begin(void);
 extern void __efi_fpsimd_end(void);
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 2509d7dde55a..11c426ddd62c 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -93,6 +93,12 @@
 	.endif
 .endm
 
+.macro _sme_check_wv v
+	.if (\v) < 12 || (\v) > 15
+		.error "Bad vector select register \v."
+	.endif
+.endm
+
 /* SVE instruction encodings for non-SVE-capable assemblers */
 /* (pre binutils 2.28, all kernel capable clang versions support SVE) */
 
@@ -174,6 +180,53 @@
 		| (\np)
 .endm
 
+/* SME instruction encodings for non-SME-capable assemblers */
+
+/* RDSVL X\nx, #\imm */
+.macro _sme_rdsvl nx, imm
+	_check_general_reg \nx
+	_check_num (\imm), -0x20, 0x1f
+	.inst	0x04bf5800			\
+		| (\nx)				\
+		| (((\imm) & 0x3f) << 5)
+.endm
+
+/*
+ * STR (vector from ZA array):
+ *	STR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
+ */
+.macro _sme_str_zav nw, nxbase, offset=0
+	_sme_check_wv \nw
+	_check_general_reg \nxbase
+	_check_num (\offset), -0x100, 0xff
+	.inst	0xe1200000			\
+		| (((\nw) & 3) << 13)		\
+		| ((\nxbase) << 5)		\
+		| ((\offset) & 7)
+.endm
+
+/*
+ * LDR (vector to ZA array):
+ *	LDR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
+ */
+.macro _sme_ldr_zav nw, nxbase, offset=0
+	_sme_check_wv \nw
+	_check_general_reg \nxbase
+	_check_num (\offset), -0x100, 0xff
+	.inst	0xe1000000			\
+		| (((\nw) & 3) << 13)		\
+		| ((\nxbase) << 5)		\
+		| ((\offset) & 7)
+.endm
+
+/*
+ * Zero the entire ZA array
+ *	ZERO ZA
+ */
+.macro zero_za
+	.inst 0xc00800ff
+.endm
+
 .macro __for from:req, to:req
 	.if (\from) == (\to)
 		_for__body %\from
-- 
2.30.2

