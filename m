Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1397475F4B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjGXLOT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjGXLOB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:14:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88281B3;
        Mon, 24 Jul 2023 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197228; x=1721733228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kFFC2bK/nCwVQZLA9Z70O9G3InA/Pl+u4zLi4egWg38=;
  b=nMdUS50/mijbGr/M+mI6LtAQww3p0rFKJzYCzE+Gvs3SFtI9neUjoST5
   +125JXZTS9iSiO+dvhOpkWEUSjrbaIK8SZqnMKEk+2Bwml21gdUIwd9eE
   hwXHOQLk+VjfEtHpOpefCQ1nPgsIr6fIQo8RcLPeF2kTmqz40800NGBOT
   zxKKxYkkW+WXBD2HkyLFAc+//kwzcxf3JDIUHbNq0L+nbe8J0SXfpeJAh
   +OuxfUVKjuaDxzSy8cpP/Mu7RWnFodSIh6fAHSfZLtxxEHNASDgP0akPy
   8dRCISJRnUJ2GPXkCxBDLOu6DyhZnqyCUjsW2dKjriCsFxemWUtLM3xrC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347015038"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347015038"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415576"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415576"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:47 -0700
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
Subject: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Date:   Mon, 24 Jul 2023 04:13:31 -0700
Message-Id: <20230724111335.107427-10-yi.l.liu@intel.com>
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

This implements the .cache_invalidate_user() callback and sets the
.cache_invalidate_user_data_len to support iotlb flush for nested domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/nested.c | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 98164894f22f..2739c0d7880d 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -69,8 +69,71 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	kfree(to_dmar_domain(domain));
 }
 
+static void intel_nested_invalidate(struct device *dev,
+				    struct dmar_domain *domain,
+				    u64 addr, unsigned long npages)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	if (addr == 0 && npages == -1)
+		intel_flush_iotlb_all(&domain->domain);
+	else
+		iommu_flush_iotlb_psi(iommu, domain,
+				      addr >> VTD_PAGE_SHIFT,
+				      npages, 1, 0);
+}
+
+static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
+					      void *user_data)
+{
+	struct iommu_hwpt_vtd_s1_invalidate_desc *req = user_data;
+	struct iommu_hwpt_vtd_s1_invalidate *inv_info = user_data;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned int entry_size = inv_info->entry_size;
+	u64 uptr = inv_info->inv_data_uptr;
+	u64 nr_uptr = inv_info->entry_nr_uptr;
+	struct device_domain_info *info;
+	u32 entry_nr, index;
+	unsigned long flags;
+	int ret = 0;
+
+	if (get_user(entry_nr, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
+		return -EFAULT;
+
+	for (index = 0; index < entry_nr; index++) {
+		ret = copy_struct_from_user(req, sizeof(*req),
+					    u64_to_user_ptr(uptr + index * entry_size),
+					    entry_size);
+		if (ret) {
+			pr_err_ratelimited("Failed to fetch invalidation request\n");
+			break;
+		}
+
+		if (req->__reserved || (req->flags & ~IOMMU_VTD_QI_FLAGS_LEAF) ||
+		    !IS_ALIGNED(req->addr, VTD_PAGE_SIZE)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		spin_lock_irqsave(&dmar_domain->lock, flags);
+		list_for_each_entry(info, &dmar_domain->devices, link)
+			intel_nested_invalidate(info->dev, dmar_domain,
+						req->addr, req->npages);
+		spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	}
+
+	if (put_user(index, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
+		return -EFAULT;
+
+	return ret;
+}
+
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
+	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
+	.cache_invalidate_user_data_len =
+		sizeof(struct iommu_hwpt_vtd_s1_invalidate),
 	.free			= intel_nested_domain_free,
 	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
 };
-- 
2.34.1

