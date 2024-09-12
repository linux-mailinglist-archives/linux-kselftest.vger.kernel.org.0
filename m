Return-Path: <linux-kselftest+bounces-17831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABBB976A23
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210F51F240BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C21AC435;
	Thu, 12 Sep 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrwSW5HM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49521AB6DD
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146783; cv=none; b=aThasEO0l0BfdfQ94AArDOxUKD/a99Y7OeBRRkHw6RdAPHpDVjZ2UUHvw/XdQ/wd3wYO7FmGrGbJFiUDfcDytJJrf09h+As1JtEBxAdwQpF5y+DOAzAFAEvynl3BlgaxfWJOMYlqoJlBqz95r+o14tjj42qdrzWQIX3XdcIy9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146783; c=relaxed/simple;
	bh=eJnbdXSVn+GEBiW5+Hj1FPgapl74+6kqW5Y3FX6tTVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgLFD/HJR41CtHUNC4S+isO3N7T2AGskyduXvqAX7RGeyW3ELzppWVQPcXhQs/fEVgqyP1XBes6+/1HYqSD+Fnjhjq3qSuDpEtB8ZIKifCRMMVGWE2vKiUu1gb4dxrLidUI3u376DF9p9guJYVlow8pqJmKN6W67vjllVR4JmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrwSW5HM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146782; x=1757682782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eJnbdXSVn+GEBiW5+Hj1FPgapl74+6kqW5Y3FX6tTVU=;
  b=NrwSW5HMu9v7pidPD9knTSYIbuwkiyCD4lelOpoLAySd5DlcLbtKRtSa
   2xVV59SLLkkGUFSGylsftZuq+SL3PCOZodV7MGYl9iBlmzs53qgjIZ8xu
   qurxP7G3OzXeTbn9rzrzK0ObRrhr7too73dkfAKWs6E9gZF84yPDol7QI
   mr1546HBduGFqcwmlcAeXFQoeYsYRbqPVmLVjRlheinPhV7FgWNohd8Um
   W29vQdQ+0vQKrfzfqygf1YthCxQK8ZUFo6FmfKMmbqDF4XoZtTFdzUUlZ
   eqGLqKhkmQ4qUFikVbKyZUGcjH5Wzq4oiBwJ0tICtqmbm4qiHTtPuljjU
   Q==;
X-CSE-ConnectionGUID: BL2wGxOiRVmucAXsMf+tcw==
X-CSE-MsgGUID: eApgQEquSpSWeorzTcjkdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27911222"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="27911222"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:12:59 -0700
X-CSE-ConnectionGUID: Jb0cNorTQgyRdvnwVXzi+g==
X-CSE-MsgGUID: Asi1SK7lS2mN0cooJ7f7jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67996560"
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
Subject: [PATCH v4 04/10] iommufd: Always pass iommu_attach_handle to iommu core
Date: Thu, 12 Sep 2024 06:12:49 -0700
Message-Id: <20240912131255.13305-5-yi.l.liu@intel.com>
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

The iommu_attach_handle is optional in the RID attach/replace API and the
PASID attach APIs. But it is a mandatory argument for the PASID replace API.
Without it, the PASID replace path cannot get the old domain. Hence, the
PASID path (attach/replace) requires the attach handle. As iommufd is the
major user of the RID attach/replace with iommu_attach_handle, this also
makes the iommufd always pass the attach handle for the RID path as well.
This keeps the RID and PASID path much aligned.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/fault.c           | 21 +++++++--------------
 drivers/iommu/iommufd/iommufd_private.h | 19 ++++++++++++++++---
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 50ce6c6e61be..9fa56b3c2b7d 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -121,7 +121,7 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 {
 	bool iopf_off = !hwpt->fault && old->fault;
 	bool iopf_on = hwpt->fault && !old->fault;
-	struct iommufd_attach_handle *curr = NULL;
+	struct iommufd_attach_handle *curr;
 	int ret;
 
 	if (iopf_on) {
@@ -130,24 +130,17 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 			return ret;
 	}
 
-	if (hwpt->fault) {
-		curr = iommufd_dev_replace_handle(idev, hwpt, old);
-		ret = IS_ERR(curr) ? PTR_ERR(curr) : 0;
-	} else {
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, NULL);
-	}
-
-	if (ret) {
+	curr = iommufd_dev_replace_handle(idev, hwpt, old);
+	if (IS_ERR(curr)) {
 		if (iopf_on)
 			iommufd_fault_iopf_disable(idev);
-		return ret;
+		return PTR_ERR(curr);
 	}
 
-	if (curr) {
+	if (old->fault)
 		iommufd_auto_response_faults(old, curr);
-		kfree(curr);
-	}
+
+	kfree(curr);
 
 	if (iopf_off)
 		iommufd_fault_iopf_disable(idev);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 7039c86d9981..30696936a926 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -499,6 +499,8 @@ iommufd_dev_replace_handle(struct iommufd_device *idev,
 	int ret;
 
 	curr = iommufd_device_get_attach_handle(idev);
+	if (!curr)
+		return ERR_PTR(-EINVAL);
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
@@ -541,28 +543,39 @@ static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	if (hwpt->fault)
 		return iommufd_fault_domain_attach_dev(hwpt, idev);
 
-	return iommu_attach_group(hwpt->domain, idev->igroup->group);
+	return iommufd_dev_attach_handle(hwpt, idev);
 }
 
 static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 					      struct iommufd_device *idev)
 {
+	struct iommufd_attach_handle *handle;
+
 	if (hwpt->fault) {
 		iommufd_fault_domain_detach_dev(hwpt, idev);
 		return;
 	}
 
-	iommu_detach_group(hwpt->domain, idev->igroup->group);
+	handle = iommufd_device_get_attach_handle(idev);
+	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	kfree(handle);
 }
 
 static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 					      struct iommufd_hw_pagetable *hwpt,
 					      struct iommufd_hw_pagetable *old)
 {
+	struct iommufd_attach_handle *curr;
+
 	if (old->fault || hwpt->fault)
 		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
 
-	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
+	curr = iommufd_dev_replace_handle(idev, hwpt, old);
+	if (IS_ERR(curr))
+		return PTR_ERR(curr);
+
+	kfree(curr);
+	return 0;
 }
 
 #ifdef CONFIG_IOMMUFD_TEST
-- 
2.34.1


