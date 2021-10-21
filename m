Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC62436A1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhJUSKw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhJUSKw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:10:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 372ED61AFC;
        Thu, 21 Oct 2021 18:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839715;
        bh=e0VThNyAhoeC7NdnFy/BCHCzlrDAia0Vs7+CxsDRZzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QaFMZuQCQXmyM9Va6vWaQR8ZWTthEparfmW+lNab21UUt46dCA9b8vM9PpdkFEkCK
         ey+CXqiBwybtUCGsu9iYkc1o73uwbKcJyMdDtHV0ibsW7qpqvLidueOUhczw3+IONh
         U49fG41AiaX9Fx0qP3aMawJmGHaL8f8E6OJrnLRzBizoccjgmQCv45Q5c/iGN9IOCc
         vb3OU7FwECxoITiRbJtQbxBqlwbU4SVxXfyiR+cJofkBUF6RpHrP/LCpmM0zoFCCQW
         FfnlqsUWB83BEWaox2Dj6PnqcYtUmNdmDOzOUAqQ+I3e4qguchtrF9GRG1rzYUpkCy
         i/5aPR5WhkNaQ==
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
Subject: [PATCH v4 12/33] arm64/sme: Implement sysctl to set the default vector length
Date:   Thu, 21 Oct 2021 19:07:01 +0100
Message-Id: <20211021180722.3699248-13-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject; bh=e0VThNyAhoeC7NdnFy/BCHCzlrDAia0Vs7+CxsDRZzk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxITNs7Vd4sexUksu2X5jC4WTfuDlr88oCndhUo MbJVC9aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsSAAKCRAk1otyXVSH0MWNB/ 9Dp4UYoZpzxSf3xW+UEF83OlV/LSu2oSzNHQikUlmc/GlU4PaYomI2yDdMq8B1Jf1wZypiTv7qW7l5 MYxZP4degiXrqUBBL77hRxrvbYJ6pN7SO0OViElVwi/OJUISuKVvkE3wgetSBxi+PIE/l/aPwIO4B+ 95ES/apmvnjRZQ0ZN0+iFdOjfg3vCPQ+PNX76wHHQlJ4b8ukefxGSgmeGQnoRwTBK9VPUaSPlM90tZ zozfgKpmjkVMuOPXdf1jsYk+x5tv1JCMn2HiNfibcRctC82+K7QFxmFOyO6agU+Oi3edyTxHKAOoEb +vSiB8s0yYZ17XPF864HIkzkJ7trDb
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
index 0b2c4dfdf9fb..65b6ccc3f8de 100644
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
 
@@ -1673,6 +1697,9 @@ static int __init fpsimd_init(void)
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

