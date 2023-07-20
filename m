Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842E175B6F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjGTSjQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 14:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjGTSjP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 14:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8242D50;
        Thu, 20 Jul 2023 11:39:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38C0561BF4;
        Thu, 20 Jul 2023 18:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B13C433CC;
        Thu, 20 Jul 2023 18:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689878350;
        bh=cJdsEMWu4Vw4UDfbXEhrIi77kKUyxBMQ+oaGSCuCK3E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YZkcJhFTmw1HPNCUbq/w1IfKEsEptFEJD1W2JPuwWxGr7tFO9SQCTfZMaEDtHuq8l
         e4zUx/zO+3w1TccNL5Y+8tenapCYOzqcq6IKH+pa2I0q5vpqoCTRcN3Rlf7hqUl2Lb
         Fcs6Fw1RgUL1heKymdHm3vK1/IkTiXJkJgqFjQR1hMijVuVwprGZ02lV7O0s9EHviS
         1tJu7D1NntfhigBfbxuXejuLWgegfJDnIpnnSS+OGTI+rvKuIe1OrOmwg0BaZcwPVz
         SDFuCMKGoQa75D8SWoNqk6tzkMO6XEa1p6cPZjyMWqcGLUL/KwnISz/HWfVhEjTzW+
         m5LAliREjPL+Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 20 Jul 2023 19:38:58 +0100
Subject: [PATCH v2 1/3] arm64/fpsimd: Ensure SME storage is allocated after
 SVE VL changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-arm64-fix-sve-sme-vl-change-v2-1-8eea06b82d57@kernel.org>
References: <20230720-arm64-fix-sve-sme-vl-change-v2-0-8eea06b82d57@kernel.org>
In-Reply-To: <20230720-arm64-fix-sve-sme-vl-change-v2-0-8eea06b82d57@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cJdsEMWu4Vw4UDfbXEhrIi77kKUyxBMQ+oaGSCuCK3E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkuX9H8a1ZEjatBHUy3+YyrBKN9Ns5zmE97HZq59se
 mG1hfjuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLl/RwAKCRAk1otyXVSH0BFLB/
 48MuNQeHejkUjg+G0TolCglEKFMd2HtiKuI+aYs/va+ARg5B5tGns4k2GfNlWF3F3MncLnUHAh6pi0
 uoZE8qR/HEHBQHh4ls8cAgx+zwm0BKVdRn85HEjCBA64N9Acm6AxpYS7OqZSq5gf736VUDI3tv0kTW
 hGf7qZpF95H28Wey0JMlDoHhmIgbniieL0gyklP4t5Zdvo0YwF79VKAXd1Ck/CB6G4kQLhcWvN94tU
 s9H+8v0mJHQjSzZntWYNYoFykVM1cQjTzmnXhyKy6USVDT1HWfVoPq6b6IhcfgTCMLvL6GxSCurZAz
 3ee2zR926o69yQ3TBwXC2+a2sbrtUw
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
the storage for SVE, and disable SME if we change the SVE vector length
while there is no SME state active.

Disabling SME traps on SVE vector length changes would make the overall
code more complex since we would have a state where we have valid SME state
stored but might get a SME trap.

Fixes: 9e4ab6c89109 ("arm64/sme: Implement vector length configuration prctl()s")
Reported-by: David Spickett <David.Spickett@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/fpsimd.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 7a1aeb95d7c3..89d54a5242d1 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -847,6 +847,8 @@ void sve_sync_from_fpsimd_zeropad(struct task_struct *task)
 int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 			  unsigned long vl, unsigned long flags)
 {
+	bool free_sme = false;
+
 	if (flags & ~(unsigned long)(PR_SVE_VL_INHERIT |
 				     PR_SVE_SET_VL_ONEXEC))
 		return -EINVAL;
@@ -897,21 +899,36 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
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
+		}
 	}
 
 	if (task == current)
 		put_cpu_fpsimd_context();
 
 	/*
-	 * Force reallocation of task SVE and SME state to the correct
-	 * size on next use:
+	 * Free the changed states if they are not in use, SME will be
+	 * reallocated to the correct size on next use and we just
+	 * allocate SVE now in case it is needed for use in streaming
+	 * mode.
 	 */
-	sve_free(task);
-	if (system_supports_sme() && type == ARM64_VEC_SME)
+	if (system_supports_sve()) {
+		sve_free(task);
+		sve_alloc(task, true);
+	}
+
+	if (free_sme)
 		sme_free(task);
 
 	task_set_vl(task, type, vl);

-- 
2.30.2

