Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE404F94D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiDHL64 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbiDHL64 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:58:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9117A8A33D
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02B946206B
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E463EC385A1;
        Fri,  8 Apr 2022 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649419011;
        bh=mpyVrfoj3Ha303zuZjG3RtyooXrFp3K4QGVZ/xNcyCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QB67v2bZQMtGaOcvFxUqMD7uRuMSxCIoZmdfhy8h6jhlUUPa0staCkBssM3cusTP5
         dywnTl6ColVhxpsgyoMiV4jm3r1LZ4K3t5ubPgw5xo0S/CmfKUIDiYxbvQiK7axaPT
         pC/OHFVkLIYwzf47hQQZCsRzHtcnrx1A10fHZ4lFMZ+f9eaLlck1HXSa6LEyqdxctr
         FvkL6MGXOwqYGYeislWxXXt/gwdIWlSW85zySMMKYObxS2YpK9a0kc4MzL0fKJEtDY
         RLMFC3qe3GKoNY3HFkTIOht1ludAabBw0hTg7WvilY3SDXrc4OOslkVIkncUgfDLqL
         CGIWI6ej8JBbg==
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
Subject: [PATCH v13 24/39] KVM: arm64: Hide SME system registers from guests
Date:   Fri,  8 Apr 2022 12:43:13 +0100
Message-Id: <20220408114328.1401034-25-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2636; h=from:subject; bh=mpyVrfoj3Ha303zuZjG3RtyooXrFp3K4QGVZ/xNcyCk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/SRWYJuMOUyhoG4RrOSW+FXVga+MXNZsFprhc0 IjsenR2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAf0gAKCRAk1otyXVSH0AqTB/ 9b0dzf1mObZw8ZekaWF6v59M4AGsTGiY9r3D/7RJFfGf7+IUzBjO/WM0Xr3Sg0WXQq0+q8HNxC6eVv 072ANolPqSWNOUdlDiIXS4LZYCTuVWy+/P5mkxns0Ah2RjXUZ3Wsd4c5fsgKSp2j/ysMXIUJ4TRlYD js9+vNyw00if0vNqNWAEil/gJO8/wlKmmNCTTYdqkULrGQ71A7F5r3IfIRgPDul1lChsXH+ejXmZY8 GwWVrpGJ+812ySVJxW9Kkhiht2/YUTo5q4ZoGjw+vNSbZcdjIibSSQ0Z6HsbK5FrF9W51IEI/R9E7J jPSs0W7v52VNfUwJqvBT18IOSlH5hC
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7b45c040cc27..689e53dd4cb1 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1132,6 +1132,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 	case SYS_ID_AA64PFR1_EL1:
 		if (!kvm_has_mte(vcpu->kvm))
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_MTE);
+
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_SME);
 		break;
 	case SYS_ID_AA64ISAR1_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
@@ -1553,7 +1555,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_UNALLOCATED(4,2),
 	ID_UNALLOCATED(4,3),
 	ID_SANITISED(ID_AA64ZFR0_EL1),
-	ID_UNALLOCATED(4,5),
+	ID_HIDDEN(ID_AA64SMFR0_EL1),
 	ID_UNALLOCATED(4,6),
 	ID_UNALLOCATED(4,7),
 
@@ -1596,6 +1598,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TRFCR_EL1), undef_access },
+	{ SYS_DESC(SYS_SMPRI_EL1), undef_access },
+	{ SYS_DESC(SYS_SMCR_EL1), undef_access },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
@@ -1678,8 +1682,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
+	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
+	{ SYS_DESC(SYS_SVCR_EL0), undef_access },
 
 	{ PMU_SYS_REG(SYS_PMCR_EL0), .access = access_pmcr,
 	  .reset = reset_pmcr, .reg = PMCR_EL0 },
@@ -1719,6 +1725,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
+	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
 
 	{ SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
 
-- 
2.30.2

