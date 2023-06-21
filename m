Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8AA7382D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 14:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjFUMHd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFUMHc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 08:07:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EFA170A;
        Wed, 21 Jun 2023 05:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiyBIlovyyYbDCqBTT4Nea5GFFBXRwSlZ6hl1KiKj/GeyRV/1jdbGfy2IIBBYCzm0+rDhagH3xZWvy6uzED4UxIsG4iqfuREZVwbyWfU71vTQ90l/NknS32+eWPfIDPH6sxlDfm9SsMvf8qnK8S54VqPMgflq4G6FYdcmdenNu145aRG9VHshMbw3KuIPjaEUVKdgCj3zYPBYN2sKEucfIVOzj47hHUh/aXtSbhhgXPJKkl9xxHS6xYsY9cxtotp9r5ONUCfff5j6TAEkhfTN3nP8Ry/kbOw/gLh7nFi0tbfc0vDJbf684oVwr6/qjCWaSOTwzhcqkb/N/JwNxoFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CIJyHdknQiV2j/HwBUVj/YthK3XmQd2QxSjx6TZRiA=;
 b=exWC+534lvrnjY4TszrZMqrzzBXuR4y+B6OzJAd0cE/vhuRangt5UXGuZjg/vkwuV70zdkIxfKIOlnQ3nU0+pKpGpxEBcAutOoxZUGoefY8GjOOfzIiAwtIoBZFoiu6QOqPdILOcwzEwkQuQer0wysOyclsEw9146PNVlhe2MoeUuDpBr2yqiWgvYxPjkEL0KTKttGWbt5YI+3FBfaXsvJ4eYmqbmvCHp0aUjIZWu9nQEZkvH/y3FxAep7Bj2dMg0XstmPeJGlqxuMqAeVcgYWC5EavJZss4OtoVZGVyIBCoFlnEtL6JAuxS2rK3CAa+7rAfrqypfdMI9J3q6e86/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CIJyHdknQiV2j/HwBUVj/YthK3XmQd2QxSjx6TZRiA=;
 b=t+1dYg+txaTd6dKTHoRgSR516uTTF7vxh/ajKUlsJ8RIs51q4DzdTWHpDu5zQrXJWm/LVcdDIhvWBXnAXlfBo06qZHabgnhnniSe2d6gJcxoDYAayesu3K5qVagNG8OMomUeAgaFYG8u1otEvZo93lDW/jZq7WsT4M5TOpmsgr/4mSEmd981gIYveVt0rTVErmhhhYwcN1lJom6+4f9PmjMGi6aymDDbRnmkbPzvuk1/17yYVGwS0j7pq0Ll8xgsyD19bnDyR280LTC5cVYsbUoCwPKPxQhNtyYoFY+4OA4LZBgjovHvbmKV8tSeV5uDIPqh9q+28gcVvumi/vglCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 12:07:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Wed, 21 Jun 2023
 12:07:28 +0000
Date:   Wed, 21 Jun 2023 09:07:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Message-ID: <ZJLn/d4UHAejDSgL@nvidia.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <SJ0PR11MB67441A87771D9140D1A1F2DC925DA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB67441A87771D9140D1A1F2DC925DA@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:74::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: c77404e9-b93d-4d69-d111-08db72501529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8BrVtkxAj35v8xpuEp6W/Uty3oV9azRX6Ff6AeTLEmWYfZN9cN6Zl7mtqEL0ZaT3MASDoPRg7YnwMCLt78AAoJhsP3C4eSFwWj3Xqb5/c5oFEN7xJjmdTcBS9ryf4dkrQkij+tXOkF8IqdBNnl6bw/JZvYd3WILxPhhGw3zVqa/3JMyUQHRorDzC+UMy1WhPb1Z+jEUOETeZZdbb11h+1mBgjcZsKaG6cnK6+ac5MnhOPW/ySWjWtpOWMbN4LoZbTwY7QMyF+ZxFq3GJL1eBwnFwBOXs/X68DLsv1XuarRVQ8cgSM+CIKZ0SK1Vugy9/E7d4NNFBwlwgoqXxJZuHI83bNrDK+gET94E5pgQ0+LxwwFWwkAjzWxVkv0yKprZ93SkmeC7AQ70XR2CNSfS5FPf9sfuFjCOIFLzqr+dh+GLRxA9xxnTcO5L8O137oh4gFvR2jZzGnPzXbie48fazdGiBgMcbHaVkKuZFnMxmOYh0r2z2vC9x3eEJiUEsU9XeCMDjQx5wy0FeiHwkrN+E40teWWHVv0c26PQNhanQGi9vTGjmjdtntSDKwiMJVIPcg7KVVlM7MHIA1XwhBmfDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(83380400001)(6512007)(41300700001)(8936002)(8676002)(66946007)(4326008)(6916009)(5660300002)(66476007)(7416002)(316002)(66556008)(2616005)(36756003)(86362001)(26005)(186003)(6506007)(38100700002)(478600001)(6666004)(2906002)(966005)(6486002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WLqO31fEmnN0sbX99c4PXGA2tWdAZGnkw74VYctzCnojkGvfsqtx/TT5f7MD?=
 =?us-ascii?Q?fxG424/x61xdZKBuF8DV9dPU83seSWYxxm7zGq6UHiI2FJ34RhhELoJYuPC3?=
 =?us-ascii?Q?HSv+ltBWdWkLzNSkz04Ho7IWYsbn1APB/GJJdhMaepAEOJlDMOqILU02s5cO?=
 =?us-ascii?Q?sqnZYlhMB9k01+O50wSicaylB/1aZ1jCZvr36CVysN5OyT0IMu+jOQLY3b9z?=
 =?us-ascii?Q?P0gpO1Xum2gfd1OQ5NEmfBAzdMev3BWFwQuBU2x6xzbHW7o7mps2mn2STGug?=
 =?us-ascii?Q?ENGg/CxGI7YLgPLJ6E4Yk0LxICkLOVH2TWvaY04le/XE6fQX5JKaPGGvfcZx?=
 =?us-ascii?Q?XR+q6KdhkABDLLdrFRYnoyNcKlTQn574hEZt5qBvLijIf9apgq5iGHIgJjX9?=
 =?us-ascii?Q?A1yUxGOPPQIOpE6Js9g7eLVdmtjagZ7KiG/Vx93spdqY4+Kza2YiT3PZ6ZCn?=
 =?us-ascii?Q?Jdd+AA/57gDt+VtpKy0wMXotpRkkaGuP60OfhY7u5a2Q+gbtPLEF9pfAot3M?=
 =?us-ascii?Q?l9l6f0V/fz/SjMu0ylR/r+AtqeG93otT/7mpBpWOamWSMpbgDc2D7eSUx95W?=
 =?us-ascii?Q?56EfEVnwBgXBfGbhiHXHyvtV+vCLN/zVMsU08bfChfbjHKQdj7Zd8CjQPUl2?=
 =?us-ascii?Q?PQ1iKCrGSWevtJV/Hqlbfuyvi6Lwu9lNqP0BBK2xH++lgzQUAvUTNMpd3Lpv?=
 =?us-ascii?Q?LaUsVbxJrRwHMcW0njwnuCkgF2yqsvdFwT3FWmOYJKbdd4NtFKsAqJBAkPMH?=
 =?us-ascii?Q?afHcVMBKUY7WgR0ba6i5Oz4OdpxVYxh53xLhV3MU/OZSf64Txd9mNeIY2c/n?=
 =?us-ascii?Q?+p7LGU+RwYG1jN/dCd4ylkoF6AI3a7IKNxUxrUn2nikI11qjUExGVxz+FtGm?=
 =?us-ascii?Q?kAekOBg36H3mrk8ZWzdm75xjDZ0qSeryIsNfNTIbA+jSh8PcHjpbBPKdQ6oD?=
 =?us-ascii?Q?oRgah0Mvdg5CeYCmnx42yX5GjiUvUhzhI6bgbMtn9cfG+qAkJMBrHGvJbP0+?=
 =?us-ascii?Q?y1S+67vzByGn77CtiJb5yX9l1FFyhaJ50n9jEEfivHhHcSFFKScA590hqZgL?=
 =?us-ascii?Q?TLcD9J5BW74ca3WsPnJAoxxDShRjt/S4Soq6yzXvjnlcI+4eRj16EFf0wgBF?=
 =?us-ascii?Q?YNDfdw1xGiWQwZQB2XY9FzszmoJevuY36UcS2pyVQ9EL7c85F/BV3tS7yBBD?=
 =?us-ascii?Q?3OITS61mogmfNgLd+dvdcu4JWe2DJAGH3hnjyqCw45Apuvz745gB39lhmilv?=
 =?us-ascii?Q?bA+xzcSk88XNPR9f29NSU9PtcvCjqExCBAOIK4BJfBaIqWF/GeLIHZyR/vuB?=
 =?us-ascii?Q?EZEF6oyAxZpwPlu7VCxg1nzzbZGGIu/6IGQ1SWfHRzs3rY6m8yRKQ90NH0E6?=
 =?us-ascii?Q?L/UspbUVFNLwR7qzp3o1yt0w7CqCtu5omRtStGsNgmUybfYkrN5lyHOoCAZ4?=
 =?us-ascii?Q?6V9Nupz2bpGQDCyNpkNa688/NUD+NVdW2yGSaFca3Fv+U6bj3eK7akTLM62h?=
 =?us-ascii?Q?ndwaZ4NTTXsAjQVQquZ/3rs40nk2jlU6k62MyAOY++K+IO6L/AbU3aL8Xs6v?=
 =?us-ascii?Q?wsNNjeRpje9C/Hdd9CzgFEFc9VcuSZcOZTf5KZgT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77404e9-b93d-4d69-d111-08db72501529
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 12:07:28.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Anatfgk1tfkNOsqHSUjjSvBhQX0SR0txtaY2hIJ21+TFZl5tqlPtSfj4iHRltK3O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 21, 2023 at 08:29:09AM +0000, Duan, Zhenzhong wrote:
> >-----Original Message-----
> >From: Jason Gunthorpe <jgg@nvidia.com>
> >Sent: Tuesday, June 20, 2023 8:47 PM
> >Subject: Re: [PATCH v2 00/11] iommufd: Add nesting infrastructure
> >
> >On Tue, Jun 20, 2023 at 01:43:42AM +0000, Tian, Kevin wrote:
> >> I wonder whether we have argued passed each other.
> >>
> >> This series adds reserved regions to S2. I challenged the necessity as
> >> S2 is not directly accessed by the device.
> >>
> >> Then you replied that doing so still made sense to support identity
> >> S1.
> >
> >I think I said/ment if we attach the "s2" iommu domain as a direct attach for
> >identity - eg at boot time, then the IOAS must gain the reserved regions. This is
> >our normal protocol.
> There is code to fail the attaching for device with RMRR in intel iommu driver,
> do we plan to remove below check for IOMMUFD soon or later?
> 
> static int intel_iommu_attach_device(struct iommu_domain *domain,
>                                      struct device *dev)
> {
>         struct device_domain_info *info = dev_iommu_priv_get(dev);
>         int ret;
> 
>         if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
>             device_is_rmrr_locked(dev)) {
>                 dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
>                 return -EPERM;
>         }

Not really, systems with RMRR cannot support VFIO at all. Baolu sent a
series lifting this restriction up higher in the stack:

https://lore.kernel.org/all/20230607035145.343698-1-baolu.lu@linux.intel.com/

Jason
