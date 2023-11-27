Return-Path: <linux-kselftest+bounces-628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EF27F99EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 07:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F4F280E9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 06:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5CAD52D;
	Mon, 27 Nov 2023 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SS+jznkO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C57113;
	Sun, 26 Nov 2023 22:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701066875; x=1732602875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iT9eIn278vkOWi9dRXT18eAeEBSlb7+r8lhrdpdya2o=;
  b=SS+jznkOGL/k2AaJrVg3g1ZsLFeZNjA79e2+jJGT6d4+C3ycsWnoL3ok
   OO47oFF0fCb3j6b/WUeNVXOj9fy/DfvNO9S7zinpG43iIHrlknBQSWtZl
   PKvN76NElPEUEnUdwIgIPtvfMLzGr59/Uy/INvZ2M6/O5S0ak+Fh6hdao
   wd6tsSkSyFc92L0Yz/Jq1ex223j32N/N/WYp5GvaVxcMiEhIOHM94N8jF
   RCrLqaiooux7Gphu0RE8hVs89TP4QDn4K5QdRMNbkfkVeacJXOTBs4OCN
   2CUWtPXg5HfY49oFjAbpl+zM7AHH80Q1edTVuOO2vP3rhI+HInFIIwde1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391518158"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="391518158"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:34:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="838608935"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="838608935"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2023 22:34:34 -0800
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
Subject: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
Date: Sun, 26 Nov 2023 22:34:23 -0800
Message-Id: <20231127063428.127436-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127063428.127436-1-yi.l.liu@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/iommu/iommufd/device.c          |  17 ++-
 drivers/iommu/iommufd/iommufd_private.h |  15 +++
 drivers/iommu/iommufd/pasid.c           | 138 ++++++++++++++++++++++++
 include/linux/iommufd.h                 |   6 ++
 5 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/pasid.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 34b446146961..4b4d516b025c 100644
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
index 0992d9d46af9..a7574d4d5ffa 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -136,6 +136,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
+	WARN_ON(!xa_empty(&idev->pasid_hwpts));
 	iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
@@ -216,6 +217,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
 
+	xa_init(&idev->pasid_hwpts);
+
 	/*
 	 * If the caller fails after this success it must call
 	 * iommufd_unbind_device() which is safe since we hold this refcount.
@@ -534,7 +537,17 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 static struct iommufd_hw_pagetable *do_attach(struct iommufd_device *idev,
 		struct iommufd_hw_pagetable *hwpt, struct attach_data *data)
 {
-	return data->attach_fn(idev, hwpt);
+	if (data->pasid == IOMMU_PASID_INVALID) {
+		BUG_ON((data->attach_fn != iommufd_device_do_attach) &&
+		       (data->attach_fn != iommufd_device_do_replace));
+		return data->attach_fn(idev, hwpt);
+	} else {
+		BUG_ON((data->pasid_attach_fn !=
+			iommufd_device_pasid_do_attach) &&
+		       (data->pasid_attach_fn !=
+			iommufd_device_pasid_do_replace));
+		return data->pasid_attach_fn(idev, data->pasid, hwpt);
+	}
 }
 
 /*
@@ -684,6 +697,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	int rc;
 	struct attach_data data = {
 		.attach_fn = &iommufd_device_do_attach,
+		.pasid = IOMMU_PASID_INVALID,
 	};
 
 	rc = iommufd_device_change_pt(idev, pt_id, &data);
@@ -718,6 +732,7 @@ int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 {
 	struct attach_data data = {
 		.attach_fn = &iommufd_device_do_replace,
+		.pasid = IOMMU_PASID_INVALID,
 	};
 
 	return iommufd_device_change_pt(idev, pt_id, &data);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 24fee2c37ce8..d37b7d0bfffe 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -349,6 +349,7 @@ struct iommufd_device {
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
+	struct xarray pasid_hwpts;
 	bool enforce_cache_coherency;
 };
 
@@ -368,9 +369,23 @@ struct attach_data {
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
+struct iommufd_hw_pagetable *
+iommufd_device_pasid_do_attach(struct iommufd_device *idev, u32 pasid,
+			       struct iommufd_hw_pagetable *hwpt);
+struct iommufd_hw_pagetable *
+iommufd_device_pasid_do_replace(struct iommufd_device *idev, u32 pasid,
+				struct iommufd_hw_pagetable *hwpt);
+
 struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/pasid.c b/drivers/iommu/iommufd/pasid.c
new file mode 100644
index 000000000000..75499a1d92a1
--- /dev/null
+++ b/drivers/iommu/iommufd/pasid.c
@@ -0,0 +1,138 @@
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
+struct iommufd_hw_pagetable *
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
+struct iommufd_hw_pagetable *
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
+		.pasid = pasid,
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
+		.pasid = pasid,
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


