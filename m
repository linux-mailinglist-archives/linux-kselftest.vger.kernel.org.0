Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F74715509
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjE3Fk4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjE3Fka (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:40:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDF0100;
        Mon, 29 May 2023 22:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425216; x=1716961216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RqHDTbRoy7dppD6/TLitl/uLv/Q9R1r91cywKn4gvas=;
  b=gjoAjQ4amXlFqo3NrT4uDzVlTO2jx37yuslPcAIMxkGT7w176rBcMN0k
   77/SNO5sckZ4g4m+ou7Sw17+g4pFVSc5P//v2p4/p8Jmw1IlUjVwEO746
   9VGKfhuc7NJEK8S9LaERbv9cQ7u1eImIav0WgvgD+icpb9ha8OHAFU+pc
   BRQLZdMpEmcBvthgkHRQb3KaoWTNvO1d8lgIwKFuLf3laR+7LHE+q9i2p
   YqaGk2D3+D/lCJr54TB6BoDJUX1YY1+AZt0zBvYAyN/N7CQiXAZhIXHFj
   EuaUhLqf6vXgSAeL7GpY4ZOxXcodANvXprxJaitF11GRKSKqfXZq9djUg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579795"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579795"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369716"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369716"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:38:55 -0700
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
Subject: [RFC PATCHES 09/17] iommufd: Add iommufd hwpt iopf handler
Date:   Tue, 30 May 2023 13:37:16 +0800
Message-Id: <20230530053724.232765-10-baolu.lu@linux.intel.com>
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

The IOPF handler is responsible for delivering I/O page faults to user
space. When an I/O page fault occurs, the fault is placed in the fault
pending list of the hardware page table (HWPT). The HWPT then generates
a fault event, which is used to notify user space of the fault. User
space can then fetch the fault information from the HWPT and handle the
fault accordingly.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  8 ++++
 drivers/iommu/iommufd/hw_pagetable.c    | 50 +++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5ff139acc5c0..8ff7721ea922 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -243,6 +243,14 @@ struct hw_pgtable_fault {
 	struct eventfd_ctx *trigger;
 };
 
+struct iommufd_fault {
+	struct device *dev;
+	ioasid_t pasid;
+	struct iommu_hwpt_pgfault fault;
+	/* List head at hw_pgtable_fault:deliver or response */
+	struct list_head item;
+};
+
 /*
  * A HW pagetable is called an iommu_domain inside the kernel. This user object
  * allows directly creating and inspecting the domains. Domains that have kernel
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index d6d550c3d0cc..4d07c7c0073e 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -12,6 +12,9 @@
 
 static struct hw_pgtable_fault *hw_pagetable_fault_alloc(int eventfd);
 static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault);
+static enum iommu_page_response_code
+iommufd_hw_pagetable_iopf_handler(struct iommu_fault *fault,
+				  struct device *dev, void *data);
 
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 {
@@ -300,6 +303,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 			rc = PTR_ERR(hwpt->fault);
 			goto out_hwpt;
 		}
+
+		iommu_domain_set_iopf_handler(hwpt->domain,
+					      iommufd_hw_pagetable_iopf_handler,
+					      hwpt);
 	}
 
 	cmd->out_hwpt_id = hwpt->obj.id;
@@ -367,6 +374,49 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+static void iommufd_compose_fault_message(struct iommu_fault *fault,
+					  struct iommu_hwpt_pgfault *hwpt_fault,
+					  unsigned int dev_id)
+{
+	hwpt_fault->size = sizeof(*hwpt_fault);
+	hwpt_fault->flags = fault->prm.flags;
+	hwpt_fault->dev_id = dev_id;
+	hwpt_fault->pasid = fault->prm.pasid;
+	hwpt_fault->grpid = fault->prm.grpid;
+	hwpt_fault->perm = fault->prm.perm;
+	hwpt_fault->addr = fault->prm.addr;
+	hwpt_fault->private_data[0] = fault->prm.private_data[0];
+	hwpt_fault->private_data[1] = fault->prm.private_data[1];
+}
+
+static enum iommu_page_response_code
+iommufd_hw_pagetable_iopf_handler(struct iommu_fault *fault,
+				  struct device *dev, void *data)
+{
+	struct iommufd_hw_pagetable *hwpt = data;
+	struct iommufd_fault_cookie *cookie;
+	struct iommufd_fault *ifault;
+
+	ifault = kzalloc(sizeof(*ifault), GFP_KERNEL);
+	if (!ifault)
+		return IOMMU_PAGE_RESP_FAILURE;
+
+	cookie = iommu_get_device_fault_cookie(dev, fault->prm.pasid);
+	if (!cookie)
+		return IOMMU_PAGE_RESP_FAILURE;
+
+	iommufd_compose_fault_message(fault, &ifault->fault, cookie->idev->obj.id);
+	ifault->dev = dev;
+	ifault->pasid = fault->prm.pasid;
+
+	mutex_lock(&hwpt->fault->mutex);
+	list_add_tail(&ifault->item, &hwpt->fault->deliver);
+	eventfd_signal(hwpt->fault->trigger, 1);
+	mutex_unlock(&hwpt->fault->mutex);
+
+	return IOMMU_PAGE_RESP_ASYNC;
+}
+
 static struct hw_pgtable_fault *hw_pagetable_fault_alloc(int eventfd)
 {
 	struct hw_pgtable_fault *fault;
-- 
2.34.1

