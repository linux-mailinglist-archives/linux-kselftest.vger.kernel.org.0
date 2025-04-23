Return-Path: <linux-kselftest+bounces-31382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D1FA9816D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 09:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323333ABBE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA70A1E3793;
	Wed, 23 Apr 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rkPMDIwq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338EC249E5;
	Wed, 23 Apr 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394342; cv=fail; b=QRfWMbI3JedpKWPAscF+qQFyVu9sYTH7Agl+fKphfjgbvSovt1GcGPeKCWanZiQE3LUMOZBDfNmYppW8XS+GjNX7whhUS0Ao+RK4p3VzUd+QiKf5B5mCv7BNoJcMGKJFLTsPpncwhiEZXPBF5NkiR8pCtYY2iFvMqkvTQjt9ZrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394342; c=relaxed/simple;
	bh=A4wQkUfk5wsgsbGyW+FiqJFt3RP5M8TAidGnLhTnm2U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jej/6HmV81Vveb7L7J0kcSBK1XB94VtMyiQnryG6u+ZyvUAnOHeMXSFyMTxTyzII8eA97TLJ1bE3RQ2uZFANfsTG4FrX9OE01rK5ZkY7MYCstnrigwPMKTnIq2LfHdMu5zHOvsixIHbn53pc1T+MA8iIh8JjwofwDWBTHKVw1xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rkPMDIwq; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcWRp57vlpMlePaDtLR/wmCAJ8vOZCxQ4Oq7IkdBOeWxnRpS+T4HLkNBazVU8mcVVND3MGKV+xWgVRL3xQ2FzqFwX5M0BCwmC31qN54bp5eoSa4APgYVVQV4kg5NmFZcQuKEmAXY13V9xJwXw58V7cf3QnRW/XNZI2s7RP5vg8A8OCvzMOTrLU1Jf/mFyyrgrbLCmQu8q+1iL1KyeVCmQI2fb1CBlllY3oyDgwi6wCzFrJhAQ3uskkQgdTJcQhylOy/DAvQfCEmmrSjOoc70PitnlAe/O0/bY2jwkhRPpf6pxr7KV9XO3Jgijh2Hs2h1gH9VunRnkpq6jecGPlOthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64RdGmRYqp/sSMpHw4BhOUZBLE4NLGggS7HwZ9PNQrg=;
 b=W1UNBOOnfG8ktjKeVkAb69WYCwiZcVfCod4Crs0anWuJLgtcZelPOLPggWo5C5YGYIxsrRJGbq+EV4Me53FNvCXdd8oYWw/1gUl3dTZ9YqKzYDBWycKBxyKTjdGYh+6KBuoOeYRpyliz9ezuoPdu5DSrNtVxHa7SIxNq75hqomGvFhXGPTGrbTw0w4D2hy+WKo7j6t9IuyGZ57+daWPEUcSCknvYVbPmvZ317wbk2stS5iyLHoH0EbnCqDTH9pb8kVH2mZyqUzKpudOj3VUCjrMrRlDD8RWLDOv+2ZCK8GniJ5N/utZsRJXr9niOBFzHFzEYUQ8XSaycK9hbGU/Lmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64RdGmRYqp/sSMpHw4BhOUZBLE4NLGggS7HwZ9PNQrg=;
 b=rkPMDIwqbQY08ICHSECRkeWhLnP8GfXEwQ7Bm0E6MIaXV5IoWmAj7+DgUZpYE/8j6PXr1TVGVHDAbu1A55oQCGajWfbSO8Ujt/8PuOTuZ1Asit7PklSVlowfSM6QBs9OeZZ4sWeCgnB/vlnzGK6VBrcqblLMqScoQpc1drhhthhUwQKosKo3Xg94I10zhPq2kXEDcd8OLPz3d/bjc1ixCf4gQ9mr/rPN7F471RmJxJ9HOVVsDZPyPrYYsoW5oPQi0KRCBdSKw6CHE3ojbuKsZSmT9KD5k7+RJjHZ3YAELtkq9WQsrnMkHNo8nFHHphbApp7w13nn1VKUgSH6gnoPhg==
Received: from BL1PR13CA0160.namprd13.prod.outlook.com (2603:10b6:208:2bd::15)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 07:45:36 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::3) by BL1PR13CA0160.outlook.office365.com
 (2603:10b6:208:2bd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Wed,
 23 Apr 2025 07:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 07:45:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 00:45:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 00:45:18 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Apr 2025 00:45:16 -0700
Date: Wed, 23 Apr 2025 00:45:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <praan@google.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <jsnitsel@redhat.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v1 00/16] iommufd: Add vIOMMU infrastructure (Part-4
 vCMDQ)
Message-ID: <aAiaiomYczA22xik@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <a0c248f0-71ff-4477-98ec-1bbd52eda566@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a0c248f0-71ff-4477-98ec-1bbd52eda566@amd.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e077c5-227a-4d3c-eacb-08dd823ad5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ptrrVyCrjwBxyOQgE3gVxguJHyGHuJObClihX3QFBca7TAjHnd8GRLtiCfHF?=
 =?us-ascii?Q?SLCMxNfk3JxnnKydWk8ICZK3vFEXhL5riYj8EpJkXC2BesKrAbm2AHhnbr6C?=
 =?us-ascii?Q?2FqjEyO+3SMq0EjfXpfOtGsGVVzyAjfeuT3P9OB15bBKeoeOfFxnESEJGM4W?=
 =?us-ascii?Q?1Z+PSc9Bm2oHJVn29Y5Vy2JL0Dhuo9Dfk9fQr9v77uCDB4yPFaWZdcoj0Rpk?=
 =?us-ascii?Q?L3ZtlgxCbc3o5En+4Cq7vFKWSF/KgRa2rE5/SAkWyUvK5srbaukpTj47mZKL?=
 =?us-ascii?Q?B3LGdO8kk8JbCjBY33LDXxJiu9DJiiwUo3+rTpxF384XitDjv2plKUwYIxXR?=
 =?us-ascii?Q?/WM9/Iir0LKwb/uWUUr/MCsErSJRCZJL6TqI7UDv5E8ouKRZu83vpn0kpFKz?=
 =?us-ascii?Q?yvtoe2hrIxS4GJH3PtlAeBGUkA4pFzkB/3N2pXrrUI2P3u24I+pHCQzmzK9M?=
 =?us-ascii?Q?OKpLhUXrwaivy1J5Ka/wW9o+AWEEq0az05EI+X/B+2w5FxJoS+s+trkMSARK?=
 =?us-ascii?Q?5pC4MbrG93KJFD1yR6sPZ1LbEE9u1hmJ3djEzW1Acbtnall1lGY4grtRbQUo?=
 =?us-ascii?Q?OiFdvlbTXWVtbqMWGSMt9TesWV4wfM9SuJrvLu6kXWzZ3ECRO+EBfcJ0g/VF?=
 =?us-ascii?Q?b4LibpvV+L+89QZj8R4YdqzaqGggZ6cSXAFDl4/bwsnZDKz3PGbyMOODTIqn?=
 =?us-ascii?Q?hVLCtyAglxVU3KBb4AqaBCn8tUSi8ICUkUKL2NhR3veN9ll/p3fQ+M/tZpgx?=
 =?us-ascii?Q?OIoPUAnj+xZZCakH9Cdtc1Cqfz5xyxMCakgOiaVN+IPj74keH0+1tmodfI9C?=
 =?us-ascii?Q?o1+U8LHoA147mnq9p7tkt6elGiYAj34+UYn/crWDdsN8MkVmrO2/FmMSAX6Z?=
 =?us-ascii?Q?YQw+S1VF1XdJKIE2qpYovxwgXdPLNbX+R7M/04T0n1+NZ1avq8FO8T/BfEnv?=
 =?us-ascii?Q?s0VnBzd4s7NG3IKIEYNJjnCsMs4GH9ylWlJpK+McPzOyo6XXa3c4WLAr58n/?=
 =?us-ascii?Q?Zyu7olkQ/nxfe4RnhepugXFq9qugkX5vmi812fBR7O/iNXqRorFAIYifrvJy?=
 =?us-ascii?Q?SLRMErL2SAFK1n5jjVQLX7ydQrierS64iO+o2am7PHNhGfPm2OPy+js9/m2I?=
 =?us-ascii?Q?htENRTfWZgYlmYXoIL1zyIpgl+DrE0QHRGsovsXXP4Du0BsslzLYHt1IZ17G?=
 =?us-ascii?Q?n22yuNM4cNL8jjT2VNq5hcVeA05xGvh2meLPGH4VeKDcFYqqg0d6ry8MHn4P?=
 =?us-ascii?Q?JnC9kDc0wAHlkVqq3qo8z7P4ChfD1PrKn9dYMkWbnmjc6YduN4OUmpH1P9ww?=
 =?us-ascii?Q?nZMbqWTwinilyH4Edc/doJioOoHGs5a8x3OYHq5OguGGw8tGZKIphsypxzX6?=
 =?us-ascii?Q?dH5D3cq53sqqKXyHRjDXX1aY8AmBT/dPm49VMGqSPThDmeVkM31npDeG1q9I?=
 =?us-ascii?Q?tXqZCw2oxO8Fl0nzbDlssSTF/DQU0VWMFcq1jaQN+NshQfHUwt0a2kAyfFow?=
 =?us-ascii?Q?s39sAT2CVNCEgqWmwZOWbnYcD6FOAKs1eRMu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 07:45:36.4526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e077c5-227a-4d3c-eacb-08dd823ad5ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

On Wed, Apr 23, 2025 at 12:58:19PM +0530, Vasant Hegde wrote:
> On 4/11/2025 12:07 PM, Nicolin Chen wrote:
> > The vIOMMU object is designed to represent a slice of an IOMMU HW for its
> > virtualization features shared with or passed to user space (a VM mostly)
> > in a way of HW acceleration. This extended the HWPT-based design for more
> > advanced virtualization feature.
> > 
> > A vCMDQ introduced by this series as a part of the vIOMMU infrastructure
> > represents a HW supported queue/buffer for VM to use exclusively, e.g.
> >   - NVIDIA's virtual command queue
> >   - AMD vIOMMU's command buffer
> 
> I assume we can pass multiple buffer details (like GPA, size) from guest to
> hypervisor. Is that correct understanding?

Yes. The NVIDIA model passes through a Virtual-Interface to a VM,
and the VM can allocate and map multiple command queues (buffers)
to the V-Interface, by providing each command queue info in:

+struct iommu_vcmdq_tegra241_cmdqv {
+	__u32 vcmdq_id;
+	__u32 vcmdq_log2size;		// size
+	__aligned_u64 vcmdq_base;	// GPA
 };

Thanks
Nicolin

