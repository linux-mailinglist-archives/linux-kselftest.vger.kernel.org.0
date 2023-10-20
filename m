Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A048B7D0BA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376773AbjJTJZJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376708AbjJTJYv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:24:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF282D5E;
        Fri, 20 Oct 2023 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793874; x=1729329874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CDuEodg+jMw+x43UiLiPo7Jd4ccwMA7AswFl0BfqSXI=;
  b=WP2EtZGyb2oFKMK8cybG6oSI+Nwv+r8bJgmqzzkbfpo7Z/TapTR5I+W5
   SfBuGKUbPz/IMYB9ew0Wu0sx8s0Ye9y+7eHSawqVxh+fbvIRAdkael17j
   h6D1LOrJfe7OmPE9OLba9B6K8tmiLq9/lqXEoTbG0TMgKmeKQUNFWmhiE
   TILq9WQUSdK2MvthXFvr0LsOBc/ElZbpS8loy6TzVKiv/XG6yk5w4Qmsk
   rHLN7TprL453btE4TvqjG1TmOacwcLXKLkb56sbjEeEA0t2jDcPJt7M+J
   ttei3OiRf24B0gp5UR20zGg0vgsYg1FKYBG0jzh4sBqXg17J/c/zEGNHz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472685547"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472685547"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750859688"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750859688"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga007.jf.intel.com with ESMTP; 20 Oct 2023 02:24:31 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com
Subject: [PATCH v5 6/6] iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
Date:   Fri, 20 Oct 2023 02:24:26 -0700
Message-Id: <20231020092426.13907-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020092426.13907-1-yi.l.liu@intel.com>
References: <20231020092426.13907-1-yi.l.liu@intel.com>
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
index e0c66e70d978..456c89eb8bd1 100644
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
 		.iotlb =  IOMMU_TEST_IOTLB_DEFAULT,
 	};
+	struct iommu_hwpt_invalidate_selftest inv_reqs[2] = {0};
 	uint32_t nested_hwpt_id[2] = {};
+	uint32_t num_inv, driver_error;
 	uint32_t parent_hwpt_id = 0;
 	uint32_t parent_hwpt_id_not_work = 0;
 	uint32_t test_hwpt_id = 0;
@@ -347,6 +350,74 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
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
 		test_cmd_mock_domain_replace(self->stdev_id,
 					     nested_hwpt_id[0]);
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index ef7a346dba3a..2e9eb53a1924 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -169,6 +169,45 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
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

