Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6754F94B9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiDHL6G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiDHL6F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:58:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525747E0AD
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08EADB82A8B
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F82DC385A1;
        Fri,  8 Apr 2022 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649418959;
        bh=soR5ockNzHaz8amwdahgIj0zNQXKGASUkPygvlxvLRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYyWLCY5cgZKadYUt5daG9yGzSwp+ZvjdqDYhgCgnutcZK7Z76URHt6GhzgUfEmoJ
         TYhL0LK5bBGuRgD1vZNrG/NkSA7B/iBYmSkkNvinrlfo3locg43vUdObxfeUGXtqag
         jZ9RxdsqWPSbsz4FRJaIP/Otafe7dhgGYNjrpPyQb2HQz3MwVDRgKGgZD3BMRPOFDm
         AVZienY/QQW2y15Ot/tJ4TMf0SBQWAdjPY+JjT5wrbr/Ga15T0RfKp3llEKIZBrCOK
         mBJam31wImwDV+XB0MdfXs0nz/VdBuJugaSDEn2NP9n3lI0VikMNeK2uLnKDVCOs/9
         Ci2gvHQ/mgjRw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v13 11/39] arm64/sme: Implement vector length configuration prctl()s
Date:   Fri,  8 Apr 2022 12:43:00 +0100
Message-Id: <20220408114328.1401034-12-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5733; h=from:subject; bh=soR5ockNzHaz8amwdahgIj0zNQXKGASUkPygvlxvLRQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/HHUGFqqSTrnQH0Dyk1t6aGxl2M/UX9ZzdNkCG QnZ0sCeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAfxwAKCRAk1otyXVSH0M+uB/ 9sPavb/Fig4WT95Yl26ykjU6QuAux8WdQRz5Vb+SPlGCkkJ2DgnRIE3lNoVJmx7I1U8hfECoqlRbPR ghmzJITFD1LN8d1lm3ATQ/h9P+MeZ4ExlQbY5eTXrA88W8SZSu3NeAtMc8sutQcDUv+GHSx4uyTLgR WHj3qrQ0vjL3ERb15391YZVF+tbUGVF87O7VvFTq9+MSA0TloI40i+ftU9bK1wY1uVYpX3Ku4jhf3G qNm1+rHV153i57deg8y8+O7XGRugTKQRZ1GHFBEAdfhoXhkfIkvCT0ojRi8rgMl5B91v0jPdy1MM4d PDShjZBXq19csiwz0a1dfQ63o2HX67
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As for SVE provide a prctl() interface which allows processes to
configure their SME vector length.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/fpsimd.h      |  4 ++++
 arch/arm64/include/asm/processor.h   |  4 +++-
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/fpsimd.c           | 32 ++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h           |  9 ++++++++
 kernel/sys.c                         | 12 +++++++++++
 6 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 32cd682258d9..38fd6aab7feb 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -288,6 +288,8 @@ static inline int sme_max_virtualisable_vl(void)
 }
 
 extern unsigned int sme_get_vl(void);
+extern int sme_set_current_vl(unsigned long arg);
+extern int sme_get_current_vl(void);
 
 #else
 
@@ -299,6 +301,8 @@ static inline void sme_setup(void) { }
 static inline unsigned int sme_get_vl(void) { return 0; }
 static inline int sme_max_vl(void) { return 0; }
 static inline int sme_max_virtualisable_vl(void) { return 0; }
+static inline int sme_set_current_vl(unsigned long arg) { return -EINVAL; }
+static inline int sme_get_current_vl(void) { return -EINVAL; }
 
 #endif /* ! CONFIG_ARM64_SME */
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index abf34a9c2eab..7a57cbff8a03 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -355,9 +355,11 @@ extern void __init minsigstksz_setup(void);
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
index e1317b7c4525..4e6b58dcd6f9 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -82,6 +82,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define TIF_SVE_VL_INHERIT	24	/* Inherit SVE vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
 #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
+#define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 754a96563f6f..39f44fcb9b99 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -149,6 +149,8 @@ static unsigned int vec_vl_inherit_flag(enum vec_type type)
 	switch (type) {
 	case ARM64_VEC_SVE:
 		return TIF_SVE_VL_INHERIT;
+	case ARM64_VEC_SME:
+		return TIF_SME_VL_INHERIT;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -807,6 +809,36 @@ int sve_get_current_vl(void)
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
index e998764f0262..a5e06dcbba13 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -272,6 +272,15 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1
 # define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2
 
+/* arm64 Scalable Matrix Extension controls */
+/* Flag values must be in sync with SVE versions */
+#define PR_SME_SET_VL			63	/* set task vector length */
+# define PR_SME_SET_VL_ONEXEC		(1 << 18) /* defer effect until exec */
+#define PR_SME_GET_VL			64	/* get task vector length */
+/* Bits common to PR_SME_SET_VL and PR_SME_GET_VL */
+# define PR_SME_VL_LEN_MASK		0xffff
+# define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
+
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 374f83e95239..b911fa6d81ab 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -117,6 +117,12 @@
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
@@ -2541,6 +2547,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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

