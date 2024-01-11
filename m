Return-Path: <linux-kselftest+bounces-2834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810ED82A6DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 05:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E557B1F226F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 04:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCADDF6E;
	Thu, 11 Jan 2024 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7KRbgEJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512C111D;
	Thu, 11 Jan 2024 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704946233; x=1736482233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UVR8KhCZvbCUivxwHesEQRJAFLYF+tJ8B4S7sGVtRGU=;
  b=S7KRbgEJcmlG1GU3aoEy92DXA6T0YvWk1ovGkvVPzndikYTaN9R6/WiE
   +yZvNDlRSu9KYEGgVXUqbv/XP3wKISMjBdR9BLay1RYwGo7gFIodZNZQY
   XEpfuhfVjWWKoqMW0PesH/dDlbO/9cg95RlWcrlvL19Qgs5tN6hEH5VAp
   AIOjgjEw4kzGHaiWaHO6v1LUxysnMdRRT9K9ZBcewSgBonV76dbGmglFH
   gK6R0uQWDJsT09C8VsuQDCUUQpSkvOlUjS3oEnDjefmC4LgDLhLpz61Jc
   kcmCZPX0kCbXucUlgQobMSzfe+8V9AdVVsF7QnzLlt2brX+qju+B3Tdnp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389167677"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389167677"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 20:10:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113691889"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1113691889"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2024 20:10:30 -0800
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
	yan.y.zhao@intel.com,
	j.granados@samsung.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v11 6/8] iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
Date: Wed, 10 Jan 2024 20:10:13 -0800
Message-Id: <20240111041015.47920-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111041015.47920-1-yi.l.liu@intel.com>
References: <20240111041015.47920-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

Add test cases for the IOMMU_HWPT_INVALIDATE ioctl and verify it by using
the new IOMMU_TEST_OP_MD_CHECK_IOTLB.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 148 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  33 ++++
 2 files changed, 181 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index c8763b880a16..1a881e7a21d1 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -116,6 +116,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY, id);
 	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO, __reserved);
 	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC, __reserved);
+	TEST_LENGTH(iommu_hwpt_invalidate, IOMMU_HWPT_INVALIDATE, __reserved);
 	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC, out_ioas_id);
 	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES,
 		    out_iova_alignment);
@@ -271,7 +272,9 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 	struct iommu_hwpt_selftest data = {
 		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
 	};
+	struct iommu_hwpt_invalidate_selftest inv_reqs[2] = {};
 	uint32_t nested_hwpt_id[2] = {};
+	uint32_t num_inv;
 	uint32_t parent_hwpt_id = 0;
 	uint32_t parent_hwpt_id_not_work = 0;
 	uint32_t test_hwpt_id = 0;
@@ -344,6 +347,151 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, parent_hwpt_id));
 
+		/* hwpt_invalidate only supports a user-managed hwpt (nested) */
+		num_inv = 1;
+		test_err_hwpt_invalidate(ENOENT, parent_hwpt_id, inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Check data_type by passing zero-length array */
+		num_inv = 0;
+		test_cmd_hwpt_invalidate(nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: Invalid data_type */
+		num_inv = 1;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST_INVALID,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: structure size sanity */
+		num_inv = 1;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs) + 1, &num_inv);
+		assert(!num_inv);
+
+		num_inv = 1;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 1, &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid flag is passed */
+		num_inv = 1;
+		inv_reqs[0].flags = 0xffffffff;
+		test_err_hwpt_invalidate(EOPNOTSUPP, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid data_uptr when array is not empty */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], NULL,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid entry_len when array is not empty */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 0, &num_inv);
+		assert(!num_inv);
+
+		/* Negative test: invalid iotlb_id */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].iotlb_id = MOCK_NESTED_DOMAIN_IOTLB_ID_MAX + 1;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
+		/*
+		 * Invalidate the 1st iotlb entry but fail the 2nd request
+		 * due to invalid flags configuration in the 2nd request.
+		 */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].iotlb_id = 0;
+		inv_reqs[1].flags = 0xffffffff;
+		inv_reqs[1].iotlb_id = 1;
+		test_err_hwpt_invalidate(EOPNOTSUPP, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 0, 0);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 1,
+					  IOMMU_TEST_IOTLB_DEFAULT);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 2,
+					  IOMMU_TEST_IOTLB_DEFAULT);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 3,
+					  IOMMU_TEST_IOTLB_DEFAULT);
+
+		/*
+		 * Invalidate the 1st iotlb entry but fail the 2nd request
+		 * due to invalid iotlb_id configuration in the 2nd request.
+		 */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].iotlb_id = 0;
+		inv_reqs[1].flags = 0;
+		inv_reqs[1].iotlb_id = MOCK_NESTED_DOMAIN_IOTLB_ID_MAX + 1;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 0, 0);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 1,
+					  IOMMU_TEST_IOTLB_DEFAULT);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 2,
+					  IOMMU_TEST_IOTLB_DEFAULT);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 3,
+					  IOMMU_TEST_IOTLB_DEFAULT);
+
+		/* Invalidate the 2nd iotlb entry and verify */
+		num_inv = 1;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].iotlb_id = 1;
+		test_cmd_hwpt_invalidate(nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 0, 0);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 1, 0);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 2,
+					  IOMMU_TEST_IOTLB_DEFAULT);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 3,
+					  IOMMU_TEST_IOTLB_DEFAULT);
+
+		/* Invalidate the 3rd and 4th iotlb entries and verify */
+		num_inv = 2;
+		inv_reqs[0].flags = 0;
+		inv_reqs[0].iotlb_id = 2;
+		inv_reqs[1].flags = 0;
+		inv_reqs[1].iotlb_id = 3;
+		test_cmd_hwpt_invalidate(nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 2);
+		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[0], 0);
+
+		/* Invalidate all iotlb entries for nested_hwpt_id[1] and verify */
+		num_inv = 1;
+		inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL;
+		test_cmd_hwpt_invalidate(nested_hwpt_id[1], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(num_inv == 1);
+		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[1], 0);
+
 		/* Attach device to nested_hwpt_id[0] that then will be busy */
 		test_cmd_mock_domain_replace(self->stdev_id, nested_hwpt_id[0]);
 		EXPECT_ERRNO(EBUSY,
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index fe0a0f566b67..7f41fb796a8a 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -219,6 +219,39 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 			test_cmd_hwpt_check_iotlb(hwpt_id, i, expected);       \
 	})
 
+static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id, void *reqs,
+				     uint32_t data_type, uint32_t lreq,
+				     uint32_t *nreqs)
+{
+	struct iommu_hwpt_invalidate cmd = {
+		.size = sizeof(cmd),
+		.hwpt_id = hwpt_id,
+		.data_type = data_type,
+		.data_uptr = (uint64_t)reqs,
+		.entry_len = lreq,
+		.entry_num = *nreqs,
+	};
+	int rc = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cmd);
+	*nreqs = cmd.entry_num;
+	return rc;
+}
+
+#define test_cmd_hwpt_invalidate(hwpt_id, reqs, data_type, lreq, nreqs)        \
+	({                                                                    \
+		ASSERT_EQ(0,                                                  \
+			  _test_cmd_hwpt_invalidate(self->fd, hwpt_id, reqs,  \
+						    data_type,                 \
+						    lreq, nreqs));            \
+	})
+#define test_err_hwpt_invalidate(_errno, hwpt_id, reqs, data_type, lreq,    \
+				 nreqs)                                    \
+	({                                                                 \
+		EXPECT_ERRNO(_errno,                                       \
+			     _test_cmd_hwpt_invalidate(self->fd, hwpt_id,  \
+						       reqs, data_type,     \
+						       lreq, nreqs));      \
+	})
+
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
 {
-- 
2.34.1


