Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22217D6AD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 14:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjJYMHx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 08:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJYMHx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 08:07:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0C129;
        Wed, 25 Oct 2023 05:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVdNRsWmM8/djkcNST+j+GIxmEqW+Gi+zXxFmnFdqhUycrY6ICPXXYu/KQWOGONkc9xtWp737fVMzs7vNhHWph9n1lq1bzHmY2OHe/HvNZg+4bBLd8ywlVP4i25bI1bgYUJjtsxi3IgSIhfpRBbGtgvc6q06t8fjCcZgolh3KGW+szx6wjFdcYvmOvuk/t5+94JXeEylF+S1V6C2Bspcup/fyZej0hV4+m+DR9tWXIDm7Ha+JSjhluOBoplZE+vtKciAwqQde9xeDaDQYBjkjx8fPVwXGCTuBV7AjVWaq+q/MEGQEOhfMVji448YsqssgyhRhEXqcQThfHJFso7flQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRfiab14XxlaJTMVsxiwBeEftoIq2cG5meO9ygbq+IA=;
 b=fc3fhqQ8FmSpFUL8vc92+cXczACieqCvv2UMvQ8AoeS9fZ9obHJjnUCvEUDUUwLIn9uUPf61jqU39iGSweT8Fb7ynh2gNc8iKcjKPUf55lq5qLyWUS6So2XnJ6i4T/qeFWfuov/byH067P/qyuQyqGskL+TyxZD0NfbTmP4Az7sAebl9P2dW6qQyLY6qlirQwhm4cyswpGuD94JqVzxBCg/GBQ2rdDnJ5ojRQ1/ssJma0bMHPj+mpgwp8EBbgKnWtaGbpNN2fvxDJr2WHJyZZhdfNJQ1BypSQAHkhCx9bCmD56A6PvAt8f9c4n7ZGWJYlWIihnkesOdOFnf9vHvnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRfiab14XxlaJTMVsxiwBeEftoIq2cG5meO9ygbq+IA=;
 b=Kdnsr6GdS0NZ9UWszQNTpteREq0yAw6HQIkDjvK8+pmv6UYovGRyqOnkSLouKLDAchzmVnc0duj/Mv9m07J+rCucYhWwMTnvIUTX52wXiDzZr5pKYHx0QKk1PGoZ72jABkQH3sCs9kDjeB1hYQ6h6Pxw0iSCdSEWcKp+gtUXIdsSlNq5V/UtjDi/AWSIcXPrjdJP22T/TRF07kyVBPhsV52o5h4qUuI/tvGQ8Fd0ryVY5gbUfQEAJuLr8WCIjgVD6E/mIiwlBlFTHxH8YGM0BDlhddy26p3FuZ1BCOfpuu0T0hcQqFZ/D+8ZjLfhwPI2HOeekYqfZXbEdnD2D9ODiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 12:07:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 12:07:48 +0000
Date:   Wed, 25 Oct 2023 09:07:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 0/8] Add Intel VT-d nested translation (part 1/2)
Message-ID: <20231025120746.GZ3952@nvidia.com>
References: <20231024151412.50046-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024151412.50046-1-yi.l.liu@intel.com>
X-ClientProxiedBy: SA1P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: e6efd898-c1a4-4b0f-4dc2-08dbd55300fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++wO0/N/2dbo3TKuYShOwUpwTF59xliUggYFJ0FLnTCNM6b1TbDw5ta1JynmJ68MPpO5Io9FzxZ5YYCl4sJGAB3PaLDdBxt0tW3l4Y+RLaVLJJqnFsPVMeBHOcN3oA45Gs7UdvBxMCtmNLo1MFQOACnjryvbZ8ywAsBBwsK1qZx/A2EQFHpk+LidwdOBoEN10AxBiB5Wr6RsNgfPTDj89/a0ytmY7wylq9o6yFooZLi9WH19+TwBXNDdpBmxPXrABBxDk513Ptxdhci0Nlr5hXKpadTjfYxQOzsrBrZU9kwyOpsyJib42YBNdGvDc9MJkyIzRmdWUqyfQe9ClGtmPapzS5ImrlwpshIaWkdjR66pe/9BB7lWcH3pFPwAC7mEBywHC8waO/sxU1ot7/Tw3HWSJjYNipz4fZlC9EWVhG8LgxvzE4l/svmu3KFW6Z4WQJh0OmMAjYKDU6jj7Z8l5L3jtmMXqvJA0p6FfrDuqjhBI9MfIvpmFAe/RNKeQ+cWkMKhD37hVPqSwosZJeYzX35z88APHAdAz0Mimg6hWoKIcph6mcnnC2i6zNY6cA2L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6916009)(316002)(4744005)(26005)(66556008)(1076003)(5660300002)(2616005)(66946007)(38100700002)(66476007)(6512007)(478600001)(6506007)(86362001)(33656002)(36756003)(6486002)(2906002)(8936002)(4326008)(7416002)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dTRHEMEBnnv1OI8xy3pFGoAjoHvLttHGE3Zw1mieCzoybAfh0hHDfA1r8TkK?=
 =?us-ascii?Q?CcniOrlOwYEz8XT7GWwZCq2JAueZ+sNN06Syi88MlEFwqhN2/UsOEiP++I/g?=
 =?us-ascii?Q?KpzRssG7rlUmMZ//FhmggHgKA8xOywR2X7DWxY9Vbz0zE1+YFbAJi4voRsWr?=
 =?us-ascii?Q?DXrqdbuS/ThmhwXFxPjMK6zcKE4SuW1aKtPQj2cME1oRgZWYS6if1F1KOqs1?=
 =?us-ascii?Q?rx7hqJf5xTTogIueTBQxXBdT4MA1CNDLKWc6bkauBkI9M8KFCuwBmkMJ35YC?=
 =?us-ascii?Q?ETV/OEoHhRUd58CBmYBHyzFIbFu1TNFATi5K7Vy5tl28FOIYtZfKKCq6HkrC?=
 =?us-ascii?Q?013c44+0AgvKLAPlFvjcmpwulGRJkcnKsK8QvJLi+fjG+3f/AmHzNz6i8U72?=
 =?us-ascii?Q?VagIJyl63tE+cUMiPh57yjLsWjcBcucqrYx6NIv+fGoLOda3JfbUBLaao4P4?=
 =?us-ascii?Q?27P9QxAIZQT7SRxNPULCV/kztdLLU0byUioU/DLyOwncMmYV8/z2WgAHjw6h?=
 =?us-ascii?Q?LA2vaZ42Xuv0SjAc6t8x3a6hRMP03i2/h+9oOMpCdNgWfGUZ/7OSwRypCSTN?=
 =?us-ascii?Q?0kN5zoAfpnN1m8b3PnhbyuVZbZXEyxe+s7dH/ELFppr/Z8IUMZwv1gV79QI+?=
 =?us-ascii?Q?CDnmVXXyyjdOfRp3Vss3yNuSZq/AiLdeg+YCtLrnoULp04dtl5BHhSYBnQVR?=
 =?us-ascii?Q?ohR+jn9BfvJbIUdBXUCAYe89ysrR1mliIwDnY8exDpX27SPq+1EvhJViEvI2?=
 =?us-ascii?Q?ktfzeFJ6Rx1pITIZJ6FvVBNQF2hR4uUjOHTh9tnXo714jyNHqdWhcQOvP45X?=
 =?us-ascii?Q?e6SUb5b2Pd5f5MtIRZuMG/iAHVG+W+P1kkozy4YFVB/zpPd82/+ECjDzcK5h?=
 =?us-ascii?Q?j6tgyobiZOHsXdv5klOV/jaR3RlmnKzPtKc+kD5iUvaXVweUoQYufN+A93pr?=
 =?us-ascii?Q?fI8/nlfwBzBvnbhZqWWaF8QY8087y987Ybo8BEclXTrhc9ud8kUFoG0Z/Vu8?=
 =?us-ascii?Q?bHwLizEgd1pxI1Pu8Q8tSijHxHogqsFBl2NHJfxpYDc+FTiBA3RYtEwKHG7w?=
 =?us-ascii?Q?oc1VM8Dpe9g5CEM+U0Z0lFeLnEbyhZ9filwUwCzrfZLM0drE75Qh3j88XZjx?=
 =?us-ascii?Q?/1nAcW4Dx6ep3nPE1sNRg2mgkIVUgEM9DiH1C/bX6/F3sZMs5aMInf9GzUl5?=
 =?us-ascii?Q?wzVcNX/Ya/1Y/ixyeaUdkWh33bXbjxO4nhX/OiuDg08fFuJ8yq5Rk3tJhHZq?=
 =?us-ascii?Q?8i9VfIy2qkR6yjWJibl9o0/VhFig/hvwt8L7M1nOkCenHDrSxEXaE3BVqeV5?=
 =?us-ascii?Q?9a1mdx3xEYcMhu8q48ugG4AS5V95bBT3mzxl+pS2hoilcNglNsMJST5p7Dwr?=
 =?us-ascii?Q?oD0M9NiCl5do7gpAO2gb84LcdmKY74MpNFiDMERMRDIf+UEvWbw0BGsMFZyv?=
 =?us-ascii?Q?aXc/zeLWJHHs5S/mbSTkjbah5zVJRwcX24a2xN7Z0nx9q2qfHwX5mPViK7KI?=
 =?us-ascii?Q?UWp9PMc59w9e6r/2bjIhoyKH0YZNYQ3fVh8zb7ySSOjMQHTjtNopUFs+azP2?=
 =?us-ascii?Q?PR2dtvr7uysOPKOZKHpa3PAGt6cs8tx8DTCgvpx1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6efd898-c1a4-4b0f-4dc2-08dbd55300fe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:07:47.9778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpeC6On3OCfH+XnlGif7/5Av9ZxS7hYC1T0OoYQZ3e+xLgkzrFl5yGAtQX575brf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 08:14:04AM -0700, Yi Liu wrote:

> Lu Baolu (5):
>   iommu/vt-d: Extend dmar_domain to support nested domain
>   iommu/vt-d: Add helper for nested domain allocation
>   iommu/vt-d: Add helper to setup pasid nested translation
>   iommu/vt-d: Add nested domain allocation
>   iommu/vt-d: Disallow read-only mappings to nest parent domain
> 
> Yi Liu (3):
>   iommufd: Add data structure for Intel VT-d stage-1 domain allocation
>   iommu/vt-d: Make domain attach helpers to be extern
>   iommu/vt-d: Set the nested domain to a device

I put this in linux-next too

I think we will need a v8 on the list

Jason
