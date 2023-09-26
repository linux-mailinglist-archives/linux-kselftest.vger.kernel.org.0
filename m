Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0A7AE90E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 11:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjIZJ1K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 05:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjIZJ1H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 05:27:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFEE1B9;
        Tue, 26 Sep 2023 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720418; x=1727256418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/jMgHbI2vnrxex5iYuctaTU7TZflpxPApcEC+X4cnK4=;
  b=i9bMJ8Tjtlap2uY4tS8e/oXqCZvx0kp+ugg1KwlT5xPCKttv9HjZ8kAh
   NYlnJIyyip8SyhFI0hAj0PhSAE212rRUGHXPxHj3oAZVKXAcUM8nBoI5e
   LNPTF+yIb1UR3G9EVNXAhprjFuNk4DZ7YbYSYGVxCzJZnXt8G3PLC/Boi
   Ml0c6SYPRBsaNm2V9ldS8Bczdn0XzsHJR5SFg0uFN25i+d+VTVxWZhaZG
   /25QU9NTjFQqlYu+phNLRuLLt1VQm9zmyrrjhSNSGLaASTGuDXBb044Th
   HK/jz+BTUwMxc9oWoeE4HgoH7RxbYRCzqMepyFJM+NEJKBBkxb6HZlB/A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360905366"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360905366"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079642548"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="1079642548"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2023 02:26:56 -0700
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
Subject: [RFC 3/8] iommufd: Support attach/replace hwpt per pasid
Date:   Tue, 26 Sep 2023 02:26:46 -0700
Message-Id: <20230926092651.17041-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926092651.17041-1-yi.l.liu@intel.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
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

This introduces three APIs for device drivers to manage pasid attach/
replace/detach.

    int iommufd_device_pasid_attach(struct iommufd_device *idev,
				    u32 pasid, u32 *pt_id);
    int iommufd_device_pasid_replace(struct iommufd_device *idev,
				     u32 pasid, u32 *pt_id);
    void iommufd_device_pasid_detach(struct iommufd_device *idev,
				     u32 pasid);

pasid operations have different implications when comparing to device
operations:

 - No connection to iommufd_group since pasid is a device capability
   and can be enabled only in singleton group;

 - no reserved region per pasid otherwise SVA architecture is already
   broken (CPU address space doesn't count device reserved regions);

 - accordingly no sw_msi trick;

 - immediated_attach is not supported, expecting that arm-smmu driver
   will already remove that requirement before supporting this pasid
   operation. This avoids unnecessary change in iommufd_hw_pagetable_alloc()
   to carry the pasid from device.c.

With above differences, this puts all pasid related logics into a new
pasid.c file.

Cache coherency enforcement is still applied to pasid operations since
it is about memory accesses post page table walking (no matter the walk
is per RID or per PASID).

Since the attach is per PASID, this introduces a pasid_hwpts xarray to
track the per-pasid attach data.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/device.c          |   9 +-
 drivers/iommu/iommufd/iommufd_private.h |   8 ++
 drivers/iommu/iommufd/pasid.c           | 152 ++++++++++++++++++++++++
 include/linux/iommufd.h                 |   6 +
 5 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/pasid.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 8aeba81800c5..be83044a5101 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -6,6 +6,7 @@ iommufd-y := \
 	ioas.o \
 	main.o \
 	pages.o \
+	pasid.o \
 	vfio_compat.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4fa4153c5df7..f88f31368eec 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -136,6 +136,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
+	WARN_ON(!xa_empty(&idev->pasid_hwpts));
 	if (idev->has_user_data)
 		dev_iommu_ops(idev->dev)->unset_dev_user_data(idev->dev);
 	iommu_device_release_dma_owner(idev->dev);
@@ -218,6 +219,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
 
+	xa_init(&idev->pasid_hwpts);
+
 	/*
 	 * If the caller fails after this success it must call
 	 * iommufd_unbind_device() which is safe since we hold this refcount.
@@ -600,7 +603,9 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 static struct iommufd_hw_pagetable *do_attach(struct iommufd_device *idev,
 		struct iommufd_hw_pagetable *hwpt, struct attach_data *data)
 {
-	return data->attach_fn(idev, hwpt);
+	return data->pasid == IOMMU_PASID_INVALID ?
+		data->attach_fn(idev, hwpt) :
+		data->pasid_attach_fn(idev, data->pasid, hwpt);
 }
 
 /*
@@ -747,6 +752,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	int rc;
 	struct attach_data data = {
 		.attach_fn = &iommufd_device_do_attach,
+		.pasid = IOMMU_PASID_INVALID
 	};
 
 	rc = iommufd_device_change_pt(idev, pt_id, &data);
@@ -781,6 +787,7 @@ int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 {
 	struct attach_data data = {
 		.attach_fn = &iommufd_device_do_replace,
+		.pasid = IOMMU_PASID_INVALID
 	};
 
 	return iommufd_device_change_pt(idev, pt_id, &data);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f1fe4120c3b1..97f0e8f28d69 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -336,6 +336,7 @@ struct iommufd_device {
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
+	struct xarray pasid_hwpts;
 	bool enforce_cache_coherency;
 	bool has_user_data;
 };
@@ -358,9 +359,16 @@ struct attach_data {
 		struct iommufd_hw_pagetable *(*attach_fn)(
 				struct iommufd_device *idev,
 				struct iommufd_hw_pagetable *hwpt);
+		struct iommufd_hw_pagetable *(*pasid_attach_fn)(
+				struct iommufd_device *idev, u32 pasid,
+				struct iommufd_hw_pagetable *hwpt);
 	};
+	u32 pasid;
 };
 
+int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
+			     struct attach_data *data);
+
 struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/pasid.c b/drivers/iommu/iommufd/pasid.c
new file mode 100644
index 000000000000..bdfdf5b2a48d
--- /dev/null
+++ b/drivers/iommu/iommufd/pasid.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023, Intel Corporation
+ */
+#include <linux/iommufd.h>
+#include <linux/iommu.h>
+#include "../iommu-priv.h"
+
+#include "iommufd_private.h"
+
+static int __iommufd_device_pasid_do_attach(struct iommufd_device *idev,
+					    u32 pasid,
+					    struct iommufd_hw_pagetable *hwpt,
+					    bool replace)
+{
+	int rc;
+
+	/*
+	 * Try to upgrade the domain we have. This is also required for
+	 * pasid attach since pasid only matters for identifying a hwpt
+	 * while cache coherency is about memory access semantics post
+	 * walking hwpt.
+	 *
+	 * Only for kernel-managed hwpt.
+	 */
+	if (idev->enforce_cache_coherency && !hwpt->user_managed) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (rc)
+			return rc;
+	}
+
+	if (!replace)
+		rc = iommu_attach_device_pasid(hwpt->domain, idev->dev, pasid);
+	else
+		rc = iommu_replace_device_pasid(hwpt->domain, idev->dev, pasid);
+	if (rc)
+		return rc;
+
+	refcount_inc(&hwpt->obj.users);
+	xa_store(&idev->pasid_hwpts, pasid, hwpt, GFP_KERNEL);
+	return 0;
+}
+
+static struct iommufd_hw_pagetable *
+iommufd_device_pasid_do_attach(struct iommufd_device *idev, u32 pasid,
+			       struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_hw_pagetable *old_hwpt;
+	int rc;
+
+	old_hwpt = xa_load(&idev->pasid_hwpts, pasid);
+	if (old_hwpt) {
+		/* Attach does not allow overwrite */
+		if (old_hwpt == hwpt)
+			return NULL;
+		else
+			return ERR_PTR(-EINVAL);
+	}
+
+	rc = __iommufd_device_pasid_do_attach(idev, pasid, hwpt, false);
+	return rc ? ERR_PTR(rc) : NULL;
+}
+
+static struct iommufd_hw_pagetable *
+iommufd_device_pasid_do_replace(struct iommufd_device *idev, u32 pasid,
+				struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_hw_pagetable *old_hwpt;
+	int rc;
+
+	old_hwpt = xa_load(&idev->pasid_hwpts, pasid);
+	if (!old_hwpt)
+		return ERR_PTR(-EINVAL);
+
+	if (hwpt == old_hwpt)
+		return NULL;
+
+	rc = __iommufd_device_pasid_do_attach(idev, pasid, hwpt, true);
+	/* Caller must destroy old_hwpt */
+	return rc ? ERR_PTR(rc) : old_hwpt;
+}
+
+/**
+ * iommufd_device_pasid_attach - Connect a {device, pasid} to an iommu_domain
+ * @idev: device to attach
+ * @pasid: pasid to attach
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ *
+ * This connects a pasid of the device to an iommu_domain. Once this
+ * completes the device could do DMA with the pasid.
+ *
+ * This function is undone by calling iommufd_device_detach_pasid().
+ */
+int iommufd_device_pasid_attach(struct iommufd_device *idev,
+				u32 pasid, u32 *pt_id)
+{
+	struct attach_data data = {
+		.pasid_attach_fn = &iommufd_device_pasid_do_attach,
+		.pasid = pasid
+	};
+
+	return iommufd_device_change_pt(idev, pt_id, &data);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_pasid_attach, IOMMUFD);
+
+/**
+ * iommufd_device_pasid_replace- Change the {device, pasid}'s iommu_domain
+ * @idev: device to change
+ * @pasid: pasid to change
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ *
+ * This is the same as
+ *   iommufd_device_pasid_detach();
+ *   iommufd_device_pasid_attach();
+ *
+ * If it fails then no change is made to the attachment. The iommu driver may
+ * implement this so there is no disruption in translation. This can only be
+ * called if iommufd_device_pasid_attach() has already succeeded.
+ */
+int iommufd_device_pasid_replace(struct iommufd_device *idev,
+				 u32 pasid, u32 *pt_id)
+{
+	struct attach_data data = {
+		.pasid_attach_fn = &iommufd_device_pasid_do_replace,
+		.pasid = pasid
+	};
+
+	return iommufd_device_change_pt(idev, pt_id, &data);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_pasid_replace, IOMMUFD);
+
+/**
+ * iommufd_device_pasid_detach - Disconnect a {device, pasid} to an iommu_domain
+ * @idev: device to detach
+ * @pasid: pasid to detach
+ *
+ * Undo iommufd_device_pasid_attach(). This disconnects the idev/pasid from
+ * the previously attached pt_id.
+ */
+void iommufd_device_pasid_detach(struct iommufd_device *idev, u32 pasid)
+{
+	struct iommufd_hw_pagetable *hwpt;
+
+	hwpt = xa_load(&idev->pasid_hwpts, pasid);
+	if (!hwpt)
+		return;
+	xa_erase(&idev->pasid_hwpts, pasid);
+	iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
+	iommufd_hw_pagetable_put(idev->ictx, hwpt);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_pasid_detach, IOMMUFD);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ffc3a949f837..0b007c376306 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -26,6 +26,12 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id);
 int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id);
 void iommufd_device_detach(struct iommufd_device *idev);
 
+int iommufd_device_pasid_attach(struct iommufd_device *idev,
+				u32 pasid, u32 *pt_id);
+int iommufd_device_pasid_replace(struct iommufd_device *idev,
+				 u32 pasid, u32 *pt_id);
+void iommufd_device_pasid_detach(struct iommufd_device *idev, u32 pasid);
+
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
 u32 iommufd_device_to_id(struct iommufd_device *idev);
 
-- 
2.34.1

