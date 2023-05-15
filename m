Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C75B702F08
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbjEOOAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbjEOOAr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214E71FFD;
        Mon, 15 May 2023 07:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsHLnOVI30rj+JedJpHQmt30LfuOxBREtfU5VPs74YPlO+44CuUxXLOatUrlyLWxn92aXAOvXekhBFcL7yHOWgujcgH4P2PGUzn8hPRqnG8Tg1GOGbKUEmQqZQ1eSXVxoSRcYmWK1Y0QTCPn/Bqrdb+7bJZ6nMgMqCWSumIGJLiR7j6NNhPESJ7VaHQOfQQ9N7mu0voSVTnTIKXj4KZiV/d+yplAPBK5tnEQ1peg9xA88+yEZ4tYObQ38c4GxlHfLY2x2nLIC9k7+Z2POP1fWAMqba5G2UVeCTS8oFLlJysGRE4G/0Nn0SkfRDWBrVhXrDn5+eI+aFIB2MvUsI5Acg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBHVMyUUS5meDFOuK7/NsbrN4Y5wXSJNz5cc/05khwI=;
 b=WyAA2LXVWK/n3IEwlvqsNE/rqvHEEgE82WtTjm/v96NZblqsa83JkW0On/p6oddsINILp5y+P5SaGgvsNzal7Klv3UykYs3BSwzBR2aZ0ndsfaFSBlgg351kl2CQNL62CX+bx/PUsjLniD6pAWyhx1IitdnKmd3I7GU1sEP11KNl02dGCg9dGjEnmbdRVkR/4Sle2zx+vkFP6FGZmNQ+yMHYMgSUD2g8XqotuNZbKCFn5NlQgMHyiJ3uC+8WI5xQY8u2Ui6kIyBk1VxoVMGdfJf2zXo0UniUyAANPwzKzyIqx2ehE0g4HL3yx/N3QJXerJ+pdzFmIq8dkd14zfzVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBHVMyUUS5meDFOuK7/NsbrN4Y5wXSJNz5cc/05khwI=;
 b=OmstpLd7t0EePLMn1iDaDXxz0fbYbQ4QbgR2khZR0q3vCLzN1Hg9uHq3Os8XSQu/WZJrYVn7Xuh9fwdDBQiqtLl3gg/oDm5M6vOwtuAqPkC0w/Ro4HHEqlJpsTPlYeQl4vP8ECKUEtdT8RvSfoiB00NJ622l7uiPd8GtPwJ4C6godo5hlRgVIypZvgFfw0NIGv9udzgSOOt+m2N4bPjg4Eym3UsGGWkpA2i0QYlRXCxlL1NKgiPOHPUUZrxPXsLJwucNhFInjlvrt/wd2Xlx7vzQpSitlKTL2z5caF276EOwIORhOb1bkHEH92yeggG6w2qJQIC1NN3bRnGPwPQiKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:39 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 07/19] iommufd: Make sw_msi_start a group global
Date:   Mon, 15 May 2023 11:00:22 -0300
Message-Id: <7-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DFC.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: ecefcfb8-1b2d-4e88-a15b-08db554cc18d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDrZ1pVFT9sUjD28//vFv3O3qCH24BHCCF7DLx5Glv4yCNK3nhZOtjnV8h/4UEKAcOjUNMnI3uQAEcFo3MeX88FGhkmX2sTGL+CXdWHww2KIgqtlXse4pm1NZIxpUhXLew3hWg4FCzW3W05BYjo6twGkKs5TNZOnKFgnq4M8yoY/321flfYpo6alzjvuBPZrKs+2BRd4RCxgctzxmoOCPiK5J7kF5khxMaIGFLsuMdUIS88Cer0ou4/84izWqwo4U5iKb+TJu+ChxikpufEsVhEuxpniCTJ5h7JzsV8KrGm5oP+tCtUSMiIAsU5TzMUPHkrFZLcJnDRSau5vyCaAom+HJsQztbC1fda0TceqD4c13gEYpg1gsOaApvWG7/ot+Q13xtm+NsCOMFSjqPVLR8ZhKwhnvacpMkRVBITNhr0tzAKbgLc2u8QarLK3MxII7/E4IOefFnzUSpJHJb6M6DqwAe93NDSp9GWdh/VWlhk7R4ZYJEkh6P1jAu7PgVA1xBHJhJq3tdbfhjwyA4/X1jGU1U+e7f9cXGyAnI1jDDr88m1ZvZ9zBDzODs6/Ge5ovn8oCpRscWfE0kkLSIwRXRVOzn6DPip/Rf+0KFQ8cpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCkVlsGTaFX+WfeyN41X3/spyuXBXxN4e0gipLmD4AoBgcOP8qx9uksz2Nta?=
 =?us-ascii?Q?6notD0CczOGXqY4ZqeUcj/CE+SGUkb+7AMKhNSvFZZHzJlaGSyMPNQZq2/Mx?=
 =?us-ascii?Q?8NniIYSfK52l4DER8Z+UsVQpUpxXqVTYWyS66kOXla0Bq3/eRnkPG7b871PN?=
 =?us-ascii?Q?7X5bXdIAkN+Fty2e5rkodWwaS0Hz8EwBhEJiVCacl1jHFSOhfgDXdj/Z0Fbt?=
 =?us-ascii?Q?7mJVSeBW96v1H7ZYQGKlB/BWaW0v8ULkHsYEQJmjSlhUu5qakHG28YEBMeG7?=
 =?us-ascii?Q?ZoXuzjwZtqrGe11Q5OOvWBG01H8ygi3oTlDb+otJAasYhTiQzAG/eVzWCdow?=
 =?us-ascii?Q?zjBrV24P1xF52gPog4z8TUaKQB4z75vNLgwG2c/W01E3SkjNCUFNi9hveZ4P?=
 =?us-ascii?Q?v+7/MEqDSx3n7OYyZyo7MELbiIudjb87orpiAYtghdvzGZ4D393gf6cIRz1p?=
 =?us-ascii?Q?g7hHG7rRGzvL4rwhHy+HXJUE7uO0a2GhE44B1owotrCJrs0XF9DjySZARYIJ?=
 =?us-ascii?Q?3QKEJGg9duGMfu2gy4YDxFBySQkLBAqQExS2RV6otFPTKiwbWWwS7+xsggya?=
 =?us-ascii?Q?0yh0GzqERL8PMEFeOpqTAcAo5qt2c0ckfBEso+yNVocYKjfijSyoXV92S3Nz?=
 =?us-ascii?Q?gvKK5kD6Wd5Shn1Hxi3aS8DvmX13lqxOId3HsJyKSuzZuokmDg0rm6c3uSJv?=
 =?us-ascii?Q?CM8pxM0cHo5GWW7rn/jpYizXa1AE6THNU/G/VRTPcDCvCoGcQb6SRs9kJy4/?=
 =?us-ascii?Q?qnViTBasQTMd8+tl9u45SL8l5nPp6ptKfFEtCfspLrnKUX0mqyQyk3Qoyc+Q?=
 =?us-ascii?Q?dJURcMMA+ciNb1aiwACqYoXrGSyPmnKlw27wgho9La/bWxZGmFk0x4W4CK2L?=
 =?us-ascii?Q?1oOP9f+hbbK5OqNEmzwzjOJoIptWedWzl/K17uWKB0yJyYnN6/1tkx3D/Wym?=
 =?us-ascii?Q?Es/kvFN7oVeyjGwJ3/JPjmCAPjF7Njy9EkWn6MZJxPnmUqnlMb+Vgu958M80?=
 =?us-ascii?Q?yg7ZJ45bRtANNd4g09681tl34gsWeL5UtkmrE2GHgRPfbaPCtzxVDnUwGTQN?=
 =?us-ascii?Q?Zm07iaUi6kijqMa1jn7Vf9vz8kgVE6jbfNCeeaIR4cL/aq762ahAnxn5AQQC?=
 =?us-ascii?Q?BFOK9cTqX+tPpXAwk16bw6FoJ+3pe9ZEK5liCDZqswHA14jrpo0FIkAD9djY?=
 =?us-ascii?Q?hCOO08Aov3JVV5n2L5b3tSP4RITaQxLD2WxdyMzw+VtDde5/aj375DgZGDq9?=
 =?us-ascii?Q?WRzaMDMfoftpGOfsFCPP/MzACvIYMwplM49rsQHqjB2e/gp9WI6EuPApeukh?=
 =?us-ascii?Q?G24wN1gc3RWsElmap/prHaULyAx6zpPm9U7gLDL8+oqGKnUFc72kQ+2hko53?=
 =?us-ascii?Q?V6DCdjUrylxPJAVy5i/tgKiImEXyxFVzgz4lOJyeCdCYgfpMBdrDxwHsRr55?=
 =?us-ascii?Q?jZi0VdUUABdSPKoym89sTDzSGm/1jUG43PneiDJG+/UgJv8UuGesDNOtNJT0?=
 =?us-ascii?Q?YQGicZfTW2io+pq71jNSD+SZrT1eAYF6tyTbO44uhS32d1/Op1s3Iz8r7JiL?=
 =?us-ascii?Q?xEWGrngbz4775PlFVMzKoXn8RruCyxUzyTQsrJTJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecefcfb8-1b2d-4e88-a15b-08db554cc18d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:35.7346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5ScccTTed9JBhyy2pUyCY3xjs514OhFw1vc7pY6YwphzsOMlEY+xGf1AWK1b74q
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
index 548288d9a5c167..b6bf447a6b1752 100644
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
index d5c3c627c0dff3..9ede238908e7b3 100644
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
2.40.1

