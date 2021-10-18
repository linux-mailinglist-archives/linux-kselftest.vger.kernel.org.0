Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C865A432725
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhJRTMV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRTMV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:12:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17EDE61351;
        Mon, 18 Oct 2021 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584210;
        bh=6jAyzoU7sbK3D2Np76VXH9OD8yxSnhT/AlyskwNIuCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nz8gqMFhRixlxeKu1QQVYx54rrt0/mTTG8qcQ795E/cb7fI1DBDzKrQNcQos0RU9m
         5FALPF9U1sju+q3jGb8peKcfbEtRIwQMo1ewn87arqqmt4jJeo9lr/x3vi4xYfe9+E
         kjPASeGrxVnl51yDTdYYzo7nGKAQ/LVQ7WVsTn/vjNKLiJ3P5pX3tW8bcz3nak8kIh
         37hN49KkDCdKVUMCpR3Kr3NosQaYz5bkYzNlhZBybeR7jI392q2g+BN8+CcjlxKp3Q
         d2kMciBahpNP0kYDlSPTcm6JyurQ5rj7SzNW5cvXzaQ02/5gILxrHSN/HLMDE/Va5d
         Gt1kTXhC18Tuw==
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
Subject: [PATCH v2 02/42] arm64/sve: Remove sve_load_from_fpsimd_state()
Date:   Mon, 18 Oct 2021 20:08:18 +0100
Message-Id: <20211018190858.2119209-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; h=from:subject; bh=6jAyzoU7sbK3D2Np76VXH9OD8yxSnhT/AlyskwNIuCs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcYopTwOgZh/1AfkKXCMC6CCaTm/+AOMIBKeHQff we1QQN6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GKAAKCRAk1otyXVSH0CX6B/ oCWtXDpfyFDfk6CSTZ99I6URivLRi0y+3G5aU2KOwhdTjwdtwecqJeykM55jLoXtThGe8ipTyJAezA MkSC92CAUXkAlBzDsMtCAQJ2QJ60fwFGilJDAx5FTRU/ILzl9OlPJv5xhPu/8spl/+Zr6Ve3ZbeLKt UCyM5jXw5Kc/AlCFVdI20dOPGToeKVjgrt52Hq2R7Kpxx6tNXWRHdGzvojqZLG600kWwTpIMb9TJe8 sZzzr6wTdB5EYtD/KNhL+Wti46N23GoI/++ypEu9XFVkNrUfapcNClXNTTYupiDNI7cs2L6zd9e6CN 0gYThN94paGSyLtbTFiY692WX13x0i
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following optimisations of the SVE register handling we no longer load the
SVE state from a saved copy of the FPSIMD registers, we convert directly
in registers or from one saved state to another. Remove the function so we
don't need to update it during further refactoring.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h  |  2 --
 arch/arm64/kernel/entry-fpsimd.S | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 9a62884183e5..e0e30567b80f 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -69,8 +69,6 @@ extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
 			   unsigned long vq_minus_1);
 extern void sve_flush_live(unsigned long vq_minus_1);
-extern void sve_load_from_fpsimd_state(struct user_fpsimd_state const *state,
-				       unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void sve_set_vq(unsigned long vq_minus_1);
 
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 196e921f61de..afbf7dc47e1d 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -66,22 +66,6 @@ SYM_FUNC_START(sve_set_vq)
 	ret
 SYM_FUNC_END(sve_set_vq)
 
-/*
- * Load SVE state from FPSIMD state.
- *
- * x0 = pointer to struct fpsimd_state
- * x1 = VQ - 1
- *
- * Each SVE vector will be loaded with the first 128-bits taken from FPSIMD
- * and the rest zeroed. All the other SVE registers will be zeroed.
- */
-SYM_FUNC_START(sve_load_from_fpsimd_state)
-	sve_load_vq	x1, x2, x3
-	fpsimd_restore	x0, 8
-	sve_flush_p_ffr
-	ret
-SYM_FUNC_END(sve_load_from_fpsimd_state)
-
 /*
  * Zero all SVE registers but the first 128-bits of each vector
  *
-- 
2.30.2

