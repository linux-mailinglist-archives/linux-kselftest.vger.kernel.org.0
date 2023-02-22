Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9100F69FD7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 22:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjBVVIP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 16:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjBVVII (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 16:08:08 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F2546150;
        Wed, 22 Feb 2023 13:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEws8k0OXV/S37b5ei7BAGE81kVR60XH+GR1Y1PLsVy8dZbto3/iP3rL754A5jJb/9tPJcitwYUBUB4phq6QI1zhkMWw6jrsg5WehYKJY9ft2qUHzZv0yhOda4zMyTfQRrwBqRh4gD0A6HfCYeQLHB6BOCB707RfUYIEK6INF1QVvT4lYVcVX27T4tOJicZwriAu4XWO14QKKyKK61qEmxCWA3z0boD14J2KDv0enEKXIBrk2lN1He1NfNGSBctu/BLrbWOXsM+cLYFrFz7UyjuW4JtDDWVLZlh1pGKffPJonJEIc/Koa0QjeQqPfDeeXuM3JbNyP+Gaj+OIOys6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQRZ6Nl22+3XdCRB5n88HRIDKaDRFW5MHEYwCdnJJHU=;
 b=AVe1MGo/bHX1NtBLWGdcezcqxjy+7CK1ToaV9jw0Pc28XpwhHFjE7/R3su2SEYZpU26IL0lZdi03MgGY2Lu5et52ZGIrlz3C3UMaZVrdj3pjwb1hfNe80QIJ3TF+0JWe+jsS17W/M2lFudlGy9JUGDPod7AoiMfKkmMrBbWiO3MHmLt7lc59OtW7k9wzzxURWcTv7EkbC5aUlzwZtxOwIuqMXXz8ZDR/NFGpRl6VK19d37oHKvHqqotniq2v1PIIkEi15sl/NSzBDNLNo1CbC1vLsaf2auXIdKhpOM9Jr6Psp6MURsZRcJB6G1t/3g8k7xoJFQhB9G8KevNylSSVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQRZ6Nl22+3XdCRB5n88HRIDKaDRFW5MHEYwCdnJJHU=;
 b=GrWz1mbgHbOcFVXd5nt4e3WFuos7oWEI8Zifo0A7DYRVzs3MpIO81Rbsr/o+yrxgk3YDcEIn8BJJkX1084p4DM5MpkvjdEnd/ycFe05nFo07xunoUGQbcvMlUYVw3wGpQWmRXVCHD9Iwlb/yZL97P53C61ps4GfIZjdF3A+tUii4TLeHss/swjl14+neKIRyRdtf+H0cftYhc1R9RKIpG4ww1nTSdIDsjELL+woqdnHvAxBb7XUKqPMn8wz5WqVFohMrJT6VoFlcNCmL6MqLEMmL0u3vdcLTTYTRkB7JSyxKHn8LnrwFFXIjJJGoT/QwPeZGCBfAdKH8RULrlebrbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 21:07:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 21:07:21 +0000
Date:   Wed, 22 Feb 2023 17:07:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH 0/6] iommufd: Add iommu capability reporting
Message-ID: <Y/aECHpCo4LJ1Rw2@nvidia.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209041642.9346-1-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR01CA0010.prod.exchangelabs.com (2603:10b6:208:10c::23)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a33f696-4aed-45f9-5ac3-08db1518c9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfMB3HoQIHqWkk5iqyBTcOfNwp91L24gsps2ZLe5wN/X5QZ5v+Mqp2XCdzqvkKtOsp+JCGD+gFDCoh5Obla6IFvnBoZLVqIYoUldFZQl0Q99zWZzZ30YhgiSK0F8f4Q6GbmyjBBtaXy9uJRbmH5e7/t05NKeohcltNUCg3NevskgRGBd73MBmftA8kpQ12XLrlY4Enjfv6kH8DaK1jTMKCNWNhlQxnmSjfCRFMWLZ6Py5adKtXq2smfh2ltiVE90GZhF0rWMnTYy7lKRmSdSxobEtiP6gHvWNi0HwzK8SaQd1v4jg5aOZQ7y9c97ItSsnevdtHuHuVVTpCjUB0/GFuTQToObEZ2An5G7++lhu3cpYJH+TdsLG/mxcsntAqADRlw3T5EhuhI8TNTj0tMaICwKDFnRCaLBb4dEL+c/lJAWrB/0cv3UdXbnt3pFnX3oNiDCzsiGklXWW4vLz40UdF4dLyK2+yU3mmJwFoQLUAvgOjS/faM7HfxTKWB/gRgpWrKRh4Pq9V2nC8T6eHu0+ggMuCujXBWW9XTZbuuziML5RFiNLLB3V4W0yMFOg/nEdY7Oy52R0PiAaJ6yrizzihvF3+whfgibibu3nv7dTB1VRMn5nP9NjVNh/xBD+oTH9mXIGRjcmPza9B1QsiXXSRzcV76KRLwdcwJN6SrRnskz+JmgK0AmcxJuxfxAighjux3FwQnIsIPweiiqzJJRNvkDCyFDtnrC5fkcwxEB2lA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199018)(38100700002)(2906002)(2616005)(83380400001)(36756003)(186003)(6506007)(6512007)(41300700001)(5660300002)(316002)(26005)(966005)(4326008)(6916009)(8676002)(66946007)(6486002)(66476007)(66556008)(86362001)(478600001)(7416002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9z3qYQyJZrsGPV/Mm+iOAqscA+4JAa02np99J3Zc/lW7gGNJeN5TXHiQEsCh?=
 =?us-ascii?Q?hXi/5XGZCUWCG1lRyQ+hmp2HVkkfrPwGEViosfsK+qP0BCg9l58AsSYU69lr?=
 =?us-ascii?Q?4fhL2BhaYGV434asPpoL91U/cD2QUbfx+cGDAkbIWoV1jadjyfGCecCEs/9k?=
 =?us-ascii?Q?4FZZ49OfCrwK9/HX3OdcdV8DyUWMdfmR0FN/T+euy202BL2XDNQbMwEaD0w/?=
 =?us-ascii?Q?9pFZwvKID4Rnn3mH+QsonwCAZH2ys5g9pm9DIcd51MRC1o7fRZQF+MNGhQe5?=
 =?us-ascii?Q?MOcETgdoMB2N16ezgAAlroJcU1PLmJglsY2lOrPOMUqeLJ/oZwAPxnFBEfYU?=
 =?us-ascii?Q?kxATM+CvbTEDxhb6IqxqWIqm3j90cDAYiz7R0wmppCZqOVlSNlSHnRrZUnNy?=
 =?us-ascii?Q?oOGXms9CIb4CXzqhWxNTt3H9isWs6ynUrN+a7yyL3B8NHhDBuZOaAIJeUrNu?=
 =?us-ascii?Q?k+hLBtm3af6O2lkxz6fGlArSlXKzz1GWTjb/XLaEuTCCQp+wrhDSHwUoWpjY?=
 =?us-ascii?Q?2AB9oUhFm9yNbcKVNvXHkoEQjEAQN4xfRms+PkfvzPDcFQWjFk/DECjbNXKQ?=
 =?us-ascii?Q?ktIaLsPdeCKx1mnQtGicLhC0TnXRu60WjmXDQmN6yHSbJ6VKHNO/Xq4uKxig?=
 =?us-ascii?Q?sjqq+zDtCj+vjGGyqKoJKX3CeeBPbNNkL1UKj/2lJfcF4YVDCoRjzHvhyAvE?=
 =?us-ascii?Q?WG9ZLjnCnlru9R0YGzxH/kIEuUDuZ1Gr1v14Bp+MmQFP6X2uepL10C9PyrRI?=
 =?us-ascii?Q?206HSb15n27YgAS8tCGyKV3qMpki4DHm9ZgrX9v+sn3eC3rByVsBcbkMgD02?=
 =?us-ascii?Q?gZmVkKn9QfNcGL06DhBLz0Foz2C6kjWeA87ofqtRTNaGTDclgRfVwaLvRz2C?=
 =?us-ascii?Q?eU1akJvyqj3KEJJALLGu8r1qF1N+XwfzoAk5RRv78nx/iIKnPv0kZJRw32W7?=
 =?us-ascii?Q?cCGwMHCcPsAK1KlNxy0hTQDKkzJcmoMGPZJIdTY9Bk08atOtvbc2phlNH0EI?=
 =?us-ascii?Q?s4qTnKUmVKOYnrRDic+YTkqCVFwh8wqtmFUGgE5niUb+JvSJL7vczZ7DikPl?=
 =?us-ascii?Q?LEHM/X328Q2yrIzBeAZLwP/3yfkBfsT/xn9r4OXVx/kiqv28uJkmz0jMNAxl?=
 =?us-ascii?Q?lBWYTMULqUnZ7pY3nWAy+NtKbtkmBiIdCwtFf3ooZVBAJ/k45EWJr9DL4vsM?=
 =?us-ascii?Q?isREGogY5o4zeOWrKjVea56+r2RD2QOJplWDLo+eC/PNq0pGqqrZyfXJ8Cbg?=
 =?us-ascii?Q?GBFotNwZWZ16d1fKkLe3ZaxJ8lD2oVO3IeiMep9GkKwoyVjylLLAcrxci5y7?=
 =?us-ascii?Q?jO3yhsW5yT9azq/PYv2OYJGoSAmNxKz+8b6NIhNFHcytCxVUP6D49RUhrFS9?=
 =?us-ascii?Q?2h0pRF9r6t6Ler2BSBeX0PcK7q+Pq9xsnZJK30XikPkuHzovCkgKJONT84jq?=
 =?us-ascii?Q?d8+NLjS7DkgqCtH4MX4ZPOaIiXJ8xtPZsKIvUsLe9YmsmqFW5N4mhK5XTLcS?=
 =?us-ascii?Q?9bnwKY3Z0FnlS5+6mH92YOQKzm4QctjQSHYrcvtHF9GhPLin+gTPTIZMkDeq?=
 =?us-ascii?Q?bng5HVOdcwyuWzW2bp06QvDHPcTn+XZDZ6A9iSoi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a33f696-4aed-45f9-5ac3-08db1518c9e7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:07:21.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6L1aL4UDdMaUSvtAc/IXpqeoBxoXI/CUxFCriodd6SKW8sjYR4yhpatblU8vIIC2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 08, 2023 at 08:16:36PM -0800, Yi Liu wrote:
> iommufd gives userspace the capabilty to manipulating iommu subsytem.
> e.g. DMA map/unmap etc. In the near future, it will also support iommu
> nested translation. Different platform vendors have different implementation
> for the nested translation. So before set up nested translation, userspace
> needs to know the hardware iommu capabilities. For example, Intel platform
> supports guest I/O page table to be the first stage translation structure.
> 
> This series reports the iommu capability for a given iommufd_device which
> has been bound to iommufd. It is a preparation work for nested translation
> support[1]. In this series, Intel VT-d capability reporting is added. Other
> vendors may add their own reporting based on this series.
> 
> [1] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting_vtd_v1

Let's have the comments addressed and this rebased on top of
 https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

Which should address eg the selftest issue

I want to start chipping away at bits of the nesting patch pile and
this part looks close

Thanks,
Jason
