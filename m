Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A106A257D
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBYA2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBYA2G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:06 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2AC18B0E;
        Fri, 24 Feb 2023 16:28:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1JbaJ7tE2h8M67dbfMylpeYOxlCQwwzbi5wGkvxjE7rM7UNiTXJQsGG7l+DH1fM7s5MowOXS910yTMwvfthlUyRwE1EHbDy1OVpbYSPc1pM/FoNrDqN6POp8lkISUP4lIHhIA1iirtiSKQbHbQmkaOZx3sF7V65LqgmaG2rm9RI/r8pGzjBBiaqcvCPO2i0FEODspmYZqOY88XrCjRX/QIVbb/UYNsX+HOXiRw1Dke7HDo4IHUDqE8AX25b/BUucGiWL4eyn2AKeeAZCfwQGyWH4+4SfLCyHZsL1PDA3nMywcLVcJ1dED7UicSDarWgrntoWH/gZ56aPw5GaWiV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lILqUPGTW7ech+aXy21BlouSIKW68LENQUYSLI+pYnM=;
 b=UGhEZ/Ztnmij8w36RMbf3Jkkf4UCjzqTZYeTIhRqjOT4UiEGyqnKFl3FVPHFdqe5OhFf+bKmCuE4PuyC4PLRt1UorG/7/UseGpyUTnt076A66muuIbsLTock6nRgKkYNq/iN0RMts+a+nge5fuPFtRSq2GjpTL4FkBe+ZDaPvOIR70ejlg4ZA/DfqVVBfJJZ9YEnLlfKvQOqw4UDL8DVTIXHUAfRWp1xUczrUg4b4ABS5QMym83jy6e36dzdrxFS+ghv/eCJc0/4GHiQgdaKGLy9L9LeYKh3ESNTJko/UC2szGMUlvzA8B5UC5s4l4Bilbt7seVpElSnzYgiQlLCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lILqUPGTW7ech+aXy21BlouSIKW68LENQUYSLI+pYnM=;
 b=JWK+IjShJ+fmTfrfQIuAw/sHZoFfA7SSd7vFIWn8zT9gUWb59MmUmIwwB1SIKyMyvB/ZVepIL1kAWxgIR0NSPwD0FIMFZv3YhNn5WFTGsxvqLePqPAlmHNKyr/KlXwfZt/qkajdpjQPyHF9rkWbiaqJyQ9sMyfBqZ4+4c6q15uzzmw0Cr+m64GP+iW3vsfOcLZSgcZYQyVWXeb6OjAaKxo1ps3GkoXza5bqayt04NG4//XJRDjCKUMaYp6KE6uALxpk2yIYLadsFREmv7GAWCaquch8z9/hMs6V7WSlEQiGUbmepOUdDYK3wUX+/aEWHvBTY3G2ShCIa5mP+3TZwKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Sat, 25 Feb 2023 00:28:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:02 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 06/14] iommufd: Move putting a hwpt to a helper function
Date:   Fri, 24 Feb 2023 20:27:51 -0400
Message-Id: <6-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0017.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b5ef9c-fa6f-4840-0749-08db16c726e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JHufGPr3FjLIZE/d/j9knwJUo0twcm59jI7Po/uo8x5lMp34a+JogbSwHoV21mGKMqONMY74D2lPmHwaKi0P2p/DwwDQ6v/lSGGSEkL840joitzLffyHBleWqB2NaEqJlpNleMeZNTlhzbewhHFQy25U0lscqw9CWbxuJtFD4eGxfF4zp8XfVeYMqCbUv38jEfEcEfcDRztcYdKgQKV0uS6TMvGlCSRn9YhC2vZRb/yGHPGRpfAOVUdWR5V1+YeV/J7oHYX5Db65vPp2/7nnlED2cY9tlKdD+4nFinwip+00S7UfB+0EqbyfH8QX53RUsqIv8l23wJVLKd4riAYuzRpMyfwDbakmsVFdIFLcHro5MRV8yUvg3fP2kTvzUQtGNxDPu1GQRBhBIzyEyL8l849JlQXbQhZZ0+kuy5V9xOPaGC69laPSqHPuyc6eYL/eSFm5828DMagl8OE6tEjekbW4hDdjyo9EpBOnzhwf5NQw7y/xC1GhzQqrujzB7rqbmV+9EUfYsunrUvmNT31dvkpyfwZZHtjscA3IP8nYnLPWBBNexiycmo7wQWOgk+W/YuAv6G1nd8+Xj27frDxbJXRoaf69fEaO0BTrNNvevV9w7I+r+A9iDsfFA/+5nG93+QQnCMPwGNPqOB+FQrX0ECsKjXoKIbRBexI6g5/Ec/CcA/b6UfKIW7Qr3xKf04s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199018)(2616005)(41300700001)(83380400001)(5660300002)(54906003)(478600001)(8936002)(4326008)(38100700002)(26005)(186003)(86362001)(8676002)(66946007)(6506007)(6512007)(66556008)(316002)(66476007)(36756003)(6486002)(2906002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9n0lw+Nwce/RueKlIif5UhszFkzEg2E+zTmtbjk9UGnEzxuvqxud9n8Moy6i?=
 =?us-ascii?Q?bkgzaRHLzRD3ZXwJoSku3iz2NT/GJjJo6eqedp+arvqrQWzSC5Z4wn0kg8Rv?=
 =?us-ascii?Q?cKmR8VvFA99Znewu2JIwxyXGLMovdWXBqBJl4Z3kyop4Aens3Q1Jmy5bMSme?=
 =?us-ascii?Q?oytdyDbAqXgs8NN+XpXaw1R7SqFUUWeE+V7rDjsOi/I8Vn31/i5lAdvkD6ii?=
 =?us-ascii?Q?1CXbKUjXwFZyorXqUwXgNK1Q9f4zz6ikkAOdWxQZVtwjMi9s7CUjVBacY+TS?=
 =?us-ascii?Q?6ljx/YejKjBXwG3yL2ah34vKkalHM0wfJFNW+2tkTc3hySMu6NfVJd2Gw5f1?=
 =?us-ascii?Q?vGrOBsg2oggr0h1pKwk5TETkkr1cgrs905skz+YcwkcLggb0q+9IwnKEtTei?=
 =?us-ascii?Q?JGAk3MReG2RTdV/SI2Urp8EZj6jSyENiaB4NHMpF7j/34ozniDvJ/5xHM/II?=
 =?us-ascii?Q?C/ntYcgcEu51aOpMAj1jd1obTWSnqWyywAxPxyZXDAcUDPs4J+7YxIow9PVM?=
 =?us-ascii?Q?klO+6lQJ/Rt+G7HUSR4TtxAA1ZswxMcr5lQxkwqEnh2rwVUWaksKjBsKg0TI?=
 =?us-ascii?Q?D43mO4SMBXRgleD1rI5HTsXG6TBCrqPmTFrx8Ua4tBboeyx19YJ6f4ewOLFy?=
 =?us-ascii?Q?KlDhjiGz874uFJ8uJHfTsd4Mxt/gy1622Z6Bzx7yZ7rs72cDeXDlyisGLYUZ?=
 =?us-ascii?Q?MpPgMsIofb80g+C2Lloql0/4Vly+bePS8wnipjYDjB2+CE3tuDKQhbXw+K5l?=
 =?us-ascii?Q?rNsHGpXcrJwXoRhhTGqgWU49sovCIcbQJ5YdW87wcNRgCLAlTkluw5aBg6Rk?=
 =?us-ascii?Q?oVxXp5+Y7s0d2tFgZD6hGoHjrAGs/gFhQecdsh1EoAOfO/DN+OOrLKGfHyHH?=
 =?us-ascii?Q?0jpmRuubT8VhTrq8p0QtThry5wDpRSshPRneu9Fn3mzpOG0SM2yl36F5k1zB?=
 =?us-ascii?Q?zN27wlSvNi+5EP4G107yuh1UshKowGVo+1phMV2Vyv9u7kt701bwu4o0fD4S?=
 =?us-ascii?Q?6oNZDe6oHaJ7wjGaBsx36mJyqWERAzcJNcZMs8YxvzyLTvTakpsc39aSwe8G?=
 =?us-ascii?Q?HNc4hvgOPAnkFgB6mRiuAVKjpDGEpxD/57yGdSiR/nyDV1PU6bIQaGQKQX1W?=
 =?us-ascii?Q?GWfQ+Frz8A3suFubwFH5Bl2hAvn9/kZs+UuYhU3VJGUzvI3gmtjRqT3g6Wj4?=
 =?us-ascii?Q?tvDO0L3NoZ6u5PSxW2s3cdN/rhgB58sqnSZI7azTukqUFiGzreSTcSDCTY+B?=
 =?us-ascii?Q?CxgRiSDXLo4ZRuVuJgJAcugYVIgWd8QL56h1yI9OX4WedFfMEeGJxHWXJW4Y?=
 =?us-ascii?Q?DKNum/1J84CXELtLAslYyP7HM32qIMleAF8wpSnuEiTLW2m+NMaS/FigqDzh?=
 =?us-ascii?Q?/iTgJVLTIVlt0g0dEQUqSVs/JrRxtMD5SRHOVykL0oFLDkjtmTsZ7mwDQv4p?=
 =?us-ascii?Q?DtpGYaUqlvIzIjtfPdzAmDWIv0/dp+LAd1ZBUEZFyrLTXVYzD9V87qP91GVu?=
 =?us-ascii?Q?J2nkBmRvRffwfKGLlnZJbmf4I3tymJlW7AWDHEXTw2Taxuy3LicQ2Tp+Miy3?=
 =?us-ascii?Q?9J15ZceRIEdYZCYX4yTYi8pkLzRgDymfJaZZCpWF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b5ef9c-fa6f-4840-0749-08db16c726e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:01.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfCr4coU5a3KO3E7AgOlh1AGHU+GXZo48l39eVC9ctQQ/IDg6wpPf5YAKhlYnFTv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Next patch will need to call this from two places.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  6 +-----
 drivers/iommu/iommufd/iommufd_private.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ea34dc5b0fd1e4..590f84afa06503 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -481,11 +481,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	hwpt = iommufd_hw_pagetable_detach(idev);
 	mutex_unlock(&idev->igroup->lock);
 
-	if (hwpt->auto_domain)
-		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
-	else
-		refcount_dec(&hwpt->obj.users);
-
+	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0497d6190fd1b3..c0c80181d05ed1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -260,6 +260,16 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
+					    struct iommufd_hw_pagetable *hwpt)
+{
+	lockdep_assert_not_held(&hwpt->ioas->mutex);
+	if (hwpt->auto_domain)
+		iommufd_object_destroy_user(ictx, &hwpt->obj);
+	else
+		refcount_dec(&hwpt->obj.users);
+}
+
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
-- 
2.39.1

