Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68626433D45
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhJSRZz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhJSRZz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:25:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05D1F61212;
        Tue, 19 Oct 2021 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664222;
        bh=ajUFFSTv9Xe/upb2ehZFq+kHiuY4thdCEVsSHOKL97Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFb0TkMmlaO0CuaKqJERKzhyMDZ80RD+jdwDJy+y4+Ow07ozNn9uwSvSEJrLIymxI
         tKLGXFgjbAKaKyga5ie/5dy+wdzGcM8czww8q8UF2Ckaafqyb8SrghxWjZvciCYJGW
         1RchFp1iFjlp41bheyz/f+c5nikQ25U5jQ5PLzhGiVDwOJ26fxLJQQJxb/Du0sGhSO
         ynl4+4lt+J8wt7+5m8deGhtUJWCT+vZxSHFm41z16q+7/8YHSi/5leiQhouzuFirID
         YkUg9ablxZVSPCaION3XCZJpsdTcWdKyizMRXgw4pUwzSpSschKgSm+7MpchTjb3Om
         tezwJwj6mu57g==
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
Subject: [PATCH v3 03/42] arm64/sve: Make sve_state_size() static
Date:   Tue, 19 Oct 2021 18:22:08 +0100
Message-Id: <20211019172247.3045838-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440; h=from:subject; bh=ajUFFSTv9Xe/upb2ehZFq+kHiuY4thdCEVsSHOKL97Q=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7GT4KSr1hE7x4IGXRxcpaK4VMzer9Oc+NVFHS8 n1d6Mt2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+xgAKCRAk1otyXVSH0PNIB/ 4jzGC+HqZNN+LDqhqau2J5foBxmYin7eUFYCftTwOA32+70MvHPH+pJEE9AtpWrniDanqCgLbNP8gB ijK3Zwz+n8VHJX500uoUiDuCL4aZerlWyc5nsls5bs+KILWG5NSReYAEXqwqE6CSmMbeWjZgtkxR1o KBO1eWA2DgEo+HTf7AHfaGuSaU1N203xb5pcdHhCCyYLFmHAV5byzS6esjg568DxRlsjkdfu6AQWAY VKEo1BwV4dJBlWRFowtIbIDzyPa5+WBsizj5Hccwph4gAPjXVfXGuG8IybzePd0f4n8GhRVmbuMbFj 8koqU0aefnk9UWZ1uY5AHOMkNbImo0
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

