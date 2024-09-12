Return-Path: <linux-kselftest+bounces-17828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B69C976A1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516031F2482F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D91AB6DB;
	Thu, 12 Sep 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwTmJ3qO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8B1A42B3
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146781; cv=none; b=u5ZKiio3KCtA2X0j8JGVlWSBWM65XrLKXYuI5l57uLxBwW9dWH5xch8Pk0WZULHJr4oWgjvFgYZu2x0sMu8dH3MLf91NvpSc04RgWjlVRfY1dZnEV2QdsL4NSdbWh7eOll6VBh8M9OoOjghLRCVOfEPUcA7E1f7gAhGySMFHY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146781; c=relaxed/simple;
	bh=xmoYn9YaVtPgcBKLH8ZDXNRrtRvd8cIPoS8sN0JtL9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNvoRnjIFtsQuLTFjG7zZ5jHtjmHDbz54BZlcYoSlF7iXu39seyfjID7jJKWNZIAZzuGVqX9zWPIdjOsAVC/HRMv+F/fzvdeuRelLPf9bZx//qGwXCETuwZTGQG/HBl1QguyAxEgJ9HG11B4E3apJSUFfodTwPwBHsGw/GpskNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwTmJ3qO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146780; x=1757682780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmoYn9YaVtPgcBKLH8ZDXNRrtRvd8cIPoS8sN0JtL9o=;
  b=PwTmJ3qOm2mibQHNbjK9BBJPvIGrUGXLnpT6If8mC6nQ25r0B1UUDbLd
   LNwVkmS9T5e+fyHlGQsfQkKztmmsaBwWIN1m/1QojojGkLXHPXYwDCaAX
   yv7KuV4aoN2w4iRh4qk5EFLqGGcvjmyqk4WO0469IJVUbTaL26AXHWLz8
   /H7dAW5dnEnke1RNrp00otALDMmwi301wuc6/EeY/AZ6/tXdQYgJ3q9Yu
   nokwfISd6l//BxlaDttsDekFACMZ/62ql5RDbMI71G1fZhxpvtkFgng9E
   cRE/Tbn/oT6odv7mC6Vx08lThSD3xnI6a2M/Ay+vZz+nuHRKp+bc3DEze
   g==;
X-CSE-ConnectionGUID: s5ImabsvQN625im4HNrpbg==
X-CSE-MsgGUID: zZPEuvAlRy2I91Gh9PRuLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27911208"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="27911208"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:12:58 -0700
X-CSE-ConnectionGUID: qSvCfFUBSG+UV17RdUaF+A==
X-CSE-MsgGUID: 5oVhZjWARh6MChHbrGWmUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67996545"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2024 06:12:58 -0700
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
Subject: [PATCH v4 02/10] iommufd: Refactor __fault_domain_replace_dev() to be a wrapper of iommu_replace_group_handle()
Date: Thu, 12 Sep 2024 06:12:47 -0700
Message-Id: <20240912131255.13305-3-yi.l.liu@intel.com>
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

There is a wrapper of iommu_attach_group_handle(), so making a wrapper for
iommu_replace_group_handle() for further code refactor. No functional change
intended.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/fault.c | 54 ++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index c4715261f2c7..cd56745f3003 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -146,35 +146,30 @@ void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 	kfree(handle);
 }
 
-static int __fault_domain_replace_dev(struct iommufd_device *idev,
-				      struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_hw_pagetable *old)
+/* Caller to free the old iommufd_attach_handle */
+static struct iommufd_attach_handle *
+__fault_domain_replace_dev(struct iommufd_device *idev,
+			   struct iommufd_hw_pagetable *hwpt,
+			   struct iommufd_hw_pagetable *old)
 {
-	struct iommufd_attach_handle *handle, *curr = NULL;
+	struct iommufd_attach_handle *handle, *curr;
 	int ret;
 
-	if (old->fault)
-		curr = iommufd_device_get_attach_handle(idev);
-
-	if (hwpt->fault) {
-		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-		if (!handle)
-			return -ENOMEM;
+	curr = iommufd_device_get_attach_handle(idev);
 
-		handle->idev = idev;
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, &handle->handle);
-	} else {
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, NULL);
-	}
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
 
-	if (!ret && curr) {
-		iommufd_auto_response_faults(old, curr);
-		kfree(curr);
+	handle->idev = idev;
+	ret = iommu_replace_group_handle(idev->igroup->group,
+					 hwpt->domain, &handle->handle);
+	if (ret) {
+		kfree(handle);
+		return ERR_PTR(ret);
 	}
 
-	return ret;
+	return curr;
 }
 
 int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
@@ -183,6 +178,7 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 {
 	bool iopf_off = !hwpt->fault && old->fault;
 	bool iopf_on = hwpt->fault && !old->fault;
+	struct iommufd_attach_handle *curr = NULL;
 	int ret;
 
 	if (iopf_on) {
@@ -191,13 +187,25 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 			return ret;
 	}
 
-	ret = __fault_domain_replace_dev(idev, hwpt, old);
+	if (hwpt->fault) {
+		curr = __fault_domain_replace_dev(idev, hwpt, old);
+		ret = IS_ERR(curr) ? PTR_ERR(curr) : 0;
+	} else {
+		ret = iommu_replace_group_handle(idev->igroup->group,
+						 hwpt->domain, NULL);
+	}
+
 	if (ret) {
 		if (iopf_on)
 			iommufd_fault_iopf_disable(idev);
 		return ret;
 	}
 
+	if (curr) {
+		iommufd_auto_response_faults(old, curr);
+		kfree(curr);
+	}
+
 	if (iopf_off)
 		iommufd_fault_iopf_disable(idev);
 
-- 
2.34.1


