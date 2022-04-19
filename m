Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB0506A26
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiDSL20 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351340AbiDSL2Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7785225281
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1643261328
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE35DC385BC;
        Tue, 19 Apr 2022 11:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367542;
        bh=u8ThAjRPQXl5naPEmM1t6kvpEaCuO/njq9kA/2bUkaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9iCwdf5mOGlA2updZg1t5RT7CM+N3TbUsCu3sp6kt2R9MuABFd1bWSMVb+DGEniq
         VeeqbLNhwdwwJtdGO+xZiL6ERJu4L5eV7B+9+UwmtWtLKsFVM7pD/L9hf1hW8fyw0f
         royKo0Tp5FZq88RAfm1+KdMqVLFhteNiMtw14HQ0idGpIEMnxzioFM930+gWGBcOib
         i+541Qf0X3rIPTRzmiDYqw4hHRhMnIGuBHBX9NeH6PmKygv+l2EfPIzpgXd75E7JlP
         SZ2FoyvqCX3aTcLynxypeZHTxZ8MlSXm/OZa+vDKoqDiPNW5Rv4UI+Tz6FExv+kPRs
         iLm3ZfJQ1/kQA==
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
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v14 33/39] kselftest/arm64: signal: Handle ZA signal context in core code
Date:   Tue, 19 Apr 2022 12:22:41 +0100
Message-Id: <20220419112247.711548-34-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; h=from:subject; bh=u8ThAjRPQXl5naPEmM1t6kvpEaCuO/njq9kA/2bUkaU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXpuB9fuiv18mtve43r9hrrzXEZhd5PyjxxmEE7XI 5a/zK2SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bgQAKCRAk1otyXVSH0OWnB/ 9h1RrDhIjy7qtw9ebchYFW/TBQiSQKcyti1Qo+qAINyNxBJg/dMkzz7mVlfPbSu8RszHUdaC6QgUEg P6WgYabvHmdq4fdubdkWNgbsc6ugmoVIH3wuSVZwe8sM1TrJOlE6/G8Y6WQrasMRO2AZ9GW+mHcexg rvBeSp0EdkV2C0hTdQA9X6c2nCbbSdbRX+6zMKBnVmkU7nrPnWluxZkrYeiiNabdnr3f2Uu/I6g1jQ dc74XoZjgt6+6y+bX54hd0yTku5Atd1VskrFu39nkb3ERT0NI7KeO+1frIZrGnAXCwRaiDrrnvhaBU eq5Zg3d7JPeh18P4s8259k7l2Zx1LO
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As part of the generic code for signal handling test cases we parse all
signal frames to make sure they have at least the basic form we expect
and that there are no unexpected frames present in the signal context.
Add coverage of the ZA signal frame to this code.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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

