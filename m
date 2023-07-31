Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D8076973D
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 15:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjGaNM0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjGaNMZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 09:12:25 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3412710F2;
        Mon, 31 Jul 2023 06:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBGoml16HmJnHIkQM4NEd9oph4Gh+ARnQncriwmS/PVYgDbrlubKvH9iDMjZDhNbOrdYrHq1YzlPxNvKai/sgDjxPFPIqQw+bL5d6LNDNa5wrC8rSxfBOUqaH9eXjhB8MubCQZF69CpCevjCFcOgWVETMazLCGZpDZVL3HFcUU4Qnuo9Vuji1bRqtzI5YSSkrttALz0+dDT5518iutBtOAo6Q6h/xTJBjpc/gg5QRVbsXTKDkwzZsG0X1IltNBMOFqWcaVoJRcwrBW/qj/35IKsDq0DR2kVuabfPwpyT9rcLLvh1DORuLrSdGpODa+q38571Cpbm8OXk+8/4uNM9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq12qfvnTF+DPSc0XgCtS20nuc6PzUgrBWeaDhCmfMA=;
 b=LYK0/+fIjGCC3dshfZnQl3Vd4/+bE3hj0ANyyPVN9spRE1tIgEtGBFvZA2TCMai3UsLeW3QNqesEi1rJ1sttcALF+wd6B57YJV9asoaJTilbfHKDQYf1tiOCtS/kMMOitGANAYys0yN5ckgdKiFPCxAiS43KcVTdGQHgpep5l7OU/MX9/G8YwbJpN04AVaghl6CfvnRs3hP0eUkVyAab9TYTr47NeMBaiU6UdUju1BILS/a6qYvh51bjSKJRjhHuLiVvkSqCk9WXrZBw3bAXjfmNbkE9e53lpcs2Vb72Sppr/4cmWHUSPQuLxCg/mCsA2kd3do5yZuwzU7td0igzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq12qfvnTF+DPSc0XgCtS20nuc6PzUgrBWeaDhCmfMA=;
 b=G7a3UaL6dVMzKVtIVyxiE8K1Ij1XEJOqsUoQ60K2feAzkwg3FTtWvdVwzqwZITy774As6EsS3LVzJ+gFUjN2c+PIfmXLO6qlx2m9H4DWVWLKWiufIeLFZRcxNX636696RUFpawZHBTPSxDVVIcsr2d4rCe1ZLORIB8j2/7pVbNP1519HaU/du79nGRbjdPmUjZlJpi56bLoOfvNiMU5K8D9R1QtedkmWjvOGAVqm9PsTinheRdtkZdX451ptwWnIniZRlW5Efp31Qytp1vUw+Cc+jfkegFY4W16Jfvvi2SXYusxDMdbfG6dIaQKOQbCRwdpUYFAhuO8q8/Jdsh+qpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 13:12:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 13:12:20 +0000
Date:   Mon, 31 Jul 2023 10:12:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Message-ID: <ZMezMZWi4u+NiGfK@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com>
 <BN9PR11MB5276AAD6B3785DC247E4F35F8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMP4AhdE6RaXXgZH@nvidia.com>
 <BN9PR11MB527629FFF470804809FFC2FC8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527629FFF470804809FFC2FC8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a03:505::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 48261b32-7ae1-4d74-4af8-08db91c7c549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGaT9u3GmLpbN1YsRmFwybcBb5XS6djxfjAclTtiWBApujph+D7tHZt325yEqpFRcZX+DlJOpLa7INuwBn6f7FriL/k198YBUtOWzso/TznkAiU9Gz7O5K+fcGadj3+93pWxiZD/hFac7iDUNN4HyPcMoz8WBlfP0Ly3pptddUILRWN/eKTBrzRH2uV9mmSk8p+WJe1DsZxyosnxY5uAz9v6M2qlrQV6OxH0ZByXtFIyo3bbnkdbLtZxR1BmYHU3rKMYZOoh+ExL1j9p212DSe7+xeq9BjuKluCPhpL7hh3uz1KmBVNNvEZdfOkkOsBsHrkIfzYAGKIJAnyBsoWAvMuJnGGSCPVBPx2Ganeu+H+PNVcXUbUKRgymqRRAoeDGYHnJIxEl7FBHH11wEjmReSXa/Q60LiexCi0AVp8nJaTJ8Nq3qAiK/HvM5qPnQsFeUTDJsYeQSmTYVLpmInPnRB9Koe0AnrrpDne7rN0LXGwfCd5NmTrgAcwjWuEga5LS9h4Kue7+rRdXsrsdiMFeQ5kQXhI+AYM8MNN6qN0bvYCZYap7NEDGkRKAY33yLjbSL/st0YXGKJ61sJqhDCxysz7vYIF6lipWJ+s4r7iWIj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39850400004)(451199021)(6486002)(6666004)(6512007)(86362001)(186003)(2616005)(36756003)(6506007)(26005)(38100700002)(5660300002)(8676002)(4326008)(41300700001)(8936002)(66946007)(6916009)(66556008)(2906002)(66476007)(7416002)(316002)(478600001)(54906003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PtgUAiXJ7LTv2rKDk4U8FjhO2W8qo+Pt3ZLPeno45ab4Awi1kRh7fyIfdhGm?=
 =?us-ascii?Q?k2qRjJ+mSWY9XaZAB3/n9xgMoajeyHH0ssd1XGdZfp2JoXb1o+PZZrjBbIBZ?=
 =?us-ascii?Q?sjNL5v73jFRCKfC6g/C0h9hzx3YeZZPCTvizVztZ9/h3Lf9LAwO9X9X0C8Zr?=
 =?us-ascii?Q?MF8oFVvE2MWEEQySkqTvYJsO8OIVrnQ9LGajvARuBUb1QFeJX3yopdz1qAhk?=
 =?us-ascii?Q?mAI4iA7MUsV/zxKlnJ25odV8cns6zQORxmLR2SILyGMmJtUQ3TbR0DKOfvuO?=
 =?us-ascii?Q?w4q2sLiQcpO1GRy9qfI1XOqKd3O7a1eiVZWoYphpQwkondkECyH2leRz64bd?=
 =?us-ascii?Q?aAB0ohPzv7UMqaagAIvuyCZCVznraw7SrWvWDWcVA2n0MXAUOAdmMyPrTdXI?=
 =?us-ascii?Q?xxTvnSu3kfXbn7qD/n/UD4QgQ5VFNgN6fQBn7/+UGSmezzxMs/d282i/ysAo?=
 =?us-ascii?Q?9BPySP7XkxXYrHY6rJjQQVUQMMG+BMEb5+sjuyx0tbm6h5JtoIPy+kG67oCN?=
 =?us-ascii?Q?+4ddEFf5e6ZrT+sO2gHtKH6howDI4+soMCJfisulyPR8YGx5urKXE7gnuLyH?=
 =?us-ascii?Q?1ZcLxaCcnkN/76uDqruG3RjvUlp3H2vIymywGeP1XS7/xXs6UjuxyXhl6kiT?=
 =?us-ascii?Q?a9TuKOIokG0OBP9rvP1TSS2y2BQqm0tnuT+4csH05BM+AHnfVFkFcAa35LS/?=
 =?us-ascii?Q?fVkR2HLB7B15OwpcouMOp4SAGQN8Tx8/piC6uxo0pQ3NzHTcx7BDLJh7qiGH?=
 =?us-ascii?Q?QVh/l0czx0lXTrBYGT+radonbsW97v/Y44Hbq4HYIBuY+lPuS8cgeyGYnuz5?=
 =?us-ascii?Q?mo9L2VC7NeoNPEKyy/Yb/afUSG/54mz8vpoegtDC60q5jUUWA/oqtFoapaB/?=
 =?us-ascii?Q?BTWgpK0Gei49NVCPrO/XGAoew4ow41GNuQqTmtw3re0UgwbZHIlvsahtfQDu?=
 =?us-ascii?Q?IRaVH5ojH79A7YfRL3SpAeOQdHdUonc3EAM6+b4DpsRX5EhWjIUVzmyFQeiI?=
 =?us-ascii?Q?eUy5CK7p5BRvjnP3NoMJhrJtb5iboHsfSziesYBtc6zms2U3luOl6+uNrQKF?=
 =?us-ascii?Q?/QiPDnsWUosdtye8l9MeLDZSlXH6v90m4vJucDCGU5y8GQUN6pVFKhlnGIQp?=
 =?us-ascii?Q?vTmAPGS9vfrSPLCP+GUpYTVcGEewWLOP+dDAl8dmiNtzjyRsFwkt/e7Gp1en?=
 =?us-ascii?Q?91xobF3JaqerWhUPPnqnD9/qEu8bvWUzADxsZT1EPUiUCr79e7SRxbZBY5bA?=
 =?us-ascii?Q?NdE1E2kNmtM0nPqJ1zFXUIPpz/UxQ8Sd1PXpE4W2aD5/Lgq20YbWjBfj9PRE?=
 =?us-ascii?Q?MJF2F8YxkhMxCu0bgDeG/17Uzci7OFxQ6FT0bb5KhnsspzWjMdpqJdNukGE5?=
 =?us-ascii?Q?B6i2xhHeM0iTXuAmRslJu60YWjnPdZN0G4wx1IEbO76q9iToGFcLTPOOP/7f?=
 =?us-ascii?Q?xNd7Z2LEJqMV1pvX4Mdy80TKnn5ncu5VjwWpLHDkNjuzjFRy9Kcsjz1NcJeU?=
 =?us-ascii?Q?xeD3zLmATLSQOkAbcB8iN5BG2uZyrZWqtyGVxVKPyhWfPZO4mxavNJ+5k7KF?=
 =?us-ascii?Q?G/RnNLStRObTUxiaDvyw2VJImJipoLXr+zTq363C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48261b32-7ae1-4d74-4af8-08db91c7c549
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 13:12:19.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxW+n9bwAr/IdWyHAFJO2lcp3q1bUs8fOOsn1TLAtl0yYMV1Ff6+UNtprARa38Bq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 06:14:50AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, July 29, 2023 1:17 AM
> > 
> > On Fri, Jul 28, 2023 at 10:07:58AM +0000, Tian, Kevin wrote:
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Monday, July 24, 2023 7:04 PM
> > > >
> > > > This reports device's reserved IOVA regions to userspace. This is needed
> > > > in the nested translation as userspace owns stage-1 HWPT, and
> > userspace
> > > > needs to exclude the reserved IOVA regions in the stage-1 HWPT hence
> > > > exclude
> > > > them in the device's DMA address space.
> > > >
> > > > This can also be used to figure out allowed IOVAs of an IOAS.
> > >
> > > We may need a special type to mark SW_MSI since it requires identity
> > > mapping in stage-1 instead of being reserved.
> > 
> > Only the kernel can do this, so there is no action for user space to
> > take beyond knowing that is is not mappable IOVA.
> > 
> > The merit for "SW_MSI" may be to inform the rest of the system about
> > the IOVA of the ITS page, but with the current situation that isn't
> > required since only the kernel needs that information.
> 
> IIUC guest kernel needs to know the "SW_MSI" region and then setup an
> 1:1 mapping for it in S1.

Yes, but qemu hardcodes this and for some reason people thought that
was a good idea back when.

> > I think the long term way forward is to somehow arrange for the SW_MSI
> > to not become mapped when creating the parent HWPT and instead cause
> > the ITS page to be mapped through some explicit IOCTL.
> 
> yes this is a cleaner approach. Qemu selects the intermediate address of
> vITS page and maps it to physical ITS page in S2. Then the guest kernel
> just pick whatever "SW_MSI" address in S1 to vITS as it does today on 
> bare metal.

Right, so I've been inclined to minimize the amount of special stuff
created for this way of doing the MSI and hope we can reach a better
way sooner than later

Jason
