Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3AF66507B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 01:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbjAKApa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 19:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbjAKApJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 19:45:09 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635CC5950D
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 16:45:07 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id b14-20020a170903228e00b00192a8ae9df5so9351781plh.7
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 16:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bel+XT/zLWd0POR6+G5xVjH82mkB2MdJkQdaPFECHUM=;
        b=DvrbbMDu518Tg86DXo5WokkRe1qtBzk0MnChbCJfqJatSYcshxXye1SEMGgzijl3Fq
         xWsu6JD7GhNl62+bPlf1fQ8yIcVSqe1FQsRCy+svbOW8SoeRUY3cOqKtLN9H/YRwdqq1
         dh4xIsXZLAIpP7LXjVHN1ckBuLFM1Kd/ZeqammL5Q22nisCaKFFqxG8vTAqsJm8URjWb
         27J6S3Mh3V0bweXTDzeeqoEWVn190lXVw7s/ojhnCbm4q3brG/4fxKdt+J7eMOt0oX+h
         C7GyXou/91q7TnDy4CLPEh43/KcY80DBKuyTd8bC/eRTAmDDlB+rWDayAWJVjRdwV0Fs
         71Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bel+XT/zLWd0POR6+G5xVjH82mkB2MdJkQdaPFECHUM=;
        b=3ZgCF7v1GKPoeWavo5uYA5Ayc6sPtFTmmxU59IoyPW2uQZE0l+yrFX0pPzwCTRF677
         Hza4qS1h5a3sEDV6WOPRTqEwXAg5JehB6Qb7Q9saxLg2zRlOLtQY83BF3gFNe54rbJ+V
         3hrEVi7k6VnDynJXJqRuf8DYDfEciwdrD92ExUBEUAfEPztY75HBAM9v7HTo4o9tcbW/
         5qiKLyCMeLnU6NB0M/RMLoYXK+kZY/BjoZt5DpSuG41QlWyG0j0t449F2HRCsB9kC0YW
         v3QEnB/s892ZkkVst0wZXqtf8sV+k6fGcnQvTLYKvY/aCN1HOOfb0kn+6lSbPOle4T1E
         I9XQ==
X-Gm-Message-State: AFqh2kqIDp9T7vZfZPIEATtqTwBojjDxztO/MOoYKz48kGv5Sinmpy9U
        PxhwPUW7MdhvQZMi2omF/NKIo869wQXCP9ha
X-Google-Smtp-Source: AMrXdXsn7oeGwtHtqG8esaQQoRugEEveNLalxNf4U6nq2TNTaCoGIKO3/48VWuBkXfFjrxxb/MSMDIQ7Ep4842g3
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90b:1494:b0:225:eaa2:3f5d with SMTP
 id js20-20020a17090b149400b00225eaa23f5dmr25140pjb.2.1673397906623; Tue, 10
 Jan 2023 16:45:06 -0800 (PST)
Date:   Wed, 11 Jan 2023 00:44:44 +0000
In-Reply-To: <20230111004445.416840-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20230111004445.416840-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111004445.416840-3-vannapurve@google.com>
Subject: [V5 PATCH 2/3] KVM: selftests: x86: Cache host CPU vendor (AMD vs. Intel)
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cache the host CPU vendor for userspace and share it with guest code.

All the current callers of this_cpu* actually care about host cpu so
they are updated to check host_cpu_is*.

Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h       |  3 +++
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 14 ++++++++++++--
 .../selftests/kvm/x86_64/fix_hypercall_test.c      |  4 ++--
 .../selftests/kvm/x86_64/mmio_warning_test.c       |  2 +-
 .../selftests/kvm/x86_64/pmu_event_filter_test.c   |  4 ++--
 .../vmx_exception_with_invalid_guest_state.c       |  2 +-
 6 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index fdb1af5ca611..c7885f72132a 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -19,6 +19,9 @@
 
 #include "../kvm_util.h"
 
+extern bool host_cpu_is_intel;
+extern bool host_cpu_is_amd;
+
 #define NMI_VECTOR		0x02
 
 #define X86_EFLAGS_FIXED	 (1u << 1)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 7d1768543b91..84915bc7d689 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -19,6 +19,8 @@
 #define MAX_NR_CPUID_ENTRIES 100
 
 vm_vaddr_t exception_handlers;
+bool host_cpu_is_amd;
+bool host_cpu_is_intel;
 
 static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
 {
@@ -113,7 +115,7 @@ static void sregs_dump(FILE *stream, struct kvm_sregs *sregs, uint8_t indent)
 
 bool kvm_is_tdp_enabled(void)
 {
-	if (this_cpu_is_intel())
+	if (host_cpu_is_intel)
 		return get_kvm_intel_param_bool("ept");
 	else
 		return get_kvm_amd_param_bool("npt");
@@ -555,6 +557,8 @@ static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 void kvm_arch_vm_post_create(struct kvm_vm *vm)
 {
 	vm_create_irqchip(vm);
+	sync_global_to_guest(vm, host_cpu_is_intel);
+	sync_global_to_guest(vm, host_cpu_is_amd);
 }
 
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
@@ -1214,7 +1218,7 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
 	max_gfn = (1ULL << (vm->pa_bits - vm->page_shift)) - 1;
 
 	/* Avoid reserved HyperTransport region on AMD processors.  */
-	if (!this_cpu_is_amd())
+	if (!host_cpu_is_amd)
 		return max_gfn;
 
 	/* On parts with <40 physical address bits, the area is fully hidden */
@@ -1254,3 +1258,9 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
 
 	return get_kvm_intel_param_bool("unrestricted_guest");
 }
+
+void kvm_selftest_arch_init(void)
+{
+	host_cpu_is_intel = this_cpu_is_intel();
+	host_cpu_is_amd = this_cpu_is_amd();
+}
diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 5489c9836ec8..0f728f05ea82 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -48,10 +48,10 @@ static void guest_main(void)
 	const uint8_t *other_hypercall_insn;
 	uint64_t ret;
 
-	if (this_cpu_is_intel()) {
+	if (host_cpu_is_intel) {
 		native_hypercall_insn = vmx_vmcall;
 		other_hypercall_insn  = svm_vmmcall;
-	} else if (this_cpu_is_amd()) {
+	} else if (host_cpu_is_amd) {
 		native_hypercall_insn = svm_vmmcall;
 		other_hypercall_insn  = vmx_vmcall;
 	} else {
diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index b0a2a0bae0f3..ce1ccc4c1503 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -93,7 +93,7 @@ int main(void)
 {
 	int warnings_before, warnings_after;
 
-	TEST_REQUIRE(this_cpu_is_intel());
+	TEST_REQUIRE(host_cpu_is_intel);
 
 	TEST_REQUIRE(!vm_is_unrestricted_guest(NULL));
 
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index c728822461b2..4dbb454e1760 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -363,7 +363,7 @@ static void test_pmu_config_disable(void (*guest_code)(void))
  */
 static bool use_intel_pmu(void)
 {
-	return this_cpu_is_intel() &&
+	return host_cpu_is_intel &&
 	       kvm_cpu_property(X86_PROPERTY_PMU_VERSION) &&
 	       kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS) &&
 	       kvm_pmu_has(X86_PMU_FEATURE_BRANCH_INSNS_RETIRED);
@@ -397,7 +397,7 @@ static bool use_amd_pmu(void)
 	uint32_t family = kvm_cpu_family();
 	uint32_t model = kvm_cpu_model();
 
-	return this_cpu_is_amd() &&
+	return host_cpu_is_amd &&
 		(is_zen1(family, model) ||
 		 is_zen2(family, model) ||
 		 is_zen3(family, model));
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
index 53e1ef2fc774..ccdfa5dc1a4d 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
@@ -111,7 +111,7 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	TEST_REQUIRE(this_cpu_is_intel());
+	TEST_REQUIRE(host_cpu_is_intel);
 	TEST_REQUIRE(!vm_is_unrestricted_guest(NULL));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-- 
2.39.0.314.g84b9a713c41-goog

