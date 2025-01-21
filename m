Return-Path: <linux-kselftest+bounces-24897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C5A18658
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 22:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E361889911
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C61B2EFB;
	Tue, 21 Jan 2025 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGCw/5y6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178523A9;
	Tue, 21 Jan 2025 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737493355; cv=fail; b=lRE97hQfpQgju3/NJARThYJmC5y43dRkE06GA9kAvSaIQJO+bJNRktZc1aZhpi0XmD/k6RqUNS6FBtbdPvVSOrKF2+3jNWucvTdgIdEVNkWSPoehePwMsiAZrIq4LuE3kXfoQ6bb/z6keh27j2W1Slm5ZyGPm6yo14YUe/Se3vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737493355; c=relaxed/simple;
	bh=Gejx5C3yG0vKonvFQtG328q8phNa2Pt8nxNV+sX3qTg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqOO8vaBVReilUc90TWyW4KaCLhP0/ApxK0jyOtrSyapgsojDDjQ0OeZW0rToz35lLEQ7nVQVseIyXZAvoTPQePCxNN+DcpGgObWXCK9cIS99fGR/ByDsBo6/cRlmh0k6DrAarvA0hwJe96+O91kGj0RYc1Z405o3GMoRSLWr38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fGCw/5y6; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTPUJa7IlafvhqnKrykeGA8LRhCG30Orc7iaZPVS8KVj5g6PK4hZOJjKf8Y7hdrug1xwnYA8lrqyThs/ycB73vJ9bwahBVmG2iO3KQBfyOu8GDRYhAYADGa59Fk9ndKXpWS53IukvfmW4SlyUMHt+RSEjKoGz7He1CV6jNHVNFjravUNM0o1IhHoKa0C7gp7uEQfyA1qfvye5oVKA9FQPDoGzPbS3H+QgQuVJjPCVNuGYshT4UIfi57gz3kwYITLSkIwNvhc2Z/Gyhe7dRJ6YXH6qH77rNXRn6GykLs4GTMWGXB+6ORdABTZTbDau/7qTnr87S+04O3A/2uy3DZGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU35b4mbEIGU6y/wwlJqRN5PGYXfOuAarC5EwKoytv0=;
 b=uY8FYygloyYPat7GeuJbuIijZiUpazwHVasHDEl1BmNl8ZVKH5tf29h+JxjEmKKwhxDx9ZoK4J/kM4qlWc9rjsSIgiD62rwDFBXjBb6AwuoeuC83MxzRfUA8sI5Znd/9j2zUeQA5puuN9WhWnNFBD+jh0nxb2MDvPLjuUkEQCis1hFHN6YKLvQBgNgwH3DIvVnQby1TReAh5IvtR3adw7k92Oiz5309dima80TQyLPoFcelV9h2qeHiw1zODzrW+DKBxjmwoHeD8fMdRRdWMB8wFQi6eMTLSFmuEEB5TmvkNuUAoYG0nM7YjXyWCaSqh6oQldcrpVmvlQqEPev6lgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU35b4mbEIGU6y/wwlJqRN5PGYXfOuAarC5EwKoytv0=;
 b=fGCw/5y6OOD0pJV5UuLd/5ZOI+CjB0TUEf8VB0YZ10XwAtxzhoJvK+cnvJmAI7Ns8S6UOKMoevaQLCtgjx/0pj4bv6Ic0/fMfLrhanosTimq2RpsOW7/5EsdaaXGBRFdrCQCZRbt6LcBDT6RFPdrhNPMKJAgv0IW/rIrpAcd0efqZrpVlXzP5HU8k3adKtqV8vdxxhnu31RuVOOSZiUGXC/Ldh979iqe7wbtExmMdfGlZBeerlOcA5GZuT5vAse3qIrWXUrkUkSsPWPQ3XQlbW/LDHpJVEaJG7Sq/ugDPLrCz8dMrTKQO4dh73wN8reMSBKVkj7RKALXxX1KNBb2dA==
Received: from BN9PR03CA0648.namprd03.prod.outlook.com (2603:10b6:408:13b::23)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 21:02:28 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::6f) by BN9PR03CA0648.outlook.office365.com
 (2603:10b6:408:13b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 21 Jan 2025 21:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 21:02:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 Jan
 2025 13:02:23 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 21 Jan 2025 13:02:22 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 21 Jan 2025 13:02:18 -0800
Date: Tue, 21 Jan 2025 13:02:16 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <Z5ALWFVTOSC/8+ji@nvidia.com>
References: <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
 <20250113195433.GV5556@nvidia.com>
 <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
 <20250114134158.GC5556@nvidia.com>
 <Z4rVg1Xg5TCiFlSb@nvidia.com>
 <20250120181854.GQ5556@nvidia.com>
 <Z463eXfgNArCOfPn@nvidia.com>
 <20250121183611.GY5556@nvidia.com>
 <Z4/7pGx6F1mpAUuV@nvidia.com>
 <20250121200924.GZ5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250121200924.GZ5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e97d03c-2377-4a43-6be5-08dd3a5eea13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qjKpNWiv7gdDYR/e3boNfwEaZnfB7oZ44iyj44te63YYtGIT4yBpPjnD2UrQ?=
 =?us-ascii?Q?MGslxJjAuBcBMo4zs6iku6/Y6MYfongpmj6nyUA8co5SgNxqlM64uK37ADok?=
 =?us-ascii?Q?lU+cnrYZr0taP3lwTACFrlcuHRQpT1MIuXcLA0lRFMBaFl1D7bm4mIQH/udS?=
 =?us-ascii?Q?4zKQ/3PSsGkjt9FjXihedeNUiUr90JDBS6N9cSrtWCuqioaDbOldaNrFi/Xp?=
 =?us-ascii?Q?yiRH0JXbh16lDQ9FQueZsTvCDzfCk49ydkv9Wngba8CpOI9WiN4uMj8l/mGr?=
 =?us-ascii?Q?fWllyfb8FCpBS5cnMLhX5cMODEtpRlTlujHEOs0LnXVd6lZwTSCvANnc82//?=
 =?us-ascii?Q?misNF0H9bQ/G2k/kEAKDXo3EdOeQwRIcBupvltEZrtVecaupFKWwjHeU1/vn?=
 =?us-ascii?Q?0Mgk7cI7g0wP577ZL72DiyBRfFOw4G1gIgfa8WGbwwS9shaIbn5l4lG6R9RX?=
 =?us-ascii?Q?ZXbIuP1QB3o1Ih+jvvWnaxGgqdaavjWoD00Ur+1srJUpCRKDMv4ZV9Yx9k51?=
 =?us-ascii?Q?m2ZnrjqkAv59HXyiKSBkceeFSslZLLwKzPQlcY6niYkCvh4YwYFUA1CwNW+L?=
 =?us-ascii?Q?aZ6mhD2dn0xx6A6WRQJCUc0aRdJuZ7UZ1Cgd5r6cUAWHHftyCNB3Alm+p0fx?=
 =?us-ascii?Q?/d0rwfKB7uWzHZTrfl27mm0uhfDnuklLn/PMKSfqBOS8v3MdLqF2kc1Gcth8?=
 =?us-ascii?Q?v8fKZ0h0eCGqZ3xZx8Z3KZ78VCuo3DN20eKzgCiyHgSF5Kqf8WK0lFvBGNFr?=
 =?us-ascii?Q?YSD+bhxe81NhPB+vYO0tlDT4bc694ly4BWVe3mv7lZXq2TyZaQT8YPal63LY?=
 =?us-ascii?Q?GeVbaaB8YJLzHGqdelFzF9MUJcTXz2iw/gbpJYvTZD89fRJSVdLiiXXhMC0P?=
 =?us-ascii?Q?ibiERrmiA446ooXcTLaXDVI4z2XsCX9T28TxvnGk40qL8JT+akQuhC74NgfN?=
 =?us-ascii?Q?SQ4r5Sg7kc6TMf5DRmrP74crQXm+jCn/MOACf1D52Md4Dv3tRei6obClc/HV?=
 =?us-ascii?Q?znvqFWyUokIfZz/M1fTneDYbuCT24FuQoi9AMvH86jvV2AziK0vK9S71b811?=
 =?us-ascii?Q?vIkp9gr3R2o4DJ5ecLxkiVfKue+Tl4bCmLT9rFWVN4p2coU2yMGKWAJVEdJC?=
 =?us-ascii?Q?+NwdztRxNgEJlPBVLc7wiTPhBOUMXyZhXOREq8aUv0nxSgtGuOIV4+HwmRUg?=
 =?us-ascii?Q?zdw67YcAlkUdyfJfBHITfOM0zmSAeBnJ9A7jRNlpjXVr7iRtZKNRDf/uL6+6?=
 =?us-ascii?Q?r9ifrZCg6RySK5NIAgXOWWTxtKBB3xpA1q1DMYcA4bD568QTgRb60uXprPca?=
 =?us-ascii?Q?nkdDROVDHLOcKEsdr5YK4HXff6ebhEjme7DceuvxBylhAZoQh7UgtVQEhYeB?=
 =?us-ascii?Q?alpdiI+gA/TW1LptKEspDtDCvaR/7cVWvQZ1kLolRRbbbley1oQYtXdh3Bnc?=
 =?us-ascii?Q?hL9K5tILNgMr6uAKBg1VfNIuLqD5U0sZbA5pdQjj+2iQ33m4bksNWLsAKkv+?=
 =?us-ascii?Q?Namg6lqKuP9IwUk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 21:02:28.3081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e97d03c-2377-4a43-6be5-08dd3a5eea13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124

On Tue, Jan 21, 2025 at 04:09:24PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 21, 2025 at 11:55:16AM -0800, Nicolin Chen wrote:
> > > > > IOMMU_VEVENTQ_STATE_OVERFLOW with a 0 length event is seen if events
> > > > > have been lost and no subsequent events are present. It exists to
> > > > > ensure timely delivery of the overflow event to userspace. counter
> > > > > will be the sequence number of the next successful event.
> > > > 
> > > > So userspace should first read the header to decide whether or not
> > > > to read a vEVENT. If header is overflows, it should skip the vEVENT
> > > > struct and read the next header?
> > > 
> > > Yes, but there won't be a next header. overflow would always be the
> > > last thing in a read() response. If there is another event then
> > > overflow is indicated by non-monotonic count.
> > 
> > I am not 100% sure why "overflow would always be the last thing
> > in a read() response". I thought that kernel should immediately
> > report an overflow to user space when the vEVENTQ is overflowed.
> 
> As below, if you observe overflow then it was at the end of the kernel
> queue and there is no further events after it. So it should always end
> up last.
> 
> Perhaps we could enforce this directly in the kernel's read by making
> it the only, first and last, response to read.

Hmm, since the overflow node is the last node in the list, isn't
it already an enforcement it's the only/first/last node to read?
(Assuming we choose to delete the overflow node from the list if
 new event can be inserted.)

> > Yet, thinking about this once again: user space actually has its
> > own queue. There's probably no point in letting it know about an
> > overflow immediately when the kernel vEVENTQ overflows until its
> > own user queue overflows after it reads the entire vEVENTQ so it
> > can trigger a vHW event/irq to the VM?
> 
> The kernel has no idea what userspace is doing, the kernel's job
> should be to ensure timely delivery of all events, if an event is lost
> it should ensure timely delivery of the lost event notification. There
> is little else it can do.

Yet, "timely" means still having an entire-queue-size-long delay
since the overflow node is at the end of the queue, right?

Thanks
Nicolin

