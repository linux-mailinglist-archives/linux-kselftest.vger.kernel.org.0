Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C04F94E9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiDHL7e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiDHL7d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A8F7E0AD
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B82D762062
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9931BC385A3;
        Fri,  8 Apr 2022 11:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649419049;
        bh=u8ThAjRPQXl5naPEmM1t6kvpEaCuO/njq9kA/2bUkaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gT6Ga9k/fQdbEwh4LSMP3foQ0XIAqDhvE/rt0EmG7xbtswt2KBSvDLWoEeyf/moQz
         2HxEPLw4WwKRqf2y0q+phyMa8KpxD5/5u8qYxujYLa4+PAKkKeiQ2a74M97iZfbrnP
         9PjWm+ITiRMFx1TnObiHucoUCK2dRlJSlz/4+l+toOFRbLJwcKxq6Z9bON+Ld4eWVv
         Qymg+bEKy2ThGkLcKfFqOupVFkNE2LtmE6VWKYoseeIY76b/p63rq8fRzocsL/quNX
         CcV/u0w1O8NzkVzRMhUyEcxQCGkweqTFuEvb+9weBLyJkpBO9XgOhY9ruun5FgJuGB
         eb9cSp0SMuVEQ==
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
Subject: [PATCH v13 33/39] kselftest/arm64: signal: Handle ZA signal context in core code
Date:   Fri,  8 Apr 2022 12:43:22 +0100
Message-Id: <20220408114328.1401034-34-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; h=from:subject; bh=u8ThAjRPQXl5naPEmM1t6kvpEaCuO/njq9kA/2bUkaU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/Z9fuiv18mtve43r9hrrzXEZhd5PyjxxmEE7XI 5a/zK2SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAf2QAKCRAk1otyXVSH0OtzB/ 4iJ514n8OHIDXidd+nS9c5atRL09wYafgnIobAalZ8bm+nXNNYLbD8K/e1Dt+MgVQ23GHqN30scavM xPl2Y1L+ZR+b5RGCVGRfc3mhp8CywSoEDK7xBQTJMJYzOHlgLrL97c10jAeoQg4WN4PCoN8FHpFeeB xGmzTxUHpAK6w5Es3f1OdgFcXaK/hI9RQpiq413GfqOsHFCaiEaF/JPZfM6AtOXNNTxwFf/ueWNMyZ 2//aTGCyFXM/FckgGbzl/aNvoJFBcGiCahdr7t7I9Hqo3gFb+ZxYHSDQpm4mQ5Yu4Mf2afk2hEXhme DrMCPVhVMwe73FXMk+aQfHBplWRapN
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

