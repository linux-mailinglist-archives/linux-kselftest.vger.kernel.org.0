Return-Path: <linux-kselftest+bounces-15247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF83950A9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7BA1F21638
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3415A1A3BC7;
	Tue, 13 Aug 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrzOUOEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85E1A38D7
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567401; cv=none; b=U05YXZm9x45jiUF+/ZgQnjWQCd9FCFJHyQyOc8X8nEqh/MjaRtoDEfWTcIr+MF1RC+yfnBmykXWh5BhyLzvNwMjEqsyWj+2Z2h2QE8jRE2yjl5pvam4RIEQSD3rW/upsm1XR0502XMFyrei36s/ea4a3MuiCHKeGK7B1YP0wgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567401; c=relaxed/simple;
	bh=BzUrNU2ZraWOWTk3Iv7hgsDb8BFWgPE59A3h3IKeVYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FUXfy5plI1GC8c7MxWtnEd2obM2oY7XgEQQd64hwq3aQPmiVquqtzE0aKrN/8ruzrdYcfDzSICaWPSi0KbhktLDUPfOkU4vx5OOCUjF+bAWmXRsW5E1E0WiWxN/OImpDPvwcBh8A1kUjTD9ShHiqo4g53+yLdWkXuuhHBXD7RiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrzOUOEH; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-39915b8e08dso81604925ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723567398; x=1724172198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IzizhsPZKqLhOYK5bcLEvi2PU+wjRDK8IZyA0qEp6YM=;
        b=VrzOUOEHmrqS26UeI9aa6DFkSDvoY7PrSBtJ5meZaZ2yinAohhuuSd7PTPYpu941Pw
         gaQkL/r6sDh/3sHyBvQxsbNaoLZ2CIl9VMbrTo3/OeOMiBXYSZAGeJz4gzhMyVDqb1Uq
         JEftC4PBbmPPlsEPdGvf2cHvWx5J2UA1V/t6OlvTlt/af7EaB32AKZ/mJh6V6bWZGcQH
         W0CgztozWTeCXQ9CFU//NaUEiBOxCcd66lbGgefz1lMf5RlKXRTvR9Zu5bT+laCyL9ot
         EMp40RvFYVs2wKs/m3HWUzzXE0b6IljU4g6bEfUN+DSzRRFix8BbxF7ocnxuBHFCBq34
         80nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567398; x=1724172198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzizhsPZKqLhOYK5bcLEvi2PU+wjRDK8IZyA0qEp6YM=;
        b=q/Og0AdywGg4MM+1rWLpd//WPlL6kiE2AEJZVtSbOb/8pzIN/LzP1yV8ieLEgTIIPY
         Nk5lv8oEUStb1VdqRkJ2vj7Gf+ALn7pQ7pJvaG0g4+mKgbVqfRX9juLdZa+EablvilsP
         +Ti6JpfPPk0cW5f1VmWVKfCBcjoPbEPbL1JLg1MYQ4RVxDd7sg0lN3xUofGMGnqRlpvV
         HY6Az/BtqSABtsvdwMWszZ1c3D4H5oBW5zxij7vxzT/KC7LDbqwg3WT6PBxoIL5uEGd5
         oK5jff6KYVpjhTVlMP4Rv7o6Jzg40RmcWPjh6ZZ+Y7eESxjIJ9jTsdiVP318wtrqRYJS
         0weA==
X-Forwarded-Encrypted: i=1; AJvYcCXLtykY4m80SGPYua+1wglAdxYzoh2tauntTcIF4qx8DX0VOheLWCUlCSf/cmVQKQtRhvduj0I8PFEpiVFIPe3seMPONakfW6B4jHSuc1Ny
X-Gm-Message-State: AOJu0Yz52gDzXDsPGzydhQDK7OBU84yr+XIjLSegMPtU7zV2CUrF+J9a
	2Lo17xTFbQHMn4w5GBVIEp6H0i8C5EpSCHdWAoYdHkCTp2Fc0N8uRLG6uiR73YJNec3xyN2PiTG
	aoKx6XNl+bwCmXpNPsPGYIw==
X-Google-Smtp-Source: AGHT+IGPy3YYdvJsVhd7Cm67IXVaqYPxT1CYYkGdmWcZNua9lh4lwNUJwrMH4rshgZzNfM+CSzuFOiFv8IYTpJVxUQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6e02:b46:b0:397:fa4e:3df0 with
 SMTP id e9e14a558f8ab-39d124c23bbmr102925ab.3.1723567398720; Tue, 13 Aug 2024
 09:43:18 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:42:43 +0000
In-Reply-To: <20240813164244.751597-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813164244.751597-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813164244.751597-6-coltonlewis@google.com>
Subject: [PATCH 5/6] KVM: x86: selftests: Test core events
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
index 9620fc33d26e..fae078b444b3 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -29,6 +29,9 @@
 /* Total number of instructions retired within the measured section. */
 #define NUM_INSNS_RETIRED		(NUM_LOOPS * NUM_INSNS_PER_LOOP + NUM_EXTRA_INSNS)
 
+/* AMD counting one extra branch. Probably at loop boundary condition. */
+#define NUM_BRANCH_INSNS_RETIRED_AMD	(NUM_LOOPS+1)
+#define NUM_INSNS_RETIRED_AMD		(NUM_INSNS_RETIRED+1)
 
 static uint8_t kvm_pmu_version;
 static bool kvm_has_perf_caps;
@@ -98,7 +101,7 @@ static uint8_t guest_get_pmu_version(void)
  * Sanity check that in all cases, the event doesn't count when it's disabled,
  * and that KVM correctly emulates the write of an arbitrary value.
  */
-static void guest_assert_event_count(uint8_t idx,
+static void guest_assert_intel_event_count(uint8_t idx,
 				     struct kvm_x86_pmu_feature event,
 				     uint32_t pmc, uint32_t pmc_msr)
 {
@@ -140,6 +143,33 @@ static void guest_assert_event_count(uint8_t idx,
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
@@ -172,28 +202,29 @@ do {										\
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
@@ -684,9 +715,45 @@ static void guest_test_rdwr_core_counters(void)
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
+	uint8_t nr_counters = this_cpu_property(X86_PROPERTY_NUM_PERF_CTR_CORE);
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
2.46.0.76.ge559c4bf1a-goog


