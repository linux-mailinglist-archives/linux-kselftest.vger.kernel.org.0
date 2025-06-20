Return-Path: <linux-kselftest+bounces-35511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF0AE263A
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83FA7A8205
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA39925178C;
	Fri, 20 Jun 2025 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7S0pnZ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA352505A9
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461690; cv=none; b=Dcmi9I3VEsYeJ9nrdPFOmzJ3ah0BBfF8XufhZ1dEMJ7uK9EfmaxSkTyousMKfGvR6R+nll88tDYtBJjdSr8t6YEuaReCh6ZQw/d+5lLDMrfyBY0v0I6UP0OPwgDcHxNvu39/UVjgz+YJgtwJNgIHqyfNWxh0Nt1jY2R7HgGApg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461690; c=relaxed/simple;
	bh=V73w1pgbSqFXwXvM7hTfw0VdokC4Ly3YERfP1r2oaYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IP/UEsbW7DzvZpHrCx/TtHzl2Lb4WVXsg37WSoAjxwxDu1ZzXm8K/5fDyXUbKDIOyng+MCRo9Zk1dSHkce5XCOAFssBtP0TIJ9v8Nrb3PU4X388KlXYZmULZXM0zromFU1C02GNDqEpm2xPmZWBbxVvaX1zFrWl9Jp8MIBvi8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7S0pnZ/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso2393517a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461688; x=1751066488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVU7QR1/mIIEUNBEqXeg8HZpGUyLAKxbGMd9rFtk0Wg=;
        b=O7S0pnZ/7ImeiSkIjf6b6u71xT1YFJSc6JVG3g5B8zvxg7wRGJO02XIe1JIM01W4ST
         1YOAwTrAGbUXACzQRNy0J5AlAPF1V9KoOkK6v0fgoOeUdYUnp1o2viAsm4n9M26ELE1b
         5cDke9HMlEo8UyVPCkF/gcOvhtnkhkYDlcp500tXZu/upeBroZL7nZi0XcLdGhnVEvan
         MnZ2YoJcS9yqxG0+JTHMqOQBwbINiy+4ocp+z/9KZbapVZxYMk8k9YcFfivCB/Q5WvCD
         icUSKkvT8zXc+O2WKO7YuFnb4KHAlbASJerat25OcRTeltYM7GmmNNFRjr7S7FaWc9en
         5Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461688; x=1751066488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVU7QR1/mIIEUNBEqXeg8HZpGUyLAKxbGMd9rFtk0Wg=;
        b=JHt6K6dxMrk3fH17FQcb8Ctcoyk7wgQUGxEPdTWgzs2hRdCuubYq67dg25A1gGoE1i
         qgdqMDUwuK/kZAH4nk1jWfV1O0dK6wD8Ey24RIdRpuMRwgCEpH4HAJ8DpagyY8wFGsbx
         RN50AxHeWB9+r+U/PZgLrJ9qfAafi45+C8dALUl4CGyCIaehjnPRGx4hccnD9hrr+83z
         PTOU7qfeI6v8P9RCrWj2sflnAb3ZnxjwzCFZon1G6YlshOQNFdszPVm2u1ICRNE1SKjE
         j/g8ijvL28dhFk1iZcAfoOvJOSp3d8GCFGrHgL38m58MPaDLRC5q3ExTE0VPH2VywBNK
         CsSA==
X-Forwarded-Encrypted: i=1; AJvYcCWhveWAxZDUtoRy+gJj0lZ8wGv2X9qvZ43dKVrTtYAFL6rK6CqlYQcKZeg8P6O7BSWXZKk0OHsGMZPTabHx8lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Uvrh81AGLBf0rHU/MYDPIrSKgGA/l0kMSly4rcHHxWMgVKXH
	tPd7JtVjt69EsE73bRx4jJkM4aa1QiSsVYWsAnU+V8JZHeJIuLZIaWwYchDjWGDhaPGj6qVD4er
	wT888N2vpMtTymw==
X-Google-Smtp-Source: AGHT+IGMixAFgJLxXQPJUzXwOsJhV/E74VD85w8ua0E3Reh9uxjfLPB0O79NOYLEJEvh+J/TNW4BG7Kj4rAoUg==
X-Received: from pjbsw7.prod.google.com ([2002:a17:90b:2c87:b0:2fb:fa85:1678])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f8b:b0:311:e8cc:424e with SMTP id 98e67ed59e1d1-3159d8d685dmr8967540a91.24.1750461688344;
 Fri, 20 Jun 2025 16:21:28 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:15 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-18-dmatlack@google.com>
Subject: [PATCH 17/33] vfio: selftests: Add driver framework
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
index a51c971004cd..a7d05a4299a1 100644
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
 
 /*
@@ -174,4 +255,15 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
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
index 72e55a560eeb..a3c3bc9a7c00 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -1,6 +1,7 @@
 VFIO_DIR := $(selfdir)/vfio
 
 LIBVFIO_C := lib/vfio_pci_device.c
+LIBVFIO_C += lib/vfio_pci_driver.c
 
 LIBVFIO_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBVFIO_C))
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 36b4b30b75cf..d8bb227e869d 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -344,6 +344,8 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type)
 	vfio_pci_iommu_setup(device, iommu_type);
 	vfio_pci_device_setup(device, bdf);
 
+	vfio_pci_driver_probe(device);
+
 	return device;
 }
 
@@ -351,6 +353,9 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
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
2.50.0.rc2.701.gf1e915cc24-goog


