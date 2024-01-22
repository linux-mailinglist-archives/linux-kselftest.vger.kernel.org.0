Return-Path: <linux-kselftest+bounces-3339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716DC836D36
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A436C1C2769C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953E67E81;
	Mon, 22 Jan 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+OzhcYe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3167A14;
	Mon, 22 Jan 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940924; cv=none; b=RcMV6WT28GU3VcMWNBYijZraAyjfbopMdT3qsxS9FYKlAElZEKbKRW2FyKbzgtmeYM4N5LLyFxRFxOq+Iu4Aqf5E8yaNk0RQDJdLy00rQK9PL+FIwMx4JgLE6wiRW/ZnKHKooH/ZYSoQ1h9rBFYunUrt3v7EWCxBNy91i+y2oEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940924; c=relaxed/simple;
	bh=+3OJGPcA4gocLlF8dxkHh0A2qtaF5oUm15PD13fHwu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B5ks6N0/k6tX5rx8Eifqls4a2JFCbrPEDqXgM76ixysut17uCEjOzTJkyoEtlhjMtzIV8d5Uu6xcN5ns9Z5S5s94z/JCfRRxkGzn6yLs7c3Q8c9GBqPjb2tiRHVr6087q4GoBWXWpA3kQv7nBWxP+Z2S4c8mitRAvvJ20IYrVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+OzhcYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13888C433F1;
	Mon, 22 Jan 2024 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940924;
	bh=+3OJGPcA4gocLlF8dxkHh0A2qtaF5oUm15PD13fHwu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F+OzhcYeHCoPhF6DByGbC445Cdpk9jFSz5VSOPM/UmcMHxin/lGpD4SvPXzP3I0BD
	 d3tRSoF7lBcQWMnmn2W+pJgzVCySSwYio1zvAXIdf3rPieMN0R+75dMrSw3YtTOnnQ
	 RuVn3lXPBcaO466WTjXjNdwMYui5l6tP19SE7XuOJ/mzwoni0EcKTdb36cSKafglsl
	 /woOlpFEIVjuVnpTwE/xxx8Jd8ogBRKio5gsAdVdeltKM+I9SV4JhG7XCIU0dHThsd
	 5vYtsptLkpYvn4MoI5E6s9jtD9dke8Cw0aRlUw2+dUxWuJeFjmKKN44yLs1f4Mm5r4
	 BaSoMcUm14LBQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:28:08 +0000
Subject: [PATCH v4 05/14] arm64/ptrace: Expose FPMR via ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-2023-dpisa-v4-5-776e094861df@kernel.org>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
In-Reply-To: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=2856; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+3OJGPcA4gocLlF8dxkHh0A2qtaF5oUm15PD13fHwu4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpeffUvMs6vJdU1QZ53hBW6wQ1GQUnd5367Tw6DR
 zSLoZliJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XnwAKCRAk1otyXVSH0HLsB/
 4hWjANhggdJQpRB27Nm4pEa1/GG0CHzM1UKwggOBac09f6K8CE4B9qjTjKtk7Z/MVpHvE9vvaf7mPc
 nuGphnxI8C6fLfytS1nrGMX+ybjQl8YBANl86yBD7AJsKBnXiYSV+PfkigKeM+hGtYLtVa/YK79Jv6
 Jpo53bg5/R4cUVIaltg3ot8hfeTjXKxp5U/kE3HYHiGsZZ1GhA2AE900U9wSGeaxHYwu0L5VjvJcHc
 EJ9X+MuiWycgrX7Kil3p9J4YQLPnrktNDj+p8J6K4THKYGTQ1soW55R2XV4fLY4K+Gb9FSVHQYCpMn
 ypxKgSMMOqC0HecnNMTyzC4HNDkUqV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add a new regset to expose FPMR via ptrace. It is not added to the FPSIMD
registers since that structure is exposed elsewhere without any allowance
for extension we don't add there.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/ptrace.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index dc6cf0e37194..aacb45bd36e6 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -698,6 +698,39 @@ static int tls_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
+static int fpmr_get(struct task_struct *target, const struct user_regset *regset,
+		   struct membuf to)
+{
+	if (!system_supports_fpmr())
+		return -EINVAL;
+
+	if (target == current)
+		fpsimd_preserve_current_state();
+
+	return membuf_store(&to, target->thread.uw.fpmr);
+}
+
+static int fpmr_set(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	unsigned long fpmr;
+
+	if (!system_supports_fpmr())
+		return -EINVAL;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fpmr, 0, count);
+	if (ret)
+		return ret;
+
+	target->thread.uw.fpmr = fpmr;
+
+	fpsimd_flush_task_state(target);
+
+	return 0;
+}
+
 static int system_call_get(struct task_struct *target,
 			   const struct user_regset *regset,
 			   struct membuf to)
@@ -1419,6 +1452,7 @@ enum aarch64_regset {
 	REGSET_HW_BREAK,
 	REGSET_HW_WATCH,
 #endif
+	REGSET_FPMR,
 	REGSET_SYSTEM_CALL,
 #ifdef CONFIG_ARM64_SVE
 	REGSET_SVE,
@@ -1497,6 +1531,14 @@ static const struct user_regset aarch64_regsets[] = {
 		.regset_get = system_call_get,
 		.set = system_call_set,
 	},
+	[REGSET_FPMR] = {
+		.core_note_type = NT_ARM_FPMR,
+		.n = 1,
+		.size = sizeof(u64),
+		.align = sizeof(u64),
+		.regset_get = fpmr_get,
+		.set = fpmr_set,
+	},
 #ifdef CONFIG_ARM64_SVE
 	[REGSET_SVE] = { /* Scalable Vector Extension */
 		.core_note_type = NT_ARM_SVE,
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 9417309b7230..b54b313bcf07 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -440,6 +440,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
 #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
 #define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
+#define NT_ARM_FPMR	0x40e		/* ARM floating point mode register */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */

-- 
2.30.2


