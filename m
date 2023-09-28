Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86417B0FDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 02:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjI1AUM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 20:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjI1AUJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 20:20:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D00196
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 17:20:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c2ca3bcf9so234400317b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695860407; x=1696465207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TVfUpdVb4H8djihj2XvGyhzWBuel7qP+7Sh6W+PqBNQ=;
        b=QfVgvl64c9mB0oYD9auDZK0joTr4LN9z9qsgMRTS7qJ0IC2VsIPjYeAgFMTE01lJY/
         DxpA8VZAHOwZ9JOjXpQ/YT5jeTrG1M0fSuteVmJ4qdpmMk4qP6qALPkj9wzGkl2K6xsQ
         pxS38FE0eQLZXb4yWwyA7lDxje892UwNW69m9XO+0uWhRkK73QCJ5e3GC/JYqQocz83W
         s+m6uPz/z2O7ySSS6PFoTcBCMjZEfr1mRVm5mDz/U+MkNJ7C9ZW0zDCuybGuPKOh0qge
         7PbNWxMWccE9/TywCKwoteEZktK20LESCqNlXLhZ361Fom+rbhC4Gyl9UmzyiFU+75+Q
         SgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695860407; x=1696465207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVfUpdVb4H8djihj2XvGyhzWBuel7qP+7Sh6W+PqBNQ=;
        b=jl17C070qsDR3l/Nh6REpsLtVX/V0B5//1rHkkNW5sNQ4iLrQJuPu5NxgXtLu/1rid
         H/08rvA1Gdjvp0EOiU/48huOTx5+ktqt1ggNq12nyAfAZCcMCMxByzfZ66srTFC5NsLA
         MBuFQX1NfFZTBhZ7e/E1XTX6DmPX/9wwflW/Ng3hdnUU3+ciDfmTwsz8hwbIiknWxVWs
         uZLICEO78OrU6xcoxububd+worymulkotFP3Npym78qAGc5jy1UAKlza7F694XgOs0GN
         t4CKpmVU2fw+MeRO4jSyS8LhXm7LoSBfSdWopijOgXZ5TUzJbGqlhQxD4CbxtbDUOHNn
         3P5Q==
X-Gm-Message-State: AOJu0YzQgrfZ26eOYRYeTgaJB47rhw0GG9UpBE0S1r4kQT2tX03o38+0
        N2LvsyUKq3D4XD4h49nXU+SyO6/2mCc=
X-Google-Smtp-Source: AGHT+IFhAUt+8/byCgo6N2PCf+dvWKMyFGUjD1tcqW/1QA0MnF0S/CYub5vkgi5QAlFkH9KMWwwIy4ogT3A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:541:b0:d0c:c83b:94ed with SMTP id
 z1-20020a056902054100b00d0cc83b94edmr49229ybs.10.1695860407456; Wed, 27 Sep
 2023 17:20:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Sep 2023 17:19:55 -0700
In-Reply-To: <20230928001956.924301-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230928001956.924301-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928001956.924301-5-seanjc@google.com>
Subject: [PATCH 4/5] KVM: selftests: Load XSAVE state into untouched vCPU
 during state test
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Expand x86's state test to load XSAVE state into a "dummy" vCPU prior to
KVM_SET_CPUID2, and again with an empty guest CPUID model.  Except for
off-by-default features, i.e. AMX, KVM's ABI for KVM_SET_XSAVE is that
userspace is allowed to load xfeatures so long as they are supported by
the host.  This is a regression test for a combination of KVM bugs where
the state saved by KVM_GET_XSAVE{2} could not be loaded via KVM_SET_XSAVE
if the saved xstate_bv would load guest-unsupported xfeatures.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/x86_64/state_test.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index df3e93df4343..115b2cdf9279 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -231,9 +231,9 @@ static void __attribute__((__flatten__)) guest_code(void *arg)
 int main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
-
+	struct kvm_cpuid2 empty_cpuid = {};
 	struct kvm_regs regs1, regs2;
-	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu *vcpu, *vcpuN;
 	struct kvm_vm *vm;
 	struct kvm_x86_state *state;
 	struct ucall uc;
@@ -286,6 +286,21 @@ int main(int argc, char *argv[])
 		/* Restore state in a new VM.  */
 		vcpu = vm_recreate_with_one_vcpu(vm);
 		vcpu_load_state(vcpu, state);
+
+		/*
+		 * Restore XSAVE state in a dummy vCPU, first without doing
+		 * KVM_SET_CPUID2, and then with an empty guest CPUID.  Except
+		 * for off-by-default xfeatures, e.g. AMX, KVM is supposed to
+		 * allow KVM_SET_XSAVE regardless of guest CPUID.  Manually
+		 * load only XSAVE state, MSRs in particular have a much more
+		 * convoluted ABI.
+		 */
+		vcpuN = __vm_vcpu_add(vm, vcpu->id + 1);
+		vcpu_xsave_set(vcpuN, state->xsave);
+
+		vcpu_init_cpuid(vcpuN, &empty_cpuid);
+		vcpu_xsave_set(vcpuN, state->xsave);
+
 		kvm_x86_state_cleanup(state);
 
 		memset(&regs2, 0, sizeof(regs2));
-- 
2.42.0.582.g8ccd20d70d-goog

