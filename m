Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F276ECCA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjHCOiS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 10:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjHCOhv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 10:37:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259649CC;
        Thu,  3 Aug 2023 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691073411; x=1722609411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FrwNPceh10Tu5Pr0DfPIpYCG71l2vETJOJy+lU/84gg=;
  b=dJr8Sl/H5I/91NygrgnbdqpZ1TNa3uZeqJ3KWKhbL+T/jCyNZYM9PR5S
   7BwkQfpAjzL1RndjZnZex27oIo5tI4EvsxR34R5wfLsOr4y8aj+l8bDcF
   QC3PsUABD3gmjmx1qkgHxpkt/YHjrKbh/UV53NSUhdjmSars7Iuk/zfSj
   oa1laxcTdwlQMiQCp0786ouD5huYFr1P4MW9YK/AZW7AtqzEks3aQB1Nv
   49Ckycch9Ev0lQR2En1Y7HZK5HdCPgPhTuEEaFSsSpxmegSfJdY2ewMdn
   jCQJsG4BN8/68CqFnjb5pFZGr0cnLOaG/fNc2n/GgDNL5HiQPeU4Fmafh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="372643396"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="372643396"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 07:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="759153202"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="759153202"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2023 07:31:49 -0700
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
Subject: [PATCH v5 4/4] iommufd/selftest: Add coverage for IOMMU_GET_HW_INFO ioctl
Date:   Thu,  3 Aug 2023 07:31:44 -0700
Message-Id: <20230803143144.200945-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803143144.200945-1-yi.l.liu@intel.com>
References: <20230803143144.200945-1-yi.l.liu@intel.com>
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

Add a mock_domain_hw_info function and an iommu_test_hw_info data
structure. This allows to test the IOMMU_GET_HW_INFO ioctl passing
the test_reg value for the mock_dev.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  9 +++++++
 drivers/iommu/iommufd/selftest.c              | 16 ++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 17 +++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

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
index 8acd0af37aa5..6b075a68b928 100644
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
@@ -290,6 +292,19 @@ TEST_F(iommufd_ioas, ioas_area_auto_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, get_hw_info)
+{
+	struct iommu_test_hw_info info;
+
+	if (self->device_id) {
+		test_cmd_get_hw_info(self->device_id, sizeof(info), &info);
+		assert(info.test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
+	} else {
+		test_err_get_hw_info(ENOENT, self->device_id,
+				     sizeof(info), &info);
+	}
+}
+
 TEST_F(iommufd_ioas, area)
 {
 	int i;
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 70353e68e599..d6d223435881 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -348,3 +348,29 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
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
+	int ret;
+
+	ret = ioctl(fd, IOMMU_GET_HW_INFO, &cmd);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+#define test_cmd_get_hw_info(device_id, data_len, data)         \
+	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, \
+					   data, data_len))
+
+#define test_err_get_hw_info(_errno, device_id, data_len, data) \
+	EXPECT_ERRNO(_errno,                                    \
+		     _test_cmd_get_hw_info(self->fd, device_id, \
+					   data, data_len))
-- 
2.34.1

