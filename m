Return-Path: <linux-kselftest+bounces-35527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 043D6AE266D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EFA7AD67A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF722586EF;
	Fri, 20 Jun 2025 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwcFvbV/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2A257430
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461714; cv=none; b=LEkWjnJsNLLc/8boXG4uymowYT47RM7VMihTcy+M4tbV9T5Xdy9nxkcPzdZdLpcuEyZLJAcQy9zdDsSattBiRw02UW86edYu6Sa+ozn/jAXCmrY6cptLvdyBV7t1a5uCD++wbghx5DFsAZaeOko8qkI2k8ushbk1FIgboks2LBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461714; c=relaxed/simple;
	bh=Ncx74SpAzcNntzZHo1q9tv5rzSgXexrKxG6ODpCJH/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f7PqY1UBQsqzn2gOsK0WMRIJZ5PZR0HIbg2BoFjGvau0Uxly23xB/WNAdTk60HLN0+okiK/b6u6Qncxw43a7UxWo0eZhlv4jR/rmH8xXosT6ddD9rVTQYCrTCReYa4Yqp9TnQtsJlhPzDfCzo3zyczW+bZ72a7uiRKXXqov16mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwcFvbV/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3122368d82bso3173367a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461712; x=1751066512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZKSIsXOLOueB130oF7Z5E/CnqwtspAwtEMUlKs5jYA=;
        b=jwcFvbV/Xb3KN33jbSx/vnO71Iv8nAz2PhGMlT2Ww+6SeCGe6EL3vvnEHFPojgLDT0
         26VeYTrJuiGEiPTI1FDOFtQKa7Ia6WIKT26OacUwnAYcxqpOFrRSzUA6qzu1Tkfs5amD
         FYY/rphzsgaZAz3ulrSnv9Z+E27Wio0j2le8rpG6ZN5/46pWD0tmB+X6Oq+wx+Cu15ek
         GTEGgnLYRZ6F3nkWIcX2GvF1ah/JIIf0BAVu2vNV2fFQIYtjvzYy5bydEKuYuLuotp6F
         vxDqSP1U1v2bjm+htnHv1/NIRQIEhyDVHKQX1M2QN2SdzVws/k4lhDV8q0jB3+4Gre3v
         Qjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461712; x=1751066512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZKSIsXOLOueB130oF7Z5E/CnqwtspAwtEMUlKs5jYA=;
        b=AAKCl9VwlkFRAkmL+PVRV+VF7CI66RNGsJzRahVLeaWR4jJhjkgs3Xjr13XjLg7Nx7
         95DgtXJOvqw/tXAv9CksDAzKW/vILxfVcTFPJKihkQDiyu69LjCHJFo1UgGO3T/Kj4HT
         Dy+uKx6wV/aQO05s5IvDUJb0/RdSGM9043via/pqRGbSvi8Pinav/8E5FxQm1jzOgVZ+
         RhWnxz0zqtP1FY0S6ZH0kd10TnBHnKGNbizzX8+i3sNxbuLK8tgg/RqGC5zGQX4L/iOq
         OZcd4tPpom25XS152YHyOVgvGOgzeCGUDpd8seQBzZZM3Dzkp34JzKZY8CW3ilyo3ivk
         ueOw==
X-Forwarded-Encrypted: i=1; AJvYcCXU2SM6bVsZNgRyEt1TQXsCgMPMVr8kUXn7nozxO++9WPgBxfXhQfOlrQKvOIxXfC2IWLHYEzXTU91r9mM5Zzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLI9mkclllQu3Nk39dBb1hEu2Qyrc1T51qOiWwVht2jH/awLZJ
	/hBF9fo34AoYpQtioCJsysXmmk5eb6QtvbJR4mOaBJFm3D59FAd8E0fmyahFCj3VjKlMr7x8lQL
	8MU18OrCgHEIFVQ==
X-Google-Smtp-Source: AGHT+IFHJjxL70GMJGRTf7hame7Lzw6gdvygwoTOqgJ1QDn6ZRT3o3M4PRqA6yGQe4JeCam/FXpiNmMlKZ+qbA==
X-Received: from pjbqo12.prod.google.com ([2002:a17:90b:3dcc:b0:311:f699:df0a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2808:b0:313:f83a:e473 with SMTP id 98e67ed59e1d1-3159d67bbd3mr7117272a91.15.1750461712326;
 Fri, 20 Jun 2025 16:21:52 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:31 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-34-dmatlack@google.com>
Subject: [PATCH 33/33] KVM: selftests: Add -d option to vfio_pci_device_irq_test
 for device-sent MSIs
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

Add the -d option to vfio_pci_device_irq_test that will make the device
send an MSI rather than synthesizing an eventfd notification from VFIO.
This requires a VFIO selftest driver for the device that supports the
send_msi() function.

This option allows the test to exercise IRQ Bypass (e.g. VT-d
device-posted interrupts in Intel).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/kvm/vfio_pci_device_irq_test.c  | 61 +++++++++++++++++--
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
index 9b90cf9dd38f..64fd4efe2096 100644
--- a/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
@@ -7,6 +7,8 @@
 #include <pthread.h>
 #include <time.h>
 #include <linux/vfio.h>
+#include <linux/sizes.h>
+
 #include <vfio_util.h>
 
 static bool guest_ready_for_irq;
@@ -60,10 +62,53 @@ void *vcpu_thread_main(void *arg)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-i iommu_mode] [segment:bus:device.function]\n", name);
+	printf("Usage: %s [-i iommu_mode] [-d] [segment:bus:device.function]\n", name);
+	printf("  -d: Send a real MSI from the device, rather than synthesizing\n"
+	       "      an eventfd signal from VFIO. Note that this option requires\n"
+	       "      a VFIO selftests driver that supports the device.\n");
 	exit(KSFT_FAIL);
 }
 
+static int setup_msi(struct vfio_pci_device *device, bool use_device_msi)
+{
+	const int flags = MAP_SHARED | MAP_ANONYMOUS;
+	const int prot = PROT_READ | PROT_WRITE;
+	struct vfio_dma_region *region;
+
+	if (use_device_msi) {
+		/* A driver is required to generate an MSI. */
+		TEST_REQUIRE(device->driver.ops);
+
+		/* Set up a DMA-able region for the driver to use. */
+		region = &device->driver.region;
+		region->iova = 0;
+		region->size = SZ_2M;
+		region->vaddr = mmap(NULL, region->size, prot, flags, -1, 0);
+		TEST_ASSERT(region->vaddr != MAP_FAILED, "mmap() failed\n");
+		vfio_pci_dma_map(device, region);
+
+		vfio_pci_driver_init(device);
+
+		return device->driver.msi;
+	}
+
+	TEST_REQUIRE(device->msix_info.count > 0);
+	vfio_pci_msix_enable(device, 0, 1);
+	return 0;
+}
+
+static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int msi)
+{
+	if (use_device_msi) {
+		printf("Sending MSI %d from the device\n", msi);
+		TEST_ASSERT_EQ(msi, device->driver.msi);
+		vfio_pci_driver_send_msi(device);
+	} else {
+		printf("Notifying the eventfd for MSI %d from VFIO\n", msi);
+		vfio_pci_irq_trigger(device, VFIO_PCI_MSIX_IRQ_INDEX, msi);
+	}
+}
+
 int main(int argc, char **argv)
 {
 	/* Random non-reserved vector and GSI to use for the device IRQ */
@@ -73,19 +118,24 @@ int main(int argc, char **argv)
 	struct timespec start, elapsed;
 	struct vfio_pci_device *device;
 	const char *iommu_mode = NULL;
+	bool use_device_msi = false;
 	const char *device_bdf;
 	struct kvm_vcpu *vcpu;
 	pthread_t vcpu_thread;
 	struct kvm_vm *vm;
+	int msi;
 	int c;
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "i:")) != -1) {
+	while ((c = getopt(argc, argv, "i:d")) != -1) {
 		switch (c) {
 		case 'i':
 			iommu_mode = optarg;
 			break;
+		case 'd':
+			use_device_msi = true;
+			break;
 		default:
 			help(argv[0]);
 		}
@@ -95,10 +145,9 @@ int main(int argc, char **argv)
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 
 	device = vfio_pci_device_init(device_bdf, iommu_mode);
-	TEST_REQUIRE(device->msix_info.count > 0);
+	msi = setup_msi(device, use_device_msi);
 
-	vfio_pci_msix_enable(device, 0, 1);
-	kvm_add_irqfd(vm, gsi, device->msi_eventfds[0]);
+	kvm_add_irqfd(vm, gsi, device->msi_eventfds[msi]);
 	kvm_route_msi(vm, gsi, vcpu, vector);
 
 	pthread_create(&vcpu_thread, NULL, vcpu_thread_main, vcpu);
@@ -106,7 +155,7 @@ int main(int argc, char **argv)
 	while (!READ_ONCE(guest_ready_for_irq))
 		sync_global_from_guest(vm, guest_ready_for_irq);
 
-	vfio_pci_irq_trigger(device, VFIO_PCI_MSIX_IRQ_INDEX, 0);
+	send_msi(device, use_device_msi, msi);
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 
-- 
2.50.0.rc2.701.gf1e915cc24-goog


