Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1436C711344
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbjEYSLe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjEYSLd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 14:11:33 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279151B1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 11:11:24 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-521262a6680so1906957a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685038283; x=1687630283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=24LANnmej8B3PcoImBJ8uEUDYvKnZqxjGN/SizttJ88=;
        b=tfbNBx83T6bPZDxFw2ZWGuTGQOsaah7q9ig8ugF86C5fhG52SQ/fOUUWwUl4r+W7Jq
         iKCuG4jyFuJ4zEbeIWoQ5eTXgHX4pe+AHekLx2MiZIGuAl5TACh0y2SJi5StGgDeOhva
         zJsSCsRi/AWap5Z+nFg7hf7oNOOgjMr+K0fTQqEN2MBGQ3O0ooQ2HBP9c6FMiIvOIc/6
         yHdrovfpytnGEv5gYTr4XVrf4OE7USNO7lH2b9ctcXJCEJ9YqcMFPR0ysoJIi2gO0Gp/
         xa0gz0fEanoleg1GN1aZCzkIA38WMLOhMikwyxym85m2e4pSxnOXOSgUme05YV+teuJG
         rdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038283; x=1687630283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24LANnmej8B3PcoImBJ8uEUDYvKnZqxjGN/SizttJ88=;
        b=Bu0X9hMVOkog3awqd9zZPQFKp/YdsOiMDRdc8H2+b3hiF7+M3cC/k1RhZDtWMmT7FL
         VN/2fNZOSamVE9DgXrMHkzot9VqMM4rYBWE/4YNRo4PPhftDLk7ozwvbQaXnKdtAOzwu
         bZVoA3HT7fg55LKF/llLNpZc+qQQKaFSwgfCos7ewQoXV8BEpGbBXp0kI5HUryJDWWqI
         shxzo2mn54Uxn13sqKRhmPfhZyulT3uk04faMmUg/gxvA44a02fMTKhQL4EoAsmacrjT
         oPQjkMoNzMcLpxRD/3onr27wlwJGNN8pG4ck+iAEmTAgnJAERYZWc7UzjJtKNlTJ/EU2
         1u5g==
X-Gm-Message-State: AC+VfDyLksJzjhBEKyWZj9kfBFpEUzTccM3mBUqNiz6ppn7c4ZqFTkzm
        reaubTtRZd94JndzTQR9f1HG0Mow9hA=
X-Google-Smtp-Source: ACHHUZ5bIKgjRyFxtN7gSChcpUakbsaH1V3Ik5uR+3HRpu33XfaUepEJ5Tou44ROLmaQZn2Z1cbN7hH+k/M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6792:0:b0:530:3aaa:81b5 with SMTP id
 e18-20020a656792000000b005303aaa81b5mr5048751pgr.8.1685038283578; Thu, 25 May
 2023 11:11:23 -0700 (PDT)
Date:   Thu, 25 May 2023 11:11:21 -0700
In-Reply-To: <20230420104622.12504-6-ljrcore@126.com>
Mime-Version: 1.0
References: <20230420104622.12504-1-ljrcore@126.com> <20230420104622.12504-6-ljrcore@126.com>
Message-ID: <ZG+kyWjyhr7cg/xb@google.com>
Subject: Re: [PATCH v2 5/7] KVM: selftests: Check if pmu_event_filter meets
 expectations on fixed ctrs
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 20, 2023, Jinrong Liang wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add tests to cover that pmu_event_filter works as expected when
> it's applied to fixed performance counters, even if there is none
> fixed counter exists (e.g. Intel guest pmu version=1 or AMD guest).
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../kvm/x86_64/pmu_event_filter_test.c        | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index a3d5c30ce914..0f54c53d7fff 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -31,6 +31,7 @@
>  #define PMU_EVENT_FILTER_INVALID_ACTION		(KVM_PMU_EVENT_DENY + 1)
>  #define PMU_EVENT_FILTER_INVALID_FLAGS			(KVM_PMU_EVENT_FLAG_MASKED_EVENTS + 1)
>  #define PMU_EVENT_FILTER_INVALID_NEVENTS		(MAX_FILTER_EVENTS + 1)
> +#define INTEL_PMC_IDX_FIXED 32
>  
>  /*
>   * This is how the event selector and unit mask are stored in an AMD
> @@ -817,6 +818,113 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> +static void intel_guest_run_fixed_counters(uint8_t fixed_ctr_idx)
> +{
> +	for (;;) {
> +		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> +		wrmsr(MSR_CORE_PERF_FIXED_CTR0 + fixed_ctr_idx, 0);
> +
> +		/* Only OS_EN bit is enabled for fixed counter[idx]. */
> +		wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, BIT_ULL(4 * fixed_ctr_idx));
> +		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL,
> +		      BIT_ULL(INTEL_PMC_IDX_FIXED + fixed_ctr_idx));
> +		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
> +		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> +
> +		GUEST_SYNC(rdmsr(MSR_CORE_PERF_FIXED_CTR0 + fixed_ctr_idx));
> +	}
> +}
> +
> +static struct kvm_vcpu *new_vcpu(void *guest_code)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +	vm_init_descriptor_tables(vm);
> +	vcpu_init_descriptor_tables(vcpu);

Unnecessary copy+paste, this test doesn't setup a #GP handler.

> +
> +	return vcpu;
> +}
> +
> +static void free_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	kvm_vm_free(vcpu->vm);
> +}
> +
> +static uint64_t test_fixed_ctr_without_filter(struct kvm_vcpu *vcpu)
> +{
> +	return run_vcpu_to_sync(vcpu);
> +}

Please don't add a wrappers that are single line passthroughs.

> +static const uint32_t actions[] = {
> +	KVM_PMU_EVENT_ALLOW,
> +	KVM_PMU_EVENT_DENY,
> +};

(a) don't define global variables with super common names (this test sets a bad
precedent).  (b) this array is used in *one* function, i.e. it can be a local
variable.  (c) using an array doesn't save you code and just obfuscates what's
happening.

> +static uint64_t test_fixed_ctr_with_filter(struct kvm_vcpu *vcpu,

Don't abbreviate "counter", there's really no need and "ctr" versus "ctrl" is
already confusing enough.

> +					   uint32_t action,
> +					   uint32_t bitmap)
> +{
> +	struct kvm_pmu_event_filter *f;
> +	uint64_t r;
> +
> +	f = create_pmu_event_filter(0, 0, action, 0, bitmap);
> +	r = test_with_filter(vcpu, f);
> +	free(f);
> +	return r;
> +}
> +
> +static bool fixed_ctr_is_allowed(uint8_t idx, uint32_t action, uint32_t bitmap)
> +{
> +	return (action == KVM_PMU_EVENT_ALLOW && (bitmap & BIT_ULL(idx))) ||
> +		(action == KVM_PMU_EVENT_DENY && !(bitmap & BIT_ULL(idx)));

This helper shouldn't exist.  It's largely a symptom of using an array.
> +}
> +
> +static void test_fixed_ctr_action_and_bitmap(struct kvm_vcpu *vcpu,
> +					     uint8_t fixed_ctr_idx,
> +					     uint8_t max_fixed_num)
> +{
> +	uint8_t i;
> +	uint32_t bitmap;
> +	uint64_t count;
> +	bool expected;
> +
> +	/*
> +	 * Check the fixed performance counter can count normally works when
> +	 * KVM userspace doesn't set any pmu filter.
> +	 */
> +	TEST_ASSERT(max_fixed_num && test_fixed_ctr_without_filter(vcpu),
> +		    "Fixed counter does not exist or does not work as expected.");
> +
> +	for (i = 0; i < ARRAY_SIZE(actions); i++) {
> +		for (bitmap = 0; bitmap < BIT_ULL(max_fixed_num); bitmap++) {

You're comparing a 32-bit value against a 64-bit value.

> +			expected = fixed_ctr_is_allowed(fixed_ctr_idx, actions[i], bitmap);
> +			count = test_fixed_ctr_with_filter(vcpu, actions[i], bitmap);
> +
> +			TEST_ASSERT(expected == !!count,
> +				    "Fixed event filter does not work as expected.");
> +		}
> +	}

static uint64_t test_with_fixed_counter_filter(struct kvm_vcpu *vcpu,
					       uint32_t action, uint32_t bitmap)
{
	...

}

static void __test_fixed_counter_bitmap(...)
{
	uint32_t bitmap;

	TEST_ASSERT(nr_fixed_counters < sizeof(bitmap));

	for (i = 0; i < BIT(nr_fixed_counters); i++) {
		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_ALLOW,
						       bitmap);
		TEST_ASSERT(!!count == !!(bitmap & BIT(idx)));

		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_DENY,
						       bitmap);
		TEST_ASSERT(!!count == !(bitmap & BIT(idx)));

	}
}

> +}
> +
> +static void test_fixed_counter_bitmap(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	uint8_t idx, max_fixed_num = get_kvm_supported_fixed_num();
> +
> +	/*
> +	 * Check that pmu_event_filter works as expected when it's applied to
> +	 * fixed performance counters.
> +	 */
> +	for (idx = 0; idx < max_fixed_num; idx++) {
> +		vcpu = new_vcpu(intel_guest_run_fixed_counters);
> +		vcpu_args_set(vcpu, 1, idx);
> +		test_fixed_ctr_action_and_bitmap(vcpu, idx, max_fixed_num);
> +		free_vcpu(vcpu);
> +	}
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	void (*guest_code)(void);
> @@ -860,6 +968,7 @@ int main(int argc, char *argv[])
>  	kvm_vm_free(vm);
>  
>  	test_pmu_config_disable(guest_code);
> +	test_fixed_counter_bitmap();
>  
>  	return 0;
>  }
> -- 
> 2.31.1
> 
