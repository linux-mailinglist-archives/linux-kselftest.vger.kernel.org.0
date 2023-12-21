Return-Path: <linux-kselftest+bounces-2304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E2381BB0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 16:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978321C23181
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1958221;
	Thu, 21 Dec 2023 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqIiSMoA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41D55E5F;
	Thu, 21 Dec 2023 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703173196; x=1734709196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g3oInV4xZqbUIJph4BflylXAOJh+ZW7UcR+m2wfhdaE=;
  b=XqIiSMoArXe9NVMY8BK+A+DSmJTsFT1ilawpE65Up5mTJktND64FnC3o
   3Sr6tZcjm5DV4NT3ELEnA3NsR2rpk6glspZFVefeSKI1XWfxkpGRWFX6d
   MaxszWLvSlhCMFhfR27rZj2oIxgUd0F3muv6uVxYWDkkLGKm/44RAhUg2
   tVGiGPoB8g+q/Ff+kvBrH9GUDcjGEjVe7RGYc1ftMQAtmyGyfZus2Uk+4
   jwVcX4/HOQSyBDVNI+ME1KNXSL15jJxoobx/kj7VGWc37l3ygGOuHgSNm
   YcCR8H4zaNea2xWFsFArZHmHi5ixPxYz3kAh1Uv/51kaGKbt/yW/OeXmk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393155524"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="393155524"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:39:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="949957247"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="949957247"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2023 07:39:53 -0800
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
Subject: [PATCH v7 4/9] iommufd/selftest: Add mock_domain_cache_invalidate_user support
Date: Thu, 21 Dec 2023 07:39:43 -0800
Message-Id: <20231221153948.119007-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221153948.119007-1-yi.l.liu@intel.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
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

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 34 ++++++++++++++
 drivers/iommu/iommufd/selftest.c     | 67 ++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 7910fbe1962d..15dd74d361f9 100644
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
+ * enum iommu_hwpt_invalidate_selftest_result_code - Result of invalidation
+ * @IOMMU_TEST_INVALIDATE_SUCC: Success
+ * @IOMMU_TEST_INVALIDATE_FAKE_ERROR: Fake error per test program's request
+ */
+enum iommu_hwpt_invalidate_selftest_result_code {
+	IOMMU_TEST_INVALIDATE_SUCC,
+	IOMMU_TEST_INVALIDATE_FAKE_ERROR,
+};
+
+/**
+ * struct iommu_hwpt_invalidate_selftest
+ *
+ * @flags: Invalidate flags
+ * @iotlb_id: Invalidate iotlb entry index
+ * @code: One of enum iommu_hwpt_invalidate_selftest_result_code
+ * @__reserved: Must be 0
+ *
+ * If IOMMU_TEST_INVALIDATE_ALL is set in @flags, @iotlb_id will be ignored
+ * @code meaningful only if the request is processed successfully.
+ */
+struct iommu_hwpt_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_FLAG_ALL	(1ULL << 0)
+#define IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR	(1ULL << 1)
+	__u32 flags;
+	__u32 iotlb_id;
+	__u32 code;
+	__u32 __reserved;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 022ef8f55088..0eb4e7a05f4a 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -473,9 +473,76 @@ static void mock_domain_free_nested(struct iommu_domain *domain)
 	kfree(mock_nested);
 }
 
+static int
+mock_domain_cache_invalidate_user(struct iommu_domain *domain,
+				  struct iommu_user_data_array *array)
+{
+	struct mock_iommu_domain_nested *mock_nested =
+		container_of(domain, struct mock_iommu_domain_nested, domain);
+	u32 error_code = IOMMU_TEST_INVALIDATE_SUCC, processed = 0;
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
+		if ((inv.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) &&
+		    (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR)) {
+			rc = -EINVAL;
+			break;
+		}
+
+		if (inv.iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX) {
+			rc = -EINVAL;
+			break;
+		}
+
+		if (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR) {
+			error_code = IOMMU_TEST_INVALIDATE_FAKE_ERROR;
+		} else if (inv.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			/* Invalidate all mock iotlb entries and ignore iotlb_id */
+			for (j = 0; j < MOCK_NESTED_DOMAIN_IOTLB_NUM; j++)
+				mock_nested->iotlb[j] = 0;
+		} else {
+			mock_nested->iotlb[inv.iotlb_id] = 0;
+		}
+
+		/* error code only cover mock iommu errors */
+		inv.code = error_code;
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


