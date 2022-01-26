Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B00949CD72
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbiAZPMU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:12:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40852 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiAZPMU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:12:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE5D7617B4
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0E7C340E6;
        Wed, 26 Jan 2022 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643209939;
        bh=IpbUE1LUP1+wV97Or602iA0h2YoCGBZmK9vzxYxrIfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRgSKsKzQ/GvYKHSUl+eMjIhEi5HhyZlfVP0dvFCmKMZYY5KWKuMxsqlPXu7o10nU
         FqXdLPIPT/3Q0BvynbAurpk8l+q2qAoPIqFb/CaS8V7NTFoX7oPgpFtKoUiidxj0C/
         jtT6KtcvTNYLqvzTDZawATUH48zhASs2F3A0g/5wqHHC2n3GA8DHOd4AXF1+3KQCwn
         4nrFJ1959tpE16g3mcI1eBx5kVymTZfiw8yQcwb0+D1bmCF7wlGUq4FtoMBRN6Srpw
         P8TbRfTXrJIPWxvZu2ZmIJi+EEGuuCcceUAPvbA6E6gewj8HUMafmZFmne5gwuYjMZ
         Hp8dsUHR8pYHg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v9 11/40] arm64/sme: Implement sysctl to set the default vector length
Date:   Wed, 26 Jan 2022 15:10:51 +0000
Message-Id: <20220126151120.3811248-12-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject; bh=IpbUE1LUP1+wV97Or602iA0h2YoCGBZmK9vzxYxrIfM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WR/FgJn/lc8qyFbpsUtXlg3lgi4N72n7+sKm+k1 dP+cSUGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFkfwAKCRAk1otyXVSH0EW8B/ 9ttjf4/ojwSYQeBnvjKjyVqvnAoeKb9lBx/meHIflTtTt3sV3vd2uPBQpWKID+SolrOGttvSd1QzEA pvOgliHnu6mIPLLJ9QlXhJkW0bY+/oAT25fjJKyVMmmk2HBeFUwroryh2RKrJ7cKabSWVeC7omebSc kdXrD7xAVuViY6SBHU+lCEwrqp41vZAtpHD77bGL07Ozlr/ktZVVs1T0xw64AbxbWzFcdj0K+dp+ya n1wkoPh+uUvsSuRqKfoCifvOuIqjR/rDaDSsV+XK8uH0BRDuRlC0leJVkrwVaTIyBcezqxbaLv5blf LqRWrOAuS+tBwZk4VY3TrN7gL+bZ0r
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
index 3fb2167f8af7..841b9609342f 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -483,6 +483,30 @@ static int __init sve_sysctl_init(void)
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
 
@@ -1681,6 +1705,9 @@ static int __init fpsimd_init(void)
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

