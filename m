Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4AE68E2CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBGVUk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjBGVUh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:37 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F833B3F3;
        Tue,  7 Feb 2023 13:20:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ25lUF8evB/R5r6PR6G8PupEoPD79Xl/RFlxXa12YM+RwCcnfA61ZW1DGpmMCFmCYQkJXGK71gTCzLAeIaCXlSP5Wt7A97FLkDtVnxiOv1z3QypIVoatVfD2XOsPp7EHyf1dB3Py7f7ozwrCvpe2/aUtFDdA9fvxgwf6CTO/lnG6tMMgVTEWJ6/0D+ZIVYbAXaKjxKUY4oW4TY/d6cUii/gzzEVAqBmB8MUf0Rhbj/AaBe5U16JLnLneos9jjbjiwgRjj9VL5o+xF8CQMDfj6im8xr6HHmJOT/W2yuh/xATzigFgtML9hqbh5svHsNmtuxOIKv3cAgy3sLwg2zZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E0XL2i9iDoC3O3UWprErehOeHhirmrW+bX0N2PllXc=;
 b=bRgo5MArW2uaXreZPGTj1mq1uGR3BIugHP3XB8rmhA/zZeVR1YmcsaUCRkMIs4c3uUFfyo/MbNuYJpKaGFSiWjqpxnPNplUT0Edzhfjqcw4P6It2G8axC08vwBKB/u9S3aqYnF80vZlJC7APigcTYTigsT/a3LqMPQD/Zpo9jyfTVdPlJcC09qE/NUfib6lQFnpVbmr4N5ibIZUHZylo3q1s6pQnps2eVYkveW7u9UEIinfvZ3VWIHIRLyhmwOHtqrTTqd2ug2kF0tFhIRANufrFfiVFll862y1rLrncm9e22wEUczlJZhOmA8pMxRET5eBQIK4i07OXvhuEzCwgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E0XL2i9iDoC3O3UWprErehOeHhirmrW+bX0N2PllXc=;
 b=dYJARupSSczwac8V+zquRpiJQeD8dSd73TbmC1JEwEa4tECHiXVzUYyEUG7vAv62AnY8vztAkJa3+Eq7O7DMO3fK0niqopXL13DOyDGLh5MzvZshymqoNZNlfULpn8+BZTIJaA1TRRT71iFHUK7FO17JH6TesOpN9P/koQGXTxUC2bNMBqijeyXaGhrSKEjGN79L4WG5BlY8UaOJxulPRvIoEkAMX1orObTrnSv3oupnep7wLvsQHviV+HbukWszAfg6+dj7te2lGuSCjrhAXxMEGOlAX7g9Uhf2rjj2Ee5UErtrHriqx5Hj8ywrJN1jT7AO6V+Mdrgdq/Z1mio5ZA==
Received: from BN1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:408:e2::11)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 21:20:34 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::c9) by BN1PR13CA0006.outlook.office365.com
 (2603:10b6:408:e2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.16 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 21:20:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:26 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:25 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:25 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 07/10] iommufd/device: Make hwpt_list list_add/del symmetric
Date:   Tue, 7 Feb 2023 13:17:59 -0800
Message-ID: <9d0d4f935c4972771f5aed4b4837d8ae35814e06.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 924b2dc4-e5e6-4ed4-62b1-08db0951261d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXifNj9JF2u8btnjwLhLkc/yJiQagoIuyzc60iUJ3OfQN79XbD4YRVnSK4AIbg+u+qttP4gCDyqy8rKQBgnTMTJPnkD+SoYHLftv2NA40S47aZv2H95lt58wuUzWnT2zHm1Lg3rYTdEukSGOPAXRTtZ740GP5Xuy/f9vOcA/l+A6wfWRKFJAwWiQddHhMbmVNdcrDPkYBUWF8Gq8oCfCwueHxxUxj+v8h/a0Ff/sM1fHLIIZdYHkKv2hCjqtCvS3XVvnLK3XWrH3Fb6aVQrnGPMOehr5wg5fIAeyaGkebztlvT/WFV1BAmDcmAiwEffNXuIMhRW5mvYIEDGiuHBwD/uYJgZuwpOdtD5cVcG6pEXvZPdjSGXJZPqSH/o+UGC/jHNV9gXNjPwfanFmvj6wtCmRcM3Iwqz2dp1Uim7KNq1sKMbMisIUA5Bkt+5ZxHqExIeXKfxH6bZudX6S3J8ji01WwRzy3igo6nHalwFPGgToyaeigrkcHSkPGHMxgpkrAhzQGOU8/XPdrbXu2kzwKTag0nQAwWfrrZ18V/8HT5+0Sadzxj/rHoqeajKohp0ZxEFG0Qi+7ga9E0LCI9WvFRM8bGaJcgq/CrmffDpy15RpRbgwxkhliDlxx4JjtoJrMqJrJhTOhQaFvIqa9Bh4Qqjn9qLWoC+Z2NiJeR32tdhMPOXX2Xfja49IxHh+olvnMmB8tYiJZkWvyJ+PydDoZQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(86362001)(8936002)(7696005)(2906002)(478600001)(41300700001)(54906003)(356005)(110136005)(6666004)(82310400005)(316002)(70206006)(40480700001)(36860700001)(2616005)(70586007)(426003)(83380400001)(47076005)(186003)(36756003)(7416002)(336012)(40460700003)(4326008)(26005)(5660300002)(7636003)(8676002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:33.7330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924b2dc4-e5e6-4ed4-62b1-08db0951261d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Because list_del() is together with iopt_table_remove_domain(), it makes
sense to have list_add_tail() together with iopt_table_add_domain().

Also place the mutex outside the iommufd_device_do_attach() call, similar
to what's in the iommufd_device_auto_get_domain() function.

Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 10ce47484ffa..b8c3e3baccb5 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -200,6 +200,8 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
+	lockdep_assert_held(&hwpt->ioas->mutex);
+
 	mutex_lock(&hwpt->devices_lock);
 
 	/*
@@ -243,6 +245,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 						   hwpt->domain);
 			if (rc)
 				goto out_detach;
+			list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
 		}
 	}
 
@@ -304,7 +307,6 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	rc = iommufd_device_do_attach(idev, hwpt);
 	if (rc)
 		goto out_abort;
-	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
@@ -343,13 +345,11 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
+		mutex_lock(&hwpt->ioas->mutex);
 		rc = iommufd_device_do_attach(idev, hwpt);
+		mutex_unlock(&hwpt->ioas->mutex);
 		if (rc)
 			goto out_put_pt_obj;
-
-		mutex_lock(&hwpt->ioas->mutex);
-		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
-		mutex_unlock(&hwpt->ioas->mutex);
 		break;
 	}
 	case IOMMUFD_OBJ_IOAS: {
-- 
2.39.1

