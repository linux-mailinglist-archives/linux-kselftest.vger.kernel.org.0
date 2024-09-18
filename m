Return-Path: <linux-kselftest+bounces-18120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F53E97C113
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 22:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA5B283C00
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 20:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519721CC15A;
	Wed, 18 Sep 2024 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xUY/Koia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E11CBE9D
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692846; cv=none; b=j6hgd8KZHxb1nejW6OfDWCtYqTxzf9Kuk576r2o7O+8K3rAdM/DC9YPMsoGPSzc7kVY1IssVs89Mc6ZfQcpELPoSzJwLsYtcHWpdMte4TiyAneiYMTpmSsEapEhGC2t7FkRcuGWL2w0opgh/dLpc3h6tZtcSOQUKDAdKxCzFx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692846; c=relaxed/simple;
	bh=EhE7fT+kvYR1Q8z0VYUdV57MUeryDUN91qCH81aB3uA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vy+D72Qt2TFyZJXiymHYWPN1ihDYBRCdEgjPigDJ5jgrJiuL80Y1l/pfo/K9Zp8SQaYv4+6ipoGnANfTOKKQpShbg1fm7rlqYANJ7M/nmR2vwTY3Ne/Bl9NxokKZNd6Wz4JjNm59N7NOmREYKZLarALIknmXPVad1X7czRndxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xUY/Koia; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1aa529e30eso334556276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726692843; x=1727297643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5LjPPMrNjWPhkrbIBVeS2QTzariP8KiUDD2AXY1srT0=;
        b=xUY/KoiaYu1WcZptKlHhPCDe7aKzCN5E3fMjLVG5KMSw5yU0uyrfnd1r6+7mPKSRUd
         cHIj7jYWihdLEOg2kifSO7zYS5jfaYWXAIEx/oLEJ2I0xDcqRUaOHkA2NvSdNy4dw7Kd
         6Kd35x+uyfDNtGWA0/G+E3NCx+qbxFJGxjtt9LAqShBsPdyAKhYkS/tyJcO4+hQFtqQl
         h6F37R+fnMn/hZYP45RyHFEqPwZh4cky3hGtcheJZLTvtH6JJjGKPp4SfN5J3GyUU758
         5QztmkgSiLCDX8gpSaRDiJDC6clfYnaQmNVxmNhKTSvQzaPqT5Tx2EFMzfdQ364n72Mt
         0MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692843; x=1727297643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LjPPMrNjWPhkrbIBVeS2QTzariP8KiUDD2AXY1srT0=;
        b=owcAUG0L3YyUjP1Koyco6eGzmlQAy10RCKNvogA9wjku2Mz5/+TVynIaNVEkckMMvv
         mMgbNFwBGDUjddbKCT2A6uNOicbsfYqk9LEgOfsIwdmXMy7vrpWOTLvDai2jKKHMC5ko
         RZO80U9gxiyNeEnMWBLBUQBtJ2IkkcSRjSKGRUuLMVXGsqh9JHOUDdU60gqNcp69DOAe
         KiVHPJKkbRnsCJJjZKYhuB9iWp1K1ED++erBtf81KdDplYz3XApgovs+KAiu8lcb0k5U
         xbuDMLDkxR43ZBgkTzw0idlgs5c/CfapxyqOmmrxLRGb0XadZsLsxi0bqow7F8ZoiwbE
         xUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/aDsQdKDNzkb4QmdWIEJZT7Ywe/gaDQbBniLMhCN1W/cHAI/TSYCN4AQgWOG3JJ7hwPVoP3EW0R9YebbmumY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5tQgMkJDG3iysTH+0dtsEcq7KeVu2RMPw0Q/s6XV9i9u9sjCs
	igKRyTZld0zXq0a/xI/5lz300S4pNvWDp/CXK+cbn7UYyDlssjkDLNm94bfW3wDpzyxdQpCD4Om
	xboSThlAsRymfCc6aA7uGtQ==
X-Google-Smtp-Source: AGHT+IFsuKcr5FzVL+z7aQg1GQc1dsi2r2Svsejd/GzBtLLxOhu7F6DPwsXM3Vd9fngcGMgwH7awUkawVaVTnLnOpw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:3602:0:b0:e1d:2043:da46 with SMTP
 id 3f1490d57ef6-e1daff6d90bmr44632276.3.1726692843155; Wed, 18 Sep 2024
 13:54:03 -0700 (PDT)
Date: Wed, 18 Sep 2024 20:53:18 +0000
In-Reply-To: <20240918205319.3517569-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918205319.3517569-6-coltonlewis@google.com>
Subject: [PATCH v2 5/6] KVM: x86: selftests: Test core events
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Test events on core counters by iterating through every combination of
events in amd_pmu_zen_events with every core counter.

For each combination, calculate the appropriate register addresses for
the event selection/control register and the counter register. The
base addresses and layout schemes change depending on whether we have
the CoreExt feature.

To do the testing, reuse GUEST_TEST_EVENT to run a standard known
workload. Decouple it from guest_assert_event_count (now
guest_assert_intel_event_count) to generalize to AMD.

Then assert the most specific detail that can be reasonably known
about the counter result. Exact count is defined and known for some
events and for other events merely asserted to be nonzero.

Note on exact counts: AMD counts one more branch than Intel for the
same workload. Though I can't confirm a reason, the only thing it
could be is the boundary of the loop instruction being counted
differently. Presumably, when the counter reaches 0 and execution
continues to the next instruction, AMD counts this as a branch and
Intel doesn't.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 87 ++++++++++++++++---
 1 file changed, 77 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 79ca7d608e00..cf2941cc7c4c 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -29,6 +29,9 @@
 /* Total number of instructions retired within the measured section. */
 #define NUM_INSNS_RETIRED		(NUM_LOOPS * NUM_INSNS_PER_LOOP + NUM_EXTRA_INSNS)
 
+/* AMD counting one extra branch. Probably at loop boundary condition. */
+#define NUM_BRANCH_INSNS_RETIRED_AMD	(NUM_LOOPS+1)
+#define NUM_INSNS_RETIRED_AMD		(NUM_INSNS_RETIRED+1)
 
 /*
  * Limit testing to MSRs that are actually defined by Intel (in the SDM).  MSRs
@@ -109,7 +112,7 @@ static uint8_t guest_get_pmu_version(void)
  * Sanity check that in all cases, the event doesn't count when it's disabled,
  * and that KVM correctly emulates the write of an arbitrary value.
  */
-static void guest_assert_event_count(uint8_t idx,
+static void guest_assert_intel_event_count(uint8_t idx,
 				     struct kvm_x86_pmu_feature event,
 				     uint32_t pmc, uint32_t pmc_msr)
 {
@@ -151,6 +154,33 @@ static void guest_assert_event_count(uint8_t idx,
 	GUEST_ASSERT_EQ(_rdpmc(pmc), 0xdead);
 }
 
+static void guest_assert_amd_event_count(uint8_t evt_idx, uint8_t cnt_idx, uint32_t pmc_msr)
+{
+	uint64_t count;
+	uint64_t count_pmc;
+
+	count = rdmsr(pmc_msr);
+	count_pmc = _rdpmc(cnt_idx);
+	GUEST_ASSERT_EQ(count, count_pmc);
+
+	switch (evt_idx) {
+	case AMD_ZEN_CORE_CYCLES_INDEX:
+		GUEST_ASSERT_NE(count, 0);
+		break;
+	case AMD_ZEN_INSTRUCTIONS_INDEX:
+		GUEST_ASSERT_EQ(count, NUM_INSNS_RETIRED_AMD);
+		break;
+	case AMD_ZEN_BRANCHES_INDEX:
+		GUEST_ASSERT_EQ(count, NUM_BRANCH_INSNS_RETIRED_AMD);
+		break;
+	case AMD_ZEN_BRANCH_MISSES_INDEX:
+		GUEST_ASSERT_NE(count, 0);
+		break;
+	default:
+		break;
+	}
+
+}
 /*
  * Enable and disable the PMC in a monolithic asm blob to ensure that the
  * compiler can't insert _any_ code into the measured sequence.  Note, ECX
@@ -183,28 +213,29 @@ do {										\
 	);									\
 } while (0)
 
-#define GUEST_TEST_EVENT(_idx, _event, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)	\
+#define GUEST_TEST_EVENT(_pmc_msr, _ctrl_msr, _ctrl_value, FEP)			\
 do {										\
 	wrmsr(_pmc_msr, 0);							\
 										\
 	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt .", FEP);	\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _ctrl_value, "clflushopt .", FEP);	\
 	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush .", FEP);	\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _ctrl_value, "clflush .", FEP);	\
 	else									\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
-										\
-	guest_assert_event_count(_idx, _event, _pmc, _pmc_msr);			\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _ctrl_value, "nop", FEP);		\
 } while (0)
 
 static void __guest_test_arch_event(uint8_t idx, struct kvm_x86_pmu_feature event,
 				    uint32_t pmc, uint32_t pmc_msr,
 				    uint32_t ctrl_msr, uint64_t ctrl_msr_value)
 {
-	GUEST_TEST_EVENT(idx, event, pmc, pmc_msr, ctrl_msr, ctrl_msr_value, "");
+	GUEST_TEST_EVENT(pmc_msr, ctrl_msr, ctrl_msr_value, "");
+	guest_assert_intel_event_count(idx, event, pmc, pmc_msr);
 
-	if (is_forced_emulation_enabled)
-		GUEST_TEST_EVENT(idx, event, pmc, pmc_msr, ctrl_msr, ctrl_msr_value, KVM_FEP);
+	if (is_forced_emulation_enabled) {
+		GUEST_TEST_EVENT(pmc_msr, ctrl_msr, ctrl_msr_value, KVM_FEP);
+		guest_assert_intel_event_count(idx, event, pmc, pmc_msr);
+	}
 }
 
 #define X86_PMU_FEATURE_NULL						\
@@ -697,9 +728,45 @@ static void guest_test_rdwr_core_counters(void)
 	}
 }
 
+static void __guest_test_core_event(uint8_t event_idx, uint8_t counter_idx)
+{
+	/* One fortunate area of actual compatibility! This register
+	 * layout is the same for both AMD and Intel.
+	 */
+	uint64_t eventsel = ARCH_PERFMON_EVENTSEL_OS |
+		ARCH_PERFMON_EVENTSEL_ENABLE |
+		amd_pmu_zen_events[event_idx];
+	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
+	uint64_t esel_msr_base = core_ext ? MSR_F15H_PERF_CTL : MSR_K7_EVNTSEL0;
+	uint64_t cnt_msr_base = core_ext ? MSR_F15H_PERF_CTR : MSR_K7_PERFCTR0;
+	uint64_t msr_step = core_ext ? 2 : 1;
+	uint64_t esel_msr = esel_msr_base + msr_step * counter_idx;
+	uint64_t cnt_msr = cnt_msr_base + msr_step * counter_idx;
+
+	GUEST_TEST_EVENT(cnt_msr, esel_msr, eventsel, "");
+	guest_assert_amd_event_count(event_idx, counter_idx, cnt_msr);
+
+	if (is_forced_emulation_enabled) {
+		GUEST_TEST_EVENT(cnt_msr, esel_msr, eventsel, KVM_FEP);
+		guest_assert_amd_event_count(event_idx, counter_idx, cnt_msr);
+	}
+
+}
+
+static void guest_test_core_events(void)
+{
+	uint8_t nr_counters = guest_nr_core_counters();
+
+	for (uint8_t i = 0; i < NR_AMD_ZEN_EVENTS; i++) {
+		for (uint8_t j = 0; j < nr_counters; j++)
+			__guest_test_core_event(i, j);
+	}
+}
+
 static void guest_test_core_counters(void)
 {
 	guest_test_rdwr_core_counters();
+	guest_test_core_events();
 	GUEST_DONE();
 }
 
-- 
2.46.0.662.g92d0881bb0-goog


