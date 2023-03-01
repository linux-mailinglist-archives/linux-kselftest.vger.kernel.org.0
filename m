Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCC6A7449
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCATai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCATag (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99CD7ED6
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jykKS8Pi91JpxLE2PibsQx9kIHhOUPyMQxZOlk9GnNizjSTlrjZAxnm5D4sCvefStOwWSs8JAvmTfY9sPXVuiQnOvFO9sITo2irI79plfKjf2MylbvNQ5eXW1dRozCrX750fbZh3xIplTNsRdtOedT6N3fhplIKJeXomPXoIMNyja9E1L4NS6dCRxxt7Q+jm9jq4zPYqoo+hwA8jixVLC9KBt4fSP/NMKFFxfTj3XWEyppt/D5iFBpT4TGUaYFgGHIEq6sOiFbuuILplTU8VNV3eaDpggIPV3+E5NvFMiY4kjhuH1yadRUYqBaIO321XAORQng2WIavaqv/cCoZt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J33EM8niFVAHF+/EU7iJ4w/x8NWYIsaXnpTM1TNRbgU=;
 b=GGmHj2aV0Gt+QRM8iIz1DtOPh44kvs5+kOiVXX3Gmq+yrWxt0FLAEUMexDQ1rHehU9pfpABIVgkN23q3myLPZ/droLtROk9QlifOWcB97yqT3SfpRcNG3j0ett8TK+cbK9jjZIdeyCNj3jiuzO6u0U3kGCrIAyJVZ+i3Rkaaio+r/S3Coi8OvGkyka4wrvhilxLIbsIhrhERQjahkFl/44MvqQ7umRpwd/X5lzAOnikn5uNta/NoJ3T41Xt2Y4h/OLLPfAn6ywxn5LtNHARwrALnfbVGJNQ1hETmhW3ZGK3R1ALpAVzgLX+0bgzKcLdsxLgK8Qj2A/OgVbKKFa8HHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J33EM8niFVAHF+/EU7iJ4w/x8NWYIsaXnpTM1TNRbgU=;
 b=khnpYJX+6P5AtpK5hdni9gGZmoehjOawKAVN0ktfDJUFgItxdBCQ61+VbiLb75hSp8gcw1VKKirIKt8PxO3ZkjE08XBygWbqOL/F/m5uXayEtBA6gY6KPjPeZ+zHQqlYNzkq17sE6AUaWqq1xu+SbI4nyaFE5PC9FuUHntTjKYM2ZU5gu8MsyzjQzQuRgjXYJhSIf+jxNeBbJZhl5WUlBkUtcoXnFdMshE6UXM7JhfLXtGyF3T05LpkF5pwmuRSyd9lwxFKCVaCIbRLgVxF6cEYHECg9FXQlplRkEZJ+VS3Pzu4NH8bGbaRn7aJPPks+LBVnqdhJ8WwJcuhgX8MUIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:33 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 01/12] iommufd: Assert devices_lock for iommufd_hw_pagetable_has_group()
Date:   Wed,  1 Mar 2023 15:30:18 -0400
Message-Id: <1-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 4983240f-97b9-4fe9-15b6-08db1a8b6b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: leMzWlQuOdaU8NnuXAODX8KKGKLxDd0/60Ygzs71bX+zT50PXx41W6pijIdw8kRGdHBlXyIJKzbc01fO8fdMktU08lzxfirmiYe4I3Gikl3yxzNKc2+8kmCQ6z/fqpbeYCCdftfU6gXqLQiLqlVJjaNOLEDV2vwBvr9FQT+Ln1wBbao/lZSR7PF/gP9DTsL3VII//uxVz4Sxg0wAeQEr1t+5YzNPYbXKubukIL19M0YUjRqriL5/uI6MLzrmS+McrHFvt18HdCWj+KcpGDBPdaV4hPihT0bX9tHymuBcz/Oa/e7Lb7VoES2duj/Ez6bJ6bh1R/DQWaigtMbk187ozZLxVg8l6wHYZNVz0F8UgTfQFsVkVRuEOtIstUqf7Uo/t8wBAVhD5585vTZb50G2GmcSbdw4ppkMzZjcDvmSO3Y5PQgfQiDeJZtSrsbXcXDfQ0fc4LBiH/v3UHtq1LorAlegfsyPppj4qJKoR/1eFe3fQjQlqlMJBzHhYgVw/Dm2Kl1ba78vPOf+r/dDyGgSn+emv63FBEN1hGq0xwCbYv1pP+6AXk9FjNz+OHqDzM9KR1krgWz3++d4gm6ssUfXQhuMnvBZP68CM56UTp7+zR/O/CAEvF/d6iUX7FwOnVd34hgBNd3OfrE1yf0th77uFFyEAZeOX2FJjnXdz++WlrJGtkGpTZMJ4UzVNxdeX9qJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(4744005)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?11QWcVn+2WgzwRz6E2aAjVsqjldF125QlV1W/UDHJ/U9xSR5FoU6nDFvX1+S?=
 =?us-ascii?Q?Tg86rbqjtDUxChHfc4JbKu8+BeATcGhtED2YWVPDk/mDhMXQs7zjEJ/4qn9N?=
 =?us-ascii?Q?jYqpEzxqB0EAfxfFP671Qt4DCHIfJWu3FHXoQNt/fdvuOMVmzoNQWzupPqY1?=
 =?us-ascii?Q?uN3/siSsptKykEX4M5Cyv4/PG7t8THvnY2YHG2FwBvxY/qeMnHbGeYedyT6y?=
 =?us-ascii?Q?ge/8gksSwIOcbLnaJuwyVpnCOvS/OjipxQK0kn9XAerViG2T83/patMhPHMx?=
 =?us-ascii?Q?OiNPmsLX0a/aHsxrbSgDqYxg2rY7HqXnbMWQ8WNa1GI0YP/i59lmXN+DB1ZI?=
 =?us-ascii?Q?ifTed+fcmxbGpFWiWMjgkAsXv8pEvC2OsOsR2TPmmAIGS1DwGDAelmAQNCvq?=
 =?us-ascii?Q?EkpjMvwdy3U/56jvx5XqIZ6F+3B15ElxaR9giGLWMZiRe/Llh1ztS0Q3qwMD?=
 =?us-ascii?Q?hunBzl/Q9NV3BoLAkzImw8CNSDvAhvInplFRUbdCmTCz9lAtP00Gjofvwrej?=
 =?us-ascii?Q?3xMpENqzDlAOyEaqTgR2xEGNXbTRgUEZie1jvgTsn1qd35dY5sL0gXeQe1kN?=
 =?us-ascii?Q?wzcjEA3rbThg5uy4kEW2LpK4ERJhucU0ukOtZJjwUuPTZYDeU26F7UY1PVxG?=
 =?us-ascii?Q?t/fDy7g4ZnQsP5+LRJgZljGtHKsxHz6RYAkmSZ2KpjqoyHY+giGsXidRpJT2?=
 =?us-ascii?Q?THOwu2g7jQRU1CIpHAFQmZcYqaSEoodsbqx8TtOy9DTRQmHirQ7BdM/ZjP3u?=
 =?us-ascii?Q?1cwjbt1BLP1rrwTk7D4HVL35jO4BrBwQ1Xn+JQVu1WLFZae++0wp0s7XQA1T?=
 =?us-ascii?Q?PxDcY/VBzGbHmmfUgFXh0EYU0rTEONFiH1UiDyKm+um8vSqFhJCqPCf+pg1S?=
 =?us-ascii?Q?k1AlwFm94DNpGtt6LgYhjElCB0n7+/RVEn1YqeeKQyLHxWFELuVn+9igpGBI?=
 =?us-ascii?Q?HRylU1/nP2J8lAF5zo5br9zpL1uAutj3Cjg+bs4tjyntPG5KNMTPSnq6aJJs?=
 =?us-ascii?Q?jf4wyPqYNv5svP+EnaAom84h7CelvenSVZFBup2sIZXDmOgI4XNIfHCP7yf/?=
 =?us-ascii?Q?jQHgvALkSXD57N6Q2xsV88dC3n3yQu4ccTjmbXIrHX2gwLxCUfS4U6r0v2vI?=
 =?us-ascii?Q?SAu38+3XFX7WoAo0Yc+7bUkeX44Um79PndcF9CWRi/yDO1r2taLtRSw3D8ct?=
 =?us-ascii?Q?nnjSgh6UkRWSlv6XT9BBgRw22Q6Tz0/PiCGJpDlNE6orRZ0LxgNhU5FnUk6R?=
 =?us-ascii?Q?yr+S7UuQs5Q4qYOURPh6GxhYjAIUZshVEIdIdj+tm/4/SSm7EQSqjMOMbpMB?=
 =?us-ascii?Q?Nb05Nab5IQbZeQj7xdSOrYmiPp8nGXJdHoBLVVvMlFhRuvjuQZy/crfZXNLC?=
 =?us-ascii?Q?J507EDcDh4u/kd4FbQ5k0pkOk7w1vXIa5J1OgsRKiny5XjhUJD/OK3yLowjx?=
 =?us-ascii?Q?PWB/0uHum2bmeGCnZD/bU+TccUI7bvf8m3YOdPJZdR+RQZK+pwL9iy4wU96N?=
 =?us-ascii?Q?uaxuCyBQw5/Uhpm97zQdySYHRZm6Cjq7OvzBxLmvf1lURB5F9xiuVEnM/guv?=
 =?us-ascii?Q?qjns4SdX4ZeQljB/LO9cOI5IFWSG0sl1lh17ypln?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4983240f-97b9-4fe9-15b6-08db1a8b6b85
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:31.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hXNtyotZXL0U8YMggA6BAVCyYLsn9mUCrrVRfgv7lgm9ZY1C/GdmGXzB3o8a8Mw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The hwpt->devices list is locked by this, make it clearer.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a0c66f47a65ada..dcfaf6567420e0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -186,6 +186,8 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_device *cur_dev;
 
+	lockdep_assert_held(&hwpt->devices_lock);
+
 	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
 		if (cur_dev->group == group)
 			return true;
-- 
2.39.2

