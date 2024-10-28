Return-Path: <linux-kselftest+bounces-20848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806FC9B3BC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B72F283047
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1664E204F99;
	Mon, 28 Oct 2024 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tspuvubf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9391EF950;
	Mon, 28 Oct 2024 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147212; cv=none; b=HVWjA0q0C/Z8QdHoEGoxgw3UieNkUjNtW2XKovQAuM+QR47RoSDG2E02mCgTWHGvV0j7ceG+1oodkShf4ZJYSc2uVbTebAZQIkTKWi1cP9o6+5U79D++oCG6+XG7MLEGP8NFa0gznumFsE5XBpC535av5zN0QHVpiSvQaQmHb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147212; c=relaxed/simple;
	bh=h2Wehl87NboyijTuuRSERBYg5ixqNkdqmXD3SKKUYoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fO/WGpx5oFoq2cRaJ6E+xwmN1ksIATHKJgzhRG7e9pUbngsyB3vF9D+znUSs8aOgg7Qw/yTXs2h/1gsAuF6uaIziCfiv9Z2CHdKsNjAwyXjrol7b8Q6MBPaN2JDvMLKIJq92Ur5J3yRcB45TafXTb2qztEKocdIWuQdMtLdtG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tspuvubf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC23C4CEE3;
	Mon, 28 Oct 2024 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147211;
	bh=h2Wehl87NboyijTuuRSERBYg5ixqNkdqmXD3SKKUYoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tspuvubf3x10cF+HBMECbXSucjNCcaUq2vMSM+Ymsbw7FHEsOHIyFCtGbCMy0YveM
	 6vEWnLmCJEKbvkua/vL1GOLDLKJSgnu7GSeSKGpFYLQWAR1EDnYSnl+OZiSPZF5Wk9
	 ENN0uljhzz3JZt5BY9khATJ/CwZ2NF/jd7BafqbaY6Sfm+2R1+ifcxz9s3HZ30HEen
	 Zvb7/To34xTgWAtzvA7alyykJxJZiLOlV9mI/kNroZC2gDU1ru4UlSMOWAElXIcEaw
	 Ixe/iqrYd9avLYbNDyouNUElRy4L6l+OR2oeHler24fJd+Z5GRNs6xQuKdanEemc22
	 WhTl+EHDNsPNg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Oct 2024 20:24:18 +0000
Subject: [PATCH 9/9] kselftest/arm64: Add 2024 dpISA extensions to hwcap
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-arm64-2024-dpisa-v1-9-a38d08b008a8@kernel.org>
References: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
In-Reply-To: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=9994; i=broonie@kernel.org;
 h=from:subject:message-id; bh=h2Wehl87NboyijTuuRSERBYg5ixqNkdqmXD3SKKUYoE=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnT5zzlffMJrd59beGZZGRufyGd1YetbuXdbEmZv5gv3E9na
 0/qzk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYSOZK9v+umV++5hrl7Opm46ybzt
 tm9eP431cc6xsWJpatNpvNEBT5cYn0gsnpm5XvtpbOXMi7KYdXeWPfpp2J5/RvGm3tZZwQs3WeWdl2
 8zM9m3+ZerzXzDypc/9hcxWbt/newkXWPdOZAtSnVhsw6/jd5lpe/S9tW4ac109/u/Mu6xRTudl+OT
 efNc4su7eBkUmNRbx5R+LyIB1bxqbPoecZp9YplF34mK7+fIlzqcPOn8YvI2sfsyUcEvfeY9b7WU6+
 YOLx+XIxBoJZf+6faOrJKnIX9M1Ler009JvQJ9UzK2pLWmexxtz/P908JoDbmY05SFKBe6rS5oftMY
 kK4TNt83PFzMqzb0hcKXySZNYEAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We don't actually test SIGILL generation for CMPBR since the need to
branch makes it a pain to generate and the SIGILL detection would be
unreliable anyway. Since this should be very unusual we provide a stub
function rather than supporting a missing function.

The sigill functions aren't well sorted in the file so the ordering is a
bit random.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 273 +++++++++++++++++++++++++++++-
 1 file changed, 271 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index f2d6007a2b983eba77a880ec7e614396a6cb1377..beb380bc09b0d07269a85a60e5d2977367740473 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -46,6 +46,12 @@ static void atomics_sigill(void)
 	asm volatile(".inst 0xb82003ff" : : : );
 }
 
+static void cmpbr_sigill(void)
+{
+	/* Not implemented, too complicated and unreliable anyway */
+}
+
+
 static void crc32_sigill(void)
 {
 	/* CRC32W W0, W0, W1 */
@@ -82,6 +88,18 @@ static void f8fma_sigill(void)
 	asm volatile(".inst 0xec0fc00");
 }
 
+static void f8mm4_sigill(void)
+{
+	/* FMMLA V0.4SH, V0.16B, V0.16B */
+	asm volatile(".inst 0x6e00ec00");
+}
+
+static void f8mm8_sigill(void)
+{
+	/* FMMLA V0.4S, V0.16B, V0.16B */
+	asm volatile(".inst 0x6e80ec00");
+}
+
 static void faminmax_sigill(void)
 {
 	/* FAMIN V0.4H, V0.4H, V0.4H */
@@ -98,6 +116,12 @@ static void fpmr_sigill(void)
 	asm volatile("mrs x0, S3_3_C4_C4_2" : : : "x0");
 }
 
+static void fprcvt_sigill(void)
+{
+	/* FCVTAS S0, H0 */
+	asm volatile(".inst 0x1efa0000");
+}
+
 static void ilrcpc_sigill(void)
 {
 	/* LDAPUR W0, [SP, #8] */
@@ -215,6 +239,42 @@ static void sme2p1_sigill(void)
 	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
 }
 
+static void sme2p2_sigill(void)
+{
+	/* SMSTART SM */
+	asm volatile("msr S0_3_C4_C3_3, xzr" : : : );
+
+	/* UXTB Z0.D, P0/Z, Z0.D  */
+	asm volatile(".inst 0x4c1a000" : : : );
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void sme_aes_sigill(void)
+{
+	/* SMSTART SM */
+	asm volatile("msr S0_3_C4_C3_3, xzr" : : : );
+
+	/* AESD z0.b, z0.b, z0.b */
+	asm volatile(".inst 0x4522e400" : : : "z0");
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void sme_sbitperm_sigill(void)
+{
+	/* SMSTART SM */
+	asm volatile("msr S0_3_C4_C3_3, xzr" : : : );
+
+	/* BDEP Z0.B, Z0.B, Z0.B */
+	asm volatile(".inst 0x4500b400" : : : "z0");
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
 static void smei16i32_sigill(void)
 {
 	/* SMSTART */
@@ -323,13 +383,73 @@ static void smesf8dp4_sigill(void)
 	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
 }
 
+static void smesf8mm8_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* FMMLA V0.4S, V0.16B, V0.16B */
+	asm volatile(".inst 0x6e80ec00");
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smesf8mm4_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* FMMLA V0.4SH, V0.16B, V0.16B */
+	asm volatile(".inst 0x6e00ec00");
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
 static void smesf8fma_sigill(void)
 {
 	/* SMSTART */
 	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
 
-	/* FMLALB V0.8H, V0.16B, V0.16B */
-	asm volatile(".inst 0xec0fc00");
+	/* FMLALB Z0.8H, Z0.B, Z0.B */
+	asm volatile(".inst 0x64205000");
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smesfexpa_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* FEXPA Z0.D, Z0.D */
+	asm volatile(".inst 0x04e0b800");
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smesmop4_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* SMOP4A ZA0.S, Z0.B, { Z0.B - Z1.B } */
+	asm volatile(".inst 0x80108000");
+
+	/* SMSTOP */
+	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
+}
+
+static void smestmop_sigill(void)
+{
+	/* SMSTART */
+	asm volatile("msr S0_3_C4_C7_3, xzr" : : : );
+
+	/* STMOPA ZA0.S, { Z0.H - Z1.H }, Z0.H, Z20[0] */
+	asm volatile(".inst 0x80408008");
 
 	/* SMSTOP */
 	asm volatile("msr S0_3_C4_C6_3, xzr" : : : );
@@ -353,18 +473,42 @@ static void sve2p1_sigill(void)
 	asm volatile(".inst 0x65000000" : : : "z0");
 }
 
+static void sve2p2_sigill(void)
+{
+	/* NOT Z0.D, P0/Z, Z0.D */
+	asm volatile(".inst 0x4cea000" : : : "z0");
+}
+
 static void sveaes_sigill(void)
 {
 	/* AESD z0.b, z0.b, z0.b */
 	asm volatile(".inst 0x4522e400" : : : "z0");
 }
 
+static void sveaes2_sigill(void)
+{
+	/* AESD {Z0.B - Z1.B }, { Z0.B - Z1.B }, Z0.Q */
+	asm volatile(".inst 0x4522ec00" : : : "z0");
+}
+
 static void sveb16b16_sigill(void)
 {
 	/* BFADD ZA.H[W0, 0], {Z0.H-Z1.H} */
 	asm volatile(".inst 0xC1E41C00" : : : );
 }
 
+static void svebfscale_sigill(void)
+{
+	/* BFSCALE Z0.H, P0/M, Z0.H, Z0.H */
+	asm volatile(".inst 0x65098000" : : : "z0");
+}
+
+static void svef16mm_sigill(void)
+{
+	/* FMMLA Z0.S, Z0.H, Z0.H */
+	asm volatile(".inst 0x6420e400");
+}
+
 static void svepmull_sigill(void)
 {
 	/* PMULLB Z0.Q, Z0.D, Z0.D */
@@ -383,6 +527,12 @@ static void svesha3_sigill(void)
 	asm volatile(".inst 0x4203800" : : : "z0");
 }
 
+static void sveeltperm_sigill(void)
+{
+	/* COMPACT Z0.B, P0, Z0.B */
+	asm volatile(".inst 0x5218000" : : : "x0");
+}
+
 static void svesm4_sigill(void)
 {
 	/* SM4E Z0.S, Z0.S, Z0.S */
@@ -458,6 +608,13 @@ static const struct hwcap_data {
 		.cpuinfo = "aes",
 		.sigill_fn = aes_sigill,
 	},
+	{
+		.name = "CMPBR",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_CMPBR,
+		.cpuinfo = "cmpbr",
+		.sigill_fn = cmpbr_sigill,
+	},
 	{
 		.name = "CRC32",
 		.at_hwcap = AT_HWCAP,
@@ -512,6 +669,20 @@ static const struct hwcap_data {
 		.cpuinfo = "f8fma",
 		.sigill_fn = f8fma_sigill,
 	},
+	{
+		.name = "F8MM8",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_F8MM8,
+		.cpuinfo = "f8mm8",
+		.sigill_fn = f8mm8_sigill,
+	},
+	{
+		.name = "F8MM4",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_F8MM4,
+		.cpuinfo = "f8mm4",
+		.sigill_fn = f8mm4_sigill,
+	},
 	{
 		.name = "FAMINMAX",
 		.at_hwcap = AT_HWCAP2,
@@ -534,6 +705,13 @@ static const struct hwcap_data {
 		.sigill_fn = fpmr_sigill,
 		.sigill_reliable = true,
 	},
+	{
+		.name = "FPRCVT",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_FPRCVT,
+		.cpuinfo = "fprcvt",
+		.sigill_fn = fprcvt_sigill,
+	},
 	{
 		.name = "JSCVT",
 		.at_hwcap = AT_HWCAP,
@@ -672,6 +850,20 @@ static const struct hwcap_data {
 		.cpuinfo = "sme2p1",
 		.sigill_fn = sme2p1_sigill,
 	},
+	{
+		.name = "SME 2.2",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SME2P2,
+		.cpuinfo = "sme2p2",
+		.sigill_fn = sme2p2_sigill,
+	},
+	{
+		.name = "SME AES",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SME_AES,
+		.cpuinfo = "smeaes",
+		.sigill_fn = sme_aes_sigill,
+	},
 	{
 		.name = "SME I16I32",
 		.at_hwcap = AT_HWCAP2,
@@ -721,6 +913,13 @@ static const struct hwcap_data {
 		.cpuinfo = "smelutv2",
 		.sigill_fn = smelutv2_sigill,
 	},
+	{
+		.name = "SME SBITPERM",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SME_SBITPERM,
+		.cpuinfo = "smesbitperm",
+		.sigill_fn = sme_sbitperm_sigill,
+	},
 	{
 		.name = "SME SF8FMA",
 		.at_hwcap = AT_HWCAP2,
@@ -728,6 +927,20 @@ static const struct hwcap_data {
 		.cpuinfo = "smesf8fma",
 		.sigill_fn = smesf8fma_sigill,
 	},
+	{
+		.name = "SME SF8MM8",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SME_SF8MM8,
+		.cpuinfo = "smesf8mm8",
+		.sigill_fn = smesf8mm8_sigill,
+	},
+	{
+		.name = "SME SF8MM4",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SME_SF8MM8,
+		.cpuinfo = "smesf8mm4",
+		.sigill_fn = smesf8mm4_sigill,
+	},
 	{
 		.name = "SME SF8DP2",
 		.at_hwcap = AT_HWCAP2,
@@ -742,6 +955,27 @@ static const struct hwcap_data {
 		.cpuinfo = "smesf8dp4",
 		.sigill_fn = smesf8dp4_sigill,
 	},
+	{
+		.name = "SME SFEXPA",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SME_SFEXPA,
+		.cpuinfo = "smesfexpa",
+		.sigill_fn = smesfexpa_sigill,
+	},
+	{
+		.name = "SME SMOP4",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SME_SMOP4,
+		.cpuinfo = "smesmop4",
+		.sigill_fn = smesmop4_sigill,
+	},
+	{
+		.name = "SME STMOP",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SME_STMOP,
+		.cpuinfo = "smestmop",
+		.sigill_fn = smestmop_sigill,
+	},
 	{
 		.name = "SVE",
 		.at_hwcap = AT_HWCAP,
@@ -764,6 +998,13 @@ static const struct hwcap_data {
 		.cpuinfo = "sve2p1",
 		.sigill_fn = sve2p1_sigill,
 	},
+	{
+		.name = "SVE 2.2",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SVE2P2,
+		.cpuinfo = "sve2p2",
+		.sigill_fn = sve2p2_sigill,
+	},
 	{
 		.name = "SVE AES",
 		.at_hwcap = AT_HWCAP2,
@@ -771,6 +1012,34 @@ static const struct hwcap_data {
 		.cpuinfo = "sveaes",
 		.sigill_fn = sveaes_sigill,
 	},
+	{
+		.name = "SVE AES2",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SVE_AES2,
+		.cpuinfo = "sveaes2",
+		.sigill_fn = sveaes2_sigill,
+	},
+	{
+		.name = "SVE BFSCALE",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SVE_BFSCALE,
+		.cpuinfo = "svebfscale",
+		.sigill_fn = svebfscale_sigill,
+	},
+	{
+		.name = "SVE ELTPERM",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SVE_ELTPERM,
+		.cpuinfo = "sveeltperm",
+		.sigill_fn = sveeltperm_sigill,
+	},
+	{
+		.name = "SVE F16MM",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SVE_F16MM,
+		.cpuinfo = "svef16mm",
+		.sigill_fn = svef16mm_sigill,
+	},
 	{
 		.name = "SVE2 B16B16",
 		.at_hwcap = AT_HWCAP2,

-- 
2.39.2


