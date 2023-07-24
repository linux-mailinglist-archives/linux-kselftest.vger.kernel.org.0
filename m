Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED375F49A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjGXLNn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjGXLNl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:13:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD364114;
        Mon, 24 Jul 2023 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197220; x=1721733220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VOFDrdAUdKDrGUTcWG8cO7SO98h9HJ976K854LoNQqw=;
  b=NNTrrXA28otY2ii4eUDMXo9O8lF0ZNeQg58PeLnnVHOupvQKrA/+1VYd
   KDqAj4Pw5SV8D2kRLGcVnckNffXCSU9JqwPXIWHNziRspPTtyJJtkA6vo
   9HKjbMNM+1GQBUW5Yy9uGIraCOK4hdrRVBiw4qGYq2KwID7/aJf4L+ReH
   56BLBhIAl5uljjz6108chqRy40X8jtVrHQ0PWtKP6/fSW9IdXBI5CX0UY
   hHoD2JiwxMjNCGDNhleGf+WB8JRTxV/fV117J3cfBUi0DVE5J3pTgAZds
   M14uHOpavggCqQCBOtCID9tJieHaHgxLaaDWh0l68MYkkCQXtapKlFGbB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347014932"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347014932"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415490"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415490"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:39 -0700
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
Subject: [PATCH v4 02/12] iommu/vt-d: Extend dmar_domain to support nested domain
Date:   Mon, 24 Jul 2023 04:13:24 -0700
Message-Id: <20230724111335.107427-3-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

The nested domain fields are exclusive to those that used for a DMA
remapping domain. Use union to avoid memory waste.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.h | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1c5e1d88862b..565e6ae54d32 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -596,15 +596,38 @@ struct dmar_domain {
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
 
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

