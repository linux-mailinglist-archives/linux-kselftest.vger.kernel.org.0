Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8B6614CE1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiKAOkO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKAOkN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:40:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116C13F9A
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C4C5B81DEA
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAA4C433C1;
        Tue,  1 Nov 2022 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313610;
        bh=XUlhSyM6tPYEzd0+yzz/l7oRBHYxosNeBw9c71QvHWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alyEZvl28Z4O4IgkJ38uG1KXmoAqmnpxt+wbUjmkSt7Zkn8Wu32TsiZcStBpxVzCq
         ShhMz2Hc9mqGYCezSTEaH9qtRs65OspQCbRPo4pIV6uRGLX+3mOuD/a5nGcUB6uxeY
         vKZzRrPItcF3ABob7s8rNo5rDgm2wyWvLTXKofR6kRtqyHL3MMBsqGtMgtRcisQrhZ
         FsZd0SP6tpTEOSLazL1Znk9v9lLaP9Uhk9sLSuqZkWo1xxHVV7SR3HWUrsUq0VMJU4
         BzgUgl35P0+QprpQVibmxtQmSLLUacuq8vbCiTdtYF3kqhA25wyARJxkvN953dDaPV
         tENW8tu+goJ0Q==
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
Subject: [PATCH v2 21/21] kselftest/arm64: Add coverage of SME 2 and 2.1 hwcaps
Date:   Tue,  1 Nov 2022 14:33:36 +0000
Message-Id: <20221101143336.254445-22-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=broonie@kernel.org; h=from:subject; bh=XUlhSyM6tPYEzd0+yzz/l7oRBHYxosNeBw9c71QvHWc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4/g9X6ib0ecYw1DQ9l67C7OI2vVG2uACZQB5k4 8ahxlbeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuPwAKCRAk1otyXVSH0IbbB/ 40/0CCxUkoXK2fIoK3hrcDrCCkHGciL+SWt/1719NKZ0wvo7IQlzFPdmZi3UEEbdVd6yXpssG75UPh TgJb5hMJYGoZEUAlXNvHecpGf6xTSgEYmRtEyV7grqHAy3/w5b76KLjWYVPS3xABrRMtgenWn1nzZi 7pneNw7AWIRZEz+vu3usscV+XSHYs+N8d97pfVaXyjKNulS0PQdgPc9v4hvjKEkFOK649/lByucOH1 EYFsFSBBzxJ5S5LtMgZzRHQBVfSJrqA7zM1ZosB6PI1DNyWaYvrbzMfE19eEXKUAiqZI2OuH4Mbn93 0m2gfsx82/Sn3U912KVUqioOIhKtw+
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

