Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5F7D7B1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 04:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjJZCyP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 22:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjJZCyH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 22:54:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5588182;
        Wed, 25 Oct 2023 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698288838; x=1729824838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GI77uxw5VR1MbYzzDAZm3hnBAc3I7vZ5BHg/97CVfqk=;
  b=c3fdUubD/Bf+pkAyPDua63XQbdwp0F6nqdE6FOJrs4mnItG/ZRmZlSHJ
   xp4mLjBDP6A569Sx93Id7Q3+jmNo5K+J4IY8bv0Rh7EN1TF6RxuackeiR
   cB4fUsU322GgjAuH56xpuSDyxawBhsoNL4FziHa6yghdDhO8n+tOEgB5Z
   e5nvh5I9SgXztapVkMjFDRuI5G6BTssVwcIWZLNDRbIKPsir3uEDXcmhN
   rQIgusYi7kfxasJ/BNhgfO8FRzIZidvh9nDmCWInf1SPvpdUrSB3oNZSq
   q8xgKCzaUrKLlvQfGqF9PbJ3JkrWs4FuNHQIQiU/xfKF78gjmJhwcfOSa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391316220"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="391316220"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 19:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735604571"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="735604571"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2023 19:53:54 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 6/6] iommufd/selftest: Add coverage for IOMMU_TEST_OP_TRIGGER_IOPF
Date:   Thu, 26 Oct 2023 10:49:30 +0800
Message-Id: <20231026024930.382898-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend the selftest tool to add coverage of testing IOPF handling. This
would include the following tests:

- Allocating and destroying an IOPF-capable HWPT.
- Attaching/detaching/replacing an IOPF-capable HWPT on a device.
- Triggering an IOPF on the mock device.
- Retrieving and responding to the IOPF through the IOPF FD

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 66 +++++++++++++++++--
 tools/testing/selftests/iommu/iommufd.c       | 24 +++++--
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 3 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index b75f168fca46..df22c02af997 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -103,8 +103,8 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 							   pt_id, NULL))
 
 static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
-				__u32 flags, __u32 *hwpt_id, __u32 hwpt_type,
-				void *data, size_t data_len)
+				__u32 flags, __u32 *hwpt_id, __u32 *fault_fd,
+				__u32 hwpt_type, void *data, size_t data_len)
 {
 	struct iommu_hwpt_alloc cmd = {
 		.size = sizeof(cmd),
@@ -122,28 +122,39 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 		return ret;
 	if (hwpt_id)
 		*hwpt_id = cmd.out_hwpt_id;
+	if (fault_fd)
+		*fault_fd = cmd.out_fault_fd;
+
 	return 0;
 }
 
 #define test_cmd_hwpt_alloc(device_id, pt_id, flags, hwpt_id)                \
 	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags, \
-					  hwpt_id, IOMMU_HWPT_TYPE_DEFAULT,  \
+					  hwpt_id, NULL,                     \
+					  IOMMU_HWPT_TYPE_DEFAULT,           \
 					  NULL, 0))
 #define test_err_hwpt_alloc(_errno, device_id, pt_id, flags, hwpt_id)         \
 	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, \
-						  flags, hwpt_id,             \
+						  flags, hwpt_id, NULL,       \
 						  IOMMU_HWPT_TYPE_DEFAULT,    \
 						  NULL, 0))
 
 #define test_cmd_hwpt_alloc_nested(device_id, pt_id, flags, hwpt_id,          \
 				   hwpt_type, data, data_len)                 \
 	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags,  \
-					  hwpt_id, hwpt_type, data, data_len))
+					  hwpt_id, NULL, hwpt_type, data,     \
+					  data_len))
 #define test_err_hwpt_alloc_nested(_errno, device_id, pt_id, flags, hwpt_id,  \
 				   hwpt_type, data, data_len)                 \
 	EXPECT_ERRNO(_errno,                                                  \
 		     _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags,  \
-					  hwpt_id, hwpt_type, data, data_len))
+					  hwpt_id, NULL, hwpt_type, data,     \
+					  data_len))
+#define test_cmd_hwpt_alloc_nested_iopf(device_id, pt_id, flags, hwpt_id,     \
+					fault_fd, hwpt_type, data, data_len)  \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags,  \
+					  hwpt_id, fault_fd, hwpt_type, data, \
+					  data_len))
 
 #define test_cmd_hwpt_check_iotlb(hwpt_id, iotlb_id, expected)                 \
 	({                                                                     \
@@ -551,3 +562,46 @@ static int _test_cmd_unset_dev_data(int fd, __u32 device_id)
 #define test_err_unset_dev_data(_errno, device_id) \
 	EXPECT_ERRNO(_errno,                       \
 		     _test_cmd_unset_dev_data(self->fd, device_id))
+
+static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd, __u32 hwpt_id)
+{
+	struct iommu_test_cmd trigger_iopf_cmd = {
+		.size = sizeof(trigger_iopf_cmd),
+		.op = IOMMU_TEST_OP_TRIGGER_IOPF,
+		.trigger_iopf = {
+			.dev_id = device_id,
+			.pasid = 0x1,
+			.grpid = 0x2,
+			.perm = IOMMU_PGFAULT_PERM_READ | IOMMU_PGFAULT_PERM_WRITE,
+			.addr = 0xdeadbeaf,
+		},
+	};
+	struct iommu_hwpt_page_response response = {
+		.size = sizeof(struct iommu_hwpt_page_response),
+		.hwpt_id = hwpt_id,
+		.dev_id = device_id,
+		.pasid = 0x1,
+		.grpid = 0x2,
+		.code = 0,
+	};
+	struct iommu_hwpt_pgfault fault = {};
+	ssize_t bytes;
+	int ret;
+
+	ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_IOPF), &trigger_iopf_cmd);
+	if (ret)
+		return ret;
+
+	bytes = read(fault_fd, &fault, sizeof(fault));
+	if (bytes < 0)
+		return bytes;
+
+	bytes = write(fault_fd, &response, sizeof(response));
+	if (bytes < 0)
+		return bytes;
+
+	return 0;
+}
+
+#define test_cmd_trigger_iopf(device_id, fault_fd, hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, fault_fd, hwpt_id))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 7cf06a4635d8..b30b82a72785 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -275,11 +275,12 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 		.iotlb =  IOMMU_TEST_IOTLB_DEFAULT,
 	};
 	struct iommu_hwpt_invalidate_selftest inv_reqs[2] = {0};
-	uint32_t nested_hwpt_id[2] = {};
+	uint32_t nested_hwpt_id[3] = {};
 	uint32_t num_inv, driver_error;
 	uint32_t parent_hwpt_id = 0;
 	uint32_t parent_hwpt_id_not_work = 0;
 	uint32_t test_hwpt_id = 0;
+	uint32_t fault_fd;
 
 	if (self->device_id) {
 		/* Negative tests */
@@ -323,7 +324,7 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 					   IOMMU_HWPT_TYPE_SELFTEST,
 					   &data, sizeof(data));
 
-		/* Allocate two nested hwpts sharing one common parent hwpt */
+		/* Allocate nested hwpts sharing one common parent hwpt */
 		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
 					   0, &nested_hwpt_id[0],
 					   IOMMU_HWPT_TYPE_SELFTEST,
@@ -332,6 +333,11 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 					   0, &nested_hwpt_id[1],
 					   IOMMU_HWPT_TYPE_SELFTEST,
 					   &data, sizeof(data));
+		test_cmd_hwpt_alloc_nested_iopf(self->device_id, parent_hwpt_id,
+						IOMMU_HWPT_ALLOC_IOPF_CAPABLE,
+						&nested_hwpt_id[2], &fault_fd,
+						IOMMU_HWPT_TYPE_SELFTEST,
+						&data, sizeof(data));
 		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[0],
 					      IOMMU_TEST_IOTLB_DEFAULT);
 		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[1],
@@ -418,10 +424,20 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 			     _test_ioctl_destroy(self->fd, nested_hwpt_id[1]));
 		test_ioctl_destroy(nested_hwpt_id[0]);
 
-		/* Detach from nested_hwpt_id[1] and destroy it */
-		test_cmd_mock_domain_replace(self->stdev_id, parent_hwpt_id);
+		/* Switch from nested_hwpt_id[1] to nested_hwpt_id[2] */
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     nested_hwpt_id[2]);
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, nested_hwpt_id[2]));
 		test_ioctl_destroy(nested_hwpt_id[1]);
 
+		/* Trigger an IOPF on the device */
+		test_cmd_trigger_iopf(self->device_id, fault_fd, nested_hwpt_id[2]);
+
+		/* Detach from nested_hwpt_id[2] and destroy it */
+		test_cmd_mock_domain_replace(self->stdev_id, parent_hwpt_id);
+		test_ioctl_destroy(nested_hwpt_id[2]);
+
 		/* Detach from the parent hw_pagetable and destroy it */
 		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(parent_hwpt_id);
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index d3f47f262c04..2b7b582c17c4 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -615,7 +615,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_cmd_get_hw_info(self->fd, idev_id, &info, sizeof(info)))
 		return -1;
 
-	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, &hwpt_id,
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, &hwpt_id, NULL,
 				 IOMMU_HWPT_TYPE_DEFAULT, 0, 0))
 		return -1;
 
-- 
2.34.1

