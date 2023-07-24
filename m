Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41EA75F46C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjGXLGA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjGXLFm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:05:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF2F1BC3;
        Mon, 24 Jul 2023 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196725; x=1721732725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A2LaVc0RXcdBJTdftWm15aTLtP5VHqA4B+E9J8h6wDI=;
  b=lPFvVkdPn6ncj2S4692/P+ZYJNuln/EvyPT9n3u1mTm5uFiyBqAB46Jf
   mBgwrj9woz/4SbKhApbJ2YP62u6QvPCgr8w5R06Qm7g0f0+Nc13f1iLho
   x82rKAeA65+7+dP/K+4TzBWVZ3hFreFETbGwfFxpLOtxfa/oYQe0RNY2/
   tIh6DkaA/mkx4FhSGNtDywSZisGe5ZNmDkNUcKEXKwR8FjLJ0Lya0uJJh
   av9VTT6mXJRmibZpQUQpwgopbofLoQtafT+KQN2X0j5dEaGMqgCicIolq
   OoXdw6PikeRpHjPu3ArCS+9pms3VpbFsaY6+4UOuRpI7Di0Y5IHJNUsvp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013358"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013358"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775893"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775893"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:24 -0700
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
Subject: [PATCH v3 16/17] iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
Date:   Mon, 24 Jul 2023 04:04:05 -0700
Message-Id: <20230724110406.107212-17-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

This allows to test whether IOTLB has been invalidated or not.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 ++++
 drivers/iommu/iommufd/selftest.c              | 22 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  4 ++++
 tools/testing/selftests/iommu/iommufd_utils.h | 14 ++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index eeac8100844d..93fcbb57b904 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -21,6 +21,7 @@ enum {
 	IOMMU_TEST_OP_ACCESS_REPLACE_IOAS,
 	IOMMU_TEST_OP_DEV_ADD_RESERVED,
 	IOMMU_TEST_OP_DEV_DEL_RESERVED,
+	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 };
 
 enum {
@@ -101,6 +102,9 @@ struct iommu_test_cmd {
 		struct {
 			__u32 ioas_id;
 		} access_replace_ioas;
+		struct {
+			__u32 iotlb;
+		} check_iotlb;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8364003efde3..92c37716804e 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -795,6 +795,25 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
+static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
+				       u32 mockpt_id, u32 iotlb)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	int rc = 0;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	mock = container_of(hwpt->domain, struct mock_iommu_domain, domain);
+
+	if (iotlb != mock->iotlb)
+		rc = -EINVAL;
+	iommufd_put_object(&hwpt->obj);
+	return rc;
+}
+
 struct selftest_access {
 	struct iommufd_access *access;
 	struct file *file;
@@ -1214,6 +1233,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_md_check_refs(
 			ucmd, u64_to_user_ptr(cmd->check_refs.uptr),
 			cmd->check_refs.length, cmd->check_refs.refs);
+	case IOMMU_TEST_OP_MD_CHECK_IOTLB:
+		return iommufd_test_md_check_iotlb(ucmd, cmd->id,
+						   cmd->check_iotlb.iotlb);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd, cmd->id,
 						  cmd->create_access.flags);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 70116c2dfc94..942860365cb6 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -310,6 +310,10 @@ TEST_F(iommufd_ioas, nested_hwpt_alloc)
 					   &nested_hwpt_id[0]);
 		test_cmd_hwpt_alloc_nested(self->device_id, parent_hwpt_id,
 					   &nested_hwpt_id[1]);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[0],
+					  IOMMU_TEST_IOTLB_DEFAULT);
+		test_cmd_hwpt_check_iotlb(nested_hwpt_id[1],
+					  IOMMU_TEST_IOTLB_DEFAULT);
 
 		/* Negative test: a nested hwpt on top of a nested hwpt */
 		test_err_cmd_hwpt_alloc_nested(EINVAL, self->device_id,
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 365fa3da2016..5e75dfac65e9 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -122,6 +122,20 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 	EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(self->fd, device_id, \
 						  pt_id, hwpt_id))
 
+#define test_cmd_hwpt_check_iotlb(hwpt_id, expected)                           \
+	({                                                                     \
+		struct iommu_test_cmd test_cmd = {                             \
+			.size = sizeof(test_cmd),                              \
+			.op = IOMMU_TEST_OP_MD_CHECK_IOTLB,                    \
+			.id = hwpt_id,                                         \
+			.check_iotlb = { .iotlb = expected },                  \
+		};                                                             \
+		ASSERT_EQ(0,                                                   \
+			  ioctl(self->fd,                                      \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_IOTLB), \
+				&test_cmd));                                   \
+	})
+
 static int _test_cmd_hwpt_alloc_nested(int fd, __u32 device_id, __u32 parent_id,
 				       __u32 *hwpt_id)
 {
-- 
2.34.1

