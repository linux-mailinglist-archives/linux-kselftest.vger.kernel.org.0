Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65EF43D110
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbhJ0SxV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243650AbhJ0SxT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:53:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D13A56103C;
        Wed, 27 Oct 2021 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360654;
        bh=e8KsjeULXIEQjMalNg3GWaCoTJ+Nm/YlFIk/oUByTL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkK7A0USr7yT4UpSK+hnWaBSQt8vsXH2jP9oSAQ69ZG+eFVilgZfx6xW0nVVQH4fu
         ynWwH69OvQAW5U/52tpPbDjYnF5G8Oqhp/EgLqI/O9JiJhfx8ZUn1KSE4m82Gdeghm
         aYxaqhNsBcsVT2RU5DzhnrIu3VR9H3/F2Bh+VRypHOPukX/eAz44jMlkzS8bgrZ8NN
         E4n+AAPZFSVTybusztytAET+/GwaSG9u5j0FJsxiTvIYDdCW1WaJWFVOOVPVL2Jf25
         y9u2njB0e+iovbozRhX/8Xv6ywANm32K0SsbIitgkDslRVYAGfkPw1V7YnNnOLjQi8
         nTLPskAARIwzw==
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
Subject: [PATCH v5 01/38] arm64/sve: Make sysctl interface for SVE reusable by SME
Date:   Wed, 27 Oct 2021 19:43:47 +0100
Message-Id: <20211027184424.166237-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; h=from:subject; bh=e8KsjeULXIEQjMalNg3GWaCoTJ+Nm/YlFIk/oUByTL0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ3ndaHKQYH9PW1ZLc3nfVVpR9DKLLsTrXpG3xmI e8pMB2mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd5wAKCRAk1otyXVSH0Lf4B/ 0TCYfpLwq8i6vJimaoWuT+r7BoXxSH2RT1SAoBresuU/L7DD0LOdVxTM7em4ARp78xazPzxO0kCgH6 elKsiSiSRcRuQHVUj5X3A1sXcMp3JcIF6qqAUS8LaCrt572SwVj1gPQFd0qYllIRHmzVzk2vJzWtrE CB7L1D4qHRMby0gNleTHYz+gkY033C2DVwEz0bjed8Of3yqgUFLNnq3hUvRFyO+rV2bjtGwJkG+FU3 W9NcxlK3votk5Njh3/MwfZg/8YYBmjfc6f9wNnilCIC4H5ugZ8pB955harIRNEdhTx4NRZatDycu0i ksgRYEHSZYefjwtcwI5lRrvY0y7s5y
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The vector length configuration for SME is very similar to that for SVE
so in order to allow reuse refactor the SVE configuration so that it takes
the vector type from the struct ctl_table. Since there's no dedicated space
for this we repurpose the extra1 field to store the vector type, this is
otherwise unused for integer sysctls.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index fa244c426f61..23e575c4e580 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
+#include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <linux/linkage.h>
 #include <linux/irqflags.h>
@@ -406,12 +407,13 @@ static unsigned int find_supported_vector_length(enum vec_type type,
 
 #if defined(CONFIG_ARM64_SVE) && defined(CONFIG_SYSCTL)
 
-static int sve_proc_do_default_vl(struct ctl_table *table, int write,
+static int vec_proc_do_default_vl(struct ctl_table *table, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct vl_info *info = &vl_info[ARM64_VEC_SVE];
+	struct vl_info *info = table->extra1;
+	enum vec_type type = info->type;
 	int ret;
-	int vl = get_sve_default_vl();
+	int vl = get_default_vl(type);
 	struct ctl_table tmp_table = {
 		.data = &vl,
 		.maxlen = sizeof(vl),
@@ -428,7 +430,7 @@ static int sve_proc_do_default_vl(struct ctl_table *table, int write,
 	if (!sve_vl_valid(vl))
 		return -EINVAL;
 
-	set_sve_default_vl(find_supported_vector_length(ARM64_VEC_SVE, vl));
+	set_default_vl(type, find_supported_vector_length(type, vl));
 	return 0;
 }
 
@@ -436,7 +438,8 @@ static struct ctl_table sve_default_vl_table[] = {
 	{
 		.procname	= "sve_default_vector_length",
 		.mode		= 0644,
-		.proc_handler	= sve_proc_do_default_vl,
+		.proc_handler	= vec_proc_do_default_vl,
+		.extra1		= &vl_info[ARM64_VEC_SVE],
 	},
 	{ }
 };
@@ -1107,7 +1110,7 @@ static void fpsimd_flush_thread_vl(enum vec_type type)
 		vl = get_default_vl(type);
 
 	if (WARN_ON(!sve_vl_valid(vl)))
-		vl = SVE_VL_MIN;
+		vl = vl_info[type].min_vl;
 
 	supported_vl = find_supported_vector_length(type, vl);
 	if (WARN_ON(supported_vl != vl))
-- 
2.30.2

