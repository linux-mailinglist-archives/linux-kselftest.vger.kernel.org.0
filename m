Return-Path: <linux-kselftest+bounces-18118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E1097C10D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 22:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0AB1C20CE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 20:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E811CBE96;
	Wed, 18 Sep 2024 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxvwbFWt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178821CB33D
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692844; cv=none; b=YE48Qasy9F8yG3vkRVVFVI592UA8FhVHUaE/kiNk0VFCLor0ZK0Moq0X8BQG8ED6N1bdSzSQw9SgFiRBOVS91JfZGc1DlUdDaE461u5kQI2RD1B3itl1fGV5hTyiTtVTWTFO5NE1loue92G5pmBIVsKXoT86yKBs02Kpt00pS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692844; c=relaxed/simple;
	bh=p6MzaJUynW/JjkmeZKB5mW65nL3/Igk6OCMaHic7+aw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YzhQU652tpUC+wOjFu31hQodwYA3iQPn/VyjW/fMHUStu0tXGhtitBuJe2QoLxUsgIQ8ZU8V/1NOkqXuwFPhgxXsQSX/E4tXyRCmmg7F5N4vRJRsWcbPpj5Kc9CUTwcTU7as8yUAujO4xrQTCIbfPBuumWLBytGvOeX74SWooDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxvwbFWt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-69a0536b23aso2267477b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 13:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726692841; x=1727297641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwPgtOW129JrsQoACWdjEIl4s6WZlvFOhv3Du6OF+8U=;
        b=SxvwbFWtq/Snn8Opm0acT0QfMfIdgN1dq0W8sk1O7KOrYEPCwyEkmuiW1kTIvWw/Jp
         IMRiq8DB8T6ptwGLcouwfxB7Pm1aAMVjXQ4bR6RUOt355LAGotp0yGzwhpg0vup8qAa+
         gglnsrl+GV7uDLG3i6+pq0MB1HZJt5DueTbO1QL9oW9EX4v/f8TTd3wR0efUPv2je4H+
         ioinA2e/al6rHbRaVJ+A2HW3zD0JUCLioD/CD6B+ngTJeQLJaEBakg8Dpg/aBVPK5INy
         /tpcIfym8tvprxLN9qXEld4aQPprCAf38yxdCp69+C3878R0NSsAEnqQfmIMjShKV3eu
         7RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692841; x=1727297641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwPgtOW129JrsQoACWdjEIl4s6WZlvFOhv3Du6OF+8U=;
        b=hOVoC7O8uonj/uD3sWBUbHC1oYQXnNNd4MnmsAu5yaijPnlbJOd+Buxt6io8cgB7LZ
         mYfiXzj9WYN1G+Bko+HUs/b64wLvbpsP9zO/h9Mte4RcBASUlt8VrcvaUDi30fNsbwEW
         y5cwAFyYijA0B0JgEJ7D86nrZWkxtSTRP32QvPwlm1nSsqrhyGAzBLMgqTIi2YSNkWce
         Fqnuoht+BttnnZNLzRHtyY4Kut9ib4+jIaYGZx9kkRARcs7i27yKWzhPwtmUGWMf34gG
         RSuVSG1Wlo7vDcyMDQ093c5/TQTRW/RK7FmMXY7dzdmqRI8tgocSAqXZVsIiZun7sw12
         h4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqgYK1F+4M9Wvyq/eS9JuLtWvNaiDzQC1PA/UArQcPkqGUA9qSgvEKjBPHHd/9nVZw9394NFvITOs2peYZm7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1pIbv5qN3Z9TrwiGyeXJ7GPyxtxbQgaGuXdRFy1Yp7J8ViBSY
	1zzx4kTstcwjeXkjQl2VkyPiQcAD6FCNPN8xiB6IT4WPfgWVwNaJYOCCoeQp+ZRGX/pG/9WblTC
	3tpDicswJ5Dj5iDJiJBYlHw==
X-Google-Smtp-Source: AGHT+IGRPIBH0lJ/zYqTw1ktDVZvUIdvA2LFZQYoQbGDgG/n34gqx1ZHStAZ7pNzlmKV4Cl93mXbQJCAfZuocHz/Dw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a81:cb07:0:b0:6db:e107:74cb with SMTP
 id 00721157ae682-6dbe1077640mr6957727b3.3.1726692840998; Wed, 18 Sep 2024
 13:54:00 -0700 (PDT)
Date: Wed, 18 Sep 2024 20:53:16 +0000
In-Reply-To: <20240918205319.3517569-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918205319.3517569-4-coltonlewis@google.com>
Subject: [PATCH v2 3/6] KVM: x86: selftests: Set up AMD VM in pmu_counters_test
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Branch in main() depending on if the CPU is Intel or AMD. They are
subject to vastly different requirements because the AMD PMU lacks
many properties defined by the Intel PMU including the entire CPUID
0xa function where Intel stores all the PMU properties. AMD lacks this
as well as any consistent notion of PMU versions as Intel does. Every
feature is a separate flag and they aren't the same features as Intel.

Set up a VM for testing core AMD counters and ensure proper CPUID
features are set.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 104 ++++++++++++++----
 1 file changed, 83 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 0e305e43a93b..5b240585edc5 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -30,10 +30,21 @@
 #define NUM_INSNS_RETIRED		(NUM_LOOPS * NUM_INSNS_PER_LOOP + NUM_EXTRA_INSNS)
 
 
+/*
+ * Limit testing to MSRs that are actually defined by Intel (in the SDM).  MSRs
+ * that aren't defined counter MSRs *probably* don't exist, but there's no
+ * guarantee that currently undefined MSR indices won't be used for something
+ * other than PMCs in the future.
+ */
+#define MAX_NR_GP_COUNTERS	8
+#define MAX_NR_FIXED_COUNTERS	3
+#define AMD_NR_CORE_COUNTERS	4
+#define AMD_NR_CORE_EXT_COUNTERS	6
+
 static uint8_t kvm_pmu_version;
 static bool kvm_has_perf_caps;
 
-static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
+static struct kvm_vm *intel_pmu_vm_create(struct kvm_vcpu **vcpu,
 						  void *guest_code,
 						  uint8_t pmu_version,
 						  uint64_t perf_capabilities)
@@ -303,7 +314,7 @@ static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
 	if (!pmu_version)
 		return;
 
-	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_arch_events,
+	vm = intel_pmu_vm_create(&vcpu, guest_test_arch_events,
 					 pmu_version, perf_capabilities);
 
 	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH,
@@ -316,15 +327,6 @@ static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
 	kvm_vm_free(vm);
 }
 
-/*
- * Limit testing to MSRs that are actually defined by Intel (in the SDM).  MSRs
- * that aren't defined counter MSRs *probably* don't exist, but there's no
- * guarantee that currently undefined MSR indices won't be used for something
- * other than PMCs in the future.
- */
-#define MAX_NR_GP_COUNTERS	8
-#define MAX_NR_FIXED_COUNTERS	3
-
 #define GUEST_ASSERT_PMC_MSR_ACCESS(insn, msr, expect_gp, vector)		\
 __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
 	       "Expected %s on " #insn "(0x%x), got vector %u",			\
@@ -463,7 +465,7 @@ static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_gp_counters,
+	vm = intel_pmu_vm_create(&vcpu, guest_test_gp_counters,
 					 pmu_version, perf_capabilities);
 
 	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_GP_COUNTERS,
@@ -530,7 +532,7 @@ static void test_fixed_counters(uint8_t pmu_version, uint64_t perf_capabilities,
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_fixed_counters,
+	vm = intel_pmu_vm_create(&vcpu, guest_test_fixed_counters,
 					 pmu_version, perf_capabilities);
 
 	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK,
@@ -627,18 +629,78 @@ static void test_intel_counters(void)
 	}
 }
 
-int main(int argc, char *argv[])
+static uint8_t nr_core_counters(void)
 {
-	TEST_REQUIRE(kvm_is_pmu_enabled());
+	uint8_t nr_counters = kvm_cpu_property(X86_PROPERTY_NUM_PERF_CTR_CORE);
+	bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
+
+	if (nr_counters != 0)
+		return nr_counters;
+
+	if (core_ext)
+		return AMD_NR_CORE_EXT_COUNTERS;
 
-	TEST_REQUIRE(host_cpu_is_intel);
-	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
-	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
+	return AMD_NR_CORE_COUNTERS;
 
-	kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
-	kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
+}
+
+static void guest_test_core_counters(void)
+{
+	GUEST_DONE();
+}
+
+static void test_core_counters(void)
+{
+	uint8_t nr_counters = nr_core_counters();
+	bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
+	bool perfmon_v2 = kvm_cpu_has(X86_FEATURE_PERFMON_V2);
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	for (uint8_t ce = 0; ce <= core_ext; ce++) {
+		for (uint8_t pm = 0; pm <= perfmon_v2; pm++) {
+			for (uint8_t nc = 0; nc <= nr_counters; nc++) {
+				vm = vm_create_with_one_vcpu(&vcpu, guest_test_core_counters);
+
+				if (nc)
+					vcpu_set_cpuid_property(
+						vcpu, X86_PROPERTY_NUM_PERF_CTR_CORE, nc);
+				if (ce)
+					vcpu_set_cpuid_feature(
+						vcpu, X86_FEATURE_PERF_CTR_EXT_CORE);
+				if (pm)
+					vcpu_set_cpuid_feature(
+						vcpu, X86_FEATURE_PERFMON_V2);
+
+				pr_info("Testing core counters: CoreExt = %u, PerfMonV2 = %u, NumCounters = %u\n",
+					ce, pm, nc);
+				run_vcpu(vcpu);
+
+				kvm_vm_free(vm);
+			}
+		}
+	}
+}
+
+static void test_amd_counters(void)
+{
+	test_core_counters();
+}
 
-	test_intel_counters();
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_is_pmu_enabled());
+
+	if (host_cpu_is_intel) {
+		TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
+		TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
+		kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
+		kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
+		test_intel_counters();
+	} else if (host_cpu_is_amd) {
+		/* AMD CPUs don't have the same properties to look at. */
+		test_amd_counters();
+	}
 
 	return 0;
 }
-- 
2.46.0.662.g92d0881bb0-goog


