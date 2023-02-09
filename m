Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058E568FF55
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjBIEfh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjBIEeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:34:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC04FC2C;
        Wed,  8 Feb 2023 20:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917177; x=1707453177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WFAZ2ai988Yvo1tUCVx+g/DUVXVhbex9a2lBtxGx98Y=;
  b=RbLg8yjZmdDL7qc2x6OZpqAaLt2OLbQrmdfION7bAjzRVo+T3NQWKaYw
   8iup/B0Jg590VHka0kbry5auTSg4X+dM3dTZkqMoujqxprItgQOyMl3Rp
   JU8z2QquTV8cpjOmLIujoN8CpkFHDoOhbUAoOwKLkb880j7rfom0aho2J
   SFKMBX3zvi/H+9GEFGvAZSsttw2NoVPCuRvHtiasHeVqK81FAOUxh1tkj
   wQCgroTm/gQuIcCcwK/rwpxdW/evMlByGzUavFVlyk0UanwVFRu4kJM0+
   LJQj0TUKB8gpFMJTybGlkiD06wB9PIDs2NEgrX4zqT4b/T/+Ee0ZfN5s3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298891"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298891"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447630"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447630"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:27 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: [PATCH 16/17] iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
Date:   Wed,  8 Feb 2023 20:31:52 -0800
Message-Id: <20230209043153.14964-17-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/iommufd_test.h          |  4 +++
 drivers/iommu/iommufd/selftest.c              | 22 +++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 27 +++++++++++++++----
 3 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 842b81397a2a..5998c63a89f2 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -13,6 +13,7 @@ enum {
 	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
 	IOMMU_TEST_OP_MD_CHECK_MAP,
 	IOMMU_TEST_OP_MD_CHECK_REFS,
+	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_CREATE_ACCESS,
 	IOMMU_TEST_OP_ACCESS_SET_IOAS,
 	IOMMU_TEST_OP_DESTROY_ACCESS_PAGES,
@@ -68,6 +69,9 @@ struct iommu_test_cmd {
 			__aligned_u64 uptr;
 			__u32 refs;
 		} check_refs;
+		struct {
+			__u32 iotlb;
+		} check_iotlb;
 		struct {
 			__u32 out_access_fd;
 			__u32 flags;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 354a0054afad..21134000bc78 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -536,6 +536,25 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
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
@@ -950,6 +969,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_md_check_refs(
 			ucmd, u64_to_user_ptr(cmd->check_refs.uptr),
 			cmd->check_refs.length, cmd->check_refs.refs);
+	case IOMMU_TEST_OP_MD_CHECK_IOTLB:
+		return iommufd_test_md_check_iotlb(ucmd, cmd->id,
+						   cmd->check_iotlb.iotlb);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd,
 						  cmd->create_access.flags);
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index cb8a5e3beca6..ea61b81fbc52 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -189,6 +189,20 @@ static int _test_ioctl_ioas_alloc(int fd, __u32 *id)
 		ASSERT_NE(0, *(id));                                \
 	})
 
+#define test_ioctl_hwpt_check_iotlb(hwpt_id, expected)                         \
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
 static int _test_ioctl_hwpt_alloc(int fd, __u32 pt_id, __u32 dev_id,
 				  __u32 *out_hwpt_id, bool nested)
 {
@@ -213,11 +227,14 @@ static int _test_ioctl_hwpt_alloc(int fd, __u32 pt_id, __u32 dev_id,
 	return 0;
 }
 
-#define test_ioctl_hwpt_alloc(pt_id, dev_id, out_hwpt_id, nested)            \
-	({                                                                   \
-		ASSERT_EQ(0, _test_ioctl_hwpt_alloc(self->fd, pt_id, dev_id, \
-						    out_hwpt_id, nested));   \
-		ASSERT_NE(0, *(out_hwpt_id));                                \
+#define test_ioctl_hwpt_alloc(pt_id, dev_id, out_hwpt_id, nested)              \
+	({                                                                     \
+		ASSERT_EQ(0, _test_ioctl_hwpt_alloc(self->fd, pt_id, dev_id,   \
+						    out_hwpt_id, nested));     \
+		ASSERT_NE(0, *(out_hwpt_id));                                  \
+		if (nested)                                                    \
+			test_ioctl_hwpt_check_iotlb(*(out_hwpt_id),            \
+						    IOMMU_TEST_IOTLB_DEFAULT); \
 	})
 #define test_err_ioctl_hwpt_alloc(_errno, pt_id, dev_id, out_hwpt_id, nested) \
 	({                                                                    \
-- 
2.34.1

