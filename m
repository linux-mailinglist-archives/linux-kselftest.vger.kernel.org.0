Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8853D7B1476
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjI1HPt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjI1HPn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 03:15:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D35CC0;
        Thu, 28 Sep 2023 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695885341; x=1727421341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=caYY16c3X4qJEs7vjlwRO/5AoAt3WHXwfSZCdiD2ZmE=;
  b=MUUMRgTThCSMlVV1j4ZAkDCiQnN9ahJ6PcuzU+TcvyVcHdmKXm8mQy/F
   g+aAp8eaWWt/Te+fZL3WWhBmn6nKxpYDZDEVMpnN8ProDarasVWjq+4c8
   VkYWlZkfoHhL0Pd+5xO1+G2i+/Pc9m0Vp5TFJFlLkTABF/rXNwnpQFpvr
   2CXqJYOih/iLUOE5kDpWrP6E5EH2Ry4iaPh6XPmwo1l/bTqxlHDB9ijOA
   yvddVyVhU3n9kD3aiazM2aqmWI40jlWP72/xnU9snwxIyt6pTv5KwNYbN
   +LqUS+2BpDfjQGXGz5fVOmtVooC9h75rOJ0zcTap1qW+Lp0oZcbn3ijS1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412914872"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="412914872"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784602100"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784602100"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2023 00:15:36 -0700
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
Subject: [PATCH v2 4/6] iommufd/hw_pagetable: Support allocating nested parent domain
Date:   Thu, 28 Sep 2023 00:15:26 -0700
Message-Id: <20230928071528.26258-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928071528.26258-1-yi.l.liu@intel.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
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

This extends IOMMU_HWPT_ALLOC to allocate domains used as parent (stage-2)
in nested translation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 5be7a31cbd9c..8b3d2875d642 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -83,6 +83,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	lockdep_assert_held(&ioas->mutex);
 
+	if (flags && !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -154,7 +157,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	struct iommufd_ioas *ioas;
 	int rc;
 
-	if (cmd->flags || cmd->__reserved)
+	if ((cmd->flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT)) || cmd->__reserved)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
-- 
2.34.1

