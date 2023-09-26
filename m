Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0317AF061
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjIZQNz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIZQNy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 12:13:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C3EB;
        Tue, 26 Sep 2023 09:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFVNI1rMc/K1OOA2R0qxxVkFUU+rl+9LKyjJz0FWGiWbnRsyXi8u73MpTm6LUSembX8YZQmqOD7M5oFVSVqkldbUwAO1fomek/8O9bUGY4fggfAm7KCBA6w6qDoK2cB0CfxkwMiF6eNqSDHmJSPl6waPcTmQ074K+jmLkHFwKltbAqKLhyYJAF29EPg8jEvGCY0sZ99xaw9l0C4HFgUczOd95xkuJ7vh79DbywFxElw3vhT0yaDDeI9S7ss60fi5ZkjDy3VkHfiRm+I9n8ECI9K9hjroOb8adJ6bmj07HMqlYy/kjxBPNfXbfTgp0O8XFFKPQgtCqAXmS8nL4mK5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSCjZBLem3IrCqFWjhyve3601El6yjrhpUE5iuoY5O0=;
 b=K0mldtTesbc5mciXk4YVIPJzcelSxG2vuvSMS+aozeWK0YWQgeHtwaLAHSgVXiCHP3I0of6F7brz4unAzYJ+OLFnhGgY1rBlNO/idw5ZOGbrYBhM3AWHxdtp8XwKw+4deQeDPRDl14mvsd1uK7eBTGGZMr1b7kMfErLa2gh4i59MObGu8W2thabqRpOfj1k3H/f5NFxexnpoRRllOpI73nhE6RPpkn2S1HpCOPAj/pIs0KWbEcrJIsHMr4wPLA1l1xABtqXU7Y/9P5Kl7AVrULZDsftn7Nc4OaQYeprDqiqu6KmYlNckefK9X06jKSk5/J0BN00SXgoM6wzJvffQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSCjZBLem3IrCqFWjhyve3601El6yjrhpUE5iuoY5O0=;
 b=EsY9a+nIKxQq5rXG1ra3mwQs0OBrQKIibxLLfB03FQs8CXCA2LanQnq/X6qqx2ctseE6QAs49Ws/G/IED+HP8GV0JOgi6iCNkZ2mGdTMAm1vjEpcBmD1hwVkyYYRXJskQ84RBFLZU/FZCv2x+7sTtJ2kags7LIUqQha9F5QmR7MpviP4HhPiRL7PyjIj1ThD9ps7K5YZMMo5Rk538LBbQEaKmVumQRTEi1oUn/1J3wt+osiOHONZxsCRgSR5QzopvCN5d3Cgg2E8Lg0DwHXNT+eZLwWi4mKgYNNuwWIJ6KScU+Z+jchofH6lSgIYW2ZwfxILLJRqcnlzGF7wz7aoJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 16:13:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 16:13:44 +0000
Date:   Tue, 26 Sep 2023 13:13:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, shuah@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest: Iterate idev_ids in mock_domain's
 alloc_hwpt test
Message-ID: <20230926161343.GP13733@nvidia.com>
References: <20230919011637.16483-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919011637.16483-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0347.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: de992d3e-9cf6-48be-95b1-08dbbeab8e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RM1samsTGxuMddoU5RbZc+nHEAlkqHG9NaW/LXgYFrrZSN1QipWeeJC2DyU4Gu+aVv+XVETozLimNuAQ3XJKQh2/IlHlZDXQmHYValb50fMlPWIOH+15zEJOCHjGkdBhX+s43woL0KHTWTlt1wb6eTB8VGCUixwYpNJeW92cN6db5mTyijPhbgQeGssSsekpjuH58rbWP8pdfMepyiOWwXjxdSSsJTMSrTx5fpySqx7lpTBysgJc4E6BaJuKOvkbEvH0JLY7NI9zZYLQJa4b2PuSeufEuncxHCAiOGoMP4pzcoN8b1Fdu34uM005+UIbiPAxCcQDFfqitp6sOAquz/1bioYrkC2CI/XIz5rx7l0grNurZVFPZAWiRFx7zZyKwCQklbVpRcLYWM54ALVpRTnIof0aN2S2n0to7AyE2vhXTR214xGlg4GqhJoCWBeicjiVoEPKRyhTJpXuZEDmC7Mf/w1RsdLYAE7JhnlFXx+tRtxFwTsV5lfCIGhFeZtkh7Zev4PpBHtRQprA5I6ZjhOrg2PlbZKbluEC3c/VG2ZDa1eui9d4WFCBGHTuTetp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(6486002)(478600001)(6512007)(86362001)(6506007)(38100700002)(36756003)(83380400001)(1076003)(2906002)(33656002)(2616005)(8936002)(5660300002)(4326008)(8676002)(26005)(4744005)(6862004)(66476007)(316002)(6636002)(66946007)(41300700001)(37006003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QIdpFyUe5DVTBRE3xbHTR62o2RH+Y8dlRfuNGeFJ2K+ZxzmAt8rEaGWiIO38?=
 =?us-ascii?Q?dLNayWjYeRBNLU2odlnU2u36+JwljeuHoux+eeYHFSB5hbxgJVmmubkxUpfR?=
 =?us-ascii?Q?ptRv8U0Gvp7kdmc2HNErjmjYiKnGqYUPHUV8yaUEMzS/rURIZJkjJLnrnfcA?=
 =?us-ascii?Q?touovWEGTVNshAd0UY+CDPD2dRzC83O2LyUd4p4/RPTxb3Kg8ocUQHaWpQPY?=
 =?us-ascii?Q?tV2lNUq2Phc7fdrjedY3ydYQrFwo0x0dU7/+N4fgKq/JS3G713kIoQzdA7em?=
 =?us-ascii?Q?jv37EmTB62YbPw/xXb0pCtbZEHrha08LDLB9ywBsDwCUiTy421uTQMGihjCS?=
 =?us-ascii?Q?NcoEtYNfk5TP/B0wZEDgshMD9vU7sy7fGHi0GYIefk9pCHw9hLNY/XBgquM4?=
 =?us-ascii?Q?3U6UzUsi8tkavWMIzEOKrOtMY2KuPbGHSqq82wqaXm+zzjCoN2hwW5yDR2Li?=
 =?us-ascii?Q?fYQ0SdnoSeQxTl67mOVW5+Dt7CFwuaNNGTTXAit5okr/Wys/WAiSzru0a6wl?=
 =?us-ascii?Q?uzEPh19261mfoeKZnVnU57MpmPdng4V6V8/v3AgLMpcscTMJtVEFTlW5ah3D?=
 =?us-ascii?Q?+wrmAdzgCy2jl6sbW1fUWiRp3v/sN/k3XD6YECGAt0JkzrKRO45BKQnRci3L?=
 =?us-ascii?Q?anBdygegxW2XMtqEvk0nzMIxvApKtTWh+uP9ErMZMpNrhvSaE8t44hTlyq2X?=
 =?us-ascii?Q?AzpMnYzGKa4cGUpgbhCnERFx5OAPUczTuDzhexgvMgZm4HvEn5GPIzmSzHdj?=
 =?us-ascii?Q?3wvm/zSaWqS5rj5Sic/n1IHi9ELWx4G354no0p2eAKbPuYbcQz1gpPZ2Fwp4?=
 =?us-ascii?Q?hCKhApPm601DIh/D0PPCdD9YCkJ+pNCMemyhPfBpuM4hS4CWL6onILNWQxG2?=
 =?us-ascii?Q?OPiSEAfqdHchaJMXImjntogQ5feuPpGhWaLJQHfmjtsysmXX11c62gC7pRQS?=
 =?us-ascii?Q?VJfp9zQuZqqcKv3x2q/nEqQL8/8OJB4dkX7ChecwDMC0fO7FrXJUk8yMl3ro?=
 =?us-ascii?Q?2vIX3L/zik1VeL5Rwzkjqaw1kyLPACCDQoqpZajSWIyBFjCFTUNc52nEPs2r?=
 =?us-ascii?Q?L1iv1s0oIx3x6qgqq/gVAKcGsUuh+KD9ZiZAGRlW28HE37NoVXDqa3NLwdnD?=
 =?us-ascii?Q?xy6TN3UJ8xzlnAqqXNKhis8//GbmzzfdFOYHH/t/IWonv6UzMlEtM6tv077L?=
 =?us-ascii?Q?ZPAMNdadflFpU+jPj7OShLsf2HSDLwcmoSfSmUtso1FgNQcfbObr2nuLpY8E?=
 =?us-ascii?Q?F8QeoWJMR+75JfIeRH01z7cc5kHnXdehsBfleYa5hRbn9dpn6ifi+S9fagGL?=
 =?us-ascii?Q?40lr9Zn9hnW3MzHMQMlPxS9tAMT+5OLawAAY7TZ58QaXUqbdpDbXtYpupGxN?=
 =?us-ascii?Q?GdGR+Rs6qmqPmBSw97MwRlHqeYdg14znVTd2j+Qs+e9tNMXd/HzyXIXYR7E/?=
 =?us-ascii?Q?XEHr95Xa5yVsdWZFm8W0kV40boGpoA6REeCLbSzhv07+cfQdhxe1QqleG3Hf?=
 =?us-ascii?Q?xVX80MJ/UD8lkexcm0LLbxjo/LSBuZHtoot8hZu4Tokzhv5ZvEHnKri1b7Rt?=
 =?us-ascii?Q?aGxx3fuLBzCVD6rvyL5ZWOKdF6CaTEzVeUDnsYc6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de992d3e-9cf6-48be-95b1-08dbbeab8e99
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:13:44.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TM04QFp+y8Vh81qozgJ+3t2CAbU2CffoW2GovWDcG+holwRCf7I12wde90gn9bgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 18, 2023 at 06:16:37PM -0700, Nicolin Chen wrote:
> The point in iterating variant->mock_domains is to test the idev_ids[0]
> and idev_ids[1]. So use it instead of keeping testing idev_ids[0] only.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Jason/Kevin, I formated the patch with "-U4" so it shows the "for" line.
> I didn't send it as a bug fix since it doesn't feel so critical that it
> should bother stable trees -- yet if there's a need, I'd resend. Thanks!
> 
>  tools/testing/selftests/iommu/iommufd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to iommufd for-next

Thanks,
Jason
