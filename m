Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0B702F0B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbjEOOAv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239050AbjEOOAs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA081BC1;
        Mon, 15 May 2023 07:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fi2tJz1US08Ba+gHR6tnsf88NHQqYorTn9tF9WMvmW+bj00hdqG/+PBnB9Jw+GanJYlgFqbCaeLBS2IrmVUO2PKpghIPOa5Bj38YA6BWRYKXvNdPMlrDC/rlfzoGpXtH1lwYCtvfGGX+4Lz66GdMZVD8+iyJQBzDLDU87KqN7b/xM41vM0xrCrBzsUrncpsVa/w3kEVAnLYsUQM37J+X01+8iND3DFGslW12q30ON9RbBDaBrjBV8VhKZNMgP0SsAHGbZp2KkGpB7L13gjMrG9+knpKcp95Jf5V26sqjA2IF/+S9h6MjQi0Vus+3UIYcdg68+6DP2hn+SC9lI3xvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KrRml8Xz4S1Kj6/7WxuwqOBkkv4fufSC/K/xYR58Xg=;
 b=YPMN5Y+ri3mxPpwfyN6vM0V5d41s6P0NIvQfDfpYAnOXWRQpUtWh7DDJTiNBGJ42gWVRSe/xKJ3BilYEeV2m2c1O2qsEr+VoXmwjTzHpsVjilX8ghHuwoegxW/IYRj7GFrzkqD0L1upUv6d7ShzWtWfRXmPzNSEW1qSkVHd/LpeI+cU+c7lYpGQXBEdS+g4n0qxtJndPVJUDT6tf+iaT73Mc5WptTIupdZrxz/0UTewDaoXPKC7Kt8AfUEDjE2T4A5jK7cmbvVRGnCibzgmcOofWbmYChM946ARFXDd9dVflZSeggoI9nghz0j20bz7YGWoeU7OcrLejmDPeE0J4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KrRml8Xz4S1Kj6/7WxuwqOBkkv4fufSC/K/xYR58Xg=;
 b=FMvjKhyZGadz0ZTg5Sr55JaoAUb6lZ+52B9reLcmCFkciIiZXh0z2q/CJiB9HnXARZ4I9/NV0m+2GCm588Atrep4TmYzyrqtP0G3zPyhd92pFxIIiz6WW+B+i9I5wL9L2a6SLuUg/qnZzdGXLTqSZgdIq6B6RnJnLe9W4TUidS/LDTQG/nXMW5LCwL3beoYRmkP3dBTMQSThUaFGdwZcyT+tgXafIYvQW/Pga+e5aZxozdXbG0DCF4WHKWnvGJa+Do0K4ojKxocTvKM+BvhRTiW3LQiwnhAVnu9lYI0PegV0yanHurvLqeV7j/mCDG4yhDBWhh5IPuF3A72a4VYw6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:40 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 09/19] iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
Date:   Mon, 15 May 2023 11:00:24 -0300
Message-Id: <9-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013E13.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 60634020-ca76-4c02-3c22-08db554cc1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAjMbhl3Mz5KzeJw5A0GXJfg93Z1nUVw1LqPzFap56uTklA2UrHmj8CNoELnsTAjl+Wf6jDxOccp9yO10TBUV2OqirBT7e9WdBFi6idOka9+BcMGQY+pmsGai00MjCzpwQ9HnslzfW/1GO5JByoje9PbTeBLFQKGNOxUTd3ctpfCbwXIizv7Z3KY+1ldR806x+H7N2hKob15ypeONUT6VCbcQDYKxqnA+khV6XmcvfwfQYIWOMXayItE26L3tUURIUHKbKWi1yl3Rba9ChuaP7PeD8W+yKKBGj5efZRy3ESmdqLsTwc9WPCgS6qwIfM1PyhS8WBGIDq47AcVbUFpuIrhjyStuYeOswbJtU9q7RvsfaS2ypuPvIUPIa7s9Dn2u7pCdcg3WKU0uc59EgIpo4zlwZ8DF/dAOoglmF3LQBoX0vxYUF7lJkj7z5n4CHujLom0jR80CUTTXbMM29dTIdNmpWtUbRhPC870rJp+kn+Sk4Y6tkvoi25wkU4p3rx7Qy/t7Rm2ABJGhLLTQDqdf1R5xuarVmiWzqKKg/pw9/AAmF4TPP6CoNeL2XpQOUeY4Nz5WPBA/1GIKt7cW5kCqvSTdD8AV21zevL6gYjMnx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wt4/8sjI1harRdMh/Mv3uPPX+udTqa4yFb9Se1cjesMpjwa4I0tLn21NFB4E?=
 =?us-ascii?Q?Mw+zBxEZvrcJB0ia7E1b4uDUNEhTvutP/Gp5xi4CEWhJMkhgat4pof00Xrfj?=
 =?us-ascii?Q?1O2QzsxauaeGX2HA8NhZG7r4kOjFgjR+YlcXS5EQVKDDw3vfF4f5L/imM9Aq?=
 =?us-ascii?Q?mb0uWpyzPnAmTP9LNeQmtHapXVZ+2kIUbxLnNEpCJPMP2NnM8M4toMZLvG4j?=
 =?us-ascii?Q?RLCoc8c12cr7lTUQskCkfkD3qmFqCLzqug9Ks2WW+0qmAk21RHzoQRD+qEhy?=
 =?us-ascii?Q?1cEBBm1HhsYpHVtgbzBdAjyMAzq3ffmwJSvnqaqxubijeMyCKzD3gLuxHXkg?=
 =?us-ascii?Q?jLVmraBHlpPcM6gNHn1+OGbWoJLSlSbGxS60ODu1ElRZsXI65WaM48cE5GQ+?=
 =?us-ascii?Q?vMTNAZRhtHGz0Immkh7PQkPFm6MKdOwvGYoYWmoJwIVOZwHeJHLPGPuiTBGz?=
 =?us-ascii?Q?IuWsbHGbZprxAUVfkATYYGrAwtd5m8vr1YfVrGGYJ/US/o9xxfMl9/xFaspk?=
 =?us-ascii?Q?mKbctq/swe1PrPaoYLcqOg5CYlNsXRSXbuqEuYt+4muaU9YkR+FEffp0wwtJ?=
 =?us-ascii?Q?FnYGw6DgFIZbzK9HrjA7CsfILbbcYKhCB3gkXtnRg0nEbvGUSBHCf9/8cQJD?=
 =?us-ascii?Q?bvAnobmB/USqhccri9JjmklVyp0bT9SNiAakcPR3jYofCKg9WH5bPSs7g0ck?=
 =?us-ascii?Q?JqX0250TVN0tfCoJ6+0Pa6L7FUZ3rrlnyHA66NHgPi4twdhVM+AOIdzvl25k?=
 =?us-ascii?Q?6G0hB3g86GWmKp/SDMO7iuSDfpANgXQv5SDtROzy6Wsy4suG/CwehoihjZoG?=
 =?us-ascii?Q?hhhOryOAJzYdZ5KVZaxhbHlqc6oKVICkBgF4zLm+PncouOFq8Qt/FeQfiJCi?=
 =?us-ascii?Q?urYACIcioZB+q5hGZjNpIXvGEZDtzI+uVmqwRWnMM3bmsEl9W/e9ZYJJuuZz?=
 =?us-ascii?Q?Qx+6Pb5IkgbbYZAFfjIiW0Fx/DQ3xES6AxzFzmNVwe49cMXVk8cFuCD+WUrV?=
 =?us-ascii?Q?nZRIvtpH62TpnRfltZ5UoWWoNsTZh0Nfo0OM3oIsOBqiH+XuJdkEHIBTGNI5?=
 =?us-ascii?Q?vykx3453cQofxxfdjEl5Go5J410EI8HDwSABXodX3/D9ZaLp3dwADYgI32l9?=
 =?us-ascii?Q?gnRrVbR+tcWkVIztNqtt+FbJLhLDFMhlOQhl/bykQfCwpZqNFimyu7aDD5Qe?=
 =?us-ascii?Q?wcp0JanTiUT7frw36rZeCraUgU6U2en+b1TuURBWnKmteQEZxzJZywqV5K2Q?=
 =?us-ascii?Q?mVu3dKs0aOT8yv4/stP3ERmNuVTbn9k7dQ8LzPMcmNANHay/+CgpvimIyEZt?=
 =?us-ascii?Q?w0ZMl9q4XGoiF60d3aCLrvuo151n02zlgymrF2p8jbWxeJl5yA+LkP+tcSM4?=
 =?us-ascii?Q?N24kCGx9h3yDG/Dtrn7Vw0kwYz3R4WbWQtRzCSzEK3B992gO4SRwyOyEaPUZ?=
 =?us-ascii?Q?A7L1TwRrRr7lUNJCLA3YiVmfgRgUZLrzyvc5rPLXgopp5zvujLrmaVPCDMEz?=
 =?us-ascii?Q?GMkFLTjJbdo7tpvQWpU/R67JyeUzJNz6mQK/TNvFdy7hzv6zW5aBVXloe2Ac?=
 =?us-ascii?Q?uUFVLdizYKI9vekpxs5watgAeh+srO0MOD2gYckw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60634020-ca76-4c02-3c22-08db554cc1aa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:35.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD9mOJS34U2IAGT+MlQ+n1YBY2TfPVwM1G1VqVPdndijKmDaCHynxSJaQZwyS2cG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Logically the HWPT should have the coherency set properly for the device
that it is being created for when it is created.

This was happening implicitly if the immediate_attach was set because
iommufd_hw_pagetable_attach() does it as the first thing.

Do it unconditionally so !immediate_attach works properly.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 19 ++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 27 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 69536f6c7be832..2eec53c5d00e74 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -295,22 +295,11 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	/*
-	 * Try to upgrade the domain we have, it is an iommu driver bug to
-	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
-	 * enforce_cache_coherency when there are no devices attached to the
-	 * domain.
-	 */
-	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
-		if (hwpt->domain->ops->enforce_cache_coherency)
-			hwpt->enforce_cache_coherency =
-				hwpt->domain->ops->enforce_cache_coherency(
-					hwpt->domain);
-		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(list_empty(&idev->igroup->device_list));
-			rc = -EINVAL;
+	/* Try to upgrade the domain we have */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (rc)
 			goto err_unlock;
-		}
 	}
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index bdb76cdb1dc347..e0699d7f4c64af 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -25,6 +25,20 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
+int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
+{
+	if (hwpt->enforce_cache_coherency)
+		return 0;
+
+	if (hwpt->domain->ops->enforce_cache_coherency)
+		hwpt->enforce_cache_coherency =
+			hwpt->domain->ops->enforce_cache_coherency(
+				hwpt->domain);
+	if (!hwpt->enforce_cache_coherency)
+		return -EINVAL;
+	return 0;
+}
+
 /**
  * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
  * @ictx: iommufd context
@@ -60,6 +74,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
+	/*
+	 * Set the coherency mode before we do iopt_table_add_domain() as some
+	 * iommus have a per-PTE bit that controls it and need to decide before
+	 * doing any maps. It is an iommu driver bug to report
+	 * IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail enforce_cache_coherency on
+	 * a new domain.
+	 */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (WARN_ON(rc))
+			goto out_abort;
+	}
+
 	/*
 	 * immediate_attach exists only to accommodate iommu drivers that cannot
 	 * directly allocate a domain. These drivers do not finish creating the
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 63b2587a37f23d..5ce9eaf5fb88e3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -254,6 +254,7 @@ struct iommufd_hw_pagetable {
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach);
+int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
 struct iommufd_hw_pagetable *
-- 
2.40.1

