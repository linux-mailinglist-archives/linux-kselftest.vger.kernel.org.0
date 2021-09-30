Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304FB41E0B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353321AbhI3SR0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353145AbhI3SRZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36C1D61A03;
        Thu, 30 Sep 2021 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025742;
        bh=YMRTMA9hSAH3XNdayzm8DwXzxJoEVd5olRUatLntM2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H56ba7r0+4gpeOI/FR6prkQ0ERqA0lMhS44DOCEiXuL3w8GnGLcJi1LmKN0l7NVGP
         cD8bOtfYH1AXpbxWx+4SN5G51OOSJkDAzsNh+qXKeaqbHoIzAB/0LBEEWXZVINzCwk
         zgNX8ka7dFV0JZcp4OjfuZWwng4VCcaXHiW1HN9yR2NjWrGniFgI64wqgwSVGGPAP8
         LXuPpCNKwXxJza1a/0/WwWgdsqsM75bSn+pwq4LOYy1qOE7PXd4jIpX5iuISC1SJJj
         5rNsy8lkUCpO4Aj6M6jwWqcX/m8CgKribYJ8YkyFwbtIwZIwel4oTbfVUx42XM1vp8
         6+Scn2s56XB9w==
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
Subject: [PATCH v1 02/38] arm64/sve: Remove sve_load_from_fpsimd_state()
Date:   Thu, 30 Sep 2021 19:11:08 +0100
Message-Id: <20210930181144.10029-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; h=from:subject; bh=YMRTMA9hSAH3XNdayzm8DwXzxJoEVd5olRUatLntM2k=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3DCKU6l6/oAmr4ExBKFpd8OJZti2P9OqJprVU+ vBHkXuaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9wwAKCRAk1otyXVSH0LzdB/ 41ff/cIVDGtrMjzgueJuHjjG7xoSLdKdn4VmYpiYhEZ1R1Ju0zKdccrLaJk0f7dWPjGhuAj0fjlzSz pWD2esjIS25Lu98NSBTn8QuipsGPFgfL4plVraVSAGXI+PArUwx+OMmMh92uvxbZQsWAV/PLFwJ9hv Za1fsG3WqIjicJlXYtIvUA/82NJx9FsSYeyo4fbjDfa4BA05Sqa2IsnNm0bFfpphVnjHVpCteRA4OO TeNR82/mKJREhnCUmftrYDnjsBxI6bxHlV0oIYrtHwS0GNQ8mpmyjXqKMN2YDSw8EAAoPqY7KqBG01 ne98pwHADJbaf/bZWOusvRtFSox+RM
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
2.20.1

