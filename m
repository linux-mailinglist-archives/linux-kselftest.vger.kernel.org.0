Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB7762F931
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 16:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiKRPWe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 10:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbiKRPWa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 10:22:30 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FBC2EF09;
        Fri, 18 Nov 2022 07:22:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHRge1wp2FEPJVKOBPFZMtRIUlO9up5j7qDRZ3npFq7sg7JMb1bzzjvmwSkzq6NFkjfr1IAx//WbqqEHqECHLrFIUTYCXwiIIANxZuk/NBFH2TX64r8XMUSws/uOCOZNpz+czl+QV7wLdkJURfNHLUU+tUmcoZ8SXVLs7pqhptInlcO6f0CNljnndiW0/P0a4c+rr2CuSvbySxEsnCgXRJvM57MllUqyxvFp8lDzRMe8AXaqWnpte570ZwwatQgnutFQcPzwUrpVeT9he5/kGteyDKNge5DmmRCG8zAUmv+GKBGnS+jzENAORz5aQ13fjnE/rOXKPG36V7PPmIHStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+baVqr/f0rKzwSRw7T6GMVAPP5qaRkE4RBZGZYCevs=;
 b=iplGlxlYPV1k7fmLF+qouxO2aIujsNqpQy1BBWdjf//ZypOKn2KuzfksVIKuOXW27nRfJWoWNA0B+WlXvtXCYp/9RsXmAMybEqpweAXJDjJuzO8msk3FYY8fGXP8+xJ6Di/yyQv/OsPN8REuumpumwEWmhizkh7eojKjDRJj3otl7NBoc0lVhTVSMDrJVV0B5MWnblQ2lBdKqV3T9f9RK1yukiX+J4uAnzdBgoLkQLUmG+1KYJARRhsMAPxoxtOIFk6UiMm0s+S6vk1IKDthU4IBN8H6p3AZiMlc0wRBpBuXuImEWyWooCEIZqLovObIx1Yieca1MO4BZ78UECRrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+baVqr/f0rKzwSRw7T6GMVAPP5qaRkE4RBZGZYCevs=;
 b=n5Ce6S84Nv8nZnVKDZ4RoAPmooq5+4vX1mM4W0S8BK2+o2qr7wV/dAR0VxUlXzaoW02ZYFlEIyFfRnvlQve8i6xaDoODyR6W61q7/c/PN12Ysj0PHMJSHVaQ1J7neph554+OEuE1QYiGlDeqhbt6PkE0xmo9AGyI/+g5ZDmPLfYMdslutzOxHQt+lluNi38deXoOMUhEpth80GAFvSEI9gevi+9ia8wIfORzPJoCxTw44iHm4qOV75+mbnCTXxDCpdss3do9EYGK1Xvwi+UUa7KRhGHODZNm8c3rEfO96uz7AYEo3z7z2Rmvd9qrgScb0VnSm2O1rbtTiY8rS3wI+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 15:22:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 15:22:27 +0000
Date:   Fri, 18 Nov 2022 11:22:25 -0400
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
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y3ejMSTWvJuELQ7K@nvidia.com>
References: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <15-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <BN9PR11MB5276B0219008568A30F5A4738C099@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B0219008568A30F5A4738C099@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:208:fc::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: cf039254-261f-44d8-c56a-08dac978b340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +l9LtzHZfwnGEmjxy4cTSPBpsuDrozCx8m53k9FP2bjUSL3N3Jch8rDyof2gEm3v8KP162fJunDY1xbaOjYO8+UNEXMyYdp5kze948h5hk6UNCj6/KnZVjY1DGZ8XNU2zr3oD51hLFM5hEtn5LqrpPLtF7cm503nLRwuAt5SrGvyvbe4dhzj16TUkPHPSiVnVGOG4PnidRZak347vYSe8ombheQgIUeGCRgOAwtWBkdcCixaEwJoJH/hdVUjKfvXAE5G/sa6cNEhsp8Nii83FnV6q7wrv8lgf9OhheYNmeQQikppT7BA203ZOfs0NIqSGzjh7nAYQH8469RKk9jipXIA5F/zTt4nXNbbhUkHt+yGEddxr09OoEsFKnk7QsHqVlX2kews5TCHJ09oPEfXndZxQ/arKl/t6qaER/c5FTXwU7apE/H4BeXKJb53ZgBdcvCWgs4Yxfm0Hm2lHQkcwJ+sEOrOnsJHUU3EDWy/CdO8frwoKJcxbi2WyIcF+fstL/E6p1/UqLj/fmUFqFGOnkvsJSEHx2GFDM6ugvOgQY0fbknc89Q2IcNNHcByNJS7hBkyC6iXFlqXQyUZwOdMrTEcCteFtEIYdQb43UWBgC2ZBsrW7X9BUfre8zn7yqM4uvkQctsFp2sHQW3Er8pRQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(38100700002)(26005)(86362001)(6506007)(7416002)(478600001)(6486002)(4326008)(316002)(8676002)(66946007)(6916009)(5660300002)(41300700001)(66476007)(54906003)(4744005)(66556008)(8936002)(2906002)(2616005)(7406005)(6512007)(186003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9UQdHGUud7qDnuWrnGJkDHAgyo3lqBJX4rRo6WMKaOLmWp/pq7/KdyrJzri3?=
 =?us-ascii?Q?wK6iXzfQNydMzNWdbmFZF+ObRBtyMdo+IZm89KeI6tg1x8RZW9OYzQ3qqo7u?=
 =?us-ascii?Q?ChnfYjOsmfzsGvNWopkLXzPGNsfSm5PKGZ90+fq2D8W6/9WIKN9CF3bCfzST?=
 =?us-ascii?Q?lgJln9P8kkc3OzgV8qCGoG7Tcn+FTssmPu6XO1maxdEkq9t/sFqk07Z2hjLG?=
 =?us-ascii?Q?+79eXiqtXTSkA8gi119VPqx/0QZA5UpvY7Vbpti0zhR/bcCGpZV0Okc91ada?=
 =?us-ascii?Q?sJBY9vzS89E9Knm+Pi8VSzFPt6yAogxSFOXm4LfBfVIoJUkMU8GCcHKMSP7/?=
 =?us-ascii?Q?2pqcfJH4FZ2lZzROmL0IVwqxGyfZR64RPRbdvhxk4Y5GfWb+6AJJhMjHCdzq?=
 =?us-ascii?Q?ZcR9mWFDGg4Ke0RIOZepJXHwUJbU5MW/egxXxt43U4QDRC0hCk5kXCC3f1dR?=
 =?us-ascii?Q?tU09kHDHgGaHl6EuRLTxhjJkWBc1rpZUMg+kzZWs7l2Cqb3RGaZOOXLaSwX1?=
 =?us-ascii?Q?668yjbtKyJC/4YaiIJA9k3FFJyLEvAZM/Pu87DSQ/Vsc0eQcpNZ/ZOXWe5ur?=
 =?us-ascii?Q?JbO72ysS90svyXfxEOhAOWY3VzGA7GE1JeTtV6y4p1roWDmmtwhfL3We0NP6?=
 =?us-ascii?Q?q2Q0dIi6fZAv1S2PNRQ/JtTANNE0TKd1PuyIQu8M7758jQI1rXW845azsuE4?=
 =?us-ascii?Q?1fFaeZ9HXiKUbg6LgIoL5MklJPJ1hJE0BL7vb7WvaruvAgipmu7IsD6eMd42?=
 =?us-ascii?Q?T+fakbGLXv3s9oilDZTYcXLcHWWSLre3UxqSmhd9QbGKdZvZWb1SvLrkk3na?=
 =?us-ascii?Q?/bftTwDuej+IInhYVn8FMWkfkvM41rTPi8CTmJ6wa1mSCARi8n254VSXtYiT?=
 =?us-ascii?Q?EDvqHdZCVqLiuHT8CGciNmCUFaSKFIrEc16zQ3XCGJl1zUWNibn0E3otKp5z?=
 =?us-ascii?Q?LaXq+OqmXpRNHsYQBmnLbkhd3cPBuC5VTqTwPkt7KqsKv3zcrzJA/oIjM5kh?=
 =?us-ascii?Q?zxoYsBdZWfyeqhR5qkIG4Dt0Ei4uVNOWI1/397eJggp3aSPhWMwnITqggFMb?=
 =?us-ascii?Q?gu3SUCmB+iq0wH6DsRK+DbcUXSW6JS/RB+jrjOHX4Wa/j/9+sPz8CUYYjHT9?=
 =?us-ascii?Q?xKI3N8jNY6Xit0oCsDh3FdqZbojvuqeIIsxESmVv2GaMYQ50u1chiQmgOdKs?=
 =?us-ascii?Q?IEtRijMV/JRVEugSbeC+UM46f5PMlld67NP7KacHR367HX29Dl1jvwNFczWR?=
 =?us-ascii?Q?kQbPKg5c6ryiD65FhcrrVAyJFqMRKhuP04juS+IiXRTZmth0XgwWnx9Avlng?=
 =?us-ascii?Q?0F+i5JWf/pDeUHgmpKs0/aitu3mEce5h4mbJq4bnisvXIA4f9H5Z2lEcWB8V?=
 =?us-ascii?Q?V8W/0BmxO4n01Wb9EK49E7JCU11H7g5ZMLms/p6TgUXERCLf78647RW66PIs?=
 =?us-ascii?Q?2nRX50DO2PdUU4vCeWg3i3hxHeuK7MG/dDmndxocM5Ic//bWopLwMWdTqNxE?=
 =?us-ascii?Q?f9bL7d/O0F8FzLRYNI2XM2hinmg41gcrz5lBN1iRObH4f1SF8fI6CwEa2NoZ?=
 =?us-ascii?Q?ij+M1TzruXHcL5SswSQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf039254-261f-44d8-c56a-08dac978b340
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 15:22:27.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azPsd+uQQIxgkarJxlHBJsChUHxXMsX546V0gSgcUB/j4bcLMs1nd39hEqcTWna0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 18, 2022 at 02:58:49AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, November 17, 2022 5:01 AM
> > index ca28a135b9675f..2fdff04000b326 100644
> > --- a/drivers/iommu/iommufd/Makefile
> > +++ b/drivers/iommu/iommufd/Makefile
> > @@ -5,6 +5,7 @@ iommufd-y := \
> >  	io_pagetable.o \
> >  	ioas.o \
> >  	main.o \
> > -	pages.o
> > +	pages.o \
> > +	vfio_compat.o
> > 
> 
> move vfio_compat out of core? it's not required if VFIO
> is not configured.

We can, but I don't know if we should. Compat ioctls are part of
/dev/iommu, and technically have nothing to do with VFIO. A native
iommufd application using VDPA could use them, if it wanted, for
instance.

Jason
