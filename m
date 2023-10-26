Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1577D831D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbjJZMsZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbjJZMr7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:47:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB7819B0;
        Thu, 26 Oct 2023 05:47:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA5BC433CD;
        Thu, 26 Oct 2023 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324455;
        bh=DV5vbUJP6sOS/WhgLcddZ8/jeMJVH5w/HMgfFosNI2U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oJU/6tspXm3T+rmBm1OmP1zOQmItkFTpSPldry2fDspeBQbWeHcZJDMRKHmFC1kdP
         34h+Hl/W91keQkXjpR4xyPOdYsjkaPZ8GaLbv/WQ0dwGfXWL9RNA5ZLKlQUjz4TXU6
         YkxSw82Kc7Jy5qne7ysYkIlA3Ou2tzFciogJCEyxtdVNQ7gSW4BgRsAmuQ/c41Kqs1
         B6vdhUHM3aTxFWlfe9QlAQQr3A6uklC67kAsT1wp+tjaKkAD8YmlCHHq/i8RADYJjZ
         twoQZXW80OReILO4TR4Tzun95v41dadSIftyGrUYHgRN1IrLHkO63NrMGHxsWpsj+U
         85mCU3B59m4Dw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:33 +0100
Subject: [PATCH 19/21] kselftest/arm64: Add 2023 DPISA hwcap test coverage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-19-8470dd989bb2@kernel.org>
References: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
In-Reply-To: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6411; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DV5vbUJP6sOS/WhgLcddZ8/jeMJVH5w/HMgfFosNI2U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+jl104+scgsdd44BgKZ6kX5xZlo8MgZA2VZjmy
 CCTmbdaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpfowAKCRAk1otyXVSH0M1RCA
 CGyCzAGWtNJ3xowMm7zA0GG2LnTUwdNxwCZCEGjjatbUXI1YHWwKp4jkXnJvM3KjD2hHXxc+8Xuh/9
 QWdITut9UUKpE0fQ3hv2rhW5HlGCGp9w2zSUPBiqRzNuLf1RZLrivP/hsJhAVfOhxr0hvgAdGkBLPn
 FIS+6nLF38ZD3ZRgfM5GkW60S9LlgOI6K0vst7CXYTjEMIoeN8M8VSjH5D7gXcHqsN4ZFGyFScLFde
 JmGeHXPGLrGvawWLyhP7OYU41rNw0izS8e6qYSMdvzcTvvThfU+I7vXIDX4lVAO3L8xi4g8mwqTKCf
 VJyfm5aGGZ3eTzum21es+g0WPPFC4X
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the hwcaps added for the 2023 DPISA extensions to the hwcaps test
program.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 217 ++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index e3d262831d91..ffc0ad1a9b16 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -58,11 +58,46 @@ static void cssc_sigill(void)
 	asm volatile(".inst 0xdac01c00" : : : "x0");
 }
 
+static void f8cvt_sigill(void)
+{
+	/* FSCALE V0.4H, V0.4H, V0.4H */
+	asm volatile(".inst 0x2ec03c00");
+}
+
+static void f8dp2_sigill(void)
+{
+	/* FDOT V0.4H, V0.4H, V0.5H */
+	asm volatile(".inst 0xe40fc00");
+}
+
+static void f8dp4_sigill(void)
+{
+	/* FDOT V0.2S, V0.2S, V0.2S */
+	asm volatile(".inst 0xe00fc00");
+}
+
+static void f8fma_sigill(void)
+{
+	/* FMLALB V0.8H, V0.16B, V0.16B */
+	asm volatile(".inst 0xec0fc00");
+}
+
+static void faminmax_sigill(void)
+{
+	/* FAMIN V0.4H, V0.4H, V0.4H */
+	asm volatile(".inst 0x2ec01c00");
+}
+
 static void fp_sigill(void)
 {
 	asm volatile("fmov s0, #1");
 }
 
+static void fpmr_sigill(void)
+{
+	asm volatile("mrs x0, S3_3_C4_C4_2" : : : "x0");
+}
+
 static void ilrcpc_sigill(void)
 {
 	/* LDAPUR W0, [SP, #8] */
@@ -81,6 +116,12 @@ static void lrcpc_sigill(void)
 	asm volatile(".inst 0xb8bfc3e0" : : : );
 }
 
+static void lut_sigill(void)
+{
+	/* LUTI2 V0.16B, { V0.16B }, V[0] */
+	asm volatile(".inst 0x4e801000");
+}
+
 static void mops_sigill(void)
 {
 	char dst[1], src[1];
@@ -202,6 +243,78 @@ static void smef16f16_sigill(void)
 	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
 }
 
+static void smef8f16_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* FDOT ZA.H[W0, 0], Z0.B-Z1.B, Z0.B-Z1.B */
+	asm volatile(".inst 0xc1a01020" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smef8f32_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* FDOT ZA.S[W0, 0], { Z0.B-Z1.B }, Z0.B[0] */
+	asm volatile(".inst 0xc1500038" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smelutv2_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* LUTI4 { Z0.B-Z3.B }, ZT0, { Z0-Z1 } */
+	asm volatile(".inst 0xc08b0000" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smesf8dp2_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* FDOT Z0.H, Z0.B, Z0.B[0] */
+	asm volatile(".inst 0x64204400" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smesf8dp4_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* FDOT Z0.S, Z0.B, Z0.B[0] */
+	asm volatile(".inst 0xc1a41C00" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smesf8fma_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* FMLALB V0.8H, V0.16B, V0.16B */
+	asm volatile(".inst 0xec0fc00");
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
 static void sve_sigill(void)
 {
 	/* RDVL x0, #0 */
@@ -320,6 +433,53 @@ static const struct hwcap_data {
 		.cpuinfo = "cssc",
 		.sigill_fn = cssc_sigill,
 	},
+	{
+		.name = "F8CVT",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_F8CVT,
+		.cpuinfo = "f8cvt",
+		.sigill_fn = f8cvt_sigill,
+	},
+	{
+		.name = "F8DP4",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_F8DP4,
+		.cpuinfo = "f8dp4",
+		.sigill_fn = f8dp4_sigill,
+	},
+	{
+		.name = "F8DP2",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_F8DP2,
+		.cpuinfo = "f8dp4",
+		.sigill_fn = f8dp2_sigill,
+	},
+	{
+		.name = "F8E5M2",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_F8E5M2,
+		.cpuinfo = "f8e5m2",
+	},
+	{
+		.name = "F8E4M3",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_F8E4M3,
+		.cpuinfo = "f8e4m3",
+	},
+	{
+		.name = "F8FMA",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_F8FMA,
+		.cpuinfo = "f8fma",
+		.sigill_fn = f8fma_sigill,
+	},
+	{
+		.name = "FAMINMAX",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_FAMINMAX,
+		.cpuinfo = "faminmax",
+		.sigill_fn = faminmax_sigill,
+	},
 	{
 		.name = "FP",
 		.at_hwcap = AT_HWCAP,
@@ -327,6 +487,14 @@ static const struct hwcap_data {
 		.cpuinfo = "fp",
 		.sigill_fn = fp_sigill,
 	},
+	{
+		.name = "FPMR",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_FPMR,
+		.cpuinfo = "fpmr",
+		.sigill_fn = fpmr_sigill,
+		.sigill_reliable = true,
+	},
 	{
 		.name = "JSCVT",
 		.at_hwcap = AT_HWCAP,
@@ -364,6 +532,13 @@ static const struct hwcap_data {
 		.sigbus_fn = uscat_sigbus,
 		.sigbus_reliable = true,
 	},
+	{
+		.name = "LUT",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_LUT,
+		.cpuinfo = "lut",
+		.sigill_fn = lut_sigill,
+	},
 	{
 		.name = "MOPS",
 		.at_hwcap = AT_HWCAP2,
@@ -464,6 +639,48 @@ static const struct hwcap_data {
 		.cpuinfo = "smef16f16",
 		.sigill_fn = smef16f16_sigill,
 	},
+	{
+		.name = "SME F8F16",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_F8F16,
+		.cpuinfo = "smef8f16",
+		.sigill_fn = smef8f16_sigill,
+	},
+	{
+		.name = "SME F8F32",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_F8F32,
+		.cpuinfo = "smef8f32",
+		.sigill_fn = smef8f32_sigill,
+	},
+	{
+		.name = "SME LUTV2",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_LUTV2,
+		.cpuinfo = "smelutv2",
+		.sigill_fn = smelutv2_sigill,
+	},
+	{
+		.name = "SME SF8FMA",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_SF8FMA,
+		.cpuinfo = "smesf8fma",
+		.sigill_fn = smesf8fma_sigill,
+	},
+	{
+		.name = "SME SF8DP2",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_SF8DP2,
+		.cpuinfo = "smesf8dp2",
+		.sigill_fn = smesf8dp2_sigill,
+	},
+	{
+		.name = "SME SF8DP4",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME_SF8DP4,
+		.cpuinfo = "smesf8dp4",
+		.sigill_fn = smesf8dp4_sigill,
+	},
 	{
 		.name = "SVE",
 		.at_hwcap = AT_HWCAP,

-- 
2.30.2

