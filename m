Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E5A49CE7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiAZPcf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:32:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51730 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbiAZPcf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:32:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 054726171D
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D45DC340ED;
        Wed, 26 Jan 2022 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211154;
        bh=Sg4MO9YZQcbV+koV+CMJiKCz9E7cFOVY1Zqkeaooq10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQduIQOmrJOzy/JWvamQdjCCLPkjj/8Q2MG5Mc6oWIdhE8pKnEzZ+LYwNMRIIfBPU
         +mMkTLzFvk50lVk3dYqWrLiMBTQ+XHaQzqqHpPLz7p6guM1mVW4VgT7aMEXAbAoNDN
         U2mXP8Cp1acOh4zCA5QPovI8k7OH238FPpfaka1hICKfbRc1aQD/R6jGdwh0chKT/p
         qyhfnj8v3E3/hYjOb/YpDIJ7DwavwmxzD3HdS6/GW+A4yaQRFHCOZckEV+IPeQSTzW
         coDi2mJSz6eCJf1jKH4aahFbzCfPbZFYPrjtzkugXErd4Pji9um7ONscfGj7z5qbLK
         7mjkVnRLE1x2g==
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
Subject: [PATCH v10 34/39] kselftest/arm64: signal: Handle ZA signal context in core code
Date:   Wed, 26 Jan 2022 15:27:44 +0000
Message-Id: <20220126152749.233712-35-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3220; h=from:subject; bh=Sg4MO9YZQcbV+koV+CMJiKCz9E7cFOVY1Zqkeaooq10=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhwvpNMvy7SNGRTsSL8cEuGKairNIi9+eypDo1i pNtel2SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFocAAKCRAk1otyXVSH0AduB/ wJKaFiduycSEaRIKlC4/tzEx3P6IXdC9ijfLHzzeTKlqaZbTFAXrHbt8pfiqjeKBL89jqHxTy+Sf2Z NOPKGmDs+V0DcUF1kFb7sexse5ngt0ifyLFwifKg7gFC1f7H9gNbecN1GInBcV56rJC3wH0lp8slis QFomWLZvt05aY5kCLYjhBRloSLgPm+1r+fogWBj4lpToHs0K5doz93rHE8e5R/NQF+YHmdV5wtqpRd YeACwOAQ2xi7mHqv6QM1bURqxeQa/XsmO0UNQa6YMO4tZPGx5o/jl3dACXz+9wkMZUqHaSRx8dIiBf W2sJpQUdAZBVd9iMNTePAhPFaQmp/0
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As part of the generic code for signal handling test cases we parse all
signal frames to make sure they have at least the basic form we expect
and that there are no unexpected frames present in the signal context.
Add coverage of the ZA signal frame to this code.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/signal/testcases/testcases.c        | 36 +++++++++++++++++++
 .../arm64/signal/testcases/testcases.h        |  3 +-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 8c2a57fc2f9c..84c36bee4d82 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -75,6 +75,31 @@ bool validate_sve_context(struct sve_context *sve, char **err)
 	return true;
 }
 
+bool validate_za_context(struct za_context *za, char **err)
+{
+	/* Size will be rounded up to a multiple of 16 bytes */
+	size_t regs_size
+		= ((ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(za->vl)) + 15) / 16) * 16;
+
+	if (!za || !err)
+		return false;
+
+	/* Either a bare za_context or a za_context followed by regs data */
+	if ((za->head.size != sizeof(struct za_context)) &&
+	    (za->head.size != regs_size)) {
+		*err = "bad size for ZA context";
+		return false;
+	}
+
+	if (!sve_vl_valid(za->vl)) {
+		*err = "SME VL in ZA context invalid";
+
+		return false;
+	}
+
+	return true;
+}
+
 bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 {
 	bool terminated = false;
@@ -82,6 +107,7 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 	int flags = 0;
 	struct extra_context *extra = NULL;
 	struct sve_context *sve = NULL;
+	struct za_context *za = NULL;
 	struct _aarch64_ctx *head =
 		(struct _aarch64_ctx *)uc->uc_mcontext.__reserved;
 
@@ -120,6 +146,13 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			sve = (struct sve_context *)head;
 			flags |= SVE_CTX;
 			break;
+		case ZA_MAGIC:
+			if (flags & ZA_CTX)
+				*err = "Multiple ZA_MAGIC";
+			/* Size is validated in validate_za_context() */
+			za = (struct za_context *)head;
+			flags |= ZA_CTX;
+			break;
 		case EXTRA_MAGIC:
 			if (flags & EXTRA_CTX)
 				*err = "Multiple EXTRA_MAGIC";
@@ -165,6 +198,9 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 		if (flags & SVE_CTX)
 			if (!validate_sve_context(sve, err))
 				return false;
+		if (flags & ZA_CTX)
+			if (!validate_za_context(za, err))
+				return false;
 
 		head = GET_RESV_NEXT_HEAD(head);
 	}
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index ad884c135314..49f1d5de7b5b 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -16,7 +16,8 @@
 
 #define FPSIMD_CTX	(1 << 0)
 #define SVE_CTX		(1 << 1)
-#define EXTRA_CTX	(1 << 2)
+#define ZA_CTX		(1 << 2)
+#define EXTRA_CTX	(1 << 3)
 
 #define KSFT_BAD_MAGIC	0xdeadbeef
 
-- 
2.30.2

