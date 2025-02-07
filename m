Return-Path: <linux-kselftest+bounces-26028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6080A2CC32
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5437A36C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B161C1A5B9C;
	Fri,  7 Feb 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKib/QBI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659B1A8F97;
	Fri,  7 Feb 2025 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954817; cv=fail; b=tjt9Hf5BnbJWoLJMM1/0oOMnxJS6mnslksCW1El3mlCA4T3nm6MddFgHP7192kBx2claGTgyV8q9mMnBCwd20P+7ADIbBvYfMwkBNr8p4rbJwR6cZ6kGWz1QfZJCLtHGOfPoMt1LUvOVaAo+oPsj+zCnRgT0z5AMWqXcNP1ByNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954817; c=relaxed/simple;
	bh=8BL0sG3lbCH5SacapsUvLQe23vdpT1GzGtOHV5/gCZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW1Wqq/jMU21LhrZ/MsundimlwHn38+NI0WHMN7X4jLEAUCd0UQAXcxdWxwXNsg/CcFpjxY3zL9IEbMmjWQSpMovpO2wB3mqatjASgxBmdy1bq1wjG2P2ZS6rFNfplJtnAhnONDudlOyDSqPU6dwmzYLkgSL7hsZ1k0T886xgb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CKib/QBI; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXsWVQGCnyADpPTALVVhE1j0NlxBRLrIMiKnKWmAFn9dSaJCZZ5vPAwH54rs9MX2Sk5cDRA6mIyPzNTtfoZRJY1E67BEcuk7OpZHqj8Nf6OpfhpDfToq1wjQRvFTB2SmPC64F2LAou5ES1tK+r7Bh816499Y46aCLvI9oqf2/X0/ExEFCKCUrJJOsDYU6t+9LXD2rOFnd+P9S9i5GuXz5bnak68rXzzBVmtGSNKUaZwrxB1GBEzykAcKhL/cdu6+sudzYu+Gwsw6SERE1c2B6w7Zear/q9SKwTY027ds9HrN8hs4gHFhSa0AoIdduX9rfLCYZ/spXjRWccK/hHkSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRaQCsf9iuofoR+rSp+ojThNdpIeXH8YDlf1WOqUSH4=;
 b=OjO0FqNn35NtNrFJDTWrAT5EjyLwf757ijXc+FAkbrsPdjDcbNtbj3YpUPoVQTj3MK6L+rbGuVmkS0YIIicjyg8EdA6t9cNjuXkLxHYnxcaJLTkr1HVkWSXSQOu0wl5czeoB2Xd4I/RxtRfE5ztqGDfhsObbv44Iz+ls1qUPSqsTCGgPqQHDMjB3QK8suAc/VcI16T4DIZScbFUIApkznfBQrdvZaJIObWIseZ8r3WKoS66bH430CxCTEgsb5yrkdSSsJE9HtjosfC4p34tlSzwmubB5RNX+oIFeKHw5a1/MK5lM2JzZf1ifT+NkY9ejiKkxVG0PQ8yX3W9+zLO9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRaQCsf9iuofoR+rSp+ojThNdpIeXH8YDlf1WOqUSH4=;
 b=CKib/QBI4cNFqKVb/FxUlfHbDJMKSdfhGf8X1csTeGqoZBCbOdUIr9NmfoTMY4b4DHWIfQmiRg5EA9RGquWX3ZXLOgZ3nmug6vQj5fUWCaZQSWU9ZWp2Y1k1tBmfIO+qKaMD9sqihn8Hp0IuribNbPVI0cwdzTte6FaMYXpNKmPcU0KAdBNNwo5dGNflKWNCKEu5R1vj4wsJg/32cy3lzDppI6EQIBjOtw6lQwk6mlOjoCYJc3SzevQaAYmMtOwnJUmdrQo8e0H7H5BB4ym9Nn36mdxYec7oVdWvUi60dX68R/JGr63YiJjiFjlzbpSeu2oFYrRIboE7S1ZU+XXDAg==
Received: from PH7P220CA0157.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::23)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 19:00:06 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::bd) by PH7P220CA0157.outlook.office365.com
 (2603:10b6:510:33b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Fri,
 7 Feb 2025 19:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 19:00:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Feb 2025
 10:59:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Feb 2025 10:59:51 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 7 Feb 2025 10:59:50 -0800
Date: Fri, 7 Feb 2025 10:59:48 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>, <alex.williamson@redhat.com>, <joro@8bytes.org>,
	<shuah@kernel.org>, <reinette.chatre@intel.com>, <yebin10@huawei.com>,
	<apatel@ventanamicro.com>, <shivamurthy.shastri@linutronix.de>,
	<bhelgaas@google.com>, <anna-maria@linutronix.de>, <yury.norov@gmail.com>,
	<nipun.gupta@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <ddutile@redhat.com>
Subject: Re: [PATCH RFCv2 09/13] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE
 ioctls
Message-ID: <Z6ZYJAjYTKGqEbxB@Asurada-Nvidia>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <d3cb1694e07be0e214dc44dcb2cb74f014606560.1736550979.git.nicolinc@nvidia.com>
 <0521187e-c511-4ab1-9ffa-be2be8eacd04@redhat.com>
 <20250129145800.GG5556@nvidia.com>
 <Z6WLXTiYVzuN368E@Asurada-Nvidia>
 <20250207143020.GR2960738@nvidia.com>
 <20250207152801.GV2960738@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207152801.GV2960738@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 930190c7-29b5-45a4-dc36-08dd47a9a1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IkEMTy6F/lVL1+bFrSzb3qVXhV1cZu6kUaBdwoDgNhG3njRUfiKisFvxRgo8?=
 =?us-ascii?Q?+T+k8VZcI5Kmjid3HEVCkHCMzMy6yxFkBWNhwyLNq9bQ20NvplrVryKqSarK?=
 =?us-ascii?Q?F2SVRNUrslK4FzliU8s08ccpeDpkUmb2zUpt/REj8DYkvMevV6dQkCEQmDj3?=
 =?us-ascii?Q?VWN+xZHufuN8H6M06h6byEqw7oAytpD1JssLKJyaqCxhRw6ymhHLt8BncgAO?=
 =?us-ascii?Q?wA6uf+zQcVx13iembr6D8fJKJGeGwPJJ1SpmgfWNa2ZY0ZguGgk6YIHocBZd?=
 =?us-ascii?Q?r+Wtjjv3KfQGP64RnsKru9GssDX/SQWoFK5nqc4lAYkKuHTL2xPfl8aztGnY?=
 =?us-ascii?Q?sxSn/wYy1GOFhdCRCAcEgXJfhNNzPxBfU3F3eWRwOC5bO8j2tnQb0ohLcaKq?=
 =?us-ascii?Q?hdJKfa1bMZbgJRTzxeqiYjTRaA10socSyTwgXw/XcnilCMu+YFgQY9bufkag?=
 =?us-ascii?Q?5jqs07OMIIrw1+4ALaC5ZOiecmtNYUrzHBz1s8YPGErCdDQvWNznfdl+3GCw?=
 =?us-ascii?Q?ek46QRCgw2msQHOMG09FGpiMvQJ6MU2Q7DSLqJytdwiGZg3KpjsxgLfdvUni?=
 =?us-ascii?Q?tLl99XoYu6ooO4hWV3id/y37rL7y/txykRFaOAEI8MNUjOE8eP1YIcQ9+lv7?=
 =?us-ascii?Q?ey2vuHF9KmeS/mefwph7DyNK9BP7R5iOnS+uVKnqCtETnC/C1kJkER0h1tvj?=
 =?us-ascii?Q?MO0MxwP2POmYvDAdQL2TA+RkV5sLrMAn3vjiZ96ZDzdj9n9BQ0MEkMwXE71a?=
 =?us-ascii?Q?3/AflYkpFtdWHkLHmg7ud/ulsvBDNfPfPeKf10oQHMUzFvIVZ1sAu67Ooi1w?=
 =?us-ascii?Q?o09PlHEoznBqpa7fIekIRbLFU+ptBH2IdUYw458p2V56Ul8iF7NYK34nhMYX?=
 =?us-ascii?Q?A++ovTtbW273AfrZXPrYgXDLf3FeEaAuNrSMj4v8SEIF7Z00k3oeUxqGRz0T?=
 =?us-ascii?Q?vAF1FLFmSkchOBNslpxz/7me7p5ok0zAjdk/iyRLCFkc5ils6cD0O+KkH73E?=
 =?us-ascii?Q?CIfa+KHmE/9l8luvLvv2UMEaRP5i37wlHbE7hbtYPofYY8hVF6dyj+nExRMF?=
 =?us-ascii?Q?02Na3n/TczH1CELLWu0SHQvB/lvmeORLsAk8M4dk1Rcm5RrTJOjHXFBbfTG0?=
 =?us-ascii?Q?Ct7oODHKCqVJHLUYzUEfruKCR8MLInNyZVAl4A4FiTnDeMHGXCj/Jnk9NKy8?=
 =?us-ascii?Q?gRSIo3LeE4oJWBUzt6/JXd5+CY9c+SpBdAc3a1/NpDF6umCZ1OhtBfdMFXga?=
 =?us-ascii?Q?898fu4BnsoqfifPaJheme/UTR8IbgYdB+VhKN/mY8qf6T2LssuJMvAkTdBme?=
 =?us-ascii?Q?RFlR+ZMyyHmUm4eKoWW2WQvi9PE//3IwUnad8yyTqHYKUXiVQcni2EEiiNxl?=
 =?us-ascii?Q?C82k5IR0Jb755Q0bpv/oMjPQhCk06UWnO5TcUmXDw0eTeWC91sZoRbrbf6Us?=
 =?us-ascii?Q?FJvTe6Kdev5wB2fylGGSccRHeMiPSmBP58bYJhjek0zfKOKyPZXlX0kWmUXq?=
 =?us-ascii?Q?szCF9flYUrKxVFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:00:04.7699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930190c7-29b5-45a4-dc36-08dd47a9a1f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217

On Fri, Feb 07, 2025 at 11:28:01AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 07, 2025 at 10:30:20AM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 06, 2025 at 08:26:05PM -0800, Nicolin Chen wrote:
> > > Yea, I found iopt_reserve_iova() is actually missed entirely...
> > > 
> > > While fixing this, I see a way to turn the OPTIONs back to per-
> > > idev, if you still prefer them to be per-idev(?). Then, we can
> > > check a given input in the set_option() against the device's
> > > reserved region list from the driver, prior to device attaching
> > > to any HWPT.
> > 
> > I didn't have a strong opinion, if the idev works without complexity
> > then I'd stick with that on the basis of narrower scope is usually
> > better.

We could forward the "SW_MSI_START" location or vITS's IPA into
each vSMMU module in the QEMU, then vSMMU module would initiate
SET_OPTION when an iommufd-enabled VFIO device attaching to it.

That's how I tested it. And this is one vITS in the VM, so we'd
only have one fixed location for all devices.

> If you make it per-idev then it is also implicitly per-GIC as well
> since each idev has exactly one GIC
> 
> This would make it useful as a way to get each ITS page mapped into a
> single fixed location.. 

Hmm, is it for the approach-2 (i.e. vITS solution)?

Do you mean a use case:
Multiple vITS pages <=> One pITS page?

> Really hard to use from the VMM though

I could imagine. The caller initiating a SET_OPTION call in VMM
will have to know what vITS page for what device. So, this info
has to go through the KVM/IRQ module to get processed and then
forwarded to the caller (vSMMU module at this moment)..

Thanks
Nicolin

