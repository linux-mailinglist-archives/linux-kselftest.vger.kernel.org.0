Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8869B6FF522
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbjEKOxJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbjEKOwa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:52:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0B91163B;
        Thu, 11 May 2023 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683816717; x=1715352717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vbt/gRKp77bRwjDyaiyibCBpUzoPaDniGF7JiqNVd8w=;
  b=gyhkbiidSgrhdaPfM1/1RuiYv9+GLsmw5Lu4AZm+Fs21jn14bJCQPJsZ
   +c5UQnTtf9ahx9ILdMqS10D8RvtUkiSbbBO1PvrXdUfeZe7HfnrxCBbtP
   bMt7Zqo3z5OMsdZUbl5uVisBgpj1QnzRuITHMEUCSPoot78r9JKr86haM
   jVp3kytm81XnyHiNUmIJYD6KVSUU7V5wdw/LbkinLrUd13IWQJOuZTv4Q
   3g5eINzqHu0PQc+CEa9kzI4/8ZTgqR/l26wFiol9RVm99Kc97hqxhDmDZ
   L9ILbaBlVLZvwiQlHot1TwuhJZenkomUM7Q41GhH+r0zlrEZ1JW1qvS9B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335025505"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="335025505"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769355189"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769355189"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 07:51:19 -0700
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
Subject: [PATCH v3 08/10] iommu/vt-d: Add nested domain allocation
Date:   Thu, 11 May 2023 07:51:08 -0700
Message-Id: <20230511145110.27707-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511145110.27707-1-yi.l.liu@intel.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

This adds the support for IOMMU_HWPT_TYPE_VTD_S1 type.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 19 +++++++++++++++++++
 include/linux/iommu.h       |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5f27cee4656a..51612da4a1ea 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4092,6 +4092,16 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	return NULL;
 }
 
+static struct iommu_domain *
+intel_iommu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
+			      const union iommu_domain_user_data *user_data)
+{
+	if (parent)
+		return intel_nested_domain_alloc(parent, user_data);
+	else
+		return iommu_domain_alloc(dev->bus);
+}
+
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain != &si_domain->domain && domain != &blocking_domain)
@@ -4736,9 +4746,18 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 }
 
+static int intel_iommu_domain_user_data_len(u32 hwpt_type)
+{
+	if (hwpt_type != IOMMU_HWPT_TYPE_VTD_S1)
+		return -EOPNOTSUPP;
+	return sizeof(struct iommu_hwpt_intel_vtd);
+};
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_alloc_user	= intel_iommu_domain_alloc_user,
+	.domain_alloc_user_data_len = intel_iommu_domain_user_data_len,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c696d8e7f43b..32324f0756de 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -234,6 +234,7 @@ union iommu_domain_user_data {
 #ifdef CONFIG_IOMMUFD_TEST
 	__u64 test[2];
 #endif
+	struct iommu_hwpt_intel_vtd vtd;
 };
 
 /**
-- 
2.34.1

