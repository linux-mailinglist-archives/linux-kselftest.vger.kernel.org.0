Return-Path: <linux-kselftest+bounces-33729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1711EAC2C68
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C38543F13
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995BD230BE0;
	Fri, 23 May 2025 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJRffg7+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC57F22D79F
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043078; cv=none; b=O1Q4DyJ1m0xGbrXpaI3N9ZZPFFwEeTtkSO0w5cD/HwG7gSfUY8359Q4KaUGJ29o2i8cbj8z8YfR6byG4nCMdKrzdo3PR+ytM4IkAFDVmF39WDtgYNQv0J7GvTJdqo4agyDhGTaJ53Ku0symScn86pvYsgbmHo5C/gEIleTZeSV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043078; c=relaxed/simple;
	bh=0RXuCVLrXEPb1pt0chxtuYDoM6mwJhSpZxLWUnlytA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o7ErQkU0NST4NYnH1bDo82nru/o+lTZdfusXyj+juV0fz08BlAaLsQFRX7XnBA379k8eHmtqZf8n1TRFQY+SgddgivDOZL33+yh7Mh9oxa9KI6MqnIJRCpRLl+qhqSjGcGgZ6Swiahj+eBrVMafCzYeBFo4ZGzJFK+PZd87e2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJRffg7+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311158ce5afso244006a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043076; x=1748647876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbwpnqFdigfxSHHnLdygU37yLnjoA7SY/d2DILwFqA4=;
        b=gJRffg7+rC5g2SPB8fOs/GEIQarn6sIhG9U/u2QQEzL1UFuUX+5utGu4CgzsKynBux
         oVP7Tg6s4OckCnlDtRtLfEVxu2pZUXpmlRb0Sx/Fbq6Dm0dospCSWCTasl3UfJrHx59D
         +jPCdxYifZOnHiF2cXMWoYjCsHMRy1SFUuao9H2RCm+NHNIVFQckRqqAw8ghOT+rIuP0
         rsjKWYCAEJOropt/uQp80Q9YvwZmUKEPGhkWdNOtu4aIbmohQdGDdw3+oJJn+ZNpzEIV
         XJQDnbh4MEHTC0YP+kvKjVAGjLFlOIOhVCr2ki9H2iu1ZDzOoTzKfsdEtZnbKNKTAw5Y
         IVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043076; x=1748647876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbwpnqFdigfxSHHnLdygU37yLnjoA7SY/d2DILwFqA4=;
        b=pj+BhtmGfU+leLdWRbTJRo29ezGrzGtbAHdjfeE0dZ+CU1kyZKrcJL5TKCAft+wqVY
         mmF+VKxbQikhyeCnGNEjVAeSnsSRvVbZHs2FgXfU9PQwrhzJQN2LnwC1jWIkQLF23o7q
         fU2+4jilXO2xItMIy9XwLjuY8pPdUoFCTYZ5cKH9L7kIMoA39I4KvjGj+0L1dbNcRxzM
         CgKfoNkAsXwNLJgfKJGZBr30e3S7Vs24orKH7yDVJndf0dxlaJdlbWvcyGmYecC15QjH
         un4v7fL0xhv8tS52C6AIoBOgA3K8pPo2gwysHyAZqy+gR073gEkZCMKbSEMfm+jBH+5A
         rNxA==
X-Forwarded-Encrypted: i=1; AJvYcCVeV236/Tbx+8EtY9gA+ydqwjEqPm2aRdPhPW4QRoWWM83zTpAJ1t/GFJpfJmEdO/Pa0tWW5Z21mS+wBKxxK/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZatCIpK484R7HM5f7KnLn0YX3vkfw1ISM07TsGUUqI2NJuOn3
	fj0h99iJZ25ZpvxcXvDdlUplWFhPdc06LC1RAsUi7ql/YsTCAZySBiSL1udNoItxkudt9GYtSmy
	vhQxp+7mSlY4Iqg==
X-Google-Smtp-Source: AGHT+IHyDcH7UMGw9toFQVxY+VoXcYmHRzwFLxAE24v5dqY6tL3VzLjA07cSUcfaJrCfjI1QXw9EgCPx4GXhsg==
X-Received: from pjbeu5.prod.google.com ([2002:a17:90a:f945:b0:2ef:d136:17fc])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:280b:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-31110d71ba8mr1339223a91.32.1748043076519;
 Fri, 23 May 2025 16:31:16 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:18 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-34-dmatlack@google.com>
Subject: [RFC PATCH 33/33] KVM: selftests: Use real device MSIs in vfio_pci_device_irq_test
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

Use real device MSIs to deliver interrupts into the guest in
vfio_pci_device_irq_test (when possible). If the device has a driver, we
can use the driver to make the device send a physical MSI, rather than
synthesizing an eventfd notification in software. This allows this test
to exercise IRQ Bypass (e.g. VT-d device-posted interrupts in Intel).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/kvm/vfio_pci_device_irq_test.c  | 66 +++++++++++++++----
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
index c792fc169028..8cbaf38357c4 100644
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
@@ -60,11 +62,54 @@ void *vcpu_thread_main(void *arg)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-i iommu_mode] segment:bus:device.function\n", name);
+	printf("Usage: %s [-i iommu_mode] [-d] segment:bus:device.function\n", name);
+	printf("  -d: Send a real MSI from the device, rather than synthesizing\n"
+	       "      an eventfd signal from VFIO. Note that this option requires\n"
+	       "      a VFIO selftests driver that supports the device.\n");
 	iommu_mode_help("-i");
 	exit(1);
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
@@ -74,16 +119,21 @@ int main(int argc, char **argv)
 	struct timespec start, elapsed;
 	struct vfio_pci_device *device;
 	const char *iommu_mode = NULL;
+	bool use_device_msi = false;
 	struct kvm_vcpu *vcpu;
 	pthread_t vcpu_thread;
 	struct kvm_vm *vm;
+	int msi;
 	int c;
 
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
@@ -96,10 +146,9 @@ int main(int argc, char **argv)
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 
 	device = vfio_pci_device_init(argv[optind], iommu_mode);
-	TEST_REQUIRE(device->msix_info.count > 0);
+	msi = setup_msi(device, use_device_msi);
 
-	vfio_pci_msix_enable(device, 0, 1);
-	kvm_add_irqfd(vm, gsi, device->msi_eventfds[0]);
+	kvm_add_irqfd(vm, gsi, device->msi_eventfds[msi]);
 	kvm_route_msi(vm, gsi, vcpu, vector);
 
 	pthread_create(&vcpu_thread, NULL, vcpu_thread_main, vcpu);
@@ -107,12 +156,7 @@ int main(int argc, char **argv)
 	while (!READ_ONCE(guest_ready_for_irq))
 		sync_global_from_guest(vm, guest_ready_for_irq);
 
-	/*
-	 * TODO: Get the device to send a physical MSI to exercise IRQ Bypass
-	 * (e.g. VT-d on Intel), rather than manually synthesizing a
-	 * notification from VFIO.
-	 */
-	vfio_pci_irq_trigger(device, VFIO_PCI_MSIX_IRQ_INDEX, 0);
+	send_msi(device, use_device_msi, msi);
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 
-- 
2.49.0.1151.ga128411c76-goog


