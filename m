Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01106FF4C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbjEKOnB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbjEKOmf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:42:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096211569;
        Thu, 11 May 2023 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815935; x=1715351935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AB/V+lOcmgiua42crOM5BnIdwENlAyxry4E4lQjQqZw=;
  b=Rr3708i8GzoJIrkMtm5IHsfGcqxS2VgOenRPnfdqoz3VpUQYeAmSy0UU
   mmXgqlu6yYZNTMYiY8UeI2lGZ73Y2OIeu+1yRz/xuRr2u2Uki2hKJSISV
   ud8sDhUIRTNlv9d3T5dbFGa0P0Rh6Vas7nchFoan+enzcoADgyURgtZ1J
   dAivKkhJDD/MX9YzeGURvHBAUOiwvzwv+WwuNXe2fFscoGEFBr46Z3cdr
   4DtcGhODOMsyCuHIVr22miCzgVhkiZBn6CuSw4XFrRuux0dlFgU39JyqP
   /T3tkZFDHj8DEZz0ZT04AM/cnRX9xHeNxsf4NF0rb1LEB37Dd3ZgffG3j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="339812989"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="339812989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730382644"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="730382644"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 07:38:54 -0700
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
Subject: [PATCH v2 11/11] iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
Date:   Thu, 11 May 2023 07:38:44 -0700
Message-Id: <20230511143844.22693-12-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511143844.22693-1-yi.l.liu@intel.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Add a mock_domain_cache_invalidate_user() and a corresponding struct
iommu_hwpt_invalidate_selftest, to allow to test IOMMU_HWPT_INVALIDATE
from user space, by using the new IOMMU_TEST_OP_MD_CHECK_IOTLB.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          | 10 ++++++++++
 drivers/iommu/iommufd/selftest.c              | 19 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  8 ++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 20 +++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index ec904931df69..c5ca69bd07d1 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -129,4 +129,14 @@ struct iommu_hwpt_selftest {
 	__u64 test_config;
 };
 
+/**
+ * struct iommu_hwpt_invalidate_selftest
+ *
+ * @flags: invalidate flags
+ */
+struct iommu_hwpt_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_ALL	(1ULL << 0)
+	__u64 flags;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 57530e7d9524..3c0051442b4d 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -362,9 +362,28 @@ static const struct iommu_ops mock_ops = {
 		},
 };
 
+static int mock_domain_cache_invalidate_user(struct iommu_domain *domain,
+					     void *user_data)
+{
+	struct iommu_hwpt_invalidate_selftest *inv_info = user_data;
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+
+	if (domain->type != IOMMU_DOMAIN_NESTED || !mock->parent)
+		return -EINVAL;
+
+	if (inv_info->flags & IOMMU_TEST_INVALIDATE_ALL)
+		mock->iotlb = 0;
+
+	return 0;
+}
+
 static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free,
 	.attach_dev = mock_domain_nop_attach,
+	.cache_invalidate_user = mock_domain_cache_invalidate_user,
+	.cache_invalidate_user_data_len =
+		sizeof(struct iommu_hwpt_invalidate_selftest),
 };
 
 static struct iommu_device mock_iommu_device = {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index afbe23cecb54..031e222cebf9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -123,6 +123,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
 	TEST_LENGTH(iommu_hw_info, IOMMU_DEVICE_GET_HW_INFO);
 	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC);
+	TEST_LENGTH(iommu_hwpt_invalidate, IOMMU_HWPT_INVALIDATE);
 #undef TEST_LENGTH
 }
 
@@ -323,6 +324,13 @@ TEST_F(iommufd_ioas, nested_hwpt_alloc)
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, parent_hwpt_id));
 
+		/* hwpt_invalidate only supports a user-managed hwpt (nested) */
+		test_err_cmd_hwpt_invalidate(EINVAL, parent_hwpt_id);
+		test_cmd_hwpt_invalidate(nested_hwpt_id[0]);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0], 0);
+		test_cmd_hwpt_invalidate(nested_hwpt_id[1]);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[1], 0);
+
 		/* Attach device to nested_hwpt_id[0] that then will be busy */
 		test_cmd_mock_domain_replace(self->stdev_id,
 					     nested_hwpt_id[0]);
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 7d9efe3f7e0d..fef17fb46160 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -169,6 +169,26 @@ static int _test_cmd_hwpt_alloc_nested(int fd, __u32 device_id, __u32 parent_id,
 		     _test_cmd_hwpt_alloc_nested(self->fd, device_id,         \
 						 parent_id, hwpt_id))
 
+static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id)
+{
+	struct iommu_hwpt_invalidate_selftest data = {
+		.flags = IOMMU_TEST_INVALIDATE_ALL,
+	};
+	struct iommu_hwpt_invalidate cmd = {
+		.size = sizeof(cmd),
+		.hwpt_id = hwpt_id,
+		.data_len = sizeof(data),
+		.data_uptr = (uint64_t)&data,
+	};
+
+	return ioctl(fd, IOMMU_HWPT_INVALIDATE, &cmd);
+}
+
+#define test_cmd_hwpt_invalidate(hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_hwpt_invalidate(self->fd, hwpt_id))
+#define test_err_cmd_hwpt_invalidate(_errno, hwpt_id) \
+	EXPECT_ERRNO(_errno, _test_cmd_hwpt_invalidate(self->fd, hwpt_id))
+
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
 {
-- 
2.34.1

