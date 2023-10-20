Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE41D7D0BA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376736AbjJTJZA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376694AbjJTJYp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:24:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1C8D5A;
        Fri, 20 Oct 2023 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793874; x=1729329874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mesj9VsQ2q8HSWMcHXIgOJYVRv65WYH80rYMTqkoSts=;
  b=lpKKZ50kwxMbxmWEBX38AdiYa6a5F1NGAXKjeYkYpxjHANH6DevFq0VJ
   gI1i/sHOAozLt/gf6yxzHv1jWyrpzCWPe8orZ6RfAOddQgdK8DB0EgSDJ
   jGFJT1siXKJlH8zT/6PpyK3KmAAEHDidl3cLvK435BHKgt7T+35tlKLYE
   OhfZWpvWRa8IrLp+74VRU4IYmNC+MBdhQwwsgkwSVf4rvNH4P3EEUzjb0
   /7rnExTQJZKXYU0mQRWj3+1F+pnMEsJhUfd27YRRv4cXQc0kcDwOpqcye
   y+Nalb12Y3DJtUQoFI2+UaHWLzSgMQkKtxRzb5SDYm0BpDXIMiBrjdCPE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472685531"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472685531"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750859685"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750859685"
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
Subject: [PATCH v5 5/6] iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
Date:   Fri, 20 Oct 2023 02:24:25 -0700
Message-Id: <20231020092426.13907-6-yi.l.liu@intel.com>
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

Allow to test whether IOTLB has been invalidated or not.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  5 ++++
 drivers/iommu/iommufd/selftest.c              | 26 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  4 +++
 tools/testing/selftests/iommu/iommufd_utils.h | 24 +++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index a96838516db9..9cf82d242aa6 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -19,6 +19,7 @@ enum {
 	IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
 	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
 	IOMMU_TEST_OP_ACCESS_REPLACE_IOAS,
+	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 };
 
 enum {
@@ -100,6 +101,10 @@ struct iommu_test_cmd {
 		struct {
 			__u32 ioas_id;
 		} access_replace_ioas;
+		struct {
+			__u32 id;
+			__u32 iotlb;
+		} check_iotlb;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index abd942cf3a79..112a934cbaca 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -759,6 +759,28 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
+static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
+				       u32 mockpt_id, unsigned int iotlb_id,
+				       u32 iotlb)
+{
+	struct mock_iommu_domain_nested *mock_nested;
+	struct iommufd_hw_pagetable *hwpt;
+	int rc = 0;
+
+	hwpt = get_md_pagetable_nested(ucmd, mockpt_id, &mock_nested);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	mock_nested = container_of(hwpt->domain,
+				   struct mock_iommu_domain_nested, domain);
+
+	if (iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX ||
+	    mock_nested->iotlb[iotlb_id] != iotlb)
+		rc = -EINVAL;
+	iommufd_put_object(&hwpt->obj);
+	return rc;
+}
+
 struct selftest_access {
 	struct iommufd_access *access;
 	struct file *file;
@@ -1172,6 +1194,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_md_check_refs(
 			ucmd, u64_to_user_ptr(cmd->check_refs.uptr),
 			cmd->check_refs.length, cmd->check_refs.refs);
+	case IOMMU_TEST_OP_MD_CHECK_IOTLB:
+		return iommufd_test_md_check_iotlb(ucmd, cmd->id,
+						   cmd->check_iotlb.id,
+						   cmd->check_iotlb.iotlb);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd, cmd->id,
 						  cmd->create_access.flags);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 7ab9ca06460d..e0c66e70d978 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -332,6 +332,10 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 					   0, &nested_hwpt_id[1],
 					   IOMMU_HWPT_DATA_SELFTEST,
 					   &data, sizeof(data));
+		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[0],
+					      IOMMU_TEST_IOTLB_DEFAULT);
+		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[1],
+					      IOMMU_TEST_IOTLB_DEFAULT);
 
 		/* Negative test: a nested hwpt on top of a nested hwpt */
 		test_err_hwpt_alloc_nested(EINVAL,
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 1a5fa44b1627..ef7a346dba3a 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -145,6 +145,30 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 		     _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags,  \
 					  hwpt_id, data_type, data, data_len))
 
+#define test_cmd_hwpt_check_iotlb(hwpt_id, iotlb_id, expected)                 \
+	({                                                                     \
+		struct iommu_test_cmd test_cmd = {                             \
+			.size = sizeof(test_cmd),                              \
+			.op = IOMMU_TEST_OP_MD_CHECK_IOTLB,                    \
+			.id = hwpt_id,                                         \
+			.check_iotlb = {                                       \
+				.id = iotlb_id,                                \
+				.iotlb = expected,                             \
+			},                                                     \
+		};                                                             \
+		ASSERT_EQ(0,                                                   \
+			  ioctl(self->fd,                                      \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_IOTLB), \
+				&test_cmd));                                   \
+	})
+
+#define test_cmd_hwpt_check_iotlb_all(hwpt_id, expected)                       \
+	({                                                                     \
+		int i;                                                         \
+		for (i = 0; i < MOCK_NESTED_DOMAIN_IOTLB_NUM; i++)             \
+			test_cmd_hwpt_check_iotlb(hwpt_id, i, expected);       \
+	})
+
 static int _test_cmd_access_replace_ioas(int fd, __u32 access_id,
 					 unsigned int ioas_id)
 {
-- 
2.34.1

