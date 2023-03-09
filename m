Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF556B1D87
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCIILc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCIIKj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:10:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258E473035;
        Thu,  9 Mar 2023 00:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349401; x=1709885401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4TvI1XHiBlsBZES0NWLs08icFspIsJBbCUEMM8KMpcU=;
  b=HQsFQEb1fE21nbqHxXRQrwpmM4KusZ0OJ4EsrOCiTTBaGM8I/LtfRpgj
   oXAdLaOrykvmeyB5MXA5QlwleY9+61AuLsaCODeOyqYCTU68WIOq9zN8w
   +8wOUZOf3WQ6HMHWEq8S6CZUzcOmXsKi4NZhtzgRl/HxrUjjoqsQxJFgJ
   shAOUb8f8hnOizc3UHPolvrlPhvXPpJIR9PjGkeAd4oqiQYl6MVXcIszw
   /2P2ZlPtk2mqlOoA9MTjfcAV61QNUQi0NB/a9p6Sos/Bzt96pCYxW+wTp
   qQWPPK0O7FGRs/o9sHM6gCTHLmphd6iLPm97Pi9c51SLLyJGcA10BBew6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023237"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023237"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471421"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471421"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:42 -0800
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 09/12] iommufd/selftest: Add domain_alloc_user() support in iommu mock
Date:   Thu,  9 Mar 2023 00:09:07 -0800
Message-Id: <20230309080910.607396-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iommu/iommufd/device.c       |  8 +++-
 drivers/iommu/iommufd/hw_pagetable.c | 31 +++++++++++--
 drivers/iommu/iommufd/iommufd_test.h | 16 +++++++
 drivers/iommu/iommufd/selftest.c     | 67 ++++++++++++++++++++++++----
 4 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0328071dcac1..f95b558f5e95 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -322,7 +322,13 @@ int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd)
 
 	cmd->out_data_type = ops->driver_type;
 	cmd->data_len = length;
-	cmd->out_hwpt_type_bitmap = iommufd_hwpt_type_bitmaps[ops->driver_type];
+
+	if (ops->driver_type != IOMMU_HW_INFO_TYPE_SELFTEST)
+		cmd->out_hwpt_type_bitmap = iommufd_hwpt_type_bitmaps[ops->driver_type];
+#ifdef CONFIG_IOMMUFD_TEST
+	else
+		cmd->out_hwpt_type_bitmap = U64_MAX; // Pretend to support all types
+#endif
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 160712256c64..0871da848447 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -7,6 +7,7 @@
 
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
+#include "iommufd_test.h"
 
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 {
@@ -181,6 +182,18 @@ const u64 iommufd_hwpt_type_bitmaps[] =  {
 	[IOMMU_HW_INFO_TYPE_DEFAULT] = BIT_ULL(IOMMU_HWPT_TYPE_DEFAULT),
 };
 
+/* Return true if type is supported, otherwise false */
+static inline bool
+iommufd_hwpt_type_check(enum iommu_hw_info_type driver_type,
+			enum iommu_hwpt_type type)
+{
+	if (WARN_ON(driver_type >= ARRAY_SIZE(iommufd_hwpt_type_bitmaps)))
+		return false;
+
+	return ((1 << type) &
+			iommufd_hwpt_type_bitmaps[driver_type]);
+}
+
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
@@ -191,6 +204,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	const struct iommu_ops *ops;
 	void *data = NULL;
 	u32 driver_type, klen;
+	bool support;
 	int rc;
 
 	if (cmd->__reserved || cmd->flags)
@@ -209,9 +223,13 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	driver_type = ops->driver_type;
 
 	/* data_type should be a supported type by the driver */
-	if (WARN_ON(driver_type >= ARRAY_SIZE(iommufd_hwpt_type_bitmaps)) ||
-	    !((1 << cmd->data_type) &
-			iommufd_hwpt_type_bitmaps[driver_type])) {
+	if (driver_type != IOMMU_HW_INFO_TYPE_SELFTEST)
+		support = iommufd_hwpt_type_check(driver_type, cmd->data_type);
+#ifdef CONFIG_IOMMUFD_TEST
+	else
+		support = true; /* selftest pretend to support all types */
+#endif
+	if (!support) {
 		rc = -EINVAL;
 		goto out_put_idev;
 	}
@@ -250,7 +268,12 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_put_pt;
 	}
 
-	klen = iommufd_hwpt_alloc_data_size[cmd->data_type];
+	if (cmd->data_type != IOMMU_HWPT_TYPE_SELFTTEST)
+		klen = iommufd_hwpt_alloc_data_size[cmd->data_type];
+#ifdef CONFIG_IOMMUFD_TEST
+	else
+		klen = sizeof(struct iommu_hwpt_selftest);
+#endif
 	if (klen) {
 		if (!cmd->data_len) {
 			rc = -EINVAL;
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 578691602d94..8bbb4f4fa1d7 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -115,4 +115,20 @@ struct iommu_hw_info_selftest {
 	__u32 test_reg;
 };
 
+/* Should not be equal to any defined value in enum iommu_hwpt_type */
+#define IOMMU_HWPT_TYPE_SELFTTEST	0xbadbeef
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
index b50ec3528ec1..b9c7f3bf64b5 100644
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
@@ -142,26 +144,66 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length)
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
+						   const void *user_data)
+{
+	const struct iommu_hwpt_selftest *user_cfg = user_data;
+	struct mock_iommu_domain *mock_parent = NULL;
+	unsigned int iommu_domain_type = IOMMU_DOMAIN_UNMANAGED;
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
@@ -296,6 +338,7 @@ static const struct iommu_ops mock_ops = {
 	.driver_type = IOMMU_HW_INFO_TYPE_SELFTEST,
 	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
+	.domain_alloc_user = mock_domain_alloc_user,
 	.capable = mock_domain_capable,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
 	.default_domain_ops =
@@ -308,6 +351,11 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
+static struct iommu_domain_ops domain_nested_ops = {
+	.free = mock_domain_free,
+	.attach_dev = mock_domain_nop_attach,
+};
+
 struct iommu_device mock_iommu_device = {
 	.ops = &mock_ops,
 };
@@ -324,7 +372,10 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
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

