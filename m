Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5634AC3F6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 16:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358758AbiBGPf2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 10:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357110AbiBGPYz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 10:24:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66CFC0401C8
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 07:24:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72DDF614A4
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACD0C004E1;
        Mon,  7 Feb 2022 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644247493;
        bh=DtugFpthaiK0xEHP2NQTQkSOyUac+uhH3/vXGpUUR8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OM0ms+db7QoIeGWQsIeWKff+Yu9N9OtEMad1sgdSh8Cs6Eoud7VrVus9k8FreYWRp
         f08JYv+w5Iocq3cUBcxE4sf4gcopXktuQsWIkj8O63xcw9TeX/hqJybarSgwWDs+w7
         gnkbmu73RpTVDon1V3jiHayW/7sPiW9bGqzqa8iHQtydr1eDmMt4vHv70f3LQ+cOhL
         2vzG4E8+VBFA4GdC4F2G8pfmBtfxkBGsE7TWBIeLQdnkiHV49z9GD7GOl1sQykkhCV
         0Yb+AgkWqmg0ICgbc5N5JFBeDxMbgsMTEiQ+uhtvBv0osk5gLsFsMZYPo/3Se4IPFg
         feveoBSPaFEJQ==
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
Subject: [PATCH v11 26/40] KVM: arm64: Hide SME system registers from guests
Date:   Mon,  7 Feb 2022 15:20:55 +0000
Message-Id: <20220207152109.197566-27-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; h=from:subject; bh=DtugFpthaiK0xEHP2NQTQkSOyUac+uhH3/vXGpUUR8E=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiATjZhVjgkrdByxSLKuspmwEp1Ss1KXA83wWthUlS vnIER7eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYgE42QAKCRAk1otyXVSH0B3yB/ 0RN8U8EgB3WodFjKH3+iu2Zd5+es1faFYvAPkkMVQn1BqxRPui1m+7WiXoeChTGN9WqMPmgeZ1iLoR vpsKQ6gAKojYqBOkd7ip5xpjiZSpnV8A5uFk8UPtRUBOt5LDNsTW3mG9xrBJskGqFZtj4Fbl8leesi /bd3ckRnjJTtZ+AbSMFCyLDN65ZWGEc/UMjx7Nigw/5HIo0O0AJR272Z6jWFtx+4ebNjUCCczSQnw/ 4NP7yx99EwzR5NdQPHZMEWAx+IMRGeK1zwyk0C9VP9VsafO58/ZW1k09Rs6CwOksPHaFGdjUr9sjbl +M6JXzB99PK2YdnSA6q+Vnl3hHgUHq
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

For the time being we do not support use of SME by KVM guests, support for
this will be enabled in future. In order to prevent any side effects or
side channels via the new system registers, including the EL0 read/write
register TPIDR2, explicitly undefine all the system registers added by
SME and mask out the SME bitfield in SYS_ID_AA64PFR1.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4dc2fba316ff..43516eda9143 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1089,6 +1089,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 	case SYS_ID_AA64PFR1_EL1:
 		if (!kvm_has_mte(vcpu->kvm))
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_MTE);
+
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_SME);
 		break;
 	case SYS_ID_AA64ISAR1_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
@@ -1508,7 +1510,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_UNALLOCATED(4,2),
 	ID_UNALLOCATED(4,3),
 	ID_SANITISED(ID_AA64ZFR0_EL1),
-	ID_UNALLOCATED(4,5),
+	ID_HIDDEN(ID_AA64SMFR0_EL1),
 	ID_UNALLOCATED(4,6),
 	ID_UNALLOCATED(4,7),
 
@@ -1551,6 +1553,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TRFCR_EL1), undef_access },
+	{ SYS_DESC(SYS_SMPRI_EL1), undef_access },
+	{ SYS_DESC(SYS_SMCR_EL1), undef_access },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
@@ -1633,8 +1637,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
+	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
+	{ SYS_DESC(SYS_SVCR_EL0), undef_access },
 
 	{ PMU_SYS_REG(SYS_PMCR_EL0), .access = access_pmcr,
 	  .reset = reset_pmcr, .reg = PMCR_EL0 },
@@ -1674,6 +1680,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
+	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
 
 	{ SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
 
-- 
2.30.2

