Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C07785C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 05:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjHKDJ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 23:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjHKDJz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 23:09:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D462713;
        Thu, 10 Aug 2023 20:09:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-686f090310dso1410257b3a.0;
        Thu, 10 Aug 2023 20:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691723394; x=1692328194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7v9ATlvJItnxgfekA1+8W47vsSU2TAf/TbFNkm3ohI=;
        b=oxkqZHhs1TipWG5MZgAaKSN27S0zC06JU8YIgEOe4238VqMsBf0JSwGqWnKDwA6jaO
         IgebfPxcaV/KLwbH+1G6WonWSeY2+xKbzn7QVQT8ZwSl/gca6WU7HwT3QN8nk9qyDUbM
         IWjv6YUBTSSvWoWQBE1xXL5Sct1m4eu++IVWZaXE0dJbam6Vpn1VhMdCU/4AbjICcAvp
         CII6r5IWsYGN1v8HdWjuH2e6aoGsbnKVwtjyJOn6gDtpGA16SdUi1GM/H6kEdXTF8Fqo
         ZxfYQCK7Vqud36A2FrG96SJBugbaDUdcgMllPdWCgndnwP6p37ysciW0LcBWJ8V86Vnh
         0ARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691723394; x=1692328194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H7v9ATlvJItnxgfekA1+8W47vsSU2TAf/TbFNkm3ohI=;
        b=NKfUDeG4OwJLA/BcnD8y90tf4RrqVqtSKKbRZezr9PzLfWINBCVO2k/0CnD687KDOu
         HITHron/Cg0ul+EHxlYjnd8COV2pvxAEJZFt0ftPiajtvurGBFCOSMIdjD3Ye6ajbPoa
         53kkaGn5NKIp/ECjs6NsUhSGUnSLz8ALVo8+qA3KmzR8VmzfnOQaHMbtP8vdIJGou1YX
         4PhWOP5Qx2i2BRM0EmxgPnsFMIEqJUxufCOMqfR+yLuLQdSnI37BYnUD3obysD2hjVIV
         hWWk+OJb+qg06I3RqGeESGvduyYcDsydqEhgurCR/GIBX8vgQUjq2GcrkJR7jb/hM44Z
         PTVw==
X-Gm-Message-State: AOJu0Yw7J0i1hpC9hdBN3WjlLqGTLtxiP4ZZmpvNNEKgIpisSQoYfUgc
        HIbJBSVnJPKjzZOL7L0OvQ0=
X-Google-Smtp-Source: AGHT+IH6Bn21/MuKGn2bv4+t/HN50FqxoPXGvAvfwWapW2Eo7RUXPrRZGQP7vE5QC5PGEpequh1ctw==
X-Received: by 2002:a05:6a20:9707:b0:137:5d1c:d087 with SMTP id hr7-20020a056a20970700b001375d1cd087mr951947pzc.4.1691723394045;
        Thu, 10 Aug 2023 20:09:54 -0700 (PDT)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id a14-20020a62bd0e000000b0068732995941sm2250177pff.79.2023.08.10.20.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 20:09:53 -0700 (PDT)
Message-ID: <853bac52-94e9-882c-c71b-ad6ae5f9c067@gmail.com>
Date:   Fri, 11 Aug 2023 11:09:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v6 3/6] KVM: selftests: Introduce __kvm_pmu_event_filter
 to improved event filter settings
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinrong Liang <cloudliang@tencent.com>
References: <20230810090945.16053-1-cloudliang@tencent.com>
 <20230810090945.16053-4-cloudliang@tencent.com>
From:   JinrongLiang <ljr.kernel@gmail.com>
In-Reply-To: <20230810090945.16053-4-cloudliang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

在 2023/8/10 17:09, Jinrong Liang 写道:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add custom "__kvm_pmu_event_filter" structure to improve pmu event
> filter settings. Simplifies event filter setup by organizing event
> filter parameters in a cleaner, more organized way.

I apologize for the oversight in this patch submission. I forgot to 
include the "Reviewed-by" tag. Please find the updated information below:

Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>

When reviewing the patch, please take this tag into account.

> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>   .../kvm/x86_64/pmu_event_filter_test.c        | 182 +++++++++---------
>   1 file changed, 90 insertions(+), 92 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index 5ac05e64bec9..94f5a89aac40 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -28,6 +28,10 @@
>   
>   #define NUM_BRANCHES 42
>   
> +/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
> +#define MAX_FILTER_EVENTS		300
> +#define MAX_TEST_EVENTS		10
> +
>   /*
>    * This is how the event selector and unit mask are stored in an AMD
>    * core performance event-select register. Intel's format is similar,
> @@ -69,21 +73,33 @@
>   
>   #define INST_RETIRED EVENT(0xc0, 0)
>   
> +struct __kvm_pmu_event_filter {
> +	__u32 action;
> +	__u32 nevents;
> +	__u32 fixed_counter_bitmap;
> +	__u32 flags;
> +	__u32 pad[4];
> +	__u64 events[MAX_FILTER_EVENTS];
> +};
> +
>   /*
>    * This event list comprises Intel's eight architectural events plus
>    * AMD's "retired branch instructions" for Zen[123] (and possibly
>    * other AMD CPUs).
>    */
> -static const uint64_t event_list[] = {
> -	EVENT(0x3c, 0),
> -	INST_RETIRED,
> -	EVENT(0x3c, 1),
> -	EVENT(0x2e, 0x4f),
> -	EVENT(0x2e, 0x41),
> -	EVENT(0xc4, 0),
> -	EVENT(0xc5, 0),
> -	EVENT(0xa4, 1),
> -	AMD_ZEN_BR_RETIRED,
> +static const struct __kvm_pmu_event_filter base_event_filter = {
> +	.nevents = ARRAY_SIZE(base_event_filter.events),
> +	.events = {
> +		EVENT(0x3c, 0),
> +		INST_RETIRED,
> +		EVENT(0x3c, 1),
> +		EVENT(0x2e, 0x4f),
> +		EVENT(0x2e, 0x41),
> +		EVENT(0xc4, 0),
> +		EVENT(0xc5, 0),
> +		EVENT(0xa4, 1),
> +		AMD_ZEN_BR_RETIRED,
> +	},
>   };
>   
>   struct {
> @@ -225,47 +241,11 @@ static bool sanity_check_pmu(struct kvm_vcpu *vcpu)
>   	return !r;
>   }
>   
> -static struct kvm_pmu_event_filter *alloc_pmu_event_filter(uint32_t nevents)
> -{
> -	struct kvm_pmu_event_filter *f;
> -	int size = sizeof(*f) + nevents * sizeof(f->events[0]);
> -
> -	f = malloc(size);
> -	TEST_ASSERT(f, "Out of memory");
> -	memset(f, 0, size);
> -	f->nevents = nevents;
> -	return f;
> -}
> -
> -
> -static struct kvm_pmu_event_filter *
> -create_pmu_event_filter(const uint64_t event_list[], int nevents,
> -			uint32_t action, uint32_t flags)
> -{
> -	struct kvm_pmu_event_filter *f;
> -	int i;
> -
> -	f = alloc_pmu_event_filter(nevents);
> -	f->action = action;
> -	f->flags = flags;
> -	for (i = 0; i < nevents; i++)
> -		f->events[i] = event_list[i];
> -
> -	return f;
> -}
> -
> -static struct kvm_pmu_event_filter *event_filter(uint32_t action)
> -{
> -	return create_pmu_event_filter(event_list,
> -				       ARRAY_SIZE(event_list),
> -				       action, 0);
> -}
> -
>   /*
>    * Remove the first occurrence of 'event' (if any) from the filter's
>    * event list.
>    */
> -static void remove_event(struct kvm_pmu_event_filter *f, uint64_t event)
> +static void remove_event(struct __kvm_pmu_event_filter *f, uint64_t event)
>   {
>   	bool found = false;
>   	int i;
> @@ -313,66 +293,73 @@ static void test_without_filter(struct kvm_vcpu *vcpu)
>   }
>   
>   static void test_with_filter(struct kvm_vcpu *vcpu,
> -			     struct kvm_pmu_event_filter *f)
> +			     struct __kvm_pmu_event_filter *__f)
>   {
> +	struct kvm_pmu_event_filter *f = (void *)__f;
> +
>   	vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
>   	run_vcpu_and_sync_pmc_results(vcpu);
>   }
>   
>   static void test_amd_deny_list(struct kvm_vcpu *vcpu)
>   {
> -	uint64_t event = EVENT(0x1C2, 0);
> -	struct kvm_pmu_event_filter *f;
> +	struct __kvm_pmu_event_filter f = {
> +		.action = KVM_PMU_EVENT_DENY,
> +		.nevents = 1,
> +		.events = {
> +			EVENT(0x1C2, 0),
> +		},
> +	};
>   
> -	f = create_pmu_event_filter(&event, 1, KVM_PMU_EVENT_DENY, 0);
> -	test_with_filter(vcpu, f);
> -	free(f);
> +	test_with_filter(vcpu, &f);
>   
>   	ASSERT_PMC_COUNTING_INSTRUCTIONS();
>   }
>   
>   static void test_member_deny_list(struct kvm_vcpu *vcpu)
>   {
> -	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_DENY);
> +	struct __kvm_pmu_event_filter f = base_event_filter;
>   
> -	test_with_filter(vcpu, f);
> -	free(f);
> +	f.action = KVM_PMU_EVENT_DENY;
> +	test_with_filter(vcpu, &f);
>   
>   	ASSERT_PMC_NOT_COUNTING_INSTRUCTIONS();
>   }
>   
>   static void test_member_allow_list(struct kvm_vcpu *vcpu)
>   {
> -	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_ALLOW);
> +	struct __kvm_pmu_event_filter f = base_event_filter;
>   
> -	test_with_filter(vcpu, f);
> -	free(f);
> +	f.action = KVM_PMU_EVENT_ALLOW;
> +	test_with_filter(vcpu, &f);
>   
>   	ASSERT_PMC_COUNTING_INSTRUCTIONS();
>   }
>   
>   static void test_not_member_deny_list(struct kvm_vcpu *vcpu)
>   {
> -	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_DENY);
> +	struct __kvm_pmu_event_filter f = base_event_filter;
>   
> -	remove_event(f, INST_RETIRED);
> -	remove_event(f, INTEL_BR_RETIRED);
> -	remove_event(f, AMD_ZEN_BR_RETIRED);
> -	test_with_filter(vcpu, f);
> -	free(f);
> +	f.action = KVM_PMU_EVENT_DENY;
> +
> +	remove_event(&f, INST_RETIRED);
> +	remove_event(&f, INTEL_BR_RETIRED);
> +	remove_event(&f, AMD_ZEN_BR_RETIRED);
> +	test_with_filter(vcpu, &f);
>   
>   	ASSERT_PMC_COUNTING_INSTRUCTIONS();
>   }
>   
>   static void test_not_member_allow_list(struct kvm_vcpu *vcpu)
>   {
> -	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_ALLOW);
> +	struct __kvm_pmu_event_filter f = base_event_filter;
> +
> +	f.action = KVM_PMU_EVENT_ALLOW;
>   
> -	remove_event(f, INST_RETIRED);
> -	remove_event(f, INTEL_BR_RETIRED);
> -	remove_event(f, AMD_ZEN_BR_RETIRED);
> -	test_with_filter(vcpu, f);
> -	free(f);
> +	remove_event(&f, INST_RETIRED);
> +	remove_event(&f, INTEL_BR_RETIRED);
> +	remove_event(&f, AMD_ZEN_BR_RETIRED);
> +	test_with_filter(vcpu, &f);
>   
>   	ASSERT_PMC_NOT_COUNTING_INSTRUCTIONS();
>   }
> @@ -567,19 +554,16 @@ static void run_masked_events_test(struct kvm_vcpu *vcpu,
>   				   const uint64_t masked_events[],
>   				   const int nmasked_events)
>   {
> -	struct kvm_pmu_event_filter *f;
> +	struct __kvm_pmu_event_filter f = {
> +		.nevents = nmasked_events,
> +		.action = KVM_PMU_EVENT_ALLOW,
> +		.flags = KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
> +	};
>   
> -	f = create_pmu_event_filter(masked_events, nmasked_events,
> -				    KVM_PMU_EVENT_ALLOW,
> -				    KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
> -	test_with_filter(vcpu, f);
> -	free(f);
> +	memcpy(f.events, masked_events, sizeof(uint64_t) * nmasked_events);
> +	test_with_filter(vcpu, &f);
>   }
>   
> -/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
> -#define MAX_FILTER_EVENTS	300
> -#define MAX_TEST_EVENTS		10
> -
>   #define ALLOW_LOADS		BIT(0)
>   #define ALLOW_STORES		BIT(1)
>   #define ALLOW_LOADS_STORES	BIT(2)
> @@ -751,17 +735,27 @@ static void test_masked_events(struct kvm_vcpu *vcpu)
>   	run_masked_events_tests(vcpu, events, nevents);
>   }
>   
> -static int run_filter_test(struct kvm_vcpu *vcpu, const uint64_t *events,
> -			   int nevents, uint32_t flags)
> +static int do_vcpu_set_pmu_event_filter(struct kvm_vcpu *vcpu,
> +					struct __kvm_pmu_event_filter *__f)
>   {
> -	struct kvm_pmu_event_filter *f;
> -	int r;
> +	struct kvm_pmu_event_filter *f = (void *)__f;
>   
> -	f = create_pmu_event_filter(events, nevents, KVM_PMU_EVENT_ALLOW, flags);
> -	r = __vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
> -	free(f);
> +	return __vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
> +}
> +
> +static int set_pmu_single_event_filter(struct kvm_vcpu *vcpu, uint64_t event,
> +				       uint32_t flags, uint32_t action)
> +{
> +	struct __kvm_pmu_event_filter f = {
> +		.nevents = 1,
> +		.flags = flags,
> +		.action = action,
> +		.events = {
> +			event,
> +		},
> +	};
>   
> -	return r;
> +	return do_vcpu_set_pmu_event_filter(vcpu, &f);
>   }
>   
>   static void test_filter_ioctl(struct kvm_vcpu *vcpu)
> @@ -773,14 +767,18 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
>   	 * Unfortunately having invalid bits set in event data is expected to
>   	 * pass when flags == 0 (bits other than eventsel+umask).
>   	 */
> -	r = run_filter_test(vcpu, &e, 1, 0);
> +	r = set_pmu_single_event_filter(vcpu, e, 0, KVM_PMU_EVENT_ALLOW);
>   	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
>   
> -	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
> +	r = set_pmu_single_event_filter(vcpu, e,
> +					KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
> +					KVM_PMU_EVENT_ALLOW);
>   	TEST_ASSERT(r != 0, "Invalid PMU Event Filter is expected to fail");
>   
>   	e = KVM_PMU_ENCODE_MASKED_ENTRY(0xff, 0xff, 0xff, 0xf);
> -	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
> +	r = set_pmu_single_event_filter(vcpu, e,
> +					KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
> +					KVM_PMU_EVENT_ALLOW);
>   	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
>   }
>   

