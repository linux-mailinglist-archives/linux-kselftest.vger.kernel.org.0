Return-Path: <linux-kselftest+bounces-43470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052FBEC25C
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80370740D32
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B60E24169D;
	Sat, 18 Oct 2025 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NW2EUbBR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19B5464D
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746079; cv=none; b=R/JSRaO8GwdUoGK2/nmtBl37tv8AqPqItQCsjY1kvcNFWo7990CvCmGLhT9Qr+duW0nK5OiB6HknLeGgADHl9i1rmQ/Vq1QlnFnHa4b2a49ElZtjylPy9I4xFyfyub2Scq/3myUdElv0Dk1GbcyRUW9Wi6pySB6BnQwcEwM7iKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746079; c=relaxed/simple;
	bh=M2+JBMCO1L+FuYx2GCn7BiCKdMGCnMS81y4JT/5Boo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AKbgOMcBRkZ7y6PruNkQDTVsHKOy3vOd5eAXjTpJLCjqY1EH14QT65bauD8imsFwrrdqC96DfjARP9DHGYn56qsSpuZQU2VwQtBav5yWS00UAKUJT7KhDpQNbEIAHRDJ+gqmp1YAHXkuzJv3ip4OOVs2ms8qbiid1vHNFR6HrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NW2EUbBR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33baf262850so2518293a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746076; x=1761350876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydhS89cP0Z2GUDxoQAtz3nc85hlQYU5pjgD7NtdLoQw=;
        b=NW2EUbBR593jgveIC1mF4rlUVscg6ZVWp+x6BQUackchvoiI7qJhyHIcl5SqFKR9r4
         F9RcIKhrDtyk7NziKorvEgWUyujgR5piaC6VG0IlmfUfiRnl2DUSj4CmLWEHq4Jng8AW
         ZQlkZBwsJ1dtvBnqg8AvOIHLq6GmAwiRDiFgWmZ1ycfF0l2wLZWSou94/Ch5FNfDsXg1
         mEbfqit/fqmuMQZJD5dGCs6paz5uv95E1MYQZIK2YMiZbPqpMFdQYoZuKVpjU8kVJhzw
         NgTM68Y4E2E1XIo8WcSzqS2ENqn1ykjFsBnQtERpxT2fJX/KQbJrQzc1pBi6/M8IUvZ3
         MHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746076; x=1761350876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydhS89cP0Z2GUDxoQAtz3nc85hlQYU5pjgD7NtdLoQw=;
        b=dTUTQXolwcnXwywh30wPO3uth0ojR3ckImKcd1Y7nGajKnWvSbExFvLeXE1sgRYHEL
         Ez3FbzynDippXxYiXWFNc5pwVJLOlXUGyPeVEFlrndfEpZBpp3kwmfbjggBhFhmoLFxE
         CpSvPfm1ZRjMbfZC+v3ATLh8B3hLzyzgcS5VbLgAOGLL8uvswCH0wB2kGhyM5QFCo5Aa
         EiOj8K48qf0iR9231OKd3v4cZA0aD5g48dvQr/aMFlE+cu62EgDdwRqdSMNJoAV+exzA
         708Fsk4jUq58kf/i0OXI8vfQfyAk+gPKzxtDTW7RXqqMwb5CfO3cofGOS2bv2x/cPvUv
         GfQg==
X-Forwarded-Encrypted: i=1; AJvYcCXQl2bpY42CUPy7aOWYUJkM4CT+23sXU8Vgg4Q/lRtUJBmyDhLct7uVlKmts0qdVJZQc/zTnL8EI5tluIoZld0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgYg59UNCrbSHvHnbhrwZMTZWN87WM4Aywno+brU8hn12nY8k
	v+zsQmC6q5a+zyZnubVsLR4sE8IZdLdJ9r3Tic2PphcGMTpN0sk8skBwlavuE3VDY1qkQqyvSy0
	eDLWvGeeIOg==
X-Google-Smtp-Source: AGHT+IFlKo2S/6ZxOLbnUbsEzTjZo01MBS/KrDhCOEW25HVXu091cfhApJVkE8GIU3Ir27SiQDoh2GBWuOw0
X-Received: from pjis18.prod.google.com ([2002:a17:90a:5d12:b0:33b:cf89:6fe6])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5281:b0:330:a301:35f4
 with SMTP id 98e67ed59e1d1-33bcf8e95dbmr7008618a91.20.1760746076272; Fri, 17
 Oct 2025 17:07:56 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:11 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-20-vipinsh@google.com>
Subject: [RFC PATCH 19/21] vfio: selftests: Initialize vfio_pci_device using a
 VFIO cdev FD
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the given VFIO cdev FD to initialize vfio_pci_device in VFIO
selftests. Add the assertion to make sure that passed cdev FD is not
used with legacy VFIO APIs. If VFIO cdev FD is provided then do not open
the device instead use the FD for any interaction with the device.

This API will allow to write selftests where VFIO device FD is preserved
using liveupdate and retrieved later using liveupdate ioctl after kexec.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  1 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 +++++++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index ed31606e01b7..8ec60a62a0d1 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -203,6 +203,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf);
 extern const char *default_iommu_mode;
 
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode);
+struct vfio_pci_device *vfio_pci_device_init_fd(int vfio_cdev_fd);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 0921b2451ba5..cab9c74d2de8 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -486,13 +486,18 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
 }
 
-static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *bdf)
+static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
+				   const char *bdf, int vfio_cdev_fd)
 {
-	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
 
-	device->fd = open(cdev_path, O_RDWR);
+	if (vfio_cdev_fd > 0) {
+		device->fd = vfio_cdev_fd;
+	} else {
+		const char *cdev_path = vfio_pci_get_cdev_path(bdf);
+		device->fd = open(cdev_path, O_RDWR);
+		free((void *)cdev_path);
+	}
 	VFIO_ASSERT_GE(device->fd, 0);
-	free((void *)cdev_path);
 
 	/*
 	 * Require device->iommufd to be >0 so that a simple non-0 check can be
@@ -507,7 +512,9 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
 	vfio_device_attach_iommufd_pt(device->fd, device->ioas_id);
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_mode)
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       const char *iommu_mode,
+					       int vfio_cdev_fd)
 {
 	struct vfio_pci_device *device;
 
@@ -518,10 +525,13 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_
 
 	device->iommu_mode = lookup_iommu_mode(iommu_mode);
 
+	VFIO_ASSERT_FALSE(device->iommu_mode->container_path != NULL && vfio_cdev_fd > 0,
+			  "Provide either container path or VFIO cdev FD, not both.\n");
+
 	if (device->iommu_mode->container_path)
 		vfio_pci_container_setup(device, bdf);
 	else
-		vfio_pci_iommufd_setup(device, bdf);
+		vfio_pci_iommufd_setup(device, bdf, vfio_cdev_fd);
 
 	vfio_pci_device_setup(device);
 	vfio_pci_driver_probe(device);
@@ -529,6 +539,17 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_
 	return device;
 }
 
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf,
+					     const char *iommu_mode)
+{
+	return __vfio_pci_device_init(bdf, iommu_mode, -1);
+}
+
+struct vfio_pci_device *vfio_pci_device_init_fd(int vfio_cdev_fd)
+{
+	return __vfio_pci_device_init(NULL, "iommufd", vfio_cdev_fd);
+}
+
 void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 {
 	int i;
-- 
2.51.0.858.gf9c4a03a3a-goog


