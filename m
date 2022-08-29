Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00575A50FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiH2QHZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiH2QHY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:07:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBE8307A
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECDA7B810FD
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E344EC433D7;
        Mon, 29 Aug 2022 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789240;
        bh=pk7Q79jKBzZEn+CCEUhIxWG1JcQQiZbxATsJw8fMdG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNHHxO3PDEM/3kD3ad3LgTr82b8EMAX0f02krGMx1GVJ6tDWXEuhZGohpdwZ6POiF
         Muu4iNRfuwEKwq2NZsDfLbYAvYFvI0UQIU0GuXt2E30WzbjID586NNaWw13/FXjKB/
         H+T6K0OPbeNU2XMpGWyzJ/bDZB1IVqZ9356U4mOQJZODYVT1ZMNoqCg8vIo9mNoMQp
         3Us4wULGFoAkix3b5tkZF2uReTdMHhJtFAySa5IojXrgeQkJWToISAPYe1USnpJoGo
         Odoix8C5GdnutXQjBCb2HL87vqrTjVDU/QXCM/IU2/CNLpydf6NUNtCpVlM87gcpcR
         tT7ncJjqpRhTg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 01/10] kselftest/arm64: Enumerate SME rather than SVE vector lengths for za_regs
Date:   Mon, 29 Aug 2022 17:06:54 +0100
Message-Id: <20220829160703.874492-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829160703.874492-1-broonie@kernel.org>
References: <20220829160703.874492-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=broonie@kernel.org; h=from:subject; bh=pk7Q79jKBzZEn+CCEUhIxWG1JcQQiZbxATsJw8fMdG8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOQelixHbkYrQD02PlN/alJJwbAH4e3wF+X4P6z3 2La5WAGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzkHgAKCRAk1otyXVSH0GLuB/ 4+xVMiV25xWnWmQv4cg4XglKhR8WJWxMDeo8gVuYdNhHuMxLDCjrBK1Zo5rCdOUfJTRCsY+/YwSjvp mFeQy6KkK6ed9TjmxSQshD8iD1pUP8Rsusx0nwr/+CJkRp0zZ1fXjSHNYoCdPCiP/pZLbgrBjB/RlZ eW/tnB1SE9jnOyCSLNCc7zFYFw5RLfHqkYtVN1vdrIIcsJMrriTgLG0TpE5rKWeUFAWGbbd3j7aB2b ENuf5n/C5d+jCKTlke62zhP/QVAQvUJh3+TRhapMd7C0gBIIbm7oEa1QQYrqjD3DeyrqeqisGzpsrQ ATz1ppjdQhdeedaMRmZ4Gcz7M/dsVM
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

The za_regs signal test was enumerating the SVE vector lengths rather than
the SME vector lengths through cut'n'paste error when determining what to
test. Enumerate the SME vector lengths instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/za_regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index b94e4f99fcac..9f1dd70289be 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -22,10 +22,10 @@ static bool sme_get_vls(struct tdescr *td)
 	int vq, vl;
 
 	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 * Enumerate up to SME_VQ_MAX vector lengths
 	 */
 	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
+		vl = prctl(PR_SME_SET_VL, vq * 16);
 		if (vl == -1)
 			return false;
 
-- 
2.30.2

