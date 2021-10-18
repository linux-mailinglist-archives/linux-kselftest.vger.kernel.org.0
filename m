Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C14432727
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRTM2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhJRTM1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:12:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E61D60ED3;
        Mon, 18 Oct 2021 19:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584216;
        bh=Haw0ruKMBZ+KymNIJ+5PYqbMuKsTO14QHT7YM1uxm54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCO5HwbNDdL27L5m0Yt4NZpM8ActNio+TJ4yM+SxBI+H2ipdB3SdOoDnY+pEpi8NX
         DEfAzYTkX+Lawa8VpKwZITBK6K0dkdvdatMN6PDlpot9UCdVDaT3jCYkciLS2FRNuf
         xrjdjhas7dIjz/vLIluzPiL3bpaL6S3g9GYxQJnzWU7BjpV9zIFENhKeefixruxx55
         97NgZ4bp1m0xemHPuNFKHcG7K+Me5T59TsIF7ETycZXX7LzV/msKSbr0lVwi6+jz0E
         IRXqr9qIA6FK9g6DEcB8iyuIfBrfN9IrqikGe4wwawHbcmicAgZ68GbYCAOTXBdea3
         HZJGDGqT1Wviw==
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
Subject: [PATCH v2 04/42] arm64/sve: Make access to FFR optional
Date:   Mon, 18 Oct 2021 20:08:20 +0100
Message-Id: <20211018190858.2119209-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6991; h=from:subject; bh=Haw0ruKMBZ+KymNIJ+5PYqbMuKsTO14QHT7YM1uxm54=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcYqOK0bBu1K5wWX59IcLeRHDjcyQkGr4HGK2PvJ eiR+Yv6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GKgAKCRAk1otyXVSH0CUhB/ 4g8AZOl2buz2Qw9dQ7pAxQPNvC50dMkZ5CZvLSSuKaJRM856wI6vsuwfgqlRdX//tKW1UY1NmWLbg3 RGHHqTlF5YHEcgKP6aKEdcUxdmEdgwQrZwhR4ogfiEkZ0OrCmachWSGyYaA9+oE8r9BBnEcSc69of2 C56Nb/1cdQSQVWBtUS21DpePFJg5g9lpVI9pz311sNwMRGibSAKtmQm0Ka+xUrItDZPGoaAfLk9RrE QWT9NtB0bVHaOSKKFb3I5A84fkbIdomB0I4Lk3wxYwjf8/X+hCH0TVbK1cgZr+K2yybz09wwrB/Rro ABfYIAQnvvF7ZKfKwMZBC8IDZ9A2rq
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SME introduces streaming SVE mode in which FFR is not present and the
instructions for accessing it UNDEF. In preparation for handling this
update the low level SVE state access functions to take a flag specifying
if FFR should be handled. When saving the register state we store a zero
for FFR to guard against uninitialized data being read. No behaviour change
should be introduced by this patch.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h       |  6 +++---
 arch/arm64/include/asm/fpsimdmacros.h | 20 ++++++++++++++------
 arch/arm64/kernel/entry-fpsimd.S      | 17 +++++++++++------
 arch/arm64/kernel/fpsimd.c            | 10 ++++++----
 arch/arm64/kvm/hyp/fpsimd.S           |  6 ++++--
 5 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 917ecc301d1d..7f8a44a9a5e6 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -65,10 +65,10 @@ static inline void *sve_pffr(struct thread_struct *thread)
 	return (char *)thread->sve_state + sve_ffr_offset(thread->sve_vl);
 }
 
-extern void sve_save_state(void *state, u32 *pfpsr);
+extern void sve_save_state(void *state, u32 *pfpsr, int save_ffr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
-			   unsigned long vq_minus_1);
-extern void sve_flush_live(unsigned long vq_minus_1);
+			   int restore_ffr, unsigned long vq_minus_1);
+extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void sve_set_vq(unsigned long vq_minus_1);
 
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 00a2c0b69c2b..84d8cb7b07fa 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -217,28 +217,36 @@
 .macro sve_flush_z
  _for n, 0, 31, _sve_flush_z	\n
 .endm
-.macro sve_flush_p_ffr
+.macro sve_flush_p
  _for n, 0, 15, _sve_pfalse	\n
+.endm
+.macro sve_flush_ffr
 		_sve_wrffr	0
 .endm
 
-.macro sve_save nxbase, xpfpsr, nxtmp
+.macro sve_save nxbase, xpfpsr, save_ffr, nxtmp
  _for n, 0, 31,	_sve_str_v	\n, \nxbase, \n - 34
  _for n, 0, 15,	_sve_str_p	\n, \nxbase, \n - 16
+		cbz		\save_ffr, 921f
 		_sve_rdffr	0
 		_sve_str_p	0, \nxbase
 		_sve_ldr_p	0, \nxbase, -16
-
+		b		922f
+921:
+		str		xzr, [x\nxbase, #0]	// Zero out FFR
+922:
 		mrs		x\nxtmp, fpsr
 		str		w\nxtmp, [\xpfpsr]
 		mrs		x\nxtmp, fpcr
 		str		w\nxtmp, [\xpfpsr, #4]
 .endm
 
-.macro __sve_load nxbase, xpfpsr, nxtmp
+.macro __sve_load nxbase, xpfpsr, restore_ffr, nxtmp
  _for n, 0, 31,	_sve_ldr_v	\n, \nxbase, \n - 34
+		cbz		\restore_ffr, 921f
 		_sve_ldr_p	0, \nxbase
 		_sve_wrffr	0
+921:
  _for n, 0, 15,	_sve_ldr_p	\n, \nxbase, \n - 16
 
 		ldr		w\nxtmp, [\xpfpsr]
@@ -247,7 +255,7 @@
 		msr		fpcr, x\nxtmp
 .endm
 
-.macro sve_load nxbase, xpfpsr, xvqminus1, nxtmp, xtmp2
+.macro sve_load nxbase, xpfpsr, restore_ffr, xvqminus1, nxtmp, xtmp2
 		sve_load_vq	\xvqminus1, x\nxtmp, \xtmp2
-		__sve_load	\nxbase, \xpfpsr, \nxtmp
+		__sve_load	\nxbase, \xpfpsr, \restore_ffr, \nxtmp
 .endm
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index afbf7dc47e1d..13c27465bfa8 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -38,9 +38,10 @@ SYM_FUNC_END(fpsimd_load_state)
  *
  * x0 - pointer to buffer for state
  * x1 - pointer to storage for FPSR
+ * x2 - Save FFR if non-zero
  */
 SYM_FUNC_START(sve_save_state)
-	sve_save 0, x1, 2
+	sve_save 0, x1, x2, 3
 	ret
 SYM_FUNC_END(sve_save_state)
 
@@ -49,10 +50,11 @@ SYM_FUNC_END(sve_save_state)
  *
  * x0 - pointer to buffer for state
  * x1 - pointer to storage for FPSR
- * x2 - VQ-1
+ * x2 - Restore FFR if non-zero
+ * x3 - VQ-1
  */
 SYM_FUNC_START(sve_load_state)
-	sve_load 0, x1, x2, 3, x4
+	sve_load 0, x1, x2, x3, 4, x5
 	ret
 SYM_FUNC_END(sve_load_state)
 
@@ -72,12 +74,15 @@ SYM_FUNC_END(sve_set_vq)
  * VQ must already be configured by caller, any further updates of VQ
  * will need to ensure that the register state remains valid.
  *
- * x0 = VQ - 1
+ * x0 = include FFR?
+ * x1 = VQ - 1
  */
 SYM_FUNC_START(sve_flush_live)
-	cbz		x0, 1f	// A VQ-1 of 0 is 128 bits so no extra Z state
+	cbz		x1, 1f	// A VQ-1 of 0 is 128 bits so no extra Z state
 	sve_flush_z
-1:	sve_flush_p_ffr
+1:	cbz		x0, 2f
+	sve_flush_p
+2:	sve_flush_ffr
 	ret
 SYM_FUNC_END(sve_flush_live)
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 0f6df1ece618..3d5d243c3f1c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -289,7 +289,7 @@ static void task_fpsimd_load(void)
 
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE))
 		sve_load_state(sve_pffr(&current->thread),
-			       &current->thread.uw.fpsimd_state.fpsr,
+			       &current->thread.uw.fpsimd_state.fpsr, true,
 			       sve_vq_from_vl(current->thread.sve_vl) - 1);
 	else
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
@@ -325,7 +325,7 @@ static void fpsimd_save(void)
 
 		sve_save_state((char *)last->sve_state +
 					sve_ffr_offset(last->sve_vl),
-			       &last->st->fpsr);
+			       &last->st->fpsr, true);
 	} else {
 		fpsimd_save_state(last->st);
 	}
@@ -962,7 +962,7 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 		unsigned long vq_minus_one =
 			sve_vq_from_vl(current->thread.sve_vl) - 1;
 		sve_set_vq(vq_minus_one);
-		sve_flush_live(vq_minus_one);
+		sve_flush_live(true, vq_minus_one);
 		fpsimd_bind_task_to_cpu();
 	} else {
 		fpsimd_to_sve(current);
@@ -1356,7 +1356,8 @@ void __efi_fpsimd_begin(void)
 			__this_cpu_write(efi_sve_state_used, true);
 
 			sve_save_state(sve_state + sve_ffr_offset(sve_max_vl),
-				       &this_cpu_ptr(&efi_fpsimd_state)->fpsr);
+				       &this_cpu_ptr(&efi_fpsimd_state)->fpsr,
+				       true);
 		} else {
 			fpsimd_save_state(this_cpu_ptr(&efi_fpsimd_state));
 		}
@@ -1382,6 +1383,7 @@ void __efi_fpsimd_end(void)
 
 			sve_load_state(sve_state + sve_ffr_offset(sve_max_vl),
 				       &this_cpu_ptr(&efi_fpsimd_state)->fpsr,
+				       true,
 				       sve_vq_from_vl(sve_get_vl()) - 1);
 
 			__this_cpu_write(efi_sve_state_used, false);
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 3c635929771a..1bb3b04b84e6 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -21,11 +21,13 @@ SYM_FUNC_START(__fpsimd_restore_state)
 SYM_FUNC_END(__fpsimd_restore_state)
 
 SYM_FUNC_START(__sve_restore_state)
-	__sve_load 0, x1, 2
+	mov	x2, #1
+	__sve_load 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_restore_state)
 
 SYM_FUNC_START(__sve_save_state)
-	sve_save 0, x1, 2
+	mov	x2, #1
+	sve_save 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_save_state)
-- 
2.30.2

