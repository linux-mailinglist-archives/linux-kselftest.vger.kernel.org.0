Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75637A5DCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjISJ0Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 05:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjISJ0U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 05:26:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F68B12E;
        Tue, 19 Sep 2023 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695115573; x=1726651573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWn2F4rKZbZokQaf2eQ2te2+YDIyfqcOhEHVKn5AcUI=;
  b=GhTLeuqvsH7Vh8XFvt3MyP8BV2hjCIqZDNgLwSDo05mqSoLtOU87qpBx
   i7RU876nkUzCJmSoOOgsep2JWoUS+9Yue4407Ci52paqeOvI2sXtbhewS
   /N5jLDwP1wovTc4EXu5Ma6frldeyQNNF8cM/R4YK0w3wsb/DVReqLlbrj
   ewUSSd5uQAKkiKthlRb5MXKYUC4mEhWgPbA76WvbBjyFS2T7eoVlWh5V6
   wBjGU2cITyke2nYqa0wGy2HFsYbPlARI/2/FyamVur3w7SQiRK7BKSVvM
   IB5ILVt8+IzVGNzKtIGXVmmVuwaJsBcQzyiwW+lnzopWzFsDbgXyNjKta
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446368946"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="446368946"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722804774"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="722804774"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2023 02:25:35 -0700
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
Subject: [PATCH 5/6] iommufd/selftest: Add domain_alloc_user() support in iommu mock
Date:   Tue, 19 Sep 2023 02:25:22 -0700
Message-Id: <20230919092523.39286-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919092523.39286-1-yi.l.liu@intel.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
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

This adds mock_domain_alloc_user function and also new test case for the
new flag IOMMU_HWPT_ALLOC_NEST_PARENT.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c              | 16 +++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 24 +++++++++++++++----
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 11 ++++++---
 4 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 56506d5753f1..b54cbfb1862b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -146,6 +146,8 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length, u32 *type)
 	return info;
 }
 
+static const struct iommu_ops mock_ops;
+
 static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 {
 	struct mock_iommu_domain *mock;
@@ -162,10 +164,23 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
 	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
+	mock->domain.ops = mock_ops.default_domain_ops;
+	mock->domain.type = iommu_domain_type;
 	xa_init(&mock->pfns);
 	return &mock->domain;
 }
 
+static struct iommu_domain *
+mock_domain_alloc_user(struct device *dev, u32 flags)
+{
+	struct iommu_domain *domain;
+
+	domain = mock_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+	if (!domain)
+		domain = ERR_PTR(-ENOMEM);
+	return domain;
+}
+
 static void mock_domain_free(struct iommu_domain *domain)
 {
 	struct mock_iommu_domain *mock =
@@ -307,6 +322,7 @@ static const struct iommu_ops mock_ops = {
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
 	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
+	.domain_alloc_user = mock_domain_alloc_user,
 	.capable = mock_domain_capable,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
 	.device_group = generic_device_group,
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 9f705c1ea30f..9c129e63d7c7 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -114,6 +114,7 @@ TEST_F(iommufd, cmd_length)
 
 	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY);
 	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO);
+	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC);
 	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC);
 	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES);
 	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS);
@@ -1404,13 +1405,28 @@ TEST_F(iommufd_mock_domain, alloc_hwpt)
 	int i;
 
 	for (i = 0; i != variant->mock_domains; i++) {
+		uint32_t hwpt_id[2];
 		uint32_t stddev_id;
-		uint32_t hwpt_id;
 
-		test_cmd_hwpt_alloc(self->idev_ids[i], self->ioas_id, &hwpt_id);
-		test_cmd_mock_domain(hwpt_id, &stddev_id, NULL, NULL);
+		test_err_hwpt_alloc(EOPNOTSUPP,
+				    self->idev_ids[i], self->ioas_id,
+				    ~IOMMU_HWPT_ALLOC_NEST_PARENT, &hwpt_id[0]);
+		test_cmd_hwpt_alloc(self->idev_ids[i], self->ioas_id,
+				    0, &hwpt_id[0]);
+		test_cmd_hwpt_alloc(self->idev_ids[i], self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT, &hwpt_id[1]);
+
+		/* Do a hw_pagetable rotation test */
+		test_cmd_mock_domain_replace(self->stdev_ids[i], hwpt_id[0]);
+		EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, hwpt_id[0]));
+		test_cmd_mock_domain_replace(self->stdev_ids[i], hwpt_id[1]);
+		EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, hwpt_id[1]));
+		test_cmd_mock_domain_replace(self->stdev_ids[i], self->ioas_id);
+		test_ioctl_destroy(hwpt_id[1]);
+
+		test_cmd_mock_domain(hwpt_id[0], &stddev_id, NULL, NULL);
 		test_ioctl_destroy(stddev_id);
-		test_ioctl_destroy(hwpt_id);
+		test_ioctl_destroy(hwpt_id[0]);
 	}
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index a220ca2a689d..3d7838506bfe 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -615,7 +615,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_cmd_get_hw_info(self->fd, idev_id, &info, sizeof(info)))
 		return -1;
 
-	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, &hwpt_id))
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, &hwpt_id))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index e0753d03ecaa..be4970a84977 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -103,10 +103,11 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 							   pt_id, NULL))
 
 static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
-					 __u32 *hwpt_id)
+				__u32 flags, __u32 *hwpt_id)
 {
 	struct iommu_hwpt_alloc cmd = {
 		.size = sizeof(cmd),
+		.flags = flags,
 		.dev_id = device_id,
 		.pt_id = pt_id,
 	};
@@ -120,8 +121,12 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 	return 0;
 }
 
-#define test_cmd_hwpt_alloc(device_id, pt_id, hwpt_id) \
-	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, hwpt_id))
+#define test_cmd_hwpt_alloc(device_id, pt_id, flags, hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, \
+					  pt_id, flags, hwpt_id))
+#define test_err_hwpt_alloc(_errno, device_id, pt_id, flags, hwpt_id) \
+	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(self->fd, device_id, \
+						  pt_id, flags, hwpt_id))
 
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
-- 
2.34.1

