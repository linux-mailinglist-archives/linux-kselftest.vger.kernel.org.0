Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E35041E0C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353328AbhI3SRq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353324AbhI3SRp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE1EA6140F;
        Thu, 30 Sep 2021 18:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025762;
        bh=PithgJcXSxG4ICOLoFz2z8ExdG55sGjdC8wj4uAYqD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIPx8zP2djUH5cgcnKc/85RhKEy3C2Lh4aelRvOAqY6X/MbIE3CKv0wl0qZ1IAVgR
         oxRXc+kA9IgIa+A2rXtrL818Vzb24o20ppybUZAXUGdFTja8pHlA/rh9lNLcRb89RT
         0ae6YKUdpxTLFok1sZb01e4UNFV+NR3lWPKcb3zzszZzAqd4ak6faf28oxm/fTuo6l
         i2jWlobZZoYD8myEVIZ8cjRACHXSvwWKkmLmovxtI2qkvkhBp7KMmzrtJ5SO2diAlY
         uz/LBAPoLPUWPPfwQ/8UFdwqBkJz6gYAM0iQkMBPehz/GnJ/lHHPmgWSaCdg3Q9+8/
         2tUvjZPmnREXg==
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
Subject: [PATCH v1 09/38] arm64/sve: Make sysctl interface for SVE reusable by SME
Date:   Thu, 30 Sep 2021 19:11:15 +0100
Message-Id: <20210930181144.10029-10-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2574; h=from:subject; bh=PithgJcXSxG4ICOLoFz2z8ExdG55sGjdC8wj4uAYqD0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3Ijcro8yKSABfOPd8ovr5grJZRZRylnaDhhItm ZPCHZquJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9yAAKCRAk1otyXVSH0LIqB/ wIMdj+WJeKCwOHoC0yWIBT4oOMwtIv05oKb5g9y+GdruHlfBALs4FgkMjivHWr3eXauTjOWnczJViI /xTs8t6BN6gWad9Q85at5Z/ii59F90QP16yOXW4q8GGQrL45XjhIGFTCT7xqRnQ1sv1yuUsMXaZXtb CcP84TmURI+GMAZggDdjbilohaiT1WxTgTeIeAZv8qQVNNgNn4DUCMaGPkXgCikIx9bicj8wL+C+2H CzJgavgAizASyEJh7ENtl56XOC5jksjF1ppZtqYdBKdDxEDqyVtX3UX0nw1K6q9hZLy9vn7pHDMzBV 9uJPSRROOLdJMVEMNn00WYu48RrI1J
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
 arch/arm64/kernel/fpsimd.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 814080209093..e3a88fba390d 100644
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
@@ -406,17 +407,21 @@ static unsigned int find_supported_vector_length(enum vec_type type,
 
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
 	};
 
+	if (!info)
+		return -EINVAL;
+
 	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
 	if (ret || !write)
 		return ret;
@@ -428,7 +433,7 @@ static int sve_proc_do_default_vl(struct ctl_table *table, int write,
 	if (!sve_vl_valid(vl))
 		return -EINVAL;
 
-	set_sve_default_vl(find_supported_vector_length(ARM64_VEC_SVE, vl));
+	set_default_vl(type, find_supported_vector_length(type, vl));
 	return 0;
 }
 
@@ -436,7 +441,8 @@ static struct ctl_table sve_default_vl_table[] = {
 	{
 		.procname	= "sve_default_vector_length",
 		.mode		= 0644,
-		.proc_handler	= sve_proc_do_default_vl,
+		.proc_handler	= vec_proc_do_default_vl,
+		.extra1		= &vl_info[ARM64_VEC_SVE],
 	},
 	{ }
 };
@@ -1107,7 +1113,7 @@ static void fpsimd_flush_thread_vl(enum vec_type type)
 		vl = get_default_vl(type);
 
 	if (WARN_ON(!sve_vl_valid(vl)))
-		vl = SVE_VL_MIN;
+		vl = vl_info[type].min_vl;
 
 	supported_vl = find_supported_vector_length(type, vl);
 	if (WARN_ON(supported_vl != vl))
-- 
2.20.1

