Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F131B5068D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 12:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbiDSKfg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 06:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbiDSKff (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 06:35:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA8D29CB2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 03:32:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39412CE13C8
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A1BC385AD;
        Tue, 19 Apr 2022 10:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650364370;
        bh=xDJBAJu/5veMEVeVdUV21/gXIWmfA4m9JztlrzCV77E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LS2W9vgCEz9aPE59dH87Nos/FEqoHQcq8SvC/Q/3bIzDYOrHX3bTNtFexsstSfSPv
         oFAQQKvkBv3SBevxm3lVY122IWMABl6zhWcuBVGz2kJ3miEJP82pcEoYhMlx5Dfkw5
         usSI0rxAVIxM1ml82ZlCTS6vJu9WU+0cY+7TbliMQe0bkDkaZB2G/Hn3+s8FZHJC25
         s5up6n4nVLQ6ktrojNwPtYA/X9LBCe5OzTqV2SPybnJ2Li8O3BH/KupVa0CKdOd65y
         B9/eNIuYT7Tho0r8PkqKhXj91dTEmEfpabQHg9S3AwpZ2LK7RnbvIpLyMCzTYsJn7t
         MEsjKs9Z0X+Mw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 1/4] kselftest/arm64: Handle more kselftest result codes in MTE helpers
Date:   Tue, 19 Apr 2022 11:32:40 +0100
Message-Id: <20220419103243.24774-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419103243.24774-1-broonie@kernel.org>
References: <20220419103243.24774-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; h=from:subject; bh=xDJBAJu/5veMEVeVdUV21/gXIWmfA4m9JztlrzCV77E=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXo/HPQt3fHsS6WLGobnHqIeZInPVzKOE7Uw0KVpH GpocEQKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6PxwAKCRAk1otyXVSH0BhSB/ wNUiToQ30C3tQVHT36DspATIMEE1k2ETTO91U5kv/2VlNNmTvnZgUC+OoSXlJj1fBitLa9GJXUic3Y daVlmldyuPAxfBrFnaCTUNpi1xp23DHnhIxumsJRxvGATFwJXvFZsoyoIGmtvauk/qjzUNO2G4s3HR dE40KGr8D5jlYivJXyd1pJ2ybXnIN4kn5V537p6euRo1pD55AmbMeSZj4R/EQsJ4Sb6QUSSh1JJ4eY wRkgHmAPEfq1vIPDFnudrd28DKHWNNVGEOd+Sb2aTnzwbOASx9A7rxg0MXKcCZmhOiCsxIC0CX0HQT jyXXiFKq6us9QjJaek03tHJc45twCG
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

The MTE selftests have a helper evaluate_test() which translates a return
code into a call to ksft_test_result_*(). Currently this only handles pass
and fail, silently ignoring any other code. Update the helper to support
skipped tests and log any unknown return codes as an error so we get at
least some diagnostic if anything goes wrong.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
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

