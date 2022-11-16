Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB3E62B00B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 01:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiKPAc5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 19:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKPAcs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 19:32:48 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8012B279;
        Tue, 15 Nov 2022 16:32:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpYtDCTuiExP+wQMJ4R6T1t75EpvmGVCtMfesOZuE9lnr/+n0KzZYsy4foplCxcNeOql5Fw2zY5UpZpV//uVDAEx5xw6Abj50ehQqO0UlMMmJNUjDaCFHN6DN5jIZcP/gx/CblGtDdJTvnFF3BlyREXIKPV49yE/dv4nh2nUzolHmuz37MKcxB4JdaN+p9rMlwTEpzFqxcK2n1+4VtTcThz35xWHOM47vi867fwTXGtbYlN7iHzgEOTq58ivAm+HoltDEWls8Z4O8SRAbC1VZju6tpAaf0PmrFD9X35ir7VOzj2NwfK+IBsU55PQZ/8rHF3Vg5ZeWGXkO024L8zJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoPzmKITWQdQEVa4vtpaY+kjZxM9RiRFhzdvixg6M7Y=;
 b=ZAnVwSjELDTX3UoEf1BjjYDoybsuwyw2zh799GpeJWuvL9GykQvIstd2TYt73Q6Sxx285lqxHrQYo8XmXtNc6UR4xHdNSPBLSknQkdb45esRM6K32jOPxuR0EjGBYW7tzUkfQ3JFSphezthyF7kmJvN2Tg+zstTvpLQ1fxS0JWxIytBEDcI7ojOtFr8sd075a/M5i+OEegiMpIM2cPR+zs32cx1TdzJpdSPjcqpGDpVtJavlz4uscT2q13YAUz+iITv5a4AMWwu468Of/Ukfaz1Uy8qtENu0lWf/9hlNwYIatu3QOupf2Pi6Lw7D56/kpnYqTTnES2467/MioIAtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoPzmKITWQdQEVa4vtpaY+kjZxM9RiRFhzdvixg6M7Y=;
 b=lmEBVEeNVw8+sGEq33nSywBa9p6ccc0X8LM5x+GD8UyvKfheV38i5ciTLTvZfPyzDcp9JYUv+G3p5MpAWXAphXb+rGTglc104xfIOmkkETQyx9+e/MIb9XmFI6zFVwbf0NORF0Ka5LQ2+13T3zyHta2mBS4Gubis7GCHer0eVXrJDmVrZnI69ndbaUOXl2FlQ4lsakmUjX9RcDdf+zCGf/uNhYgPcAjzAgoNKaU4a7QT9g64EIR2i10rGbrrwAMA+fZB597AX6rxEJKHa8jeIM3VvBJYRogON/p/LdBb/JpTVROJwvjX/FRxQ2uTauNPnYZFXMeudH0GzHG/RXEDRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 00:32:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 00:32:45 +0000
Date:   Tue, 15 Nov 2022 20:32:44 -0400
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
Subject: Re: [PATCH v4 09/17] iommufd: Data structure to provide IOVA to PFN
 mapping
Message-ID: <Y3QvrFSqqxcT6I8A@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <9-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB527638FCF4A1351DBA1A644E8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3KMbyVwS6D505cA@nvidia.com>
 <BN9PR11MB5276CAB38B1691983A20B1D18C049@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3Oqq74bKsQo1YMH@nvidia.com>
 <BN9PR11MB52763671DBCFA976C0038E6A8C079@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763671DBCFA976C0038E6A8C079@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: ae580299-3983-4f4e-bb6b-08dac76a1472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxqeFi0GC3N42E5HmuJSdsA7vWA69xCPYwDto7ZLyI8vR8Nv0fT/SGsnfPS1Zzgij0aF+y3s1FL/0z3EWKW+J3Omn4deYLhs5CcSrDtudRFIgVAxFax9qgkD9enfjyAfTQtgoKBtX161DWeoZj4ntiLtknUrbGeRAjE85AF0T/fynOQQ3ktWyUdu/CeLAJDnpV6XMhIBhBWDM8k7T499NlWV+ULs2LXBH8ngVHc90R9kyTrUTztamuRv1/l8qGxvMPCRuD+iNnhRdC3l6ZQWGL3d+tL45t8xIj2sM3jaWaGo8xU7P+zn8lZm9AtTo7EOadADRb8C61nSTnPzfkh4lWMhox2bgxqfC897Wu/iGvij/lxMZtpoUuZJ2/6UgU5uZ3fEjQt8wqn95B2dSCPRVhO7gPX1RCoOgrhVRJJmjs8Ih5XHnr2zrRicEPB5eAF9C0o5rdKWPrZ2ZukINKiRfqlKSscz/rUOxO66Flb9aATpBFX+yRGdVXq1R83QVno98yDVpGXbXdOHX/ZGg+x5SDSCjJx0d+DYGW1yM5/9WUr4IhJFvn2gQVelzYst5RSJyzmXEQlzuBto6P5418Flu6b/hnzzc02660sm9NVvTrep7swo6O//xAUBWv5jrWXTJf+u0ir0cTRL598IPXXkej3Zrbby79WBRWYRkrD/XRMsX86xHYk3aloviXXpZeROYIqiFRIvL/xBsdCcpi1Z/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199015)(478600001)(6486002)(54906003)(86362001)(6916009)(38100700002)(316002)(7416002)(7406005)(83380400001)(6506007)(8936002)(186003)(2616005)(5660300002)(66556008)(66946007)(4326008)(41300700001)(8676002)(36756003)(66476007)(2906002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lz/L7JIuekRltsZsF9mpi+XN/bwFASzbCZP8knOE59IMvGKuCfkKJbIS834X?=
 =?us-ascii?Q?+lFRudssu2IUueWR/D/brFZjnX/7vyNHbykJ8RQuqVtpqS+pP7uKmgUPbbWA?=
 =?us-ascii?Q?9kWdhOb5zGCViGtryD+mQPWUH5XftH9NqIy8F++cQyJWd1uEXECRD0xh8gq7?=
 =?us-ascii?Q?11TQxRz+oPPVDCtCdr/GYOuzJymQfY6Vi5FbuKHQ5Qi93RvDgTQGjK3gdJ3t?=
 =?us-ascii?Q?DHDHM3LwfBgYy5P4BIUfEMQPJKTNZRCHHGr6eTbVRvp84ly54kvbALe0ymsG?=
 =?us-ascii?Q?BZqgNHf9XjOVzwObGV8+YUgsXNt1IM9LIju0GHEVekzALdIZ2S7UuRRB2HYb?=
 =?us-ascii?Q?/dTHl2Jn5ZjwzN/r8xCKFT/qi7ck7KtkpJob5HHIVhnY/cR+hVp//RepY/7M?=
 =?us-ascii?Q?iuGPQu8UZ0FMJpxhzPWiEbSPy/UiwJIif8SOIQ0ksmq5COTh4K2llTXBPT7a?=
 =?us-ascii?Q?Fiwajba0DvUXvnPOFqEw5oA28rsGGAjBbNZUnF72u5Pdl7YHe4JoCwy92QVX?=
 =?us-ascii?Q?xwnSp92gTfGjf1CVT2Xg/p3VuyBRpi7N5DwSy9NCexbyar5IbUGCeZYDDM0v?=
 =?us-ascii?Q?NKaeaLAcQY6KpYWOXhxDeeq/DyoibHzWT3bklzNrg/ICa3+VbPaNa4e38EHF?=
 =?us-ascii?Q?ivZgrEGo98s+z7VPOTHY0F7pycMvQpNATNZOjiQwXE7mpucWERhWvsUNWF22?=
 =?us-ascii?Q?g1RtJrWznFK4CTueMJQRyGIZSp1vdya9udjWUUs40xBY+H14XsCHvXaIZsWf?=
 =?us-ascii?Q?SEi+8cmedfl2RpQwG+E6laV/Vdm276EVQP7Ww+Dwm+6MKMV+2D4vaUupv9Q3?=
 =?us-ascii?Q?q0uNpPJ7Zq/C9qE8w/aKH9z9CzxrPOtvHUUMWlKlvqWVdb1hESl9dcv/88qB?=
 =?us-ascii?Q?7yZA2/UYop7a/qX1UDdoV/wvVTOvHNewZLhb/7OSMb6ZiZoNVm0YsrzVAAx/?=
 =?us-ascii?Q?lbLIsEsJ9i31C+GIb6yjpuDnNZFap3oargGDAfvEd+uArZDIg/GcbgK7ueSQ?=
 =?us-ascii?Q?RCelqY+hFq6b3cswVp2Wjj9Lo2PdogQJ/VBjsAL+dp4AkFaCFxPwzXDVe6Wh?=
 =?us-ascii?Q?6KnezKnkEYgCg7s7J74XO/n7XsDS6Z+6UzOLvgGx1qt5pH77H7XkdhfTVzPL?=
 =?us-ascii?Q?oDZVaFDCpW0r4doeCO8RjsVzww1X1+Sw6iGjPW8PMUxs2J0+/KOxloAOsBiS?=
 =?us-ascii?Q?Ef8FZEWEBGteDMJAtDbw7AUSYYmdN1p1f0IRZv6V/7XtMmqh4bY609y2vfR9?=
 =?us-ascii?Q?DkeXa+bHyuEHVxUXX0sQtuOkvhuUxPzRkrX8texfD1UII+pTq3UY8d84hjDy?=
 =?us-ascii?Q?x3lUTq8MM4aphC3pCWz5ctWCmJYAiOgspVOzXLxbwfAql5Av7+cHnVg/sa9V?=
 =?us-ascii?Q?sWxSTM9nZrhyT5GwSMGFcdgV057XpNfV+GoNX04Yetyw7lpLYTCi+GaeOVxh?=
 =?us-ascii?Q?x5Hk7GuM8LVkvawH5TIFIr1MkaEb0BVznikID71+nPCx+NHNyK1mGBEe46Tv?=
 =?us-ascii?Q?N066zNpBDWIDK998ekkytD32xGup0tjedx63TWDuacPokM+5x3oV0qmPDGDS?=
 =?us-ascii?Q?LvKDynxX9yJCLYOiqhE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae580299-3983-4f4e-bb6b-08dac76a1472
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 00:32:45.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Hmf5ild6CTdGGIUioOvJbKTaeSOYiZoE4IYBN5WXB1qV0x3j1qhpJJccgn+kwv5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 16, 2022 at 12:09:52AM +0000, Tian, Kevin wrote:

> > > > 0 is commonly used as an errant value for uninitialized things. We
> > > > don't automatically map it into a process mm because it can cause
> > > > security problems if we don't trap a bogus 0/NULL pointer reference.
> > > >
> > > > The same logic applies here too, the allocator should not return 0 to
> > > > reserve it as an unmapped IOVA page to catch bugs.
> > >
> > > CPU doesn't reference IOVA. Where do such bugs exist?
> > 
> > SW is always buggy and SW programs the DMA address, so it could leave
> > a 0 behind or something during the programming.
> 
> address 0 is never a bug in DMA to IOVA. if it is, it will be out of the
> aperture or in the reserved IOVA list. 

It is a SW bug in the sense that 0 is commonly an uninitialized value or
uninitialized memory.

> DMA API is also a auto-iova scheme from driver p.o.v while it doesn't
> impose any restriction on address 0.

It probably shouldn't do that. It also allocates -1ULL which causes
real bugs too. :(

 
> > > > > > +		if (!__alloc_iova_check_used(&allowed_span, length,
> > > > > > +					     iova_alignment,
> > page_offset))
> > > > > > +			continue;
> > > > > > +
> > > > > > +		interval_tree_for_each_span(&area_span, &iopt-
> > >area_itree,
> > > > > > +					    allowed_span.start_used,
> > > > > > +					    allowed_span.last_used) {
> > > > > > +			if (!__alloc_iova_check_hole(&area_span,
> > length,
> > > > > > +						     iova_alignment,
> > > > > > +						     page_offset))
> > > > > > +				continue;
> > > > > > +
> > > > > > +
> > 	interval_tree_for_each_span(&reserved_span,
> > > > > > +						    &iopt-
> > >reserved_itree,
> > > > > > +
> > area_span.start_used,
> > > > > > +
> > area_span.last_used) {
> > > > > > +				if (!__alloc_iova_check_hole(
> > > > > > +					    &reserved_span, length,
> > > > > > +					    iova_alignment,
> > page_offset))
> > > > > > +					continue;
> > > > >
> > > > > this could be simplified by double span.
> > > >
> > > > It is subtly not compatible, the double span looks for used areas.
> > > > This is looking for a used area in the allowed_itree, a hole in the
> > > > area_itree, and a hole in the reserved_itree.
> > >
> > > the inner two loops can be replaced by double span, since both
> > > are skipping used areas.
> > 
> > The 2nd loop is looking for a used on allowed and the 3rd loop is
> > looking for a hole in reserved. To fix it we'd have to invert allowed
> > to work like reserved - which complicates the uAPI code.
> 
> The 1st loop finds an allowed range which can hold requested length
> 
> The 2nd loop finds an *unused* hole in the allowed range
> 
> The 3rd loop further looks for a hole in reserved.
> 
> last two both try to find a hole.

Ooh, OK, I read that in the wrong order, you know I looked at this
many times to see if it could use the double span..

Ugh that is a pain, the double_span.h isn't setup for two .c files to
use it.

Anyhow, so like this:

	interval_tree_for_each_span(&allowed_span, &iopt->allowed_itree,
				    PAGE_SIZE, ULONG_MAX - PAGE_SIZE) {
		if (RB_EMPTY_ROOT(&iopt->allowed_itree.rb_root)) {
			allowed_span.start_used = PAGE_SIZE;
			allowed_span.last_used = ULONG_MAX - PAGE_SIZE;
			allowed_span.is_hole = false;
		}

		if (!__alloc_iova_check_used(&allowed_span, length,
					     iova_alignment, page_offset))
			continue;

		interval_tree_for_each_double_span(
			&used_span, &iopt->reserved_itree, &iopt->area_itree,
			allowed_span.start_used, allowed_span.last_used) {
			if (!__alloc_iova_check_hole(&used_span, length,
						     iova_alignment,
						     page_offset))
				continue;

			*iova = used_span.start_hole;
			return 0;
		}
	}


> > This is the comment:
> > 
> > /*
> >  * This is part of the VFIO compatibility support for VFIO_TYPE1_IOMMU.
> > That
> >  * mode permits splitting a mapped area up, and then one of the splits is
> >  * unmapped. Doing this normally would cause us to violate our invariant of
> >  * pairing map/unmap. Thus, to support old VFIO compatibility disable
> > support
> >  * for batching consecutive PFNs. All PFNs mapped into the iommu are done
> > in
> >  * PAGE_SIZE units, not larger or smaller.
> >  */
> > static int batch_iommu_map_small(struct iommu_domain *domain,
> > 				 unsigned long iova, phys_addr_t paddr,
> > 				 size_t size, int prot)
> > 
> 
> I meant a comment in iopt_calculate_iova_alignment().

How about "see batch_iommu_map_small()" ?

Jason
