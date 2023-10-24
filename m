Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C017C7D54DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjJXPKg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjJXPKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:10:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7721210F7;
        Tue, 24 Oct 2023 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698160206; x=1729696206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gNGCnNDGdTQFs9gXbPTF7NHqDllgZWxNgdtOO6a+rHc=;
  b=OvS8UH33Rs+5fo8/5tTRX6jqORT7zAZNzstK96CAhyGGdEx7YyvNjjWo
   Mfr5ZcnvtCQlHFnzNuzLryCzY7gQ5wo3HId0AX57qH0Xwy6w4T1dStD9n
   sICQRNbzwpdBdiot6IgxwLkjQmJcrnOp0NU65hI7tyihoH+affWPpqha/
   /MqurWW+qYmTr+rxM1viQdoIZXCPTwFBNEgqb4Rf6INopz8ZnX4llzNp9
   ndDjLre6K6vcsxiz9MWoAHqJqNQQJ5lQPFjE5L/Kh0SOgonaw80VubXag
   KlciDRO74s4muFKRP9gYu3bFItpok5Uq1BwIj/Y1lWH+hccY1UaDwoGAW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418203124"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418203124"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6486196"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 08:06:24 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v6 09/10] iommufd/selftest: Add nested domain allocation for mock domain
Date:   Tue, 24 Oct 2023 08:06:08 -0700
Message-Id: <20231024150609.46884-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024150609.46884-1-yi.l.liu@intel.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iommu/iommufd/selftest.c     | 150 +++++++++++++++++++++------
 2 files changed, 138 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1f2e93d3d4e8..cf7d999a55bb 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -46,6 +46,11 @@ enum {
 	MOCK_FLAGS_DEVICE_NO_DIRTY = 1 << 0,
 };
 
+enum {
+	MOCK_NESTED_DOMAIN_IOTLB_ID_MAX = 3,
+	MOCK_NESTED_DOMAIN_IOTLB_NUM = 4,
+};
+
 struct iommu_test_cmd {
 	__u32 size;
 	__u32 op;
@@ -130,4 +135,17 @@ struct iommu_test_hw_info {
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
index d71007234896..bf9a88193367 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -93,6 +93,12 @@ struct mock_iommu_domain {
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
@@ -217,54 +223,97 @@ const struct iommu_dirty_ops dirty_ops = {
 };
 
 static const struct iommu_ops mock_ops;
+static struct iommu_domain_ops domain_nested_ops;
 
-static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+static struct iommu_domain *
+__mock_domain_alloc_paging(unsigned int iommu_domain_type, bool needs_dirty_ops)
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
 	mock->domain.ops = mock_ops.default_domain_ops;
+	if (needs_dirty_ops)
+		mock->domain.dirty_ops = &dirty_ops;
 	mock->domain.type = iommu_domain_type;
 	xa_init(&mock->pfns);
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
+	domain = __mock_domain_alloc_paging(iommu_domain_type, false);
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
-	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
-	struct iommu_domain *domain;
+	struct mock_iommu_domain *mock_parent;
+	struct iommu_hwpt_selftest user_cfg;
+	int rc;
 
-	if (flags &
-	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
-		return ERR_PTR(-EOPNOTSUPP);
+	if (!user_data) {	/* must be mock_domain */
+		struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+		bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+		bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
+
+		if (parent)
+			return ERR_PTR(-EINVAL);
+		if (has_dirty_flag && no_dirty_ops)
+			return ERR_PTR(-EOPNOTSUPP);
+		return __mock_domain_alloc_paging(IOMMU_DOMAIN_UNMANAGED,
+						  has_dirty_flag);
+	}
 
-	if (parent || user_data)
+	/* must be mock_domain_nested */
+	if (user_data->type != IOMMU_HWPT_DATA_SELFTEST)
 		return ERR_PTR(-EOPNOTSUPP);
+	if (!parent || parent->ops != mock_ops.default_domain_ops)
+		return ERR_PTR(-EINVAL);
 
-	if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
-	    (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
-		return ERR_PTR(-EOPNOTSUPP);
+	mock_parent = container_of(parent, struct mock_iommu_domain, domain);
+	if (!mock_parent)
+		return ERR_PTR(-EINVAL);
 
-	domain = mock_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
-	if (domain && !(mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
-		domain->dirty_ops = &dirty_ops;
-	if (!domain)
-		domain = ERR_PTR(-ENOMEM);
-	return domain;
+	rc = iommu_copy_struct_from_user(&user_cfg, user_data,
+					 IOMMU_HWPT_DATA_SELFTEST, iotlb);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return __mock_domain_alloc_nested(mock_parent, &user_cfg);
 }
 
 static void mock_domain_free(struct iommu_domain *domain)
@@ -434,19 +483,41 @@ static const struct iommu_ops mock_ops = {
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
@@ -454,6 +525,25 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
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

