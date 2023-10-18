Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8CA7CE2EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjJRQh1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJRQh0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 12:37:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78914AB;
        Wed, 18 Oct 2023 09:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyOj/NO2fV+51MtfJkUnQhz30+Uz0mihlCcjtXbE7u3sLNZgh08MqDTLY4g+8mXoAb0Q/DFxvo5o/2lo+ZYDvxoNUCXqFgq98hhyw2e8hB28FdCvR0Sucw+wFXX+tKX3r29+ZQvPwpEA1hv/YmgNt8+iXYDaigHIFf4wydAyoCS29hkL3mHNaaRCszgjCK83PNp+rGHQNfcq6et4WbqqhOMZWwFnDGo1hY518To5D7Xvipp2XFQnAwtyrcbt9EYoNgAEpsjvK78b2g5uLlBiQXrtbORi4u5LD5Ma4alwBrQlAPh+gtVe46tMl5KFBNWX7cHutXah/yOT3UAjH34hww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/xYz+1V02lTS5PLvxnX38wXWkbtB3NbkXRBkwf6J6o=;
 b=cL9Pbo6Td8pcLzbzoqZGpsq7WGGqQKddTAk/wNbQFbq/+37AOq8Z2Sg5y7EtsB4QAjGBy1S+N3zlIDqCYGymhoDkf3+6PGSH9K1pU/uRPgkXcRK+WxOGH8rOkoIwFEL4CW3/QDC7OXDdj0W4PzDHg45gnzbNSM19w7Xv1zETp1vGz7MhXLkZ6d+zpEBBHiix577bBgqGY9ixygHEB4xLwAT/Vj1iREPUHC+GJYxYBOykiKgamEq/aeUO6dm+l88D7eJDlbqLITm5rAn5oYjifPMaI8etIrqHvARHdK8MQ0kdz0JE6iebR7n7GQagPwMCoghFFlZErcvU7yNhWaMqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/xYz+1V02lTS5PLvxnX38wXWkbtB3NbkXRBkwf6J6o=;
 b=cjg8XTh0AWYM5bA17jzj66NeOT94NuipybD0nwayYXDr1vCbAjmeqLuMDxxYud6JNKqd9viTqXJiuJ1khcaH+l9bIeE3i5gq6T7iKhzDExgMATC2UCrakeww/hOZuvTacuEQ9NBzqGovLekm9KY4y/QSpZiBB2F6bd1qwfnHro6NxbTOdho9/I/uKUZY+w2QYFmvxo4r0zoXGRJxkJfPo9EYsFllPYIQQ+fRUdewtGwVb+o5hUcIFmICAAbuTa4FNZgnzB+QpW1IoycPnmK4C6KP+m2uWH5iwOY7KIp+f0OHFjJQjbaT1NGCGweBHtEfG3Dm/Dp7TmbYlzDHeef1Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 16:37:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 16:37:22 +0000
Date:   Wed, 18 Oct 2023 13:37:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <20231018163720.GA3952@nvidia.com>
References: <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
 <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
 <20231013140456.GR3952@nvidia.com>
 <ZSmE6unIukqJ3GKu@Asurada-Nvidia>
 <79f0cab5-39ad-3d98-3896-6e1ba7b8db21@intel.com>
 <20231016115407.GO3952@nvidia.com>
 <ZS1+VMEo+0bCecui@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS1+VMEo+0bCecui@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: d040bd83-0538-4267-cfec-08dbcff88092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7iL9KinlD+OPSaTmhHlp8/5q13yMm/GPcm9ztCLFfG2Ft3Wts5xUzh1lEnqXI8XROZy3O13VAhpiO+fj1JZm6XcAdUQMm+4yskRCGntCVZ/FjE+JPVVKD4UCKE9YLu4NgJkP8Y3mtRTCSEHtP2nZq0vyS2FgmF9Wg7v1eB+kUv5WxWNdgYRXPjhOtTrTmq9Jl7h4x7YIY94Oax+1txQ73RoUA/suKk/SFdcWh2287dICDV7dwxciYgE/FHV69sdbskdvToevR4FGD6xYJQiXulQl7ZUDwqdDssa4a8iwrIjYQ3Sxeok7ukuKz0VA+P/l9jAy4qKDTz6dQlGOQEVU2DZXRjANIxst61+sMlYs9afgE1KtXukr1xeAX9eZfDEPubHGaQmBEOqxnHnP3Lafj4/t4pqmpx75+85mQdnTD/LNWjAIHwAkF3GUfUxocSZiyf9uoBkw2RU6vXtzIDyZF/uZLPYPJd/ec91jIRFd+DPWBYBOCFBO/fgkkKMxkq/9eAgDGitChwnW6LWauEnwDGfcRkhB9uoBssG9P/CwqnmuhAIEyP4v/S6mgxfFc0oV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(6512007)(5660300002)(6506007)(2616005)(1076003)(53546011)(41300700001)(83380400001)(2906002)(4326008)(6862004)(8676002)(8936002)(7416002)(66946007)(6636002)(478600001)(6486002)(66556008)(316002)(66476007)(38100700002)(37006003)(33656002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qejt985LPoErpt6SymzspCeHm0RJIrXsGhtyd/0IBHs7Y6XhsJ7vQU2Lwcs6?=
 =?us-ascii?Q?Ndn9IhE5c1Kj3OBDgbpr02CFrrYkRa6AFDUc6ARUNyzQbIrHM/HRgF6JYZHA?=
 =?us-ascii?Q?lZ5vqBSSy/RauBfr9uJONE38Qdvx5bnyb5YBzC7Vbj/18ybRjOtxpfEKpNZC?=
 =?us-ascii?Q?JelGaTXKzD3l1gVuoQbXdjeakIk6w0JUHt/8Ss7gpJvcnmefVKPNVQDoBbVP?=
 =?us-ascii?Q?deJ35ofsPqcFsNogqUgEEMmEbsfFpWP7frDNU2jYPkND3yKnXLPw/3yYo9Qi?=
 =?us-ascii?Q?+nY3LQPhE6ltQxuqU/oyJyahYtaq64CXiHj1S19OzuEgwavcxI734S0qkN11?=
 =?us-ascii?Q?zLugPmKdmX65pzJpRubHgikI0xDvJp4Vyk6NY9/zkpFiPcpW78GD6gbKZKGL?=
 =?us-ascii?Q?lN9loJmFXws27c55CZV8/RUcUk0YYEve0X26XChmm0Pw71/nImGJhYsRrI/B?=
 =?us-ascii?Q?jPCAVZgeLK4NBhBlkSesM3PtsL9nbB8TxQxrzHuwu79zpaV9ApttaGG2Hyms?=
 =?us-ascii?Q?yGUKn2YonESkeEgD/fgNAQZYMUHPJgrO7eWUBYSzpOTlgUPOEb4+a4wl2Bep?=
 =?us-ascii?Q?Cvb8IVrGRSV/tY8O2R+CJ8UOSjAchPJc0qxKqz2mQHOxpgOhy1HKlBxsVlJW?=
 =?us-ascii?Q?RcSpZf62Q5uGt0l6suFpDd+p8HrWWZf16MpRUjFCa2JoGGorueRrY4p++zWH?=
 =?us-ascii?Q?615Idic4d/BWZp0gwbsTp2MuRsN2/kohX5vXa+XWqrMy6fd9UCawc/hST81Y?=
 =?us-ascii?Q?w7ws2ZABH7wErFlUM073VzOSW3um0dHYzyGGHJU7XBRSBzbzsXJzL/8iclVD?=
 =?us-ascii?Q?DVJwAMUW6mQcbVu91UX48G/6W4JVBJtDgoeFq9ZE/fFfKyg+SVhVmo00djmX?=
 =?us-ascii?Q?dtL5Oh3h9IpsWeYC+/T3c5nB3hMHyLuoIPvL3+8nGJT+5ALMVYHwSeWl+ZEz?=
 =?us-ascii?Q?quWHcFKp2Dn83M/YNw4cglFgDjN9MCz/rPp7g9iTlv1pyuY1YY2B5pNBm1TL?=
 =?us-ascii?Q?o3buTOdJRNDDIFYLlaEyIjBI/ama1JD7fjwSwKIUpHJndR5PGBg+xO5bdfq+?=
 =?us-ascii?Q?qDxMxz3fN8l8PpaoRIXo0NBL+CD0s9XiiAxXPmsv50HOPIQAjlyjk4pfGpgQ?=
 =?us-ascii?Q?6h2qLb3MBHJaeV2RI/vwC/IF4AZKeQFntTv9MkRnbBU8h/ElUs4daA5Cn4+W?=
 =?us-ascii?Q?C7IgP4QVc7YWxwrbjRojW5ECaJSi1Nwr+MoRvSUwRxEMbZB3eBnYUm+napTn?=
 =?us-ascii?Q?oKHnJCtYUna7vsU1cn04kWTXgpeI437UyevcDofYbZoohnSXE+smMYKJ5cY2?=
 =?us-ascii?Q?jI8AAylM+bCu0dzeqZqV6O2XRctufX6OpwbDxLCSmyuxIkxShkp29xZucNfX?=
 =?us-ascii?Q?/K6bbd6lxH7UTQ1wEJl3P97x99aMoP+DgVftW8p19+jK4Ju5XIFZ67UEw4ao?=
 =?us-ascii?Q?rx8WVOxXHsb1oHU2w9YHvMMUMsaPUkHJNYbz02nzCdnXTbTmFV2nnxs42jKD?=
 =?us-ascii?Q?+urn8v1Nh5Gz/LSQ9dGgIowxeQHlJj4uBwv2knZuaT1ob3VShjJCqEkiqHqg?=
 =?us-ascii?Q?v72/A2/epFpMnR/seUD32C5U6iMaiOFpLnVxLNqy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d040bd83-0538-4267-cfec-08dbcff88092
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 16:37:22.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zug8SguJ9tCJVoE2BujmE4+2K+fTCVJij18XppuRryDhVgT8PK/WEs6ad38QphRQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 11:17:56AM -0700, Nicolin Chen wrote:
> On Mon, Oct 16, 2023 at 08:54:07AM -0300, Jason Gunthorpe wrote:
> > On Mon, Oct 16, 2023 at 11:28:15AM +0800, Yi Liu wrote:
> > > On 2023/10/14 01:56, Nicolin Chen wrote:
> > > > On Fri, Oct 13, 2023 at 11:04:56AM -0300, Jason Gunthorpe wrote:
> > > > > On Fri, Oct 13, 2023 at 12:33:13PM +0800, Yi Liu wrote:
> > > > > 
> > > > > > not really. Below the users of the struct iommu_user_data in my current
> > > > > > iommufd_nesting branch. Only the domain_alloc_user op has type as there
> > > > > > can be multiple vendor specific alloc data types. Basically, I'm ok to
> > > > > > make the change you suggested, just not sure if it is good to add type
> > > > > > as it is only needed by one path.
> > > > > 
> > > > > I don't think we should ever have an opaque data blob without a type
> > > > > tag..
> > > > 
> > > > I can add those "missing" data types, and then a driver will be
> > > > responsible for sanitizing the type along with the data_len.
> > > > 
> > > > I notice that the enum iommu_hwpt_data_type in the posted patch
> > > > is confined to the alloc_user uAPI. Perhaps we should share it
> > > > with invalidate too:
> > > 
> > > invalidation path does not need a type field today as the data
> > > type is vendor specific, vendor driver should know the data type
> > > when calls in.
> > 
> > I'm not keen on that, what if a driver needs another type in the
> > future?  You'd want to make the invalidation data format part of the
> > domain allocation?
> 
> The invalidation data has hwpt_id so it's tied to a hwpt and its 
> hwpt->domain. Would it be reasonable to have a different type of
> invalidation data for the same type of hwpt?

Yeah, maybe? Go down the road 10 years and we might have SMMUv3
invalidation format v1 and v2 or something?

Like we don't know what the HW side will do, they might extend the
command queue to have bigger commands and negotiate with the driver if
the bigger/smaller format is used. We've done that in our HW a couple
of times now.

Jason
