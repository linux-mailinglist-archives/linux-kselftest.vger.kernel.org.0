Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAC07A9FCC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjIUU2G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 16:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjIUU1b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 16:27:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A412A5102B;
        Thu, 21 Sep 2023 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318592; x=1726854592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QCYSdfSXFxQ7WaALFaYm4jsUT2kSUGMBFqo7HP5RmjU=;
  b=Bqe5phMeghF+N5rNuPdtcmuSre15gxLq1eYXVP8k6t2D1hg2VGw+C/Od
   FIfujusl9xw7Fl/UTsnENWakjPGaVN+UePGAdtzaP3Vl36E3THsuQ9O1v
   r+/EadOqnwIDI6VF8SFW/xE8DQJs9UxkgCPpYo5wS/j81LjbiJMjsQsV3
   ZW5qVT4TPWLF4uleaG81PnZnBfUWgb6I1QXIgRr0vWLsDJPaP3vUcT8qu
   8onPbopz0fK9FmEpQNArzrks3UzInlnV3CHKh7sT/TaBEqIGQqlXvPw3q
   XkxT5wDo63Uqdjyw7m9rSPCqWCdoygy9aBglkK+RqMyWIpUIyZ+NYDI+i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832885"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832885"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649546"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649546"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:13 -0700
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
Subject: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on kernel-managed domains
Date:   Thu, 21 Sep 2023 00:51:29 -0700
Message-Id: <20230921075138.124099-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Now enforce_cache_coherency and msi_cookie are kernel-managed hwpt things.
So, they should be only setup on kernel-managed domains. If the attaching
domain is a user-managed domain, redirect the hwpt to hwpt->parent to do
it correctly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c       | 4 ++++
 drivers/iommu/iommufd/hw_pagetable.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index eb120f70a3e3..104dd061a2a3 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -305,12 +305,16 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	 * domain after request_irq(). If it is not done interrupts will not
 	 * work on this domain.
 	 *
+	 * Note: always set up a msi_cookie on a kernel-manage hw_pagetable.
+	 *
 	 * FIXME: This is conceptually broken for iommufd since we want to allow
 	 * userspace to change the domains, eg switch from an identity IOAS to a
 	 * DMA IOAS. There is currently no way to create a MSI window that
 	 * matches what the IRQ layer actually expects in a newly created
 	 * domain.
 	 */
+	if (hwpt->user_managed)
+		hwpt = hwpt->parent;
 	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt->msi_cookie) {
 		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
 		if (rc)
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index dc3e11a23acf..90fd65859e28 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -152,6 +152,10 @@ iommufd_user_managed_hwpt_alloc(struct iommufd_ctx *ictx,
 
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 {
+	/* Always enforce cache coherency on a kernel-managed hw_pagetable */
+	if (hwpt->user_managed)
+		hwpt = hwpt->parent;
+
 	if (hwpt->enforce_cache_coherency)
 		return 0;
 
-- 
2.34.1

