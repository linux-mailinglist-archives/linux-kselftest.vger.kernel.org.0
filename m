Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF349CE38
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbiAZPac (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiAZPac (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:30:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A7FC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:30:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B6E6189F
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CE8C340E8;
        Wed, 26 Jan 2022 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211031;
        bh=nsQjmDdgPJtJfJxvvZpWGXRhAfTHUXOJuIX2lFKVELQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjVwVNFGVgU6d+5x9U46Ko6e4xoSDPjjTM7ALGBAT0Ny9Ye2Q26KMV64S+UVwsZzL
         crp02q66lmR7xyD5jTHExIJPSEySzBBqf6jW40RITQWAdeZPFUZT+Kb4WGjxHaDZss
         MrdHc77qna5u0xOdNLWvykz2HoTACkXE9aW1hFMdHUe88uSB986Nt9bs55pl2h29vL
         vr8fEh8Oiz/amLp3AKJRong3SGGirLj9KzFOh+FDTlVrbyIL4Pzj3pr9E/FOOLP1zI
         rhth5RNqodSASljoiOuhcIU9HPLL4pm/Uk4jlIH2c7hIjz4Upnutj7xUgqw6xutFeD
         p8lTIr1jVkT4g==
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
Subject: [PATCH v10 02/39] arm64: Always use individual bits in CPACR floating point enables
Date:   Wed, 26 Jan 2022 15:27:12 +0000
Message-Id: <20220126152749.233712-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3603; h=from:subject; bh=nsQjmDdgPJtJfJxvvZpWGXRhAfTHUXOJuIX2lFKVELQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhQeSQHAuaI8AaEmsoOOScY6hIzepTAdNuqKvGd q7qdl8KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFoUAAKCRAk1otyXVSH0F/4B/ 9n341H7JFBMqUQenz4r0mO1hSaKEtQJSdpRUtxc4vz4b/kUiyOWamc6dX3QPb6sVvH5Kd44ImfyjHk yS2oSnVvpDbPHvLNApwj3AIzIfh6YvvM6xPZcHtbZAZjGNxTjLcBuwu6piPA9wXN442e6fDgyLxdR+ Z9R9Sq64ZSS/oXkII94wszWDodecOC4z0bFjGfvKyzN0SRzwZcMROBaePLZnjVQDbM4AlPx0Xny0SW vcKFsjO5j9/mvq7Ot6+QweHVBulxcQ6j3SfCcU3XSaQgcOqJ5GrhhvC33BQSuei9BmiNaZMO70mFMB 0LzAQSMWnbqYEhOp4ptf6UVT88RuS3
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
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
index 58e14f8ead23..4689b0fe7f4d 100644
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

