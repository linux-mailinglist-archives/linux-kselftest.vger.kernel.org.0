Return-Path: <linux-kselftest+bounces-17819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF759769F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8A91F21FFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21511A76C3;
	Thu, 12 Sep 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApvJcn3i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E71A3040
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146277; cv=none; b=EjXCv0CKBHJ04/TpeDJXIfIF+uTTrUuPvEHNVx9ZF+hCSvV1dZsuvy+iKkmJP8YE6uE1eOrUGgfXVoC0KSOGiD2Nte3CX10KZSc0VpFu78tNyOsRpV4+gWEQXTEIxwKhtnVvvC+SUFYvKV1rnBI94uAN+MoVCEIPPFSpHJCrfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146277; c=relaxed/simple;
	bh=7Mou63F6Si0LBgDAYfUJIlqLAYZyr2Fjly0h3zS3O/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXsyoEn2hyT9JB+VuJM2XTvUb571Eg1qoUKdGgjc/h0yzAZSLhdOWHqwQEBJ6ix5j7Zv/DCwzDZaN0X0JXV2ac4YK+zG5vVamizetLmY9Qn95MA+Xuz+surL9yLf+zicrv11Nzngre9udqeRi/PFXP7oWHKdtcTQoURz2i/w2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApvJcn3i; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146276; x=1757682276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Mou63F6Si0LBgDAYfUJIlqLAYZyr2Fjly0h3zS3O/0=;
  b=ApvJcn3i+Sx+qKWQPT6J9i1t8bkaxBvp7An3olKeIq9dzxPAodGHK2pU
   mi8g1UQhTz08svyVnzySXZIWhchXejAIsFN2b/9/ez1W+ecDbTjMUHcmn
   Os4WBfBwXTmH57EAY0kH4a8FWgB2gE8+P2MU5KTmgTdpkr0ngUJRoCNNY
   SMC28IMWWHJ8p/P89ecfLjHGt1UEabXtvN4yTCK+6YrqslEQoBGidfsvr
   tSEqcFUKHtZe/WPhQjmZvtyH+8ZonqjcGMoSmzgnfUlpogS4zYEW4In9C
   9tmc7LX6Po+BBC1uymdmONgykGt9f+2yF9ok8OMkJH55dnEMTQNovlfqJ
   g==;
X-CSE-ConnectionGUID: K9D34U2fQkes30Tb2tS4Hg==
X-CSE-MsgGUID: i/OpkFJZRk+NXgLfAjVAMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36380542"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36380542"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:04:34 -0700
X-CSE-ConnectionGUID: DgeXWjRESTGSgIThZMByGA==
X-CSE-MsgGUID: OuXIn9GITSi37F24G3eRqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72509934"
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
Subject: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to handle domain replacement
Date: Thu, 12 Sep 2024 06:04:24 -0700
Message-Id: <20240912130427.10119-4-yi.l.liu@intel.com>
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

set_dev_pasid op is going to support domain replacement and keep the old
hardware config if it fails. Make the Intel iommu driver be prepared for
it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 98 ++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 80b587de226d..6f5a8e549f3f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4248,8 +4248,8 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-					 struct iommu_domain *domain)
+static void domain_remove_dev_pasid(struct iommu_domain *domain,
+				    struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
@@ -4257,11 +4257,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	struct dmar_domain *dmar_domain;
 	unsigned long flags;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
-		return;
-	}
-
 	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
@@ -4278,13 +4273,24 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
+}
+
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *domain)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
 	intel_pasid_tear_down_entry(iommu, dev, pasid,
 				    INTEL_PASID_TEARDOWN_DRAIN_PRQ);
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return;
+	domain_remove_dev_pasid(domain, dev, pasid);
 }
 
-static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid,
-				     struct iommu_domain *old)
+static struct dev_pasid_info *
+domain_prepare_dev_pasid(struct iommu_domain *domain,
+			 struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4293,22 +4299,13 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret;
 
-	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
-		return -EOPNOTSUPP;
-
-	if (domain->dirty_ops)
-		return -EINVAL;
-
-	if (context_copied(iommu, info->bus, info->devfn))
-		return -EBUSY;
-
 	ret = prepare_domain_attach_device(domain, dev);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
 	if (!dev_pasid)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	ret = domain_attach_iommu(dmar_domain, iommu);
 	if (ret)
@@ -4318,6 +4315,47 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_detach_iommu;
 
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	return dev_pasid;
+out_detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+out_free:
+	kfree(dev_pasid);
+	return ERR_PTR(ret);
+}
+
+static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+				     struct device *dev, ioasid_t pasid,
+				     struct iommu_domain *old)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct dev_pasid_info *dev_pasid;
+	int ret;
+
+	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	if (domain->dirty_ops)
+		return -EINVAL;
+
+	if (context_copied(iommu, info->bus, info->devfn))
+		return -EBUSY;
+
+	dev_pasid = domain_prepare_dev_pasid(domain, dev, pasid);
+	if (IS_ERR(dev_pasid))
+		return PTR_ERR(dev_pasid);
+
+	/* Clear the old configuration if it already exists */
+	intel_pasid_tear_down_entry(iommu, dev, pasid,
+				    INTEL_PASID_TEARDOWN_DRAIN_PRQ);
+
 	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
@@ -4325,24 +4363,18 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
 						     dev, pasid);
 	if (ret)
-		goto out_unassign_tag;
+		goto out_undo_dev_pasid;
 
-	dev_pasid->dev = dev;
-	dev_pasid->pasid = pasid;
-	spin_lock_irqsave(&dmar_domain->lock, flags);
-	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
-	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	if (old)
+		domain_remove_dev_pasid(old, dev, pasid);
 
 	if (domain->type & __IOMMU_DOMAIN_PAGING)
 		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
-out_unassign_tag:
-	cache_tag_unassign_domain(dmar_domain, dev, pasid);
-out_detach_iommu:
-	domain_detach_iommu(dmar_domain, iommu);
-out_free:
-	kfree(dev_pasid);
+
+out_undo_dev_pasid:
+	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
 }
 
-- 
2.34.1


