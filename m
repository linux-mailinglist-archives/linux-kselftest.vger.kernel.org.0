Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426CD7D7B10
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 04:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjJZCxm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 22:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjJZCxl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 22:53:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E3185;
        Wed, 25 Oct 2023 19:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698288818; x=1729824818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VBLOjlJxAcdax0Z6JAId0gaInjYlScrClZox6xpbv6s=;
  b=DGzz4OkQ2Q2YaekIQzgNct7SvJRPQM1P+XgU9Y0kg0JmIYwX8VKSFkso
   WoOB/cHBtDp35ifD/TprFZ2dTR1pOx1csdJ9IB+b68hN2MQWX8I1h+PVm
   CjmV77azBSCYjqMJF4Dj0tq4bNYhGMG+CFD3X3ZOzj6g+Wv1AJC6F+Rtw
   Syu8lZlkolIs623Rt1+hXORfwTMPgxZYTMuVqeZp0JHIMB5y3Gjn1Nb2Z
   eQR7gjzOglngIWPUeFhTv88OrIYMxoM/8I+tO8Bknp1pU/49H8ogao0cK
   zHhv6nMo01ccpZ49t6Ih/d8tJOEdEnohwDmaskckLeYzZXYsJh8DszEpd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391316150"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="391316150"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 19:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735604492"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="735604492"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2023 19:53:34 -0700
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
Subject: [PATCH v2 1/6] iommu: Add iommu page fault cookie helpers
Date:   Thu, 26 Oct 2023 10:49:25 +0800
Message-Id: <20231026024930.382898-2-baolu.lu@linux.intel.com>
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

Add an xarray in iommu_fault_param as place holder for per-{device, pasid}
fault cookie. The iommufd will use it to store the iommufd device pointers.
This allows the iommufd to quickly retrieve the device object ID for a
given {device, pasid} pair in the hot path of I/O page fault delivery.

Otherwise, the iommufd would have to maintain its own data structures to
map {device, pasid} pairs to object IDs, and then look up the object ID on
the critical path. This is not performance friendly.

The iommufd is supposed to set the cookie when a fault capable domain is
attached to the physical device or pasid, and clear the fault cookie when
the domain is removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      |  3 +++
 drivers/iommu/iommu-priv.h | 15 ++++++++++++
 drivers/iommu/io-pgfault.c | 50 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2ca3a3eda2e4..615d8a5f9dee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -608,6 +608,8 @@ struct iommu_device {
  * @dev: the device that owns this param
  * @queue: IOPF queue
  * @queue_list: index into queue->devices
+ * @pasid_cookie: per-pasid fault cookie used by fault message consumers.
+ *                This array is self-protected by xa_lock().
  * @partial: faults that are part of a Page Request Group for which the last
  *           request hasn't been submitted yet.
  * @faults: holds the pending faults which needs response
@@ -619,6 +621,7 @@ struct iommu_fault_param {
 	struct device *dev;
 	struct iopf_queue *queue;
 	struct list_head queue_list;
+	struct xarray pasid_cookie;
 
 	struct list_head partial;
 	struct list_head faults;
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 2024a2313348..0dc5ad81cbb6 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -27,4 +27,19 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 struct bus_type *bus,
 				 struct notifier_block *nb);
 
+#ifdef CONFIG_IOMMU_IOPF
+void *iopf_pasid_cookie_set(struct device *dev, ioasid_t pasid, void *cookie);
+void *iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid);
+#else
+static inline void *iopf_pasid_cookie_set(struct device *dev, ioasid_t pasid, void *cookie)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void *iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif /* CONFIG_IOMMU_IOPF */
+
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index b288c73f2b22..6fa029538deb 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -454,6 +454,7 @@ int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
 	mutex_init(&fault_param->lock);
 	INIT_LIST_HEAD(&fault_param->faults);
 	INIT_LIST_HEAD(&fault_param->partial);
+	xa_init(&fault_param->pasid_cookie);
 	fault_param->dev = dev;
 	fault_param->users = 1;
 	list_add(&fault_param->queue_list, &queue->devices);
@@ -575,3 +576,52 @@ void iopf_queue_free(struct iopf_queue *queue)
 	kfree(queue);
 }
 EXPORT_SYMBOL_GPL(iopf_queue_free);
+
+/**
+ * iopf_pasid_cookie_set - Set a fault cookie for per-{device, pasid}
+ * @dev: the device to set the cookie
+ * @pasid: the pasid on this device
+ * @cookie: the opaque data
+ *
+ * Return the old cookie on success, or ERR_PTR on failure.
+ */
+void *iopf_pasid_cookie_set(struct device *dev, ioasid_t pasid, void *cookie)
+{
+	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
+	void *curr;
+
+	if (!iopf_param)
+		return ERR_PTR(-ENODEV);
+
+	curr = xa_store(&iopf_param->pasid_cookie, pasid, cookie, GFP_KERNEL);
+	iopf_put_dev_fault_param(iopf_param);
+
+	return xa_is_err(curr) ? ERR_PTR(xa_err(curr)) : curr;
+}
+EXPORT_SYMBOL_NS_GPL(iopf_pasid_cookie_set, IOMMUFD_INTERNAL);
+
+/**
+ * iopf_pasid_cookie_get - Get the fault cookie for {device, pasid}
+ * @dev: the device where the cookie was set
+ * @pasid: the pasid on this device
+ *
+ * Return the cookie on success, or ERR_PTR on failure. Note that NULL is
+ * also a successful return.
+ */
+void *iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
+	void *curr;
+
+	if (!iopf_param)
+		return ERR_PTR(-ENODEV);
+
+	xa_lock(&iopf_param->pasid_cookie);
+	curr = xa_load(&iopf_param->pasid_cookie, pasid);
+	xa_unlock(&iopf_param->pasid_cookie);
+
+	iopf_put_dev_fault_param(iopf_param);
+
+	return curr;
+}
+EXPORT_SYMBOL_NS_GPL(iopf_pasid_cookie_get, IOMMUFD_INTERNAL);
-- 
2.34.1

