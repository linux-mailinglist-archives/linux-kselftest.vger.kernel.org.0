Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31197D0B6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376777AbjJTJUe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376689AbjJTJUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:20:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF63D10C9;
        Fri, 20 Oct 2023 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793606; x=1729329606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WecaBkjQIRXL/SAH1O7c8IdbUV3/1HB1OkZaHJ7DeYY=;
  b=GHu3mM1I7QXKQ2uD1BsQftU2RxgCJDqdKvtUVRhPgULDqreQ2gq4v6YD
   sKzmuy/jFYt7VY1lsbcDh+1iUz3VS2bQL7yD0Z1EAq9e+xLEgc8YnyuYt
   UwhzLqwiVY7ZgPN9fMbJhfbmsqLsREOLX0DEjQk9Yq5bapmyUoIJt/R3D
   3JpkilMC4aydYgYjLsEX/ggS518nm4L9A0qY/WkzedYUTg3QuV+yRF3Yj
   eMlYRn49dXkVZ//Gz9X9VLjQ/9wx9tkS3Beled5+NYsdkeoJc9gFJsaLI
   2yMbrRb89TYownh1Vt9uHmRjOPXn+J/PhvX64p/IWfM9fwqXkaQdVOfvt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366693443"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366693443"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707179478"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707179478"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:20:03 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com
Subject: [PATCH v5 09/10] iommufd/selftest: Add nested domain allocation for mock domain
Date:   Fri, 20 Oct 2023 02:19:45 -0700
Message-Id: <20231020091946.12173-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020091946.12173-1-yi.l.liu@intel.com>
References: <20231020091946.12173-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Add nested domain support in the ->domain_alloc_user op with some proper
sanity checks. Then, add a domain_nested_ops for all nested domains and
split the get_md_pagetable helper into paging and nested helpers.

Also, add an iotlb as a testing property of a nested domain.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  18 ++++
 drivers/iommu/iommufd/selftest.c     | 135 +++++++++++++++++++++++----
 2 files changed, 133 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 3f3644375bf1..440ec3d64099 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -40,6 +40,11 @@ enum {
 	MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES = 1 << 0,
 };
 
+enum {
+	MOCK_NESTED_DOMAIN_IOTLB_ID_MAX = 3,
+	MOCK_NESTED_DOMAIN_IOTLB_NUM = 4,
+};
+
 struct iommu_test_cmd {
 	__u32 size;
 	__u32 op;
@@ -109,4 +114,17 @@ struct iommu_test_hw_info {
 	__u32 test_reg;
 };
 
+/* Should not be equal to any defined value in enum iommu_hwpt_data_type */
+#define IOMMU_HWPT_DATA_SELFTEST	0xdead
+
+/**
+ * struct iommu_hwpt_selftest
+ *
+ * @iotlb: default mock iotlb value, IOMMU_TEST_IOTLB_DEFAULT
+ */
+struct iommu_hwpt_selftest {
+#define IOMMU_TEST_IOTLB_DEFAULT	0xbadbeef
+	__u32 iotlb;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index eca5b1d0919d..5f513c5d6876 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -90,6 +90,12 @@ struct mock_iommu_domain {
 	struct xarray pfns;
 };
 
+struct mock_iommu_domain_nested {
+	struct iommu_domain domain;
+	struct mock_iommu_domain *parent;
+	u32 iotlb[MOCK_NESTED_DOMAIN_IOTLB_NUM];
+};
+
 enum selftest_obj_type {
 	TYPE_IDEV,
 };
@@ -147,20 +153,16 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length, u32 *type)
 }
 
 static const struct iommu_ops mock_ops;
+static struct iommu_domain_ops domain_nested_ops;
 
-static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+static struct iommu_domain *
+__mock_domain_alloc_paging(unsigned int iommu_domain_type)
 {
 	struct mock_iommu_domain *mock;
 
-	if (iommu_domain_type == IOMMU_DOMAIN_BLOCKED)
-		return &mock_blocking_domain;
-
-	if (iommu_domain_type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
-
 	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
 	if (!mock)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
 	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
@@ -170,20 +172,72 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 	return &mock->domain;
 }
 
+static struct iommu_domain *
+__mock_domain_alloc_nested(struct mock_iommu_domain *mock_parent,
+			   const struct iommu_hwpt_selftest *user_cfg)
+{
+	struct mock_iommu_domain_nested *mock_nested;
+	int i;
+
+	mock_nested = kzalloc(sizeof(*mock_nested), GFP_KERNEL);
+	if (!mock_nested)
+		return ERR_PTR(-ENOMEM);
+	mock_nested->parent = mock_parent;
+	mock_nested->domain.ops = &domain_nested_ops;
+	mock_nested->domain.type = IOMMU_DOMAIN_NESTED;
+	for (i = 0; i < MOCK_NESTED_DOMAIN_IOTLB_NUM; i++)
+		mock_nested->iotlb[i] = user_cfg->iotlb;
+	return &mock_nested->domain;
+}
+
+static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+{
+	struct iommu_domain *domain;
+
+	if (iommu_domain_type == IOMMU_DOMAIN_BLOCKED)
+		return &mock_blocking_domain;
+	if (iommu_domain_type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+	domain = __mock_domain_alloc_paging(iommu_domain_type);
+	if (IS_ERR(domain))
+		domain = NULL;
+	return domain;
+}
+
 static struct iommu_domain *
 mock_domain_alloc_user(struct device *dev, u32 flags,
 		       struct iommu_domain *parent,
 		       const struct iommu_user_data *user_data)
 {
-	struct iommu_domain *domain;
+	struct mock_iommu_domain *mock_parent;
+	struct iommu_hwpt_selftest user_cfg;
+	int rc;
 
 	if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	domain = mock_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
-	if (!domain)
-		domain = ERR_PTR(-ENOMEM);
-	return domain;
+	if (!user_data) {	/* must be mock_domain */
+		if (parent)
+			return ERR_PTR(-EINVAL);
+		return __mock_domain_alloc_paging(IOMMU_DOMAIN_UNMANAGED);
+	}
+
+	/* must be mock_domain_nested */
+	if (user_data->type != IOMMU_HWPT_DATA_SELFTEST)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!parent || parent->ops != mock_ops.default_domain_ops)
+		return ERR_PTR(-EINVAL);
+
+	mock_parent = container_of(parent, struct mock_iommu_domain, domain);
+	if (!mock_parent)
+		return ERR_PTR(-EINVAL);
+
+	rc = iommu_copy_struct_from_user(&user_cfg, user_data,
+					 IOMMU_HWPT_DATA_SELFTEST, iotlb);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return __mock_domain_alloc_nested(mock_parent, &user_cfg);
 }
 
 static void mock_domain_free(struct iommu_domain *domain)
@@ -342,19 +396,41 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
+static void mock_domain_free_nested(struct iommu_domain *domain)
+{
+	struct mock_iommu_domain_nested *mock_nested =
+		container_of(domain, struct mock_iommu_domain_nested, domain);
+
+	kfree(mock_nested);
+}
+
+static struct iommu_domain_ops domain_nested_ops = {
+	.free = mock_domain_free_nested,
+	.attach_dev = mock_domain_nop_attach,
+};
+
 static inline struct iommufd_hw_pagetable *
-get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
-		 struct mock_iommu_domain **mock)
+__get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id, u32 hwpt_type)
 {
-	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_object *obj;
 
-	obj = iommufd_get_object(ucmd->ictx, mockpt_id,
-				 IOMMUFD_OBJ_HWPT_PAGING);
+	obj = iommufd_get_object(ucmd->ictx, mockpt_id, hwpt_type);
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
-	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
-	if (hwpt->domain->ops != mock_ops.default_domain_ops) {
+	return container_of(obj, struct iommufd_hw_pagetable, obj);
+}
+
+static inline struct iommufd_hw_pagetable *
+get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
+		 struct mock_iommu_domain **mock)
+{
+	struct iommufd_hw_pagetable *hwpt;
+
+	hwpt = __get_md_pagetable(ucmd, mockpt_id, IOMMUFD_OBJ_HWPT_PAGING);
+	if (IS_ERR(hwpt))
+		return hwpt;
+	if (hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED ||
+	    hwpt->domain->ops != mock_ops.default_domain_ops) {
 		iommufd_put_object(&hwpt->obj);
 		return ERR_PTR(-EINVAL);
 	}
@@ -362,6 +438,25 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	return hwpt;
 }
 
+static inline struct iommufd_hw_pagetable *
+get_md_pagetable_nested(struct iommufd_ucmd *ucmd, u32 mockpt_id,
+			struct mock_iommu_domain_nested **mock_nested)
+{
+	struct iommufd_hw_pagetable *hwpt;
+
+	hwpt = __get_md_pagetable(ucmd, mockpt_id, IOMMUFD_OBJ_HWPT_NESTED);
+	if (IS_ERR(hwpt))
+		return hwpt;
+	if (hwpt->domain->type != IOMMU_DOMAIN_NESTED ||
+	    hwpt->domain->ops != &domain_nested_ops) {
+		iommufd_put_object(&hwpt->obj);
+		return ERR_PTR(-EINVAL);
+	}
+	*mock_nested = container_of(hwpt->domain,
+				    struct mock_iommu_domain_nested, domain);
+	return hwpt;
+}
+
 struct mock_bus_type {
 	struct bus_type bus;
 	struct notifier_block nb;
-- 
2.34.1

