Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF226928D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 21:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjBJU6n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 15:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjBJU6m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 15:58:42 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF16118B1C;
        Fri, 10 Feb 2023 12:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L++W6t4hhQbd0xpGZMRJKK+XIWfUqbu1uU/2ajaz/3KXYTLapQgPZrE8R1kQAkxjYePna9CmQIXPW8aHwzM6fTWI/X62lRfxy+QbzW4VECFn+WYmbE/tg5b9ODpfm9jieMfNhj5VRrYWI5m+dkNKceM29zTgvWvaHv7JStl2tLj1sRLlVAOOuYQFyay5aaZMI8+zycomOtPxNwgsmz8V0L0ROkTvBozC20GpQ8/PsGhBDjHeETJ66PMq79kPTGDq1k9hC3AgSOxwqUtyOkHrhZuWnkPxhH9wDYOzH/Bm3MXX7dGL9ERrK5I6OVpROk65+QgyHtYQnM+Z7xuD0Ea4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMFNtB8gQBp8yQQpcJSM/0JNe3w52R8z75q4cGKOAPQ=;
 b=D0OEIwbzaoc55qbtK7lyENkywvwDZRNr4KA6uII4JaPZKzJwlUvAWQPc2+59tBtQs9btAQJMtqwJlGEhM33tlAKLnK7LdykCyMbP4SZWswMPWnep1DQkQjP9jV5gOSRBhJSsGFI9vqzj2n9+mcT274Nj0Kcqm2q6sVJs2SUSJkBX3O3eEPfND4PbdMNNzSaB0YPYxz7h3uN3OXS7STSdhC3JIKl7RJVFsAxEXuEYdxFTjj/hO7yXcLznR4tGd2BWP3MFpcN2mrQPg0XcFLfzc9iOcRP9O8s3ypuLw1YXvZcGAssnfU97tReXx1xau95wspFMgccUnBH36ReQYMvtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMFNtB8gQBp8yQQpcJSM/0JNe3w52R8z75q4cGKOAPQ=;
 b=i8rKL7ozzc/+m6OzrtPpBcVXjzEnY5Y0ExXl0PsSWoNxwF7EFLpO97v4RVmEjYc1vRUxlP0mR+i55vkvatP4sL1g/Lb7Rnb+qWdv7MZf8JHOju95oWCj3R3G3ByMoydgL/vikHzPjPK6KkgGMm/kSD91nt+nHG+S8gAqn+CjV2iCoWghaA2KErJuuOAwYL5UdXDftTBIfNwiUVkB0E2x5S9rA9c673vTFIKwfM96/vaIhe+sYtbAyjd0EHICMOOZjdIdYV9OHm84Au97hzPhSeSl59+r2+RQyJPLTQ05yrhqTOw9anpfw2O/uW4tEgD7aiVeHYSqXK/QQXB3OWjq9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 20:58:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 20:58:39 +0000
Date:   Fri, 10 Feb 2023 16:58:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/6] iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <Y+av/j4TgmPEZPy2@nvidia.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-4-yi.l.liu@intel.com>
 <BN9PR11MB5276F92ABD5998FDD74D510A8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <09349db9-8847-614e-4c8c-1b0a15119244@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09349db9-8847-614e-4c8c-1b0a15119244@oracle.com>
X-ClientProxiedBy: MN2PR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:208:238::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3e9977-903b-4419-148e-08db0ba995ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/82OdqXVe7pH0IHwyX3gQZoZG8INU04MrgofvYKnXMH7NF2hlZb8UhkHzQADPtVE/B9vwiUT2U5my9WPlGy9t2ULgHRunq/m60xzEQ5G7a1DCiEwQ7hP1jTOUBo2lxHEaFVpL1ZL7IgEiRpxtx7LHsxuRmMzASZmQgCqovsnJBZCqxbeJDGpLE68LfVdo2wpgbI+CryjuIBUVcijz6H9uvzsmNnzUcSWPJKY5x97Sat2neEt+FF46bqTuenitU9nlhxAkCfFRsOSxWVjuWsPuCNtXL7hxWiTqqYWdGszy3Akt/8+Wc26glr1bm2TkaNDLsG0+bq6VqavoWCmVsb++Gw2f49Q+BkPXYnd6Rir/6to87MxRkelO2KZKtdmjSJKjWWdVBkJkzarjQP2/57T0PbYx/+LH7mMG57VUvx5/8kzoL8GbDpvo1Yx03OiHovgyEr27t+HnMr1QC8ItE3VdDEln/pFo3Kg7VTVqm13gwhtYgUVry/LUgw9HIraHdE8cwC2Dyjr0SnexwGWY8T5PF18VRYBrYSCAaqTmv0aeHfwSHORQelnLmi0WjgJZT7ViiAbnjrur3lBSKvMOBX3/IV+0dIQ/DcR1vXfUAL7nacpX5eZJg94wmSius2yygIw4i6wY1FoWXTLRVv0uxhRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199018)(66556008)(66476007)(66946007)(316002)(54906003)(8676002)(5660300002)(8936002)(7416002)(41300700001)(4326008)(6916009)(478600001)(6512007)(6506007)(186003)(26005)(53546011)(2616005)(6486002)(36756003)(86362001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m/uQdyx8AS48GZTyUh9svX6fJjWLfyO8poVlfreU1Gx57Grq4MtWTxwHoulI?=
 =?us-ascii?Q?NFdznf3TF4yqGlYLHfEWjK8k4Z7wvmN9JlV7K0wxrEWlsuaEh5k2S5c5i7/p?=
 =?us-ascii?Q?fsTR4g9evMuPccDjoARfegsqh1M0OyUYkDEWRqnVBsnRuKyv754LcWe4AnE+?=
 =?us-ascii?Q?L5cW/6UTTdNBguI6dfiUFAmK5VhzVBoEMgkwQO7jc98OLBi23BOipnL7nTWH?=
 =?us-ascii?Q?I8U7zwJVnO/RyjmStinGv7R3jHWOxB4ox8j7XWAC5DtsWYV5zgp1R9egcFNv?=
 =?us-ascii?Q?dok5lN2GLrfWjk1v+rGd2M8+MEQ1hpIuPk6rIqzAfBzOEN4AXy6f6dJXMFss?=
 =?us-ascii?Q?sFqwOQFF1f1TZPvKc8CCId1AV0eSkEX+p0Pt5Rq0tDahLx9Mn6eyXq9tErUc?=
 =?us-ascii?Q?zKhuK8gl5ugAacizNrmcHGiB0DMuJz4TWTx64AU59craQ8UO5oRoS7shtwQQ?=
 =?us-ascii?Q?SIUsip3KS6NQ3eTOCaXvy7jCHKybcHfVy64yA6Dr8v2cORIp2E7si7ti6HHQ?=
 =?us-ascii?Q?hpznZ6KEY2mx9725ILumkoSJ8K3hYrnSQ6h8E1q4RBytTOOgAdWhlZMatFWS?=
 =?us-ascii?Q?fhYSbQ7mKSaXq/XDhIaajK8bEOvFlM/d3qoO2/LYpU6/VrvxJIk4o7G0bI5u?=
 =?us-ascii?Q?EgtNiUgQyEqp36SbTIKkm9xwRFCqrQ2o8PRi75FwB09rzKooPP35VjOVK5HT?=
 =?us-ascii?Q?WXi4Qzywui5zENGBGhT6L2WwzqkGhhD2XjjI0cu0y9Z0np3WLsL5tJ0noHQr?=
 =?us-ascii?Q?V/zbeoL9xYx5kHYZ/aKvMwFP/RSNxUlPJji8je1ktLqj2D7uNEN5xkRDs0jq?=
 =?us-ascii?Q?zFVQp6AZubpJzBdTDKtBLUi2Nvjj6J8X/tudH/b+o3wNiu5qa+9z3FNxApEg?=
 =?us-ascii?Q?mJQUJKZ9mNdGzs5tT0sCIsKV2EJ76UBFFlfBBrqHCLEgKbW3v947fk6JPe3v?=
 =?us-ascii?Q?uPxJIkO+n40ndaWXaCSjpfHVOv5URSf+72i2utKLb86AEZ1Lh7DSzpST8BH/?=
 =?us-ascii?Q?rlMiPCeiTQ+86AZGKmB87NkKO5BkILoTEQRcK8rQI353xNft640vhWHCOe14?=
 =?us-ascii?Q?YPzXVGXDU6deyqjgQ+mBSll8W4HYM2e0IP38g1FpuyhP4MLhgppq7psSVcO0?=
 =?us-ascii?Q?1XPGKF32GiwWbEx3A+JBtDLKtd5Y1x5c4Ux4QYTDowhN929cYqCxXI2nnzzh?=
 =?us-ascii?Q?bOFUhI2JyBsbWI3rdE68HXBXXL/E/8gfIH+PKzWoGP9kgLSbl5QMQm8TPEQx?=
 =?us-ascii?Q?8dTLdBOP/ev+wtwQwe9lBPZRuKP+f1LFSvOT4XEuEs6gIXojTaH75DzXnz4m?=
 =?us-ascii?Q?Qba83XyU6xm+i5eqCMW7+YFBG0KnsUNsf+JhV8L/eKcxDqoFpx7A5gu0TBE5?=
 =?us-ascii?Q?2ODn2sSf7NzcCV2rKTg90dJI95yj1xfauRywJ21n/aRQfUS6FzE08RgLcAZs?=
 =?us-ascii?Q?ZvBsrtmcdJ1E9QeGAyzT8LTCd/6qXLfxvJ7mjlyRmHiJmsnZQfKmR/rVfe3H?=
 =?us-ascii?Q?MzRN2ZpF5qg7LNbSnzX9ay+5t6yqlXEAi5Iq0Oxr60+joAYpvq5AjOfMS5iT?=
 =?us-ascii?Q?L1X+J/b/Gm8WE1zDejc9dmqMoHJI/buS0KyphyZf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3e9977-903b-4419-148e-08db0ba995ba
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 20:58:39.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exc2u20kU0EqWTCUVgXx0cGvcccWhELKjfRCS5/mmfGDN2nIIj56iDroiGrjuogz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 10, 2023 at 11:10:34AM +0000, Joao Martins wrote:
> On 10/02/2023 07:55, Tian, Kevin wrote:
> >> From: Liu, Yi L <yi.l.liu@intel.com>
> >> Sent: Thursday, February 9, 2023 12:17 PM
> >> + * zeroed if the user buffer is larger than the data kernel has.
> >> + *
> >> + * The type specific data would be used to sync capability between the
> >> + * vIOMMU and the hardware IOMMU, also for the availabillity checking of
> >> + * iommu hardware features like dirty page tracking in I/O page table.
> > 
> > It's fine to report format information related to stage-1 page table
> > which userspace manages.
> > 
> > but IMHO this should not be an interface to report which capability is
> > supported by iommufd. Having hardware supporting dirty bit 
> > doesn't mean the underlying iommu driver provides necessary support
> > to iommufd dirty tracking.
> > 
> 
> +1
> 
> In fact this shouldn't really be a way to check any capability as we are dumping
> straight away the IOMMU hardware registers. By dumping raw IOMMU hardware data,
> forces the application to understand IOMMU hardware specific formats.  Maybe
> that's OK for hw nesting as there's a lot of info you need to know for the
> vIOMMU pgtables, pasid and etc so both are tightly coupled. But it is a bit
> disconnected from what really the software (IOMMUFD) and driver can use, without
> getting onto assumptions.
> 
> [Calling it IOMMU_DEVICE_GET_HW_INFO would be bit more obvious if you're not
> asking IOMMUFD support]
> 
> For capability checking, I think this really should be returning capabilities
> that both IOMMU driver supports ... and that IOMMUFD understands and marshalled
> on a format of its own defined by IOMMUFD. Maybe using IOMMU_CAP or some other
> thing within the kernel (now that's per-device), or even simpler. That's at
> least had written initially for the dirty tracking series.

Yes, the design of IOMMU_DEVICE_GET_INFO is already split. The HW
specific structure should only contain things related to operating the
HW specific paths (ie other HW specific structures in other APIs)

The enclosing struct should have general information about operating
the device through the abstract API - like dirty tracking.

But it may be that HW will individually report dirty tracking
capabilties related to special page table types - ie can the S2 page
table do dirty tracking

Jason
