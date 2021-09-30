Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54B641E0BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353326AbhI3SRj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353324AbhI3SRi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ECE6619E5;
        Thu, 30 Sep 2021 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025756;
        bh=LADqu07rjax+PE5YAcxNAoRFPlppdtivW2aMJIg8yXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEVU3nLXcbtC/LiyBTBPKSDrfrIK/9KscQ3ulNTO83gqwmPR4JpyAwppBlWhdkRHH
         K41sVDEenZuqD319uTZVf8dm+PsmVVcZ6Dg2xx9ROSdRiNpPKB3kl1Q7/5pIfgJo2d
         xZcIj7L5gdwaczjaBSyjLx57rY1itnqX/bCuOIsBhkPXn6pCyllCpbnd+z2F56ee3n
         cwDKwb7ss6sDVjje6LcOP3/+Jq4SR6sv7OArABA1s27GoznUMM3CK3ulbq+BQL8SBI
         grTlSvavvvEVkTEz21yWau3tojIb+Fj59IssK41xO6lA+w9PqBUXLjfZ1QiQcCtsZP
         7vOxkTXlT4X3A==
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
Subject: [PATCH v1 07/38] arm64/sve: Explicitly load vector length when restoring SVE state
Date:   Thu, 30 Sep 2021 19:11:13 +0100
Message-Id: <20210930181144.10029-8-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4692; h=from:subject; bh=LADqu07rjax+PE5YAcxNAoRFPlppdtivW2aMJIg8yXo=; b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBhVf3H5uyL6a00ZUpCgexhENaHDR3E5ZosWgynxCHH ZH/YeUKJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9xwAKCRAk1otyXVSH0IssB/ iIG3dbiiiJUwoKwhbS81m7oXkmhWHJHn073EhVtMyNGnUIqDdioA3UEPqAGyLQmB3RxTZZPXgI69/k 7pOfdj/i44EUdn1u+N1USZoJC/PZYYoW09RWvbTISzpfPj03anygbpYnj+SSrGfrKHxOjTS4h8YA4P QPSTwfdZCYtQKZWUtw70dzuSoZDBAYISiaRioWKNHBJEtke+2axnKqfir2+XMUqH/kRvjHbJ1S8cu9 EHoB3zEa2t8NosOMAIMmcgiPenwMdXav3kx/P5wh8McL+c4qgZAxf1Z536q0ddWrE5dTiDnMzM4Omo 87NRFueOor6VmP0eYbXKHHQtxCUTU=
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
index 02fa676d1a9a..a18f409dec33 100644
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
index d45f14a68b9c..44bb3203c9d1 100644
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
2.20.1

