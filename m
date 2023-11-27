Return-Path: <linux-kselftest+bounces-631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1DC7F99F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 07:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA5D1F20E8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 06:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D340D2EE;
	Mon, 27 Nov 2023 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyK3mx5g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B66186;
	Sun, 26 Nov 2023 22:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701066883; x=1732602883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GkpokbbZU4q0iBs6OdC+VBUxtyyaR/47ClPUeT1fPRA=;
  b=RyK3mx5gkndFFtEw35u7MD72g+IRzjTwSefaOvqPqiX3TWoaOOFk2ABR
   6IHsxNs6qKIh3hJre6liTv+2SilSG6ptv5xlNIxav5uL7aGeMwewyr+Zv
   KVKWPeWjUuxVOlc1D8WREcg+2/YWOMUh7JNGxCXf1SZ21bfPoKdWvUDw/
   XPHtC1dcaEIZqMeOHton2EliPqgV6x22VBLxVIj/We9cL1UM+Sg8k5BRV
   HrV2Sxuqq3mIV/En1ERMl9c7wil0kfNmrFiTyNykXPtwB7mUQegalmUKh
   dd7LQIgxhee5g7w1vvdPUuEY2DTuIc+/e1lZbPaKm6u6mBPMlc9juagTk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391518210"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="391518210"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:34:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="838608952"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="838608952"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2023 22:34:41 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com,
	xin.zeng@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH 7/8] iommufd/selftest: Add coverage for iommufd pasid attach/detach
Date: Sun, 26 Nov 2023 22:34:27 -0800
Message-Id: <20231127063428.127436-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127063428.127436-1-yi.l.liu@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tests iommufd pasid attach/replace/detach.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 172 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  28 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  78 ++++++++
 3 files changed, 274 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 2781d5bc6309..4dfd2d33c0a0 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2221,4 +2221,176 @@ TEST_F(vfio_compat_mock_domain, huge_map)
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
+					   IOMMU_HWPT_DATA_SELFTEST,
+					   &data, sizeof(data));
+		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id, 0,
+					   &nested_hwpt_id[1],
+					   IOMMU_HWPT_DATA_SELFTEST,
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
index f590417cd67a..6d1b03e73b9d 100644
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
 				 IOMMU_HWPT_DATA_NONE, 0, 0))
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
index d4a169a2278e..890d622cde86 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -682,3 +682,81 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, void *data,
 
 #define test_cmd_get_hw_capabilities(device_id, caps, mask) \
 	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, NULL, 0, &caps))
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


