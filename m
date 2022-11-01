Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6C614CD3
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKAOjk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiKAOjj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB9012AFF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64A3C615AF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97BFC4347C;
        Tue,  1 Nov 2022 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313577;
        bh=WtLZskmj0qPo98o2L14apeeTu/h7b96ZNMltJ+zQPHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTjyV/81DGsCax1YBvLPB1mDTZkpe2yPHjYicXsB8M5Z0SJ3n2d5k9rYVtM0TyPvI
         GYCW0mRYTVcVrmopebHLgb6/FqSfeKXru0v1wB6kph4n3T87A8jgu+cDpQ7LkSZVoD
         x8V3M6w7IWTXzr68/XnKZqCoLF2Chm6FhvMQJmSpsBKUEzgcvIDGF/Cavfup8z6ovf
         Xkby0gzwa7cFiOyhsOwCQx/BGhzRT8aLyVqrtyMmjUMOq43Cq6XdHWYBXmmiGW8cEx
         +u9v42T990oukUefN1lyDNpTXl6Oelyyp+FidZAgSPcDnVhCkItZ1UJvdW74vcRJTq
         o/4SxpG+lJofA==
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
Subject: [PATCH v2 09/21] arm64/sme: Provide storage for ZT0
Date:   Tue,  1 Nov 2022 14:33:24 +0000
Message-Id: <20221101143336.254445-10-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3004; i=broonie@kernel.org; h=from:subject; bh=WtLZskmj0qPo98o2L14apeeTu/h7b96ZNMltJ+zQPHo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4yQsw2eFc36W6Nj2o/z05lO1c+jtujGyIEcwYm QWn+JCuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuMgAKCRAk1otyXVSH0GT0CA CDgeib0V8bpeC2U5Wm52+G07etBIqOvvQO8A5iPLCugp6sKf2R6SuKT+iVBLyOqsjKnCgdmS7FhDJ+ NAZixiFw7ryQvTYC5fNhLtG8ILHvhJUTLoFL0FiEY8KO2358CxifvVcNEZtq+94itropg2huYOhAVc 7F2bb1Bx5Scb+ext5usFdCgi9hD9R6CkRXehWo+N0D33+mb+oq3rYKT9W1ds34oTCB399y+LD4A6pH sEAxmzQiKnVm+Ws/dRRaU/ZVvPw5lQ+irSjuZ8UecDroS8XO3P2cKUPwpTVszpm6qJmwqkXNcP7W6x D/WlYpnxq+1V9oOkcgHG9voHE0ScvR
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

