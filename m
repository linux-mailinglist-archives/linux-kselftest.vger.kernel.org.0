Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A6715500
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjE3FjD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjE3Fiv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:38:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4925F9;
        Mon, 29 May 2023 22:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425123; x=1716961123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gr1PrXHXDMunpLUzMb5OW1a71V2+XwQ9sviJMqeoaWE=;
  b=U/cWZ4WqUmSKWxOaqI2CPDZSTJehFGmeT3ftilIZ9vu2zbelFlGe99rz
   4XHVQ2Mxem4lxyrXFDw4FU438ZU6TIbnlAV5thM6aqzPEkMadWX0wPCW0
   R0DOBKFyaAYMgjrh+8ruqfvNWqVOYJqz/qHKxveyHcHqSupDiAbGWPZ7H
   DYmFephLk8/odqQMIGqXswA9FfKrSt7le/5pcl4jT75kDdAZlbRhPYBNm
   +nlbBCNE9fZbbmGb0EpwVgCibjnZUGU9vKy/z6FQWsSel5Ckhq3mcJP50
   8asSFI5s19ax1tfPxPRP11XqWjpKbODpGxjhLT+c4tGjvoNVVxYtJb0XS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579684"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579684"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369541"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369541"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:38:39 -0700
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
Subject: [RFC PATCHES 05/17] iommu: Split IO page fault handling from SVA
Date:   Tue, 30 May 2023 13:37:12 +0800
Message-Id: <20230530053724.232765-6-baolu.lu@linux.intel.com>
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

The current IO page fault handling framework is tightly coupled with the
SVA implementation, as SVA is the only use case that requires IO page
fault handling. However, with the introduction of nested translation, the
first level page table is now managed by userspace. This means that any
IO page fault generated for this first level IO address should be routed
to userspace and handled there.

To support this, we need to split the IO page fault handling framework
from the SVA implementation, and make it generic for all use cases.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                         |  8 ++++++
 drivers/iommu/{iommu-sva.h => io-pgfault.h}   | 26 +++++--------------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  2 +-
 drivers/iommu/intel/iommu.c                   |  2 +-
 drivers/iommu/intel/svm.c                     |  2 +-
 drivers/iommu/io-pgfault.c                    |  2 +-
 drivers/iommu/iommu-sva.c                     |  2 +-
 drivers/iommu/iommu.c                         |  2 +-
 drivers/iommu/Kconfig                         |  4 +++
 drivers/iommu/Makefile                        |  3 ++-
 drivers/iommu/intel/Kconfig                   |  1 +
 12 files changed, 29 insertions(+), 27 deletions(-)
 rename drivers/iommu/{iommu-sva.h => io-pgfault.h} (69%)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f69ac54dc583..c201704f9aea 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1399,6 +1399,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault,
+		      struct device *dev, void *data);
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1417,6 +1420,11 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
+static inline enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault, struct device *dev, void *data)
+{
+	return IOMMU_PAGE_RESP_INVALID;
+}
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/io-pgfault.h
similarity index 69%
rename from drivers/iommu/iommu-sva.h
rename to drivers/iommu/io-pgfault.h
index 5333d6a26047..587844e36554 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/io-pgfault.h
@@ -1,18 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SVA library for IOMMU drivers
+ * I/O page fault helpers for IOMMU drivers
  */
-#ifndef _IOMMU_SVA_H
-#define _IOMMU_SVA_H
+#ifndef _IOMMU_PGFAULT_H
+#define _IOMMU_PGFAULT_H
 
-#include <linux/mm_types.h>
-
-/* I/O Page fault */
 struct device;
 struct iommu_fault;
 struct iopf_queue;
 
-#ifdef CONFIG_IOMMU_SVA
+#ifdef CONFIG_IOMMU_PGFAULT
 int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
 
 int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
@@ -22,11 +19,8 @@ int iopf_queue_flush_dev(struct device *dev);
 struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
-enum iommu_page_response_code
-iommu_sva_handle_iopf(struct iommu_fault *fault,
-		      struct device *dev, void *data);
 
-#else /* CONFIG_IOMMU_SVA */
+#else /* CONFIG_IOMMU_PGFAULT */
 static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
 {
 	return -ENODEV;
@@ -62,11 +56,5 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 {
 	return -ENODEV;
 }
-
-static inline enum iommu_page_response_code
-iommu_sva_handle_iopf(struct iommu_fault *fault, struct device *dev, void *data)
-{
-	return IOMMU_PAGE_RESP_INVALID;
-}
-#endif /* CONFIG_IOMMU_SVA */
-#endif /* _IOMMU_SVA_H */
+#endif /* CONFIG_IOMMU_PGFAULT */
+#endif /* _IOMMU_PGFAULT_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947e..a6401500585b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 
 #include "arm-smmu-v3.h"
-#include "../../iommu-sva.h"
+#include "../../io-pgfault.h"
 #include "../../io-pgtable-arm.h"
 
 struct arm_smmu_mmu_notifier {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8ec4ee5270b1..021e72eade5f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -30,7 +30,7 @@
 
 #include "arm-smmu-v3.h"
 #include "../../dma-iommu.h"
-#include "../../iommu-sva.h"
+#include "../../io-pgfault.h"
 
 static bool disable_bypass = true;
 module_param(disable_bypass, bool, 0444);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 42288bd449a0..7473531c7568 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -26,7 +26,7 @@
 #include "iommu.h"
 #include "../dma-iommu.h"
 #include "../irq_remapping.h"
-#include "../iommu-sva.h"
+#include "../io-pgfault.h"
 #include "pasid.h"
 #include "cap_audit.h"
 #include "perfmon.h"
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e95b339e9cdc..243edc81db75 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -22,7 +22,7 @@
 #include "iommu.h"
 #include "pasid.h"
 #include "perf.h"
-#include "../iommu-sva.h"
+#include "../io-pgfault.h"
 #include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index dedc2ea70970..7e735369a041 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
-#include "iommu-sva.h"
+#include "io-pgfault.h"
 
 /**
  * struct iopf_queue - IO Page Fault queue
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 02574a49275a..585ee56e29d9 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -7,7 +7,7 @@
 #include <linux/sched/mm.h>
 #include <linux/iommu.h>
 
-#include "iommu-sva.h"
+#include "io-pgfault.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
 static DEFINE_IDA(iommu_global_pasid_ida);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fd65ed1d3642..cace57c066f4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -36,7 +36,7 @@
 #include "dma-iommu.h"
 #include "iommu-priv.h"
 
-#include "iommu-sva.h"
+#include "io-pgfault.h"
 
 #include "iommu-priv.h"
 
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index db98c3f86e8c..92ecaf21b355 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -157,6 +157,9 @@ config IOMMU_DMA
 config IOMMU_SVA
 	bool
 
+config IOMMU_PGFAULT
+	bool
+
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PCI
@@ -402,6 +405,7 @@ config ARM_SMMU_V3_SVA
 	bool "Shared Virtual Addressing support for the ARM SMMUv3"
 	depends on ARM_SMMU_V3
 	select IOMMU_SVA
+	select IOMMU_PGFAULT
 	select MMU_NOTIFIER
 	help
 	  Support for sharing process address spaces with devices using the
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 769e43d780ce..ff5c69c7cb02 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
-obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o io-pgfault.o
+obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
+obj-$(CONFIG_IOMMU_PGFAULT) += io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 2e56bd79f589..0c2d9202f8ff 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -15,6 +15,7 @@ config INTEL_IOMMU
 	select DMA_OPS
 	select IOMMU_API
 	select IOMMU_IOVA
+	select IOMMU_PGFAULT
 	select NEED_DMA_MAP_STATE
 	select DMAR_TABLE
 	select SWIOTLB
-- 
2.34.1

