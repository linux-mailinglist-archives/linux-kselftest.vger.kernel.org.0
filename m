Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1597D0B6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376691AbjJTJUd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376581AbjJTJUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:20:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4966410CC;
        Fri, 20 Oct 2023 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793607; x=1729329607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shTI2KMyyslAvE3tCPkiK5CdJon8vMT9e7Gflk4kpKk=;
  b=llrQ4tFwmRnv2BGeQNHztNWH71wHDSbyju48FL927vdjHx5YWHI6zyUk
   92aQ5VHXdkeC0gH2M2OKjcszeq9l8rdMFymtOXzzTYUFgMdajkqDL59lj
   4o+JyHN+fg4ISGpTH/9LKWcK0EGGoUEzZhvmxzTXonyb44koB5/Xy64h+
   7l+wagTtP0KTSZ9cc8xSYE98kIEmrscXabveRJSQ9YVgDAzkn8rpFbUhi
   FE5bV0JMX6H2zN78ofWXNhA8XZ26+jELFnzDvLPH0GNXqbR+Af+Wt+ti9
   BBIaXBKu9DVxOMwe41imymkAQbWjklizw1v/t8apmKMORptSlIGnI77RB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366693448"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366693448"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707179481"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707179481"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:20:04 -0700
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
Subject: [PATCH v5 10/10] iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with nested HWPTs
Date:   Fri, 20 Oct 2023 02:19:46 -0700
Message-Id: <20231020091946.12173-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020091946.12173-1-yi.l.liu@intel.com>
References: <20231020091946.12173-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

The IOMMU_HWPT_ALLOC ioctl now supports passing user_data to allocate a
user-managed domain for nested HWPTs. Add its coverage for that. Also,
update _test_cmd_hwpt_alloc() and add test_cmd/err_hwpt_alloc_nested().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 120 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |   3 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  31 ++++-
 3 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 6323153d277b..7ab9ca06460d 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -264,6 +264,126 @@ TEST_F(iommufd_ioas, ioas_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, alloc_hwpt_nested)
+{
+	const uint32_t min_data_len =
+		offsetofend(struct iommu_hwpt_selftest, iotlb);
+	struct iommu_hwpt_selftest data = {
+		.iotlb =  IOMMU_TEST_IOTLB_DEFAULT,
+	};
+	uint32_t nested_hwpt_id[2] = {};
+	uint32_t parent_hwpt_id = 0;
+	uint32_t parent_hwpt_id_not_work = 0;
+	uint32_t test_hwpt_id = 0;
+
+	if (self->device_id) {
+		/* Negative tests */
+		test_err_hwpt_alloc(ENOENT, self->ioas_id, self->device_id,
+				    0, &test_hwpt_id);
+		test_err_hwpt_alloc(EINVAL, self->device_id,
+				    self->device_id, 0, &test_hwpt_id);
+
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT,
+				    &parent_hwpt_id);
+
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+				    0, &parent_hwpt_id_not_work);
+
+		/* Negative nested tests */
+		test_err_hwpt_alloc_nested(EINVAL,
+					   self->device_id, parent_hwpt_id,
+					   0, &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_NONE,
+					   &data, sizeof(data));
+		test_err_hwpt_alloc_nested(EOPNOTSUPP,
+					   self->device_id, parent_hwpt_id,
+					   0, &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST + 1,
+					   &data, sizeof(data));
+		test_err_hwpt_alloc_nested(EINVAL,
+					   self->device_id, parent_hwpt_id,
+					   0, &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST,
+					   &data, min_data_len - 1);
+		test_err_hwpt_alloc_nested(EFAULT,
+					   self->device_id, parent_hwpt_id,
+					   0, &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST,
+					   NULL, sizeof(data));
+		test_err_hwpt_alloc_nested(EOPNOTSUPP,
+					   self->device_id, parent_hwpt_id,
+					   IOMMU_HWPT_ALLOC_NEST_PARENT,
+					   &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST,
+					   &data, sizeof(data));
+		test_err_hwpt_alloc_nested(EINVAL, self->device_id,
+					   parent_hwpt_id_not_work,
+					   0, &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST,
+					   &data, sizeof(data));
+
+		/* Allocate two nested hwpts sharing one common parent hwpt */
+		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
+					   0, &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST,
+					   &data, sizeof(data));
+		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
+					   0, &nested_hwpt_id[1],
+					   IOMMU_HWPT_DATA_SELFTEST,
+					   &data, sizeof(data));
+
+		/* Negative test: a nested hwpt on top of a nested hwpt */
+		test_err_hwpt_alloc_nested(EINVAL,
+					   self->device_id, nested_hwpt_id[0],
+					   0, &test_hwpt_id,
+					   IOMMU_HWPT_DATA_SELFTEST,
+					   &data, sizeof(data));
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
+		test_ioctl_destroy(parent_hwpt_id_not_work);
+	} else {
+		test_err_hwpt_alloc(ENOENT, self->device_id, self->ioas_id,
+				    0, &parent_hwpt_id);
+		test_err_hwpt_alloc_nested(ENOENT,
+					   self->device_id, parent_hwpt_id,
+					   0, &nested_hwpt_id[0],
+					   IOMMU_HWPT_DATA_SELFTEST,
+					   &data, sizeof(data));
+		test_err_hwpt_alloc_nested(ENOENT,
+					   self->device_id, parent_hwpt_id,
+					   0, &nested_hwpt_id[1],
+					   IOMMU_HWPT_DATA_SELFTEST,
+					   &data, sizeof(data));
+		test_err_mock_domain_replace(ENOENT,
+					     self->stdev_id, nested_hwpt_id[0]);
+		test_err_mock_domain_replace(ENOENT,
+					     self->stdev_id, nested_hwpt_id[1]);
+	}
+}
+
 TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 31386be42439..2a3b45d49700 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -615,7 +615,8 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	if (_test_cmd_get_hw_info(self->fd, idev_id, &info, sizeof(info)))
 		return -1;
 
-	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, &hwpt_id))
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0, &hwpt_id,
+				 IOMMU_HWPT_DATA_NONE, 0, 0))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index be4970a84977..1a5fa44b1627 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -103,13 +103,17 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 							   pt_id, NULL))
 
 static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
-				__u32 flags, __u32 *hwpt_id)
+				__u32 flags, __u32 *hwpt_id, __u32 data_type,
+				void *data, size_t data_len)
 {
 	struct iommu_hwpt_alloc cmd = {
 		.size = sizeof(cmd),
 		.flags = flags,
 		.dev_id = device_id,
 		.pt_id = pt_id,
+		.data_type = data_type,
+		.data_len = data_len,
+		.data_uptr = (uint64_t)data,
 	};
 	int ret;
 
@@ -121,12 +125,25 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 	return 0;
 }
 
-#define test_cmd_hwpt_alloc(device_id, pt_id, flags, hwpt_id) \
-	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, \
-					  pt_id, flags, hwpt_id))
-#define test_err_hwpt_alloc(_errno, device_id, pt_id, flags, hwpt_id) \
-	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(self->fd, device_id, \
-						  pt_id, flags, hwpt_id))
+#define test_cmd_hwpt_alloc(device_id, pt_id, flags, hwpt_id)                \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags, \
+					  hwpt_id, IOMMU_HWPT_DATA_NONE,     \
+					  NULL, 0))
+#define test_err_hwpt_alloc(_errno, device_id, pt_id, flags, hwpt_id)         \
+	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, \
+						  flags, hwpt_id,             \
+						  IOMMU_HWPT_DATA_NONE,       \
+						  NULL, 0))
+
+#define test_cmd_hwpt_alloc_nested(device_id, pt_id, flags, hwpt_id,          \
+				   data_type, data, data_len)                 \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags,  \
+					  hwpt_id, data_type, data, data_len))
+#define test_err_hwpt_alloc_nested(_errno, device_id, pt_id, flags, hwpt_id,  \
+				   data_type, data, data_len)                 \
+	EXPECT_ERRNO(_errno,                                                  \
+		     _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags,  \
+					  hwpt_id, data_type, data, data_len))
 
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
-- 
2.34.1

