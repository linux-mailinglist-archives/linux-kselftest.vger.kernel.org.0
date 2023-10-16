Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5B7CA746
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 13:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJPL5n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 07:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjJPL5m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 07:57:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B72EE;
        Mon, 16 Oct 2023 04:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS2ezBuLt69S/hk72IftAzpqcTurMU2d3DUwXjIOmBjtpOJEq6AxsuDLYQeA2nvZZtnRrGdhK+YBKEbPgNZuhTWRoDtWUAtW/0RP9AXLl3C/mVC0DmlbsuNWajliIntHAv31zuWwUA55ORQCky8vkdWjsANu0XBowQZLFIZXVU1Pzi/jYek+KTeKE1mPXTB0Z/rwVWTgxVcBRGZZbcOkb2gmLqL1ZgGc323q7DA6yw8Lt6hipzoJaxYmmQLxGGDFOlA1So40M+ZxDVP2QxwEQTaw+M28q3xBeHwf6SJ02JUSk7g4pzufgG7RVe9OZSVNQMBQTFWhp5icMruHpIUJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v13PLWkXZ66wysx6qv0HBBTwj9vKz5xqJXtl+0KE4mU=;
 b=n6Cb35g5lmsJFsGjvtJe4MdGEginUnXDLEY7pBPPtN8CdPQzss56OAvLVRe4dkdhx2D0HF3MS6FPeJgybfHzuYwY/isMzY6eTuEPi/67iCBohPfUCOjj/5dXGmrCpb/VeM/LpqFE5XkUoOAR5B3jGqaPI7t8Ta8NeIXhJ3md1qH+ZSQcd0Jq5MoJ7U3nDWTO8AIaJAK3zmk6/phP0zSFGZAKBHBPfrEESaeEW7LnYkCcMSNhN8/K6ujl+7UGrzSe+LLuwO5EPqQ7VULI3U/d4HDzZ7X7MBP4bSMnibkVtI7XqL9G9G+p/+Vfjro0HEWrcLqWs5850nd5sX1bKJ+ZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v13PLWkXZ66wysx6qv0HBBTwj9vKz5xqJXtl+0KE4mU=;
 b=HACbzcz+3IEHwH91KumijGfznDZh/TXugP50rC5cE29Os6OtiqfKB6s8RCN+4pYCl4n4d5C0ZJz4Dsrc+2IbyoUoON2+xDs+2GQ1zRrI/a3yycI0Sageu32spc/WIgLquItLh4E8gjvDMKUhKXsS5ihdTcO5r9CxiuzBL4eTW8EI7DsxUpL8NsFlMO6qnArVRlP7h3ZAiPOwZcWvA+e9RBUKWJO+h4m7rToJ6F0WDAWpNaewC442RQ5bVjcZEZYKHSAeprN6Qo4dExqTRtBbGNH8jqLNR7gxGXW1hRk8ouvnKeYk2wenfPyElUtbGcjvTVZF8cqtWhEP9weJNGM6Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 11:57:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 11:57:38 +0000
Date:   Mon, 16 Oct 2023 08:57:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Message-ID: <20231016115736.GP3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a481a6-1720-4908-598e-08dbce3f178f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6/xQ+PNfsNskXNgWQberyLLXx/Wm+MTLitZJGKWoZ8soi9VK3Eswyn0cMT32OtQSOKP06zSp6yfsbruBtag57gulLFjRjOr5LgQTOUD8zjPEbRMRRPjPYKjpDoFoP4Av/zkxXZqsLCu9xBGh1EX0uanReNu6HCxluUmtiRWBIM8ClEn+N4gWSnGAZSRo+IOiQJjDNgZIm0yy9Kz3LT5oPN+83+TQ5kcEESS1lrfb+ty6qeDyQMhrMyjp52QZarpPmEO0GoI67sYulGnRebk31zHMXoZqBSGiEQStx1J7WVU1OHzYJv+TCy5ZOcUaWxDXLkKouRRtvRugm9CTCT13cGyMdDEtzeOndo6wJQppgXANAmOzt1hMvEW2VjIEDD/jIMz1pb30dWZOqnY4MSqD/GacJy63WaanKksgz2zrRYNXroROOcYk6GwS/CeUrxAvvwnTHYQQ29FGBv7O6BjzufCItRqAhqYMW8YY/ye1ZuKa53nM5sbItBZAd9d0G16/j4TSHCPTon5ElrI7A45zGyWVMfPnOg6zxOVsjpAfbOYPaRyX9st95/DqK2pPpFt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(478600001)(6486002)(66946007)(66476007)(54906003)(6916009)(66556008)(83380400001)(86362001)(38100700002)(6512007)(316002)(2616005)(26005)(1076003)(6506007)(41300700001)(33656002)(5660300002)(36756003)(4326008)(8936002)(8676002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FsrlPBU7f8zhWFz6B0SQm61A1F7df8ShQLCoWqk9OHmaa+dN/RKrbgVtvYLs?=
 =?us-ascii?Q?DkLyFFSYD8mtrue+7zmynnYXBoP08yIBWNYrCb/Fp0/0gpwEQjyzs8tqV8oV?=
 =?us-ascii?Q?Z474Fh11rPa9PLHrMxTK/NyH8XSacY34IfaktB5ZCDlXz0fTxlXlBNMFXgY/?=
 =?us-ascii?Q?JE6cG3T7bRq+aHY69o3kW7uYv/P2hqPSQ7lykRc+pEYNwLgjp0QduuihNvdM?=
 =?us-ascii?Q?DKaZxaj+UkgF7G9aOL8GQOFS7uFkJWH8o/Vz4/K2VTVxDBa/qzLTnhVckv21?=
 =?us-ascii?Q?omrETqK4y08RGSGYu61enGivQ6cOtlXxzhfuxzj+DoQul2twjCfyJvUD9Xl2?=
 =?us-ascii?Q?fRrvP0uruvSrP/BoJzOiieftnbDRxcDi1n+Q2BeK9f8oBiQohWQ4iRFK6mSI?=
 =?us-ascii?Q?TgJPy5QzibfLde1nXiqo2Bt/GuwCXEsP6Ib0J4k9CfWtwI042c1UhyVH/DdW?=
 =?us-ascii?Q?X2BmXQ3U4c6e/z2ezqSTmEsXF92/uK992GtREoRxmTecVgA0/9r2ilQVZb3s?=
 =?us-ascii?Q?RCl0WASiy8/87kfIz84d2OSoc+z1vBGRpq41H4xyqBlU56UF1+X+fP6irSIi?=
 =?us-ascii?Q?SzfD/9DaSSI/wdYvmaRRnYRWpw3WXOPeIW+DC6wXfWf+4UnAk4JH7eBG6KR7?=
 =?us-ascii?Q?uehEXeKXoXKTxiajMNcp5Nl81uTeuyuvtYtj85i702h1GMioNoAr+09UEMGE?=
 =?us-ascii?Q?/xbKE0hXbXj5WVjG85aAJ8oRZdVw7jrkb9wHuQDA54h8f9ZxP36Y98x/xsn9?=
 =?us-ascii?Q?L/Rj27irkCgOrSeiCaPgaKW2m3w0tlFvTAlWs7vStjvh9kR667KmN0gHUq1c?=
 =?us-ascii?Q?u3NKF28sNxyKbDNzLeXG8LFsjOpnH0NsOqLwbe9Y4+mZE4WlO53wWmUgSrnm?=
 =?us-ascii?Q?Th8oYhjWU0MmVE7P1ZlQqVgXAD56gxqxhlUeuvGJuIKUFdLZqSXAseZrmaB/?=
 =?us-ascii?Q?cqkz3D4NQPKrhN0R8vrS/GFJjaU1C84tX+qz6NF9RXpsyJT2LZC8rPuIWyKG?=
 =?us-ascii?Q?KHw7ZJ84l48Vxtn/FjgiTjr2qouE9SonRYI6/ITpkKup4fZ1amfPtkjAGfjE?=
 =?us-ascii?Q?PGMJPrqa6nFwWL5J00ToKDt6Nrk1KfzuNLWS67NoLUhY4AbXP2WDRvSPDeDh?=
 =?us-ascii?Q?srvPEjsVjJwyxC+wR9eW/Il+oVsfNobxHTP/cFiRktlybrIkPF88Txo6AbHj?=
 =?us-ascii?Q?d5xOqSUg5UX99ta5McbLTLdRDkGbRz3nA6R31TIt2jZWxa26Vf81e1fexI2k?=
 =?us-ascii?Q?0d4oAnQ9iR6Np50cLoHTO1slPJZKjuUE+Z7CuQwsVebGSJAV6v76gdLWQymx?=
 =?us-ascii?Q?uwspDTe6b/3xgJPjhgjqVNAHKlsTUOWeZ6//WRsheO+uwE5vjfLFIhVOQIXD?=
 =?us-ascii?Q?xOY75YXFjYORG/CEWf0U6Gch5Vt2xDtyNxpGBrlhvcNxxaRm1T5alNFHxeQ4?=
 =?us-ascii?Q?1NQuIbsZUvLc5XUbgnDseAvW4Uv4jIOynaH9vgydn6lFcDW0YtgTc6pKkOq5?=
 =?us-ascii?Q?VoYI+meDBLanJqW5a/tiP/aGbATiYMXQAuUvXaTBVeppwaLbv21o1+PXk+TC?=
 =?us-ascii?Q?fW22IIZyA73YmXAqMcE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a481a6-1720-4908-598e-08dbce3f178f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:57:38.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbtT0U1cuRZAuylEEWagtiiw3vNjfg9ikpj/DYeezdqTJgf0LG41PSPybhD8oAdD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 08:48:03AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, October 14, 2023 8:45 AM
> > 
> > On Tue, Sep 26, 2023 at 01:16:35AM -0700, Tian, Kevin wrote:
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Thursday, September 21, 2023 3:51 PM
> > > >
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > >
> > > > Now enforce_cache_coherency and msi_cookie are kernel-managed hwpt
> > > > things.
> > > > So, they should be only setup on kernel-managed domains. If the
> > attaching
> > > > domain is a user-managed domain, redirect the hwpt to hwpt->parent to
> > do
> > > > it correctly.
> > > >
> > >
> > > No redirection. The parent should already have the configuration done
> > > when it's created. It shouldn't be triggered in the nesting path.
> > 
> > iommufd_hw_pagetable_enforce_cc() is not only called in alloc(),
> > but also in hwpt_attach/replace() if cc is not enforced by the
> > alloc() because the idev that initiates the hwpt_alloc() might
> > not have idev->enforce_cache_coherency. Only when another idev
> > that has idev->enforce_cache_coherency attaches to the shared
> > hwpt, the cc configuration would be done.
> 
> is this a bug already? If the 1st device doesn't have enforce_cc in its
> iommu, setting the snp bit in the hwpt would lead to reserved
> bit violation.

I suspect there are technically some gaps in the intel driver, yes..
 
> another problem is that intel_iommu_enforce_cache_coherency()
> doesn't update existing entries. It only sets a domain flag to affect
> future mappings. so it means the 2nd idev is also broken.

This is such a gap, intel driver should not permit that.

> The simplest option is to follow vfio type1 i.e. don't mix devices
> with different enforce_cc in one domain.

This is why I wanted to get rid of this bad mechanism going forward.

Manually created hwpt should have a manual specification of cc and
then we don't have so many problems.

It means userspace needs to compute if they want to use CC or not, but
userspace already needs to figure this out since without autodomains
it must create two hwpts manually anyhow.

Jason
