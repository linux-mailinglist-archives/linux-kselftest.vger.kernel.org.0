Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A77A5DC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjISJ0W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 05:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjISJ0U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 05:26:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59984134;
        Tue, 19 Sep 2023 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695115573; x=1726651573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q66OHCFRu99evLMCHuExKGxiNMAzbw1601UJQaxYYqQ=;
  b=SxEwXDz+jalvWe/dutrmWsSyZEo1t4MwJCSVo4ZcJjd7SiGvrivuok03
   mWCpZ0VUbJWyub9fzTdF2CfCHOZgWGK02iDOiFLkniNnnNmadyVMXZJE7
   UrtC7VXOBRud+FkfLTLdPBOnhLaHsLebLHju2Y3XTPbIZvkZXKTAd6FFP
   rggKnkWOXzI/SXx9dGlE458WzuGfhNRodh1hpsakeYG61u2EwBbXj1G0e
   uksDIwQRNylTtHUVx+8/9fjFzYhacLrz1BaxnHdQzZjYnhvQp5WImiTkj
   6v1DamzK7dyvl0SaAYTxDuW+P5X1PnR6g99Bu2io0DTRTcNjbzg2uF0lk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446368928"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="446368928"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722804772"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="722804772"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2023 02:25:34 -0700
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
Subject: [PATCH 4/6] iommufd/hw_pagetable: Support allocating nested parent domain
Date:   Tue, 19 Sep 2023 02:25:21 -0700
Message-Id: <20230919092523.39286-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919092523.39286-1-yi.l.liu@intel.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This extends IOMMU_HWPT_ALLOC to allocate domains used as parent (stage-2)
in nested translation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 5be7a31cbd9c..26a8a818ffa3 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -83,6 +83,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	lockdep_assert_held(&ioas->mutex);
 
+	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -154,7 +157,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	struct iommufd_ioas *ioas;
 	int rc;
 
-	if (cmd->flags || cmd->__reserved)
+	if (cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT || cmd->__reserved)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
-- 
2.34.1

