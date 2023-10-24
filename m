Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47F27D5634
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjJXP1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjJXP1E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:27:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA3726A8;
        Tue, 24 Oct 2023 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698161153; x=1729697153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bknCuaXgjYm3S8328FfTMjKxCUCRzktFyfoYpNNj9c=;
  b=GzCTkamULyCM+t/oVAfkKoE4HSzJi5VSWcaG9X7NJmfMJ4NVxC+cgaE0
   yVTZOhXbcrMyjtB0cEWZp+4t45GaD81DEt0Zuqxun++vkdyA96egzMgUA
   PuS6Y7vDgRAEzus/YjSCC372OAuaXWOp11L0AX0qWmk/lQgtpF5V1DrBh
   xr9V+mrQeQUazR5M64hBlZByAu3gltlwqWzfPZDnK9wTVHst/ptcSBfGk
   G5kgXk+FtHF3VJMaXQQV7pQtqoUCtsGAQJnMB7EQNHl+NvMteUz5LGkIl
   0/7yW853+hea17rEGnbXD2X+H2iHf5rH81rCg9SGQd5F40uzFD5tQlZjo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418212209"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418212209"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1005688928"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="1005688928"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2023 08:14:17 -0700
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
Subject: [PATCH v7 7/8] iommu/vt-d: Add nested domain allocation
Date:   Tue, 24 Oct 2023 08:14:11 -0700
Message-Id: <20231024151412.50046-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024151412.50046-1-yi.l.liu@intel.com>
References: <20231024151412.50046-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

This adds the support for IOMMU_HWPT_DATA_VTD_S1 type. And 'nested_parent'
is added to mark the nested parent domain to sanitize the input parent domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 67 +++++++++++++++++++++++++------------
 drivers/iommu/intel/iommu.h |  1 +
 2 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 292baa64188b..85366862fb5e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4077,46 +4077,69 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
 			      const struct iommu_user_data *user_data)
 {
-	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
 	bool dirty_tracking;
+	bool nested_parent;
 
 	if (flags &
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (parent || user_data)
-		return ERR_PTR(-EOPNOTSUPP);
-
 	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
-	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !nested_supported(iommu))
-		return ERR_PTR(-EOPNOTSUPP);
-
+	nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 	dirty_tracking = (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
-	if (dirty_tracking && !ssads_supported(iommu))
-		return ERR_PTR(-EOPNOTSUPP);
 
-	/*
-	 * domain_alloc_user op needs to fully initialize a domain
-	 * before return, so uses iommu_domain_alloc() here for
-	 * simple.
-	 */
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
-		domain = ERR_PTR(-ENOMEM);
+	if (!user_data) { /* Must be PAGING domain */
+		struct iommu_domain *domain;
 
-	if (!IS_ERR(domain) && dirty_tracking) {
-		if (to_dmar_domain(domain)->use_first_level) {
-			iommu_domain_free(domain);
+		if (nested_parent && !nested_supported(iommu))
 			return ERR_PTR(-EOPNOTSUPP);
+		if (dirty_tracking && !ssads_supported(iommu))
+			return ERR_PTR(-EOPNOTSUPP);
+		if (parent)
+			return ERR_PTR(-EINVAL);
+
+		/*
+		 * domain_alloc_user op needs to fully initialize a domain
+		 * before return, so uses iommu_domain_alloc() here for
+		 * simple.
+		 */
+		domain = iommu_domain_alloc(dev->bus);
+		if (!domain)
+			return ERR_PTR(-ENOMEM);
+
+		if (nested_parent)
+			to_dmar_domain(domain)->nested_parent = true;
+
+		if (dirty_tracking) {
+			if (to_dmar_domain(domain)->use_first_level) {
+				iommu_domain_free(domain);
+				return ERR_PTR(-EOPNOTSUPP);
+			}
+			domain->dirty_ops = &intel_dirty_ops;
 		}
-		domain->dirty_ops = &intel_dirty_ops;
+
+		return domain;
 	}
 
-	return domain;
+	/* Must be nested domain */
+	if (user_data->type != IOMMU_HWPT_DATA_VTD_S1)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!nested_supported(iommu))
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!parent || parent->ops != intel_iommu_ops.default_domain_ops)
+		return ERR_PTR(-EINVAL);
+	if (!to_dmar_domain(parent)->nested_parent)
+		return ERR_PTR(-EINVAL);
+	if (nested_parent)
+		return ERR_PTR(-EINVAL);
+	if (dirty_tracking)
+		return ERR_PTR(-EINVAL);
+
+	return intel_nested_domain_alloc(parent, user_data);
 }
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d5aaaedf2094..65e660eb1f47 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -601,6 +601,7 @@ struct dmar_domain {
 					 * level.
 					 */
 	u8 dirty_tracking:1;		/* Dirty tracking is enabled */
+	u8 nested_parent:1;		/* Has other domains nested on it */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
-- 
2.34.1

