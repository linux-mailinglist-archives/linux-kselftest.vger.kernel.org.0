Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5860752B6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGMULs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGMULq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 16:11:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFE330CA;
        Thu, 13 Jul 2023 13:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D81861B0F;
        Thu, 13 Jul 2023 20:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33903C433C9;
        Thu, 13 Jul 2023 20:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689279060;
        bh=o0ANSAw56sA/lMUOCihuB62S6J6BNaztJzZehhETvE0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ApDZj1uNZf71FBvouOCrf0wVUKZBSLI6OueVam0HtYW3CKzVHw7ccPspsR6GadW/t
         6JKMYvbZIHWgHo+mC5GhpKoZnUrI4yHJ3rChkhiqrI9iAa1A85AO+40S/t0Nc0hw23
         lbMkupHw15GIDRin0Ad11BWdAMmbEk+9E7FGUh+t4GaFXUpk4EMsxiVn40T8OEgrdk
         4/YA+H/sXL/qhb8A4tY6dqOrfukCEm8vW587MmvQlmg9KeDPmMNnkEXjZ2j5BkwzCn
         UtqR6LgpSKUpJzDhElGqbr2t3hBPdN4LJ8Rct+OsKdkYdxJ+F8zBeGmaAQJvALZ075
         J7TYA1T2d/psQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 21:06:04 +0100
Subject: [PATCH 1/3] arm64/fpsimd: Ensure SME storage is allocated after
 SVE VL changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-arm64-fix-sve-sme-vl-change-v1-1-129dd8611413@kernel.org>
References: <20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org>
In-Reply-To: <20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3179; i=broonie@kernel.org;
 h=from:subject:message-id; bh=o0ANSAw56sA/lMUOCihuB62S6J6BNaztJzZehhETvE0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBksFpNzlGIjJ25VfURcqNr5OdlZ9uZz5Sciz6zF2v/
 AgnJnvOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLBaTQAKCRAk1otyXVSH0GjsB/
 0adS+55bGJsIYkt/TYHWkX71CLRv8+BFzENgFSc3PJTu/3/Z3R2CWVLT9snutH2r4EFffoYq1QdNvb
 QMUFXoBW1ih7dlCVaxTuZSifF0MNJ+U5Eq+AVO0xIIuKKChEsveQ8mAGCK9D/f+9nuOrnFnEHAkOrh
 OueZcuR/I8DNofEsSFRU4F7Vv/rEAUi5iYnbvPN32qo5z6CT0QMa1j+5vuMIBoeo47MYa7DnVoOp1A
 d2LSvG3K+LJ1qOaRCBVISQotHoM5zZS3aaZrqQxZ82+Cg8FiTO8BEek0TlBp+OcGJOBn6Qcclew/2T
 viSAjxBXH9Y7+48OYQTK8PKfKPh372
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When we reconfigure the SVE vector length we discard the backing storage
for the SVE vectors and then reallocate on next SVE use, leaving the SME
specific state alone. This means that we do not enable SME traps if they
were already disabled. That means that userspace code can enter streaming
mode without trapping, putting the task in a state where if we try to save
the state of the task we will fault.

Since the ABI does not specify that changing the SVE vector length disturbs
SME state, and since SVE code may not be aware of SME code in the process,
we shouldn't simply discard any ZA state. Instead immediately reallocate
the storage for SVE if SME is active, and disable SME if we change the SVE
vector length while there is no SME state active.

Disabling SME traps on SVE vector length changes would make the overall
code more complex since we would have a state where we have valid SME state
stored but might get a SME trap.

Fixes: 9e4ab6c89109 ("arm64/sme: Implement vector length configuration prctl()s")
Reported-by: David Spickett <David.Spickett@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/fpsimd.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 7a1aeb95d7c3..a527b95c06e7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -847,6 +847,9 @@ void sve_sync_from_fpsimd_zeropad(struct task_struct *task)
 int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 			  unsigned long vl, unsigned long flags)
 {
+	bool free_sme = false;
+	bool alloc_sve = true;
+
 	if (flags & ~(unsigned long)(PR_SVE_VL_INHERIT |
 				     PR_SVE_SET_VL_ONEXEC))
 		return -EINVAL;
@@ -897,22 +900,37 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 		task->thread.fp_type = FP_STATE_FPSIMD;
 	}
 
-	if (system_supports_sme() && type == ARM64_VEC_SME) {
-		task->thread.svcr &= ~(SVCR_SM_MASK |
-				       SVCR_ZA_MASK);
-		clear_thread_flag(TIF_SME);
+	if (system_supports_sme()) {
+		if (type == ARM64_VEC_SME ||
+		    !(task->thread.svcr & (SVCR_SM_MASK | SVCR_ZA_MASK))) {
+			/*
+			 * We are changing the SME VL or weren't using
+			 * SME anyway, discard the state and force a
+			 * reallocation.
+			 */
+			task->thread.svcr &= ~(SVCR_SM_MASK |
+					       SVCR_ZA_MASK);
+			clear_thread_flag(TIF_SME);
+			free_sme = true;
+		} else  {
+			alloc_sve = true;
+		}
 	}
 
 	if (task == current)
 		put_cpu_fpsimd_context();
 
 	/*
-	 * Force reallocation of task SVE and SME state to the correct
-	 * size on next use:
+	 * Free the changed states if they are not in use, they will
+	 * be reallocated to the correct size on next use.  If we need
+	 * SVE state due to having untouched SME state then reallocate
+	 * it immediately.
 	 */
 	sve_free(task);
-	if (system_supports_sme() && type == ARM64_VEC_SME)
+	if (free_sme)
 		sme_free(task);
+	if (alloc_sve)
+		sve_alloc(task, true);
 
 	task_set_vl(task, type, vl);
 

-- 
2.30.2

