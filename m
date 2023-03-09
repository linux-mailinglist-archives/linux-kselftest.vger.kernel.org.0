Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D9D6B2490
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 13:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCIMxj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 07:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCIMxi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 07:53:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A240B67812;
        Thu,  9 Mar 2023 04:53:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvC7jlAhnXiWvgf0e6X61HWjC6Bv+UVSzNWSpzz/Jd0taU0uvhiazz2mj13eCEJqR5NnqxvaqP92fFmAyy1da8VZRnuy+Fxz8Q+QqWFaqxNSPMy+5Ls4ngQOUY40Dx6FP+NWPK9XJ8y9rvoXFmcYwg8/eRlwQW+W3g/Websz6m3N86DZ8EHq2OPXckOMeXSImdY8j7EHsfDUFSFf7AewZMyl91hvcn9i0iz4Z4zWC2Dq2vZCnUT4XWIR/b266m8vn26Of88VVuKIuQrw7TT45gO41JX+Xy2cph59jm/gAv33JEq8x7zisGsz+bhBhmZc+rsStepYvg9EoiAHC1QnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txP9QfVmURjcA64zWGZWabuzA2mqoYeu3DQFN3lXfoY=;
 b=eKanFwcAiz7EJRwck53PrfiWMqYq2JTAulxOWpaHDad/Bcp/1XcscOJb9poyJZ3THmc52Q3IYvOvpboLkYpPZxlyLcv0AuIqQm9buOrZVYIu1TDYEPGP2xoAJKMSNBnq9Y+nvyI13M3pXWGofr4sDYf9G3HNK+gr0lapezHHUyqjP2rGWoC3EUCgeg7dmTwd5vai0JpRfJJsKLBu/16KTL1kyEuuQVUIZa+n9uspEXprZociqbhFesDx4dvtYajIEQZf4a7YHROZ/HAkS/KHS6gM1RPB36mWJNiyQpD/Tm7CeSvrePpy2pqY22r2WqK7A9/CBfm8bSnz98mvfacFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txP9QfVmURjcA64zWGZWabuzA2mqoYeu3DQFN3lXfoY=;
 b=m2E0j/6mb1Sei9jxvYYuX07eFrtA+uRTu9jdgvaqye+/R/g9zmPhm/by36Dbi6bbuKCcaM244yhPOCWdSU8RMDYfjbYf4C4EhyLk97iA4pBQDg3utRA/PslBCUVHT5v2AwrFuUQjKlGIFLMx3SrqnbQHMn2F5u6wuawm1ZmqT642o8QmPWTG0V3Jzr9aSxwwVsivZKNCzeUMf+BgMauro14S1jc6rt9TMmny4fqVzG4mqPV0zDz1uj9ti6DOfkvzKyJXDUkPKAZqt4wvQ9QbZdX6cIauOSwdhYDoSVGk8gNuLx1JT3b440Mp5MfM0UDpn8UtGcXseHfzDZxb6SksiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 12:53:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 12:53:35 +0000
Date:   Thu, 9 Mar 2023 08:53:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 01/17] iommufd: Move isolated msi enforcement to
 iommufd_device_bind()
Message-ID: <ZAnWzIbgxwoDlpc/@nvidia.com>
References: <1-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <b2a3ebf2-272d-2f4f-2489-253c4973a6db@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a3ebf2-272d-2f4f-2489-253c4973a6db@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d4a36d-3305-4e38-ee11-08db209d4b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiqUEXc8pwk47Hi9TeyBXxErVbl2NN9vgiw9XRMqZtnPeDPJWYpY/5t6oahS9urpVF4fkgXxsE6saCwQjzKQC3VEUST32NnUbblqdow95BS5K7Dy8ZzTw2ZWVHylDySpKPyqrb9cqkQAu3t5+u/px3GKSHvT7XPHNjAjC7jt3jJ6/hpaVWdTn/9i1HCKE/tP5o/1bxoMy7nJLZBbP3R/wS1RINfW2+xfXhYDkrgi0tRerqQzIq+jZU1oE6KkHaEe/ri6Uv27b0qqFmtFOBMcEN86amPQ4N6mTCvdUvNtmAqSCXkcZjKRNj2BieOhdJgkoyjpifZR20cU6Y+4q8oLhiCZDLf4r+/PnjucDNy8OpJb9oreg8dzojuV0buxa1fvYYuRqBRbyQvA1vYmHUWdp4i8+lIhn0u9EgC51gy9v9FDNQGXZAA7waaTo2ukyrlGDFMPs+oIz6Fr5Xc+ARVpH+IAEvnatZ1wTGivEwf/nBdyyjNuXMRszNL1epaxPPcIs/6Cnfzunb61XWwUckkMysL6VYv4/diQzWFp/yEKYRizhj8pqXqyGelLznVx4rDM29FVAac382PfYeAE/62pW4M+vbsMm6EfqK4R7qVtqhf1w8xpig6s2dafII677zevRyYZmWTla9y2Yl1ae9Va2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199018)(83380400001)(2616005)(2906002)(186003)(4326008)(5660300002)(66556008)(6916009)(66946007)(66476007)(8676002)(26005)(41300700001)(478600001)(36756003)(53546011)(8936002)(6666004)(38100700002)(86362001)(6486002)(316002)(6512007)(6506007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?waK9krwCXL01p0Z6/7C2ROz3Qj8WQlgev4w0ontlrPUDe6UMxnSIRJespfmH?=
 =?us-ascii?Q?2/mD3cRFLpfcA64oG6xONssdgG2zCw5glrYGMtwxMs8hDEODbo57RDuY4Ha9?=
 =?us-ascii?Q?5MYwTvbmy52H2iSsHPO1m/nCRukrWTrD6hji2CwXSqjZBks6ndetBqwZop65?=
 =?us-ascii?Q?Xnz6eXbAqfiEMfHt1L4MAc7Uo9o1SK5fdHdM1R6e2nMmevPkiim/a/r9ob+h?=
 =?us-ascii?Q?OhOafdE+H33fnwEdlibRrUdOzU9+orKWZ+To80W3WLgkMgho7ITjWotpfTGX?=
 =?us-ascii?Q?Nn40bCJ/lfYPrEYPFXdTSmjDuwchBrIYx2EatqiFVxA2e8INl2+Luwa5Tk0x?=
 =?us-ascii?Q?pAmw2RAcKZbSo4gtxf+bLMJK6c6VqghOhZzfKD+XehtLNz2Fpv68watLsu9f?=
 =?us-ascii?Q?mrSgvpl+PjKqGyvIRmqEHvMvRg/FVDjNb1OIeaMo+SiYOe8dj1U7geMhCGpH?=
 =?us-ascii?Q?/p3o57FSGXgmm4a1g2T3uIJMXO5NUmEJdQivdyn98Rz8w5zwKyAvK5fkqHkt?=
 =?us-ascii?Q?PcYv2+PF6wth3JJ0EAKyZuGr0LCngZUcbgOBKgbnLOXQpWKGSgeVqRq3wuoi?=
 =?us-ascii?Q?hGi4rOH1tg12rETFfL82+0O8MkTPTB4Vm2WCJy7w1NvutouuoJ3o2ry8Lp3W?=
 =?us-ascii?Q?gXCqBEl/Cf+BJUHN6Y/0d9hlueeMX7detL2M225oXsEyj/RCE5xn+WfTrxWG?=
 =?us-ascii?Q?MhEhjFY1W+BvMKsgTniuZ2qYYL9mnFAj8FEvoB5sCMFde7saR9L6GUJkiPbb?=
 =?us-ascii?Q?LmSTJGCLRCuZN8ttIHcpcRMSP0ETyp1tOOYKWwVQdUqUB7DOz5Gdb04J48vv?=
 =?us-ascii?Q?fw1oZWA/mcCxXeUXgymgPBqH63yDTre/vXL/XbIDKJB0LeS0TNa27GtqvBlg?=
 =?us-ascii?Q?DqrzdLaUlHXk9Afq65Gtes1+2sTLMoW7HyusAk3/xheUmM6ieLp7GEFCVRPj?=
 =?us-ascii?Q?AZNevLK8EDykVqUNACg1vTwcXH09NkoN7++4AvrYFIjP/3DcUo+nZuFoM2Ty?=
 =?us-ascii?Q?BeFqaFp+oHm7xpNejFKMGUoyvv01lPLUB2lZSf7zgVmeUpxX15T1Adco7H/+?=
 =?us-ascii?Q?374IZbC+TxQQoWL9xYmLCOYyPFpRFNaVN4bSbDRw4bHC2UoGbQyk5VAgYrS1?=
 =?us-ascii?Q?gDq/6lrOexZSWktz8tAvgBSLuoILrq4weoNmju1lOrl2UET+aGevxyCRenJG?=
 =?us-ascii?Q?uUH2LzWUCFBxe/quBBtEwF5+NIAKd5ge09pilhHWwo6A1wYrRrqk7D2w8TSp?=
 =?us-ascii?Q?eG14WTKSi0dqWliudOwV9Ucqf1WDRwVD4ssjVVFGtoDHwkpSQ2xBuuIMPL9m?=
 =?us-ascii?Q?dHrFE/BRQQeeEwKfDg315rfjEmrHEtmm96qEjVVr3dSEy8OKxcLWhZj891tV?=
 =?us-ascii?Q?txExZkCHTrkUeLJ3a7/q5ASxXWGtBG/llxDA7j1S3FtaD1HvbjLvnQtw4q8A?=
 =?us-ascii?Q?Ln2sZ8kQwPACG5ityt6MeMxYdwgNTWZ7aUB5WYU8w1ykuZrBhODlK4YjCkYF?=
 =?us-ascii?Q?bC3Uxosm0MZ6+ttHb5+g5X5SmrNmxyTgrrGGm1LHV5a8xPQChk5g0diOSpZU?=
 =?us-ascii?Q?A6xYZZBGEzQNzKe5znkixlDMPNrhSmqfXwqWnyjx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d4a36d-3305-4e38-ee11-08db209d4b36
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 12:53:35.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuuEKYQAnilHQe3Sja0lEg6OT6KVwLC1ciUJWKGA+XN0sEQ7ewGrBPUArsClpORo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 10:55:31AM +0800, Baolu Lu wrote:
> On 3/8/23 8:35 AM, Jason Gunthorpe wrote:
> > With the recent rework this no longer needs to be done at domain
> > attachment time, we know if the device is usable by iommufd when we bind
> > it.
> > 
> > The value of msi_device_has_isolated_msi() is not allowed to change while
> > a driver is bound.
> > 
> > Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> > Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> > ---
> >   drivers/iommu/iommufd/device.c | 38 ++++++++++++++++++----------------
> >   1 file changed, 20 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index c6f4852a8a0c08..63b65cdfe97f29 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -60,6 +60,26 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> >   	if (!group)
> >   		return ERR_PTR(-ENODEV);
> > +	/*
> > +	 * For historical compat with VFIO the insecure interrupt path is
> > +	 * allowed if the module parameter is set. Insecure means that a MemWr
> > +	 * operation from the device (eg a simple DMA) cannot trigger an
> 
> Nit:
> 
> "... cannot trigger an ..." or "... can trigger an ..."?

Oh, yes that got flipped at some point

Thanks,
Jason
