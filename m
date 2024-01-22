Return-Path: <linux-kselftest+bounces-3338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB75D836D8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA90B32A9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE4A67A18;
	Mon, 22 Jan 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emPH6bVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10367A14;
	Mon, 22 Jan 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940920; cv=none; b=dbP0zCDnEAjRSkMDCyRUCOiQKr8xI0DMVywbCQthk2B/NIz8YFAVVLm7Kr9XlX5mb8/xqT65lkrou+LhsDVbN1OWdlmEuVskzWa7CfOtFOB4VXNvpe4FG0QtWvwHVMrs9BkQSVpd9J3se6GNUniico9dRG1jT3310AACLOQUGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940920; c=relaxed/simple;
	bh=+pr8+N8Az9rPBwlL16ghSk5vvthU1BeA1Gwu1lfKkCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Awc8BKmHGcwSWREAdXOCTn4rfyzrFKM+2tob7zTNK8eI+IYeN/NuCnxV6LLU9SqslANuD9O2aH5IEsWaKSBwHLhUkKqSFi4ZjvVnq5us9+Y1FSgHQVr1YLPyW9kpiZtzxNZ2OfgdRXGlh24D1eYmKkfhfAvAijiqD40UMlAMMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emPH6bVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D2AC433A6;
	Mon, 22 Jan 2024 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940920;
	bh=+pr8+N8Az9rPBwlL16ghSk5vvthU1BeA1Gwu1lfKkCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=emPH6bVQpR9YrfpoWnw93UNLoNbTh0Y+361RAoYbshNkNb3paif/pghASXMzUNHC3
	 R5UNrGzP4IUhb5AjSfRnxqHnkvFwbRNaJyJC9SKiMDKBk8+SNZZiG5rmYPG00XCMq1
	 m+GeMQcOJKYoqwSjM0RZAUk4e7SSTDTEX5177tftGuh7Eb2UcNPgd0SugL0cvbZbbo
	 Ve5W65yiB23ZF/KBfPEr6KEXOnae95SDkZX0+1eQ1vyBRs+/GMX7YCWcFBwziN46aV
	 bxh1vPnXbf1HW+s09vdN64zuX7rHc+hP+pNXCI/C5bZWeanYEm0lEmzMH/Qb0AUOf1
	 wZuTQ/ZjlSceg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:28:07 +0000
Subject: [PATCH v4 04/14] arm64/signal: Add FPMR signal handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-2023-dpisa-v4-4-776e094861df@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4176; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+pr8+N8Az9rPBwlL16ghSk5vvthU1BeA1Gwu1lfKkCg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpeemMcjtO3x6aJ7Mp4fDPWsxoGQEEMqHIm04K3m
 rl/5oHWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XngAKCRAk1otyXVSH0KAUB/
 oCOckYgqQPWtkIpjbnK5PyBXu7UlJPpDpWBfglbvoK8S/H9Z4HZ0kdtBBefMB5E9ZyuHJti7CF+WSe
 QYhzzpY2wszuTO1J9aQ7F80OP9Itl80Pr2wpEmkGFVuhpt6b4TV9HTgGr+eQEnD5Z5l0tqLEt0SIHd
 l4Q5E7CX25F2BLDc7WeNm0TuaSxhdExtsKQGHqQ8HHqRCRmYS9ElU4Nhr4load+VPGPZJZeX8MToW/
 QZ8tR/MNvV1S5zDLpOc2um68ULskcbSagXXM4Q3oj/mVRmM/BVXFqS4K/rk8GtpZUcdnnBUTA6Wzr2
 CWqJUvAzFRMkpvfUsB5Z3v+f2hI4jN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Expose FPMR in the signal context on systems where it is supported. The
kernel validates the exact size of the FPSIMD registers so we can't readily
add it to fpsimd_context without disruption.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  8 +++++
 arch/arm64/kernel/signal.c               | 59 ++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index f23c1dc3f002..8a45b7a411e0 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -152,6 +152,14 @@ struct tpidr2_context {
 	__u64 tpidr2;
 };
 
+/* FPMR context */
+#define FPMR_MAGIC	0x46504d52
+
+struct fpmr_context {
+	struct _aarch64_ctx head;
+	__u64 fpmr;
+};
+
 #define ZA_MAGIC	0x54366345
 
 struct za_context {
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0e8beb3349ea..460823baa603 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -60,6 +60,7 @@ struct rt_sigframe_user_layout {
 	unsigned long tpidr2_offset;
 	unsigned long za_offset;
 	unsigned long zt_offset;
+	unsigned long fpmr_offset;
 	unsigned long extra_offset;
 	unsigned long end_offset;
 };
@@ -182,6 +183,8 @@ struct user_ctxs {
 	u32 za_size;
 	struct zt_context __user *zt;
 	u32 zt_size;
+	struct fpmr_context __user *fpmr;
+	u32 fpmr_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -227,6 +230,33 @@ static int restore_fpsimd_context(struct user_ctxs *user)
 	return err ? -EFAULT : 0;
 }
 
+static int preserve_fpmr_context(struct fpmr_context __user *ctx)
+{
+	int err = 0;
+
+	current->thread.uw.fpmr = read_sysreg_s(SYS_FPMR);
+
+	__put_user_error(FPMR_MAGIC, &ctx->head.magic, err);
+	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
+	__put_user_error(current->thread.uw.fpmr, &ctx->fpmr, err);
+
+	return err;
+}
+
+static int restore_fpmr_context(struct user_ctxs *user)
+{
+	u64 fpmr;
+	int err = 0;
+
+	if (user->fpmr_size != sizeof(*user->fpmr))
+		return -EINVAL;
+
+	__get_user_error(fpmr, &user->fpmr->fpmr, err);
+	if (!err)
+		write_sysreg_s(fpmr, SYS_FPMR);
+
+	return err;
+}
 
 #ifdef CONFIG_ARM64_SVE
 
@@ -590,6 +620,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->tpidr2 = NULL;
 	user->za = NULL;
 	user->zt = NULL;
+	user->fpmr = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -684,6 +715,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			user->zt_size = size;
 			break;
 
+		case FPMR_MAGIC:
+			if (!system_supports_fpmr())
+				goto invalid;
+
+			if (user->fpmr)
+				goto invalid;
+
+			user->fpmr = (struct fpmr_context __user *)head;
+			user->fpmr_size = size;
+			break;
+
 		case EXTRA_MAGIC:
 			if (have_extra_context)
 				goto invalid;
@@ -806,6 +848,9 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0 && system_supports_tpidr2() && user.tpidr2)
 		err = restore_tpidr2_context(&user);
 
+	if (err == 0 && system_supports_fpmr() && user.fpmr)
+		err = restore_fpmr_context(&user);
+
 	if (err == 0 && system_supports_sme() && user.za)
 		err = restore_za_context(&user);
 
@@ -928,6 +973,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 		}
 	}
 
+	if (system_supports_fpmr()) {
+		err = sigframe_alloc(user, &user->fpmr_offset,
+				     sizeof(struct fpmr_context));
+		if (err)
+			return err;
+	}
+
 	return sigframe_alloc_end(user);
 }
 
@@ -983,6 +1035,13 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		err |= preserve_tpidr2_context(tpidr2_ctx);
 	}
 
+	/* FPMR if supported */
+	if (system_supports_fpmr() && err == 0) {
+		struct fpmr_context __user *fpmr_ctx =
+			apply_user_offset(user, user->fpmr_offset);
+		err |= preserve_fpmr_context(fpmr_ctx);
+	}
+
 	/* ZA state if present */
 	if (system_supports_sme() && err == 0 && user->za_offset) {
 		struct za_context __user *za_ctx =

-- 
2.30.2


