Return-Path: <linux-kselftest+bounces-17820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6D49769F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5FCB22E61
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A841A7AD6;
	Thu, 12 Sep 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPBQACcF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B91A724B
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146278; cv=none; b=mcOJtqE9kekTh19RCt1S68orsUYKqFq8NfnmrG8R2wMNVxwzU7nkek3reKHZgNFUdMMV7uDbyCAnq4q3k4+1YyHUDflxQmpD32bCc/8DCJd1lnkERw8FnhKAS/AZwYIToAuXMh+76n+wvX6FVCiyqhtD4nLu5zIRujvRKfhSxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146278; c=relaxed/simple;
	bh=sGbcPWSBpcVNAtNQfx5+HpsfgiOp1WmGAWMS4UxxrBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLO2zxRfpXzoM3t0qI5CGSGJE63yxwbLVMyMn19FYdnkJgfg0YTgBnz5DPx6NB54kh7fom4ljK1DBxls385pNGClTnL61WwXqfrdS4M+fAB/+dqMNl8PQ3k7o0VKuskIncJaO7X38Ilw766HkLalUtW+00Y3dSNoDp1npyBKf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPBQACcF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146276; x=1757682276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sGbcPWSBpcVNAtNQfx5+HpsfgiOp1WmGAWMS4UxxrBs=;
  b=gPBQACcF4tbWgjG6VSl5DBNwVTXu8TOC/Wt1aoK83gOzJZ5tzu/tP5bu
   0sCEKkTR0npnEXCzvb7dBo9+kEvjeF4Us57OVeBKd03NQx2lLg8OjIbh8
   sm7BVxui4Bg+HK/oQvujEethlCf5qugxaDqophEf4n3oXGZb+58dR/pfG
   mruKxwRs3ACVA0bMoLSOTHxbNZuCP7uw7p9la9o+AfbSsFyRjaT4PIj6w
   H6Cpj+dAz5UisD1PeAhkHtDN+EQncuwzRD/QOXcefGV1dazrLrXlomMzA
   9/g/lZpCIqbb/4MskOe8C0oGbVvsgP42e8pMNNEZIVO24CVEE2/Bcptwh
   A==;
X-CSE-ConnectionGUID: aKxqFBVoQRilAWTgy3/b0Q==
X-CSE-MsgGUID: UUjc9+RcSLWjoBm25Sdj0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36380551"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36380551"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:04:35 -0700
X-CSE-ConnectionGUID: 0T/EvMCDRzKFehWr548uGQ==
X-CSE-MsgGUID: h2k0upPBQ0KEKdgih+iBaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72509941"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 12 Sep 2024 06:04:34 -0700
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
Subject: [PATCH v2 4/6] iommu/vt-d: Add set_dev_pasid callback for nested domain
Date: Thu, 12 Sep 2024 06:04:25 -0700
Message-Id: <20240912130427.10119-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912130427.10119-1-yi.l.liu@intel.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

Extend intel_iommu_set_dev_pasid() to set a nested type domain to a PASID
of a device.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 22 +++++++++++++++++-----
 drivers/iommu/intel/iommu.h  |  3 +++
 drivers/iommu/intel/nested.c |  1 +
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6f5a8e549f3f..749ee7741ec4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -284,6 +284,11 @@ static int __init intel_iommu_setup(char *str)
 }
 __setup("intel_iommu=", intel_iommu_setup);
 
+static int domain_type_is_nested(struct dmar_domain *domain)
+{
+	return domain->domain.type == IOMMU_DOMAIN_NESTED;
+}
+
 static int domain_pfn_supported(struct dmar_domain *domain, unsigned long pfn)
 {
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
@@ -4299,7 +4304,12 @@ domain_prepare_dev_pasid(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret;
 
-	ret = prepare_domain_attach_device(domain, dev);
+	/* Nested type domain should prepare its parent domain */
+	if (domain_type_is_nested(dmar_domain))
+		ret = prepare_domain_attach_device(
+				&dmar_domain->s2_domain->domain, dev);
+	else
+		ret = prepare_domain_attach_device(domain, dev);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -4329,9 +4339,9 @@ domain_prepare_dev_pasid(struct iommu_domain *domain,
 	return ERR_PTR(ret);
 }
 
-static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid,
-				     struct iommu_domain *old)
+int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid,
+			      struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4356,7 +4366,9 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	intel_pasid_tear_down_entry(iommu, dev, pasid,
 				    INTEL_PASID_TEARDOWN_DRAIN_PRQ);
 
-	if (dmar_domain->use_first_level)
+	if (domain_type_is_nested(dmar_domain))
+		ret = intel_pasid_setup_nested(iommu, dev, pasid, dmar_domain);
+	else if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
 	else
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b3b295e60626..36cf59bfe4ea 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1109,6 +1109,9 @@ void device_block_translation(struct device *dev);
 int prepare_domain_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 void domain_update_iommu_cap(struct dmar_domain *domain);
+int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid,
+			      struct iommu_domain *old);
 
 int dmar_ir_support(void);
 
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 36a91b1b52be..c5a94c00b396 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -131,6 +131,7 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
+	.set_dev_pasid		= intel_iommu_set_dev_pasid,
 	.free			= intel_nested_domain_free,
 	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
 };
-- 
2.34.1


