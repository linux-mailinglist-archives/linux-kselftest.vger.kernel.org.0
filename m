Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B976641E0D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353362AbhI3SSP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhI3SSN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:18:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 935A06140F;
        Thu, 30 Sep 2021 18:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025790;
        bh=wT2L8M/ObpQjIrEXr9/+1717zyVZfM+tPnHbYjh7yr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJwGzIs3ghYfqFBi76dv/BAoAAhAKCuRKv0ytjZt8URTgk1qgQtloCkoo6rNhBqMm
         6H5dmEN6dGqw3nLBpCR/NYLEA58ibrVhc9lOhNIjCPlUXZ/SD0qLTN/CQ4OXc9kdmv
         +j6eg9qwMwYMO8yno4QJT8Ffjs1WEaDUYGrD0OhOS2x55aGReyShlleabEtETX2azR
         eDvyfXCY0NweOQ+2/SGuz6Uxed49CQTUsTgAsy6DfRyoGIsg8qpKqPlz+GErHOqfDY
         Og0Qs/z2I3KgHs5RKU2s/z8w45QPcb3l3+zV4GO7syCe7zFV7EZ4Il+sCNibjhJ/lG
         8vR9LAFWlCLVw==
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
Subject: [PATCH v1 19/38] arm64/sme: Implement vector length configuration prctl()s
Date:   Thu, 30 Sep 2021 19:11:25 +0100
Message-Id: <20210930181144.10029-20-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4404; h=from:subject; bh=wT2L8M/ObpQjIrEXr9/+1717zyVZfM+tPnHbYjh7yr8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3QeKj8ubCq2+5PilkRptZlu4EfuATDih0eiCya hhzyWSeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX90AAKCRAk1otyXVSH0O0XB/ 9agzigpLxiAG69faCdxSzapY42GdoGdKMiu1AMqkfs2MqK/tYvMFJA6/fmlUchbs4Dn899zE8CF0r1 3k3JeRudQQk6Jf9Bmn7JxzKsjo+0qD1dTEeT/KbPrTe6fTIOflpdSEkwrj0b9u3b59/iVmW42tTZdK cpuYPx6owKpctz/l6A4D/BOYiIV7xcdrZbtlucWIWHfe5lLHUi7ePHtg1Q4/u3whNFEqCugNGw+xqc xX59doJ4KAc6s5smdUsdFFbtjXroi44cXWQCOM6BuZG2d7+1hhJ6A5i/RFA/3gigRwRQjh+TkTmNdz tC6p0mgDV6jj0XZt1BCPuGAApabUj3
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As for SVE provide a prctl() interface which allows processes to
configure their SME vector length.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/processor.h   |  4 +++-
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/fpsimd.c           | 30 ++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h           |  9 +++++++++
 kernel/sys.c                         |  6 ++++++
 5 files changed, 49 insertions(+), 1 deletion(-)

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
index 13df5920fe1e..9511428c2e81 100644
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
@@ -800,6 +802,34 @@ int sve_get_current_vl(void)
 	return vec_prctl_status(ARM64_VEC_SVE, 0);
 }
 
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
index 8fdac0d90504..bf45194ce03b 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2463,6 +2463,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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
2.20.1

