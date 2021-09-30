Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9FC41E0CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353341AbhI3SSK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353313AbhI3SSJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:18:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4133761A03;
        Thu, 30 Sep 2021 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025786;
        bh=ppNilmd41ktcloswCiFo5q0EqUcX7jUnqq9a+DvuZf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFDRDG3eXhxramQSvgOrqSc32JEY3ti8KG1TQ310it8UBxxUdbH+20u9JzJ0BkNCE
         vBKhjqqbUD9h+ikPKk0DHdpud4+kxBywvx8OxehGwUKKuGIIE8nPOiXdbzFECG27/X
         jtfIT5zardNAbCMOYwJ7YTXNrh79VSxXxSZfOODQNBudTi0qQ1tfq6i7EnI16dMC9M
         PwYnHw5o0XEKIOxWB9ub87y+jin2NpCNqKqRldZMXUze8/5Iun7kQdGDWmQbdmF+ol
         OdcVkORinsTsV6BKpVtn4ahk07kxrdQfYtFTDiNKqTM4E5qh82r2RYVamA6v/krEkS
         L1MD53JYMd/hw==
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
Subject: [PATCH v1 18/38] arm64/sme: Implement sysctl to set the default vector length
Date:   Thu, 30 Sep 2021 19:11:24 +0100
Message-Id: <20210930181144.10029-19-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject; bh=ppNilmd41ktcloswCiFo5q0EqUcX7jUnqq9a+DvuZf4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3PlaTEipZFWpf2CpTPoMn0FTSlkC+9f7GmZ6X4 tlHqPA6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9zwAKCRAk1otyXVSH0LZuB/ oDSJh+sYo4gwbP84gJgxSDuonJlPFCgGIeL0a6rG/iF2IiPHP+PcXb1QS5ecl54AefScThQhnV/cw7 Ia4tUPqSSyHJEXHDHOBrx9UHO9MChMwG7IY4QhaX9/tfctZb06spbJt9k7gxzuzq8wBGNmT/sxnF1j FeoyYT+tIR+l/k1vNywJjoOXGyHhW9uKIGYZzXSUnPMRtc0Yc9LJJ7sopQwzhSQ9Yp1j3geLKMFNdj 6/lYizsLA+vyTvAbOCpeHThHyCiD/1cmoMes3Yn9QQETnOKVnpMrsroDMYRa1+/6F8okoGQfRJVZCp uaDytRT/XgLH4+4fJ8TKZPXVc43H0f
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As for SVE provide a sysctl which allows the default SME vector length to
be configured.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 430c949a2438..13df5920fe1e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -482,6 +482,30 @@ static int __init sve_sysctl_init(void)
 static int __init sve_sysctl_init(void) { return 0; }
 #endif /* ! (CONFIG_ARM64_SVE && CONFIG_SYSCTL) */
 
+#if defined(CONFIG_ARM64_SME) && defined(CONFIG_SYSCTL)
+static struct ctl_table sme_default_vl_table[] = {
+	{
+		.procname	= "sme_default_vector_length",
+		.mode		= 0644,
+		.proc_handler	= vec_proc_do_default_vl,
+		.extra1		= &vl_info[ARM64_VEC_SME],
+	},
+	{ }
+};
+
+static int __init sme_sysctl_init(void)
+{
+	if (system_supports_sme())
+		if (!register_sysctl("abi", sme_default_vl_table))
+			return -EINVAL;
+
+	return 0;
+}
+
+#else /* ! (CONFIG_ARM64_SME && CONFIG_SYSCTL) */
+static int __init sme_sysctl_init(void) { return 0; }
+#endif /* ! (CONFIG_ARM64_SME && CONFIG_SYSCTL) */
+
 #define ZREG(sve_state, vq, n) ((char *)(sve_state) +		\
 	(SVE_SIG_ZREG_OFFSET(vq, n) - SVE_SIG_REGS_OFFSET))
 
@@ -1676,6 +1700,9 @@ static int __init fpsimd_init(void)
 	if (cpu_have_named_feature(SME) && !cpu_have_named_feature(SVE))
 		pr_notice("SME is implemented but not SVE\n");
 
-	return sve_sysctl_init();
+	sve_sysctl_init();
+	sme_sysctl_init();
+
+	return 0;
 }
 core_initcall(fpsimd_init);
-- 
2.20.1

