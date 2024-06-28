Return-Path: <linux-kselftest+bounces-12918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF99E91BAE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 11:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674311F22D78
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5615382C;
	Fri, 28 Jun 2024 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRRubi//"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801AA1509A1;
	Fri, 28 Jun 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565564; cv=none; b=cMSomKYCl5jbl2H7djyZQrT1Svc5oMNtfG1aUeQ6CccCDUAczVJYc0bOTzB5JK7BlZxqsarmbTBMk6qsljX/WFBu3XpJDNmDkfNDVtjITCyvgsEiBFktcU+t66hevDI6pqbfLnd85nJTYZDvCznx5Ae53idaPv1nodzdM9If3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565564; c=relaxed/simple;
	bh=Psit6RkX2rUHxpWkJbFE0cNh6ZqzPY3O2CNF0zlcsZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUM9o4NWnDQHgcZyR7VYPbGFVense74HYuyj4MLRD+zgRm70SOmWu2ymnaAbf5466464FdVTVM2FC8WvxHSLeqbxZAvLjb5pxBeKjfJjSrilZQ0wxR2a9P4e7AaDvEJAdFEvn2jbY/N2I55q3chIg8Rdxb5Sx4HFkVG4GeFOjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRRubi//; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719565562; x=1751101562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Psit6RkX2rUHxpWkJbFE0cNh6ZqzPY3O2CNF0zlcsZ4=;
  b=jRRubi//tbD3CuSePm4AnuEzOhzH2pS9orPQZWwymuf/d3wjbon07RpA
   SYTR22PrYlHUdJ08GXIkp7j9upNwBnj9N5Yrk4gQRe/anF2/adPdAhiwD
   UImobynH+MOEDjcD6xb0Sli6n9gi+ZKtNKy4gjg3ns5D9B1aeFg2pVuvy
   TlbEQV9DcwEPVchi5H52V//4dYW5IBS+kIBXCh2uR4P/FZpbwRVFA9GSV
   MUd4UpO7zvHVGWHaimqfTEM/sFdwdWQtSMkWhpLUVnErqBhrQT8kr/Q7p
   PLtT48z7e76oNV3bo/qT5+XaUAEH95BkAYFSoF6VE/Zn6kaAafsSmfV1J
   A==;
X-CSE-ConnectionGUID: Dh6CwfL4RE+XJ/GRWssHXQ==
X-CSE-MsgGUID: uZNo9GQWRDOZIWOPN3TOxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20613676"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="20613676"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:06:01 -0700
X-CSE-ConnectionGUID: Ia2ysZK0SguRX2YC0vX9YQ==
X-CSE-MsgGUID: l4LMpx/8RMCDJna5I54djA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44517048"
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
Subject: [PATCH v3 2/7] iommufd: Pass pasid through the device attach/replace path
Date: Fri, 28 Jun 2024 02:05:52 -0700
Message-Id: <20240628090557.50898-3-yi.l.liu@intel.com>
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

Most of the core logic before conducting the actual device attach/
replace operation can be shared with pasid attach/replace. So pass
pasid through the device attach/replace helpers to prepare adding
pasid attach/replace.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 873630c111c1..8f13aa94d3af 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -415,7 +415,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 }
 
 static struct iommufd_hw_pagetable *
-iommufd_device_do_attach(struct iommufd_device *idev,
+iommufd_device_do_attach(struct iommufd_device *idev, u32 pasid,
 			 struct iommufd_hw_pagetable *hwpt)
 {
 	int rc;
@@ -469,7 +469,7 @@ iommufd_group_do_replace_paging(struct iommufd_group *igroup,
 }
 
 static struct iommufd_hw_pagetable *
-iommufd_device_do_replace(struct iommufd_device *idev,
+iommufd_device_do_replace(struct iommufd_device *idev, u32 pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_group *igroup = idev->igroup;
@@ -532,7 +532,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 }
 
 typedef struct iommufd_hw_pagetable *(*attach_fn)(
-	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
+			struct iommufd_device *idev, u32 pasid,
+			struct iommufd_hw_pagetable *hwpt);
 
 /*
  * When automatically managing the domains we search for a compatible domain in
@@ -540,7 +541,7 @@ typedef struct iommufd_hw_pagetable *(*attach_fn)(
  * Automatic domain selection will never pick a manually created domain.
  */
 static struct iommufd_hw_pagetable *
-iommufd_device_auto_get_domain(struct iommufd_device *idev,
+iommufd_device_auto_get_domain(struct iommufd_device *idev, u32 pasid,
 			       struct iommufd_ioas *ioas, u32 *pt_id,
 			       attach_fn do_attach)
 {
@@ -569,7 +570,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		hwpt = &hwpt_paging->common;
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt)) {
 			iommufd_put_object(idev->ictx, &hwpt->obj);
 			/*
@@ -596,7 +597,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt = &hwpt_paging->common;
 
 	if (!immediate_attach) {
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_abort;
 	} else {
@@ -617,8 +618,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	return destroy_hwpt;
 }
 
-static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
-				    attach_fn do_attach)
+static int iommufd_device_change_pt(struct iommufd_device *idev, u32 pasid,
+				    u32 *pt_id, attach_fn do_attach)
 {
 	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_object *pt_obj;
@@ -633,7 +634,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = (*do_attach)(idev, pasid, hwpt);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -642,8 +643,8 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
-		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
-							      do_attach);
+		destroy_hwpt = iommufd_device_auto_get_domain(idev, pasid, ioas,
+							      pt_id, do_attach);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -680,7 +681,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 {
 	int rc;
 
-	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	rc = iommufd_device_change_pt(idev, IOMMU_PASID_INVALID, pt_id,
+				      &iommufd_device_do_attach);
 	if (rc)
 		return rc;
 
@@ -710,7 +712,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
  */
 int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 {
-	return iommufd_device_change_pt(idev, pt_id,
+	return iommufd_device_change_pt(idev, IOMMU_PASID_INVALID, pt_id,
 					&iommufd_device_do_replace);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);
-- 
2.34.1


