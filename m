Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C836219F1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 18:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiKHRBb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 12:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiKHRBa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 12:01:30 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8333F28F;
        Tue,  8 Nov 2022 09:01:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7I0Vj+zumiHUT55UM120Fp2CowqjaLtqnYBsJSoyppha6+HImFXcothgTwUr2Ufe7Hnzu7/phiU5hXSepexRZkdDFnVfSD1W1/DagCbbHM6Qs/Y2AuZ29IBIqAkUUpf5R9oybzj+R2HzbVis6OwaTQiegLBmwHE5RoEflNzrjNqcCRWHzp/CUGSSPidyyutiNfxYElpWukPCN1+O7zIkNzSFPfk5nuzL2Lvk/43eByCL96qmLg9bWFWRIAKb6k1h6J/YbU3aD++comiVahP7qlbEjYtYDQ8lAURe3wXMRVQ0kYd4veo7VtzWdRtcUKwsFsRA3s+pZ+drxgy4OEpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDFL3fml/XZezdxJwN7sXPwJdXONiV8GGQIFXpK3eL4=;
 b=QlC+dp19kIh30c5gU0i06JxEfp6dT8xX4IVs3SN9mGvv8X5R7pZgqMD6wCDhT4x+EEWXEmgXVoDq9CDSYxUiE750kTqt9Ah1TU0tOhOpaux1Up98vvV9ZP12H9FnpbYmh+xO73YnoR+HfOwnX/Y0HeGWhfJ7h/5g7Y5TsBsDZidWcTkasR8ZC6dqGhBFz8o3kGjNUj7ACWsk3Xnf4GZvhcm1vqQFdRRVvyNIh5lts06s1fXyBgZreuqLAio3vJ738JJJMoAaX+8Ex2sRHutJm2cW6h2p8hdvsOgpdBB2oVTvVViBi+eLebYyt1R2qVayASZnhikI0riE0d0rB79zVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDFL3fml/XZezdxJwN7sXPwJdXONiV8GGQIFXpK3eL4=;
 b=lbO05Jvji4FTyTMfSZoLe9i3ywBvlfarZlAkXXDuhQgcFbMO+Coghp0QibFez/8XEeyljOnuin7wTi/Gjq7x1nLcDl0Ni6EiNn9RcI3upNWi+CRigdLC5iwJ6O25XzstOz1+16YPaN2V1x/fzrcGmgJJo/TPmis0PEUrGon0i1941zw1/hYyLsPcurwgcl0Z7wBcnOqWYFxtstcnPiJl/bfGREsui41h7JSXJsz5AV4ZFIZ+6ArZsRTUwHPntkIi056xFAihZ7L32a65g5wRgod6+BxLb+RG9aKLA5nWu09G0sVmShi0fNvG8HRdqdYRDr8watkl/Bm27WZquucMWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5187.namprd12.prod.outlook.com (2603:10b6:610:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 17:01:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 17:01:27 +0000
Date:   Tue, 8 Nov 2022 13:01:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 10/17] iommufd: IOCTLs for the io_pagetable
Message-ID: <Y2qLZtnpuBooH2t4@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <10-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2pZMSejF7nHinIr@debian.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2pZMSejF7nHinIr@debian.me>
X-ClientProxiedBy: BLAPR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:208:32f::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5187:EE_
X-MS-Office365-Filtering-Correlation-Id: d41fe0bc-5573-43bf-237b-08dac1aadfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFbeIUD4gCSTzBNbqB70HopkEKK3rlF/+tcYGkz8RF4utijsmx2rmxqmc20uKK8ntL5PRJhHzQldNAjmCxngmxTphd2sHF6KvruA0nR/zIjYF/dN8Pu5zZT8JlmmWBs35bOCRDggTQeWgKS+D3oKWKGn6+JDDXHbPtoctIMHeCVbhCKkgOupqGXDWpTRnfQIQVcwnnHK47AV97Nqt4dNBtbyaT7NQA9etByFhGBdxWj5bxCiyEMwNG0ClnN6J18nrsOzXhlahTXCW8C87aIh3z/3fMQtpOihEvGac9e4UxcSNeTC3HKpLu9gtG/md0vv8+i2dBWJV1lVE6BNZA8D/Daa1Ix5JlVK4d21a0jhrPIyCRI7tkl5+ecbunAmIrewkd3H2XSDGUsAAKJSfgjm9NEVHTlTlRLQXwrBEjqGF2jPGFYRb3H5yTth3WaZ2TQB8yeFEYfPRXac17MhK7/k2q3Ul9+QzUXgRlaChh/iKnbufmkz5uRX/SoM7NrsNS0abYi09zlTGAAIpLhsMJO50OtcLEAlyfxon7jgElwJBmnUkoLX4LF8zCLz7XnQ6/6Ze/sJ6Q1ro/jXjYfzy3T+OoN7Um7ZvjwDj3eaNVnGXbRP//kqCBNU+g4lqvcyk6HPEbR+DUK37iUT9YeK3jERN56Pcrh0THsAJ19TtATv2Y9zh5NVtsN/NFh0qBrEsa/Ry1cfrRct54NMLuHzSu4eBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(6512007)(83380400001)(66476007)(186003)(2616005)(26005)(38100700002)(8936002)(7416002)(54906003)(7406005)(5660300002)(2906002)(478600001)(6486002)(53546011)(6506007)(41300700001)(316002)(8676002)(66556008)(4326008)(66946007)(86362001)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pfa7eF+1rz7cJv5BMljMjyEuu4McEJRC9k8JegHn303HqrvbV+w6KFg690tX?=
 =?us-ascii?Q?/+ELLhvpSaVQabAP6cXVmWiWEjw2fyivAThQJffSUBHTCENExpvLUQwP8y/B?=
 =?us-ascii?Q?zl7f/AAPrKm7vLh5TGzNdsGC1KeJsrpLd0rC2qMyQ07Wgmm2tzH3F3XcmxQO?=
 =?us-ascii?Q?pkwqbW8bvq/47DtK9P9LAcKXXVR1OCfhBfppUynkZN5MjLdkmONBEiMKovR9?=
 =?us-ascii?Q?nVQtUxU1nkcIUHm3kFjENBZvo972vKGi26UcztBIysrhMHoTwxqeYTeylyoX?=
 =?us-ascii?Q?rMr1eAZoN8Beaf9FxXf7ukwU7L/iZjb2CETOkUWitsH68AsHM6tqpuGMUnM/?=
 =?us-ascii?Q?Wzz4L7Kukb6AJoT+lFImmwGtA2e1Wu63VsRZf33gZjVxACAW9KA8KmyZoGzF?=
 =?us-ascii?Q?K+NrCcUnlUaDO6TGZGLNFHAOdUtCvSusSaV+jLRgxEgGZq/wK5mrAjBwifZQ?=
 =?us-ascii?Q?FhuWascmDyvrVIdoOW9H6x9naqlh6moWUQcgaLV3y8NJ17cvIjARHeMT9Wg2?=
 =?us-ascii?Q?vkKHmN8Hgg4nOOhI2DIQFxLxocgPF0gMcNroQfxLIsASZT1bm0vZlg6pWvgg?=
 =?us-ascii?Q?KjJfniGhE7KzxktRoD75wcXP5xE3L6oQBV2fmrZqWdmp0OIfF6PgINElYMOW?=
 =?us-ascii?Q?NudZYiP0uxBA62J7V6aoczjQilM+RRaasBtBKdYTq7wOwGp24unaJkXGa3t0?=
 =?us-ascii?Q?1K/qkllBeTfGNv04Q53RY/7ZWi2O1pOeanGxRe8of64w4ywFJ+aV0amrBBOW?=
 =?us-ascii?Q?mNDn/VwVHyR8RB5CTBGhvTMFeq1ESrTRjoZQTZYgQ1c1HiduW964F2rLcHHy?=
 =?us-ascii?Q?QUV90dSi9PrDMS1JH7UYEEX+Scsvl4or1vTjRNqZvRhwIMgkjgSAFFRMuCAP?=
 =?us-ascii?Q?5e/MYXhE23umrvOBFIhrv3IWFVzsoEED9F9GDoBaReJVGwfu9qP4lfcvdO51?=
 =?us-ascii?Q?lUyPJ0E4ZBVl8R/fbFdnPGE2QOcp1kI7eztd6ekwTzVR9Xmt1XO016wFAcKi?=
 =?us-ascii?Q?rvAOUMSv+dYbLFmKlzb1jIzqFtAmmXn5SLDLFZ0qpO9qsWqbVhePnUNSWFXk?=
 =?us-ascii?Q?xyZCzNw/Z1FT1K/GX3aj1TXoHRuSEC8Ot6+B5Hl8qZl3U1CcwHOFjzJ5RBva?=
 =?us-ascii?Q?oExlHB5N1CzL521bWhminb/tBGrzdTfnnEfoNmeawV1GPL+fjF/tsbKboIj1?=
 =?us-ascii?Q?f2fiH2tDg47O1W8fBdmCoQxDrnxyWaaCvEwBo7zsn5m9ByyHP/G88lhzokCu?=
 =?us-ascii?Q?PWb1a/kctxJdiCpxHZehVjJr72liq+Q9jYGCB6DfiUldQb5RICYn9QgR0nNZ?=
 =?us-ascii?Q?vJoTT2i5Y+5X2iERtidHs8t0nLZpyAzqb+5bO7VyEhuudvMFObrrhvIAS61X?=
 =?us-ascii?Q?rDTCzLVFfWbzQvHP9KOJS/mzdCKFavtxMaWEUiBA1Pr+/BTlgDk549p4ELgs?=
 =?us-ascii?Q?09Dnj+hBQtBGjiB4o3QX4282WSgZhWZx97E501XcVKFqTQM6ETigMtnu7bmZ?=
 =?us-ascii?Q?llSBdVK65ZxdFKrSkQTJxWCZwT3RIx6n1/QR63zB9h0noGgrJkb8ooat+GbL?=
 =?us-ascii?Q?KBH0+Qmio9pYZLIq/vM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41fe0bc-5573-43bf-237b-08dac1aadfe3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:01:27.3495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skQzoImjpaDdxcE0t4JEs3lJRW1baQMP3Q2S13dcnTDfRjTmQjSmlxAApCsC7Asr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5187
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 08, 2022 at 08:27:13PM +0700, Bagas Sanjaya wrote:
> I see kernel-doc warnings (missing short descriptions) when making
> htmldocs, so I have applied the fixup:
> 
> ---- >8 ----
> 
> From 5643b202ae9853c11434466c76aeaaa044e88b07 Mon Sep 17 00:00:00 2001
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> Date: Tue, 8 Nov 2022 20:14:25 +0700
> Subject: [PATCH] iommufd: Add missing ioctl short descriptions
> 
> Checking kernel-doc comments in iommufd.h header with scripts/kernel-doc
> produces missing short description warnings:
> 
> include/uapi/linux/iommufd.h:80: warning: missing initial short description on line:
>  * struct iommu_iova_range
> include/uapi/linux/iommufd.h:250: warning: missing initial short description on line:
>  * enum iommufd_option
> include/uapi/linux/iommufd.h:267: warning: missing initial short description on line:
>  * enum iommufd_option_ops
> include/uapi/linux/iommufd.h:277: warning: Cannot understand  * @size: sizeof(struct iommu_option)
>  on line 277 - I thought it was a doc line
> include/uapi/linux/iommufd.h:299: warning: missing initial short description on line:
>  * enum iommufd_vfio_ioas_op
>
> One of them is reported by Stephen Rothwell when merging iommufd tree for
> linux-next.

Thanks, I was about to try to figure out what that was. I squashed it in.

Jason
