Return-Path: <linux-kselftest+bounces-4324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F0884DB5D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 840DCB2487A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8A6D1DC;
	Thu,  8 Feb 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ctn59+PP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EAE6BB55;
	Thu,  8 Feb 2024 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380597; cv=none; b=am7v7zPJ22t5Boj59vYhII8NqGMEkFKvt/CoOQX6TOmeUlmocOpm1dHa0sp+yIHONV/riKHyQgIX4lWko6oEgzq8SjR4T6nrQypZ7El21ByruOKaDzzxvrn1GBBmEAN8HD2M1qn29GgAHSusgX3xLYu0RK8wAU22VGSd75FGnWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380597; c=relaxed/simple;
	bh=E5vqPNymMiBaUwgno+gdspERLQZxZHNPzxdUdl6DYtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqNP4LDMlwIpz9WQ1yO2Y9Tny9fMVEVqwc8VLobDiHyh7PGsYdZofs/wgrw1Qf073ZyeXhaKorrrg30O2u8XzrTebuCZg9k3TBzKu7YFyAdW0ZP87Log4zRRUUc5s5lTsqwPadnKyhkrzoGVABw0lQ5T88rZGhm+Q5hhKNQycZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ctn59+PP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380597; x=1738916597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E5vqPNymMiBaUwgno+gdspERLQZxZHNPzxdUdl6DYtw=;
  b=Ctn59+PPCl7yPs/4fKewQM9CkYzA2CNXLP2QIapjy/uGeWvLL1FbZTap
   /tUkPRNFzhxtnZiA+4skETRApuFEsiswvQUwxtlrUG+mB1GX00pCBOxov
   ygwUxSVJjtt9BsyJGot2pk6HpuKGpbHNvxBzv4tHLWicCHekpxvsbrFpg
   l6SAaNEmPXWgNlF+DKz9/+ZmLkhe5Pt5Wa6hHCCRF/xqSKwpZ8V7umcIx
   Hd/ZPlT29n2kNT4+YrgvVNE1XVy1TW3GBEAVo+SRdWxT3pwDXrLUibrqq
   joXTrZkep0RBt4fekhCmWEeumtdnnjKgGEsEDU3p3ar5Eja6AUXNTz16X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="5036353"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="5036353"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6252137"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa003.jf.intel.com with ESMTP; 08 Feb 2024 00:23:15 -0800
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
Subject: [PATCH rc 7/8] iommu/vt-d: Wrap the dirty tracking loop to be a helper
Date: Thu,  8 Feb 2024 00:23:06 -0800
Message-Id: <20240208082307.15759-8-yi.l.liu@intel.com>
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

Add device_set_dirty_tracking() to loop all the devices and set the dirty
tracking per the @enable parameter.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dae20991e036..7636d3f03905 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4730,23 +4730,35 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
 	return vtd;
 }
 
+static int
+device_set_dirty_tracking(struct list_head *devices, bool enable)
+{
+	struct device_domain_info *info;
+	int ret = 0;
+
+	list_for_each_entry(info, devices, link) {
+		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
+						       IOMMU_NO_PASID, enable);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					  bool enable)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct device_domain_info *info;
 	int ret;
 
 	spin_lock(&dmar_domain->lock);
 	if (dmar_domain->dirty_tracking == enable)
 		goto out_unlock;
 
-	list_for_each_entry(info, &dmar_domain->devices, link) {
-		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
-						       IOMMU_NO_PASID, enable);
-		if (ret)
-			goto err_unwind;
-	}
+	ret = device_set_dirty_tracking(&dmar_domain->devices, enable);
+	if (ret)
+		goto err_unwind;
 
 	dmar_domain->dirty_tracking = enable;
 out_unlock:
@@ -4755,10 +4767,8 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 
 err_unwind:
-	list_for_each_entry(info, &dmar_domain->devices, link)
-		intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
-						 IOMMU_NO_PASID,
-						 dmar_domain->dirty_tracking);
+	device_set_dirty_tracking(&dmar_domain->devices,
+				  dmar_domain->dirty_tracking);
 	spin_unlock(&dmar_domain->lock);
 	return ret;
 }
-- 
2.34.1


