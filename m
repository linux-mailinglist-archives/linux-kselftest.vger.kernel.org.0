Return-Path: <linux-kselftest+bounces-24038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D4FA04CF7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 00:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4399C163BEE
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 23:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDA1F8693;
	Tue,  7 Jan 2025 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8JkBs5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F351E8837;
	Tue,  7 Jan 2025 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290888; cv=none; b=TrZPSm/HhPtI9pDQB3J1c2vQdy1mFq4tqYFrQfPVWr6UiEEK8GiNm4zyzir0VJ9ZBw2GF6NaIAMapBLCjNsl2O3rN+jGtVwUnxdthtta7vX7iSTHzPMdmtFVS7iNpUDz3EJreb+VDHU8n498CgWrhxioy3WzBVrkf9XQCxZOQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290888; c=relaxed/simple;
	bh=6vsrU75Zvr56XyW0ZUq3O2I72KmLrChf/PHpFFu8cK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ot9TrIoUGOP9LNL1zVmp7Oy8QQTfmsX/Aa6em7xQOvsVRvSiMlNrydNQwgEgO4HQQuQOxruULZ8AHbx8VTiOeKx4cjvxpLHAoJUR/zPVwpO7NFty8zUHjXp4gBX26GiR0dA+dGTy1xj44KDgYz9HvuayCkloldL19WYcdIPGfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8JkBs5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A05C4CED6;
	Tue,  7 Jan 2025 23:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736290887;
	bh=6vsrU75Zvr56XyW0ZUq3O2I72KmLrChf/PHpFFu8cK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h8JkBs5SY4QFGRC3s72U03IZcASlIDKXErI95zCpbRHwzr9osqoJFiiXPsuVJLyrE
	 myNYs1tsTxAGdeOiLvHZ9Un1cYhmX1mpczKqPbpqtvPoJn3wKlo8StjPr1MGVfhbBB
	 71HVzI20FbBA/mQAU0Hriv7YdMv34HKD9MUDrq1l76oNUxN7d38pEpRYSod1+78vo+
	 q0wsD7GQFxf2NXHs6ndmSWvic4o/NLVRTTTB1RMIADK45PPgIkCghpIx0MUSLdt43M
	 Ae1jtPmBNo9ceUbcwRG/6BGCZbEcAKUkyOalQH88agsQFKge4Tmdhz074lR4YfSbxj
	 tPLnZommBSRng==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 07 Jan 2025 22:59:45 +0000
Subject: [PATCH v5 5/5] kselftest/arm64: Add 2024 dpISA extensions to hwcap
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-arm64-2024-dpisa-v5-5-7578da51fc3d@kernel.org>
References: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
In-Reply-To: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=8931; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6vsrU75Zvr56XyW0ZUq3O2I72KmLrChf/PHpFFu8cK0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnfbI064wXKQz0Nysq79Vb7AUqpN72tezRtuDm8RAn
 aWHTYIiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ32yNAAKCRAk1otyXVSH0NInB/
 0Q5KYjkXXOhHhbUdNId9w+UVOj99J7pXIdGcmW3prOSRzrPy68MhX62m0g+9peCK+HQlrq/Syn4qIi
 cVkNEZGBZIZhI3vu2owCXT1u6iHkLYdIBnAPjqMo03NJKaSRed9n4tyX+aRSnh9lUpoaD+sHriQHjo
 8lxCNfuToberka/54a1Pe1NyrK7n3Fd1JU7ZU8Mnk0qDbKc7aAgl4ERd0B5SfS0lPJEk6cnB396fEf
 3JXNoyMkA4AYhA793JoR5XeEqJkRitQyTUdruV5LJOuzurop7KFYW6oD/fwBEqE5Dk9Bk5Gidh+ZeP
 zV1znUz8YWRQp5mTT6QTU/soCIqWju
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add coverage of the hwcaps for the 2024 dpISA extensions to the hwcap
test.

We don't actually test SIGILL generation for CMPBR since the need to
branch makes it a pain to generate and the SIGILL detection would be
unreliable anyway. Since this should be very unusual we provide a stub
function rather than supporting a missing test.

The sigill functions aren't well sorted in the file so the ordering is a
bit random.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 235 +++++++++++++++++++++++++++++-
 1 file changed, 233 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 0029ed9c5c9aa4451f3d0573ee672eca993fb2f4..35f521e5f41c6662c895322e56bf32e2fe83b979 100644
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
 static void gcs_sigill(void)
 {
 	unsigned long *gcspr;
@@ -226,6 +250,42 @@ static void sme2p1_sigill(void)
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
@@ -339,8 +399,44 @@ static void smesf8fma_sigill(void)
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
@@ -364,18 +460,42 @@ static void sve2p1_sigill(void)
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
 	/* BFADD Z0.H, Z0.H, Z0.H */
 	asm volatile(".inst 0x65000000" : : : );
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
@@ -394,6 +514,12 @@ static void svesha3_sigill(void)
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
@@ -469,6 +595,13 @@ static const struct hwcap_data {
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
@@ -523,6 +656,20 @@ static const struct hwcap_data {
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
@@ -545,6 +692,13 @@ static const struct hwcap_data {
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
 		.name = "GCS",
 		.at_hwcap = AT_HWCAP,
@@ -691,6 +845,20 @@ static const struct hwcap_data {
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
@@ -740,6 +908,13 @@ static const struct hwcap_data {
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
@@ -761,6 +936,27 @@ static const struct hwcap_data {
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
@@ -783,6 +979,13 @@ static const struct hwcap_data {
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
@@ -790,6 +993,34 @@ static const struct hwcap_data {
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
2.39.5


