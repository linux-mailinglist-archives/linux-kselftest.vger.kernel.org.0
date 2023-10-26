Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A427D7B18
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 04:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjJZCyJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 22:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjJZCyA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 22:54:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DFDD48;
        Wed, 25 Oct 2023 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698288835; x=1729824835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y/UELdAKdixD7UAeztRKsYvoefrXj6uhYDxNLPIhGxs=;
  b=VquIDyw+GABnBgSiZP0rQGLB4wNXsfsV2PSgvkQDQz+NDTppJO8+8geQ
   dZo+rJcdIsT0r0/VjeSqyRGP3fmWOMm1dr2fPBZXVAe7AZAHVnqfd2omG
   p2s0Lo130ooOUNRz0Y/0d+HSlTIno8bQoIp7r6kG511B3JWVwjEyJg3EY
   c3gI2jkB31QZj7xmCOtAwl6kDHunQy4Wej7gAqFyp3RhysnOqDWZlfgAw
   F2ou/c3dvwblA0Q1aASY2fw1xqDJx4HynTCVTD0IuB1AtiqxZkEIpYcBy
   Bz9PlXONZbPUSIE81+FfVhBLpVv3UoH8oRUH37k5outTAVrFC7L0KEOAc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391316202"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="391316202"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 19:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735604559"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="735604559"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2023 19:53:50 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 5/6] iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_IOPF test support
Date:   Thu, 26 Oct 2023 10:49:29 +0800
Message-Id: <20231026024930.382898-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend the selftest mock device to support generating and responding to
an IOPF. Also add an ioctl interface to userspace applications to trigger
the IOPF on the mock device. This would allow userspace applications to
test the IOMMUFD's handling of IOPFs without having to rely on any real
hardware.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  8 ++++
 drivers/iommu/iommufd/selftest.c     | 56 ++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 65a363f5e81e..98951a2af4bd 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -21,6 +21,7 @@ enum {
 	IOMMU_TEST_OP_ACCESS_REPLACE_IOAS,
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_DEV_CHECK_DATA,
+	IOMMU_TEST_OP_TRIGGER_IOPF,
 };
 
 enum {
@@ -109,6 +110,13 @@ struct iommu_test_cmd {
 		struct {
 			__u32 val;
 		} check_dev_data;
+		struct {
+			__u32 dev_id;
+			__u32 pasid;
+			__u32 grpid;
+			__u32 perm;
+			__u64 addr;
+		} trigger_iopf;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 117776d236dc..b2d2edc3d2d2 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -401,11 +401,21 @@ static void mock_domain_set_plaform_dma_ops(struct device *dev)
 	 */
 }
 
+static struct iopf_queue *mock_iommu_iopf_queue;
+
 static struct iommu_device mock_iommu_device = {
 };
 
 static struct iommu_device *mock_probe_device(struct device *dev)
 {
+	int rc;
+
+	if (mock_iommu_iopf_queue) {
+		rc = iopf_queue_add_device(mock_iommu_iopf_queue, dev);
+		if (rc)
+			return ERR_PTR(-ENODEV);
+	}
+
 	return &mock_iommu_device;
 }
 
@@ -431,6 +441,12 @@ static void mock_domain_unset_dev_user_data(struct device *dev)
 	mdev->dev_data = 0;
 }
 
+static int mock_domain_page_response(struct device *dev, struct iopf_fault *evt,
+				     struct iommu_page_response *msg)
+{
+	return 0;
+}
+
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
@@ -443,6 +459,7 @@ static const struct iommu_ops mock_ops = {
 	.probe_device = mock_probe_device,
 	.set_dev_user_data = mock_domain_set_dev_user_data,
 	.unset_dev_user_data = mock_domain_unset_dev_user_data,
+	.page_response = mock_domain_page_response,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -542,6 +559,9 @@ static void mock_dev_release(struct device *dev)
 {
 	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
 
+	if (mock_iommu_iopf_queue)
+		iopf_queue_remove_device(mock_iommu_iopf_queue, dev);
+
 	atomic_dec(&mock_dev_num);
 	kfree(mdev);
 }
@@ -1200,6 +1220,32 @@ static_assert((unsigned int)MOCK_ACCESS_RW_WRITE == IOMMUFD_ACCESS_RW_WRITE);
 static_assert((unsigned int)MOCK_ACCESS_RW_SLOW_PATH ==
 	      __IOMMUFD_ACCESS_RW_SLOW_PATH);
 
+static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct iopf_fault event = { };
+	struct iommufd_device *idev;
+	int rc;
+
+	idev = iommufd_get_device(ucmd, cmd->trigger_iopf.dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	event.fault.prm.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (cmd->trigger_iopf.pasid != IOMMU_NO_PASID)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	event.fault.type = IOMMU_FAULT_PAGE_REQ;
+	event.fault.prm.addr = cmd->trigger_iopf.addr;
+	event.fault.prm.pasid = cmd->trigger_iopf.pasid;
+	event.fault.prm.grpid = cmd->trigger_iopf.grpid;
+	event.fault.prm.perm = cmd->trigger_iopf.perm;
+
+	rc = iommu_report_device_fault(idev->dev, &event);
+	iommufd_put_object(&idev->obj);
+
+	return rc;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = container_of(obj, struct selftest_obj, obj);
@@ -1271,6 +1317,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 			return -EINVAL;
 		iommufd_test_memory_limit = cmd->memory_limit.limit;
 		return 0;
+	case IOMMU_TEST_OP_TRIGGER_IOPF:
+		return iommufd_test_trigger_iopf(ucmd, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1312,6 +1360,9 @@ int __init iommufd_test_init(void)
 				  &iommufd_mock_bus_type.nb);
 	if (rc)
 		goto err_sysfs;
+
+	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
+
 	return 0;
 
 err_sysfs:
@@ -1327,6 +1378,11 @@ int __init iommufd_test_init(void)
 
 void iommufd_test_exit(void)
 {
+	if (mock_iommu_iopf_queue) {
+		iopf_queue_free(mock_iommu_iopf_queue);
+		mock_iommu_iopf_queue = NULL;
+	}
+
 	iommu_device_sysfs_remove(&mock_iommu_device);
 	iommu_device_unregister_bus(&mock_iommu_device,
 				    &iommufd_mock_bus_type.bus,
-- 
2.34.1

