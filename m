Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750937A8318
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjITNSi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjITNSf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:18:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE5091;
        Wed, 20 Sep 2023 06:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDkHM8hfTphUSWwQ/GRSO/ITsPBYEHFFlRxnPZMrtJLW4U0bbijrb9nbaIHcKhnIGOBem1HytgtJC8h4rQ5GYjzwAge8ShkBzegce7ymo1wWj0bgeTf3DFPFBhLUPi3VK/Cc1ujXeKPWCFX9Ikyqp+tEHvzI8P6bm9bhJLQP24Aevy0pGK31EaEvNdBRBI0NeW6J/6jd9Q4HB19FxnjHMm9D2mFOwIeU4h9E6WF3KBfXHKvVH4he1/N2gJaPerYrOAUN6V/q8w/XdD8xCNhO8GuKfYP/OAhsKCEJAC3cbK9sG5xAfuWNRP2cUH3eI9hBLP3LK9iX+tzy6x+HoceoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5u5Yq3YuHRARolHIAmYJYLOKZwbb0f3b4u+zIdySoU=;
 b=IZeTTw3q7jZFqm8D2Qnk52KmrZOqFi203VaL/E/PWeNoTGDr7VSb8hP8h7iodal9Nh1qBhRr7mGky9oQslCN/mlVIyIqWuY4fFhw8C32dyI768p2VUi/6S3m49DBt47fYvj1o44iNLUCyHIhMoS1zu68LHcv8MN7Di+/knrar59YcoVnnjtLaaSv76B4ZUyry1keumVanMa2tHyTWz6WQawDKqswfZ/Ui0e6XabjmPBTdqMCFnhZ1rMv9a1s0G3CwuzMJwumRzbwuDSaPnbHv2hpDzax0x37p4BMAOOtMT3breJI53Yh2H9bFIxYzKPzeywO9y+Pqg7xIttEvo/1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5u5Yq3YuHRARolHIAmYJYLOKZwbb0f3b4u+zIdySoU=;
 b=spVG53krI5NOWfNovKHjRWoc4Zm27177a3xShY4clOVKcklbRyigXa8tlmCEN3M83CuAfM6xfiEeVoXIww518Xpaf74rYRZdkEF1YcuNHgX4pdL7WftoM8VOMNBMzuurg9BrfPugb4HMNbRm+ucS2a5cJrAwhNI4YDL11UMpbXdcDfBjOtEb1044E0P8WXme3AZyVr9wMvIZt6cbz+0WTPG2EgEHVwVJPhXwgTVOQkp54FMT3WAh2yor1J9QWPojdpBFmnX7zlEE+IoFr0EEWG1lbdl7OE0WxHKuK5SfCYPF8BNj7rCj/pCJx3sReOnOLpIPkBm6/A/+YFxSztO1bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 13:18:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:18:25 +0000
Date:   Wed, 20 Sep 2023 10:18:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Message-ID: <20230920131822.GZ13733@nvidia.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
 <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
 <20230920130522.GV13733@nvidia.com>
 <DS0PR11MB7529609BC4574A17ECE469A2C3F9A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529609BC4574A17ECE469A2C3F9A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: BY5PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 45373b7c-748f-4750-7fba-08dbb9dc1211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YO68aSxL3OkUDrMeZxEMB7RtMXkYjC3HiTcn3SY7Laza7McvBQfkCaTa6Xs7W3MIzWKGz9LubLQ2xc2wsIpFt7UhPug70elQCxGQHj6rl3sBmOJQbCs9qP2Umcy9smkd1XOXG2HxVEccxxDw3lK6anNPvZTnlLadEEMuBunQFZTKbgFhtZvmNZ9OP3xBMV2wP+SbA10TRMV5AZoQG6yk9CUGzfpjjO14V2qP5m3WIEFtBCY8/LV3JqaTXgiwTC5PNXnaJIgv8HLwXtMwfjPFf5FyoyP6OlgXy4yInWVzRqwbI+obOchwigpb0JZi1zEBQL0dpOBSSSc2WOFfls11RK4CHRG7NYB1vuST6L5t4d5ghzp5UgZQ44xFJWyT7g2i8SxbLGsUbNmb+BQGYyPz1/+B7BP2pIayrpWCWDoPNp9FfXS9vFzTCEeHyDDd8gBu8mrfclmH+gbO2kT0EorEVDqFEbjCkuoHr0z2myqOEXWBRY275N2Vd5seXt6IjyI/BLqRwRRx35bWlfxpcrbzdLZaPjxpHSIWygGxWgi3ktx5hx/Q52R87l1wrimV3J9z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199024)(186009)(1800799009)(4326008)(8936002)(8676002)(41300700001)(36756003)(6486002)(6506007)(5660300002)(6666004)(6512007)(26005)(1076003)(2616005)(6916009)(316002)(86362001)(54906003)(478600001)(66556008)(66946007)(66476007)(33656002)(2906002)(83380400001)(7416002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RxSZ80Hev3j9ZZz7F3f2y1+QvGpSw2zHOCvULGKnzpgm9kd94JQNLSiAK5lN?=
 =?us-ascii?Q?GdloLm/TzxS23chT8agNLvgX0wwHWZ07iTuPGRoMqYzM7Wb5TzM9Q0jpU/i6?=
 =?us-ascii?Q?zO5+tfDsqF5VBD+x5rS8KhX/AUs5obuRsxZE3+jJpLpFnEQpcEEdrXR1ycd1?=
 =?us-ascii?Q?s1qDvBKxwEzEDhSPID/yVM2zlQ2CgTJB4w/3wIr2BK9fGNnwfhxJhe0RjahF?=
 =?us-ascii?Q?w/cQAtQL57EYDbcw4MEXGVVvwp4SYtLOV2IOZXHJpq8oMEqRS68x8APiWjCU?=
 =?us-ascii?Q?/lLKvvY80MyLXiV7i3ZltkMIYcv6BPvIxqej293gDQa1xNTfwpk0A4HFk28T?=
 =?us-ascii?Q?ZctWfspHb2p4kRpZX5mJqsEr0M1TzW8GsvFqaXMw3XDwtpel4UIvkuqnnHjn?=
 =?us-ascii?Q?jSH4p0bMBwYsOfh78fIquzygbm9bbRoYHJfSoqhVyI1Br5fgJ9fxd1mIDogp?=
 =?us-ascii?Q?gigXon60uM+p5YzDLgKmtH5bPIO1jroBoXWA3PKC4jgEkcj0U2U+x0rZeIWm?=
 =?us-ascii?Q?ZE52QuYbHKP2vW3pydkTWIo/7UxhLJgdJ7sf0Faafp5CUCfGV9lU0bOHHLdN?=
 =?us-ascii?Q?1REDCHw52rHkO/YsKexs9y7lbuEs8zrSz55yllVk8xNN++woMqEp0evIlMb1?=
 =?us-ascii?Q?+EQT/B4zTc9Ns/HOr/uVuylH+HuZVszIRAat2nGZpPZiKqRioQIXmbv1Y96w?=
 =?us-ascii?Q?nVZ6eIOzt69SiIR2t2XD7tGtwvMNzbGy+NAj+hWtpF8TeFpTJyKUK72an6D/?=
 =?us-ascii?Q?6crUQTmhBUYhU9FIfLnWTLGhWhl1Tl6/tmRs/N2OjW/kiGlawEvSJggQDYZR?=
 =?us-ascii?Q?QGvRvg+tXmmYm+edbhfbvLMbmAG1sdOaQP6NdaCxMLsSXeZC1JdUVklYJkwI?=
 =?us-ascii?Q?SJKCAkzPx7vWzkCsiXju0I32I+QAqbymx5UnAqi86QfL96L+5AI0EiD/FWH9?=
 =?us-ascii?Q?O696RL3CIY6pKUZgBg70e4ToGIEBSBt6bPqFxfddGGJHfKtSnvsybOEBEac1?=
 =?us-ascii?Q?9vpYB6563coWC0ed2GBS/lXKTaSPyz4EuwN9lBnS0AJHlfa2IMABRd7iVMEd?=
 =?us-ascii?Q?3pWMACG3orqPE0wo0Jh4XE7Sw9aP3i1ylYrS8Cn54ht9hGI1o7WugMX/lwNQ?=
 =?us-ascii?Q?szfZ0oEZVSUi5DlhvwILVWWmNZlj0rfiMN1l2OmzIPIfNfI9hJ5O3uyXpVOG?=
 =?us-ascii?Q?H/c6xLk/PQHk9hKnvkVu0gK3wiC09mBf5J8KKL39A/8+YcSr/OrSgNteCdHC?=
 =?us-ascii?Q?Ku/Og9325d1yf4ycevhFbrNl6a6mZhsGEGtfQqzb+JvCpUHOqeJwAxQN39QJ?=
 =?us-ascii?Q?uJ/LesRCHtwhjtmkwfYpUwc5HTUFiu+Kwx3gfu9nT2bf95Zno+M56igWy7+Q?=
 =?us-ascii?Q?udSUMkXOTlFVLosQlDKQB1+UjJ0m4dscHkJakHvdBzZmwSqXJggz5vskmmZ7?=
 =?us-ascii?Q?RCLRJwI45TmQFjrxkun8AhT0hcCqpXzmUWh8yVKN0PNeZLVrsWBNEtwe5Dx5?=
 =?us-ascii?Q?9eVEX1JlFMpqRDF+c6ZRgf9BthiXgZu6YYh56hq8ZcQxnn0OeoyeeZdAcy1h?=
 =?us-ascii?Q?wNWN2dOBNaj2EvFnPdSbpiscjvpyXXQqKzD9mhi3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45373b7c-748f-4750-7fba-08dbb9dc1211
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:18:25.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/WM7KXs70h0iWv7+N/quviPHXtMUyXpmo16rt52yQlADfGt6Y2IOeJihbpN5I7M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 01:10:04PM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, September 20, 2023 9:05 PM
> > 
> > On Wed, Sep 20, 2023 at 01:28:41PM +0800, Baolu Lu wrote:
> > > >
> > > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > > index 5db283c17e0d..491bcde1ff96 100644
> > > > --- a/drivers/iommu/intel/iommu.c
> > > > +++ b/drivers/iommu/intel/iommu.c
> > > > @@ -4074,6 +4074,25 @@ static struct iommu_domain
> > *intel_iommu_domain_alloc(unsigned type)
> > > >   	return NULL;
> > > >   }
> > > > +static struct iommu_domain *
> > > > +intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
> > > > +{
> > > > +	struct iommu_domain *domain;
> > > > +	struct intel_iommu *iommu;
> > > > +
> > > > +	iommu = device_to_iommu(dev, NULL, NULL);
> > > > +	if (!iommu)
> > > > +		return ERR_PTR(-ENODEV);
> > > > +
> > > > +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu-
> > >ecap))
> > > > +		return ERR_PTR(-EOPNOTSUPP);
> > 
> > There is a check missing for supported flags
> > 
> >  if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
> > 	return ERR_PTR(-EOPNOTSUPP);
> 
> Well, the iommufd has such check. But I also noticed your another
> reply to Weijiang. So your preference is to do the flags validation
> in iommu driver instead of iommufd. Isn't it?

The core code should check that only kernel known bits are set

The driver code should check that only driver supported bits are set.

Today there is only one bit so the checks are the same code.

Tomorrow when we add a new bit the checks will not be the same

Jason
