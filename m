Return-Path: <linux-kselftest+bounces-33939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0BAC6B1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 15:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173FB1BC6C3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707C288514;
	Wed, 28 May 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmRWKuBX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367E28643A
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440699; cv=none; b=GXCk8KyeKD0zVpLqlkSGhpCFCkfMT25dU0GLcurWki4vz7yNgUy111bPYT7La3ZP4CJhZ5a9hOMqCAojIRaXw71GmkIC84l8uaWLqK0Dbruc1xEDwCUXr55aKge+Kba8yy+c7sO+acn1sNGF0U40Vmj4Gi78osdNQwt7Q9AMZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440699; c=relaxed/simple;
	bh=d9/ar5v16RsbtX277WP290VgdFIsq/m2Gd1iupLMNYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJOf0OhH3Gaj38EYI8Ci/w9/HrECOjSecD2W5BERFSJ7Oig4MTSFuycWt56hme100fdZ5B7s9S60Pr5D7PJBf8QtJSAhhngUU9iGAxlh2KJkMJ3jlfMVIMPUvEr0d9upphD80qnT93H/xn5mO+9+YRI1fDR1DghE28dxjw6xTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmRWKuBX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748440696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHNl3ldABX8E7TPXyDDnG8CSbzly8EDwfMe7Y6Vc170=;
	b=UmRWKuBXVffePRXuMw52aDRKzX04StXbPaMaWhpNbBPhz8Aq+wFohLoS+cxXCkkvieA1hf
	LJ1DfHUGoZcmA+dJ0v8DWYS5VRM6Ps+oQFg1SvA04CYD9fJfid6fFpI9dgWoJwrvPp9OaL
	lhwKbTfRKSpuKkLAn/Me+hbtRXzPtP8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-scWHvWtbNg-YbI3cSY4CbA-1; Wed, 28 May 2025 09:58:13 -0400
X-MC-Unique: scWHvWtbNg-YbI3cSY4CbA-1
X-Mimecast-MFC-AGG-ID: scWHvWtbNg-YbI3cSY4CbA_1748440692
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450787c8626so4223305e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 06:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748440692; x=1749045492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHNl3ldABX8E7TPXyDDnG8CSbzly8EDwfMe7Y6Vc170=;
        b=Tf2mXxnCeNMhtpjQWV/eAa0v3Tq3L+5ob0xMSSC6sCz11ELQ9sCRwI/JJoTICZ1eW0
         MXxyJS16lqRmSg45ZfDi75Nr98tlIfKKcbdq2sW9g4LK4SvOBEf5oc3Li7TeB3XodStW
         R+1OQJpOnAKX86NcbRxmLnYSZJRmrWznzXOpFyFtt14OI0/KlwwoH4P/IVasMYEOfI11
         q3fV9KYBClkJMa5MtZjQBpNMqqBXkzz6QacF3318h1/tyIg1TGaNG8h78Agy3PfABauN
         zx2G3mIcxfKIvJSWRHKZb86VKqx1DF6Am7yJWMwZnyYEcOZAUwxwLnU0uo3T6J/zKbvx
         pcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX6KCYjl+h26ggbw4w0YzoHSGbh7qGvd3HlGeyvUHSI6ELnb7E2IZu2lMx0pepg8aOJk5WMje/BH6eyTwc6TM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpz5Vhec8ln23fGHKqByf/bKaD2KlKCG4iR88RQey8dD6clzUU
	mySmjZTFkaRx2Qllj7DSZnIW7LGgGKS5CXxM59Km2ySGozwZRi3Z3saOHraXEqebLDugkzKPkWG
	ZQqu8+tABqTDT/FI/CQKVPqzU+b4/pdZZ3kgJkg1Ge6YhLFr4WxAQoR0hw+M9P7iss5E0NA==
X-Gm-Gg: ASbGncu7HSGooKptIUPecUCixGBHg9kCuJ5sWG666GrIM7cnjmw/8Jnk2F9hdqq9/P+
	3c3SjW01B4cqY8IU2NBeEYQNBbH7un46XzXXKxDO/yHYJ3JI0RmZopQSLlB1kbCS4zpib1UBrUU
	8TpeN3lmwowFq3jFrjciMv05MtRYl09+HzzAsjSb0aJvkWMp8JjEwVqs5WeCYrzU4qnGLVieEES
	3lMiZPk19j4eQzDXkp/zKFjJ1rfDY6UogcNESifdorO9TI/vLwWCICmHAxc5FW/lj/tq7oW+u5U
	QvR7I213zPRjc85PrOPCUycGtw3T4VngVoo6R8WMMOa4w/go71NciQ==
X-Received: by 2002:a05:600c:8189:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-44c919e13f3mr144959655e9.11.1748440692157;
        Wed, 28 May 2025 06:58:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqzLEDkfQmQWWcPbXN4NNDgGddj948ymAUAzbar+s/KIa9aBEzkLArwvflMAWN7lKAl99o7w==
X-Received: by 2002:a05:600c:8189:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-44c919e13f3mr144959375e9.11.1748440691703;
        Wed, 28 May 2025 06:58:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4500e1de18dsm23518245e9.40.2025.05.28.06.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 06:58:11 -0700 (PDT)
Message-ID: <1e0250cd-e70e-45d9-92fc-1bf377ff835a@redhat.com>
Date: Wed, 28 May 2025 15:58:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/9] KVM: arm64: nv: selftests: Enable hypervisor
 timer tests to run in vEL2
Content-Language: en-US
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, seanjc@google.com,
 darren@os.amperecomputing.com
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
 <20250512105251.577874-4-gankulkarni@os.amperecomputing.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250512105251.577874-4-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ganapatrao,

On 5/12/25 12:52 PM, Ganapatrao Kulkarni wrote:
> Adding required changes to enable and test HVTIMER and HPTIMER
> in vEL2. In default case, PTIMER and VTIMER are validated and with
> NV enabled (with argument "-g 1"), HPTIMER and HVTIMER are validated
> by injecting respective timer interrupts.
> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>  tools/testing/selftests/kvm/arch_timer.c      |   8 +-
>  .../testing/selftests/kvm/arm64/arch_timer.c  | 118 +++++++++++++++---
>  .../selftests/kvm/include/arm64/arch_timer.h  |  16 +++
>  .../selftests/kvm/include/timer_test.h        |   1 +
>  4 files changed, 123 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
> index acb2cb596332..5c30bda0462b 100644
> --- a/tools/testing/selftests/kvm/arch_timer.c
> +++ b/tools/testing/selftests/kvm/arch_timer.c
> @@ -35,6 +35,7 @@ struct test_args test_args = {
>  	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
>  	.timer_err_margin_us = TIMER_TEST_ERR_MARGIN_US,
>  	.reserved = 1,
> +	.is_nested = false,
>  };
>  
>  struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
> @@ -43,6 +44,7 @@ struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
>  static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
>  static unsigned long *vcpu_done_map;
>  static pthread_mutex_t vcpu_done_map_lock;
> +bool is_nested;
>  
>  static void *test_vcpu_run(void *arg)
>  {
> @@ -193,6 +195,7 @@ static void test_print_help(char *name)
>  	pr_info("\t-o: Counter offset (in counter cycles, default: 0) [aarch64-only]\n");
>  	pr_info("\t-e: Interrupt arrival error margin (in us) of the guest timer (default: %u)\n",
>  		TIMER_TEST_ERR_MARGIN_US);
> +	pr_info("\t-g: Enable Nested Virtualization, run guest code as guest hypervisor (default: Disabled)\n");
I would recommend "default: 0" in all enhanced tests to clarify that 0/1
are the values to be used.

Thanks

Eric
>  	pr_info("\t-h: print this help screen\n");
>  }
>  
> @@ -200,7 +203,7 @@ static bool parse_args(int argc, char *argv[])
>  {
>  	int opt;
>  
> -	while ((opt = getopt(argc, argv, "hn:i:p:m:o:e:")) != -1) {
> +	while ((opt = getopt(argc, argv, "hn:i:p:m:o:e:g:")) != -1) {
>  		switch (opt) {
>  		case 'n':
>  			test_args.nr_vcpus = atoi_positive("Number of vCPUs", optarg);
> @@ -226,6 +229,9 @@ static bool parse_args(int argc, char *argv[])
>  			test_args.counter_offset = strtol(optarg, NULL, 0);
>  			test_args.reserved = 0;
>  			break;
> +		case 'g':
> +			test_args.is_nested = atoi_non_negative("Is Nested", optarg);
> +			break;
>  		case 'h':
>  		default:
>  			goto err;
> diff --git a/tools/testing/selftests/kvm/arm64/arch_timer.c b/tools/testing/selftests/kvm/arm64/arch_timer.c
> index eeba1cc87ff8..50bf05bb6f85 100644
> --- a/tools/testing/selftests/kvm/arm64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/arm64/arch_timer.c
> @@ -12,16 +12,22 @@
>  #include "timer_test.h"
>  #include "ucall_common.h"
>  #include "vgic.h"
> +#include <nv_util.h>
>  
>  enum guest_stage {
>  	GUEST_STAGE_VTIMER_CVAL = 1,
>  	GUEST_STAGE_VTIMER_TVAL,
>  	GUEST_STAGE_PTIMER_CVAL,
>  	GUEST_STAGE_PTIMER_TVAL,
> +	GUEST_STAGE_HVTIMER_CVAL,
> +	GUEST_STAGE_HVTIMER_TVAL,
> +	GUEST_STAGE_HPTIMER_CVAL,
> +	GUEST_STAGE_HPTIMER_TVAL,
>  	GUEST_STAGE_MAX,
>  };
>  
>  static int vtimer_irq, ptimer_irq;
> +static int hvtimer_irq, hptimer_irq;
>  
>  static void
>  guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
> @@ -47,6 +53,26 @@ guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
>  		shared_data->xcnt = timer_get_cntct(PHYSICAL);
>  		timer_set_ctl(PHYSICAL, CTL_ENABLE);
>  		break;
> +	case GUEST_STAGE_HVTIMER_CVAL:
> +		timer_set_next_cval_ms(HVIRTUAL, test_args.timer_period_ms);
> +		shared_data->xcnt = timer_get_cntct(HVIRTUAL);
> +		timer_set_ctl(HVIRTUAL, CTL_ENABLE);
> +		break;
> +	case GUEST_STAGE_HVTIMER_TVAL:
> +		timer_set_next_tval_ms(HVIRTUAL, test_args.timer_period_ms);
> +		shared_data->xcnt = timer_get_cntct(HVIRTUAL);
> +		timer_set_ctl(HVIRTUAL, CTL_ENABLE);
> +		break;
> +	case GUEST_STAGE_HPTIMER_CVAL:
> +		timer_set_next_cval_ms(HPHYSICAL, test_args.timer_period_ms);
> +		shared_data->xcnt = timer_get_cntct(HPHYSICAL);
> +		timer_set_ctl(HPHYSICAL, CTL_ENABLE);
> +		break;
> +	case GUEST_STAGE_HPTIMER_TVAL:
> +		timer_set_next_tval_ms(HPHYSICAL, test_args.timer_period_ms);
> +		shared_data->xcnt = timer_get_cntct(HPHYSICAL);
> +		timer_set_ctl(HPHYSICAL, CTL_ENABLE);
> +		break;
>  	default:
>  		GUEST_ASSERT(0);
>  	}
> @@ -75,6 +101,16 @@ static void guest_validate_irq(unsigned int intid,
>  		accessor = PHYSICAL;
>  		timer_irq = ptimer_irq;
>  		break;
> +	case GUEST_STAGE_HVTIMER_CVAL:
> +	case GUEST_STAGE_HVTIMER_TVAL:
> +		accessor = HVIRTUAL;
> +		timer_irq = hvtimer_irq;
> +		break;
> +	case GUEST_STAGE_HPTIMER_CVAL:
> +	case GUEST_STAGE_HPTIMER_TVAL:
> +		accessor = HPHYSICAL;
> +		timer_irq = hptimer_irq;
> +		break;
>  	default:
>  		GUEST_ASSERT(0);
>  		return;
> @@ -142,38 +178,79 @@ static void guest_code(void)
>  {
>  	uint32_t cpu = guest_get_vcpuid();
>  	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
> +	bool is_nested = false;
> +	enum arch_timer vtimer, ptimer;
> +	int vtmr_irq, ptmr_irq;
> +	enum guest_stage stage_vtimer_cval, stage_vtimer_tval;
> +	enum guest_stage stage_ptimer_cval, stage_ptimer_tval;
>  
> -	local_irq_disable();
> +	if (read_sysreg(CurrentEL) == CurrentEL_EL2)
> +		is_nested = true;
>  
> +	local_irq_disable();
>  	gic_init(GIC_V3, test_args.nr_vcpus);
>  
> -	timer_set_ctl(VIRTUAL, CTL_IMASK);
> -	timer_set_ctl(PHYSICAL, CTL_IMASK);
> +	if (is_nested) {
> +
> +		vtimer = HVIRTUAL;
> +		ptimer = HPHYSICAL;
> +		vtmr_irq = hvtimer_irq;
> +		ptmr_irq = hptimer_irq;
> +		stage_vtimer_cval = GUEST_STAGE_HVTIMER_CVAL;
> +		stage_vtimer_tval = GUEST_STAGE_HVTIMER_TVAL;
> +		stage_ptimer_cval = GUEST_STAGE_HPTIMER_CVAL;
> +		stage_ptimer_tval = GUEST_STAGE_HPTIMER_TVAL;
> +	} else {
> +		vtimer = VIRTUAL;
> +		ptimer = PHYSICAL;
> +		vtmr_irq = vtimer_irq;
> +		ptmr_irq = ptimer_irq;
> +		stage_vtimer_cval = GUEST_STAGE_VTIMER_CVAL;
> +		stage_vtimer_tval = GUEST_STAGE_VTIMER_TVAL;
> +		stage_ptimer_cval = GUEST_STAGE_PTIMER_CVAL;
> +		stage_ptimer_tval = GUEST_STAGE_PTIMER_TVAL;
> +	}
> +
> +	timer_set_ctl(vtimer, CTL_IMASK);
> +	timer_set_ctl(ptimer, CTL_IMASK);
> +	gic_irq_enable(vtmr_irq);
> +	gic_irq_enable(ptmr_irq);
>  
> -	gic_irq_enable(vtimer_irq);
> -	gic_irq_enable(ptimer_irq);
>  	local_irq_enable();
>  
> -	guest_run_stage(shared_data, GUEST_STAGE_VTIMER_CVAL);
> -	guest_run_stage(shared_data, GUEST_STAGE_VTIMER_TVAL);
> -	guest_run_stage(shared_data, GUEST_STAGE_PTIMER_CVAL);
> -	guest_run_stage(shared_data, GUEST_STAGE_PTIMER_TVAL);
> +	guest_run_stage(shared_data, stage_vtimer_cval);
> +	guest_run_stage(shared_data, stage_vtimer_tval);
> +	guest_run_stage(shared_data, stage_ptimer_cval);
> +	guest_run_stage(shared_data, stage_ptimer_tval);
>  
>  	GUEST_DONE();
>  }
>  
>  static void test_init_timer_irq(struct kvm_vm *vm)
>  {
> -	/* Timer initid should be same for all the vCPUs, so query only vCPU-0 */
> -	vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
> -			     KVM_ARM_VCPU_TIMER_IRQ_PTIMER, &ptimer_irq);
> -	vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
> -			     KVM_ARM_VCPU_TIMER_IRQ_VTIMER, &vtimer_irq);
>  
> -	sync_global_to_guest(vm, ptimer_irq);
> -	sync_global_to_guest(vm, vtimer_irq);
> -
> -	pr_debug("ptimer_irq: %d; vtimer_irq: %d\n", ptimer_irq, vtimer_irq);
> +	/* Timer initid should be same for all the vCPUs, so query only vCPU-0 */
> +	if (is_vcpu_nested(vcpus[0])) {
> +		vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
> +				KVM_ARM_VCPU_TIMER_IRQ_HPTIMER, &hptimer_irq);
> +		vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
> +				KVM_ARM_VCPU_TIMER_IRQ_HVTIMER, &hvtimer_irq);
> +
> +		sync_global_to_guest(vm, hptimer_irq);
> +		sync_global_to_guest(vm, hvtimer_irq);
> +
> +		pr_debug("hptimer_irq: %d; hvtimer_irq: %d\n", hptimer_irq, hvtimer_irq);
> +	} else {
> +		vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
> +				KVM_ARM_VCPU_TIMER_IRQ_PTIMER, &ptimer_irq);
> +		vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
> +				KVM_ARM_VCPU_TIMER_IRQ_VTIMER, &vtimer_irq);
> +
> +		sync_global_to_guest(vm, ptimer_irq);
> +		sync_global_to_guest(vm, vtimer_irq);
> +
> +		pr_debug("ptimer_irq: %d; vtimer_irq: %d\n", ptimer_irq, vtimer_irq);
> +	}
>  }
>  
>  static int gic_fd;
> @@ -184,7 +261,10 @@ struct kvm_vm *test_vm_create(void)
>  	unsigned int i;
>  	int nr_vcpus = test_args.nr_vcpus;
>  
> -	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> +	if (test_args.is_nested)
> +		vm = nv_vm_create_with_vcpus_gic(nr_vcpus, vcpus, NULL, guest_code);
> +	else
> +		vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
>  
>  	vm_init_descriptor_tables(vm);
>  	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
> diff --git a/tools/testing/selftests/kvm/include/arm64/arch_timer.h b/tools/testing/selftests/kvm/include/arm64/arch_timer.h
> index bf461de34785..82ba908fba8b 100644
> --- a/tools/testing/selftests/kvm/include/arm64/arch_timer.h
> +++ b/tools/testing/selftests/kvm/include/arm64/arch_timer.h
> @@ -11,6 +11,8 @@
>  enum arch_timer {
>  	VIRTUAL,
>  	PHYSICAL,
> +	HVIRTUAL,
> +	HPHYSICAL,
>  };
>  
>  #define CTL_ENABLE	(1 << 0)
> @@ -37,8 +39,10 @@ static inline uint64_t timer_get_cntct(enum arch_timer timer)
>  
>  	switch (timer) {
>  	case VIRTUAL:
> +	case HVIRTUAL:
>  		return read_sysreg(cntvct_el0);
>  	case PHYSICAL:
> +	case HPHYSICAL:
>  		return read_sysreg(cntpct_el0);
>  	default:
>  		GUEST_FAIL("Unexpected timer type = %u", timer);
> @@ -52,9 +56,11 @@ static inline void timer_set_cval(enum arch_timer timer, uint64_t cval)
>  {
>  	switch (timer) {
>  	case VIRTUAL:
> +	case HVIRTUAL:
>  		write_sysreg(cval, cntv_cval_el0);
>  		break;
>  	case PHYSICAL:
> +	case HPHYSICAL:
>  		write_sysreg(cval, cntp_cval_el0);
>  		break;
>  	default:
> @@ -68,8 +74,10 @@ static inline uint64_t timer_get_cval(enum arch_timer timer)
>  {
>  	switch (timer) {
>  	case VIRTUAL:
> +	case HVIRTUAL:
>  		return read_sysreg(cntv_cval_el0);
>  	case PHYSICAL:
> +	case HPHYSICAL:
>  		return read_sysreg(cntp_cval_el0);
>  	default:
>  		GUEST_FAIL("Unexpected timer type = %u", timer);
> @@ -83,9 +91,11 @@ static inline void timer_set_tval(enum arch_timer timer, int32_t tval)
>  {
>  	switch (timer) {
>  	case VIRTUAL:
> +	case HVIRTUAL:
>  		write_sysreg(tval, cntv_tval_el0);
>  		break;
>  	case PHYSICAL:
> +	case HPHYSICAL:
>  		write_sysreg(tval, cntp_tval_el0);
>  		break;
>  	default:
> @@ -100,8 +110,10 @@ static inline int32_t timer_get_tval(enum arch_timer timer)
>  	isb();
>  	switch (timer) {
>  	case VIRTUAL:
> +	case HVIRTUAL:
>  		return read_sysreg(cntv_tval_el0);
>  	case PHYSICAL:
> +	case HPHYSICAL:
>  		return read_sysreg(cntp_tval_el0);
>  	default:
>  		GUEST_FAIL("Could not get timer %d\n", timer);
> @@ -115,9 +127,11 @@ static inline void timer_set_ctl(enum arch_timer timer, uint32_t ctl)
>  {
>  	switch (timer) {
>  	case VIRTUAL:
> +	case HVIRTUAL:
>  		write_sysreg(ctl, cntv_ctl_el0);
>  		break;
>  	case PHYSICAL:
> +	case HPHYSICAL:
>  		write_sysreg(ctl, cntp_ctl_el0);
>  		break;
>  	default:
> @@ -131,8 +145,10 @@ static inline uint32_t timer_get_ctl(enum arch_timer timer)
>  {
>  	switch (timer) {
>  	case VIRTUAL:
> +	case HVIRTUAL:
>  		return read_sysreg(cntv_ctl_el0);
>  	case PHYSICAL:
> +	case HPHYSICAL:
>  		return read_sysreg(cntp_ctl_el0);
>  	default:
>  		GUEST_FAIL("Unexpected timer type = %u", timer);
> diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
> index 9b6edaafe6d4..95f61c4a8a80 100644
> --- a/tools/testing/selftests/kvm/include/timer_test.h
> +++ b/tools/testing/selftests/kvm/include/timer_test.h
> @@ -26,6 +26,7 @@ struct test_args {
>  	/* Members of struct kvm_arm_counter_offset */
>  	uint64_t counter_offset;
>  	uint64_t reserved;
> +	bool is_nested;
>  };
>  
>  /* Shared variables between host and guest */


