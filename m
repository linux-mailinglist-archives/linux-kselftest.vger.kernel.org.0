Return-Path: <linux-kselftest+bounces-46561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E61BC8BAD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3ED3B92BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E33E34D4F0;
	Wed, 26 Nov 2025 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHWrfcrC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6534CFDB
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185804; cv=none; b=uQ3drlmBFxCxbl16oaEflMKDFITp6bGBQu6zyzd8qWBGL7L/aoCdZE1lnFfSweJvpldJImRQ89qN5oKFRiJsdDZ0D4OQS00J/dDSwLaqRjUJv0Xx/+xiNdOZrCFrdALfsVZnUS/Sb17tUd707TNmaDs/8JfK8kuzd3F9eiB2ezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185804; c=relaxed/simple;
	bh=pY5ouGUCyRUEJXsQXzAc3UxouobBtC66I9KMuiV6pDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Of0ig7ghJj5GEHB9+S2BLfRtRb6BW7tf/tqR8vgKQcZIK9VR3xvLNhvIsOE7ghhV/PeaiSn8DhwIDE1ovTZ54P21PjQ1yzDZI22yf1RRMFYncpbRAiGlT/uBoeehZfFTM8q5ydiQTrKhtuv0CeBhTlQqRY2pl3HCqtileRYit5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pHWrfcrC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bbcf3bd4c8fso78475a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185801; x=1764790601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m959yfvIsSxpy5q7Eg0smleSkVURLFC+s19Qeh/qusk=;
        b=pHWrfcrCCPVOmeBv0AXoHItMQ/DNkudESfPMrswO4cgI7+NRV6hU8l70LGFfSBEiSv
         DQ1eDgKOBEOZ+pEuwwiF9w32FfooK6K/YzdbjHXqLEVkQn/mtJfQ6uxX7E6zbu07vrik
         DyJGx8pT2BcATAp/Cz23dNdsj8/bYIq8Fd90/r3jG2SlNhuazdk+l8wv2HqiejJ1NAcI
         LuMQZq14+6JUYV2ZgpCxnKz0GcKO0qEttdSRwvrMIjYyV5tIB2djsJ4lRvE0nljBIqtN
         ydXJEHYteKOmGd3bYg6P55iZsCBP/Bhafhfa+Cr8Cwtk0mY9m4oWt9mva+yblU/LWBbK
         U8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185801; x=1764790601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m959yfvIsSxpy5q7Eg0smleSkVURLFC+s19Qeh/qusk=;
        b=m6ngYdC/V8LgmmOXw3a4bEGhKhnPaYJKywQZp4OZOSjDh9XfdCYMffIC5T2iTqC6aL
         U1xPjaOL1WsP4LkGWpv9jf+Mv4hprap2b2j1L7ai5YPW83E0oYFco8SFekKNwOLEo1Z7
         fj8A77laM7XYxI1phka2YhIxUZUm1OecVVdv2/hMZB0xlxLMnQIAqo23XsbO477kNUqs
         Ss/ZAmXQbcMmoHnS6e/FzYsTnEc76f9hv1fP5Nk7qtgwm0L/hg9JhWVH3hgGvD2Fx9BC
         tfLYI4UWKRUkWGUsYO6IkLtzm9D82PcVfuWIDo00wP2ruBs0tQbY8nw1a0omlm347S9/
         flEw==
X-Forwarded-Encrypted: i=1; AJvYcCXO0xWW4/BVRnthTIAMUOxwlL0q8DCWcBldAhDdve9P45wP7P/JKubUEqW1ufda96Hm251vcCEoD8SOKwyTWe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgaFn+jcTAMzKzLqT6K7nH9bV3IylloWh9Dqw7gSaqtwU6g7lO
	DCIqNVNSYcRPSw82tgUzueZRN7Gq0KhvCy2vqNxkZN811jNzAfff8bMRhCw13/bjfT0ChV8uPUk
	9GaS8IRuKIN6kSQ==
X-Google-Smtp-Source: AGHT+IFHEidLnQkcHmYLLGmMjLxzA1O3bNZ0x68Qy0dH/iUpCs9DOSGGUEyYCq/FUTYeONv/KIiX9w+sQ3BkIA==
X-Received: from pfcs3.prod.google.com ([2002:a05:6a00:6fc3:b0:7b8:8099:b70b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2590:b0:35d:1bcd:687f with SMTP id adf61e73a8af0-3614f2550a8mr23300680637.9.1764185800837;
 Wed, 26 Nov 2025 11:36:40 -0800 (PST)
Date: Wed, 26 Nov 2025 19:36:06 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-20-dmatlack@google.com>
Subject: [PATCH 19/21] vfio: selftests: Expose low-level helper routines for
 setting up struct vfio_pci_device
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

Expose a few low-level helper routings for setting up vfio_pci_device
structs. These routines will be used in a subsequent commit to assert
that VFIO_GROUP_GET_DEVICE_FD fails under certain conditions.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  5 +++
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 +++++++++++++------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 896dfde88118..2389c7698335 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -125,4 +125,9 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
+/* Low-level routines for setting up a struct vfio_pci_device */
+struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu);
+void vfio_pci_group_setup(struct vfio_pci_device *device);
+void vfio_pci_iommu_setup(struct vfio_pci_device *device);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index e9423dc3864a..c1a3886dee30 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -199,7 +199,7 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 	return group;
 }
 
-static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
+void vfio_pci_group_setup(struct vfio_pci_device *device)
 {
 	struct vfio_group_status group_status = {
 		.argsz = sizeof(group_status),
@@ -207,7 +207,7 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	char group_path[32];
 	int group;
 
-	group = vfio_pci_get_group_from_dev(bdf);
+	group = vfio_pci_get_group_from_dev(device->bdf);
 	snprintf(group_path, sizeof(group_path), "/dev/vfio/%d", group);
 
 	device->group_fd = open(group_path, O_RDWR);
@@ -219,14 +219,12 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->iommu->container_fd);
 }
 
-static void vfio_pci_container_setup(struct vfio_pci_device *device, const char *bdf)
+void vfio_pci_iommu_setup(struct vfio_pci_device *device)
 {
 	struct iommu *iommu = device->iommu;
 	unsigned long iommu_type = iommu->mode->iommu_type;
 	int ret;
 
-	vfio_pci_group_setup(device, bdf);
-
 	ret = ioctl(iommu->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
 	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
 
@@ -236,8 +234,14 @@ static void vfio_pci_container_setup(struct vfio_pci_device *device, const char
 	 * because the IOMMU type is already set.
 	 */
 	(void)ioctl(iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
+}
 
-	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
+static void vfio_pci_container_setup(struct vfio_pci_device *device)
+{
+	vfio_pci_group_setup(device);
+	vfio_pci_iommu_setup(device);
+
+	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, device->bdf);
 	VFIO_ASSERT_GE(device->fd, 0);
 }
 
@@ -337,9 +341,7 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
-struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
-					       struct iommu *iommu,
-					       int device_fd)
+struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu)
 {
 	struct vfio_pci_device *device;
 
@@ -349,9 +351,20 @@ struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
 	device->bdf = bdf;
 	device->iommu = iommu;
 
+	return device;
+}
+
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd)
+{
+	struct vfio_pci_device *device;
+
+	device = vfio_pci_device_alloc(bdf, iommu);
+
 	if (device->iommu->mode->container_path) {
 		VFIO_ASSERT_EQ(device_fd, -1);
-		vfio_pci_container_setup(device, bdf);
+		vfio_pci_container_setup(device);
 	} else {
 		vfio_pci_iommufd_setup(device, bdf, device_fd);
 	}
-- 
2.52.0.487.g5c8c507ade-goog


