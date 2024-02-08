Return-Path: <linux-kselftest+bounces-4321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0541084DB53
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298071C25B42
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B66BB50;
	Thu,  8 Feb 2024 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEoxwlqx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357F6A35C;
	Thu,  8 Feb 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380596; cv=none; b=JbcJEJYhZFNxA4hd/2OWs0oGYjBKCz0arwSuMcF8HtgD108RTrX4BawlGM1UZuab07xuua5bXhYJvjkajzmRmk9RQnLFgU5xd6o7oeWDFXghyD1yjcByD7p01KZ7e/sr1wwAZu4PUvJ73uNSun60W4CTjYyuju2pbE31fMti3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380596; c=relaxed/simple;
	bh=WWbaez9ncxln4TMS8ZatinCzJo3/RSqN211StWyg4QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3FWOG1d7iy0XuJ6hWXIOB5ij6j4Tph02NsOWNXQTSvgVYWxDL2bIRRU3C0VSbICwXQvhgS3ofeJTdv1nPpfTFrI1oWXFKP9bWfDxiplr1S6fKwIF1Ah2V2aVevpiq78vp3fWKicsfoTMJ4eQ9YuhHFLtvaHdlT2BixRMGOhd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEoxwlqx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380594; x=1738916594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WWbaez9ncxln4TMS8ZatinCzJo3/RSqN211StWyg4QA=;
  b=iEoxwlqxiq9sXumlxd80B1YfEd8WYzYJd6TOUgnRfiqpm6+kRDrz+u3i
   U6rFg1Tki/Srv3S/YlHMznA9nkb9QhLy1sRK24Fc57vfcKkYtOp4gwI2X
   UMolKbCBt7GkTUtWu9AoiN3DH+eRNGTLfCOOZJb6U6xNN0MaKVw1qclID
   enrLVWGLQfUHzncAD/gmfnnv839MhRqiUwGJ6evZJBhHQVfX//SVwxV1j
   gmCYDC30bcF4ZnkjI5xJJ0eC32vPMEdSGA9oZj/vXKF7/T3UJ6G0p9s8J
   9DN8b7ar1Owwlab2IL9YyvFhOXSwMgUvWzMV9gpeeUiXhgKVSugsnIi4r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="5036327"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="5036327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6252118"
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
Subject: [PATCH rc 4/8] iommu/vt-d: Update iotlb in nested domain attach
Date: Thu,  8 Feb 2024 00:23:03 -0800
Message-Id: <20240208082307.15759-5-yi.l.liu@intel.com>
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

Should call domain_update_iotlb() to update the has_iotlb_device flag
of the domain after attaching device to nested domain. Without it, this
flag is not set properly and would result in missing device TLB flush.

Fixes: 9838f2bb6b6b ("iommu/vt-d: Set the nested domain to a device")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 4 +---
 drivers/iommu/intel/iommu.h  | 1 +
 drivers/iommu/intel/nested.c | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 46174ff5ae22..b1ceebe13107 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -396,8 +396,6 @@ static int domain_update_device_node(struct dmar_domain *domain)
 	return nid;
 }
 
-static void domain_update_iotlb(struct dmar_domain *domain);
-
 /* Return the super pagesize bitmap if supported. */
 static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 {
@@ -1218,7 +1216,7 @@ domain_lookup_dev_info(struct dmar_domain *domain,
 	return NULL;
 }
 
-static void domain_update_iotlb(struct dmar_domain *domain)
+void domain_update_iotlb(struct dmar_domain *domain)
 {
 	struct dev_pasid_info *dev_pasid;
 	struct device_domain_info *info;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 9b27edb73aa9..4145c04cb1c6 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1066,6 +1066,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
  */
 #define QI_OPT_WAIT_DRAIN		BIT(0)
 
+void domain_update_iotlb(struct dmar_domain *domain);
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 42d4d222e70f..f068ecf72f5a 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -65,6 +65,8 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	list_add(&info->link, &dmar_domain->devices);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	domain_update_iotlb(dmar_domain);
+
 	return 0;
 }
 
-- 
2.34.1


