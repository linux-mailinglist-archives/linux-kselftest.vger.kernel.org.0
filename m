Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB882433D4A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhJSR0K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhJSR0J (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1958461212;
        Tue, 19 Oct 2021 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664236;
        bh=dWKwIji7Kr5dlyRb93unizGlssfPjvHpEJo3+AD7RiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBgtv3Q5uJYSkryic3oMfNxXseFKzTCSp3QnE7jlopdeYiA9F3GRgqciAEBdi4xQ/
         jB0hu7pGmKuA47gYJggKRfzOHL136HD6LDStNzQsKlfbmN4Wo+1ThyopofsQgB3d66
         +HMlEDFg+jLUnQNSwGVeMdf81NYrh40lv5cGJFd3CrI19pxZc8Bqeps/sDdUcG7qq7
         T6HjwGi+C1G+eEkAEI6f1LUZ8cntc2CG6m5+kzFZnJ8CbO3dLxhiWndlsWfXnj8In/
         +5PmnQv13CDxWEtyZ3rsOvWpoFtMXhjbavv/nBZoSx9GHnahjidohEk+xrIekEXwQY
         uOkt3xOob0KTQ==
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
Subject: [PATCH v3 08/42] arm64/sve: Explicitly load vector length when restoring SVE state
Date:   Tue, 19 Oct 2021 18:22:13 +0100
Message-Id: <20211019172247.3045838-9-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4692; h=from:subject; bh=dWKwIji7Kr5dlyRb93unizGlssfPjvHpEJo3+AD7RiM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7K1HzzepCNDlTlGyO5Etc8LvGVGniXLuCXglzF dkUvBWGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+ygAKCRAk1otyXVSH0CXaB/ 9ZCE1+LDrs5l2R7qTh/Bew03hsqut5T9HH/fym+EsRPnhzPHR0514JlFXDixG75KSLCtb+taTyip60 g2YSMKMUe1L2LvfyJINvkz6uMdnt3lDX+JtPNjPi/OuTr20AwU4VeyYzDc8V9qmmBl5/Ex4uQakvuA m3iSD9jl5rbeb2n6F0ke/JAuGCl9k1Zov7TQNGhAMCRy1hb1bhwW0gz8dePTYUrKk2q9RtH5DLJMP5 V9oENLg25prwFtGIBP4pcRNNydJ59N44j0L2fuz7wPUnzEJxtjOBRS0kBhYbxw7oWybrls0RuzNVF+ ktcYYKWore4WUMnWYyLn0x/d/9KPvZ
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
index e5ffd8b265b6..2509d7dde55a 100644
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
index f588c214d44b..dc242e269f9a 100644
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

