Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AAB6B1D94
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjCIIMm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCIILu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:11:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE4E20C1;
        Thu,  9 Mar 2023 00:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349421; x=1709885421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C4LaUzIKNDTM/Z5R5uU/50kK5Lu4e+7iggD/P2dtuk4=;
  b=KWIrskr7S+vyuX7JOw/IZvjv/HYhp2O8DNMsZrWiDfLvDE5/ftD1sc3A
   gGWCUOYWcw8TuQePJ+bCFEibbxQ138fLRsYZcx2oM/4kN4ZeAWNX6eWuL
   hQK+Jo/YN5yipw9o/TLeAf9Qn6/KiTB2iW9DXZVCv8Ypa2VVBHwa8/1rf
   3h6+8sL3U6ULBJY6roAZNEhHLvrLlxSmNwMiUcPjcSG7rXTpsdh5zKarT
   5XmcxkCNGVYS27pDMPvutoRGP2EB2lSmQ1sAqDM1T7y7eeRfq39FA0v3T
   JRgexqQ6Sd40XFs88CDjQ4QdHeK7M5Imz3ReBhGsurRr5IBiZqM8d4LnJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023258"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023258"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471446"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471446"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:45 -0800
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 11/12] iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
Date:   Thu,  9 Mar 2023 00:09:09 -0800
Message-Id: <20230309080910.607396-12-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 8bbb4f4fa1d7..4b60a6df0428 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -19,6 +19,7 @@ enum {
 	IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
 	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
 	IOMMU_TEST_OP_ACCESS_SET_IOAS,
+	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 };
 
 enum {
@@ -95,6 +96,9 @@ struct iommu_test_cmd {
 		struct {
 			__u32 ioas_id;
 		} access_set_ioas;
+		struct {
+			__u32 iotlb;
+		} check_iotlb;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index b9c7f3bf64b5..a0d57f00f759 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -667,6 +667,25 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
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
@@ -1077,6 +1096,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_md_check_refs(
 			ucmd, u64_to_user_ptr(cmd->check_refs.uptr),
 			cmd->check_refs.length, cmd->check_refs.refs);
+	case IOMMU_TEST_OP_MD_CHECK_IOTLB:
+		return iommufd_test_md_check_iotlb(ucmd, cmd->id,
+						   cmd->check_iotlb.iotlb);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd,
 						  cmd->create_access.flags);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 783afd6ccd2e..10f1592dc9e7 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -313,6 +313,10 @@ TEST_F(iommufd_ioas, nested_hwpt_alloc)
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
index e0e484e1c775..211798190e5b 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -120,6 +120,20 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
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

