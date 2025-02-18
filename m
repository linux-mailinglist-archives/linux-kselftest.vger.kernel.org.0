Return-Path: <linux-kselftest+bounces-26901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7286AA3A761
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 20:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5576188C636
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358C51E51FA;
	Tue, 18 Feb 2025 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DJuQMA/A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630921B9E5;
	Tue, 18 Feb 2025 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906852; cv=fail; b=BEPPxiiqFT8jRa640saRdhiDeyxdPKC4K9JmkK2obFWfkqBwwAGX9g4LhnA2IuWJCV/CrTYeib8Kpzq727fyZc5Fpg/bVp9I1eJOEo8/xRBZNwkvSWLT/nkk8pOtRb9ZNNqUQqYyKynT32GYP8j26uUzuyrSHN6aM2t6rBcmx/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906852; c=relaxed/simple;
	bh=SZrJTOr4u40jx99JmRGJzJni6J1vp9RrFIp3QIRJGbw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIK/pGqlsHiEJNmt9S9g069O5j710zWDjULi/NISOHaTxtGbj3TjMuMKS3VCKGiGxtfBmqzlnZJlJFh2kqzC5ikiZJMrbzrLKjcGSd/QpgqW+lW5Aqe3f1rfXMcjWKTaHFUQAJksa+NsbOWUcMtwx1yRvtvGCfz/oNydNn+1Yr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DJuQMA/A; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqUkIkubl1MFL12HHdd8f3mNac7iYWjs7SwnYPTIHuxWJoKZdMrA072ZGSz9GPXR2KOIFC6Jo8R09gOxTjwvvMePi2Uxhic51udqqwMDqExYH1TcfxXi3+GDiGgdw54TXx4mlp3lxuHOy4WwtuJPCQg74IV2DUCm4Pt19BzZYkkL2SZc8p6eDNeTAXCsr2FrZVbvUNchx4jO6sDcbOIriQESO7/rwEL6Luyo53F+0/CYZLSSeI7DTl4wRNMgvzHCyYZSjD84B+TkXOib+cE6sESEw2Uc733Hiy3qv+OxG1riumg0+4JjVtSsIvAk76258w5VS5abVG3KDkYDJ+eUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0YgGsK4Gx4fed7RGa75+aNLGFXvtdxE7pqSyT+jtYY=;
 b=m9mxPY7XHJFrXt6rAVajWicxZdpbjiHX06TJaA0Uo+ogfNpaNJPAlpiEwksJXhrBTSJ1cRyiksX47yv6tcdxoduXfkFek7qr+jb9fT0Czk6E7FVIcF6EPFPaPCksOYl+J0I3MAzHHhXsx1J7Sy+Z37Ssc8G99qRU74nIEPIBfe6Qigdqgrv6SmrWQwrMMofhnulJ7KkZxjvXna2uyJEkXVoOZjdfex8qaLUEuecHUiGsHQROGm8OBN1U7puOMur8Vk6uokxS2335xrM+Jtilung6esgtbOkyNLx53BdzMoKebzi0F4dvWmsA0o5Cy8upKJ7RMiZi2RrGqwEpu1yZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0YgGsK4Gx4fed7RGa75+aNLGFXvtdxE7pqSyT+jtYY=;
 b=DJuQMA/A9bpaAZuJDxn4p2EV/mnzXh8YNUfbSuS8/awwDa8Yi7WHhLzVV+JOc5E/90MM1EUHVAhd4v6oOnPQm3P6NOGl8hUrllUuMYH95PQNiAj+rWcGaFo9CmzHuD4ZAubsFmjRo0kD6Y8S5Jl3v//5r36KrFvkzMtz/n7SyQ9kU+sFtG81A2lgOmNsQcqxb89MifuvGpORNMOk+R4nYLt+f30gIUpQ13lKFRLGkVRBbaYwq/ZGHJ/u3OCtADket6XiWSfID2/3etIMrUSiDdZ8KUWtfTPriY3fYSljCjWh8VMVv3CriU3MexbuGD/xEBX2FeDMqaWPF0Y2aIoZKQ==
Received: from BN9PR03CA0086.namprd03.prod.outlook.com (2603:10b6:408:fc::31)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 19:27:27 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::1c) by BN9PR03CA0086.outlook.office365.com
 (2603:10b6:408:fc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 19:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 19:27:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 11:27:11 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Feb
 2025 11:27:10 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Feb 2025 11:27:09 -0800
Date: Tue, 18 Feb 2025 11:27:07 -0800
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
Subject: Re: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z7TfC4fmvm4e6fEb@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
 <20250218171821.GG4099685@nvidia.com>
 <Z7TRNL0u0YmN30ax@nvidia.com>
 <20250218185046.GK4099685@nvidia.com>
 <Z7TZP3jXlRzweFE8@nvidia.com>
 <20250218190846.GA4183890@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218190846.GA4183890@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c27980-5ead-44f2-d10d-08dd50524762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YfBiuAD0dANivEV4OF89RsbA+UvDiqqznapHDKLRz13IbhFP8qYFOqEHrASE?=
 =?us-ascii?Q?MS+W1UQRgKXeGMN2cPMg3PMvwy00LgdScpeiiSisVhNfKV2tszpo+bGDU0W9?=
 =?us-ascii?Q?5jbGZkFvmrlsHtujGihthNxBK6lVFyEihC+58t8j8OwMaqAteheTFKCZTSjb?=
 =?us-ascii?Q?C+zJrL2QdfSYiHM9Our4VyRQ5S45ZEn22PegJt3C1BtWwnBBKumD/an1Cnqt?=
 =?us-ascii?Q?kYb4eWtWL1IQW25EGKyE9qZMwybrsqvN5vRvAZM05oXMQAADCMn7LMph7cOx?=
 =?us-ascii?Q?VwWM4Ona5SAVpmyYsbZiJSBrcEGxooafg+s5b1Obe5+V4lwzPfZwhOS11TWD?=
 =?us-ascii?Q?JkM84vI3agps8TLHkB50fM6j6h4gm9V70hc/ir7Qs2lvxv9FgPlKQs6As/IB?=
 =?us-ascii?Q?0OUw4EDwgMmJUSQ/eNjs8Hc40paQPyNDtIhZZKLJ3RygZEHRETz8KxIi+qjA?=
 =?us-ascii?Q?PFrXGE8DaAXncj/Qwo0hVwPpJk1h3SBbagKQq5UVp83W3KWT81AABhX6mVSn?=
 =?us-ascii?Q?tXrCOFGXj9FGJ9r4YF4DEU491y/T4uBcMyuVT9Fih/LmkJiCCTbaeBzaXDEB?=
 =?us-ascii?Q?EeOYDgYD7k/rBCs4fzGoG4m4U0NWBbDQe7UomxEUlu7af+JhTqUcNd3omp4M?=
 =?us-ascii?Q?Xnb6TSACn68joKMYsRA6kQVPg45MRdD/LHa9Dvc+NnHuTBEwBDsdlI75QG+A?=
 =?us-ascii?Q?Q0ZJy9NgjlqHucGILVFD+wH6rKLev32dChmyrdV0txilQDV2r4w+rG5cXV1+?=
 =?us-ascii?Q?BanGOERlJYNIFEhmTXtVL+ONe9vd7XY/kheRaPk2ynqN+UIgn53m8YSTJYba?=
 =?us-ascii?Q?AvRHhSUteVqDTVzK4zu8ZXHBbSpuvO2Kt6YlbPeyS+71X0d9asjF1eiNiHxr?=
 =?us-ascii?Q?iT25CSOgPWlJNoPGgaLm3NzbImmIAUWj9QOoztlqsJ+HjrIYSeugqhFAIKfq?=
 =?us-ascii?Q?g9Qbc+EC8o/EmBkn22aUz9+SLqrYNMd6vb2Bm4SOc2kJdQyHP1xbe7ex7Qdt?=
 =?us-ascii?Q?ZL9nZhXPdwj5WXM7enFVnMpqutOoodsDnB1EV672GM2N99I/pCqPj9uaHWOW?=
 =?us-ascii?Q?fq0V5mzKBjF5+2t1yGXjskW6eDZgXTP8RKmfcOl/TrUJZrL34WYA+NL3clrm?=
 =?us-ascii?Q?TfhEg8b9fmrwcKXtf4h9PmIdk04PjcDnF2OHj7uPx3/HmcVHZzTS26ZqOgkW?=
 =?us-ascii?Q?g8u7gmL0SmZ8ONcsIMqhRlTM9hdcuoMW2cvxfsfr7X6sw3k72joCQQZC9Mu3?=
 =?us-ascii?Q?R+sYO7SmSlpzZo3biCsW3f5g15CJ475/sVLAe/Jr6DCrNvmYb9UIFIcsdH6G?=
 =?us-ascii?Q?RRjAT5ezQjutaz/UKMuwlQv9E4i4isv5cWpaOBW0tcZKFBiO07Zjhp3LIt3T?=
 =?us-ascii?Q?7nttab2qdbOGRk8eZbaVxqVi/7aMTJAdFP2LgEJFcO0ueFCSGDR2BuyjXnia?=
 =?us-ascii?Q?1VuFcrXpfRhBJthL6alrxv3HyjkdPvb4JILBMniXq/3XaRkQ/SjlLfrqYTyT?=
 =?us-ascii?Q?QJ5AgeGa51zIvoA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:27:26.9802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c27980-5ead-44f2-d10d-08dd50524762
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151

On Tue, Feb 18, 2025 at 03:08:46PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 18, 2025 at 11:02:23AM -0800, Nicolin Chen wrote:
> > > > > This already holds the streams_mutex across all of this, do you think
> > > > > we should get rid of the vmaster_rwsem and hold the streams_mutex on
> > > > > write instead?
> > > > 
> > > > They are per master v.s. per smmu. The latter one would make master
> > > > commits/attaches exclusive, which feels unnecessary to me, although
> > > > it would make the code here slightly cleaner..
> > > 
> > > I'd pay the cost on the attach side to have a single lock on the fault
> > > side..
> > 
> > OK. Maybe a small patch to turn the streams_mutex to streams_rwsem?
> 
> I don't think the interrupt path is multithreaded, is it? So only 1
> reader anyhow?

Right, it's IRQF_ONESHOT. I will keep that unchanged.

Thanks
Nicolin

