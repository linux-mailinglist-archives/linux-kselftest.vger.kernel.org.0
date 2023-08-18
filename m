Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961397809C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359825AbjHRKMo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376259AbjHRKMR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 06:12:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2A64695;
        Fri, 18 Aug 2023 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692353510; x=1723889510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qRcDL7apjvHKNsy4Hei9xFez3fCr15Qdd3DQi6MJcj0=;
  b=WOARj+2Ah8U1tf46ZLVBdzrxiCxyjL7y9yEAZm93/c1I7W4ni9RAbxZD
   8h7Am4o/zoXw93YayDbNMxfxt5Qalq56TMYgxo/fXskrnPsk+9WKZjisg
   OegGXvN7kY/QwfggSa4Dho8kFePXbBXrju7VjmL5pDoWEabhCAz/UEnCy
   5xvtsM83SXJSknU7BFULJworHpK0SaOuNyWGsrR1WSOJcBYoGSCVr8vmo
   PvbcGdkxwUABX+a8vcU38wDHkrxwyg8gR3VgNDC8yntCzfJxIsDIRx6MR
   KIMIqVXpUgkQVSO1PqHkY0Bvged6FvptLM7eKJp7Wdwy8kSmBkbSC5n/9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370526316"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="370526316"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858624998"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="858624998"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga004.jf.intel.com with ESMTP; 18 Aug 2023 03:10:37 -0700
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
Subject: [PATCH v9 4/5] iommufd/selftest: Add coverage for IOMMU_GET_HW_INFO ioctl
Date:   Fri, 18 Aug 2023 03:10:32 -0700
Message-Id: <20230818101033.4100-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818101033.4100-1-yi.l.liu@intel.com>
References: <20230818101033.4100-1-yi.l.liu@intel.com>
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
structure. This allows to test the IOMMU_GET_HW_INFO ioctl passing the
test_reg value for the mock_dev.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  9 +++
 drivers/iommu/iommufd/selftest.c              | 16 +++++
 tools/testing/selftests/iommu/iommufd.c       | 38 +++++++++++-
 .../selftests/iommu/iommufd_fail_nth.c        |  4 ++
 tools/testing/selftests/iommu/iommufd_utils.h | 62 +++++++++++++++++++
 5 files changed, 128 insertions(+), 1 deletion(-)

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
index 9223ff3f23f9..90e7c5400282 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -131,6 +131,21 @@ static struct iommu_domain mock_blocking_domain = {
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
@@ -290,6 +305,7 @@ static struct iommu_device *mock_probe_device(struct device *dev)
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
+	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
 	.capable = mock_domain_capable,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 8acd0af37aa5..33d08600be13 100644
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
@@ -290,6 +292,40 @@ TEST_F(iommufd_ioas, ioas_area_auto_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, get_hw_info)
+{
+	struct iommu_test_hw_info buffer_exact;
+	struct iommu_test_hw_info_buffer_larger {
+		struct iommu_test_hw_info info;
+		uint64_t trailing_bytes;
+	} buffer_larger;
+	struct iommu_test_hw_info_buffer_smaller {
+		__u32 flags;
+	} buffer_smaller;
+
+	if (self->device_id) {
+		/* Provide a zero-size user_buffer */
+		test_cmd_get_hw_info(self->device_id, NULL, 0);
+		/* Provide a user_buffer with exact size */
+		test_cmd_get_hw_info(self->device_id, &buffer_exact, sizeof(buffer_exact));
+		/*
+		 * Provide a user_buffer with size larger than the exact size to check if
+		 * kernel zero the trailing bytes.
+		 */
+		test_cmd_get_hw_info(self->device_id, &buffer_larger, sizeof(buffer_larger));
+		/*
+		 * Provide a user_buffer with size smaller than the exact size to check if
+		 * the fields within the size range still gets updated.
+		 */
+		test_cmd_get_hw_info(self->device_id, &buffer_smaller, sizeof(buffer_smaller));
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
index 70353e68e599..e0753d03ecaa 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -21,6 +21,10 @@ static unsigned long BUFFER_SIZE;
 
 static unsigned long PAGE_SIZE;
 
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
+
 /*
  * Have the kernel check the refcount on pages. I don't know why a freshly
  * mmap'd anon non-compound page starts out with a ref of 3
@@ -348,3 +352,61 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
 	})
 
 #endif
+
+/* @data can be NULL */
+static int _test_cmd_get_hw_info(int fd, __u32 device_id,
+				 void *data, size_t data_len)
+{
+	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
+	struct iommu_hw_info cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.data_len = data_len,
+		.data_uptr = (uint64_t)data,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_GET_HW_INFO, &cmd);
+	if (ret)
+		return ret;
+
+	assert(cmd.out_data_type == IOMMU_HW_INFO_TYPE_SELFTEST);
+
+	/*
+	 * The struct iommu_test_hw_info should be the one defined
+	 * by the current kernel.
+	 */
+	assert(cmd.data_len == sizeof(struct iommu_test_hw_info));
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
+	if (info) {
+		if (data_len >= offsetofend(struct iommu_test_hw_info, test_reg))
+			assert(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
+		if (data_len >= offsetofend(struct iommu_test_hw_info, flags))
+			assert(!info->flags);
+	}
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

