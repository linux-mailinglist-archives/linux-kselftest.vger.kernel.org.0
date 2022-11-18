Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AE162EBE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 03:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiKRC1e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 21:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKRC1d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 21:27:33 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8F117880;
        Thu, 17 Nov 2022 18:27:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/drKptvTOZbVtO/vxSelr2ZnF5rjG83TA6MdVAKOsuFRPS5rUAk4MBU1RYVNWPHekN5ADf+DKy0VzEW9LxV+JLYoPJDOxyeTh9iv2mfsjSg0VT3+C9+93VUGIX3QpOxEUaMn3mGBH681hpOP+2vCSGQMsrx1RT8PzFouaK0+Odj7Mnr35te6WcPidq8OLL+jYV/netTTdwHAGT45dWk6gRXcedXtX1Z8XzkEssck//W87QN/v50ZQ7F6WZ86neRQ1DEAbGgm4iTOuPX8KJKStzulNBbk1b55oNAd8XjCiU3ZprSqUpVxv61X2qgJwfUS+II+XYMOCt8f87tEMi2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJW501ICwp2dyy69+ccuWDN4HZ4lium1y7bfZVpwBnE=;
 b=XuqtrK/hHPBzRK4fZ9mVaS8KC0Y4gybFdc6d0AN1jSqKvp0Qj3J9nTIVE/PKfM8SlhF7/1LJt2sPTzccVAvDEJXFqHdNtSHSN0BcIHgLFm6z7XsETtgj7EBdIsxRt1+hDd9hy+ILT7StZ83DKL18h8QEnKMfT4Dy9lYXlOeRjAlzTc1r0N5Rjg6B1NH+1pWXC5oLVJN07TLGeGh0y18r6Vwmq2Fs0b6CNvjmzID3cQTYlLU1F7elVJyW8uTWKbCBx1y6yjskgyrNJZN5hVzqi0aijufWqe/bRJ+6C5GsfIpkHvNyHZGAapemLMhpas1QmQNjT6fMHcFjLnPtpsV2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJW501ICwp2dyy69+ccuWDN4HZ4lium1y7bfZVpwBnE=;
 b=jB9gTUrwdun/i8SrSGT5y9We3vdnPSSRL4s582wrNpTM0x3yl5C+tRBLXxdF1CSGkb4adO79fSD7UoRJb2SFjD87X/+1RtYCvEJOAykxhCjf9DicxXDVo23OeDVJGb6YS0K5L3+LcbdPtGGoSQIRyJm6vZ/aPWydZhhXPKu5ES1Z+PTEUOz8pIeAkV8VFXUszBjAv+WjtvA95ClBo4tviat1z/SARoaYxaHKLmykx2wdWjJXntm95f1bCzZVgPe/CTvO4F5qm4igviDksPdWsBxX+2Vu8ct7kjFMH/b68CuT3Gc2eAV/3n2D+cZSb73a5Srgg2J8lssSqpCdbF2kCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 02:27:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 02:27:30 +0000
Date:   Thu, 17 Nov 2022 22:27:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v5 08/19] iommufd: PFN handling for iopt_pages
Message-ID: <Y3btkI9kvCLDK0ul@nvidia.com>
References: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <8-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <BN9PR11MB527690223B13E5B57AC6636C8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527690223B13E5B57AC6636C8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR20CA0063.namprd20.prod.outlook.com
 (2603:10b6:208:235::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 97babe43-699c-49de-1cf2-08dac90c7153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6bQeRhGZsFqPyQWyD8RDrwGs+MS8vXp9UGYqm+UWOlmny2n06jZoVv0hoH8jvVwzhtO6HMBlKjxhEZt++HLj5aAAjkbB98+SziXpO+PqxdJQnPYVyvlhAbzlYQFzTYiCMcUv720PJm5jVAFWue5Fd3tKlXvFOwAoPVyYDZap2fYoUYHSabm/qY4MH5ywlH4u4qjUEwEdB4iO0t53mg3x8GwdL/UAdrScRY180wGlBXfJVovEslyF6T9gTumfJMnzdb6ohKx32zXm4HKZamQWT60kyMqM5DXdVU6MHmGtw2U/b7L7bkf8rjvUaSWZdNUovDZ/4FG5iXNRKSTNHwu3XtcYmIHNPewvYtcPWM5VaOJrS/o8AvG+uxmi1yar1zKzqV9VRpZV7Xo57iJiONVon2EK6Lp/fwfFpdb/kCRzD+c/VuXlqGBIS0Zg30Mnbrd78BwuHiA9AuA8tgEj1rYWvd3ISSdMjLapkrNhE15Tjg1m41WM4rQcEhv43Xl8EnwZDUET+57Oi7AKG5N3qLSIZ/eN1Fqd4K64b+Pr/DjRDcm+F6KZBDaAYeqU9JnUfoezH5CbpZHRU6RLXhl05O3wMiNpPLeTHkkdvmQ4YcCewjm5Ogg0xehFdWhz6ESFyP0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(36756003)(38100700002)(66946007)(7416002)(2906002)(4744005)(7406005)(4326008)(8936002)(86362001)(8676002)(316002)(54906003)(186003)(2616005)(6486002)(478600001)(66556008)(66476007)(26005)(5660300002)(41300700001)(6916009)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9IwcaOu/RTmrpldGNljJwbzcTen3RzG1yYnM25cYn/t2N1i1MgxzQdfqZ9hI?=
 =?us-ascii?Q?FXsImiKlYUmbAhwCSUPtsPoj7piYnLDnRcVUUPe9uRg/pf4M/3oNaPZWRiJP?=
 =?us-ascii?Q?Yj7QzQQKvYWagv8QZj78B8N4GSGtZJNMvz8IiyY8JtGAPiz1DhJ4ayKD8FeJ?=
 =?us-ascii?Q?2Z4asNur63oufvlMADu1wX7Xdly6Q9cx/Hx7maEKUTENaPIbhWFrXmCuviir?=
 =?us-ascii?Q?aqgr/EPsrgpJ34ZlUp5XOcISrgOYBIgIXbQgkoQwSpNpFfzT8OX4WVaWxns9?=
 =?us-ascii?Q?C5LYmlVz60gGTZfAQA4oQq5V5D1ZpSt/IJ75Qf+z2gQy9galb0xDVi9QruVB?=
 =?us-ascii?Q?9x7tNeIoA4h891o9Vys2KSYfVoBSeoHwrL/nxHEC5SEG1AnzjmBydd4+MSXQ?=
 =?us-ascii?Q?FjnF9R60+SBTlrnTQdCm4ddD18+7ampumAbC0rcG7fDYPtmMUL+T0fr90y6W?=
 =?us-ascii?Q?pJ0UBKaPduXdjdwm2aLuA4mcDOZxh8lUMdb/B3DVw/mU/Mi7Kn0gloDz7Eb9?=
 =?us-ascii?Q?nHmmuuDO4d8Mx0DZ5pWZIFfPtBzI1djXoOM9/xqyoUbfKvY+mwXzRLJCYOgd?=
 =?us-ascii?Q?Zl6cCrltKU5qR7gooS4Kv0biUshJRZTa+9qnud1VJ/xdIB5OuTkZSCq5OqBf?=
 =?us-ascii?Q?hSJqnErYKHk91hQ4y//v064Yjyw+oMGDvTq5y4gxzo7bwDiARKFm2ht0iFMQ?=
 =?us-ascii?Q?3MBXZu0pEqkwh2GMS3uxbrvBxH64xq5s7NfZdJZAdffn7k/HEharwDvGwjX/?=
 =?us-ascii?Q?A9vOBDyUaW+1QHqIj7EABpujr+wLRxnGZJq31/ydG/1yg3JfRFTQAvrHqlMM?=
 =?us-ascii?Q?0SEPJRIBxEG77YP+HYDuQIqwFPp+KmCnGClINYU5izVc00DSqW4z8syoIFkI?=
 =?us-ascii?Q?Elk0U3IkgJ0F1smntwFhQspxgmc2hkHZPQyammR0uFsrM55nkIrIueXMs/QR?=
 =?us-ascii?Q?uMgXWd/ESnZ2zdt9GLEOCRIwdzUa4RFUIP9x0/zPs2DFnmyIgqukjoxVZvcl?=
 =?us-ascii?Q?WUZI6HmF+0qkb7Il1IcRQmWY/wH/q/xEmSQvTf5rmwvusDzgCI8VOS6pGNQX?=
 =?us-ascii?Q?eSXBZy0th30UhxA/7eBpjysB9tAlwQZVtjhU/PNgoZuQX2CskEbuQ8W8ztkE?=
 =?us-ascii?Q?5L0txfxsL+e/kk0hx4fXQc+iEYSG1xRi6i5SUx01IEqED0Z7Q4VZh1ixVdrO?=
 =?us-ascii?Q?4wCqMHchNdbj12RcmT2rNI7uT2oVni1RN2H0mGMO5RIfHUQ4PVVowhIUe7q1?=
 =?us-ascii?Q?tTVYTSVgiQrtMjqsQ6fuO5lGYACfj8fS+c1XUcyVFAjNrtab5aK1hqoTWFW2?=
 =?us-ascii?Q?PKYRBUeUeDi9vNaCBd/OrijhYQQ4rIYtrudUf+3UVDWRoPCJcV9udAutyMzp?=
 =?us-ascii?Q?oHe9+6Fa+FfGLuiurRl24lOODsmaCGeyBNwwYiAdxKtpTVdeg1RU+H8PYmII?=
 =?us-ascii?Q?pXRqa+tqaPvdUkCQR6UPr9fjG0u3+Tf4DW5NFa1C1plSBuSBoISyOdkNC1Od?=
 =?us-ascii?Q?jJrV2gDGnqYaJ+kBnUEyHgTqpAx9775rEQytz582DLiUJnk99/fPZelgAVXQ?=
 =?us-ascii?Q?Z9m7N6kDCC+YpD1yzfc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97babe43-699c-49de-1cf2-08dac90c7153
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 02:27:30.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xS1yBG/kYC+jPHIIx4uD6W8MWACyvJG3IAXKDtXNkYWVpYTyHu9q/M7tLgIxxxNq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 18, 2022 at 02:24:23AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, November 17, 2022 5:01 AM
> > +static void batch_skip_carry(struct pfn_batch *batch, unsigned int skip_pfns)
> > +{
> > +	if (!batch->total_pfns)
> > +		return;
> > +	skip_pfns = min(batch->total_pfns, skip_pfns);
> > +	batch->pfns[0] += skip_pfns;
> > +	batch->npfns[0] -= skip_pfns;
> > +	batch->total_pfns -= skip_pfns;
> > +}
> 
> You forgot to add the assertion which you replied to v4:
> 
> @@ -239,6 +239,8 @@ static void batch_skip_carry(struct pfn_batch *batch, unsigned int skip_pfns)
>  {
>         if (!batch->total_pfns)
>                 return;
> +       if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
> +               WARN_ON(batch->total_pfns != batch->npfns[0]);
>         skip_pfns = min(batch->total_pfns, skip_pfns);
>

All the IS_ENABLED assertions are together in a later patch

Thanks,
Jason
