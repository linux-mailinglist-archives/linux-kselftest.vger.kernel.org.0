Return-Path: <linux-kselftest+bounces-46550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AB5C8B9E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF8C74E8A24
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810EC345CAE;
	Wed, 26 Nov 2025 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="leAra91s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B13446C2
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185786; cv=none; b=afyFCH7fbXtAkalmsJPkxE843OQ8ciSRUfPGmYXsGBPuo2WCnLDwIEfcrpgrkj15/6bH3w6KqFGzNQeCq2/fKRgKl8sp75k9cEka2MLFRad8MKkX4bjHmj8MOt/WFt4G80zdg452HwgWP7Fc5mwxfovqZumvULbDIRZx+RGr+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185786; c=relaxed/simple;
	bh=mCOKJ+2oazOul2zSOoTvvQYPlws6VrgIzEWD2SHP4h0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tGx5lZJsLJvzazhxkTo74hlHn6sZrF1FDPU400MKNJjfEg4DwEwz5EV57TyAyIAs4mP1JltGcIBQq5wQK4a0BzsmjIbprr1+kRtJK2lZ9Gm++Nq8sfgyWXqrknWZbHPT2razud/NckpauLX9PyWU1OldUa9GbuKbDnUxlyKCxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=leAra91s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34374bfbcccso78831a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185784; x=1764790584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=34dEI7XqQFY3PUssu08ewRf+hu3ICrVVHhgvFs2tITk=;
        b=leAra91seKzVgaVuc1yowBpyV16MZVEQ/3jryUfGEdiEb4Q3Ko2JxP/oPV93go6eOV
         rGzf0xj00ibva5m04HYWQMNtHdlfUI0xHJjaVKm7XiyOwnvsZJUgUAggVq3l6rkJOw1g
         2zApUa/IIbAXWmSO9ccvS4EjN+D7sAxQDfq0pnyCf7kTfwzqdf2lrqu8DtPNujROkOve
         ARdeSCLlfpDROJmZ1Jw8Dcfk/xWjHx4es34lalz3/aGgqBWKLZC7F8D3x38RRxI2Yyho
         4UPf5jeZHgg5JGUuf9j6ZGX/ZK40tbuih14vHz+uBcmy9R2nmAbajhlomhXH3gyfSlWJ
         LBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185784; x=1764790584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34dEI7XqQFY3PUssu08ewRf+hu3ICrVVHhgvFs2tITk=;
        b=hP8SIlhPFUSi4mOjWHR5ObHIFnV22tNYTS2v/RUSZ0TrxZmKcSfkSeRHT4FjtNhvQK
         uHQDNprNhBlM6oJz0EUlDi4Py8oFfqA956QQ0KrwHBuk/ItxjmbDHceqxuOuGhR/jC9N
         WYfvyYfWB4vQeBT3RMHFlEOliFM+0uPM9CzOegmewJbYmzFgRdMwarK/lbqsr2AlqDkI
         TX8Og8aKNV7iPG7bMEfvMRN3slrX+eh37EO4UbkmGmlCrLTlkRG2lswf28d/Uu05Klqz
         hYx1iqMze/bswFjApUB42WQoWU4K4dWn1fnmYKeQK6wFOZqRuJiyjZ+7tolIunM+L9U1
         i+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsdHvIWp+09wnzs8tForMEBUv1xVYXZnv//vonVWvw2aGYL48XsWDT1CKaf/146/1Cs1/4R3xY/9W1B/GP+jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2BiqOgBy2awYGZU8GbB1SvO5H9QCuQyT9YXhtVyL3QU4XmXG
	uFmhIUBPetYzUwOyNX5HZi1PO0cxCSzUKRtQV/Ra3qD0Y6J3/WRZmzyasOeTXLGDeiN+awEkhK9
	gJ3Jx8joYnAQl9Q==
X-Google-Smtp-Source: AGHT+IEqIu3OlacY0Bm+LqAlpJoB8yetidaH8WntE+ttbQ3ZI60SDomuw3uasEM3kvlaRlv8+XaIAZZGkGEx9w==
X-Received: from pfbfb24.prod.google.com ([2002:a05:6a00:2d98:b0:781:e8d:dd2b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d96:b0:35e:6c3:c8d0 with SMTP id adf61e73a8af0-3637e0c5c31mr8915052637.54.1764185783558;
 Wed, 26 Nov 2025 11:36:23 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:55 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-9-dmatlack@google.com>
Subject: [PATCH 08/21] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
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

Enforce that files for incoming (preserved by previous kernel) VFIO
devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
opening the corresponding VFIO character device or via
VFIO_GROUP_GET_DEVICE_FD.

Both of these methods would result in VFIO initializing the device
without access to the preserved state of the device passed by the
previous kernel.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/device_cdev.c |  4 ++++
 drivers/vfio/group.c       |  9 +++++++++
 include/linux/vfio.h       | 11 +++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 0a6e972f322b..f1e54dcc04e7 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -57,6 +57,10 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	struct vfio_device *device = container_of(inode->i_cdev,
 						  struct vfio_device, cdev);
 
+	/* Device file must be retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD */
+	if (vfio_liveupdate_incoming_is_preserved(device))
+		return -EBUSY;
+
 	return __vfio_device_fops_cdev_open(device, filep);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index c376a6279de0..93dbbf37ec4c 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -313,6 +313,15 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
+	/*
+	 * This device was preserved across a Live Update. Accessing it via
+	 * VFIO_GROUP_GET_DEVICE_FD is not allowed.
+	 */
+	if (vfio_liveupdate_incoming_is_preserved(device)) {
+		ret = -EBUSY;
+		goto err_put_device;
+	}
+
 	fdno = get_unused_fd_flags(O_CLOEXEC);
 	if (fdno < 0) {
 		ret = fdno;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 4e400a7219ea..040c2b2ee074 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -16,6 +16,7 @@
 #include <linux/cdev.h>
 #include <uapi/linux/vfio.h>
 #include <linux/iova_bitmap.h>
+#include <linux/pci.h>
 
 struct kvm;
 struct iommufd_ctx;
@@ -425,4 +426,14 @@ static inline int __vfio_device_fops_cdev_open(struct vfio_device *device,
 
 struct vfio_device *vfio_find_device(const void *data, device_match_t match);
 
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	struct device *d = device->dev;
+
+	if (dev_is_pci(d))
+		return pci_liveupdate_incoming_is_preserved(to_pci_dev(d));
+
+	return false;
+}
+
 #endif /* VFIO_H */
-- 
2.52.0.487.g5c8c507ade-goog


