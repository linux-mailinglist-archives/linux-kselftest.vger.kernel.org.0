Return-Path: <linux-kselftest+bounces-4320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FBF84DB51
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6441F245FE
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6826BB27;
	Thu,  8 Feb 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KafITziR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C36A348;
	Thu,  8 Feb 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380595; cv=none; b=LKroM8zLWYPamuuPb34BC25eDnjc1K1dyIcceBcvq40WvjKm1eegKMALZdNST4U6aOSGyG7iBN70HHaMCuiJyv/YWXwmeR/L22mwsPoxFpSXzVZc+YLzYVcoiWnNm/jVeUpoK3TEBZs21xoIpeOyl1VaKZBzYFySCcf+zmdKT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380595; c=relaxed/simple;
	bh=rkAIlr3b517pIibgb/ERZPXd9p33fw79H8+yLPYzn6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPTiUF10Xnf+zvdyVyhwtwAQdphtThq90e+inx+QP7E2N2b2ImjkwjP0S7vWojhIK5XKXsdNMsDENyn/rNcLlkuT2TBh1geinNTus/BJjM7Fpt0X5S5psOn6RGr7Sa4RlahJFrh6BvZh099rGgDO8QsrcufQP4idr2Mb68pM71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KafITziR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380594; x=1738916594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rkAIlr3b517pIibgb/ERZPXd9p33fw79H8+yLPYzn6Y=;
  b=KafITziRG6TwsCCYFb918pNXiwe4PbU7q8V/uSsZKUlEyTKwLpKn+fxH
   y4detufcB7WSEqmmERD6lycbwQj0V+VB58rtQMKBTa6k3FUsPjDuM/99C
   uaUiL3ADwAnyzyOUnrcokIKJYevOSeQIjq9hfwg6TSm0GyeRVzH+pB/rr
   z3aFybx91nwsYq28Okd7HHD4DNOpTmNz7kYxu2r/SYJhJQgZBrOhHTmRs
   5TPEBqWxMTWolQI1rFWnEhTMi8B1X+izVkNaOVLCaftJXSPQmP1jLpkGJ
   pjztp/XGoWNoUrkD9kncXDZHfAZ06f49ER707SM3fHqCcO0jpwTGj2aKz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="5036318"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="5036318"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6252111"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa003.jf.intel.com with ESMTP; 08 Feb 2024 00:23:12 -0800
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
Subject: [PATCH rc 3/8] iommu/vt-d: Add missing iotlb flush for parent domain
Date: Thu,  8 Feb 2024 00:23:02 -0800
Message-Id: <20240208082307.15759-4-yi.l.liu@intel.com>
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

If a domain is used as the parent in nested translation its mappings might
be cached using DID of the nested domain. But the existing code ignores
this fact to only invalidate the iotlb entries tagged by the domain's own
DID.

Loop the s1_domains list, if any, to invalidate all iotlb entries related
to the target s2 address range. According to VT-d spec there is no need for
software to explicitly flush the affected s1 cache. It's implicitly done by
HW when s2 cache is invalidated.

Fixes: b41e38e22539 ("iommu/vt-d: Add nested domain allocation")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index eef6a187b651..46174ff5ae22 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1452,6 +1452,28 @@ static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *
 		iommu_flush_write_buffer(iommu);
 }
 
+/*
+ * Flush the relevant caches in nested translation if the domain
+ * also serves as a parent
+ */
+static void parent_domain_flush(struct dmar_domain *domain,
+				unsigned long pfn,
+				unsigned long pages, int ih)
+{
+	struct dmar_domain *s1_domain;
+
+	spin_lock(&domain->s1_lock);
+	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
+		struct iommu_domain_info *info;
+		unsigned long i;
+
+		xa_for_each(&s1_domain->iommu_array, i, info)
+			__iommu_flush_iotlb_psi(info->iommu, info->did,
+						pfn, pages, ih);
+	}
+	spin_unlock(&domain->s1_lock);
+}
+
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -1471,6 +1493,9 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		if (!cap_caching_mode(iommu->cap))
 			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
 	}
+
+	if (dmar_domain->nested_parent)
+		parent_domain_flush(dmar_domain, 0, -1, 0);
 }
 
 static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
@@ -1994,6 +2019,9 @@ static void switch_to_super_page(struct dmar_domain *domain,
 				iommu_flush_iotlb_psi(info->iommu, domain,
 						      start_pfn, lvl_pages,
 						      0, 0);
+			if (domain->nested_parent)
+				parent_domain_flush(domain, start_pfn,
+						    lvl_pages, 0);
 		}
 
 		pte++;
@@ -4126,6 +4154,9 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 				      start_pfn, nrpages,
 				      list_empty(&gather->freelist), 0);
 
+	if (dmar_domain->nested_parent)
+		parent_domain_flush(dmar_domain, start_pfn, nrpages,
+				    list_empty(&gather->freelist));
 	put_pages_list(&gather->freelist);
 }
 
-- 
2.34.1


