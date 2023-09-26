Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594E17AE91B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjIZJ11 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 05:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjIZJ1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 05:27:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2795192;
        Tue, 26 Sep 2023 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720421; x=1727256421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAJiGm+JuAYUnyQirh3cHKdY9uGqPBhJyidvyEhPLkw=;
  b=kVr9I3aoW2JjbSUNn6LcB+vUUjLKsNCF7o+jHp99oqG8mNWIfsmxw8mj
   Dm+KJo8d5cO2dpKj430YwF9T2Eq8Yfd2xq7lULNaj1M1Tz3qWDMezRQgJ
   AjjkZ7imyb/oa2Y/BfQQ6ryFzjdgWGfeJ1S4VhIen7WeqQHrbR6i5TsGM
   2dUeuJcqGjk1yToEnAaxNNxSTpLK5y4f/zdspkGmeqfIZO4b20JSpFS5l
   of8G96VYHdgdsGX8kvVBffwaZNqcc/7PaQTp83ZkGdN5ECI6Wgjp7O3wq
   hKDv2m7zSB2kCAv1xL7Cxnz7Uj/YGQep0PuuO9S09i4paRuTjE3Lxl5Od
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360905423"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360905423"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079642572"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="1079642572"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2023 02:27:00 -0700
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
Subject: [RFC 7/8] iommufd/selftest: Add coverage for iommufd pasid attach/detach
Date:   Tue, 26 Sep 2023 02:26:50 -0700
Message-Id: <20230926092651.17041-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926092651.17041-1-yi.l.liu@intel.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
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

This tests iommufd pasid attach/replace/detach.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 172 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  28 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  78 ++++++++
 3 files changed, 274 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 7cf06a4635d8..92e20a18bbea 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2022,4 +2022,176 @@ TEST_F(vfio_compat_mock_domain, huge_map)
 	}
 }
 
+FIXTURE(iommufd_device_pasid)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t hwpt_id;
+	uint32_t stdev_id;
+	uint32_t device_id;
+};
+
+FIXTURE_SETUP(iommufd_device_pasid)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+	test_ioctl_ioas_alloc(&self->ioas_id);
+
+	test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
+			     &self->hwpt_id, &self->device_id);
+}
+
+FIXTURE_TEARDOWN(iommufd_device_pasid)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+TEST_F(iommufd_device_pasid, pasid_attach)
+{
+	if (self->device_id) {
+		struct iommu_hwpt_selftest data = {
+			.iotlb =  IOMMU_TEST_IOTLB_DEFAULT,
+		};
+		uint32_t nested_hwpt_id[2] = {};
+		uint32_t parent_hwpt_id = 0;
+		uint32_t pasid = 100;
+		bool result;
+
+		/* Allocate two nested hwpts sharing one common parent hwpt */
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT,
+				    &parent_hwpt_id);
+
+		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id, 0,
+					   &nested_hwpt_id[0],
+					   IOMMU_HWPT_TYPE_SELFTEST,
+					   &data, sizeof(data));
+		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id, 0,
+					   &nested_hwpt_id[1],
+					   IOMMU_HWPT_TYPE_SELFTEST,
+					   &data, sizeof(data));
+
+		/*
+		 * Attach ioas to pasid 100, should succeed, domain should
+		 * be valid.
+		 */
+		test_cmd_pasid_attach(pasid, self->ioas_id);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, self->hwpt_id,
+						      &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Try attach pasid 100 with self->ioas_id, should succeed
+		 * as it is the same with existing hwpt.
+		 */
+		test_cmd_pasid_attach(pasid, self->ioas_id);
+
+		/*
+		 * Try attach pasid 100 with another hwpt, should FAIL
+		 * as attach does not allow overwrite, use REPLACE instead.
+		 */
+		test_err_cmd_pasid_attach(EINVAL, pasid, nested_hwpt_id[0]);
+
+		/*
+		 * Detach hwpt from pasid 100, and check if the pasid 100
+		 * has null domain. Should be done before the next attach.
+		 */
+		test_cmd_pasid_detach(pasid);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, 0, &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Attach nested hwpt to pasid 100, should succeed, domain
+		 * should be valid.
+		 */
+		test_cmd_pasid_attach(pasid, nested_hwpt_id[0]);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, nested_hwpt_id[0],
+						      &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Detach hwpt from pasid 100, and check if the pasid 100
+		 * has null domain
+		 */
+		test_cmd_pasid_detach(pasid);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, 0, &result));
+		EXPECT_EQ(1, result);
+
+		/* Replace tests */
+		pasid = 200;
+
+		/*
+		 * Replace pasid 200 without attaching it first, should
+		 * fail with -EINVAL.
+		 */
+		test_err_cmd_pasid_replace(EINVAL, pasid, parent_hwpt_id);
+
+		/*
+		 * Attach a s2 hwpt to pasid 200, should succeed, domain should
+		 * be valid.
+		 */
+		test_cmd_pasid_attach(pasid, parent_hwpt_id);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, parent_hwpt_id,
+						      &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Replace pasid 200 with self->ioas_id, should succeed,
+		 * and have valid domain.
+		 */
+		test_cmd_pasid_replace(pasid, self->ioas_id);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, self->hwpt_id,
+						      &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Replace a nested hwpt for pasid 200, should succeed,
+		 * and have valid domain.
+		 */
+		test_cmd_pasid_replace(pasid, nested_hwpt_id[0]);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, nested_hwpt_id[0],
+						      &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Replace with another nested hwpt for pasid 200, should
+		 * succeed, and have valid domain.
+		 */
+		test_cmd_pasid_replace(pasid, nested_hwpt_id[1]);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, nested_hwpt_id[1],
+						      &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Detach hwpt from pasid 200, and check if the pasid 200
+		 * has null domain.
+		 */
+		test_cmd_pasid_detach(pasid);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, 0, &result));
+		EXPECT_EQ(1, result);
+
+		test_ioctl_destroy(nested_hwpt_id[0]);
+		test_ioctl_destroy(nested_hwpt_id[1]);
+		test_ioctl_destroy(parent_hwpt_id);
+	}
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index d3f47f262c04..797f2b3103fc 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -206,12 +206,16 @@ FIXTURE(basic_fail_nth)
 {
 	int fd;
 	uint32_t access_id;
+	uint32_t stdev_id;
+	uint32_t pasid;
 };
 
 FIXTURE_SETUP(basic_fail_nth)
 {
 	self->fd = -1;
 	self->access_id = 0;
+	self->stdev_id = 0;
+	self->pasid = 0; //test should use a non-zero value
 }
 
 FIXTURE_TEARDOWN(basic_fail_nth)
@@ -223,6 +227,8 @@ FIXTURE_TEARDOWN(basic_fail_nth)
 		rc = _test_cmd_destroy_access(self->access_id);
 		assert(rc == 0);
 	}
+	if (self->pasid && self->stdev_id)
+		_test_cmd_pasid_detach(self->fd, self->stdev_id, self->pasid);
 	teardown_iommufd(self->fd, _metadata);
 }
 
@@ -579,7 +585,6 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	struct iommu_test_hw_info info;
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
-	uint32_t stdev_id;
 	uint32_t idev_id;
 	uint32_t hwpt_id;
 	__u64 iova;
@@ -608,7 +613,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL,
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &self->stdev_id, NULL,
 				  &idev_id))
 		return -1;
 
@@ -619,11 +624,26 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				 IOMMU_HWPT_TYPE_DEFAULT, 0, 0))
 		return -1;
 
-	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
+	if (_test_cmd_mock_domain_replace(self->fd, self->stdev_id, ioas_id2, NULL))
+		return -1;
+
+	if (_test_cmd_mock_domain_replace(self->fd, self->stdev_id, hwpt_id, NULL))
 		return -1;
 
-	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, hwpt_id, NULL))
+	self->pasid = 200;
+
+	/* Tests for pasid attach/replace/detach */
+	if (_test_cmd_pasid_attach(self->fd, self->stdev_id, self->pasid, ioas_id))
 		return -1;
+
+	if (_test_cmd_pasid_replace(self->fd, self->stdev_id, self->pasid, ioas_id2))
+		return -1;
+
+	if (_test_cmd_pasid_detach(self->fd, self->stdev_id, self->pasid))
+		return -1;
+
+	self->pasid = 0;
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index b75f168fca46..40d954a4cbc1 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -551,3 +551,81 @@ static int _test_cmd_unset_dev_data(int fd, __u32 device_id)
 #define test_err_unset_dev_data(_errno, device_id) \
 	EXPECT_ERRNO(_errno,                       \
 		     _test_cmd_unset_dev_data(self->fd, device_id))
+
+static int _test_cmd_pasid_attach(int fd, __u32 stdev_id, __u32 pasid, __u32 pt_id)
+{
+	struct iommu_test_cmd test_attach = {
+		.size = sizeof(test_attach),
+		.op = IOMMU_TEST_OP_PASID_ATTACH,
+		.id = stdev_id,
+		.pasid_attach = {
+			.pasid = pasid,
+			.pt_id = pt_id,
+		},
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_ATTACH), &test_attach);
+}
+
+#define test_cmd_pasid_attach(pasid, hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_pasid_attach(self->fd, self->stdev_id, pasid, hwpt_id))
+
+#define test_err_cmd_pasid_attach(_errno, pasid, hwpt_id) \
+	EXPECT_ERRNO(_errno, \
+		     _test_cmd_pasid_attach(self->fd, self->stdev_id, pasid, hwpt_id))
+
+static int _test_cmd_pasid_replace(int fd, __u32 stdev_id, __u32 pasid, __u32 pt_id)
+{
+	struct iommu_test_cmd test_replace = {
+		.size = sizeof(test_replace),
+		.op = IOMMU_TEST_OP_PASID_REPLACE,
+		.id = stdev_id,
+		.pasid_replace = {
+			.pasid = pasid,
+			.pt_id = pt_id,
+		},
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_REPLACE), &test_replace);
+}
+
+#define test_cmd_pasid_replace(pasid, hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_pasid_replace(self->fd, self->stdev_id, pasid, hwpt_id))
+
+#define test_err_cmd_pasid_replace(_errno, pasid, hwpt_id) \
+	EXPECT_ERRNO(_errno, \
+		     _test_cmd_pasid_replace(self->fd, self->stdev_id, pasid, hwpt_id))
+
+static int _test_cmd_pasid_detach(int fd, __u32 stdev_id, __u32 pasid)
+{
+	struct iommu_test_cmd test_detach = {
+		.size = sizeof(test_detach),
+		.op = IOMMU_TEST_OP_PASID_DETACH,
+		.id = stdev_id,
+		.pasid_detach = {
+			.pasid = pasid,
+		},
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_DETACH), &test_detach);
+}
+
+#define test_cmd_pasid_detach(pasid) \
+	ASSERT_EQ(0, _test_cmd_pasid_detach(self->fd, self->stdev_id, pasid))
+
+static int test_cmd_pasid_check_domain(int fd, __u32 stdev_id, __u32 pasid,
+				       __u32 hwpt_id, bool *result)
+{
+	struct iommu_test_cmd test_pasid_check = {
+		.size = sizeof(test_pasid_check),
+		.op = IOMMU_TEST_OP_PASID_CHECK_DOMAIN,
+		.id = stdev_id,
+		.pasid_check = {
+			.pasid = pasid,
+			.hwpt_id = hwpt_id,
+			.out_result_ptr = (__u64)result,
+		},
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_PASID_CHECK_DOMAIN), &test_pasid_check);
+}
-- 
2.34.1

