Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7B0432726
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhJRTMZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhJRTMY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:12:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E91F861074;
        Mon, 18 Oct 2021 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584213;
        bh=ajUFFSTv9Xe/upb2ehZFq+kHiuY4thdCEVsSHOKL97Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvQoon/eHTNs4GXy9OJOhOYMRRqCfj4brDAIigGbgKWe5F5U2AaPVEmKz0YVHA2Cn
         1rKaCuTLdpqonGc2aCv+leoeI5y8NzIRPfGl4Zv087aV0aCLW/cKxKpdAET3etSDo2
         dqBTxoebub05VBt47br92dP+qr+QqB84nBzI10Ehk4cepT/Bj7YFvZKfOJIyt9kN4t
         tbDgzTYVo527hLDpggLSSMt69d4Z8mu2gbkPrtWi00RHmIZK3rC5m68lnKya9R3z6t
         wHWFuDohTAULAArZ8TemmSL2w63N1VsjIvKG+kHeTKhEkIUQuzknAhgxzw1QfMjdr+
         Nfq8QArRnlnyQ==
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
Subject: [PATCH v2 03/42] arm64/sve: Make sve_state_size() static
Date:   Mon, 18 Oct 2021 20:08:19 +0100
Message-Id: <20211018190858.2119209-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440; h=from:subject; bh=ajUFFSTv9Xe/upb2ehZFq+kHiuY4thdCEVsSHOKL97Q=; b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBhbcYpT4KSr1hE7x4IGXRxcpaK4VMzer9Oc+NVFHS8 n1d6Mt2JATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GKQAKCRAk1otyXVSH0E6vB/ jJuX3+e2IvtLdkojuRGJ+3w/JMALAbk4LHPw8I1oMtEHQ8QvfyWYR1BELwrkbysJ2iX3M0a8iqtiYN zFIu+G83nwt0XIp1N1Rm9l2dnY3nS5JQ4tP7U5Io6FuikN0pTDMDZDVAbEa+fXjaNiU5pQo6XWi8r0 7aDgCqb/pNJKRCRF1SZ5Yv51NUk5DWJyCddRRmxXb2aE7Bb3hJEo+C2aCUof8Paa7C4bg+uwvDlVWu ghHT3P1T5NMnEgEjNn7m3PzrtecBlQVTYr88MWxhPMGCMWgWdiXlxD53tQ+5fnD3PP/2LC8OpNIKn3 yElmjVvu8/0SN2KxRGgJuSQoacNj4=
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are no users outside fpsimd.c so make sve_state_size() static.
KVM open codes an equivalent.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h | 2 --
 arch/arm64/kernel/fpsimd.c      | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index e0e30567b80f..917ecc301d1d 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -104,8 +104,6 @@ static inline bool sve_vq_available(unsigned int vq)
 
 #ifdef CONFIG_ARM64_SVE
 
-extern size_t sve_state_size(struct task_struct const *task);
-
 extern void sve_alloc(struct task_struct *task);
 extern void fpsimd_release_task(struct task_struct *task);
 extern void fpsimd_sync_to_sve(struct task_struct *task);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 995f8801602b..0f6df1ece618 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -497,7 +497,7 @@ static void sve_to_fpsimd(struct task_struct *task)
  * Return how many bytes of memory are required to store the full SVE
  * state for task, given task's currently configured vector length.
  */
-size_t sve_state_size(struct task_struct const *task)
+static size_t sve_state_size(struct task_struct const *task)
 {
 	return SVE_SIG_REGS_SIZE(sve_vq_from_vl(task->thread.sve_vl));
 }
-- 
2.30.2

