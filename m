Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A32D7787F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 09:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjHKHPX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 03:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjHKHPU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 03:15:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800F530D3;
        Fri, 11 Aug 2023 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691738116; x=1723274116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXnjiBk5Rm1Wh/mIr4DvEInc/Fi8Guc3wJK5YvAkue4=;
  b=K+u0O+5VCi5YzKvqgyeFsA5FM6tsBrIoM8fojZnBXH7o5OoMGeL8HFpv
   Rw1N7u0/34/ddFlwpcfLA0cdVtf2bkknwkfEedhxIk+EY9b6msqV7RFtZ
   XE5I+RsISZLTcPzQBAlLfkQdL20scFoi4HfzWXjjYa6KT7nqtsW3hFhbX
   QYnVABSSDOBJX2qfm0cG4SczzhWjuGO5TE4lV1UQ//nPUgI3veGVgMBdS
   ULi012+rZeLpBwOYWfXzhlt6IdZLBJRlKxE33QCBBmEWP97AJZ1pqPEeO
   RovjHxdlUw9zQPWfkUdbHuz+UBcTgtWq5loS8hXmT3KiVgfvo71btkYcU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351937717"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="351937717"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 00:15:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="979142010"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="979142010"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2023 00:15:07 -0700
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
Subject: [PATCH v7 4/4] iommufd/selftest: Add coverage for IOMMU_GET_HW_INFO ioctl
Date:   Fri, 11 Aug 2023 00:15:01 -0700
Message-Id: <20230811071501.4126-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811071501.4126-1-yi.l.liu@intel.com>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
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

Add a mock_domain_hw_info function and an iommu_test_hw_info data
structure. This allows to test the IOMMU_GET_HW_INFO ioctl passing
the test_reg value for the mock_dev.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  9 ++++
 drivers/iommu/iommufd/selftest.c              | 16 +++++++
 tools/testing/selftests/iommu/iommufd.c       | 28 ++++++++++-
 .../selftests/iommu/iommufd_fail_nth.c        |  4 ++
 tools/testing/selftests/iommu/iommufd_utils.h | 47 +++++++++++++++++++
 5 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 258de2253b61..3f3644375bf1 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -100,4 +100,13 @@ struct iommu_test_cmd {
 };
 #define IOMMU_TEST_CMD _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE + 32)
 
+/* Mock structs for IOMMU_DEVICE_GET_HW_INFO ioctl */
+#define IOMMU_HW_INFO_TYPE_SELFTEST	0xfeedbeef
+#define IOMMU_HW_INFO_SELFTEST_REGVAL	0xdeadbeef
+
+struct iommu_test_hw_info {
+	__u32 flags;
+	__u32 test_reg;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index bb2cd54ca7b6..ab4011e3a7c6 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -128,6 +128,21 @@ static struct iommu_domain mock_blocking_domain = {
 	.ops = &mock_blocking_ops,
 };
 
+static void *mock_domain_hw_info(struct device *dev, u32 *length, u32 *type)
+{
+	struct iommu_test_hw_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->test_reg = IOMMU_HW_INFO_SELFTEST_REGVAL;
+	*length = sizeof(*info);
+	*type = IOMMU_HW_INFO_TYPE_SELFTEST;
+
+	return info;
+}
+
 static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 {
 	struct mock_iommu_domain *mock;
@@ -279,6 +294,7 @@ static void mock_domain_set_plaform_dma_ops(struct device *dev)
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
+	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
 	.capable = mock_domain_capable,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 8acd0af37aa5..7e0fdf372c12 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -113,6 +113,7 @@ TEST_F(iommufd, cmd_length)
 	}
 
 	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY);
+	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO);
 	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC);
 	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES);
 	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS);
@@ -185,6 +186,7 @@ FIXTURE(iommufd_ioas)
 	uint32_t ioas_id;
 	uint32_t stdev_id;
 	uint32_t hwpt_id;
+	uint32_t device_id;
 	uint64_t base_iova;
 };
 
@@ -211,7 +213,7 @@ FIXTURE_SETUP(iommufd_ioas)
 
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
-				     &self->hwpt_id, NULL);
+				     &self->hwpt_id, &self->device_id);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -290,6 +292,30 @@ TEST_F(iommufd_ioas, ioas_area_auto_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, get_hw_info)
+{
+	struct iommu_test_hw_info buffer_exact;
+	struct iommu_test_hw_info_buffer {
+		struct iommu_test_hw_info info;
+		uint64_t trailing_bytes;
+	} buffer_larger;
+
+	if (self->device_id) {
+		/* Provide a user_buffer with exact size */
+		test_cmd_get_hw_info(self->device_id, &buffer_exact, sizeof(buffer_exact));
+		/*
+		 * Provide a user_buffer with size larger than the exact size to check if
+		 * kernel zero the trailing bytes.
+		 */
+		test_cmd_get_hw_info(self->device_id, &buffer_larger, sizeof(buffer_larger));
+	} else {
+		test_err_get_hw_info(ENOENT, self->device_id,
+				     &buffer_exact, sizeof(buffer_exact));
+		test_err_get_hw_info(ENOENT, self->device_id,
+				     &buffer_larger, sizeof(buffer_larger));
+	}
+}
+
 TEST_F(iommufd_ioas, area)
 {
 	int i;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index d4c552e56948..a220ca2a689d 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -576,6 +576,7 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 /* device.c */
 TEST_FAIL_NTH(basic_fail_nth, device)
 {
+	struct iommu_test_hw_info info;
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
 	uint32_t stdev_id;
@@ -611,6 +612,9 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				  &idev_id))
 		return -1;
 
+	if (_test_cmd_get_hw_info(self->fd, idev_id, &info, sizeof(info)))
+		return -1;
+
 	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, &hwpt_id))
 		return -1;
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 70353e68e599..ccd0ef7833a0 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -348,3 +348,50 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
 	})
 
 #endif
+
+static int _test_cmd_get_hw_info(int fd, __u32 device_id,
+				 void *data, size_t data_len)
+{
+	struct iommu_hw_info cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.data_len = data_len,
+		.data_ptr = (uint64_t)data,
+	};
+	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
+	int ret;
+
+	ret = ioctl(fd, IOMMU_GET_HW_INFO, &cmd);
+	if (ret)
+		return ret;
+
+	assert(cmd.out_data_type == IOMMU_HW_INFO_TYPE_SELFTEST);
+
+	/*
+	 * Trailing bytes should be 0 if user buffer is larger than
+	 * the data that kernel reports.
+	 */
+	if (data_len > cmd.data_len) {
+		char *ptr = (char *)(data + cmd.data_len);
+		int idx = 0;
+
+		while (idx < data_len - cmd.data_len) {
+			assert(!*(ptr + idx));
+			idx++;
+		}
+	}
+
+	assert(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
+	assert(!info->flags);
+
+	return 0;
+}
+
+#define test_cmd_get_hw_info(device_id, data, data_len)         \
+	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, \
+					   data, data_len))
+
+#define test_err_get_hw_info(_errno, device_id, data, data_len) \
+	EXPECT_ERRNO(_errno,                                    \
+		     _test_cmd_get_hw_info(self->fd, device_id, \
+					   data, data_len))
-- 
2.34.1

