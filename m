Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8E77C44D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 02:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjHOAHg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 20:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjHOAHM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 20:07:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAA511D;
        Mon, 14 Aug 2023 17:07:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f94328a4so3286431b3a.0;
        Mon, 14 Aug 2023 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692058031; x=1692662831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIkO9a2jx/LlcIe91jov+x/hrsKTSsxrVnvfV3qLu+w=;
        b=GleBOZnWm/4yptsct23xsWjRl4FmSulENc/8ZCpakFczYeyJqmTxIFNMW1tLipddtY
         eWR5kiIvSgpNkCmhejg+qHKhPhJqcFQhiYlZ8c1mxQkAdYiVj6Bd96HwY5t2hxReaUeq
         9hoylNEjBCACtDHMQ2osjWF70brtY8F8Hab0e1dtmd53DVLemXgJ8dlDpktyaCQUdJte
         yNc0jfSq47W1cyst01Atin9BDyXcgPh/QYMdNsStjVW/17kG3N/8zhDk+EHjhlBtyi6l
         AqyzDOT62NkWBe4R+rL3wACWUDZyZQAcbE4NWGlLNNOH6+SJi5QXHnN820Y3MWpM2IXD
         ijTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692058031; x=1692662831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIkO9a2jx/LlcIe91jov+x/hrsKTSsxrVnvfV3qLu+w=;
        b=BWVEqzhnponrY4j+9vOQgUf2ujV9jD1WxasM0AqdqgTSClfjE6IAyMSbwvmssCwDIb
         ebFLunZQG74Mgfi+4DlYJxPS3BtN6khQK6WgCoedaNUQUYPivdI9TzmpCLB7PIEpkScx
         KUoHCKEMtQDGJ4wZo+rGuCuek83OFv1FBvJhxjRTnij2hJn18kbJQyOWoS+5DSKqaYf7
         6qYSOeTIkOKbRlsrnyOyM2Rivom+IdpvpcZIpxSZMeUIqxKNV67ptnIReQLdIXWK2Ihz
         L8C9eevjGl5+B6msC+7ZdWoIgeqJ+1QWuDDJZ5JsQU2CI3/IfJc8AlmrmQwElrMdgRsD
         ecew==
X-Gm-Message-State: AOJu0YxCNIVg9BQbR/xHikTqziCpXcv5MSYfu7U1Ae8lRoYwFPNnhMxp
        tHhOJaORuBQDi1R4kfuI7uA=
X-Google-Smtp-Source: AGHT+IGU7QGcBGqL3dCBGP1LyC3Q0ee0fldrfLMzjbNXgAKf3o2g6U6D1VZCeDPwZDXUI5Sk5awGOw==
X-Received: by 2002:a05:6a00:15d0:b0:684:bb4a:b86e with SMTP id o16-20020a056a0015d000b00684bb4ab86emr661716pfu.1.1692058031125;
        Mon, 14 Aug 2023 17:07:11 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7838a000000b00686f0b15b06sm8455293pfm.188.2023.08.14.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:07:10 -0700 (PDT)
Date:   Mon, 14 Aug 2023 17:07:09 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com
Subject: Re: [PATCH v6 5/6] KVM: selftests: Test if event filter meets
 expectations on fixed counters
Message-ID: <20230815000709.GF2257301@ls.amr.corp.intel.com>
References: <20230810090945.16053-1-cloudliang@tencent.com>
 <20230810090945.16053-6-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810090945.16053-6-cloudliang@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 05:09:44PM +0800,
Jinrong Liang <ljr.kernel@gmail.com> wrote:

> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add tests to cover that pmu event_filter works as expected when it's
> applied to fixed performance counters, even if there is none fixed
> counter exists (e.g. Intel guest pmu version=1 or AMD guest).
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../kvm/x86_64/pmu_event_filter_test.c        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index 8b8bfee11016..732c76c41bb0 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -27,6 +27,7 @@
>  #define ARCH_PERFMON_BRANCHES_RETIRED		5
>  
>  #define NUM_BRANCHES 42
> +#define INTEL_PMC_IDX_FIXED		32
>  
>  /* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
>  #define MAX_FILTER_EVENTS		300
> @@ -808,6 +809,84 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
>  	TEST_ASSERT(!r, "Masking non-existent fixed counters should be allowed");
>  }
>  
> +static void intel_run_fixed_counter_guest_code(uint8_t fixed_ctr_idx)
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
> +static uint64_t test_with_fixed_counter_filter(struct kvm_vcpu *vcpu,
> +					       uint32_t action, uint32_t bitmap)
> +{
> +	struct __kvm_pmu_event_filter f = {
> +		.action = action,
> +		.fixed_counter_bitmap = bitmap,
> +	};
> +	do_vcpu_set_pmu_event_filter(vcpu, &f);
> +
> +	return run_vcpu_to_sync(vcpu);
> +}
> +
> +static void __test_fixed_counter_bitmap(struct kvm_vcpu *vcpu, uint8_t idx,
> +					uint8_t nr_fixed_counters)
> +{
> +	unsigned int i;
> +	uint32_t bitmap;
> +	uint64_t count;
> +
> +	TEST_ASSERT(nr_fixed_counters < sizeof(bitmap) * 8,
> +		    "Invalid nr_fixed_counters");
> +
> +	/*
> +	 * Check the fixed performance counter can count normally when KVM
> +	 * userspace doesn't set any pmu filter.
> +	 */
> +	count = run_vcpu_to_sync(vcpu);
> +	TEST_ASSERT(count, "Unexpected count value: %ld\n", count);
> +
> +	for (i = 0; i < BIT(nr_fixed_counters); i++) {
> +		bitmap = BIT(i);
> +		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_ALLOW,
> +						       bitmap);
> +		TEST_ASSERT_EQ(!!count, !!(bitmap & BIT(idx)));
> +
> +		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_DENY,
> +						       bitmap);
> +		TEST_ASSERT_EQ(!!count, !(bitmap & BIT(idx)));
> +	}
> +}
> +
> +static void test_fixed_counter_bitmap(void)
> +{
> +	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	uint8_t idx;
> +
> +	/*
> +	 * Check that pmu_event_filter works as expected when it's applied to
> +	 * fixed performance counters.
> +	 */
> +	for (idx = 0; idx < nr_fixed_counters; idx++) {
> +		vm = vm_create_with_one_vcpu(&vcpu,
> +					     intel_run_fixed_counter_guest_code);
> +		vcpu_args_set(vcpu, 1, idx);
> +		__test_fixed_counter_bitmap(vcpu, idx, nr_fixed_counters);
> +		kvm_vm_free(vm);
> +	}
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	void (*guest_code)(void);
> @@ -851,6 +930,7 @@ int main(int argc, char *argv[])
>  	kvm_vm_free(vm);
>  
>  	test_pmu_config_disable(guest_code);
> +	test_fixed_counter_bitmap();
>  
>  	return 0;
>  }
> -- 
> 2.39.3
> 

Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
