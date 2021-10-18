Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120A1432728
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhJRTMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhJRTMa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:12:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C2F261074;
        Mon, 18 Oct 2021 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584218;
        bh=qGViczQi8kfgNY18tuJ5XZePAITEPk1XLPM+P37XPQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMD5E2stG6S6MPunUKAdpanQ84ln4xnOL3XPAZJm0dbxgNuLeKNbSKYJaS9PY4axv
         qKjWtvcQkROcuS59af9a5PBYwNnCeapAK4Rmr5yOSoTYv1aJtYXihQ/gcoD7RBN1YB
         Xw9nhtzXaWoC9kYJXKEqV9O53f4/RzmauhoMfPojQiT0ggDU+rJhs2VkNYMOsYfg3q
         axu7slDeafPXpLvISvzx19FzpIJbDd8S2/UYFIljupCeBvDS/n1eIieVwnIRecn7pc
         kP0LMtzNFDlPiaAJUkdANIO9lANMwNfxZo3vMwREFxEoEtDiRYkqu+KPyBTE481AI0
         4DZvVVg/8rSIg==
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
Subject: [PATCH v2 05/42] arm64/sve: Rename find_supported_vector_length()
Date:   Mon, 18 Oct 2021 20:08:21 +0100
Message-Id: <20211018190858.2119209-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2501; h=from:subject; bh=qGViczQi8kfgNY18tuJ5XZePAITEPk1XLPM+P37XPQ8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcYrxsQwMpRVO5jjNNCNWpOVBsOxh+6gS+S7dlRT iYBw566JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GKwAKCRAk1otyXVSH0IbUB/ 9BW0YFO+rH/mGo/D9M4BXvXh9Jqrypd+Rn/R46dmei0aXqSsMYX+1V17ZBcbkQBPhrY/1+zrVwvWTk 2xTXCMcbXk+0BXT8zMcKWfWh5YeP1/jp2dnAc51dqvp2GzPSxdjRPL+VAglkBk24klmiJ7l8NPSayT 3S1idgYBfs8oTwvcK0oCb73Dxip2If9Mj1UuMp+f/4XeQDlQfvjdsPrYWhekBjLf+Ll0bJ5wUtfEXU /TqzW3ADRkbpgj5m51wsqVynewBLkHi5vCzmBnTlW8OtLsSYNJL2012unltn9ARJGlHQEt3Cl8+WqB SpVsbSorBeshmZjbqGRCMwNBCe9Yry
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

