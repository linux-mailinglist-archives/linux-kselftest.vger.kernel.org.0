Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B047091B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245514AbhLJSru (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49086 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245496AbhLJSrq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3A34B8295C
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8009C341CC;
        Fri, 10 Dec 2021 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161848;
        bh=/s17ACmwQy08kqs9COdIwwDs64OctXotUwEPO09KCro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3XXT+4Gc2GUD6/HsNvWkoP/sIINyXdMIQTwIdgGsdh1ZWEUhOOfZHuQ1KftGAzJQ
         dbKBootd0ze9Hhc8dZ+KyB2jjvwu7pqJs2wgVRyeA8EExTkeH0OO3N3EVvDWwl8esN
         3y6DXFHsThinocfz7rX7cpk/KzuU2UF1W/7wnRgvl0UcYxkVy/miD/8SvEiFftLYTJ
         cZkVJJgXwSg8mlSwXJqEH083Zgqwi2PL3AYv04F1xn9rmKDVZWlX1q/a5kfHoeCidM
         JsC2H619UlZAiNwyeNnGqtWS68YPN0ILCuHaOlSp9NpEHy5fXMtjpS2cBQVLbsTeBH
         edhaI7sFms0Zg==
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
Subject: [PATCH v7 11/37] arm64/sme: Define macros for manually encoding SME instructions
Date:   Fri, 10 Dec 2021 18:41:07 +0000
Message-Id: <20211210184133.320748-12-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; h=from:subject; bh=/s17ACmwQy08kqs9COdIwwDs64OctXotUwEPO09KCro=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59Grw5kle1YF8ZEm/3MKeZcjPjoYvDoDW0KkPN4 lZQMlOuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfRgAKCRAk1otyXVSH0EoZB/ 9Knl3MOvuq6WHspDw+QuJHU4dAUbxTUtfvKZW7ojcsBfwpiZz1pZ+YgPO6rQiGL1E3ja/YK2YpfJcb jkh/2e5k2AfK6JvUv9RvsWMRA/Z7hw5dTK246Nc0RKMpBPZLeUfHBt9g0M9P9bxBk19+TW8kh4+Md7 UvbZpQcrYnA4/WNmS4e85INtXZVvKQNeJFa5qOU8Jggv09rPRtZnOOdB1GDV3oBsCllwksCApTzU1y iORj0a47bGFBHCXzULrtka7CWDckE1ZZn+3a8XTwW/CovVImMEsMIgE2nFGXxJADRFDWeTf5gn/m/Y q1EIp2G/LAOh8Ur5u5kSAncdzydSIl
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

