Return-Path: <linux-kselftest+bounces-35526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF3AE2668
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11FD17B94D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221282580CA;
	Fri, 20 Jun 2025 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAxEAJEb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D3257455
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461713; cv=none; b=YU1lMTHLEUvA7ELDw85OtWUZU6c4epwhq0niBBAXxFhepbaZii8Kp0RiKeCVfm1ZEBnLg1qSp3cGu1GOZZcLx7HlXAM41SgfHiTcvDgbynQ+IFTKoKOScaHupxNQJ18MTMnAP4W4yr4Zx1u/Q4fzUiV1e0FNmiyosBf2ugUhNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461713; c=relaxed/simple;
	bh=zlHl0/Wlr/tQ3C/QOKkhtnpL/a6ZWPW6CLnHE2av/fw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c7z8c6eRuw3apiPKl9+rnq5EZDDiEODfbafmUVII/GxaY9gZVSodhblfPMYhzuIaDq5LwIi34Yknh+kgTX/tZUubw4It+hw06ADGDnJflolv9PnY556VPKbiOl+X+ZgKJP+IWV17ys89AizjBiRCi9cWvqFgunbkc+10xmJJNmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAxEAJEb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-236725af87fso27450505ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461711; x=1751066511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnkawiv9pb/cFlMBRrRkFgNfZniVoGI3MaUc2ZXgeFo=;
        b=iAxEAJEbEgvir3YmrBvH1PBtEussNj2g43eE0wHJQ2zbe7HpbMq2JYRS+x6TV3L1Mr
         eJp70RHx9AqjmutNxAsw/aL70FqGQjrFnNL4/6w/z0iRS1K1xmNoS+akakaqhHCiYetn
         7kfIJYRWHQCH45IRG9qfEmgQ+S9wnIKnXo3T5Bjx0gqBMYU0FfQZOgu1d2PIyBn683xF
         87k/B6YU6Y/6LVKEL7I+12Hc7HRJTCBd6/FxluUJY224tlhC7Uu0F6y9N6RxDxEznlwO
         RxIaQ9M1PhJGB7wCq3QJMPh/8TRGK7iWWYh0u0RU49kMEYl/IfUGeJVkLoCfWDw6uqTA
         0Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461711; x=1751066511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnkawiv9pb/cFlMBRrRkFgNfZniVoGI3MaUc2ZXgeFo=;
        b=pP8zvgcviHIsf4PfySfpp6HFXfMaBWGFv5WpOItjwLcMTr6mdA9TX2N+SOLAQ+CH7v
         4dsrgUj0mTg2Ek4+yQq8x/1CN+/ZRUAn6znc+5MONj8JRmaMNE+Ne4H2AID8itRmHZv9
         QUTG96ohiIwuJbdahcvgZKp0oVkeWcqXiKOXyhPFhyK3T9DC9GMoqgntTJbUzNDZXYbY
         MdB1zBcEx9Vs8I5+B+2oOoZndWI989IKerV7ufoltsEN19qil1c+3U/DU1Xz/3MtijCS
         NO0aO0JCxNFzq0Txvkgur+bsQ0hIGZcCI/oqtL6JZ/UtKvdSk56a94OEsVb0NhFxzlRO
         FJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCU0py/AWcdmIvz11lvDilQHUefUvO87BJHGzkxYNvfvn5C8RAH9RZPQNMCt6/KzBWImBMWPK7VOE29YfDbCX4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWScOfh4xmsA9ycoQwNICsb464zF90LGuvBewTguUyDbT1B5PS
	Wxyy+TXiz4i8bHbqnYOnGPL0gkRONEVMk6TLshohgRrXGG4pkQWq/ZXgti8vzBxhbk7u0PaJM15
	LS7w4OcVAPSbRLw==
X-Google-Smtp-Source: AGHT+IGiFuI5QftqeZu0fViqqCIvYNicTnK1eCKdMdkgeB+v9dekM0XI3oU9yblfpejHVPM7ccIZcGX3fIizCg==
X-Received: from pgbcw13.prod.google.com ([2002:a05:6a02:428d:b0:b2f:64d0:993e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e54a:b0:234:d7b2:2aab with SMTP id d9443c01a7336-237d972fa09mr63697625ad.14.1750461710861;
 Fri, 20 Jun 2025 16:21:50 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:30 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-33-dmatlack@google.com>
Subject: [PATCH 32/33] KVM: selftests: Test sending a vfio-pci device IRQ to a VM
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
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
 .../selftests/kvm/vfio_pci_device_irq_test.c  | 123 ++++++++++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/vfio_pci_device_irq_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 5a9644ce910b..ba6727dcf59d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -146,6 +146,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += vfio_pci_device_irq_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index bee65ca08721..8afa6d6f1435 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -907,6 +907,8 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...);
 void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
 int _kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level);
 
+void kvm_add_irqfd(struct kvm_vm *vm, u32 gsi, int fd);
+
 #define KVM_MAX_IRQ_ROUTES		4096
 
 struct kvm_irq_routing *kvm_gsi_routing_create(void);
@@ -915,6 +917,8 @@ void kvm_gsi_routing_irqchip_add(struct kvm_irq_routing *routing,
 int _kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 
+void kvm_route_gsi(struct kvm_vm *vm, struct kvm_irq_routing_entry *entry);
+
 const char *exit_reason_str(unsigned int exit_reason);
 
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a055343a7bf7..737252812d15 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1891,6 +1891,16 @@ void kvm_irq_line(struct kvm_vm *vm, uint32_t irq, int level)
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
@@ -1941,6 +1951,17 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing)
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
index 000000000000..9b90cf9dd38f
--- /dev/null
+++ b/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
@@ -0,0 +1,123 @@
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
+	printf("Usage: %s [-i iommu_mode] [segment:bus:device.function]\n", name);
+	exit(KSFT_FAIL);
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
+	const char *device_bdf;
+	struct kvm_vcpu *vcpu;
+	pthread_t vcpu_thread;
+	struct kvm_vm *vm;
+	int c;
+
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
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
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_install_exception_handler(vm, vector, guest_irq_handler);
+
+	device = vfio_pci_device_init(device_bdf, iommu_mode);
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
2.50.0.rc2.701.gf1e915cc24-goog


