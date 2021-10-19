Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9F433D59
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhJSR0u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233580AbhJSR0u (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F95A610E5;
        Tue, 19 Oct 2021 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664277;
        bh=/InHIoJ50NuJ6S58CqVg/X+eR3Xiy834t7j5zaUAe5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iO7Wu8tp1HtKI9n5bbOjtyeN/nUBBbZnsTJPZJDETUm9rFfOHre2uAD11Xkc+bUAr
         2+xkuQjLMz+0dH5P8aNWGCePP2c36mMz5vSKfYnr8Gt1tIxE4Z9dBL6ZEWfizUzGs7
         XZkau1NBhe6qdMwd22PY+PNscvX65MK5ntYpSnl4XFTsAey8DxtGpmUywddK7Tq+dH
         Sya8EXuF0lzYveI6kJm5JPD4pmgVf3wTYcXb5PgPZ3HFdfYsFqYaI58DmD/N8ZwIDG
         jFXd5/eSFuk8SxxkYxQOsWixnK8/hVEYpsaWNVF8dNdvbF2e/jTeI5sDbeZ9fb0CJe
         /q58l+Gh1xl/g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 22/42] arm64/sme: Implement vector length configuration prctl()s
Date:   Tue, 19 Oct 2021 18:22:27 +0100
Message-Id: <20211019172247.3045838-23-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5719; h=from:subject; bh=/InHIoJ50NuJ6S58CqVg/X+eR3Xiy834t7j5zaUAe5Q=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7VHJCQ8wCHEpf36J+ZV2mmE2uvi4n0l0YmeGVb 7GeUGeuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+1QAKCRAk1otyXVSH0FFOB/ 9uXqXR4V4Jr4pbr0ePS/1vZlnY38y5IGuqsrm0glBHFNTRSvESx0G1n8V6xh/vtkE0+oHGN0R+/M79 3DJ9ueSpxHw0Gblw4/234jfjPPKKfiGL5xk34Hpwy6hZmNswrwL9z9dI57f2ElgOyK3fbaq7QWXLax ZaRvW3igd8RBdyFMttHfX9xR7iOyOkNq/kQ5lnBvn8mELX41JR85Mg632r6mEgrkUUZoIFYW0OoEqA 2wyecRCRO6OFeru8/5us3SjWNlEFtiscfyF/oclscEgx6CYU6II1Oxbj7q5qFxWsLCbj36H9ZZjf8O XoOchO1syIltjouYvycxLVQTBspQSB
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As for SVE provide a prctl() interface which allows processes to
configure their SME vector length.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h      | 13 +++++++++++
 arch/arm64/include/asm/processor.h   |  4 +++-
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/fpsimd.c           | 32 ++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h           |  9 ++++++++
 kernel/sys.c                         | 12 +++++++++++
 6 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index a65779fe6d56..3550317cbb3d 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -278,6 +278,9 @@ static inline int sme_max_virtualisable_vl(void)
 	return vec_max_virtualisable_vl(ARM64_VEC_SME);
 }
 
+extern int sme_set_current_vl(unsigned long arg);
+extern int sme_get_current_vl(void);
+
 #else
 
 static inline void sme_setup(void) { }
@@ -287,6 +290,16 @@ static inline int sme_max_virtualisable_vl(void) { return 0; }
 static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
 
+static inline int sme_set_current_vl(unsigned long arg)
+{
+	return -EINVAL;
+}
+
+static inline int sme_get_current_vl(void)
+{
+	return -EINVAL;
+}
+
 #endif /* ! CONFIG_ARM64_SME */
 
 /* For use by EFI runtime services calls only */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 575a1fe719b7..a62d2f8045bf 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -354,9 +354,11 @@ extern void __init minsigstksz_setup(void);
  */
 #include <asm/fpsimd.h>
 
-/* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
+/* Userspace interface for PR_S[MV]E_{SET,GET}_VL prctl()s: */
 #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
 #define SVE_GET_VL()	sve_get_current_vl()
+#define SME_SET_VL(arg)	sme_set_current_vl(arg)
+#define SME_GET_VL()	sme_get_current_vl()
 
 /* PR_PAC_RESET_KEYS prctl */
 #define PAC_RESET_KEYS(tsk, arg)	ptrauth_prctl_reset_keys(tsk, arg)
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index d5c8ac81ce11..5c4355204f4a 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -81,6 +81,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define TIF_SVE_VL_INHERIT	24	/* Inherit SVE vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
 #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
+#define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 9c2b3893f14d..96780b6821b6 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -145,6 +145,8 @@ static unsigned int vec_vl_inherit_flag(enum vec_type type)
 	switch (type) {
 	case ARM64_VEC_SVE:
 		return TIF_SVE_VL_INHERIT;
+	case ARM64_VEC_SME:
+		return TIF_SME_VL_INHERIT;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -800,6 +802,36 @@ int sve_get_current_vl(void)
 	return vec_prctl_status(ARM64_VEC_SVE, 0);
 }
 
+#ifdef CONFIG_ARM64_SME
+/* PR_SME_SET_VL */
+int sme_set_current_vl(unsigned long arg)
+{
+	unsigned long vl, flags;
+	int ret;
+
+	vl = arg & PR_SME_VL_LEN_MASK;
+	flags = arg & ~vl;
+
+	if (!system_supports_sme() || is_compat_task())
+		return -EINVAL;
+
+	ret = vec_set_vector_length(current, ARM64_VEC_SME, vl, flags);
+	if (ret)
+		return ret;
+
+	return vec_prctl_status(ARM64_VEC_SME, flags);
+}
+
+/* PR_SME_GET_VL */
+int sme_get_current_vl(void)
+{
+	if (!system_supports_sme() || is_compat_task())
+		return -EINVAL;
+
+	return vec_prctl_status(ARM64_VEC_SME, 0);
+}
+#endif /* CONFIG_ARM64_SME */
+
 static void vec_probe_vqs(struct vl_info *info,
 			  DECLARE_BITMAP(map, SVE_VQ_MAX))
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43bd7f713c39..b3212d73c198 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -269,4 +269,13 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
 # define PR_SCHED_CORE_MAX		4
 
+/* arm64 Scalable Matrix Extension controls */
+/* Flag values must be in sync with SVE versions */
+#define PR_SME_SET_VL			63	/* set task vector length */
+# define PR_SME_SET_VL_ONEXEC		(1 << 18) /* defer effect until exec */
+#define PR_SME_GET_VL			64	/* get task vector length */
+/* Bits common to PR_SME_SET_VL and PR_SME_GET_VL */
+# define PR_SME_VL_LEN_MASK		0xffff
+# define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 8fdac0d90504..59b1ce29b6c9 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -116,6 +116,12 @@
 #ifndef SVE_GET_VL
 # define SVE_GET_VL()		(-EINVAL)
 #endif
+#ifndef SME_SET_VL
+# define SME_SET_VL(a)		(-EINVAL)
+#endif
+#ifndef SME_GET_VL
+# define SME_GET_VL()		(-EINVAL)
+#endif
 #ifndef PAC_RESET_KEYS
 # define PAC_RESET_KEYS(a, b)	(-EINVAL)
 #endif
@@ -2463,6 +2469,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SVE_GET_VL:
 		error = SVE_GET_VL();
 		break;
+	case PR_SME_SET_VL:
+		error = SME_SET_VL(arg2);
+		break;
+	case PR_SME_GET_VL:
+		error = SME_GET_VL();
+		break;
 	case PR_GET_SPECULATION_CTRL:
 		if (arg3 || arg4 || arg5)
 			return -EINVAL;
-- 
2.30.2

