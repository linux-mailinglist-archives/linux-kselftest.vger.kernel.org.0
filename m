Return-Path: <linux-kselftest+bounces-46563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336B0C8BAE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF743BA501
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2123A34DCF7;
	Wed, 26 Nov 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWTiWNxf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E534D92E
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185807; cv=none; b=u7ej4vWj8vSMhsz1EaAIasShtCkD+1b7i7Qpr7azdBQ64MchQLC98Vyt66VWH71jsmgrpAEUbLGUwH92jvJnvM1RmaY7G1/si2IWM6WQXHqXlzXri4gUrXXhYZ8jXiuWv7zbaFADYTz+uvHEiodcOKq/jU0bgHgoo3ZZL0VPZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185807; c=relaxed/simple;
	bh=KlrakXRYDAwae9AantcdeyMmPCGsY3ONeKbMm2nz5i0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HiGn0OEXdMrpSmJJUWM3du+Yb/igTy4STuFoA7FLsTqdRUQ3sUWa+KS5nk5nKGtMsGsYOikiWk7W1ICZbBT7F1CR9UAn11dmzLkK6DvTs2XKyVeVtz+qOnYwlNnsV3x66cQCOkKSFMpsKlvCKJlw7fmBlw9y+yTHOUSdrngNUGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWTiWNxf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295595cd102so1631065ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185804; x=1764790604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4HruGk4w1YQ8UWc4dTnuGXBMMZoDm4CrvXWdnupA6c=;
        b=WWTiWNxfaNnX+oBcLgUNkYafPNVUbL0RUQAhNMs6LbIoWTkYvBzvKvGou9CwkxQdEl
         hix409K4K9TiANobe19fQJCMJhc3QJzPv6hqy8QJJkmTtBBkvh/NMgul1tb4TnhnzsON
         YCf2Ug00lvbBFF3qZcsInQB6+bcuXS9XJ0gXVgKExcMWgfU5mQ76v9VuM2t0Ft0UpPC6
         pJ1djSga2WnvBHAxMskx2fxW42RE/5NJqhHN5Bqa39DdNiM+27DnOC/CqdJLi9dvwq9z
         L8suHOGkhtCOw4A/gZ6CXYFE4ZAsaI/7ldJqg0FwLUTHmoRtUoRjrCOnovelx/T13YHR
         RuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185804; x=1764790604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4HruGk4w1YQ8UWc4dTnuGXBMMZoDm4CrvXWdnupA6c=;
        b=uPMY3yvXF4twg35Wjipf+eZKAJeZmeNwT9nEsPzFfFWNT/y9nhYXgV4/xXnrN2kQzF
         tp01XnRpXU930SGaLPDfshgdYvLH2q2h7vg4LgT9nFbsU3kMkU5B17HV05bKd8VgQgaX
         ZEC2Y/ULs8N1O7zXWaX+vQS4X2Snkp3f+4/obOFVSc5IDwOQ3R7IOiN3x9nVeXOdeXKN
         zhl2RDpz6SWb0Cea68RiBuVp1OR2XbUccv+Umo6uNi3KH3OgbE3197Tvm8UDEzChOs5z
         /MfEinFyxoFh3OPo7mIk6X8AnV2ZktQjlQbK/PnVLvuVZvPY3O/NfuUp0LNWwpeIx8oS
         Z7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWSZz0bfECeSByV9OiX733BDTT34SHjGIozIp0j4o6IvtHtiXeeiw9yfUgCxx6PV/fVfRpqVG6rvrbcgEicio8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Lm8NSQ9Nqe/Ap9zu7gU+lkVJ/exzXOhMbHMlChCGp3VOI9i5
	BaYjRawCDbtqpaRgmo6te5x64kJDsrEWWCYcZdL++0fJRFzeFcV3GeDxFUo1rwoiteR9TvCZEza
	QBda4pC4GpUaFYw==
X-Google-Smtp-Source: AGHT+IEBIWWppu0CTBFQwqlZd62yUWkoTSQEwzYofKMCO8/xCUHYiOx68XHiZKglrx1LrJ62PFpPkJgu1NINKA==
X-Received: from pfbei35.prod.google.com ([2002:a05:6a00:80e3:b0:7be:dfde:de14])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3ca8:b0:35f:c643:105e with SMTP id adf61e73a8af0-3614eda6de1mr22522832637.34.1764185804103;
 Wed, 26 Nov 2025 11:36:44 -0800 (PST)
Date: Wed, 26 Nov 2025 19:36:08 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-22-dmatlack@google.com>
Subject: [PATCH 21/21] vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Add a long-running DMA memcpy operation to
vfio_pci_liveupdate_kexec_test so that the device attempts to perform
DMAs continuously during the Live Update.

At this point iommufd preservation is not supported and bus mastering is
not kept enabled on the device during across the kexec, so most of these
DMAs will be dropped. However this test ensures that the current device
preservation support does not lead to system instability or crashes if
the device is active. And once iommufd and bus mastering are preserved,
this test can be relaxed to check that the DMA operations completed
successfully.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 925c5fc30d56..3af50110a65d 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -1,8 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/sizes.h>
+#include <sys/mman.h>
+
 #include <libliveupdate.h>
 #include <libvfio.h>
 
+#define MEMCPY_SIZE SZ_1G
+#define DRIVER_SIZE SZ_1M
+#define MEMFD_SIZE (MEMCPY_SIZE + DRIVER_SIZE)
+
+static struct dma_region memcpy_region;
 static const char *device_bdf;
 
 #define STATE_SESSION "567e1b8d-daf1-4a4a-ac13-35d6d275f646"
@@ -11,8 +19,100 @@ static const char *device_bdf;
 enum {
 	STATE_TOKEN,
 	DEVICE_TOKEN,
+	MEMFD_TOKEN,
 };
 
+static void dma_memcpy_one(struct vfio_pci_device *device)
+{
+	void *src = memcpy_region.vaddr, *dst;
+	u64 size;
+
+	size = min_t(u64, memcpy_region.size / 2, device->driver.max_memcpy_size);
+	dst = src + size;
+
+	memset(src, 1, size);
+	memset(dst, 0, size);
+
+	printf("Kicking off 1 DMA memcpy operations of size 0x%lx...\n", size);
+	vfio_pci_driver_memcpy(device,
+			       to_iova(device, src),
+			       to_iova(device, dst),
+			       size);
+
+	VFIO_ASSERT_EQ(memcmp(src, dst, size), 0);
+}
+
+static void dma_memcpy_start(struct vfio_pci_device *device)
+{
+	void *src = memcpy_region.vaddr, *dst;
+	u64 count, size;
+
+	size = min_t(u64, memcpy_region.size / 2, device->driver.max_memcpy_size);
+	dst = src + size;
+
+	/*
+	 * Rough Math: If we assume the device will perform memcpy at a rate of
+	 * 30GB/s then 7200GB of transfers will run for about 4 minutes.
+	 */
+	count = (u64)7200 * SZ_1G / size;
+	count = min_t(u64, count, device->driver.max_memcpy_count);
+
+	memset(src, 1, size / 2);
+	memset(dst, 0, size / 2);
+
+	printf("Kicking off %lu DMA memcpy operations of size 0x%lx...\n", count, size);
+	vfio_pci_driver_memcpy_start(device,
+				     to_iova(device, src),
+				     to_iova(device, dst),
+				     size, count);
+}
+
+static void dma_memfd_map(struct vfio_pci_device *device, int fd)
+{
+	void *vaddr;
+
+	vaddr = mmap(NULL, MEMFD_SIZE, PROT_WRITE, MAP_SHARED, fd, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	memcpy_region.iova = SZ_4G;
+	memcpy_region.size = MEMCPY_SIZE;
+	memcpy_region.vaddr = vaddr;
+	iommu_map(device->iommu, &memcpy_region);
+
+	device->driver.region.iova = memcpy_region.iova + memcpy_region.size;
+	device->driver.region.size = DRIVER_SIZE;
+	device->driver.region.vaddr = vaddr + memcpy_region.size;
+	iommu_map(device->iommu, &device->driver.region);
+}
+
+static void dma_memfd_setup(struct vfio_pci_device *device, int session_fd)
+{
+	int fd, ret;
+
+	fd = memfd_create("dma-buffer", 0);
+	VFIO_ASSERT_GE(fd, 0);
+
+	ret = fallocate(fd, 0, 0, MEMFD_SIZE);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	printf("Preserving memfd of size 0x%x in session\n", MEMFD_SIZE);
+	ret = luo_session_preserve_fd(session_fd, fd, MEMFD_TOKEN);
+	VFIO_ASSERT_EQ(ret, 0);
+
+	dma_memfd_map(device, fd);
+}
+
+static void dma_memfd_restore(struct vfio_pci_device *device, int session_fd)
+{
+	int fd;
+
+	printf("Retrieving memfd from LUO\n");
+	fd = luo_session_retrieve_fd(session_fd, MEMFD_TOKEN);
+	VFIO_ASSERT_GE(fd, 0);
+
+	dma_memfd_map(device, fd);
+}
+
 static void before_kexec(int luo_fd)
 {
 	struct vfio_pci_device *device;
@@ -32,6 +132,27 @@ static void before_kexec(int luo_fd)
 	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
 	VFIO_ASSERT_EQ(ret, 0);
 
+	dma_memfd_setup(device, session_fd);
+
+	/*
+	 * If the device has a selftests driver, kick off a long-running DMA
+	 * operation to exercise the device trying to DMA during a Live Update.
+	 * Since iommufd preservation is not supported yet, these DMAs should be
+	 * dropped. So this is just looking to verify that the system does not
+	 * fall over and crash as a result of a busy device being preserved.
+	 */
+	if (device->driver.ops) {
+		vfio_pci_driver_init(device);
+		dma_memcpy_start(device);
+
+		/*
+		 * Disable interrupts on the device or freeze() will fail.
+		 * Unfortunately there isn't a way to easily have a test for
+		 * that here since the check happens during shutdown.
+		 */
+		vfio_pci_msix_disable(device);
+	}
+
 	close(luo_fd);
 	daemonize_and_wait();
 }
@@ -106,9 +227,23 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	 */
 	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
 
+	dma_memfd_restore(device, session_fd);
+
 	printf("Finishing the session\n");
 	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
 
+	/*
+	 * Once iommufd preservation is supported and the device is kept fully
+	 * running across the Live Update, this should wait for the long-
+	 * running DMA memcpy operation kicked off in before_kexec() to
+	 * complete. But for now we expect the device to be reset so just
+	 * trigger a single memcpy to make sure it's still functional.
+	 */
+	if (device->driver.ops) {
+		vfio_pci_driver_init(device);
+		dma_memcpy_one(device);
+	}
+
 	vfio_pci_device_cleanup(device);
 	iommu_cleanup(iommu);
 }
-- 
2.52.0.487.g5c8c507ade-goog


