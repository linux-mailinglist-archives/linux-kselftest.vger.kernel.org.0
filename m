Return-Path: <linux-kselftest+bounces-46547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6878C8B9A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AF3135991C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F7343D82;
	Wed, 26 Nov 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OF99GhsF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3E342C8C
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185782; cv=none; b=a6gYRnwh5R89IJ0IL0f+TjyZ00WUAvTivvN/fKLstbOKnxB1Fm2Ed7Lmhe8US5igQjuIWLsPKvLDvM3YSuUrB3z2q/VhdBCA61n+io2Hep/lgb5ftxqoTdwpuwGeUTtAkJgjCPEcYb3pvRUf5bXZJnARDbrucbHlaQkz6ZJWypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185782; c=relaxed/simple;
	bh=eWQ0jCNtCej3K5+qd3kNS3unsOCSFfv5PnVYoXcfUwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XaOgEYemL3aJ0SJRyu4AI98x6mjdPf6FfI8Frk5m+/Pm44i6TJiFvKmARAJ5BOw6PcjruSsF/i8OsjbXZ3bNZX3Ry/PSIRfkswLBQoWCbhOe7md7E/xLNottj1/5cqjOx6Hy6+73T2+Nix/Z4vfxV7B9lvVeN/s8Uze0tRYIcak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OF99GhsF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b9208e1976so98693b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185779; x=1764790579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ewOyHN8sWLyC5m0IHbHnpnDsQX1yh6Ng3tYlExD0qM=;
        b=OF99GhsFHzEVXZ9zyJO3PtjymIap0eRmnwm+led79mMqBRUhG5nl0XcNzmaTmOaT6r
         BXoOSKlfRSzM/sMc2NvehaPD6M9EO1IoRt8jaUg2SBP3TdpKr+gnfT84zuLlm7PUPGn2
         68Rinqs4jgSEQ6zr1cfCDqOFQ7w/azQYcSZ/IO3SrgcqmfMFkke+btb6TlOn6Q7hmW1m
         lwddOgTpWLmm+EtP1vjWlMFHJmkPYsB2Vy9wwgXt1pFPXrRjFCCU9+VFGc6Z3zWtZozd
         tMGaXmivG///ZYF0OTY1EX/V/+OXFfuN0VJkF75zsLWDJrKNvs5LCpL0fdqMvS5D/mKo
         K+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185779; x=1764790579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ewOyHN8sWLyC5m0IHbHnpnDsQX1yh6Ng3tYlExD0qM=;
        b=fJFALzTp0owvG4Off1n4/E2ucU+zOQGdIdAYp9BuSAY2IKoehJt4s2SKywV1L3KOeH
         VU+K95Uc9uToaRTYtlHnPgH0DtYBOWE524/0/7Gpd/UHoYxpWmwBy18rpvMdWg95N491
         TiHFIZhBCOoM4wuNA8Sj4NUU2EZkwxeg9nA+Fn/xUHMxAmgtg6tBWYtyepbgq2vtOFVw
         VRqVwx3Ie9IaW5TAQvGtqso2hohHgZI26Lzk4oydIXw7QzZP+5OM2sIbLmcYlQEz3G6W
         tuDL4kse68QkXFHHux6B+DzZGYcuHIzLi9qQU3kGZnHn2X7NExUpSj3G+YZx5Ry9hDE+
         gtcw==
X-Forwarded-Encrypted: i=1; AJvYcCU25WEzgysCQs+ABnrVYt8acEaKPUtEyfueL/XKENSCE9TL+SfVAvfnZDm0ZKfzCtUZaeoy1EewsrMrA7YuWVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmI24moZOXh7RAkPY0HLqU9JTWrFq7OlvE+76+Xf/buNyRMUrm
	fxaEcKtesdolYmVUVv3e0gopIpT23w/hlCjimpXKypk7wMgzKuywWG5Tq6IT6ukhVio1VtRp4lk
	YRuZa++MrZzAwGA==
X-Google-Smtp-Source: AGHT+IHBXARD0M4TNVc+5iNMok8lRsm6YAxKL931j3Ozfj+tg8nBvG322NUGKmqWAR0CwYxApWkwx5vZFj9KpQ==
X-Received: from pfblu1.prod.google.com ([2002:a05:6a00:7481:b0:7ba:6768:fe53])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3983:b0:7ac:78d6:5f00 with SMTP id d2e1a72fcca58-7c58effc48emr22677849b3a.31.1764185778900;
 Wed, 26 Nov 2025 11:36:18 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:52 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-6-dmatlack@google.com>
Subject: [PATCH 05/21] vfio/pci: Preserve vfio-pci device files across Live Update
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

Implement the live update file handler callbacks to preserve a vfio-pci
device across a Live Update. Subsequent commits will enable userspace to
then retrieve this file after the Live Update.

Live Update support is scoped only to cdev files (i.e. not
VFIO_GROUP_GET_DEVICE_FD files).

State about each device is serialized into a new ABI struct
vfio_pci_core_device_ser. The contents of this struct are preserved
across the Live Update to the next kernel using a combination of
Kexec-Handover (KHO) to preserve the page(s) holding the struct and the
Live Update Orchestrator (LUO) to preserve the physical address of the
struct.

For now the only contents of struct vfio_pci_core_device_ser the
device's PCI segment number and BDF, so that the device can be uniquely
identified after the Live Update.

Require that userspace disables interrupts on the device prior to
freeze() so that the device does not send any interrupts until new
interrupt handlers have been set up by the next kernel.

Reset the device and restore its state in the freeze() callback. This
ensures the device can be received by the next kernel in a consistent
state. Eventually this will be dropped and the device can be preserved
across in a running state, but that requires further work in VFIO and
the core PCI layer.

Note that LUO holds a reference to this file when it is preserved. So
VFIO is guaranteed that vfio_df_device_last_close() will not be called
on this device no matter what userspace does.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-Developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci.c            |   2 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 100 ++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h       |   2 +
 drivers/vfio/vfio.h                    |  13 ----
 drivers/vfio/vfio_main.c               |   9 ---
 include/linux/kho/abi/vfio_pci.h       |  15 ++++
 include/linux/vfio.h                   |  28 +++++++
 7 files changed, 144 insertions(+), 25 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index c2fe34a830d8..281c69c086d3 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 	return 0;
 }
 
-static const struct vfio_device_ops vfio_pci_ops = {
+const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
 	.init		= vfio_pci_core_init_dev,
 	.release	= vfio_pci_core_release_dev,
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index b84e63c0357b..a0147dee8c0f 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -8,25 +8,120 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
 #include <linux/errno.h>
+#include <linux/vfio.h>
 
 #include "vfio_pci_priv.h"
 
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					     struct file *file)
 {
-	return false;
+	struct vfio_device_file *df = to_vfio_device_file(file);
+
+	if (!df)
+		return false;
+
+	/* Live Update support is limited to cdev files. */
+	if (df->group)
+		return false;
+
+	return df->device->ops == &vfio_pci_ops;
 }
 
 static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+	struct folio *folio;
+	int err;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM))
+		return -EINVAL;
+
+	if (vfio_pci_is_intel_display(pdev))
+		return -EINVAL;
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, get_order(sizeof(*ser)));
+	if (!folio)
+		return -ENOMEM;
+
+	ser = folio_address(folio);
+
+	ser->bdf = pci_dev_id(pdev);
+	ser->domain = pci_domain_nr(pdev->bus);
+
+	err = kho_preserve_folio(folio);
+	if (err)
+		goto error;
+
+	args->serialized_data = virt_to_phys(ser);
+	return 0;
+
+error:
+	folio_put(folio);
+	return err;
 }
 
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
+	struct vfio_pci_core_device_ser *ser = phys_to_virt(args->serialized_data);
+	struct folio *folio = virt_to_folio(ser);
+
+	kho_unpreserve_folio(folio);
+	folio_put(folio);
+}
+
+static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
+{
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+	int ret;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	guard(mutex)(&device->dev_set->lock);
+
+	/*
+	 * Userspace must disable interrupts on the device prior to freeze so
+	 * that the device does not send any interrupts until new interrupt
+	 * handlers have been established by the next kernel.
+	 */
+	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
+		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
+		return -EINVAL;
+	}
+
+	pci_dev_lock(pdev);
+
+	ret = pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state);
+	if (ret)
+		goto out;
+
+	/*
+	 * Reset the device and restore it back to its original state before
+	 * handing it to the next kernel.
+	 *
+	 * Eventually both of these should be dropped and the device should be
+	 * kept running with its current state across the Live Update.
+	 */
+	if (vdev->reset_works)
+		ret = __pci_reset_function_locked(pdev);
+
+	pci_restore_state(pdev);
+
+out:
+	pci_dev_unlock(pdev);
+	return ret;
 }
 
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
@@ -42,6 +137,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.can_preserve = vfio_pci_liveupdate_can_preserve,
 	.preserve = vfio_pci_liveupdate_preserve,
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
+	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index b9f7c4e2b4df..7f189e5e6c0a 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -11,6 +11,8 @@
 /* Cap maximum number of ioeventfds per device (arbitrary) */
 #define VFIO_PCI_IOEVENTFD_MAX		1000
 
+extern const struct vfio_device_ops vfio_pci_ops;
+
 struct vfio_pci_ioeventfd {
 	struct list_head	next;
 	struct vfio_pci_core_device	*vdev;
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..6b89edbbf174 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -16,17 +16,6 @@ struct iommufd_ctx;
 struct iommu_group;
 struct vfio_container;
 
-struct vfio_device_file {
-	struct vfio_device *device;
-	struct vfio_group *group;
-
-	u8 access_granted;
-	u32 devid; /* only valid when iommufd is valid */
-	spinlock_t kvm_ref_lock; /* protect kvm field */
-	struct kvm *kvm;
-	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
-};
-
 void vfio_device_put_registration(struct vfio_device *device);
 bool vfio_device_try_get_registration(struct vfio_device *device);
 int vfio_df_open(struct vfio_device_file *df);
@@ -34,8 +23,6 @@ void vfio_df_close(struct vfio_device_file *df);
 struct vfio_device_file *
 vfio_allocate_device_file(struct vfio_device *device);
 
-extern const struct file_operations vfio_device_fops;
-
 #ifdef CONFIG_VFIO_NOIOMMU
 extern bool vfio_noiommu __read_mostly;
 #else
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 38c8e9350a60..9182dc46d73f 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1386,15 +1386,6 @@ const struct file_operations vfio_device_fops = {
 #endif
 };
 
-static struct vfio_device *vfio_device_from_file(struct file *file)
-{
-	struct vfio_device_file *df = file->private_data;
-
-	if (file->f_op != &vfio_device_fops)
-		return NULL;
-	return df->device;
-}
-
 /**
  * vfio_file_is_valid - True if the file is valid vfio file
  * @file: VFIO group file or VFIO device file
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 37a845eed972..9bf58a2f3820 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -9,6 +9,9 @@
 #ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
 #define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
 
+#include <linux/compiler.h>
+#include <linux/types.h>
+
 /**
  * DOC: VFIO PCI Live Update ABI
  *
@@ -25,4 +28,16 @@
 
 #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
 
+/**
+ * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
+ * device.
+ *
+ * @bdf: The device's PCI bus, device, and function number.
+ * @domain: The device's PCI domain number (segment).
+ */
+struct vfio_pci_core_device_ser {
+	u16 bdf;
+	u16 domain;
+} __packed;
+
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index eb563f538dee..f09da3bdf786 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -80,6 +80,34 @@ struct vfio_device {
 #endif
 };
 
+struct vfio_device_file {
+	struct vfio_device *device;
+	struct vfio_group *group;
+
+	u8 access_granted;
+	u32 devid; /* only valid when iommufd is valid */
+	spinlock_t kvm_ref_lock; /* protect kvm field */
+	struct kvm *kvm;
+	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
+};
+
+extern const struct file_operations vfio_device_fops;
+
+static inline struct vfio_device_file *to_vfio_device_file(struct file *file)
+{
+	if (file->f_op != &vfio_device_fops)
+		return NULL;
+
+	return file->private_data;
+}
+
+static inline struct vfio_device *vfio_device_from_file(struct file *file)
+{
+	struct vfio_device_file *df = to_vfio_device_file(file);
+
+	return df ? df->device : NULL;
+}
+
 /**
  * struct vfio_device_ops - VFIO bus driver device callbacks
  *
-- 
2.52.0.487.g5c8c507ade-goog


