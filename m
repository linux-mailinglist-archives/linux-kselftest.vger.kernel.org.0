Return-Path: <linux-kselftest+bounces-24403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6BA0C1C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7A16B7B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348901C9B62;
	Mon, 13 Jan 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UsFv//2q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1A1BD9F9;
	Mon, 13 Jan 2025 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797693; cv=fail; b=W70cym4RhbKa0DeT/habCJrcErm6RJhasSg0yAiBwtMR+og8G/zpVqwebf8cB4UlvMaurjfdOweTqd6uue4RGSJiHMahSibjZf0nGIGHu1LHPK2autkawO3PwmnQV46OYqPqJll6Mjs2ATgYo7rk3caUpjy59LYnWP8jdy4jruw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797693; c=relaxed/simple;
	bh=/ir0sVD3seLiPvBr43wFeTxeC8e6nGuTJCbnpC7PSKA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/yEyxfiz4AEPuQo8+zhekDAGU12VNs/hi5geD1Ye3OWVHaoTAWKPgmrhvMpQJK328tpPED+VC1fKyDv7+OY09htJ5RLaBFr9eEEuk1j3F0AVk0DTVaW0kQ/SQQ6DbxUuRmLAClwdyOwzaAoduikbsniwmm7zMpB80wQwFEb0K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UsFv//2q; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rViPTrz5ZoqSY3oozGFowGl1F8jE4Ka10wBffzRYgKl0cIe4yO+OAEkwlkbh2vYIjkZbomYvPciznuCb3T2CJwldYJ+OhAfIVUFNpzyCN1WYfsYTgjXiJBavBYBzrPjs4lgGWXwEa3NHOShO8Kkx4Q664rbt3/E6puLBxho9MowRU7zuhVzkxyjUdm4qoOfCgOOvNuTyTkyVtDeSGYWsBnQcEx4ZExiMPtljwc1L+ef1a1cGQNen75kat9tHYAyCU5QVUhb/OOAQH42I0scHgUpeNJJFdnLUff6FoXpjUBcpGa6gt0Bcq+4gIJOFMbzR0UBgBvaPbfoYteilMl6IYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hwt7foqPGbr8kdHPd5ocJGr4Mx/PTPZZTqQyE6Xian0=;
 b=FBxnRb0WImumn+WWpo3m3YaXEiAxuE6Mtn1aGTiJOzxy093awUoMQ6qWcnA6pFGE3VlauFh5wcKdu6Kidp+VrjgqWnbuET2R7eXPf2yIjMIOtXHtzIqnja1t3kwQD890DILbQcloT8r+nr1cDyzYojFqQN+Cx79VjCZ9oZMjPec2CLSCcGHS8+cxj2BngsFmepaPzpuDopEl7Gg6ssThWkgkVTQ3iscenhTxeGi2HWVzyq9057A7Gn+1z2YwuM35DQXG5ddR04TurPZYTP0gSa8eA5cU11yQg1DtUxI+mZmZd2/aZw/qq9VIfk0/B0YfLYGNQPH3sg1mifFP3LXZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hwt7foqPGbr8kdHPd5ocJGr4Mx/PTPZZTqQyE6Xian0=;
 b=UsFv//2qc5EZllUrRf8kGo0GSjJRG4BF6hQGVaQ/UVWO1z/TyYxmkbT/6Rqtz45Jvrwe3YECU0232cydCSSbw67QX2CG/JmuqVwM+lCzCHGHoFq7Vq0j8k9nTI4tFVk7XdfmXUwY5jN+C5p04C25x0hWnkJ9r3QhKPctdbAz4BxwY/BPlZlN3iLvEUVc+HQmwRNRX6PAuoL9uMXbAUgcQWKyjtSmib9uIlhD1ydscCfyYlq6hN5FURkY6NtltNQ+TAD7NuEAhi4btbsK6oycE6ePadWY2lh+gB2r2lFYzQGtcQmUTbNhNZwZ21RFdY1XYvGRfhiNXTNOAVrVD8UwPg==
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 19:48:05 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4b) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 19:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 19:48:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 11:47:55 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 11:47:54 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 13 Jan 2025 11:47:53 -0800
Date: Mon, 13 Jan 2025 11:47:52 -0800
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
Message-ID: <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
 <20250110174132.GH396083@nvidia.com>
 <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
 <20250110195114.GJ5556@nvidia.com>
 <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
 <20250113192144.GT5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113192144.GT5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 35320ea1-0dce-4161-3de2-08dd340b3259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AcAsj7t9A4LDREi+gXwIE0IxFVCzBBpkzSx6TYpPfG7QqXBJ+On7PTTA+vMl?=
 =?us-ascii?Q?clflmFRkajj0pIn1xp5uVZnPdeFFSExg/7eEjuaIAJtBIitCJpZ9QvAsjads?=
 =?us-ascii?Q?miv4WTNGXL1CnK+C0ZkZjWzrPU99MUVB+YdRw8K2AX6bnVKyc6evZiMTLR3w?=
 =?us-ascii?Q?0+2aU+wRiUPqHNL4x4l1lGxQG92mNbrzqZznWUadawJjwQS92RTiiWh0epyw?=
 =?us-ascii?Q?wDhEhDzB/hJunBDOeEUAbnyeUtg+NJs/sKNnkDycsDfEjCt4fP0b357g2fk7?=
 =?us-ascii?Q?3RejppS7Kk+zbQv/HRG0iomD2ACfCmDpKqXKLMwoNXB98v2LSyzxwrLhaqSs?=
 =?us-ascii?Q?/2K4reJW9evyQ7zcQtD+MokiyR6s1QxsqF9O+YshOb8DiFnn72cuF2NLzi9m?=
 =?us-ascii?Q?cMts/zixjQUKInbwvvQfTh81HlfnNyl+ygv4nQWXXCj55YttUczGEk7+RzdJ?=
 =?us-ascii?Q?mSCe07nwTiWPrTN8WiIZ7ZScSJ+Yj5mpG3uhsELw3HuYowjcGXZhFXz0TyIL?=
 =?us-ascii?Q?4E+WWKD3f/WrX+EH/1XEfFuAW6M1+W2DmIM4koMx+uYiSJvapApRi2lPEDsJ?=
 =?us-ascii?Q?dobuNQwXXrQLu6PJz8FFuIDGGGie5J4zxU9KCDeUgX8zzTkhoTZTzV3diA2Y?=
 =?us-ascii?Q?pYcZZctgwJK6EawI4Du0HYbo5qREtHAW8YDsKpirQrzgvu8gYxvVNCAJz8Ca?=
 =?us-ascii?Q?w6vmG4ceQNPsZU0si6m4DVX1zualqhI9DNTPbgGaJpRATdJ2lsaZTF4/WCsU?=
 =?us-ascii?Q?PlFV/h3Wbx1VMy0XdOiPuOPL3HDLlZFYn95XFXQX3q/5Tc80ezL13mwXAIAp?=
 =?us-ascii?Q?OyOB0RTGD4gaYLSQcUAQCinU1IQfFNOv2yLgcj0pGLfm/Uxa/p29KDH2dDM+?=
 =?us-ascii?Q?5Io7Kglly85KQIgBsMD/LM9sbXjW9abX8x1PkTuUafZkSU7tWuFG6+TRQCnb?=
 =?us-ascii?Q?n7wfJQ5nPsTRdTv5qBQkO4OYQ7uCFzbWnLZ4dXbMq3CElRo5oHLRpO4U+yPp?=
 =?us-ascii?Q?trSBUV/dpyMKXjKhlHvpaHw3mFaFvOTsoGPSTUYGGN8hNIUrvucX3wW70mB2?=
 =?us-ascii?Q?692qV47uUmCuOLeCzPD9QZGbLC74hMwjII4zWKB2FtUuviU1lRG92Iwt6fFu?=
 =?us-ascii?Q?l9mBWnU0yovz3p0y1r8Zj58T7Q3aVCyluEWMPvw0zizFrjMZKZ8Nv+Edhd7c?=
 =?us-ascii?Q?skgOJHsNAFQEo+53v3b3fFU0lXAiGxidsQg23HPWLcVgsuCvkkFdHon6yfn8?=
 =?us-ascii?Q?Z8aaOH3TeI/5Hq5Ym/ts0sJeahoBpJUr+v6X1/6DDfwxx65wfFaxxDumUYC2?=
 =?us-ascii?Q?omsW0lusueyQ3qLqc1xok+EHdvQ8exuRAM8cAW8jxgtpi06i7jy+PAKknbik?=
 =?us-ascii?Q?1hmx7RA6f+hGMfGSONuODDMsjc5ys461hPURskhz7Xpbg6YnY4nIr0bFVVrm?=
 =?us-ascii?Q?vEtS+RtQ7gPBe/xMogfpJoGP3cFVJ28XGd3HnomGsiNg2lDANGYk4SqjpYno?=
 =?us-ascii?Q?AN7WMQQ2HPhB3N0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:48:04.9847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35320ea1-0dce-4161-3de2-08dd340b3259
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129

On Mon, Jan 13, 2025 at 03:21:44PM -0400, Jason Gunthorpe wrote:
> On Sun, Jan 12, 2025 at 09:37:41PM -0800, Nicolin Chen wrote:
> 
> > > > > I supposed we will need a way to indicate lost events to userspace on
> > > > > top of this?
> > > > 
> > > > Perhaps another u32 flag in the arm_smmuv3_vevent struct to report
> > > > an overflow. That said, what userspace/VMM will need to do with it?
> > > 
> > > Trigger the above code in the VM somehow?
> > 
> > I found two ways of forwarding an overflow flag:
> > 
> > 1. Return -EOVERFLOW to read(). But it cannot return the read bytes
> > any more:
> 
> You could not return any bytes, it would have to be 0 bytes read, ie
> immediately return EOVERFLOW and do nothing else.
> 
> Returning EOVERFLOW from read would have to also clear the overflow
> indicator.

OK. That means user space should read again for actual events in the
queue, after getting the first EOVERFLOW.

One concern is, if the report() keeps producing events to the queue,
it will always set the EOVERFLOW flag, then user space won't have a
chance to read the events out until the last report(). Wondering if
this would make sense, as I see SMMU driver's arm_smmu_evtq_thread()
reporting an OVERFLOW while allowing SW to continue reading the evtq.

> The other approach would be to add a sequence number to each event and
> let userspace detect the non-montonicity. It would require adding a
> header to the native ARM evt.

Yea, I thought about that. The tricky thing is that the header will
be a core-level header pairing with a driver-level vEVENTQ type and
can never change its length, though we can define a 64-bit flag that
can reserve the other 63 bits for future use?

That being asked, this seems to be a better approach as user space
can get the overflow flag while doing the read() that can potentially
clear the overflow flag too, v.s. blocked until the last report().

> > 2. Return EPOLLERR via pollfd.revents. But it cannot use POLLERR
> > for other errors any more:
> > --------------------------------------------------
> > @@ -420,2 +421,4 @@ static __poll_t iommufd_eventq_fops_poll(struct file *filep,
> >         poll_wait(filep, &eventq->wait_queue, wait);
> > +       if (test_bit(IOMMUFD_VEVENTQ_ERROR_OVERFLOW, veventq->errors))
> > +               return EPOLLERR;
> >         mutex_lock(&eventq->mutex);
> 
> But then how do you clear the error? I've only seen POLLERR used for
> fatal conditions so there is no recovery, it is permanent.

Overflow means the queue has tons of events for user space to read(),
so user space should read() to clear the error.

I found this piece in eventfd manual, so was wondering if we can resue:
https://man7.org/linux/man-pages/man2/eventfd.2.html
              ?  If an overflow of the counter value was detected, then
                 select(2) indicates the file descriptor as being both
                 readable and writable, and poll(2) returns a POLLERR
                 event.  As noted above, write(2) can never overflow the
                 counter.  However an overflow can occur if 2^64 eventfd
                 "signal posts" were performed by the KAIO subsystem
                 (theoretically possible, but practically unlikely).  If
                 an overflow has occurred, then read(2) will return that
                 maximum uint64_t value (i.e., 0xffffffffffffffff).

Thanks
Nicolin

