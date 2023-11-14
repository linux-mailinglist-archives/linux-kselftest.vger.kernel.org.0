Return-Path: <linux-kselftest+bounces-93-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A547EB23C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50A21C20AA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200A23FE28;
	Tue, 14 Nov 2023 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glzj0v12"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3E41231;
	Tue, 14 Nov 2023 14:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3F5C433C7;
	Tue, 14 Nov 2023 14:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972561;
	bh=qb52W/FnN/1SulYmCofB+kYw3kMDdBBbntUr0aosnTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Glzj0v120aflxdYnHPfQd5su3t1oeElorZGM5ygd7L7vJOE02ndlcmY7Cy6kGduK1
	 sdaA9Torg1JX33/HErdM00gVUc4Yqh/YMSPrxgx1yyJYjTekPWbpxdSrVpKBzOm12h
	 +xNaiPXCX+z8QsfRWw7uTr/lNm8LBpGETZuesV83fMfGTZFpbdAEDzfUhgZPuNdJF+
	 3iHql5yIDkbFKLHB8Uh+KswIvKxkQFV2BvcydwFCjFaPlcsXcwvxYrVWSJIuGtha23
	 4Jjenpr+FEIxqd2UaiV/rr+IQjHTR61Wwr0YYtVknPgcdELOHNHJg6VikSRA6wAsBu
	 mzJSIXsVsu1ew==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:34:57 +0000
Subject: [PATCH v2 12/21] arm64/signal: Add FPMR signal handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-12-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qb52W/FnN/1SulYmCofB+kYw3kMDdBBbntUr0aosnTs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WeFMLwbe9KIbWdJ3rpZTtwz0hq1SldLKGbW2Vu
 EfVeOvKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFngAKCRAk1otyXVSH0AzJB/
 4uGbb9V7V0/YWxM9klilQspJUf+w7iLUUTCI7xqcc18nZ/Wz/cFF9nv6RkpZaeFY/SAwefA7DHfx4Z
 QMCbzIe9X5pipNbiJG9HikTVwmhlVT2yzH+594uYvZIOEZyFdXMRlMB2VXaAxYcTBJxhM1YevpTpGI
 BUUwXb16OWpcplqKe0tnS/hNUCA0bJinbG1SBNxIyWQp/lT6ZWoYUoz3rMbkyAuli4QZ3VCVj034oD
 DWPz9KsvWTkw83VNreAjayLOafHUIaPmYFyzcNxGpFopnKUQ6BDyQXV+ASga8MHsn5DC9tePVrZbp7
 OmrqJxLZH65ixKJ57BEe3LjihqK3DM
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
index 0e8beb3349ea..e8c808afcc8a 100644
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
+	current->thread.fpmr = read_sysreg_s(SYS_FPMR);
+
+	__put_user_error(FPMR_MAGIC, &ctx->head.magic, err);
+	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
+	__put_user_error(current->thread.fpmr, &ctx->fpmr, err);
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


