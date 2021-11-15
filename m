Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6F45084A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhKOPcT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:32:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235334AbhKOPbz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:31:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9608611BF;
        Mon, 15 Nov 2021 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990137;
        bh=e8KsjeULXIEQjMalNg3GWaCoTJ+Nm/YlFIk/oUByTL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESpBj8mlrrEgg9S6mpHlekACb4TwMuHWVLVak3XjaEc2M96GeleWRW3igoZ6FcKif
         UNLvVupg0V/TYy6SI1LXIYp1MYwSRf5rbb5IPiI3HfzBGSDo2SD0J2Aall/HUBPolP
         WBnlb8JPNYjRtBmSqr3qKN13s8yZBLQ+YINw3ByCEv4Bv18GN8ONrCE28eaLsl5oVb
         RYXuG+90XrSuU4QM+X1fLgT6kM+cveXlo2MuHUQUsLboCAVS8xGqMZcoRqrp0uPtp7
         e6xmFpH0UkhjdSIjGBc9DbY7VlpLO79wglWvkYpyvw7PxbWVh18Oc/EcnmmAvIzhhN
         NxelFM37//6sA==
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
Subject: [PATCH v6 01/37] arm64/sve: Make sysctl interface for SVE reusable by SME
Date:   Mon, 15 Nov 2021 15:27:59 +0000
Message-Id: <20211115152835.3212149-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; h=from:subject; bh=e8KsjeULXIEQjMalNg3GWaCoTJ+Nm/YlFIk/oUByTL0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyFdaHKQYH9PW1ZLc3nfVVpR9DKLLsTrXpG3xmI e8pMB2mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8hQAKCRAk1otyXVSH0JTZB/ 426r5tVF5ROXMhj/mFRDQKiOPF6554FjUSqimbWfPG7+FvhrhJd5AhUM5Yx8kf2a84/wLgH8YFEqU1 f68iPsSFRP9rnO2ArRd/pj4E41gt8vNkV3fWuSukxH9k0QNLhipSCaq7zF2lz4e47idP2UPAspV1+c MvUwhEMQJreeJhsJ9/3c11M+NDIF7/PXh/UZny0IXOQfA79VaWMzk7a4m91hCYmfflv80wGs9zRTWd 2ACUTtud+caRE9upT+SeKbFbiqXgXEfdNUna1kt+xuVJUxYZuSmNew+rEiSqINB4iWFLK6nJY4PnP2 kGAcnbWSCwkv9rPWYHI30p/Y9Sdmcl
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

