Return-Path: <linux-kselftest+bounces-6025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCFE8743AE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 00:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D62B22D4F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DFC1CA9F;
	Wed,  6 Mar 2024 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EArEt74o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186211C6B9;
	Wed,  6 Mar 2024 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766940; cv=none; b=BkkiUdUhykoEOiS5+TL9TZnM4lLkk1n1sRH77GRqoA9OeHzFXyPTL96UQQ6xDx7Vzc4p8OCgNMRE0DO5Uvy5pqjhPIc7oedSjOQ3T4mS0CAFHdkytV7YtCIuuDkzpCR9z6OoRAs+oRxXA09cHqOH/ey2IivW4FSqM6zEPtG9u7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766940; c=relaxed/simple;
	bh=+3OJGPcA4gocLlF8dxkHh0A2qtaF5oUm15PD13fHwu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deoAl7ZCBZRcltPyflYP9/1JvwGeQjAHWPC3QAQu5VYC5UskqWAq1sEegM/1IUAnaRtr1dxoMLqhVTuDQRD/GJ/IRaGOEzok3it226BNbtXDuQ7VAQ8FoZ2bOB9WOLNkRu1RejW/h8ky+M52/Nip+w8FKbukSxn6f2RMKL1+GVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EArEt74o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF92FC433C7;
	Wed,  6 Mar 2024 23:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709766939;
	bh=+3OJGPcA4gocLlF8dxkHh0A2qtaF5oUm15PD13fHwu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EArEt74olpI6KRT5KcicLl481sZiXKM6wufTOfVETy7pvg3ILClm6vIcXZcp55gHL
	 2CzEBBYGYo2sHPWOd9RG1nT/BzWw0JT44PSQPGgrbNT9u/o8gZ3WxbTHuMI5ZcXkhS
	 O+OWB0SdSD6gJYZnEciIkgfWZW8CJyd3Tq55So+gPt1PWP3eudNbiP58e6R4P+sG/z
	 UTnb2atq9Uh2JVlWnt12X1jNbMoClp/KlD638N5zcE7DVWabbISrvGDaPLYSDui+A6
	 yWKCr3x2MOOopeuvmegEY2jIXe29NJCKT6sga6I4bQ4XALR0FZHAJ725A1OuRp2k3w
	 IvpaK7nnqUdMA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Mar 2024 23:14:50 +0000
Subject: [PATCH v5 5/9] arm64/ptrace: Expose FPMR via ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-arm64-2023-dpisa-v5-5-c568edc8ed7f@kernel.org>
References: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
In-Reply-To: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2856; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+3OJGPcA4gocLlF8dxkHh0A2qtaF5oUm15PD13fHwu4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl6PkElRcXs+yiabpULUsTdQJagvaDXtIMEnxgYOr0
 euD6GdOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZej5BAAKCRAk1otyXVSH0AsGB/
 9Bg13kv/TAR3bL527teaV3G28XZwQ3JQers7/RqVeUIYIjeQJWryi8Q7ES+GfAgGPd2kMb36QgE9ng
 p5eH5aN4VHw/fBMB6gz1yRx4JeqhIlyyH7e49VeQLIdhMz8HXge4w8K9juaJH1x0YIycF2KdwbvFVd
 B8+fw1NJPnUgIFNSb6bis/LKUIWE+/XH7z+1Wne7862MhzMhD0SkFKK+fUowQNLsOY6b5eefIpc4J4
 esqA9OxiqDYbETLWnL6XEe2V76eUMH4eoGln1pEPcwM7ICZ95/om+XzWpE8+hr1E+cFkEPvhe40yYp
 GjdlOIMOhTyq31TsI0Xjm0NaOqQ3es
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


