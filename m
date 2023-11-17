Return-Path: <linux-kselftest+bounces-247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7557EF368
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 14:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2784E1F2696C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C4E32C6D;
	Fri, 17 Nov 2023 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKAICCHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F2CD6A;
	Fri, 17 Nov 2023 05:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700226448; x=1731762448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/yseFcU7MAcJE8wUttutj1uMPXnZ2HTzdId0S/Tk2J4=;
  b=AKAICCHuBSqs01ok9pz5Wwide7bgv7/c+cpkyKsUsFGZkD6A3K82kL1q
   Qfqgv8nX7IHzqwzETr88/pz9Ebi78P37xJtKJPJ1Y6JpCxtqRXAWPMq66
   QEs3juC+zzpq/Xh2IG5JRD/qC10C+8WtcecyEUArBa+W3J+I+ata6FHeb
   8s0iyfwu/PVwiF+yAqnBqCqHwUTqIxMfF7JM9iFyTAtIXnRnM1tf5Xzlf
   TtKSMy7yvPC3mt8Pp0KpRVUsAOn0aSbdMiNrCt5+DJDSxa4Ft85Pekkzx
   qYQM7ypY4CIQre16Op40jDCOkdtek38LyKvviVuAFs+p9Jkh5gtvM77hY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="388446427"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="388446427"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:07:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="836072069"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="836072069"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2023 05:07:27 -0800
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
Subject: [PATCH v6 5/6] iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
Date: Fri, 17 Nov 2023 05:07:16 -0800
Message-Id: <20231117130717.19875-6-yi.l.liu@intel.com>
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
index 0000f58dcda3..35d6207a96dd 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -21,6 +21,7 @@ enum {
 	IOMMU_TEST_OP_ACCESS_REPLACE_IOAS,
 	IOMMU_TEST_OP_MOCK_DOMAIN_FLAGS,
 	IOMMU_TEST_OP_DIRTY,
+	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 };
 
 enum {
@@ -121,6 +122,10 @@ struct iommu_test_cmd {
 			__aligned_u64 uptr;
 			__aligned_u64 out_nr_dirty;
 		} dirty;
+		struct {
+			__u32 id;
+			__u32 iotlb;
+		} check_iotlb;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 2a9b970ca84e..f2d4599f701b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -836,6 +836,28 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
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
@@ -1317,6 +1339,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
index 6ed328c863c4..c8763b880a16 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -330,6 +330,10 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 					   &nested_hwpt_id[1],
 					   IOMMU_HWPT_DATA_SELFTEST, &data,
 					   sizeof(data));
+		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[0],
+					      IOMMU_TEST_IOTLB_DEFAULT);
+		test_cmd_hwpt_check_iotlb_all(nested_hwpt_id[1],
+					      IOMMU_TEST_IOTLB_DEFAULT);
 
 		/* Negative test: a nested hwpt on top of a nested hwpt */
 		test_err_hwpt_alloc_nested(EINVAL, self->device_id,
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 050e9751321c..69561ba9e7aa 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -195,6 +195,30 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
 		     _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, flags, \
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


