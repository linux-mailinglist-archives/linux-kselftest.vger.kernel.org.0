Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9A7AA0D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjIUUtb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 16:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjIUUso (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 16:48:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB621172B;
        Thu, 21 Sep 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318596; x=1726854596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1YqrkwhCam53zwwuki+BzVJ5pD4pOMGdr/+tuWqbeU8=;
  b=hz7Ny9y+A34sYV+yOe6hDFQLqYCEip17cBxqCWPrU8cag1puXRZPKekg
   cYU25I2gYb2VWcZMPogquT/R+J7vTy0FEzRHF7Cl9KM54L9oPTN/w7IlC
   fGfZv/cZMz3DeuA8sVZ17aHxP5LSptmpJKDS1+eoVAPnrAbfD0TiVjFZQ
   UXBcCWiDc2wcNqPMaV7WRiV2Ymd0tRhO+ixPIb0BpvL7SGGIZY7SQLHwd
   HNKpbvdNyEMJfkhchyq+A57+118xOZ6hf3nWHzn8FZoXJxCX6HDsEaqA8
   /Qkqg43OtGNdhLJkGw0lLNJWak8zQCP0A0NtIxblNtSmnYEimd3uLeQTa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832949"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832949"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649578"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649578"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:17 -0700
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
Subject: [PATCH v4 13/17] iommufd/selftest: Add nested domain allocation for mock domain
Date:   Thu, 21 Sep 2023 00:51:34 -0700
Message-Id: <20230921075138.124099-14-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Add nested domain support in the ->domain_alloc_user op with some proper
sanity checks. Then, add a domain_nested_ops for all nested domains.

Also, add an iotlb as a testing property of a nested domain. A following
patch will verify its value for the success of a nested domain allocation
and a cache invalidation request.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  18 +++++
 drivers/iommu/iommufd/selftest.c     | 114 ++++++++++++++++++++++++---
 2 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 3f3644375bf1..7f997234a1a8 100644
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
 
+/* Should not be equal to any defined value in enum iommu_hwpt_type */
+#define IOMMU_HWPT_TYPE_SELFTEST		0xdead
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
index 2205a552e570..bd967317927f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -88,6 +88,17 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 struct mock_iommu_domain {
 	struct iommu_domain domain;
 	struct xarray pfns;
+	bool nested : 1;
+	/* mock domain test data */
+	union {
+		struct { /* nested */
+			struct mock_iommu_domain *parent;
+			u32 iotlb[MOCK_NESTED_DOMAIN_IOTLB_NUM];
+		};
+		struct { /* parent */
+			enum iommu_hwpt_type hwpt_type;
+		};
+	};
 };
 
 enum selftest_obj_type {
@@ -147,8 +158,12 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length, u32 *type)
 }
 
 static const struct iommu_ops mock_ops;
+static struct iommu_domain_ops domain_nested_ops;
 
-static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+static struct iommu_domain *
+__mock_domain_alloc_kernel(unsigned int iommu_domain_type,
+			   struct mock_iommu_domain *dummy,
+			   const struct iommu_hwpt_selftest *user_cfg)
 {
 	struct mock_iommu_domain *mock;
 
@@ -156,11 +171,11 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 		return &mock_blocking_domain;
 
 	if (iommu_domain_type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
 	if (!mock)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
 	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
@@ -170,18 +185,91 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 	return &mock->domain;
 }
 
+static struct iommu_domain *
+__mock_domain_alloc_nested(unsigned int iommu_domain_type,
+			   struct mock_iommu_domain *mock_parent,
+			   const struct iommu_hwpt_selftest *user_cfg)
+{
+	struct mock_iommu_domain *mock;
+	int i;
+
+	if (iommu_domain_type != IOMMU_DOMAIN_NESTED)
+		return ERR_PTR(-EINVAL);
+
+	if (!user_cfg)
+		return ERR_PTR(-EINVAL);
+
+	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
+	if (!mock)
+		return ERR_PTR(-ENOMEM);
+	mock->nested = true;
+	mock->parent = mock_parent;
+	mock->domain.type = iommu_domain_type;
+	mock->domain.ops = &domain_nested_ops;
+	for (i = 0; i < MOCK_NESTED_DOMAIN_IOTLB_NUM; i++)
+		mock->iotlb[i] = user_cfg->iotlb;
+	return &mock->domain;
+}
+
+static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+{
+	struct iommu_domain *domain;
+
+	if (iommu_domain_type != IOMMU_DOMAIN_BLOCKED &&
+	    iommu_domain_type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+	domain = __mock_domain_alloc_kernel(iommu_domain_type, NULL, NULL);
+	if (IS_ERR(domain))
+		domain = NULL;
+	return domain;
+}
+
 static struct iommu_domain *
 mock_domain_alloc_user(struct device *dev, u32 flags,
 		       enum iommu_hwpt_type hwpt_type,
 		       struct iommu_domain *parent,
 		       const struct iommu_user_data *user_data)
 {
-	struct iommu_domain *domain;
+	struct iommu_domain *(*alloc_fn)(unsigned int iommu_domain_type,
+					 struct mock_iommu_domain *mock_parent,
+					 const struct iommu_hwpt_selftest *user_cfg);
+	unsigned int iommu_domain_type = IOMMU_DOMAIN_UNMANAGED;
+	struct iommu_hwpt_selftest data, *user_cfg = NULL;
+	struct mock_iommu_domain *mock_parent = NULL;
+	size_t min_len, data_len;
+
+	switch (hwpt_type) {
+	case IOMMU_HWPT_TYPE_DEFAULT:
+		if (user_data || parent)
+			return ERR_PTR(-EINVAL);
+		min_len = data_len = 0;
+		alloc_fn = __mock_domain_alloc_kernel;
+		break;
+	default:
+		/* IOMMU_HWPT_TYPE_SELFTEST cannot be a case for a big value */
+		if (hwpt_type != IOMMU_HWPT_TYPE_SELFTEST)
+			return ERR_PTR(-EINVAL);
+		if (!user_data || !parent ||
+		    parent->ops != mock_ops.default_domain_ops)
+			return ERR_PTR(-EINVAL);
+		iommu_domain_type = IOMMU_DOMAIN_NESTED;
+		mock_parent = container_of(parent,
+					   struct mock_iommu_domain, domain);
+		min_len = offsetofend(struct iommu_hwpt_selftest, iotlb);
+		data_len = sizeof(struct iommu_hwpt_selftest);
+		alloc_fn = __mock_domain_alloc_nested;
+		break;
+	}
 
-	domain = mock_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
-	if (!domain)
-		domain = ERR_PTR(-ENOMEM);
-	return domain;
+	if (user_data) {
+		int rc = iommu_copy_user_data(&data, user_data,
+					      data_len, min_len);
+		if (rc)
+			return ERR_PTR(rc);
+		user_cfg = &data;
+	}
+
+	return alloc_fn(iommu_domain_type, mock_parent, user_cfg);
 }
 
 static void mock_domain_free(struct iommu_domain *domain)
@@ -340,6 +428,11 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
+static struct iommu_domain_ops domain_nested_ops = {
+	.free = mock_domain_free,
+	.attach_dev = mock_domain_nop_attach,
+};
+
 static inline struct iommufd_hw_pagetable *
 get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 		 struct mock_iommu_domain **mock)
@@ -352,7 +445,10 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
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
-- 
2.34.1

