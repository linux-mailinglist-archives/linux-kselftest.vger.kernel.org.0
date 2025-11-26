Return-Path: <linux-kselftest+bounces-46548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAECC8B9AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 954F0359A5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFADE3446AA;
	Wed, 26 Nov 2025 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEPsZ/GI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDBE34321C
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185783; cv=none; b=djnLwwKHVD93cVJmerO6fVDXvHW4mlPep25ShNYvctEYkPhTlJIftexf2gwphS45+/l/+c9BI7pVZJ/NHRfjgkdZKvXKRxJINQ0Dg7PRDG5VI7RzqhEFkafgYsWuCT/XsKnTNLwsmEqtTuAuAGv3A03F/WBgVztjQUnwKFo8UMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185783; c=relaxed/simple;
	bh=ujUPtKhH8eK0VUfq5+GCiwM/drW+JJnPW9gwQ6T/y+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rnlsk31HV8ufJujL1OlAD8IgzGSgRhFQuwm28zqYyQzMHQvLxk9qmgJb9K59tuBBRQISWnjXz8EMIjCtSD1jbm7MjDB2yDmPREybeC/nARkN08IQw41xfdZc7gaXx6dUYoqKiQiESkzkDHPd0VifaLyrDariRZ9hebn7fZlyLZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEPsZ/GI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b82c2c2ca2so94727b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185780; x=1764790580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+rT/I6Er8D4dJfq77ubBBjkiST524x14FZV2ZAC1gg=;
        b=LEPsZ/GIoTjVMON6d8GulqhpcTtGgQToklb3aFboko4OK80K8fK8eYYFRUyn+9Txtg
         iOrnhfcqLt/zmOW0GH5yJxk+fpN0h5Z3uv1mon5bmdCh171YPNNBXflff2TQbnH4mi3k
         N7u0jDqplzZTMjj4hoOleyHm3+B/9MoGVuz7tzJvpAy/VfQ1dfTCUMRdwGh3jflfu1yw
         RU5BLp0SXxxtYnVrjOgkGrrlct5er12KeoT9o6rGPeTqM5AIx8sx7l3gJkqUQi3kAJhn
         YfjuxTBTaYp//2yCa2eL+7DHJNFuBBeH0DoT+3bURmaOzv13jzF8jQH5pdc8HTE0BP87
         pMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185780; x=1764790580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+rT/I6Er8D4dJfq77ubBBjkiST524x14FZV2ZAC1gg=;
        b=KODASeA0Ry9rl/qB3UH0griQ+BxlD+keD7bdix4JFpKnFFxJXgzJOkXImElxLP+d+f
         ZzQmVq5bat8uUHWO+tRVk7/wwdGIcfEabQsIOJEnJiCr0YvVgU8XgTgc9sObEM5RxUDL
         MOa98iyDMvBF1nWekCzUhOnP13dDp17IKmlyL6A4FxU+5hUKUhIEwYttIDmNdLoIgXcB
         xXzONBAYqSKF7zPUHZ/874wfd55EgfJWTs1K9crEgzRDSxPAEczQ9yXyPkz8fRwp3oWX
         VZw4F2Y5MrwhIHhYKSMhP4JKkZMQ5d2rudPdzqo09J1yJHsjZM59H21ElHrRs4D3xmHB
         TaFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqkjTFrCANbEnwUhHpOkyCNTkEJZk0f50qUCMpw1f4qHf6wdYHwgiL8jkN4oy7wslFWaU8EqoLl6sZpa1slEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXlF8UxfDAIjF/tzqSYySgEuyoIDe6nlGiflqc9QU5UKUwXNx
	YkkXgHDq1U2DRFHu7vJ07iGMk7E7QoQTfZyWR8nCbrLU9HKTp5/2MtYHJB023m8Q2LFrLMHFlrv
	deBUP+1/fra1MHQ==
X-Google-Smtp-Source: AGHT+IGDRxLe3KOI/zDK03uAwR3U+/6DpvmuKHCLULTgg0s0yJtUlbehI9/yQQlCmgVCk4FPLCQg3k160b0cAA==
X-Received: from pfgt42.prod.google.com ([2002:a05:6a00:13aa:b0:7ae:e321:13cf])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1399:b0:7b2:1fb0:6da3 with SMTP id d2e1a72fcca58-7c58e60111bmr20427615b3a.24.1764185780467;
 Wed, 26 Nov 2025 11:36:20 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:53 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-7-dmatlack@google.com>
Subject: [PATCH 06/21] vfio/pci: Retrieve preserved device files after Live Update
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

Enable userspace to retrieve preserved VFIO device files from VFIO after
a Live Update by implementing the retrieve() and finish() file handler
callbacks.

Use an anonymous inode when creating the file, since the retrieved
device file is not opened through any particular cdev inode, and the
cdev inode does not matter in practice.

For now the retrieved file is functionally equivalent a opening the
corresponding VFIO cdev file. Subsequent commits will leverage the
preserved state associated with the retrieved file to preserve bits of
the device across Live Update.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-Developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/device_cdev.c             | 21 +++++---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 75 +++++++++++++++++++++++++-
 drivers/vfio/vfio_main.c               | 13 +++++
 include/linux/vfio.h                   | 12 +++++
 4 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 480cac3a0c27..0a6e972f322b 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -16,14 +16,8 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-/*
- * device access via the fd opened by this function is blocked until
- * .open_device() is called successfully during BIND_IOMMUFD.
- */
-int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+int __vfio_device_fops_cdev_open(struct vfio_device *device, struct file *filep)
 {
-	struct vfio_device *device = container_of(inode->i_cdev,
-						  struct vfio_device, cdev);
 	struct vfio_device_file *df;
 	int ret;
 
@@ -52,6 +46,19 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	vfio_device_put_registration(device);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__vfio_device_fops_cdev_open);
+
+/*
+ * device access via the fd opened by this function is blocked until
+ * .open_device() is called successfully during BIND_IOMMUFD.
+ */
+int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+{
+	struct vfio_device *device = container_of(inode->i_cdev,
+						  struct vfio_device, cdev);
+
+	return __vfio_device_fops_cdev_open(device, filep);
+}
 
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index a0147dee8c0f..b7451007fca4 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -8,6 +8,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -124,13 +126,83 @@ static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
 	return ret;
 }
 
+static int match_device(struct device *dev, const void *arg)
+{
+	struct vfio_device *device = container_of(dev, struct vfio_device, device);
+	const struct vfio_pci_core_device_ser *ser = arg;
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	return ser->bdf == pci_dev_id(pdev) && ser->domain == pci_domain_nr(pdev->bus);
+}
+
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_device *device;
+	struct folio *folio;
+	struct file *file;
+	int ret;
+
+	folio = kho_restore_folio(args->serialized_data);
+	if (!folio)
+		return -ENOENT;
+
+	ser = folio_address(folio);
+
+	device = vfio_find_device(ser, match_device);
+	if (!device)
+		return -ENODEV;
+
+	/*
+	 * During a Live Update userspace retrieves preserved VFIO cdev files by
+	 * issuing an ioctl on /dev/liveupdate rather than by opening VFIO
+	 * character devices.
+	 *
+	 * To handle that scenario, this routine simulates opening the VFIO
+	 * character device for userspace with an anonymous inode. The returned
+	 * file has the same properties as a cdev file (e.g. operations are
+	 * blocked until BIND_IOMMUFD is called), aside from the inode
+	 * association.
+	 */
+	file = anon_inode_getfile_fmode("[vfio-device-liveupdate]",
+					&vfio_device_fops, NULL,
+					O_RDWR, FMODE_PREAD | FMODE_PWRITE);
+
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto out;
+	}
+
+	ret = __vfio_device_fops_cdev_open(device, file);
+	if (ret) {
+		fput(file);
+		goto out;
+	}
+
+	args->file = file;
+
+out:
+	/* Drop the reference from vfio_find_device() */
+	put_device(&device->device);
+
+	return ret;
+}
+
+static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
+{
+	return args->retrieved;
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	struct folio *folio;
+
+	folio = virt_to_folio(phys_to_virt(args->serialized_data));
+	folio_put(folio);
 }
 
 static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
@@ -139,6 +211,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
 	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
+	.can_finish = vfio_pci_liveupdate_can_finish,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
 };
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 9182dc46d73f..c5b5eb509474 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -13,6 +13,7 @@
 #include <linux/cdev.h>
 #include <linux/compat.h>
 #include <linux/device.h>
+#include <linux/device/class.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/iommu.h>
@@ -1706,6 +1707,18 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
 }
 EXPORT_SYMBOL(vfio_dma_rw);
 
+struct vfio_device *vfio_find_device(const void *data, device_match_t match)
+{
+	struct device *device;
+
+	device = class_find_device(vfio.device_class, NULL, data, match);
+	if (!device)
+		return NULL;
+
+	return container_of(device, struct vfio_device, device);
+}
+EXPORT_SYMBOL_GPL(vfio_find_device);
+
 /*
  * Module/class support
  */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index f09da3bdf786..4e400a7219ea 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -413,4 +413,16 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
 void vfio_virqfd_disable(struct virqfd **pvirqfd);
 void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
+#if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
+int __vfio_device_fops_cdev_open(struct vfio_device *device, struct file *filep);
+#else
+static inline int __vfio_device_fops_cdev_open(struct vfio_device *device,
+					       struct file *filep)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
+
+struct vfio_device *vfio_find_device(const void *data, device_match_t match);
+
 #endif /* VFIO_H */
-- 
2.52.0.487.g5c8c507ade-goog


