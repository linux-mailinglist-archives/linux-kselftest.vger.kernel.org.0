Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82D1756B98
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjGQSOo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjGQSO0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:14:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716599;
        Mon, 17 Jul 2023 11:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtLB6tKQn111eB3ojTAnJrMiun3Dlfl9gWRyW1hpfK2KytKt4SCd+busgEJvwn0oUpaeUbwV8omI6C7ssr7nIjUWSnC5n7xSBUeZ6UKMRp8bKJo3GcbrUh1ZW5Bj3c2UjGU3COhZSnCUA0K0A+8Qw/fbSeuPxirdQrfEeChOqHRM7pI8O5V+lnPHLUfj63pYp2xj6QJ6/6udb+I0XZOSuyl1T0OxMliBGgXwzsulCx5RiHcb6CJ6Z/Hm918B2GMMimsMxj3LrR5WecbJHXaGhqyWmouMJES6efZn87TtNCxjxAU9lCfjWyDAJv79Vd0DQ3VtlsfwS8v1Ulk2f4CsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN0qA8U2d8lz/z4AuOr5qtTlu7B18EIn4DYb4x0ocmY=;
 b=EF4wOeJwp42q+3Vx2F5MDm9VN1/EiNJIEBbdSYEayu7SDNhcLPUt7hAFZY2uuJTyJcDpMq58hbxfonwdcTgWaeAJGUWWBWINNsoqhJwKJUspZMcUl65ucsvmdxhP6XyVfsAShGeloGR0ebi1vprmIEpg3dbIRPHm8BZUzISHcQcYo5XVgem4t40wbd2/ifR6z/7j5uLcXvVPe9KH0ZvzFQyXlUrvtfKbfZSBowWi6HQHSOCvV58JVrI6ZurZZGnRlxzkGJcksIsQ7tBOZgRPDlAwhzOAVg/c5NK25nnaiBG/PGar1E8M7cLNee4yw42Hadd7k022/PmKqS8DfglUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN0qA8U2d8lz/z4AuOr5qtTlu7B18EIn4DYb4x0ocmY=;
 b=kBBfdLp+4e/BK7wWu1G7XYCh6XWKtjEpMKJ4rTD9ifIEKK14aTl8oLg1dfPVGBtyOLRl0ufvx3YOdkkfUj66HHZ2Z4rLHsv9DG71T3pFKeROWcg/K8vGBIiVKc3RtSFHWA0MN4fAcaYzF2MG9we0s+gMihSurruCEo3kuWEI8W4c5jl1QQnrcznRCmqkOh7GXKIjDe0ZT/4V4mWHE4NGSy9gI76Lux/w468kQEsoy5RgC4h3IodwVmuTmy4zAxjan/kULEKLsM0rwRLcu1/9lHZC2QrTuzmN6d3SCfl8QbnAT9niP1AKw5FavZwp/LmYbFyCqVgwltqNeuI6mY32dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 18:12:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:31 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 11/19] iommufd: Fix locking around hwpt allocation
Date:   Mon, 17 Jul 2023 15:12:07 -0300
Message-ID: <11-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f1616b-c71a-47e4-fdfa-08db86f15eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sA36YYBjwict1iu8Fs02TOJTnuajLi+6SPfqNsn2yg6HHnpJRVSF5MYAv4r5cakQMYO56rT3r9rJncrEudPwC3cVtmlWXrzjMI618OdOEKuOkV1Rpx8ykUn5kO+ZaUlehf+BxGw+5+dwp14zyX52lZS+IpXDYnqlAeh7XzBx4vjtMcgfmFQiwIOpi2ria076Zn0lva8MzYcf1KQ3alirP+Hw+sUa1UmZzPy/jhpsZ2ng1TarOHjPpBGTHr4AyMcAlvGqPbPDowyqb24BqBXlPIRL/4FeEi2du3ytZmW//+SCl6rGOqehQx39zxnGu8Ja1vC13erfkDqV0X5yhTj5VE6iD4KHvta+ATzpTFzvyGVMWn1w450QFP42MLySDVzABKYEAivKmAd9Ijl8740UYOp4xtb1js1kfat/FkV1KRbNHGfYz1Oz2F24MwR68shqUSAOhxjYLysxd1Xgl6jXA1GlRxKpNsXJxqt/i0SmjwsSvfIjrGmVTD5nwaaj+uWaLLZPP2182oEvvYlZ8sojiDRX0n/1u6kC8fUZ7tuCP25IvxMZ6R2TU9c+J9W9vk/M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(316002)(41300700001)(83380400001)(6512007)(186003)(2616005)(26005)(6506007)(6486002)(478600001)(54906003)(6666004)(4326008)(66946007)(66476007)(66556008)(38100700002)(86362001)(5660300002)(8676002)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CNGxoH1OnbTmeWWKqAerWTAK5AoQLfokMzDSnOHBWrFo6OXMZ6yz/HrE2LRT?=
 =?us-ascii?Q?unWXStIxFo8dJ7fvD/nYG+6395dKqiixLNkEnS0QUSlFEp5SFcVB6qxdDF7J?=
 =?us-ascii?Q?ABJzN30P7mahbuxUjonSZfWNiNX25b1ZAdUgoFiKkQ9JE+9rJk/RnXZ4XbiV?=
 =?us-ascii?Q?rhNfV1wnZ6KQ5kW6kvzOZv6/vTgR82e7reEEJrvRWqB2tHJT7ewCZaO1GPFH?=
 =?us-ascii?Q?XB0pV7vFtMN6KKHfi2F0UGnDXlrkShmsIFPIADeYh6/wfC9unQ1LbbiNm9UB?=
 =?us-ascii?Q?CN9LvnDBbFDjIVcM4X/OwqOoRLGDRl0MNvrMqhSib+rr+9sb+kSGP9k4DoVh?=
 =?us-ascii?Q?w+aG+A6skEFbbutoYRKBGsgffT2d2/aE3CyBkJfIDvkLdlGaOOYmtgvFgrdA?=
 =?us-ascii?Q?jM9xTlJDQCJfJyegEQ197ZOxTA3qJHxSHc7Ek9HS/RDuHH/tJdb1Em4bZTuC?=
 =?us-ascii?Q?LsCqozq8XSTeRxJgEWEMDlMUL/dzdBzb2zhY69UeavxEuu9ct/klNOfpXi1G?=
 =?us-ascii?Q?5WAl4SgNpnaiQBifvPvzmBEf2ZfYyjdJjyT12MTklGIYct6wxXgjXvL/LjMe?=
 =?us-ascii?Q?ma4yh7UT4tfLkqID+VBLNoxSecqMd8Z37yibLbKCphyLm/OAas8tbhh17zBs?=
 =?us-ascii?Q?r5hazDNKlKKgLTX7RAZvTkm4LAlXF1JqDtRCyCUxeTFNy4RMPPORFNgfO/qA?=
 =?us-ascii?Q?5pusEaxFkXDeJ/ifeW1f77YOqxWDa6zE4eUib/RXe3wEZZVYdnnZotYoLKiy?=
 =?us-ascii?Q?8sPFAK5ZmQT3qLYxyAlAeJPwuGItM/F4Mf/N+5jOSTvyHFBM+sAcDDYI0CdT?=
 =?us-ascii?Q?iHE8jDZNDs0xZbABIrNVefW0hvgjStUEMp1WJYvkCRHUYqEkdxaP229mBGYx?=
 =?us-ascii?Q?opiyMVyxrqGDcjaOFqxink5YzSXazsvN5o4RPVA5RoX63SWZe/1I9C63AswW?=
 =?us-ascii?Q?yU2R6qoeqZPw144Mbz/VUlBB4AflGCyFZMvjep5sS2AT/3AfFPOqJgfNiPaW?=
 =?us-ascii?Q?FBsqwnuoqEqlvUe9ixM7wb1tWNJ2dkSKQG+Hmsc324b0wUd0DupY5FZTeErD?=
 =?us-ascii?Q?J0cgwHdajhhqG3mYRc1NQYcTrskvpUR/HblVDLBSw3qXmOyJWb4hS4KCeEfh?=
 =?us-ascii?Q?7NdoTuGtOYlM9T35ITGSK1Fwm4ZndGlnCwmHsM17io64hW6wnPxYyYrBaLJm?=
 =?us-ascii?Q?b0NzlfFLvZtE05Ify5s1lOpXc5llg+usMIy0fekcN33aGZ6GbDaSkSlcP16E?=
 =?us-ascii?Q?UHnkozoGe+x03mhjxxdg4PNPjH4m3183/DsklhTSWfeNzTBvaAWCxfW8B3wh?=
 =?us-ascii?Q?78CRuxQYKJu6dITaeHvs9lE5EjaEmc8j1nReqy0/wFP3fpInAXbSiqkqMX46?=
 =?us-ascii?Q?0FHxMelYywqAOmoCs1oVl5qgsdISzfyl52p2KbQal6iqMmH1nLdxmDxQaHgw?=
 =?us-ascii?Q?D0PjqjEek6tsBRwwJBCEuowAeJ/YHGuVH28oKOsKxWl5QWNbQvREYGrWH6fe?=
 =?us-ascii?Q?pyO22Q8YeRD67R6BsuPcrekssVu0W7vJE/AYr1bsBFRvrwKwWaH7H2Uosoyo?=
 =?us-ascii?Q?ArxNK6e8lDhancKICBHIE75BYoE6YuXmOxqKOfOR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f1616b-c71a-47e4-fdfa-08db86f15eb7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:23.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IpzMN4DjvfLfcK6csWTuB0jhBqfFQsV69wg319PEsviLe9zf9o2dag3GeJhiNxi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Due to the auto_domains mechanism the ioas->mutex must be held until
the hwpt is completely setup by iommufd_object_abort_and_destroy() or
iommufd_object_finalize().

This prevents a concurrent iommufd_device_auto_get_domain() from seeing
an incompletely initialized object through the ioas->hwpt_list.

To make this more consistent move the unlock until after finalize.

Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for physical devices")
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d41e34d1b778dd..f2b34c56d01216 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -398,8 +398,8 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt->auto_domain = true;
 	*pt_id = hwpt->obj.id;
 
-	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
+	mutex_unlock(&ioas->mutex);
 	return 0;
 out_unlock:
 	mutex_unlock(&ioas->mutex);
-- 
2.41.0

