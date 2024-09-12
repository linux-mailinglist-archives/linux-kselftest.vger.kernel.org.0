Return-Path: <linux-kselftest+bounces-17841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12068976A50
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365451C2363D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F71AD9CF;
	Thu, 12 Sep 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abd2zzZ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B31AD274;
	Thu, 12 Sep 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147060; cv=none; b=DygIRfrdOCBszbPgtaBXqplEqgZIcTjTs41ZLiZvA3CvsXn5I2HpLCFFllmCWKqRd42Uxa5eGR3nQsP7HJyQ7kVCPRMcr3FPEUXySo81NuPA3fNo99dut3nNsxgBnU95ln5Z4zYtCs/qmyrKBOp7oKsMp2GdqNe73ItgmSmGfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147060; c=relaxed/simple;
	bh=ORiqaMFzDWS7Iedmhg2dvKRmpGRWSqUlNvXrw4PLWuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMkxFY0yI7ue6OjMk8rbOMxrXtCOhVmLci5KMeqPr/Q/EDf8TeSgZbqODbGE1VHrkvcEhrvufMfQOiK40Cp1CB+7KWJOkxR8AYoufIrn3+9TGgs+FqkUETjl55/Y9iszq9QzrFz7CZFHJ1hAZ99jbOburSkHWZvZf/QCaNK6Yc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abd2zzZ8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726147058; x=1757683058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ORiqaMFzDWS7Iedmhg2dvKRmpGRWSqUlNvXrw4PLWuQ=;
  b=abd2zzZ8W2RT0zJmFltVeUH4Nug4jPNVA6ixa6WpifYdMzNeLOvYT46V
   xbtKqTPKHbmGjptv4hv9hNx5d+AOV3fhNQ5v3h9rCc2ii5x209dSw4sJP
   8XV/t4Ln9smToLhRGXvAxHPbJLLW4AVd8TR3O0isvlN0kC49slsfk/znG
   jXKsWqhdQFoPzqcElg89iIHsxgDTG7SAtt+8V7CMANeFLu7uds84hJq09
   JzCvRzeDuXHz2+7UR3BSS9JjQyQFDavF9YgEEkUFQQA4caklBetZHUSgm
   puo6KiqgrQG6jrpdOsXqTgrL+lk7YeD9ZpEw3QKTPvvWJS5MBJORNOjdD
   g==;
X-CSE-ConnectionGUID: /RVvV3nUR3qxfwVArp/w1Q==
X-CSE-MsgGUID: /HPXZDBFQcS8AHePuSw0Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="13493315"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="13493315"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:17:32 -0700
X-CSE-ConnectionGUID: cyTA3GmDR1O2UmZED8PUog==
X-CSE-MsgGUID: wFOkdkN1TL6hddVEsXITow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72692538"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 12 Sep 2024 06:17:33 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v3 2/4] vfio-iommufd: Support pasid [at|de]tach for physical VFIO devices
Date: Thu, 12 Sep 2024 06:17:27 -0700
Message-Id: <20240912131729.14951-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912131729.14951-1-yi.l.liu@intel.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds pasid_at|de]tach_ioas ops for attaching hwpt to pasid of a
device and the helpers for it. For now, only vfio-pci supports pasid
attach/detach.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/iommufd.c      | 50 +++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci.c |  2 ++
 include/linux/vfio.h        | 11 ++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 82eba6966fa5..2f5cb4f616ce 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -119,14 +119,22 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 	vdev->iommufd_device = idev;
+	ida_init(&vdev->pasids);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_physical_bind);
 
 void vfio_iommufd_physical_unbind(struct vfio_device *vdev)
 {
+	int pasid;
+
 	lockdep_assert_held(&vdev->dev_set->lock);
 
+	while ((pasid = ida_find_first(&vdev->pasids)) >= 0) {
+		iommufd_device_pasid_detach(vdev->iommufd_device, pasid);
+		ida_free(&vdev->pasids, pasid);
+	}
+
 	if (vdev->iommufd_attached) {
 		iommufd_device_detach(vdev->iommufd_device);
 		vdev->iommufd_attached = false;
@@ -168,6 +176,48 @@ void vfio_iommufd_physical_detach_ioas(struct vfio_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_physical_detach_ioas);
 
+int vfio_iommufd_physical_pasid_attach_ioas(struct vfio_device *vdev,
+					    u32 pasid, u32 *pt_id)
+{
+	int rc;
+
+	lockdep_assert_held(&vdev->dev_set->lock);
+
+	if (WARN_ON(!vdev->iommufd_device))
+		return -EINVAL;
+
+	if (ida_exists(&vdev->pasids, pasid))
+		return iommufd_device_pasid_replace(vdev->iommufd_device,
+						    pasid, pt_id);
+
+	rc = ida_alloc_range(&vdev->pasids, pasid, pasid, GFP_KERNEL);
+	if (rc < 0)
+		return rc;
+
+	rc = iommufd_device_pasid_attach(vdev->iommufd_device, pasid, pt_id);
+	if (rc)
+		ida_free(&vdev->pasids, pasid);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_iommufd_physical_pasid_attach_ioas);
+
+void vfio_iommufd_physical_pasid_detach_ioas(struct vfio_device *vdev,
+					     u32 pasid)
+{
+	lockdep_assert_held(&vdev->dev_set->lock);
+
+	if (WARN_ON(!vdev->iommufd_device))
+		return;
+
+	if (!ida_exists(&vdev->pasids, pasid))
+		return;
+
+	iommufd_device_pasid_detach(vdev->iommufd_device, pasid);
+	ida_free(&vdev->pasids, pasid);
+}
+EXPORT_SYMBOL_GPL(vfio_iommufd_physical_pasid_detach_ioas);
+
 /*
  * The emulated standard ops mean that vfio_device is going to use the
  * "mdev path" and will call vfio_pin_pages()/vfio_dma_rw(). Drivers using this
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e727941f589d..6f7ae7e5b7b0 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -144,6 +144,8 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.unbind_iommufd	= vfio_iommufd_physical_unbind,
 	.attach_ioas	= vfio_iommufd_physical_attach_ioas,
 	.detach_ioas	= vfio_iommufd_physical_detach_ioas,
+	.pasid_attach_ioas	= vfio_iommufd_physical_pasid_attach_ioas,
+	.pasid_detach_ioas	= vfio_iommufd_physical_pasid_detach_ioas,
 };
 
 static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 000a6cab2d31..11b3b453752e 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -67,6 +67,7 @@ struct vfio_device {
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
+	struct ida pasids;
 	u8 iommufd_attached:1;
 #endif
 	u8 cdev_opened:1;
@@ -91,6 +92,8 @@ struct vfio_device {
  *		 bound iommufd. Undo in unbind_iommufd if @detach_ioas is not
  *		 called.
  * @detach_ioas: Opposite of attach_ioas
+ * @pasid_attach_ioas: The pasid variation of attach_ioas
+ * @pasid_detach_ioas: Opposite of pasid_attach_ioas
  * @open_device: Called when the first file descriptor is opened for this device
  * @close_device: Opposite of open_device
  * @read: Perform read(2) on device file descriptor
@@ -115,6 +118,8 @@ struct vfio_device_ops {
 	void	(*unbind_iommufd)(struct vfio_device *vdev);
 	int	(*attach_ioas)(struct vfio_device *vdev, u32 *pt_id);
 	void	(*detach_ioas)(struct vfio_device *vdev);
+	int	(*pasid_attach_ioas)(struct vfio_device *vdev, u32 pasid, u32 *pt_id);
+	void	(*pasid_detach_ioas)(struct vfio_device *vdev, u32 pasid);
 	int	(*open_device)(struct vfio_device *vdev);
 	void	(*close_device)(struct vfio_device *vdev);
 	ssize_t	(*read)(struct vfio_device *vdev, char __user *buf,
@@ -139,6 +144,8 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
 void vfio_iommufd_physical_unbind(struct vfio_device *vdev);
 int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id);
 void vfio_iommufd_physical_detach_ioas(struct vfio_device *vdev);
+int vfio_iommufd_physical_pasid_attach_ioas(struct vfio_device *vdev, u32 pasid, u32 *pt_id);
+void vfio_iommufd_physical_pasid_detach_ioas(struct vfio_device *vdev, u32 pasid);
 int vfio_iommufd_emulated_bind(struct vfio_device *vdev,
 			       struct iommufd_ctx *ictx, u32 *out_device_id);
 void vfio_iommufd_emulated_unbind(struct vfio_device *vdev);
@@ -166,6 +173,10 @@ vfio_iommufd_get_dev_id(struct vfio_device *vdev, struct iommufd_ctx *ictx)
 	((int (*)(struct vfio_device *vdev, u32 *pt_id)) NULL)
 #define vfio_iommufd_physical_detach_ioas \
 	((void (*)(struct vfio_device *vdev)) NULL)
+#define vfio_iommufd_physical_pasid_attach_ioas \
+	((int (*)(struct vfio_device *vdev, u32 pasid, u32 *pt_id)) NULL)
+#define vfio_iommufd_physical_pasid_detach_ioas \
+	((void (*)(struct vfio_device *vdev, u32 pasid)) NULL)
 #define vfio_iommufd_emulated_bind                                      \
 	((int (*)(struct vfio_device *vdev, struct iommufd_ctx *ictx,   \
 		  u32 *out_device_id)) NULL)
-- 
2.34.1


