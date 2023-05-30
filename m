Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089887154FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjE3Fis (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjE3Fip (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:38:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDEF10A;
        Mon, 29 May 2023 22:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425119; x=1716961119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h1z/1a3RfZ5jKSl5h5yWsantwr32xIn20gPZtjOFYMo=;
  b=GtToZCREpNKxc5SOl7DuRNoIq/Tp6XopyV242inU8cT6RZgUVSrCpZf1
   UqJCSWpsu4+ZyuG66lcsUcbWy+Ctzv+9YUjzKSq9hf/4DkMVhuQqiA2zh
   w6Tz8F/FEb7jw2SVTGM/Kh9PbLQnkRcrqRAL5TCE0Nc8hiP84UZ5M1KDz
   R8SozzEY4ctEx6K62Byy0FLHVqrRUia214D/gVtKm4jyOFYeCdLuOwYVU
   u4NaPJFsBfboRpXzXI2YpW6ydK0krBeKjUJbMA2A2aMyA9jc7QP52aBwl
   xeYpVyXvyvM6mxVmmi0ByJ7ShEaQVh0IQV7EBtU6amqHzVNNfrwJl36RJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579666"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579666"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:38:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369506"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369506"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:38:36 -0700
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
Subject: [RFC PATCHES 04/17] iommu: Pass device parameter to iopf handler
Date:   Tue, 30 May 2023 13:37:11 +0800
Message-Id: <20230530053724.232765-5-baolu.lu@linux.intel.com>
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

So that IOMMUFD can route the io page fault to the user space with the
device id, which was generated when the user space bound the device to
an IOAS.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      | 2 ++
 drivers/iommu/iommu-sva.h  | 5 +++--
 drivers/iommu/io-pgfault.c | 2 +-
 drivers/iommu/iommu-sva.c  | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f554328528bc..f69ac54dc583 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -254,6 +254,7 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
 	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
+						      struct device *dev,
 						      void *data);
 	void *fault_data;
 	union {
@@ -276,6 +277,7 @@ static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
 static inline void
 iommu_domain_set_iopf_handler(struct iommu_domain *domain,
 		enum iommu_page_response_code (*handler)(struct iommu_fault *fault,
+							 struct device *dev,
 							 void *data),
 		void *data)
 {
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index 54946b5a7caf..5333d6a26047 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -23,7 +23,8 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
 enum iommu_page_response_code
-iommu_sva_handle_iopf(struct iommu_fault *fault, void *data);
+iommu_sva_handle_iopf(struct iommu_fault *fault,
+		      struct device *dev, void *data);
 
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
@@ -63,7 +64,7 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 }
 
 static inline enum iommu_page_response_code
-iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
+iommu_sva_handle_iopf(struct iommu_fault *fault, struct device *dev, void *data)
 {
 	return IOMMU_PAGE_RESP_INVALID;
 }
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 83f8055a0e09..dedc2ea70970 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -88,7 +88,7 @@ static void iopf_handler(struct work_struct *work)
 		 * faults in the group if there is an error.
 		 */
 		if (status == IOMMU_PAGE_RESP_SUCCESS)
-			status = domain->iopf_handler(&iopf->fault,
+			status = domain->iopf_handler(&iopf->fault, group->dev,
 						      domain->fault_data);
 
 		if (!(iopf->fault.prm.flags &
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 9821bc44f5ac..02574a49275a 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
  * I/O page fault handler for SVA
  */
 enum iommu_page_response_code
-iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
+iommu_sva_handle_iopf(struct iommu_fault *fault, struct device *dev, void *data)
 {
 	vm_fault_t ret;
 	struct vm_area_struct *vma;
-- 
2.34.1

