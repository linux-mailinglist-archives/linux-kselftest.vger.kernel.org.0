Return-Path: <linux-kselftest+bounces-46558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CC1C8BAAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2193A3BD0DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B18D34BA50;
	Wed, 26 Nov 2025 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTHOE9Hi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBB34B18F
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185799; cv=none; b=J0ugin9+rk1gfAnPOLoQbkeG4tqT2vTVBwKsa92Vh2JrVizgJpwbx5kmaJ421Gb541sLT8+I0rANxxzF9dzZN/qwnIAznpFW5VzL05vFtdHrOe/aNiEvNCXFzi8QtCdAJ3IJ2SDYyYCWbQSyOlpNEoAI9k7gwbI1D2TiAfkJ3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185799; c=relaxed/simple;
	bh=oOTZ22wFJZqnFzsFStI6K/6j0+r7OjYCkSOC13WPK5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d+2mz8GD0e4ErzbQ8QeAGl7pkJ8/AWjJebeEF+Z9FYwbF6JhsoAY2OlkCOvxw02iSF/HcpblgU+a0NCd1rsCTmtE6OPy0UJNC2niAE7mF1QmBrC5+vy7RUordeuh1zeEC4N04kKJ+gibtk0NjOg2GQYLMJhsjURQRrMKlQjfQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTHOE9Hi; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b82c2c2ca2so95082b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185796; x=1764790596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNFE9+5HOL1VTfFvE91RbwOqejjTuBWxPiJYobw2Kcg=;
        b=DTHOE9HimPqnsmGO6KjbvxuhCOECIH5aP141Aqw88qkgl6OjQ/aonnhvd3T1slhAQ7
         zBUK7gmd6ghG/GH2jPBWTHoUDeSuChKWwmm2+AzYrL/XB6eFCwQRVy1I/+VA+NZYZMRK
         HKRnSVQga9HjIrnis7Uycvjamsaea+CHWIyRI5M97xgqVWAwxARlG0GlRzxQrR0iVdyA
         /bROYq3pk8j8XhOnWoMwpZY9W1UzpnC3Py2OcW0iNfEd78pk1+vp8IjPipFXenTadPdj
         9zAWfR+KXH9iCYV5yHBISKm6QDihYJqf32tPuugvozilzqVpr/g1kbIF3I11epmvepsW
         v0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185796; x=1764790596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNFE9+5HOL1VTfFvE91RbwOqejjTuBWxPiJYobw2Kcg=;
        b=F9Ts0qBWHtYeYo9dt2Eb6CNrWdWcZuhceGdt4v9AoC6eqXrhIfVVRwWU1P8EwPOfYn
         dATg0aKYunhW87F/0/3oQj8OyZ1uVitWmi+HmSn6IpMG8+BWIDgutrAADvGPRp7qdj6T
         EUqEIyszLc00z1b55+BKG2pBMgo3rHaookpYaSfNK6Mxnko2lxw8sD8jGhSGiuhP6CPb
         STJbayAmi0KWJQdttZR7JG7KssLWTTRGFPqbfn0t2HLtyHqIg2oDYPFsA8sTmNxpty2l
         9GRsGMv+1zxa+zuo90ma5C3oc6zNgap2A9wACY0YhPxlQUEE3fQxW5TxyseO3zw95n5K
         oCjg==
X-Forwarded-Encrypted: i=1; AJvYcCWG0w3CXH3MbEnE2X68j9pUVqPvQTQNzMIkN8EG3n6MoDZsQg/cso2US38H/+xQNrtTTltMlaYna8wmZeem7HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYb3zZkOsOKbtGoljBSKG7XQCnehUkMZhWcHz6TGUv72EE4pBM
	qVGFjURa6gA5GluVVxvXMsu1pPUIxz/Ui6/5j37/wlS/9oEcOKKXMhS1Gfq9cmhD2y25bPBfMP3
	kjOqiu7ZNIlG4Mw==
X-Google-Smtp-Source: AGHT+IFQhjKrX/N6hJ5PO1HA/1hqWlujUuZce1Edh5MBtvzNhWFpXfCucZ7C6spTR8QDg6JjwdBie16yKE0H0A==
X-Received: from pfbmy26-n2.prod.google.com ([2002:a05:6a00:6d5a:20b0:7ba:3994:c73f])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d88:b0:7b9:ef46:ec70 with SMTP id d2e1a72fcca58-7c58e50c16emr18773625b3a.23.1764185795950;
 Wed, 26 Nov 2025 11:36:35 -0800 (PST)
Date: Wed, 26 Nov 2025 19:36:03 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-17-dmatlack@google.com>
Subject: [PATCH 16/21] vfio: selftests: Initialize vfio_pci_device using a
 VFIO cdev FD
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

From: Vipin Sharma <vipinsh@google.com>

Use the given VFIO cdev FD to initialize vfio_pci_device in VFIO
selftests. Add the assertion to make sure that passed cdev FD is not
used with legacy VFIO APIs. If VFIO cdev FD is provided then do not open
the device instead use the FD for any interaction with the device.

This API will allow to write selftests where VFIO device FD is preserved
using liveupdate and retrieved later using liveupdate ioctl after kexec.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-Developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  3 ++
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 ++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..896dfde88118 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -38,6 +38,9 @@ struct vfio_pci_device {
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd);
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 468ee1c61b0c..e9423dc3864a 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -319,19 +319,27 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
 }
 
-static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *bdf)
+static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
+				   const char *bdf, int device_fd)
 {
-	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
+	const char *cdev_path;
 
-	device->fd = open(cdev_path, O_RDWR);
-	VFIO_ASSERT_GE(device->fd, 0);
-	free((void *)cdev_path);
+	if (device_fd >= 0) {
+		device->fd = device_fd;
+	} else {
+		cdev_path = vfio_pci_get_cdev_path(bdf);
+		device->fd = open(cdev_path, O_RDWR);
+		VFIO_ASSERT_GE(device->fd, 0);
+		free((void *)cdev_path);
+	}
 
 	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd)
 {
 	struct vfio_pci_device *device;
 
@@ -341,10 +349,12 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
 	device->bdf = bdf;
 	device->iommu = iommu;
 
-	if (device->iommu->mode->container_path)
+	if (device->iommu->mode->container_path) {
+		VFIO_ASSERT_EQ(device_fd, -1);
 		vfio_pci_container_setup(device, bdf);
-	else
-		vfio_pci_iommufd_setup(device, bdf);
+	} else {
+		vfio_pci_iommufd_setup(device, bdf, device_fd);
+	}
 
 	vfio_pci_device_setup(device);
 	vfio_pci_driver_probe(device);
@@ -352,6 +362,11 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
 	return device;
 }
 
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+{
+	return __vfio_pci_device_init(bdf, iommu, /*device_fd=*/-1);
+}
+
 void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 {
 	int i;
-- 
2.52.0.487.g5c8c507ade-goog


