Return-Path: <linux-kselftest+bounces-26892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13684A3A58A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C84A1746CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7D52356C1;
	Tue, 18 Feb 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rplUdt2n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC02356B5;
	Tue, 18 Feb 2025 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903307; cv=fail; b=MSdUBEAjHQe1XEfyF1s9OuteaH6VFgcQQixYfVPc/bG/21c/RlwvyOb/feuDymaAVp0pmQnPfgrQL/6UJOKqDrqdY9hcpYFZxuQ4VzS9Ph5v+hBUtgj9jXOJaJZkyB0mm/e/+rrXfNRux9BVtJ7cWDcphCqpf9yh7BTZxoU+yaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903307; c=relaxed/simple;
	bh=2BrPplgt+/0SQT73Wv4UYeQtHXHMK1Yre7EM+DoDSQA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiY7PPMyzkqwK4utmkpeW6/TwNX7GnbHTq39n19ZG0T+O0ojLcgY35zz5QmwQiAwOZm4jWRglMXnD9m/qTvGAK+A3iykqQepHGQhJfC3IXQ09agoCbEG2QHBtUnxfRxTRU1I1hd1hHliz93UWksZNvjRm1UZvcTxKBfsBoy0FPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rplUdt2n; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gggpx2t2SYrhpGtGhsm1FskDrsjvJJiqhPwN+FPzWxk4/3bViylbDhnrKJvhpPzGGhSkaXC2vZZQz4b+/UdmmMBPaInDnabLcu02euTzEk2bLkOY/tuKvllH+3uEkQCdc6qvHbqqjbUfBXu/09xH8OzbQ3p7R4bjIfHcCWStZjH3tt6/YMpCvnZ15tSBnbQ1oFUtaRVddE63+zfSoA68MWPoTcUcGuZ1cdO3Vypoa5W23ta3tNrqyQynCau4Hcsg3vQa6Z7mmd+fiIJX0abVzb92NEMKzy5n3KgdguGLeG0WjmfZZcfzHbLHAsfOHSlQskN33jBCQXsEYFRn1/MgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/glo3vhL5ZjkefwwnAwHakl5+piosevkSRs4pjYSOSM=;
 b=ZKmNIdkh47SvpTV27fp9pzyDdhZn48oWWgacf37fCf1zPlttHTi8T3mnRqoi+ctWS1Z3rivv6bWyNKgXquWTUgmypn6cUUihuBcx8js0F8QAhfL4ulKLxnMzZTp4+iCT5MzBiPyKaYdU0zABl7yTYJb1Asq3JGqktjleXCIp72jl0lnqj5q8saf5QBIioQ9Mc67Rd9Jl4K/kguvezB4SiyrhGXiV7ofACO4OLqleFzMj6pCV3yU2uV2KhMexuGztdXN2lABllzE/XnRLHCmIamPfmd8iriaXVfRrjEyLdhREliEtXvB0OwvUvnzwfi0PzQns9rbPfX3HfJWEJOh7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/glo3vhL5ZjkefwwnAwHakl5+piosevkSRs4pjYSOSM=;
 b=rplUdt2nix1GqVxqXutEB8xYPXW6A1ciIlRXG0NbThWHFUFBMnUxWWKpSpvijfxfA0/AeV5L6fbbsSaMK0F3v88r4a2jfe0x4NPdrr0xKBUQ18ghOr592nrdwGfHxDpz2tfdfaD/2Pgpm4P6Xb78WoqHU4wAo6RwGClxBjJ+gxvZIgUDArG29cM4UBnLs58VeAFVNNPwaSCkYgw02XZwKev3pX4Y7eCnGsi9arFoqOG1Gw/LbFU+rPxy/KZHpVh/T502D6/9RO3Ty8tGsH/xTULftyF5zKscGTEXlZYNKPz/Zz8+LRWElSGhB0TZHUUUImODzrU4SsIZwFKfODC8uQ==
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by SA5PPFD911547FB.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 18:28:23 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::b3) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Tue,
 18 Feb 2025 18:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 18:28:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 10:28:07 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Feb
 2025 10:28:07 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Feb 2025 10:28:05 -0800
Date: Tue, 18 Feb 2025 10:28:04 -0800
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
Message-ID: <Z7TRNL0u0YmN30ax@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
 <20250218171821.GG4099685@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218171821.GG4099685@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SA5PPFD911547FB:EE_
X-MS-Office365-Filtering-Correlation-Id: df7c1ce0-03fc-45b4-5a36-08dd504a0741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9TQNnYli6ma6XSjuMwDZoniWGGgVjNt4t1pVjTMWeUg4MQ7KWsU1T2MD3q8m?=
 =?us-ascii?Q?HtPrRdKTmTTn4cAQ8UXJ2wGyvLXzL2ddiGDsKRF7qg99r/OLOyBmUX7WC5Dn?=
 =?us-ascii?Q?IpBxv+flT6n4foMwnDFzDdGs8iMvYac98xdBDWSjHtFqrMBOBLNWtyzXYLwq?=
 =?us-ascii?Q?443KkekAPoHuhLkDmKx/1xAgFtof8bHLaTDK09YRx0XyrQtKsj+iM+uVRRW7?=
 =?us-ascii?Q?m3h3j2qyMzWKnJ0jzLKElpaRsAralL1d2xWzEQLK3EY2tht6HMMEAuHzQUsB?=
 =?us-ascii?Q?5l0XmjzBxiCLC3YhqkAUw4hc7+Gsupjoi0Lk6eC5oKowRrQMq71kONjmrrEf?=
 =?us-ascii?Q?XZr+jXuBM6Nsm97y2nY/yWACvNdMnR2XykePL8wIKUV+vZYzWOptHZgNT7vV?=
 =?us-ascii?Q?EoZpxVV9mj9QXq6pRPEg3MJf+yXDYjVpXEM6QxWcM4kUhtFWk0xQncDUo8df?=
 =?us-ascii?Q?dPtQjM++82LVVs98KA1BWv3SPsMrvHbm1tSEWwRCE2+yYP9YBh2+KNbCHcQL?=
 =?us-ascii?Q?oZIYXbdjfHO1c43TbteW4rQi+Wx/CmFrvjfRRuM2BEAUqG6g/DrRCfRLWXoK?=
 =?us-ascii?Q?pb27wDFXOG905/loE5pEcf0klHUbdyFvlwIVj+fNkINY+3fxaWXfQzjiTePA?=
 =?us-ascii?Q?ku+46PaPo8l1wVTSZS6AGwXjrvwEDh43K6b5hyhqx+2Q2keRHVkpdW9L9dHI?=
 =?us-ascii?Q?9RtCpSjysabe/CeJo2FG9IDV1J9zEsW0LOOZBR5kKqJA9OuqtGDtzEa2Po6V?=
 =?us-ascii?Q?bhYChPFSs8NIdG5bKBEmfehIVsogf0cA4Ik+BXncgAcva0HivsiqKy9RqUgM?=
 =?us-ascii?Q?lUnsh/vi4R5Dp4G3ZrmZKgLnEj2e3IpxC0adozajy0WHSr6mUxwi4GmmICGe?=
 =?us-ascii?Q?QmzovTOQjQV55+lRYjIQ/N0fHkaI+6QoLDxJN0z2E4Sj1iQmCN+7sy+bqJnl?=
 =?us-ascii?Q?urEbXysUKOZTURJOGo5U2hTvLuog0v4Zor56V9DnadHP9KoP30ZplSRHYdvh?=
 =?us-ascii?Q?fUiCjyrwY6nlr6zaenH80WA0AmZmfU/LbE1zHmEfQ3SDsAO5wjO92dzKq/vs?=
 =?us-ascii?Q?dfvR+XLVtrgsMfFxCt7Y48bQZZjGnry3kTBip9BheCTy8oeDBnhJI47/e0PS?=
 =?us-ascii?Q?qrGbDrJ926vt8nK8GLeVkchssKF+xfmyvaJwTDLob6xccFlDEl2tY6PS1ikq?=
 =?us-ascii?Q?V4fLxeADIebsQy+dAHhs17pFMNBKOK9fMG9L/CFxvqCQoK7d6zG6wbY0TqnR?=
 =?us-ascii?Q?Ks3FZKjTdp5LA3oymr1StOe8gTD00nFg6Hp1Zog4u+llK194hrYjkNF/bEdY?=
 =?us-ascii?Q?4Sa8OG63PaIz8uCcbOR381IMYfiYjkSPwOPr2p5WsZLrlsmCA1gfjb+nt0kd?=
 =?us-ascii?Q?IQobqZw0RrdqWoKTGQPIwkS8SR0q+tVZbMSLji6aOtXw5X6yfXGpw8GrCoDb?=
 =?us-ascii?Q?sKtE1ISYXbJ3WBDEJzEEvQ2o3vwbsDa2RwPzBNGIR2laXSsknzsW23oNSfxG?=
 =?us-ascii?Q?C3GOz6QcItYRl14=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:28:23.4441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7c1ce0-03fc-45b4-5a36-08dd504a0741
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB

On Tue, Feb 18, 2025 at 01:18:21PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 24, 2025 at 04:30:42PM -0800, Nicolin Chen wrote:
> 
> > @@ -1831,31 +1831,30 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
> >  		return -EOPNOTSUPP;
> >  	}
> 
> There is still the filter at the top:
> 
> 	switch (event->id) {
> 	case EVT_ID_TRANSLATION_FAULT:
> 	case EVT_ID_ADDR_SIZE_FAULT:
> 	case EVT_ID_ACCESS_FAULT:
> 	case EVT_ID_PERMISSION_FAULT:
> 		break;
> 	default:
> 		return -EOPNOTSUPP;
> 	}
> 
> Is that right here or should more event types be forwarded to the
> guest?

That doesn't seem to be right. Something like EVT_ID_BAD_CD_CONFIG
should be forwarded too. I will go through the list.

> >  	mutex_lock(&smmu->streams_mutex);
> [..]
>   
> > -	ret = iommu_report_device_fault(master->dev, &fault_evt);
> > +	if (event->stall) {
> > +		ret = iommu_report_device_fault(master->dev, &fault_evt);
> > +	} else {
> > +		down_read(&master->vmaster_rwsem);
> 
> This already holds the streams_mutex across all of this, do you think
> we should get rid of the vmaster_rwsem and hold the streams_mutex on
> write instead?

They are per master v.s. per smmu. The latter one would make master
commits/attaches exclusive, which feels unnecessary to me, although
it would make the code here slightly cleaner..

Thanks
Nicolin

