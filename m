Return-Path: <linux-kselftest+bounces-17308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5732196E14F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B50B1C21DB0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49DF1A3AAB;
	Thu,  5 Sep 2024 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZlB0Od/0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA41A0B0F;
	Thu,  5 Sep 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558065; cv=fail; b=dDhmU9vuc9CT0Z2R0633jGhkcfDTxMzsl+wIps9I/s3QuDSM0T6lT8FYEwPNO0oHvMUZM3afOjVJehCNKHqVowUK1Kx8a7YIc4CG4I6Yn0BhhS9LPXpeVIFPAo6RAsvTR6so2HF0sBBfHxfTqyTNe8lBbQJQAt3pdqq5TDCHeqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558065; c=relaxed/simple;
	bh=i/EiO8sP3e19RlIvNztfSKH0+dj7Jd4kQy5DPgZtG5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X33AJBmFfG/joT3ynA9H7Ylaf2PWWs/dD7/D2jABSUIWWNQIPEC138t4MEbO28kg8jA6tkZgbhCrwfeGeekSPvaxPubRHB+k2+uCfOaHOi0kihwcEnapYq8ZIXknfwc8fSY8r3tdZOAQnWnALILUYcP3WDL9N/m7ymNVd5bajso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZlB0Od/0; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whggDkWVEhMpknSGNI8dJqB72X85h9KmDGzDD+SvzHRTBt7iwOHSgLtfuupjLzbAlyYPo2BZsCOhVR67SWH3kbP9m6On3r29kIGVuXwEyrKTcDtCZFEgvosXdUrb85VM0JpvxDp56h+TN7aZt25PYUMqfeemMAGhXsfelAOGJhXOmtSg2YoDyOE51jWvgNwCQb0DXGcqssoP/cXfE+4WqZNRocMiOfkWDusJiDMLBErglytepd1tkI3Kmm1Ylw6HwEhekme7CTX+xP+eLMIY90FrBA8b5/B97p6+/p1igajUN4qSOWEdMx+2wRNUPRSwAVXg8Ku0H1lDIjKMSf6E5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Csfa4mvUH26Jkp2aTkMe+XRHvg25MWjJlOjLgnVULA=;
 b=oRLgtgR2S16ya3P3hWCb8aPHtQt++bJ3E9GMury3RKKMNGJBTyzoQZSXzem+nDJtcOfZ5n/abSeVoPENE6AFLL216WdMXSbFzNX/riWIUjuEFCunDnvKVZDbO+rBZ7tjfnmM/KvIL/BsFi8q74ZOie0alacZUlR6Y1ovvaIDlhzF9Sw+uRUMxnNwW450xCeoLLcahbhz6hTmi6QMJpvvixIzoMnej6eTjgXV4URvyM263S/6Ubjo+x9XlUSychPCiOwmQoGzeUti27Nk3ETVbACjECGHxggYYnhi+TM2BYt5Tr1+wjLAMULtH1fQCw8I/Deiyk8rBESWV5nIVOB9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Csfa4mvUH26Jkp2aTkMe+XRHvg25MWjJlOjLgnVULA=;
 b=ZlB0Od/080ocrizt6bIbLDR3i9ef11aaVfOroNJZEzfUFZ7cF1lFxvHjUeSFWcBb/dEW5mn0rbm+ErxIsns0G0UZnT74wegMeQ/GLoRmJWc8sTqCXCzqVI6ZYM22V6o/6TP3tRTsgnUyUHsqEQUiNUhCGoQHDs8KN7F4oKRdeMpd9LvDaIS1fLrd5lfPHL/hWTVEIpnpDv4QRLTYYYcrwmxHXZS+7Psgqx1a0KcFEL8XfV3qDb9RRVIf8wfMfUec9fEukfrYMU7fzIUrmVxPSBNI7EScU+br/CLBeuhkR2MdJsiJZd+B3EcwWItxc0bLcHHhWteh0t3sN2ZD8ew2wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 17:41:01 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 17:41:01 +0000
Date: Thu, 5 Sep 2024 14:41:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20240905174100.GV1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
 <20240905155302.GM1358970@nvidia.com>
 <ZtnmDvhVVKeE4Z/u@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtnmDvhVVKeE4Z/u@nvidia.com>
X-ClientProxiedBy: MN2PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:23a::26) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4f0364-a08b-4baf-4939-08dccdd1e86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cpxxIcjqdiZJHhyfjL1e30W3MnAumfU0JaC8w1x08WvSdsfc4oMjO2mbhInN?=
 =?us-ascii?Q?/PW2Xx85O2Tn3hhu1T0ryyBObz5hwzPWv41qNfHw9BTxMDkuAAvpWA6tXajE?=
 =?us-ascii?Q?CYiq+mZGS8Pq4bn7TCXl2WSLA0CRQDZ9hDNqwDoOzwSrDYfb+eOUA21kBFlw?=
 =?us-ascii?Q?choFN8GPT/nLl4tl6RH6rrFRcrzTj3bzlaN4Qp27ovNf2VPREu2obBmF5BJq?=
 =?us-ascii?Q?ZTk7hTJ/RalDtds0BY8fEe0BdVyjTbjROpX/tc+q+o7IbOXSLApqQiTNZUEU?=
 =?us-ascii?Q?5L6oXf297/TD3QxcrtG1ajLJl2NIy7LyhGIUrHGG0xBJgzIr3OwsEMAe7Xfy?=
 =?us-ascii?Q?As5EXcwqiiI3UUyYm/JJQfu32vHXXF1FNkt3gny+ylMoMAkRuB/I39BlN5+7?=
 =?us-ascii?Q?Q7NQqBL2bSKCErTxJLuiHJjtaARB98Yq28syyGp6BFID+LFki7P+f4zGu7J1?=
 =?us-ascii?Q?wjCiRGnOBP9KFi9WfKLZZNaevs/7MTzB6nvVta8ApdcqjhdRVQlGrtRSfxq+?=
 =?us-ascii?Q?sHpLGJ+ERF4nznB5Mh6LCu7VUYeUFUXwzdBwYeCEe3vlemRhZ5XXBr3xZCYg?=
 =?us-ascii?Q?XM27O3/rHrbPLZhRs8NCTRB+7TdSe87jdacfio/Rnzjaziw1Y2t3iADeYBCX?=
 =?us-ascii?Q?69777GM8LeSIyzuEaKfC6rWweGpNivpBBhC4HDy52+lwocUx+Rqp6l0eA2hJ?=
 =?us-ascii?Q?KD4TLk+GOvn1CIL16gEJkJLEjujhe2cTlxTSga/LH0yexDPF/rgxpZcwjHlm?=
 =?us-ascii?Q?DgrIfLt+c+SpRPGfvRk9HVGk7tmRuw+wpYIn2Yp9CFYZBnrwPeEC9GEHb4pW?=
 =?us-ascii?Q?s1mBx4ppbqrs+tzzVIZTS3K16h+exXItFBFHPsQwK2Y2Uv5MnMhIHJtyR/NW?=
 =?us-ascii?Q?9nuZDPAI5q5MguSHiGJ051+d/Bw81OKCeogc4tNdV8VBqPp2ANxOurq8PN76?=
 =?us-ascii?Q?D/PPt4MkT1RbHx/CcLIDg0yzpU+NlZFB0EJ7/rxq6ZLiKGuluvDfYa/MI9NF?=
 =?us-ascii?Q?5MT/03jpSvsOp+21NYI8F2i3ztSndVL5IdPf33q6fYWuUf+KrsDgeog607Oc?=
 =?us-ascii?Q?XYTNcgAOnNHsKKCIX5sUudRC46Xe4LCT2akRfR9uGGek2tYZj9/kG4Zp5a0H?=
 =?us-ascii?Q?+Y6a7UKElosDzCg604eRLVO1XRcXDsbllMAGFC83nuD7Yh9GG8y76PekyXFm?=
 =?us-ascii?Q?MAD/RBX+Lvzafoyo3Ow+Hnvk8cSxh+iBTyv8lgvkrJqI8T4V6fUiOh4kKKA+?=
 =?us-ascii?Q?0T2QSh6ORrXU2TWdatBEduE3XxG5FDV1/2EBkt95SCbXTOotAqekzXu9r523?=
 =?us-ascii?Q?ThRHMpsWFqQ1cKd8nF1qPR0aGK6zyWuyUcuhb3dxbZ5Lhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryx8l++3mJQAmq26uL4qVYaby4QPtufyW/i4qH2+bQ6FQzKrW58WdRVD7fs7?=
 =?us-ascii?Q?Wbo9sqKE9x/Q7okdxJUqP+d3jSZdE9A7uyHSyXGnq8o7m10jErVWtukqWhU/?=
 =?us-ascii?Q?Nl487wPt4qsZSVT55s7HoGI+ASqWEILusI7Mv5d8Ds5CBDvRbgtNZfNpod6V?=
 =?us-ascii?Q?OgBXcspLqNtFk+S+cIQU4OpF0w6VPeGsI1DJwsCLcj1HPm/TgDN9pj3Z1zL9?=
 =?us-ascii?Q?37n46o/LfePMfQ0XCFwqKxfmaMrNtqTFbBxHQrRHZ3GGQcWvVOb29UhtqjxJ?=
 =?us-ascii?Q?ka5av6yhtqJaFblR0tYux8n8FY5DukX+pE7o+lXJpCN0/MSODExW+g4tWhVn?=
 =?us-ascii?Q?z8aIE+mudzQ63Z0akMTVuy8dHumYFjBqg7+gypwNem6NOlw19MIj6F1W/ukR?=
 =?us-ascii?Q?AXQNgR2Bl40jRfXz9RjqvfLmZJZ3gpNuf2gH8PAoTs3Wb/8O0xnYOEg9wmXD?=
 =?us-ascii?Q?L4n2EJbi4tQW8M14BFaDlpXh++BNowI0WgHdN6WHRHwa9C0xhqy7z81ihQX0?=
 =?us-ascii?Q?TKKPG6ueL5d1gpCoFxSPNjYLe6y9pa92QYJFAqGKQY2eTSWnd6dCtsv79Spv?=
 =?us-ascii?Q?vimaI+SdXiKFvmL7I35MkGUrLR+4iEVyr6BblWKZjma90nP5TKgRME6zPoWZ?=
 =?us-ascii?Q?KwddQdxUcLOfmlIntd6ufl99JGpzY3L2peN5uBD28qQvp8vKym1GMA31ifLS?=
 =?us-ascii?Q?QssFpxfylJm67VT9G83FbJBQ3D13KZRZcTt71Yjf18zSfyKnP4BsjBjlYOSs?=
 =?us-ascii?Q?y4lfe7vmQSc9rM9+GW8lLw1KNC16m7uKWY4KBl3cch9pvfemifObV8msGY7E?=
 =?us-ascii?Q?jzVPo1gxjHatFQReNVoUM2pZWnkt+Vf7Hs7UYJOlLYgEzm3Y74ZOdpUcSIv3?=
 =?us-ascii?Q?Msj5YrN4LqGR+iGyA3aayNQBqwxKsYYnyjrFaNZBpGlyP0+IuDOzjH3fdZ0e?=
 =?us-ascii?Q?As7zDLluOFq+pKH51V2PCjPog84haSE7HvrRtSSy8hjuO1HrHN6mLABIJR2z?=
 =?us-ascii?Q?Wh/fqFB8fKdB2ljMcYdHpk0QzP0jdKGCMl4dWzR4UTC93HwwYzuRAjvgNKAj?=
 =?us-ascii?Q?Kx2AI82nnVOfVlbfMlOuxP/HpHbkE5ZHKm5eTK3do6Acfj6boUaQZnhrOKAD?=
 =?us-ascii?Q?WoQve5IKTBFDlGe1BXMxej1e6bW+kV9WtSFuGDw08SY6DY+zl3S1g6pvE79t?=
 =?us-ascii?Q?O13gVii+ziuRZFne/ut2HZUSMH7rz4W1RSoSaeWEqS6dJSrdQ4+iZYRmZILt?=
 =?us-ascii?Q?pjoJTZsYGKyMDjcVy6K2Dr4jzQGkwdA9AzKOjFbB+EWr/X7jVpU7Tbr3Xkgw?=
 =?us-ascii?Q?0iCm2p/bgNhWuryg28L6dovY+RDjVtD/b1q+l++uWdEwNGxfDWOcyfmllWd6?=
 =?us-ascii?Q?kDslH9B5/l5251OC6SJAmjmpsk01pSo9XmZHNsi5O5TxCMmubC0r9owJFDam?=
 =?us-ascii?Q?ZG64ofDvJsc8WUfZUCCAZKD+vst0BE9HJQaGP/jsnF7mIfbXgtTHdswJXl+H?=
 =?us-ascii?Q?Fb7aFNE6ZWoBxG1svp+Yn62BgTjgd9CbUyz3XjBikzf0wBfBPSkn3YG+j11W?=
 =?us-ascii?Q?OcAJVCZx5O1J3+b0QILf2vnJOvywx6Las+1TbaUp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4f0364-a08b-4baf-4939-08dccdd1e86b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 17:41:01.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAbhuvXc+cinNdnP62L1pT6es94uCj/VrKyBW16pB3arfEzmUASfnooSIBA/CWkd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

On Thu, Sep 05, 2024 at 10:10:38AM -0700, Nicolin Chen wrote:
> On Thu, Sep 05, 2024 at 12:53:02PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 27, 2024 at 09:59:39AM -0700, Nicolin Chen wrote:
> > > +/**
> > > + * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
> > > + * @size: sizeof(struct iommu_viommu_alloc)
> > > + * @flags: Must be 0
> > > + * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
> > > + * @dev_id: The device to allocate this virtual IOMMU for
> > 
> > @dev_id: The device's physical IOMMU will be used to back t he vIOMMU
> > 
> > > + * @hwpt_id: ID of a nesting parent HWPT to associate to
> > 
> > A nesting parent HWPT that will provide translation for an vIOMMU DMA
> >
> > > + * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> > > + *
> > > + * Allocate a virtual IOMMU object that holds a (shared) nesting parent HWPT
> > 
> > Allocate a virtual IOMMU object that represents the underlying
> > physical IOMMU's virtualization support. The vIOMMU object is a
> > security isolated slice of the physical IOMMU HW that is unique to a
> > specific VM. Operations global to the IOMMU are connected to the
> > vIOMMU, such as:
> >   - Security namespace for guest owned ID, eg guest controlled cache tags
> >   - Virtualization of various platforms IDs like RIDs and others
> >   - direct assigned invalidation queues
> >   - direct assigned interrupts
> >   - non-affiliated event reporting
> >   - Delivery of paravirtualized invalidation
> 
> Ack.

Also write something about the HWPT..

> Looks like you prefer using "vIOMMU" v.s. "VIOMMU"? I would go
> through all the patches (QEMU including) to keep that aligned.

Yeah, VIOMMU just for all-caps constants

Jason

