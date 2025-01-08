Return-Path: <linux-kselftest+bounces-24077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386FA06561
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830B83A26FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55B61AA1D9;
	Wed,  8 Jan 2025 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bP4zn/lp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004A1AAA15
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364669; cv=none; b=BA0KB+/srXGaxzroTZod3nQo/FEWY2vfIck8WlakuxYHAET2pnOOsVd1WMzFMtLjFK4WJrwvqtmMdteLMl67XNF7CWhi5mCllK4Ye1bbS3L5k4h7p+RrE9+nsKK7g2+FuUJkKBVu0nIqh3aJhhMrEBuJCJXLKNb/7o7fhmHKfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364669; c=relaxed/simple;
	bh=j8Lp5ED8JKW0YShHaZyKoSTKpSj2NUc/6Fr7W0m9S8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bBRM5yd80WphI6gelBu5LG/BYjpcObQyHAFXPg1S5JWPnBEU5MPiyu3SiDkDBfr7Cp2YrJpwtttjqQw4Fd5WZPW6Em06VdusMa+q211d9ZoqlGAe7BG9wag378eEUHRo7niIw9AILyFrUxMulI8oN4jHAQs4EJvF/nl9Bhj89fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bP4zn/lp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9dbeb848so264103a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 11:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736364667; x=1736969467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QSU9WBtVajX3qFErB85rNsWVoVpkqgMri6VMcSJZxE=;
        b=bP4zn/lpDXwJPr4oIJkIMLaeJcL7shODw1/XJ56WquJ3x0t/ZwG/E+pFM+Hczwt28L
         TKNcNqPhSgVoFocA1FyG884oo/PBo1oQdxlCtc7lV6z17Jugohu5+Wn+E+5EDdFdRAUe
         bku9KoSCEZ47bKrw5CDYCnRXupmp7Invr3jIgrkMeupRATf82n7kmeAuiPjBGAedIYqK
         fSuZGfSzo1g/oJJweojVgrKueD4GI6JiYp+dc1/0hLzVhEqru1ugsURz/WOr3SXsCIZh
         99pJ4WrJ18tWEnX865wVE9FQRQahrfd7MRdyD++MTeyFmWv0GHVVUqsaf0f19YpmPqXm
         YF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736364667; x=1736969467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QSU9WBtVajX3qFErB85rNsWVoVpkqgMri6VMcSJZxE=;
        b=vnDnP4V1l7WykGn3By2rEmlpEC+ZvXDkTEOuRd1yKly/AoawOu3ovcRQVuKb+oiuMD
         cwdTL2oH3vN1W55P5RxTTitdrd0bfB2I4wSSrxBsqvY+9gJdFbfcKXxQVAK3hnHtyKvt
         NlvlDgbAa8fHsmnHrOmvbb+ImE0cuufJsCjJl0H/KSwxAnSq7/SBFKPZSvmQ9skONj8d
         oNj91/PYPgnLFx+MOpkwNjJovVRpDRcNaLGajYrBaAgtiLS0DFZEX6QCNJXX1Hx53ZNA
         QNjbZ1HM9oFyZE2QxOFcrDNPNr/toprB2H/lOMVVXpWo5cPTy/rhhNTuvmre+6od5utj
         b8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvqJj388Kpopu2KMf+4EMW+Q7Vwz4Vgo9LVccd1vSR9guVdH9+HSBeLbdSGrbkLGYPVBN+az8G7UGM6K8MAfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4NbraUE+MnDBb/wdQGUotb7h2aPVO9HHHw5tYxpJ2K2BFTpR
	QrQyky80uHWNVrBVE4SztwKYPmiqTpELHdifenHmSbpMvQx9y01ES3+MacQlISeDsywd+Ey/hDu
	AWg==
X-Google-Smtp-Source: AGHT+IEqs6N7PPsng94De5dx3mkquV1TM1SYIb1HlxfQlEumNRj6VcGiC4B0xcwZFGnydYIZent9HBZlEJA=
X-Received: from pfwo12.prod.google.com ([2002:a05:6a00:1bcc:b0:72b:ccb:c99b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c89b:b0:1e1:dd97:7881
 with SMTP id adf61e73a8af0-1e88d12745bmr6952244637.23.1736364667587; Wed, 08
 Jan 2025 11:31:07 -0800 (PST)
Date: Wed, 8 Jan 2025 11:31:06 -0800
In-Reply-To: <20240918205319.3517569-6-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com> <20240918205319.3517569-6-coltonlewis@google.com>
Message-ID: <Z37Seos1zVHk0-p7@google.com>
Subject: Re: [PATCH v2 5/6] KVM: x86: selftests: Test core events
From: Sean Christopherson <seanjc@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Jinrong Liang <ljr.kernel@gmail.com>, Jim Mattson <jmattson@google.com>, 
	Aaron Lewis <aaronlewis@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 18, 2024, Colton Lewis wrote:
> Test events on core counters by iterating through every combination of
> events in amd_pmu_zen_events with every core counter.
> 
> For each combination, calculate the appropriate register addresses for
> the event selection/control register and the counter register. The
> base addresses and layout schemes change depending on whether we have
> the CoreExt feature.
> 
> To do the testing, reuse GUEST_TEST_EVENT to run a standard known
> workload. Decouple it from guest_assert_event_count (now
> guest_assert_intel_event_count) to generalize to AMD.
> 
> Then assert the most specific detail that can be reasonably known
> about the counter result. Exact count is defined and known for some
> events and for other events merely asserted to be nonzero.
> 
> Note on exact counts: AMD counts one more branch than Intel for the
> same workload. Though I can't confirm a reason, the only thing it
> could be is the boundary of the loop instruction being counted
> differently. Presumably, when the counter reaches 0 and execution
> continues to the next instruction, AMD counts this as a branch and
> Intel doesn't

IIRC, VMRUN is counted as a branch instruction for the guest.  Assuming my memory
is correct, that means this test is going to be flaky as an asynchronous exit,
e.g. due to a host IRQ, during the measurement loop will inflate the count.  I'm
not entirely sure what to do about that :-(

> +static void __guest_test_core_event(uint8_t event_idx, uint8_t counter_idx)
> +{
> +	/* One fortunate area of actual compatibility! This register

	/*
	 * This is the proper format for multi-line comments.  We are not the
	 * crazy net/ folks.
	 */

> +	 * layout is the same for both AMD and Intel.

It's not, actually.  There are differences in the layout, it just so happens that
the differences don't throw a wrench in things.

The comments in tools/testing/selftests/kvm/include/x86_64/pmu.h document this
fairly well, I don't see any reason to have a comment here.

> +	 */
> +	uint64_t eventsel = ARCH_PERFMON_EVENTSEL_OS |
> +		ARCH_PERFMON_EVENTSEL_ENABLE |
> +		amd_pmu_zen_events[event_idx];

Align the indentation.

	uint64_t eventsel = ARCH_PERFMON_EVENTSEL_OS |
			    ARCH_PERFMON_EVENTSEL_ENABLE |
			    amd_pmu_zen_events[event_idx];

> +	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
> +	uint64_t esel_msr_base = core_ext ? MSR_F15H_PERF_CTL : MSR_K7_EVNTSEL0;
> +	uint64_t cnt_msr_base = core_ext ? MSR_F15H_PERF_CTR : MSR_K7_PERFCTR0;
> +	uint64_t msr_step = core_ext ? 2 : 1;
> +	uint64_t esel_msr = esel_msr_base + msr_step * counter_idx;
> +	uint64_t cnt_msr = cnt_msr_base + msr_step * counter_idx;

This pattern of code is copy+pasted in three functions.  Please add macros and/or
helpers to consolidate things.  These should also be uint32_t, not 64.

It's a bit evil, but one approach would be to add a macro to iterate over all
PMU counters.  Eating the VM-Exit for the CPUID to get X86_FEATURE_PERF_CTR_EXT_CORE
each time is unfortunate, but I doubt/hope it's not problematic in practice.  If
the cost is meaningful, we could figure out a way to cache the info, e.g. something
awful like this might work:

	/* Note, this relies on guest state being recreated between each test. */
	static int has_perfctr_core = -1;

	if (has_perfctr_core == -1)
		has_perfctr_core = this_cpu_has(X86_FEATURE_PERFCTR_CORE);

	if (has_perfctr_core) {

static bool get_pmu_counter_msrs(int idx, uint32_t *eventsel, uint32_t *pmc)
{
	if (this_cpu_has(X86_FEATURE_PERFCTR_CORE)) {
		*eventsel = MSR_F15H_PERF_CTL + idx * 2;
		*pmc = MSR_F15H_PERF_CTR + idx * 2;
	} else {
		*eventsel = MSR_K7_EVNTSEL0 + idx;
		*pmc = MSR_K7_PERFCTR0 + idx;
	}
	return true;
}

#define for_each_pmu_counter(_i, _nr_counters, _eventsel, _pmc)		\
	for (_i = 0; i < _nr_counters; _i++)				\
		if (get_pmu_counter_msrs(_i, &_eventsel, _pmc))		\

static void guest_test_core_events(void)
{
	uint8_t nr_counters = guest_nr_core_counters();
	uint32_t eventsel_msr, pmc_msr;
	int i, j;

	for (i = 0; i < NR_AMD_ZEN_EVENTS; i++) {
		for_each_pmu_counter(j, nr_counters, eventsel_msr, pmc_msr) {
			uint64_t eventsel = ARCH_PERFMON_EVENTSEL_OS |
					    ARCH_PERFMON_EVENTSEL_ENABLE |
					    amd_pmu_zen_events[event_idx];

			GUEST_TEST_EVENT(pmc_msr, eventsel_msr, eventsel, "");
			guest_assert_amd_event_count(i, j, pmc_msr);

			if (!is_forced_emulation_enabled)
				continue;

			GUEST_TEST_EVENT(pmc_msr, eventsel_msr, eventsel, KVM_FEP);
			guest_assert_amd_event_count(i, j, pmc_msr);
		}
	}
}

