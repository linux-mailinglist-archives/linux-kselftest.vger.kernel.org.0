Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E2C75F497
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGXLNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGXLNk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:13:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB303FF;
        Mon, 24 Jul 2023 04:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197219; x=1721733219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kbYmkqlWfiZyr5V+MfSLsZH2Swvwd5lpXr1iZWBr3EE=;
  b=h5jMYAklhnvQiIq5nhQPUHJewqu0FTxB5NBsGJ//VHIcCFbf8T0cDNtF
   67rZmTJBmFZNWopV+zKP0ZgmLlyI6NGekBzlIjp5Bz6m/H9OTTw726PVD
   8/nEgtvv8nZRNFrH6Plp5aV6jIjVXxXy7JCR5ozpxc4Xn/9dazTGGodGa
   c61Qw6lCtS7UiAmoSrcBxbRXJGP0tRYrpFaQIr+bfsPECN09kdE49Hdp5
   HE1YRgNBO3OkxGTpI1wlK+wCdg15C97Rd1lN6yd6ihOE4aDvNcYXpUjdF
   CidUeDH/E1CNEj5HPUf4ezi7DgEaDLkoNxEteLg5F4lhS0gHFxvo6u08E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347014921"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347014921"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415485"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415485"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:38 -0700
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
        zhenzhong.duan@intel.com
Subject: [PATCH v4 01/12] iommufd: Add data structure for Intel VT-d stage-1 domain allocation
Date:   Mon, 24 Jul 2023 04:13:23 -0700
Message-Id: <20230724111335.107427-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724111335.107427-1-yi.l.liu@intel.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds IOMMU_HWPT_TYPE_VTD_S1 for stage-1 hw_pagetable of Intel VT-d
and the corressponding data structure for userspace specified parameter
for the domain allocation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/uapi/linux/iommufd.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index ede822e5acbb..90b0d3f603a7 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -351,12 +351,45 @@ struct iommu_vfio_ioas {
 };
 #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
 
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
+ * struct iommu_hwpt_vtd_s1 - Intel VT-d specific user-managed stage-1
+ *                            page table info (IOMMU_HWPT_TYPE_VTD_S1)
+ * @flags: Combination of enum iommu_hwpt_vtd_s1_flags
+ * @pgtbl_addr: The base address of the stage-1 page table.
+ * @addr_width: The address width of the stage-1 page table
+ * @__reserved: Must be 0
+ *
+ * VT-d specific data for creating a stage-1 page table that is used
+ * in nested translation.
+ */
+struct iommu_hwpt_vtd_s1 {
+	__aligned_u64 flags;
+	__aligned_u64 pgtbl_addr;
+	__u32 addr_width;
+	__u32 __reserved;
+};
+
 /**
  * enum iommu_hwpt_type - IOMMU HWPT Type
  * @IOMMU_HWPT_TYPE_DEFAULT: default
+ * @IOMMU_HWPT_TYPE_VTD_S1: Intel VT-d stage-1 page table
  */
 enum iommu_hwpt_type {
 	IOMMU_HWPT_TYPE_DEFAULT,
+	IOMMU_HWPT_TYPE_VTD_S1,
 };
 
 /**
-- 
2.34.1

