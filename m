Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C633450860
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhKOPdu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236577AbhKOPce (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:32:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66D6761B51;
        Mon, 15 Nov 2021 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990176;
        bh=mjm7thjDN8diH9n6OczzntZPpt/lXCMWc+eQF8W+ua8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fP2E4dpgUBMyIOxfyGw/r5uHl7+EW1evo/0O4kFyuE060tp84W5irzJBCsSId16ak
         H1ERs+QC6H6dFJeqnbSwAePC5lKlHWHSjNwrRkm0joBb5Nmc/K6E8oriTqBLPPzngS
         CwCD9eazxohUlUgokFTlaEPtnPbsE4whZpnS27G/iozW9XLFFbkWSZMlHKbDJx8rPM
         fKzfulbbQGKRKM4+JlXBUdC3v4S7QgI29iyqBts0h/ypTV+sDmFDuyaNg7K3YBMQXM
         OQB24KB8yfj1/OBiFLsys4kfzJ67VhQ8c8hLCbF1flr7N9gWojDBgvZUccjCn22Tiu
         V/LZbDkNkjmgw==
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
Subject: [PATCH v6 15/37] arm64/sme: Implement sysctl to set the default vector length
Date:   Mon, 15 Nov 2021 15:28:13 +0000
Message-Id: <20211115152835.3212149-16-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject; bh=mjm7thjDN8diH9n6OczzntZPpt/lXCMWc+eQF8W+ua8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyQFYe22kPJ1r98BQ03YcX/sBy1CdLzbUxts54q MsZ1nC6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8kAAKCRAk1otyXVSH0GX5B/ 4kUyTcXIpxPqG/rbd5yq1JuNCpmgPWEbt8wx8b6qaE8H4wfL0edIJF4ytCm3ONGBCeUSsAnWL1QXjX C0/DGbYARaeDtNYrMCVqnHDOcae6fyRGfyH1ivgqr1a0xxV4XMbkEDWqJLj8f9cu9q2V5nzN3IeOP2 qT1n+B5p3jacl2Zk3vJciyYAwZ0IDIkfIYRAxwnjIEeH5bfeWuzLz5Gu/rCAp6FfmQDHdy+xa7Zau4 O9SAgzLIeWd2+kaNQtdhFJK4H6fPB+jjeSSKUe2XB7kY7jdRQts7EKA60zYXtxPTeDGP9DBwyCBXl/ 38K0LTqo4p5O+VeqFKQHqs6vrYsUtB
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
index f9b77d0b8e40..9b247d13c3fe 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -479,6 +479,30 @@ static int __init sve_sysctl_init(void)
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
 
@@ -1684,6 +1708,9 @@ static int __init fpsimd_init(void)
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
2.30.2

