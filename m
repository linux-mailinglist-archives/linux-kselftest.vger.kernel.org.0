Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2683741E0CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353336AbhI3SR7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353334AbhI3SR6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BF386140F;
        Thu, 30 Sep 2021 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025776;
        bh=bk19DQoRjgMuHaiu/mfLItxOH8DFlqB9cO0cemHl+eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqbHvLd/hgdxwlWTre0QWQcn0HVYyirdiY8fwY44AS0TtwRDZsEIjZ7bK426Yj8AU
         LBaLbImmbTfBRhw5qHgqpKzb/+Li5zKx7NW/i4TT1MIkAInAECHQkpr5yKrrkreutz
         YpdMuibKHGH5Ebeo6A1TxtDVBJWMIHbkelT5RlJfy8dQXgKWT7QjCBAbyHuBrMNrz2
         hvBzffbU+aWrI6SVtaD0UzXIQ5qYEHmrymQRMOMwVKZuDg4wzux7mfTjijAKwrydHR
         EwmyDF47ouu19Lx9jg1n6jlYXqyC6eVnaZsm3IfA4LP7AqBgAZWVueTQvhJyXWAd98
         Rr7GvmGLOazpw==
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
Subject: [PATCH v1 14/38] arm64/sme: Define macros for manually encoding SME instructions
Date:   Thu, 30 Sep 2021 19:11:20 +0100
Message-Id: <20210930181144.10029-15-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2071; h=from:subject; bh=bk19DQoRjgMuHaiu/mfLItxOH8DFlqB9cO0cemHl+eY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3MJwMVNprTX/tMxcIgJJFUk27teqF7s1WCo4fF cElk4aqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9zAAKCRAk1otyXVSH0E1wB/ 0ZbWXYme7KMdPMNZhxh0+knn64XrAHOIkPvx8g3mpM+m9ZGBVZUyRnnVbHpJVl+Z0/dVVie6v6bJGj kIvdOQnZ2Z2prgBWDZzVR742DEoF+eZI7PPqJtdIH7mZqq64QsX527ECjWgJtDBogvxplTssGyb7l0 GOcAVOyihQICDgFE2i3ko95ofB/6rqe4rWXdr4ifvGme1+Nr3v48HjLbiiLaXgdg75utRKEbr3qyVL QpLOepvNI9xBD/al8jwsUXKGHm6ZEwFFgAtbku849w/6eYCO7wKNuwHx/0LMmNuOlo/tSSqkou71yE XqJPY01VJ+hZ8zjCJ2VRwMvslGmhAE
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

We do not use SMSTART and SMSTOP, instead saving and restoring SVCR via
system register access.

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
2.20.1

