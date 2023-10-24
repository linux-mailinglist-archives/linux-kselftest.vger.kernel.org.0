Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2A67D563A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjJXP1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjJXP1D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:27:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E34F2699;
        Tue, 24 Oct 2023 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698161151; x=1729697151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yaXPXgiHPft1t+FfYx+gcc9MnjEET03QhJxsh9MS9DU=;
  b=TfNxncsiPQGawNwwvRp6vU0YMdU2d0et4x7RhQnWuY/6YnI00BF0JgS+
   TMS36MLXIwYqKD3BZmMnGMFatZzjSTM7x1xHV8qV0VoTNVHZKWFTJMvf8
   chun5fBr79PN1KvbL3o8CkCZZ5gj3O5qlH3gfDQrAsgKWJJE7KlyRwTeV
   w9VELrZcJ1s3c5mFWMkRAmdgyDehFaJ6L8LRjttaQAZguc8fNYG41UoE4
   oRVZ28iogysKFUjVXgJ5dTJy15ZiRbgGa2V1mX4O9xexALstUWtCbKHog
   0GKNB1g3WEIDdxX8X0jjYO99TiP/2VYdXAk6kIV33T6+rlWXaHHBkWPbZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418212168"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418212168"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1005688921"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="1005688921"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2023 08:14:16 -0700
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
Subject: [PATCH v7 5/8] iommu/vt-d: Make domain attach helpers to be extern
Date:   Tue, 24 Oct 2023 08:14:09 -0700
Message-Id: <20231024151412.50046-6-yi.l.liu@intel.com>
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

This makes the helpers visible to nested.c.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++---------
 drivers/iommu/intel/iommu.h |  7 +++++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cb64759b3d95..292baa64188b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -282,7 +282,6 @@ static LIST_HEAD(dmar_satc_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
-static void device_block_translation(struct device *dev);
 static void intel_iommu_domain_free(struct iommu_domain *domain);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
@@ -561,7 +560,7 @@ static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 }
 
 /* Some capabilities may be different across iommus */
-static void domain_update_iommu_cap(struct dmar_domain *domain)
+void domain_update_iommu_cap(struct dmar_domain *domain)
 {
 	domain_update_iommu_coherency(domain);
 	domain->iommu_superpage = domain_update_iommu_superpage(domain, NULL);
@@ -1779,8 +1778,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	return domain;
 }
 
-static int domain_attach_iommu(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info, *curr;
 	unsigned long ndomains;
@@ -1829,8 +1827,7 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 	return ret;
 }
 
-static void domain_detach_iommu(struct dmar_domain *domain,
-				struct intel_iommu *iommu)
+void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 {
 	struct iommu_domain_info *info;
 
@@ -3975,7 +3972,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
  * all DMA requests without PASID from the device are blocked. If the page
  * table has been set, clean up the data structures.
  */
-static void device_block_translation(struct device *dev)
+void device_block_translation(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
@@ -4128,8 +4125,8 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
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
index 43108424f315..d5aaaedf2094 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -878,6 +878,13 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
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

