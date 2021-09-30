Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E843B41E0BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353323AbhI3SRb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353145AbhI3SRa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 475266140F;
        Thu, 30 Sep 2021 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025747;
        bh=9bcf7KxjnHwy84LLqVT2WnWXLe06Wq7dmDWcSm397U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dzhn7LnVDtLMcZBjcKOXLxzwC8Ddadq4nW/cmw0YWAFPA4lZMmPyVJeZxcCAEoFKy
         EdDqN5NQ9R31Krc/pP/Fy4q69Zp8RZiGC5gvJmIfVaRWttCJ5MvnYv1UdmY8oo0EJ8
         4Fh0HRW5DgXWGLvobo4JYPXqZrmRL041xbHSCevjsLZWD9VQwn7JEB+LY2QacRrLa3
         iWNZbpOM15Lm+kQOa4esr5L0rwXU3P9FQSCoQ6DEDDCrgbKEbIew2Chk1BN++PwI1I
         aycXf0s6l+8QWheij30NJvGInwYGJoF/ugsqlNjdcaGrWvl21ZTbKT1zj1CyXD0+Y7
         lBjnPkPhXfU2A==
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
Subject: [PATCH v1 04/38] arm64/sve: Rename find_supported_vector_length()
Date:   Thu, 30 Sep 2021 19:11:10 +0100
Message-Id: <20210930181144.10029-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2501; h=from:subject; bh=9bcf7KxjnHwy84LLqVT2WnWXLe06Wq7dmDWcSm397U4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3EVkrXn6fpHj4dPsvwd+7Bohc92mOvGdm5ZmL4 HxEgWXqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9xAAKCRAk1otyXVSH0HulB/ 0YWPgoP4fwpMbpc3f9Dop3HPiTKF+gycRFh7ywTqRw2NB5NA4eNmUb8/mE0oqt9A0w0KVzTE9n7lpt d5H4bAOrVyMxFsf7ns53KNT0NvBaOyXOR/q46HKPoATdhEIVbhoXR80CpK1lg4HjgcelhybIh0+y8+ NGHsDL2jigKGpFuhh2ohuHMCoZGPwVyabs4uyM9joWYlQCwqhHDmuLlO2rNXl29zsoByv7sZCUPLDU 2qId51zaWPFLPViIdPWW1/8H4A8cM1HY4dIYQNpllRhnQW9Ai4TtR5eNh2t717vtowYe9B+A0Wk7OU ZFmCYrN6gqbfztN+2exNJkMwHLgUx+
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
index 3465d3328e44..dff71c041e85 100644
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
2.20.1

