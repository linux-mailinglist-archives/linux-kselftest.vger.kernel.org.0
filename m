Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58E74D4C5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 16:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbiCJOze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 09:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346818AbiCJOuF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 09:50:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753F818A7BD
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 06:44:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA50F61019
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 14:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9D0C340F7;
        Thu, 10 Mar 2022 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646923498;
        bh=1ZcfM6fNgL6QzNDRPAHRIDvxY/f/Jl+4OdunBdGPjPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgGXbj9B81OXFRO/3ttR9o2YRJ+vgnQzYDNRmE8RtDV2w7tafCNyUAzppOYpexPYz
         NkKN0kNvhEJudNm5UqvFHabRopXAjHZCL2YVX++muRPzI0VNzfV6ecbEuNEGljEGqM
         3wWKdaVECI4FmulHumGsYT/NVzEsnoifZ3GPHQbU8T7d2gb0oiIkLJAay+jxVtw5Hx
         lPTQI54bR+EuUlpdzfIAPvshNbmVtTlP1YHWFPjVQjXCRC7jl+cwc6i5OP/Worq4bm
         iH8fN3mxviENwt2cvVp7TnY6V4YG4vMXRGLzPg4KGu63qeel25jyIZVzezW/Gred4X
         3agsAgqn+5rgw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/4] kselftest/arm64: Handle more kselftest result codes in MTE helpers
Date:   Thu, 10 Mar 2022 14:43:32 +0000
Message-Id: <20220310144335.2097457-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220310144335.2097457-1-broonie@kernel.org>
References: <20220310144335.2097457-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; h=from:subject; bh=1ZcfM6fNgL6QzNDRPAHRIDvxY/f/Jl+4OdunBdGPjPE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiKg6SetzCRkzYMb9qtvanEidxRpe/RBV7Xb4+b8bL JE+047GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYioOkgAKCRAk1otyXVSH0CTNB/ 0Z+mIwJhQrYB3x8bb5LbEyn+3NmEcjZjic7VNvxRmJD1xgRlj1haGU58KgcVnLHASs4cgQTTEgRDmn iF3+BygMSXd/f1BdoCw8JYT7OphRw1hOiJ5iYMlxnMCYM94fa/k0zX4627OCpcsp07OKS1041pCCNm gx1hH+5aLTaeJBYC6dKc4muyTcuPueK6PcxUasGuoXIXImcWYr6ViYPEQDQUHBtFkXMd8SKUiupU+r Z313rGo5RoRejY79ohDbh4MK4yEQArs0Z4dZG1lC5klAeNVpbNyG2EmFOHI/5So0ce8k+iMVIYHC5O Lt4nv4Da7/XTZeoS3k3M5jtUDLOKhI
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The MTE selftests have a helper evaluate_test() which translates a return
code into a call to ksft_test_result_*(). Currently this only handles pass
and fail, silently ignoring any other code. Update the helper to support
skipped tests and log any unknown return codes as an error so we get at
least some diagnostic if anything goes wrong.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/mte/mte_common_util.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.h b/tools/testing/selftests/arm64/mte/mte_common_util.h
index 195a7d1879e6..2d3e71724e55 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.h
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.h
@@ -75,10 +75,21 @@ unsigned int mte_get_pstate_tco(void);
 /* Test framework static inline functions/macros */
 static inline void evaluate_test(int err, const char *msg)
 {
-	if (err == KSFT_PASS)
+	switch (err) {
+	case KSFT_PASS:
 		ksft_test_result_pass(msg);
-	else if (err == KSFT_FAIL)
+		break;
+	case KSFT_FAIL:
 		ksft_test_result_fail(msg);
+		break;
+	case KSFT_SKIP:
+		ksft_test_result_skip(msg);
+		break;
+	default:
+		ksft_test_result_error("Unknown return code %d from %s",
+				       err, msg);
+		break;
+	}
 }
 
 static inline int check_allocated_memory(void *ptr, size_t size,
-- 
2.30.2

