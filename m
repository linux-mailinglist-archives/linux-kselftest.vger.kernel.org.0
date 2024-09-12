Return-Path: <linux-kselftest+bounces-17837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40E976A2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C660284DE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F461AD25F;
	Thu, 12 Sep 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJS0yEvQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292A1AD253
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146786; cv=none; b=R/Csy7p6VsmrplmqD76jdkuA3482EAEHPjUOa3sRUS3Aw6NWcUqWjembOhJsvSwqJ30KWDLRKRvk2uppOI7wfMgZ5RhzMMvQ9a5xjTtvvLCAoXulIoPC5mkAjbOpL75XYJAUdis/EAokHvXxk1zQdZwWQDLbsgZL+oPtTqwO8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146786; c=relaxed/simple;
	bh=5jTgcN0fE7IWIWv+PdTycAuY6e4GCRrI1nr0aWzCH1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsoo7rYlVJTPHZJk6BPetqCWBEHDdi5qptnmVQbC1TjCC2zXMJZGNWaQeJNofMWT/ZKkNcstT11LS53N9iLtQEbgFCeE5LbtRjc/2oA8sQsh754aj71f9D7aZcRprFBvXk98VUS+lM4qPVMDlkQkMYNacZL2V7XMgeZ11lcI3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJS0yEvQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146785; x=1757682785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5jTgcN0fE7IWIWv+PdTycAuY6e4GCRrI1nr0aWzCH1M=;
  b=FJS0yEvQAdnE9byAyv8gHVaM7CwcKySETltETpEqd3P6cL5rJlXa7N5h
   9eW2ghmoo71lKxyX8VAr2mptufO1CRo/06m0F9NEIh0ELyalRzxX6Wg5J
   fX+rBai0cOBw9IsvsdQetnex+GzcHAFUYHArHAO341qRKwwC7oE6Sj4Ij
   EGdW+1tzv5XdcxoVwObedNI+YoICvDvw7jHFQC0KEiCL3fLsRpNUHmdMO
   javcCf5qkePVemLPV+GiTqBTJWM0kZwdTuWbxg/YZwm6HqNzroSvNvuEY
   Co27D0605oQUjVSIM97VMa8AttXVlhC/LMB6u893gZchE1BKUzniOe8Gh
   A==;
X-CSE-ConnectionGUID: G4ZL+H3zTXuKdXSG3682Gg==
X-CSE-MsgGUID: LSEh/9MWR7CPMNSk6WwedQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27911264"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="27911264"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:13:01 -0700
X-CSE-ConnectionGUID: q8fsJUQfQ8C1fYLJqEC7og==
X-CSE-MsgGUID: T0QgYZyKRdOqW0hS02gKAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67996586"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2024 06:13:01 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v4 10/10] iommufd/selftest: Add coverage for iommufd pasid attach/detach
Date: Thu, 12 Sep 2024 06:12:55 -0700
Message-Id: <20240912131255.13305-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912131255.13305-1-yi.l.liu@intel.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
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
 tools/testing/selftests/iommu/iommufd.c       | 256 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  29 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  78 ++++++
 3 files changed, 359 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 4927b9add5ad..98f5beecca1b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2386,4 +2386,260 @@ TEST_F(vfio_compat_mock_domain, huge_map)
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
+		uint32_t fault_id, fault_fd;
+		uint32_t iopf_hwpt_id;
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
+		test_ioctl_fault_alloc(&fault_id, &fault_fd);
+		test_cmd_hwpt_alloc_iopf(self->device_id, parent_hwpt_id, fault_id,
+					 IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
+					 IOMMU_HWPT_DATA_SELFTEST, &data,
+					 sizeof(data));
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
+		 * but have the old valid domain. This is a designed
+		 * negative case, normally replace with self->ioas_id
+		 * could succeed.
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
+		/* Attach to iopf-capable hwpt */
+
+		/*
+		 * Attach an iopf hwpt to pasid 2048, should succeed, domain should
+		 * be valid.
+		 */
+		pasid = 2048;
+		test_cmd_pasid_attach(pasid, iopf_hwpt_id);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, iopf_hwpt_id,
+						      &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Replace with parent_hwpt_id for pasid 2048, should
+		 * succeed, and have valid domain.
+		 */
+		test_cmd_pasid_replace(pasid, parent_hwpt_id);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, parent_hwpt_id,
+						      &result));
+		EXPECT_EQ(1, result);
+
+		/*
+		 * Detach hwpt from pasid 2048, and check if the pasid 2048
+		 * has null domain.
+		 */
+		test_cmd_pasid_detach(pasid);
+		ASSERT_EQ(0,
+			  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
+						      pasid, 0, &result));
+		EXPECT_EQ(1, result);
+
+		/* Attach to iopf-capable hwpt */
+		test_ioctl_destroy(iopf_hwpt_id);
+		close(fault_fd);
+		test_ioctl_destroy(fault_id);
+
+		test_ioctl_destroy(nested_hwpt_id[0]);
+		test_ioctl_destroy(nested_hwpt_id[1]);
+		test_ioctl_destroy(parent_hwpt_id);
+	}
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index c5d5e69452b0..749d3fe6b0fe 100644
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
 
@@ -619,11 +624,27 @@ TEST_FAIL_NTH(basic_fail_nth, device)
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
+	if (_test_cmd_pasid_attach(self->fd, self->stdev_id, self->pasid, ioas_id)) {
+		self->pasid = 0;
 		return -1;
+	}
+
+	_test_cmd_pasid_replace(self->fd, self->stdev_id, self->pasid, ioas_id2);
+
+	if (_test_cmd_pasid_detach(self->fd, self->stdev_id, self->pasid))
+		return -1;
+
+	self->pasid = 0;
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 40f6f14ce136..399e023993fc 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -762,3 +762,81 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd)
 
 #define test_cmd_trigger_iopf(device_id, fault_fd) \
 	ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, fault_fd))
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


