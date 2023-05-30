Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D30715515
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjE3FlR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjE3Fkk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:40:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1684011C;
        Mon, 29 May 2023 22:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425221; x=1716961221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m2M+k/wNJUpLwNpk+M4ahpND6qZ7v9d+7FJR9k8IhpI=;
  b=XUig3CMzlCFHMc2SGR3BCTOkCeVg+Rjbuu8FNXcIjeS8lUD9ivQ4z0+2
   ZaGMW9S/S6Rf7sbJb+M02dQt/oMWPwiZfaXpI0WOlhbzFEVRrRjJg4nrA
   dnxcLxWjH/bOZJtOtKq0iR6ag5SYPwUJz8N9fi+SK4q1/bgC+Lxc5b0vw
   Mvn/Is7boI6zjjWQ7DPVsNo6uqzQoMYY3AJZrIBRUDjU4GatCFPejCMHY
   x8EIk9OOv6iEizearEIB4j05gaHE0/cpcXBezM2E2IljQbV/aaO8xBJgO
   j3W2BLO/YBcJUTRrJrNhLhgM3tKGnLP4VcKp+wxEAhAI75VEa2nJjhXy9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579880"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579880"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369909"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369909"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:39:15 -0700
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
Subject: [RFC PATCHES 14/17] iommufd: Drain all pending faults when destroying hwpt
Date:   Tue, 30 May 2023 13:37:21 +0800
Message-Id: <20230530053724.232765-15-baolu.lu@linux.intel.com>
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

When a HWPT is unexpectedly destroyed, drain all faults in the pending
lists. It is safe because the iommu domain has been released and there
will never be new io page faults anymore.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 8c441fd72e1f..7f18e6bd76ec 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -574,11 +574,26 @@ static struct hw_pgtable_fault *hw_pagetable_fault_alloc(int eventfd)
 	return ERR_PTR(rc);
 }
 
+static void iommufd_fault_list_destroy(struct hw_pgtable_fault *fault,
+				       struct list_head *list)
+{
+	struct iommufd_fault *ifault;
+
+	mutex_lock(&fault->mutex);
+	while (!list_empty(list)) {
+		ifault = list_first_entry(list, struct iommufd_fault, item);
+		if (iommufd_fault_timer_teardown(ifault))
+			drain_iopf_fault(ifault);
+		list_del_init(&ifault->item);
+		iommufd_put_fault(ifault);
+	}
+	mutex_unlock(&fault->mutex);
+}
+
 static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
 {
-	WARN_ON(!list_empty(&fault->deliver));
-	WARN_ON(!list_empty(&fault->response));
-
+	iommufd_fault_list_destroy(fault, &fault->deliver);
+	iommufd_fault_list_destroy(fault, &fault->response);
 	eventfd_ctx_put(fault->trigger);
 	kfree(fault);
 }
-- 
2.34.1

