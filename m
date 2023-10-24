Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7488D7D59BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjJXRaT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjJXRaS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 13:30:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E027128;
        Tue, 24 Oct 2023 10:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+wIzI6FzmKxRJxeE3Xbm1R1pIz4rwMwmAPGOtrj7/ccU4OO05MUKyRf/fflq3ZD3FrnQaXijEWrqYWxBfnOa0TA18e3Gg8Ki9wTTj0Z+5BXf3ykNaondKU5ZqF4J5Rp0NaaOq3mRho88FwvLsAGwz/EMaFI6YH2rMZaTmJ9PQ6DOGt+fQFK/orFewzhBUb33LuNaNWsx7fOiwkEkcmUzgPPqtNB9ddiiFzVj0c86jf2NWl0RCvCAUj1IqcyEZFZdluYkSzGFRxFSgLLilmjMiffXQborAf9MaRqMscqHGIR8V0cWpnvgy1u0wQ1Jy6aiCI8hDhLx6gI2tgAQiIThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu0uU2uCK/pY7ypAzAmqIaCaIodkqur1kAMksV6LIJk=;
 b=lf8fTACoL1wiyho+2fokrh3vvrn51IT9dVdsuzf81TEjVxfSXB+LSwi9U6Df1hbhM2ozfx05IX/ulYeLa9kewv0VXLahhGPyw6QL8fiPO81Yz8/jvQWihI1fIdh1LKQyog24v54X4fTWcHA16643PxFnlLoHTWP5vPTzLobSMkyMQXmOervGb6tTZT1jXAzpnCWj7gbPhW/VR4S1aOBWsllH7ld9/1nJSLgLZcIun6EQlqb8MyKHMZR1USF86fs5trmP8nGKnxhfS/UeDAV+KXUHcWHvZPFNG5UK+SMcIk0oMqeumde6RQGNyFbWqzv3SxjW3EdNPdPjgWz7/0ldiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu0uU2uCK/pY7ypAzAmqIaCaIodkqur1kAMksV6LIJk=;
 b=op/Nxw+E/T9ZxWnVOZ/0egBvTqLeuiYKIqJbJKY8aYEt+M66TzsjL7BhSdypOMxst7IqCJh4EAA7BVsoX0LWaA6XHHy45yMK0A4aknQt2kZ/4l5SuhisqwfjiD7VVytWq9AREvpUC3VoeLFA0pYxyPybIRULDa4geH0JfKPGn2eiYFTMvqnTVc2ih9CZsPM1jkJat2rBAZyfSfrtFw0Y31fAyU8QCuqYMsX5MSiiZXqxtos/fuQ7WAv0xbAtKEA5b2zOw60tEHd5EcPkBvqUDwPtFi/pWSmNIwJdwNjrnVx5ngjd0pG9xpwFSsLZQher/vOmISiwJjKK/9xudjxUKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB5013.namprd12.prod.outlook.com (2603:10b6:a03:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 17:30:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 17:30:12 +0000
Date:   Tue, 24 Oct 2023 14:30:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
Message-ID: <20231024173009.GQ3952@nvidia.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
 <20231024171810.GO3952@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024171810.GO3952@nvidia.com>
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdc8cd3-154a-4380-463f-08dbd4b6e091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oiu73f5+O2w18C2oVeIDRZXah9QQfCsVa7GiV8o6f4AU/USKBazzis8i0jpPUmjlYL9BGhOBPXHLkTLHN0zcdDXRflkGjMN9T1064f81qJ9R52Lxmom/bY4UiuaR4XWufMftqfSuxXWhxi4IPk+M9PksRVYEc3scuwsXpC2BHU3iOABEpY2rGOccmvgStvHnX0J+wtoViivR81VWBLOTcQL7H2j3Fwrn+2FAkD7DhutWu3U/b+4PF1I1AYYyw9c1grfOMFVWadqmcnXHJxWPJiaGc3w841N1sVaF2OzBPuwnQKvTtqmIQwk3slYc/FWULMa59Jm0iBrqLx1YE4/7t5u9vQnBxe0S60fO2ACxdo3UsO1+KPjzg7GZ/LgJjX5nnQVT3HPDzwlx3nDIz8NSOSg+IfQrzHYO5brwaAM6dXEt5hyxbvlXK2HeQU3Nz90k/XsLjpG2y/nX4oxQ5MF74XvSzMzmWzfOMXsAoAXd9PodzWW0A41rMknzVNl0WdmEa8eMHmbQSEWhqWQ5gKVSwAhlPdlODWsGzuyonbZhGGHVtG6CK5cQzBvl20B1tt2k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(6506007)(6512007)(6666004)(2616005)(1076003)(26005)(5660300002)(86362001)(33656002)(4326008)(8676002)(8936002)(83380400001)(7416002)(2906002)(66946007)(66556008)(66476007)(38100700002)(6916009)(316002)(36756003)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WnbVGYyAN5L17PNis2xkbtYoStVeAmv7bKy7L5rOxgTFh+BR3BItPAv/Y/LY?=
 =?us-ascii?Q?gG+Bk6PBP+r7Pxr69jyJxfvjarYiZWyHv8unJPjLlMjbUeji5Ya0y6VkH3jv?=
 =?us-ascii?Q?4S/gDyPkVNt9eZoaKut8daWetyOCYSIujAeTvh0PvYsjspBk0w02sk8QW6Va?=
 =?us-ascii?Q?72dU9p8677N0bBbniyc+9SQFsABCWaojk4kNJ9GQFRd2/V7mPOddRJ94nww3?=
 =?us-ascii?Q?EAIe3msIjJzs4xPxD+bg/IC62+KCktTNb262xneF6PiLxOhnbYMzR1GTNdd0?=
 =?us-ascii?Q?yheljzhMcCxkoDtHrKps0DAnNTljycAjhHhTV/woKt70tuA/Zu/UiwFCd2R7?=
 =?us-ascii?Q?M3IyySh7slU6pMnjvHl0c+Z5sq9TERLdeyw+7wmJY/zgqCEA3U/SIihwMtbE?=
 =?us-ascii?Q?hdJHt5ADrHJa8YkFsTqjEsybt90uq7q1nE89nWUIla2Gbaf/u5tzPvbpKmwC?=
 =?us-ascii?Q?3CxbxFDs3mvYm7VFhLtcaxfoe6BTd/MQbOhfJ9WcZyFhX3PYNbXFwXIajUxx?=
 =?us-ascii?Q?Ix5iW4aoXjF26DhGNdOApwtbUM42nhP6sUibB0uYaebnQIO1RAteInXuXnpZ?=
 =?us-ascii?Q?T2z0Hy6oXb/tk6RL3VGs/vW29va1tQTuE9EdAt03EJ24wCmu9By5wdeynOad?=
 =?us-ascii?Q?o7TaZT9cLm6jHovyNlCFEVeODSOutq/L1tyFozEe7M0ZzIh64/czjQDtkJOK?=
 =?us-ascii?Q?quN31s1uM6xnqE7O7u6pI1Nhupb+f11LPyQ0OaVdc/mjLZhu1hCVJ5rPb6Ed?=
 =?us-ascii?Q?D5voubDkBXsa4Qyb8k50LLLHpewHASYQG2U7dhZnQcbJ8WrxeujYz2KLQied?=
 =?us-ascii?Q?puydezkfO4tTq8D5ccHbZZW6nyUG19+in93dCUmnOrtoU+lwfND5dtobyASS?=
 =?us-ascii?Q?TAw5UXFWEUHB3ij4MEzSBQ7H2wI5dBhSRqwAE1vVD+ptbQrcBAwU2NMq3JQn?=
 =?us-ascii?Q?KnbOm1thC78gJo5IiKQOLAHHkL2kjFoI8z3dlGhpi103+RWFWVrRZHW44ahj?=
 =?us-ascii?Q?Xv2C2j7H3c+R0FDOEaJBqWnr39PyzNMvsPW0qpIz6qWIlRSYBDr9lt0JFnIG?=
 =?us-ascii?Q?BUEPyE+kjQ1wTXMv13LS1qMCMOERTYsTgZwfsyetlj3yYFeRNDTwQhvnnHH0?=
 =?us-ascii?Q?tTYuR2Y3LURUixznqLsEqX78jf1UlZUCL8Y9/VPUCkGQKSAtNT1mlHMwcEdc?=
 =?us-ascii?Q?oC6NNjhVt1Zcnmzaeuk+rpNw8NWDCeAXcBcFM9dMZDTk7lZXk2597umNBaac?=
 =?us-ascii?Q?9DlLtwxcyGYoE3jseF+Mvey7hWU6UsOBHYo1I8XdpZ24TRg4KL46AwpObO8c?=
 =?us-ascii?Q?xupWxX+OYQsmSwTupmIT/ZBERc/uMLW/wGM8sD5Fe3AWJpcbYx4al82IqnKj?=
 =?us-ascii?Q?Ckga02hHSCQXULM9J/zPsz+wxxOcXDJMzzyH9FrFuCwwSr0sK3P7wngE/Vq5?=
 =?us-ascii?Q?+TRETzKHjrnwyYePBwDGgX52YG2P4K2YnDyK5gLFfV9+y1UIg7RUCbwrFq6H?=
 =?us-ascii?Q?WS/nVi53TDkABjUGa7T6kiUs4tyEstXsRVnpNEJK+QmulfM78dp+vbgicsKT?=
 =?us-ascii?Q?bqiPMWCz47gS4R9WJi10o3WCk//bOuz0GGA/XYg4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdc8cd3-154a-4380-463f-08dbd4b6e091
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:30:12.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mk3aWtafGyt1zbblbBqH4rLMOAYIN0fiyFdgQuHcoDvYuwCATp5DEs95k8J7YMLd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5013
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 02:18:10PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 24, 2023 at 08:06:06AM -0700, Yi Liu wrote:
> > @@ -195,6 +279,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
> >  	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
> >  		struct iommufd_hwpt_paging *hwpt_paging;
> >  
> > +		if (cmd->data_type != IOMMU_HWPT_DATA_NONE) {
> > +			rc = -EINVAL;
> > +			goto out_put_pt;
> > +		}
> >  		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
> >  		mutex_lock(&ioas->mutex);
> >  		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
> 
> ?? What is this?
> 
> Ah something went wrong earlier in "iommu: Pass in parent domain with
> user_data to domain_alloc_user op"

Bah, I got confused because that had half the uapi, so in this pathc
 
> Once we added the user_data we should flow it through to the op
> always.

Like this:

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 92859b907bb93c..a3382811af8a81 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -586,8 +586,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 
-	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev,
-						 0, immediate_attach);
+	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, 0,
+						immediate_attach, NULL);
 	if (IS_ERR(hwpt_paging)) {
 		destroy_hwpt = ERR_CAST(hwpt_paging);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index cfd85df693d7b2..324a6d73f032ee 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -96,7 +96,8 @@ iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
 struct iommufd_hwpt_paging *
 iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  struct iommufd_device *idev, u32 flags,
-			  bool immediate_attach)
+			  bool immediate_attach,
+			  const struct iommu_user_data *user_data)
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
 				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
@@ -107,7 +108,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	lockdep_assert_held(&ioas->mutex);
 
-	if (flags && !ops->domain_alloc_user)
+	if ((flags || user_data) && !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (flags & ~valid_flags)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -127,7 +128,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	if (ops->domain_alloc_user) {
 		hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
-						      NULL, NULL);
+						      NULL, user_data);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
@@ -210,8 +211,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if (flags || user_data->type == IOMMU_HWPT_DATA_NONE ||
-	    !ops->domain_alloc_user)
+	if (flags || !user_data->len || !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent)
 		return ERR_PTR(-EINVAL);
@@ -249,6 +249,11 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
+	const struct iommu_user_data user_data = {
+		.type = cmd->data_type,
+		.uptr = u64_to_user_ptr(cmd->data_uptr),
+		.len = cmd->data_len,
+	};
 	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_ioas *ioas = NULL;
 	struct iommufd_object *pt_obj;
@@ -273,25 +278,17 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
 		struct iommufd_hwpt_paging *hwpt_paging;
 
-		if (cmd->data_type != IOMMU_HWPT_DATA_NONE) {
-			rc = -EINVAL;
-			goto out_put_pt;
-		}
 		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
 		mutex_lock(&ioas->mutex);
-		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
-							cmd->flags, false);
+		hwpt_paging = iommufd_hwpt_paging_alloc(
+			ucmd->ictx, ioas, idev, cmd->flags, false,
+			user_data.len ? &user_data : NULL);
 		if (IS_ERR(hwpt_paging)) {
 			rc = PTR_ERR(hwpt_paging);
 			goto out_unlock;
 		}
 		hwpt = &hwpt_paging->common;
 	} else if (pt_obj->type == IOMMUFD_OBJ_HWPT_PAGING) {
-		const struct iommu_user_data user_data = {
-			.type = cmd->data_type,
-			.uptr = u64_to_user_ptr(cmd->data_uptr),
-			.len = cmd->data_len,
-		};
 		struct iommufd_hwpt_nested *hwpt_nested;
 		struct iommufd_hwpt_paging *parent;
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6fdad56893af4d..24e5a36fc875e0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -290,7 +290,8 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd);
 struct iommufd_hwpt_paging *
 iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  struct iommufd_device *idev, u32 flags,
-			  bool immediate_attach);
+			  bool immediate_attach,
+			  const struct iommu_user_data *user_data);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
 struct iommufd_hw_pagetable *
