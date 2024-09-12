Return-Path: <linux-kselftest+bounces-17833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E68976A27
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B82E2850D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1616B1AD241;
	Thu, 12 Sep 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNepi0HW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106691AB6E9
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146784; cv=none; b=RfZvXyNuuEJmkDjQv2ncsGc++6Nuwrka2mBzCYJaksO9Kr60UlwO2ZEZEpkVJ2g0U+nkY0LiI2X6Hsyv6rie7bGjKcLtejIyNubxHV7xBnddst+KyQ5EFJkVF5Vb7C+XTLfIVBGHBgY4EV5JhUTDDgR3AXCBGrELSyk/DskevlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146784; c=relaxed/simple;
	bh=JalE0jXrYSf4TMMDcQ0hU3nkUJku8eqsRIbd5G38UuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmqvQLux45G1c07K65H5llPAM1qEvm/SqugstLiaYp3YAURfuMLlQoxoe6cmp4+gvjQPo1u10YXaRhqANvrwbukWDYiZ2CneOcEiA3Y9LLrGPrQ9q31+oSdZYL7gV1gzlkvNg4RwURhWmlUUfdW0nWCz2i+n/Q/OWHAbqtQGAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNepi0HW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146782; x=1757682782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JalE0jXrYSf4TMMDcQ0hU3nkUJku8eqsRIbd5G38UuU=;
  b=UNepi0HW7r50BV1yhmV+hAu1O06RvdKMfgqmE3b0RGXeAh7BMAeoR88c
   LcbqaNJNWaL9I1ArU5DCMJpIYvzreeZpCGCSYCZRY54/XWOeIMkKimnJT
   Cj+SEUrcyzcuOwEuTFvzMQlAQGVKv5Cy+aVASQqpPA1/jd9MdWc0vJIcm
   B6XV2f3HsM0TeuYtYvNkrjNhlG/QiuiQeq42uUv1Bl15w2cO+fHd7zAc3
   aPwboD67B5CDcu9CtB6ivbE6y2RVoQk0dn6emJK3AILEZ/s9jVYbJsPeb
   CEdsN0gSJo19MieSiZfZtUg/iXRZ3mHUyFYWS0HU+Lag1p1zKAEKwAJkz
   w==;
X-CSE-ConnectionGUID: SvJ/WYh7SiKJkz0N0VIZDA==
X-CSE-MsgGUID: 1DJ0M8VBQqCO1I2tbGQR+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27911229"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="27911229"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:12:59 -0700
X-CSE-ConnectionGUID: 50W4rc02QQ+ajRIeBWo2Gg==
X-CSE-MsgGUID: T2ARwcP3Qbu4/MDsaJcR4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67996563"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2024 06:12:59 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v4 05/10] iommufd: Pass pasid through the device attach/replace path
Date: Thu, 12 Sep 2024 06:12:50 -0700
Message-Id: <20240912131255.13305-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912131255.13305-1-yi.l.liu@intel.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the core logic before conducting the actual device attach/
replace operation can be shared with pasid attach/replace. So pass
pasid through the device attach/replace helpers to prepare adding
pasid attach/replace.

So far the @pasid should only be IOMMU_NO_PASID. No functional change.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 44 ++++++++++++-----------
 drivers/iommu/iommufd/fault.c           | 14 +++++---
 drivers/iommu/iommufd/hw_pagetable.c    |  5 +--
 drivers/iommu/iommufd/iommufd_private.h | 47 ++++++++++++++++---------
 4 files changed, 66 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3214a4c17c6b..953eb2349d59 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -352,7 +352,8 @@ static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
 }
 
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
-				struct iommufd_device *idev)
+				struct iommufd_device *idev,
+				ioasid_t pasid)
 {
 	int rc;
 
@@ -377,7 +378,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_hwpt_attach_device(hwpt, idev);
+		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
 		if (rc)
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
@@ -396,14 +397,14 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 }
 
 struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_detach(struct iommufd_device *idev)
+iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
 
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
-		iommufd_hwpt_detach_device(hwpt, idev);
+		iommufd_hwpt_detach_device(hwpt, idev, pasid);
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_is_paging(hwpt))
@@ -416,12 +417,12 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 }
 
 static struct iommufd_hw_pagetable *
-iommufd_device_do_attach(struct iommufd_device *idev,
+iommufd_device_do_attach(struct iommufd_device *idev, ioasid_t pasid,
 			 struct iommufd_hw_pagetable *hwpt)
 {
 	int rc;
 
-	rc = iommufd_hw_pagetable_attach(hwpt, idev);
+	rc = iommufd_hw_pagetable_attach(hwpt, idev, pasid);
 	if (rc)
 		return ERR_PTR(rc);
 	return NULL;
@@ -470,7 +471,7 @@ iommufd_group_do_replace_paging(struct iommufd_group *igroup,
 }
 
 static struct iommufd_hw_pagetable *
-iommufd_device_do_replace(struct iommufd_device *idev,
+iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_group *igroup = idev->igroup;
@@ -498,7 +499,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 			goto err_unlock;
 	}
 
-	rc = iommufd_hwpt_replace_device(idev, hwpt, old_hwpt);
+	rc = iommufd_hwpt_replace_device(idev, pasid, hwpt, old_hwpt);
 	if (rc)
 		goto err_unresv;
 
@@ -533,7 +534,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 }
 
 typedef struct iommufd_hw_pagetable *(*attach_fn)(
-	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
+			struct iommufd_device *idev, ioasid_t pasid,
+			struct iommufd_hw_pagetable *hwpt);
 
 /*
  * When automatically managing the domains we search for a compatible domain in
@@ -541,7 +543,7 @@ typedef struct iommufd_hw_pagetable *(*attach_fn)(
  * Automatic domain selection will never pick a manually created domain.
  */
 static struct iommufd_hw_pagetable *
-iommufd_device_auto_get_domain(struct iommufd_device *idev,
+iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
 			       struct iommufd_ioas *ioas, u32 *pt_id,
 			       attach_fn do_attach)
 {
@@ -570,7 +572,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		hwpt = &hwpt_paging->common;
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt)) {
 			iommufd_put_object(idev->ictx, &hwpt->obj);
 			/*
@@ -597,7 +599,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt = &hwpt_paging->common;
 
 	if (!immediate_attach) {
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_abort;
 	} else {
@@ -618,8 +620,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	return destroy_hwpt;
 }
 
-static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
-				    attach_fn do_attach)
+static int iommufd_device_change_pt(struct iommufd_device *idev,
+				    ioasid_t pasid,
+				    u32 *pt_id, attach_fn do_attach)
 {
 	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_object *pt_obj;
@@ -634,7 +637,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -643,8 +646,8 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
-							      do_attach);
+		destroy_hwpt = iommufd_device_auto_get_domain(idev, pasid, ioas,
+							      pt_id, do_attach);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -681,7 +684,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 {
 	int rc;
 
-	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	rc = iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
+				      &iommufd_device_do_attach);
 	if (rc)
 		return rc;
 
@@ -711,7 +715,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
  */
 int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 {
-	return iommufd_device_change_pt(idev, pt_id,
+	return iommufd_device_change_pt(idev, IOMMU_NO_PASID, pt_id,
 					&iommufd_device_do_replace);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);
@@ -727,7 +731,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
-	hwpt = iommufd_hw_pagetable_detach(idev);
+	hwpt = iommufd_hw_pagetable_detach(idev, IOMMU_NO_PASID);
 	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 9fa56b3c2b7d..d69849f3ed13 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -56,7 +56,8 @@ static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
 }
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				    struct iommufd_device *idev)
+				    struct iommufd_device *idev,
+				    ioasid_t pasid)
 {
 	int ret;
 
@@ -67,7 +68,7 @@ int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 	if (ret)
 		return ret;
 
-	ret = iommufd_dev_attach_handle(hwpt, idev);
+	ret = iommufd_dev_attach_handle(hwpt, idev, pasid);
 	if (ret)
 		iommufd_fault_iopf_disable(idev);
 
@@ -104,11 +105,13 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 }
 
 void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev)
+				     struct iommufd_device *idev,
+				     ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 
-	handle = iommufd_device_get_attach_handle(idev);
+	handle = iommufd_device_get_attach_handle(idev, pasid);
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
 	iommufd_auto_response_faults(hwpt, handle);
 	iommufd_fault_iopf_disable(idev);
@@ -116,6 +119,7 @@ void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 }
 
 int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
+				     ioasid_t pasid,
 				     struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_hw_pagetable *old)
 {
@@ -130,7 +134,7 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 			return ret;
 	}
 
-	curr = iommufd_dev_replace_handle(idev, hwpt, old);
+	curr = iommufd_dev_replace_handle(idev, pasid, hwpt, old);
 	if (IS_ERR(curr)) {
 		if (iopf_on)
 			iommufd_fault_iopf_disable(idev);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index aefde4443671..9a346c59b5e5 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -180,7 +180,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	 * sequence. Once those drivers are fixed this should be removed.
 	 */
 	if (immediate_attach) {
-		rc = iommufd_hw_pagetable_attach(hwpt, idev);
+		/* Sinc this is just a trick, so passing IOMMU_NO_PASID is enough */
+		rc = iommufd_hw_pagetable_attach(hwpt, idev, IOMMU_NO_PASID);
 		if (rc)
 			goto out_abort;
 	}
@@ -193,7 +194,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 out_detach:
 	if (immediate_attach)
-		iommufd_hw_pagetable_detach(idev);
+		iommufd_hw_pagetable_detach(idev, IOMMU_NO_PASID);
 out_abort:
 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 30696936a926..38aa9232f0f5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -349,9 +349,10 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  bool immediate_attach,
 			  const struct iommu_user_data *user_data);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
-				struct iommufd_device *idev);
+				struct iommufd_device *idev,
+				ioasid_t pasid);
 struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_detach(struct iommufd_device *idev);
+iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid);
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj);
 void iommufd_hwpt_paging_abort(struct iommufd_object *obj);
 void iommufd_hwpt_nested_destroy(struct iommufd_object *obj);
@@ -459,11 +460,12 @@ struct iommufd_attach_handle {
 #define to_iommufd_handle(hdl)	container_of(hdl, struct iommufd_attach_handle, handle)
 
 static inline struct iommufd_attach_handle *
-iommufd_device_get_attach_handle(struct iommufd_device *idev)
+iommufd_device_get_attach_handle(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommu_attach_handle *handle;
 
-	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+	WARN_ON(pasid != IOMMU_NO_PASID);
+	handle = iommu_attach_handle_get(idev->igroup->group, pasid, 0);
 	if (IS_ERR(handle))
 		return NULL;
 
@@ -471,7 +473,8 @@ iommufd_device_get_attach_handle(struct iommufd_device *idev)
 }
 
 static inline int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
-					    struct iommufd_device *idev)
+					    struct iommufd_device *idev,
+					    ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 	int ret;
@@ -481,6 +484,7 @@ static inline int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
 		return -ENOMEM;
 
 	handle->idev = idev;
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
 					&handle->handle);
 	if (ret)
@@ -491,14 +495,14 @@ static inline int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
 
 /* Caller to free the old iommufd_attach_handle */
 static inline struct iommufd_attach_handle *
-iommufd_dev_replace_handle(struct iommufd_device *idev,
+iommufd_dev_replace_handle(struct iommufd_device *idev, ioasid_t pasid,
 			   struct iommufd_hw_pagetable *hwpt,
 			   struct iommufd_hw_pagetable *old)
 {
 	struct iommufd_attach_handle *handle, *curr;
 	int ret;
 
-	curr = iommufd_device_get_attach_handle(idev);
+	curr = iommufd_device_get_attach_handle(idev, pasid);
 	if (!curr)
 		return ERR_PTR(-EINVAL);
 
@@ -507,6 +511,7 @@ iommufd_dev_replace_handle(struct iommufd_device *idev,
 		return ERR_PTR(-ENOMEM);
 
 	handle->idev = idev;
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	ret = iommu_replace_group_handle(idev->igroup->group,
 					 hwpt->domain, &handle->handle);
 	if (ret) {
@@ -530,47 +535,55 @@ void iommufd_fault_destroy(struct iommufd_object *obj);
 int iommufd_fault_iopf_handler(struct iopf_group *group);
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				    struct iommufd_device *idev);
+				    struct iommufd_device *idev,
+				    ioasid_t pasid);
 void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev);
+				     struct iommufd_device *idev,
+				     ioasid_t pasid);
 int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
+				     ioasid_t pasid,
 				     struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_hw_pagetable *old);
 
 static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
-					     struct iommufd_device *idev)
+					     struct iommufd_device *idev,
+					     ioasid_t pasid)
 {
 	if (hwpt->fault)
-		return iommufd_fault_domain_attach_dev(hwpt, idev);
+		return iommufd_fault_domain_attach_dev(hwpt, idev, pasid);
 
-	return iommufd_dev_attach_handle(hwpt, idev);
+	return iommufd_dev_attach_handle(hwpt, idev, pasid);
 }
 
 static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
-					      struct iommufd_device *idev)
+					      struct iommufd_device *idev,
+					      ioasid_t pasid)
 {
 	struct iommufd_attach_handle *handle;
 
 	if (hwpt->fault) {
-		iommufd_fault_domain_detach_dev(hwpt, idev);
+		iommufd_fault_domain_detach_dev(hwpt, idev, pasid);
 		return;
 	}
 
-	handle = iommufd_device_get_attach_handle(idev);
+	handle = iommufd_device_get_attach_handle(idev, pasid);
+	WARN_ON(pasid != IOMMU_NO_PASID);
 	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
 	kfree(handle);
 }
 
 static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
+					      ioasid_t pasid,
 					      struct iommufd_hw_pagetable *hwpt,
 					      struct iommufd_hw_pagetable *old)
 {
 	struct iommufd_attach_handle *curr;
 
 	if (old->fault || hwpt->fault)
-		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
+		return iommufd_fault_domain_replace_dev(idev, pasid,
+							hwpt, old);
 
-	curr = iommufd_dev_replace_handle(idev, hwpt, old);
+	curr = iommufd_dev_replace_handle(idev, pasid, hwpt, old);
 	if (IS_ERR(curr))
 		return PTR_ERR(curr);
 
-- 
2.34.1


