Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39C07BD5B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbjJIIvm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbjJIIvg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:51:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F235410F;
        Mon,  9 Oct 2023 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696841495; x=1728377495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5oSl+8ABY4vMSX9OU2YlTePC4xhTypHD8FVbeS8l5Dc=;
  b=X06F2lsQCmdC4Ka44hq+k5KesMR3Q+SUElVwwZRwKpivOAa121mKChHK
   qHSByYnis09eXYObQRt5s/2+RmU71ed/7SQWqGFwxCSOzNs3aKqx373tv
   QZPk2TSkQ19ChGQb9ASCh/5PspfMAQH3VQxLWH7e/IVYUBNy0UvH5hwi+
   4XDulU3/JeENyI7CxLOCoJPyYgsJp9a90wVKFNJrdv1Vns5q3jaAWpCV5
   5DiSpqnm65gPIK6aJMf00ggiHPyLUWXS6ILm50V+KuaYHwJRUXdwx9gso
   TSGYqsQQidwF8vRD8q1O9u5wiZH96ro4oRAs6Yn7l/vsGPBYytGf9cwyo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364390811"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="364390811"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818781686"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818781686"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2023 01:51:33 -0700
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
Subject: [RFC 4/7] iommufd: Support attach/replace for SIOV virtual device {dev, pasid}
Date:   Mon,  9 Oct 2023 01:51:20 -0700
Message-Id: <20231009085123.463179-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009085123.463179-1-yi.l.liu@intel.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kevin Tian <kevin.tian@intel.com>

SIOV devices allows driver to tag different PASIDs for the virtual devices
within it. Such driver should call iommufd_device_bind_pasid() to connect
the pasid of the device to iommufd, and then driver is able to attach the
virtual device to IOAS/HWPT with the iommufd_device_attach() API.

Unlike physical devices, for SIOV virtual devices, iommufd_device_attach()
eventually uses the idev->default_pasid when the virtual device is attached
to an IOAS/HWPT. Also, there is no need to do immediate_attach per iommu
domain allocation in the attach/replace path if any iommu domain allocation
happens since the attach/replace is eventually pasid attach/replace.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 35c1419ee96b..4882e3106b2e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -841,7 +841,11 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		.pasid = IOMMU_PASID_INVALID
 	};
 
-	rc = iommufd_device_change_pt(idev, pt_id, &data);
+	if (idev->igroup)
+		rc = iommufd_device_change_pt(idev, pt_id, &data);
+	else
+		/* SIOV device follows generic pasid attach flow */
+		rc = iommufd_device_pasid_attach(idev, idev->default_pasid, pt_id);
 	if (rc)
 		return rc;
 
@@ -876,7 +880,12 @@ int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 		.pasid = IOMMU_PASID_INVALID
 	};
 
-	return iommufd_device_change_pt(idev, pt_id, &data);
+	if (idev->igroup) {
+		return iommufd_device_change_pt(idev, pt_id, &data);
+	} else {
+		/* SIOV device follows generic pasid replace flow */
+		return iommufd_device_pasid_replace(idev, idev->default_pasid, pt_id);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);
 
@@ -891,8 +900,12 @@ void iommufd_device_detach(struct iommufd_device *idev)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
-	hwpt = iommufd_hw_pagetable_detach(idev);
-	iommufd_hw_pagetable_put(idev->ictx, hwpt);
+	if (idev->igroup) {
+		hwpt = iommufd_hw_pagetable_detach(idev);
+		iommufd_hw_pagetable_put(idev->ictx, hwpt);
+	} else {
+		iommufd_device_pasid_detach(idev, idev->default_pasid);
+	}
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
-- 
2.34.1

