Return-Path: <linux-kselftest+bounces-17834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE3B976A28
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C74A1C23250
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FA11AD251;
	Thu, 12 Sep 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXUGiikq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662611AC440
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146784; cv=none; b=ixYqXEYII1ImAGtBC2A//9VBk+e3pJEo8WaNzHYn8hzdYApq90aIkQMFHcZFCBbrWqAWC4RfXc+Yv8P0KM/URdMHF2NQp57C4pIyx0gXAya4QC0TDwyZnHP0WC/ojf1GEjO5qT0ZfDdT0yWsIuHrVlOQOljwv+Aytz0Ju4sQNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146784; c=relaxed/simple;
	bh=dpiKoCcc9TP8bfWcbEGDYwTz/zI/neM9JmFU0mpmdNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEcDDqsjECGZtdDRNU5GbYxVkVxkvoAOAVlEcYyIWCjj3YsfIWFbM4N/hl9YLx2Q6cGK6FCv7C1vbDe6B90uP8YYEWPtge/2EayJPLpCSgtO1JANHS4iUYHYkMv6JJJFcQHsWdkhw6+ErL8zyl3aOa4VVBAbvOFYV7J74flnv70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXUGiikq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146783; x=1757682783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpiKoCcc9TP8bfWcbEGDYwTz/zI/neM9JmFU0mpmdNo=;
  b=JXUGiikqj9Gr052cZ1CpnIvroF94qAgzbJ1W0KzqSt03tCmSx2/6IRfR
   g7SEB2KXK1J/z2AzHT+YPQgfAgp6tMqwBsmxbgwkIXudEloD8RHxsvxtp
   S03SRTGn0YXKUMuutTt+aRJNGia/z9tizteigN5dysYRX5RHuWJy88/4G
   iLdCfYf2mmiQvBBMFh4Oa/oFnOZS9yBzXjEM09SGNASqy/xXk46f1hETk
   vSrbVXGd+pq61eS0XptziVaAp5Bm8nwZ3iBmtAoHpgVf9mUwLg+9i5J/E
   zSd2KP9Dk0SAa46+KaeBvnulyeBauCcUsEOwqSTczForR7R2HlWmdzG+Y
   Q==;
X-CSE-ConnectionGUID: 6VnOkEVJQJO2uYxbQ2LnoQ==
X-CSE-MsgGUID: a65BXYGeSt+KBDFFPRn5IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27911242"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="27911242"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:13:00 -0700
X-CSE-ConnectionGUID: +LQjvvkPRjeQ1QaPF4aWwg==
X-CSE-MsgGUID: x0JrXDpYT2iVdhMyS0jPNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67996571"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2024 06:13:00 -0700
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
Subject: [PATCH v4 07/10] iommufd/selftest: Add set_dev_pasid and remove_dev_pasid in mock iommu
Date: Thu, 12 Sep 2024 06:12:52 -0700
Message-Id: <20240912131255.13305-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912131255.13305-1-yi.l.liu@intel.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/selftest.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 222cfc11ebfd..7fd8dc5a667f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -539,6 +539,30 @@ static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features fea
 	return 0;
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
@@ -558,6 +582,7 @@ static const struct iommu_ops mock_ops = {
 	.dev_enable_feat = mock_dev_enable_feat,
 	.dev_disable_feat = mock_dev_disable_feat,
 	.user_pasid_table = true,
+	.remove_dev_pasid = mock_iommu_remove_dev_pasid,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -565,6 +590,7 @@ static const struct iommu_ops mock_ops = {
 			.map_pages = mock_domain_map_pages,
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
+			.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 		},
 };
 
@@ -629,6 +655,7 @@ static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free_nested,
 	.attach_dev = mock_domain_nop_attach,
 	.cache_invalidate_user = mock_domain_cache_invalidate_user,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 };
 
 static inline struct iommufd_hw_pagetable *
@@ -689,6 +716,10 @@ static void mock_dev_release(struct device *dev)
 
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
+	struct property_entry prop[] = {
+		PROPERTY_ENTRY_U32("pasid-num-bits", 20),
+		{},
+	};
 	struct mock_dev *mdev;
 	int rc;
 
@@ -714,6 +745,12 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
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
@@ -1549,6 +1586,7 @@ int __init iommufd_test_init(void)
 		goto err_sysfs;
 
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
+	mock_iommu_device.max_pasids = (1 << 20);
 
 	return 0;
 
-- 
2.34.1


