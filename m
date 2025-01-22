Return-Path: <linux-kselftest+bounces-24912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8DEA18C9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 08:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9363B1889FC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1B1AF0DB;
	Wed, 22 Jan 2025 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r7saYjTo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB308143723;
	Wed, 22 Jan 2025 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737530165; cv=fail; b=bx5wG4yvLxsY/dGO8YteufzXU3y6G6RL0tmOBwGWHKg3tlfUh3ltN+FTRO4doVChTJcYyzhlrz42eFlxMC8RgmWHHb7Sdyz/qfm7bfk5jFY7/R1XPsMxs9hrVoIEt2Inpe5Fd9hpDv1xnXmo1S56B3VtWc426KbCDrF+N6b2mvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737530165; c=relaxed/simple;
	bh=qlsUIL7PKqEU3Dkfdxy7IG9ZmynB7cmLOJIsaF7ylA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noW0m+t6cQeNCNufOGkJtROihlIp6LlzQiLoCQ2m9uU40/YA78A+jkaX6nos+LtG1qWT43TNy0pNtdv5g33cmRqAMOXJBEgr3rg8XIp+einK7b83Nt6TK+zgDfsukTY2duBJPuT3C/dV470ZjOETQISgk44Ek5gXoie8GfDE9f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r7saYjTo; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKL/F/kGvJqMB1nuwPVbcedv+THNm/3X0iejhJpMbVDEoINe0aOdhXy9dT7z+fC3b/3+PsfKiP4O+E4VDipZKuSoG6HjxsukRWpdXsuMxIW2HL/pzVde39OAX+hxDfvVHqhQZKOzcrhrvrVmmU7XZmJTtYgPkkgOT71pSflQLNe91/zzEc+FDfczOkBZXHBVtZAl1mJv1dLmN7eRUwKxv1DuOT0uIxFM0grPSIwavSUpGHsXMaAAWisqBYxG5OsWFTz2g8FDfBfVyT4WJT4x9YAT/waNSNRJMSZOqaxWyZjOqsDlJOxgP0L8IX0qQlLqAVuaMGquy3tlFElMocoYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hhWPgTtRw8HFH6N8rgW5HV+TT3s9L6Lbj53zgNmAjg=;
 b=IYxc1DQL1pBX3gl4O+HLnKlUbtkfShUxQ9fs64bEhGnGF3jWZUzfgMkDPgqtH01QV8RdYROTs9FXFtmkjD3hQVQnOx8QIm8lqsRgzjn6+29/rzUsR0QVdAC1YoqNe4LkSKXo1VISyW6SPMCLySU5GeykR+PuAHEHMG3+AAa4o9VITlrTBqkjlywQvEygGOrGIqdf/Addmn2cZ2nLm5TZmifBGsZ6PY7zgX/tvEfHz0Atd7C/hz0MOtieMuCGbX8IXXTStIShjUXnp7qE9mFoAGqPYBNkz26huV9unL6CNYD4DkndSEg8hsp+UuQ683lUogrVKHXZg+mqA7iniIsDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hhWPgTtRw8HFH6N8rgW5HV+TT3s9L6Lbj53zgNmAjg=;
 b=r7saYjToR1PYcfSb/1fvVaYim/qrmiC9ZXgW7ZFNhTX9LobIbIWB0I3cKxTv00o4OL59Zz4BfueZvaiMkG/0pXp6bkHUoEQnV+OcPQlU9T8puwGHTpKmUI1ohGM4wxPhVv3UMe02qzqmMt0EMKaC2LRurgB7zrnbsbNgPkw1WEVtbZzUyectWaRUprJuIgLxavuM8hTUBpR4xkzHce170jy0s2PypH4KjHK+WbfozAYs4aEfJZ/zg+us/66jPBmXwSDRo0+ebFBaa8tz4omB/6rrkclk48KPEOQEtuI1vJ2Dp3oK5bqpKk4QeiLX2tmMS9S0zUSD5CGd5rsyRZAukA==
Received: from DS7PR03CA0091.namprd03.prod.outlook.com (2603:10b6:5:3b7::6) by
 PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Wed, 22 Jan
 2025 07:15:59 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::e0) by DS7PR03CA0091.outlook.office365.com
 (2603:10b6:5:3b7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 22 Jan 2025 07:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 07:15:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 Jan
 2025 23:15:43 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 Jan
 2025 23:15:42 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 21 Jan 2025 23:15:37 -0800
Date: Tue, 21 Jan 2025 23:15:36 -0800
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
Message-ID: <Z5CbGKYbwy+qPjyh@nvidia.com>
References: <Z4rVg1Xg5TCiFlSb@nvidia.com>
 <20250120181854.GQ5556@nvidia.com>
 <Z463eXfgNArCOfPn@nvidia.com>
 <20250121183611.GY5556@nvidia.com>
 <Z4/7pGx6F1mpAUuV@nvidia.com>
 <20250121200924.GZ5556@nvidia.com>
 <Z5ALWFVTOSC/8+ji@nvidia.com>
 <20250121211404.GB5556@nvidia.com>
 <Z5AUNVHzJPATVqAY@nvidia.com>
 <20250122002128.GC5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122002128.GC5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8b0ee0-f085-4118-ea67-08dd3ab49ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EtLlpyMoRLEagzYxjU/1QdeFtEMTYT+zwi+rP2qN4ke08Pn+qi+WJJ4mkT7w?=
 =?us-ascii?Q?HtrucRz+7+WJP7UphLm51AXmoKZShIfmSesyKD7N3wCoWFLE6xLkrlQb0zn7?=
 =?us-ascii?Q?zRpBGKqkHk00EPpufXl047t2jCNPxeRzSbC/Wd2/rlATZZDVHe4UaKMOKwME?=
 =?us-ascii?Q?Tjt7jvQV2Ps05P8OfBC+qqInSNmJWmtD7ayzgv0O6Y43ZFw83uDHIKv3FX8c?=
 =?us-ascii?Q?jNOnMowxiJmrA9OehCD13UTff/ihRA0W8odBcO2KgvRgUclTXwMzXV/St142?=
 =?us-ascii?Q?6frzHOSzC9AubyR0TN3LUllKR8x0q1y4JO/000HUBlkZGbthfgTljEPjrH9o?=
 =?us-ascii?Q?o3+K/TDl6W/xgr3Xuxal0twRHgWrHUWH3rsnJ+ik4YIbc7E6vA7wHqDrsPZe?=
 =?us-ascii?Q?xcChuruZ6un9hzGmFHTfU3o2TAXdvHUOpqiWdEXhPldygFDJRWp0SgYk/Bmo?=
 =?us-ascii?Q?Htx2kyDktf4tkYBVWwo5F3KbIGkH858SA8eJXqyjLM/K5OZSR63+uUnKr7hD?=
 =?us-ascii?Q?ylbAIFW6+QPWYRKupotYB2DW2nIo+dmW1++U9DMcnxCG/jLrRiuJzw6Lcdgg?=
 =?us-ascii?Q?RI0PjkvIGR8txkbgyZoA9gWUPllqkKFQ0mfQzbYPScSTq8cNAgvSNvtokUd2?=
 =?us-ascii?Q?EJz8M283itlorhSo0OP//8hdlo7iQYXntWRFNicLSKXrIcsXs08OKBsCBDp1?=
 =?us-ascii?Q?aOS4p41PWb6lHmEJKxtyWekKc0F3pLueHsRM5Bhky28ywjtiZevV788a+c5h?=
 =?us-ascii?Q?IpG+u3QYBletAn0gSam5V/X+KdvtxSuzLw/SPTmGQUL0kK+2TQkPDp3fwVA2?=
 =?us-ascii?Q?2dFWX3Rn0zH3bt+cJBzYYr/581pfOcHRCVPlJe2HAqfcSE6b9/oSXH2G6BPm?=
 =?us-ascii?Q?gqBNr64QCvoDHMEWwPICqv7z4idA+aamWsIK6DzW7SzBro+uzPJ4D3RHmc85?=
 =?us-ascii?Q?ovdxUsnKGT/rDDQFelKOthvIbXE20SSh9q6A77YZ0kZWS/mgc8T8Qy2a22Wc?=
 =?us-ascii?Q?/dl7ybMRrRm5f3qNF7YIAB8PV+DDcRGYpLhFUL3SGzjoV8ye7htGl1RpmHMt?=
 =?us-ascii?Q?jou1odJh+x+xfjAHRCmeMfErMNdElaef9NAvSNJk3eavv4iEjRWeyOpJJkhJ?=
 =?us-ascii?Q?IPrB16LJW8wJrFi0jP3gwoxap1HHlvBtRrtWN1DpaYm6ekilyxVcqOCgF49b?=
 =?us-ascii?Q?QLk1iXxJKVfJRo6H2G1xTNtVynVD0ta7Yn8BMtJqhe83Y+P7dk1OGWxkoRg9?=
 =?us-ascii?Q?J20YYP9hDJweEps/jVlfo1mxzS/CqducpPf2UXpp2+xV9csH1pQVwKz6DxYU?=
 =?us-ascii?Q?utuEv6wWLPWYrs+sBkYJzd45oQyJRT9fr8RX30vL807WfDneDqUOoYFldqhs?=
 =?us-ascii?Q?aNQCsdKEntPSHxmaO3tFMhcWl+/+X/EMBCIv/KFhun0dI/avjGpludW8LsT6?=
 =?us-ascii?Q?ubS5jF9PK8IuAYTZPn5lQ5y4bBdDDja66cILlElqnFy0tV6E4NBE7Ln3WaLE?=
 =?us-ascii?Q?Y2BdHMzFNPoAC2Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 07:15:58.8738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8b0ee0-f085-4118-ea67-08dd3ab49ece
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155

On Tue, Jan 21, 2025 at 08:21:28PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 21, 2025 at 01:40:05PM -0800, Nicolin Chen wrote:
> > > There is also the minor detail of what happens if the hypervisor HW
> > > queue overflows - I don't know the answer here. It is security
> > > concerning since the VM can spam DMA errors at high rate. :|
> > 
> > In my view, the hypervisor queue is the vHW queue for the VM, so
> > it should act like a HW, which means it's up to the guest kernel
> > driver that handles the high rate DMA errors..
> 
> I'm mainly wondering what happens if the single physical kernel
> event queue overflows because it is DOS'd by a VM and the hypervisor
> cannot drain it fast enough?
> 
> I haven't looked closely but is there some kind of rate limiting or
> otherwise to mitigate DOS attacks on the shared event queue from VMs?

SMMUv3 reads the event out of the physical kernel event queue,
and adds that to faultq or veventq or prints it out. So, it'd
not overflow because of DOS? And all other drivers should do
the same?

Thanks
Nicolin

