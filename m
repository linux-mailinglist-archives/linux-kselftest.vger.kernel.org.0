Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF47777CF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbjHJP5N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjHJP5K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 11:57:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55BE2112;
        Thu, 10 Aug 2023 08:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX3Ps9baebypnVI+ev2DPdzcwsw9qJpEWX0xBS+QOUZhVS5TxUm23AJA3v7PiHVq4zTGBauakiH+U0+151ntWl3S1hQ7nO0mZcG82+4UVZBk/cPm4TIWx30BvqU3+usMbkmK8p/4hClBIeoveRLbqJvHz84GPb/Q7eiYdO0/Bq/A8kfwTM5czSfwT2b/a0kGsDsXjFWA3vDrsn39tnl3RG+u2yFcEeOMTK9aIHRCW6xL+pKloo6hDgPpzTHf3347PBx5ogdJiDW0miuLCuTwvdADrCFsN8HBfNlDeM6HT6InujLBs2TFvmSBSm4sWspVfMESaI4YW+frNnEV3fAmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4WadUE/0c677yqnwhT2LBHCKMtHyc5okxShkY3Uj3o=;
 b=V0RfB4nqiJulJzjlX9axe/ac3MH1kpXjq2xsUElhh0mthApWhD6TAiW3q6l52JTB8eM5+E1XMJhZQF+xyAIqoZqjRi/xeVR2BGxlOp1zOJFrHw0wmPvuog1v6UCHk3MfK130jPMBPQo1dtuhDR56CoY5RnY6SFBlfKS86gEo2nBogev2gXpNPJrl3t317dj/JdcQe8umDYTEOURRhwRf0XGwrCGAVdkWaHjULVP5Pl1ZyeQEg400v2t28hem2CZPmrhSv6PMozQO06pZb3zcejY+ziLaRzhE/26BbViKtinuS3285mujZ8U0tg7eaA5liXToZ+JEjv7x+G8GcyX3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4WadUE/0c677yqnwhT2LBHCKMtHyc5okxShkY3Uj3o=;
 b=VYL2JJRueVUAJkiGXErDYl4eDVWFXxsjpAF3C2PN6gIwL/XsdfY1C+48UuJSB1L2k5P7KH2ZUeG4xuoMmoBIJJQucGvHE2o/1bfxgHnyfIlPJladuI3gLXqxS488UL0W91E3Ev0Y5jGKoSyjFiyRtEDVR/Xwt1ngGB/uVDtCiGKIaI7OCqov15HK2tMEP4XYmDyrZClQxu2cqT6wnK/evOC+V8ZF46RIfYIKiPknqMvuOBqKCPx5+nJIhtwWBbp+0wSy96udtOV3/IZKOe8T3TVNbjmIGq+iGdedvkJuIvCqGYbZhn0z7PQa0Mqm+migTtav/zG8TnuCPbMhvf9Kjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:57:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:57:08 +0000
Date:   Thu, 10 Aug 2023 12:57:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZNUI0D7ZMvLWlBNx@nvidia.com>
References: <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com>
 <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com>
 <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
 <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527683351B687B97AB84B51B8C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca29f58-6b91-4c0b-e2bb-08db99ba730f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yjtdrx3o91Auy5VICMVvPwcm3WZFfE+/RHv4XKVvGk1qk4v+cMViWDowQuFOESAEOIpyDdLNyBcUfrmwlGg4vm9FxrwUCVd8o2+lgQjO1ChtaM7xZ99szYdAGyyQsuxkxwhGOqG9krVdWh11uHYR7j3hpYTbm4ws0A6oD3XfQBf/w3uwtWT+RnSfKOvj61InX/WO4snH9gYdDIcavAIWw7kqt2QRnbBywUym3rowoYu4yVZN6OmyPHYDmRVzA9879s8lrnltZkabxGWGys9joVwE7o9FQZYwXEIf6+AoDVj0DjZapAWKQrrdCTIaqs06CLYqMwbNCpOUeYLHcD7SxIgDbCTun2/371VqnwkLk4EZ+wgclz3ymNGBDW7jIotzYVipxlW7VTaQaDHzsTkLIQjmQemTw9/zmpygK8qWIppD+KYDAFCeoSEtpbjVtALeVtLZmQUpUGD85ggZSCOLrtGgI0D27zOA2DZihqtBf4e6bzcztlybv79oTkxsx9gY92NT18cJ2ynbNzkO1hmGvonM9+dyndWlaucljk/okjlcz2jw5Q27PssRg3I+nGV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799006)(186006)(451199021)(54906003)(36756003)(478600001)(6666004)(66946007)(6916009)(26005)(66476007)(6506007)(66556008)(6512007)(6486002)(4326008)(2906002)(41300700001)(316002)(7416002)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Vpwbf6o35ih7tkc/SCYREgbX52l3pg5/mH1aUJCdRtkOJQVexA15yF19GnW?=
 =?us-ascii?Q?gxHDFbClprgt5MVJceFuzHH8exIKTl0atGOK1dGBE7nM/HjHYe0Kz3nSWooK?=
 =?us-ascii?Q?yYbJzfQTBu7px44AcsUEUocC7ErFwAij2hgfeAuyZBcL2NeM2JoGl7QfObHC?=
 =?us-ascii?Q?qM1Qo4Qx/DEgFoNOXU4q9PXmHyj0yxCuJt8fC+smuOMr/cKEOLI+ObKnmcJ3?=
 =?us-ascii?Q?IBFl9xlViJ2zZjWZWWN90bGaHjktPSBOUg3L//KflUjQSgZiKmNK6GDq+RvF?=
 =?us-ascii?Q?3j+itTACNRs0zlnmQx6ynwSREV2E3sW0vEhOQVrikgQkRCgCyV9rInxe+ShR?=
 =?us-ascii?Q?0K0yENA66jubM5aLIOWaW4Az4rFCPDhTXfwn7O3VyUn6tPBvN+TVUd6ZIV7d?=
 =?us-ascii?Q?wBYvAZJwINBuRtrjUzqTxfnOeQSSZFJAT5SUtSu48O8vlaNNkZPh32q8QGBn?=
 =?us-ascii?Q?b7wCuehHRBHU36k5Il3mPA5szJCdhuGsGZBWb7c2dNvWyjuYjx/shkM7+o0x?=
 =?us-ascii?Q?ODdUHUCppSty86Au2mGJKvlGRBUKnQ47jH5vTkCLVFA2Cuz10OZSn2l+7VxA?=
 =?us-ascii?Q?LpxxjqmJAdPAJQawlFvIZyHOsdVN0b7M2J/P3bit7WzNLri8Hxhfv3G8MLXG?=
 =?us-ascii?Q?ZfWYCfs0XtxKK1PEJ4PRr6T6gpzvF6wXQSVNSpy1xZCTQJP3MBS0u4tZJabl?=
 =?us-ascii?Q?eA7fzITXws3w1LxJTGK3VND7A9qRjG7QSpeUbmxVfCLc4q2sZLUzbsbNdg4O?=
 =?us-ascii?Q?liKYskqfPjbdSdCJzKBNO5UieP1yWME9VUSplX3EOBwdzlqe9Cd2tlvd8+my?=
 =?us-ascii?Q?pzFEXc+pk8XmGkyCcf5rEn6HCMGt1NeOmQyXJBtw50HcMjcS2fhyTR4L4PgP?=
 =?us-ascii?Q?UiQBHR03+RtYyAsZ8Ql5dpI+cKFMJQpg2s1D6aZNHuimSrIqbm7P1q8rpfx5?=
 =?us-ascii?Q?Vgj+WTFBzJV/kG5AkknF/n8Y4sjvrsfEtDncdmwk/CnVR68ActqKcJwcG+XB?=
 =?us-ascii?Q?6x2AdxDvx/OvHFaWj5GvLccP9h6QEr25NsPNgwo80PD46l9gWN+qC+dcv3ep?=
 =?us-ascii?Q?/L3WFQPJeaJLl0l7v4u3l2tq/lFJe50MBaz6RcGdQ+eowDMYQeCVXnks3mGe?=
 =?us-ascii?Q?tbSPQr2sionNKVnKS+RYKdgrqYACtpGmmYA9PwJkraJrUybAwTICCBRgRfwt?=
 =?us-ascii?Q?oIllzyP4fEHcsi9GfyzQfPequ+1FYaFcvcZO/S+X+P5/r96jAvymkgjhZtkF?=
 =?us-ascii?Q?S57gJ61z5pbKpdb/PV4+3mamPWERmJnpvviYSVdtzHb9ode428mDJrwGHSq1?=
 =?us-ascii?Q?AlPCxRL4evDQGg5bPaYmr1/h7f0mIupTqdCvdjEPQMin829TA/JRusU60f8q?=
 =?us-ascii?Q?hlEnsj7Ugo9W/H6f+c7Psqha3VJV7j7LVhIa6Xv6TaYm0YYTNZaBGmsszGZz?=
 =?us-ascii?Q?IsWMrwCDmfpMeocyc1Zgq/nWe4/0ky+WNvpPdstxLTJpwQ1xjZ++VM6+Hgjh?=
 =?us-ascii?Q?j7S8JLfru0y5ZEPubWT6SO2TAoUS76qEaU2WR7DoSewIqwBVi3jDSL2eOANz?=
 =?us-ascii?Q?AEL72Gqne1Ay+QrYG6D+KE+WsOJg95+Znv29Ph9J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca29f58-6b91-4c0b-e2bb-08db99ba730f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:57:07.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IE0DFGoAERbrQCyDYNiUOhtWbxP8FcTEZkuIb5hFuieEz6D2bt8v5xBvFlvia2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 02:49:59AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, August 10, 2023 4:17 AM
> > 
> > On Wed, Aug 09, 2023 at 04:19:01PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 09, 2023 at 12:12:25PM -0700, Nicolin Chen wrote:
> > > > On Wed, Aug 09, 2023 at 01:24:56PM -0300, Jason Gunthorpe wrote:
> > > > > Similarly for managing the array of invalidation commands.
> > > >
> > > > You mean an embedded uptr inside a driver user data struct right?
> > > > Sure, that should go through the new helper too.
> > >
> > > If we are committed that all drivers have to process an array then put
> > > the array in the top level struct and pass it in the same user_data
> > > struct and use another helper to allow the driver to iterate through
> > > it.
> > 
> > I see. Both VTD and SMMU pass uptr to the arrays of invalidation
> > commands/requests. The only difference is that SMMU's array is a
> > ring buffer other than a plain one indexing from the beginning.
> > But the helper could take two index inputs, which should work for
> > VTD case too. If another IOMMU driver only supports one request,
> > rather than a array of requests, we can treat that as a single-
> > entry array.
> > 
> 
> I like this approach.

Do we need to worry about the ring wrap around? It is already the case
that the VMM has to scan the ring and extract the invalidation
commands, wouldn't it already just linearize them?

Is there a use case for invaliation only SW emulated rings, and do we
care about optimizing for the wrap around case?

Let's answer those questions before designing something complicated :)

Jason
