Return-Path: <linux-kselftest+bounces-2661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE25D825611
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 15:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5343D1F21B17
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2AC2D7B0;
	Fri,  5 Jan 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZgXUtIj4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8293588C;
	Fri,  5 Jan 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk1MJgHh1M3mGwaZpvR+klFRZOB0/jz33BeJlOHT0DXhAbn/y7B2D0p9f0C5b9vRfyZgOdjypOv43NzJ+OUoWIU6MyXlUyqsvhG30DfXU444WoDKWJwhySZ/1b5dsa4IVX1jmbPtg97Z0Dk4LabeuVxAYazpzfLwgOsTH7ZbS1ZAinnPlFGhoVlXRigKoo1tGU0te6R17jIZBzTy+KOhFSuetYrzxFNzdQSWkh4Uf2iPerS4ttFlm6QrXlXqxnUyYEPPsqKW83Ib1UtRNIQER9a7vcfS8JWWrPQR1wrn3XwWZZQrG9wmC+jZNJzPxjif6wx5b6ec+kaZo4nNB7yjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP48OH3JemuBmAJBBTUNZEOewc5ZIQvd8mXEam+hOgg=;
 b=oIsGbfirELOqwo0lzlPnmfiXMkME++z5dZgQRmM8neN2qBAo6ucLwszBdmXH9fvteixIkUimHPGxTjqfBTqROCP8QORroW8Wo0W15A8KbCRykkfnn7Fqa8SqCoSQmwu3vAKHIUdvTIcBuC9fqUFCg0Uh+JowYXxfhitGb0HSdNd24MJv69uOy3hUhaa/Nu+buYEJkjR8eg0GI9Z02lUI1eCv93h4RRRdtnO3FCXYAq2N3vU26Xt3GKM3VC3Hd6SJudvjZanlx65G97x+yqVHDDwIGqfVFiI25zP1XjVGU3Ywt/FfsWVuuYeDvBm8T10obIezGxncJqEycq7KYMO/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP48OH3JemuBmAJBBTUNZEOewc5ZIQvd8mXEam+hOgg=;
 b=ZgXUtIj4Qcs8PamFj6jIAUP0OhhTecQoVJKVFLL6gVdxqqHAQlWlmZ+fcHDcjeSuqeKxZV6ZJHZlQeVnARo6HoLGiGH23JNX2qB+V37k6x31Z2pEcBh3vhZiWnBsX+4W3wGGx/MxdpgkYdlNR8rxQtjKaRRWq1U7X1M+O9lvVAegN+p8pgve607IxupOVmtwtXf7PuO2t1WFECHKO6pwSYzHCgYSMnLoKOo7tvGnKXekGGJwFNHgKtnyY/AU4jvTBEpAFTcSACBLak9roaPzBmTmIjNtA18obeHp/5bzx2HEXaa0Ef85zX7wYQMzpHpDtDYmfhrbyPSpuyIHYfNUwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 14:45:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:45:17 +0000
Date: Fri, 5 Jan 2024 10:45:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
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
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <20240105144516.GC50406@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <20240104143658.GX50406@nvidia.com>
 <BN9PR11MB52769EEDAE2783426144E2588C662@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769EEDAE2783426144E2588C662@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:2d::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4e4b74-5f3b-4969-83c7-08dc0dfceed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xotm2n9Lx2AcF9rGsJw96jnPqhLIoYi/AZiSmPvwoqVyNAN8jvCrgjCNK7mnESwuU0v1pvzKCe1vI+Tqo7xPwOYxYLpp4oyIdDetGGpKRqhzzUFVuu4dui8xs6/Fgv8KrJK6Nef8Y5WSZxK1513htJCr3wCQYzY9dIXBxwejtsnKAhzkff/+894Kmbz2umhKk1H2fyp2Oe40D3PRkHLEhBcH4wQbDj4q9xYIZdtoxjXQJRzFWWdGb9tl4uKAJgCrEplvW1GExcVnAfLDMOohpUrAVDNI41YFhrNwgcX5Ukeaqmj6yfgMaWy45phYZCdbv6c2NHxwp7NDvQBnUOK+hcxUZAu/g1ttToOQqfKWFxYaeRmPb6bSRAQsmOEUJ/bm3gDxklfF08JIy0cgpdKtPZULqCyY9D1lbHoZ6extJaZboG0GsU4bOBYlmBWICsOinem+yTh2R/5x7x0EzKP7vrHbOh3hWZ4646hVDIgLhWimQnLdm0BF4I4HiambFwbQ7Z9Gobd9Zp2wdoEDTwAGlpK+DJs6xy/CIT8Q11L85fL15VzNA6YtGAZJ8RUD+wnJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(6916009)(66476007)(66556008)(86362001)(66946007)(4326008)(6512007)(6506007)(2616005)(1076003)(26005)(5660300002)(2906002)(7416002)(36756003)(478600001)(33656002)(6486002)(83380400001)(316002)(54906003)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?91VQZZ5LrMUSq80YEKI56YK6LLSB6o4ouDplgG6Xf69IS1hvSXK/GvaK11Ge?=
 =?us-ascii?Q?4A3Y02zN6FOHAd+N4yJgFFbfnc2JyG6v6hxBBd67e6H68/THWGiADy5+aAL3?=
 =?us-ascii?Q?FoS3eexKScxOzwuYJKOdDSRvunIUlvJNVdRyWb2MZIZoyEv+dYS/VJaeyHHL?=
 =?us-ascii?Q?ch8lIqdk8EJwXA/TaSgEPajWgYluSgws6pQCXaOsiFQ5WP1ZKtrOIZh4FAub?=
 =?us-ascii?Q?YHvmvFCZ/iYfnjCn5LMXUWas5NtDiQXsj8KhTnPHTRJ9mfU06ZpFFfDml53Q?=
 =?us-ascii?Q?46qku8rsjF7+TP6RTJdbksl29CJLtxBPv7OQhCrDO/bfBVYak7gKpKoqXq1j?=
 =?us-ascii?Q?YGeEIZDbRwRrS9yUema4keccrGdwaEgQA00i2NaNcwP+d6YOx8ItX8jcp6Se?=
 =?us-ascii?Q?/22g5P2rFKbXa8rbdb97HyQmnlbjjnUDU4ivhbLb/pZLdHdaGwUC/v3aau+A?=
 =?us-ascii?Q?TZ5aqDIGezI/IHYXc16RWER+4E/U3dglB/DgY+ciRq2WwZpJOosTrN/2/PHE?=
 =?us-ascii?Q?wP++iHWWkAxezCdKQAXSFFmW+nRBN6r9r25tfUGb3jnDFAwMQHHPYt1HCD1g?=
 =?us-ascii?Q?RhO7cSeUswJNQRg3NN8jkkOPm5exXpNwoOfhIn/qtsdvtUOFB0MtLxNPDbTV?=
 =?us-ascii?Q?uU34ZWc0MDkx+vZ9Ym66czVYQoWLO1OU03mZVHHitmHUwfGPexzOiZV3Qvdo?=
 =?us-ascii?Q?5EkIJF8Boftxg99Bklvl8qlxnVN+s5NgrrHlUmxabzd7CzkqlksIUj6eVi9n?=
 =?us-ascii?Q?AmIPYiFOBw9Um9DrbonaKFs3kiDCZumrD7tPEOKtD+JwvZTNocncoJOa6Iwu?=
 =?us-ascii?Q?lOo+9FRJVwaZnS9Wo2DaB/6v+Wzs1oS6ghjd/qP0Xb2PF4E7e/a9BYot4L1L?=
 =?us-ascii?Q?po2EwfqHdOrlu44fv5QIQwuqk2F/P4mIbn22rhq+bLat9au4kS/j6s1oUsGh?=
 =?us-ascii?Q?SAc1pdtXOhRNvSyZ6KjBXWVFSZyPH0EI3XE3dqlGldiIe/3EPcZPsXty/wub?=
 =?us-ascii?Q?pY++BAFzDy7ES7ISq4gJd+6DXm80M5T1njv/wjhyImzpOlAjUK0qlsUUkr+Y?=
 =?us-ascii?Q?Piiqk+rNIJm6G6dmuadLWhinKLurtdrIDZ1x1EXBSYoQwjlTF/1ZDY2d8btP?=
 =?us-ascii?Q?4Fu8ppgcO0L2h3TT2tb9+01FuzRmSnEpnNaZ2sxcTbR7770eyWFdE0YIzdMq?=
 =?us-ascii?Q?561Y8nw9MILEpt2UySfi7Mgu+k3tXrekCpAjPvnPR7kBr8S1RHpaYK19ZAPA?=
 =?us-ascii?Q?6287Vb2MNM90KenVzQGFUm2IjGqA0KnL5PFZSg/eK7g2IlZmzAfQMvG5S1eS?=
 =?us-ascii?Q?A1vS6UEL8jjTlZRa/djQAlZOoWiXxv0nrO5pM6zwZZY9CrO/nNpbWHzYUdnH?=
 =?us-ascii?Q?oi+RaSLIMZ626NDX5gEnmnKpJtl7pIFpNHPB1oKzkCDHdJ2NUfde+ap8bewR?=
 =?us-ascii?Q?BaOrdtI0AQfBw8GpXkASnnEkPhYXvLsKthP6EYffbeUbCgErY2KTj0waXUD8?=
 =?us-ascii?Q?UcifEAgQzUJt/FLTjFLQZwDo183iPzS8IDpniPQ++sqUr6X07ugc2r/rL588?=
 =?us-ascii?Q?LmcxDDOsuMoXY0qJxkI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4e4b74-5f3b-4969-83c7-08dc0dfceed0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:45:17.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1U9vpxigpf9kqmL1GbNHyFXMNfZKeUBGeHIMgdhnIRUgyYfkOSVLdV+e3aYn0lm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111

On Fri, Jan 05, 2024 at 02:52:50AM +0000, Tian, Kevin wrote:
> > but in reality the relation could be identified in an easy way due to a SIOV
> > restriction which we discussed before - shared PASID space of PF disallows
> > assigning sibling vdev's to a same VM (otherwise no way to identify which
> > sibling vdev triggering an iopf when a pasid is used on both vdev's). That
> > restriction implies that within an iommufd context every iommufd_device
> > object should contain a unique struct device pointer. So PASID can be
> > instead ignored in the lookup then just always do iommufd_get_dev_id()
> > using struct device.
> 
> A bit more background.
> 
> Previously we thought this restriction only applies to SIOV+vSVA, as
> a guest process may bind to both sibling vdev's, leading to the same
> pasid situation.
> 
> In concept w/o vSVA it's still possible to assign sibling vdev's to
> a same VM as each vdev is allocated with a unique pasid to mark vRID
> so can be differentiated from each other in the fault/error path.

I thought the SIOV plan was that each "vdev" ie vpci function would
get a slice of the pRID's PASID space statically selected at creation?

So SVA/etc doesn't matter, you reliably get a disjoint set of pRID &
pPASID into each VM.

From that view you can't identify the iommufd dev_id without knowing
both the pRID and pPASID which will disambiguate the different SIOV
iommufd dev_id instances sharing a rid.

> But when looking at this err code issue with Yi closely, we found
> there is another gap in the VT-d spec. Upon devtlb invalidation
> timeout the hw doesn't report pasid in the error info register. this
> makes it impossible to identify the source vdev if a hwpt invalidation
> request involves sibling vdev's from a same PF.

Don't you know which command timed out?
 
> with that I'm inclined to always imposing this restriction for SIOV. 
> One may argue that SIOV w/o vSVA w/o devtlb is conceptually immune
> but I'm with you that given SIOVr1 is one-off I prefer to limiting its
> usability other than complexing the kernel.

By this you mean give up on SIOV entirely and always assign the full
pRID to an entire VM? I'm confused what restriction you mean if you
can't rely on the PASID?

Jason

