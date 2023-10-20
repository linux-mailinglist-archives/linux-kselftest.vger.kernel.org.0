Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24817D0BD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376649AbjJTJdJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376708AbjJTJc7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:32:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868BED55;
        Fri, 20 Oct 2023 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794374; x=1729330374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ib1IMmuWc4reT62H1wiulcc7gMI+m46FXf0FSrS+Cos=;
  b=Dc4z6UaXI8oaeVQBnI/cSI7NbEZyXoCRmb4FZr0+qrUQxq1eyljZIhsO
   gVj21uhxqNQHmj03dKAl50BWq8m5HpuEcJKGDdKAheN02vxHofCft1so5
   B2+6KU4pv+Cnyd6sVj2Gs44WHNgaJz/+Cwj1Z8HA1Qlc4VEgd/HFalCcJ
   Ly18nTgKG9kWesvDURfQdaDcM8ECtOmOduC5qEvBw7Z97+a/JAAWz6XA2
   sM0GGVlOBPSfP0jc9HNKEgaHVp4dtSioLfQm5jVoUl+05hDuXNjpPJCl4
   5T2zb3nKbpNPlPykERMhxmPHrkW8BaW3cnNYCo9SAVxhQuiUplsV4ynw/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450691725"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450691725"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="733906305"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="733906305"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2023 02:32:53 -0700
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
Subject: [PATCH v6 5/8] iommu/vt-d: Make domain attach helpers to be extern
Date:   Fri, 20 Oct 2023 02:32:43 -0700
Message-Id: <20231020093246.17015-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020093246.17015-1-yi.l.liu@intel.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
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

This makes the helpers visible to nested.c.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++---------
 drivers/iommu/intel/iommu.h |  7 +++++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8d78149e793e..b47025fbdea4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -282,7 +282,6 @@ static LIST_HEAD(dmar_satc_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
-static void device_block_translation(struct device *dev);
 static void intel_iommu_domain_free(struct iommu_domain *domain);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
@@ -560,7 +559,7 @@ static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 }
 
 /* Some capabilities may be different across iommus */
-static void domain_update_iommu_cap(struct dmar_domain *domain)
+void domain_update_iommu_cap(struct dmar_domain *domain)
 {
 	domain_update_iommu_coherency(domain);
 	domain->iommu_superpage = domain_update_iommu_superpage(domain, NULL);
@@ -1778,8 +1777,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	return domain;
 }
 
-static int domain_attach_iommu(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info, *curr;
 	unsigned long ndomains;
@@ -1828,8 +1826,7 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	return ret;
 }
 
-static void domain_detach_iommu(struct dmar_domain *domain,
-				struct intel_iommu *iommu)
+void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info;
 
@@ -3974,7 +3971,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
  * all DMA requests without PASID from the device are blocked. If the page
  * table has been set, clean up the data structures.
  */
-static void device_block_translation(struct device *dev)
+void device_block_translation(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4109,8 +4106,8 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 		domain_exit(to_dmar_domain(domain));
 }
 
-static int prepare_domain_attach_device(struct iommu_domain *domain,
-					struct device *dev)
+int prepare_domain_attach_device(struct iommu_domain *domain,
+				 struct device *dev)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ff55184456dd..b4560983b8b9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -860,6 +860,13 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
  */
 #define QI_OPT_WAIT_DRAIN		BIT(0)
 
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
+void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
+void device_block_translation(struct device *dev);
+int prepare_domain_attach_device(struct iommu_domain *domain,
+				 struct device *dev);
+void domain_update_iommu_cap(struct dmar_domain *domain);
+
 int dmar_ir_support(void);
 
 void *alloc_pgtable_page(int node, gfp_t gfp);
-- 
2.34.1

