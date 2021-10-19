Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA9E433D47
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhJSR0B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhJSR0B (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96BC3610FC;
        Tue, 19 Oct 2021 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664228;
        bh=qGViczQi8kfgNY18tuJ5XZePAITEPk1XLPM+P37XPQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHtJqp6GSrKGF7qgfiEh7Rn4FnFI6LMM+hRxzAlE0bPOnq2l8vRlfaMULjIVlUKyw
         B6u3JWwcvXvrmi2nD0u+u/1toBY6HJEEJj+Xt7TPA6RdumAsVc0XLW5L7nPUSAFPme
         d2pCjmeDe7HZcoouuu8cXCUytOx1X4E5pcROZf2BNzHEZX6QRnS+fnraMc/mgJyaKx
         e4psJkzsEh/uv4bR0+oSPu8k6R8eJUNC3Imt50USnqTbx0h8k8balQtc4e4GfTvaCW
         V8HX2pHvYoOjDQKFutEfrCEci46+XC/CwvCLjPBZZBR53YWR8WY0JiFzUUcayvi+lA
         b7jnm9J9fblYg==
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
Subject: [PATCH v3 05/42] arm64/sve: Rename find_supported_vector_length()
Date:   Tue, 19 Oct 2021 18:22:10 +0100
Message-Id: <20211019172247.3045838-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2501; h=from:subject; bh=qGViczQi8kfgNY18tuJ5XZePAITEPk1XLPM+P37XPQ8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7HxsQwMpRVO5jjNNCNWpOVBsOxh+6gS+S7dlRT iYBw566JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+xwAKCRAk1otyXVSH0GdEB/ 9tUody1RF1BaXo3rBrGoNV6QZDR2y2SECibv+mnLQmgGoJzy74drLDhdh4gyx4OIk0rcngLx2rPLN8 t1iwvn5gYxFaR+oR1w5+XoQNgCew87nbDjFBaGPeoevnXX+kP6C5tHCwZtETKWtPBamqU7+E3UI6Ri +hRYBNXtYi8YsJLbRJcv1NiSV/Fm2Dh6OF4kRSJyykeYng0/2f8GxSvN54jMxAdxnWjDZL63D/nRTL /ghWF+VlOoRTxVJb2OYND7tFI9YFvZ7/q7FuaDkh3Q2zESxWFmzG2v3Uq3Mwi+9aUg+h7PSAF0qmEX VZdZ9flwNhNXJ9ArsSaKYbsGfIRtfs
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The function has SVE specific checks in it and it will be more trouble
to add conditional code for SME than it is to simply rename it to be SVE
specific.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 3d5d243c3f1c..25aa6f2386a1 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -337,7 +337,7 @@ static void fpsimd_save(void)
  * If things go wrong there's a bug somewhere, but try to fall back to a
  * safe choice.
  */
-static unsigned int find_supported_vector_length(unsigned int vl)
+static unsigned int find_supported_sve_vector_length(unsigned int vl)
 {
 	int bit;
 	int max_vl = sve_max_vl;
@@ -379,7 +379,7 @@ static int sve_proc_do_default_vl(struct ctl_table *table, int write,
 	if (!sve_vl_valid(vl))
 		return -EINVAL;
 
-	set_sve_default_vl(find_supported_vector_length(vl));
+	set_sve_default_vl(find_supported_sve_vector_length(vl));
 	return 0;
 }
 
@@ -598,7 +598,7 @@ int sve_set_vector_length(struct task_struct *task,
 	if (vl > SVE_VL_ARCH_MAX)
 		vl = SVE_VL_ARCH_MAX;
 
-	vl = find_supported_vector_length(vl);
+	vl = find_supported_sve_vector_length(vl);
 
 	if (flags & (PR_SVE_VL_INHERIT |
 		     PR_SVE_SET_VL_ONEXEC))
@@ -873,14 +873,14 @@ void __init sve_setup(void)
 	 * Sanity-check that the max VL we determined through CPU features
 	 * corresponds properly to sve_vq_map.  If not, do our best:
 	 */
-	if (WARN_ON(sve_max_vl != find_supported_vector_length(sve_max_vl)))
-		sve_max_vl = find_supported_vector_length(sve_max_vl);
+	if (WARN_ON(sve_max_vl != find_supported_sve_vector_length(sve_max_vl)))
+		sve_max_vl = find_supported_sve_vector_length(sve_max_vl);
 
 	/*
 	 * For the default VL, pick the maximum supported value <= 64.
 	 * VL == 64 is guaranteed not to grow the signal frame.
 	 */
-	set_sve_default_vl(find_supported_vector_length(64));
+	set_sve_default_vl(find_supported_sve_vector_length(64));
 
 	bitmap_andnot(tmp_map, sve_vq_partial_map, sve_vq_map,
 		      SVE_VQ_MAX);
@@ -1066,7 +1066,7 @@ void fpsimd_flush_thread(void)
 		if (WARN_ON(!sve_vl_valid(vl)))
 			vl = SVE_VL_MIN;
 
-		supported_vl = find_supported_vector_length(vl);
+		supported_vl = find_supported_sve_vector_length(vl);
 		if (WARN_ON(supported_vl != vl))
 			vl = supported_vl;
 
-- 
2.30.2

