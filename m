Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF149CE37
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbiAZPaa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiAZPaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:30:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A201AC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:30:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 635EBB81EAC
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE79FC340E9;
        Wed, 26 Jan 2022 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211027;
        bh=+7q3tm71SwRhuirdKp9GKi5rtB4x6+OdJkLWZ94Mc9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKpiUPWGJn5/R3/hrA6KUjIQMOQseET9rVeMOERLgNH63wYUVxzIQX1mkfYnSJL/V
         5fdOlA+vyuwYWRm2TbkJ3h8w3bD/raSvJIdQ1A/+VK5k/uwqOBFo6habmgjiZ2bUoA
         utiomc0JdQ2rMOeOygp9neIQL55fu+8GiCNeaG9XdZ8IHzd9SvP/rxR+jDCXp7vAut
         bQn9W/YhSBT0EHNmuCRK+xwYNXU7+5AE71eGbNQeI9LS70ckHjFEMR/aJrBbAyNf+s
         4T4//t0BkwkWBQyrF+kX0EPqCr4uMrkT0YufP6z3V4D5sSegKNuxt4A7CpvclSHK3C
         QJ4Q1mTADiuDA==
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
Subject: [PATCH v10 01/39] arm64: Define CPACR_EL1_FPEN similarly to other floating point controls
Date:   Wed, 26 Jan 2022 15:27:11 +0000
Message-Id: <20220126152749.233712-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; h=from:subject; bh=+7q3tm71SwRhuirdKp9GKi5rtB4x6+OdJkLWZ94Mc9g=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhQxPwduzBtzQGWnI6lrwWCEEEUoE/eJxky1JgR ndA8iA+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFoUAAKCRAk1otyXVSH0MfcB/ 93YOtEzossPOr/OyEZOKK/aZMa7a2B6+dfkFu8whff49RudKPrZcdGUMfyjsYKiJEA16Y0/pPFMo9l GfSuvbLn7P+0okTOjbfI5WOA+RGcSS3LYkpuMLMzjf/htrubIL3OZ0VMVCFHmgb/w3L3o1QMJjDBLw OfYGZ80yYfNbQF3KrSC68tNwgFLsTpPE3FMDbcwNZcNPfkk37iul9gyNrwLMB8Z8ZsO0P8Nsh/BqwJ fppmEtB4LpR6QakUnjICrFIZps/iMzqITKg97ipIAML+zuqq+NMp8TrRI0SbKGXftNvXi8zEW7uowp yt2JFm8NLvWMl96hyfoXMAmeilq5yf
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The base floating point, SVE and SME all have enable controls for EL0 and
EL1 in CPACR_EL1 which have a similar layout and function. Currently the
basic floating point enable FPEN is defined differently to the SVE control,
specified as a single define in kvm_arm.h rather than in sysreg.h. Move the
define to sysreg.h and provide separate EL0 and EL1 control bits so code
managing the different floating point enables can look consistent.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 1 -
 arch/arm64/include/asm/sysreg.h  | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 01d47c5886dc..eec790842fe2 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -355,7 +355,6 @@
 	ECN(SOFTSTP_CUR), ECN(WATCHPT_LOW), ECN(WATCHPT_CUR), \
 	ECN(BKPT32), ECN(VECTOR32), ECN(BRK64)
 
-#define CPACR_EL1_FPEN		(3 << 20)
 #define CPACR_EL1_TTA		(1 << 28)
 #define CPACR_EL1_DEFAULT	(CPACR_EL1_FPEN | CPACR_EL1_ZEN_EL1EN)
 
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 898bee0004ae..1da4c43d597d 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1097,6 +1097,10 @@
 #define ZCR_ELx_LEN_SIZE	9
 #define ZCR_ELx_LEN_MASK	0x1ff
 
+#define CPACR_EL1_FPEN_EL1EN	(BIT(20)) /* enable EL1 access */
+#define CPACR_EL1_FPEN_EL0EN	(BIT(21)) /* enable EL0 access, if EL1EN set */
+#define CPACR_EL1_FPEN		(CPACR_EL1_FPEN_EL1EN | CPACR_EL1_FPEN_EL0EN)
+
 #define CPACR_EL1_ZEN_EL1EN	(BIT(16)) /* enable EL1 access */
 #define CPACR_EL1_ZEN_EL0EN	(BIT(17)) /* enable EL0 access, if EL1EN set */
 #define CPACR_EL1_ZEN		(CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN)
-- 
2.30.2

