Return-Path: <linux-kselftest+bounces-24900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C268FA18765
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 22:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0298E169F56
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 21:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6A31F78E8;
	Tue, 21 Jan 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qo3xCr82"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BF1B6D15;
	Tue, 21 Jan 2025 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495633; cv=fail; b=FjsOq0K8zvXvXWekxbTrUerOolEO2saqJXnRecTVXxIE0Yz1USWpv+bJqQKRsVRB9PsAMgTzXEGacvsOAKXke2u/x19rHyHBzecLAv4BqeYMXDYr24EVpSWq/W7tOuWroVwp478M1kxjgj1ysmcwXzmvdUTArsaoEHFLCxx35ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495633; c=relaxed/simple;
	bh=atJRXw5jAP8vbwDl++2ytvu82FW6pVXzb+TTT35Pdfs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCiL7Aq84DdHYeiJry1SPFDUyejGWdmMru/+yDQKk0t6iuRlrMZowMGFzZjFFdlpiTz+KvaSHQZgxspYRtWgjLVRyRDwSfIZdzhV9nvo+zbiWhkXQxv86U/87tyZtHw9MX8B653s0lT9/u95c9U6T8wa1mi9rYukNQx55EUGnRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qo3xCr82; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaBIe2h/ZJOaL9YFUP0hNdHSu4mFh6zB/BxhkXh8Uh/20x7F2SqQwd0vqNV10xaDHRPhUuA5SIDXgwPyUYwNq/oAgBAFPbCEZlpocZi9G2WR8sVLsJAc0Sl/UyaVZo0t2VVG1o2e/gYTbZ+G6l0PLMn/FsvdKWyN1QU5q/emsIknKXylB7napcXwAqxXA03lXwH5PDOj3ez5lFQUwb5/dkseF4OPS1BTekVKYP848/6WLNFpPRrU3vC6RsPmSQkR370zbhG3epEq+UA8CZLik/Pw1YOZra+4386c1a64dil9DYSr2yJMKj0guAUpnomEAgHxpBtRA27pYJGz8LATcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMwG0sh/wA7ZgwQU5ZTEd6lBJgpXmevxARM6TyhJrZo=;
 b=quS+VcrNCJFX+pcM9N6ILiLpPKFBK6NUwdJNWwkjJjR9Tb7YzeT2Amz8vzdREinkFr4f9fSPE+PyAfW1A5C/D3re97u8uDzLQrj3ZL5vUSnGrNNaBkADcYzavzUXhorGzTwn1V6KECGfsHHPizZoYbZK2g81JlRneG3N0gf6hGtHxITrLSodVmXt2KaFfieD6YzdCUmeCW2qKyxMiId8q6anDEqsgfFvafTN2CjbfGWgAi9n219EDHcWxrkgipjoGFqsfIE/5asAjsIlybHKy30Bv0GCmjTYklGGtMUe8Zphu757qMZX3V5KWnESe3bebsHoP4ZSjgdGDFAHSNYlcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMwG0sh/wA7ZgwQU5ZTEd6lBJgpXmevxARM6TyhJrZo=;
 b=Qo3xCr82J+JAoPlCJ6UUlvfZXl3cCtTFfyelBWKrXLT1jAEIaymF7w2J4kcVwOEaqF23Z81DnQecsndjjz6+wzQHdx1fDJiCCry+7rvTibG0/w6uanAXXJ6W/59DP/z67Pn1wE62yFuuwHNBkaY9SH9ffl2WW/8pwyqUqT/cWBA9773bpLJ4XEibVtJXxYCx2Rs9I5CiBJwDtDzcodAgix0o0p4mU8E+fCu+of/2BXfBA3k8m7xaE0qHj4ScMwGVrmLdJ5NO8o3MAsWuwXzTYd7aGlIX6m5VWKbi3a4Pjfx51uxHJzLTWHuqrqqzartFpjwDGmB5hmaU2Q82SPaIbQ==
Received: from CH2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:610:4f::15)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 21:40:27 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::5) by CH2PR18CA0005.outlook.office365.com
 (2603:10b6:610:4f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Tue,
 21 Jan 2025 21:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 21:40:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 Jan
 2025 13:40:12 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 Jan
 2025 13:40:11 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 21 Jan 2025 13:40:07 -0800
Date: Tue, 21 Jan 2025 13:40:05 -0800
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
Message-ID: <Z5AUNVHzJPATVqAY@nvidia.com>
References: <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
 <20250114134158.GC5556@nvidia.com>
 <Z4rVg1Xg5TCiFlSb@nvidia.com>
 <20250120181854.GQ5556@nvidia.com>
 <Z463eXfgNArCOfPn@nvidia.com>
 <20250121183611.GY5556@nvidia.com>
 <Z4/7pGx6F1mpAUuV@nvidia.com>
 <20250121200924.GZ5556@nvidia.com>
 <Z5ALWFVTOSC/8+ji@nvidia.com>
 <20250121211404.GB5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250121211404.GB5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: a92b63f8-6c4a-4f2b-cc3b-08dd3a643885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+/hZllBAp/xJtgAeI0vo7XVCE8LvF7j6/+Y72RXiZTDcgq5IXurMmj29trfD?=
 =?us-ascii?Q?oymnVv9jRPTVOjAnEeB7TA3Zh1Rw9a2MLCxzJFcKyL4skcyh+AdAFCoDreNj?=
 =?us-ascii?Q?O8NHEDsXEFE3UdxOuaCcMu2SxdiRBn3qC6vaHqdcJub9yDXqvByLgnkrO/ES?=
 =?us-ascii?Q?QKnJHUgUj2ZqML6egMPhFDrr5KqD6aVm7UTu9jT7gxZyO91H+8Tp0eN+JxvI?=
 =?us-ascii?Q?7Cnhxh82JjVebWnfd0havCY1QFQj1xtXiQ92IuRR9j+QNun98TZZSX2j2tFT?=
 =?us-ascii?Q?L7/1+2RL9X5wGacULLJyyItkWWyapdord1DkYVvE4XGt1MnK6np9Kmcjtf3/?=
 =?us-ascii?Q?k1iXGi4WlRVMq/zUO20eyrzUQQ+crhuRSz8BN0TqSPUK0DA6azeJUDEkrGlM?=
 =?us-ascii?Q?RuX443qOpLy0IeXe6NrN+pnsCu8CUmGQXQ0Mv+MkXNy38a+rPljuBTp/7CPd?=
 =?us-ascii?Q?R0Xwyc8BxeZpfSgR91OI5+my5XqR9dqXtIsIESqZwWvnMVSO02VNkne0DO/v?=
 =?us-ascii?Q?in8j4gEBlYIC5qEfApgYUB2cIieIlYDuzYLtNpMIU/OVIcwxBTYH9vDF5Dy+?=
 =?us-ascii?Q?V5sUQ/SXK8NvIafelmGCGkMmR+uE42HmOtaWnn2EYM6RyZ137QXfRoOc1sqt?=
 =?us-ascii?Q?LAdMwsPXClKxlBJJ1wXFLIRXRFhaALs5I61XpXm4h8xDB0tlSRVoveeVfC4G?=
 =?us-ascii?Q?EnR/gxoAVawJItpYUuw8hjExdO/c5rGyGR0IymcAATBPw1lATn7mMZppY/KI?=
 =?us-ascii?Q?Yi7EaflnF8GwNm1vkP9upVFiphIduHdMBzC48PIjkz+r/9yihYlfIzrNxXBy?=
 =?us-ascii?Q?jUZItPH9Dzb8FEe1gNudP+CV+BxVl7Y6PSjzd2+dLwGSsNdC6vzBunYoWrk8?=
 =?us-ascii?Q?cWJvEM26wH0y4+mNwW1QQmZidBD0A/LdsABI8YZAow7AJkyvjCpC4ETeU3Zg?=
 =?us-ascii?Q?8HdUlZrVn0AhcKjUsOx6RqjBf30q32CAgUVqdBY0LdOlAS34h6NmsGuckD52?=
 =?us-ascii?Q?7019GATne4xvYLO6vMgIcVLFHwOg87pLIbQA7zk0S3X7JBCgZRYoX03HJrF5?=
 =?us-ascii?Q?Sn/uUH+y/TH+PFbh/bB2CSkxAXSmtR5CitnZXlabCnegdOx/f4WI2Y7FN4GR?=
 =?us-ascii?Q?aJO8zYUTP5fG/8eLEG7MMIcJYWNDqCCeLmxu6iU0ixCuTh6cAmHcrAJCBoB2?=
 =?us-ascii?Q?AHLnbx+up2VH8MDB2o6xNYJQWX/uviSwSOOC9XsUXobd92hrWZj1bJTKEiQc?=
 =?us-ascii?Q?opjcAXITEBSfm+OVMHhiKqygMwsONwYZozkaSzZnYCGP15t84r4LUihRBkBz?=
 =?us-ascii?Q?sFZKe3DEjkN+Gldzr9rmrzWd7djbNj3XH/YQ9gMSKNVpEnIULMIHhlokUiWK?=
 =?us-ascii?Q?Lw9rO19f52/JMF/PVHh8v6JV9sGwJOt+tM+LHONGOUKbsbOKdEipR+mGJ01G?=
 =?us-ascii?Q?CzSG9To1vBRsCGHy5NJFTlAObeGdv9b/1hX/ARwKNSxNLTiafIh0xLjcNwtk?=
 =?us-ascii?Q?CsdlNefMwr1Lav0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 21:40:27.4193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92b63f8-6c4a-4f2b-cc3b-08dd3a643885
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

On Tue, Jan 21, 2025 at 05:14:04PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 21, 2025 at 01:02:16PM -0800, Nicolin Chen wrote:
> > On Tue, Jan 21, 2025 at 04:09:24PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Jan 21, 2025 at 11:55:16AM -0800, Nicolin Chen wrote:
> > > > > > > IOMMU_VEVENTQ_STATE_OVERFLOW with a 0 length event is seen if events
> > > > > > > have been lost and no subsequent events are present. It exists to
> > > > > > > ensure timely delivery of the overflow event to userspace. counter
> > > > > > > will be the sequence number of the next successful event.
> > > > > > 
> > > > > > So userspace should first read the header to decide whether or not
> > > > > > to read a vEVENT. If header is overflows, it should skip the vEVENT
> > > > > > struct and read the next header?
> > > > > 
> > > > > Yes, but there won't be a next header. overflow would always be the
> > > > > last thing in a read() response. If there is another event then
> > > > > overflow is indicated by non-monotonic count.
> > > > 
> > > > I am not 100% sure why "overflow would always be the last thing
> > > > in a read() response". I thought that kernel should immediately
> > > > report an overflow to user space when the vEVENTQ is overflowed.
> > > 
> > > As below, if you observe overflow then it was at the end of the kernel
> > > queue and there is no further events after it. So it should always end
> > > up last.
> > > 
> > > Perhaps we could enforce this directly in the kernel's read by making
> > > it the only, first and last, response to read.
> > 
> > Hmm, since the overflow node is the last node in the list, isn't
> > it already an enforcement it's the only/first/last node to read?
> > (Assuming we choose to delete the overflow node from the list if
> >  new event can be inserted.)
> 
> Since we don't hold the spinlock the whole time there is a race where
> we could pull the overflow off and then another entry could be pushed
> while we do the copy_to_user.

I see. I'll be careful around that. I can imagine that one tricky
thing can be to restore the overflow node back to the list when a
copy_to_user fails..

> > > > Yet, thinking about this once again: user space actually has its
> > > > own queue. There's probably no point in letting it know about an
> > > > overflow immediately when the kernel vEVENTQ overflows until its
> > > > own user queue overflows after it reads the entire vEVENTQ so it
> > > > can trigger a vHW event/irq to the VM?
> > > 
> > > The kernel has no idea what userspace is doing, the kernel's job
> > > should be to ensure timely delivery of all events, if an event is lost
> > > it should ensure timely delivery of the lost event notification. There
> > > is little else it can do.
> > 
> > Yet, "timely" means still having an entire-queue-size-long delay
> > since the overflow node is at the end of the queue, right?
> 
> Yes, but also in this case the vIOMMU isn't experiancing an overflow
> so it doesn't need to know about it. 
> 
> The main point here is if we somehow loose an event the vIOMMU driver
> may need to do something to recover from the lost event. It doesn't
> become relavent until the lost event is present in the virtual HW
> queue.

Ack.

> There is also the minor detail of what happens if the hypervisor HW
> queue overflows - I don't know the answer here. It is security
> concerning since the VM can spam DMA errors at high rate. :|

In my view, the hypervisor queue is the vHW queue for the VM, so
it should act like a HW, which means it's up to the guest kernel
driver that handles the high rate DMA errors..

The entire thing is complicated since we have a double buffer: a
kernel queue and a hypervisor queue. I am not very sure if both 
queues should have the same depth or perhaps the kernel one might
have a slightly bigger size to buffer the hypervisor one. If only
kernel could directly add events to the hypervisor queue and also
set the overflow flag in the hypervisor..

Thanks
Nicolin

