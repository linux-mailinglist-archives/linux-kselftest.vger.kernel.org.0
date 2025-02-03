Return-Path: <linux-kselftest+bounces-25589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EBDA261B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E67B7A26FB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CF920E001;
	Mon,  3 Feb 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ErolDE1N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA620CCC2;
	Mon,  3 Feb 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738604945; cv=fail; b=eRXxqbdwqbnCJ7n7mGXmIcGoY454c64Mm5Bjq4+bh5vcYCNJKOuMvfrV+QtpNwM2xekbMMACW5M51r9uLRd6lyFOeZRZR6bfb+mBW8C+VDMOUxVfh4u2N5xUpEph6+IlAWzSHdf7VM9T220CWdGzTrkhWDsD3CN4Mb3A6RzC12I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738604945; c=relaxed/simple;
	bh=bqP8Rr0f10t1ANSmqd6DuAhRUrLfiFMLZ7gatfoQH60=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gao2R25VWtmcc1vU28R1uBn6+9GyOvJ/PYi2+XVg0PBdrFlccgXtoTK2Om+8QoOGrzLAaFk7Vvk3gBuFKuwdphx+4x7yXwqEe7aSulQ/4SLMHG7TuazkSCPYKSw4N77jMW5kY6pPrLM7tXJgpu2Hy6qh6rhqEoGMVk2DLBLjTZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ErolDE1N; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRG/fOgx0d0ChGc4ZbPyUgbWJFKWWG+NixGnAnnXLmgd4+uBAgzrWI/Mymu6/EoX1ei470KUTWkFR4+SJSIwzHrraK2VDciF/IVu3YanWsK3m4rgxPgl+zby83ETwOdHPwhQFEYhT9vANLj/7rS78CqrO3A0A3b3UmpgsmEcfGqsSM20LLIP8PdfCGJOG7dpJa6ebp03DziDGrCRzDQWkcAAO8Ht0z6+4aQJlZXGAVXQJ5NRIAXWuUtOuOD1tP6LGJ9vDkJVxCwXpUmhH81Y09+doJSZBQ2oHvfvskQ78cPeH873YdMdMti90PtQh9czLmrH5rSYT+77ZVb75vMhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkUkIUuSNGZdR/mRtv2PlkXnSm1sbXomDOYETl6hgh8=;
 b=YSG/TPNLidXFMcEfPBAsLyBQTdekNwPuwD7LFDaKK/QKZvv1TZhJXfkWcnMVYAk/vtUEBxjUq4SzjjMr21UxnGqaV8OT6wKf6NxLSiY7KkynaAt17m9z8mNxhCPviUYufB2ekRChuCJI+ViDeuFLsDPHKejCfdGBzTgCq3FI8oEE7KognQ4ccoRaus39D/v0J5xmMlbdnXiUrAokqlYj2swOxvg1IgLO7/SMX3cEEl4/qqKx78M/3mOdmkbGhcfT29O3tCcvvlnos5KhbukMCwfkvVegaPnKSPtU076QoOyv3yLgfJl+XqHPkWAq+s96P7eC9Hmh4O/JvDPonBF3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkUkIUuSNGZdR/mRtv2PlkXnSm1sbXomDOYETl6hgh8=;
 b=ErolDE1NQP0FgU5wR+Bj3S9bUTnUpUc9qeMaoVjF5biZ8rJFniWFwSTebTq0ETqUbDuioZyVcUoS58ergyAmmSSj8LYl8iaR0bJIbpWbUbxTfUurDrCEcrLiB1l8ACZjS4eqY/udewQHmUWV/H30j66rA85ujUTpPvmp4AmgzC4IXI/tN3JJx3DyvlbEBbj4SRLdVjsDWNuRkkaHZ3uoDmZe5WW12F42hrd0yPeFoTTB9tp1lrr6fJITU6JdYxE4k72eV4dLvXgqFY+KHX8AoSg/xLmzm7Guzx4mmZAdVk0aUZuAMiMeTXFIxMbikT81nw43fU+oDmR8OfWrkbSN5w==
Received: from BN1PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:e1::7)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 17:48:58 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::55) by BN1PR12CA0002.outlook.office365.com
 (2603:10b6:408:e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 17:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 17:48:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 09:48:39 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 09:48:39 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Feb 2025 09:48:38 -0800
Date: Mon, 3 Feb 2025 09:48:36 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>, <joro@8bytes.org>, <shuah@kernel.org>,
	<reinette.chatre@intel.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: Re: [PATCH RFCv2 05/13] iommu: Turn fault_data to iommufd private
 pointer
Message-ID: <Z6EBdDbMZqh+9NOL@Asurada-Nvidia>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <3b26ce04e8ecb5e47f028fe5cae48e5235e68420.1736550979.git.nicolinc@nvidia.com>
 <fd878b3a-ea02-49e0-9b5f-524e7fa1ecdf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fd878b3a-ea02-49e0-9b5f-524e7fa1ecdf@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c00892-17d4-4c30-e578-08dd447b0936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?65X739zJXaDfq8vM1ow0JPkfMe2Qwp4hAqIF5elx9w6jf/+6Hu/O+fW0ZpJN?=
 =?us-ascii?Q?Czuh0drlSB/5kCMZSCg7rHtj9hW08zdhhuyY96bJx4l5qU/2/ROJgDWcKeR8?=
 =?us-ascii?Q?q9LCr++G2RmoLDNHlpvOaWLFu7WOn2WrnDlybYWOlmhDm9GQdoeqF0XwChDm?=
 =?us-ascii?Q?AyQFDIH8r1qMM+7P5eyzj/K65CEbXooIdhb0SH47RaW5Xya7WVYDP+ZMzCkZ?=
 =?us-ascii?Q?X5WUmDG/JlqZ1uucAGq2zEv0YXa48rOndDzzwzViWGp1XT62MPgHVXUMAPlP?=
 =?us-ascii?Q?2N34ywDASTcWWk4e6lziYd21ypOc5pjyGiDFjHPm6t0PYe3g7MlPKEzd0juR?=
 =?us-ascii?Q?Ocs5echYDo5ajSZdfw7ddgB6+FTXuZOJcs1Wdf0uv5VP5Z4cREmZ3QPhdEUa?=
 =?us-ascii?Q?QlbpHtn7UA5TNk/osQMR59Xp5AHcWjWmFX5ZTlEIbay/+wyRp0Z5LaQ+FlTt?=
 =?us-ascii?Q?NPwbXCKETrMUdKDPfN3wUUTKiRnCP7FICQeHkGbJWmHYBuLqVFoaDqYX6/oQ?=
 =?us-ascii?Q?LLZf/0xwwgrthzk0+ACWwGg6S3aKkIQDCiW+8GcUNQvCPtIjKTCUcuj9gjDZ?=
 =?us-ascii?Q?5MCYCOcOoEEwe0ZqW4yHoN8A9wdPnztgWaH4hVqZMcxDcPECx+esO91dbWpT?=
 =?us-ascii?Q?uRANvmLWBHprtDdYRn5ZLidkKWSqPnM+V1Acsyd1LyesXRR+fcxM7H4FYLUz?=
 =?us-ascii?Q?xiKTWCCLmhDqQVK5QgdWWM5+lvC7taHCpxliJ3Hq09XJOW2Xr39UybfPPWrS?=
 =?us-ascii?Q?7MG6Wp/kioUcb9EQe3OS5IGBPwyjXtFjwrgzuP0+BHV4R7W75znO3b0CMlyI?=
 =?us-ascii?Q?WtuVG0PSlitKn0o4ZpKamxLlmxkzC7zO/y5Zn8rt583KWB+K8GUv39TBZxE7?=
 =?us-ascii?Q?NnpE4TLZ6HHPGehYh5FHUlYcV8JD0IhZcPc5Zcp7CUBB9/jBepWUrzvJb/9w?=
 =?us-ascii?Q?DsLq8ad8/GOa8NatcK1MeXdTAa/4lvpHgE/McGSrMIf+ys0SZwOv5NemOSdB?=
 =?us-ascii?Q?2JipYnQVAM5TFk15rTJAP56G6d//Xt4IoxLr96JUvFSaMp9/B8XskItpZMNp?=
 =?us-ascii?Q?zB4+Sl+DuxsCK6fRnJBD+buAwcutZGwUEYpaiOu7fvfAqtodBNLoCEVEqJEl?=
 =?us-ascii?Q?iLCsp0+oUlqkcT8aueoZsMkBw/q6RQV5DcVYI1jZ4sh/iCkf0xNTUXPCxb7X?=
 =?us-ascii?Q?ayKFJRuX3BBOYFoLulHSxVccE76YAh2zwzt1h28zc25zrVyuSgOuqtF5LiYb?=
 =?us-ascii?Q?ACC3HxdRkx+Zv9Nmuny7X/bFm2EdVdSvl+LOR+NWSbDPZtPG0rfjeRioch8J?=
 =?us-ascii?Q?ThUeyEcODaGXjnanIV4hjSh8zUCypIMxXDkVKKs/igv+jsIdl/IOqMedeES8?=
 =?us-ascii?Q?YHDKOuK1vJlDwE6eKNE3x7v3Jl+qYtIpE9Qz21NZ03iW8UKeFEEOdCheUP9C?=
 =?us-ascii?Q?8XM6by/dstwDSU55XCwq++TDEvx38PVWt3DOs6xC7duAgHqHLDQ7x4yjPIHo?=
 =?us-ascii?Q?sIwgQMGgz0RlGFE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 17:48:58.0862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c00892-17d4-4c30-e578-08dd447b0936
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354

Hi Eric,

On Wed, Jan 29, 2025 at 01:40:54PM +0100, Eric Auger wrote:
> On 1/11/25 4:32 AM, Nicolin Chen wrote:
> > A "fault_data" was added exclusively for the iommufd_fault_iopf_handler()
> > used by IOPF/PRI use cases, along with the attach_handle. Now, the iommufd
> > version of sw_msi function will resue the attach_handle and fault_data for
> reuse

Ack.

> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> > index ce03c3804651..f7c0d7b214b6 100644
> > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > @@ -402,10 +402,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
> >  		}
> >  		hwpt->fault = fault;
> >  		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> > -		hwpt->domain->fault_data = hwpt;
> >  		refcount_inc(&fault->obj.users);
> >  		iommufd_put_object(ucmd->ictx, &fault->obj);
> >  	}
> > +	hwpt->domain->iommufd_hwpt = hwpt;

> don't we want to reset this somewhere on release path?

We do iommu_domain_free() entirely on HWPT's release path.

This basically sets the domain's "owner data" as Jason remarked:
https://lore.kernel.org/linux-iommu/20250113164037.GO5556@nvidia.com/

Thanks
Nicolin

