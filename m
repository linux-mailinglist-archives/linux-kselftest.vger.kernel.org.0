Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5C27764F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 18:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjHIQZN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 12:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHIQZM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 12:25:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51EB1724;
        Wed,  9 Aug 2023 09:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uo3bXseAzOq6JSSt9Mt1N/kFXiJRqHbLqL7mblB6Ovredyf2w+iOshQsPqUWDSciLn26znop5mfV1ptF5ZU8CqdZ+K5rJkvrQAf3Laed+VNgqxFxGsd+rCy5sZIxq34q20TZNivmjl4IbOXE3l1LsfLOAhMd8d5esiXHWHNBIOT22ZNJkXa1l0Q4GwQpswSfG827V+qXL36Y/M2VaRyOTSArqT2QqtjcwrWTdxS0K7qi+7R68TTzlJEAQ1oJmTgluixzAlJqLHcCsumqvM5R//ROJ1W+9fD4GWbI2fsaIXgYRnAkI7xN7BYz+rFT92h6Jfff7sjGLbZ3gjk3asodNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZOOz8qzCVnz5l4AJumXICc3CB3C47TRy05LZGQcFIM=;
 b=VheO01u3ebelKuRwuVk1WZ/GvfL7jact026U0ER+DEoQ52nEqnaZ7ZcqQe6xOAUvh6WY7zpImiVYyeGAR1spTlLROJEk+DQEw+SlcYQ0rLqPsPnTg3xKtTQZu2ErU95Otu93c++Pki5gHSKhEjaEZDhvACzdVnsa18DNLGXJwJHzvoREiHIkteRoKBjVLig54rDJ4pDhoS9vOhVh8DM0VzkelyWLOspcjrNQk9Yabt+H/rEE6osh0whV4ijDjtju7iUWggSJkLW7N8uTJscmjUpPYK8y6XfMCkbk8MVoNGhocnDmeEdEtj+qHVNCV7ZMIlsr4YDEe3ItY6f83paCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZOOz8qzCVnz5l4AJumXICc3CB3C47TRy05LZGQcFIM=;
 b=ISQ7K+OeLpKv88kx/ERdEDODB0JebBj3a1kpCxMMrdr1vkjW4RKUm+BPiLBGkvT08FeAqSfb/WUsi/mI4R523CFB1CTn0a+R9eVhjnncQowqO0wwBEPEU8GYVaj9rS99+xCTeGFOnsCIp23kcKzR6Qqs4SR7FD5CTyWLOww37Tb2b+6rF4D1KhbS136nahCiR6n3372LKxur4vOuqV1aLzFv+cO70PrA8PojKRrejUoI5WBRAc+XA5Q1dXzq6ypycPPYc4nedvWbRIJBUpxmHMwvZegTMHLZsXlOdcmTs2N0r6rnP5mvk1qj+QH2W75Hp4k760ES5nPngIAs265B6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 16:25:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 16:25:08 +0000
Date:   Wed, 9 Aug 2023 13:24:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
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
Message-ID: <ZNO92PIx2IQ70+DY@nvidia.com>
References: <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNGypUee/U9d68TZ@Asurada-Nvidia>
 <ZNI2O4Upyna5AWDA@nvidia.com>
 <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 0834fa33-642a-496f-d2f1-08db98f53224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLg6bz14qdCZsmElV/lJsl3HXB2K9DO2/WJiET7M2jdgTublv+ceff7Cob3Ywfk37PF2V1a+sRycfI2wVXYmHz6g+zIkSnp3DAQcz+xmonhOO3s4dDT2holRp5nbh2BzmvxLzwtAOcLFtCX+fyAZzL+FShWQTk5rZFtXKHIdfXNvRs8mIXep8Ugp8D7kWaehsP/xSwDpw3I8dcX+aaaJkDuNKKjYsYh7b87g05RSP3q8UWatn0h1MoKnt6Lzx1s1aXtbeRoSsaMSP48u4uhcm6K3cM+tIO7kEl5vNBypbqX8cH1s1aPvz0IG97ne4GeNqCr3Ch6/gYD6Bs6zyCq+jF6zoWMQCnSUnZcbIXD0zGyRJwIkPKXyc++IbsA+5It6LtCT+p4/0kYuk3FAt8vNPPWsrnPhIwv/Z6YQjfYUEwmGJ/wezoGI1aYumtq55xakje+Rh65Fp0Z2zrKVVyxPthwMpTpXEUIit2Yve5gwFK1YnbLlVevjUmvh7jjEpjg4z8ksnCXWaKbaS+kPiFUDiHZGzeUl0KVn+OxRc5qcsIA4HdY3eLth7vlv9FfWhZ9AzotozAXj3GRktiEFgT3ga2Fucppykw/ZbEkQwyLYHBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(186006)(1800799006)(66946007)(2906002)(66476007)(66556008)(4326008)(6666004)(6916009)(6486002)(83380400001)(8676002)(5660300002)(7416002)(316002)(41300700001)(8936002)(38100700002)(2616005)(54906003)(478600001)(36756003)(26005)(6506007)(86362001)(6512007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9OH5KM3kf3kScB9oLv2d/pEVWd33ud4EV+2n/mdM+x32fNqyh7xA6IQTu3X2?=
 =?us-ascii?Q?NkOyyVBTV/8/6jUstmtVYalZnysIqgYYnsqn2rMeTfDhz8v3N+TUeXkr1A1W?=
 =?us-ascii?Q?KlUM0jq2ga9a/qjCcFtVTwh9mBznwTLpUDg5UQ4tGZtOombr1NWaBLFzxDrw?=
 =?us-ascii?Q?DHed/iGVTf5imH0DBxTHJm8DbXlSScF/idEtcJRZWqsjK9y1MwRqzhXjRtYg?=
 =?us-ascii?Q?d1puCUxnvDCGKn31A1Wr5gd4GxkkydQbTTdPSZ+mmU2Tg2grhZb2EszIdi7o?=
 =?us-ascii?Q?KbN/fga8dMz5QZCOi+EJxTo8SUH07NklC3lI7FnMSmNTnYTgyPWuyEfarY0Z?=
 =?us-ascii?Q?CXRjRu4xg7NeXOfFUqZIgsggEcJ5q40Fxuhn2Hmyd/s9zpXMTsTKgBavcw9t?=
 =?us-ascii?Q?Z5b4cKUUlUfRiSSWdpOl1RvRGi+oNJC7jWNl9X1keQDwGZn+RjMvIC8wg/94?=
 =?us-ascii?Q?AhvY+gnqkdRYTCULiJjGf8lI5nePP/qcZAq7fGsGrRdMX/tqJC8vx/7QlWKq?=
 =?us-ascii?Q?nK8edrVZb+biM/NjpcgPV4Aj8KU5OAmw1TeaCpUTs1nMYQ7xzx+Nq0Pq4Iob?=
 =?us-ascii?Q?UZ6MBTFTH1/E7WYA+lqcrezde5zwuEz8MeLKHV1hEg6GY495OfUj+wLB0NBx?=
 =?us-ascii?Q?BMLoLWDqU7VLPqbYZlFYCl0qk/0S5tVLJKpV0iFmJhh+euVaeYhtNcZ9ji+p?=
 =?us-ascii?Q?p/1L96Yx2qNiEqlcdofwe409M4OsmZm9OhFswG2X5NUFpXIMjXCIVLVjGnxn?=
 =?us-ascii?Q?9c6pBIDs1OxXpYA3VlRZQjKik4i6rAy3hEddNCA1rSTGzI66NgEsEOyLVVo8?=
 =?us-ascii?Q?0jtkpoO4i/yyvJkoerb2V0iWr1q28XU6m5l52dzyVk3hK/OY8L6yfR8tn82i?=
 =?us-ascii?Q?sHwt1UJQCXg0DQDXtQeoXkJsjwhffuqnv/oD4bvTR9a5+8kETlcvxg/6/3jQ?=
 =?us-ascii?Q?/pryTQCMQcOjzfZaBUTsGfSh+Zj13acD6byn17tBidnZlSWFDpmvBZXmAmk/?=
 =?us-ascii?Q?xUG2uNYO63Df5oXmThxCTUEb/XlXG6mIgQ5VW84BSGBY3MRQ/bKVc3El+Dvs?=
 =?us-ascii?Q?OtS3HRXZF68SjNXlJSkWt0tr1fUwK6zMuMN+/HAI/XvuuK7KG28SbrUtmkQM?=
 =?us-ascii?Q?Ybo1kyDyBJV8Pat0m8Y+zvQ1JHIdHLVAEqx7+3kcI47DXvU//X8zmIlsm+KM?=
 =?us-ascii?Q?Fpvv4nAKx8A4/rqx+hM/GTAYxrNYNElUL+likylrns3vzzOo0ADxusZhi0RX?=
 =?us-ascii?Q?q3bsNFzLG9EyGsNO7Myyq1DkwP1x5MPqt+A8oESJDZu6bh8s/AalWixF+Atb?=
 =?us-ascii?Q?yJf2Ww76kBDbCWk0lgbt4MWrXn8Hkd6alRM/Hn2Qi3VZok50K0SBzpDfegJx?=
 =?us-ascii?Q?U99KrO7IrbzsqezztsvZbZG6HK8CgMulAqtOjlcXrEx+aR+ozrX8Hvz8ua64?=
 =?us-ascii?Q?bsR/2KJE+LgLdjTRtbjpgcH5suhxtZwh6DOd9wlanO8UqHQkTtw20YVdX5Qe?=
 =?us-ascii?Q?9fkoER0+r9bN1N6jnaG7CptNb/U0upRk1ZQ5qkQDFgTfWW/0NUheBRiRxnqU?=
 =?us-ascii?Q?QXAhjMpNlpYGVE3RqwI11mZazBiXkf3YISLqTyAD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0834fa33-642a-496f-d2f1-08db98f53224
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 16:25:08.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1DVHEw2ILDjmhp2aezMfrWiO6NKGZ6vgA3zjaW2AYzDgU7+Zq+xpKkOGZ7i+hor
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 09:30:12AM +0000, Liu, Yi L wrote:

> Yeah, adding new structures to ucmd_buffer may increase the size as
> well if the new one is larger. While for an array, if there is new entry,
> it is for sure to increase the size. I remember there is one tricky thing
> when handling the selftest type. E.g. it is defined as 0xbadbeef, if using
> it to index array, it would expire. So we have some special handling on
> it. If defining the things in iommu_ops, it is simpler. Selftest may be
> not so critical to determining the direction though.

Maybe we are trying too hard to make it "easy" on the driver.

Can't we just have the driver invoke some:

driver_iommufd_invalidate_op(??? *opaque)
{
	struct driver_base_struct args;

        rc = iommufd_get_args(opaque, &args, sizeof(args),
	     offsetof(args, last));
	if (rc)
	   return rc;
}

The whole point of this excercise was to avoid the mistake where
drivers code the uapi checks incorrectly. We can achieve the same
outcome by providing a mandatory helper.

Similarly for managing the array of invalidation commands.

Jason
