Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E1D43D120
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbhJ0SyE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240445AbhJ0SyE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:54:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60B15610A6;
        Wed, 27 Oct 2021 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360698;
        bh=mjm7thjDN8diH9n6OczzntZPpt/lXCMWc+eQF8W+ua8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3ls6I3hNexQgEImIjfqR3Z+GB6XtrGbxkuNzHQ4onGtVt4XfONcF8l6CekJ7LBa1
         jZDn3i/PsX5Rcru/Gb/3xRX+yqzi/SAFNqchSgWg5TgtvAJdJ03yxWUR0/gf3Zt6pl
         Y9pnoFigYg4N865ubSBdIFIIbfAwRutEthU6RDA+QmwLtEr1FAjvXbav1Pm7mA/+EE
         bXpj9AicJlQRXhmqikLeo//IU/IZPvMfx3skKh9+b/MCdPdh7YTl9zOFTiOwgpvja4
         3ZLGd6MJHO6SOXo1YFM4JkxYHpFKBsAM5g7/pbMNs5tj/Hgy4Iir0AyAx0fd94rxT8
         X/ghxlMgRK9HA==
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
Subject: [PATCH v5 16/38] arm64/sme: Implement sysctl to set the default vector length
Date:   Wed, 27 Oct 2021 19:44:02 +0100
Message-Id: <20211027184424.166237-17-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject; bh=mjm7thjDN8diH9n6OczzntZPpt/lXCMWc+eQF8W+ua8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ3zFYe22kPJ1r98BQ03YcX/sBy1CdLzbUxts54q MsZ1nC6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd8wAKCRAk1otyXVSH0OHcB/ 9yy19XkX7e4yxjyRMsKLJiTGmbSfCty0W4tSYy1AqFoR3fC7unm0uzibp59ss7+F5CDGp/pC8wIH3k S8Qf/sY6aTtYrVsHvyZYv6cL8OlktolWKDNPtUQf5fyS2tL0K8aWjWJisNMBqmL1NTMhhEFmU30G+c hqUB9QLuoYNat8wRsaMbeYjpVbtJmu/gYq6CfluJA2+ddrQxbb36xQmHg0DwPefCwcpkckxCC48Y/2 065S6FlJQo58u4eAFBMm61ZTfnk9u2lQFapdU0aebbVfQFk3adDQ1jXKg/AoaAfRlnp0ERTIAwJKqC PKqnFD4TvfvXZpIbKVmJWPFB1dyu6K
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

