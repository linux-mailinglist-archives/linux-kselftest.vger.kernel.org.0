Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C4368FE6D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBIEVM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIEVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:21:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A861DBCD;
        Wed,  8 Feb 2023 20:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916414; x=1707452414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnj0cCi2ra/GTQprP6oGdeKLwYac70d/g6YVtvXPxLQ=;
  b=ixHXGSQ98xLDq0naL4+db3i/9Jcs86tfL/LTZu/Pc8vW4DVHPukE9WCa
   KK2fdLYwHMt7tNziWw8nCMYnxtJZX2omVnScKEETw/SjI44rrsOTn7JeS
   OYzNBwSyockfncxU33pRhEPkF8AgMVFtQ7pplvLMaCOxmB/l0+eOjRdME
   ZDzpU9BPos6LQW9OvilY92QYzqVebtT6Lx6AoSQZfg5gP8b0HjBitmZNV
   6SRLuh+G7LvxiuSLbmJBWWyeBwzuHSZ9JvqOsgHFBJs/uDdNrQ+cpd95f
   bR0sx6R3bhX5pKWMEKkuorDPg6E9MT5mO2vXMKvETgxmt5UgheAPxFFce
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394600768"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394600768"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:16:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912982142"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912982142"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 20:16:56 -0800
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
Subject: [PATCH 6/6] iommufd/selftest: Add coverage for IOMMU_DEVICE_GET_INFO ioctl
Date:   Wed,  8 Feb 2023 20:16:42 -0800
Message-Id: <20230209041642.9346-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209041642.9346-1-yi.l.liu@intel.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
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

This allows to get info for the mock_dev, helps to run selftest to check
IOMMU_DEVICE_GET_INFO in selftest.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c                |  1 +
 drivers/iommu/iommufd/iommufd_test.h          | 15 +++++++++++
 drivers/iommu/iommufd/selftest.c              | 16 ++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 18 ++++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++++++++++++++
 5 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 470838e6902d..0e5d2bde7b3c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -8,6 +8,7 @@
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
+#include "iommufd_test.h"
 
 MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
 
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index f2c61a9500e7..1605ff2b1a90 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -94,4 +94,19 @@ struct iommu_test_cmd {
 };
 #define IOMMU_TEST_CMD _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE + 32)
 
+/* Mock structs for IOMMU_DEVICE_GET_INFO ioctl */
+#define IOMMU_DEVICE_DATA_SELFTEST		0xfeedbeef
+#define IOMMU_DEVICE_INFO_SELFTEST_REGVAL	0xdeadbeef
+
+/**
+ * struct iommu_device_info_selftest
+ *
+ * @flags: Must be set to 0
+ * @test_reg: Pass IOMMU_DEVICE_INFO_SELFTEST_REGVAL to user selftest program
+ */
+struct iommu_device_info_selftest {
+	__u32 flags;
+	__u32 test_reg;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 5afed3fc30fe..5013c8757f4b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -104,6 +104,20 @@ struct selftest_obj {
 	};
 };
 
+static void *mock_domain_hw_info(struct device *dev, u32 *length)
+{
+	struct iommu_device_info_selftest *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->test_reg = IOMMU_DEVICE_INFO_SELFTEST_REGVAL;
+	*length = sizeof(*info);
+
+	return info;
+}
+
 static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 {
 	struct mock_iommu_domain *mock;
@@ -239,6 +253,8 @@ static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
+	.driver_type = IOMMU_DEVICE_DATA_SELFTEST,
+	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1e293950ac88..8e1369451464 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -124,6 +124,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP);
 	TEST_LENGTH(iommu_option, IOMMU_OPTION);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
+	TEST_LENGTH(iommu_device_info, IOMMU_DEVICE_GET_INFO);
 #undef TEST_LENGTH
 }
 
@@ -185,6 +186,7 @@ TEST_F(iommufd, global_options)
 FIXTURE(iommufd_ioas)
 {
 	int fd;
+	uint32_t dev_id;
 	uint32_t ioas_id;
 	uint32_t domain_id;
 	uint64_t base_iova;
@@ -212,7 +214,8 @@ FIXTURE_SETUP(iommufd_ioas)
 	}
 
 	for (i = 0; i != variant->mock_domains; i++) {
-		test_cmd_mock_domain(self->ioas_id, NULL, &self->domain_id);
+		test_cmd_mock_domain(self->ioas_id, &self->dev_id,
+				     &self->domain_id);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -281,6 +284,19 @@ TEST_F(iommufd_ioas, ioas_area_auto_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, device_get_info)
+{
+	struct iommu_device_info_selftest info;
+
+	if (self->dev_id) {
+		test_cmd_device_get_info(self->dev_id, sizeof(info), &info);
+		assert(info.test_reg == IOMMU_DEVICE_INFO_SELFTEST_REGVAL);
+	} else {
+		test_err_device_get_info(ENOENT, self->dev_id,
+					 sizeof(info), &info);
+	}
+}
+
 TEST_F(iommufd_ioas, area)
 {
 	int i;
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 67805afc620f..1807d29c05f8 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -294,3 +294,29 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
 	})
 
 #endif
+
+static int _test_cmd_device_get_info(int fd, __u32 device_id,
+				     __u32 data_len, void *data)
+{
+	struct iommu_device_info cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.data_len = data_len,
+		.data_ptr = (uint64_t)data,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_DEVICE_GET_INFO, &cmd);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+#define test_cmd_device_get_info(device_id, data_len, data)		\
+	ASSERT_EQ(0, _test_cmd_device_get_info(self->fd, device_id,	\
+					       data_len, data))
+
+#define test_err_device_get_info(_errno, device_id, data_len, data)	\
+	EXPECT_ERRNO(_errno,						\
+		     _test_cmd_device_get_info(self->fd, device_id,	\
+					       data_len, data))
-- 
2.34.1

