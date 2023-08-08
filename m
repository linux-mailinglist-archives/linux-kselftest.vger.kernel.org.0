Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9192773766
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 05:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHHDNB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 23:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjHHDNA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 23:13:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B870E7;
        Mon,  7 Aug 2023 20:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z82k2cXZuEdxRZDNC7SY+5pHFh6EfvrGZO7XDv48W+RAyvfcne3ZLlxk7mhlZWBtxmbDJZybaB3X+ZbexK2Iup+muIKLqgvmifxPAeAIMW31U/If/t4w6dFS2E0Tqs4drk/yRQEn9xgg3mmI8xtv2N2e+DPafwovsaQrPw3JVDHKQLOSDLSSRjAP2dz350OvCSgATQdcF2FY/7iziph/UgSwlDXvuRN4BdwGLOITUNV2i5bgJ1/22kQ8BCXzjzSGAP4+HoivUAweRkZVoPKOV8PkqKzAM7hbW3S4CxvqzDi8eTNR6vpXHUmHBcsrhZdCj4hkqjRQ6BEt91FH/QfSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eALnJYcGKflQ/kh5eX2J9rbfxsXpouoABpu2G9OAQlQ=;
 b=nUsb4uVSpLuS1KNCQDLHX516pu1y/ClrnX+08wV5MlJJdAhjslw10RvPjV66WR0mcjc8VrbNk2kGRcd8Yqyzm2klY2g7YA2r3lEyznJnncH2yGdkHWUGy1s1lR4vZBxx02qeCnUUSy10B8b4F4QzzwHxhn8FMERGenIpf+C5OuR48YMicEJ3rNRE8Azk+h8eySohU2XPi/jiDklt0nUn4HklW+JwNIDArNy5W9dSAhqygotoxuuezxPbXkzh6v6z6Q0hIDkxPcLK/Q4ZyFV9H3Vv2C28A0UhhsIKLxJzhF4Sh0ZB+nLj79o3TAAEN6nqfRhXClJN5wtbfiIYEooCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eALnJYcGKflQ/kh5eX2J9rbfxsXpouoABpu2G9OAQlQ=;
 b=eHTzMFFp63WQpdluivgRIWmX6XwuEzvPeBq+vOP6ciM7aaKNVmX6/W+juPHrOwgZHLdbP/wToUbeitOiKc/yH/vejXFtxyE0gvU8rftheC6EZpCE/LH4jiFJlm2w/UGw8kQxYLTIygcb4wjJG/MphQ9HLoJ8IHKA2mEjeBWP1k9o+geIaqN7Fi8POD2kANRxZ0q/tfMiFIVA1lpfc7ymemf86EqLrqVxX+c1tIoOX86xmrPVvgXRGfsuClbrzww8YqsmiccLItxEtQq+Y9fsw1WMsjZWx09KaBhN0q1P5BxUWmBmcZ6t3W3xlUQSdjUvnMfu2i1St3IeOPZ5eOjIlA==
Received: from PH0PR07CA0060.namprd07.prod.outlook.com (2603:10b6:510:e::35)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 03:12:51 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::e1) by PH0PR07CA0060.outlook.office365.com
 (2603:10b6:510:e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 03:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 03:12:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 7 Aug 2023
 20:12:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 7 Aug 2023
 20:12:40 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 7 Aug 2023 20:12:39 -0700
Date:   Mon, 7 Aug 2023 20:12:37 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZNGypUee/U9d68TZ@Asurada-Nvidia>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cda00ae-25f4-468f-55de-08db97bd5b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0WLcyo5yUAUJhOWtpYtkCmk/TN7egcaFnOw0k/NZsHIkIYqnHYPBUpbgXbAJjQ0a5qpR8apH7LJe2ZLKZZhSWhQ1J2P1Z99WyX9FAU+RmWDs58t60Fekfkeb+iMfCaAdehzRsyZNoBTREmxD+70E8LkkyiVD7Cm0zkiEQVi8uJCx7KaKNaF74nvL5YAT90s5az7JL5B68VEGVMI5kZS4uiqMdkxSDx5Rr3vLIYuqEENs/iL9EFv578TDSCaJ+eW1sFyY3xwGZbs9/H9NqR1qnrl/tFWKw+0msPvsSMRZvzD+ZP+mtoPbXXdV3fdu5DpPppfKQhtK6MuhWDPExSLm9sZiSrSQqMLt5NLwqCzIJK5DyvKwf4vapfAyrlBbO3F0atTMDulSQqtPNpkv+7AKWmtInHXPZYqrzdXssqIft6p6Y7P0GSansUPej5ZvvSk1su9FiK+IzLF6sE5cyD0is1Qh+CnEEJXCcBECacB5AWm1z2J7WAI2RPfWWJAehxhvPoefk96n2U0uhLFMFgL9h9OeWuirUlkKdyG+qg0IqPx9Y/3ro/azBZ/bKFU0aijaieNCo1/hl7ZCJ2nG2v5Km6ce/av1Ci89LGgWuHac91pOrLr0DpQslu3uVS6+qtjE0/0Dm6IhOGD54PqtLbUdbn0ZQpa/h4WoIX/w1cBWZ3N8hvyE686Vx9GEUr4ZGDjspoUjEfFY+Ys6rjc2WAyng1xLEKN6mRnomAnkrKpUehsDMqM8VyB78vVF4terAt17E6CNmUAKz+SZJVTgim0Mauw/GAAYjigBHgimI9RGkspGuPNRNIpjwNFMd1ZOs2N
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(82310400008)(186006)(1800799003)(90011799007)(90021799007)(40470700004)(46966006)(36840700001)(70206006)(4326008)(6916009)(41300700001)(316002)(2906002)(54906003)(478600001)(9686003)(26005)(336012)(7416002)(8676002)(8936002)(70586007)(5660300002)(426003)(47076005)(83380400001)(86362001)(36860700001)(40460700003)(40480700001)(356005)(7636003)(55016003)(82740400003)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 03:12:54.3236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cda00ae-25f4-468f-55de-08db97bd5b9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 07, 2023 at 03:08:29PM +0000, Liu, Yi L wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Monday, July 24, 2023 7:14 PM
> > >
> > > +static int intel_nested_cache_invalidate_user(struct iommu_domain
> > > *domain,
> > > +                                         void *user_data)
> > > +{
> > > +   struct iommu_hwpt_vtd_s1_invalidate_desc *req = user_data;
> > > +   struct iommu_hwpt_vtd_s1_invalidate *inv_info = user_data;
> > > +   struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > > +   unsigned int entry_size = inv_info->entry_size;
> > > +   u64 uptr = inv_info->inv_data_uptr;
> > > +   u64 nr_uptr = inv_info->entry_nr_uptr;
> > > +   struct device_domain_info *info;
> > > +   u32 entry_nr, index;
> > > +   unsigned long flags;
> > > +   int ret = 0;
> > > +
> > > +   if (get_user(entry_nr, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
> > > +           return -EFAULT;
> > > +
> > > +   for (index = 0; index < entry_nr; index++) {
> > > +           ret = copy_struct_from_user(req, sizeof(*req),
> > > +                                       u64_to_user_ptr(uptr + index *
> > > entry_size),
> > > +                                       entry_size);
> >
> > If continuing this direction then the driver should also check minsz etc.
> > for struct iommu_hwpt_vtd_s1_invalidate and iommu_hwpt_vtd_s1_invalidate_desc
> > since they are uAPI and subject to change.
> 
> Then needs to define size in the uapi data structure, and copy size first and
> check minsz before going forward. How about the structures for hwpt alloc
> like struct iommu_hwpt_vtd_s1? Should check minsz for them as well?

Assuming that every uAPI data structure needs a min_size, we can
either add a structure holding all min_sizes like iommufd main.c
or have another xx_min_len in iommu_/domain_ops.

Currently, we have the union of structures in iommu.h and also a
xx_data_len in iommu_ops. So, neither of the two places seem to
be optimal from my p.o.v... any suggestion?

Also, alloc allows data_len=0, so a min_size check will be only
applied to data_len > 0 case.

Thanks
Nic
