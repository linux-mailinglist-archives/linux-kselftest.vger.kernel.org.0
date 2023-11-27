Return-Path: <linux-kselftest+bounces-626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B777F99E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 07:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C2C1C20973
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71033D297;
	Mon, 27 Nov 2023 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObDitU70"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA83B93;
	Sun, 26 Nov 2023 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701066873; x=1732602873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gfJ5Tr0rMCO47IrzKCPsGdamJiWS8H3RpIXUStFV1G8=;
  b=ObDitU70vmjvyDnBIiEPBb9TFqEsDXHXh/zXrnVhDs3pf9qP5dOVAV7P
   DVqnpxkgComSftdmACtwAwJ1eTZR56dYkldrNNFu09AWt5lTOqZsLcB86
   lF7eR6yOq6PY0JRcu1pPL178sUuYah7ILiY4XM3oN0GrUm7MEPaHSXjp3
   9YndoTIPvB/YBFRqnwywQeinFAIendA3M4MRobCzfLZEO3GKYHFlDer0F
   cYlEGLmpvnsFL3l19u5i8ZvRhRvrhVM6ax5fiqC3AukxvHYy8h8Z/VaWZ
   7m7/foDqYJ24up7xG+TH2vritjJmYsTxzu78dbBrrcZAHmJVD9Aa5jzgn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391518145"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="391518145"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:34:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="838608931"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="838608931"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2023 22:34:32 -0800
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
Subject: [PATCH 2/8] iommufd: replace attach_fn with a structure
Date: Sun, 26 Nov 2023 22:34:22 -0800
Message-Id: <20231127063428.127436-3-yi.l.liu@intel.com>
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

Most of the core logic before conducting the actual device attach/
replace operation can be shared with pasid attach/replace. Create
a new structure so more information (e.g. pasid) can be later added
along with the attach_fn.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 35 ++++++++++++++++---------
 drivers/iommu/iommufd/iommufd_private.h |  8 ++++++
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 59d3a07300d9..0992d9d46af9 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -531,8 +531,11 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	return ERR_PTR(rc);
 }
 
-typedef struct iommufd_hw_pagetable *(*attach_fn)(
-	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
+static struct iommufd_hw_pagetable *do_attach(struct iommufd_device *idev,
+		struct iommufd_hw_pagetable *hwpt, struct attach_data *data)
+{
+	return data->attach_fn(idev, hwpt);
+}
 
 /*
  * When automatically managing the domains we search for a compatible domain in
@@ -542,7 +545,7 @@ typedef struct iommufd_hw_pagetable *(*attach_fn)(
 static struct iommufd_hw_pagetable *
 iommufd_device_auto_get_domain(struct iommufd_device *idev,
 			       struct iommufd_ioas *ioas, u32 *pt_id,
-			       attach_fn do_attach)
+			       struct attach_data *data)
 {
 	/*
 	 * iommufd_hw_pagetable_attach() is called by
@@ -551,7 +554,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	 * to use the immediate_attach path as it supports drivers that can't
 	 * directly allocate a domain.
 	 */
-	bool immediate_attach = do_attach == iommufd_device_do_attach;
+	bool immediate_attach = data->attach_fn == iommufd_device_do_attach;
 	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
@@ -569,7 +572,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		hwpt = &hwpt_paging->common;
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = do_attach(idev, hwpt, data);
 		if (IS_ERR(destroy_hwpt)) {
 			iommufd_put_object(&hwpt->obj);
 			/*
@@ -596,7 +599,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt = &hwpt_paging->common;
 
 	if (!immediate_attach) {
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = do_attach(idev, hwpt, data);
 		if (IS_ERR(destroy_hwpt))
 			goto out_abort;
 	} else {
@@ -617,8 +620,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	return destroy_hwpt;
 }
 
-static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
-				    attach_fn do_attach)
+int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
+			     struct attach_data *data)
 {
 	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_object *pt_obj;
@@ -633,7 +636,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = do_attach(idev, hwpt, data);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -643,7 +646,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
 		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
-							      do_attach);
+							      data);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -679,8 +682,11 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 {
 	int rc;
+	struct attach_data data = {
+		.attach_fn = &iommufd_device_do_attach,
+	};
 
-	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	rc = iommufd_device_change_pt(idev, pt_id, &data);
 	if (rc)
 		return rc;
 
@@ -710,8 +716,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
  */
 int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 {
-	return iommufd_device_change_pt(idev, pt_id,
-					&iommufd_device_do_replace);
+	struct attach_data data = {
+		.attach_fn = &iommufd_device_do_replace,
+	};
+
+	return iommufd_device_change_pt(idev, pt_id, &data);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 160521800d9b..24fee2c37ce8 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -363,6 +363,14 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
+struct attach_data {
+	union {
+		struct iommufd_hw_pagetable *(*attach_fn)(
+				struct iommufd_device *idev,
+				struct iommufd_hw_pagetable *hwpt);
+	};
+};
+
 struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
-- 
2.34.1


