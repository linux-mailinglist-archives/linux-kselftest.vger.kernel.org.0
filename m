Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C54621A9E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 18:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiKHR35 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 12:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHR34 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 12:29:56 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9621B110C;
        Tue,  8 Nov 2022 09:29:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9slzge+P0vbEtpIJeiRYiFgVXouvZYSSPqIt2i3aETtx5Pn+ybieOD8MGAQyDCUoK3LEdlbe20Le63wplSBWVRc6TOJKnloGUwra+t6BXku0CGoMEEizWRVxHoguzVoJ+V+xAJfgKu7BDPAyi/qVcf9tD3aXWu74teTVKDxscWsxKIHikdjmRyrZ5TEV7eWDj0DUhNX3Ofj0ZB1wOoWc7GWOo7daSGA5WaF3mycYSbmowU2jkzhyhZrH0o2r30alma0TayoZLfC8U4qhu3OwYVF3w5KDVi6MiH7GQ//1BQdpNJddK4+l0y5eecyyK5gTtW8u4iLQ5xNoHvu/jSdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+w3+zwj93c2hKaRG4vJzUcOyhcWKvRv87j3AjqupI0=;
 b=ElzJ0E+AKG1cl/zx2DUOVyZ/jE44TgU7+RvmQN0ddO1BXlYjYEie51oLfGNcKcgytA6VKgxzahPFDgtQJa9VGxVYGV2YIfWicze0t6pZpHNUXeuc/3BhS79Ovq/HdpkRip8DB0XJFVWWWOgeOy25zzprfBbFbgkj2IextnOsS2CN5myJejQsdG/KXZiYQok4hQ0V124cl6J+fvtjhpQmikjwVSCfurXpsrqNe9Y7eUfONmIJiJT6CyNORyJqV7/q3AZQjDwqQ2YEmwXqzxJGz9Abq8m/DNYKS/MzU6q9dAGmbM9XSS7GtzTtzQ+xPdriAVsVWNk3oLpQ0L1ESPGOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+w3+zwj93c2hKaRG4vJzUcOyhcWKvRv87j3AjqupI0=;
 b=OI8CoNoOLTqaEUT+syHCkrTmRT95Fzd26mJzS0m7h2NNDPE7ZeWaSk2bAg5VqD6APQjkDxerm5PtyGxbSMDjB7JnXnNRBu248kS8BVdoEkItAnFdwtHeEJVlDGvZ+j1asarSeqCBlPF3BUnoeAN+iss/0re2odqeTM+u7LZIuPJLGzvfPEXqshKU9cZkKWOxSZ+RMFfEhf+49KZ0DTIhJcLTJW2me0WxGb/MrghcYSX1vcZcszIJedDUqoACJo5C/O13SK7BxhAd7G6eH0olzdxsX9YSD3Yg2/q2l430/m1rbUeUjLOq8Fw+e+ut6ZkKcl9q1YyOFKiPc/QxC/q2NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Tue, 8 Nov
 2022 17:29:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 17:29:54 +0000
Date:   Tue, 8 Nov 2022 13:29:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
Message-ID: <Y2qSEVu91SOfvVmO@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52765289F880B8A7297077318C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2kd/Ptt0iR6SGsh@nvidia.com>
 <BN9PR11MB5276706B744018EC6E36E1128C3F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276706B744018EC6E36E1128C3F9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR15CA0064.namprd15.prod.outlook.com
 (2603:10b6:208:237::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: e034aa1b-2e73-4d1b-13ab-08dac1aed93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szo+3HO3bqs3toT9tIp5NDeqA/CaKwIFJyvPBAy6Zh0KNLD7ffNHISteQik7t73upX/gKgvbBpq7BGeNF1hC2wfFkQwU1Yp3cebd+jnvvvDeUjsYX7n+9se30H9iZdztc2hkFRIfrQJcaRIGV87MwqhiSr2tem4bFnXtRKpHFDoVkMizYTG7YKWVt6KJZ/vLfVrQEamkMEue/q6/RT/vQQPSlhye8UVSYvW39UlADqNTlY0WF+iVw4l4YPlKl0Ckkh8FghZmGz17DitsQzOe5Sle3SrWFbuGXgpM2SyyWm3/AwEy5ua/KYtOKkVhTAfIw0CcHOnACkQSOKgaT9SzD8hCRsma87T+kewozk9lu5cWF1Z/gizhcJ4hl8LhYgg9Cu3RMV5b31LFBwz02zDj0y2v1RDr84O0BbmDKoRXQgU+QD58bo1WQbiYA1bn4eFtib62a8nGLt7580GbRRAymjhIkLJrAofv4fzjWGJHRi7+91O1VgwmKRFlS9CdU0slbs+YkObSsSyT6fFowRAfvO6stsJohYxT5Dm468Sw42AyBYzu+IEKWRJA5iWDXzvAnDSY3AKA0GoMqPJ1T7Xdq85h0Umatv7ZJp2DBSYnNMLlV3RbsHr8qb+2XC2EPBihF7jab1RmuQwfm7xUiaFkJ/GSP40VSMxSa+Y3m/UfhKhOl1vLwucAj5r/2WKg3DYs4Y29jW2P51EKs26hLRa6LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(186003)(478600001)(2906002)(7406005)(5660300002)(316002)(41300700001)(6916009)(8936002)(66556008)(66476007)(54906003)(6486002)(7416002)(66946007)(38100700002)(86362001)(4326008)(83380400001)(26005)(8676002)(6512007)(6506007)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4oowAwkn1Vr9yfrzfqoiHlOPQ5z5IjOg2frC1x3zLDXcn7un1kKhgnm5e3C3?=
 =?us-ascii?Q?NB0VU6JRPN2wtZlIp+MwUQ6VdqCUSJLhqEyj4+2F9GF1jZJO9j9+v1QFMA/B?=
 =?us-ascii?Q?+GFV5nOhpwo8Grk9+yLbZQr0/RYgJqNObN5imbOkWFCKRZ9PRlj6LPZNQvvu?=
 =?us-ascii?Q?EKUp0wqgikbGotm9/9jxcCqMfYHodvawFECYylBIaagAPlntgtc0iS+sxDRv?=
 =?us-ascii?Q?cIZqiir3TaI75OkjxLaYdhiYT4q4Tx/1bHvzZJ0aZa1pfgdEoV8ZdIpkX4TJ?=
 =?us-ascii?Q?Dy3tsYEgcgunsr4KD8FI0ePu+O6DVRJVWqBYa/zfiVjli+0EBkaXShJeNmsE?=
 =?us-ascii?Q?ETeQNnLRpixeYbAB+r14QP8Rsyn5iAhD7qfTdi4XhLbv+uKc5LaH+LvWyAzB?=
 =?us-ascii?Q?+KaPavI6PKb7pZ6raPkh3WMu+e0RELGTI1LgE/dpy8hV1zzm+xnyB7PHvjwA?=
 =?us-ascii?Q?VRek9JB9m6B9vz0+LPs4bpQ6i1lzc+2Px54PeppFVuuiy/LUe9kb+YiB2iX7?=
 =?us-ascii?Q?o6pkC26HNN8MiBFChOKa5MIheh+r5EkcsGhJ/GO5XlFJoYLTwguC24poh1sO?=
 =?us-ascii?Q?wvItTtNXfEig7zWSopACytq6lYbq+iP+gk8yG0hjIrJZmBfQZQf+7sB4i277?=
 =?us-ascii?Q?kt9RFey6DqkcfLBlI820bG5ArpT5AFNjYFsa9IAd4Db1vZSisYk+7o7iDWQP?=
 =?us-ascii?Q?8VmsO3SYDZxK33IDKJH5NS+oouqZT2zjyRVl/uAcr/azv8IlUNpC89h8AQMq?=
 =?us-ascii?Q?WdHvSaSIjYq99nQRwN1txQo8yLZnjhdjNQncFM2IPhl8Yoj1oxd213mNanW1?=
 =?us-ascii?Q?fOp2Ob7yvkA4Lyr/HQMtyYLTmEMjkfV897dweG5peFN4oRYfMNO8YdnUBlkS?=
 =?us-ascii?Q?Cb+i3GU34YvV7SGPqHsLVVBvMtyVRazZWoaHSdPmsPrM/G9CR9t2GO3tuRkF?=
 =?us-ascii?Q?lLaC4fDbGtnHtgteZaIENr2d3mBCVkFuPIwMjDp73uTe3am8bTn7Y9zDfXij?=
 =?us-ascii?Q?SDR5BDqUAXdEEuvPSKsLKU+0AJNOKUmlO2eWFEgq9tGBaIC1hX0Eq58fmfxs?=
 =?us-ascii?Q?pIVSkk6BtoXTcG7PmTnO8glZLCTNeKwBa0HQoesYD/ye7aZPKr7VhfdJIqlL?=
 =?us-ascii?Q?qAysQtaZhn/U2eyd9Q/ck3bOtSFY62jb4faiFpXkolNCoZrNF159CG4Tjr6Z?=
 =?us-ascii?Q?fWhBTZPZJCx0C76tOO9BTq2q9HNBDj7SH0lGgGLIOeTXrFUx9mSeG+2DUMjr?=
 =?us-ascii?Q?tzz3X8Ym+22rXSydZRYYSRQs+d5qtTJANbOn6A78vfKL59aDyYj+r6fYauUY?=
 =?us-ascii?Q?K7HtL6AAgAaZEjYP5rJMYnA9aL7H9GYN9SiBKLfOsJuqFwkdsIQuHML9tHRS?=
 =?us-ascii?Q?xUkoh4nsL/LaJ7GLyjKvXpfCJUiN6g+dGfcWUlRtUpRYAcsDHwkB5wsKFGKx?=
 =?us-ascii?Q?Ar5Zi/Omk2MX9f9q4HBINtfRldmeZLjqkMrFJod7gwhfcM0p31kke8HPwoi5?=
 =?us-ascii?Q?xINbDxqyGVNsXz3N9pKO4wKHEIthWf3vToxaZ8PyUtbp2A04VuqTNmlwjwz7?=
 =?us-ascii?Q?zubJBOQP81taS253uYA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e034aa1b-2e73-4d1b-13ab-08dac1aed93f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:29:54.1481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlWOPDwudFZ4Hs+uke30CPgeR09+aVNxze4+zlgrn5nP2KVw2Xj50s/XUj63xieC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 08, 2022 at 02:05:20AM +0000, Tian, Kevin wrote:
> > The concept was the allow list only really impacts domain
> > attachment. When a user uses FIXED they have to know what they are
> 
> it also impacts automatic IOVA
> 
> > doing. There is not a good reason to deny the user to use any IOVA
> > that is not restricted by the reserved list.
> 
> I just didn't get why different restrictions are applied to automatics vs.
> fixed allocation.

Because it isn't a restriction on allocation, it is a restriction on
domain attachment. (and this is a bit confusing and subtle, but it is
what it was built for)

The purpose is to allow the IOMMU driver to allocate a domain with
knowledge of what the user would like to do. For instance a small
allowed range may allow the driver to allocate fewer hops in the IO
page table, and a create a domain with a smaller aperture.

"automatic" is supposed to find a good IOVA that is the best IOVA for
that mapping. We have defined the best IOVA as one that doesn't reach
into areas that future domains are allowed to mark as reserved.

fixed can do anything legal, including violate the allowances if it
wants. This just means a future domain attachment might fail. Domain's
won't look at any currently mapped IOVA, only the allowance ranges
when they size themselves.

Jason
