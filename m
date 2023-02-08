Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0B68EF3C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 13:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjBHMmu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 07:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBHMmt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 07:42:49 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458182729;
        Wed,  8 Feb 2023 04:42:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faSO6+NfOoL8HS/uT0qK2VcBiMBr1lprxLa3+9J/TXoc3HyRpOFL5VkFL4rIR09QuRDuf3w8VODMfY5+beVqU04EVwv3UaNNR3McmH2bQJccNrv1ea92vHx/4cqDDYVSrLcMUXQVf8mAAeta3aWSfT5a6whty1lhbASuJzR997jx9lgg3w/Suip7WGZoe/Y0n123SQUyU/Dlo42giqZmLbCe08TuLiW1n5zmuyF8DEmDamgF2y5fDRF0btRz6J39AozSVJwP37CxBSQpR2RZ4huuwXjz4nsct2cQb7zQ1NVSYAI9XUga4P9dFaid9AZLqLc99Mnlu8iuaLcktLBJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l35ZF5uOWYL30u5FG0baWo3/O8eM/ME9vtsjcl+CJWg=;
 b=GIUzLcq0a0ZejNtLItZgBWfPElQNGyCkUb0kO7BebiKsQt34g64m7tNwhg2304RlW0OHUvG9dTfILNtyxq9bM0h2hB68wZKDoLze2vvVL6zgTP/qWzbBoN+R0nolyq+R9wh8SvBn6J9CG7R0eCmzD12YF5fjPX+9+vcOBlZVyiCxwiwxLyi6Y73Li7M3Nqw7p7C9G67KPEZ6RE5Z/xcSIcjqRzGMaap9bz0tQoAO2LJl9WtZ8JeeLLh1b6oDZaLQJRgmJzPu2j4U9BHwLd9j3xRBcBhcROWYQ17ypm1hBbLkAMFG4ND9nj1y0hJlzCAf+7HJvB/DVebtI7tPJUYY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l35ZF5uOWYL30u5FG0baWo3/O8eM/ME9vtsjcl+CJWg=;
 b=Jt6XRx83TWiym71w4MEVANIKMNxP1EIWnuQncnSUjOQWXBtKbwtEyx/WppP+86MxhA0xACpfstu/smBaCohGPToAaqbjXCrcZuLZ235utAUQb/SE73QQRFjEJ1iFTMJCxjx40F5BviffwcBRMTETgZgyHQgtfnNZO03+FD41Ema8byFYM2biL1iZM8C5YdBaYc9fAK0Q2hRWHcZFcpDtqFObSbXNyLgojO1swrDx1EPGvRFufXCzpwKAi/pJLyEAYqDXz+lsuPgjlNsVo9YiV2TgGMsLI4/i9kDlXpkmxZvQk//DpEr/Wt57uKS9ydoQmbn13niXwbdnQt6WfEXScA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 12:42:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Wed, 8 Feb 2023
 12:42:45 +0000
Date:   Wed, 8 Feb 2023 08:42:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y+OYxM3WWr7ZxzF/@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90iOAmnBtqQtmiA@ziepe.ca>
 <BN9PR11MB527689447DD190FECE4FDA158CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+D/vWwRLD27slQz@nvidia.com>
 <BN9PR11MB52769E24B07CA7296D8BEAF28CDB9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+JCjazMAMzNrc+e@nvidia.com>
 <BN9PR11MB5276CD7FAA1BF85CD8F94C908CD89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276CD7FAA1BF85CD8F94C908CD89@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:32b::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 769df7d2-d496-4f73-8dc6-08db09d1fa30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dF2D+IPW/kbqMFlPPB1HrYFLSnvVqFi31a0p/6LOwpwg7uik6JSEW0LIhgIq3IhzneNTcS2TqxFv4fzENdRbHsGDzT3grUrWXkJFvAmd9VypRYRPSsmdmfImHN6HawpgU7LZ1DxpDpyzO5Eb/d8SERlxmxPamDAtNXFGzWV2wkUiEybJ3+GkhLuImNy+DAtxYkqV36p3N2lmEmc5BTbamGFv5uTI97Arsw6i4wMtay1tbNv0ke3jE4MeUuQU66Ut8TISFtVnq0c9rzjU1y0xvYfSIR/g1gehrOFMofn3a2mBsHYAZ3jNhQd5k1a6pEH1CVA1BMdIe29gXeMbMIXtKq2+AySM3lf1pDxKlgpII+vYTKXQB/vIUc8UFlJKBrK8KTsfKWQoNWMI86NClBfdZx2FrVIT/uaMRlyRu2Mb5zGeNkvyAmfPiDz50zPEaRI14SHP0qZNhq+It2aRf0LwFURBjIfinJr3w59sBWVnU0AzlU81utOWqCG+3RT+DlWup0KJu5+NergJEocxUvejJoaBgQ6XIs1aUm+p+at++/JkcVVsarGRu/FwK/JraHRsObrIu5vCoXjX3EwXe+LIC4TTAXmzgfNqX/h3PEoQ5xFfcjRvaYvbelMHxWzhgqFUP9OQhgWs+miFGQlYTvdaog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199018)(66476007)(66556008)(6486002)(6916009)(66946007)(41300700001)(316002)(478600001)(54906003)(83380400001)(38100700002)(8676002)(186003)(2906002)(86362001)(2616005)(6512007)(26005)(8936002)(5660300002)(6506007)(7416002)(36756003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ywTzRePbL9z7HGRy/JN//kewgzDManmLtoPiqLYI1a8aiW2nECe38ieS3QrX?=
 =?us-ascii?Q?PbADziIF52uIa1248u/tYOIAjJKv/xmKvhqp0TdiAZuwGNCmNZuQUOTTN+bq?=
 =?us-ascii?Q?c0JdSqbWTn7bBKLbuu/7Abh9/ZQENiaERXF1zJNvpzHodmhwIOOrfhvlrSlW?=
 =?us-ascii?Q?Q7Nl6qK/GV5fv2Yd0LxnwbgCyjXSULm4oU2MetshPseqHYSavs2JVuMic3tJ?=
 =?us-ascii?Q?7/NecyCviASHxFRcRwYAaxp/guFWeHT+Akb6asygIBiFS/8k/RW5azSL0lFB?=
 =?us-ascii?Q?TeTJUBkXvLGVBMJzyqtMKnZf7t5/PixUCweKxm4iHarWHY9yAj5mhqfYs3Dm?=
 =?us-ascii?Q?yPzkDnEZ0uzJoEPj15KkMfGwkxCEHs++wkqrXFWGywkDRqkGNjfO5VpyTyvv?=
 =?us-ascii?Q?4s2FZ/Mv+NQ0xsWsZsmPJjf7pv2CU5GmwpN1caH40GuTiyYM4BYEwLmDAsq1?=
 =?us-ascii?Q?UqGg5r3N6M2YCn8VaJPyvbRD64fLKfmg/Bxj7bBbSD9fTI4UtWeu6MM6wcIm?=
 =?us-ascii?Q?o6xMrAGejV8PCW4hAJcnjco2TwFJywx0XCmRlCVInVFOxL+wJKSH3wS/T5Il?=
 =?us-ascii?Q?uGlaToPt4TyRGF2Eoc+RWX7rjesUUQRJzsvmSDph4TGqxm26Y+s2deIoAXac?=
 =?us-ascii?Q?tYHoBsxGK8UGgcYAXMqqY90oD+j05qJHiV9rVs7TuNAvX31dQzothxr0yUwz?=
 =?us-ascii?Q?0A+twuXlK4TGps75c7RM8ttG2e6EWxlO3USTuXp+qbHueGJ2tdmBb5pL3FQD?=
 =?us-ascii?Q?zkhAfu6McQv1j1rishzDLmFWqbIWoqrWY+kb+KZdPhUGaHWbOWqxDv1JbaI2?=
 =?us-ascii?Q?J1H9Av0u17BZnNxf0DSRiyO/fVC6AgK8ZmEofkRjsjuW7DV6K0rwVoLEKwYd?=
 =?us-ascii?Q?Eq9WssWLD3tm2dYErrrzOBNSTDdmY8UXTwCOUpC/FSh4vr8jBawlfLYig4vT?=
 =?us-ascii?Q?RXg0eUMEvosi7l8uusnjQFtqSwtY0Z5GGW0MTPdELLLZ9od2wqcQKPc4Su2x?=
 =?us-ascii?Q?3g+uum5Jvi/J3FwpzSazOLcrNxQLrUxyQl5SATHTkzrAVzVxNuwIlu6l2yN2?=
 =?us-ascii?Q?2gZq+4NHT1ZoOdxrkPTjjpr2GENPkZ1FSzJv41hQlJOeM7m4hROW3m/IluAh?=
 =?us-ascii?Q?fDe42i1TYB1DMbTM3+qIem77bGG8sCG6A94Fqbyg7qZSMXgMNNiAKzLjboso?=
 =?us-ascii?Q?9lMxkROVSfoIEMR6st8QZ9Rkq4HQRFEfk34/S/3J4PMEUDyJIjR8TNpTjuD2?=
 =?us-ascii?Q?GCi7NWOVSJ1qEJdQ1oumcXs2VQnYGPZBOliejS2U+5agsmqqJcfrcvxuItcH?=
 =?us-ascii?Q?wiF2TvRm+vEv+S/jszvgyvQmmTwfdYxYqvrpHbu06PJM5y9Asb0jL77rMr1z?=
 =?us-ascii?Q?wPqU5apHsElQ7Em+HvK8Nywh8JiQ0CUgFFxvrWYgIOGx/uefVLBwPNJ8+GH5?=
 =?us-ascii?Q?eaLDMlxjLnJJJbDMgGhSn6WOaDzXgEklMTEpfqFoNAe+r13F4gOCi5xmJPsJ?=
 =?us-ascii?Q?JFSvpuD0AOL9wMh2CBLI3gHuxGno20iptmG2x7wEBIz9JjA+Tg8IJb/KVu46?=
 =?us-ascii?Q?kS/v/0mTTCZcg6x6Vmz4FNTNGgdqc3KdsCywP03y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769df7d2-d496-4f73-8dc6-08db09d1fa30
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 12:42:45.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcPxD7vnefTWAsuM226+TYutAfg+LZ4sg75g+emGrWc/ZTU+GKrwwyOwxJRA533d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 08, 2023 at 04:25:58AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, February 7, 2023 8:23 PM
> > 
> > On Tue, Feb 07, 2023 at 12:32:50AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Monday, February 6, 2023 9:25 PM
> > > >
> > > > On Mon, Feb 06, 2023 at 06:57:35AM +0000, Tian, Kevin wrote:
> > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > Sent: Friday, February 3, 2023 11:03 PM
> > > > > >
> > > > > > On Fri, Feb 03, 2023 at 08:26:44AM +0000, Tian, Kevin wrote:
> > > > > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > > > > Sent: Thursday, February 2, 2023 3:05 PM
> > > > > > > >
> > > > > > > > All drivers are already required to support changing between
> > active
> > > > > > > > UNMANAGED domains when using their attach_dev ops.
> > > > > > >
> > > > > > > All drivers which don't have *broken* UNMANAGED domain?
> > > > > >
> > > > > > No, all drivers.. It has always been used by VFIO.
> > > > >
> > > > > existing iommu_attach_group() doesn't support changing between
> > > > > two UNMANAGED domains. only from default->unmanaged or
> > > > > blocking->unmanaged.
> > > >
> > > > Yes, but before we added the blocking domains VFIO was changing
> > > > between unmanaged domains. Blocking domains are so new that no
> > driver
> > > > could have suddenly started to depend on this.
> > >
> > > In legacy VFIO unmanaged domain was 1:1 associated with vfio
> > > container. I didn't say how a group can switch between two
> > > containers w/o going through transition to/from the default
> > > domain, i.e. detach from 1st container and then attach to the 2nd.
> > 
> > Yes, in the past we went through the default domain which is basically
> > another unmanaged domain type. So unmanaged -> unmanaged is OK.
> > 
> 
> it's right in concept but confusing in current context whether DMA
> domain still has its own type. That's why I replied earlier the statement
> makes more sense after your patch which cleans up the domain type
> is merged.

We are just reasoning about why the existing drivers are safe with
this - and my draft patch to remove DMA simply demonstrates that DMA
== UNMANAGED, and the above reasoning about VFIO in the past
demonstrates that this has historically be expected of drivers.

So I'm not so worried about patch order as long as things do work

Jason
