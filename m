Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948F3715502
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjE3FkQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjE3Fjr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:39:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0729FEC;
        Mon, 29 May 2023 22:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425172; x=1716961172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6jgEaCBH1za2zv3I11ejxRFyRn62+jMYqJd6rX08Vs=;
  b=BhZDgvEKW3OfNlunv3CyGbDPaAvQUrhY4KO35oqlvKGvvLlpaTb2nh+H
   jmh3auU/Yrj82o7VEK2DjyGBHLb0S/L5IL9+IhV/QNZyg7Sww2KTHYmyI
   QE3/tIVnLOfvRFKzDI/+OaZ1/SgUweYdBJelqoP8c4P/DaMAensgzfG1v
   fbj6tGBC/7799MKqWPg4a6v5vCczPG3nFd8aWB/IaJFh0mEFhxpRoyD7L
   mwnMFDDiPXkxM6XxTqy+48r29UXH5jvOjm2Vqa4lpwZnT5sihef6vvNSX
   7VtlBuoGYbybH4rSlKl3kIknLjdCe7wfNg5QjWUf1gQIWqzxLxYKaFRf+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579717"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579717"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369579"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369579"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:38:43 -0700
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
Subject: [RFC PATCHES 06/17] iommu: Add iommu page fault cookie helpers
Date:   Tue, 30 May 2023 13:37:13 +0800
Message-Id: <20230530053724.232765-7-baolu.lu@linux.intel.com>
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

Add an xarray in iommu_fault_param as place holder for per-{device, pasid}
fault cookie. The iommufd will use it to store the mapping of device object
ID and the device pointer. This allows the iommufd to quickly retrieve the
device object ID for a given {device, pasid} pair in the hot path of IO
page fault delivery.

Otherwise, the iommufd would have to maintain its own data structures to
map {device, pasid} pairs to object IDs, and then look up the object ID on
the critical path. This is not performance friendly.

The iommufd is supposed to set the cookie when a fault capable domain is
attached to the physical device or pasid, and clear the fault cookie when the
domain is removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      |  2 ++
 drivers/iommu/iommu-priv.h |  3 +++
 drivers/iommu/iommu.c      | 45 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c201704f9aea..9b0058ac971c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -617,12 +617,14 @@ struct iommu_fault_event {
  * @data: handler private data
  * @faults: holds the pending faults which needs response
  * @lock: protect pending faults list
+ * @pasid_cookie: per-pasid fault cookie
  */
 struct iommu_fault_param {
 	iommu_dev_fault_handler_t handler;
 	void *data;
 	struct list_head faults;
 	struct mutex lock;
+	struct xarray pasid_cookie;
 };
 
 /**
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index a6e694f59f64..17ab989702a0 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -17,5 +17,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
+void *iommu_set_device_fault_cookie(struct device *dev, ioasid_t pasid,
+				    void *cookie);
+void *iommu_get_device_fault_cookie(struct device *dev, ioasid_t pasid);
 
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cace57c066f4..2f81be7f3a90 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1270,6 +1270,7 @@ int iommu_register_device_fault_handler(struct device *dev,
 	param->fault_param->data = data;
 	mutex_init(&param->fault_param->lock);
 	INIT_LIST_HEAD(&param->fault_param->faults);
+	xa_init(&param->fault_param->pasid_cookie);
 
 done_unlock:
 	mutex_unlock(&param->lock);
@@ -1435,6 +1436,50 @@ int iommu_page_response(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_page_response);
 
+/**
+ * iommu_set_device_fault_cookie - Set a fault cookie for per-{device, pasid}
+ * @dev: the device to set the cookie
+ * @pasid: the pasid on this device
+ * @cookie: the opaque data
+ *
+ * Return the old cookie on success, or ERR_PTR(err#) on failure.
+ */
+void *iommu_set_device_fault_cookie(struct device *dev, ioasid_t pasid,
+				    void *cookie)
+{
+	struct iommu_fault_param *fault_param;
+	void *curr;
+
+	if (!dev->iommu || !dev->iommu->fault_param)
+		return ERR_PTR(-ENODEV);
+
+	fault_param = dev->iommu->fault_param;
+	curr = xa_store(&fault_param->pasid_cookie, pasid, cookie, GFP_KERNEL);
+
+	return xa_is_err(curr) ? ERR_PTR(xa_err(curr)) : curr;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_set_device_fault_cookie, IOMMUFD_INTERNAL);
+
+/**
+ * iommu_get_device_fault_cookie - Get the fault cookie for {device, pasid}
+ * @dev: the device to set the cookie
+ * @pasid: the pasid on this device
+ *
+ * Return the cookie on success, or ERR_PTR(err#) on failure.
+ */
+void *iommu_get_device_fault_cookie(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_fault_param *fault_param;
+
+	if (!dev->iommu || !dev->iommu->fault_param)
+		return ERR_PTR(-ENODEV);
+
+	fault_param = dev->iommu->fault_param;
+
+	return xa_load(&fault_param->pasid_cookie, pasid);
+}
+EXPORT_SYMBOL_NS_GPL(iommu_get_device_fault_cookie, IOMMUFD_INTERNAL);
+
 /**
  * iommu_group_id - Return ID for a group
  * @group: the group to ID
-- 
2.34.1

