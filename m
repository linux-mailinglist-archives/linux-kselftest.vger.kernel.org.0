Return-Path: <linux-kselftest+bounces-12920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6E91BAE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 11:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA533284E97
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402E6154C15;
	Fri, 28 Jun 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kgho1iXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256B1527B1;
	Fri, 28 Jun 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565565; cv=none; b=HBiOGjjq3Gu8mog73//zouNWuhF/fKLckVq4KH17OPik9AbnXk4/46wif2CVks1yoVPHKU0qvXfMIRT0Kcv3bgRmblZ3pKs0XcdNm0JLR7aZ023KL/hvA9+YWHCY0hPcOKsOjcvOWH9pzznkVLAL5MoAxFjc8Toi5OwpYdcbE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565565; c=relaxed/simple;
	bh=6iOAUmDH/OZvIYETeDrV5nTOLh1xt3YeRBNG8ojZSH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3JUqcugpk325a6iQoafy98VLzz9EJ3aBPmtGa3M+auHxtkwhTtwIJ/jxvQ2ES3YP3+EKfYdFmULxHxXUb2GoVJrku88kkyqgD4N8f4ks77RHwh9T01k1w/XryV+7YuWsqKiSmCibrboCBYrHlE4MqsqQDnrbjLip80s9aahKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kgho1iXJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719565563; x=1751101563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6iOAUmDH/OZvIYETeDrV5nTOLh1xt3YeRBNG8ojZSH4=;
  b=Kgho1iXJMKj2y+ZrfI3w+zaytT0JSrOcCY8yCjz+NhgKl1SH1PeGg1nb
   FkRPbAkLCrzJv6lFq77w8xrdXlqYxaDcNFURV7X0Fod220/CSmnwu8FXQ
   VUemhm0Oi+h/uzHejLY1vvs8/PhpcJUAM8TWgDUC47GAw5L9TytRJ1Kai
   N9HP/Y8cq9uZ5coQOutrQ+Nbkh97w36kGGgAwDvyfkB8W07IhASHTzrbl
   SgIEMyjxaiI6SbHzFszRf+6VyWkOyV+i7gBBwULKLMEcehm+5q7hRd9eS
   8s759oHdEeDpNbiKDzuRt6/fezGfucYc4jjINDMZc1j0Lof3bumHSy8Cj
   Q==;
X-CSE-ConnectionGUID: 2PDg20/AS/yZ7HfB7y/B0g==
X-CSE-MsgGUID: AeAjLT8LRh6zAQOcaO+nKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20613683"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="20613683"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:06:02 -0700
X-CSE-ConnectionGUID: F3ove92+QzajMARIlkur7w==
X-CSE-MsgGUID: xemDPRgLTmGEefv8OSdMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44517055"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jun 2024 02:06:01 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/7] iommufd: Support attach/replace hwpt per pasid
Date: Fri, 28 Jun 2024 02:05:53 -0700
Message-Id: <20240628090557.50898-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628090557.50898-1-yi.l.liu@intel.com>
References: <20240628090557.50898-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/iommu/iommufd/device.c          |  11 +-
 drivers/iommu/iommufd/iommufd_private.h |  15 +++
 drivers/iommu/iommufd/pasid.c           | 157 ++++++++++++++++++++++++
 include/linux/iommufd.h                 |   6 +
 5 files changed, 184 insertions(+), 6 deletions(-)
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
index 8f13aa94d3af..9933fc492207 100644
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
@@ -531,10 +534,6 @@ iommufd_device_do_replace(struct iommufd_device *idev, u32 pasid,
 	return ERR_PTR(rc);
 }
 
-typedef struct iommufd_hw_pagetable *(*attach_fn)(
-			struct iommufd_device *idev, u32 pasid,
-			struct iommufd_hw_pagetable *hwpt);
-
 /*
  * When automatically managing the domains we search for a compatible domain in
  * the iopt and if one is found use it, otherwise create a new domain.
@@ -618,8 +617,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, u32 pasid,
 	return destroy_hwpt;
 }
 
-static int iommufd_device_change_pt(struct iommufd_device *idev, u32 pasid,
-				    u32 *pt_id, attach_fn do_attach)
+int iommufd_device_change_pt(struct iommufd_device *idev, u32 pasid,
+			     u32 *pt_id, attach_fn do_attach)
 {
 	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_object *pt_obj;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 991f864d1f9b..673ebf5dd0a5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -394,6 +394,7 @@ struct iommufd_device {
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
+	struct xarray pasid_hwpts;
 	bool enforce_cache_coherency;
 };
 
@@ -408,6 +409,20 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
+typedef struct iommufd_hw_pagetable *(*attach_fn)(
+			struct iommufd_device *idev, u32 pasid,
+			struct iommufd_hw_pagetable *hwpt);
+
+int iommufd_device_change_pt(struct iommufd_device *idev, u32 pasid,
+			     u32 *pt_id, attach_fn do_attach);
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
index 000000000000..2f0cb836955f
--- /dev/null
+++ b/drivers/iommu/iommufd/pasid.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, Intel Corporation
+ */
+#include <linux/iommufd.h>
+#include <linux/iommu.h>
+#include "../iommu-priv.h"
+
+#include "iommufd_private.h"
+
+struct iommufd_hw_pagetable *
+iommufd_device_pasid_do_attach(struct iommufd_device *idev, u32 pasid,
+			       struct iommufd_hw_pagetable *hwpt)
+{
+	void *curr;
+	int rc;
+
+	refcount_inc(&hwpt->obj.users);
+	curr = xa_cmpxchg(&idev->pasid_hwpts, pasid, NULL, hwpt, GFP_KERNEL);
+	if (curr) {
+		if (curr == hwpt)
+			rc = 0;
+		else
+			rc = xa_err(curr) ? : -EBUSY;
+		goto err_put_hwpt;
+	}
+
+	rc = iommu_attach_device_pasid(hwpt->domain, idev->dev, pasid);
+	if (rc) {
+		xa_erase(&idev->pasid_hwpts, pasid);
+		goto err_put_hwpt;
+	}
+
+	return NULL;
+
+err_put_hwpt:
+	refcount_dec(&hwpt->obj.users);
+	return ERR_PTR(rc);
+}
+
+struct iommufd_hw_pagetable *
+iommufd_device_pasid_do_replace(struct iommufd_device *idev, u32 pasid,
+				struct iommufd_hw_pagetable *hwpt)
+{
+	void *curr;
+	int rc;
+
+	refcount_inc(&hwpt->obj.users);
+	curr = xa_store(&idev->pasid_hwpts, pasid, hwpt, GFP_KERNEL);
+	rc = xa_err(curr);
+	if (rc)
+		goto out_put_hwpt;
+
+	if (!curr) {
+		xa_erase(&idev->pasid_hwpts, pasid);
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	if (curr == hwpt)
+		goto out_put_hwpt;
+
+	/*
+	 * After replacement, the reference on the old hwpt is retained
+	 * in this thread as caller would free it.
+	 */
+	rc = iommu_replace_device_pasid(hwpt->domain, idev->dev, pasid);
+	if (rc) {
+		WARN_ON(xa_err(xa_store(&idev->pasid_hwpts, pasid,
+					curr, GFP_KERNEL)));
+		goto out_put_hwpt;
+	}
+
+	/* Caller must destroy old_hwpt */
+	return curr;
+
+out_put_hwpt:
+	refcount_dec(&hwpt->obj.users);
+	return ERR_PTR(rc);
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
+ *
+ * iommufd does not handle race between iommufd_device_pasid_attach(),
+ * iommufd_device_pasid_replace() and iommufd_device_pasid_detach().
+ * So caller of them should guarantee no concurrent call on the same
+ * device and pasid.
+ */
+int iommufd_device_pasid_attach(struct iommufd_device *idev,
+				u32 pasid, u32 *pt_id)
+{
+	return iommufd_device_change_pt(idev, pasid, pt_id,
+					&iommufd_device_pasid_do_attach);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_pasid_attach, IOMMUFD);
+
+/**
+ * iommufd_device_pasid_replace - Change the {device, pasid}'s iommu_domain
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
+ *
+ * iommufd does not handle race between iommufd_device_pasid_replace(),
+ * iommufd_device_pasid_attach() and iommufd_device_pasid_detach().
+ * So caller of them should guarantee no concurrent call on the same
+ * device and pasid.
+ */
+int iommufd_device_pasid_replace(struct iommufd_device *idev,
+				 u32 pasid, u32 *pt_id)
+{
+	return iommufd_device_change_pt(idev, pasid, pt_id,
+					&iommufd_device_pasid_do_replace);
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
+ *
+ * iommufd does not handle race between iommufd_device_pasid_detach(),
+ * iommufd_device_pasid_attach() and iommufd_device_pasid_replace().
+ * So caller of them should guarantee no concurrent call on the same
+ * device and pasid.
+ */
+void iommufd_device_pasid_detach(struct iommufd_device *idev, u32 pasid)
+{
+	struct iommufd_hw_pagetable *hwpt;
+
+	hwpt = xa_erase(&idev->pasid_hwpts, pasid);
+	if (WARN_ON(!hwpt))
+		return;
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


