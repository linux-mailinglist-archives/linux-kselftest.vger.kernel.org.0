Return-Path: <linux-kselftest+bounces-27117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A7AA3E677
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 22:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90083B1AF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 21:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD0726463D;
	Thu, 20 Feb 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GbNKrurB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A01EB1BA;
	Thu, 20 Feb 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086212; cv=fail; b=TFYggbUqE1zfhYsGTb9YEd9EBnrYGxFCMEgtWRM9+eGiBVMq7jI3uT35NE3g1R51Bcx7DHoogMtqiZK1bnBPRmBV2Oes9SmqCpeReKWVjXbt3U/0xSBBcmoOUEWffjuiU9SDZi9AGtsyLMNeLttIqxbk/u/LKBvNq45r7ZEYc7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086212; c=relaxed/simple;
	bh=MleTJyvu/W9Psue2v8xoWfjAjYtxMsNX2/UJBiHJiak=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE3A2X/D+6Ku6/y42B3arRJzQHN4PbA5rLMtjZovVA3VGqshk4K+7OPGM7eWT05vrtsJmwPtBgGiD6YJDS+YpOZeVfYZ8xRlUnc4tP3idXUxinkAR9BsLFVaVx3Fq8xlBy3FZaZZvbynqjIFdkRXvyLdvzT92gMefY+FN6lzSsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GbNKrurB; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1JN86LcWdMLkDqXXcFSE7cDYQ/2S0Y5k8DNtihOuXyBpObQkGkQefLynWf939g+T2B5bN/XWtHnDhcKlGE5TJUcNGsFWGGgEmK7elMO/rJbfhhiFT8R2NFgVnw+BRxn7M/A4gMG+h02qkp+RhQ7SL4T675qLyiuv1McozkkiEFbLUxZftAm6b88tyRYdkVXAZE1LZGCFu6218PpDsdq49LLEPTt/26j2kBDDToe2bBwmn4uO3gIrHxUO8WS1Nwg2FYJZtDmaeNQlx47xsUreLhyI14NgPeWUT5jVUDdWXO9aC0PxBuvrVn0akonM56kD0DV62o9s6j/zQ2WdSERfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkqVTrjN7uBVQcVWCYTofvUUoNS8+3Nl4/ATU1ESurg=;
 b=Cxz+556b4MFMxClJ5/qjxYnW0DFbNOYoN455bFFnUg741wAefNOLpBf+H1g7Zw4Fr92PCQ1H2oqt8lE9FF9Xas0XZna556WJV2ezFF8O49YVZ8YQEDIMJx07ySPa0PPQvAV0JJ152GQtrJAt6mGyhGBtlgEh3uPeaktY0sTJ/5IhRofRkSZM2jpe6JShEO2UaR+xosMkjCEVMQO5bcA5a3kYWzT2betoFo0XBtL+4TOfXU3/uj61GtLuLKy5D5bn6lyD7mLJ1A4wJ4bthefZBWezD80kCLUq0aeeJ/AkSpD7GlwuAAKI5MNBCurPzvHgu1mBZ+M2iSTA7LGESvGoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkqVTrjN7uBVQcVWCYTofvUUoNS8+3Nl4/ATU1ESurg=;
 b=GbNKrurBr/zzYriMknQPcGT8CEQHhYqSKn7Ica74p8lSJMZdqMpETphEycjlN53SSjPUY+WpN0yu8PJfy53GaZ8lhcqmmM9R+vbqZbjBoMZqi6lPaVphWwUSEHXhNDiBkUfd8zTdouYeudFpZtBzTLq/D/kTfGsyDdMFawnxbijjRryLUHvAn70yHpdLnA+kQrui6oeIiF6377ZiqEtoHk8zB+jAgu12FdWNUnPSyRLoOTALFIvf/a9KQ/Lr4CWuVXB4inpIb4XzQwewou3eOvJm0ISjWl6oqiEEvW0oXEH+X5NbWs5UrDlQ03d/izKflolYi71ntW6Kijt0ACRRJQ==
Received: from DM6PR17CA0009.namprd17.prod.outlook.com (2603:10b6:5:1b3::22)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 21:16:44 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::9b) by DM6PR17CA0009.outlook.office365.com
 (2603:10b6:5:1b3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 21:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:16:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:16:28 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:16:28 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:16:27 -0800
Date: Thu, 20 Feb 2025 13:16:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 07/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <Z7ebqtJUwzgOIeSC@Asurada-Nvidia>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <3d952137a7935608f9cc6b05bd561a58a0c5da16.1737754129.git.nicolinc@nvidia.com>
 <20250218153541.GD4099685@nvidia.com>
 <BN9PR11MB52766CE9C579D3EE1CE1A7058CC52@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52766CE9C579D3EE1CE1A7058CC52@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: a285de5f-d756-4518-8513-08dd51f3e055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ez+Ie99B+KPppWu/JMauspeHInXEWCfKaO0BGf8ADSihLCnZntxLLS91KfYS?=
 =?us-ascii?Q?Lc53HopzP10a720FhP6RlclTyBS6/9vwKRl9oqeuAt2sWe0fit+ALEgYZepN?=
 =?us-ascii?Q?5X1EiZFwR5zsukXrkKqEFFAPhubwFGdf95wuCs9E8Z75V+6sY0MVV233m9Ng?=
 =?us-ascii?Q?9MaJ0GymBvSaXou7p+8nYEs2rPyv3vLOUqEvYYCPEDE6WHRCxXl7Ffvu3eYC?=
 =?us-ascii?Q?0+ll645jnA6T/teNQc22Em1H74ZWW/MT8FE3DSM/xnh7Zez7rLHU7/sPiIMc?=
 =?us-ascii?Q?3PSQHEQEEO4UrQN5V2PAV6gcIahyQ0YyNDPAEP2Wf+dSnrabX92TuVw2M5sy?=
 =?us-ascii?Q?UWwxKV+mwEQlHunATvLldve8sQ6/GSPb4sssZnlvqDw8m9/rOCJ2CSZRlf0z?=
 =?us-ascii?Q?XHEzj4ZYmC42IvVCeKG0oZ46sxt5s9wC7PVdd6+RnMQVTaYDLBAVQ3nXMwYA?=
 =?us-ascii?Q?nRH2g3z7tm4AZqgAeEj6nTLpphpBtOhVNnrNqCE3kQq7bfv6vMus+lvH8a7Q?=
 =?us-ascii?Q?B+aIr5miiOLC+2bS1KAo+6GF3u4FywHqsxc+1yXdzJw4M3bJNK5gRj96lhP7?=
 =?us-ascii?Q?Y4JmALjs3+8+y7brQJAb3w59/vVs2ltLQj0P2hfS+8o5pM87mfVIp//ddI6j?=
 =?us-ascii?Q?MQD1aM5wOFChP17geffNQ3F34EXtl8Ev8jrKZ4ZmbzErDAZ4CV+aQR3ZZwRS?=
 =?us-ascii?Q?gQoG/WZx9NUW4aIOf7KVkREBEA/h0eMcAwd/mPgG6uNYYjDliXY8ukdM7I5d?=
 =?us-ascii?Q?k6/Jv5gNEAKnJ2hprMbC2eeQVwvQSHhHL1V0ykhWqrYlNDgH9Aqod6z2IBb2?=
 =?us-ascii?Q?A3JGiUfrASDyHAXXng4SFpNoOn0SN49yS9/Y42JFUedn8znMk4a6n4qfNO+r?=
 =?us-ascii?Q?u6rcoPfd+M5zrNvFr1Ke8ZBOLP6+hkVoEyOlyAMH1iunsoOqlsZB1Q9fzemY?=
 =?us-ascii?Q?HD06N/fPgfpIrf52j8QKFKU8q19YVmeNS0mAWdwBrFdGc7MAu66IpNlZsU43?=
 =?us-ascii?Q?249C8Li6Z8Xnwf/jqQmIoDyT457DOba6ZlbJG/tzana0E8qYJzTscZsuaIq0?=
 =?us-ascii?Q?MZzeUivnekPneL2PN4zT2AVi9lAJ4DOBbhlBlmP3NF4pxZ2ZF8hpveex6Z2+?=
 =?us-ascii?Q?+HwRhE6axvOvgnPgVFrHqqQGUIO2SIukzUy7PjXM/FluysClYkegzWqQ4wE9?=
 =?us-ascii?Q?xNLsXuun9oAuSCN2oNNm+c5Rbpx/NpCnXueKMoB/i3zu0bHPtTW8AULtTV5L?=
 =?us-ascii?Q?HX+2/+xMYoAzqDHkTFFEAAiKNlfu6BVpGaCFimlMWgrZV65F5xudZv22emAE?=
 =?us-ascii?Q?wnOEtG0zTDf8tvkrid5PdJiYUe/PDk29MP9ycgrfkHiolekiRBB1XScVtIIM?=
 =?us-ascii?Q?teLWD3a+jDxESYermvbrXAQVpiTyCUoIA9ddN0nsFgWeE6ecq8oLZHkpqnmh?=
 =?us-ascii?Q?7XdHL1yYPVqqNJnmUsD+8sONYQuibVHjgnLhZfpFz73EycqwZnOOQjRiYzgo?=
 =?us-ascii?Q?V4A0tmQZFoHTbdY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:16:43.7675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a285de5f-d756-4518-8513-08dd51f3e055
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

On Wed, Feb 19, 2025 at 06:58:16AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, February 18, 2025 11:36 PM
> > 
> > On Fri, Jan 24, 2025 at 04:30:36PM -0800, Nicolin Chen wrote:
> > > +int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
> > > +				enum iommu_veventq_type type, void
> > *event_data,
> > > +				size_t data_len)
> > > +{
> > > +	struct iommufd_veventq *veventq;
> > > +	struct iommufd_vevent *vevent;
> > > +	int rc = 0;
> > > +
> > > +	if (WARN_ON_ONCE(!data_len || !event_data))
> > > +		return -EINVAL;
> > > +
> > > +	down_read(&viommu->veventqs_rwsem);
> > > +
> > > +	veventq = iommufd_viommu_find_veventq(viommu, type);
> > > +	if (!veventq) {
> > > +		rc = -EOPNOTSUPP;
> > > +		goto out_unlock_veventqs;
> > > +	}
> > > +
> > > +	if (atomic_read(&veventq->num_events) == veventq->depth) {
> > > +		vevent = &veventq->overflow;
> > > +		goto out_set_header;
> > > +	}
> > > +
> > > +	vevent = kmalloc(struct_size(vevent, event_data, data_len),
> > GFP_KERNEL);
> > > +	if (!vevent) {
> > > +		rc = -ENOMEM;
> > > +		goto out_unlock_veventqs;
> > 
> > This should record an overflow too
> > 
> 
> In that case probably we want to rename 'overflow' to 'lost_event'
> which counts lost events for whatever reasons (overflow, oom, etc.)

Naming-wise, I think it may sound better to call the overflow node
just an 'exception' that concludes with lost eventsfor different
reasons.

A complication is that this 'exception' would give userspace a very
implicit reason as the node just report the number of lost events
v.s. providing the reason to each lost event.

With this, maybe the IOMMU_VEVENTQ_FLAG_OVERFLOW in the uAPI should
be just IOMMU_VEVENTQ_FLAG_EXCEPTION? Any better idea?

Thanks
Nicolin

