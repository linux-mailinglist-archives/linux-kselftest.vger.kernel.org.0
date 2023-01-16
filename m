Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F9866C5BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjAPQKB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjAPQJK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:09:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D57E27D77;
        Mon, 16 Jan 2023 08:06:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E413B81060;
        Mon, 16 Jan 2023 16:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90ABC433F0;
        Mon, 16 Jan 2023 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885171;
        bh=Z9m1L9CCYmsUckq6Ug10yYsoeGBftC2rqgGXdm+qGnI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=C41zsSd4TYcbQ/935ulv95zqpnpesewkagwrYKczcMlSez6jk/ucsSXMpyNfdWg/L
         Hp89tkV1UC8uklvTDKSGCcsiAjEE7XbmE8oCM81Lx4qkAFSO0JoCSqPJaZvWrbAWhV
         VacOuPCg1tvNoKLkcx/Dv9ybTR9NZP5iQ3nmKe6/QA/6jFBajZckfXKrkH7d99fEXW
         smH9isCoOCw62Ahd0DTceEBNGEzGp3AGMGNgJTCaE3BawnIOeP5tiuoDZFYAIG9xgq
         akzdHPKxDas3bci0raQtWWrggAFxvL4Cw8FYgOJz3xoOiridNKLmA4ZDJfd9VdFC3T
         w089dqoyYzFPA==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:44 +0000
Subject: [PATCH v4 09/21] arm64/sme: Provide storage for ZT0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-9-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Z9m1L9CCYmsUckq6Ug10yYsoeGBftC2rqgGXdm+qGnI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWo3OFkxngCoQuoGUymajWBKPQe+b4/Y5YeZMaF
 G5BAmLuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1qAAKCRAk1otyXVSH0Jt3B/
 4u0a0q7OQe2DN6lWm1akjYOBoPvsGVRUWLjHsm6PNJSSsIew/4ir0mg5ltnWtPZEwWNDp67WzYDxWj
 OsyiXKkIQE2OH1copHrOJH5u0h4khkod8z9dYwMIzRZ6OE2WmbIbFG7da3hRD8OiLruEmFUVveNxeY
 purfXEwumoy0j17TcQANEII7T4eVOSOYmSz97FBaUtHwa9RueFMqmOUT1co14auOdgcEtre1vvleRt
 kALejXM1nw9yfIGhVC1yukSRxsRyZWg8yagPUcFKvvLBk55oKvAJXE/nltfbk+PaAfBzQX4YDWRX25
 AWq8IfA0Ta/sgfFekz/K7hy4VvJ5W5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the system supports SME2 there is an additional register ZT0 which
we must store when the task is using SME. Since ZT0 is accessible only
when PSTATE.ZA is set just like ZA we allocate storage for it along with
ZA, increasing the allocation size for the memory region where we store
ZA and storing the data for ZT after that for ZA.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h | 13 +++++++++++++
 arch/arm64/kernel/process.c     | 10 +++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 2a66e3b94553..8df769c20677 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -105,6 +105,13 @@ static inline void *sve_pffr(struct thread_struct *thread)
 	return (char *)thread->sve_state + sve_ffr_offset(vl);
 }
 
+static inline void *thread_zt_state(struct thread_struct *thread)
+{
+	/* The ZT register state is stored immediately after the ZA state */
+	unsigned int sme_vq = sve_vq_from_vl(thread_get_sme_vl(thread));
+	return thread->sme_state + ZA_SIG_REGS_SIZE(sme_vq);
+}
+
 extern void sve_save_state(void *state, u32 *pfpsr, int save_ffr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
 			   int restore_ffr);
@@ -354,6 +361,9 @@ extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
 
+/* Will move with signal support */
+#define ZT_SIG_REG_SIZE 512
+
 /*
  * Return how many bytes of memory are required to store the full SME
  * specific state for task, given task's currently configured vector
@@ -366,6 +376,9 @@ static inline size_t sme_state_size(struct task_struct const *task)
 
 	size = ZA_SIG_REGS_SIZE(sve_vq_from_vl(vl));
 
+	if (system_supports_sme2())
+		size += ZT_SIG_REG_SIZE;
+
 	return size;
 }
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4ce0c4313ec6..71d59b5abede 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -307,11 +307,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 	/*
 	 * In the unlikely event that we create a new thread with ZA
-	 * enabled we should retain the ZA state so duplicate it here.
-	 * This may be shortly freed if we exec() or if CLONE_SETTLS
-	 * but it's simpler to do it here. To avoid confusing the rest
-	 * of the code ensure that we have a sve_state allocated
-	 * whenever sme_state is allocated.
+	 * enabled we should retain the ZA and ZT state so duplicate
+	 * it here.  This may be shortly freed if we exec() or if
+	 * CLONE_SETTLS but it's simpler to do it here. To avoid
+	 * confusing the rest of the code ensure that we have a
+	 * sve_state allocated whenever sme_state is allocated.
 	 */
 	if (thread_za_enabled(&src->thread)) {
 		dst->thread.sve_state = kzalloc(sve_state_size(src),

-- 
2.34.1

