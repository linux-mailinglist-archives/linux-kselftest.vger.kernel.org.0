Return-Path: <linux-kselftest+bounces-1175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B48D805A7A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6FBB210D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E760BB1;
	Tue,  5 Dec 2023 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icJCPj4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD660B97;
	Tue,  5 Dec 2023 16:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBED5C433CA;
	Tue,  5 Dec 2023 16:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795135;
	bh=fY7XsyGWBCyMThKR5lWJhW/9PqmzwSI9SznLLw/I8/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=icJCPj4A9WCN6Iwk/ZpD1gRlp/UCIDyT4MxLMmSIfHTnTBS308FzsBcqXUbDgYHGb
	 DsNu/7TbP906USdh7qH0tH3/RNtREyEUytsDI94kRATbCf4mi+gU3CpI1hDw8oJnnP
	 kJJ34YHj4FFEQMXhtKpb+aI6iH8wsDJmLAednLXPphTNzfjN1rfCm9motv27B6jCrV
	 D2wIlz4C3sl3C9i+lQkoygWdmBGpS0pKjJcPBD1w+Bxo8DCisk/2ZEVqEBZn/R+c16
	 AliEgHRQkDZrBMcJjkrq3N9QRwjlT0slBiJrDFcHAIv6+cK+v2Za16ThKR2pM/Lfn9
	 Jfou1Vdf2/98Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:17 +0000
Subject: [PATCH v3 19/21] kselftest/arm64: Add 2023 DPISA hwcap test
 coverage
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-19-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=6393; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fY7XsyGWBCyMThKR5lWJhW/9PqmzwSI9SznLLw/I8/I=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtT8kO86r29PD5Ocp5F8u9Gdv+6n8263fxtm6BsYcPbyN7ls
 /3uwk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYSKQ5+/9i+Y17poocm17YKbVYs/
 vod97Ky15hlr9fTHPX0i1yKb5c/0kn/G+IjVR4QHtjsWVAQeOH2fa/Vk3xd3F9efSPY7i4j63RbAtL
 EadvFW8yM6wycn4JqtT+NDPQ9LVbz7RQfuJq22DO8He6zctXXtO+53A33T3bKaHqefeul5OungjiKr
 twIf6J8NUdLkXTpPlXZNyxTzoouHvziW8WD56mrhVpXPTnG8ODfseGvy96dF8XJE3vO/s2TXLWXcd9
 sSFsV4OeJJQqlC7RauBv/iU2L0Ryosird6blv77NaF0WYMy5ZnoEi0Lh94zb7IE2Ounce5fzR7U8s7
 EzEZL62h1pnH8xoX29E9tFb8MmAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add the hwcaps added for the 2023 DPISA extensions to the hwcaps test
program.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 217 ++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 1189e77c8152..d8909b2b535a 100644
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
@@ -95,6 +130,12 @@ static void lse128_sigill(void)
 		     : "cc", "memory");
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
@@ -216,6 +257,78 @@ static void smef16f16_sigill(void)
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
@@ -353,6 +466,53 @@ static const struct hwcap_data {
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
@@ -360,6 +520,14 @@ static const struct hwcap_data {
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
@@ -411,6 +579,13 @@ static const struct hwcap_data {
 		.cpuinfo = "lse128",
 		.sigill_fn = lse128_sigill,
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
@@ -511,6 +686,48 @@ static const struct hwcap_data {
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


