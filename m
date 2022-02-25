Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED6A4C4C82
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiBYRgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 12:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243845AbiBYRgs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 12:36:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F761E480E
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 09:36:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B4CFB832D1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 17:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC3DC340F3;
        Fri, 25 Feb 2022 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810573;
        bh=fPRJD0248ODasGawFZ9MrAUyOiIkorlLpf0lwPYSse4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7yHcNWNYwCsXr9K+4JVhAuGlLmQUfm3lxKI0xrM8ZDVdYftRUoHj1svDs6cppQV3
         JOmi3VnK+BSvYZY5FdzakRcCBvxAnFohGI+yevmAgPmf3EhSsoJ/DYfugEXBbGTz3w
         DhQNXh8gL/VzGVVYcMkztepXxFAguTQ/YjJ9cbS0CHptzXH5AP069UVjRAwImDV+yq
         rbPs5vnlkUgUz0EeqIbj8sMvdlL3urLc+PiHy9lwP8U4M7luJ4mI/Pvt8DAy0D4krU
         tu/W89mlK3y4TCJgZKPZAJxkiBzmJAXFvxTw4P6uG6M7/AeLJ4p2COjCl7Oi0F70Ip
         RhBD1Nl/SV/ug==
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
Subject: [PATCH v12 28/40] KVM: arm64: Handle SME host state when running guests
Date:   Fri, 25 Feb 2022 16:59:11 +0000
Message-Id: <20220225165923.1474372-29-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4113; h=from:subject; bh=fPRJD0248ODasGawFZ9MrAUyOiIkorlLpf0lwPYSse4=; b=owGbwMvMwMWocq27KDak/QLjabUkhiRJrgdPZY3n336R6Pl/tQlv76vfc2foqudVsC8oDeDpFD0p EhDWyWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBMJCiD/b/rGeZbJSa7LdNq+35lTu 4qMgkJ/nB4reHnStGin8kuDNv1ZrZyHJXdnv+G81rn4xTjzUGvv7G+5As/fHua7udlUxnL3CZaOFfJ sBd2XD+4qX+S8ISoZMu3ins0n+UfLlD6bnYgT/siU/jygo+fBYRreRYuj+fe2dpedVyYmVOsme3Goj tb5Pju5H94UC8hxJaYHGH3RuzotidzIkM3r4qomGbW+WbO1k7pqZX6j3I0VW0slkt9+myeJDA9VS1i B0f17Ujro2+dudwE5myatXGVVeqX/u8+v40vW9xK3aZh79EcJzFZ/VCiV4+0yHfJWQwVec9aWPPY9M X4GYpaZrzsvsu70cFgW2TCV/ksAA==
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

While we don't currently support SME in guests we do currently support it
for the host system so we need to take care of SME's impact, including
the floating point register state, when running guests. Simiarly to SVE
we need to manage the traps in CPACR_RL1, what is new is the handling of
streaming mode and ZA.

Normally we defer any handling of the floating point register state until
the guest first uses it however if the system is in streaming mode FPSIMD
and SVE operations may generate SME traps which we would need to distinguish
from actual attempts by the guest to use SME. Rather than do this for the
time being if we are in streaming mode when entering the guest we force
the floating point state to be saved immediately and exit streaming mode,
meaning that the guest won't generate SME traps for supported operations.

We could handle ZA in the access trap similarly to the FPSIMD/SVE state
without the disruption caused by streaming mode but for simplicity
handle it the same way as streaming mode for now.

This will be revisited when we support SME for guests (hopefully before SME
hardware becomes available), for now it will only incur additional cost on
systems with SME and even there only if streaming mode or ZA are enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/fpsimd.c           | 36 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7dc85d5a6552..404b7358ba96 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -438,6 +438,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */
 #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
 #define KVM_ARM64_FP_FOREIGN_FPSTATE	(1 << 14)
+#define KVM_ARM64_HOST_SME_ENABLED	(1 << 15) /* SME enabled for EL0 */
 
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 338733ac63f8..1c585553d74f 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -82,6 +82,26 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 
 	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
 		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
+
+	/*
+	 * We don't currently support SME guests but if we leave
+	 * things in streaming mode then when the guest starts running
+	 * FPSIMD or SVE code it may generate SME traps so as a
+	 * special case if we are in streaming mode we force the host
+	 * state to be saved now and exit streaming mode so that we
+	 * don't have to handle any SME traps for valid guest
+	 * operations. Do this for ZA as well for now for simplicity.
+	 */
+	if (system_supports_sme()) {
+		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
+			vcpu->arch.flags |= KVM_ARM64_HOST_SME_ENABLED;
+
+		if (read_sysreg_s(SYS_SVCR_EL0) &
+		    (SYS_SVCR_EL0_SM_MASK | SYS_SVCR_EL0_ZA_MASK)) {
+			vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
+			fpsimd_save_and_flush_cpu_state();
+		}
+	}
 }
 
 void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu)
@@ -129,6 +149,22 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
 	local_irq_save(flags);
 
+	/*
+	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
+	 * CPACR_EL1_DEFAULT and we need to reenable SME.
+	 */
+	if (has_vhe() && system_supports_sme()) {
+		/* Also restore EL0 state seen on entry */
+		if (vcpu->arch.flags & KVM_ARM64_HOST_SME_ENABLED)
+			sysreg_clear_set(CPACR_EL1, 0,
+					 CPACR_EL1_SMEN_EL0EN |
+					 CPACR_EL1_SMEN_EL1EN);
+		else
+			sysreg_clear_set(CPACR_EL1,
+					 CPACR_EL1_SMEN_EL0EN,
+					 CPACR_EL1_SMEN_EL1EN);
+	}
+
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
 		if (vcpu_has_sve(vcpu)) {
 			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
-- 
2.30.2

