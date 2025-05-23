Return-Path: <linux-kselftest+bounces-33727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC15CAC2C6B
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9166DA4082E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8981D22DF9F;
	Fri, 23 May 2025 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKFwn/vT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF222B8A2
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043077; cv=none; b=ipMjtWZe11ZjB+1OBeTrU6Ndq/sUYXfCQ/emUiJpNGKHhhlHCb2FJkMgviHNyIb2bla48JLcF3aDwJiy2+5XxWR0UJepblzjjN1uQNXdQUAn6Pe3Aka+k0xaaX9RKR/I6pCHC00uGq5B8VUD65luHuL3jREsOLBSR1BNfzBgBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043077; c=relaxed/simple;
	bh=7rRBY86PTObo3oEj6GtRFKOFWd3Gm261npT8EREiQ40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UFTFMj2WPyihnsq4zLQSy1QnGjeOySrA4dTtVwG6w9I14NhZzmWTgJ3ngpEhWxWI/PZoCM/Q27E1kKpO0g05znX9Ycjc0N5NiPvgEwbNORJmwitUQqLN7qD4gSCOkBKLqK9HaZZqUDJeaGMlmDJkXQwe8gg/EQlgzFsxRlqOrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKFwn/vT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b269789425bso357883a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043075; x=1748647875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yo9mRGpagqbJhYzSp9Ult1E6G6b4ESDTgwcuA3onprI=;
        b=WKFwn/vTZjPvtP3lnc5vbWhX6SXZl05Vyuj0z9wlNf/E5qPgdeeTFTCKoAymwnvgYM
         O2C+UTNVjSBHGV2x/2//+mQbeHFzIJSKyrdvZXAe+H3pQLK5hfNN0SJMpkPOvPdpa+jk
         NdI9jeiS2VneG1WLANsAwQOo2Sy8SslEreyyv2O2MeJGg0z7zIsGqY01mdLpFnGOTR2j
         soqxuVd5yQvF0W8LiZarbJl5aMZZpWE6OkxL+I81dV/2qzSS+hDFem+0oIrVN0H+sfhE
         Xro4ng6/nXUhTSQZU09m4UKDo1y41qoBmDVF6RRgceDO0BPM1D4ZP9rwQ3dubozdV1iH
         CHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043075; x=1748647875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yo9mRGpagqbJhYzSp9Ult1E6G6b4ESDTgwcuA3onprI=;
        b=EeEYip3+YzMgOLbT7/nuQTKKL+b1QvxIwjW3Ts6TvZ0YcwAf1q4fNLeoGUMXF0Ou2A
         kNn6QKdcvcLyz4w8Na1KdTa6ugIqJuFCHnFhxNZ+wpBy6y9TVA/wY/go+nSwM0prQlXr
         9+EAws1LcQvmiByI10xQaJOfa2BUUYkTM/KFEqd/4iU4mkpS3LvQN5pxcXMJpvDrqrv3
         bJ3YOUvVVsBFFYdFKNNW8/0609qcLu/+wnQSCRZ8kThm4NxF19yQCkuKLykOwWldzYhR
         P9pPrk3nixW48l3w7WKwFo7f4e9wQL0+wCjmgpCyXBgjWgwi31is/KM5Sxn4FYNzNsuS
         byOA==
X-Forwarded-Encrypted: i=1; AJvYcCX1sqxzsV4B9hEGkZ6S72QYCLE8aIHtrqaIqukFM7HYFTAW4GHcVKOVeI6FvwZGyG/920Xs459/GYPS5H7Rlkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wjedrf3c20aIWavVpfmn37VzplL9gmUuUbaVaY2jG9OaJ0Ot
	wu+LC2ew86FOYTEOvEubG57nUitC7MDdXbxsFNTdnriKBQQHbbDDMbJ9zn+/aFf/X5+6dyvD5Ka
	FM9X3p7i6WyQcKw==
X-Google-Smtp-Source: AGHT+IF5to/4I9yAyOmnfnA1trnApj3SN76KVvlbuzWw2yq6WhGqsv1WJFS6rBHMnkN9ethsvDzyy189vp+W1Q==
X-Received: from pgww10.prod.google.com ([2002:a05:6a02:2c8a:b0:b2b:fdb8:587])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:5483:b0:215:d217:2194 with SMTP id adf61e73a8af0-2188c3530f5mr2155614637.34.1748043075109;
 Fri, 23 May 2025 16:31:15 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:17 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-33-dmatlack@google.com>
Subject: [RFC PATCH 32/33] KVM: selftests: Test sending a vfio-pci device IRQ
 to a VM
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a new selftest called vfio_pci_device_irq_test that routes and
delivers an MSI from a vfio-pci device into a guest.

Note that this test currently uses vfio_pci_irq_trigger(), in which VFIO
emulates a device sending the MSI. In the future we want to replace this
with a real MSI so we can test the hardware path (e.g. VT-d on Intel).

This test only supports x86_64 for now, but can be ported to other
architectures in the future.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  21 +++
 .../selftests/kvm/vfio_pci_device_irq_test.c  | 129 ++++++++++++++++++
 4 files changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/vfio_pci_device_irq_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 85f651743325..fefb6408b2e9 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -139,6 +139,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += vfio_pci_device_irq_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 373912464fb4..860883ac53e1 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -866,6 +866,8 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...);
 void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
 int _kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
 
+void kvm_add_irqfd(struct kvm_vm *vm, u32 gsi, int fd);
+
 #define KVM_MAX_IRQ_ROUTES		4096
 
 struct kvm_irq_routing *kvm_gsi_routing_create(void);
@@ -874,6 +876,8 @@ void kvm_gsi_routing_irqchip_add(struct kvm_irq_routing *routing,
 int _kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 
+void kvm_route_gsi(struct kvm_vm *vm, struct kvm_irq_routing_entry *entry);
+
 const char *exit_reason_str(unsigned int exit_reason);
 
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 815bc45dd8dc..3ae752da5065 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1871,6 +1871,16 @@ void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level)
 	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_IRQ_LINE, ret));
 }
 
+void kvm_add_irqfd(struct kvm_vm *vm, u32 gsi, int fd)
+{
+	struct kvm_irqfd arg = {
+		.gsi = gsi,
+		.fd = fd,
+	};
+
+	vm_ioctl(vm, KVM_IRQFD, &arg);
+}
+
 struct kvm_irq_routing *kvm_gsi_routing_create(void)
 {
 	struct kvm_irq_routing *routing;
@@ -1921,6 +1931,17 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing)
 	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SET_GSI_ROUTING, ret));
 }
 
+void kvm_route_gsi(struct kvm_vm *vm, struct kvm_irq_routing_entry *entry)
+{
+	u8 buf[sizeof(struct kvm_irq_routing) + sizeof(*entry)] = {};
+	struct kvm_irq_routing *routes = (void *)&buf;
+
+	routes->nr = 1;
+	routes->entries[0] = *entry;
+
+	vm_ioctl(vm, KVM_SET_GSI_ROUTING, routes);
+}
+
 /*
  * VM Dump
  *
diff --git a/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
new file mode 100644
index 000000000000..c792fc169028
--- /dev/null
+++ b/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "kvm_util.h"
+#include "test_util.h"
+#include "apic.h"
+#include "processor.h"
+
+#include <pthread.h>
+#include <time.h>
+#include <linux/vfio.h>
+#include <vfio_util.h>
+
+static bool guest_ready_for_irq;
+static bool guest_received_irq;
+
+#define TIMEOUT_NS (10ULL * 1000 * 1000 * 1000)
+
+static void guest_enable_interrupts(void)
+{
+	x2apic_enable();
+	asm volatile ("sti");
+}
+
+void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu, u8 vector)
+{
+	struct kvm_irq_routing_entry entry = {
+		.gsi = gsi,
+		.type = KVM_IRQ_ROUTING_MSI,
+		.u.msi.address_lo = 0xFEE00000 | (vcpu->id << 12),
+		.u.msi.data = vector,
+	};
+
+	kvm_route_gsi(vm, &entry);
+}
+
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	WRITE_ONCE(guest_received_irq, true);
+	GUEST_DONE();
+}
+
+static void guest_code(void)
+{
+	guest_enable_interrupts();
+	WRITE_ONCE(guest_ready_for_irq, true);
+
+	for (;;)
+		continue;
+}
+
+void *vcpu_thread_main(void *arg)
+{
+	struct kvm_vcpu *vcpu = arg;
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(UCALL_DONE, get_ucall(vcpu, &uc));
+
+	return NULL;
+}
+
+static void help(const char *name)
+{
+	printf("Usage: %s [-i iommu_mode] segment:bus:device.function\n", name);
+	iommu_mode_help("-i");
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	/* Random non-reserved vector and GSI to use for the device IRQ */
+	const u8 vector = 0xe0;
+	const u32 gsi = 32;
+
+	struct timespec start, elapsed;
+	struct vfio_pci_device *device;
+	const char *iommu_mode = NULL;
+	struct kvm_vcpu *vcpu;
+	pthread_t vcpu_thread;
+	struct kvm_vm *vm;
+	int c;
+
+	while ((c = getopt(argc, argv, "i:")) != -1) {
+		switch (c) {
+		case 'i':
+			iommu_mode = optarg;
+			break;
+		default:
+			help(argv[0]);
+		}
+	}
+
+	if (optind >= argc)
+		help(argv[0]);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_install_exception_handler(vm, vector, guest_irq_handler);
+
+	device = vfio_pci_device_init(argv[optind], iommu_mode);
+	TEST_REQUIRE(device->msix_info.count > 0);
+
+	vfio_pci_msix_enable(device, 0, 1);
+	kvm_add_irqfd(vm, gsi, device->msi_eventfds[0]);
+	kvm_route_msi(vm, gsi, vcpu, vector);
+
+	pthread_create(&vcpu_thread, NULL, vcpu_thread_main, vcpu);
+
+	while (!READ_ONCE(guest_ready_for_irq))
+		sync_global_from_guest(vm, guest_ready_for_irq);
+
+	/*
+	 * TODO: Get the device to send a physical MSI to exercise IRQ Bypass
+	 * (e.g. VT-d on Intel), rather than manually synthesizing a
+	 * notification from VFIO.
+	 */
+	vfio_pci_irq_trigger(device, VFIO_PCI_MSIX_IRQ_INDEX, 0);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
+	while (!READ_ONCE(guest_received_irq)) {
+		elapsed = timespec_elapsed(start);
+		TEST_ASSERT(timespec_to_ns(elapsed) < TIMEOUT_NS, "vCPU never received IRQ\n");
+		sync_global_from_guest(vm, guest_received_irq);
+	}
+
+	pthread_join(vcpu_thread, NULL);
+	vfio_pci_device_cleanup(device);
+
+	return 0;
+}
-- 
2.49.0.1151.ga128411c76-goog


