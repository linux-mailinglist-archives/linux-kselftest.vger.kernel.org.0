Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3843A7BD5B8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbjJIIvn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345609AbjJIIvg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:51:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0022F102;
        Mon,  9 Oct 2023 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696841493; x=1728377493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1yMPZv0+hy/FoeMbAtBKKDM1b/wty0WUySVOG2Kdxzs=;
  b=OU+rXxQOXeqqApHuqeAtYdMWE8prkmHe58jlq9BFXir9LqfW8WBN1o/A
   s9n1LIlJ6L+lFr42tRI6QQpraLt9m1+HJE6BD3It8fqQyV3cIS3/r13F+
   a/mt+rRJ/TRWQaF4G+hSF1vzNT/rPmWqMPlfOImlTnibjgnnR1PHfJwZ0
   wtLxQN23oKVCuq3bvmm1yKgkKaaqp08LyjkzCNNKUgIUw7D5pGSp6UkIa
   j29RukifBR8dW4AZVMTZTBlL70ZXkEnt3HzAkd14LolcNnMASqXqVZ30Z
   gHpFbkOCMxVowr5eL+GueYnkTzjVUbADgctkHnPCBlE00pP9Lw+IHRpC+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364390800"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="364390800"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818781671"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818781671"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2023 01:51:31 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [RFC 3/7] iommufd: Add iommufd_device_bind_pasid()
Date:   Mon,  9 Oct 2023 01:51:19 -0700
Message-Id: <20231009085123.463179-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009085123.463179-1-yi.l.liu@intel.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kevin Tian <kevin.tian@intel.com>

Intel SIOV allows creating virtual devices of which the vRID is
represented by a pasid of a physical device. So such device can be
bound to an iommufd as physical device does and then later be attached
to an IOAS/hwpt using that pasid.

Binding a virtual device has different security contract comparing
to binding a physical device. There is no DMA ownership claim per
pasid since the parent device is already claimed by the parent driver
including the entire pasid space. With that we simply store the pasid
in the object once it passes other checks.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 72 ++++++++++++++++++++++++-
 drivers/iommu/iommufd/iommufd_private.h |  7 +++
 include/linux/iommufd.h                 |  3 ++
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 9dd76d92b7f6..35c1419ee96b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/msi.h>
 #include "../iommu-priv.h"
 
 #include "io_pagetable.h"
@@ -139,8 +140,10 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	WARN_ON(!xa_empty(&idev->pasid_hwpts));
 	if (idev->has_user_data)
 		dev_iommu_ops(idev->dev)->unset_dev_user_data(idev->dev);
-	iommu_device_release_dma_owner(idev->dev);
-	iommufd_put_group(idev->igroup);
+	if (idev->igroup) {
+		iommu_device_release_dma_owner(idev->dev);
+		iommufd_put_group(idev->igroup);
+	}
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
 		iommufd_ctx_put(idev->ictx);
 }
@@ -257,6 +260,71 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
 
+/**
+ * iommufd_device_bind_pasid - Bind a virtual device to an iommu fd
+ * @ictx: iommufd file descriptor
+ * @dev: Pointer to the parent physical device struct
+ * @pasid: the pasid value representing vRID of this virtual device
+ * @id: Output ID number to return to userspace for this device
+ *
+ * The virtual device always tags its DMA with the provided pasid.
+ * A successful bind allows the pasid to be used in other iommufd
+ * operations e.g. attach/detach and returns struct iommufd_device
+ * pointer, otherwise returns error pointer.
+ *
+ * There is no ownership check per pasid. A driver using this API
+ * must already claim the DMA ownership over the parent device and
+ * the pasid is allocated by the driver itself.
+ *
+ * PASID is a device capability so unlike iommufd_device_bind() it
+ * has no iommu group associated.
+ *
+ * The caller must undo this with iommufd_device_unbind()
+ */
+struct iommufd_device *iommufd_device_bind_pasid(struct iommufd_ctx *ictx,
+						 struct device *dev,
+						 u32 pasid, u32 *id)
+{
+	struct iommufd_device *idev;
+	int rc;
+
+	/*
+	 * iommufd always sets IOMMU_CACHE because we offer no way for userspace
+	 * to restore cache coherency.
+	 */
+	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * No iommu supports pasid-granular msi message today. Here we
+	 * just check whether the parent device can do safe interrupts.
+	 * Isolation between virtual devices within the parent device
+	 * relies on the parent driver to enforce.
+	 */
+	if (!iommufd_selftest_is_mock_dev(dev) &&
+	    !msi_device_has_isolated_msi(dev)) {
+		rc = iommufd_allow_unsafe_interrupts(dev);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
+	idev = iommufd_alloc_device(ictx, dev);
+	if (IS_ERR(idev))
+		return idev;
+	idev->default_pasid = pasid;
+
+	/*
+	 * If the caller fails after this success it must call
+	 * iommufd_unbind_device() which is safe since we hold this refcount.
+	 * This also means the device is a leaf in the graph and no other
+	 * object can take a reference on it.
+	 */
+	iommufd_object_finalize(ictx, &idev->obj);
+	*id = idev->obj.id;
+	return idev;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_bind_pasid, IOMMUFD);
+
 /**
  * iommufd_ctx_has_group - True if any device within the group is bound
  *                         to the ictx
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 06ebee4c87c5..7b3405fd6fd3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -332,10 +332,17 @@ struct iommufd_group {
 struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
+	/* valid if this is a physical device */
 	struct iommufd_group *igroup;
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
+	/*
+	 * valid if this is a virtual device which gains pasid-granular
+	 * DMA isolation in IOMMU. The default pasid is used when attaching
+	 * this device to a IOAS/hwpt.
+	 */
+	u32 default_pasid;
 	struct xarray pasid_hwpts;
 	bool enforce_cache_coherency;
 	bool has_user_data;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 0b007c376306..402320d6eba1 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -20,6 +20,9 @@ struct iommu_group;
 
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
+struct iommufd_device *iommufd_device_bind_pasid(struct iommufd_ctx *ictx,
+						 struct device *dev,
+						 u32 pasid, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
 
 int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id);
-- 
2.34.1

