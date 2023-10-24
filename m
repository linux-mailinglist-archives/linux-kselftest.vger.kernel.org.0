Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4B7D5490
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbjJXPAR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjJXPAR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:00:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2946C111;
        Tue, 24 Oct 2023 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698159615; x=1729695615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lnL4CP2uD9rbT1rIxMvDwFK1eRPFnr1/Kd5xalHC4fQ=;
  b=a4TmtTewz6BsDibsksUVO5AJC7RlodfAAUAGWTA59KljmkdY1bGklV55
   8+iY0SzkFBl+FXdlrzJkg8QGGAWFhgk9XTJ9WNJ9HajB7KneD+YE0N8tv
   +l6tfxjWYwGLi6DRbKOOaayYvpbr+jHM5R9+9ByofITwdtORWDsSCdF3a
   J/MXqC/AVEbDLDQUviIyEZLIokyorhGSdkEjKzp1BjpQDdszstlYHq8AQ
   c6IWuEUD5VbeYbztPjrgKj605x++v6udYXSbGAWWthU7TV78j21sUQCDE
   8Z7L2rAlwJJayOZszfveMwVDKqwiP8QcWmF5EtdSMtlVkiOan6ZNYZh1A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="366416746"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="366416746"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="932067639"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="932067639"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2023 08:00:12 -0700
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
Subject: [PATCH] iommu/vt-d: Enhance capability check for nested parent domain allocation
Date:   Tue, 24 Oct 2023 08:00:11 -0700
Message-Id: <20231024150011.44642-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the scalable mode check before allocating the nested parent domain
as checking nested capability is not enough. User may turn off scalable mode
which also means no nested support even if the hardware supports it.

Fixes: c97d1b20d383 ("iommu/vt-d: Add domain_alloc_user op")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v1: Based on Joao's dirty page tracking v6 https://github.com/jpemartins/linux/commits/iommufd-v6
---
 drivers/iommu/intel/iommu.c | 2 +-
 drivers/iommu/intel/iommu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index eb92a201cc0b..65f46f1347e6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4090,7 +4090,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
-	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
+	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	dirty_tracking = (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3bb569146229..cc7301579773 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -544,6 +544,8 @@ enum {
 				 ecap_pasid((iommu)->ecap))
 #define ssads_supported(iommu) (sm_supported(iommu) &&                 \
 				ecap_slads((iommu)->ecap))
+#define nested_supported(iommu)	(sm_supported(iommu) &&			\
+				 ecap_nest((iommu)->ecap))
 
 struct pasid_entry;
 struct pasid_state_entry;
-- 
2.34.1

