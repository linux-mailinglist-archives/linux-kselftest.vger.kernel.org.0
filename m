Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246706B1D1A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 08:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCIHzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 02:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjCIHyc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 02:54:32 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666C5C15C;
        Wed,  8 Mar 2023 23:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678348451; x=1709884451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmUqj4gFzFf1bk/blwMUJTq0+ikbJFi2lqRYVPnMXWw=;
  b=gRpz4ic+Kg7rCIGL5W+BBFbO/DHS9i/NWbHM6Sm6bkv/h1hOe6x8OSEm
   hDWOCPuk3UenGDcZ5zM4CmvTbBYcp8tGs2KKPNOQEyLmomzyhno3rbtQ5
   3E1OtecO1tOijqUq+/Sb65+/JHGwbX0S2IrfG/FRdLLQoXBMw0LotG5bW
   SZzQYibO8H2C9nVkGnTKlWk5PKnysqs1oUClqiokVBC/cz2F0l687KVnR
   ci76yotBPWrIcAGPTwlZUQaNFo79C6bJHberg6Cin7ub0Pi7NlWIe+WMn
   yyUN/LJEjBJ9+Xh1rjnMwdXbA5iqeLrIu2WEjhSh63LlMwJFipEMG55xi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="422652868"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="422652868"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 23:54:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="851432770"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="851432770"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2023 23:54:04 -0800
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
Subject: [PATCH v2 4/4] iommufd/selftest: Add coverage for IOMMU_DEVICE_GET_HW_INFO ioctl
Date:   Wed,  8 Mar 2023 23:53:58 -0800
Message-Id: <20230309075358.571567-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309075358.571567-1-yi.l.liu@intel.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Add a mock_domain_hw_info function and an iommu_hw_info_selftest data
structure. This allows to test the IOMMU_DEVICE_GET_HW_INFO ioctl by
passing the test_reg value for the mock_dev.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c                |  1 +
 drivers/iommu/iommufd/iommufd_test.h          | 15 +++++++++++
 drivers/iommu/iommufd/selftest.c              | 16 ++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 17 +++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6948539488a5..5c352807d946 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -8,6 +8,7 @@
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
+#include "iommufd_test.h"
 
 static bool allow_unsafe_interrupts;
 module_param(allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index da1898a9128f..578691602d94 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -100,4 +100,19 @@ struct iommu_test_cmd {
 };
 #define IOMMU_TEST_CMD _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE + 32)
 
+/* Mock structs for IOMMU_DEVICE_GET_HW_INFO ioctl */
+#define IOMMU_HW_INFO_TYPE_SELFTEST	0xfeedbeef
+#define IOMMU_HW_INFO_SELFTEST_REGVAL	0xdeadbeef
+
+/**
+ * struct iommu_hw_info_selftest
+ *
+ * @flags: Must be set to 0
+ * @test_reg: Pass IOMMU_HW_INFO_SELFTEST_REGVAL to user selftest program
+ */
+struct iommu_hw_info_selftest {
+	__u32 flags;
+	__u32 test_reg;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d7832ffc3aa6..b50ec3528ec1 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -128,6 +128,20 @@ static struct iommu_domain mock_blocking_domain = {
 	.ops = &mock_blocking_ops,
 };
 
+static void *mock_domain_hw_info(struct device *dev, u32 *length)
+{
+	struct iommu_hw_info_selftest *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->test_reg = IOMMU_HW_INFO_SELFTEST_REGVAL;
+	*length = sizeof(*info);
+
+	return info;
+}
+
 static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 {
 	struct mock_iommu_domain *mock;
@@ -279,6 +293,8 @@ static void mock_domain_set_plaform_dma_ops(struct device *dev)
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
+	.driver_type = IOMMU_HW_INFO_TYPE_SELFTEST,
+	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
 	.capable = mock_domain_capable,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 5c33b6b52c65..d2ce2ddbdc40 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -124,6 +124,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP);
 	TEST_LENGTH(iommu_option, IOMMU_OPTION);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
+	TEST_LENGTH(iommu_hw_info, IOMMU_DEVICE_GET_HW_INFO);
 #undef TEST_LENGTH
 }
 
@@ -188,6 +189,7 @@ FIXTURE(iommufd_ioas)
 	uint32_t ioas_id;
 	uint32_t stdev_id;
 	uint32_t hwpt_id;
+	uint32_t device_id;
 	uint64_t base_iova;
 };
 
@@ -214,7 +216,7 @@ FIXTURE_SETUP(iommufd_ioas)
 
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
-				     &self->hwpt_id, NULL);
+				     &self->hwpt_id, &self->device_id);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -293,6 +295,19 @@ TEST_F(iommufd_ioas, ioas_area_auto_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, device_get_hw_info)
+{
+	struct iommu_hw_info_selftest info;
+
+	if (self->device_id) {
+		test_cmd_device_get_hw_info(self->device_id, sizeof(info), &info);
+		assert(info.test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
+	} else {
+		test_err_device_get_hw_info(ENOENT, self->device_id,
+					    sizeof(info), &info);
+	}
+}
+
 TEST_F(iommufd_ioas, area)
 {
 	int i;
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 399779acce23..b57e1e60f69d 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -345,3 +345,29 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
 	})
 
 #endif
+
+static int _test_cmd_device_get_hw_info(int fd, __u32 device_id,
+					__u32 data_len, void *data)
+{
+	struct iommu_hw_info cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.data_len = data_len,
+		.data_ptr = (uint64_t)data,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_DEVICE_GET_HW_INFO, &cmd);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+#define test_cmd_device_get_hw_info(device_id, data_len, data)         \
+	ASSERT_EQ(0, _test_cmd_device_get_hw_info(self->fd, device_id, \
+						  data_len, data))
+
+#define test_err_device_get_hw_info(_errno, device_id, data_len, data) \
+	EXPECT_ERRNO(_errno,                                        \
+		     _test_cmd_device_get_hw_info(self->fd, device_id, \
+						  data_len, data))
-- 
2.34.1

