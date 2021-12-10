Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059C147090E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhLJSrR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSrR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B20C061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:43:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B8ED7CE2C89
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B39C341C5;
        Fri, 10 Dec 2021 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161818;
        bh=e8KsjeULXIEQjMalNg3GWaCoTJ+Nm/YlFIk/oUByTL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K73dUB7MHEqoOHrYNXF7KiQf6+anEbn7Vcp77rCkMV5NlFgQL5dNRPkNVI0VUDh6A
         jG3HWQ/fPUO7rcg/Uzdrc1ZVDh+bGIGpL1a1zh+DZm5lZxxWjvzKIw4k3RTsF+z1VN
         N08bVVxENZN+mzXj+9x9jDs7Rf+SkulHv2fbjai+n4iBwDFPvHO6OQNJHqtvJ+Y2WG
         6u80dGVdk3i8kH3MnaC6iYuq5Kw0Ln07tgbGdV8/HDtVDoy0jF2NtrAA7cf2PXFZYc
         5QtvrfN+/jV1xrl7oDiUIgvKvGSN3TkhTajdGE52ZFVBXJl4DKV0cFBXXA7K4VlO3b
         zR7KJhmxM4tbQ==
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
Subject: [PATCH v7 01/37] arm64/sve: Make sysctl interface for SVE reusable by SME
Date:   Fri, 10 Dec 2021 18:40:57 +0000
Message-Id: <20211210184133.320748-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; h=from:subject; bh=e8KsjeULXIEQjMalNg3GWaCoTJ+Nm/YlFIk/oUByTL0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs58+daHKQYH9PW1ZLc3nfVVpR9DKLLsTrXpG3xmI e8pMB2mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfPgAKCRAk1otyXVSH0A3tB/ 0V/nE7dFNt4AH8pewS5QHSIo2yPB7/XPDtn9+N3+Olkgfi8Z6EG0Ik8FL5rv9irT4IhxeDYNuD6xz1 uIPbxb/143m8TPbH53lwdaZfIkfGPmHEYpjZfR9jzd6c1Woi8ECxEX9/zq2wuTae+y8IJbZjx5HBgK k0oYn9Dg6/qLEwZY/HY5DaAuStK4cCUWFNgNsLbXzK0EMCGrbVtrdJWR7vmVBAfD0ILZE6PBKAMps9 JjCuR4nGciT4KSt1id7kKd8qNRMijvYr9WKbokM58+BeNKoFJ0mkvBYuc49r4vTLflVWORiJVd/pOT ZWmiXNRcsNXvim9jJrc7E52dPz1OHR
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

