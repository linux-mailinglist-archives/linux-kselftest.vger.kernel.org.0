Return-Path: <linux-kselftest+bounces-12923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4830E91BAEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 11:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50A81F22FBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B999E155333;
	Fri, 28 Jun 2024 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkGikpKf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EA1552FA;
	Fri, 28 Jun 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565567; cv=none; b=Sa4RfYAaQU298vJr5wVNMyydOPh3zEY3XOs/iG+LLDKZnLYsHUCfHT/0IhOhUCHlypIgKYG5YHyXALWQPxivHV6sH97P+oLPd6W3Ys7M66vGpsfn9gKAj4oeFwieWrDoIWjOGgb2GAvamjOzI1l1r2I5hrgaHP3NF0rCHw1J07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565567; c=relaxed/simple;
	bh=DNLbeuxkGVQOD+Wh47BjxObAGyoVwf3Bjs7s8Ay1Ek4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uOosoTdjNo9e/OPni/gocXwbTC4Hu3f4rTAF4+zsceTXRjm21gXsHOXEfc2bAo69V7m9Shu7mpXfjPy23lp2+6kpT08eut5azzyziXeBR+0aY/lMQfOfr6rwCY1CROXr/UyZxvlH8+jebiPyGKJVFXkHbx/AZdJST7+bpqczbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkGikpKf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719565565; x=1751101565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNLbeuxkGVQOD+Wh47BjxObAGyoVwf3Bjs7s8Ay1Ek4=;
  b=EkGikpKfvbm79GbJ8LKsuRZW+uTQcDUEHsqWtKhH4ThM9k7XKAjqMrmA
   AR1+oqjI5LEgi0YA7u7GU5DJjrrk1Ym7jk0E7cBSOJoBn0c3C6LGipBzX
   osgYY20+zU6OUs65LHcV0vPI/64sG1e4VyrKcMdICGlmq6e9Hq+m+lvZ+
   hZ1nBUmyr0HSZMiMZJ8FsRA9FjRL4QdA4/7d/8sxeD4nC26S7JVGQZdxK
   KtkRFC20vCkytFEC/dutJ5pvvVaUZe7+6Boi6j/2iMRfgbwLTSwUECoaT
   ex5DTnasvThHJEPxaGnUQIr9HHqPwihjvne61TQVVT+nmesVuR153xIYX
   g==;
X-CSE-ConnectionGUID: Bt/8tx51QPOeybBrywnvMQ==
X-CSE-MsgGUID: tSnaBZDjT+O4hO8YUGaKSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20613713"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="20613713"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:06:04 -0700
X-CSE-ConnectionGUID: OeGTBs58TOKzRPGFBTZYiw==
X-CSE-MsgGUID: cBqgTf35QLOrXhfUcNBo/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44517087"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jun 2024 02:06:04 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 7/7] iommufd/selftest: Add coverage for iommufd pasid attach/detach
Date: Fri, 28 Jun 2024 02:05:57 -0700
Message-Id: <20240628090557.50898-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628090557.50898-1-yi.l.liu@intel.com>
References: <20240628090557.50898-1-yi.l.liu@intel.com>
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
 tools/testing/selftests/iommu/iommufd.c       | 207 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  28 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  78 +++++++
 3 files changed, 309 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index edf1c99c9936..6db0eabb689e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2346,4 +2346,211 @@ TEST_F(vfio_compat_mock_domain, huge_map)
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
+		test_err_cmd_pasid_attach(EBUSY, pasid, nested_hwpt_id[0]);
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
+		/* Negative Tests for pasid replace, use pasid 1024 */
+
+		/*
+		 * Attach a s2 hwpt to pasid 1024, should succeed, domain should
+		 * be valid.
+		 */
+		pasid = 1024;
+		test_cmd_pasid_attach(pasid, parent_hwpt_id);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, parent_hwpt_id,
+						      &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Replace pasid 1024 with self->ioas_id, should fail,
+		 * but have the old valid domain.
+		 */
+		test_err_cmd_pasid_replace(ENOMEM, pasid, self->ioas_id);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, parent_hwpt_id,
+						      &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Detach hwpt from pasid 1024, and check if the pasid 1024
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
index 8d2b46b2114d..9b112b108670 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -684,3 +684,81 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, void *data,
 
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


