Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CFD6DE153
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjDKQoi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDKQoe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:44:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F131526A;
        Tue, 11 Apr 2023 09:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPNSmbPljrsexb5Vy1mkfCLGZiHoa56a0O/N7OhjGihMjdyJho620A+2ugnd2Dszrshx64liM/qKYIwKTJN0HPsAH3+iW+A4khUtkMoguYGhqQcg3IFdlJp7KiOiyzvFHV5vtxfhLxXeCDxuZRD5VRP1cyFr1u4JU+es5qn1klKrOl7uIE3lTMTRHC8owU2PhWD/acf9FfOTZsZtihT3M6Ecwi6ZJsA3Kj5puGXKVw04nPecm8yHoDMDUlbbe4QhZT2/xAAqmdBMUqvrtUypw+91tWuaWKRIr1DY2u+tUa9jyQjfofD6pfgtLHxSbxIa518edKgIi3htgadU05jrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3blGAHefJ4aP70tNrJtt6rGHVG5EmtnNNBaQcgWD0rI=;
 b=XtgGVHRZX3TtHmLPkiQt80F7Qkh9qbegMNa3INx5gbLzh6273q/vuXiOKFHPpAGkGyuG79Qnk7vU83ed6wIIV9/Zh66q668Kk3oFugkN/hMxZTGUBlZRD++dIsJ9osl77X46ijJPtBWnzuTH909b+lbJoPrs8Gy4r0FtPlHXuXCN4yJ8SBoTd+ILFXyd6/GJdHatu5XSv0qeM8d2nRmIMGPr6K3/pw+yKSehRVLN66b0qoowL9TC4meC1EPcc0hKKDeXMVr4T4m4TR8gJGKeDrzyTsU9DVZvJ2G1UCgw7USPi2AEKFEZkJfXzZW2y8BpXJwgugMAKCem5AvfYkE+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3blGAHefJ4aP70tNrJtt6rGHVG5EmtnNNBaQcgWD0rI=;
 b=Bf8KfX52eTYKFjxGmfUsP1bsgDeX/c8+2obxtLxy8ZmNuECpE0V5tmyEyvL3n79SWcsVPcSDj/txLBgbCwq75dPt41M8Dik5FdInEdWBpBThx2Y0MjixZ9OvkIsO3jxpk1glUmS8f3E1FbPbZ041eokxRVtg/IRUKbuC4yCIKvzz+XMWyyW9D6hM5KFFPPn414o+HnEJ5rzGuT+tYZXbsXfB5DAMIdS+KZNLwTYHQeG+GqulsQa/s9KgyDRoHOQsdGdeZnp/rb0aocS7SDQZIWqy0ANhONQ0Pzmp6LnCk40Q1RUUwumDRcWkJW93acJ4NI7TjBDgqPISqydTIUft7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:25 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 01/17] iommufd: Move isolated msi enforcement to iommufd_device_bind()
Date:   Tue, 11 Apr 2023 13:43:02 -0300
Message-Id: <1-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4783e8-8799-4845-7adf-08db3aabde5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ww7sNjYsWJAXgwPq3hKAGv26ucLSsAB9DEojf2yAT1yO5WirMlMQ6Rst0vd4QAIpnGP5snO/Nx/qqsIp7vU14+IJJOAwo52+9b4frWg0OT+kXS9b1eDC1YGt0osau6uSMZS60UeIGweOfu3lRrH+3q6pNrtFTA2ZXiWslwJxADVyQvejDLyaeG7IPJkkD1YrtS815SF0G+Vjo5wYCWi8FvfOE1pX7eNQcJyHsuoPwaQSUmVBTNVK7jctb3nSbDcEIwLBcfNDVL+AkffCoCs3bd6eQk/1EoYpJugEGSun/3l5Yk19x2d0oNqaMNvUEuay7L+X1Gy7y+RIZLBhHZkDq9u82Hklv6qMGIQNJp09UZE5YM79DGK1ZTQverGcjwR0t0Yvl5/t4+kqRtJgb/3a1sjNPVlWcxpgAnbnP6evsZTySV7e2IKX55VekPJVNUTd8drOGrfHRCPdNzbVUFEDbt2Rg6Udq9v04rC0VXzaEpSmqAqXQ6EgjMrsyG1lHpCVO48oBXe/9Wivl1Cyu3b8KjUn1KZL/9QJiC6foLIwP5sqmuqFI7Hk7Coh7HnbcR/fziUAkyyVu3V/0OSAJ6+0Yvq2BiglmrOThQ2+CHXpZl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BRjjHt/QL0f6393QS7KLrtbWj5eI+6JDWwCsy9in/VTZA2ar+NrB/GUrPi81?=
 =?us-ascii?Q?xMZDbAo0DRDi/BapEh58AhshkUFnbpk/IuxzeyS670hzHTVmWPWfXDlaFGTf?=
 =?us-ascii?Q?u8voeqHDlEiytwgdRz0pGYJj6sVJVA4tKSPsBfekdF4ExadT/Nh927gF/0CM?=
 =?us-ascii?Q?eY0uAWbo9lK/xk8YBm1l6qSQI7A7fYBbXDxpVVg+OG5aucxtW8xvTv5I4l7o?=
 =?us-ascii?Q?VZ6SnLHchTGp+zBbzuJknarS9Y05qmzi7/WPZ75+g+IdR8szVL0/vStC1XIY?=
 =?us-ascii?Q?4gi4L0g03LnvAf8ZoWQlZLEOoLha+9NdjFFhI6GKDQFbZrWmYSU3zy13Xm1i?=
 =?us-ascii?Q?eUp7yrJA6yjJT6rCpjKiv5DDLo/26TLiCBuEuQ1htCbKtcN522aBguBwdLRU?=
 =?us-ascii?Q?3S1lwh8M+7+SPHGignXQXRVuYPHbPJ9XrummcHKrf+8p58J78bziyLxoNRu9?=
 =?us-ascii?Q?QdWYKV2IH7+8KKpLH7M/LHV1c1/Cge+++6zYsvGg7Ygo/pdXs0xD143BobpY?=
 =?us-ascii?Q?Dhz8jwOSoygyFiybheaNiS3WDFZpE8CErKnZEJxFCeNmvjfXmGIns63l7Yfu?=
 =?us-ascii?Q?pG3ETvz8hJsWHATkb6kxK8C9qC0PdxTESD/I2PhdepH22eIs4UqSmj1hM1le?=
 =?us-ascii?Q?522zujYG3BXPomdpCmn3Ea5FzVAhR0BSrZj3tLhWWMzBXEDbJg6twQsJxoce?=
 =?us-ascii?Q?FnbJOr9QDb49cOA9+YinL28qC9izaL4W3LKvzPL0N72zcphNAKdmFyxbxTtB?=
 =?us-ascii?Q?UW6/JU41aDA154dtF/DKmR20mEvjpJBlABmArAkvtkJPuzV1yLCJ90fE7D0R?=
 =?us-ascii?Q?zSOSGpARYYsZPHhcckOujfC7afV794aTLMdj1AbG4S2FSMtPFkR6maeMlc6e?=
 =?us-ascii?Q?9eFGPSyOP5GbuV5oqTj896ZweD1BwIhXkrZLJ8RChr5a/Mn2AEEsqld3D0lZ?=
 =?us-ascii?Q?NPbNRvNXpqpJFCY6YPDyafHxjSN6B5h2OE2GG8Kbll0HgSXTP4q0QT3askp+?=
 =?us-ascii?Q?Fwks8wXiOC6yFnhmN9Dlrz6DR0I15l8KPQtcgK4S6r1ByXUA7eCVDKzttA2o?=
 =?us-ascii?Q?z3HQ+Q+gnz//6LH9Uah0/ukrVqpCcTMQ5WeP0OmiAUkTd1mPYWdPXRXTeA+H?=
 =?us-ascii?Q?gLM4x8MzZnmMZsTu0f15JnvT1a9anaZexnbNdc4N9w4MhU65EgH3voxRL0uh?=
 =?us-ascii?Q?EylaIVNfkInChMmc2hlwtPMA/FKrY1M5KAXvyYPWxnwdykeDy9vA4aHvAeOF?=
 =?us-ascii?Q?dH4HpQsndWXSvKxePc9OHM4tkseLaamZWIiAhepPhDCY1kSorUmnC57HuW9T?=
 =?us-ascii?Q?HZrfKzvqHgzW4qBKBsw69IgCUBNfOl1Uqd7H8GKPCAoTcldfjSkCbbZSj+oE?=
 =?us-ascii?Q?HI7CsIkVDCvXIBJy1s8LTYq95GNt93GN7LFedNZfZGz90Xnha24PmICnvxh+?=
 =?us-ascii?Q?QagH+b46xCsyZzECdE0g6S8E5bpsKO7CPZ6OlauB+KyWlM+avR76hpLgaBzj?=
 =?us-ascii?Q?qAmRQyQg433ww4aThNBBhj5GZC+3vfHhoDe+cnf2vDpRBnOdf8vSjS3gAYKX?=
 =?us-ascii?Q?Q/26N5T/IBFfKb6sXOE+tT0Ac755B3nyw06cbqEo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4783e8-8799-4845-7adf-08db3aabde5e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:24.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeOTJ9QCB+9pxdnhf35+DrFD19YAGFvaKICsRiC73ETuEdflE7Q3p1xphTMpUdQK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With the recent rework this no longer needs to be done at domain
attachment time, we know if the device is usable by iommufd when we bind
it.

The value of msi_device_has_isolated_msi() is not allowed to change while
a driver is bound.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 38 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index c6f4852a8a0c08..e66303c17c894c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -60,6 +60,26 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
+	/*
+	 * For historical compat with VFIO the insecure interrupt path is
+	 * allowed if the module parameter is set. Secure/Isolated means that a
+	 * MemWr operation from the device (eg a simple DMA) cannot trigger an
+	 * interrupt outside this iommufd context.
+	 */
+	if (!iommufd_selftest_is_mock_dev(dev) &&
+	    !iommu_group_has_isolated_msi(group)) {
+		if (!allow_unsafe_interrupts) {
+			rc = -EPERM;
+			goto out_group_put;
+		}
+
+		dev_warn(
+			dev,
+			"MSI interrupts are not secure, they cannot be isolated by the platform. "
+			"Check that platform features like interrupt remapping are enabled. "
+			"Use the \"allow_unsafe_interrupts\" module parameter to override\n");
+	}
+
 	rc = iommu_device_claim_dma_owner(dev, ictx);
 	if (rc)
 		goto out_group_put;
@@ -146,24 +166,6 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 		 */
 		hwpt->msi_cookie = true;
 	}
-
-	/*
-	 * For historical compat with VFIO the insecure interrupt path is
-	 * allowed if the module parameter is set. Insecure means that a MemWr
-	 * operation from the device (eg a simple DMA) cannot trigger an
-	 * interrupt outside this iommufd context.
-	 */
-	if (!iommufd_selftest_is_mock_dev(idev->dev) &&
-	    !iommu_group_has_isolated_msi(idev->group)) {
-		if (!allow_unsafe_interrupts)
-			return -EPERM;
-
-		dev_warn(
-			idev->dev,
-			"MSI interrupts are not secure, they cannot be isolated by the platform. "
-			"Check that platform features like interrupt remapping are enabled. "
-			"Use the \"allow_unsafe_interrupts\" module parameter to override\n");
-	}
 	return 0;
 }
 
-- 
2.40.0

