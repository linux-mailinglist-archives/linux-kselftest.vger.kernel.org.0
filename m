Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE7D433D44
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhJSRZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhJSRZw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:25:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 340A2610E5;
        Tue, 19 Oct 2021 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664219;
        bh=6jAyzoU7sbK3D2Np76VXH9OD8yxSnhT/AlyskwNIuCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkJmyrFd4DVx4MvnYqFb6MbscO22RNhmbH2cUAamriPQZjD8K+W0RU/RhOIxgsusS
         zR5G2URdcIE3ASbNACE0Qb2OdKk1SgL+hoaJsTuOb8e8jtYQ0S2hgqXf7QQRUvz7HW
         y48zDOSirXq3Y1Fs7K2ULpQM5Ia9NlWhke9kzAaDA6CI0PUwZ+ltXeabT1ijF7iSWq
         zJ+sBEbGx+8+P+nDsZEkuyPMJQekSyA9dAj28c4eCcmsCqtJuo7oFXHqFSLJL538QY
         Lyd79wwRpM9ZdvJ+21NIosb+IBlIb9VhUsgO8tBDYb1fakyeXk3TiRpvt+NSLDNPew
         4H+sOO2Qlobpw==
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
Subject: [PATCH v3 02/42] arm64/sve: Remove sve_load_from_fpsimd_state()
Date:   Tue, 19 Oct 2021 18:22:07 +0100
Message-Id: <20211019172247.3045838-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; h=from:subject; bh=6jAyzoU7sbK3D2Np76VXH9OD8yxSnhT/AlyskwNIuCs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7FpTwOgZh/1AfkKXCMC6CCaTm/+AOMIBKeHQff we1QQN6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+xQAKCRAk1otyXVSH0EMfB/ sEH5U1XYru3j05qeJQbVU88Fk1/lqlHbT7lo3yzVj1I5kgugEwNlbKELDWSS1Zqu35/jjpMMZITVyQ 9kyZbJY1YbyAEsilO85U07PuiSnHqo4c+EbC2NeqH1ZtG6Gz9ZGcVmfF4q7oGXw+XhO9Uc+VjO1YKN oKjCFRxImmx3VVY1fu7E3WESyD1T4RQQIuPq2Xpd6z2pA0+ggkNLJBSWL9DUysZqqcGQCLuXa1rPZt KVMDA8HiH+mrf69Hfv1z/VI7iyhbVq/u6vmJlv5eT+UgjtV2P++WYo2dMCfZYgugiLhCKDEF6yftJ/ sZ3jXmuaUZz19bWegTaMdrjnqK2/WX
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

