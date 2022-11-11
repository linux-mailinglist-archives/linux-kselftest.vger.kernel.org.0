Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C5A6263D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiKKVvc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiKKVvW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D153C73769
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 689EDB827F1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DB5C43470;
        Fri, 11 Nov 2022 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203478;
        bh=WtLZskmj0qPo98o2L14apeeTu/h7b96ZNMltJ+zQPHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvuG0ifuald5f4Sk8K5IfrJGJ+cFFJ5i/LZuBRLHBO34HuFZbwVPB8RLk+DtLQWNG
         nZvuFkbjdzbqOJvB7G4Fpzw7EDSbZX6tEs+DfCirYGvHygNoCN60mXhERo0CFzGkx/
         N4JT8n60FX9Jyd6IavwPBsoEMNtlxgvbOn2TVmjaCe1/TTfpp2UwA5O2xGqJjTZ2db
         klwoPK7gIgGtgEQy4jelPzP4Y/RDmWjCDS7iSgcc05XUuXZByzmAJta15HJUjwPEti
         PXYdDfdDFNkJzRKgAepuYoBBUQneousFT7TKPhoZP2Xy9uJGCRKy/rQEW4eoP+cVLz
         rEg55cK2bTSGQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 09/21] arm64/sme: Provide storage for ZT0
Date:   Fri, 11 Nov 2022 21:50:14 +0000
Message-Id: <20221111215026.813348-10-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3004; i=broonie@kernel.org; h=from:subject; bh=WtLZskmj0qPo98o2L14apeeTu/h7b96ZNMltJ+zQPHo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOVQsw2eFc36W6Nj2o/z05lO1c+jtujGyIEcwYm QWn+JCuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DlQAKCRAk1otyXVSH0NRgB/ 4qWxwZSr4PIvzYgiP4h1awnVYF4aLxZPPgW5ThBc9c6kCDs91My2C/WiLpU8friuVOPIA8huVT/Qfi 5XXfqE1mXbtaLm/iZ0czvVmNEW5KzOKzGa0QaO9qP8KllfRsyQRkvyXQEysfAbGThVgbTAsKZr5glA 8cd8nb5767/sK8tMxZLHewtGUXbtUxTC15ZjwjerXLVDwzGE9l1mVnY0cmQOqgzVdsQlnolhYvZV/p vMsGEJtSw6flsXO3vFFq4U3aqmFjhswNY0fn12FNh7G8THZ1thjRH0IGns36Wr5mub92mdkO1teXkQ JAFKoxPtKydx6rlKBXjpe+juMEIlEs
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
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
index f2bda963cfe5..2d7a69b49349 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -96,6 +96,13 @@ static inline void *sve_pffr(struct thread_struct *thread)
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
@@ -345,6 +352,9 @@ extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
 
+/* Will move with signal support */
+#define ZT_SIG_REG_SIZE 512
+
 /*
  * Return how many bytes of memory are required to store the full SME
  * specific state for task, given task's currently configured vector
@@ -357,6 +367,9 @@ static inline size_t sme_state_size(struct task_struct const *task)
 
 	size = ZA_SIG_REGS_SIZE(sve_vq_from_vl(vl));
 
+	if (system_supports_sme2())
+		size += ZT_SIG_REG_SIZE;
+
 	return size;
 }
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5cfb876c76ee..b7919bf45e2e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -307,11 +307,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 	/*
 	 * In the unlikely event that we create a new thread with ZA
-	 * enabled we should retain the ZA state so duplicate it here.
-	 * This may be shortly freed if we exec() or if CLONE_SETTLS
-	 * but it's simpler to do it here. To avoid confusing the rest
-	 * of the code ensure that we have a sve_state allocated
-	 * whenever za_state is allocated.
+	 * enabled we should retain the ZA and ZT state so duplicate
+	 * it here.  This may be shortly freed if we exec() or if
+	 * CLONE_SETTLS but it's simpler to do it here. To avoid
+	 * confusing the rest of the code ensure that we have a
+	 * sve_state allocated whenever za_state is allocated.
 	 */
 	if (thread_za_enabled(&src->thread)) {
 		dst->thread.sve_state = kzalloc(sve_state_size(src),
-- 
2.30.2

