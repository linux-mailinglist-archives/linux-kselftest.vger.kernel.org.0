Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0406CAD3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjC0SjL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjC0SjJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339C126BF;
        Mon, 27 Mar 2023 11:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRc/WgliuYKSCZmScvq9NNAi+K/9MyQoMNT1AXk1Xk/pKrxjzmfNZ0BWL4EQsCIKc7KRE5RmcOc9IvJoKN9RwiBNinRdi1g2aKKXHklIxHlRSRUSuo/p0SkUVEKfDRhkuVWl0m/5ADnqbfRS/f5Txx02U1L9msBGnKwQJSYIGHmkYCLSpwhK5YY85jKsK2a85sJQkcb36JoKO18fjqNHYtpxVpuzxetgFYOrodI0TBRpnU3OSI4DS8iQv+DyffOOFMb9CrZEpz5F/ZY8L7iclldEqSxN5dBD9bEvcNRfw286mxBHCY+uxdLAf013R+ZhlngjGriR7d+BoARpA5qfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqEdBCvKS3kb6/zXnbyqH6NHhzeWWtIOLCvDKB92FM0=;
 b=hL8JjWlkHYAawbRx3QgfBq40x05Y2cPzX0f/b9+W6d2DJIFc+alFodFBIVE6Y5qBKkTjeXmy1fjt/K7tghytN++VUdridpB05nXtGK2dX7keXKfHQRwQR2RiK+tleY5pwQemu9wefHokfwtXPpNeCynGTnN1w69GrC+iXIgjo7S2JEKTNeaYgML7N8gc5/tGAHF/jQrPW8Kc8Zznkr9inaG4qtBhTgQFflDr/fEMGxh0OwQaENscG2QoygHJPzCNC06D9lYcvulzFQCTEnypOWqBP2dMIz30yJiueeMoFn62tzzHDtsyg3PJTQq3YGvA71aZsVDe/QxEy+pKCWfkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqEdBCvKS3kb6/zXnbyqH6NHhzeWWtIOLCvDKB92FM0=;
 b=AJolqEhgrdtehTHurqgh8Gf8qR+LRL4m21bongVZVC8JwZdqlDwO4bSOvKb/G0xP4Zsxem6Ws71sVi93WOX9goiztBT9gcFcmw/TXT8PtD1ZmsiH1Wri4fJHkKqzszYkpe0aCVtYGsdGxCySXsS1geQFyQ4NysLKN/TB9gfkBH4uqvgyKqMofZisvpUDTt2rDBquQe7zvjdSE90wSenjacnw/cJQ5+Qs+GsEzzZIQC+DFpMUxKXSFT0Sgf7WTHHCgTXSTg0SG62D+xx5XHQFJJGJ5wpnDqkUqbQPHEctRkjdQlQvfUbVG5CGRqD9kYJY1L6gVpzvUyZu8lsy8ihPAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:26 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 07/17] iommufd: Make sw_msi_start a group global
Date:   Mon, 27 Mar 2023 15:38:01 -0300
Message-Id: <7-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0174.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8b5eea-778e-4b26-9469-08db2ef26e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLplYV/wyyIC6eHi5xrHxrQUBgIBVXWNTyHM5G98aGUUrn/IRASonFZIGZ6D86THFiMkjAL7iNSZzALYO5l7OfxpM3R2SSKqMoYRDxccP0gnRYOrxOK08aM9d2o5MyhSO/a725Q8mdjaL38KGvKukHlwpwPganc9cV3jgYg4Cluw5Ux8NP3ZaeVoZAN1q1qe+KLIRyZo8G19VrFnHlbCtkb2r8ZKTdXVGBAx8tTw9Cs1/CkZDw3Qo1xoLckvRY83Y8eHbwQep0B+6NNzpleo8EnUtZtmRCg/wZUkmBUvk/CD7GaUVmf9bsR8+KXJidgxIjjaQvftAV3CDNF2/8hADjU1yXwHfsdT/AhWaZg7KqhivxTUrIwSCEDYQiuFpaGonkM5dWgAogLrZEEGy9nrKlopvWSdvHv+BdVA/6cQdmjfCHfEtQgCOzwRH+QHWCXUonWBrPMKy5gVEwx8ZnyQ09tnjiFhTBGTU15BTnMWK57Y2+dGINWmUCdPL1VBZ0kuI0IS63u0br/IXDq2vTrCTb4neIxsWGQskAuHFDMz55y/RqlylTNB+0t66+rF89rC9rWXYEwqXEH3yy0CPvlod914MxL9Dydsm3wwKaIinak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(86362001)(26005)(6506007)(186003)(2616005)(83380400001)(6512007)(8936002)(5660300002)(6666004)(6486002)(41300700001)(4326008)(54906003)(2906002)(38100700002)(316002)(66556008)(66946007)(8676002)(66476007)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tUdKF0fCCXR+tta7FLTPw3+ayzB0EuqBoAs3Z1GgOPQfmLcc0tNBfHV6aWMT?=
 =?us-ascii?Q?uAFiRBB5nNyazW1ZnpDjbJ2csSOwzZhhqxW8gV1B1WNwc4f/71OA7iZjmk8p?=
 =?us-ascii?Q?X4wSFz+Hg/qfTSgyLq03ogrxxskWz6J0IXapfzCheSbJflnjqIl50vRNqfmt?=
 =?us-ascii?Q?Kxo6NViyXyhaYbdwgx4LPSpDy/MomjjpURqFjKs7kMMjiILQIF7IMW54SbQl?=
 =?us-ascii?Q?kUyomXZRirLKz4AxhpT+Qptq0ys2lgMoE1dnozz+a4CWGXc/RGoOlGcnLN81?=
 =?us-ascii?Q?8cKcPri7HK4m/EULBaOzMYZqqmjoticlt+6HKz72UnBT+6zrw1iv9PDskRh8?=
 =?us-ascii?Q?j6EXuruEzYVYyaPx1SOj6YXGFSqoBleIAv97z+hPE+D5nlq9HyG/90LWkWVi?=
 =?us-ascii?Q?BpX5yQPi+R5y28qEgXaD/7n8TO/4lxzDL3/a+0709EIVpvyxbsMfSoyK5y6J?=
 =?us-ascii?Q?0ADU/nh2qQQe0+xVpAzdnkU/8ze865y2CtebDmEcgnGonjOmLPX9QuYc/Csv?=
 =?us-ascii?Q?5Hu7QJpvGU71oa/zmq4knK2DWEvAWg89cnvQA2sqnHXvbiYP8ZuWqhxH77e7?=
 =?us-ascii?Q?RVqCMp4atg9aY4eGqK9OTLJWAI3I6ZrTwahCddrhXvxzKWRaiRho5evfujnw?=
 =?us-ascii?Q?8SKQqxkg+2ei5CD0DfLToUBKeJm2D2B6WIIQl3CCVi6hzAylSj40iLhs0aj/?=
 =?us-ascii?Q?FuMltFMfhz9o9f3AOu0o/6aaoRaKvXphhFQ1M0d839L/wlNzJFaC3dX0Wmdm?=
 =?us-ascii?Q?97CnSdxA74hY1ksHqSOijvx2M8b6KP+N0x00fa/nwXV734xIlI7RZ0VhPAEl?=
 =?us-ascii?Q?NWbxx3p9dPCw/IrpcxTBngm4pekOQUU+cmi5Jb72G/z8L6FoUlVjYKqTtw4k?=
 =?us-ascii?Q?r++T6fo25rcEwBG9rWZiXRFRNW1EQnKVqDDcyVFa71lwBY4FTRC95RChwYuA?=
 =?us-ascii?Q?YeEnk/MUCCCawChp01q9KFbjChbp6tBuTcuY6KlF8lQzT7kvbTYKFYdjJBOf?=
 =?us-ascii?Q?zYy8FddNGO8B/5mer1OjwWDhUwstDzeY1MVWBCSpPNrJyIpkvD8fdlp41Wte?=
 =?us-ascii?Q?BlNd9qfi1F9EKXVqVGAVn50Uc8X6JbLBF9qvVuG08+t/H0+QffFFZhfcxIO8?=
 =?us-ascii?Q?g3SalbmlXTBD+P5zEvIct8KHh99vhOu/BxyeTFmO9H6t9xQLsxePQp5QWgnR?=
 =?us-ascii?Q?DfjFHVqhAue3g8IlMog8lBJx5RytoX0GapQ/q68eBxauMCwjkRnipAmkvrnx?=
 =?us-ascii?Q?BD258sgFXe49MvogUBM32W5+6PiKTf5Vj9vdFYkNS4kJp9yIgTwXV85A0yzn?=
 =?us-ascii?Q?f/8IMSzo+zEoHggGoHtxnfZCfJsp4BfrWkb8G602xr/0qzRD93K41pIekntc?=
 =?us-ascii?Q?lx+zhvONxmWQ4qDKOqqLWbH8l4KtC0n4WY3Aju5Ka+PqgfhkHqH8IEUzzIah?=
 =?us-ascii?Q?Fw2KJsxAZtzwdKzLAofjIv/kq1usgcv9t1mjQOpRFUCBRl0P0+dR5TpQHEYY?=
 =?us-ascii?Q?yKjtW53xFEz+Rh7htRZLrS3CxKaSVEXcBopinBSfbcyl2YXTwEB13QJfwv/b?=
 =?us-ascii?Q?p0KCsnWdLurYYifnGyzRNZF8hhsYGMcCQ1xdKUD1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8b5eea-778e-4b26-9469-08db2ef26e15
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:16.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFXW7BJCW1T7c5DlJVdhKYjUPBOa7So+QkHMw411g/Dtv0ZcyV+81fzYF6EApnIB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sw_msi_start is only set by the ARM drivers and it is always constant.
Due to the way vfio/iommufd allow domains to be re-used between
devices we have a built in assumption that there is only one value
for sw_msi_start and it is global to the system.

To make replace simpler where we may not reparse the
iommu_get_resv_regions() move the sw_msi_start to the iommufd_group so it
is always available once any HWPT has been attached.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 14 +++++++-------
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0aac63742437aa..866b28d24d4ee9 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -88,6 +88,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
 	INIT_LIST_HEAD(&new_igroup->device_list);
+	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -249,10 +250,10 @@ void iommufd_device_unbind(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
 
-static int iommufd_device_setup_msi(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt,
-				    phys_addr_t sw_msi_start)
+static int iommufd_group_setup_msi(struct iommufd_group *igroup,
+				   struct iommufd_hw_pagetable *hwpt)
 {
+	phys_addr_t sw_msi_start = igroup->sw_msi_start;
 	int rc;
 
 	/*
@@ -285,7 +286,6 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
-	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
 	mutex_lock(&idev->igroup->lock);
@@ -313,8 +313,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		}
 	}
 
-	rc = iopt_table_enforce_dev_resv_regions(
-		&hwpt->ioas->iopt, idev->dev, &sw_msi_start);
+	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
+						 &idev->igroup->sw_msi_start);
 	if (rc)
 		goto err_unlock;
 
@@ -326,7 +326,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+		rc = iommufd_group_setup_msi(idev->igroup, hwpt);
 		if (rc)
 			goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 22863759c3bfb0..7f4936cf537be4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -267,6 +267,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct iommufd_hw_pagetable *hwpt;
 	struct list_head device_list;
+	phys_addr_t sw_msi_start;
 };
 
 /*
-- 
2.40.0

