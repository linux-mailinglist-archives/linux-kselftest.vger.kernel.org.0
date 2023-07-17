Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132C756B72
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGQSNS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjGQSNF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:05 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D871BC3;
        Mon, 17 Jul 2023 11:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KT1gZAHrl6ygDmSdqpRWly2GklzkH3iVNl3R/1aCbS8k3SfEL81Qq2DHi607X+UhC2/MoohMpjJ/NA/I0Q+cec/sRolENlzYuwQuHKvjgTOGPs5sP3tgT/sO1ETTApyMnU/oveo9hjWtjLoxcg7IMrBXualbY7puUhs7AYv6bAa4NPlKJ+yXLT8+p+IdtO+SJ9wLx4ePJGVA6HwOuctFG68tETpX+XZ4stPKA9ggmHRgMyIiNRjC2MScoOUlK+CeT5HhcKKfuH08pAie331ULbw5X2m7BV/b6YFOSA9N2VE2hgWW3y8D++pHcrcd4VG6LRtMHfpmOwVOHKHSDBnmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sgtd24NY/W45v1jgk7GcLwdCWHckPN9QJng9ZjPGeIM=;
 b=dmYRIh6sRA02Va4VNSjb0YUSQ881oQx4ENVroy7Ph+AChlQW94n2iZAzc6mftnZ7C57eAcM/8kyaN6/+Xf0N1s6YBmljGooKxKMP43wLu8V3FvbRvjCW9zYXitGfbKtYFYvHO6HoP/E5TS0X0kiImfdxIixLK7PSg2oSF1BAK/hzto/iRhatDpLjF7mnPE/0+kcxZjWjBSKZV/iwoknUvfRYUs/LHp/kUfX5QCpAEWO0J/95/cECes7zmMiQCFJatyhoVIFinfsaXXIXs3GOkaN7c0kXsEUNiaZ8uSmiHrzjFOIzcmmnGZr9ubZTJrK2DvUHtGuGV9UdC/hNazJXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sgtd24NY/W45v1jgk7GcLwdCWHckPN9QJng9ZjPGeIM=;
 b=gApSVR30Kp+Ax2FMBv4NGd94UfqzJjzQSyeuzmoYXWj+k8GoSEJ6JV+ukzGVPZYfrYEtyBoeb05xGHzFE0dJUs5N8Lu8f7q0CyiZlpX6J9W4jwK4R3x78e1O8ioMDMnKuPPTDv4gTAuOhMKm1+ZVukKzkFOm4W0saRZQxouK6EnBtDTF7cgb3jabSNvm/TKDAE8apohY/niowBHiUeYx5u2h0hIE0/+mfE2JEhh24JIWDgVjlZN231vJRglxJBAGO7KjOuD+9b6fnSFENh40R7n8XyE/hyhCu03/pRx+98WpzytgN6e12yAA9PSYx0/wp+Du391CKwUrIhtATu+ESg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:19 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 07/19] iommufd: Make sw_msi_start a group global
Date:   Mon, 17 Jul 2023 15:12:03 -0300
Message-ID: <7-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0074.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 5862ad6b-43de-4342-b253-08db86f15b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEQEPFuxt7VxgkbPywtGbpGDbbiWAuu/0CfL4AA4dh1hXjyX4Xputb1yKSIgy6YTYjJx9VFxGt11XLYLwGkSrpOLfGWnCPBUIORJEP5I8d9OFHSvzaKgrsMieDilHFOoDscC0AWnHzVdaiVG0QNn9+pd3e5jrylSsI5urGTw5eVnxy/r054DQWVI9kpvazhBMZIuBC5m8/tw5IVC7/QRVctgSoaOpBCzw+MGpHuZGErQ9GrV/VzCOHxtkLUrbgek6CvKSujrJhqddshPYAyLBvUNnDdLLMmLRKmZ3VtLGmxaHci+Loj+P1JAr6IHyc2yYZY+QA4AugK+Vod2kjzBpyhoXf0ugSeUlFqT/qnZQCilW2TOfo5oV3aGq3iJL/HceVMf92WNE5/hglF2305UQ/6j4kkMbQpQ1wUg2M+SIKmixIctzMCs1CQT7Osk5/ztgL6//vl6BeuO2mWnzXyj9nPfaFxWir6shrw7wgLJN56walzqPfepaOtF8x1eC/neM7Em+ydDon9StDWsXt9+whpJm9LZGz44ZQXpXATAFRKjEemUS4gNSrunSt8PWsRGOz3ry3kUIuxc1rCWXWsTOw3g1eg2zeLZw68FSjeVNf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(6512007)(186003)(83380400001)(6506007)(26005)(38100700002)(6666004)(6486002)(54906003)(316002)(5660300002)(66476007)(66946007)(66556008)(2616005)(4326008)(478600001)(41300700001)(8936002)(8676002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yI18imMNbljERv85OQkdvaIpFNPN6lLow/3GuBMPa9ceJJtU8Ja8+a+W+aqS?=
 =?us-ascii?Q?ll/an43a77390MNJJQlxcWYYNXhuGufxYZ8I2vDwG4tdzf3+yDH7cQtdMa7e?=
 =?us-ascii?Q?11xXpALSyiaTDFVyfy1hYCvsMtnRcryHSq5m5TPw7TwzKToB9PV6h3/t+RHA?=
 =?us-ascii?Q?auPhNImYHKJlxgBK5rLoMEjm6pY5Qkwtj/pbS0k4QL1wX3XTfx0GzwHgngni?=
 =?us-ascii?Q?9Z2wzXLAJloQbRpbXub1K8uS39u0q/ScxMuuD4cJvlsvRvKI83GwBBn+9B0m?=
 =?us-ascii?Q?XZFFD44GjjoOM2c2qvS4ErHCli1fFuO1YQ0008xXPbrxmIp7Wu9ZlRz7LG0H?=
 =?us-ascii?Q?1gGcaYMhrPqAkYvYqGUUoU3ea8AcpJPE3AxpU5OhCCJj4SUfl4smPeYQOah+?=
 =?us-ascii?Q?Aoo4DYEiZvtvYCZGuLKPigWDKVUtalmwnjHBSNZqk8/MFuy3NyIIhNADQDQu?=
 =?us-ascii?Q?lN1jPwTqMXcOR8MBEs2yni4OqOQLlI6U8ood/M3kNI9KjP2Icz9GwHec8qYl?=
 =?us-ascii?Q?Jg5M4MmH2HH6Da+nYTvNWUQq5as+bOG46nWUjTTKcM3jzgay4wYdhHkv+VA7?=
 =?us-ascii?Q?FzCud8MyZ/R7QhZRC4I5D254zC/KVbgc1UTGDM5DBvN1OVgzAQQbSsBbJVHX?=
 =?us-ascii?Q?C5SWeyXKEJzHKel73mXKLGV3IDO4su2ZslmE7xaiavr1qC4ucjznpmCLDYrb?=
 =?us-ascii?Q?q/fO24OKQKAuEJ8Iqj2gOyoCXMNiJSp9SdT6v7XzUGZb4KZYvwFVOoN0jw+D?=
 =?us-ascii?Q?/aPIsnuHj77Gk3Dbj0BK2c9lX2LVAbQoPKx5lRTPFe0nmBs/hMLk6CwtZd2C?=
 =?us-ascii?Q?UMLFFVsI3pPsLdyWNIBVyIB0u9Z8C3B1N1yZ7cZMJHw5zARXuEnc+iFObbUT?=
 =?us-ascii?Q?JgJZznahuLGd2llBzUH3NcplEbdS4z6+1KQFaNnNB70tUnm2de+mgualmuiq?=
 =?us-ascii?Q?CZ6fQ66D0LNzWF1y3LXpOo419w81v9eZ3cy4AxQGnmoGVeRM2Za0Rz/IBE1n?=
 =?us-ascii?Q?8lgUf0h5hoPLRb14Kd/lQC+dudvJxVvI/+r7E25COAaYQIiA2lhhB9ie7mVk?=
 =?us-ascii?Q?jRlC1GJWjx/Vbn57SmGr2oSTGcy1fDha5GtHPYC9vgy0hJjcEzLf2MjUsh2q?=
 =?us-ascii?Q?pQDgrfmmIP5nx/oMc3P6OAlQmTQHes2PvSjWjFtRutoFY4QecQ4nJKmAi+e6?=
 =?us-ascii?Q?ht73DcGrusp1GZ0cnACHPZkSlxbRuyTgTciS4YR8hIku4GgVVnsJevGEm2zS?=
 =?us-ascii?Q?EPZIectzXCO0O2DUjqv86NJ1mYtzFCh5Ru7zteMAlayN2Bn+PoD6ajAsAyJj?=
 =?us-ascii?Q?UsE8M0nnb3aeYT2jBw0J//y9Mutpcgf7AoKtxplHMB/MBjzDJRwnhWfk5lrI?=
 =?us-ascii?Q?5mN9M3wDVxVVqFXohRV7oPpE0YPZL3fNslXtz/xTrgz8Hpx6jfE6QY++PUis?=
 =?us-ascii?Q?rjxg97PUBGtEM4x05okV5MY3+duaA0NoFJstbue66ol2ZFkvF9mtug6YBZza?=
 =?us-ascii?Q?E7Lw6f2SB8/Va/LgveHuZdjA5q1lQz4BUcpylHWSkNNvhQVLRUQu/5zaCqas?=
 =?us-ascii?Q?FoSwAU5L0cDtcYhM8B9NViGvqmf+a7hpo8KD3q5+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5862ad6b-43de-4342-b253-08db86f15b56
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:18.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqdRrkhPn1Pmyhtw3VQKxpTLloILru8DYXC0MtYAWqWMbASAY+PhHUHN41LNJZwZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 14 +++++++-------
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index b2504c612a37b7..0ca9fdab07dfdc 100644
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
2.41.0

