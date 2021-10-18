Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D67443272B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRTMj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRTMi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:12:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C03D760ED3;
        Mon, 18 Oct 2021 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584227;
        bh=JfiYVf9Y04mHxqgwzAG6187a+qq3BhQ8I6VaeT3DD6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nNDMfU+V/e8XTos/qMBujC75Sdn5kef9I/3dthX5QzqRL+ZQU4ahx89V+Fy9yXjCo
         CVCrBS89M0bvFBZh+Xl98AS4h29bRs+UVxwwABTwgK0AWaFp3kNDXAR+6Rxymm5pnh
         Tp/AtVy5/QEhnw0hg7huCkEvEYFGS8bHoPXO9LYRhKuxOxvYsu3KIbIeBDZ64BaXCP
         Zu8MImJpKoo4/Ja3M3VtH3Kb43OYqOP5lyOAr1qm9RvOiz8s97ujil76J6MlA9X6UM
         GDHiYO0TYxquPDrTXipfjMTXy3GE5Lmtb5l7aWv4bzA7g4JrYJBdci+40HG9bc1Fp1
         HqN20xEBxG2EQ==
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
Subject: [PATCH v2 08/42] arm64/sve: Explicitly load vector length when restoring SVE state
Date:   Mon, 18 Oct 2021 20:08:24 +0100
Message-Id: <20211018190858.2119209-9-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4692; h=from:subject; bh=JfiYVf9Y04mHxqgwzAG6187a+qq3BhQ8I6VaeT3DD6Y=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcYtxIWvMtTroK0jDwaZplgHgkGnwav4DlS6u+dI ff1AB0iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GLQAKCRAk1otyXVSH0CoJB/ 4zICsR3QuK0Qj8Im35sV667l+JEiF/YX5pML7zRXlThDnRD242VcbpR0nydAExqESP4xK75b4Xs8yT 6VkrbwfwC1wE7X3csjcMAHStvat1l0S3cNsBCyB6izvMqXaJsBa1iCfV0HbQnA6ExNA14DsuXvy+Sc 2I6Svi4cEoKCxjk91ZVirRhiQocvA3wgd8rBGJ2AnFPWaA+PDsTWKy3NWBhtMcp2i3owbHpnzn/J/z UhSavANHK5EZNzsO8Ubd3CWUyJ5+Qycpf+gSlvHtpwhvcL89gi4VR8fE4ZDO6LxikAb+kJ0r8UlDZm GYHH5Kk8M21vVA8yx1IBRmoLp0cxGB
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently when restoring the SVE state we supply the SVE vector length
as an argument to sve_load_state() and the underlying macros. This becomes
inconvenient with the addition of SME since we may need to restore any
combination of SVE and SME vector lengths, and we already separately
restore the vector length in the KVM code. We don't need to know the vector
length during the actual register load since the SME load instructions can
index into the data array for us.

Refactor the interface so we explicitly set the vector length separately
to restoring the SVE registers in preparation for adding SME support, no
functional change should be involved.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h       |  2 +-
 arch/arm64/include/asm/fpsimdmacros.h |  7 +------
 arch/arm64/kernel/entry-fpsimd.S      |  3 +--
 arch/arm64/kernel/fpsimd.c            | 13 +++++++------
 arch/arm64/kvm/hyp/fpsimd.S           |  2 +-
 5 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 5a1f79a4a500..1d0b5fa253a0 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -67,7 +67,7 @@ static inline void *sve_pffr(struct thread_struct *thread)
 
 extern void sve_save_state(void *state, u32 *pfpsr, int save_ffr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
-			   int restore_ffr, unsigned long vq_minus_1);
+			   int restore_ffr);
 extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void sve_set_vq(unsigned long vq_minus_1);
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 84d8cb7b07fa..b22538a6137e 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -241,7 +241,7 @@
 		str		w\nxtmp, [\xpfpsr, #4]
 .endm
 
-.macro __sve_load nxbase, xpfpsr, restore_ffr, nxtmp
+.macro sve_load nxbase, xpfpsr, restore_ffr, nxtmp
  _for n, 0, 31,	_sve_ldr_v	\n, \nxbase, \n - 34
 		cbz		\restore_ffr, 921f
 		_sve_ldr_p	0, \nxbase
@@ -254,8 +254,3 @@
 		ldr		w\nxtmp, [\xpfpsr, #4]
 		msr		fpcr, x\nxtmp
 .endm
-
-.macro sve_load nxbase, xpfpsr, restore_ffr, xvqminus1, nxtmp, xtmp2
-		sve_load_vq	\xvqminus1, x\nxtmp, \xtmp2
-		__sve_load	\nxbase, \xpfpsr, \restore_ffr, \nxtmp
-.endm
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 13c27465bfa8..2339d370bfe1 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -51,10 +51,9 @@ SYM_FUNC_END(sve_save_state)
  * x0 - pointer to buffer for state
  * x1 - pointer to storage for FPSR
  * x2 - Restore FFR if non-zero
- * x3 - VQ-1
  */
 SYM_FUNC_START(sve_load_state)
-	sve_load 0, x1, x2, x3, 4, x5
+	sve_load 0, x1, x2, 4
 	ret
 SYM_FUNC_END(sve_load_state)
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 9248c9efe5fd..e75dd20a40cf 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -318,12 +318,13 @@ static void task_fpsimd_load(void)
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE))
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
+		sve_set_vq(sve_vq_from_vl(task_get_sve_vl(current)) - 1);
 		sve_load_state(sve_pffr(&current->thread),
-			       &current->thread.uw.fpsimd_state.fpsr, true,
-			       sve_vq_from_vl(task_get_sve_vl(current)) - 1);
-	else
+			       &current->thread.uw.fpsimd_state.fpsr, true);
+	} else {
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
+	}
 }
 
 /*
@@ -1423,10 +1424,10 @@ void __efi_fpsimd_end(void)
 		    likely(__this_cpu_read(efi_sve_state_used))) {
 			char const *sve_state = this_cpu_ptr(efi_sve_state);
 
+			sve_set_vq(sve_vq_from_vl(sve_get_vl()) - 1);
 			sve_load_state(sve_state + sve_ffr_offset(sve_max_vl()),
 				       &this_cpu_ptr(&efi_fpsimd_state)->fpsr,
-				       true,
-				       sve_vq_from_vl(sve_get_vl()) - 1);
+				       true);
 
 			__this_cpu_write(efi_sve_state_used, false);
 		} else {
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 1bb3b04b84e6..e950875e31ce 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -22,7 +22,7 @@ SYM_FUNC_END(__fpsimd_restore_state)
 
 SYM_FUNC_START(__sve_restore_state)
 	mov	x2, #1
-	__sve_load 0, x1, x2, 3
+	sve_load 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_restore_state)
 
-- 
2.30.2

