Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DE747091F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbhLJSr7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47570 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245496AbhLJSr6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 21E76CE2C89
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB4BC341C7;
        Fri, 10 Dec 2021 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161860;
        bh=mjm7thjDN8diH9n6OczzntZPpt/lXCMWc+eQF8W+ua8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3FuoCZWqpiU9Fa8U1c81ZaeREULX2t9bFMAvGbH1bfFHRyyZwFXI3Wi04A6Ei5y5
         iuu5YsBXtTRBv04e8Bhy/4YFYJ1QweNGiyUM18NdNCa50ocRr0h64f9zaqK/vELQzt
         fHxkQIygt+N+UNjv8ui/82TYVCxpIDPk/ji9145/2Sc8pLURCsEw/llgRGwdYS7K7y
         9Bf2B+xrgcy0mxRpr3mvwj58jwhBXx0U2EQxZiF44cM7ZrRBF3cKYN8LVjwqSHpZVb
         BuVaTxHMx/pe2+pw9zrScv3+DEJRFA6h4GnkctsPiOIqsOrydFTEcWYIIhswsLh+S9
         LCzlC6G57Uu3w==
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
Subject: [PATCH v7 15/37] arm64/sme: Implement sysctl to set the default vector length
Date:   Fri, 10 Dec 2021 18:41:11 +0000
Message-Id: <20211210184133.320748-16-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject; bh=mjm7thjDN8diH9n6OczzntZPpt/lXCMWc+eQF8W+ua8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59KFYe22kPJ1r98BQ03YcX/sBy1CdLzbUxts54q MsZ1nC6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfSgAKCRAk1otyXVSH0CMUCA CD1ExPQiiWYJoFlTl6HnGpjbFrdwIfZ39TSAzTbfoYxk6b0Ci/ApVJc+Pw48+j6mmJ7OVH8Q+SAKEV 5FD+DWUvlasVQ+Fnr/NqWwwtHTZyc73dq7uBlj/fhSx7g/zLXfjkcFrFRjCn81AL3zUs7JaO/FC7VE pLIEJr4x+EBK7sDJC58PlZJIs3bshl/6/AWLyJN0HHUKcQjNtJGIMUvMzD3tO66WZtj1RDQ74Zm3km 1ByYV+XayAscHiLQSqB4gV/K8fXC1yXTcElYigKc+pOxzIObImreG82jx8mhG0zQO23bvi1j9iKOTr wT7IfmVrTtN65eZlxjwDGymJDN7D9R
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

