Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07076012B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJQP0r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiJQP0q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 11:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5967558E4
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 08:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C16F611A8
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 15:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DF1C433B5;
        Mon, 17 Oct 2022 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666020404;
        bh=uqFGlPxL2sBgmYdEcCsoFzK5krIGZNq9NokISwORtCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bW3mubSOHhdnFma4Mxo/gffJqkSH7VoAVR5LHKPeNwb7jrHZzP4XNfa3RLcmzQx+R
         8U1CXaBfv56bOLi005exc0ZOhCeSeJ7GrTtF/REV3nUbhmLnajCRrkFHK8Zos6wBDv
         7Xy3xlz5JjB3oBI8nqC1Il9J2pOt2zBDFTCpyhOl3n0Tchdk7R3gDu3I7HBmhzMBXA
         oTFgpcWwP8YZHHx1MVLY+a8C1jh0XiyBnF+jkrm+Orz5d9g5YwT/u1skwrvauBZJXF
         eltUi5gosXtuAoalR/FVbXQ62hBpSLc3UTVvIJgXrBV2iMNiHvVYOaHCE9W0EFrDE+
         BAtHWvk3R1vng==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/6] kselftest/arm64: Add FEAT_CSSC to the hwcap selftest
Date:   Mon, 17 Oct 2022 16:25:16 +0100
Message-Id: <20221017152520.1039165-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017152520.1039165-1-broonie@kernel.org>
References: <20221017152520.1039165-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=broonie@kernel.org; h=from:subject; bh=uqFGlPxL2sBgmYdEcCsoFzK5krIGZNq9NokISwORtCE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjTXPb/Rd5EqhfLM+KgtgF477vfIapDrMO1jSwnbi+ 2to9MxuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY01z2wAKCRAk1otyXVSH0NQ1B/ 0dtemDowy3YOPeLsxOu8LdltDTCDj/E/442EDhPFu3fdXOjEADS8g/LfzqrVcAVnjx+lQeTc/yYfsd fRNMvZp2PcAZNyPBRX4sn1X4ZLSzE0qh5FlZYYkAecsGZrMM3QaY8ziy+osqsfeyF4ytZKfWw6KJgN lU8lkNhZLaBZF+pPTaqhjvBFjqZc+EouP5Z9qODHDBL6pe0z1y+d5CtDUpXKKYrOV7IOWwyXji1rmq mwqnn68xQRnObIDuY3s4g740c9mhcNVFdSU1GoX5XACg+WddY/Ia5UKSa3xMdfn+i2ButHpX5UrQ94 FYenldPRX+O2OJjnSP8tT3MHsux6PC
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add FEAT_CSSC to the set of features checked by the hwcap selftest.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 9f1a7b5c6193..c7a6b327a7d0 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -33,6 +33,12 @@
  */
 typedef void (*sigill_fn)(void);
 
+static void cssc_sigill(void)
+{
+	/* CNT x0, x0 */
+	asm volatile(".inst 0xdac01c00" : : : "x0");
+}
+
 static void rng_sigill(void)
 {
 	asm volatile("mrs x0, S3_3_C2_C4_0" : : : "x0");
@@ -118,6 +124,13 @@ static const struct hwcap_data {
 	sigill_fn sigill_fn;
 	bool sigill_reliable;
 } hwcaps[] = {
+	{
+		.name = "CSSC",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_CSSC,
+		.cpuinfo = "cssc",
+		.sigill_fn = cssc_sigill,
+	},
 	{
 		.name = "RNG",
 		.at_hwcap = AT_HWCAP2,
-- 
2.30.2

