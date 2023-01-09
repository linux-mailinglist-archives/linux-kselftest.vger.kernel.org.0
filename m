Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB1A662E33
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 19:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjAISJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 13:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjAISIt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 13:08:49 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8183C3A8
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Jan 2023 10:07:43 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h192so6436191pgc.7
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Jan 2023 10:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjepIbO6GWlHhX91qulkt2Gx/2Rp33KnfWlDoun7rHc=;
        b=njVGvA2BBq3lnqckIDLq2Gfu60hjfzhMZj2lCDBA9Q/Lpa3+ceKbvbCs7TKBQE6VJI
         JcLcW2ERDIL33DzVnKFGiRsQDhsvMqscBoj/k1aNTZeqSd+0O+78Kgx6Vg3zbyValq16
         h4mCDaoPitJhps3c/ZPEY8VZWtzGEaa92W68IbCJgZSSUlI2EBgQJ9rJ2rFN5p0HAayC
         rkBh3/3+LriKDJ3ih4M1SbWqcNNFZctTCctIRO1JQrgWvMNOIt1QhgmzRUAUfQRe+BIg
         RY2Nh3iZ38UcRLASvxnTDMrmJArGi3ESXXRR3EOtolt7GJydZNIud/QfIf29lt0RhaFH
         v8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjepIbO6GWlHhX91qulkt2Gx/2Rp33KnfWlDoun7rHc=;
        b=2BqiBoruIiP2wmMpZuOpp9/Uk7Z9woke7rkTlVt7BSO8yNR94RwGRIyDS3hT1xmPPZ
         LKOOu7YJRBIYUoB8HO0H46115i8REelff8+diaLl/ZOn2ZZ+ACoCdkSXDYPax7io675S
         wAj9Q6k0iJvO0ek6u0hQsNch3kIxtzIyW2pTT2lDxNvhG7ZlRlK2O32usDutqlgvejBZ
         qBQo+b3fWuCzuQSo8ViyqH7lQmd2GqF9g70RbgLwOiqApqhV3vSgyFsped5Z0ZZ0oj+k
         TyYXPxExawXEzJuThzCcyto4pOITNcohu5rT51zop7cDZ2vB6ZWD7XbujToDisjWa+3n
         yQ8Q==
X-Gm-Message-State: AFqh2ko0YfzRTb3REIwRYnbup6tMtTFtLpA+LkEY1XwnPKpXremccqPw
        Hqy9tWcReLRP5dvUH3clGUcyMryBjTlbxw0/
X-Google-Smtp-Source: AMrXdXs8UZlZ+kaiOTh68EobJZJpxdjrDGhRiljc7mD96iwfDDLVeszhLuzh0X0p8er38fyUS+VXGw==
X-Received: by 2002:a05:6a00:1948:b0:581:bfac:7a52 with SMTP id s8-20020a056a00194800b00581bfac7a52mr702100pfk.1.1673287662364;
        Mon, 09 Jan 2023 10:07:42 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k18-20020a628412000000b0058103f45d9esm3138368pfd.82.2023.01.09.10.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:07:41 -0800 (PST)
Date:   Mon, 9 Jan 2023 18:07:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com
Subject: Re: [V4 PATCH 1/4] KVM: selftests: x86: use this_cpu_* helpers
Message-ID: <Y7xX6hg+YTgTrAzW@google.com>
References: <20221228192438.2835203-1-vannapurve@google.com>
 <20221228192438.2835203-2-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228192438.2835203-2-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 28, 2022, Vishal Annapurve wrote:
> Use this_cpu_* helpers to query the cpu vendor.

Neither the changelog nor the shortlog captures what this patch actually does,
or rather what I inteded it to do.  Specifically, what I suggested (or intended
to suggest) was:

  KVM: selftests: Rename vendor string helpers to use "this_cpu" prefix

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---

...

> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index acfa1d01e7df..a799af572f3f 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1006,26 +1006,14 @@ void kvm_x86_state_cleanup(struct kvm_x86_state *state)
>  	free(state);
>  }
>  
> -static bool cpu_vendor_string_is(const char *vendor)
> -{
> -	const uint32_t *chunk = (const uint32_t *)vendor;
> -	uint32_t eax, ebx, ecx, edx;
> -
> -	cpuid(0, &eax, &ebx, &ecx, &edx);
> -	return (ebx == chunk[0] && edx == chunk[1] && ecx == chunk[2]);
> -}
> -
>  bool is_intel_cpu(void)

Drop the is_intel_cpu() and is_amd_cpu() wrappers.  The whole point of the rename
was so that it's obvious at the call site that the function is checking the "current"
CPU context.

That obviously means dropping the is_host_cpu_amd() and is_host_cpu_intel() wrappers
too.  IMO, the extra layer to jump through (more from a code reading perspective then
a code generation perspective) isn't worth protecting the booleans.

It's slightly more churn (in between patches, not overall), but the benefit is that
it allows squasing patches 2 and 3 into a single patch, e.g. "KVM: selftests: Cache
host CPU vendor (AMD vs. Intel)"

---
 tools/testing/selftests/kvm/include/x86_64/processor.h    | 3 +++
 tools/testing/selftests/kvm/lib/x86_64/processor.c        | 8 ++++----
 tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c   | 4 ++--
 tools/testing/selftests/kvm/x86_64/mmio_warning_test.c    | 2 +-
 .../testing/selftests/kvm/x86_64/pmu_event_filter_test.c  | 4 ++--
 .../kvm/x86_64/vmx_exception_with_invalid_guest_state.c   | 2 +-
 6 files changed, 13 insertions(+), 10 deletions(-)

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
index 0b8de34aa10e..84915bc7d689 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -19,8 +19,8 @@
 #define MAX_NR_CPUID_ENTRIES 100
 
 vm_vaddr_t exception_handlers;
-static bool host_cpu_is_amd;
-static bool host_cpu_is_intel;
+bool host_cpu_is_amd;
+bool host_cpu_is_intel;
 
 static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
 {
@@ -115,7 +115,7 @@ static void sregs_dump(FILE *stream, struct kvm_sregs *sregs, uint8_t indent)
 
 bool kvm_is_tdp_enabled(void)
 {
-	if (this_cpu_is_intel())
+	if (host_cpu_is_intel)
 		return get_kvm_intel_param_bool("ept");
 	else
 		return get_kvm_amd_param_bool("npt");
@@ -1218,7 +1218,7 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
 	max_gfn = (1ULL << (vm->pa_bits - vm->page_shift)) - 1;
 
 	/* Avoid reserved HyperTransport region on AMD processors.  */
-	if (!this_cpu_is_amd())
+	if (!host_cpu_is_amd)
 		return max_gfn;
 
 	/* On parts with <40 physical address bits, the area is fully hidden */
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

base-commit: 04b420511919f7b78f17f5fa6dc92975a8b2d7c4
-- 

