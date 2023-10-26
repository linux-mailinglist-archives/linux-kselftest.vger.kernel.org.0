Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8D7D830D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjJZMrn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjJZMr0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:47:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2010EF;
        Thu, 26 Oct 2023 05:47:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE3AC433CA;
        Thu, 26 Oct 2023 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324433;
        bh=qb52W/FnN/1SulYmCofB+kYw3kMDdBBbntUr0aosnTs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZrNfCl1/bl7Dw8ATVLKX3hSzMdpCuDkyfGPm1s6Prn3GMokNNRfjlBD1o0LRHD0DI
         Gph6e0BlfyssVsxdu1ayodPMxz7TAtb53sS2rp+Vg6BOY8+zBRQlfW+/DWq0ocOdWw
         IWQTcjwXJXpVu8ZW32xlwKsJo5ITD/Iw1h45Nirj9L3PzQk2Fw8OQGgMqR/mhVrizL
         CiPR+sGSEwjc0DOoYxGSiHC4waIL7CLTTT3B347MzQG99zOA8rKI/Ry8yN6QcqyMOB
         PdEBqOnSZjPI4iK/kE5Zh9lfKFRBlVJimaD/cpBmHSJBJl3yQCVy45lupOb/aX05EG
         kxm8dVU4lxofg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:26 +0100
Subject: [PATCH 12/21] arm64/signal: Add FPMR signal handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-12-8470dd989bb2@kernel.org>
References: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
In-Reply-To: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qb52W/FnN/1SulYmCofB+kYw3kMDdBBbntUr0aosnTs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+dtRDImwIBFnMpAxfDCPPH5HNwneLMpNDGTRSR
 DPy3hQ2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpfnQAKCRAk1otyXVSH0GkoB/
 9pPH4k8PLyBH5X4ES02nO3SZvxFJasGzc40jJ9n2AG7F2inbB3oAQVR9/czqVnsmw5J0PNX5C8CT5l
 TaY8nFERmVyof1Q8yXZ91ON2Gl+DltqmZFoW+WMgLpWo0J3V4DGygrKe4/mbBl1Xjtt+uSVbHPDz91
 KZikp4SGOhjjMupzuJaUzeRFpI/FjAu6mIPNNGmI3zRRZM+9E84Atx+iDbrMVK0U8OH1i7E13vui4G
 aRh9k5RurGbb/7wqKsxchUxRucCg+4Hq0KE6o62cy10WChqrVi9U0kVz0KeB2ZAHz4tQo34SIYaGkw
 45a7h4a2SVokXZz7BzafBtG1Q4UwN3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

