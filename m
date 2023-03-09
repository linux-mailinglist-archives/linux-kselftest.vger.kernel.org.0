Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C16B1D63
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCIIJj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCIIJe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:09:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F657302F;
        Thu,  9 Mar 2023 00:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349373; x=1709885373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ze+YqyOq2FcrfezTmpCROik4OQxGxrLylWyUGP+0lZs=;
  b=gUaae1S1QdkkM12C3plJrp3gD35ZIuOuIl0wqjG6ppAaRe8HxEABnC2z
   Jrrfh64Az5sC4l+j3d7I2IRhNcn5OBwaykka1Z+/DwFzmDgrU0ZSiynWN
   2yH0fsBwNf+zmALZFX42BtlOxbU6ChxFC+Z3pX2qs3xg7vu2YJwnbCH6L
   +9aYgtrFkHVyzCSheMdGJPfAyglR470sUSa9b6OsvOw/jqkFp1dg4atmm
   3zkKTHG6ffNa0eocEt/o66AIdd9IDwTU1r6AIwkaFV6SvAKxasksubk7l
   wb8UHAwjwWl5kMELY1Q/iVI5vd5sZcv6RiB4ldIiaLf3lk5mOixZ70nRz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023072"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471382"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471382"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:26 -0800
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
Subject: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed hw_pagetables
Date:   Thu,  9 Mar 2023 00:09:03 -0800
Message-Id: <20230309080910.607396-6-yi.l.liu@intel.com>
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

From: Nicolin Chen <nicolinc@nvidia.com>

A user-managed hw_pagetable does not need to get populated, since it is
managed by a guest OS. Move the iopt_table_add_domain and list_add_tail
calls into a helper, where the hwpt pointer will be redirected to its
hwpt->parent if it's available.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 16e92a1c150b..6e45ec0a66fa 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -43,6 +43,23 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 	return 0;
 }
 
+static int iommufd_hw_pagetable_link_ioas(struct iommufd_hw_pagetable *hwpt)
+{
+	int rc;
+
+	if (hwpt->parent)
+		hwpt = hwpt->parent;
+
+	if (!list_empty(&hwpt->hwpt_item))
+		return 0;
+
+	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
+	if (rc)
+		return rc;
+	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
+	return 0;
+}
+
 /**
  * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
  * @ictx: iommufd context
@@ -131,10 +148,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			goto out_unlock;
 	}
 
-	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
+	rc = iommufd_hw_pagetable_link_ioas(hwpt);
 	if (rc)
 		goto out_detach;
-	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
 
 	mutex_unlock(&idev->igroup->lock);
 	return hwpt;
-- 
2.34.1

