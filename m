Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CEA433D54
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhJSR0h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234526AbhJSR0g (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1ED46135F;
        Tue, 19 Oct 2021 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664263;
        bh=/s17ACmwQy08kqs9COdIwwDs64OctXotUwEPO09KCro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHM6k8V6uh3p0aS2ITnxe94wc3DfitjvXTzaH4s6C98WFpXR3s4JbDSTDrGlt98KN
         rpPit20ihKd0RD0H1/5nxx5+3UZNUfkKAGa5heWs3ojT1U5Dh3TittyPT6HLBr6Cs9
         2yAAViXZqzUCLJuMFQ3DgNprldXJ4B5rh8YqqSsaIOshs1q3UFMVWl384HnAZoWWdn
         te6iDpkvwbAjikIhhlKPOxZJ3DK318CI2RCU9/bTjGJBeFJSni5x9JPwzODcZedhAg
         IDZol07+eHrfwU9mmYX+vQPa9N59mItxDFR2GqfBkMWLdcTPstvlJU2OYmxxpT78gW
         Uz5TH6jtbdL4g==
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
Subject: [PATCH v3 17/42] arm64/sme: Define macros for manually encoding SME instructions
Date:   Tue, 19 Oct 2021 18:22:22 +0100
Message-Id: <20211019172247.3045838-18-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; h=from:subject; bh=/s17ACmwQy08kqs9COdIwwDs64OctXotUwEPO09KCro=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7Rrw5kle1YF8ZEm/3MKeZcjPjoYvDoDW0KkPN4 lZQMlOuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+0QAKCRAk1otyXVSH0HfOB/ 0Rgc7fa9tFv+YSzyepuBgXH0tiMxdWPT+cpkhNSrw4txBPVU3A8wjvxeFLiIdrzFam2ebTVfJ5KeZw xcnrQ4VEEUdAcdWB9b1LpgF539xgwkK1ziirm1a3UCcCd0ZOgdJVPbX8LXSK48+o9HlC0MbJG0OVCj esEvJgTCzC9qX7KnOQJSzyqB8J7dB2WtaCWCqz8Yjy/Zx5PmHXdwhAFCA+sT92z5QfRnLglf5/TIwa g7lykWjd1ZQOwfRiVfwimyCUsnzJzNhplFIhceZRVVly9eobyNOiR5Enx7kDtlpKrIxxnYdz7zkzhx pFqHPKCX6gaUm1fjcb9E3LETbv5ex1
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

