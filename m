Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B5175F462
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjGXLFj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjGXLF2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:05:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4877DE55;
        Mon, 24 Jul 2023 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196703; x=1721732703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MEDTFzJSWH7Dn8MTQLtqIwIGcW191lhpinBFtTwSFsY=;
  b=J4xwSdFHCRBVjBwqIDmxGEmhfq0X+ZxPwflOXBMPY1KVpEVG8qrDeOT7
   msDS9asAU708XvMur7LBpBU5VYn9MyuBdmzsB7HKeumeLrqxZZSf+qgGZ
   6kWGcO2eJYMWwDsu1iCuZJPOHLaVrN+iuyzmiJ/2Rx6+qBZkG1KL2Q0XY
   GWJYanaH4OwmF2lA5Ncx3WkvUCRsYFopa6dX+8ofKxIdYVJ/S7n1LT/vc
   HgCylLgechrY0mxMvrbgIx2PTbv9wz8ek+dns6e9sZ7koYnhaJm6HXGPh
   oH8nzilw7uztcynitc9vvVzhNWOVFMNsWMaajOvQKdCMMnvUY46nqA+7P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013342"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013342"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775888"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775888"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:24 -0700
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
Subject: [PATCH v3 15/17] iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with user data
Date:   Mon, 24 Jul 2023 04:04:04 -0700
Message-Id: <20230724110406.107212-16-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
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

The IOMMU_HWPT_ALLOC ioctl now supports passing user_data to allocate a
customized domain. Add its coverage for both a regular domain case and
a nested domain case.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 114 +++++++++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  36 ++++++
 2 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index bfe0f76f7fb0..70116c2dfc94 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -114,6 +114,7 @@ TEST_F(iommufd, cmd_length)
 
 	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY);
 	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO);
+	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC);
 	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC);
 	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES);
 	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS);
@@ -194,6 +195,7 @@ FIXTURE_VARIANT(iommufd_ioas)
 {
 	unsigned int mock_domains;
 	unsigned int memory_limit;
+	bool new_hwpt;
 };
 
 FIXTURE_SETUP(iommufd_ioas)
@@ -233,6 +235,12 @@ FIXTURE_VARIANT_ADD(iommufd_ioas, mock_domain)
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
@@ -260,6 +268,93 @@ TEST_F(iommufd_ioas, ioas_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, hwpt_alloc)
+{
+	uint32_t new_hwpt_id = 0;
+
+	if (self->stdev_id && self->device_id) {
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id, &new_hwpt_id);
+		test_cmd_mock_domain_replace(self->stdev_id, new_hwpt_id);
+		/* hw_pagetable cannot be freed if a device is attached to it */
+		EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, new_hwpt_id));
+
+		/* Detach from the new hw_pagetable and try again */
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+		test_ioctl_destroy(new_hwpt_id);
+	} else {
+		test_err_cmd_hwpt_alloc(ENOENT, self->device_id,
+					self->ioas_id, &new_hwpt_id);
+		test_err_mock_domain_replace(ENOENT,
+					     self->stdev_id, new_hwpt_id);
+	}
+}
+
+TEST_F(iommufd_ioas, nested_hwpt_alloc)
+{
+	uint32_t nested_hwpt_id[2] = {};
+	uint32_t parent_hwpt_id = 0;
+	uint32_t test_hwpt_id = 0;
+
+	if (self->device_id) {
+		/* Negative tests */
+		test_err_cmd_hwpt_alloc(ENOENT, self->ioas_id, self->device_id,
+					&test_hwpt_id);
+		test_err_cmd_hwpt_alloc(EINVAL, self->device_id,
+					self->device_id, &test_hwpt_id);
+
+		/* Allocate two nested hwpts sharing one common parent hwpt */
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+				    &parent_hwpt_id);
+
+		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
+					   &nested_hwpt_id[0]);
+		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
+					   &nested_hwpt_id[1]);
+
+		/* Negative test: a nested hwpt on top of a nested hwpt */
+		test_err_cmd_hwpt_alloc_nested(EINVAL, self->device_id,
+					       nested_hwpt_id[0],
+					       &test_hwpt_id);
+		/* Negative test: parent hwpt now cannot be freed */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, parent_hwpt_id));
+
+		/* Attach device to nested_hwpt_id[0] that then will be busy */
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     nested_hwpt_id[0]);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, nested_hwpt_id[0]));
+
+		/* Switch from nested_hwpt_id[0] to nested_hwpt_id[1] */
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     nested_hwpt_id[1]);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, nested_hwpt_id[1]));
+		test_ioctl_destroy(nested_hwpt_id[0]);
+
+		/* Detach from nested_hwpt_id[1] and destroy it */
+		test_cmd_mock_domain_replace(self->stdev_id, parent_hwpt_id);
+		test_ioctl_destroy(nested_hwpt_id[1]);
+
+		/* Detach from the parent hw_pagetable and destroy it */
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+		test_ioctl_destroy(parent_hwpt_id);
+	} else {
+		test_err_cmd_hwpt_alloc(ENOENT, self->device_id, self->ioas_id,
+					&parent_hwpt_id);
+		test_err_cmd_hwpt_alloc_nested(ENOENT, self->device_id,
+					       parent_hwpt_id,
+					       &nested_hwpt_id[0]);
+		test_err_cmd_hwpt_alloc_nested(ENOENT, self->device_id,
+					       parent_hwpt_id,
+					       &nested_hwpt_id[1]);
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     nested_hwpt_id[0]);
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     nested_hwpt_id[1]);
+	}
+}
+
 TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
@@ -663,6 +758,8 @@ TEST_F(iommufd_ioas, access_pin)
 			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
 
 	for (npages = 1; npages < BUFFER_SIZE / PAGE_SIZE; npages++) {
+		uint32_t new_hwpt_id = 0;
+		uint32_t mock_device_id;
 		uint32_t mock_stdev_id;
 		uint32_t mock_hwpt_id;
 
@@ -696,12 +793,27 @@ TEST_F(iommufd_ioas, access_pin)
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
 				   &access_cmd));
 		test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-				     &mock_hwpt_id, NULL);
+				     &mock_hwpt_id, &mock_device_id);
 		check_map_cmd.id = mock_hwpt_id;
+		if (variant->new_hwpt) {
+			test_cmd_hwpt_alloc(mock_device_id, self->ioas_id,
+					    &new_hwpt_id);
+			test_cmd_mock_domain_replace(mock_stdev_id,
+						     new_hwpt_id);
+			check_map_cmd.id = new_hwpt_id;
+		} else {
+			check_map_cmd.id = mock_hwpt_id;
+		}
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
 				   &check_map_cmd));
 
+		if (variant->new_hwpt) {
+			/* Detach from the new hwpt for its destroy() */
+			test_cmd_mock_domain_replace(mock_stdev_id,
+						     mock_hwpt_id);
+			test_ioctl_destroy(new_hwpt_id);
+		}
 		test_ioctl_destroy(mock_stdev_id);
 		test_cmd_destroy_access_pages(
 			access_cmd.id,
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index f13df84f6b42..365fa3da2016 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -118,6 +118,42 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 
 #define test_cmd_hwpt_alloc(device_id, pt_id, hwpt_id) \
 	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, hwpt_id))
+#define test_err_cmd_hwpt_alloc(_errno, device_id, pt_id, hwpt_id)     \
+	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(self->fd, device_id, \
+						  pt_id, hwpt_id))
+
+static int _test_cmd_hwpt_alloc_nested(int fd, __u32 device_id, __u32 parent_id,
+				       __u32 *hwpt_id)
+{
+	struct iommu_hwpt_selftest data = {
+		.flags = IOMMU_TEST_FLAG_NESTED,
+		.test_config = IOMMU_TEST_IOTLB_DEFAULT,
+	};
+	struct iommu_hwpt_alloc cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.pt_id = parent_id,
+		.hwpt_type = IOMMU_HWPT_TYPE_SELFTTEST,
+		.data_len = sizeof(data),
+		.data_uptr = (uint64_t)&data,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_HWPT_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (hwpt_id)
+		*hwpt_id = cmd.out_hwpt_id;
+	return 0;
+}
+
+#define test_cmd_hwpt_alloc_nested(device_id, parent_id, hwpt_id)     \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc_nested(self->fd, device_id, \
+						 parent_id, hwpt_id))
+#define test_err_cmd_hwpt_alloc_nested(_errno, device_id, parent_id, hwpt_id) \
+	EXPECT_ERRNO(_errno,                                                  \
+		     _test_cmd_hwpt_alloc_nested(self->fd, device_id,         \
+						 parent_id, hwpt_id))
 
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
-- 
2.34.1

