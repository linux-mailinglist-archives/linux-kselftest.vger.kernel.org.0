Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F46B1D5A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCIIJg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCIIJd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:09:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42072036;
        Thu,  9 Mar 2023 00:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349372; x=1709885372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DK2k6evSa483gL5qczVDNJ/CshEmsXAsK8rNm81jnSk=;
  b=lnwSDmgGJIks8FzMKo9E4Qssf9G3eMpwOUyOXyIoPyx0l9RgM4YBixye
   YezXL3H52y2QvB8lQO3Eg6n6mfRa8ScazwsJ7I/OxkVcrm2S00aJv6/zA
   yEYsulrMY7gj2EZex1FoAa3uml5iAwPVHn6YXJTGVAFteReLBVJ28v5fJ
   JaKmLwxXQwpHcbcLEyMD0vZsQXdFGWRdVVKrRtYvn4YeaGglSI6d5MRG8
   lQtcc44fNV8p3vRi/2bZAiW5Qe6O24CNtEErgTOSlxbFK1xZ3hs+FhV+T
   qN6cJqG5VV56QHvXf6dl1u2z8/2N2PxxaoHqheVdBJDvk8JAWBJGoi4QN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023019"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023019"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471356"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471356"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:21 -0800
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
Subject: [PATCH 02/12] iommu: Add nested domain support
Date:   Thu,  9 Mar 2023 00:09:00 -0800
Message-Id: <20230309080910.607396-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
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

Introduce a new domain type for a user space I/O address, which is nested
on top of another user space address represented by a UNMANAGED domain. The
mappings of a nested domain are managed by user space software, therefore
it's unnecessary to have map/unmap callbacks. But the updates of the PTEs
in the nested domain page table must be propagated to the caches on both
IOMMU (IOTLB) and devices (DevTLB).

The nested domain is allocated by the domain_alloc_user op, and attached
to the device through the existing iommu_attach_device/group() interfaces.

A new domain op, named cache_invalidate_user is added for the userspace to
flush the hardware caches for a nested domain through iommufd. No wrapper
for it, as it's only supposed to be used by iommufd.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a269bc62a31c..080278c8154d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -67,6 +67,9 @@ struct iommu_domain_geometry {
 
 #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
 
+#define __IOMMU_DOMAIN_NESTED	(1U << 5)  /* User-managed IOVA nested on
+					      a stage-2 translation        */
+
 /*
  * This are the possible domain-types
  *
@@ -92,6 +95,7 @@ struct iommu_domain_geometry {
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
 #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
+#define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
 
 struct iommu_domain {
 	unsigned type;
@@ -325,6 +329,7 @@ struct iommu_ops {
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
+ * @cache_invalidate_user: Flush hardware TLBs caching user space IO mappings
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
@@ -354,6 +359,8 @@ struct iommu_domain_ops {
 			       size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain,
 			   struct iommu_iotlb_gather *iotlb_gather);
+	void (*cache_invalidate_user)(struct iommu_domain *domain,
+				      void *user_data);
 
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
-- 
2.34.1

