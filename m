Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C586FF4D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbjEKOnF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbjEKOmd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:42:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DFC10A1C;
        Thu, 11 May 2023 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815933; x=1715351933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZEAkTT8t+vgMoK2Yq15MLDHZMzyQDBzk03KBMhHFS44=;
  b=dJ/xm5qWY2/uCAKdlsZBXM0ELQuPdrOavU+lYJwyCiBT1YF1ifu+1QZT
   ZQ1/5hxWVYHN3h2naIxi/t97AhQAWK1opLyT4YD4rysXIuJ0UvYEMYhVb
   51c4gMdJNNIvYCBannX2WigfjpSDSB0soJazXXYlvdU/K5m6X9sDgYBm2
   ft3i82XBEXPF+/OOqjnoRIDosVmsw+hOJZQ0VcAC+lXsBpcxn+ZjXj81I
   Hwd8G1k2Y649Tv0SqpAxyfOsyvJ57AjixGq2iPXrKYxUUCfiwwDC+vNqp
   PcN0pz+PwlBlSxELPECxMQZI8jOkXPvhACjzViWOnaQPwlii7WqTb8taG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="339812940"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="339812940"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730382631"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="730382631"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 07:38:51 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: [PATCH v2 08/11] iommufd/selftest: Add domain_alloc_user() support in iommu mock
Date:   Thu, 11 May 2023 07:38:41 -0700
Message-Id: <20230511143844.22693-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511143844.22693-1-yi.l.liu@intel.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Add mock_domain_alloc_user function and iommu_hwpt_selftest data structure
to support user space selftest program to allocate domains with user data.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c |  1 +
 drivers/iommu/iommufd/iommufd_test.h | 16 ++++++
 drivers/iommu/iommufd/selftest.c     | 78 +++++++++++++++++++++++++---
 include/linux/iommu.h                |  3 ++
 4 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 8206367b8d83..47ec7ddd5f5d 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -7,6 +7,7 @@
 
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
+#include "iommufd_test.h"
 
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 {
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 3f3644375bf1..e77d57dd8e25 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -109,4 +109,20 @@ struct iommu_test_hw_info {
 	__u32 test_reg;
 };
 
+/* Should not be equal to any defined value in enum iommu_hwpt_type */
+#define IOMMU_HWPT_TYPE_SELFTTEST		0xdead
+
+/**
+ * struct iommu_hwpt_selftest
+ *
+ * @flags: page table entry attributes
+ * @test_config: default iotlb setup (value IOMMU_TEST_IOTLB_DEFAULT)
+ */
+struct iommu_hwpt_selftest {
+#define IOMMU_TEST_FLAG_NESTED		(1ULL << 0)
+	__u64 flags;
+#define IOMMU_TEST_IOTLB_DEFAULT	0xbadbeef
+	__u64 test_config;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af7459e211ad..616525c5d308 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -84,7 +84,9 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 
 struct mock_iommu_domain {
 	struct iommu_domain domain;
+	struct mock_iommu_domain *parent;
 	struct xarray pfns;
+	u32 iotlb;
 };
 
 enum selftest_obj_type {
@@ -142,26 +144,69 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length)
 	return info;
 }
 
-static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+static const struct iommu_ops mock_ops;
+static struct iommu_domain_ops domain_nested_ops;
+
+static struct iommu_domain *
+__mock_domain_alloc(unsigned int iommu_domain_type,
+		    struct mock_iommu_domain *mock_parent,
+		    const struct iommu_hwpt_selftest *user_cfg)
 {
 	struct mock_iommu_domain *mock;
 
 	if (iommu_domain_type == IOMMU_DOMAIN_BLOCKED)
 		return &mock_blocking_domain;
 
-	if (WARN_ON(iommu_domain_type != IOMMU_DOMAIN_UNMANAGED))
-		return NULL;
-
 	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
 	if (!mock)
 		return NULL;
-	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
-	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+	mock->parent = mock_parent;
+	mock->domain.type = iommu_domain_type;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
-	xa_init(&mock->pfns);
+	if (mock_parent) {
+		mock->iotlb = user_cfg->test_config;
+		mock->domain.ops = &domain_nested_ops;
+	} else {
+		mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
+		mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+		mock->domain.ops = mock_ops.default_domain_ops;
+		xa_init(&mock->pfns);
+	}
 	return &mock->domain;
 }
 
+static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+{
+	if (WARN_ON(iommu_domain_type != IOMMU_DOMAIN_BLOCKED &&
+		    iommu_domain_type != IOMMU_DOMAIN_UNMANAGED))
+		return NULL;
+	return __mock_domain_alloc(IOMMU_DOMAIN_UNMANAGED, NULL, NULL);
+}
+
+static struct iommu_domain *mock_domain_alloc_user(struct device *dev,
+						   struct iommu_domain *parent,
+						   const union iommu_domain_user_data *user_data)
+{
+	const struct iommu_hwpt_selftest *user_cfg = (struct iommu_hwpt_selftest *)user_data;
+	unsigned int iommu_domain_type = IOMMU_DOMAIN_UNMANAGED;
+	struct mock_iommu_domain *mock_parent = NULL;
+
+	/* Check union iommu_domain_user_data in include/linux/iommu.h */
+	static_assert(sizeof(struct iommu_hwpt_selftest) <= 16);
+
+	if (parent) {
+		if (parent->ops != mock_ops.default_domain_ops)
+			return NULL;
+		if (!user_cfg || !(user_cfg->flags & IOMMU_TEST_FLAG_NESTED))
+			return NULL;
+		iommu_domain_type = IOMMU_DOMAIN_NESTED;
+		mock_parent = container_of(parent,
+					   struct mock_iommu_domain, domain);
+	}
+
+	return __mock_domain_alloc(iommu_domain_type, mock_parent, user_cfg);
+}
+
 static void mock_domain_free(struct iommu_domain *domain)
 {
 	struct mock_iommu_domain *mock =
@@ -290,12 +335,21 @@ static void mock_domain_set_plaform_dma_ops(struct device *dev)
 	 */
 }
 
+static int mock_domain_user_data_len(u32 hwpt_type)
+{
+	if (hwpt_type != IOMMU_HWPT_TYPE_SELFTTEST)
+		return -EOPNOTSUPP;
+	return sizeof(struct iommu_hwpt_selftest);
+};
+
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
 	.hw_info_type = IOMMU_HW_INFO_TYPE_SELFTEST,
 	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
+	.domain_alloc_user = mock_domain_alloc_user,
+	.domain_alloc_user_data_len = mock_domain_user_data_len,
 	.capable = mock_domain_capable,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
 	.default_domain_ops =
@@ -308,6 +362,11 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
+static struct iommu_domain_ops domain_nested_ops = {
+	.free = mock_domain_free,
+	.attach_dev = mock_domain_nop_attach,
+};
+
 static struct iommu_device mock_iommu_device = {
 	.ops = &mock_ops,
 };
@@ -324,7 +383,10 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
-	if (hwpt->domain->ops != mock_ops.default_domain_ops) {
+	if ((hwpt->domain->type == IOMMU_DOMAIN_UNMANAGED &&
+	     hwpt->domain->ops != mock_ops.default_domain_ops) ||
+	    (hwpt->domain->type == IOMMU_DOMAIN_NESTED &&
+	     hwpt->domain->ops != &domain_nested_ops)) {
 		iommufd_put_object(&hwpt->obj);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c2d0fa3e2e18..dff4fc2b2014 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -231,6 +231,9 @@ struct iommu_iotlb_gather {
  * include/uapi/linux/iommufd.h.
  */
 union iommu_domain_user_data {
+#ifdef CONFIG_IOMMUFD_TEST
+	__u64 test[2];
+#endif
 };
 
 /**
-- 
2.34.1

