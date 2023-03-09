Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054BC6B1DF5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCIIZJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCIIYS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:24:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CD514EB0;
        Thu,  9 Mar 2023 00:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350183; x=1709886183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8FKzjXidbvZaREDXMrJoGHp6nNM9UNsEUhh+2h9xdEU=;
  b=XIXig3ooZb2MMzfG0jTf82bP75lFMg7lxkaYwr0o4/HCJClgpSHn0L8A
   Rjzj/w23G1AaUbKlde2wgC0Aumi13wv4GCSqTw5wkWh0Tv/d8Zu2Je1uA
   jV30KBXPDWm/zS26cgrsvzdCSCcgd++GkQioK/omttmFead8IRYV1encZ
   3RgsnqQuWV08MznmydJRl+4QygwpTNtJUR3JZiW2cSD+Hth7MuNHbWs7T
   xWX1DjhSG/ppnXf5MkLp3IXOa58852vEQHfT66mcfP5lqZRBxccP7bYwF
   Z0yW7hGyo3VnQQTuaQnsIY/J+5qoxm23B7T2MvroCvUayTU7QCiLx1Se8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364026207"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364026207"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787474152"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787474152"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:22:12 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/5] iommu/vt-d: Implement hw_info for iommu capability query
Date:   Thu,  9 Mar 2023 00:22:04 -0800
Message-Id: <20230309082207.612346-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309082207.612346-1-yi.l.liu@intel.com>
References: <20230309082207.612346-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 19 +++++++++++++++++++
 drivers/iommu/intel/iommu.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2f4bd33582..004406209793 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4780,8 +4780,26 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 }
 
+static void *intel_iommu_hw_info(struct device *dev, u32 *length)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_hw_info_vtd *vtd;
+
+	vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
+	if (!vtd)
+		return ERR_PTR(-ENOMEM);
+
+	vtd->cap_reg = iommu->cap;
+	vtd->ecap_reg = iommu->ecap;
+	*length = sizeof(*vtd);
+
+	return vtd;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
+	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
@@ -4794,6 +4812,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.def_domain_type	= device_def_domain_type,
 	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
+	.driver_type		= IOMMU_HW_INFO_TYPE_INTEL_VTD,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.page_response		= intel_svm_page_response,
 #endif
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d6df3b865812..9871de2170eb 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -23,6 +23,7 @@
 #include <linux/bitfield.h>
 #include <linux/xarray.h>
 #include <linux/perf_event.h>
+#include <uapi/linux/iommufd.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
-- 
2.34.1

