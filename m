Return-Path: <linux-kselftest+bounces-43248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FFBE0315
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C5619C837A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1882FF171;
	Wed, 15 Oct 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLCrSsBL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D30325480;
	Wed, 15 Oct 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553244; cv=none; b=sW5dCGfKgopiMvso7ffYttPhTxucKmxe4jfaIAbDCmJ3cAD5YjhsyKT7zlFhLZ3SIQYMbGNqJ7ejVRIf2Om3K10uFto117VVPFUh1xWG0A6Nr3kOOHDyI6MR80JAlLKWpeXWPOwvEFE50QsizZH5qwss9qn3f89FKKoV4xa8Weg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553244; c=relaxed/simple;
	bh=+Javi/lDPly3WQ7PYApd6wyA1S6AX6Lvw7kx1jlRpzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2oEuelgPd3+MvaHPuL3r0sT7BoOh79iLkJYoq+xBo/lI99M0AaIoXJtVXMMp6w+LQd39yDGfZ79/PSc03ACzHUCScGnXbKjFT4N74qm9GwEWkBxcS7o8PQei21PO5CF6PM1sf6vhLbcj8kI0DlsETuriE8Yofvhg1cvQZboUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLCrSsBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECE7C113D0;
	Wed, 15 Oct 2025 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760553243;
	bh=+Javi/lDPly3WQ7PYApd6wyA1S6AX6Lvw7kx1jlRpzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OLCrSsBLhmEjVYhn7LiDSt/I3R80NdRN+j2tkSFgxdhT5P5Vy7cyXB5rA3zTZmI1n
	 s/BBh3PFfdw+Iovi8sQCjnzJl47GrqwK3qh2WIDTyRl4eX40gmwD5IzNqVh9kiRTk7
	 gIDxr7UsEH0njWZFfxA7i7K2EfRmsBtYgRqYAI780O0yti0ONIYLs28mvE4ENRLCpH
	 cRandzo1/U6JpmYPz6HzxBBvYP+4ECYD/c6AECYr3OPV6f9I1z9RA+1TptFqp1na2q
	 12qKYa8g7+8FOjrOBgXSDKi0m7jvYNPgpFbOXbsBGFQIYAgcTt0BGNkR2ESPgKEnVj
	 VGQd6Y9KesZmw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 18:56:36 +0100
Subject: [PATCH v2 1/3] arm64/sme: Support disabling streaming mode via
 ptrace on SME only systems
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm64-sme-ptrace-sme-only-v2-1-33c7b2f27cbf@kernel.org>
References: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
In-Reply-To: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
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
X-Mailer: b4 0.15-dev-2a268
X-Developer-Signature: v=1; a=openpgp-sha256; l=5057; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+Javi/lDPly3WQ7PYApd6wyA1S6AX6Lvw7kx1jlRpzI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo7+kTNgWoU2oobNiqUbUdxjB07TnaJTjotU7lQ
 N0SOVhh5giJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO/pEwAKCRAk1otyXVSH
 0K21B/9azbP3GezwJs599o1Jg6RV+tXCfIexZiEGLp7NyRvGtF+FvhYQQnd++R1JKGs2dLnWnE1
 GaJr/2/icMcBiVHubdm45Ao+wrpSYpV/ItmQMXTcyMLEoWAKbuPYI4UI4NKGYKW2s00wngKI+8F
 l9LlU7nOi+Syna5Q54wLpR01noq4g0yiSLgQlfq155icLUaxRTwd0pSBbOBDoknL4MbahuaS0xb
 ucZ6Kr/5CVPT1Y4RGzFfXJawByYClnOWS/oXY78pXUF7B80hXML/TlfcWfJZDhbzNoucqZMc2sU
 rCT6XvTpUzvKggMsyLo282uDA2Sc4NZl8uZgBHyRB2KNlMay
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
2.47.2


