Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A538071550D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjE3FlJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjE3Fkc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:40:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAD2103;
        Mon, 29 May 2023 22:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425218; x=1716961218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6fZzsnppnyR7kpcIKhto0g6Vd7ftpsuL2xR0ieUO5k=;
  b=VIE0qjZGTE14lWmzfNCzPYAo5ofaZcgAUDJ4exbgCz05CKN0U9gb03+p
   YPKvjK3SEpYgEqOxFmKwe0gk7/yTFs+5jWbVj97qoGFrDyJZ8//wS9Gzk
   mAFW9/YFMeYAgT86MIlWXOAfh5NNApoocTWEl3rSYoRc9hKD1/eQJPs+D
   sXDJZ4t+4c4UlJIu3gScvlj4Y4/RZkccbQeTMe7l6rJO3wJcJYM1wstfh
   3nn2zc8X/QtXhzsu19PwSZOPmTnen9eygJhbfFcjOM9ngUuEBS7GH/PBX
   t+aEqNjn8Jovpfv1YHRM3OxQk6HO4zNuUxGTV2khexsvWy4hVXnhZRCKB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579819"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579819"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369801"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369801"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:39:02 -0700
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
Subject: [RFC PATCHES 11/17] iommufd: Deliver fault messages to user space
Date:   Tue, 30 May 2023 13:37:18 +0800
Message-Id: <20230530053724.232765-12-baolu.lu@linux.intel.com>
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

Provide a read-only file interface that allows user space to obtain fault
messages by sequentially reading the file. User space can determine whether
all fault messages have been read by comparing the provided read buffer
with the actually returned data length. Once a fault is read by the user,
it will be moved from the pending list to the waiting-for-response list.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 +
 drivers/iommu/iommufd/hw_pagetable.c    | 66 +++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 67e5aa0f996e..6da0ba9421d0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -242,6 +242,8 @@ struct hw_pgtable_fault {
 	struct list_head response;
 	struct eventfd_ctx *trigger;
 	bool user_pasid_table;
+	struct file *fault_file;
+	int fault_fd;
 };
 
 struct iommufd_fault {
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ca3e4d92f2aa..09377a98069b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -4,6 +4,8 @@
  */
 #include <linux/iommu.h>
 #include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
 #include <uapi/linux/iommufd.h>
 
 #include "../iommu-priv.h"
@@ -310,6 +312,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		iommu_domain_set_iopf_handler(hwpt->domain,
 					      iommufd_hw_pagetable_iopf_handler,
 					      hwpt);
+
+		cmd->out_fault_fd = hwpt->fault->fault_fd;
 	}
 
 	cmd->out_hwpt_id = hwpt->obj.id;
@@ -421,6 +425,62 @@ iommufd_hw_pagetable_iopf_handler(struct iommu_fault *fault,
 	return IOMMU_PAGE_RESP_ASYNC;
 }
 
+static ssize_t hwpt_fault_fops_read(struct file *filep, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct hw_pgtable_fault *fault = filep->private_data;
+	size_t fault_size = sizeof(struct iommu_fault);
+	struct iommufd_fault *ifault;
+	size_t done = 0;
+
+	if (ppos || count % fault_size)
+		return -ESPIPE;
+
+	mutex_lock(&fault->mutex);
+	while (!list_empty(&fault->deliver) && count > done) {
+		ifault = list_first_entry(&fault->deliver, struct iommufd_fault, item);
+		if (copy_to_user(buf + done, &ifault->fault, fault_size))
+			break;
+		done += fault_size;
+		list_del_init(&ifault->item);
+		if (ifault->fault.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)
+			list_add_tail(&ifault->item, &fault->response);
+		else
+			kfree(ifault);
+	}
+	mutex_unlock(&fault->mutex);
+
+	return done;
+}
+
+static const struct file_operations hwpt_fault_fops = {
+	.owner		= THIS_MODULE,
+	.read		= hwpt_fault_fops_read,
+};
+
+static int hw_pagetable_get_fault_fd(struct hw_pgtable_fault *fault)
+{
+	struct file *filep;
+	int fdno;
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0)
+		return fdno;
+
+	filep = anon_inode_getfile("[iommufd-pgfault]", &hwpt_fault_fops,
+				   fault, O_RDONLY);
+	if (IS_ERR(filep)) {
+		put_unused_fd(fdno);
+		return PTR_ERR(filep);
+	}
+
+	fd_install(fdno, filep);
+	fault->fault_file = filep;
+	fault->fault_fd = fdno;
+
+	return 0;
+}
+
 static struct hw_pgtable_fault *hw_pagetable_fault_alloc(int eventfd)
 {
 	struct hw_pgtable_fault *fault;
@@ -440,8 +500,14 @@ static struct hw_pgtable_fault *hw_pagetable_fault_alloc(int eventfd)
 		goto out_free;
 	}
 
+	rc = hw_pagetable_get_fault_fd(fault);
+	if (rc)
+		goto out_put_eventfd;
+
 	return fault;
 
+out_put_eventfd:
+	eventfd_ctx_put(fault->trigger);
 out_free:
 	kfree(fault);
 	return ERR_PTR(rc);
-- 
2.34.1

