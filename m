Return-Path: <linux-kselftest+bounces-39390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C54B2E4F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 20:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A36A23E04
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 18:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C027FB2D;
	Wed, 20 Aug 2025 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emGAKO6l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E12798F0;
	Wed, 20 Aug 2025 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714577; cv=none; b=tf3W1erNXZ6I9lcWeG1bfaFCCdBeTfyw930EpxDspK7WKzvDRDCSDRRPfco4zrrGqLFCA2WiXyUKM1E4D9ALldKp67Jk1FL79sAUBJ9rgelHwNAhH/Uo3DhEHN41HGqlYO6Nxvl4Njco2BPDWThTEraB5zkkDqwRardwN2uf2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714577; c=relaxed/simple;
	bh=0cwUclnjLWnGliCQcpa8hoycuIbbaDjLpbHWDzHQVD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JL+LN6FkzPYw1UEDiR3L+cVI17fjTiA2FcSrPkEqiL7mrWEud49QqcY8xjwQtsL3EVa/nIX4OkAld9OxezbnfSQzgx9Sa7ygXfk/07bQc8survjSeMPyONwx76D4jmkEijU0ZEA8ShRpA3cxi0BMa39gJSFSKBvQNpgaHS54HdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emGAKO6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D45C116B1;
	Wed, 20 Aug 2025 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755714576;
	bh=0cwUclnjLWnGliCQcpa8hoycuIbbaDjLpbHWDzHQVD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=emGAKO6lq7bMnTNnm3mU1HIyCSA9ocOLpKGhpoxGOygM6sqbufmP4kwRhMGv6fHy7
	 YTzIm8s0M5JcIMnQKqZlGFpHOCZy7XYdabrsDp1hmhlqOss2UuelTkDhGqjkF4K7yd
	 l++K3WldnJQvAv+kCYFDCPIOnCwaaRwAZVkf1isYlXySyNvMeFnpN1zBTp0SvQVks6
	 qfCq9H/0f+TpARHNmmtCAnm1b+Qvn+eI0hj5EJt9mCld82ZYwT7Ys7Z2KO4+wk8I5z
	 QtiBh2cr0wfD8btHthGVz4irIXazi4wYRtNxEKMwsLeojiSU/BWbbGGbTGhp7BWYSR
	 cBE/WUykzd0zg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 20 Aug 2025 19:29:05 +0100
Subject: [PATCH 3/5] arm64/sme: Support disabling streaming mode via ptrace
 on SME only systems
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-arm64-sme-ptrace-sme-only-v1-3-f7c22b2871f8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5057; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0cwUclnjLWnGliCQcpa8hoycuIbbaDjLpbHWDzHQVD0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBophQCUfs2yu78q+NnrMRmVLiS0xhc90jY1beJh
 69Mi/yRMfSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKYUAgAKCRAk1otyXVSH
 0AnVB/sE4E2/WH5Q+UMNHOb1lJpIUoWhABDCsgPhH/0D64cih6wUSP19mAaYUERBq11NR1MMLo4
 tvISRMvkgkn3CsbDgxIw1u1vzSYwJzS2+3KouCKwaslYrD8JSwL80sbLsa3kUO8jDCAqWc2NCEj
 WVj9l0xPcFJ8yTmpvqO9iEJyZwQmmelgFCTiXdY1ZHUhHB6RIw2kjFpLbxC08bqgTrsYRPLv9S2
 j7bLp+hRaUyJm7BzXmpq78lF4QdlToyhCFcpH8qYQs8Y1LUM2rfQjt9xrVUHS870EGXa2TgOrLl
 6mF0dm6t+QY25SxCOuJWaatlZjNI1R/8X2Cjd/bVk0CQXiOY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently it is not possible to disable streaming mode via ptrace on SME
only systems, the interface for doing this is to write via NT_ARM_SVE but
such writes will be rejected on a system without SVE support. Enable this
functionality by allowing userspace to write SVE_PT_REGS_FPSIMD format data
via NT_ARM_SVE with the vector length set to 0 on SME only systems. Such
writes currently error since we require that a vector length is specified
which should minimise the risk that existing software is relying on current
behaviour.

Reads are not supported since I am not aware of any use case for this and
there is some risk that an existing userspace application may be confused if
it reads NT_ARM_SVE on a system without SVE. Existing kernels will return
FPSIMD formatted register state from NT_ARM_SVE if full SVE state is not
stored, for example if the task has not used SVE. Returning a vector length
of 0 would create a risk that software would try to do things like allocate
space for register state with zero sizes, while returning a vector length of
128 bits would look like SVE is supported. It seems safer to just not make
the changes to add read support.

It remains possible for userspace to detect a SME only system via the ptrace
interface only since reads of NT_ARM_SSVE and NT_ARM_ZA will succeed while
reads of NT_ARM_SVE will fail. Read/write access to the FPSIMD registers in
non-streaming mode is available via REGSET_FPR.

sve_set_common() already avoids allocating SVE storage when doing a FPSIMD
formatted write and allocating SME storage when doing a NT_ARM_SVE write so
we change the function to validate the new case and skip setting a vector
length for it.

The aim is to make a minimally invasive change, no operation that would
previously have succeeded will be affected, and we use a previously
defined interface in new circumstances rather than define completely new
ABI.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/sve.rst |  5 +++++
 arch/arm64/kernel/ptrace.c       | 40 +++++++++++++++++++++++++++++++++-------
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/arch/arm64/sve.rst b/Documentation/arch/arm64/sve.rst
index 28152492c29c..a61c9d0efe4d 100644
--- a/Documentation/arch/arm64/sve.rst
+++ b/Documentation/arch/arm64/sve.rst
@@ -402,6 +402,11 @@ The regset data starts with struct user_sve_header, containing:
   streaming mode and any SETREGSET of NT_ARM_SSVE will enter streaming mode
   if the target was not in streaming mode.
 
+* On systems that do not support SVE it is permitted to use SETREGSET to
+  write SVE_PT_REGS_FPSIMD formatted data via NT_ARM_SVE, in this case the
+  vector length should be specified as 0. This allows streaming mode to be
+  disabled on systems with SME but not SVE.
+
 * If any register data is provided along with SVE_PT_VL_ONEXEC then the
   registers data will be interpreted with the current vector length, not
   the vector length configured for use on exec.
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4b001121c72d..b9bdd83fbbca 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -912,13 +912,39 @@ static int sve_set_common(struct task_struct *target,
 		return -EINVAL;
 
 	/*
-	 * Apart from SVE_PT_REGS_MASK, all SVE_PT_* flags are consumed by
-	 * vec_set_vector_length(), which will also validate them for us:
+	 * On systems without SVE we accept FPSIMD format writes with
+	 * a VL of 0 to allow exiting streaming mode, otherwise a VL
+	 * is required.
 	 */
-	ret = vec_set_vector_length(target, type, header.vl,
-		((unsigned long)header.flags & ~SVE_PT_REGS_MASK) << 16);
-	if (ret)
-		return ret;
+	if (header.vl) {
+		/*
+		 * If the system does not support SVE we can't
+		 * configure a SVE VL.
+		 */
+		if (!system_supports_sve() && type == ARM64_VEC_SVE)
+			return -EINVAL;
+
+		/*
+		 * Apart from SVE_PT_REGS_MASK, all SVE_PT_* flags are
+		 * consumed by vec_set_vector_length(), which will
+		 * also validate them for us:
+		 */
+		ret = vec_set_vector_length(target, type, header.vl,
+					    ((unsigned long)header.flags & ~SVE_PT_REGS_MASK) << 16);
+		if (ret)
+			return ret;
+	} else {
+		/* If the system supports SVE we require a VL. */
+		if (system_supports_sve())
+			return -EINVAL;
+
+		/*
+		 * Only FPSIMD formatted data with no flags set is
+		 * supported.
+		 */
+		if (header.flags != SVE_PT_REGS_FPSIMD)
+			return -EINVAL;
+	}
 
 	/* Allocate SME storage if necessary, preserving any existing ZA/ZT state */
 	if (type == ARM64_VEC_SME) {
@@ -1016,7 +1042,7 @@ static int sve_set(struct task_struct *target,
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
 {
-	if (!system_supports_sve())
+	if (!system_supports_sve() && !system_supports_sme())
 		return -EINVAL;
 
 	return sve_set_common(target, regset, pos, count, kbuf, ubuf,

-- 
2.39.5


