Return-Path: <linux-kselftest+bounces-35493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3913AE2571
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6C73AE6B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3725DB12;
	Fri, 20 Jun 2025 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qx7ITm54"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769925BF04
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457947; cv=none; b=aXjWKT7rXERdFU3LwAbw9CpOu9jL+VjBn9LnTQ0ueQVYglU9sq8+i73yHmaMZgjjRpphMWBoC2x1K3BWXTh6/tJVWNmRYjuo0ZX6NA2HoDhTmwVGACXylde2sz+ZxNvpc4d67uADYfPdG8Vx0ksG/g0zIdYgC0re4P3NQJlcT+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457947; c=relaxed/simple;
	bh=DzV1iQPyhQYH/07BErYJfalFEt85HaMiwlc8OwgiWrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NaEqVPZKUXrPd/I98cPBcOB/4HmeRROxD0oZAnxb+Z7K9W6MZAMhL/kcwh4FrAgXw/cqJ4oimNClqmRrTDwO3bN+MFxyEpAVgdjxnHiRddk6FQkvLqrGFLCp0RqvyRKL/dvm3iq0EaBoCASgq0QtxAintsx8JU0qGsF/yEGhxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qx7ITm54; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddc65f95b8so44633915ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457943; x=1751062743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NzRy/DCIVlwO1UeSIhiO63SgndmbkqKBMoPqbIF1wck=;
        b=Qx7ITm540uwjexD6neLrYrKihQOUxvcZmmJUb2h81mZSu9Jqwq67hE0F1XqiFvl95e
         yOB4jMstYFSvydfMUfZ7Oxhz/V7C8x121nri++RcnISmmVEZiBKDEb/PLW9s2lr6oi+p
         ePRzK7d6dj/3GdqD4+4poDtaF9+ebcvKkuqrXNZfXkCBK4TRYEpNdnUpIM3lKWxSyAU5
         ObQeQ8GoGbcTywhaCnR+U2lLQRoxJz01ZQFIVw9wcAHRyDL2+Lybs+M3iBWJBVkPMn3k
         ng66S098dcPL3M+G1GINgYLi/n/1cjrf4RK3OB612skTTW7U0NltUcgjqfCDwMN9hiXd
         nkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457943; x=1751062743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzRy/DCIVlwO1UeSIhiO63SgndmbkqKBMoPqbIF1wck=;
        b=rtDojCCHzUTcPGVkPKlsDQz+hSLByG4K5lM2Pj9lVpCf6xqdGHgOs/P16F7IPDcjWG
         WgLVqGqjON85iNSRXJ7AkHtg3T/yIShzAth9OGGtL6BjKBAsRZv5kVQATX7EQevRRVSI
         rmMH0lkpQITq8FA19N83DSbyGChc88FJ1jMu3Y+c/dwoGw4lQrgkiXjNFSeEd8E4NxgC
         n7pPvslFBJed/0rdItdEZ7iEqvzxHYCVggV/2V3/VaiJnQD0Dz/JwJEzMc0x9jmxhP4O
         CjEscfVEbH3KbUYkMKnK9w1GPxan29/XrNexKFp0OWKBVCBYf2WFjwRD8SSUjhKWoVHv
         ZDXA==
X-Forwarded-Encrypted: i=1; AJvYcCVssgpAd9QOwbkAx6YUNkmYCa0BNxg+1mQLDUiTobK7fN9eRwmJGWrcwLISLuLJkHQDWr4VN+GDTb4WsrCRbfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbqwE5gCXNhRMS3r/kX/kJRXKeG9glQu6LSiHbJnjx575KXDD
	VrWwV+fXgOWnkkj3lFj9YvpOBYJ8Mce3RWpJRQ/8MI53Chd1dcaWolxQDKC9a1Rhk/SMEN77r5B
	tFH/os5jFldawjvTj62bvFqeqbg==
X-Google-Smtp-Source: AGHT+IGL0FZSPU1ilcGsH+T8e2Jo4op9tS5C/DjCI1eSwz135bo73pLwqVefVkcFUgBxqY2EeJDtp/6Z5o5Ovw5jOw==
X-Received: from ilbdi5.prod.google.com ([2002:a05:6e02:1f85:b0:3dd:754f:1dc4])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1c2f:b0:3dd:89b0:8e1b with SMTP id e9e14a558f8ab-3de38cbfed7mr58377885ab.15.1750457943154;
 Fri, 20 Jun 2025 15:19:03 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:25 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-26-coltonlewis@google.com>
Subject: [PATCH v2 23/23] KVM: arm64: selftests: Add test case for partitioned PMU
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Run separate a test case for a partitioned PMU in vpmu_counter_access.

An enum is created specifying whether we are testing the emulated or
partitioned PMU and all the test functions are modified to take the
implementation as an argument and make the difference in setup
appropriately.

Because the test should still succeed even if we are on a machine
where we have the capability but the ioctl fails because the driver
was never configured properly, use __vcpu_ioctl to avoid checking the
return code.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/include/uapi/linux/kvm.h                |  2 +
 .../selftests/kvm/arm64/vpmu_counter_access.c | 63 +++++++++++++------
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index b6ae8ad8934b..cb72b57b9b6c 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -930,6 +930,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
 #define KVM_CAP_ARM_WRITABLE_IMP_ID_REGS 239
+#define KVM_CAP_ARM_PARTITION_PMU 242
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1356,6 +1357,7 @@ struct kvm_vfio_spapr_tce {
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
 /* Memory Encryption Commands */
 #define KVM_MEMORY_ENCRYPT_OP      _IOWR(KVMIO, 0xba, unsigned long)
+#define KVM_ARM_PARTITION_PMU	_IOWR(KVMIO, 0xce, u8)
 
 struct kvm_enc_region {
 	__u64 addr;
diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
index f16b3b27e32e..93259b73de7c 100644
--- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
@@ -25,6 +25,16 @@
 /* The cycle counter bit position that's common among the PMU registers */
 #define ARMV8_PMU_CYCLE_IDX		31
 
+enum pmu_impl {
+	EMULATED,
+	PARTITIONED
+};
+
+const char *pmu_impl_str[] = {
+	"Emulated",
+	"Partitioned"
+};
+
 struct vpmu_vm {
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
@@ -405,7 +415,7 @@ static void guest_code(uint64_t expected_pmcr_n)
 }
 
 /* Create a VM that has one vCPU with PMUv3 configured. */
-static void create_vpmu_vm(void *guest_code)
+static void create_vpmu_vm(void *guest_code, enum pmu_impl impl)
 {
 	struct kvm_vcpu_init init;
 	uint8_t pmuver, ec;
@@ -419,6 +429,7 @@ static void create_vpmu_vm(void *guest_code)
 		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
 		.attr = KVM_ARM_VCPU_PMU_V3_INIT,
 	};
+	bool partition = impl;
 
 	/* The test creates the vpmu_vm multiple times. Ensure a clean state */
 	memset(&vpmu_vm, 0, sizeof(vpmu_vm));
@@ -449,6 +460,9 @@ static void create_vpmu_vm(void *guest_code)
 	/* Initialize vPMU */
 	vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
 	vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
+
+	if (kvm_has_cap(KVM_CAP_ARM_PARTITION_PMU))
+		__vcpu_ioctl(vpmu_vm.vcpu, KVM_ARM_PARTITION_PMU, &partition);
 }
 
 static void destroy_vpmu_vm(void)
@@ -475,12 +489,12 @@ static void run_vcpu(struct kvm_vcpu *vcpu, uint64_t pmcr_n)
 	}
 }
 
-static void test_create_vpmu_vm_with_pmcr_n(uint64_t pmcr_n, bool expect_fail)
+static void test_create_vpmu_vm_with_pmcr_n(uint64_t pmcr_n, enum pmu_impl impl, bool expect_fail)
 {
 	struct kvm_vcpu *vcpu;
 	uint64_t pmcr, pmcr_orig;
 
-	create_vpmu_vm(guest_code);
+	create_vpmu_vm(guest_code, impl);
 	vcpu = vpmu_vm.vcpu;
 
 	pmcr_orig = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0));
@@ -508,7 +522,7 @@ static void test_create_vpmu_vm_with_pmcr_n(uint64_t pmcr_n, bool expect_fail)
  * Create a guest with one vCPU, set the PMCR_EL0.N for the vCPU to @pmcr_n,
  * and run the test.
  */
-static void run_access_test(uint64_t pmcr_n)
+static void run_access_test(uint64_t pmcr_n, enum pmu_impl impl)
 {
 	uint64_t sp;
 	struct kvm_vcpu *vcpu;
@@ -516,7 +530,7 @@ static void run_access_test(uint64_t pmcr_n)
 
 	pr_debug("Test with pmcr_n %lu\n", pmcr_n);
 
-	test_create_vpmu_vm_with_pmcr_n(pmcr_n, false);
+	test_create_vpmu_vm_with_pmcr_n(pmcr_n, impl, false);
 	vcpu = vpmu_vm.vcpu;
 
 	/* Save the initial sp to restore them later to run the guest again */
@@ -529,6 +543,7 @@ static void run_access_test(uint64_t pmcr_n)
 	 * check if PMCR_EL0.N is preserved.
 	 */
 	vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
+
 	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
 	aarch64_vcpu_setup(vcpu, &init);
 	vcpu_init_descriptor_tables(vcpu);
@@ -550,14 +565,14 @@ static struct pmreg_sets validity_check_reg_sets[] = {
  * Create a VM, and check if KVM handles the userspace accesses of
  * the PMU register sets in @validity_check_reg_sets[] correctly.
  */
-static void run_pmregs_validity_test(uint64_t pmcr_n)
+static void run_pmregs_validity_test(uint64_t pmcr_n, enum pmu_impl impl)
 {
 	int i;
 	struct kvm_vcpu *vcpu;
 	uint64_t set_reg_id, clr_reg_id, reg_val;
 	uint64_t valid_counters_mask, max_counters_mask;
 
-	test_create_vpmu_vm_with_pmcr_n(pmcr_n, false);
+	test_create_vpmu_vm_with_pmcr_n(pmcr_n, impl, false);
 	vcpu = vpmu_vm.vcpu;
 
 	valid_counters_mask = get_counters_mask(pmcr_n);
@@ -607,11 +622,11 @@ static void run_pmregs_validity_test(uint64_t pmcr_n)
  * the vCPU to @pmcr_n, which is larger than the host value.
  * The attempt should fail as @pmcr_n is too big to set for the vCPU.
  */
-static void run_error_test(uint64_t pmcr_n)
+static void run_error_test(uint64_t pmcr_n, enum pmu_impl impl)
 {
-	pr_debug("Error test with pmcr_n %lu (larger than the host)\n", pmcr_n);
+	pr_debug("Error test with pmcr_n %lu (larger than the host allows)\n", pmcr_n);
 
-	test_create_vpmu_vm_with_pmcr_n(pmcr_n, true);
+	test_create_vpmu_vm_with_pmcr_n(pmcr_n, impl, true);
 	destroy_vpmu_vm();
 }
 
@@ -619,30 +634,42 @@ static void run_error_test(uint64_t pmcr_n)
  * Return the default number of implemented PMU event counters excluding
  * the cycle counter (i.e. PMCR_EL0.N value) for the guest.
  */
-static uint64_t get_pmcr_n_limit(void)
+static uint64_t get_pmcr_n_limit(enum pmu_impl impl)
 {
 	uint64_t pmcr;
 
-	create_vpmu_vm(guest_code);
+	create_vpmu_vm(guest_code, impl);
 	pmcr = vcpu_get_reg(vpmu_vm.vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0));
 	destroy_vpmu_vm();
 	return get_pmcr_n(pmcr);
 }
 
-int main(void)
+void test_pmu(enum pmu_impl impl)
 {
 	uint64_t i, pmcr_n;
 
-	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
+	pr_info("Testing PMU: Implementation = %s\n", pmu_impl_str[impl]);
+
+	pmcr_n = get_pmcr_n_limit(impl);
+	pr_debug("PMCR_EL0.N: Limit = %lu\n", pmcr_n);
 
-	pmcr_n = get_pmcr_n_limit();
 	for (i = 0; i <= pmcr_n; i++) {
-		run_access_test(i);
-		run_pmregs_validity_test(i);
+		run_access_test(i, impl);
+		run_pmregs_validity_test(i, impl);
 	}
 
 	for (i = pmcr_n + 1; i < ARMV8_PMU_MAX_COUNTERS; i++)
-		run_error_test(i);
+		run_error_test(i, impl);
+}
+
+int main(void)
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
+
+	test_pmu(EMULATED);
+
+	if (kvm_has_cap(KVM_CAP_ARM_PARTITION_PMU))
+		test_pmu(PARTITIONED);
 
 	return 0;
 }
-- 
2.50.0.714.g196bf9f422-goog


