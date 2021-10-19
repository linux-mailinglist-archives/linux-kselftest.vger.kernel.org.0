Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459F5433D4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhJSR0P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhJSR0P (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 939C1610E5;
        Tue, 19 Oct 2021 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664242;
        bh=WjZeha3MWu4TJuokbQ1Ub4DAQ9GmKwVVzyOzdhRbxVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lidMMeDpiki7TRFWElIlx9A+/CXOXFHYFeC6CzD4i6CvQJWxnlggh4wCv6txrD0L2
         mfRfCtBdo4XSzTA/1gzyIxQSZUKWNueknm1sYwKnBRBijkJtm/x5a2askRMt+kgZv8
         zG/TOAI9ZglZr+IBlPvciQ4xTtRUcx9dUtNpvLVgQgJ/Ug7DaeeSGD2QPHehwmTrxt
         jC6zcum9Azm1UDv9THJG2mO8qI5pVJfyJ6H9LCZbq9moNYDe+4HnwUK9LsLN/jHa2y
         w0NBx7l5YE27VsA23oDe9ms281ySAN0FnrjQZbfi7niXn3eor0S37uoaWYq8Yty1gM
         XLueEJe3vr6WA==
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
Subject: [PATCH v3 10/42] arm64/sve: Make sysctl interface for SVE reusable by SME
Date:   Tue, 19 Oct 2021 18:22:15 +0100
Message-Id: <20211019172247.3045838-11-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3161; h=from:subject; bh=WjZeha3MWu4TJuokbQ1Ub4DAQ9GmKwVVzyOzdhRbxVo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7LSmJgZCxrTpwBtd0xxBnTBDB1GcuBKHruW3mB M803OhWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+ywAKCRAk1otyXVSH0H+sB/ wL4IuD5CMwhtPE5rZ8pHwaIS2l9FIibNq1jED9rH9wrpcg6mUfffd5qRkw4mc8XWbvG+8ao4QkVo8u eCWDn4K4ia9iHxXkrzm7ukXDdCOJuuyq7bgN4+Z+H/aq+JhcC5qxZ945ymiymCleI2tHVzQchSwLhq XUrDo6QgV0p7Kf/HcLN4JV4PuJMzDEwqDelQI1RyLMEmoF0cLJCU9E1/ITR/Hvyl4ct8I7fseEkWjY lmXDc9htOWtCtfim4v/thtaLwYJbGubNsMgSP42edQ9ndno1F5FNlwSWldkBDDoXuwWtlhT/Wihrbz LsFt06uyI6IYeffNY08FkySv4JZwVg
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
 arch/arm64/kernel/fpsimd.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 3474122f9207..53462636b5cf 100644
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
2.30.2

