Return-Path: <linux-kselftest+bounces-34769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9FAD610F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E7357ADBEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A625A64C;
	Wed, 11 Jun 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clHW15g6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57FA2571DF
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676635; cv=none; b=kPHQG7tweQsmy0y38zrnVppcG65oDO7oi5RQxFJ0l1TcZ9eq1taSVES1SNkvBe65gWVRW6MeRXzScyNH6v8qCi8K+rEDpa4WxfTXT8w3jk7lTIttMNyorWuHfJHOK2b1/Zt3qUwRG6Uphw8ENdtlTmPt02fx2N2tDTRqDX3V4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676635; c=relaxed/simple;
	bh=lE6nUOIrKb4G9fRr4Fu+box3ulN6PQJB0SdDXJ5axmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d+RrCMazLYeWB1KdfkgI/LQ4OmyIx+2D5Mpl8tTyN1hcQrK0E6BS7AKWASBlvetF3YLxz/MxgZ/Dt/jxe7wubzZFg4g4e3pHS39yaJLx0o/Fc2ZJj5JHbGRGg9mh2exMSq+RG4gG/CHTwqqyWe6b8XjMFtVKenKUQR2EIgk36G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clHW15g6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26db9af463so199556a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749676632; x=1750281432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6jtteubntBQN2p3kF5NvnYpZ0T18nDw91+DVALzqP8=;
        b=clHW15g6nMAIEe05bx4UKcajDHkPzhzaLIH8m1Lm3JVQKS8sNI3HtPuOqAHJ2q6lez
         rexYKQfTofnvda8gQCrwhgpqE+e7mv+TVAaGpAgKbYl/ImUv8m1xDNRCLqya2+BaFqJG
         fvNCLzhE1dVeUNbr+AZcHZuNijms3Z06GkDDk8YU4mfzQfZzT+b8jfHptiAZ/agPC2Qj
         b/GzOkzlE87s62fozUN6ZQjIoOO1peBlw7rHoRo1H0tw5gNafCRFVMqGX3S+XNW2LLzx
         q+xgnbzrb661auxG5942JE8jJKQ+HZpFGTLtvK25Xbshr0bqhTCqZ30Qmu+k7fNLfypU
         RRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676632; x=1750281432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6jtteubntBQN2p3kF5NvnYpZ0T18nDw91+DVALzqP8=;
        b=X5S5XkIkXw8wWSKCTKkN446ooC+x7g32c19xOv2Q6fr1pTWK+EYsRbFl8Z6yCSa4Za
         E2iNwS7HefCyaY1IA0WRBm7yYZaI2TPCtnGpmufSDz6W4IQ5OqjfhFeXNtjX2sNCAlOc
         yafpxh2QH36kze8Gdv50pchWkdYCIoGpCBQjG65/Qmyr7C86Bzn/E+hm8BP4PTpqSsz/
         wU+JoIpJymWkCgTJq5fOJvoF7mmN2JnXCN79iqpc2USbRMnJGZBaEZsxhQMi9zYNkhUp
         rRODrsSRIkcz0mICBSTseatVsPgrjk8bmryFteYxutNaD54vH6fLULl9x2e7EM+2NJrF
         02yA==
X-Forwarded-Encrypted: i=1; AJvYcCW85QGVdMwfGyhKMXhe4j9JieYivDxorg7aZlVSkKNwb6ikZAdb2+hLX8Wj/OMhvC0gg/pm0R4TfVSolISxE1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvYVLzzLt2HBVMpsslLG41033O5ojRrze9vrGEDtouAR0LIjTC
	iH+f+G00eAd3mKNwrGaoEqUp/G1flX43WL7z/CtBCmot91Q9LynGYBTPRz3zPG0+auTyUEyMnpT
	vD8g15B38HA==
X-Google-Smtp-Source: AGHT+IEr8iX/cIgcvsGYjAWSEZKLzLBYLe9qYqD9d7H++gZpo2ukhpqL6kw+SW8ooyNprJAB1kFZlg6/m6pQ
X-Received: from pgdu24.prod.google.com ([2002:a05:6a02:2f58:b0:b2f:b096:8b5a])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431c:b0:201:85f4:ade6
 with SMTP id adf61e73a8af0-21f9b8f4694mr394232637.27.1749676632082; Wed, 11
 Jun 2025 14:17:12 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:16:37 +0000
In-Reply-To: <cover.1749672978.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1749672978.git.afranji@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <c95acb18a40593e398747395cf7e92877a1805b7.1749672978.git.afranji@google.com>
Subject: [RFC PATCH v2 10/10] KVM: selftests: Add irqfd/interrupts test for
 TDX with migration
From: Ryan Afranji <afranji@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: sagis@google.com, bp@alien8.de, chao.p.peng@linux.intel.com, 
	dave.hansen@linux.intel.com, dmatlack@google.com, erdemaktas@google.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de, 
	zhi.wang.linux@gmail.com, ackerleytng@google.com, andrew.jones@linux.dev, 
	david@redhat.com, hpa@zytor.com, kirill.shutemov@linux.intel.com, 
	linux-kselftest@vger.kernel.org, tabba@google.com, vannapurve@google.com, 
	yan.y.zhao@intel.com, rick.p.edgecombe@intel.com, 
	Ryan Afranji <afranji@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Adds a selftest to verify interrupts sent to a TDX VM before migration
are successfully handled by the migrated VM.

Co-developed-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   4 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |   2 +
 .../selftests/kvm/include/x86/tdx/test_util.h |   5 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  35 ++-
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      |  20 ++
 .../selftests/kvm/lib/x86/tdx/test_util.c     |  17 ++
 .../kvm/x86/tdx_irqfd_migrate_test.c          | 264 ++++++++++++++++++
 .../selftests/kvm/x86/tdx_migrate_tests.c     |  21 --
 9 files changed, 343 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_irqfd_migrate_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d4c8cfb5910f..4ae0d105c2a7 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -156,6 +156,7 @@ TEST_GEN_PROGS_x86 += x86/tdx_vm_test
 TEST_GEN_PROGS_x86 += x86/tdx_shared_mem_test
 TEST_GEN_PROGS_x86 += x86/tdx_upm_test
 TEST_GEN_PROGS_x86 += x86/tdx_migrate_tests
+TEST_GEN_PROGS_x86 += x86/tdx_irqfd_migrate_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 8b252a668c78..f93ac2b9b0ff 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -80,6 +80,7 @@ enum kvm_mem_region_type {
 	MEM_REGION_PT,
 	MEM_REGION_TEST_DATA,
 	MEM_REGION_TDX_BOOT_PARAMS,
+	MEM_REGION_TDX_SHARED_DATA,
 	MEM_REGION_UCALL,
 	NR_MEM_REGIONS,
 };
@@ -958,6 +959,9 @@ int _kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
 struct kvm_irq_routing *kvm_gsi_routing_create(void);
 void kvm_gsi_routing_irqchip_add(struct kvm_irq_routing *routing,
 		uint32_t gsi, uint32_t pin);
+void kvm_gsi_routing_msi_add(struct kvm_irq_routing *routing, uint32_t gsi,
+			     uint32_t address_lo, uint32_t address_hi,
+			     uint32_t data);
 int _kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 9b495e621225..4393c8649718 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -10,6 +10,8 @@ extern uint64_t tdx_s_bit;
 void tdx_filter_cpuid(struct kvm_vm *vm, struct kvm_cpuid2 *cpuid_data);
 void __tdx_mask_cpuid_features(struct kvm_cpuid_entry2 *entry);
 void tdx_enable_capabilities(struct kvm_vm *vm);
+int __tdx_migrate_from(int dst_fd, int src_fd);
+void tdx_migrate_from(struct kvm_vm *dst_vm, struct kvm_vm *src_vm);
 
 struct kvm_vcpu *td_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id, void *guest_code);
 
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
index 3330d5a54698..0dd859974cb3 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
@@ -130,4 +130,9 @@ uint64_t tdx_test_read_64bit(struct kvm_vcpu *vcpu, uint64_t port);
  */
 uint64_t tdx_test_read_64bit_report_from_guest(struct kvm_vcpu *vcpu);
 
+/*
+ * Enables X2APIC for TDX guests.
+ */
+void tdx_guest_x2apic_enable(void);
+
 #endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9dc3c7bf0443..bbb489635064 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1293,10 +1293,12 @@ static void vm_migrate_mem_region(struct kvm_vm *dst_vm, struct kvm_vm *src_vm,
 				  struct userspace_mem_region *src_region)
 {
 	struct userspace_mem_region *dst_region;
-	int dst_guest_memfd;
+	int dst_guest_memfd = -1;
 
-	dst_guest_memfd =
-		vm_link_guest_memfd(dst_vm, src_region->region.guest_memfd, 0);
+	if (src_region->region.guest_memfd != -1)
+		dst_guest_memfd = vm_link_guest_memfd(dst_vm,
+						      src_region->region.guest_memfd,
+						      0);
 
 	dst_region = vm_mem_region_alloc(
 			dst_vm, src_region->region.guest_phys_addr,
@@ -1312,8 +1314,12 @@ static void vm_migrate_mem_region(struct kvm_vm *dst_vm, struct kvm_vm *src_vm,
 	src_region->host_mem = 0;
 
 	dst_region->region.guest_memfd = dst_guest_memfd;
-	dst_region->region.guest_memfd_offset =
-		src_region->region.guest_memfd_offset;
+	if (src_region->region.guest_memfd == -1) {
+		dst_region->fd = src_region->fd;
+	} else {
+		dst_region->region.guest_memfd_offset =
+			src_region->region.guest_memfd_offset;
+	}
 
 	userspace_mem_region_commit(dst_vm, dst_region);
 }
@@ -2057,6 +2063,25 @@ void kvm_gsi_routing_irqchip_add(struct kvm_irq_routing *routing,
 	routing->nr++;
 }
 
+void kvm_gsi_routing_msi_add(struct kvm_irq_routing *routing, uint32_t gsi,
+			     uint32_t address_lo, uint32_t address_hi,
+			     uint32_t data)
+{
+	int i;
+
+	assert(routing);
+	assert(routing->nr < KVM_MAX_IRQ_ROUTES);
+
+	i = routing->nr;
+	routing->entries[i].gsi = gsi;
+	routing->entries[i].type = KVM_IRQ_ROUTING_MSI;
+	routing->entries[i].flags = 0;
+	routing->entries[i].u.msi.address_lo = address_lo;
+	routing->entries[i].u.msi.address_hi = address_hi;
+	routing->entries[i].u.msi.data = data;
+	routing->nr++;
+}
+
 int _kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing)
 {
 	int ret;
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index a3612bf187a0..8216a778474a 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -372,6 +372,26 @@ static void tdx_apply_cr4_restrictions(struct kvm_sregs *sregs)
 	sregs->cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
 }
 
+int __tdx_migrate_from(int dst_fd, int src_fd)
+{
+	struct kvm_enable_cap cap = {
+		.cap = KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM,
+		.args = { src_fd }
+	};
+
+	return ioctl(dst_fd, KVM_ENABLE_CAP, &cap);
+}
+
+void tdx_migrate_from(struct kvm_vm *dst_vm, struct kvm_vm *src_vm)
+{
+	int ret;
+
+	vm_migrate_mem_regions(dst_vm, src_vm);
+	ret = __tdx_migrate_from(dst_vm->fd, src_vm->fd);
+	TEST_ASSERT(!ret, "Migration failed, ret: %d, errno: %d\n", ret, errno);
+	src_vm->enc_migrated = true;
+}
+
 static void load_td_boot_code(struct kvm_vm *vm)
 {
 	void *boot_code_hva = addr_gpa2hva(vm, FOUR_GIGABYTES_GPA - TD_BOOT_CODE_SIZE);
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
index f92ddda2d1ac..7b622ccb2433 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
@@ -6,6 +6,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include "apic.h"
 #include "kvm_util.h"
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
@@ -185,3 +186,19 @@ uint64_t tdx_test_read_64bit_report_from_guest(struct kvm_vcpu *vcpu)
 {
 	return tdx_test_read_64bit(vcpu, TDX_TEST_REPORT_PORT);
 }
+
+void tdx_guest_x2apic_enable(void)
+{
+	uint64_t x2apic_spiv = APIC_BASE_MSR + (APIC_SPIV >> 4);
+	uint64_t value, ret;
+
+	/*
+	 * x2apic does not have to be enabled for TDs, TDs already have x2apic
+	 * enabled, and must use x2apic. Hence, we just soft-enable APIC.
+	 */
+	ret = tdg_vp_vmcall_instruction_rdmsr(x2apic_spiv, &value);
+	GUEST_ASSERT_EQ(ret, 0);
+	ret = tdg_vp_vmcall_instruction_wrmsr(x2apic_spiv,
+					      value | APIC_SPIV_APIC_ENABLED);
+	GUEST_ASSERT_EQ(ret, 0);
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_irqfd_migrate_test.c b/tools/testing/selftests/kvm/x86/tdx_irqfd_migrate_test.c
new file mode 100644
index 000000000000..d80cc204bd67
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/tdx_irqfd_migrate_test.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdint.h>
+#include <stdio.h>
+#include <linux/kvm.h>
+#include <string.h>
+#include <sys/eventfd.h>
+
+#include "apic.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "tdx/tdcall.h"
+#include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
+#include "tdx/test_util.h"
+#include "test_util.h"
+#include "ucall_common.h"
+
+#define TEST_IRQ_PIN 24
+
+#define NUM_INTERRUPTS 256
+#define INTERRUPT_COUNT_GPA 0x100000000ULL
+#define INTERRUPT_COUNT_MEMSLOT 5
+
+#define MIGRATION_LOOPS 10
+
+static uint32_t (*interrupt_count_per_vector)[NUM_INTERRUPTS];
+
+static void interrupt_handler_increment_count(struct ex_regs *regs)
+{
+	(*interrupt_count_per_vector)[regs->vector]++;
+	x2apic_write_reg(APIC_EOI, 0);
+}
+
+static void guest_code(void)
+{
+	uint32_t sync_count = 0;
+
+	tdx_guest_x2apic_enable();
+
+	/* Enable interrupts which are disabled by default. */
+	asm volatile("sti");
+
+	/* Keep guest runnable by continuously looping. */
+	while (true)
+		GUEST_SYNC(++sync_count);
+}
+
+/**
+ * gsi_route_add - Used to add a GSI route.
+ *
+ * @msi_redir_hint: Look up "Message Address Register Format" in Intel SDM
+ * @dest_mode: Look up "Message Address Register Format" in Intel SDM
+ *             Use false for DM=0 and true for DM=1
+ * @trig_mode: Look up "Message Data Register Format" in Intel SDM
+ *             Use false for edge sensitive and true for level sensitive
+ * @delivery_mode: A 3 bit code: look up "Message Data Register Format"
+ *
+ * Add a route by building up the routing information in address_hi, address_lo
+ * and data according to how it is used in struct kvm_lapic_irq. For full
+ * details, look up how fields in struct kvm_lapic_irq are used.
+ *
+ * Return: None
+ */
+static void gsi_route_add(struct kvm_irq_routing *table, uint32_t gsi,
+			  bool use_x2apic_format, uint32_t dest_id,
+			  uint8_t vector, bool msi_redir_hint, bool dest_mode,
+			  bool trig_mode, uint8_t delivery_mode)
+{
+	union {
+		struct {
+			u32 vector : 8, delivery_mode : 3,
+			dest_mode_logical : 1, reserved : 2,
+			active_low : 1, is_level : 1;
+		};
+		uint32_t as_uint32;
+	} data = { 0 };
+	union {
+		struct {
+			u32 reserved_0 : 2, dest_mode_logical : 1,
+			    redirect_hint : 1, reserved_1 : 1,
+			    virt_destid_8_14 : 7, destid_0_7 : 8,
+			    base_address : 12;
+		};
+		uint32_t as_uint32;
+	} address_lo = { 0 };
+	union {
+		struct {
+			u32 reserved : 8, destid_8_31 : 24;
+		};
+		uint32_t as_uint32;
+	} address_hi = { 0 };
+
+	/* Fixed 0xfee (see Intel SDM "Message Address Register Format") */
+	address_lo.base_address = 0xfee;
+
+	address_lo.destid_0_7 = dest_id & 0xff;
+	if (use_x2apic_format)
+		address_hi.destid_8_31 = (dest_id & 0xffffff00) >> 8;
+
+	data.vector = vector;
+	address_lo.dest_mode_logical = dest_mode;
+	data.is_level = trig_mode;
+	data.delivery_mode = delivery_mode & 0b111;
+	address_lo.redirect_hint = msi_redir_hint;
+
+	kvm_gsi_routing_msi_add(table, gsi, address_lo.as_uint32,
+				address_hi.as_uint32, data.as_uint32);
+}
+
+/**
+ * Sets up KVM irqfd in @vm
+ *
+ * @gsi: irqchip pin toggled by this event
+ */
+static void set_irqfd(struct kvm_vm *vm, int fd, uint32_t gsi, bool assign)
+{
+	struct kvm_irqfd ifd = {
+		.fd = fd,
+		.gsi = gsi,
+		.flags = assign ? 0 : KVM_IRQFD_FLAG_DEASSIGN,
+		.resamplefd = 0,
+	};
+
+	vm_ioctl(vm, KVM_IRQFD, &ifd);
+}
+
+static void setup_interrupt_count_per_vector(struct kvm_vm *vm)
+{
+	vm_vaddr_t gva;
+	int npages;
+
+	npages = round_up(sizeof(*interrupt_count_per_vector), PAGE_SIZE);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    INTERRUPT_COUNT_GPA,
+				    INTERRUPT_COUNT_MEMSLOT, npages, 0);
+	vm->memslots[MEM_REGION_TDX_SHARED_DATA] = INTERRUPT_COUNT_MEMSLOT;
+
+	gva = vm_vaddr_alloc_shared(vm, sizeof(*interrupt_count_per_vector),
+				    KVM_UTIL_MIN_VADDR,
+				    MEM_REGION_TDX_SHARED_DATA);
+
+	interrupt_count_per_vector = addr_gva2hva(vm, gva);
+	memset(interrupt_count_per_vector, 0,
+	       sizeof(*interrupt_count_per_vector));
+
+	write_guest_global(vm, interrupt_count_per_vector,
+			   (uint32_t(*)[NUM_INTERRUPTS])gva);
+}
+
+static void handle_vcpu_exit(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected exit: %s",
+			  exit_reason_str(vcpu->run->exit_reason));
+	}
+}
+
+void map_gsis_to_vectors(struct kvm_vm *vm, struct kvm_vcpu *vcpu, int *eventfds)
+{
+	struct kvm_irq_routing *table;
+	uint32_t vector_and_gsi;
+	int efd;
+
+	/* Flush table first. */
+	table = kvm_gsi_routing_create();
+	kvm_gsi_routing_write(vm, table);
+
+	/* Writing frees table, so we have to create another one. */
+	table = kvm_gsi_routing_create();
+
+	/* Map vectors to gsis 1 to 1 */
+	for (vector_and_gsi = 32; vector_and_gsi < NUM_INTERRUPTS;
+	     ++vector_and_gsi) {
+		gsi_route_add(table, vector_and_gsi,
+			      /*use_x2apic_format=*/true,
+			      /*dest_id=*/vcpu->id,
+			      /*vector=*/vector_and_gsi,
+			      /*msi_redir_hint=*/false,
+			      /*dest_mode=*/false,
+			      /*trig_mode=*/false,
+			      /*delivery_mode=*/0b000);
+
+		efd = eventfd(0, EFD_NONBLOCK);
+		set_irqfd(vm, efd, vector_and_gsi, true);
+
+		eventfds[vector_and_gsi] = efd;
+	}
+
+	/* Configure KVM. Writing frees table. */
+	kvm_gsi_routing_write(vm, table);
+
+}
+
+int main(int argc, char *argv[])
+{
+	int eventfds[NUM_INTERRUPTS] = { 0 };
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int vector, migration;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_SPLIT_IRQCHIP));
+
+	setbuf(stdout, NULL);
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+
+	vcpu = td_vcpu_add(vm, 0, guest_code);
+
+	for (vector = 0; vector < NUM_INTERRUPTS; ++vector) {
+		vm_install_exception_handler(vm, vector,
+					     interrupt_handler_increment_count);
+	}
+
+	setup_interrupt_count_per_vector(vm);
+
+	td_finalize(vm);
+
+	map_gsis_to_vectors(vm, vcpu, eventfds);
+
+	tdx_run(vcpu);
+	handle_vcpu_exit(vcpu);
+
+	for (migration = 0; migration < MIGRATION_LOOPS; ++migration) {
+		struct kvm_vcpu *next_vcpu;
+		struct kvm_vm *next_vm;
+
+		next_vm = td_create();
+		tdx_enable_capabilities(next_vm);
+		next_vcpu = vm_vcpu_recreate(next_vm, 0);
+
+		/* Inject on source VM. */
+		for (vector = 32; vector < NUM_INTERRUPTS; ++vector)
+			TEST_ASSERT_EQ(eventfd_write(eventfds[vector], 1), 0);
+
+		map_gsis_to_vectors(next_vm, next_vcpu, eventfds);
+
+		vcpu = next_vcpu;
+
+		tdx_migrate_from(next_vm, vm);
+		kvm_vm_free(vm);
+		vm = next_vm;
+
+		tdx_run(vcpu);
+		handle_vcpu_exit(vcpu);
+
+		for (vector = 32; vector < NUM_INTERRUPTS; ++vector)
+			TEST_ASSERT_EQ((*interrupt_count_per_vector)[vector],
+				       migration + 1);
+	}
+
+	kvm_vm_free(vm);
+	for (vector = 32; vector < NUM_INTERRUPTS; ++vector)
+		close(eventfds[vector]);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_migrate_tests.c b/tools/testing/selftests/kvm/x86/tdx_migrate_tests.c
index e15da2aa0437..498e42f37697 100644
--- a/tools/testing/selftests/kvm/x86/tdx_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86/tdx_migrate_tests.c
@@ -10,27 +10,6 @@
 #define NR_MIGRATE_TEST_VMS 10
 #define TDX_IOEXIT_TEST_PORT 0x50
 
-static int __tdx_migrate_from(int dst_fd, int src_fd)
-{
-	struct kvm_enable_cap cap = {
-		.cap = KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM,
-		.args = { src_fd }
-	};
-
-	return ioctl(dst_fd, KVM_ENABLE_CAP, &cap);
-}
-
-
-static void tdx_migrate_from(struct kvm_vm *dst_vm, struct kvm_vm *src_vm)
-{
-	int ret;
-
-	vm_migrate_mem_regions(dst_vm, src_vm);
-	ret = __tdx_migrate_from(dst_vm->fd, src_vm->fd);
-	TEST_ASSERT(!ret, "Migration failed, ret: %d, errno: %d\n", ret, errno);
-	src_vm->enc_migrated = true;
-}
-
 void guest_code(void)
 {
 	int ret;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


