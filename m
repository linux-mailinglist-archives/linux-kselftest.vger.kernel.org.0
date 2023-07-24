Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49C75FE00
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjGXRnt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjGXRnr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 13:43:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC71704;
        Mon, 24 Jul 2023 10:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIrEag6FoXMW9W+kog3qjs1X8dJ14FU3f4RbGhslSCIXQdgQ7IUmynchtf0e3sgzmFjVzEwBrjLtH6MM09yj+vfARbtWxUQHfWOefrO6zZ1eW+VjXK6sLF9IDpimoGiaqdJYsBKzc0dFekAPXLLZDIJeJoZnK4+KhfUaGKC1Y1JE+Z7h5ZtRyZs+dBzhRx+Frl6sdgvFq2Caq13OnAnXQOnNxUmaJTVlps0aUHAqpQksaabf0LPmqqebH3VKeXR+4fSXdrNSwcIzHHiP/uZ+6yL+E1cfoA46fzaYGr5gLlNL6CKnCwfzBmAtmxB0uxaNBM4SbOcItANHBcBj7/AyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDdaIIFAvP3MascKx+afFSNqHvi9913lPjH1KbFWvQk=;
 b=NAN+xs6ofkYP4GTnhGe+rGCcyrH9DE6tBKKPc781rvAAlirJzwSkd3cgGx1X33TP6itovk3AnmwxurtK7qYY9bKwHWfLALdqus8xeuFoFEA+kCxdGepKQqS/g0W226TqwJTcfqzdWacKThbeRMqvl68OJb+gauldj3xz0rf25Z4ST4qeAQoZmzAnAP6dLVCb0PjPhPvsAHno/55SlYklEEclne8qBPqAMo43aHhg8u3S6S1zhyCqORX39EGAp/iSGA9k6t/EkN62Q/xwCSo1cbGTCMC4tZ+ZN3k5y7NOF601pDjBYx+mM+6KdogDFJrIPrr01bx+K/gfsVM0lqtMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDdaIIFAvP3MascKx+afFSNqHvi9913lPjH1KbFWvQk=;
 b=hMdmbUcPEwbnjgCSgZWsVFo7N9sDAthd9CDRj6Oo+dxj08cvzJKKOaO9QpnD2As3AagcWVwVMA2OILB2F5N87+Q/VyyBL8zmw6NrNzNyoESoxC5zacwqz4dwKjs5hBH9icoCyoSBeib8a5iHTCjenyrq1fQAOs/W5v7XdSmp7+UfHWJdRXYvUZFaPiSAseraCKnjgxHR3fzSKRM9Nb6dMfFYQbrIagVVpaY4ZuJ2bTNevhfEVpSd5RkUV526K69TKieKWqeOhcRLnEhGydKlUu+HuFHJVmG7bUDEmHMXpbWq5NyI36FaBvsrMz53tQdiDPRvf6A7et5aj7Cbp64PSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Mon, 24 Jul
 2023 17:43:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 17:43:38 +0000
Date:   Mon, 24 Jul 2023 14:43:37 -0300
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
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v4 1/4] iommu: Move dev_iommu_ops() to private header
Message-ID: <ZL64SWDClG+cqwGA@nvidia.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724105936.107042-2-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:208:23c::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 75fd1e46-a759-410c-8d9f-08db8c6d8317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEKTh0QQC1Sa6AqdkUrZEKLMWMxftD31T0wVOm4uU96xK1yCViRrUVhGZfHZRCIlgmEB+8XoN5ebgJs76RMSA/NuiRD1znFMYCzh3nA3wiQ1kgixPxJ/msHVPNR0YxEg7A1YZRNhGlrqmDw5+rxEYC/5G2y0aDHEDoDqgX0cHv5y+k4fBn3RMVWFYUGD5P4aEEb8UI8HjfUruciotbX6taKEPzjlA3GgYc/Cg6GZ5tsdoFn4FuhYW5tXXYu0pX5OFnBQJW1U0t7R50Kv9N14DiuP7JQBufI4WDs9bd2p9jCbAFZHWcO6YlpVyRjnclPH+f7TXGYhLeGF2HtVLhN1SQsermFEYfhPs+aaKJcximudFRthLFQFaAk7NpsVv60ICEPYwMrzA7xeJgQBGfSEsA5e5/e3UMz5uKa8iTVafSmcIXMFp5p233dL/GCUOkqLQolNYmx63kunHf/QHCoh3K4KMbC2u0wj+5LFwrPbbKyS/aiIgnLGAlQxLxwvYMoHthDiPX0128/Ln7kcXotit9matzjufkoUeQ1hw+Ns4Fc/O/V12MK4C05QyGpbk3vBKwDc/1mM1TQHzUkvnxz2ENa2YJcRr7o0JZMjjJmUAXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(66476007)(186003)(6512007)(316002)(66946007)(6916009)(4326008)(66556008)(26005)(6486002)(41300700001)(6506007)(5660300002)(7416002)(8676002)(8936002)(478600001)(2616005)(83380400001)(2906002)(4744005)(38100700002)(36756003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rd/QgEorYFzcNfVEsgGOix5AXgqB+hpXCC0wUTFqFfHHaSQvtNQ5YRGeTAgD?=
 =?us-ascii?Q?RHRkqDslcmDUwn7P10/hxmf04kGaUIHoJGM+qluuH+Q2obsDeGi2B3ChbKnM?=
 =?us-ascii?Q?WasqJ2TPP3rVNOMPL6UDPIKCJhQRDSL075If1dbxPHbYTnjSJ5LwRfUMB9Hr?=
 =?us-ascii?Q?rJNgJl17I6zd7vNq2kiqaoGjlYSahWdEja5Bw2NWALxZeFTrt4ah8CZ8UhJs?=
 =?us-ascii?Q?qRl20C+UlNNF7WsloQrxmycL5/1jKByCmLZAYKAi9rb7g0aIDEXvisAsQazI?=
 =?us-ascii?Q?U0ZYBjGURBhl4d3taIhyzEOLGd2cNW86sWbnbJpPPvk3+CRQNLW+sYNteZAC?=
 =?us-ascii?Q?TqE5jUad3UvpPLzUuBdOhroPFTWamhKiWGzjKHpNBz9oQVqVe04N9ap1zobp?=
 =?us-ascii?Q?AatUOAnzr2x1Z0NfR3JOwKf8Ck9tmZzVmefdkXqz99+IYalMy5AdYx5FLJ2J?=
 =?us-ascii?Q?OjuFGl8wj5g7Vn3wC6cdZv3UaPXaayfkgq39CvYGhEvZiffuyWx3D+XvbWvk?=
 =?us-ascii?Q?yITR5+5jx5TY6sAcMTZDM3oF/wEjhCAwfEY68HSvgkQr4q60D1AB1vlf6bW7?=
 =?us-ascii?Q?E02v/HDSCscpHvrfSNWCaFJmu447hyFxrrL2L3ieiWx7tFmfHB9eVN6Y9Vuy?=
 =?us-ascii?Q?D2WvmBKQekX9af6VIlj/e6asSPQRJzKyP3pmIMz5Rg50vHmsQQ+JTc2rYS/a?=
 =?us-ascii?Q?OMIYppbbDDRf1uUj8ll3h0pgH0RIzAAYaoVeE8+nM/Ye6RWRR9BVqVJfFvd8?=
 =?us-ascii?Q?TE2LcBgHV4EVcUlBSH7wbLhXT5IGH2JmpVGhyHKq9xksALsXhKtWURdMj1pH?=
 =?us-ascii?Q?eLttZVPGw7jK0XbTAyb7xVfEtlgSFZWXpGjfNVCO1H+GaAPd6tLqm8E0bmaN?=
 =?us-ascii?Q?+obNV+Rzn9w4x4M3JJZ8+Q9U4rasSpmq78X0EoQkOzeoCl3xQSr5rXVpecq6?=
 =?us-ascii?Q?ViH3vlia8r9v37HWvwWclPsIwSoZbe0/UlavqtcSNlTcHEnrCE2atxYawXUn?=
 =?us-ascii?Q?x9GogXE+7Rj1BqeVxTvjlLiMWOogAyr2Sj3/zFuS22GKrHzEDh4IjzFDzgHl?=
 =?us-ascii?Q?UzlNka+9gsyfM1uPJflUBVAOInej+RVsgpj5hj2MPH2+dOAacRAgsC8x1Gyq?=
 =?us-ascii?Q?F8uWG+3lZhvKIRceUPxyezOZ7YzyIRjgcKBJv7vvl5f/Nz4X6R1cVEzFje2g?=
 =?us-ascii?Q?DX0ieCbgRznnveIjNfyXLfQfcgG+cHbaS9A5crVtTXpT5X/e3fY+UDez+nqq?=
 =?us-ascii?Q?c7BALF+FaUL7eyLIOp4VYpkB2Td0gY1Oqgku1jna1znRcg11pFu6C+wO4wAl?=
 =?us-ascii?Q?EZtbFb+GoOUXaWhgZ7aFmnffF/B+fUsG9xiWP0t3JrRSKzugkwj12XVjKK8G?=
 =?us-ascii?Q?XBydfytsbpMnl0m29wI55nSdEp/rCMWDDlLaWGRkxCRkuestVcD8ulbGnUHk?=
 =?us-ascii?Q?D9zAI6rXnr9881G+WLDnEMaZ+z822XTDoOoI8XZyI3nlCjPgnFAE+bF4Wl2V?=
 =?us-ascii?Q?0twz80DoMWJXkLMSNDGLRWnmkfZ9om2NdiIEyVvezG0OxZ9S0fmlqp4Fs4Sv?=
 =?us-ascii?Q?RKK+FjBwu5u1ZQym4AzPKuDdPo1vlsenFeSKOZtd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fd1e46-a759-410c-8d9f-08db8c6d8317
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 17:43:38.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlrH8pHbDAVV43lkDlWAW8VnQF5I52iMSo1qOKARpUoG4BpmKem2p/JCn7jOH2rc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 03:59:33AM -0700, Yi Liu wrote:
> dev_iommu_ops() is essentially only used in iommu subsystem, so
> move to a private header to avoid being abused by other drivers.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu-priv.h | 11 +++++++++++
>  include/linux/iommu.h      | 11 -----------
>  2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
