Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0432715510
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjE3FlL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjE3Fki (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:40:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CF7118;
        Mon, 29 May 2023 22:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425221; x=1716961221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2yv6wk0yhr7L3GSjmAj5VYe1jRJn9Erv0tqyPH6K18E=;
  b=MSE07+G5zPMmkFu7aM9g8QdHnDePLUoAnOzcj3bIiNb9NmIyTLc/o6o4
   IKrZpoYjYQUuzTXgJPmrVjKE1nxvJT3u/ZmreYHOymn0oZJp+RRlxeIjR
   mmb14rWnFwHYLYIYgEjhzBMTqXyFTjzGvvmT6oGe9fpQHTOEpHPjM0qzd
   RXccPrdIXOwtgs/plH2ehSWQKwt/hQNnUkf6prfN1Ox9zD+Ob8WCPxx2b
   kE96EQew15G9e0Hh4Bhe8F7DyZkgXrgLZc/D9VYs1j50LP9pZ/SAaWETf
   GeeXvjuRU7gAQ1bxWUqSVrN+uj9Wav67FlWhN6SuisOMiuAOJkRHTMSCS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579863"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579863"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369869"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369869"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:39:11 -0700
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
Subject: [RFC PATCHES 13/17] iommufd: Add a timer for each iommufd fault data
Date:   Tue, 30 May 2023 13:37:20 +0800
Message-Id: <20230530053724.232765-14-baolu.lu@linux.intel.com>
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

In case that user space failed to read or respond the pending faults. As
the per-fault iommufd data will be possibly accessed in two different
contexts: user reading/responding and the timer expiring, add a reference
counter for each iommufd fault data and free the data only after all the
reference counters are released.

The page fault response timeout value is device-specific and indicates how
long the bus/device will wait for a response to a page fault request. The
timeout value is added to the per-device fault cookie. Ideally, it should
be calculated according to the platform configuration (PCI, ACPI, device
tree, etc.). This defines a default value of 1 second in case that no
platform opt-in is available. This default value is roughly estimated and
subject to be changed according to real use cases.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  8 +++
 drivers/iommu/iommufd/device.c          |  3 +
 drivers/iommu/iommufd/hw_pagetable.c    | 80 +++++++++++++++++++++++--
 3 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0985e83a611f..f5b8a53044c4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -249,9 +249,12 @@ struct hw_pgtable_fault {
 struct iommufd_fault {
 	struct device *dev;
 	ioasid_t pasid;
+	struct iommufd_hw_pagetable *hwpt;
 	struct iommu_hwpt_pgfault fault;
 	/* List head at hw_pgtable_fault:deliver or response */
 	struct list_head item;
+	struct timer_list timer;
+	refcount_t users;
 };
 
 /*
@@ -336,6 +339,11 @@ struct iommufd_device {
 
 struct iommufd_fault_cookie {
 	struct iommufd_device *idev;
+	/*
+	 * The maximum number of milliseconds that a device will wait for a
+	 * response to a page fault request.
+	 */
+	unsigned long timeout;
 };
 
 static inline struct iommufd_device *
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3408f1fc3e9f..6ad46638f4e1 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -374,6 +374,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	return 0;
 }
 
+#define IOMMUFD_DEFAULT_IOPF_TIMEOUT	1000
+
 static int iommufd_device_set_fault_cookie(struct iommufd_hw_pagetable *hwpt,
 					   struct iommufd_device *idev,
 					   ioasid_t pasid)
@@ -387,6 +389,7 @@ static int iommufd_device_set_fault_cookie(struct iommufd_hw_pagetable *hwpt,
 	if (!fcookie)
 		return -ENOMEM;
 	fcookie->idev = idev;
+	fcookie->timeout = IOMMUFD_DEFAULT_IOPF_TIMEOUT;
 
 	curr = iommu_set_device_fault_cookie(idev->dev, pasid, fcookie);
 	if (IS_ERR(curr)) {
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index c1f3ebdce796..8c441fd72e1f 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -6,6 +6,7 @@
 #include <linux/eventfd.h>
 #include <linux/file.h>
 #include <linux/anon_inodes.h>
+#include <linux/timer.h>
 #include <uapi/linux/iommufd.h>
 
 #include "../iommu-priv.h"
@@ -396,6 +397,60 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
 	hwpt_fault->private_data[1] = fault->prm.private_data[1];
 }
 
+static void drain_iopf_fault(struct iommufd_fault *ifault)
+{
+	struct iommu_page_response resp = {
+		.version	= IOMMU_PAGE_RESP_VERSION_1,
+		.pasid		= ifault->fault.pasid,
+		.grpid		= ifault->fault.grpid,
+		.code		= IOMMU_PAGE_RESP_FAILURE,
+	};
+
+	if (!(ifault->fault.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
+		return;
+
+	if ((ifault->fault.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) &&
+	    (ifault->fault.flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID))
+		resp.flags = IOMMU_PAGE_RESP_PASID_VALID;
+
+	iommu_page_response(ifault->dev, &resp);
+}
+
+static void iommufd_put_fault(struct iommufd_fault *ifault)
+{
+	if (!ifault)
+		return;
+
+	if (refcount_dec_and_test(&ifault->users))
+		kfree(ifault);
+}
+
+static int iommufd_fault_timer_teardown(struct iommufd_fault *ifault)
+{
+	int rc;
+
+	rc = timer_delete(&ifault->timer);
+	if (rc)
+		iommufd_put_fault(ifault);
+
+	return rc;
+}
+
+static void iopf_timer_func(struct timer_list *t)
+{
+	struct iommufd_fault *ifault = from_timer(ifault, t, timer);
+	struct hw_pgtable_fault *fault = ifault->hwpt->fault;
+
+	mutex_lock(&fault->mutex);
+	if (!list_empty(&ifault->item)) {
+		list_del_init(&ifault->item);
+		drain_iopf_fault(ifault);
+	}
+	mutex_unlock(&fault->mutex);
+
+	iommufd_put_fault(ifault);
+}
+
 static enum iommu_page_response_code
 iommufd_hw_pagetable_iopf_handler(struct iommu_fault *fault,
 				  struct device *dev, void *data)
@@ -416,6 +471,10 @@ iommufd_hw_pagetable_iopf_handler(struct iommu_fault *fault,
 	iommufd_compose_fault_message(fault, &ifault->fault, cookie->idev->obj.id);
 	ifault->dev = dev;
 	ifault->pasid = fault->prm.pasid;
+	ifault->hwpt = hwpt;
+	refcount_set(&ifault->users, 2);
+	timer_setup(&ifault->timer, iopf_timer_func, 0);
+	mod_timer(&ifault->timer, jiffies + msecs_to_jiffies(cookie->timeout));
 
 	mutex_lock(&hwpt->fault->mutex);
 	list_add_tail(&ifault->item, &hwpt->fault->deliver);
@@ -443,10 +502,12 @@ static ssize_t hwpt_fault_fops_read(struct file *filep, char __user *buf,
 			break;
 		done += fault_size;
 		list_del_init(&ifault->item);
-		if (ifault->fault.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)
+		if (ifault->fault.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE) {
 			list_add_tail(&ifault->item, &fault->response);
-		else
-			kfree(ifault);
+		} else {
+			iommufd_fault_timer_teardown(ifault);
+			iommufd_put_fault(ifault);
+		}
 	}
 	mutex_unlock(&fault->mutex);
 
@@ -526,6 +587,7 @@ int iommufd_hwpt_page_response(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_page_response *cmd = ucmd->cmd;
 	struct iommu_page_response resp = {};
+	struct iommufd_fault *ifault = NULL;
 	struct iommufd_fault *curr, *next;
 	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_device *idev;
@@ -547,6 +609,7 @@ int iommufd_hwpt_page_response(struct iommufd_ucmd *ucmd)
 		if (curr->dev != idev->dev || curr->fault.grpid != cmd->grpid)
 			continue;
 
+		ifault = curr;
 		if ((cmd->flags & IOMMU_PGFAULT_FLAGS_PASID_VALID) &&
 		    cmd->pasid != curr->fault.pasid)
 			break;
@@ -555,6 +618,15 @@ int iommufd_hwpt_page_response(struct iommufd_ucmd *ucmd)
 		    !(cmd->flags & IOMMU_PGFAULT_FLAGS_PASID_VALID))
 			break;
 
+		/*
+		 * The timer has expired if it was not pending. Leave the
+		 * response to the timer function.
+		 */
+		if (!iommufd_fault_timer_teardown(curr)) {
+			rc = -ETIMEDOUT;
+			break;
+		}
+
 		resp.version = IOMMU_PAGE_RESP_VERSION_1;
 		resp.pasid = cmd->pasid;
 		resp.grpid = cmd->grpid;
@@ -564,11 +636,11 @@ int iommufd_hwpt_page_response(struct iommufd_ucmd *ucmd)
 
 		rc = iommu_page_response(idev->dev, &resp);
 		list_del_init(&curr->item);
-		kfree(curr);
 		break;
 	}
 	mutex_unlock(&hwpt->fault->mutex);
 
+	iommufd_put_fault(ifault);
 	iommufd_put_object(&idev->obj);
 out_put_hwpt:
 	iommufd_put_object(&hwpt->obj);
-- 
2.34.1

