Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8267D7BB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjJZEnO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjJZEm4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:42:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD9B1734;
        Wed, 25 Oct 2023 21:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295371; x=1729831371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kJQbhlGr3UHL/vwCI8YpVWg6//iOWpSzH/c2w2J/uEw=;
  b=ZFOZPb1T3Gj1YYCYU+F6E0D5EgWm4vkkAKtZmjyRtg15IlhoYyVAV0Tq
   Di3kvMw9F/7q+WM5pIM9pdofavzIgEr9GKKhjCVqqGp0ff/QTqZ2NgPES
   FgPyl51/fni3P0chEkzUpkW/itGFeYCD8w/EJZWbiMhdHua2RbzmLqong
   sIfuty+nznhyAwKXfm7g4EFA8UtO6IrhFsvHqrkTRZt89K+xzWslYp5in
   x+iQZLspbt7nwaPSXV3egkrXQQjuQnshQgXyHvJa24i9B8C2OVy4oDfd3
   f47FVrZ9zB4JKknXFNdTPOEVQFscL6oGsBkCoHeHAS+scXCJqtL6RgZI2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="367670720"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="367670720"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829478509"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="829478509"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2023 21:42:19 -0700
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com
Subject: [PATCH v8 1/8] iommufd: Add data structure for Intel VT-d stage-1 domain allocation
Date:   Wed, 25 Oct 2023 21:42:09 -0700
Message-Id: <20231026044216.64964-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026044216.64964-1-yi.l.liu@intel.com>
References: <20231026044216.64964-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds IOMMU_HWPT_DATA_VTD_S1 for stage-1 hw_pagetable of Intel
VT-d and the corressponding data structure for userspace specified parameter
for the domain allocation.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/uapi/linux/iommufd.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d816deac906f..3ce5ee5f09b6 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -361,12 +361,42 @@ enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
 };
 
+/**
+ * enum iommu_hwpt_vtd_s1_flags - Intel VT-d stage-1 page table
+ *                                entry attributes
+ * @IOMMU_VTD_S1_SRE: Supervisor request
+ * @IOMMU_VTD_S1_EAFE: Extended access enable
+ * @IOMMU_VTD_S1_WPE: Write protect enable
+ */
+enum iommu_hwpt_vtd_s1_flags {
+	IOMMU_VTD_S1_SRE = 1 << 0,
+	IOMMU_VTD_S1_EAFE = 1 << 1,
+	IOMMU_VTD_S1_WPE = 1 << 2,
+};
+
+/**
+ * struct iommu_hwpt_vtd_s1 - Intel VT-d stage-1 page table
+ *                            info (IOMMU_HWPT_DATA_VTD_S1)
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_flags
+ * @pgtbl_addr: The base address of the stage-1 page table.
+ * @addr_width: The address width of the stage-1 page table
+ * @__reserved: Must be 0
+ */
+struct iommu_hwpt_vtd_s1 {
+	__aligned_u64 flags;
+	__aligned_u64 pgtbl_addr;
+	__u32 addr_width;
+	__u32 __reserved;
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
+ * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE,
+	IOMMU_HWPT_DATA_VTD_S1,
 };
 
 /**
-- 
2.34.1

