Return-Path: <linux-kselftest+bounces-17826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F344976A02
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FE528294F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFC61A4F0A;
	Thu, 12 Sep 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWF8SmCx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E71A76BC
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146423; cv=none; b=lXFRnJW3Vrstpb0p9sPn54Y9owObAg3tlm7a38cMDuOsojTZGLE6y/umhquGGmt8Wl2btUsFZAZQFachx7U/WxQcMO7X/T9wDzdHsbMEhXmQt/iwopiXnQQpL5PPdhtYtHt9XA9HuthHEva8YgqFmhEJ2rg02KZCGz6kWwtkyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146423; c=relaxed/simple;
	bh=QHMX8+iPDNCER7PtW+1/gV8HijVmgMWRWz2/Gc1dFGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYev3PfgZmSJlQx2OEhB/9G7in0M6kKJdYQQ0gdPZ4Ka3TqEzVyAlOQumGJb0I0t9hdlmZX59KEwBnVr30wL8Yslu3Hk3ThyiSJcwPxENlO4p72yil6wIRUJPSTqDKSZX2yquhc3BYvwII+CahUjy+pRc+kUPjVHvWwDpScw91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWF8SmCx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146419; x=1757682419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QHMX8+iPDNCER7PtW+1/gV8HijVmgMWRWz2/Gc1dFGs=;
  b=TWF8SmCxSYqrQCyEdY+llXHbxXC39ZjJbmc+x9N2csUxvy5KPqJPpxG9
   HptzqLMlL9jfSxfkFLViVE+SPWXR2CCcYFi/ZGkZ6+7oeU7sDIwx0eHDy
   OmRL+Q7KYNqYIeyj306GRTNQ0j2KyJMtJt6B6rrvO1bj4W7K38Ka1vpeA
   /v0LAJE7nGSSP0dzuNoUaTinrfrGPnCyOFgF8Ake7X9winyS43A8nJ2p9
   Q/Z4Po2qd6Mj86U38e+a3iE9Tf63ZdPKlYFCoio66Cc409vhvlDjytLWZ
   yLo+1w9UCqdFq18YZVwfUH3JPQ8mJmByfppMxVuYYUabkU67VuFWjtZQF
   w==;
X-CSE-ConnectionGUID: ihu7ZhEmSV6KA2UzUXvyOg==
X-CSE-MsgGUID: R2ZyoQNPQviLLwyDw8gEOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="35585696"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="35585696"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:06:58 -0700
X-CSE-ConnectionGUID: 8DAe83dIQTO+XLTraNTfEA==
X-CSE-MsgGUID: tQgPMU9rRVm6lk2WvCUFmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="68211624"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 12 Sep 2024 06:06:58 -0700
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
Subject: [PATCH 2/3] iommu/vt-d: Make blocked domain support PASID
Date: Thu, 12 Sep 2024 06:06:52 -0700
Message-Id: <20240912130653.11028-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912130653.11028-1-yi.l.liu@intel.com>
References: <20240912130653.11028-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocked domain can be extended to park PASID of a device to be the
DMA blocking state. By this the remove_dev_pasid() op is dropped.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 749ee7741ec4..ed34ee45a25c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3426,10 +3426,15 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
 	return 0;
 }
 
+static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old);
+
 static struct iommu_domain blocking_domain = {
 	.type = IOMMU_DOMAIN_BLOCKED,
 	.ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= blocking_domain_attach_dev,
+		.set_dev_pasid	= blocking_domain_set_dev_pasid,
 	}
 };
 
@@ -4280,8 +4285,9 @@ static void domain_remove_dev_pasid(struct iommu_domain *domain,
 	kfree(dev_pasid);
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-					 struct iommu_domain *domain)
+static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4289,8 +4295,10 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	intel_pasid_tear_down_entry(iommu, dev, pasid,
 				    INTEL_PASID_TEARDOWN_DRAIN_PRQ);
 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
-		return;
-	domain_remove_dev_pasid(domain, dev, pasid);
+		goto out;
+	domain_remove_dev_pasid(old, dev, pasid);
+out:
+	return 0;
 }
 
 static struct dev_pasid_info *
@@ -4651,7 +4659,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
-	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.page_response		= intel_svm_page_response,
-- 
2.34.1


