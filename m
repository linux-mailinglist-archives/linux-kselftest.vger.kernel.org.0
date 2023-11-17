Return-Path: <linux-kselftest+bounces-248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A87EF369
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 14:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00502813AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6084C32C79;
	Fri, 17 Nov 2023 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HT+OtEib"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF15D56;
	Fri, 17 Nov 2023 05:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700226450; x=1731762450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H6apQmaq9NvRSCx0sNgfa9w19/tOoRidHmKkQVvY0CM=;
  b=HT+OtEibts0dvr5TU0yVK7d6blZAUGp2LPPt43BTMRODG6sp+gNokq7L
   ku5G9oMIvOsPUXGcVBzWUTXAaBynjOuKZ6OCmWF3m7i4j3on/c3l0fK8q
   PyVhTDAYWvdXFtyFa6zsnPaPlpi+f6SCdqZpHPXc1FAyaYzWvEUitZnkf
   9buF1s4yf9y89HcT2wl2Tfm5M+/8gXjJXGCLB8Bp8EiRLULnTyvsl6Q5c
   pYPPXXXsEZryvwzGjWCtvRESl+wnWmaPp4kw49M+3D57elQ/n1aFWco/X
   2+h2erur+TPGKRA6qq5GarEMQvW4aU8IgPX4gs9SgVKb48iMQ1jvUHNGu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="388446450"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="388446450"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:07:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="836072073"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="836072073"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2023 05:07:28 -0800
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
Subject: [PATCH v6 6/6] iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
Date: Fri, 17 Nov 2023 05:07:17 -0800
Message-Id: <20231117130717.19875-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117130717.19875-1-yi.l.liu@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
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

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 71 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 39 ++++++++++
 2 files changed, 110 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index c8763b880a16..2781d5bc6309 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -116,6 +116,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY, id);
 	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO, __reserved);
 	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC, __reserved);
+	TEST_LENGTH(iommu_hwpt_invalidate, IOMMU_HWPT_INVALIDATE, out_driver_error_code);
 	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC, out_ioas_id);
 	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES,
 		    out_iova_alignment);
@@ -271,7 +272,9 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 	struct iommu_hwpt_selftest data = {
 		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
 	};
+	struct iommu_hwpt_invalidate_selftest inv_reqs[2] = {0};
 	uint32_t nested_hwpt_id[2] = {};
+	uint32_t num_inv, driver_error;
 	uint32_t parent_hwpt_id = 0;
 	uint32_t parent_hwpt_id_not_work = 0;
 	uint32_t test_hwpt_id = 0;
@@ -344,6 +347,74 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, parent_hwpt_id));
 
+		/* hwpt_invalidate only supports a user-managed hwpt (nested) */
+		num_inv = 1;
+		test_err_hwpt_invalidate(ENOENT, parent_hwpt_id, inv_reqs,
+					 IOMMU_HWPT_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv, NULL);
+		/* Negative test: wrong data type */
+		num_inv = 1;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_DATA_NONE,
+					 sizeof(*inv_reqs), &num_inv,
+					 &driver_error);
+		/* Negative test: structure size sanity */
+		num_inv = 1;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_DATA_SELFTEST,
+					 sizeof(*inv_reqs) + 1, &num_inv,
+					 &driver_error);
+		assert(driver_error == IOMMU_TEST_INVALIDATE_ERR_FETCH);
+
+		num_inv = 1;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_DATA_SELFTEST,
+					 1, &num_inv, &driver_error);
+		assert(driver_error == IOMMU_TEST_INVALIDATE_ERR_FETCH);
+
+		/* Invalidate the 1st iotlb entry but fail the 2nd request */
+		num_inv = 2;
+		inv_reqs[0].iotlb_id = 0;
+		inv_reqs[1].iotlb_id = MOCK_NESTED_DOMAIN_IOTLB_ID_MAX + 1;
+		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_DATA_SELFTEST,
+					 sizeof(*inv_reqs), &num_inv,
+					 &driver_error);
+		assert(num_inv == 1);
+		assert(driver_error == IOMMU_TEST_INVALIDATE_ERR_REQ);
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
+		inv_reqs[0].iotlb_id = 1;
+		test_cmd_hwpt_invalidate(nested_hwpt_id[0], inv_reqs,
+					 sizeof(*inv_reqs), &num_inv);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 0, 0);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 1, 0);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 2,
+					  IOMMU_TEST_IOTLB_DEFAULT);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 3,
+					  IOMMU_TEST_IOTLB_DEFAULT);
+		/* Invalidate the 3rd and 4th iotlb entries and verify */
+		num_inv = 2;
+		inv_reqs[0].iotlb_id = 2;
+		inv_reqs[1].iotlb_id = 3;
+		test_cmd_hwpt_invalidate(nested_hwpt_id[0], inv_reqs,
+					 sizeof(*inv_reqs), &num_inv);
+		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[0], 0);
+		/* Invalidate all iotlb entries for nested_hwpt_id[1] and verify */
+		num_inv = 1;
+		inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_ALL;
+		test_cmd_hwpt_invalidate(nested_hwpt_id[1], inv_reqs,
+					 sizeof(*inv_reqs), &num_inv);
+		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[1], 0);
+
 		/* Attach device to nested_hwpt_id[0] that then will be busy */
 		test_cmd_mock_domain_replace(self->stdev_id, nested_hwpt_id[0]);
 		EXPECT_ERRNO(EBUSY,
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 69561ba9e7aa..d4a169a2278e 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -219,6 +219,45 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 			test_cmd_hwpt_check_iotlb(hwpt_id, i, expected);       \
 	})
 
+static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id, void *reqs,
+				     uint32_t req_type, uint32_t lreq,
+				     uint32_t *nreqs, uint32_t *driver_error)
+{
+	struct iommu_hwpt_invalidate cmd = {
+		.size = sizeof(cmd),
+		.hwpt_id = hwpt_id,
+		.req_type = req_type,
+		.reqs_uptr = (uint64_t)reqs,
+		.req_len = lreq,
+		.req_num = *nreqs,
+	};
+	int rc = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cmd);
+	*nreqs = cmd.req_num;
+	if (driver_error)
+		*driver_error = cmd.out_driver_error_code;
+	return rc;
+}
+
+#define test_cmd_hwpt_invalidate(hwpt_id, reqs, lreq, nreqs)                  \
+	({                                                                    \
+		uint32_t error, num = *nreqs;                                 \
+		ASSERT_EQ(0,                                                  \
+			  _test_cmd_hwpt_invalidate(self->fd, hwpt_id, reqs,  \
+						    IOMMU_HWPT_DATA_SELFTEST, \
+						    lreq, nreqs, &error));    \
+		assert(num == *nreqs);                                        \
+		assert(error == 0);                                           \
+	})
+#define test_err_hwpt_invalidate(_errno, hwpt_id, reqs, req_type, lreq,    \
+				 nreqs, driver_error)                      \
+	({                                                                 \
+		EXPECT_ERRNO(_errno,                                       \
+			     _test_cmd_hwpt_invalidate(self->fd, hwpt_id,  \
+						       reqs, req_type,     \
+						       lreq, nreqs,        \
+						       driver_error));     \
+	})
+
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
 {
-- 
2.34.1


