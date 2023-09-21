Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7937AA102
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 22:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjIUU4h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjIUUtM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 16:49:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA2D4CB00;
        Thu, 21 Sep 2023 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318588; x=1726854588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZEXWeTeOBrejODuS6erDuW9xhi+ilN63E3t7GSB+Dc=;
  b=mYLObWUcd9WTK/8as8BLRXq34hkELQ+jqRWpxcYabdwgQj1hmo3YyPjU
   K6XUxEbrRgGBFkE1odl1b4Yk0/Wdyd1QWoT0Qop9VQQ/qHEQAJXaL5mph
   E2xcdYJi5zLclO7jDAskar481WVdWzYHT2AuoI3OhwCRdL2DLNaR9fq6K
   pG0rjNNOfMGhA0yAthttcVSto8Fc3oKCRajdWVOnDmIEHv9klpnTW+PSr
   LdxGsuuJnxrKP1AL9XlL4hDVseR70QrauEMQyAa7R0Rp+B5/BTsENVMME
   kRqUjQ/ESVtEeDzghup16Tvvx2LufPHsE+dd1A4aIJ0tba/KcqBIhcTY3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832824"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832824"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649502"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649502"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:09 -0700
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
Subject: [PATCH v4 03/17] iommufd: Unite all kernel-managed members into a struct
Date:   Thu, 21 Sep 2023 00:51:24 -0700
Message-Id: <20230921075138.124099-4-yi.l.liu@intel.com>
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

The struct iommufd_hw_pagetable has been representing a kernel-managed
HWPT, yet soon will be reused to represent a user-managed HWPT. These
two types of HWPTs has the same IOMMUFD object type and an iommu_domain
object, but have quite different attributes/members.

Add a union in struct iommufd_hw_pagetable and group all the existing
kernel-managed members. One of the following patches will add another
struct for user-managed members.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 3064997a0181..947a797536e3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -231,13 +231,18 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
  */
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
-	struct iommufd_ioas *ioas;
 	struct iommu_domain *domain;
-	bool auto_domain : 1;
-	bool enforce_cache_coherency : 1;
-	bool msi_cookie : 1;
-	/* Head at iommufd_ioas::hwpt_list */
-	struct list_head hwpt_item;
+
+	union {
+		struct { /* kernel-managed */
+			struct iommufd_ioas *ioas;
+			bool auto_domain : 1;
+			bool enforce_cache_coherency : 1;
+			bool msi_cookie : 1;
+			/* Head at iommufd_ioas::hwpt_list */
+			struct list_head hwpt_item;
+		};
+	};
 };
 
 struct iommufd_hw_pagetable *
-- 
2.34.1

