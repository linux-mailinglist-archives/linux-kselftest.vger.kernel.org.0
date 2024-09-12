Return-Path: <linux-kselftest+bounces-17829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F8976A21
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B6EB21190
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7FD1AB6CA;
	Thu, 12 Sep 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0L/N11Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD91AAE23
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146781; cv=none; b=pMyoqaPYILNRHtHfxU+pMFXe2EjfxeZbBhhUB0bNpnmF40IHKSDH/9puGxStKIyRFZ7PoeKgdwHQ5EJDYxjhS4daXNdmYRztWQxAaWQrlpUnD66s5JdJ/Us3vzqKtVzgKbEw4UIpNTtawWc7qKz2J8b5MVbcxTRKDFS55k4SopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146781; c=relaxed/simple;
	bh=+RrM8RnHiQcNHpfSMob6Sud/wYOiWahLrKt6W9NEt54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mF3J/TTEWQz0VlmsxCn7nfI1hq8GFQ5mErwmUOMC0LvkDpMZ13ugUHX9UKC8V21Ivq5q2a+u7kYwcP32CXam+LdLiSycUHk53ql1tTv0F38RwFvlYuqcjxwkFBqPLIwHM/wxGDA2j4lfo1Y+nMus+dUy6aHeNKCpIMQQUCWxEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0L/N11Y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146780; x=1757682780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+RrM8RnHiQcNHpfSMob6Sud/wYOiWahLrKt6W9NEt54=;
  b=d0L/N11Ynnh6CXwKXZu1k4n9wwwpuFhoTM5AwuFz79qsntBe3PvJNrDH
   g4SGYkQaVJklvLWW4TuEct+ZQLNS2N4XPLkbFrnnE7NF9c+fxNvfYhpZb
   q8NyWvCQXvNBXYwoZKUt6/6EHWmtvS6RI3cUrAgLVvgDvSYRVjxxyLD7i
   zEx7xeE9b7mNbXLI13oqIsLNjsEYyMKT4flUsko5dr84FB9duaJeiowlK
   QoijOOkYkkhwCMHE1k5Thv8OwPpZnMiXQn6/7CqwLq5XoZvNoC2eGRuZw
   XUnFGwq6NBg+eL45V18jRKrARUpl4nuKGJDWeHpXUnjfaa8Mwr4Gh91Au
   Q==;
X-CSE-ConnectionGUID: U1ZNQZSFRAumwb84JyNatQ==
X-CSE-MsgGUID: mkMw5APBR4uXcF/yALqSXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27911215"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="27911215"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:12:59 -0700
X-CSE-ConnectionGUID: d3p+8L0XTR611IAwn7kRSA==
X-CSE-MsgGUID: OSIlxOrXQ3qfmDCqJl7/aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67996553"
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
Subject: [PATCH v4 03/10] iommufd: Move the iommufd_handle helpers to iommufd_private.h
Date: Thu, 12 Sep 2024 06:12:48 -0700
Message-Id: <20240912131255.13305-4-yi.l.liu@intel.com>
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

iommufd plans to always pass in an iommu_attach_handle to the iommu
core, so it's no longer fault specific, hence move the helpers out
of the fault.c

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/fault.c           | 61 +------------------------
 drivers/iommu/iommufd/iommufd_private.h | 57 +++++++++++++++++++++++
 2 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index cd56745f3003..50ce6c6e61be 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -55,25 +55,6 @@ static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
 	mutex_unlock(&idev->iopf_lock);
 }
 
-static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev)
-{
-	struct iommufd_attach_handle *handle;
-	int ret;
-
-	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle)
-		return -ENOMEM;
-
-	handle->idev = idev;
-	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
-					&handle->handle);
-	if (ret)
-		kfree(handle);
-
-	return ret;
-}
-
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 				    struct iommufd_device *idev)
 {
@@ -86,7 +67,7 @@ int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 	if (ret)
 		return ret;
 
-	ret = __fault_domain_attach_dev(hwpt, idev);
+	ret = iommufd_dev_attach_handle(hwpt, idev);
 	if (ret)
 		iommufd_fault_iopf_disable(idev);
 
@@ -122,18 +103,6 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&fault->mutex);
 }
 
-static struct iommufd_attach_handle *
-iommufd_device_get_attach_handle(struct iommufd_device *idev)
-{
-	struct iommu_attach_handle *handle;
-
-	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
-	if (IS_ERR(handle))
-		return NULL;
-
-	return to_iommufd_handle(handle);
-}
-
 void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_device *idev)
 {
@@ -146,32 +115,6 @@ void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 	kfree(handle);
 }
 
-/* Caller to free the old iommufd_attach_handle */
-static struct iommufd_attach_handle *
-__fault_domain_replace_dev(struct iommufd_device *idev,
-			   struct iommufd_hw_pagetable *hwpt,
-			   struct iommufd_hw_pagetable *old)
-{
-	struct iommufd_attach_handle *handle, *curr;
-	int ret;
-
-	curr = iommufd_device_get_attach_handle(idev);
-
-	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle)
-		return ERR_PTR(-ENOMEM);
-
-	handle->idev = idev;
-	ret = iommu_replace_group_handle(idev->igroup->group,
-					 hwpt->domain, &handle->handle);
-	if (ret) {
-		kfree(handle);
-		return ERR_PTR(ret);
-	}
-
-	return curr;
-}
-
 int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 				     struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_hw_pagetable *old)
@@ -188,7 +131,7 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 	}
 
 	if (hwpt->fault) {
-		curr = __fault_domain_replace_dev(idev, hwpt, old);
+		curr = iommufd_dev_replace_handle(idev, hwpt, old);
 		ret = IS_ERR(curr) ? PTR_ERR(curr) : 0;
 	} else {
 		ret = iommu_replace_group_handle(idev->igroup->group,
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1141c0633dc9..7039c86d9981 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -458,6 +458,63 @@ struct iommufd_attach_handle {
 /* Convert an iommu attach handle to iommufd handle. */
 #define to_iommufd_handle(hdl)	container_of(hdl, struct iommufd_attach_handle, handle)
 
+static inline struct iommufd_attach_handle *
+iommufd_device_get_attach_handle(struct iommufd_device *idev)
+{
+	struct iommu_attach_handle *handle;
+
+	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+	if (IS_ERR(handle))
+		return NULL;
+
+	return to_iommufd_handle(handle);
+}
+
+static inline int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
+					    struct iommufd_device *idev)
+{
+	struct iommufd_attach_handle *handle;
+	int ret;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->idev = idev;
+	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
+					&handle->handle);
+	if (ret)
+		kfree(handle);
+
+	return ret;
+}
+
+/* Caller to free the old iommufd_attach_handle */
+static inline struct iommufd_attach_handle *
+iommufd_dev_replace_handle(struct iommufd_device *idev,
+			   struct iommufd_hw_pagetable *hwpt,
+			   struct iommufd_hw_pagetable *old)
+{
+	struct iommufd_attach_handle *handle, *curr;
+	int ret;
+
+	curr = iommufd_device_get_attach_handle(idev);
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+
+	handle->idev = idev;
+	ret = iommu_replace_group_handle(idev->igroup->group,
+					 hwpt->domain, &handle->handle);
+	if (ret) {
+		kfree(handle);
+		return ERR_PTR(ret);
+	}
+
+	return curr;
+}
+
 static inline struct iommufd_fault *
 iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
 {
-- 
2.34.1


