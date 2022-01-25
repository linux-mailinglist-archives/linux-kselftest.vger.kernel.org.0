Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C403349AA3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 05:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3414017AbiAYDfp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 22:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3420689AbiAYCZI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 21:25:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D233C08B4ED
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 16:16:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A58B61541
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40610C340E7;
        Tue, 25 Jan 2022 00:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069761;
        bh=IpbUE1LUP1+wV97Or602iA0h2YoCGBZmK9vzxYxrIfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNsyHz3XIn0qik+Ak/q4XnAvFlyTxR5cjgufRYPmTd4QCAqfUPUgF9oYHPUkZFeIG
         bQXmXw0whHb8rB3MJVg809nNzkRUJxLepSWkow0WJm8afUFe5JDuhK6iZw0YGUMOBj
         OmXw7IvX1+wjXMD+Y1hUX8cn5YCpn9KeVCCUzNynJgLDfoLJWh+VpmHYWfBpcc2ljC
         0I2xMTGncc0irZBJ4PuvEP35N1wK1KbaH5LQuKdDCDXhvJBHftQBZjnh0Njp1Kle3S
         Q6Tof9/Sdw4nM5yGVu5f0yXpf+FZHtDiJYBciID9U+u3Y08uQTIJz+xQSPhbAghZ1E
         q1t8Ze0vlkMXA==
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
Subject: [PATCH v8 10/38] arm64/sme: Implement sysctl to set the default vector length
Date:   Tue, 25 Jan 2022 00:10:46 +0000
Message-Id: <20220125001114.193425-11-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject; bh=IpbUE1LUP1+wV97Or602iA0h2YoCGBZmK9vzxYxrIfM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70AJFgJn/lc8qyFbpsUtXlg3lgi4N72n7+sKm+k1 dP+cSUGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9ACQAKCRAk1otyXVSH0LmcB/ 0XEndfFhFnPc9ukDndbHEkcdsYuIuaO9EE8pTzRCW8uq/WSN69mXCJdyu5YSm2wcgfPgwwKovZuGGg dmBTQ9Vtb7QEU3nAnRTNP47CH6yZ2tTnHZ4KUdDRiLJxhhOiZkUFpygLIr/uTDthfBvV5eAQi/gcEw B5q9bhVjxk+lp/ippXXOd4FQv4W16Hgngmiz+/XGaT3DP5nZ++BWSHnqiWoZd4tewFl7YBSTJB5vOJ UAF8MeMEbDmeRMBBgAVOyDDvheAC6yu7z0OHtVbJor62zqu1Iiu6/nqYHyYzoe9mWRedauX4rAqPHt nMwkABpNBbWjPH3p5/XY3sILfvxakv
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

