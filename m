Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8B432735
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhJRTND (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRTND (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:13:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A44B6128A;
        Mon, 18 Oct 2021 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584252;
        bh=vmrnb4pZHUUx1LULEOYHjo+TlRUPJefDCczU3XrbKj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOKocOgAf+HDD4drB7nAa8KonBrtVZmCn2E1B2PP+8HyX6jibrRppX1u/YTNEvQIz
         6OmIjvC7lQZTmyJONb9rHDeyaSZ0ERCmrxaSUpHUT8sZY6nHxIJRhEJ0eKjpOSWKgI
         BG3pMFsjA5EtATQxlqSLACVsy2i3xDNI1G/KxxByr2/GVgmkr3PKepE6y4ZV8bZHNh
         CtVAVnQuGnqwtVXJ5S0HU4vIsgZZ6dCDZmsWrml8ZK4WXFcNMAs9LTmovZT3oP8yZb
         /shJWV4K5DTwl5ZqVPFEaf1pAqPwspAWhkWWTWl0bzVa6KzkVVd5M+Bltcwl9yyIUr
         tz6vOhopP3wjw==
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
Subject: [PATCH v2 17/42] arm64/sme: Define macros for manually encoding SME instructions
Date:   Mon, 18 Oct 2021 20:08:33 +0100
Message-Id: <20211018190858.2119209-18-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; h=from:subject; bh=vmrnb4pZHUUx1LULEOYHjo+TlRUPJefDCczU3XrbKj4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcY0sa4NV0tNF/cVSQTzhYx2Lrx0YXiiTS2B3EK8 94Z4JiGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GNAAKCRAk1otyXVSH0MveB/ 9ayPkVSERtHrIlDC866sWID66Ms+71wSQ75c8jUcLweRimYnqojZIj6mh4M9FTt4f61oCwZxC7eqpj NJ0vzOlvOArAtF4SAxRRzD0S7LnCsSzi3WyPAlOK8jH2o0M7d75IJsc9KfaX0PwCQsRqyhpU/OraGW LezLGAIWeHl0wNHGSdrcdB567Sh/JlzcC2fOLkKKpjUQ2hO0SR0A5otzLcAlHChJMbMIT9CjYKEZwh 0gyySOq34qTVb+TeahDjKFtjkfU4+RLVT25e2BZcbcjI+OvQ+xUR0XMZfpUs1EYpu3fBjfMOxwOxhP Utxin1CWYluGwMVjt58dMLXEFgNgwe
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
index b22538a6137e..bc45bb984c49 100644
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

