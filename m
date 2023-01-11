Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3D066507D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 01:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjAKApb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 19:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjAKApG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 19:45:06 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3BB5A8A3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 16:45:04 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id w185-20020a6382c2000000b004b1fcf39c18so3774073pgd.13
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 16:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5nmfF04B2IHgLFB8aCXKpeIh21CW5hhnA3Zs7nsESA=;
        b=eO2t/+pj8mPlLMMdcEpbBNko4TJswSnywcF/DfhdxgABLVsoaSv5PwBNwl3Qma9Q/J
         eXScNp2W/dA8aEVblqFCjNCBjYCy9lZ5DfDFpoVJQKW8nt15tQ3gpISUZq51HTO6+LPn
         Ht8MK+yMvyLmKBsjXWJ9uxI1h77qVAgk6m/k3gQJCqiCjR1XHVpLSTLdyyEjfFJ4EOGp
         x29Ky/AliXXIegn4/Dy/8vOdvdCxB4TSCf6e71+HcES1hoOOQDGKH7WBjui1oH2Wk3ZQ
         Xfcy/crmDd6kyKLEaGlEjLbmhm6FKCgH/DBXy7teV2ghTi/tFYfy00Vm75JHekaMbbYa
         Mt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5nmfF04B2IHgLFB8aCXKpeIh21CW5hhnA3Zs7nsESA=;
        b=3TKt3G/8LxjckIVAhaVUpfEAB9E+0cblTV0mQFmgil/3Z+HkakV7CrVFVjudmGvUVY
         YZ1+DJoyeBNZm+lelPpR73bL+29pf9PYDPN1trpgNThucyuUmUx/EpK54Xk3n8kwaVnV
         zRptHQXasnKIXUN+wuviVSfST1/6k83THUjVlDZLCRYNc1CNDshihSSHIkwLtNs1CKlG
         fULy3ogIS9Qf4uzE8aUr4Ha7sda88kFbWNGUMLjJvh4kxIYxnMJaaH9MyhdE7m/ZOfWr
         Z0QagE/e7RQaAjhJFcPiM5anjS19ZDyDdB0aE8FzcDCqFF/ApyMRRdMyPqf2rvwBxUxh
         Z3Og==
X-Gm-Message-State: AFqh2kq9mUdGzsD1T74n9mcAjW9f9O9gY/OZ3BUm/4UBCaE4hJIRye60
        HLrEY9y2MpZDeCZpbJs0GeHyjhp0FIjFsROR
X-Google-Smtp-Source: AMrXdXvIsZvqIwPXVSDDcpOSnlLt/VOqLw9atFZ7FZqmkCAhzULy+I69nrXjKn/XLRy+k8kzhieWBXvtznW6559i
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:aa7:81d4:0:b0:577:5678:bc80 with SMTP
 id c20-20020aa781d4000000b005775678bc80mr5338691pfn.62.1673397904191; Tue, 10
 Jan 2023 16:45:04 -0800 (PST)
Date:   Wed, 11 Jan 2023 00:44:43 +0000
In-Reply-To: <20230111004445.416840-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20230111004445.416840-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111004445.416840-2-vannapurve@google.com>
Subject: [V5 PATCH 1/3] KVM: selftests: x86: Use "this_cpu" prefix for cpu
 vendor queries
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com,
        andrew.jones@linux.dev, Vishal Annapurve <vannapurve@google.com>
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

Replace is_intel/amd_cpu helpers with this_cpu_* helpers to better
convey the intent of querying vendor of the current cpu.

Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 25 +++++++++++++++---
 .../selftests/kvm/lib/x86_64/processor.c      | 26 ++-----------------
 .../selftests/kvm/x86_64/fix_hypercall_test.c |  4 +--
 .../selftests/kvm/x86_64/mmio_warning_test.c  |  2 +-
 .../kvm/x86_64/pmu_event_filter_test.c        |  4 +--
 .../vmx_exception_with_invalid_guest_state.c  |  2 +-
 6 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 2a5f47d51388..fdb1af5ca611 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -555,6 +555,28 @@ static inline uint32_t this_cpu_model(void)
 	return x86_model(this_cpu_fms());
 }
 
+static inline bool this_cpu_vendor_string_is(const char *vendor)
+{
+	const uint32_t *chunk = (const uint32_t *)vendor;
+	uint32_t eax, ebx, ecx, edx;
+
+	cpuid(0, &eax, &ebx, &ecx, &edx);
+	return (ebx == chunk[0] && edx == chunk[1] && ecx == chunk[2]);
+}
+
+static inline bool this_cpu_is_intel(void)
+{
+	return this_cpu_vendor_string_is("GenuineIntel");
+}
+
+/*
+ * Exclude early K5 samples with a vendor string of "AMDisbetter!"
+ */
+static inline bool this_cpu_is_amd(void)
+{
+	return this_cpu_vendor_string_is("AuthenticAMD");
+}
+
 static inline uint32_t __this_cpu_has(uint32_t function, uint32_t index,
 				      uint8_t reg, uint8_t lo, uint8_t hi)
 {
@@ -691,9 +713,6 @@ static inline void cpu_relax(void)
 		"hlt\n"	\
 		)
 
-bool is_intel_cpu(void);
-bool is_amd_cpu(void);
-
 struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu);
 void vcpu_load_state(struct kvm_vcpu *vcpu, struct kvm_x86_state *state);
 void kvm_x86_state_cleanup(struct kvm_x86_state *state);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index acfa1d01e7df..7d1768543b91 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -113,7 +113,7 @@ static void sregs_dump(FILE *stream, struct kvm_sregs *sregs, uint8_t indent)
 
 bool kvm_is_tdp_enabled(void)
 {
-	if (is_intel_cpu())
+	if (this_cpu_is_intel())
 		return get_kvm_intel_param_bool("ept");
 	else
 		return get_kvm_amd_param_bool("npt");
@@ -1006,28 +1006,6 @@ void kvm_x86_state_cleanup(struct kvm_x86_state *state)
 	free(state);
 }
 
-static bool cpu_vendor_string_is(const char *vendor)
-{
-	const uint32_t *chunk = (const uint32_t *)vendor;
-	uint32_t eax, ebx, ecx, edx;
-
-	cpuid(0, &eax, &ebx, &ecx, &edx);
-	return (ebx == chunk[0] && edx == chunk[1] && ecx == chunk[2]);
-}
-
-bool is_intel_cpu(void)
-{
-	return cpu_vendor_string_is("GenuineIntel");
-}
-
-/*
- * Exclude early K5 samples with a vendor string of "AMDisbetter!"
- */
-bool is_amd_cpu(void)
-{
-	return cpu_vendor_string_is("AuthenticAMD");
-}
-
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 {
 	if (!kvm_cpu_has_p(X86_PROPERTY_MAX_PHY_ADDR)) {
@@ -1236,7 +1214,7 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
 	max_gfn = (1ULL << (vm->pa_bits - vm->page_shift)) - 1;
 
 	/* Avoid reserved HyperTransport region on AMD processors.  */
-	if (!is_amd_cpu())
+	if (!this_cpu_is_amd())
 		return max_gfn;
 
 	/* On parts with <40 physical address bits, the area is fully hidden */
diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 32f7e09ef67c..5489c9836ec8 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -48,10 +48,10 @@ static void guest_main(void)
 	const uint8_t *other_hypercall_insn;
 	uint64_t ret;
 
-	if (is_intel_cpu()) {
+	if (this_cpu_is_intel()) {
 		native_hypercall_insn = vmx_vmcall;
 		other_hypercall_insn  = svm_vmmcall;
-	} else if (is_amd_cpu()) {
+	} else if (this_cpu_is_amd()) {
 		native_hypercall_insn = svm_vmmcall;
 		other_hypercall_insn  = vmx_vmcall;
 	} else {
diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index fb02581953a3..b0a2a0bae0f3 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -93,7 +93,7 @@ int main(void)
 {
 	int warnings_before, warnings_after;
 
-	TEST_REQUIRE(is_intel_cpu());
+	TEST_REQUIRE(this_cpu_is_intel());
 
 	TEST_REQUIRE(!vm_is_unrestricted_guest(NULL));
 
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 2de98fce7edd..c728822461b2 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -363,7 +363,7 @@ static void test_pmu_config_disable(void (*guest_code)(void))
  */
 static bool use_intel_pmu(void)
 {
-	return is_intel_cpu() &&
+	return this_cpu_is_intel() &&
 	       kvm_cpu_property(X86_PROPERTY_PMU_VERSION) &&
 	       kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS) &&
 	       kvm_pmu_has(X86_PMU_FEATURE_BRANCH_INSNS_RETIRED);
@@ -397,7 +397,7 @@ static bool use_amd_pmu(void)
 	uint32_t family = kvm_cpu_family();
 	uint32_t model = kvm_cpu_model();
 
-	return is_amd_cpu() &&
+	return this_cpu_is_amd() &&
 		(is_zen1(family, model) ||
 		 is_zen2(family, model) ||
 		 is_zen3(family, model));
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
index 2641b286b4ed..53e1ef2fc774 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
@@ -111,7 +111,7 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	TEST_REQUIRE(is_intel_cpu());
+	TEST_REQUIRE(this_cpu_is_intel());
 	TEST_REQUIRE(!vm_is_unrestricted_guest(NULL));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-- 
2.39.0.314.g84b9a713c41-goog

