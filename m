Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C05345084F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhKOPci (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:32:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236579AbhKOPcV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:32:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5784761C4F;
        Mon, 15 Nov 2021 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990165;
        bh=/s17ACmwQy08kqs9COdIwwDs64OctXotUwEPO09KCro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8Liziy5kDUIK2YycR47jyrt8HRBSHCTEiTUZsbztEuj6k6MxjCkMGZJJIjSMU5mR
         6TK+qVrCNHJWvFlYuGfkvQRlvPVGsQLLDKgc0dlRj3BRDMmU75yObYv/rosttguhk6
         rHp4LnQNymy5UrEcl/6n9wSbfLZfr21gyjscVWqUhzYY9Emr7eBa8F9olm7FzH8weQ
         L9Zt6PLY2Yle4r2aprFcJib7IGzaPX+QVpIxY3LOpynbDSIrVZAVBOTmbs4kfGhieR
         eeebR/3H/67WaG4vCLQSU+83t5xmncM2glRYvZJvdpXcqQEBzVHizUcHBWXcJ9N4OR
         8q9eAMgcpmwPg==
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
Subject: [PATCH v6 11/37] arm64/sme: Define macros for manually encoding SME instructions
Date:   Mon, 15 Nov 2021 15:28:09 +0000
Message-Id: <20211115152835.3212149-12-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; h=from:subject; bh=/s17ACmwQy08kqs9COdIwwDs64OctXotUwEPO09KCro=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyNrw5kle1YF8ZEm/3MKeZcjPjoYvDoDW0KkPN4 lZQMlOuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8jQAKCRAk1otyXVSH0GkzB/ 45q6uxNTNlv7wVfNUHPzqUvMes2I4XgYd9MMVlQPv0Gq2rUJ5URYlO9a4lhAB386MzYDypnySG4wCZ Rd6MiFjVtG15Qp/Ca1PO3aVl6keumfUTogF7HIXUTuxuSom36R9mfcCNZRk823RuVsFIz3Q45OqHSw BjDKgGctGrjIHqbMfHFP3ecoYZonI+hpDMXbaSuEiFELEsiTz7hgPIGfZH12Ay9R7jcAAfgsyif8tI yKmDaQIDaNNGr4fFDP0AnhmCM+g4pMoXvdetKhATe5yjM+qT5QcRXTAj60rgs0EBv1zUSrhJ3OUA5y JU79oxrwaAGxTBPerYhGhFHUEQyKL6
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As with SVE rather than impose ambitious toolchain requirements for SME we
manually encode the few instructions which we require in order to perform
the work the kernel needs to do. That is currently:

 - Vector store and load for the ZA array.
 - Zeroing of the whole ZA array.

This does not include the SMSTART and SMSTOP instructions which are
single instructions and only used from C code, a later patch will define
them as inline assembly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimdmacros.h | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 2509d7dde55a..f9fb5f111758 100644
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
 
@@ -174,6 +180,44 @@
 		| (\np)
 .endm
 
+/* SME instruction encodings for non-SME-capable assemblers */
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

