Return-Path: <linux-kselftest+bounces-2470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635C581F021
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 17:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955181C214C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED347F48;
	Wed, 27 Dec 2023 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYhWmrF2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA52846B87;
	Wed, 27 Dec 2023 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703693644; x=1735229644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YaKsYJmpoP1J2+af2wMppPzhvG3pSWEOhFLhzXoh4BU=;
  b=ZYhWmrF2w1SvPxUy2s+i04RkaPSbjT+0wl7Kt40MmvelMxnrhQ8f9XsO
   3ZQeGU5KHzOm6ziAbh68R6gK7kfGmU+HJF2+ZjweEF1MjRKkRNISQOuo2
   +0YV33xqDPL15scGmVJqDCl3GgVu+TEKg0fG44aiVZjSPEfU2ADVsCAxT
   T9zYgHENXmxcpekVqYIYXWF/SiTzlQQeAnVxD2gnPB6YguNOAYIxqYKK7
   Dg636FlqGMmjYhCORFgFKzLLbRrSKfHukC7cPORwl3MaKfYAGeNKa5voC
   GS+ZDWijRp2u+5VlW/rwPsiplEu1grgRUrTT5onYZUQevbva0ba/TBG1I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="396186231"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="396186231"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:14:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="781775205"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="781775205"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 27 Dec 2023 08:14:02 -0800
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
	yan.y.zhao@intel.com,
	j.granados@samsung.com
Subject: [PATCH v8 04/10] iommufd/selftest: Add mock_domain_cache_invalidate_user support
Date: Wed, 27 Dec 2023 08:13:48 -0800
Message-Id: <20231227161354.67701-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227161354.67701-1-yi.l.liu@intel.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

Add mock_domain_cache_invalidate_user() data structure to support user
space selftest program to cover user cache invalidation pathway.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 34 ++++++++++++++++
 drivers/iommu/iommufd/selftest.c     | 60 ++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 7910fbe1962d..2eef5afde711 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -148,4 +148,38 @@ struct iommu_hwpt_selftest {
 	__u32 iotlb;
 };
 
+/* Should not be equal to any defined value in enum iommu_hwpt_invalidate_data_type */
+#define IOMMU_HWPT_INVALIDATE_DATA_SELFTEST 0xdeadbeef
+#define IOMMU_HWPT_INVALIDATE_DATA_SELFTEST_INVALID 0xdadbeef
+
+/**
+ * enum iommu_hwpt_invalidate_selftest_error - Hardware error of invalidation
+ * @IOMMU_TEST_INVALIDATE_FAKE_ERROR: Fake hw error per test program's request
+ */
+enum iommu_hwpt_invalidate_selftest_error {
+	IOMMU_TEST_INVALIDATE_FAKE_ERROR = (1 << 0)
+};
+
+/**
+ * struct iommu_hwpt_invalidate_selftest - Invalidation data for Mock driver
+ *                                         (IOMMU_HWPT_INVALIDATE_DATA_SELFTEST)
+ * @flags: Invalidate flags
+ * @iotlb_id: Invalidate iotlb entry index
+ * @hw_error: One of enum iommu_hwpt_invalidate_selftest_error
+ * @__reserved: Must be 0
+ *
+ * If IOMMU_TEST_INVALIDATE_ALL is set in @flags, @iotlb_id will be ignored
+ * @hw_error meaningful only if the request is processed successfully.
+ * If IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR is set in @flags, report a
+ * hw error back, cache would not be invalidated in this case.
+ */
+struct iommu_hwpt_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_FLAG_ALL	(1 << 0)
+#define IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR	(1 << 1)
+	__u32 flags;
+	__u32 iotlb_id;
+	__u32 hw_error;
+	__u32 __reserved;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 022ef8f55088..ebc6c15abf67 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -473,9 +473,69 @@ static void mock_domain_free_nested(struct iommu_domain *domain)
 	kfree(mock_nested);
 }
 
+static int
+mock_domain_cache_invalidate_user(struct iommu_domain *domain,
+				  struct iommu_user_data_array *array)
+{
+	struct mock_iommu_domain_nested *mock_nested =
+		container_of(domain, struct mock_iommu_domain_nested, domain);
+	u32 hw_error = 0, processed = 0;
+	struct iommu_hwpt_invalidate_selftest inv;
+	int i = 0, j;
+	int rc = 0;
+
+	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_SELFTEST) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	for ( ; i < array->entry_num; i++) {
+		rc = iommu_copy_struct_from_user_array(&inv, array,
+						       IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+						       i, __reserved);
+		if (rc)
+			break;
+
+		if ((inv.flags & ~(IOMMU_TEST_INVALIDATE_FLAG_ALL |
+				  IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR)) ||
+		    inv.__reserved) {
+			rc = -EOPNOTSUPP;
+			break;
+		}
+
+		if (inv.iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX) {
+			rc = -EINVAL;
+			break;
+		}
+
+		if (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR) {
+			hw_error = IOMMU_TEST_INVALIDATE_FAKE_ERROR;
+		} else if (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			/* Invalidate all mock iotlb entries and ignore iotlb_id */
+			for (j = 0; j < MOCK_NESTED_DOMAIN_IOTLB_NUM; j++)
+				mock_nested->iotlb[j] = 0;
+		} else {
+			mock_nested->iotlb[inv.iotlb_id] = 0;
+		}
+
+		inv.hw_error = hw_error;
+		rc = iommu_respond_struct_to_user_array(array, i, (void *)&inv,
+							sizeof(inv));
+		if (rc)
+			break;
+
+		processed++;
+	}
+
+out:
+	array->entry_num = processed;
+	return rc;
+}
+
 static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free_nested,
 	.attach_dev = mock_domain_nop_attach,
+	.cache_invalidate_user = mock_domain_cache_invalidate_user,
 };
 
 static inline struct iommufd_hw_pagetable *
-- 
2.34.1


