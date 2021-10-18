Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFCE432739
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhJRTNP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231890AbhJRTNO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:13:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 821B560ED3;
        Mon, 18 Oct 2021 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584263;
        bh=+C9MV9SABbDylMTq/cdciwMD8BqPUU53XJ1T9g2XfGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNvsd7QbGWggXw/KqWtsLi/U0im/7dx3i5RvMl8uzPbi6yrP3MfxQV6HMlIug0lUw
         XMhSHcyfN39+bf+a+1R7v3nCoSGaqrVPqRE/yje4yYvHi20L9KHGpwfIpqHM3oiCNL
         +pzQ4rQpjzQq9Q/Oqs8IRbhJhkAeRKazxE00C8gX6PQLgwc4i98v7vhA/jaJWh6bv6
         iumqMfxgbddG3JIuRZSGPxcpjfr6vZiuqm73aRXL1udhj+8kKj7fG5tU/q+aDkoEnd
         wAzmSAebdlvj8HJSMV+RbX2jOfoPYUGW7j4Pbpeflec+3bI6QOXRf0QZVaTXNPE0Cs
         r8Ulpyp8heoRg==
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
Subject: [PATCH v2 21/42] arm64/sme: Implement sysctl to set the default vector length
Date:   Mon, 18 Oct 2021 20:08:37 +0100
Message-Id: <20211018190858.2119209-22-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject; bh=+C9MV9SABbDylMTq/cdciwMD8BqPUU53XJ1T9g2XfGs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcY304yVXWBjoin8/CMkb2S9VuFzqdeY8tKRaST7 bEKDoTiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GNwAKCRAk1otyXVSH0Bv3B/ 4zyL/rVyhulcNvJ7xW6947jfSStrXHaauG/CRqjUVN/fhqvdzqLvd0aS3Tfj3ITpwUx47Tp4BkuUpM L1xMXxJfbmMN3zVj/+j2sebdLJyQ78SS+zioh1EMpHksnEXtN37wb4kI2tglt31g9gqvEnCnXWJTR3 Hi6WeodKHsclkYVau8hV+xQ4TM0Ukm+wKD+UAx/wCSqgY2+6XBC+h8Djui64tw3qYlxmi9WK864U3u 7bXdfV3o22OJsA+nrhZh0XPXRxhIpOBlSb5lyy0/IJa5HTMkiH55c01dqTuce7E6UwnxztyeX6XG9B SNSuJxej5WNLX9tBETGBi7X10jb351
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

