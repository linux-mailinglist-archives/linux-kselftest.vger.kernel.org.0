Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A155260D316
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiJYSMh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiJYSMf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911D3B1DFC;
        Tue, 25 Oct 2022 11:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvFuiVBAqMixckHyuS5azgL//Na3Ett+QzVGWsjZK2aWvbfoCgsJ3RhOdCipovI7z2rMf+5rz62X94qith5a9Pv3NGxRFb8VkK4TJ/BdMLTRLzZRNVzFBisrodWC21zZYwCqI97q8pjyCzIHUnqs18dpWJuHizQ36VDw9NXG6QJNpFKdysQ+/v6M1UtSkAwWNpQ/MwGyhX6NGb4nvmlDXtKJUuOZ2is+PV9MFM2/3jm4vP/EfnWTg4AK/1VJmv5o1qj6pf7f+J4r3a4fU3RTLeAl5XhIPMoveilaYNzDMFqfgy6N1goujUjSaA3riyD7YRPrJJ6vx62FDdnw2M+bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aNorrgrLiE1iwOdAxehUWSj/XSLvXIKgSRFtwlKwdE=;
 b=OWmbtVOVyA4uUEYAl1GGmX1Tfv56qzc2nAZVucaa/Er+LLe+N9a+3rFZps2v2kP17TCoWw/Nv859ap5DIY1P30IoLYLK/+Qkhh/eN8Lab3uQphIcEiNH6Xmu1WtPIIbK0ZPuLyFEgokhgeF7C8QmrnRTfG1Cxc87oZt3JGV+pJF/oIiScMPnyjsZYCmph6ZrR6/ASmHCagMRlloU5EUWOLq4orGqV2qhgVc8GcOqYhO3yiLtylcjcL2+9JQM2rMsXGXcG9kI84v0Gsw5A80/EcF6UUWUUXWZTUoHpOCWOymRmTcGenhlOQLi3Rz/zNb8bLCech31Y51B0XyZVyynkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aNorrgrLiE1iwOdAxehUWSj/XSLvXIKgSRFtwlKwdE=;
 b=JRNl+JbVcZpMXjP93ETFCQaO2/QG2vJcyJx1egI1a0XXB27qlyN8INe8Rv9kz0cu59MyVSkTLFvUxGmq4OeflXp2Z/BR/TIrg31iJHQor4SbS+DWOn8sTuWKmciaqoglP73jK+WDwEJ5zyqESlewnPKXP4ll3tIBhu1YzK7AbglOFdzvsWhERT3bXl6hSJiyigbdAUKKVkZb0iawSIxTYkv5HeV19h58y6W4m10FPeCmAAndc4KZKcbaHepoXvx2NhicexoT90sTvUl8H3mwi2ea3uJmN6xKLQDxjwtdRL+LFXGWrwoaSboU4npRU1HCNw3qEGFfx1yZxbRtS8NSDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 18:12:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:31 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v3 01/15] iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
Date:   Tue, 25 Oct 2022 15:12:10 -0300
Message-Id: <1-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:208:239::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ca51c3-1d1e-4198-de07-08dab6b47902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pbUp6c2B7fnE+qu3KmyVrY/NByFvCte0lc4w5gDxHFKM2oGb3fLEQIfJYKwNTJD/d1neph4HKLPAr4EF3amEF0Q8EejYIatn3rwm59PgYkMpRZP1+yYNHjbn7nwnoTyCp4r1gW1A8cZsHr+sF3e+jE5MJuTnhgdT/Kt16RvT2Ot+Afk/ebSrEkmEBRHPGSrjqsCHdVqzPCE/g9grMQIgrpJOy+P+49JHorOA/N553sATz6voElucu3JO5oCEFVRv/pKIWPSQkz3nCKq1jNAyM4huP1MsmK7z8Yh4UhFF7ZjgDl+q6nw7cHKyhX4WwCfk/qEE6Dr1Ga2zcNQ4q7UCelg0HOmu9Zy82lT0g/7U31FiA5r+3gQbOP+wwpTVY8rDySTFgOG+yY/rqUUT/R1KDUJhFabTKnncuDyIU07isAICh0/oaG1RkYzy5bzGWz/1oYP/Uakc/Q2IA0hAYwDtx3MYUNEH9S4rIdaeB34p9HmNWNpNaL34K5C75jQcI+A7tH+btbMapTyzDuMkK57pKAcEIyaD89GLExf8N9hM3h8OSvsi0xKf5G05Qp3Y/L77ssMrTfwJP7+pOkC1Aajkk0h10zAxzbL4r52ctfnuHcQYAwQGtLGSoNbcVg1sQM0Z+CgzbAuqy3/+6Em9KdlE/WkEWHML+M1CCmVRnTja3mtnfgYBZWjU2gGdfeZlMvQQSt/SAKetua6BpVPNg3TkR8VYEHAEMK96AMyjSq5KMfbA5qHWhnbhD8NdMEj5+oKawsT8rGgP2gmN5gmb5JxRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(7406005)(7416002)(41300700001)(5660300002)(8936002)(66476007)(6506007)(110136005)(66946007)(36756003)(4326008)(8676002)(6512007)(66556008)(6666004)(316002)(26005)(2616005)(921005)(38100700002)(186003)(2906002)(54906003)(86362001)(6486002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HfVHhgbRWCAkLsHxNpjHJy2lIXeYWeIyknVuM+FXMT/ZrpNfsz8nKvwnGTfY?=
 =?us-ascii?Q?59P0K/ogRHoPGNHMSioUE0sexzG4WNd0P3gMsCrQDP5MSPC37XjqYiv74N6D?=
 =?us-ascii?Q?CqaDKaUPzdq/Oyoe8xzQ5BgTzFuxGSjgEPMwXob99HgjnZY71WqP7kipl8s3?=
 =?us-ascii?Q?CEL+uS3UVepmuhkjEU4SYx3FWT2+medCfe6G1NoViU6aufM1AnINvtBZsDAh?=
 =?us-ascii?Q?Hu+4mK7A7eDvDLFsl3WMj1/L4AIJZshuDgXRVK9shppakktytY8aSJkrTv9f?=
 =?us-ascii?Q?7iU1B0OhcVuo6PoDadcBs/RXkSW6W1/5AF/qhrYnTSAu0QjZZF7t39WB9Kae?=
 =?us-ascii?Q?b5S69cQSGHoHm6NLuZ82kPTZJrYJUAPoyoTkFBHDwpnHD7SmyrNJLqS3wZxS?=
 =?us-ascii?Q?ODfO1QlUTUdMgSr0asNdGApvO7NAHgRPnNkjvD28lBCyyGG2GKD/Y+F+iHme?=
 =?us-ascii?Q?+qSbqOJ5FZMPQUt10QnIm/pp4q5+3I7WTZyo1+bqdeON0YbAXyBMtAwj1Ccw?=
 =?us-ascii?Q?SNkuoUWBg/eU4wBLVjA9E1ATlN42gwREoNZK825PVUDGkA3hs7ulG/5WYNOX?=
 =?us-ascii?Q?wRjWJd2EOqQ0+E5oqtynnrfjqLTeuFeUnrUC2xjPzAWaPMoKWhAJD5qrTfns?=
 =?us-ascii?Q?JsUo4uZRFHSg7YoAEyTdawaPXJx3bUwoyHgPC1lKczQxI+LeCdnbLc3ATN55?=
 =?us-ascii?Q?ulv20beISSVsHnIF9YbJFQwfkzH14CbGHe4fS94POqgS4watWGL7wt0ujoJ9?=
 =?us-ascii?Q?Mh+ZanAOBB2uRVK8Jy1OxXZ0Q2QyfYtT2XZy2qVbpnK5AFEqqoxRy13IcKsR?=
 =?us-ascii?Q?9DIe7QXIki1+AI5KqVnfkxJHIruyaKto01wR23LwPMqBX5f5kIdk6uwE68hA?=
 =?us-ascii?Q?7hPNVkRvd4NFRxiKHibDr6JOFELXQFz9I1TgNvDnILjc9SZJDg+utW17J0hQ?=
 =?us-ascii?Q?ipUECqGfqbEVtxfBxEHTMJNUvqANms1IkCTXKOZ1v6YW0erKqYkOBxvDyH6p?=
 =?us-ascii?Q?G7EcPPVj8X9kNZkgWobVLArBig3+yAmaEyWeJcQyA9MIlekU+SJUQb6InHWh?=
 =?us-ascii?Q?hC42jZeFAyieXdnfNuJgqYB0jNzhR2TD4QV6PlZc5IFoCeDr01WqojZl85Gu?=
 =?us-ascii?Q?h+cOSv/GHSTuCsVFjdN+JP0s91huBt44TZVMM/criAdH9kW6LOvQGKceLR7h?=
 =?us-ascii?Q?dMhmypUyEkMSwfIIu1qsz3FEUnTIvEnVv7VX4bCVi6T8KZFJZeL5tk7h/ptl?=
 =?us-ascii?Q?LmaGk85X07i5sl9ULbkFT+9buUWbQOUdE4q8XuN6NlMcNN73pWvKNFAcRwM8?=
 =?us-ascii?Q?8DXLD5J1SExb5lKsAf+L5wnk99IiGXOevFUqH1WNDG76+u4d9yDZMwgWGasz?=
 =?us-ascii?Q?6L4VEq99CjCrVuIXdlTV2aKc7j0Q6PQs9r4RwqYpOQSM/Dn/8xnatreWSmtE?=
 =?us-ascii?Q?KKiiX8/27D+VufyHvA7EIuLt9p506dW3A68jv84HHOv1iptDcqDcBOMz3Q4q?=
 =?us-ascii?Q?mKqL7tgKpt9Hmj3MBVLA8PrMZj6yQDf2juIWBzma2FfGJOCjzojp1rywqU8z?=
 =?us-ascii?Q?lblVgzvgLZudyCT8rII=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ca51c3-1d1e-4198-de07-08dab6b47902
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:26.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvlH+ae1//R+qJQLwSkSE+lxvxPEV5qEgMdIuGtQQQ9JqUSZG91q1FVYlo2RDU2x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This queries if a domain linked to a device should expect to support
enforce_cache_coherency() so iommufd can negotiate the rules for when a
domain should be shared or not.

For iommufd a device that declares IOMMU_CAP_ENFORCE_CACHE_COHERENCY will
not be attached to a domain that does not support it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c   | 2 ++
 drivers/iommu/intel/iommu.c | 4 ++++
 include/linux/iommu.h       | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d3b39d0416fa32..d0802cab2a2f0c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2286,6 +2286,8 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 		return false;
 	case IOMMU_CAP_PRE_BOOT_PROTECTION:
 		return amdr_ivrs_remap_support;
+	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
+		return true;
 	default:
 		break;
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 48cdcd0a5cf346..438ba997fa230e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4458,7 +4458,11 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 		return irq_remapping_enabled == 1;
 	if (cap == IOMMU_CAP_PRE_BOOT_PROTECTION)
 		return dmar_platform_optin();
+	if (cap == IOMMU_CAP_ENFORCE_CACHE_COHERENCY) {
+		struct device_domain_info *info = dev_iommu_priv_get(dev);
 
+		return ecap_sc_support(info->iommu->ecap);
+	}
 	return false;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3c9da1f8979e3a..40cf2d8393465f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -108,6 +108,11 @@ enum iommu_cap {
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
 	IOMMU_CAP_PRE_BOOT_PROTECTION,	/* Firmware says it used the IOMMU for
 					   DMA protection and we should too */
+	/*
+	 * Per-device flag indicating if enforce_cache_coherency() will work on
+	 * this device.
+	 */
+	IOMMU_CAP_ENFORCE_CACHE_COHERENCY,
 };
 
 /* These are the possible reserved region types */
-- 
2.38.0

