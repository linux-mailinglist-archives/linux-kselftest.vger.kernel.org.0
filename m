Return-Path: <linux-kselftest+bounces-4323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8102684DB5A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AE2B243E1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566F6BFDF;
	Thu,  8 Feb 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtlFc3wV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA786BB25;
	Thu,  8 Feb 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380597; cv=none; b=Kd/DrJgHKCgVcE5+uD3IQwJMMp7WomM5kgz/D67SDrGuvnWWQpR+SIq12VI4uNQOm0f/tYGAvA0ezQRUecwu7cZ/BJzYJoYQVxN5Dn5OL0lphTZKb75IEyMUi2rNjngRF5FbdooDFjcSkkZN0e/WAw0CCFMfLj9PWdDU8XZoteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380597; c=relaxed/simple;
	bh=m/RDlw1Azbc+HTUjCY0lMPLwvnpodCQbjh7vQHAUPf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZTEreUggIc/NzxgapRZHlTAoFtXL45DvRpMZtdG5H8dfvMm5Oejy0JWwZ46HjX4scDfb9SgaBUh/uKXyrTkoIB5bC9l1/mf/vpMbdXRsGkBglzvrUOSGlOoo80Cn0RWDdNy6qjn+PmbCWUZk2QDyIsiJZMFgUBGE3espTu2lbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtlFc3wV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380596; x=1738916596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/RDlw1Azbc+HTUjCY0lMPLwvnpodCQbjh7vQHAUPf4=;
  b=EtlFc3wVPVZva8pB2sUAjsNSoFSIT1As8GwTj/sw2K+rBQc/+i4TOYuv
   rqtZxe6cFvZhvSju0kD+mffzhzqNcGNsrsFkx46bGZiIr71MtsyY6rUfe
   blmkissZjB7IDtbnH1POAs8yM0chrzaRRh23kH3K5M8fhNUlwNk7JEyp0
   BC2t+UX7gKjPy+f+1ZWhm6cOYqB3A7J5IvjP126qsth1QeKekTUVE4bhf
   l0m7qlk7VTGlP3snl0yNxynn0B69vFVqHJGg9wBo0uWU34qO4+nrvUKuf
   rRhq1hDtKnQNc571+87JH2QGhR33gyygamFx+aY9Tr7iBeVMu5tzz8UT0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="5036345"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="5036345"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6252131"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa003.jf.intel.com with ESMTP; 08 Feb 2024 00:23:14 -0800
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
Subject: [PATCH rc 6/8] iommu/vt-d: Remove @domain parameter from intel_pasid_setup_dirty_tracking()
Date: Thu,  8 Feb 2024 00:23:05 -0800
Message-Id: <20240208082307.15759-7-yi.l.liu@intel.com>
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

The only usage of input @domain is to get the domain id (DID) to flush
cache after setting dirty tracking. However, DID can be obtained from
the pasid entry. So no need to pass in domain. This can make this helper
cleaner when adding the missing dirty tracking for the parent domain,
which needs to use the DID of nested domain.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 7 +++----
 drivers/iommu/intel/pasid.c | 3 +--
 drivers/iommu/intel/pasid.h | 1 -
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c5a0275697cb..dae20991e036 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4742,8 +4742,7 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 		goto out_unlock;
 
 	list_for_each_entry(info, &dmar_domain->devices, link) {
-		ret = intel_pasid_setup_dirty_tracking(info->iommu,
-						       info->domain, info->dev,
+		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
 						       IOMMU_NO_PASID, enable);
 		if (ret)
 			goto err_unwind;
@@ -4757,8 +4756,8 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 
 err_unwind:
 	list_for_each_entry(info, &dmar_domain->devices, link)
-		intel_pasid_setup_dirty_tracking(info->iommu, dmar_domain,
-						 info->dev, IOMMU_NO_PASID,
+		intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
+						 IOMMU_NO_PASID,
 						 dmar_domain->dirty_tracking);
 	spin_unlock(&dmar_domain->lock);
 	return ret;
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3239cefa4c33..a32d7e509842 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -428,7 +428,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
  * Set up dirty tracking on a second only or nested translation type.
  */
 int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
-				     struct dmar_domain *domain,
 				     struct device *dev, u32 pasid,
 				     bool enabled)
 {
@@ -445,7 +444,7 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
 		return -ENODEV;
 	}
 
-	did = domain_id_iommu(domain, iommu);
+	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
 	if (pgtt != PASID_ENTRY_PGTT_SL_ONLY &&
 	    pgtt != PASID_ENTRY_PGTT_NESTED) {
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 8d40d4c66e31..487ede039bdd 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -307,7 +307,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, u32 pasid);
 int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
-				     struct dmar_domain *domain,
 				     struct device *dev, u32 pasid,
 				     bool enabled);
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
-- 
2.34.1


