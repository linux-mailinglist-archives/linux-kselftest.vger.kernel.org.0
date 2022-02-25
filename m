Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393AB4C4C58
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbiBYRfG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiBYRfF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:35:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04A31A41D0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:34:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77961B832D1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87E5C340F1;
        Fri, 25 Feb 2022 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810470;
        bh=q8rViqmu5PhdmSANLYaaDJZnkq5qNmrlwrEKeJhpZ6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z79cs7rAC321iIZ1d04Ar7sk4OC3+vM8Y6Q9fn6mkyMFZBZDgegbWtVWtFw9uFtMD
         UmPu//hHq64J7TMpLIKBspEVamtpgPz+9aDPtoUxaPVzubxA7mt8UMp6H7eqUSHfY1
         3M1Qbkjdyx6ZI4PakNVzts1IFU4HuvoFlxVmzxlvr4+2mojY9MxDrUy15BeJklvbJd
         eWJDD7xCd+n+j96wFu/47aeV31MYC98F+/9FqqghzudB4GJ5Gm7jER46xp0VnE6bpE
         2mCiRLegzn3sEhYN0NXHYP+1sVLwQmwSSYyVJgjW5v/MVuAiU/Mp4SxUZb+mznwjix
         wkrRfnsatzxaw==
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
Subject: [PATCH v12 02/40] arm64: Always use individual bits in CPACR floating point enables
Date:   Fri, 25 Feb 2022 16:58:45 +0000
Message-Id: <20220225165923.1474372-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3656; h=from:subject; bh=q8rViqmu5PhdmSANLYaaDJZnkq5qNmrlwrEKeJhpZ6w=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQrLRLHo2MdQYjnQtSzqpVMPLuUCPLCy22fMuJHq V/+hyLiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkKywAKCRAk1otyXVSH0JCJB/ 4rwcd/ySDraoAvakeLCrOqgBK05bwmE9I79v4wzfLWnSTZ6uPf9AL7r/14q2YwdXv6/NS8+uU+YerJ nmgEUo4h0uYBvnLm1XcgNnG+hMIvfefrcw6MfKZO2ahkeigcIsX34jsQRcjISVU3UyYUT05qqCHHZk 3AR61iegBYcTbWGwkHh+SlsLvTuFev86+XyfjpmjVG1C1cgPl7jJZVpD3pGcCxtsKzmcfnrYoW9yiq Rqa2GpsMULqoH1HpAxWrA5LrziqoHvMMiKb4kGck4CHzPW2wQvt/eItAhDJNJ+3+LBySi3Xmf2nomk Y+m7RIPrLCGqKos6K1s7iw0SUA4l/t
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CPACR_EL1 has several bitfields for controlling traps for floating point
features to EL1, each of which has a separate bits for EL0 and EL1. Marc
Zyngier noted that we are not consistent in our use of defines to
manipulate these, sometimes using a define covering the whole field and
sometimes using defines for the individual bits. Make this consistent by
expanding the whole field defines where they are used (currently only in
the KVM code) and deleting them so that no further uses can be
introduced.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h        | 3 ++-
 arch/arm64/include/asm/sysreg.h         | 2 --
 arch/arm64/kvm/hyp/include/hyp/switch.h | 4 ++--
 arch/arm64/kvm/hyp/vhe/switch.c         | 6 +++---
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index eec790842fe2..1767ded83888 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -356,6 +356,7 @@
 	ECN(BKPT32), ECN(VECTOR32), ECN(BRK64)
 
 #define CPACR_EL1_TTA		(1 << 28)
-#define CPACR_EL1_DEFAULT	(CPACR_EL1_FPEN | CPACR_EL1_ZEN_EL1EN)
+#define CPACR_EL1_DEFAULT	(CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN |\
+				 CPACR_EL1_ZEN_EL1EN)
 
 #endif /* __ARM64_KVM_ARM_H__ */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1da4c43d597d..e66dd9ebc337 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1099,11 +1099,9 @@
 
 #define CPACR_EL1_FPEN_EL1EN	(BIT(20)) /* enable EL1 access */
 #define CPACR_EL1_FPEN_EL0EN	(BIT(21)) /* enable EL0 access, if EL1EN set */
-#define CPACR_EL1_FPEN		(CPACR_EL1_FPEN_EL1EN | CPACR_EL1_FPEN_EL0EN)
 
 #define CPACR_EL1_ZEN_EL1EN	(BIT(16)) /* enable EL1 access */
 #define CPACR_EL1_ZEN_EL0EN	(BIT(17)) /* enable EL0 access, if EL1EN set */
-#define CPACR_EL1_ZEN		(CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN)
 
 /* TCR EL1 Bit Definitions */
 #define SYS_TCR_EL1_TCMA1	(BIT(58))
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 701cfb964905..6379a1e3e6e5 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -174,9 +174,9 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 
 	/* Valid trap.  Switch the context: */
 	if (has_vhe()) {
-		reg = CPACR_EL1_FPEN;
+		reg = CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN;
 		if (sve_guest)
-			reg |= CPACR_EL1_ZEN;
+			reg |= CPACR_EL1_ZEN_EL0EN | CPACR_EL1_ZEN_EL1EN;
 
 		sysreg_clear_set(cpacr_el1, 0, reg);
 	} else {
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 11d053fdd604..619353b06e38 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -38,7 +38,7 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 
 	val = read_sysreg(cpacr_el1);
 	val |= CPACR_EL1_TTA;
-	val &= ~CPACR_EL1_ZEN;
+	val &= ~(CPACR_EL1_ZEN_EL0EN | CPACR_EL1_ZEN_EL1EN);
 
 	/*
 	 * With VHE (HCR.E2H == 1), accesses to CPACR_EL1 are routed to
@@ -53,9 +53,9 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 
 	if (update_fp_enabled(vcpu)) {
 		if (vcpu_has_sve(vcpu))
-			val |= CPACR_EL1_ZEN;
+			val |= CPACR_EL1_ZEN_EL0EN | CPACR_EL1_ZEN_EL1EN;
 	} else {
-		val &= ~CPACR_EL1_FPEN;
+		val &= ~(CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN);
 		__activate_traps_fpsimd32(vcpu);
 	}
 
-- 
2.30.2

