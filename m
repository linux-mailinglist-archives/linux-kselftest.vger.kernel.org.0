Return-Path: <linux-kselftest+bounces-2831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F9482A6D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 05:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72B81F21179
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 04:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CD08F62;
	Thu, 11 Jan 2024 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5YZxkBb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF746139;
	Thu, 11 Jan 2024 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704946228; x=1736482228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jR0MOQ0kqVSVT6BksVmkq7HuXTI6cH5F4jkXr2f/2Kg=;
  b=e5YZxkBbbPGlNJfrm3fZHvnI2HlnrNbr5pf8sGd/uxjsQsPxPLr7SePe
   tlXQbQNr+qkSe/8l59BYOJnMRCEu9Coo2a2L1I4pKVURoPfMVN9iOuSX+
   p9ESdCUtAiLntpaRials0aJ4q+1UrSMbgAu7Y9fkaX1RxKOL45yJ290CH
   7b2v49d44vg8w3QvHvvndbUYuN+sIM2GfGRUJZbWwEoKEncYjhioCwl7Z
   FyIu2yuqq2wYRYLiWt9GQJmGnYW8fvfI4s4mQYTxPS+zQkTLKgAIK66Lx
   VpzEctFUGNVzrG/8CIsgnC7Igl2Sb+h39raAOLMDHRHhkKEe4YXGJ9HXw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389167653"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389167653"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 20:10:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113691862"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1113691862"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2024 20:10:26 -0800
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
	j.granados@samsung.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v11 4/8] iommufd/selftest: Add mock_domain_cache_invalidate_user support
Date: Wed, 10 Jan 2024 20:10:11 -0800
Message-Id: <20240111041015.47920-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111041015.47920-1-yi.l.liu@intel.com>
References: <20240111041015.47920-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/iommufd_test.h | 18 ++++++++++
 drivers/iommu/iommufd/selftest.c     | 50 ++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 7910fbe1962d..09dfc8aa65c4 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -148,4 +148,22 @@ struct iommu_hwpt_selftest {
 	__u32 iotlb;
 };
 
+/* Should not be equal to any defined value in enum iommu_hwpt_invalidate_data_type */
+#define IOMMU_HWPT_INVALIDATE_DATA_SELFTEST 0xdeadbeef
+#define IOMMU_HWPT_INVALIDATE_DATA_SELFTEST_INVALID 0xdadbeef
+
+/**
+ * struct iommu_hwpt_invalidate_selftest - Invalidation data for Mock driver
+ *                                         (IOMMU_HWPT_INVALIDATE_DATA_SELFTEST)
+ * @flags: Invalidate flags
+ * @iotlb_id: Invalidate iotlb entry index
+ *
+ * If IOMMU_TEST_INVALIDATE_ALL is set in @flags, @iotlb_id will be ignored
+ */
+struct iommu_hwpt_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_FLAG_ALL	(1 << 0)
+	__u32 flags;
+	__u32 iotlb_id;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 022ef8f55088..23879135d1c3 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -473,9 +473,59 @@ static void mock_domain_free_nested(struct iommu_domain *domain)
 	kfree(mock_nested);
 }
 
+static int
+mock_domain_cache_invalidate_user(struct iommu_domain *domain,
+				  struct iommu_user_data_array *array)
+{
+	struct mock_iommu_domain_nested *mock_nested =
+		container_of(domain, struct mock_iommu_domain_nested, domain);
+	struct iommu_hwpt_invalidate_selftest inv;
+	u32 processed = 0;
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
+						       i, iotlb_id);
+		if (rc)
+			break;
+
+		if (inv.flags & ~IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			rc = -EOPNOTSUPP;
+			break;
+		}
+
+		if (inv.iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX) {
+			rc = -EINVAL;
+			break;
+		}
+
+		if (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			/* Invalidate all mock iotlb entries and ignore iotlb_id */
+			for (j = 0; j < MOCK_NESTED_DOMAIN_IOTLB_NUM; j++)
+				mock_nested->iotlb[j] = 0;
+		} else {
+			mock_nested->iotlb[inv.iotlb_id] = 0;
+		}
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


