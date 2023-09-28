Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B597B0FE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 02:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjI1AUO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjI1AUJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 20:20:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3ED102
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 17:20:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c4ec85ea9so236282157b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 17:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695860403; x=1696465203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i6Py+ACdvl5qdIki/mVRt+DdjK10J7Lfr08DhLsqDcA=;
        b=NOfvqPavBdoSw9hxoZwK+Sx1zCwPZSVkE8XSyB6iJ2tyTOs4Y17H1XrPwDyRUDaSyl
         ySDs3YiBTb6F1Q7flZaBX5OI6O76jpGiuuGDNvIsYq4Wbblhwl/nl7bV1ZOBFraJGq8f
         TfwzZUv6XNKYOFrFPPgYnWPuI9qR/dy+0RF8dTiE4W/ZVFcrkkBq3k+g3F1Uwi1pIgfP
         JCP+2lqeVGdZgzbH1XX2WY38wOLLo367wBFF2xmWAHcP4FSRrUwgcCXQHe1hrdPSMkh+
         /lYW+nmmYJMtW7jKPYCwkZHZn3QmhG/hCktyAxRUghI7w8eB5wDwk4znW98WLOaEDSMn
         ombQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695860403; x=1696465203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6Py+ACdvl5qdIki/mVRt+DdjK10J7Lfr08DhLsqDcA=;
        b=IWdPfFq3D2QEih7uYMwRyR+MblOmIYxUlWVG1DW21WzUQ8iQcXZ2qm/snOm3a96TgH
         UYqxCw1fGwT1XIzLNSQ12/onpHL3bkThmgyGTFYjV+giUPfbbl6Iqx6mSmu2PDCa6Ck0
         lI/ka7KzGJ4jMNMkdKS4vhcLoXME4EfEF+ZX/Po/Oemxd9f/pm7meWJXErSdbnGFcvaK
         NUWJJayBYRLkX630iJ5CeResrYElUVelbEOVQKc0OIFctafpzlvu9rf6Mto1gLNc2OCT
         IW1d6Yb+9NsmgEZ+4IiNm8PeHSLAUuB2lKjrkDdKyM+MaJgrbFxS+UKTXKCiRmt9jFCi
         SBoA==
X-Gm-Message-State: AOJu0Yz0pBOAK8ICELNwY4Tzf5mprskBc7pTJ4mPYmOokh4R1WezHJQ3
        dOe17SiTo6ht3GIh0tklIMgxcKArSPQ=
X-Google-Smtp-Source: AGHT+IHUrcVz15+j+5HECYlp3Pgaiq4UBfegTD1MqSW66kU3ut2BpeebBPZckxrdcj0LzX6zbXVIBR34wfg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4316:0:b0:58c:8c9f:c05a with SMTP id
 q22-20020a814316000000b0058c8c9fc05amr53375ywa.9.1695860403653; Wed, 27 Sep
 2023 17:20:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Sep 2023 17:19:53 -0700
In-Reply-To: <20230928001956.924301-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230928001956.924301-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928001956.924301-3-seanjc@google.com>
Subject: [PATCH 2/5] KVM: x86: Constrain guest-supported xfeatures only at KVM_GET_XSAVE{2}
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Tyler Stachecki <stachecki.tyler@gmail.com>,
        Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Mask off xfeatures that aren't exposed to the guest only when saving guest
state via KVM_GET_XSAVE{2} instead of modifying user_xfeatures directly.
Preserving the maximal set of xfeatures in user_xfeatures restores KVM's
ABI for KVM_SET_XSAVE, which prior to commit ad856280ddea ("x86/kvm/fpu:
Limit guest user_xfeatures to supported bits of XCR0") allowed userspace
to load xfeatures that are supported by the host, irrespective of what
xfeatures are exposed to the guest.

There is no known use case where userspace *intentionally* loads xfeatures
that aren't exposed to the guest, but the bug fixed by commit ad856280ddea
was specifically that KVM_GET_SAVE{2} would save xfeatures that weren't
exposed to the guest, e.g. would lead to userspace unintentionally loading
guest-unsupported xfeatures when live migrating a VM.

Restricting KVM_SET_XSAVE to guest-supported xfeatures is especially
problematic for QEMU-based setups, as QEMU has a bug where instead of
terminating the VM if KVM_SET_XSAVE fails, QEMU instead simply stops
loading guest state, i.e. resumes the guest after live migration with
incomplete guest state, and ultimately results in guest data corruption.

Note, letting userspace restore all host-supported xfeatures does not fix
setups where a VM is migrated from a host *without* commit ad856280ddea,
to a target with a subset of host-supported xfeatures.  However there is
no way to safely address that scenario, e.g. KVM could silently drop the
unsupported features, but that would be a clear violation of KVM's ABI and
so would require userspace to opt-in, at which point userspace could
simply be updated to sanitize the to-be-loaded XSAVE state.

Reported-by: Tyler Stachecki <stachecki.tyler@gmail.com>
Closes: https://lore.kernel.org/all/20230914010003.358162-1-tstachecki@bloomberg.net
Fixes: ad856280ddea ("x86/kvm/fpu: Limit guest user_xfeatures to supported bits of XCR0")
Cc: stable@vger.kernel.org
Cc: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/fpu/xstate.c |  5 +----
 arch/x86/kvm/cpuid.c         |  8 --------
 arch/x86/kvm/x86.c           | 18 ++++++++++++++++--
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 76408313ed7f..ef6906107c54 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1539,10 +1539,7 @@ static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 		fpregs_restore_userregs();
 
 	newfps->xfeatures = curfps->xfeatures | xfeatures;
-
-	if (!guest_fpu)
-		newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
-
+	newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
 	newfps->xfd = curfps->xfd & ~xfeatures;
 
 	/* Do the final updates within the locked region */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0544e30b4946..773132c3bf5a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -360,14 +360,6 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.guest_supported_xcr0 =
 		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
 
-	/*
-	 * FP+SSE can always be saved/restored via KVM_{G,S}ET_XSAVE, even if
-	 * XSAVE/XCRO are not exposed to the guest, and even if XSAVE isn't
-	 * supported by the host.
-	 */
-	vcpu->arch.guest_fpu.fpstate->user_xfeatures = vcpu->arch.guest_supported_xcr0 |
-						       XFEATURE_MASK_FPSSE;
-
 	kvm_update_pv_runtime(vcpu);
 
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 41d8e6c8570c..1e645f5b1e2c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5386,12 +5386,26 @@ static int kvm_vcpu_ioctl_x86_set_debugregs(struct kvm_vcpu *vcpu,
 static void kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
 					  u8 *state, unsigned int size)
 {
+	/*
+	 * Only copy state for features that are enabled for the guest.  The
+	 * state itself isn't problematic, but setting bits in the header for
+	 * features that are supported in *this* host but not exposed to the
+	 * guest can result in KVM_SET_XSAVE failing when live migrating to a
+	 * compatible host without the features that are NOT exposed to the
+	 * guest.
+	 *
+	 * FP+SSE can always be saved/restored via KVM_{G,S}ET_XSAVE, even if
+	 * XSAVE/XCRO are not exposed to the guest, and even if XSAVE isn't
+	 * supported by the host.
+	 */
+	u64 supported_xcr0 = vcpu->arch.guest_supported_xcr0 |
+			     XFEATURE_MASK_FPSSE;
+
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return;
 
 	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.guest_fpu, state, size,
-				       vcpu->arch.guest_fpu.fpstate->user_xfeatures,
-				       vcpu->arch.pkru);
+				       supported_xcr0, vcpu->arch.pkru);
 }
 
 static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
-- 
2.42.0.582.g8ccd20d70d-goog

