Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E18592FFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbiHONdV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242981AbiHONdB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:33:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F29017053
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C7E160EC2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DA6C4347C;
        Mon, 15 Aug 2022 13:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570379;
        bh=+LI8T2tA3D0W4jHBlk8SZzjrz3GUYnCv7SGlY2zQn2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1GmFRBFM0w+tDwWi23iCgrRV4kJa2wKqSBSZieRVWbZjH2NiSGHIAYlMi5934kJc
         HZ4mbYoUR5FCNDj2c+r+kWAPUtQxZr+NcewuWTlsh32OHfYSfZwLVdgxwG/+f4fb8z
         puJXvCD+gHxn7BP//8f7v0CoKz+ds8raakUo2YGDCyZ4r2F1aWlulhObL88MjXfaRj
         NaGye+1BYexCl3/1qNfMGmMiykPqx375L147hGO6+Q7q7HRTENH7MF9w5UhQj+eJPe
         T8Yye6IPYS+gZetzGbAKwAHZ62Df7/xq+Jb4JQ7UkHrPSNQcxWV3HTY44HQ65XpM0N
         jKPDjXDDhJA8g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 06/10] kselftest/arm64: Only validate each signal context once
Date:   Mon, 15 Aug 2022 14:32:32 +0100
Message-Id: <20220815133236.235464-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133236.235464-1-broonie@kernel.org>
References: <20220815133236.235464-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3258; i=broonie@kernel.org; h=from:subject; bh=+LI8T2tA3D0W4jHBlk8SZzjrz3GUYnCv7SGlY2zQn2Q=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+krwJUXK/s/g3rF4Rh7MBT99qYdZEnt7xAeJcKyV 7ykOlU6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpK8AAKCRAk1otyXVSH0L8rB/ 9/XHTCkhHe24fXfDewMBsFjhJxRy0vhgiB1aPOa9ssT5vDJkpaiuFpoithcaX0KYt+pAOSiZC5Bdax yhTCEDMEKLqDjwbMe+4Q6/STB36uEtXkUzg0eVp/G4o6QqT7BIf0C9ZguhrAYzollZl6HX5fyNbHVa /QvWZOGnZiLe5aH0ztl7lmnujeOX4/b8/7+xZxVYk2RS01u2++kRidYcPIP0nFpQmnqEvsP6AvSbPF bDG/rJePfmrGW+JiKHJ/+WQ3W5DhJfNFSL2W8wVXUeGRIOMjApyeo5h3AJ/uThP6PlJ9pcNIg3Xym7 1i+MRNmUpUiQnT1JT/l55qtGSNQ8BR
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

Currently for the more complex signal context types we validate the context
specific details the end of the parsing loop validate_reserved() if we've
ever seen a context of that type. This is currently merely a bit inefficient
but will get a bit awkward when we start parsing extra_context, at which
point we will need to reset the head to advance into the extra space that
extra_context provides. Instead only do the more detailed checks on each
context type the first time we see that context type.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/signal/testcases/testcases.c        | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 16dc916939f9..0b3c9b4b1d39 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -105,6 +105,7 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 	bool terminated = false;
 	size_t offs = 0;
 	int flags = 0;
+	int new_flags;
 	struct extra_context *extra = NULL;
 	struct sve_context *sve = NULL;
 	struct za_context *za = NULL;
@@ -120,6 +121,8 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			return false;
 		}
 
+		new_flags = 0;
+
 		switch (head->magic) {
 		case 0:
 			if (head->size)
@@ -133,7 +136,7 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			else if (head->size !=
 				 sizeof(struct fpsimd_context))
 				*err = "Bad size for fpsimd_context";
-			flags |= FPSIMD_CTX;
+			new_flags |= FPSIMD_CTX;
 			break;
 		case ESR_MAGIC:
 			if (head->size != sizeof(struct esr_context))
@@ -144,14 +147,14 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 				*err = "Multiple SVE_MAGIC";
 			/* Size is validated in validate_sve_context() */
 			sve = (struct sve_context *)head;
-			flags |= SVE_CTX;
+			new_flags |= SVE_CTX;
 			break;
 		case ZA_MAGIC:
 			if (flags & ZA_CTX)
 				*err = "Multiple ZA_MAGIC";
 			/* Size is validated in validate_za_context() */
 			za = (struct za_context *)head;
-			flags |= ZA_CTX;
+			new_flags |= ZA_CTX;
 			break;
 		case EXTRA_MAGIC:
 			if (flags & EXTRA_CTX)
@@ -159,7 +162,7 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			else if (head->size !=
 				 sizeof(struct extra_context))
 				*err = "Bad size for extra_context";
-			flags |= EXTRA_CTX;
+			new_flags |= EXTRA_CTX;
 			extra = (struct extra_context *)head;
 			break;
 		case KSFT_BAD_MAGIC:
@@ -192,16 +195,18 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			return false;
 		}
 
-		if (flags & EXTRA_CTX)
+		if (new_flags & EXTRA_CTX)
 			if (!validate_extra_context(extra, err))
 				return false;
-		if (flags & SVE_CTX)
+		if (new_flags & SVE_CTX)
 			if (!validate_sve_context(sve, err))
 				return false;
-		if (flags & ZA_CTX)
+		if (new_flags & ZA_CTX)
 			if (!validate_za_context(za, err))
 				return false;
 
+		flags |= new_flags;
+
 		head = GET_RESV_NEXT_HEAD(head);
 	}
 
-- 
2.30.2

