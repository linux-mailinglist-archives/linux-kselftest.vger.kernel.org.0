Return-Path: <linux-kselftest+bounces-24075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66725A064EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55465166B7B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 18:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D3F200BAA;
	Wed,  8 Jan 2025 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5eZ4TbQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DB38DD1
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736362458; cv=none; b=Gzp6r6Stf1tr2VR+c+MUFSk93skSIu6HUqYvfQmL7f6iiBfiPFyU8fA31JWrWYqrT5w7NOskhZ15TCp/2vpfKI3I0nvd93qPWWeei1SZISe3wQk/GhvOYRxFKzJC/ItHCBQGa44P+Wutvai3rCKsjphE5BtO0ay1eXwXk1OIbYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736362458; c=relaxed/simple;
	bh=AcVycJIocmS3y50l07pvSeJqPJHazZxtgt2mtF6OBDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DE4Y16SVAa2XxBBqTQ4FZxoyjYWzatFEdeCrZTys1pioRQvhC/UhenB1xnZebMuuMW3SqehXLcEc/m8xrQOwjwhmtQb3w5sS8Qu91jmYyV/tGftKbIIUyhywzifCZVHGibejLH9XvvPdUDKfNA6XxGjsl7ma84Ys4yathuUeydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5eZ4TbQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216750b679eso576055ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 10:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736362456; x=1736967256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNYwFqiLmIGAf+fusGGqqOFq5iSUUqWqbZflZR0K0F8=;
        b=R5eZ4TbQjshqq705eWc43ugS9UGmDtItJfU6SRId77v/l1BOMMz8hQsAJ70AcvfKah
         DPUxSlvqNVbTNSmMmeHS9DM4b9D8E3isCHFxW7U4FXIOyBle4czX26SkST+rCOYDrzk0
         friOxGgVG/NFlgy/Hh9IwS8P484NYkwv6u4p6xAJZ31Caq2y9GcQKgxLu0nx/lkix9ZP
         g8ICZwLAjtw1/4p6Yt0y5onwSSpAkVhqKDATdYDU8nKXVVTba6d0STscMBdp+wxmwFZy
         B5d3+7MQIV516ub1jwUnhvDKSL52uXj1lQVlGnnvPD2tUNa4JNyBRh+LwEculDAz/IGz
         UxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736362456; x=1736967256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNYwFqiLmIGAf+fusGGqqOFq5iSUUqWqbZflZR0K0F8=;
        b=dBdKlX6+RZ+B6AgvcUODMAumvlEqm6YxBVBzYCCZg0iy4nBqMiCDrmqwQP9MtXsjNY
         xv1U4KOB3Axrq4F4kEn/YGdDyVVYK1IVXmDn3XklYt/5QBfqjcij0ryhNP0m0SsFt7K7
         enk6hQkkEi9u9tZ8C257lH8KRsMAJebI2r7nVoq6nOz+6nlyUleGDqjZCFTdOtFhD/9Y
         AHhMmSldDBcBHX4gqtjvMlBra6elqnc5ezPwU3Hlk8qcG9e6IK2/kL28uUdzKNkWffuL
         q4SE85yPAqYm2ZXKDLHeC/ZmvNQbqMTi1sOPdA92a+OOL700rsSUUyYdBEEIxBVTQMZN
         Ln3g==
X-Forwarded-Encrypted: i=1; AJvYcCXD2SqTInLGp8g4TADs2AbO3IAt3+e0HVSxhNJWMPtDU6o+2hARP5VSzIvIJBjLPumg9Eg/T43FGkSunz+iQCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyj1+fJyy+i8aqh7EJ/oUtgSMF2ZFQEuwnjedX1i3oDIgkjfUA
	5rUNwJ7+Y/85ROUOJjH3lD9S0l413DRnL9fGMeVRhncymNo5w1BLU3e4CqYPn3/zKMGXZWwtr7Z
	Uow==
X-Google-Smtp-Source: AGHT+IHnxAFvFj+MGeqlu1xSXDBMWH63mKHYA6+8mB/CLGdjPoIwLmG8Yu0pqxb54p9+diw19jhP45w5mlI=
X-Received: from pghm1.prod.google.com ([2002:a63:f601:0:b0:7fd:de44:ec7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230c:b0:208:d856:dbb7
 with SMTP id d9443c01a7336-21a83fe460bmr55071765ad.39.1736362456204; Wed, 08
 Jan 2025 10:54:16 -0800 (PST)
Date: Wed, 8 Jan 2025 10:54:14 -0800
In-Reply-To: <20240918205319.3517569-5-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com> <20240918205319.3517569-5-coltonlewis@google.com>
Message-ID: <Z37J1jJCTBZk-0cs@google.com>
Subject: Re: [PATCH v2 4/6] KVM: x86: selftests: Test read/write core counters
From: Sean Christopherson <seanjc@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Jinrong Liang <ljr.kernel@gmail.com>, Jim Mattson <jmattson@google.com>, 
	Aaron Lewis <aaronlewis@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 18, 2024, Colton Lewis wrote:
> Run a basic test to ensure we can write an arbitrary value to the core
> counters and read it back.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  .../selftests/kvm/x86_64/pmu_counters_test.c  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 5b240585edc5..79ca7d608e00 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -641,11 +641,65 @@ static uint8_t nr_core_counters(void)
>  		return AMD_NR_CORE_EXT_COUNTERS;
>  
>  	return AMD_NR_CORE_COUNTERS;
> +}
> +
> +static uint8_t guest_nr_core_counters(void)
> +{
> +	uint8_t nr_counters = this_cpu_property(X86_PROPERTY_NUM_PERF_CTR_CORE);
> +	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);

For both this and nr_core_counters(), there's no need to read PERF_CTR_EXT_CORE
if nr_counters is non-zero, and then no need to capture it in a local variable.
> +
> +	if (nr_counters != 0)
> +		return nr_counters;
> +
> +	if (core_ext)
> +		return AMD_NR_CORE_EXT_COUNTERS;
> +
> +	return AMD_NR_CORE_COUNTERS;

This is *painfully* similar to nr_core_counters().  It actually took me almost
a minute of staring to see the difference.  One option would be to add a helper
to dedup the if-statements, but while somewhat gross, I actually think a macro
is the way to go.

#define nr_core_counters(scope)								\
({											\
	uint8_t nr_counters = scope##_cpu_property(X86_PROPERTY_NR_PERFCTR_CORE);	\
											\
	if (!nr_counters) {								\
		if (scope##_cpu_has(X86_FEATURE_PERFCTR_CORE))				\
			nr_counters = AMD_NR_CORE_EXT_COUNTERS;				\
		else									\
			nr_counters = AMD_NR_CORE_COUNTERS;				\
	}										\
	nr_counters;									\
})

static uint8_t kvm_nr_core_counters(void)
{
	return nr_core_counters(kvm);
}

static uint8_t guest_nr_core_counters(void)
{
	return nr_core_counters(this);

}

> +

Unnecessary newline.

> +}
>  
> +static void guest_test_rdwr_core_counters(void)
> +{
> +	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
> +	uint8_t nr_counters = guest_nr_core_counters();
> +	uint8_t i;
> +	uint32_t esel_msr_base = core_ext ? MSR_F15H_PERF_CTL : MSR_K7_EVNTSEL0;

Please don't concoct new abbreviations.  "esel" isn't used anywhere in KVM, and
AFAICT it's not used in perf either.

I would also prefer to have consistent naming between the Intel and AMD tests
(the Intel test uses base_<name>_msr).

base_eventsel_msr is all of four characters more.

> +	uint32_t cnt_msr_base = core_ext ? MSR_F15H_PERF_CTR : MSR_K7_PERFCTR0;

For better or worse, the Intel version uses "base_pmc_msr".  I see no reason to
diverage from that.


> +	uint32_t msr_step = core_ext ? 2 : 1;
> +
> +	for (i = 0; i < AMD_NR_CORE_EXT_COUNTERS; i++) {
> +		uint64_t test_val = 0xffff;
> +		uint32_t esel_msr = esel_msr_base + msr_step * i;
> +		uint32_t cnt_msr = cnt_msr_base + msr_step * i;

And then
		uint32_t eventsel_msr = ...;
		uint32_t pmc_msr = ...;

> +		bool expect_gp = !(i < nr_counters);

Uh, isn't that just a weird way of writing:

		bool expect_gp = i >= nr_counters;

> +		uint8_t vector;
> +		uint64_t val;
> +
> +		/* Test event selection register. */

This is pretty obvious if the MSR is named eventsel_msr. 

> +		vector = wrmsr_safe(esel_msr, test_val);
> +		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, esel_msr, expect_gp, vector);
> +
> +		vector = rdmsr_safe(esel_msr, &val);
> +		GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, esel_msr, expect_gp, vector);
> +
> +		if (!expect_gp)
> +			GUEST_ASSERT_PMC_VALUE(RDMSR, esel_msr, val, test_val);
> +
> +		/* Test counter register. */

Same thing here.  If there is novel information/behavior, then by all means add
a comment.

> +		vector = wrmsr_safe(cnt_msr, test_val);
> +		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, cnt_msr, expect_gp, vector);
> +
> +		vector = rdmsr_safe(cnt_msr, &val);
> +		GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, cnt_msr, expect_gp, vector);
> +
> +		if (!expect_gp)
> +			GUEST_ASSERT_PMC_VALUE(RDMSR, cnt_msr, val, test_val);
> +	}
>  }
>  
>  static void guest_test_core_counters(void)
>  {
> +	guest_test_rdwr_core_counters();
>  	GUEST_DONE();
>  }
>  
> -- 
> 2.46.0.662.g92d0881bb0-goog
> 

