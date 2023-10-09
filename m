Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CED27BD5C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbjJIIwB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345585AbjJIIvj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:51:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F26119;
        Mon,  9 Oct 2023 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696841496; x=1728377496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MMr9DP0UvmKdR0AiATz4gv5TmgkJKV5gTCWbUuE39ig=;
  b=WrGIPFWpdMXRDW5tTeTzjOf33Hx+1Wa7jNPyMHjMPTAG+azgXzu0abZJ
   SFAHib1L6uVIt604Zi1c6c2du2eZDt/yE0uo0PqxDaa24CBei8/hNtltz
   paJQQRYs0fNVzC1v5wdgOgKb3vSO9AeKV7RWSXVt4GcNi/PPduXlVTaGZ
   71k2JcYsMt+tc9hf2eSzWsRGbm2mCfDwEZ6qQsBzTwn0pP+0InXdCEego
   U73JdTib/iRnVkTFhq8w2k9Nnny5zUUfFxBFhFwNuUtO6OtdAih0VUfFA
   UE/5j17sE7JGmsSXazknXW76cxlRywPUDp4i+wBX8krh19YU0PzyRThlN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364390822"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="364390822"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:51:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818781701"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818781701"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2023 01:51:34 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [RFC 5/7] iommufd/selftest: Extend IOMMU_TEST_OP_MOCK_DOMAIN to pass in pasid
Date:   Mon,  9 Oct 2023 01:51:21 -0700
Message-Id: <20231009085123.463179-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009085123.463179-1-yi.l.liu@intel.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
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

This extends IOMMU_TEST_OP_MOCK_DOMAIN to accept a pasid from caller.
Hence it is able to cover the iommufd_device_bind_pasid() for SIOV
virtual devices. pasid #0 is selected to mark the physical devices,
non-zero pasid values would be considered as SIOV virtual device bind.
Will add SIOV test cases later.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  2 ++
 drivers/iommu/iommufd/selftest.c              | 10 ++++++--
 tools/testing/selftests/iommu/iommufd.c       | 24 +++++++++----------
 .../selftests/iommu/iommufd_fail_nth.c        | 16 ++++++-------
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++-------
 5 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index cf10f250b0d2..64217f33f91a 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -62,6 +62,8 @@ struct iommu_test_cmd {
 			__aligned_u64 length;
 		} add_reserved;
 		struct {
+			/* #0 is invalid, any non-zero is meaningful */
+			__u32 default_pasid;
 			__u32 out_stdev_id;
 			__u32 out_hwpt_id;
 			/* out_idev_id is the standard iommufd_bind object */
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 5fb025ab8677..60c6d76c82b4 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -638,8 +638,14 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 		goto out_sobj;
 	}
 
-	idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev,
-				   &idev_id);
+	if (!cmd->mock_domain.default_pasid)
+		idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev,
+					   &idev_id);
+	else
+		idev = iommufd_device_bind_pasid(ucmd->ictx,
+						 &sobj->idev.mock_dev->dev,
+						 cmd->mock_domain.default_pasid,
+						 &idev_id);
 	if (IS_ERR(idev)) {
 		rc = PTR_ERR(idev);
 		goto out_mdev;
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index be2a95163d10..9a1fbba89e96 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -219,7 +219,7 @@ FIXTURE_SETUP(iommufd_ioas)
 	}
 
 	for (i = 0; i != variant->mock_domains; i++) {
-		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
+		test_cmd_mock_domain(self->ioas_id, 0, &self->stdev_id,
 				     &self->hwpt_id, &self->device_id);
 		self->base_iova = MOCK_APERTURE_START;
 	}
@@ -450,9 +450,9 @@ TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
 	if (self->stdev_id) {
-		test_cmd_mock_domain(self->hwpt_id, NULL, NULL, NULL);
+		test_cmd_mock_domain(self->hwpt_id, 0, NULL, NULL, NULL);
 	} else {
-		test_err_mock_domain(ENOENT, self->hwpt_id, NULL, NULL);
+		test_err_mock_domain(ENOENT, self->hwpt_id, 0, NULL, NULL);
 	}
 }
 
@@ -902,7 +902,7 @@ TEST_F(iommufd_ioas, access_pin)
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
 				   &access_cmd));
-		test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
+		test_cmd_mock_domain(self->ioas_id, 0, &mock_stdev_id,
 				     &mock_hwpt_id, NULL);
 		check_map_cmd.id = mock_hwpt_id;
 		ASSERT_EQ(0, ioctl(self->fd,
@@ -1058,7 +1058,7 @@ TEST_F(iommufd_ioas, fork_gone)
 		 * If a domain already existed then everything was pinned within
 		 * the fork, so this copies from one domain to another.
 		 */
-		test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
+		test_cmd_mock_domain(self->ioas_id, 0, NULL, NULL, NULL);
 		check_access_rw(_metadata, self->fd, access_id,
 				MOCK_APERTURE_START, 0);
 
@@ -1067,7 +1067,7 @@ TEST_F(iommufd_ioas, fork_gone)
 		 * Otherwise we need to actually pin pages which can't happen
 		 * since the fork is gone.
 		 */
-		test_err_mock_domain(EFAULT, self->ioas_id, NULL, NULL);
+		test_err_mock_domain(EFAULT, self->ioas_id, 0, NULL, NULL);
 	}
 
 	test_cmd_destroy_access(access_id);
@@ -1107,7 +1107,7 @@ TEST_F(iommufd_ioas, fork_present)
 	ASSERT_EQ(8, read(efd, &tmp, sizeof(tmp)));
 
 	/* Read pages from the remote process */
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, 0, NULL, NULL, NULL);
 	check_access_rw(_metadata, self->fd, access_id, MOCK_APERTURE_START, 0);
 
 	ASSERT_EQ(0, close(pipefds[1]));
@@ -1277,7 +1277,7 @@ FIXTURE_SETUP(iommufd_mock_domain)
 	ASSERT_GE(ARRAY_SIZE(self->hwpt_ids), variant->mock_domains);
 
 	for (i = 0; i != variant->mock_domains; i++)
-		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
+		test_cmd_mock_domain(self->ioas_id, 0, &self->stdev_ids[i],
 				     &self->hwpt_ids[i], &self->idev_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
@@ -1471,7 +1471,7 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 
 			/* Add and destroy a domain while the area exists */
 			old_id = self->hwpt_ids[1];
-			test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
+			test_cmd_mock_domain(self->ioas_id, 0, &mock_stdev_id,
 					     &self->hwpt_ids[1], NULL);
 
 			check_mock_iova(buf + start, iova, length);
@@ -1609,7 +1609,7 @@ TEST_F(iommufd_mock_domain, alloc_hwpt)
 		test_cmd_mock_domain_replace(self->stdev_ids[i], self->ioas_id);
 		test_ioctl_destroy(hwpt_id[1]);
 
-		test_cmd_mock_domain(hwpt_id[0], &stddev_id, NULL, NULL);
+		test_cmd_mock_domain(hwpt_id[0], 0, &stddev_id, NULL, NULL);
 		test_ioctl_destroy(stddev_id);
 		test_ioctl_destroy(hwpt_id[0]);
 	}
@@ -1756,7 +1756,7 @@ FIXTURE_SETUP(vfio_compat_mock_domain)
 
 	/* Create what VFIO would consider a group */
 	test_ioctl_ioas_alloc(&self->ioas_id);
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, 0, NULL, NULL, NULL);
 
 	/* Attach it to the vfio compat */
 	vfio_ioas_cmd.ioas_id = self->ioas_id;
@@ -2037,7 +2037,7 @@ FIXTURE_SETUP(iommufd_device_pasid)
 	ASSERT_NE(-1, self->fd);
 	test_ioctl_ioas_alloc(&self->ioas_id);
 
-	test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
+	test_cmd_mock_domain(self->ioas_id, 0, &self->stdev_id,
 			     &self->hwpt_id, &self->device_id);
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index f7f4b838c2d1..691903c63de0 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -321,7 +321,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, 0, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -332,7 +332,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, 0, &stdev_id, &hwpt_id, NULL))
 		return -1;
 	return 0;
 }
@@ -356,12 +356,12 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, 0, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
+	if (_test_cmd_mock_domain(self->fd, ioas_id, 0, &stdev_id2, &hwpt_id2,
 				  NULL))
 		return -1;
 
@@ -376,9 +376,9 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_destroy(self->fd, stdev_id2))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, 0, &stdev_id, &hwpt_id, NULL))
 		return -1;
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
+	if (_test_cmd_mock_domain(self->fd, ioas_id, 0, &stdev_id2, &hwpt_id2,
 				  NULL))
 		return -1;
 	return 0;
@@ -536,7 +536,7 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, 0, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
@@ -613,7 +613,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &self->stdev_id, NULL,
+	if (_test_cmd_mock_domain(self->fd, ioas_id, 0, &self->stdev_id, NULL,
 				  &idev_id))
 		return -1;
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 8339925562f3..bc9080fc9c2f 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -44,14 +44,16 @@ static unsigned long PAGE_SIZE;
 				&test_cmd));                                  \
 	})
 
-static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
-				 __u32 *hwpt_id, __u32 *idev_id)
+static int _test_cmd_mock_domain(int fd, unsigned int ioas_id,
+				 unsigned int default_pasid,
+				 __u32 *stdev_id, __u32 *hwpt_id,
+				 __u32 *idev_id)
 {
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
 		.op = IOMMU_TEST_OP_MOCK_DOMAIN,
 		.id = ioas_id,
-		.mock_domain = {},
+		.mock_domain = { .default_pasid = default_pasid, },
 	};
 	int ret;
 
@@ -67,12 +69,13 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
 		*idev_id = cmd.mock_domain.out_idev_id;
 	return 0;
 }
-#define test_cmd_mock_domain(ioas_id, stdev_id, hwpt_id, idev_id)       \
-	ASSERT_EQ(0, _test_cmd_mock_domain(self->fd, ioas_id, stdev_id, \
-					   hwpt_id, idev_id))
-#define test_err_mock_domain(_errno, ioas_id, stdev_id, hwpt_id)      \
-	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
-						   stdev_id, hwpt_id, NULL))
+#define test_cmd_mock_domain(ioas_id, pasid, stdev_id, hwpt_id, idev_id)   \
+	ASSERT_EQ(0, _test_cmd_mock_domain(self->fd, ioas_id, pasid,       \
+					   stdev_id, hwpt_id, idev_id))
+#define test_err_mock_domain(_errno, ioas_id, pasid, stdev_id, hwpt_id)    \
+	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id,      \
+						   pasid, stdev_id,        \
+						   hwpt_id, NULL))
 
 static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 					 __u32 *hwpt_id)
-- 
2.34.1

