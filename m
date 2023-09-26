Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818067AE90B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 11:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjIZJ1F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjIZJ1E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 05:27:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E51B2;
        Tue, 26 Sep 2023 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720416; x=1727256416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QCsRGQDqeqnft3ND0MqwCNuelDppwZbyFgsmSGIdNm0=;
  b=AXgnmlPrYOT2Y5p2f9THZDw3LLjyTh0VUvWDj9FKMU4GRBbf55qVjnEE
   XmhY2VAkZXDtsmAITTyMKqqN2Zpl1Glje/jsYvUnw74oFc7QffAKRlkx+
   ux3KdE8TXqpiyyTItuqu5z2kNeL/oasb7g8uwzmIBkyiY8YaKDrbNa+Kg
   9DaRrpGG871d+4gFx2OF1v2PHk8LuoCyC6IEgGny6NsEvZr+cmNh2KCgr
   UgtTOx8knFI4WSaUeJHK/Q1/3irLEHOn9gEijazVYtqiD7q+toLcA3Izn
   j6CsIRMIjTFpv9aU83w/Ixe/J/APB2maCObuy9BgbIu7mb/3Q/HR9cIEA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360905351"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360905351"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:26:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079642532"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="1079642532"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2023 02:26:55 -0700
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
Subject: [RFC 2/8] iommufd: replace attach_fn with a structure
Date:   Tue, 26 Sep 2023 02:26:45 -0700
Message-Id: <20230926092651.17041-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926092651.17041-1-yi.l.liu@intel.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
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

Most of the core logic before conducting the actual device attach/
replace operation can be shared with pasid attach/replace. Create
a new structure so more information (e.g. pasid) can be later added
along with the attach_fn.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 35 ++++++++++++++++---------
 drivers/iommu/iommufd/iommufd_private.h |  8 ++++++
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 645ab5d290fe..4fa4153c5df7 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -597,8 +597,11 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	return ERR_PTR(rc);
 }
 
-typedef struct iommufd_hw_pagetable *(*attach_fn)(
-	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
+static struct iommufd_hw_pagetable *do_attach(struct iommufd_device *idev,
+		struct iommufd_hw_pagetable *hwpt, struct attach_data *data)
+{
+	return data->attach_fn(idev, hwpt);
+}
 
 /*
  * When automatically managing the domains we search for a compatible domain in
@@ -608,7 +611,7 @@ typedef struct iommufd_hw_pagetable *(*attach_fn)(
 static struct iommufd_hw_pagetable *
 iommufd_device_auto_get_domain(struct iommufd_device *idev,
 			       struct iommufd_ioas *ioas, u32 *pt_id,
-			       attach_fn do_attach)
+			       struct attach_data *data)
 {
 	/*
 	 * iommufd_hw_pagetable_attach() is called by
@@ -617,7 +620,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	 * to use the immediate_attach path as it supports drivers that can't
 	 * directly allocate a domain.
 	 */
-	bool immediate_attach = do_attach == iommufd_device_do_attach;
+	bool immediate_attach = data->attach_fn == iommufd_device_do_attach;
 	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_hw_pagetable *hwpt;
 
@@ -633,7 +636,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = do_attach(idev, hwpt, data);
 		if (IS_ERR(destroy_hwpt)) {
 			iommufd_put_object(&hwpt->obj);
 			/*
@@ -660,7 +663,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	}
 
 	if (!immediate_attach) {
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = do_attach(idev, hwpt, data);
 		if (IS_ERR(destroy_hwpt))
 			goto out_abort;
 	} else {
@@ -681,8 +684,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	return destroy_hwpt;
 }
 
-static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
-				    attach_fn do_attach)
+int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
+			     struct attach_data *data)
 {
 	struct iommufd_hw_pagetable *destroy_hwpt;
 	struct iommufd_object *pt_obj;
@@ -696,7 +699,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
-		destroy_hwpt = (*do_attach)(idev, hwpt);
+		destroy_hwpt = do_attach(idev, hwpt, data);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -706,7 +709,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
 		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
-							      do_attach);
+							      data);
 		if (IS_ERR(destroy_hwpt))
 			goto out_put_pt_obj;
 		break;
@@ -742,8 +745,11 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 {
 	int rc;
+	struct attach_data data = {
+		.attach_fn = &iommufd_device_do_attach,
+	};
 
-	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
+	rc = iommufd_device_change_pt(idev, pt_id, &data);
 	if (rc)
 		return rc;
 
@@ -773,8 +779,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
  */
 int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
 {
-	return iommufd_device_change_pt(idev, pt_id,
-					&iommufd_device_do_replace);
+	struct attach_data data = {
+		.attach_fn = &iommufd_device_do_replace,
+	};
+
+	return iommufd_device_change_pt(idev, pt_id, &data);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1bd412cff2d6..f1fe4120c3b1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -353,6 +353,14 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 int iommufd_set_dev_data(struct iommufd_ucmd *ucmd);
 int iommufd_unset_dev_data(struct iommufd_ucmd *ucmd);
 
+struct attach_data {
+	union {
+		struct iommufd_hw_pagetable *(*attach_fn)(
+				struct iommufd_device *idev,
+				struct iommufd_hw_pagetable *hwpt);
+	};
+};
+
 struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
-- 
2.34.1

