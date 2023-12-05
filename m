Return-Path: <linux-kselftest+bounces-1169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A20805A68
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A881C21169
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3345F1D7;
	Tue,  5 Dec 2023 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWbOTIp7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44504174B;
	Tue,  5 Dec 2023 16:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC32C433C8;
	Tue,  5 Dec 2023 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795113;
	bh=2lwb/HSWzM5tgdqcRY+V9adtYXXgaHL2EUDsgIl8iAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aWbOTIp7BAeM7M9edFghNOB9zuNmHhjVLPEWWnH2qibCMpqrzqRl9/24fBH+GL1Wh
	 74xW+/ox4uc53MhyFjurT11KRQsGatcOjqVWPv5Iw1/ZCs4Dn3o5todVr/L1b3V6E3
	 Bgguk6AVYhQx+3Zqb4Amaamj4rSGzYsvwxO4D6o4Y0sVLX2TuFgXerqEFvtQcx49JM
	 vgVhwi7/4vMztnywEtg+4n9PwiP+LqF6bzigY9TDIe55vm3n/QqRQRJtF0vzHrvKyP
	 Zl2VtdpHsSc38OKVEWirv4yYFRqEpN9q75atScCaEp2ZrG93gXiYIvjefp6J2LsUdP
	 7EKuUnRRoCIbQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:11 +0000
Subject: [PATCH v3 13/21] arm64/ptrace: Expose FPMR via ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-13-dbcbcd867a7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2lwb/HSWzM5tgdqcRY+V9adtYXXgaHL2EUDsgIl8iAQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TzkcQsYbxC6pvJ8YS6+FKAx70IH3oLdIv7YcTz
 BBdO84CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U8wAKCRAk1otyXVSH0HdIB/
 9FycjVcWV3Ped1Oqok9i3fivLEVtROTv4ppONagRAUwzwUXBksNjPtbFcAze0lRYR4qb3YnaFlkpIh
 Yjkdaw2q0PSOtqq2Qs5oBbCu7YlvTDNVU8+Zq5z4+lVtwZDEhxUm0KdiZdujatfHAmk17A2sEiVtNe
 +KEJIp/dZ5lxhuvPOxTy9DblFksEJEWRrpYwY6Gq/CtfbUmXNnfrig+2F6L0hRRl2plNsAyqN6oush
 +2iZHnI6pcJX9MwbKSFSnV0W3bYslqrW/27+k5wbyMyogz+TnGL8JhNe0lmEzxVr53zyNlJIsK2hWm
 SIQTuctqYxvsoVsw/kA/vVzrelW4LU
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
index 20d7ef82de90..cfb8a4d213be 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -697,6 +697,39 @@ static int tls_set(struct task_struct *target, const struct user_regset *regset,
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
+	return membuf_store(&to, target->thread.fpmr);
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
+	target->thread.fpmr = fpmr;
+
+	fpsimd_flush_task_state(target);
+
+	return 0;
+}
+
 static int system_call_get(struct task_struct *target,
 			   const struct user_regset *regset,
 			   struct membuf to)
@@ -1417,6 +1450,7 @@ enum aarch64_regset {
 	REGSET_HW_BREAK,
 	REGSET_HW_WATCH,
 #endif
+	REGSET_FPMR,
 	REGSET_SYSTEM_CALL,
 #ifdef CONFIG_ARM64_SVE
 	REGSET_SVE,
@@ -1495,6 +1529,14 @@ static const struct user_regset aarch64_regsets[] = {
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


