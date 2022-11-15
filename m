Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05F629CED
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 16:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKOPFX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 10:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiKOPFV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 10:05:21 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1CCA1B2;
        Tue, 15 Nov 2022 07:05:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz/gcMYKneHtW6ckyn1GwjZbFEdose0g7UbaulPn4bn/E4bVE6islKY8nokzfhE50kxUP5ml2Su8FgBdc6RfOhjs0A3GvvP6bs5Oa2atUkuJ2BVI+FWVmCNmFtfGAWjQDfLzsDLpofFpDj5zNCBqwxdCY36J9fanTBJgNLNio9f7yPjj3J9Qfdu9HK3a4WE0VVutLn0Xk8vgVccMhXlRfvXVuUcY7ZDyXUUtOpnrnu9SGyXCIPnmCzVspoFwQ+ZX2x+KHTDICuKlyX20v5lDdbqLclwFEWSaZlstZOgQkHCOAB8d+dUfA2OrF03BsRBdRLdeJsFX6dxbNZf1gjd79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J02oea7PZPCY7jpwjjmdjlROdLqj7RHg9e0Z/xsc5Z4=;
 b=ig9+QIGz+UjlGciDp8yVR7zPTYDGXSbK5xf0ip3kQhyEV23i6MQq/PB7biNTSyc+JGY6orAE55B8YMxbebS6kTfCA9zIgpSTDI40uEI7unf4mXx6hIAmnLbB1cigRk0JDV7TJeI2VOoX0qP1My13Jj5dQxdUfx3P5dqBIGeEpcJq0hhQwSOBkdY0d8HuCpeyAUaNq76WZ1bTkA1wE7Qi4oOUtlcgM9gFiRYAjRwpAc/xvRFSrdswocUscFUAXvN5GWyfkMaBLzCC3n90R+G/XwuJ6n3VgPpDTlZzUjRFP/CIogWoeXlX0kyivB0g/9FmF70vymxR98OVPJk1Et4Efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J02oea7PZPCY7jpwjjmdjlROdLqj7RHg9e0Z/xsc5Z4=;
 b=Xerap/rN6i94Ikc9MNzyNaZH13gUXNdc/GicUbQ1R0v19YRiUQMgpK8AOBKZj6lQitvZUvVWWwrCLV06mDyOnWxLpQzBhkjTD8PcRT11laiBUAg8jpYBWxiwBkaiblL92ufaZyppnsoMe+uRF5NY7PYH2065syDxAmvwc8PkMlmD6rWl5e9TO2+fH3BkuJuANjAJah4KTXi9CyfhSENnhNNSy7HNg1WpFsQAqIlHJAoDDuOoKiVjAoXSuq9rkuiTrBL77cXLE8+S9/j/HH/7a+G54oneEWdv9kV3ejOgqZ6hgxbPhuhnGPKnJe2pQdKbLJepJd7lUNHsxKehxhpgxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 15:05:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 15:05:17 +0000
Date:   Tue, 15 Nov 2022 11:05:15 -0400
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
Message-ID: <Y3Oqq74bKsQo1YMH@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <9-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB527638FCF4A1351DBA1A644E8C059@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3KMbyVwS6D505cA@nvidia.com>
 <BN9PR11MB5276CAB38B1691983A20B1D18C049@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276CAB38B1691983A20B1D18C049@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d88027d-4945-4c4c-a4f4-08dac71ace23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gB9Ob7LCmMSEZaSs9CCWfhwH+lo1GJ3pa09zDqxEMW9yeKN82LEtVhIZ0stmIOaTGBZgtuwP3EImDJQCZbs1ngucCVstsMxHKcmmPN5H6T34LpVWNHFAm0zTOZoYpPxsZjKrmEjqKB+P0GFufgKeM2lHHNDTvFLq0isBoqU/H1CsiKLgFKzlFazDtUAQr4JSPe7+aPeOD/F2n6+QtE3gXqp2feidH3bKigfHpQXgnr7enUYVO6cOwpzVRsAezn7ybxnhn3jgSLq2vuHtAz+LP5dsYo82lJ6nFKa7p9r9A4k8gxndI8bkMBzWlkT3QLzViEEtS8xo8YlK7G4A7KH8dUuUf++C7fcl4h89LazusHTqCdVaKFs6GuNJ+rPqzg3eZspIxmP1tZEoRzTfzZjFGrfY8PaCtJHaBVMb5L624edk4SEAKwhVkYai1DshK+uHYIGZBBSqRBeR5/zsUO9RY0ogPdFs0axDz63NPOo63dhcXvdkIItm0oNWgPTlo3kJ8wn8ivqlZp0R1O6DZWXqYUCuy0GikP2Buh9xuP6ib4Qu5yqMahdJpiL0xqAoDyPLG0pGYTw5X8cjIx60mWZXRri2MeLqxuUICRsrnC0039tDECJ6XDp+R5Wnpgx3pnkJF+U5vW9zIqi/I98xC3+T39tWhHwpLganLZmWMmA7JizRlQV59OTg/XZqTPgZ/od+fTfmtYGfTj+GuPuxQWlLtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(478600001)(6916009)(54906003)(6506007)(6486002)(26005)(316002)(6512007)(86362001)(66556008)(8936002)(38100700002)(66476007)(186003)(4326008)(8676002)(66946007)(2616005)(7416002)(5660300002)(7406005)(36756003)(83380400001)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zE6tcv/O49PUcJVxB88pXmCFqaZF79jCjoz6XKV0PvJcgDeqIObGj9VMy8Fk?=
 =?us-ascii?Q?C9Een9ctnU42a1tinT2hK9SnroGwGoOKPRmKYzPAMq7a5f8SjiU91jWxj8Wo?=
 =?us-ascii?Q?T7s9p76tw6E/TOzEtOxmOUZBtZFyIXnRMnwYIaf6juTKk+wmZkFyhBOVsuy6?=
 =?us-ascii?Q?KSSx+gUYvElIFIKVpFrmjGeLo+4wbBBXce5M2HLI/bUbqQMb4yoswvx/JfSs?=
 =?us-ascii?Q?pSWOfUtLhpEa7paz7ZgFbRHDCLq1Kcyv9UryifOhYEVN9jGuwYb7yl2Kg8nP?=
 =?us-ascii?Q?ZuMdQws8lbNN8styv7XLxyV5nCgPS3fD5HtVGPB5CyN8uQ/2s9l22Rdv+G4o?=
 =?us-ascii?Q?FwEfkTDMO56YQJadm3nY15TRswq44XWsc/Q8KuEtG1MpJHL/BIUqLjby2zkU?=
 =?us-ascii?Q?nzaUT3CPiFIQtXEaKVV6/wD561nRxQQe8+zjQfOIb7O6VeyOCaVCcCOun6Bd?=
 =?us-ascii?Q?taJuQsIjUGrmpYmcEOTMwPET1GO9nI/IoTsNGUnrHypssxmnmrXmeVdDHajV?=
 =?us-ascii?Q?t6fvAyeGqSF3H9UWq8K5SwSmoJiHImhZiNL/Ge7ICNalHyisdJLMFzvjzjnK?=
 =?us-ascii?Q?IcEWpMi8+8nW7O4ZXyOEuH2e3/9+ZDOhXQlxl8nDCcZwsEbYarlvP/AB69nU?=
 =?us-ascii?Q?bYrtpUeyXmoRhymoQlngwoctu2OHQt3iHxaWEef41cM/0hBZ92FhxU8KkK33?=
 =?us-ascii?Q?IQSFwW90oYmUdqDt9P9vch6JSEI3Qo5g5Y3rml9HFpDzUvy6FVo2pWYJLdPI?=
 =?us-ascii?Q?HjWXZtdy8E0QrUZGfZsqvDUKU2hb4SELY84u+tl3hNi8v7SDjF4fTaPWpZKb?=
 =?us-ascii?Q?1qLwX+GWz1Yfb8LemGz6DPEsh2AL3mAb5UcTBT7POmGdalFd9x7xXQVJcLt3?=
 =?us-ascii?Q?ECFAQu6k8PfE1TDzhugdxWKIYw2wltvfj64QcWdXKn89PAT8m97arP2p7wIt?=
 =?us-ascii?Q?2j73Pke74efzNNBzcifb2RcwJhXMtwr7w7EVHYz4CfGw8eKYLA3tsqpIY+YM?=
 =?us-ascii?Q?bHVp5vQ08WE1J13tLvXtzpWTbPwGCP8PIYh6zuyVyjnPe8fkb8UiDv2XOpWV?=
 =?us-ascii?Q?feXr3uyB60RsJWA7AYCmmEGVIUvaepjcyqJiTQ+vQfJjdtfFKr/9R2/rxzPl?=
 =?us-ascii?Q?oXkpjajsZrut+fdP6gd4bVH5rkZ10qklfWAQRhJNbD45JhoUV71vVor7r+zf?=
 =?us-ascii?Q?5ksow4dzOocQuW3IcZzNdVwHaV6JB2vMOf+4n31b9Goj32hUNbXaUNse7dEh?=
 =?us-ascii?Q?IitP/u+FJu2auxYT4qQzHIbEQyCf+u/MhLad/1HB7XET75c8NUfON7d57v2Z?=
 =?us-ascii?Q?wshtXX24N8BW2uszFC6oOcOjGikqEVpeHQgwVOer5WWDWuWurkmzc+28cQZ7?=
 =?us-ascii?Q?ipYgdCHj+Lm8jMtrd5zDLVFSWljKKsvio6P9K4XZDV7dyhv+nwTHQO2n4O3c?=
 =?us-ascii?Q?XIyC9LlNmk9O35GbMWg4PZ6zSlg0UoQIuaDSACsOcmo0zOqWtxR6ytfau81S?=
 =?us-ascii?Q?FlYzIkudYcskyjn55cWzNckWpm28aDNv/NxMNT4nl/ytO72xefBasVQEGrlH?=
 =?us-ascii?Q?b4tjoP+z0gPQDviYhUc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d88027d-4945-4c4c-a4f4-08dac71ace23
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 15:05:17.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmWoDFbGiJ+EXUsZoX72CPeM2UuT+pM6PwFkZ8SY+lOSmOjxIRXvBFTvVcvD7tzj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 15, 2022 at 03:13:56AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, November 15, 2022 2:44 AM
> > 
> > On Mon, Nov 14, 2022 at 07:28:47AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Tuesday, November 8, 2022 8:49 AM
> > > >
> > > > +
> > > > +/*
> > > > + * Automatically find a block of IOVA that is not being used and not
> > reserved.
> > > > + * Does not return a 0 IOVA even if it is valid.
> > >
> > > what is the problem with 0? should this be documented in uAPI?
> > 
> > 0 is commonly used as an errant value for uninitialized things. We
> > don't automatically map it into a process mm because it can cause
> > security problems if we don't trap a bogus 0/NULL pointer reference.
> > 
> > The same logic applies here too, the allocator should not return 0 to
> > reserve it as an unmapped IOVA page to catch bugs.
> 
> CPU doesn't reference IOVA. Where do such bugs exist?

SW is always buggy and SW programs the DMA address, so it could leave
a 0 behind or something during the programming.

> > I don't think it needs to be documented
> 
> this again causes a subtle difference between automatic allocation
> and fixed iova. If we really think address 0 is something related
> to bug, then why is it allowed with fixed iova?

Because fixed can do anything up to the limits of the HW. It is like
mmp, where MAP_FIXED can allocate 0s as well, but automatic allocation
will not.

> > > > +		if (!__alloc_iova_check_used(&allowed_span, length,
> > > > +					     iova_alignment, page_offset))
> > > > +			continue;
> > > > +
> > > > +		interval_tree_for_each_span(&area_span, &iopt->area_itree,
> > > > +					    allowed_span.start_used,
> > > > +					    allowed_span.last_used) {
> > > > +			if (!__alloc_iova_check_hole(&area_span, length,
> > > > +						     iova_alignment,
> > > > +						     page_offset))
> > > > +				continue;
> > > > +
> > > > +			interval_tree_for_each_span(&reserved_span,
> > > > +						    &iopt->reserved_itree,
> > > > +						    area_span.start_used,
> > > > +						    area_span.last_used) {
> > > > +				if (!__alloc_iova_check_hole(
> > > > +					    &reserved_span, length,
> > > > +					    iova_alignment, page_offset))
> > > > +					continue;
> > >
> > > this could be simplified by double span.
> > 
> > It is subtly not compatible, the double span looks for used areas.
> > This is looking for a used area in the allowed_itree, a hole in the
> > area_itree, and a hole in the reserved_itree.
> 
> the inner two loops can be replaced by double span, since both
> are skipping used areas.

The 2nd loop is looking for a used on allowed and the 3rd loop is
looking for a hole in reserved. To fix it we'd have to invert allowed
to work like reserved - which complicates the uAPI code.

> > > > +	if (iopt->disable_large_pages)
> > > > +		new_iova_alignment = PAGE_SIZE;
> > > > +	else
> > > > +		new_iova_alignment = 1;
> > >
> > > I didn't understand why we start searching alignment from a
> > > smaller value when large pages is enabled. what is the
> > > connection here?
> > 
> > 'disable_large_pages' is a tiny bit misnamed, what it really does is
> > ensure that every iommu_map call is exactly PAGE_SIZE, not more (large
> > pages) and not less (what this is protecting against).
> > 
> > So if a domain has less than PAGE_SIZE we upgrade to
> > PAGE_SIZE. Otherwise we allow using the lowest possible alignment.
> > 
> > This allows userspace to always work in PAGE_SIZE units without fear
> > of problems, eg with sub-page-size units becoming weird or something.
> 
> above are good stuff in a comment.

This is the comment:

/*
 * This is part of the VFIO compatibility support for VFIO_TYPE1_IOMMU. That
 * mode permits splitting a mapped area up, and then one of the splits is
 * unmapped. Doing this normally would cause us to violate our invariant of
 * pairing map/unmap. Thus, to support old VFIO compatibility disable support
 * for batching consecutive PFNs. All PFNs mapped into the iommu are done in
 * PAGE_SIZE units, not larger or smaller.
 */
static int batch_iommu_map_small(struct iommu_domain *domain,
				 unsigned long iova, phys_addr_t paddr,
				 size_t size, int prot)

Thanks,
Jason
