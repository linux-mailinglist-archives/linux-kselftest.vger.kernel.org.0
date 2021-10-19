Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EF5433D58
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhJSR0s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234613AbhJSR0r (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D074D610E5;
        Tue, 19 Oct 2021 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664274;
        bh=+C9MV9SABbDylMTq/cdciwMD8BqPUU53XJ1T9g2XfGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXwQ6cUzFgCDotsQCLrpSKtSwOxJ0i69M9dXxTOw1Tuc6yxt6UiJT0FY9nYiuDLFF
         X9BIZjOHZT37vbK3i/z+qfey1y8oocKzP0AKGROI7SM0c1fyD9soPusqtfAqhJK3I/
         w6LsW30z76/FtT/7gXtcRkx9NfK5MQ8DuMI/qtUFmGprMcGA1l5KU1QxgeUu2jLQEc
         EthVETwWAbNDPy+fu85Qd7hbxfjwihK48z4DhYF1rFFxHjyubo3/JzmWVdbYtr4DeL
         0b77PB5z9o7EjyHl7Wdr6c6zD+Hg8nKjvKUDG7icXN/RmIgDtd2P/Jvbp8JoO7M34c
         2odsHCzSeli+g==
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
Subject: [PATCH v3 21/42] arm64/sme: Implement sysctl to set the default vector length
Date:   Tue, 19 Oct 2021 18:22:26 +0100
Message-Id: <20211019172247.3045838-22-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject; bh=+C9MV9SABbDylMTq/cdciwMD8BqPUU53XJ1T9g2XfGs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7U04yVXWBjoin8/CMkb2S9VuFzqdeY8tKRaST7 bEKDoTiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+1AAKCRAk1otyXVSH0Aj1B/ 4oUepMcf3calVSwIp7YE2SDVgmipH7R11QvF7z4e5L6DRnNShInkPPCtrq0O+fUb71PxBrCRl8bhgH QVXktFgnqPoefvCx4rHuodkLLejXTa10lrgQAMFoisb7pUuJREsS4WbDlSQPObuIjSctAsbMtu3JN1 SQvBzRSiKHiARuSNp5SiBXEeJYWyu6qaT80IiuV+sNlchvz76bR+PJL23oZ+TReDiE5QfyIt1CsOYh UJbtpMGcorLlW5yXRvV4aNi6CxPNlh4Xai7leya7lDfPNfD0wHrAerEEfqx9NENavr2yTtQ675KOAa sPD6ByxEq25nB0ScvOBuqjW6bFiyHy
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
index 2da7c955d275..9c2b3893f14d 100644
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
2.30.2

