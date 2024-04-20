Return-Path: <linux-kselftest+bounces-8506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901D28AB7E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42AF1C20FD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40079152DFE;
	Fri, 19 Apr 2024 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DTPbIl0m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5771215216D
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570508; cv=none; b=rAowPOGXuRdAUMwsIHiSxCOF6KMFZv2odRd9L+4BNlVHPFMsHzJTBpJNtws5TAoBZgHTqHufxYH86FbIebaoaCyip6gAyP/WxIlvCFm7fJFWhLYwkyLy+m9BJ7rKGLqGZccrKgk+sgmhNFw483qInXodvPrIkbg+mJ1hznv9JcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570508; c=relaxed/simple;
	bh=qmxHl8vxeYn5DtrysL1MX7I/gk/fpV99jP4XgJO/9GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSTc4STKE39TlsDAWRvI9j4GSJV4fsu/meidv/LzHIVINNcOGCaQYivR2uZ7oLolG2BxQlfx2TRzAnW/hHwJQXgBKbCjGMupW75JTOBg/AhjKHtLll2Wv060mIKdnPZZmHKdfg1Bay8qE76oM+1ATg2nSP/jHpG/NarAmBKUtj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DTPbIl0m; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e8fce77bb2so5920335ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570505; x=1714175305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/mZsCXDIiEsYT4IyH2AIBXmm9ZHxCdzgU5y8aMm+wo=;
        b=DTPbIl0m9ZolfsGUydKmDsFqaqMDRQW3bvD/wNSE5FpcYjRWoY+eSPWwfwWOUlCqay
         aMbotWHXeH4rwOFfqFB0nr3JvNpQjhJnYiP5keC5hUVMaz7o9ictyQIwP6+1Z2DczHxM
         sUjnO1qQb0myBKxZIgFkkoUhli0kwqpUszIYYXrnpcqT3yAH43CYcxphmOHP0DfhZXYG
         DyEGNxWquCw8i1uqhSnoWHR5+7QDjHRetnwHzQy8HH2Qj2s61Iu44ZUqDzcH/G28rHsx
         JuMEaVZtdo+EPN8rmZ/Bbn8g/suPPhKSGAWgDd0SdFp6Y/aIWiZvpI1rfNNLaHulynD9
         WvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570505; x=1714175305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/mZsCXDIiEsYT4IyH2AIBXmm9ZHxCdzgU5y8aMm+wo=;
        b=hq7D3fm6qxIFFMGdWeVrP5+bMz0J49bY3gUuk7c9PbtXgfrIvLUMYr6g5sCDTGIOeY
         XwUDT2jKrWX5ok93vuU2ufbvLAUufCTVxAyf+oK0Grs3OX4x4Ggi0b1f3F1OtJTNZ3To
         vv6sdiF66uPg2JYPJe/HCASRks7+DIFI3Bc5DrrQj9Fv5CbHgzD1pcOI+7c8dZ+4gFW2
         ZPnTVtFHRFLQOx9FVVnOwzkbct3ZqDvOJPOTt+aOBLawAg0V5IpW8AOb218pO1sELWFt
         /3OPaRwbISEjqEaFDOq0jE2CgfDGvawqGhxfAJYdAWZCF0YZ2++0QWznINmcRSrM4em7
         3brg==
X-Forwarded-Encrypted: i=1; AJvYcCVNklnl1W8Dn4mdeBEyr2Ix/ZccVZ+FTjYkiJ/2Kjb3d2rUalYm/RGkZyqNUvBj4hYyRnWSGefSa0pJgVBtsQj3pcr15q09pJQgxOQB03rW
X-Gm-Message-State: AOJu0YxEaXpor3B/8K4N0lFm93mNXoiB98YEJaPxd+m0BnZDOKXvg8/d
	txrsPABKHn1OFWkcsY7CK4O1IvyWGC2520PzF0bZwvw/hX+IOtdMjrmDX7J9XOI=
X-Google-Smtp-Source: AGHT+IF+aoD5WgVZpoEDtEmpVoIMpg0OJuDqmNC+S8wL2PSmvGrxxoIhzREjLcyxzn9Zxh9U5qFFPg==
X-Received: by 2002:a17:902:7286:b0:1e7:7832:386c with SMTP id d6-20020a170902728600b001e77832386cmr3679550pll.52.1713570504749;
        Fri, 19 Apr 2024 16:48:24 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:24 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	samuel.holland@sifive.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v8 22/24] KVM: riscv: selftests: Add a test for PMU snapshot functionality
Date: Sat, 20 Apr 2024 08:17:38 -0700
Message-Id: <20240420151741.962500-23-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify PMU snapshot functionality by setting up the shared memory
correctly and reading the counter values from the shared memory
instead of the CSR.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../testing/selftests/kvm/include/riscv/sbi.h |  25 +++
 .../selftests/kvm/lib/riscv/processor.c       |  12 ++
 .../selftests/kvm/riscv/sbi_pmu_test.c        | 144 ++++++++++++++++++
 3 files changed, 181 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
index 6675ca673c77..046b432ae896 100644
--- a/tools/testing/selftests/kvm/include/riscv/sbi.h
+++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
@@ -8,6 +8,12 @@
 #ifndef SELFTEST_KVM_SBI_H
 #define SELFTEST_KVM_SBI_H
 
+/* SBI spec version fields */
+#define SBI_SPEC_VERSION_DEFAULT	0x1
+#define SBI_SPEC_VERSION_MAJOR_SHIFT	24
+#define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
+#define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
+
 /* SBI return error codes */
 #define SBI_SUCCESS				 0
 #define SBI_ERR_FAILURE				-1
@@ -33,6 +39,9 @@ enum sbi_ext_id {
 };
 
 enum sbi_ext_base_fid {
+	SBI_EXT_BASE_GET_SPEC_VERSION = 0,
+	SBI_EXT_BASE_GET_IMP_ID,
+	SBI_EXT_BASE_GET_IMP_VERSION,
 	SBI_EXT_BASE_PROBE_EXT = 3,
 };
 enum sbi_ext_pmu_fid {
@@ -60,6 +69,12 @@ union sbi_pmu_ctr_info {
 	};
 };
 
+struct riscv_pmu_snapshot_data {
+	u64 ctr_overflow_mask;
+	u64 ctr_values[64];
+	u64 reserved[447];
+};
+
 struct sbiret {
 	long error;
 	long value;
@@ -113,4 +128,14 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 
 bool guest_sbi_probe_extension(int extid, long *out_val);
 
+/* Make SBI version */
+static inline unsigned long sbi_mk_version(unsigned long major,
+					    unsigned long minor)
+{
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT)
+		| (minor & SBI_SPEC_VERSION_MINOR_MASK);
+}
+
+unsigned long get_host_sbi_spec_version(void);
+
 #endif /* SELFTEST_KVM_SBI_H */
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index e8211f5d6863..ccb35573749c 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -502,3 +502,15 @@ bool guest_sbi_probe_extension(int extid, long *out_val)
 
 	return true;
 }
+
+unsigned long get_host_sbi_spec_version(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION, 0,
+		       0, 0, 0, 0, 0);
+
+	GUEST_ASSERT(!ret.error);
+
+	return ret.value;
+}
diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 7c81691e39c5..9002ff451abf 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -19,6 +19,11 @@
 #define RISCV_MAX_PMU_COUNTERS 64
 union sbi_pmu_ctr_info ctrinfo_arr[RISCV_MAX_PMU_COUNTERS];
 
+/* Snapshot shared memory data */
+#define PMU_SNAPSHOT_GPA_BASE		BIT(30)
+static void *snapshot_gva;
+static vm_paddr_t snapshot_gpa;
+
 /* Cache the available counters in a bitmask */
 static unsigned long counter_mask_available;
 
@@ -186,6 +191,32 @@ static unsigned long read_counter(int idx, union sbi_pmu_ctr_info ctrinfo)
 	return counter_val;
 }
 
+static inline void verify_sbi_requirement_assert(void)
+{
+	long out_val = 0;
+	bool probe;
+
+	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
+	GUEST_ASSERT(probe && out_val == 1);
+
+	if (get_host_sbi_spec_version() < sbi_mk_version(2, 0))
+		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");
+}
+
+static void snapshot_set_shmem(vm_paddr_t gpa, unsigned long flags)
+{
+	unsigned long lo = (unsigned long)gpa;
+#if __riscv_xlen == 32
+	unsigned long hi = (unsigned long)(gpa >> 32);
+#else
+	unsigned long hi = gpa == -1 ? -1 : 0;
+#endif
+	struct sbiret ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
+				      lo, hi, flags, 0, 0, 0);
+
+	GUEST_ASSERT(ret.value == 0 && ret.error == 0);
+}
+
 static void test_pmu_event(unsigned long event)
 {
 	unsigned long counter;
@@ -234,6 +265,59 @@ static void test_pmu_event(unsigned long event)
 	stop_reset_counter(counter, 0);
 }
 
+static void test_pmu_event_snapshot(unsigned long event)
+{
+	unsigned long counter;
+	unsigned long counter_value_pre, counter_value_post;
+	unsigned long counter_init_value = 100;
+	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
+
+	counter = get_counter_index(0, counter_mask_available, 0, event);
+	counter_value_pre = read_counter(counter, ctrinfo_arr[counter]);
+
+	/* Do not set the initial value */
+	start_counter(counter, 0, 0);
+	dummy_func_loop(10000);
+	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
+
+	/* The counter value is updated w.r.t relative index of cbase */
+	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
+	__GUEST_ASSERT(counter_value_post > counter_value_pre,
+		       "Event update verification failed: post [%lx] pre [%lx]\n",
+		       counter_value_post, counter_value_pre);
+
+	/*
+	 * We can't just update the counter without starting it.
+	 * Do start/stop twice to simulate that by first initializing to a very
+	 * high value and a low value after that.
+	 */
+	WRITE_ONCE(snapshot_data->ctr_values[0], ULONG_MAX/2);
+	start_counter(counter, SBI_PMU_START_FLAG_INIT_SNAPSHOT, 0);
+	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
+	counter_value_pre = READ_ONCE(snapshot_data->ctr_values[0]);
+
+	WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
+	start_counter(counter, SBI_PMU_START_FLAG_INIT_SNAPSHOT, 0);
+	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
+	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
+	__GUEST_ASSERT(counter_value_pre > counter_value_post,
+		       "Counter reinitialization verification failed : post [%lx] pre [%lx]\n",
+		       counter_value_post, counter_value_pre);
+
+	/* Now set the initial value and compare */
+	WRITE_ONCE(snapshot_data->ctr_values[0], counter_init_value);
+	start_counter(counter, SBI_PMU_START_FLAG_INIT_SNAPSHOT, 0);
+	dummy_func_loop(10000);
+	stop_counter(counter, SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT);
+
+	counter_value_post = READ_ONCE(snapshot_data->ctr_values[0]);
+	__GUEST_ASSERT(counter_value_post > counter_init_value,
+		       "Event update verification failed: post [%lx] pre [%lx]\n",
+		       counter_value_post, counter_init_value);
+
+	stop_reset_counter(counter, 0);
+}
+
 static void test_invalid_event(void)
 {
 	struct sbiret ret;
@@ -301,6 +385,34 @@ static void test_pmu_basic_sanity(void)
 	GUEST_DONE();
 }
 
+static void test_pmu_events_snaphost(void)
+{
+	int num_counters = 0;
+	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
+	int i;
+
+	/* Verify presence of SBI PMU and minimum requrired SBI version */
+	verify_sbi_requirement_assert();
+
+	snapshot_set_shmem(snapshot_gpa, 0);
+
+	/* Get the counter details */
+	num_counters = get_num_counters();
+	update_counter_info(num_counters);
+
+	/* Validate shared memory access */
+	GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_overflow_mask), 0);
+	for (i = 0; i < num_counters; i++) {
+		if (counter_mask_available & (BIT(i)))
+			GUEST_ASSERT_EQ(READ_ONCE(snapshot_data->ctr_values[i]), 0);
+	}
+	/* Only these two events are guranteed to be present */
+	test_pmu_event_snapshot(SBI_PMU_HW_CPU_CYCLES);
+	test_pmu_event_snapshot(SBI_PMU_HW_INSTRUCTIONS);
+
+	GUEST_DONE();
+}
+
 static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
@@ -357,6 +469,35 @@ static void test_vm_events_test(void *guest_code)
 	test_vm_destroy(vm);
 }
 
+static void test_vm_setup_snapshot_mem(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	/* PMU Snapshot requires single page only */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, PMU_SNAPSHOT_GPA_BASE, 1, 1, 0);
+	/* PMU_SNAPSHOT_GPA_BASE is identity mapped */
+	virt_map(vm, PMU_SNAPSHOT_GPA_BASE, PMU_SNAPSHOT_GPA_BASE, 1);
+
+	snapshot_gva = (void *)(PMU_SNAPSHOT_GPA_BASE);
+	snapshot_gpa = addr_gva2gpa(vcpu->vm, (vm_vaddr_t)snapshot_gva);
+	sync_global_to_guest(vcpu->vm, snapshot_gva);
+	sync_global_to_guest(vcpu->vm, snapshot_gpa);
+}
+
+static void test_vm_events_snapshot_test(void *guest_code)
+{
+	struct kvm_vm *vm = NULL;
+	struct kvm_vcpu *vcpu;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	__TEST_REQUIRE(__vcpu_has_sbi_ext(vcpu, KVM_RISCV_SBI_EXT_PMU),
+				   "SBI PMU not available, skipping test");
+
+	test_vm_setup_snapshot_mem(vm, vcpu);
+
+	run_vcpu(vcpu);
+
+	test_vm_destroy(vm);
+}
+
 int main(void)
 {
 	test_vm_basic_test(test_pmu_basic_sanity);
@@ -365,5 +506,8 @@ int main(void)
 	test_vm_events_test(test_pmu_events);
 	pr_info("SBI PMU event verification test : PASS\n");
 
+	test_vm_events_snapshot_test(test_pmu_events_snaphost);
+	pr_info("SBI PMU event verification with snapshot test : PASS\n");
+
 	return 0;
 }
-- 
2.34.1


