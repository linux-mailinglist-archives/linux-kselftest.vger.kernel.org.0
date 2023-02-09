Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD49968FF4E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjBIEfH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjBIEez (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:34:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337EF518F4;
        Wed,  8 Feb 2023 20:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917185; x=1707453185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dlcR+UhuTmADspR4+oiL3WW4I/8TuCAOY+usI2kEQJs=;
  b=dl4CrnpInnfB/CgOV3sCGlp5pQoFvOOqhpr8Kf8euXYo/gDGa5CoSyRk
   RL/m1W59lTZ0PL8kInEFL42M1koA+3HvVyndT16uiuB6weaGJFYvncZdl
   F5U7KrOMi+fksieh/4+EeCYU7F7egoK7AGQD3wsx7A0LLTua7S0Rux/mZ
   NihIZavUf1KTfZPd6bmDJryOZWo/6RiJfrXK9i8Re1uvCNeyQ8Sir6GTV
   5WiM1LE3xbRa/RJlhvjQ9gLs86B5VFAkLxbpw637CEhU/Sek+YNUJXPk4
   8JEhO4TRNbqcUzpJuOEtM14B4qxbJczJi7iEhLWEgDwXczIsSk7IiFHiw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298915"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298915"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447643"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447643"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:29 -0800
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
Subject: [PATCH 17/17] iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
Date:   Wed,  8 Feb 2023 20:31:53 -0800
Message-Id: <20230209043153.14964-18-yi.l.liu@intel.com>
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

This only adds limited sanity.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c          |  7 ++++++-
 drivers/iommu/iommufd/iommufd_test.h          | 10 +++++++++
 drivers/iommu/iommufd/selftest.c              | 15 +++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  8 +++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++++++++++++
 5 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 1f1940969b2b..86864a3e170e 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -283,7 +283,12 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		goto out_put_hwpt;
 	}
 
-	klen = iommufd_hwpt_invalidate_info_size[cmd->data_type];
+	if (cmd->data_type != IOMMU_PGTBL_DATA_SELFTTEST)
+		klen = iommufd_hwpt_invalidate_info_size[cmd->data_type];
+#ifdef CONFIG_IOMMUFD_TEST
+	else
+		klen = sizeof(struct iommu_hwpt_invalidate_selftest);
+#endif
 	if (!klen) {
 		rc = -EINVAL;
 		goto out_put_hwpt;
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 5998c63a89f2..4913884a8b24 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -134,4 +134,14 @@ struct iommu_hwpt_selftest {
 	__u64 test_config;
 };
 
+/**
+ * struct iommu_hwpt_invalidate_selftest
+ *
+ * @flags: invalidate flags
+ */
+struct iommu_hwpt_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_ALL	(1 << 0)
+	__u64 flags;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 21134000bc78..06b5e8829488 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -283,6 +283,20 @@ static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
 	return (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE;
 }
 
+static void mock_domain_iotlb_sync_user(struct iommu_domain *domain,
+					void *user_data)
+{
+	struct iommu_hwpt_invalidate_selftest *inv_info = user_data;
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+
+	if (domain->type != IOMMU_DOMAIN_NESTED || !mock->parent)
+		return;
+
+	if (inv_info->flags & IOMMU_TEST_INVALIDATE_ALL)
+		mock->iotlb = 0;
+}
+
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
@@ -301,6 +315,7 @@ static const struct iommu_ops mock_ops = {
 
 static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free,
+	.iotlb_sync_user = mock_domain_iotlb_sync_user,
 };
 
 static inline struct iommufd_hw_pagetable *
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index ddd7c898fc50..3fc7a1cd8fef 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -126,6 +126,7 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
 	TEST_LENGTH(iommu_device_info, IOMMU_DEVICE_GET_INFO);
 	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC);
+	TEST_LENGTH(iommu_hwpt_invalidate, IOMMU_HWPT_INVALIDATE);
 #undef TEST_LENGTH
 }
 
@@ -312,6 +313,13 @@ TEST_F(iommufd_ioas, ioas_nested_hwpt)
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, parent_hwpt_id));
 
+		/* hwpt_invalidate only supports a user-managed hwpt (nested) */
+		test_err_ioctl_hwpt_invalidate(EINVAL, parent_hwpt_id);
+		test_ioctl_hwpt_invalidate(nested_hwpt_id[0]);
+		test_ioctl_hwpt_check_iotlb(nested_hwpt_id[0], 0);
+		test_ioctl_hwpt_invalidate(nested_hwpt_id[1]);
+		test_ioctl_hwpt_check_iotlb(nested_hwpt_id[1], 0);
+
 		/* Attach device to nested_hwpt_id[0] that then will be busy */
 		test_cmd_mock_domain_replace(self->ioas_id, self->dev_id,
 					     nested_hwpt_id[0]);
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index ea61b81fbc52..73ba0bacbb9a 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -244,6 +244,27 @@ static int _test_ioctl_hwpt_alloc(int fd, __u32 pt_id, __u32 dev_id,
 		ASSERT_EQ(0, *(out_hwpt_id));                                 \
 	})
 
+static int _test_ioctl_hwpt_invalidate(int fd, __u32 hwpt_id)
+{
+	struct iommu_hwpt_invalidate_selftest data = {
+		.flags = IOMMU_TEST_INVALIDATE_ALL,
+	};
+	struct iommu_hwpt_invalidate cmd = {
+		.size = sizeof(cmd),
+		.hwpt_id = hwpt_id,
+		.data_type = IOMMU_PGTBL_DATA_SELFTTEST,
+		.data_len = sizeof(data),
+		.data_uptr = (uint64_t)&data,
+	};
+
+	return ioctl(fd, IOMMU_HWPT_INVALIDATE, &cmd);
+}
+
+#define test_ioctl_hwpt_invalidate(hwpt_id)	\
+	ASSERT_EQ(0, _test_ioctl_hwpt_invalidate(self->fd, hwpt_id))
+#define test_err_ioctl_hwpt_invalidate(_errno, hwpt_id)	\
+	EXPECT_ERRNO(_errno, _test_ioctl_hwpt_invalidate(self->fd, hwpt_id))
+
 static int _test_ioctl_ioas_map(int fd, unsigned int ioas_id, void *buffer,
 				size_t length, __u64 *iova, unsigned int flags)
 {
-- 
2.34.1

