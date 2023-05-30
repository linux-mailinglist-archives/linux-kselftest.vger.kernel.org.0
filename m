Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9071771550E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjE3FlK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjE3Fke (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:40:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DFA10E;
        Mon, 29 May 2023 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425220; x=1716961220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQ3ebZ+WvKqSSMLvVYjG3PLHGPBP7fGn6L526ZX5WqY=;
  b=gXygGp/wWg0D3p4eNCwUPw01hjcQ+X1wI4mLFukZ0sU6ypfZQeWci3lM
   JwGC3FxpzddNfO2cGSvkTSVdz9KbFfxrPzNroRkQp2AUDRBKIkird6jIe
   HyYOmgUxAbqzIQoD+gpbHpRGwnLRoeoc+DT9OVpLUJChTE3hR3TQR5OQU
   4oqPDPfBKsE46ruiM5tuTSq4hJLm7cdj7CouH7iSgTRsTXCKstR14jDsX
   y1T1xxlU6zLK8IlV1xGHUEMm+GUqLEQODeyY43dTvss3Ua2B+AJ39oeb+
   9kRKeiGtwqX1/SSPgum49j9jeY/GGVNZ/cGa8JmXvsbboceyPUHTfsL1C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579853"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579853"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369842"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369842"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:39:06 -0700
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
Subject: [RFC PATCHES 12/17] iommufd: Add io page fault response support
Date:   Tue, 30 May 2023 13:37:19 +0800
Message-Id: <20230530053724.232765-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Externd the IOMMUFD framework to provide a user space API for responding
to page faults.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/uapi/linux/iommufd.h            | 23 +++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    | 54 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  3 ++
 4 files changed, 81 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6da0ba9421d0..0985e83a611f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -288,6 +288,7 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 void iommufd_hw_pagetable_abort(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
 int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
+int iommufd_hwpt_page_response(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 63863e21d043..65bb856dd8fb 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -50,6 +50,7 @@ enum {
 	IOMMUFD_CMD_HWPT_INVALIDATE,
 	IOMMUFD_CMD_DEVICE_SET_DATA,
 	IOMMUFD_CMD_DEVICE_UNSET_DATA,
+	IOMMUFD_CMD_PAGE_RESPONSE,
 };
 
 /**
@@ -779,4 +780,26 @@ struct iommu_device_unset_data {
 	__u32 dev_id;
 };
 #define IOMMU_DEVICE_UNSET_DATA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_UNSET_DATA)
+
+/**
+ * struct iommu_hwpt_page_response - ioctl(IOMMUFD_CMD_PAGE_RESPONSE)
+ * @size: sizeof(struct iommu_hwpt_page_response)
+ * @flags: encodes whether the corresponding fields are valid
+ *         (IOMMU_PGFAULT_FLAGS_* values)
+ * @hwpt_id: hwpt ID of target hardware page table for the response
+ * @dev_id: device ID of target device for the response
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @code: response code from &enum iommu_page_response_code
+ */
+struct iommu_hwpt_page_response {
+	__u32 size;
+	__u32 flags;
+	__u32 hwpt_id;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 code;
+};
+#define IOMMU_PAGE_RESPONSE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_PAGE_RESPONSE)
 #endif
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 09377a98069b..c1f3ebdce796 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -521,3 +521,57 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
 	eventfd_ctx_put(fault->trigger);
 	kfree(fault);
 }
+
+int iommufd_hwpt_page_response(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_page_response *cmd = ucmd->cmd;
+	struct iommu_page_response resp = {};
+	struct iommufd_fault *curr, *next;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_device *idev;
+	int rc = -EINVAL;
+
+	hwpt = iommufd_get_hwpt(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt))
+		return rc;
+
+	if (!hwpt->parent || !hwpt->fault)
+		goto out_put_hwpt;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		goto out_put_hwpt;
+
+	mutex_lock(&hwpt->fault->mutex);
+	list_for_each_entry_safe(curr, next, &hwpt->fault->response, item) {
+		if (curr->dev != idev->dev || curr->fault.grpid != cmd->grpid)
+			continue;
+
+		if ((cmd->flags & IOMMU_PGFAULT_FLAGS_PASID_VALID) &&
+		    cmd->pasid != curr->fault.pasid)
+			break;
+
+		if ((curr->fault.flags & IOMMU_PGFAULT_FLAGS_RESP_NEEDS_PASID) &&
+		    !(cmd->flags & IOMMU_PGFAULT_FLAGS_PASID_VALID))
+			break;
+
+		resp.version = IOMMU_PAGE_RESP_VERSION_1;
+		resp.pasid = cmd->pasid;
+		resp.grpid = cmd->grpid;
+		resp.code = cmd->code;
+		if (curr->fault.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
+			resp.flags = IOMMU_PAGE_RESP_PASID_VALID;
+
+		rc = iommu_page_response(idev->dev, &resp);
+		list_del_init(&curr->item);
+		kfree(curr);
+		break;
+	}
+	mutex_unlock(&hwpt->fault->mutex);
+
+	iommufd_put_object(&idev->obj);
+out_put_hwpt:
+	iommufd_put_object(&hwpt->obj);
+
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index bb39dc6f3b27..0c8988808f43 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -279,6 +279,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
+	struct iommu_hwpt_page_response resp;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -335,6 +336,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_device_set_data, data_len),
 	IOCTL_OP(IOMMU_DEVICE_UNSET_DATA, iommufd_device_unset_data,
 		 struct iommu_device_unset_data, dev_id),
+	IOCTL_OP(IOMMU_PAGE_RESPONSE, iommufd_hwpt_page_response, struct iommu_hwpt_page_response,
+		 code),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
-- 
2.34.1

