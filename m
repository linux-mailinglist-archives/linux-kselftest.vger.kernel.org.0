Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79610436A14
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhJUSKP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232363AbhJUSKO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:10:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4E1B61AFE;
        Thu, 21 Oct 2021 18:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839678;
        bh=oLjBApoBo6XlL66dW+vqRgFF5K1FKoawYHnJx7iQyGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5q50V7CqAYde/0zCLJ2XL8/cM7HOy8vDNRw3Kq5igtPdelMjPARx3/oX+Tlwj+bm
         G3rs9FQgNfztVsUjmTEduNSXRMvwXMfuEVGk+N5l7cJzENLk4g7NzGrFJqnKIxHY1F
         UGy0o6J35+W6zqvasWz5ZCg39O7UHKkXyXqR4mahhr8ODYERq+KedK1h4n7xasKujP
         i0qwpndeH3ts0HMunfjEhb608ixLtwMHrNOGaqdqvOgDDD2XxwmX7Uh4VHjSh63gTk
         QyXHkmosC7rvByAKjpclyWCmND+n5HJFgCYTysjKoiUo43TGeqi+/MdvtNM4QHqNlD
         NqFWwE/Z02tfg==
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
Subject: [PATCH v4 01/33] arm64/sve: Make sysctl interface for SVE reusable by SME
Date:   Thu, 21 Oct 2021 19:06:50 +0100
Message-Id: <20211021180722.3699248-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3011; h=from:subject; bh=oLjBApoBo6XlL66dW+vqRgFF5K1FKoawYHnJx7iQyGE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaw/pIo6AKp4/lS2KdnPYd4akubhMY+sMxWb2tly xgU3mRGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsPwAKCRAk1otyXVSH0AIyCA CDWTEs1qdGkLBJJfZ0/V1Ggei6P/yGPQ7bd9ssdCLfbGJeGAiL+OAWmd3Fgh3a4Yy1kGq+ptPbYuM6 RUZLfrijVIq6h7ZT66QBJ0Ix3Z+8+apuLnYfKsz+OOtpPLATm2HgeBhdf7uJGimegrJaydL1JN0Vb5 bfOPkOW+f6IgcxDUCRFg+0SBLfFo/0S132BAM3lkfJf+WRy+eHLq7X3/S8uFEK9J9CqylBgWlX+fPA Ue1AEN4YDfOvapTF6CTnKNg4Irwr5U64vF8bd6mM5uiHcFxXLoU0Tklgspq4BUis1dmlUtDeH4DhZX KrTfi8sw6+cx/QRPJYuzz8N0/7MV7H
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
 arch/arm64/kernel/fpsimd.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 3474122f9207..a81b3a6615f0 100644
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
@@ -155,11 +156,6 @@ static int get_default_vl(enum vec_type type)
 	return READ_ONCE(vl_config[type].__default_vl);
 }
 
-static int get_sve_default_vl(void)
-{
-	return get_default_vl(ARM64_VEC_SVE);
-}
-
 #ifdef CONFIG_ARM64_SVE
 
 static void set_default_vl(enum vec_type type, int val)
@@ -172,6 +168,11 @@ static void set_sve_default_vl(int val)
 	set_default_vl(ARM64_VEC_SVE, val);
 }
 
+static int get_sve_default_vl(void)
+{
+	return get_default_vl(ARM64_VEC_SVE);
+}
+
 static void __percpu *efi_sve_state;
 
 #else /* ! CONFIG_ARM64_SVE */
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

