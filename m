Return-Path: <linux-kselftest+bounces-627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9297F99E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 07:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC75F1C20946
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 06:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E2DDC7;
	Mon, 27 Nov 2023 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKWhKpOy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CFC12F;
	Sun, 26 Nov 2023 22:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701066876; x=1732602876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZ2ZM14suqOR6uWNGYJVIr5wJqTHJJ9fSMownQVohd4=;
  b=iKWhKpOyvcGW0g8bPt36MIBtXJVO2xGPoxx2gGzI1KIBJdYUSuVuB9rm
   pGCAjbSFDreSGjjAfdDoCPX+oWRrRn07SkfHmoZ1Nl6qO8oMzFH19HBbd
   OHTLoxZ9kXGs9aJm4xrGLITRGT1gYm3lOvG7bQcvm47DMOzOcNGSbPOHe
   KkrTAZWh5hVLMtCDG3NFNOFPkw/s+FyalU8JmrDOGzsL/f+fblUnDdsZY
   B7Tds8I6ekV+8tsF6l7h/XozE4UHVMUMOgNXg2OrRhP1hOAHIpT9/IgYB
   hXaWemA/o2wSQX2tMN3LyO5Mhf2pb605Vrj78WOgNJPhSO/0smxDdunPA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391518172"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="391518172"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="838608940"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="838608940"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2023 22:34:35 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com,
	xin.zeng@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH 4/8] iommufd/selftest: Add set_dev_pasid and remove_dev_pasid in mock iommu
Date: Sun, 26 Nov 2023 22:34:24 -0800
Message-Id: <20231127063428.127436-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127063428.127436-1-yi.l.liu@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/selftest.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index f2d4599f701b..221a206bf38f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -440,6 +440,31 @@ static struct iommu_device *mock_probe_device(struct device *dev)
 	return &mock_iommu_device;
 }
 
+static void mock_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+
+	/* Domain type specific cleanup: */
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
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
+					 struct device *dev, ioasid_t pasid)
+{
+	return 0;
+}
+
 static const struct iommu_ops mock_ops = {
 	/*
 	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
@@ -455,6 +480,7 @@ static const struct iommu_ops mock_ops = {
 	.capable = mock_domain_capable,
 	.device_group = generic_device_group,
 	.probe_device = mock_probe_device,
+	.remove_dev_pasid = mock_iommu_remove_dev_pasid,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -462,6 +488,7 @@ static const struct iommu_ops mock_ops = {
 			.map_pages = mock_domain_map_pages,
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
+			.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 		},
 };
 
@@ -519,6 +546,7 @@ static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free_nested,
 	.attach_dev = mock_domain_nop_attach,
 	.cache_invalidate_user = mock_domain_cache_invalidate_user,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 };
 
 static inline struct iommufd_hw_pagetable *
-- 
2.34.1


