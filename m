Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9757768FF58
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjBIEfj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBIEeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:34:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD514FCCA;
        Wed,  8 Feb 2023 20:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917176; x=1707453176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2GoeRKmjgxpi25WPV05lJfCSbw3rqCdg+3MaXjTvzM4=;
  b=F1NWxFlBHLe9rLWlhv63FdItjCJXJT0bmJfYss88kFX7rFs9Osvbgfxw
   bykE9WbAMq939wWCAxHW9q5noh7FbKL5mwv5cKsbG75nBWL7N7QiSqXge
   q5HvtKRPdaEyBGv3QNnT2vtMRXFb00FYqatVTyMO/K0xd4SLsuwr2FNrP
   s+HVo+73s6h5DTWqfigcJ81597V10yhdTGLKUvjF3VmALLDsb/Tot3azn
   F+4CpoUAScCf34V8lLyOxouMYW21RnbExwCoSUiz3IqvJk7T/D6QKeaC4
   QKrcsn9ODQBCfrs/zwR43GCsTSXdjyqEaLEGouHhCgUKdv4QQPj5mX5Wv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298867"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298867"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447613"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447613"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:25 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: [PATCH 15/17] iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC ioctl
Date:   Wed,  8 Feb 2023 20:31:51 -0800
Message-Id: <20230209043153.14964-16-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
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

This allows to allocate hwpt for mock device to check the IOMMU_HWPT_ALLOC
in selftest.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c                |   2 +-
 drivers/iommu/iommufd/hw_pagetable.c          |  28 ++++-
 drivers/iommu/iommufd/iommufd_test.h          |  16 +++
 drivers/iommu/iommufd/selftest.c              |  42 ++++++-
 tools/testing/selftests/iommu/iommufd.c       | 116 +++++++++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  68 ++++++++++
 6 files changed, 266 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index bf803975062c..ea5691468740 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -228,7 +228,7 @@ int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
 		cmd->out_pgtbl_type_bitmap = iommufd_supported_pgtbl_types[ops->driver_type];
 #ifdef CONFIG_IOMMUFD_TEST
 	else
-		cmd->out_pgtbl_type_bitmap = 0;
+		cmd->out_pgtbl_type_bitmap = U64_MAX; // Pretend to support all types
 #endif
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 44a75ccc8e08..1f1940969b2b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -5,6 +5,7 @@
 #include <linux/iommu.h>
 
 #include "iommufd_private.h"
+#include "iommufd_test.h"
 
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 {
@@ -111,6 +112,15 @@ static const size_t iommufd_hwpt_info_size[] = {
 	[IOMMU_PGTBL_DATA_VTD_S1] = sizeof(struct iommu_hwpt_intel_vtd),
 };
 
+/* Return true if type is supported, otherwise false */
+static inline bool
+iomufd_hwpt_type_check(enum iommu_device_data_type driver_type,
+		       enum iommu_pgtbl_data_type type)
+{
+	return ((1 << type) &
+			iommufd_supported_pgtbl_types[driver_type]);
+}
+
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommufd_hw_pagetable *hwpt, *parent = NULL;
@@ -124,6 +134,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	void *data = NULL;
 	u32 driver_type, klen;
 	int rc;
+	bool support;
 
 	if (cmd->__reserved || cmd->flags)
 		return -EOPNOTSUPP;
@@ -148,8 +159,14 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	driver_type = ops->driver_type;
 
 	/* data_type should be a supported type by the hardware */
-	if (!((1 << cmd->data_type) &
-			iommufd_supported_pgtbl_types[driver_type])) {
+	if (cmd->data_type != IOMMU_PGTBL_DATA_SELFTTEST)
+		support = iomufd_hwpt_type_check(driver_type,
+						 cmd->data_type);
+#ifdef CONFIG_IOMMUFD_TEST
+	else
+		support = true; /* selftest pretend to support all types */
+#endif
+	if (!support) {
 		rc = -EINVAL;
 		goto out_put_dev;
 	}
@@ -182,7 +199,12 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_put_pt;
 	}
 
-	klen = iommufd_hwpt_info_size[cmd->data_type];
+	if (cmd->data_type != IOMMU_PGTBL_DATA_SELFTTEST)
+		klen = iommufd_hwpt_info_size[cmd->data_type];
+#ifdef CONFIG_IOMMUFD_TEST
+	else
+		klen = sizeof(struct iommu_hwpt_selftest);
+#endif
 	if (klen) {
 		if (!cmd->data_len) {
 			rc = -EINVAL;
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index a73ab51afe79..842b81397a2a 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -114,4 +114,20 @@ struct iommu_device_info_selftest {
 	__u32 test_reg;
 };
 
+/* Should not be equal to any defined value in enum iommu_pgtbl_data_type */
+#define IOMMU_PGTBL_DATA_SELFTTEST	0xbadbeef
+
+/**
+ * struct iommu_hwpt_selftest
+ *
+ * @flags: page table entry attributes
+ * @test_config: default iotlb setup (value IOMMU_TEST_IOTLB_DEFAULT)
+ */
+struct iommu_hwpt_selftest {
+#define IOMMU_TEST_FLAG_NESTED		(1 << 0)
+	__u64 flags;
+#define IOMMU_TEST_IOTLB_DEFAULT	0xbadbeef
+	__u64 test_config;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 3623a42648d5..354a0054afad 100644
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
@@ -119,6 +121,8 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length)
 	return info;
 }
 
+static const struct iommu_ops mock_ops;
+
 static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 {
 	struct mock_iommu_domain *mock;
@@ -132,10 +136,38 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
 	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
+	mock->domain.ops = mock_ops.default_domain_ops;
+	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
 	xa_init(&mock->pfns);
 	return &mock->domain;
 }
 
+static struct iommu_domain_ops domain_nested_ops;
+
+static struct iommu_domain *mock_domain_alloc_user(struct device *dev,
+						   struct iommu_domain *parent,
+						   const void *user_data)
+{
+	const struct iommu_hwpt_selftest *alloc = user_data;
+	struct mock_iommu_domain *mock_parent;
+	struct mock_iommu_domain *mock;
+
+	if (!parent || !alloc || !(alloc->flags & IOMMU_TEST_FLAG_NESTED))
+		return mock_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+
+	mock_parent = container_of(parent, struct mock_iommu_domain, domain);
+
+	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
+	if (!mock)
+		return NULL;
+	mock->parent = mock_parent;
+	mock->iotlb = alloc->test_config;
+	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
+	mock->domain.ops = &domain_nested_ops;
+	mock->domain.type = IOMMU_DOMAIN_NESTED;
+	return &mock->domain;
+}
+
 static void mock_domain_free(struct iommu_domain *domain)
 {
 	struct mock_iommu_domain *mock =
@@ -257,6 +289,7 @@ static const struct iommu_ops mock_ops = {
 	.driver_type = IOMMU_DEVICE_DATA_SELFTEST,
 	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
+	.domain_alloc_user = mock_domain_alloc_user,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -266,6 +299,10 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
+static struct iommu_domain_ops domain_nested_ops = {
+	.free = mock_domain_free,
+};
+
 static inline struct iommufd_hw_pagetable *
 get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 		 struct mock_iommu_domain **mock)
@@ -278,7 +315,10 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
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
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 8e1369451464..ddd7c898fc50 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -125,6 +125,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_option, IOMMU_OPTION);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
 	TEST_LENGTH(iommu_device_info, IOMMU_DEVICE_GET_INFO);
+	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC);
 #undef TEST_LENGTH
 }
 
@@ -196,6 +197,7 @@ FIXTURE_VARIANT(iommufd_ioas)
 {
 	unsigned int mock_domains;
 	unsigned int memory_limit;
+	bool new_hwpt;
 };
 
 FIXTURE_SETUP(iommufd_ioas)
@@ -235,6 +237,12 @@ FIXTURE_VARIANT_ADD(iommufd_ioas, mock_domain)
 	.mock_domains = 1,
 };
 
+FIXTURE_VARIANT_ADD(iommufd_ioas, mock_domain_hwpt)
+{
+	.mock_domains = 1,
+	.new_hwpt = true,
+};
+
 FIXTURE_VARIANT_ADD(iommufd_ioas, two_mock_domain)
 {
 	.mock_domains = 2,
@@ -250,6 +258,96 @@ TEST_F(iommufd_ioas, ioas_auto_destroy)
 {
 }
 
+TEST_F(iommufd_ioas, ioas_new_hwpt)
+{
+	uint32_t new_hwpt_id = 0;
+	bool nested = true;
+
+	if (self->dev_id) {
+		test_cmd_mock_domain_alloc_and_replace(self->ioas_id,
+						       self->dev_id,
+						       &new_hwpt_id, !nested);
+		/* hw_pagetable cannot be freed if a device is attached to it */
+		EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, new_hwpt_id));
+
+		/* Detach from the new hw_pagetable and try again */
+		test_cmd_mock_domain_replace(self->ioas_id, self->dev_id,
+					     self->domain_id);
+		test_ioctl_destroy(new_hwpt_id);
+	} else {
+		test_err_ioctl_hwpt_alloc(ENOENT, self->ioas_id, self->dev_id,
+					  &new_hwpt_id, !nested);
+		test_err_mock_domain_replace(ENOENT, self->ioas_id,
+					     self->dev_id, new_hwpt_id);
+	}
+}
+
+TEST_F(iommufd_ioas, ioas_nested_hwpt)
+{
+	uint32_t nested_hwpt_id[2] = {};
+	uint32_t parent_hwpt_id = 0;
+	uint32_t test_hwpt_id = 0;
+	bool nested = true;
+
+	if (self->dev_id) {
+		/* Negative tests */
+		test_err_ioctl_hwpt_alloc(EINVAL, self->dev_id,
+					  self->ioas_id, &test_hwpt_id, !nested);
+		test_err_ioctl_hwpt_alloc(EINVAL, self->dev_id,
+					  self->dev_id, &test_hwpt_id, !nested);
+
+		/* Allocate two nested hwpts sharing one common parent hwpt */
+		test_ioctl_hwpt_alloc(self->ioas_id, self->dev_id,
+				      &parent_hwpt_id, !nested);
+
+		test_ioctl_hwpt_alloc(parent_hwpt_id, self->dev_id,
+				      &nested_hwpt_id[0], nested);
+		test_ioctl_hwpt_alloc(parent_hwpt_id, self->dev_id,
+				      &nested_hwpt_id[1], nested);
+
+		/* Negative test: a nested hwpt on top of a nested hwpt */
+		test_err_ioctl_hwpt_alloc(EINVAL, nested_hwpt_id[0],
+					  self->dev_id, &test_hwpt_id, nested);
+		/* Negative test: parent hwpt now cannot be freed */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, parent_hwpt_id));
+
+		/* Attach device to nested_hwpt_id[0] that then will be busy */
+		test_cmd_mock_domain_replace(self->ioas_id, self->dev_id,
+					     nested_hwpt_id[0]);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, nested_hwpt_id[0]));
+
+		/* Switch from nested_hwpt_id[0] to nested_hwpt_id[1] */
+		test_cmd_mock_domain_replace(self->ioas_id, self->dev_id,
+					     nested_hwpt_id[1]);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, nested_hwpt_id[1]));
+		test_ioctl_destroy(nested_hwpt_id[0]);
+
+		/* Detach from nested_hwpt_id[1] and destroy it */
+		test_cmd_mock_domain_replace(self->ioas_id, self->dev_id,
+					     parent_hwpt_id);
+		test_ioctl_destroy(nested_hwpt_id[1]);
+
+		/* Detach from the parent hw_pagetable and destroy it */
+		test_cmd_mock_domain_replace(self->ioas_id, self->dev_id,
+					     self->domain_id);
+		test_ioctl_destroy(parent_hwpt_id);
+	} else {
+		test_err_ioctl_hwpt_alloc(ENOENT, self->ioas_id, self->dev_id,
+					  &parent_hwpt_id, false);
+		test_err_ioctl_hwpt_alloc(ENOENT, parent_hwpt_id, self->dev_id,
+					  &nested_hwpt_id[0], true);
+		test_err_ioctl_hwpt_alloc(ENOENT, parent_hwpt_id, self->dev_id,
+					  &nested_hwpt_id[1], true);
+		test_err_mock_domain_replace(ENOENT, self->ioas_id,
+					     self->dev_id, nested_hwpt_id[0]);
+		test_err_mock_domain_replace(ENOENT, self->ioas_id,
+					     self->dev_id, nested_hwpt_id[1]);
+	}
+}
+
 TEST_F(iommufd_ioas, ioas_destroy)
 {
 	if (self->domain_id) {
@@ -621,6 +719,7 @@ TEST_F(iommufd_ioas, access_pin)
 			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
 
 	for (npages = 1; npages < BUFFER_SIZE / PAGE_SIZE; npages++) {
+		uint32_t new_hwpt_id = 0;
 		uint32_t mock_device_id;
 		uint32_t mock_hwpt_id;
 
@@ -655,11 +754,26 @@ TEST_F(iommufd_ioas, access_pin)
 				   &access_cmd));
 		test_cmd_mock_domain(self->ioas_id, &mock_device_id,
 				     &mock_hwpt_id);
-		check_map_cmd.id = mock_hwpt_id;
+		if (variant->new_hwpt) {
+			test_cmd_mock_domain_alloc_and_replace(self->ioas_id,
+							       mock_device_id,
+							       &new_hwpt_id,
+							       false);
+			check_map_cmd.id = new_hwpt_id;
+		} else {
+			check_map_cmd.id = mock_hwpt_id;
+		}
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
 				   &check_map_cmd));
 
+		if (variant->new_hwpt) {
+			/* Detach from the new hwpt for its destroy() */
+			test_cmd_mock_domain_replace(self->ioas_id,
+						     mock_device_id,
+						     mock_hwpt_id);
+			test_ioctl_destroy(new_hwpt_id);
+		}
 		test_ioctl_destroy(mock_device_id);
 		test_ioctl_destroy(mock_hwpt_id);
 		test_cmd_destroy_access_pages(
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 1807d29c05f8..cb8a5e3beca6 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -66,6 +66,36 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *device_id,
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
 						   device_id, hwpt_id))
 
+static int _test_cmd_mock_domain_replace(int fd, unsigned int ioas_id,
+					 __u32 device_id, __u32 hwpt_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
+		.id = ioas_id,
+		.mock_domain_replace = {
+			.device_id = device_id,
+			.hwpt_id = hwpt_id,
+		},
+	};
+
+	return ioctl(fd, IOMMU_TEST_CMD, &cmd);
+}
+
+#define test_cmd_mock_domain_replace(ioas_id, device_id, hwpt_id)                \
+	ASSERT_EQ(0, _test_cmd_mock_domain_replace(self->fd, ioas_id, device_id, \
+						   hwpt_id))
+#define test_err_mock_domain_replace(_errno, ioas_id, device_id, hwpt_id)     \
+	EXPECT_ERRNO(_errno, _test_cmd_mock_domain_replace(self->fd, ioas_id, \
+							   device_id, hwpt_id))
+
+#define test_cmd_mock_domain_alloc_and_replace(ioas_id, device_id,            \
+					       hwpt_id, nested)               \
+	({                                                                    \
+		test_ioctl_hwpt_alloc(ioas_id, device_id, hwpt_id, nested);   \
+		test_cmd_mock_domain_replace(ioas_id, device_id, *(hwpt_id)); \
+	})
+
 static int _test_cmd_access_set_ioas(int fd, __u32 access_id,
 				     unsigned int ioas_id)
 {
@@ -159,6 +189,44 @@ static int _test_ioctl_ioas_alloc(int fd, __u32 *id)
 		ASSERT_NE(0, *(id));                                \
 	})
 
+static int _test_ioctl_hwpt_alloc(int fd, __u32 pt_id, __u32 dev_id,
+				  __u32 *out_hwpt_id, bool nested)
+{
+	struct iommu_hwpt_selftest data = {
+		.flags = nested ? IOMMU_TEST_FLAG_NESTED : 0,
+		.test_config = nested ? IOMMU_TEST_IOTLB_DEFAULT : 0,
+	};
+	struct iommu_hwpt_alloc cmd = {
+		.size = sizeof(cmd),
+		.dev_id = dev_id,
+		.pt_id = pt_id,
+		.data_type = IOMMU_PGTBL_DATA_SELFTTEST,
+		.data_len = sizeof(data),
+		.data_uptr = (uint64_t)&data,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_HWPT_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	*out_hwpt_id = cmd.out_hwpt_id;
+	return 0;
+}
+
+#define test_ioctl_hwpt_alloc(pt_id, dev_id, out_hwpt_id, nested)            \
+	({                                                                   \
+		ASSERT_EQ(0, _test_ioctl_hwpt_alloc(self->fd, pt_id, dev_id, \
+						    out_hwpt_id, nested));   \
+		ASSERT_NE(0, *(out_hwpt_id));                                \
+	})
+#define test_err_ioctl_hwpt_alloc(_errno, pt_id, dev_id, out_hwpt_id, nested) \
+	({                                                                    \
+		EXPECT_ERRNO(_errno,                                          \
+			     _test_ioctl_hwpt_alloc(self->fd, pt_id, dev_id,  \
+						    out_hwpt_id, nested));    \
+		ASSERT_EQ(0, *(out_hwpt_id));                                 \
+	})
+
 static int _test_ioctl_ioas_map(int fd, unsigned int ioas_id, void *buffer,
 				size_t length, __u64 *iova, unsigned int flags)
 {
-- 
2.34.1

