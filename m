Return-Path: <linux-kselftest+bounces-12919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA82C91BAE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 11:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D0628500C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214BD154BEA;
	Fri, 28 Jun 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXPrygWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031A1534E6;
	Fri, 28 Jun 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565565; cv=none; b=EG1PbKmAMUWQ/ms/AwkDdP5O8hE/XBWaGJjRP0vEMUhZ+FBCa/fd/Pl74fxV/xcooFcQdPFTuXZlanVJnWFMVl3QRhmbQ/0OsYZOZDEoPdZY7YGPaX29Cc0CfGlj+aRJn8cI9r5BrWHFC965CUmBatDTImahRPQ57YsgCD0sSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565565; c=relaxed/simple;
	bh=E8EekZNuM4xjfpZc6aNNgoeYO9VXpIcBhd9fnAAZlcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCjREaZGltKIXUK8eszpJJ4bIHN3knDtmmbx39EtDeseQKx9ZG9TLNFwZYWF6lGQemuGk95TzhdECs0sFk94Yt+AAh1oa6DTBZM4nxTmzotci0WwRPUjOtxkg0ABPIiEYvvF5FHuUQ3kbWGGLIjsCac/dHjWKsHSLAYDJQKjFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXPrygWY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719565563; x=1751101563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E8EekZNuM4xjfpZc6aNNgoeYO9VXpIcBhd9fnAAZlcg=;
  b=FXPrygWYKYST+ZRbZLiYunZb2yr0xdlcvZAdh0uhdBRBbyW2TStQhtCq
   EUflBfcZS4umuajq0Wp/bXj0El4BiTXR24q1ZLbJoHYOyB9VpSf6vfrIp
   QMfQrdbl5MIzsxi5SYpDmzFG/26TZTJSNxy78cygPL5q60ZxMZNSNHNn9
   YW/u1cl6fHL69DESizcFvVzWX5NQoG+EzIbNUw7LaWrnVx20N3WtoZblI
   R3PDn/HC1Pv0XSCp63h4VIp1I34H/6S9LgUNLQzZu+iplzHxPO7cLLpmi
   JaIYhNsSrvo3Uo5KW2M9Xnub8UkrMZWZSbmErvBbIMTHcMk8AEIXj8RS4
   w==;
X-CSE-ConnectionGUID: 4uNBbzZYRRCsoLOVbVkvNw==
X-CSE-MsgGUID: ++vlH3tCSFupXWRdOgiTng==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20613689"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="20613689"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:06:02 -0700
X-CSE-ConnectionGUID: i8GTV2LBTSe5m25sdvVrYA==
X-CSE-MsgGUID: FObCH1S6TNW9Lk7FzUY6gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44517063"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jun 2024 02:06:02 -0700
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
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 4/7] iommufd/selftest: Add set_dev_pasid and remove_dev_pasid in mock iommu
Date: Fri, 28 Jun 2024 02:05:54 -0700
Message-Id: <20240628090557.50898-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628090557.50898-1-yi.l.liu@intel.com>
References: <20240628090557.50898-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two callbacks are needed to make pasid_attach/detach path complete for
mock device. A nop is enough for set_dev_pasid, a domain type check in the
remove_dev_pasid is also helpful.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 7a2199470f31..1404eca156a8 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -514,6 +514,30 @@ static struct iommu_device *mock_probe_device(struct device *dev)
 	return &mock_iommu_device;
 }
 
+static void mock_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+					struct iommu_domain *domain)
+{
+	/* Domain type specific cleanup: */
+	if (domain) {
+		switch (domain->type) {
+		case IOMMU_DOMAIN_NESTED:
+		case IOMMU_DOMAIN_UNMANAGED:
+			break;
+		default:
+			/* should never reach here */
+			WARN_ON(1);
+			break;
+		}
+	}
+}
+
+static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old)
+{
+	return 0;
+}
+
 static const struct iommu_ops mock_ops = {
 	/*
 	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
@@ -529,6 +553,7 @@ static const struct iommu_ops mock_ops = {
 	.capable = mock_domain_capable,
 	.device_group = generic_device_group,
 	.probe_device = mock_probe_device,
+	.remove_dev_pasid = mock_iommu_remove_dev_pasid,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -536,6 +561,7 @@ static const struct iommu_ops mock_ops = {
 			.map_pages = mock_domain_map_pages,
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
+			.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 		},
 };
 
@@ -600,6 +626,7 @@ static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free_nested,
 	.attach_dev = mock_domain_nop_attach,
 	.cache_invalidate_user = mock_domain_cache_invalidate_user,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 };
 
 static inline struct iommufd_hw_pagetable *
@@ -660,6 +687,10 @@ static void mock_dev_release(struct device *dev)
 
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
+	struct property_entry prop[] = {
+		PROPERTY_ENTRY_U32("pasid-num-bits", 20),
+		{},
+	};
 	struct mock_dev *mdev;
 	int rc;
 
@@ -685,6 +716,12 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (rc)
 		goto err_put;
 
+	rc = device_create_managed_software_node(&mdev->dev, prop, NULL);
+	if (rc) {
+		dev_err(&mdev->dev, "add pasid-num-bits property failed, rc: %d", rc);
+		goto err_put;
+	}
+
 	rc = device_add(&mdev->dev);
 	if (rc)
 		goto err_put;
@@ -1491,6 +1528,8 @@ int __init iommufd_test_init(void)
 				  &iommufd_mock_bus_type.nb);
 	if (rc)
 		goto err_sysfs;
+
+	mock_iommu_device.max_pasids = (1 << 20);
 	return 0;
 
 err_sysfs:
-- 
2.34.1


