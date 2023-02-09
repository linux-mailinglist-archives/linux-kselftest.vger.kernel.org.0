Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69BD6909C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 14:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBINXM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 08:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBINXL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 08:23:11 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5C5357D;
        Thu,  9 Feb 2023 05:23:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL0J+4QLdoYer2Ql/jZtdf4ft1AxiY5tZjhLS7XdEB3MbhfPUSfURPxoOezn8WgB9h99XcHtsJKG8J58UnQp+365Hiw1niIjqGdwo1PqYgIAcM4EIKwRMN9+lBReWOQAIspVPwECwOoS/M/EjNqsavvSkpR5cxljUYY1kHzHTF1DP0xqETVCTpaKuAeqwDAE7dY5sk5bu/5gTx77UziwMA7XP5qN+O8quZX2b++63JfXP6t5e4Za+vUI/brMkzClmDFgSep2CuS+WDT4HfLA1M74MvXjz8NoQL2W24YB+XO/x4FfWszaN2gzj5PuqqzytM4j2Ka9zP7mNCJhxjgnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or3K9+ad53rBtPnYf/rEpiOaIg0ZkNVZlMGkNCyttp8=;
 b=QoAbHaOVVrtGL+jYQK2p5QgAcUkdsSsoiWh1rQBmErjpNf35+2rIb7q/+rXdk3ADjVckDl4S3XjaNetmbyh2yf4vbNnjhrbmRAQoa3/b+wXa4osW6nUFttRsjr2cFAZFZJlqGmRoqC8qONDakTvFgZ+w97k+2gwb8s2B+OaR51i1VE1fmokAsh9B54Nfe0YUPHw7/rO62Bniw1gEU5G1zbAlJGQOodlCDELzGxgxy6fqR2fmuqd2K87RkWEKmpKnT9CNtVioORsEFJALf35uRy4FZaEUgUT1u8QcgKjvzgqkeSKWP9ABPOa3Y/NRsQZ3DMs0PGxR/KVjrXR6HYv/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or3K9+ad53rBtPnYf/rEpiOaIg0ZkNVZlMGkNCyttp8=;
 b=Kdii+P16NZh22kTsJllFXChWTgK32uATnuOO4L94moc3D/J2EBGowmOQxFbhwNKlT0LihT2y44d5l73IvmOlJBop/OF+AYhEG2CTdCHxvVcqYgm6g4Lz3Z/By6NW8BbFQ5x948uxowm2WcGXw0WBiLtPvqiCJT1mT7DUEcXSuB5tyOV+OLCjN8CG04xrTzvCtpScXHomGWrrNl8lSNGZhD9OutHH8sk77eUiuknjhtSj1q9wMGgVR8FXHOUYVVMrv2B3BOx/RnDX6DQWeGTLDrSyYS4M69kSZMuGYb9H1OIZlmY/jUE+SLzQj+hjn7xZT1qJBMEIJ9Xko8KEotgrgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 13:23:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 13:23:04 +0000
Date:   Thu, 9 Feb 2023 09:23:03 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y+Tzt0p+hDz0QMfH@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276859C11057878722F30988CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276859C11057878722F30988CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:208:2be::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f49086-a943-4433-28e3-08db0aa0c6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70Uml7+ivJfDad4cQ+cNXZj275n59cE02NFhhuyyAO0JG+xckg68UnsskrW1Cgik20eWoj5yaB+ddF0gMPraCUn4p8mB5/wrem+8EKrOg+fFqVFcQJeXCbsCcGiCWW0gsPCxozBdsV26bzitG51zrH5F0Sp+dp1yVCRKJe+4AbryJ0uTp+Rljl3Yuu+sxdantJcuyDAX+Couah98+aP8m8RDhG48QCEpHHejITIrwLMT6jAyQMsrTmWqIdll2fW1Bf8Ht+p20/O1i/tluCbo9oJ05FizkXLey+kVoOaxEU8jaXKI7p/g4gixv1oMTWxmwM4Dp0cuvmRpGPa3HXv4a5w56v6do0/pkQuUC+W1N8S8A5AI6xjr7UF3JkwqJZh3qYnLwHTvGGwOTh3pNssmchRyqdA66OrGyCX0zG1Ami2074eeOM8UScxb70YIyN/c2UvL/wOPXehnAiPdn0apZFD7K9yqVEheBMwmzHTSAdqJMMQiMqs83R7q0J/06Xu4BxV3eBdGSrLp839SQI8LTLTPaQByPqxWgysuW6JkYedKwDtcxL8QRsKDS1kCy3MWIVAxF+eBEo9pev5fo8+K7Ottac5+szOHo7Lkalf5yUnGEtCTDRJmXRg9LLmM44Su984aN8khU68dXBitUzTOLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199018)(54906003)(86362001)(26005)(186003)(6512007)(36756003)(2616005)(66556008)(7416002)(5660300002)(4326008)(6916009)(8676002)(8936002)(478600001)(41300700001)(66946007)(66476007)(4744005)(6486002)(6506007)(2906002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ZL8HR96FBqqNF5fj1DNX99Bf+d8XYJwjYLupf3bb6EZ8cjHqymvjw9hyz2n?=
 =?us-ascii?Q?x7Z0y+WzIwe13Es/awJQH9c9hyOx72uLxsHKuSdLbbttGezehDS7X0MzoZ2G?=
 =?us-ascii?Q?zvP1opyfEpP7EIDbuMzv22shg539QhQamyL7Y1vumOKEA7FQTZnTLOzYBvA8?=
 =?us-ascii?Q?tM0bxTX5wOFbnkw6Y5agD/hPPOqeTA8ej3DQ99DADoYh9SVxtZqgwx/b+eaM?=
 =?us-ascii?Q?G80cheO8ThnMHrvz/xYrhIjrvcKRcVdOtSkZpwTQ0iGy9+lIgOt8P37Q4a0c?=
 =?us-ascii?Q?M1XniDnZbVuGHAre522/mD7vlxoD5+zQWk9sXzkQZQpvQF0JD01xwSKJvFVx?=
 =?us-ascii?Q?OcuMnZeI7G6YsEcK2AdvXbqn1ig4ycGCf8aQBDmN2lJeYooU/G1O6qhWtYeI?=
 =?us-ascii?Q?KaJkUSaQKgqC84NNKVrXiKTk/ZJAte1dzY9cacGdJYnNKmZcEMdchQhmmkDM?=
 =?us-ascii?Q?g/yeCfppIM3OVzkNAxYT6GsIayqOB4wlrB4P6mnz+UUZxgAhZoqxuOAETo4H?=
 =?us-ascii?Q?elkzl12XY6/DXhfwlbBLvuvmql1Zaq5Sm2fu6Q1Azo5QcuyA8V0K1kQBlbIy?=
 =?us-ascii?Q?Is2HdkS1az6PxRSBcyTa6rf7bg4VMQ8yyuuhOtVmt74evDcOLFKAD93yt+BN?=
 =?us-ascii?Q?AuM3ONyoBMh3NDi+cBLihteieW4VLrt/xZe1DNRG0zEUG5Lwq45jB1Dts07G?=
 =?us-ascii?Q?xdcetFPuc0hslf9I696U6maaW9r+9CKc4zTAq+9A5WAGPzXXnymkQpSgxT4D?=
 =?us-ascii?Q?kCviH3J/1QsKUgpH9oLeV9nThWtPxUJEwLmdIZ3OH7JrbX0RtN+CXLeOjcAx?=
 =?us-ascii?Q?Hy7LPtVS3RyXS4kTmYjX26uVk/8ujIc2PDRIJyuI1XJ3ELhnr1RQb8iP4wwT?=
 =?us-ascii?Q?dgUzXZJ/7Y2oy1BTzR7J6bWn8lk6xxSeDhf393giEXW+M6tnZU8QlZCiob57?=
 =?us-ascii?Q?sPINddfQiPBzqMPaIVJ+eNEgrB0gWT/Bf5QH/mWtLYF+2RhjnSlkVRkwVHCz?=
 =?us-ascii?Q?DRLfz0bV2zP1IR8MUKVKcVm9+vnfuUOt7SfDolIIH4O5NYgsV7wTJ6528Hxm?=
 =?us-ascii?Q?QqyHJVmI89cQ6279FZrkCpPd+wKo1dzw98N563B4G8elSad5xJWMW4brD50o?=
 =?us-ascii?Q?C7y1eaY7GYs+6VFZVPwqEYrP4ORHkhcoQVdRYxaYdR5rbvJzrjo22EFWrK/y?=
 =?us-ascii?Q?/CTQvxVOfnwxb1H9uBUDGf9YkXha/0jJA3iW4/qIFHdxcmvuZvvTVfQkYotf?=
 =?us-ascii?Q?wKgaXa9iqUJHyYbxfDYI+SGA9B5CBU01FAUYQQklLU+L4LqCTY4AEfn9Nd0Q?=
 =?us-ascii?Q?l2U26mVMigCnEHK+Atc0yeDCBLS5Wwr0gENlutUJRiSn1t9CEP8D5ZbULsAr?=
 =?us-ascii?Q?wP+bel5u817SRYD09wslNqcZB+yKoeEHSEEjPSNFYObrlPfer5MUINmxpWk0?=
 =?us-ascii?Q?5COlZUgEpaeX4NxADiz/dzXmGiNvr0spT0lq2/JkPecRXRzGxwEG97b5znCD?=
 =?us-ascii?Q?nrjxHX/fKsQ7Nj00d7JeX/nrHIhhUeV1bKp6yUHAF6ktnPrySg41aTTXQL8a?=
 =?us-ascii?Q?fRV7/elTOAXNh0CwUq+D0SytjWSuOLD0Mg06qljM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f49086-a943-4433-28e3-08db0aa0c6a8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 13:23:04.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iN1jHQ769BN7Y2fCR3ua+/HKbbtWXOhxYMsqYeWQPTvMfSro5K0U94YH/lK7X2Yp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 02:55:24AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, February 8, 2023 5:18 AM
> > 
> > +int iommu_group_replace_domain(struct iommu_group *group,
> > +			       struct iommu_domain *new_domain)
> > +{
> > +	int ret;
> > +
> > +	if (!new_domain)
> > +		return -EINVAL;
> 
> Is there value of allowing NULL new domain so this plays like
> iommu_detach_group() then iommufd only needs call one
> function in both attach/detach path?

We've used NULL to mean the 'platform domain' in the iommu core code
in a few places, I'd prefer to avoid overloading NULL.

IMHO it doesn't help iommufd to substitute detach with replace.

Jason
