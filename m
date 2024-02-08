Return-Path: <linux-kselftest+bounces-4325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00484DB5E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D92C1F24811
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E1C6DCFC;
	Thu,  8 Feb 2024 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltPA6O/S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122D6BFA3;
	Thu,  8 Feb 2024 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380598; cv=none; b=CWZweU2swfNSkMj3/jD9ojKm/YR1MYup0JluspCyJd+fsjONwawUaJrzWbEaAZPT1MlK6IOWKsSacM6R/+AmAX9TPPX2f1EL1eUDUquqLmOLM+7JzRHn76Q1QANLLRfPqn6lXAye2QDmltefFyEG32hfGYK36y1aO5R8KbsA/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380598; c=relaxed/simple;
	bh=thi2b5CgZH40iDhft4tiI0ilUOViNb/SOYwiICBayms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTcwP2kpHgqn4PwwFBhkx8jtVO+C9TXe4Z8HJdwJrFfxzPfS22o8A93XN19k+wSA6kagGSikhBoHd5DesJIBNTVQ66gwxDsopzt+JEJuybOTDYMPiUV7OondZ942x/zfI46nMdWliDjltQKrwRlS7gggNCFM6FCOIhFHNTfX/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltPA6O/S; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380597; x=1738916597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=thi2b5CgZH40iDhft4tiI0ilUOViNb/SOYwiICBayms=;
  b=ltPA6O/Sy9TUw9S9HAt2bF6AyypG9EvXnvaBlP2+rkLUw7EXFBh4TEuK
   DnsWmj597SvZjYjvIo6b8on0Kq+xrambj7Q5ph1dMRRiAYfn7YP5nZaE0
   89Y4VMF/LnU58RpZT5jXuJASfxTnZ57kR4S8iogVA/EbEcfVFPaBYIyDr
   I8rIFpTUY1XecRZcKLnVGhmAHMvTyjZ4Q9QZ5VFhPh+y9g7vbM97yfK5G
   vnkIgUlAAShpDuUvy06wL9iI7hr8DQubTduCKvL0/yAo45YHdTIrglMF3
   sISOj7f/mnfa4Tl5ollbWUz1PywV5TKkzyFDOzyL0Zn+GWiHT3JiKeCI+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="5036360"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="5036360"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6252142"
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
Subject: [PATCH rc 8/8] iommu/vt-d: Add missing dirty tracking set for parent domain
Date: Thu,  8 Feb 2024 00:23:07 -0800
Message-Id: <20240208082307.15759-9-yi.l.liu@intel.com>
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

Setting dirty tracking for a s2 domain requires to loop all the related
devices and set the dirty tracking enable bit in the PASID table entry.
This includes the devices that are attached to the nested domains of a
s2 domain if this s2 domain is used as parent. However, the existing dirty
tracking set only loops s2 domain's own devices. It will miss dirty page
logs in the parent domain.

Now, the parent domain tracks the nested domains, so it can loop the
nested domains and the devices attached to the nested domains to ensure
dirty tracking on the parent is set completely.

Fixes: b41e38e22539 ("iommu/vt-d: Add nested domain allocation")
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7636d3f03905..b4101712a0c3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4746,6 +4746,36 @@ device_set_dirty_tracking(struct list_head *devices, bool enable)
 	return ret;
 }
 
+static int
+parent_domain_set_dirty_tracking(struct dmar_domain *domain,
+				 bool enable)
+{
+	struct dmar_domain *s1_domain;
+	unsigned long flags;
+	int ret;
+
+	spin_lock(&domain->s1_lock);
+	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
+		spin_lock_irqsave(&s1_domain->lock, flags);
+		ret = device_set_dirty_tracking(&s1_domain->devices, enable);
+		spin_unlock_irqrestore(&s1_domain->lock, flags);
+		if (ret)
+			goto err_unwind;
+	}
+	spin_unlock(&domain->s1_lock);
+	return 0;
+
+err_unwind:
+	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
+		spin_lock_irqsave(&s1_domain->lock, flags);
+		device_set_dirty_tracking(&s1_domain->devices,
+					  domain->dirty_tracking);
+		spin_unlock_irqrestore(&s1_domain->lock, flags);
+	}
+	spin_unlock(&domain->s1_lock);
+	return ret;
+}
+
 static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					  bool enable)
 {
@@ -4760,6 +4790,12 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	if (ret)
 		goto err_unwind;
 
+	if (dmar_domain->nested_parent) {
+		ret = parent_domain_set_dirty_tracking(dmar_domain, enable);
+		if (ret)
+			goto err_unwind;
+	}
+
 	dmar_domain->dirty_tracking = enable;
 out_unlock:
 	spin_unlock(&dmar_domain->lock);
-- 
2.34.1


