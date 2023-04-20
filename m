Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08596E9C06
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjDTSwY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjDTSvy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AB94221;
        Thu, 20 Apr 2023 11:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSRmmjDvZjN4/WQuFtFBDDSUz7YqPADRW1M1dI/hgwm7pKDkSL0ErPkRNqZLbvUoNRQiDY1DxCcy3nmFG9NC66dl36eKurrxvTxS14/G8ngWmweEayLpeocOwnUZaWqtwewaEuWVFuz2AU2frOxVHs1LrNN7v/EskrP1ombyyJQKsjnQHsyqVyGkiTOAhXgKuihGtNRX5Po4SlVqa7ee/+WeHCMIwoxYklDlUBBBIA4B+GMAJgdKVBXW92yPQlxyy8BDD7fPqzMWnpVCl7MQFti1r0avtpa5b/iAkCo2sHxmXmvomOC6h17rDiHbtwESrvBlLEeFQVbP31apYx5NfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxa71Jdmk1BalfkQ1UgLAXDQ+nsULNuZsStUUfI6AN0=;
 b=akNENlJ48ZIvg8EXdxcgFhliye6i9Cjxg8CUpK/muXAJ4Fd7Jtov09ZiWjn9PXe/TXyPCoppkshNEOmEcDjQ/p29nnZPYgadZRSI0dA9NsT9xaizZ+lwcbyQlLF+otDkRZE5FPgYrGeGR1zuNMfhz9TFhXk+3W8+xS/u2x1abIbpucmkCEr9MqQD8pSLFy+dPFyBfE5yzIHOJpOSlOLMTYIrKtu/K/TiRBTL5c059rbotBaUtaDDXb2kJ86ugJq3q8xH4rBulFI5t8pQt+q3iqR6Si+XA0ZHiTC8GsuA+Jxs5tMEWvQEZC0yi0Eb+hbQQIcPLKjJ+Tj6VTh9I/GlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxa71Jdmk1BalfkQ1UgLAXDQ+nsULNuZsStUUfI6AN0=;
 b=guqR3rjZHAuDX7Afxqydklvs7/+mXzMia6i+9/fd1RYt7Luc2A9LtlZ2xTny50V1dMAzPgSdPtifViABpFATb+XukIJ5SG+2vTBFhtX/wfvKXwDZxbyA+qdGzvXrQVGMELUd4ZG1JKusXWjZkM+9/jzBAD9//dunsmL65czbZw2tKkL+pNRtFBln6R3Sg7kMSRGZGbOVvs2yvyh5hQunh30+MTnLmsEb31zBuXEPrOvk3ZqDF2GFai1ClNA9QArNI+YQCu31huNokRxodW+/vNsKPQb8Zb7a1bKEzDz0ZSFqjjt6CxhnWU3KvjXj6VSzD0ivUyfOV2RszzGflxPrdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:46 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 08/19] iommufd: Move putting a hwpt to a helper function
Date:   Thu, 20 Apr 2023 15:51:23 -0300
Message-Id: <8-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:208:23e::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b44d19a-3ccf-4434-1941-08db41d045a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k686SuqL2jAeIjxJBNifWI043FScc1OBgFvqBZKeUmczl+AEOZNJ+tEIo/iJyasGMDG4Lg2oRYbZSUZRhm9M0Ucf882kY99NeF+8tNYcQ7TDpkqYJ5rZYKXy23WVOls4K/6OaYIfvllxgd6HhA8S5+Y4JxYcI3XoW8qolZ8HU4YGg08e4QNEjFgnlaUpxf8CzG4GsRjwQzjCBDYmF1Rd/dclelxri3stJaillBHmF+L+2TJgVZpHxGtSIk9R7izai3f4bojhO2d5Aq5+KpXvZ4gtReN1PT11DHCuZH8DGNLDKqJX48oy27l0aQMl/d+/3dTMCup7ZQcLPUW5Lhw7KICVyDycxdmxa9H54NKsxVLuvgslN62XEowmvyy5Hja6jcUBgWLKVPwOu32Z9t1kkMu9ZAimzQSTzyUU/1JQ2FbyFV6MSZg1HwJS0c4hC3NEcvFHbrmJ+3qYoXFED9h9KHPK6g08SZAYqY/ReUSrYCuFVTIBppOfHkQdn33Bod/B8OaZ1wrcZSKCUwCs5N032cZbfRC+R+D/qqIl2KkNPSVvkvZDbMOZMFd+PHdaGPh3RfGJdHTe+VMeDyd0Ghay439NEepP0rK10J9yDPPXhsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f9/dmvQlJuv0qKh5AlpId23BF1FDGM4aHe2p64m+ggbYcv8rbkHgq+Cd+kpj?=
 =?us-ascii?Q?E4M+ZAo4nePNRaGslqGGlH34yUzx2xXPcVYieP09rPYSmp8sZ73Q8waPTRJ6?=
 =?us-ascii?Q?rPGJVjVn1+npuNoQ1D5cLlXEtmi7mve9kYyf16Foqvp0Nlgf9woyRo4BHYdW?=
 =?us-ascii?Q?gEkEOUNIoVagUEAETGraFE54IAQDTjSCaxuDpV+68nexz9J4EIhOxD+JYWMs?=
 =?us-ascii?Q?qmdWhhk1/AvSM1EnZW3w/CrOwmeXBga1OnX6ptjLo6vmT0Lp9VT2JVEdQbff?=
 =?us-ascii?Q?7Wmyh7JlFFeHpZpezfp3/dFa9DqqAKfYlDIOt/R9ZUpZU+X0YARTXlEBmd4D?=
 =?us-ascii?Q?QVrNe8MXX2yHtCJjxijO2IjYdi0fePIsr6pwEMT55+BbHZGI2tVYO2/0UtQY?=
 =?us-ascii?Q?dkB9k5fV5opwm1xmf8flpOB/T9gfEBw3MvZU0vSMsg1PLkDdT0v3shWXT13y?=
 =?us-ascii?Q?UOJMlWzOqRtdHF5FAjFuqqHthrlY4aam3jMGDlbkDIKuhuZFuUuZl4dr/VWD?=
 =?us-ascii?Q?djhKnAuOu22L1O11TRCZxQHNfjdhyOhSsEMFfAVIdie7QTDl5SJ8cQVPIKhn?=
 =?us-ascii?Q?zc+3BbJx/Iq6Oek1rSaBtm5d6L//TIYX4UMgZy16ciE5wqhOv6tGPg1pBmIr?=
 =?us-ascii?Q?814RnHGq+JgLTphsttzmgijQiKiCcOelQ+fwxjGjdRDuYuNYuQLARCJm06u5?=
 =?us-ascii?Q?HibSpqIw56tB+NWvQL4YhCy56vcfiZTP6DU0jZSBIwHHaqaGb6Q+yPJl/IEZ?=
 =?us-ascii?Q?vBDL02sOuhDtlAo8KDxBcsjWeZW1ym7eRHul5Pt7g/ogLKL924o4+3ft4kzx?=
 =?us-ascii?Q?6IS84bH4+kvQB3hPSFqu46hynUKxKZLoy78+ifFRRHEzhHf5uo5HT6k9uNVn?=
 =?us-ascii?Q?HrMhuubX9BUI2YDJmZkjxxfk9zvbIpQXZ7G7vwTY7s/5d8AAdt3ogyL4G60J?=
 =?us-ascii?Q?0GDHWEWzIoJu4Xui+xrIjn+GJuQS/gWrTRoBTEGLx0XFRKpVTn1omjyQKfPE?=
 =?us-ascii?Q?4OVLKCnsTsBvNWuRQrBSuqhDpsZRRSIx8v1njmLBIbymZnGxjuv4rMknT9yo?=
 =?us-ascii?Q?8MQiXw4FbdBXzt+s7aUvRK0qi8ykCvvSqTz+/x1yRMAMLFItE129ZtlxJX/y?=
 =?us-ascii?Q?kfVi5zO8zrHhzMyB1PzyBTFpJVVs36qI0/DaKwYPmWkQ0Q5IDVpyp8ICRSJ+?=
 =?us-ascii?Q?Vi7nntkOU7AGxEy2Ap/CAaZZwon24DcrFqtqc1FSglvhbg1CxevmlrBZ9xlW?=
 =?us-ascii?Q?EJhWZqj5QwomyQI1qN/qummn2maboZJTeW8UQzVXa3y99I3OXqWxhpi01hOc?=
 =?us-ascii?Q?GuYmSNR5HZsw4KXy/zXKHh6GJPajnckqTng6SvfVA/swzb44aYZagRWMWBkh?=
 =?us-ascii?Q?3LPAoVZI+viuTn5Gasa8JoHfMz6tiTUFcmdDgtjMoPp5habhxpwgbhTjil0+?=
 =?us-ascii?Q?NtQASmSk9Ou+7ID9lH85doha28hFbZaCpu40M/Ex0E2NLolWVYiR+o4PbMwN?=
 =?us-ascii?Q?NMvGHI7DGf4p+c4bNw1Y5f5k//sz/QML7Z+BH1okrGJ6y2QsLX3xilRCYcdA?=
 =?us-ascii?Q?DE1BaRu0SMawJKEb9C1LB6kHEJGbWNgWLaZcbiRa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b44d19a-3ccf-4434-1941-08db41d045a8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:38.2144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6lDaIWOjuayxLzzB3s0P9bywXki+4CSTJWDxmV6MRGp8IBGo7lt4LhVkrMpSp6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Next patch will need to call this from two places.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  6 +-----
 drivers/iommu/iommufd/iommufd_private.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 59fca93bbd0c47..ca9776432c56e8 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -483,11 +483,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	struct iommufd_hw_pagetable *hwpt;
 
 	hwpt = iommufd_hw_pagetable_detach(idev);
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
index 7f4936cf537be4..8bf053f4d4a9ce 100644
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
2.40.0

