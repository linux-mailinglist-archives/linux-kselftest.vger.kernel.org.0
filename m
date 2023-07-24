Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9275F418
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjGXLAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjGXLAs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:00:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC3E10E0;
        Mon, 24 Jul 2023 04:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196421; x=1721732421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lYtRvULoCnmHMuniuUeiJdk/Hoz+sv7WeK/x8+TbZUk=;
  b=T6yy8G//KVB6+oQFp4//LodErEB2HA28+nXZpX1JhAfQvG5w4UwjOxHU
   4Tvd6GqtPp7dBMbtnUGBYWv0d7SBZeK1F6M4VB8P1NWxsQda0oSzauiJn
   eVDk1B/9aWMBQ46nSUXpQOi86Fj15fC7dSIPW66emlEcjPtDgjjfKYPhl
   UI0DGNKMAvWZh91TtgheqXhxRvkrFpnItwihY+AdhlDFub1R7yFoFfG7w
   W8/djQaxL0EUYmbTv9XDCxbjGAS23pgMoHp9vEjoMmGN2CIky2vnvTGW1
   VmGt5LODj5/feUMupnPJGfj5fGjm1dYuSFbeZk2wpdjDmcWRAQfbOeVbg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347012292"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347012292"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839409096"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839409096"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 03:59:44 -0700
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
Subject: [PATCH v4 4/4] iommufd/selftest: Add coverage for IOMMU_GET_HW_INFO ioctl
Date:   Mon, 24 Jul 2023 03:59:36 -0700
Message-Id: <20230724105936.107042-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724105936.107042-1-yi.l.liu@intel.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/iommu/iommufd/device.c                |  1 +
 drivers/iommu/iommufd/iommufd_test.h          |  9 +++++++
 drivers/iommu/iommufd/selftest.c              | 16 ++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 17 +++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++++++++++++++
 5 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 1015d6c42e2b..0deb2a2ec01a 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -8,6 +8,7 @@
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
+#include "iommufd_test.h"
 
 static bool allow_unsafe_interrupts;
 module_param(allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
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
index bb2cd54ca7b6..af7459e211ad 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -128,6 +128,20 @@ static struct iommu_domain mock_blocking_domain = {
 	.ops = &mock_blocking_ops,
 };
 
+static void *mock_domain_hw_info(struct device *dev, u32 *length)
+{
+	struct iommu_test_hw_info *info;
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
+	.hw_info_type = IOMMU_HW_INFO_TYPE_SELFTEST,
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
index 70353e68e599..f13df84f6b42 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -348,3 +348,29 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
 	})
 
 #endif
+
+static int _test_cmd_get_hw_info(int fd, __u32 device_id,
+				 __u32 data_len, void *data)
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
+						  data_len, data))
+
+#define test_err_get_hw_info(_errno, device_id, data_len, data) \
+	EXPECT_ERRNO(_errno,                                    \
+		     _test_cmd_get_hw_info(self->fd, device_id, \
+						  data_len, data))
-- 
2.34.1

