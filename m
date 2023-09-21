Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38277AA27B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 23:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjIUVTS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 17:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjIUVTE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 17:19:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38BC7DBA;
        Thu, 21 Sep 2023 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316242; x=1726852242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2qafvDTEA4tHJGGUOtUPjMOBwx7ln2B9qY4E8ARD9Lg=;
  b=kXGNE3tnjII73oaq+TCn5QHy2JltX0wmnnWnFwAj0MMCJzLexs/Ub+/M
   4CVR4+9m2SQ7RPbKSZ2aOyQOjwnAvR3kSspiK+B3XskX/4DU1eZqwgh62
   ngl9z2yq9jKJdJKlhpxfC0PbIO6wqz4duzzXYIUTtKgALRYa0vO/ji+7K
   Bgmxe6PXX0O7jrZMBYvumQ4ntEtQudiU8nFe8nqSTgmAYWhx5c97LfeY2
   wjc1L1xSPUKIpa9ptPx7ggSTNImIlkEvOcig4miYnFokle3PoJ6DpxJBi
   RBSgi6qNPNGfH4+ZDn/zIEhIxrEn0DV827iQhfxouOCF/fOzOGKyUAlcz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764386"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764386"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812523053"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812523053"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:44 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v5 02/11] iommu/vt-d: Extend dmar_domain to support nested domain
Date:   Thu, 21 Sep 2023 00:54:22 -0700
Message-Id: <20230921075431.125239-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075431.125239-1-yi.l.liu@intel.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

The nested domain fields are exclusive to those that used for a DMA
remapping domain. Use union to avoid memory waste.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.h | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c18fb699c87a..4a7f1cc16afa 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -597,15 +597,38 @@ struct dmar_domain {
 	struct list_head devices;	/* all devices' list */
 	struct list_head dev_pasids;	/* all attached pasids */
 
-	struct dma_pte	*pgd;		/* virtual address */
-	int		gaw;		/* max guest address width */
-
-	/* adjusted guest address width, 0 is level 2 30-bit */
-	int		agaw;
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
-	u64		max_addr;	/* maximum mapped address */
+	union {
+		/* DMA remapping domain */
+		struct {
+			/* virtual address */
+			struct dma_pte	*pgd;
+			/* max guest address width */
+			int		gaw;
+			/*
+			 * adjusted guest address width:
+			 *   0: level 2 30-bit
+			 *   1: level 3 39-bit
+			 *   2: level 4 48-bit
+			 *   3: level 5 57-bit
+			 */
+			int		agaw;
+			/* maximum mapped address */
+			u64		max_addr;
+		};
+
+		/* Nested user domain */
+		struct {
+			/* parent page table which the user domain is nested on */
+			struct dmar_domain *s2_domain;
+			/* user page table pointer (in GPA) */
+			unsigned long s1_pgtbl;
+			/* page table attributes */
+			struct iommu_hwpt_vtd_s1 s1_cfg;
+		};
+	};
 
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
-- 
2.34.1

