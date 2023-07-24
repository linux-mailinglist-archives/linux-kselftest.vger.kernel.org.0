Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E3475F4B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjGXLOe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGXLOR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:14:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E209110DF;
        Mon, 24 Jul 2023 04:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197231; x=1721733231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tXRlj9btBIeoEUnM5jIM9VZ+Pcrfyh8ZFvgKt8H4Rkw=;
  b=isDVGT36hMWHHdknPRkQf17vyrPMGGmFBAGvBpoNzqvjBLDwh44vQFL+
   0RzpAuCW1E1rvrbPoqafJtb4dkqQSWX9UKZNTEBg03zx5FZfZXu4LqUkq
   acjMaOuawAB+q6d9gEYUVvFZmQc9zYl3mgZ9KR5dUweh8b3F7HmbLxTh0
   zcAxOVKINnGh9ymcHxBGjnGfstdyBAM49dWm31rBmIn5eKeZI05k4e1dr
   RWDJf7OwYbKB0yGYtMFKkd6tEBpyWQ1Zv4CZNN2Xwmq8Q2mhc7CSOXndk
   1q+dWcA6VqI7Coewd6BTINxNBgld2am25+7vUkNXMWwjFXrw1q8cpplTV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347015052"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347015052"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415586"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415586"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:48 -0700
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
Subject: [PATCH v4 10/12] iommu/vt-d: Add nested domain allocation
Date:   Mon, 24 Jul 2023 04:13:32 -0700
Message-Id: <20230724111335.107427-11-yi.l.liu@intel.com>
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

This adds the support for IOMMU_HWPT_TYPE_VTD_S1 type.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 20 ++++++++++++++++++++
 include/linux/iommu.h       |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3119a79ebc83..6977d320c440 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4084,6 +4084,25 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	return NULL;
 }
 
+static struct iommu_domain *
+intel_iommu_domain_alloc_user(struct device *dev,
+			      enum iommu_hwpt_type hwpt_type,
+			      struct iommu_domain *parent,
+			      const union iommu_domain_user_data *user_data)
+{
+	if (hwpt_type != IOMMU_HWPT_TYPE_DEFAULT &&
+	    hwpt_type != IOMMU_HWPT_TYPE_VTD_S1)
+		return ERR_PTR(-EINVAL);
+
+	if ((hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) == !!parent)
+		return ERR_PTR(-EINVAL);
+
+	if (parent)
+		return intel_nested_domain_alloc(parent, user_data);
+	else
+		return iommu_domain_alloc(dev->bus);
+}
+
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain != &si_domain->domain && domain != &blocking_domain)
@@ -4732,6 +4751,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 231920efab84..09b8e800b55e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -240,6 +240,7 @@ union iommu_domain_user_data {
 #ifdef CONFIG_IOMMUFD_TEST
 	__u64 test[2];
 #endif
+	struct iommu_hwpt_vtd_s1 vtd;
 };
 
 /**
-- 
2.34.1

