Return-Path: <linux-kselftest+bounces-39391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04637B2E4FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 20:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA75E7B3FF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EF428136B;
	Wed, 20 Aug 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgHvn3Wb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD1280CFA;
	Wed, 20 Aug 2025 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714580; cv=none; b=T7YbE2MOAP4+RK3pma6DAl2K3vPvmx3odyQUXGtX//Fy2OyowH5uIqEdq2QfCDOOHe7POKCLs5m4BL6GKYUf09GGAFbLrAVAc0kvgYn5GNe0M58b+GUum0tnmT6S+7N4+tVPpxMfT++W6gtl+lTkirZ3CnNHq9wPz3ug5m8AcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714580; c=relaxed/simple;
	bh=7yYQgVpvwR50FjsSjL4YhMM/gAvl6YUZb0wor5dneuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amWtftpkK/I/vpxRSaj4nbDAHBcCNZhoZOtXIszmROMuVXroVGicMlXxvZx4D+1MUcJ4ajnxPkGebWHQVFqO6rlIE5/WLY2t07eGzpvjFaId13+YI9NIvZ6GN65ldhLIPkZTtmYEu13WgtuJWCutIatd+reNc9YdtUN4G1x0cyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgHvn3Wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A900C116C6;
	Wed, 20 Aug 2025 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755714579;
	bh=7yYQgVpvwR50FjsSjL4YhMM/gAvl6YUZb0wor5dneuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MgHvn3WbTwCQyqYCVGAUi1nOpKIIYwqfk2QqGPUzrFMYPOgDYvpwA4cawpaV+oT5l
	 8Iy4qDlUfBAsWBKGHLkqt3OL56fGoaDfO1dLA5npQO5FV8l+C1Xj/bJVYogzk/Sb2e
	 jiYVed9+cSVfdIVHpn1JvkbCxKGiDBsXx7z8nnFyaEmI88EH0AI5ufGYhJEe+SOGCS
	 EwZjA57ubwKm5RUEt1x4QbEojF+DY8J2fKZCcc9CV5w3H/3q0I8eJ+tcwXaoMdohvU
	 UX+siKVjqePcl39RV1b5+/tw8NHicJQRbJifyPmVWe7F030UQz0ZGw/tpuOdBOtQdh
	 qGFLedDq0Wbrw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 20 Aug 2025 19:29:06 +0100
Subject: [PATCH 4/5] kselftst/arm64: Test NT_ARM_SVE FPSIMD format writes
 on non-SVE systems
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-arm64-sme-ptrace-sme-only-v1-4-f7c22b2871f8@kernel.org>
References: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
In-Reply-To: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 David Spickett <david.spickett@arm.com>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Luis Machado <luis.machado.foss@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2876; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7yYQgVpvwR50FjsSjL4YhMM/gAvl6YUZb0wor5dneuY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBophQDBCnwEb501FLky81u9LBxHlAhDWR4gmn9k
 mEJosS/c1OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKYUAwAKCRAk1otyXVSH
 0LfPCACA73choIeRJkU3n15ARoQsj6wSJ4dWK3BIH5qL6LaiyaCFmR9pGo90ITc9K3MQI3R5RuD
 NfWln+t4vCHrrbV4FJzo0vH1EJC8k70J8ZVAJT+AoYbBEejdXeyZGJEPd+NJP1YgPKNDblzKEcq
 IORUZ5vmvUP5EU2lMpoiWQPwvH7pYPZ0kbOykQ4Rwh385LX4VrkMzyX9Fw7FvLisz5Y7NJiaG2v
 9uBw37OjcjKxKDK+TXLth7oBqzpeEQXfxqTTZ7shCMdU2KKdHaj+aoZZi7g8p2UCFJJ3bv/zeE9
 3aGX0zOsm1hbyBolt4ecosh8w9aoJsWGsEM6fpBNU/NLezP2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to allow exiting streaming mode on systems with SME but not SVE
we allow writes of FPSIMD format data via NT_ARM_SVE even when SVE is not
supported, add a test case that covers this to sve-ptrace.

We do not support reads.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 61 +++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 5f39ca0b4194..fe43fb07ee6c 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -378,6 +378,58 @@ static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 	free(svebuf);
 }
 
+/* Write the FPSIMD registers via the SVE regset when SVE is not supported */
+static void ptrace_sve_fpsimd_no_sve(pid_t child)
+{
+	void *svebuf;
+	struct user_sve_header *sve;
+	struct user_fpsimd_state *fpsimd, new_fpsimd;
+	unsigned int i, j;
+	unsigned char *p;
+	int ret;
+
+	svebuf = malloc(SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD));
+	if (!svebuf) {
+		ksft_test_result_fail("Failed to allocate FPSIMD buffer\n");
+		return;
+	}
+
+	/* On a system without SVE the VL should be set to 0 */
+	memset(svebuf, 0, SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD));
+	sve = svebuf;
+	sve->flags = SVE_PT_REGS_FPSIMD;
+	sve->size = SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD);
+	sve->vl = 0;
+
+	/* Try to set a known FPSIMD state via PT_REGS_SVE */
+	fpsimd = (struct user_fpsimd_state *)((char *)sve +
+					      SVE_PT_FPSIMD_OFFSET);
+	for (i = 0; i < 32; ++i) {
+		p = (unsigned char *)&fpsimd->vregs[i];
+
+		for (j = 0; j < sizeof(fpsimd->vregs[i]); ++j)
+			p[j] = j;
+	}
+
+	ret = set_sve(child, &vec_types[0], sve);
+	ksft_test_result(ret == 0, "FPSIMD write via SVE\n");
+	if (ret) {
+		ksft_test_result_skip("Verify FPSIMD write via SVE\n");
+		goto out;
+	}
+
+	/* Verify via the FPSIMD regset */
+	if (get_fpsimd(child, &new_fpsimd)) {
+		ksft_test_result_skip("Verify FPSIMD write via SVE\n");
+		goto out;
+	}
+	ksft_test_result(memcmp(fpsimd, &new_fpsimd, sizeof(*fpsimd)) == 0,
+			 "Verify FPSIMD write via SVE\n");
+
+out:
+	free(svebuf);
+}
+
 /* Validate attempting to set SVE data and read SVE data */
 static void ptrace_set_sve_get_sve_data(pid_t child,
 					const struct vec_type *type,
@@ -810,6 +862,15 @@ static int do_parent(pid_t child)
 		}
 	}
 
+	/* We support SVE writes of FPSMID format on SME only systems */
+	if (!(getauxval(AT_HWCAP) & HWCAP_SVE) &&
+	    (getauxval(AT_HWCAP2) & HWCAP2_SME)) {
+		ptrace_sve_fpsimd_no_sve(child);
+	} else {
+		ksft_test_result_skip("FPSIMD write via SVE\n");
+		ksft_test_result_skip("Verify FPSIMD write via SVE\n");
+	}
+
 	ret = EXIT_SUCCESS;
 
 error:

-- 
2.39.5


