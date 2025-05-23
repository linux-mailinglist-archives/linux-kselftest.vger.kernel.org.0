Return-Path: <linux-kselftest+bounces-33715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 973C8AC2C4C
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84833189259D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA16221FC1;
	Fri, 23 May 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUPNk4u3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D2221571
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043059; cv=none; b=g9+tPYFqCrBlEbvpS7iaNTYP+V+6azRVv0/N/+FbYXYA3YdQJLKwA3HS4i7cCpq3oxEjMbu4kcIt0rMq1DzYuLm9BuK8dnX/X47n0R59p66TkCJzIOD84LkxgJEF3dO3F+1kfWvYiJHlkt6Cu4U2jM94YD66pIFcbwkqNMoafCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043059; c=relaxed/simple;
	bh=PSCIf5BoXqV9DFf81VMT3KVzXFmvTTgYv3m9lzeHfa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IbJ3aS0LHIUE+T/G07PeYqQpXRZNtSBDgkWGX/AeE4S/7RssAGlovp1M9zKdKuTYpLN/gasQOraQsS/yjIZK25rF5URaPNvd7u1bsUBE3s1P7aDGtpkRYQx3GNGxuQGkvpz10l4RAKLxHoZuShPeAmwb+Rc5/pRprxyQeb+vEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUPNk4u3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22c31b55ac6so4229595ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043057; x=1748647857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHy41pMdVW1uqaaEn2dqN2nDG5jgAQEjZgP0rVb81ZU=;
        b=jUPNk4u3sXrm479k655ZQKOf3vLiqwk96AN2B+X0RZvc+7TptDv6dhyHMKf5L9sawn
         ZTxhUK/tjw90qwUVboOyGJ4RqUkS1QzuJtzHQw52BkH0nG4h/nt6ii+NfFlgMp+tqYeT
         kdmBn5Cpe5LNAZT/ZvYCXSyXrxIWIvW6SD53IlhvTqqIjxpYq8s0dwxi9Ei7VIvgTcA8
         5plGgTQktfiy/4t5vcsKhp5IR00CUH886qh7y1ZnR/hIqy/gz69jz8YLaDvcT2jaN+UU
         Zhseil7BGFmrzYG0lTtenek47wyCDNsahQA/8lfm3NpllusmNaUa2aiPM9hdkS3Wlica
         IJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043057; x=1748647857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHy41pMdVW1uqaaEn2dqN2nDG5jgAQEjZgP0rVb81ZU=;
        b=KwUSwVCk/9mIbi6TL8PL4Jf2IusA8wdjF6wLAoHztkXulaXArsfqbYD/c2WandrNh5
         AX+pcnZ2JVnBJN6j+ELwe8ovlQDBjPw9rkSNxUkgyVO0MOpFAN5tMI7rRInR9iZB+w5S
         Os4X5rny5Dzjt6nsHZZelO5iIX1GENTvQPx/yu6SsVtZch0e0mWpXbcr/klIzL7d/Ato
         z8PRFwE9bO413Ua8N+eJWUTgkpuP4zgoJQjCzr3uKuIBGXNA4Zv3Bli+ncXz8MeU1Lkj
         b5G9PiGqfGlFr9E5JZdeayH99DDorIZR9/MjX6khqdF+jAByXFpwsHVP6w1l1491RDtE
         34AA==
X-Forwarded-Encrypted: i=1; AJvYcCXPKis1R4v7WTbEnvjc0ssBgug9TL3ohs3TcRBZI1vhhPT1fCv2AwexMoeDqKCVrG1IrOal7DRGNsITxuQAj80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YNmrXGci+q+7UdhgnIpsMRt/z46fMItnRQh804DFwpuAGvcG
	KvanlkJ/kuVMnCmGx6v8quVaMHD9Kk/8r0RFpv6xGTNxtPFD9lziEafq/hD18ZebnogF9tMiYMI
	Vzs0PtNcIbl0D/Q==
X-Google-Smtp-Source: AGHT+IGiZLcSaKVyX+tmWd4lYQOOZSc/u9bdh+SrueOymck9W9qiFjunLDawSgfJlZq2qykNLKrv77prZEzZfQ==
X-Received: from pjbnc6.prod.google.com ([2002:a17:90b:37c6:b0:2fc:3022:36b8])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc44:b0:224:10a2:cad5 with SMTP id d9443c01a7336-23414f61878mr21409155ad.10.1748043057141;
 Fri, 23 May 2025 16:30:57 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:04 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-20-dmatlack@google.com>
Subject: [RFC PATCH 19/33] vfio: selftests: Add driver framework
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

Add a driver framework to VFIO selftests, so that devices can generate
DMA and interrupts in a common way that can be then utilized by tests.
This will enable VFIO selftests to exercise real hardware DMA and
interrupt paths, without needing any device-specific code in the test
itself.

Subsequent commits will introduce drivers for specific devices.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  92 ++++++++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
 .../selftests/vfio/lib/vfio_pci_device.c      |   5 +
 .../selftests/vfio/lib/vfio_pci_driver.c      | 116 ++++++++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/lib/vfio_pci_driver.c

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index df56c84273e8..c824c993d82e 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -63,6 +63,85 @@ struct vfio_dma_region {
 	u64 size;
 };
 
+struct vfio_pci_device;
+
+struct vfio_pci_driver_ops {
+	const char *name;
+
+	/**
+	 * @probe() - Check if the driver supports the given device.
+	 *
+	 * Return: 0 on success, non-0 on failure.
+	 */
+	int (*probe)(struct vfio_pci_device *device);
+
+	/**
+	 * @init() - Initialize the driver for @device.
+	 *
+	 * Must be called after device->driver.region has been initialized.
+	 */
+	void (*init)(struct vfio_pci_device *device);
+
+	/**
+	 * remove() - Deinitialize the driver for @device.
+	 */
+	void (*remove)(struct vfio_pci_device *device);
+
+	/**
+	 * memcpy_start() - Kick off @count repeated memcpy operations from
+	 * [@src, @src + @size) to [@dst, @dst + @size).
+	 *
+	 * Guarantees:
+	 *  - The device will attempt DMA reads on [src, src + size).
+	 *  - The device will attempt DMA writes on [dst, dst + size).
+	 *  - The device will not generate any interrupts.
+	 *
+	 * memcpy_start() returns immediately, it does not wait for the
+	 * copies to complete.
+	 */
+	void (*memcpy_start)(struct vfio_pci_device *device,
+			     iova_t src, iova_t dst, u64 size, u64 count);
+
+	/**
+	 * memcpy_wait() - Wait until the memcpy operations started by
+	 * memcpy_start() have finished.
+	 *
+	 * Guarantees:
+	 *  - All in-flight DMAs initiated by memcpy_start() are fully complete
+	 *    before memcpy_wait() returns.
+	 *
+	 * Returns non-0 if the driver detects that an error occurred during the
+	 * memcpy, 0 otherwise.
+	 */
+	int (*memcpy_wait)(struct vfio_pci_device *device);
+
+	/**
+	 * send_msi() - Make the device send the MSI device->driver.msi.
+	 *
+	 * Guarantees:
+	 *  - The device will send the MSI once.
+	 */
+	void (*send_msi)(struct vfio_pci_device *device);
+};
+
+struct vfio_pci_driver {
+	const struct vfio_pci_driver_ops *ops;
+	bool initialized;
+	bool memcpy_in_progress;
+
+	/* Region to be used by the driver (e.g. for in-memory descriptors) */
+	struct vfio_dma_region region;
+
+	/* The maximum size that can be passed to memcpy_start(). */
+	u64 max_memcpy_size;
+
+	/* The maximum count that can be passed to memcpy_start(). */
+	u64 max_memcpy_count;
+
+	/* The MSI vector the device will signal in ops->send_msi(). */
+	int msi;
+};
+
 struct vfio_pci_device {
 	int fd;
 	int group_fd;
@@ -79,6 +158,8 @@ struct vfio_pci_device {
 
 	/* eventfds for MSI and MSI-x interrupts */
 	int msi_eventfds[PCI_MSIX_FLAGS_QSIZE + 1];
+
+	struct vfio_pci_driver driver;
 };
 
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
@@ -160,4 +241,15 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 		(device_id == vfio_pci_config_readw(device, PCI_DEVICE_ID));
 }
 
+void vfio_pci_driver_probe(struct vfio_pci_device *device);
+void vfio_pci_driver_init(struct vfio_pci_device *device);
+void vfio_pci_driver_remove(struct vfio_pci_device *device);
+int vfio_pci_driver_memcpy(struct vfio_pci_device *device,
+			   iova_t src, iova_t dst, u64 size);
+void vfio_pci_driver_memcpy_start(struct vfio_pci_device *device,
+				  iova_t src, iova_t dst, u64 size,
+				  u64 count);
+int vfio_pci_driver_memcpy_wait(struct vfio_pci_device *device);
+void vfio_pci_driver_send_msi(struct vfio_pci_device *device);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H */
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 388533f8d407..10a1a9316e4c 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -1,6 +1,7 @@
 VFIO_DIR := $(selfdir)/vfio
 
 LIBVFIO_C := lib/vfio_pci_device.c
+LIBVFIO_C += lib/vfio_pci_driver.c
 
 LIBVFIO_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBVFIO_C))
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index e823d3ff7f45..63f033047b4c 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -340,6 +340,8 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type)
 	vfio_pci_iommu_setup(device, iommu_type);
 	vfio_pci_device_setup(device, bdf);
 
+	vfio_pci_driver_probe(device);
+
 	return device;
 }
 
@@ -347,6 +349,9 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 {
 	int i;
 
+	if (device->driver.initialized)
+		vfio_pci_driver_remove(device);
+
 	vfio_pci_bar_unmap_all(device);
 
 	VFIO_ASSERT_EQ(close(device->fd), 0);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
new file mode 100644
index 000000000000..c98bd2d31d8a
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+
+#include "../../../kselftest.h"
+#include <vfio_util.h>
+
+static struct vfio_pci_driver_ops *driver_ops[] = {};
+
+void vfio_pci_driver_probe(struct vfio_pci_device *device)
+{
+	struct vfio_pci_driver_ops *ops;
+	int i;
+
+	VFIO_ASSERT_NULL(device->driver.ops);
+
+	for (i = 0; i < ARRAY_SIZE(driver_ops); i++) {
+		ops = driver_ops[i];
+
+		if (ops->probe(device))
+			continue;
+
+		printf("Driver found: %s\n", ops->name);
+		device->driver.ops = ops;
+	}
+}
+
+static void vfio_check_driver_op(struct vfio_pci_driver *driver, void *op,
+				 const char *op_name)
+{
+	VFIO_ASSERT_NOT_NULL(driver->ops);
+	VFIO_ASSERT_NOT_NULL(op, "Driver has no %s()\n", op_name);
+	VFIO_ASSERT_EQ(driver->initialized, op != driver->ops->init);
+	VFIO_ASSERT_EQ(driver->memcpy_in_progress, op == driver->ops->memcpy_wait);
+}
+
+#define VFIO_CHECK_DRIVER_OP(_driver, _op) do {				\
+	struct vfio_pci_driver *__driver = (_driver);			\
+	vfio_check_driver_op(__driver, __driver->ops->_op, #_op);	\
+} while (0)
+
+void vfio_pci_driver_init(struct vfio_pci_device *device)
+{
+	struct vfio_pci_driver *driver = &device->driver;
+
+	VFIO_ASSERT_NOT_NULL(driver->region.vaddr);
+	VFIO_CHECK_DRIVER_OP(driver, init);
+
+	driver->ops->init(device);
+
+	driver->initialized = true;
+
+	printf("%s: region: vaddr %p, iova 0x%lx, size 0x%lx\n",
+	       driver->ops->name,
+	       driver->region.vaddr,
+	       driver->region.iova,
+	       driver->region.size);
+
+	printf("%s: max_memcpy_size 0x%lx, max_memcpy_count 0x%lx\n",
+	       driver->ops->name,
+	       driver->max_memcpy_size,
+	       driver->max_memcpy_count);
+}
+
+void vfio_pci_driver_remove(struct vfio_pci_device *device)
+{
+	struct vfio_pci_driver *driver = &device->driver;
+
+	VFIO_CHECK_DRIVER_OP(driver, remove);
+
+	driver->ops->remove(device);
+	driver->initialized = false;
+}
+
+void vfio_pci_driver_send_msi(struct vfio_pci_device *device)
+{
+	struct vfio_pci_driver *driver = &device->driver;
+
+	VFIO_CHECK_DRIVER_OP(driver, send_msi);
+
+	driver->ops->send_msi(device);
+}
+
+void vfio_pci_driver_memcpy_start(struct vfio_pci_device *device,
+				  iova_t src, iova_t dst, u64 size,
+				  u64 count)
+{
+	struct vfio_pci_driver *driver = &device->driver;
+
+	VFIO_ASSERT_LE(size, driver->max_memcpy_size);
+	VFIO_ASSERT_LE(count, driver->max_memcpy_count);
+	VFIO_CHECK_DRIVER_OP(driver, memcpy_start);
+
+	driver->ops->memcpy_start(device, src, dst, size, count);
+	driver->memcpy_in_progress = true;
+}
+
+int vfio_pci_driver_memcpy_wait(struct vfio_pci_device *device)
+{
+	struct vfio_pci_driver *driver = &device->driver;
+	int r;
+
+	VFIO_CHECK_DRIVER_OP(driver, memcpy_wait);
+
+	r = driver->ops->memcpy_wait(device);
+	driver->memcpy_in_progress = false;
+
+	return r;
+}
+
+int vfio_pci_driver_memcpy(struct vfio_pci_device *device,
+			   iova_t src, iova_t dst, u64 size)
+{
+	vfio_pci_driver_memcpy_start(device, src, dst, size, 1);
+
+	return vfio_pci_driver_memcpy_wait(device);
+}
-- 
2.49.0.1151.ga128411c76-goog


