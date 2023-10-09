Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773967BD5C0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbjJIIvy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbjJIIvl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:51:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9BBED;
        Mon,  9 Oct 2023 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696841498; x=1728377498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/ghgXXFlCC5X+m363LcA6Jn28Rpf678n/rxTiOLSIg=;
  b=ZO90lCD+bDqiDh0qMA4Dq9b6XnY+fYZXUDyLyD5zf5sApFTqYBjQmV04
   lJ8qMHzBWDO75wrRddpdIKOc1jTAT8Sou5qquJM2KreQZlv2UO1d7LHoa
   wCylcVtRGnnTzKZWIn3dTCdPSSnDiDOYJau5Or1kBtX0M9z9FcSwfmvuQ
   n0h12aGyCy5Cl2epS+e3PFwHFfwIVtkIcvuh2RZ2brDh7AQUwcq+QT7n5
   FzlNYWX/ajEm6+cPvUol83ODoS/05y8ye2okgWuVGVPZtYxwU57pKaj3d
   pxMU4SxyTAesSSs3EKNexAiMvwb7rdZ4/PWtpmLxb4w6f9K7hOzfPrU1y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364390846"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="364390846"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818781714"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818781714"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2023 01:51:36 -0700
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
Subject: [RFC 6/7] iommufd/selftest: Add test coverage for SIOV virtual device
Date:   Mon,  9 Oct 2023 01:51:22 -0700
Message-Id: <20231009085123.463179-7-yi.l.liu@intel.com>
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

This adds test coverage for SIOV virtual device by passsing a non-zero pasid
to IOMMU_TEST_OP_MOCK_DOMAIN op, and check if the SIOV virtual device (a.k.a
pasid of this device) is attached to the mock domain, then tries to replace
with a new hwpt and other types of hwpts, and check if the attached domain of
this virtual device is correct.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 53 ++++++++++++++++++-
 .../selftests/iommu/iommufd_fail_nth.c        | 26 +++++++++
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 9a1fbba89e96..945ab07a8b84 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2031,14 +2031,20 @@ FIXTURE(iommufd_device_pasid)
 	uint32_t device_id;
 };
 
+FIXTURE_VARIANT(iommufd_device_pasid)
+{
+	uint32_t pasid;
+};
+
 FIXTURE_SETUP(iommufd_device_pasid)
 {
 	self->fd = open("/dev/iommu", O_RDWR);
 	ASSERT_NE(-1, self->fd);
 	test_ioctl_ioas_alloc(&self->ioas_id);
 
-	test_cmd_mock_domain(self->ioas_id, 0, &self->stdev_id,
-			     &self->hwpt_id, &self->device_id);
+	test_cmd_mock_domain(self->ioas_id, variant->pasid,
+			     &self->stdev_id, &self->hwpt_id,
+			     &self->device_id);
 }
 
 FIXTURE_TEARDOWN(iommufd_device_pasid)
@@ -2046,6 +2052,12 @@ FIXTURE_TEARDOWN(iommufd_device_pasid)
 	teardown_iommufd(self->fd, _metadata);
 }
 
+/* For SIOV test */
+FIXTURE_VARIANT_ADD(iommufd_device_pasid, siov_pasid_600)
+{
+	.pasid = 600, //this is the default pasid for the SIOV virtual device
+};
+
 TEST_F(iommufd_device_pasid, pasid_attach)
 {
 	if (self->device_id) {
@@ -2071,6 +2083,43 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 					   IOMMU_HWPT_ALLOC_DATA_SELFTEST,
 					   &data, sizeof(data));
 
+		if (variant->pasid) {
+			uint32_t new_hwpt_id = 0;
+
+			ASSERT_EQ(0,
+				  test_cmd_pasid_check_domain(self->fd,
+							      self->stdev_id,
+							      variant->pasid,
+							      self->hwpt_id,
+							      &result));
+			EXPECT_EQ(1, result);
+			test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
+					    0, &new_hwpt_id);
+			test_cmd_mock_domain_replace(self->stdev_id,
+						     new_hwpt_id);
+			ASSERT_EQ(0,
+				  test_cmd_pasid_check_domain(self->fd,
+							      self->stdev_id,
+							      variant->pasid,
+							      new_hwpt_id,
+							      &result));
+			EXPECT_EQ(1, result);
+
+			/*
+			 * Detach hwpt from variant->pasid, and check if the
+			 * variant->pasid has null domain
+			 */
+			test_cmd_pasid_detach(variant->pasid);
+			ASSERT_EQ(0,
+				  test_cmd_pasid_check_domain(self->fd,
+							      self->stdev_id,
+							      variant->pasid,
+							      0, &result));
+			EXPECT_EQ(1, result);
+
+			test_ioctl_destroy(new_hwpt_id);
+		}
+
 		/*
 		 * Attach ioas to pasid 100, should succeed, domain should
 		 * be valid.
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 691903c63de0..a5fb45d99869 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -644,6 +644,32 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	self->pasid = 0;
 
+	if (_test_ioctl_destroy(self->fd, self->stdev_id))
+		return -1;
+
+	self->pasid = 300;
+	self->stdev_id = 0;
+
+	/* Test for SIOV virtual devices attach */
+	if (_test_cmd_mock_domain(self->fd, ioas_id, self->pasid,
+				  &self->stdev_id, NULL, &idev_id))
+		return -1;
+
+	/* Test for SIOV virtual device replace */
+	if (_test_cmd_mock_domain_replace(self->fd, self->stdev_id,
+					  hwpt_id, NULL))
+		return -1;
+
+	if (_test_cmd_pasid_detach(self->fd, self->stdev_id, self->pasid))
+		return -1;
+
+	self->pasid = 0;
+
+	if (_test_ioctl_destroy(self->fd, self->stdev_id))
+		return -1;
+
+	self->stdev_id = 0;
+
 	return 0;
 }
 
-- 
2.34.1

