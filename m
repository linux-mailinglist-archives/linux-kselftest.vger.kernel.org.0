Return-Path: <linux-kselftest+bounces-634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F3E7F9A0B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 07:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BA71C20B18
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A38D291;
	Mon, 27 Nov 2023 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsFim5ho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241BC133;
	Sun, 26 Nov 2023 22:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701067152; x=1732603152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pDVskkLMVGFFDFeU0VLYi3kSiq/U4WCUpxivzmmSlTI=;
  b=HsFim5hoB3kzXWAGVDs0KH6USQpAYzACKdQwg17QOnG1bZxQbJU3iZik
   TDVvhBzWvKIsNuPya+Ft2ZyMNEB3NeeiTe91kC3quKJj61JN8FKgUCyZI
   3vqU43omVTSLAM2tQKl3u81gXwHoOHIwN4szP+GqRET4ZVYuaBnrz7+Fn
   7NRkDHUg3zH8PU7+ukybz5KgaL267YgIDEjtJp0dpzMOSNpigvOokjhGH
   3Hi+3Kb8nCzPLByhesPhB5YUixxOtupEfxh5Dkch5X+obJilZpkYD1IHR
   Yf+FFL7f7+WHqeJcb3kSIMVD6Lbnc34xbgVTVU85tfsgcgrugSGkY6ZY4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="392397735"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="392397735"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="717940808"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="717940808"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2023 22:39:11 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com,
	xin.zeng@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH 1/3] vfio-iommufd: Support pasid [at|de]tach for physical VFIO devices
Date: Sun, 26 Nov 2023 22:39:07 -0800
Message-Id: <20231127063909.129153-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127063909.129153-1-yi.l.liu@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Tian <kevin.tian@intel.com>

This adds pasid_at|de]tach_ioas ops for attaching hwpt to pasid of a
device and the helpers for it. For now, only vfio-pci supports pasid
attach/detach.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/iommufd.c      | 48 +++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci.c |  2 ++
 include/linux/vfio.h        | 11 +++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 82eba6966fa5..43a702b9b4d3 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -119,6 +119,7 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 	vdev->iommufd_device = idev;
+	xa_init(&vdev->pasid_pts);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_physical_bind);
@@ -127,6 +128,17 @@ void vfio_iommufd_physical_unbind(struct vfio_device *vdev)
 {
 	lockdep_assert_held(&vdev->dev_set->lock);
 
+	if (!xa_empty(&vdev->pasid_pts)) {
+		void *entry;
+		unsigned long index;
+
+		xa_for_each(&vdev->pasid_pts, index, entry) {
+			xa_erase(&vdev->pasid_pts, index);
+			iommufd_device_pasid_detach(vdev->iommufd_device, index);
+		}
+		xa_destroy(&vdev->pasid_pts);
+	}
+
 	if (vdev->iommufd_attached) {
 		iommufd_device_detach(vdev->iommufd_device);
 		vdev->iommufd_attached = false;
@@ -168,6 +180,42 @@ void vfio_iommufd_physical_detach_ioas(struct vfio_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_iommufd_physical_detach_ioas);
 
+int vfio_iommufd_physical_pasid_attach_ioas(struct vfio_device *vdev,
+					    u32 pasid, u32 *pt_id)
+{
+	void *entry;
+	int rc;
+
+	lockdep_assert_held(&vdev->dev_set->lock);
+
+	if (WARN_ON(!vdev->iommufd_device))
+		return -EINVAL;
+
+	entry = xa_load(&vdev->pasid_pts, pasid);
+	if (xa_is_value(entry))
+		rc = iommufd_device_pasid_replace(vdev->iommufd_device, pasid, pt_id);
+	else
+		rc = iommufd_device_pasid_attach(vdev->iommufd_device, pasid, pt_id);
+	if (rc)
+		return rc;
+	xa_store(&vdev->pasid_pts, pasid, xa_mk_value(*pt_id), GFP_KERNEL);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_iommufd_physical_pasid_attach_ioas);
+
+void vfio_iommufd_physical_pasid_detach_ioas(struct vfio_device *vdev, u32 pasid)
+{
+	lockdep_assert_held(&vdev->dev_set->lock);
+
+	if (WARN_ON(!vdev->iommufd_device) ||
+	    !xa_is_value(xa_load(&vdev->pasid_pts, pasid)))
+		return;
+
+	iommufd_device_pasid_detach(vdev->iommufd_device, pasid);
+	xa_erase(&vdev->pasid_pts, pasid);
+}
+EXPORT_SYMBOL_GPL(vfio_iommufd_physical_pasid_detach_ioas);
+
 /*
  * The emulated standard ops mean that vfio_device is going to use the
  * "mdev path" and will call vfio_pin_pages()/vfio_dma_rw(). Drivers using this
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index cb5b7f865d58..e0198851ffd2 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -142,6 +142,8 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.unbind_iommufd	= vfio_iommufd_physical_unbind,
 	.attach_ioas	= vfio_iommufd_physical_attach_ioas,
 	.detach_ioas	= vfio_iommufd_physical_detach_ioas,
+	.pasid_attach_ioas	= vfio_iommufd_physical_pasid_attach_ioas,
+	.pasid_detach_ioas	= vfio_iommufd_physical_pasid_detach_ioas,
 };
 
 static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 454e9295970c..7b06d1bc7cb3 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -66,6 +66,7 @@ struct vfio_device {
 	void (*put_kvm)(struct kvm *kvm);
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
+	struct xarray pasid_pts;
 	u8 iommufd_attached:1;
 #endif
 	u8 cdev_opened:1;
@@ -83,6 +84,8 @@ struct vfio_device {
  *		 bound iommufd. Undo in unbind_iommufd if @detach_ioas is not
  *		 called.
  * @detach_ioas: Opposite of attach_ioas
+ * @pasid_attach_ioas: The pasid variation of attach_ioas
+ * @pasid_detach_ioas: Opposite of pasid_attach_ioas
  * @open_device: Called when the first file descriptor is opened for this device
  * @close_device: Opposite of open_device
  * @read: Perform read(2) on device file descriptor
@@ -107,6 +110,8 @@ struct vfio_device_ops {
 	void	(*unbind_iommufd)(struct vfio_device *vdev);
 	int	(*attach_ioas)(struct vfio_device *vdev, u32 *pt_id);
 	void	(*detach_ioas)(struct vfio_device *vdev);
+	int	(*pasid_attach_ioas)(struct vfio_device *vdev, u32 pasid, u32 *pt_id);
+	void	(*pasid_detach_ioas)(struct vfio_device *vdev, u32 pasid);
 	int	(*open_device)(struct vfio_device *vdev);
 	void	(*close_device)(struct vfio_device *vdev);
 	ssize_t	(*read)(struct vfio_device *vdev, char __user *buf,
@@ -131,6 +136,8 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
 void vfio_iommufd_physical_unbind(struct vfio_device *vdev);
 int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id);
 void vfio_iommufd_physical_detach_ioas(struct vfio_device *vdev);
+int vfio_iommufd_physical_pasid_attach_ioas(struct vfio_device *vdev, u32 pasid, u32 *pt_id);
+void vfio_iommufd_physical_pasid_detach_ioas(struct vfio_device *vdev, u32 pasid);
 int vfio_iommufd_emulated_bind(struct vfio_device *vdev,
 			       struct iommufd_ctx *ictx, u32 *out_device_id);
 void vfio_iommufd_emulated_unbind(struct vfio_device *vdev);
@@ -158,6 +165,10 @@ vfio_iommufd_get_dev_id(struct vfio_device *vdev, struct iommufd_ctx *ictx)
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


