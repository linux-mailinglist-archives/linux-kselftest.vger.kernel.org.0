Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7AB758AC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 03:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGSBVS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 21:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSBVR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 21:21:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4D12F;
        Tue, 18 Jul 2023 18:21:15 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6862842a028so912597b3a.0;
        Tue, 18 Jul 2023 18:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689729675; x=1690334475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r98SwIuCR5wk/UZFxeuXqHCnCC/0/cUGmeyzvrJ3y8c=;
        b=onilTHiCvorh1QZPOIKwt3VUjJh9H3ifKDcHKb14k8+2ePGO62RRT/N7D992SR599Q
         g4ZukZanowJVtgp8NdBrr4PNb1EFg3XLAVWq+uL5+3IXXVOcHG7al5HpTzH8VIto5tZy
         BV/IF495RZ7RbrjbMWjmQGNuwZD67jefo1bkvhkfVxwnFw1gAtMHpiPo1uug6Zx0xzoV
         DoHbi+uB+iyVXwbjXxQKu55GaT3j1zznZDKIY8iOiG0eWzbgxAfpxl7Iuot3QX23cJjA
         yithyi7UJy1kQDLmMetgsqGYKqlTBpIApGn+uFwjD8JyTyt/RPTqopn8SMFE9KwezUXd
         BZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689729675; x=1690334475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r98SwIuCR5wk/UZFxeuXqHCnCC/0/cUGmeyzvrJ3y8c=;
        b=SOBNrMqjFzzWooTI3o55cIXN0rZ7vFhzDP7Pwd3XSVlhj+StyvU2ARUexTqECg398s
         0lOaHuMPjUoZPPbSHXArlDGD7rR1Q097mwqqbUskdvvBMeZ0WB06r1GbaCwjZE4YOB2d
         Y+iq7Xh6Z13IpD4R2TaIwUZIusOjAK8MThX2PyHl5i7ktKTSeBzcCOwztqzDT5WCRfw2
         1iMYeskrcDno244TDwOEwZAngxN2mqN2JnzUQ32TWtKS6+cjTwTKqGWRn3pIGXtGvDPM
         eu/T7PXOKW+ERnnxpw5kt0UP9gnuyByDqe3sijIS+daRZ2cDfEOX7bWiFAU7U9efJOiz
         0g6Q==
X-Gm-Message-State: ABy/qLY+uSt7wEcGSpnm0Q2nxsyed+SUA1zVx6Cn+IFpe5jpRO+nszAj
        Em2UPPFi9qykJVf92KPqW/E=
X-Google-Smtp-Source: APBJJlFhqPEfm4i/Ycj5uAgViqvEa8kf5bIHeNfwteCEyK5mzHmjNxRUyckE8ovegZsj1hy+Djb2Pg==
X-Received: by 2002:a05:6a00:1487:b0:67a:c810:3cb0 with SMTP id v7-20020a056a00148700b0067ac8103cb0mr1451882pfu.3.1689729675004;
        Tue, 18 Jul 2023 18:21:15 -0700 (PDT)
Received: from localhost ([192.55.54.50])
        by smtp.gmail.com with ESMTPSA id i5-20020aa787c5000000b0067aea93af40sm2109331pfo.2.2023.07.18.18.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 18:21:14 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:21:13 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH v4 5/6] KVM: selftests: Test if event filter meets
 expectations on fixed counters
Message-ID: <20230719012113.GE25699@ls.amr.corp.intel.com>
References: <20230717062343.3743-1-cloudliang@tencent.com>
 <20230717062343.3743-6-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230717062343.3743-6-cloudliang@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 17, 2023 at 02:23:42PM +0800,
Jinrong Liang <ljr.kernel@gmail.com> wrote:

> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add tests to cover that pmu event_filter works as expected when
> it's applied to fixed performance counters, even if there is none
> fixed counter exists (e.g. Intel guest pmu version=1 or AMD guest).
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../kvm/x86_64/pmu_event_filter_test.c        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index 63f85f583ef8..1872b848f734 100644
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
> @@ -805,6 +806,84 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
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
> +	TEST_ASSERT(nr_fixed_counters < sizeof(bitmap),

sizeof(bitmap) * 8?

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
> +		ASSERT_EQ(!!count, !!(bitmap & BIT(idx)));
> +
> +		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_DENY,
> +						       bitmap);
> +		ASSERT_EQ(!!count, !(bitmap & BIT(idx)));
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
> @@ -848,6 +927,7 @@ int main(int argc, char *argv[])
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

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
