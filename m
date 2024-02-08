Return-Path: <linux-kselftest+bounces-4322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD21884DB55
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE061C25B14
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1DD6BFA0;
	Thu,  8 Feb 2024 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qxj4rkkL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0156A8B2;
	Thu,  8 Feb 2024 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380596; cv=none; b=ICS6brqY+VWflH1ey5HMr7Co2JnatAZvwRhbQP3BTuIXgmyH8UIR5WO4n35XqE6Nu+g7czueWp0QWcjx5h9DEhQbXBNUaaGRymb2BrwUWwTFrKCoiRxi0Ml1dbn9eyzCHvgRNI0YUjnlVUfRL+NbjNBU4zFfBcCsPWXV+ApppM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380596; c=relaxed/simple;
	bh=PKyfNmIGpOnyrWFOlTJVA1L/Yj9yssKddjjlBkd/VSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pe8nzB/I8Kxj7xw9wALst+RVWIxn3EtrXh1A7NgKvRnsPr+KsGRfqaF81s1Gsc3W349oCWsNkrDy/cARTgkS7VLLXo76YCnLTs0wBqS3NPocxyR4Q9hDt4pXP2+NuKpNK3iRbNesctL2NKhnnSUJUYI0+s3zGawOrqDZqqrFxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qxj4rkkL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380595; x=1738916595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PKyfNmIGpOnyrWFOlTJVA1L/Yj9yssKddjjlBkd/VSU=;
  b=Qxj4rkkLBlZjeHj6hM8ny7fPKnUy/5av6ThgK0tXeKETKflcYqIaoELs
   UXtD8uDY9VJKogFE8MqfMUte/6QlVkI/nYCH8iVnwZjWjg1beBj1IwSJD
   LRbCJOtnMOQHgrEGgWJKYq2yrInOPdfiI+aWlJyvdKVt4hKEtg44jTA+7
   Uz1cM0vyIGk2phlZOp0BWcIUSJw+6FEDHlqzffxsV4Ozs5qbk7M5d3Btd
   BV1wOoaFVLktGh94Eqgp3+xJ73m+hJprJHga0orIWrBnUGnuFScJpFm1C
   oUP/JNq3zZEZ+WRZFjwBFZSxBhRs8uOm8TzmOELoQnv5M7qYqvSshwQWF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="5036337"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="5036337"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6252124"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa003.jf.intel.com with ESMTP; 08 Feb 2024 00:23:13 -0800
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
	yi.y.sun@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH rc 5/8] iommu/vt-d: Add missing device iotlb flush for parent domain
Date: Thu,  8 Feb 2024 00:23:04 -0800
Message-Id: <20240208082307.15759-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208082307.15759-1-yi.l.liu@intel.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ATS-capable devices cache the result of nested translation. This result
relies on the mappings in s2 domain (a.k.a. parent). When there are
modifications in the s2 domain, the related nested translation caches on
the device should be flushed. This includes the devices that are attached
to the s1 domain. However, the existing code ignores this fact to only
loops its own devices.

As there is no easy way to identify the exact set of nested translations
affected by the change of s2 domain. So, this just flushes the entire
device iotlb on the device.

As above, driver loops the s2 domain's s1_domains list and loops the devices
list of each s1_domain to flush the entire device iotlb on the devices.

Fixes: b41e38e22539 ("iommu/vt-d: Add nested domain allocation")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b1ceebe13107..c5a0275697cb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1462,12 +1462,30 @@ static void parent_domain_flush(struct dmar_domain *domain,
 
 	spin_lock(&domain->s1_lock);
 	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
+		struct device_domain_info *device_info;
 		struct iommu_domain_info *info;
+		unsigned long flags;
 		unsigned long i;
 
 		xa_for_each(&s1_domain->iommu_array, i, info)
 			__iommu_flush_iotlb_psi(info->iommu, info->did,
 						pfn, pages, ih);
+
+		if (!s1_domain->has_iotlb_device)
+			continue;
+
+		spin_lock_irqsave(&s1_domain->lock, flags);
+		list_for_each_entry(device_info, &s1_domain->devices, link)
+			/*
+			 * Address translation cache in device side caches the
+			 * result of nested translation. There is no easy way
+			 * to identify the exact set of nested translations
+			 * affected by a change in S2. So just flush the entire
+			 * device cache.
+			 */
+			__iommu_flush_dev_iotlb(device_info, 0,
+						MAX_AGAW_PFN_WIDTH);
+		spin_unlock_irqrestore(&s1_domain->lock, flags);
 	}
 	spin_unlock(&domain->s1_lock);
 }
-- 
2.34.1


