Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9C9620476
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiKHAJg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiKHAJf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:09:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397E1EEC9;
        Mon,  7 Nov 2022 16:09:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtrHPXMlY8zEdDkTjJa74Lj4IBlhNuSSeXFIMD1LElH1Z2wE5SZgcaUjHnMDuiJmEO7xqkB+MYShMFZIGU2T7qeZWo42tQxu75f+44aM8Zryf2VVVmhYbGow969V1Sc+n5m0bYD8VHJHDQwRcSy3OueVzoff1d9QSn35w/NCik4SHuC40kMciq+7qHOCNQ6L7Aah2eCtG2gnt8fkYLjH3eq6xTI1JpJAKg9xZWgpf1NuXilZMQxkhqbjZguMLjMW85jvs4SC5JgzcHmxB7Rvhu/pIvJWOWb5LFnXvIZxmm8Li8gyjyALT6zV1/S5NZlxF+GPmf2Hw4V6rErJj7YG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR28jgWn9OHJP5yCEhnNhBg88c2at38sLbDS5hvCI1E=;
 b=VahTWWHldapKAHPrpQv4C5MyKyX8RxQWMyp/LwSU//G9UrSxtXu/SmSnDrt8V9zSTqXagQVlNF0cLzeCJLYVuudjaxBon614/BzKGAv9f0F1X2EZNx3intuiU96WgYFY1cWWcG9BwWtcUM4H5GtLiDZPEKq5WH5DzL4I0Jtn4sTXLA3AWKhagRXJnbvvKY9RYLDwmtshdvxQy2USFwve+52wrcmCh8lQlgs/tSk+ioIf6FE9gE4G4LaJYKurbeboqCWT0RAaQc64oxMOKn5+DSohOXv3w0yXNELdjEa/MKZSzikyGe1ypyvEdJx7+7gjUH9IgCg4HC2iXOiMGewGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR28jgWn9OHJP5yCEhnNhBg88c2at38sLbDS5hvCI1E=;
 b=cZW+GMyN7nSi/2A360mOPagGxePFtaJ1jIjm7xhJew1OZiGSfh651a0ls8loqRcDzZ4DX6vQdfV+YiR4ozZ+2btZTUa3fH9g+gtKwfcUb2/fUC5KLv3sil9ZLGkTUJSFhCTWA2dW6cp14LnipdUnTsPnb6V+XwHwVg5zAZb+QtuiCYQQLfc4AReiWdJtSQ2j+aols1qXhf1Qy5SbvzEbCPZDev/5pJQLPB9jtkYbZRxz5GLH8I0mN5IgXXIW97gLlRs5MwXrfmopna7HaY50DOBzJN+qpjPS1177uIEzEVkNmKjF76zp9bUoOUNrm3Get31NkQD7taYcqySfx56Erw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:09:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:09:33 +0000
Date:   Mon, 7 Nov 2022 20:09:31 -0400
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
Subject: Re: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y2meOyG2zY4iMupy@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52763ADFBACFE7AFE11F5F078C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2k7fkxSzxTPTXkN@nvidia.com>
 <BN9PR11MB5276EA038EAA0345CA0ED0438C3C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EA038EAA0345CA0ED0438C3C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:208:32e::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d22f7c-3c70-47a9-18ee-08dac11d837e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZvvuL4QVWy48BokVThp1P0OBqV5yiyMIw1RLuGQHbzCmleCWb+S9v/YvdNixRZo/gcCfYlHHk5kVxlqKEF6foCdYESUf4eqs2ApCvnHtgCkRc0zJF6QTCiPNnzaVSe7ifY7SXsKBnR+aC7ZuOT34pGcecsY3BpZo5NZw7vfC2ZOa3I1lVPUg/GlTf66fpwNt6WeJoHdZXUb0Td8dTHZVUd+UlvOL9PCqZ37d0VS62fkaM/ft6FHh14l8KdvQOwy3HMa2q1DTO6E9NYrkb5mPa0xfXmCyW5SqE/tD0VBU+qmLgFEbIvGoSlT4y+gz+DsN23940YA4rj2J3SRNe26KwvPi9CTcp6kgacgSLubImOIu6odUgHHRthy9EAeyjzGR5+i9H7lrZJFWVyYMM1J9yG8lk4tFJ6PB4StymGP4pG+sCMmSlhi5khymIfGmwyljwUu/wBAbyl89aa3FReSU87lZ+sq3wOjXNrXlP70mAsg0LBFpKW5hCf2ARK251594EZiH8i72RObpHblzpopVrFgr3j2vouphah9Ve+m9CG29UVPqKsPFAQoHUMdpsVdM2c8o40ZWEXROsTmtFTXzww1sF5KcEBN6BqaHaBLu1fq/+BHVrIrPOHN9WbQu5Rb8JepH6ix8ssHPo9GU5a2ceoDjYU9MozuLmaazo8vL5WVOdgq2zApmwaxsHVs5clcLarxEaNClvfi5qJwJezARw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(36756003)(86362001)(66556008)(2906002)(4744005)(5660300002)(7406005)(7416002)(26005)(6512007)(186003)(38100700002)(2616005)(6506007)(8676002)(4326008)(41300700001)(66946007)(316002)(66476007)(8936002)(6486002)(6916009)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MLVJUChSSpscljNR7Es0GWc95wuv7GrY/hqURGSVVHuH0S8aZC/GkhJQg+Xm?=
 =?us-ascii?Q?hjbqB5b8tDjOf779I6IHR8dKgeViy2n/WHFk6lvTAVoCBYe/DPiXaNGNKApa?=
 =?us-ascii?Q?9HE8tD3OgpPazKXwT8B+zcZW64N1k26Pjv6cdnXSUYx2QKanwdlpG44Cvmi6?=
 =?us-ascii?Q?ZH+mxL3sxRiz5OwRHKI8XOYX3bhIpdZWqrI8e0fSDs5zIwOPSmjuwhDXwIJy?=
 =?us-ascii?Q?FF8oJOxpxtjgBoN0Rc1JNh4/hIsPfGFQ/9Qvg5ZjzVmIlYajVWq5DlE4kfiD?=
 =?us-ascii?Q?7R176LPKsZUp/YsfxcYewJ1cxu4IQbBgmy0p6uOU0BZkFEAm5fv1SNuTmydD?=
 =?us-ascii?Q?Rr5YQ2kvDDrOq9+FEjhmn2RfZJaKJdz5ns4TGTuCfrNeBdFf7c97gnVsPSKP?=
 =?us-ascii?Q?Cgk9XLP6DMy5nOCjMxdkXsCoA0l63nH/+2dCPFc64f4AHxnuK5vHRGswKGPA?=
 =?us-ascii?Q?iR7RIcvNyoJJ9g3ClewrPyleh1t7hcK6nWLGkz9J3jnBiS8aM/uWOm7spfml?=
 =?us-ascii?Q?xc7LcKq+Esw1THxBJLnWRmPUMbsY18+htBDio8mvDqW0GvtHiJIEK2B56FBr?=
 =?us-ascii?Q?iUDXeIjaWd6Od7gwqTefWhcGmpZ+8DTnqRuxYgtZ6ciVbFDCdvayzuu3Tm9w?=
 =?us-ascii?Q?Y9jmp5TueJwYS+QwJA/9lcIr92Sz0FY3xfm0D6BHI5ncQ+jL5L2m/w/+AsBp?=
 =?us-ascii?Q?1dIbZueL3bCz9wDpSqvMNhdZkQlsWOVW3NwoGUAyvGf+SH8z5XWfry/DgQsr?=
 =?us-ascii?Q?HEI26wjsd0fDULeQGFe4f5ub+jNaXokxIN4fiT6nAMwsbpoPKIZrWTyd2eff?=
 =?us-ascii?Q?O/tcza/E47YCRPBYEfdg1cRSb3w+GLQdexBlmL0swjukUZ5AgF6Y3QA3/OzT?=
 =?us-ascii?Q?cOYGbrCaPsZQDmacQV95mxiHN60KBFSkvjM0Qll9mc4sE2gTtr3fgOdKW4QG?=
 =?us-ascii?Q?lNY/E6jomNwv2DJ+lF7oyfPrjoumtFfNeB25BwhD5MNxDtmKgc8ge1zMiRxK?=
 =?us-ascii?Q?TdZzKCDItIQRoKSiUeJju3JCudDeGqjWh1HrzuVeSrOIMcrWKW1Zh31d+WIV?=
 =?us-ascii?Q?3p0lpiKRdTiIBj4YW9WLNkGexpwFAFkjNh72NhBYFMQPVhEHlWDMSR/MZWlF?=
 =?us-ascii?Q?ziqoT+u9DSIeUMGyB6A3q13PQ7FkAUB4JX318KiiMAKKrG+YFLnr/ihy6Z23?=
 =?us-ascii?Q?cTRTgXZY4hNshdjFoeVcdPy0aFzZhW3F07HQCQduyeOpE7tgfBMLywOE7Wjr?=
 =?us-ascii?Q?HTTOFwkdi5MbGJH61KFhbvuKFQFvisDPHGZGJUMVqSmtXyCMlo2Tio7DN0fL?=
 =?us-ascii?Q?/UCRI3YeOAh1NHC8HSaeSGe9PMLFg0PGIEx6CX5opx3IRyjv0caIPcAaNmDi?=
 =?us-ascii?Q?18msxovDUSZGjEOkIr+Ems09tTxjF3v9+f5Y2Ycot/erXXafcPcyXrG84C0d?=
 =?us-ascii?Q?QlMDX+/4B2J7M3jtjt/q4i0QEo9TPl6DchEAAcy41IBEfl9bouzlhunhICZQ?=
 =?us-ascii?Q?X/gI7LPkWMWEVX68D3HXiPUor4XHTgJ07uUwkBxAcZH+mAlGKcbx8EUPiy1A?=
 =?us-ascii?Q?aJTCxK1R+SfmaWtdHOM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d22f7c-3c70-47a9-18ee-08dac11d837e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:09:33.2200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIIZ0ign50Is9PpXNIjtX8S2Fz739ASBA1qFKeKMxiLI6tY1uBgyjTGOA/U/DVUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 11:53:24PM +0000, Tian, Kevin wrote:
> > Other than that, userspace can change the IOAS it wants freely, there
> > is no harm to the kernel and it may even be useful.
> 
> it allows devices SET_CONTAINER to an same iommufd attached to different
> IOAS's if IOAS_SET comes in the middle. Is it desired?

Sure, if userspace does crazy things then userspace gets to keep all
the pieces - it doesn't harm the kernel.

The IOAS is bound during get_device, and that is one of the key
conceptual things we changed with iommufd.

Jason
