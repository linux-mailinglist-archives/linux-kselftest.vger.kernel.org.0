Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644FF43D11C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbhJ0Sxy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243627AbhJ0Sxx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:53:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DF89610CA;
        Wed, 27 Oct 2021 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360687;
        bh=/s17ACmwQy08kqs9COdIwwDs64OctXotUwEPO09KCro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESRgyBg09QBMTLSkhw89sZoIZiP6I75Yy+G+AIOiR/Etmf3g45wDBRVWbn37mj/T2
         Jq8kBO5ijnflFdahg9/1RQ48QmY1YRSgDMziHD0RorpDHrIswmkIoZKc55SuGtsQLw
         KR7jI/is8fOUFenRlzTzQmuLH2xWaj5ndEu1ZOdDPABvQRLksBQ7j1DIUCuldakw2n
         1wEcCOtRzXHORNPZAVxv7ANvVb9sUDKqwLyrYVf4KKV+EMNKGQK5i6XL/rbmQYXqDz
         ZkgrSjPCpm+YOwfr2itkQdBmf6lLYeDETiLhIq8tyCVM9BNpFp491HB+IDdtxp3nlD
         WvTJIr/hj7WLg==
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
Subject: [PATCH v5 12/38] arm64/sme: Define macros for manually encoding SME instructions
Date:   Wed, 27 Oct 2021 19:43:58 +0100
Message-Id: <20211027184424.166237-13-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; h=from:subject; bh=/s17ACmwQy08kqs9COdIwwDs64OctXotUwEPO09KCro=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ3wrw5kle1YF8ZEm/3MKeZcjPjoYvDoDW0KkPN4 lZQMlOuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd8AAKCRAk1otyXVSH0NSZB/ 0UtW/83vbs0zokrgFiqYzZl/MKtRrwjKrR1F31EA7x/HvS+BpqA09BtZ4omeMw07/1Rh1wqFVomwCd laSSjvqc3zbTE4h/75beADutfX85YvhT0atbXH2XpNTRijO+1Du+XzLqvY1sluY6v2sDKsgCu8/K7c Cy+PRCFJ22xZVUGi9lVqBN+lda1C5FfAvnlpC7rD/OBaVjJrQaQQA+egpVF9xC2gIFkElWWe/Ypu4b XjtGKLLMxHqcmZzSM2Ozg07zDC0zFTn/fZcSPmfEQqgVgcTRw8ve7kYexKIJ3+nP21eAEXO6OM0kyi At5y0EUau/GOv9voKENgR2Y39VQtxV
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

