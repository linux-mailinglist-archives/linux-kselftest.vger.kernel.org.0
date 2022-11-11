Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AEE6263E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiKKVwH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiKKVvw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854766B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42C69B82802
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55A3C43140;
        Fri, 11 Nov 2022 21:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203508;
        bh=XUlhSyM6tPYEzd0+yzz/l7oRBHYxosNeBw9c71QvHWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2cqmvb7RR7jM2gAE2qBLXHBkeARYrbJqaki9f/saur9wE5zXNQ5YFYa9DeaDn7md
         tQ17Mew8359YbKdZEXJkvSICM5CjVP+u8DeiGC7nD8wXes8Lu2ypXSgyYWJ12cthnJ
         g974mcEL6iaLqbq9LsBm/gHfDl6t6mFe1ZtykxPAi6bRSujGts/V3/yL9IrFEsc2CW
         DH0f+e0jCF8LNzWEVyH4HBzoHmnCi+WZ4IS2gY8q9FBa9niewy1++5UtOjqc46P85D
         hcPE34Kew7jDbiYUnL3LRfLShRnV0lAhx5KhwFliobtlP53zLCddNb0z2/bj02O0dY
         EhEkd9aos8oxQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 21/21] kselftest/arm64: Add coverage of SME 2 and 2.1 hwcaps
Date:   Fri, 11 Nov 2022 21:50:26 +0000
Message-Id: <20221111215026.813348-22-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=broonie@kernel.org; h=from:subject; bh=XUlhSyM6tPYEzd0+yzz/l7oRBHYxosNeBw9c71QvHWc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOhg9X6ib0ecYw1DQ9l67C7OI2vVG2uACZQB5k4 8ahxlbeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DoQAKCRAk1otyXVSH0MDCCA CD63BiV8AaRQC8iFH4KWPiXqqlOeGC1WfwDVAHrswmHQyeXLD+cLaXcdMsY7ZXKiZriyb8cpttM3ws OS3r31Ly5tIdvbxMGNQMwGCt4su7HHR645qLEM9mc5O1maen/npkkRUuOHAY225G9aTJIH88I5w9mi VJJo51WRMvxmgvYohpja5wm9OBYd3slAUS0XJyNx2hqfG+FvAaTCk7xYyftxRhrMSLF1emduW5cdky i6M2pD0Fpuq3Avqe//Bmp4kXZ9CRP/YBBB7f23aJ2FHzjlcNFrAvQcKhkC8M+YDbfwFugj4RuakILA rpsX9QO/QBc2gi74LKQGoJdH/BVWh1
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the hwcaps defined by SME 2 and 2.1 to the hwcaps test.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 115 ++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 9f255bc5f31c..832bb10d282c 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -50,6 +50,78 @@ static void sme_sigill(void)
 	asm volatile(".inst 0x04bf5800" : : : "x0");
 }
 
+static void sme2_sigill(void)
+{
+	/* SMSTART ZA */
+	asm volatile("msr S0_3_C4_C5_3, xzr" : : : );
+
+	/* ZERO ZT0 */
+	asm volatile(".inst 0xc0480001" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void sme2p1_sigill(void)
+{
+	/* SMSTART SM */
+	asm volatile("msr S0_3_C4_C3_3, xzr" : : : );
+
+	/* BFCLAMP { Z0.H - Z1.H }, Z0.H, Z0.H */
+	asm volatile(".inst 0xc120C000" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smei16i32_sigill(void)
+{
+	/* SMSTART SM */
+	asm volatile("msr S0_3_C4_C3_3, xzr" : : : );
+
+	/* SMOPA ZA0.S, P0/M, P0/M, Z0.B, Z0.B */
+	asm volatile(".inst 0xa0800000" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smebi32i32_sigill(void)
+{
+	/* SMSTART SM */
+	asm volatile("msr S0_3_C4_C3_3, xzr" : : : );
+
+	/* BMOPA ZA0.S, P0/M, P0/M, Z0.B, Z0.B */
+	asm volatile(".inst 0x80800008" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smeb16b16_sigill(void)
+{
+	/* SMSTART SM */
+	asm volatile("msr S0_3_C4_C3_3, xzr" : : : );
+
+	/* BFADD ZA.H[W0, 0], {Z0.H-Z1.H} */
+	asm volatile(".inst 0xC1E41C00" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smef16f16_sigill(void)
+{
+	/* SMSTART SM */
+	asm volatile("msr S0_3_C4_C3_3, xzr" : : : );
+
+	/* FADD ZA.H[W0, 0], { Z0.H-Z1.H } */
+	asm volatile(".inst 0xc1a41C00" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
 static void sve_sigill(void)
 {
 	/* RDVL x0, #0 */
@@ -158,6 +230,49 @@ static const struct hwcap_data {
 		.sigill_fn = sme_sigill,
 		.sigill_reliable = true,
 	},
+	{
+		.name = "SME2",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME2,
+		.cpuinfo = "sme2",
+		.sigill_fn = sme2_sigill,
+		.sigill_reliable = true,
+	},
+	{
+		.name = "SME 2.1",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME2P1,
+		.cpuinfo = "sme2p1",
+		.sigill_fn = sme2p1_sigill,
+	},
+	{
+		.name = "SME I16I32",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_I16I32,
+		.cpuinfo = "smei16i32",
+		.sigill_fn = smei16i32_sigill,
+	},
+	{
+		.name = "SME BI32I32",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_BI32I32,
+		.cpuinfo = "smebi32i32",
+		.sigill_fn = smebi32i32_sigill,
+	},
+	{
+		.name = "SME B16B16",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_B16B16,
+		.cpuinfo = "smeb16b16",
+		.sigill_fn = smeb16b16_sigill,
+	},
+	{
+		.name = "SME F16F16",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_F16F16,
+		.cpuinfo = "smef16f16",
+		.sigill_fn = smef16f16_sigill,
+	},
 	{
 		.name = "SVE",
 		.at_hwcap = AT_HWCAP,
-- 
2.30.2

