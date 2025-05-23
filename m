Return-Path: <linux-kselftest+bounces-33686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D57ECAC2B7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4471BA78C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 21:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6F820E6E3;
	Fri, 23 May 2025 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JjOEil85"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC6720E313;
	Fri, 23 May 2025 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036775; cv=fail; b=S4rQ7h/d/JIMYRXMhplyIUFMh+6CCnB9fdkjmHctrZriIkpeiSaypOkEdDPg2cCwogGTXFIgPv4DLUUC5IW6XrGU+4elAulQXmAsKZc1DxI14vKOLkzEMUF7yZq2mIcLVYws4czQP7ncyPumW2J2qnooWE8j3G4tA4gViOiH89c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036775; c=relaxed/simple;
	bh=AjPuI0gup1fNCxmuJaMqHBy2VZXAVdMMcNwXdCU908g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXRBVuoMDAg/FXksTSJ/kYyVje6y0kys+KM6xqyWcDHjKtUwJ6U1nUo9tfPnBskNJw69O3FF8yZmsaz3VNwTbqaQ/7AKCQeWD/64ppgAw40hu+Kd70teMO0iMBq3KbdLwLeIx+9X/kMiGD8QKFnJgRSKqpiplB6Mnf+kVGSlc1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JjOEil85; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9noV+DjAwq5rfL7ukcYGcoQMtmA7a5FDcIccu9xlt6LVeY8Ch+61i2EZOq+uIoNp2qEjYxklaco1v86DGb2CuwUCtHTdh79iotnfxNoiJHWz/v57hrFC8ipnM3nN43LWiN9Wo+s0MHPgQyzYNTvkS1cSzMhYA02FpH86/7S6lqMDVLJ4QKrvwBqfAskf5l4UJ7ONyP9LgyWM9sTKK6ts0ja6g4/ue/Z9FBhAd65+H7CEh+wkxfjZdFvlPjO56q2S17Bte1j+BVQ5MXiyeaZG4obSwFV9Eq3wp4qpRvu+q0+WXgk/ITloAhCORqlY9Rb2IBX6AqaUPWgimitr4ltDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teiDQPJLspsSCPoDqpuhkmQED3A9zkVPcTKiFcDSU14=;
 b=qUH/UdPy3mqKvm096a7tWEZex6z/T6D34gP3TlKojDN5aqI8HUKp2kyjPuLN3scyYuyFPcnvO4+wFj2JzfgiM2bG0MsRaYKNBXFF4mbez2EbCdwyLrcZYEPMbmw5zQKfqOKNvwqlOJmNrnhCclSejl1jNHfYluF+tuBjz/LRo+fiEKRnFwE4x+Tp4zRkFzqy+T/yV0DW6EGOXT8wzX0GVlUrt2qK+3LtzmI1XniiT2/Q/JwrhncxAy4IRFXkCv1pQOZtGpAzi5XHfajTvd5XEu71xW6WVuy5A+ExXikhXC6Er/XbVfj3rqwwr/QDI4HzH0znf/8VWcBmoTmxzRA6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teiDQPJLspsSCPoDqpuhkmQED3A9zkVPcTKiFcDSU14=;
 b=JjOEil85J8Uij1Fc307wWih5LFH4H3Mw5N0uiRlfUr0pMMl5Wo1V7S8Kp+tSEi4vK+A2lx/G87ZmqsWpNDgbKfWIyfYYDw54RgalFSJwb3vWj9xcFeNNmVlrzCSPVY9GybJpYw9Rj8qwl+43gd0OO6+2FqybYyljzlTKDg/+KLxTrBWNqbTT6uPhNCEyFXe8NCQ2aJz+v6Ni4miIySkhe8oatj1enKiSTpVy802sZFo3xQhxz+R43/FTWXrzUu5IuIkFQNLCrGUjHoEPJBYjlL/p8qPjupC1fJW1K/lDJJlVFMbRcRdOLPSaB3POIzyvyaY6K3sGdyyZzxMynH/vsg==
Received: from SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 21:46:09 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e7) by SJ0PR03CA0279.outlook.office365.com
 (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Fri,
 23 May 2025 21:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 21:46:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 May
 2025 14:46:01 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 23 May
 2025 14:46:00 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 23 May 2025 14:45:59 -0700
Date: Fri, 23 May 2025 14:45:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 13/29] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Message-ID: <aDDslV6ZJpxJNuaG@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <580a36f629402506d232052ddd20ef21ec91d5bc.1747537752.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C599F23964E423CCA2738C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C599F23964E423CCA2738C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: d548050d-5c44-40a5-9851-08dd9a433add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U/oNoknTln29t3ukD0/iWJStKMX1c018hR6asxRPpsEo0QBhPzdMxOz9ySxY?=
 =?us-ascii?Q?mcFSRtZXypS/rXNrq5vpGS5Q+UI8Bdh4dMUmOwBlfTLgiJInCobrLaeQDJVH?=
 =?us-ascii?Q?QTzhKPRrZ6AD+D4Vf6k63NtIco6kaki9MNLC9k+nF+EGl0oVORh4ZjpADIM4?=
 =?us-ascii?Q?ctTRwaGfDp4E7tf7FLMMcLfU9lTb9xj2PVONydldtAS4QtD8rFqdh9twPTYc?=
 =?us-ascii?Q?51HB2yCJKCgulfUtdxnC3+RPjoVeyYAFds8csS+T23qYb1Gytvo1j1roiS1S?=
 =?us-ascii?Q?tmUIPjc01P3xFDveY3CK7gRGF28Sa2en+MR2Eju1HEqbYalPvGtk1iwDfxwC?=
 =?us-ascii?Q?28FcmeGyBzScAGZHZmCyZb3dv67vrUywIMoulwhyEP3Rb7BH20wcRdxsFSPQ?=
 =?us-ascii?Q?19RlJvnRQ+6WYgYOQk8O5zaVaCqmizYJZXemgsM1jpbQo/EHelpjIwcUKlJD?=
 =?us-ascii?Q?G+vtIaeIC0D+3k1c7UDVLjV8emK0+yftKfLI2aX0V0+HybqZE8AM6dKvDEh3?=
 =?us-ascii?Q?2lnu2OgsE/D0EfKf/61+W7EkbzbS87UjyBJDIvyoUINJZG4f8umI6ESqdMGA?=
 =?us-ascii?Q?YPlpd7McVfABFq0ZG9UAmxYDG0SzR8fHr63EZTW3UDWAQwXayiYU4dpSrbXw?=
 =?us-ascii?Q?xHvtRucr1c0F2BuTObsLnKCrf4RUsDX7yiMzVlFo8uEQTsNh3RYm4g2vGkDA?=
 =?us-ascii?Q?+h+ZHsSQG3as0j6o4CrCAwmZZ6eNEdj9kUNgg0tnTTN8FLa8Ms1SkU3qFSqA?=
 =?us-ascii?Q?Q0mc0gqxEuYno9wodQyGTZ3cGOs4/wE8srkgxq59zMNfgOsZ+SBpoaEmBuSO?=
 =?us-ascii?Q?vINJpshNIMlqg7rrEYsqS9FMroGv4aj4fxBi/dyPOjUirVqsWiTpS75Mpb2S?=
 =?us-ascii?Q?SGY0mMaWabq3INV9wiWkwFgghiKiyJ5+jtrW7XzbrC4b/X3TxYJvKyCSpevI?=
 =?us-ascii?Q?gptxgz2GUsislgvR8kniWSy+SUQDbCYDXZl30h3aOr4GwSc3P9qzv/ag/xsh?=
 =?us-ascii?Q?SbQcVQAirpDr5KWtS5jOZLKlPG+2KFA7nagfmJPERW9Z9YLXNhjgqlN7NFFp?=
 =?us-ascii?Q?0/CtEGwbfVyJjMivh/hlczRNEZUfd/AFkEYRa1BsatK6HjmMHmjZPRlcBNxV?=
 =?us-ascii?Q?/v/sCtSH1cGYjjv/Mgqkpc6Yap0Fjtr/pPwbAE0jMFnFSflxfjD6/68bOMiR?=
 =?us-ascii?Q?SvsCEEX0VG67zeqyAPTxtFVpHVY+vYG6g5Bypm34TZv4YFRrRVxVb+Dc1Qca?=
 =?us-ascii?Q?n7XUrsb+saVBJrmVwLvxCABUDrvGXMLRGywoy1tuy3XN0Fq54prq6DyezsSr?=
 =?us-ascii?Q?Vxx3js8l2urf4d/Lk1fBRkfi7nWjvfRHTpfUf/D0p0HCKj/Z0TkFbywjAV3y?=
 =?us-ascii?Q?e2Lqus9VMdAdnELxLUOQCXt0GPN17azK6GvUFMtM1HD86LHr48tZ1kB2I4jW?=
 =?us-ascii?Q?p3dLdtPtB4S8VIdaeWA8CTYeKLbIgjXtmnkNF6RBqtMualSj84vwMsjuKgnx?=
 =?us-ascii?Q?7q6IpjfUQpFX8Swd/EeA5euOz5osWpJfPsLv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 21:46:09.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d548050d-5c44-40a5-9851-08dd9a433add
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

On Fri, May 23, 2025 at 07:55:18AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Sunday, May 18, 2025 11:22 AM
> > 
> > +
> > +enum iommufd_viommu_flags {
> > +	/*
> > +	 * The HW does not go through an address translation table but
> > reads the
> > +	 * physical address space directly: iommufd core should pin the
> > physical
> > +	 * pages backing the queue memory that's allocated for the HW
> > QUEUE, and
> > +	 * ensure those physical pages are contiguous in the physical space.
> > +	 */
> > +	IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA = 1 << 0,
> > +};
> 
> The queue itself doesn't read an address.
>
> What about 'QUEUE_BASE_PA'?

But the HW queue object represents the HW feature, not the guest
queue memory. So, it is accurate to say that it reads an address?

We have this in doc:
- IOMMUFD_OBJ_HW_QUEUE, representing a hardware accelerated queue, as a subset
  of IOMMU's virtualization features, for the IOMMU HW to directly read or write
  the virtual queue memory owned by a guest OS. This HW-acceleration feature can
  ...

Thanks
Nic

