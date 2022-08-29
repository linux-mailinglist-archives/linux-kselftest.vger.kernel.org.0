Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D865A50CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiH2P5v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH2P5v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6838296779
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04FE5611D6
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F8FC433B5;
        Mon, 29 Aug 2022 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661788669;
        bh=mvOc/8cUdGxzIqrwz0EePKC3ZU/yxeDw11W9Ibm+0ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+QqQkofozBdeTbm1tGQ1cWeLvYtbiyLFq2bIYmco+rnqh/m1b3R46EU8386rzqPv
         YdbZ71EXLQGCh1OqOQS4ygsrGDk9jRrH2A6Y/VPNuTtmDg59BfUIlpMs/EkxCuULih
         jv3rkMFLMtSUbKbGY3tKtFQPNEZnRz4fM9fmdfs7rKmvffa7ny0WvRojra1+mtx6PP
         OC4R6lVsaG982goY0QojIRc4M4XbF/Ym6vaV4xXgpyjmKVzPjWlxr7OTwWiSVbSgB8
         gLKohqBCbYudm5bns+rZo1Yzin6Or3Khheh+IdoW7mVkjBh1bxFuyu5bMHWO7AR0E5
         UJHC11yFE/sXA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/2] kselftest/arm64: Tighten up validation of ZA signal context
Date:   Mon, 29 Aug 2022 16:57:27 +0100
Message-Id: <20220829155728.854947-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829155728.854947-1-broonie@kernel.org>
References: <20220829155728.854947-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=broonie@kernel.org; h=from:subject; bh=mvOc/8cUdGxzIqrwz0EePKC3ZU/yxeDw11W9Ibm+0ns=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOHnq554edjZ4LhfZqZf9K7H9cXh++0PwGRZBP38 y9uOMC+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzh5wAKCRAk1otyXVSH0DPaB/ 4jo1LugwnJ8yGJgncCn4tfCLj6WxYcT/GLXTTosJff7PUMWehmxi+2tG7ElmREuST52F/oAfpHON8J mxha7hg83MifEbBYi40fNF7uzKDRI4fandyRFG/Amxcb0cxYuLgwGTPjJQJx47Fms8Vipiqh70NmD+ 41USUOnBf30WJA6vfcm/rRPh1qpkQlfP/xAknS3fhUIxkecKOEgrKWJLdry4d8hQ+/o7DB4Hac985Q ZVcLpzqxPOdE024LKra/wT5Mj+7Bg0tciIDNAOUYtHwXoyMjVS2mQbFSxhWee4qgFZBbrhCyzNhS0g M7Fu4aWzT4e/sCrEnrajHh7RVjrDUb
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

Currently we accept any size for the ZA signal context that the shared
code will accept which means we don't verify that any data is present.
Since we have enabled ZA we know that there must be data so strengthen
the check to only accept a signal frame with data, and while we're at it
since we enabled ZA but did not set any data we know that ZA must contain
zeros, confirm that.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/signal/testcases/za_regs.c   | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index b94e4f99fcac..2514cb7de525 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -52,6 +52,8 @@ static void setup_za_regs(void)
 	asm volatile(".inst 0xd503457f" : : : );
 }
 
+static char zeros[ZA_SIG_REGS_SIZE(SVE_VQ_MAX)];
+
 static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 			 unsigned int vl)
 {
@@ -87,10 +89,22 @@ static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 		return 1;
 	}
 
-	/* The actual size validation is done in get_current_context() */
+	if (head->size != ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(vl))) {
+		fprintf(stderr, "ZA context size %u, expected %lu\n",
+			head->size, ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(vl)));
+		return 1;
+	}
+
 	fprintf(stderr, "Got expected size %u and VL %d\n",
 		head->size, za->vl);
 
+	/* We didn't load any data into ZA so it should be all zeros */
+	if (memcmp(zeros, (char *)za + ZA_SIG_REGS_OFFSET,
+		   ZA_SIG_REGS_SIZE(sve_vq_from_vl(za->vl))) != 0) {
+		fprintf(stderr, "ZA data invalid\n");
+		return 1;
+	}
+
 	return 0;
 }
 
-- 
2.30.2

