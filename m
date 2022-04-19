Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F420506A35
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351265AbiDSL1K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351403AbiDSL1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:27:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE97E5F98
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64F58B8185F
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13280C385AD;
        Tue, 19 Apr 2022 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367448;
        bh=e1FepHYyPDtYPxnE8RM2o5Ez5kqchRRRHTdF7jTJt0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mM+gE/86Q+945YmfwZyzVp+MctGmqZGtqmmQ3IwgrEpja2w9dMsqlbCUF03D8Lp1C
         QVDShJoxGBK8QeOgd5QcNSVAoJ1+W4KJVTeaUfzzJM6ILvO4LBG+mSafDsXws5ldJb
         SKiLzwq+wgjH9wtyt6zA7DXBwKopEUGnE66Qt40SdhhWV8vAJoS8HecCswGSRhEbXw
         nym5IhFz6c+zNMGruOb/UH9cSX1lj+I6yT3/zZiN+DcPi214salibLEYZM4zYcSNMH
         JJApfRB5OBD1Cvgbp2aSM2ktVECK6Vclf/K3jkVwGp31OHihH5DmBa95SJ249VI6j1
         DP1vOwlSc1ORQ==
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
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v14 10/39] arm64/sme: Implement sysctl to set the default vector length
Date:   Tue, 19 Apr 2022 12:22:18 +0100
Message-Id: <20220419112247.711548-11-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; h=from:subject; bh=e1FepHYyPDtYPxnE8RM2o5Ez5kqchRRRHTdF7jTJt0I=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXptvfNVOkYK9UDaZYdTcEoExO5R2QeomzfAMIOf2 YYjoNkeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bbwAKCRAk1otyXVSH0N64B/ 9GHiPt8w0MHlQx7BaX+GNanbWqTfMm6o5wbv/LNlBfjmdTfFpv4rONHYTwzHb9AFW42hjqF1l85OMI TnGNLblgr9TyDY7JESr0P7BHuSwY0d5JCqLQLXcSAr2oWtvI0sYlMsY76PgDq/6j+8E2GsHc5F4FO8 YR8aXzQxjqi7NV7fl91iRe9HS2xvSeDXcrvHVMPcGAtH1IvWIOUh8cCsmhzWQnDvcHGOPNBM6LBzuq G8J18Jz7LZTEL0x8A+IO3WvowFt8X6jNRIC4p3K/GzTXu3UMzIEdm3GlJzaz9FGmbU7AkgNTJB+YYb rkc6HxhueNkCqIIff8cvj+WNHOfgQ+
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As for SVE provide a sysctl which allows the default SME vector length to
be configured.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5e5fbd9cba75..754a96563f6f 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -489,6 +489,30 @@ static int __init sve_sysctl_init(void)
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
 
@@ -1687,6 +1711,9 @@ static int __init fpsimd_init(void)
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

