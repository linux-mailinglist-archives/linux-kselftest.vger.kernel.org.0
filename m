Return-Path: <linux-kselftest+bounces-36224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E388FAF0652
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 00:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233034E3A1C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEED2302CD9;
	Tue,  1 Jul 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CRg9lAyx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68697283FD4;
	Tue,  1 Jul 2025 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407695; cv=fail; b=f97Q1fztEll2sntxYH2cL0w2v0Z25ph/JeMV5dkWAO920Y6id2YamY7wdcYhJ0Qnv44CPoJmQdYzaeg1UypjQ855mc3I9Zs5hu8200njxg0FnWN3lUniEO7nrKDPTgKrl48xnNYSYqaLSGYUcRQ9x4Rv/zv16razS+lLzKpdi3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407695; c=relaxed/simple;
	bh=HsEsqmBhzKJ/aVBWUw1d7VhY0dIDEu1kA3Dsnp9Tjk0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9STrsd7Y9bvxnHPklfhA75XSNRKHidPZmV1jYBHl20kU9Vn+W8PHpYf0ZvKXwlJkbV2r/2cwt07R2ox/6F12kGv1NQ+ECELu1tFg/6DsDTKt3qzEAPe9HYJOIAMIVheapNWgGOon1g29qdLAwAvUxm0wYiwNYIZbRbk+98VYO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CRg9lAyx; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXg1NtooA3KL/l1kTGtL1ZqRD5ugNCKMz6foya6bQQG2xomlJpZFjzYVnUe+dC0PdAhQRpc070F7rdj5/1gIu8kaoiQyGtCcg9wos1geQrs2zg8NdKMg6Lz/noOeYCTUn47ExlQh76vlDMCCVD8NTfega0So9f5YErMUxDqDdxuDuYA4Y4xgxvyYTDDrYKCQkrg8w9jLmacCewGX6Cr8NCIr3VA+EusCS8sIyn+isVh/jdieGBqDkJQg4yIu+KGktZdR7dE0O3LbAry6AfGUcRg9Weo4i1O9uc8mvzYFGJeGsCuhjC83q8FsRgSxBnZrU5WKIeUiT0bppLF/YcC43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImdEhMqAVASqHzX+cCrdWNx7bD4yHRFRL4FUliyuIY0=;
 b=H/Hrjms6REV4y9QMzbvkp3wegE22qeJByrFPE3LrQp32PzcNbRXbJnO+eNWpQdH37LSLX6TR67W2qbnaUuyB1JG0UzRkAV9YnVTlIfAJzlzmqgz8e4l6Z2rtedZCNveOXtoPESxb1boA3wtFcVpsWd/eiAz1/mLjT6iR89dECfuDfA3Ik7qsvjr9LmDStrzg7ylEXjuB3249Mz1saeii/NsnnKkvZDtdQFt1A9i5Y+BDf6lj4OX/QtFD7rLSRG9uzPH4PB1sKyNkOBJrpn0Uz3YnhY+Cnsu848/G5GyDPuJ6zlRS/jeYiDgHAYIt/tPqo+Nmlx48PyNYfD7DKM4gJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImdEhMqAVASqHzX+cCrdWNx7bD4yHRFRL4FUliyuIY0=;
 b=CRg9lAyxnpUwOpJY3IbyXRQslQtMCbH8+0MYnmq5REC6sBpvXac6YWBlYNR92ekWPluQrmqFQulb0q2GsuYTEw++GqifKODFgzGnTOdB0JbaO8+/NfjQ1tEqMtBWwdbfW+iZJI97NSf/JQmD0GVmZFI33RuIDj+a1HoI6LPK2twAj6s1suzuPUqc6VnxxrksTyQaWxJrr1hjNJh/8IhYVDQ6NGM37voY7J0BUxbvKKuOm9UGlfwVvCVMC2r/u4aONst7K38Tm5MYjWR92Kfzn3MfVJScfaRFC+nkyDofrBrOAwFrKY1Dnz5RasMbb5OEhXqzqevZtp4XMfpTustbDg==
Received: from CH5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:1f1::25)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 22:08:08 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::76) by CH5PR03CA0007.outlook.office365.com
 (2603:10b6:610:1f1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 22:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 22:08:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 15:07:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Jul 2025 15:07:59 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 1 Jul 2025 15:07:58 -0700
Date: Tue, 1 Jul 2025 15:07:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
 <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aGRIctg4T6cQECx4@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 712baad7-1c79-4388-a217-08ddb8ebc2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ocs7rckttIK6PmTEfsnhxwdOQoNdKm9HIV7g2ip2vaKdGt9JQCj1OghE2qN?=
 =?us-ascii?Q?wS0k1goXWDCXKMz59UJpSddV4DJNMDSeQ+rrCilCJyZhFs9pSmsfy01LadYM?=
 =?us-ascii?Q?ZMGx76Wja/x3RGU/a1hArZbK9qvvA5S2LZMuqWPRj4Ma0Q3fw84SszvMzb9O?=
 =?us-ascii?Q?GAkn0CXQHuXBjgz8IGzN36Y8vMscmY3bRDgH7v1aD5uN/GEsI/Gt4PFX8pHV?=
 =?us-ascii?Q?+/ejFxJtm6/Aj3pK3kLlodex5NgoM8Qw/l8e3oEggqFjS7fyQZ0p9lFj3ku4?=
 =?us-ascii?Q?nR3UdkUblgYd0IN8poZ2HQzMYhLDbq8soEgsr8ef94cLfhVYYkR1eePx1n+3?=
 =?us-ascii?Q?NYI7ieQmhI4Z1JN5xmryysOrl5UI/xm5SqsUoAWJZ32sStK5l1+J1m8HqTlS?=
 =?us-ascii?Q?VvP7Qua+p364gcUT7SSX+MkpXuzcfnH/YXQarl1NieimoJo/vL2KmuuErhZ9?=
 =?us-ascii?Q?YHndcHceb5/LFUlQUOhXv+3G8UASnrYR3N7pKfk0t3HNtrrOx8n1ah9XSdKE?=
 =?us-ascii?Q?3QtHYu0Z8clc/r3HONpp0V8Md/YZtU48jyEM9StCgvH2RTpkk/O6eu8vrkaj?=
 =?us-ascii?Q?jpRRBRIKZsZ8vPoLEGjjJ/bzuhniKhxbzSy/U9BR3h1/brsn8mlqoVF0E9+M?=
 =?us-ascii?Q?Ctpa1d0LU3D+AZSY/tk1sWJqHRCC/PFvs1BMK0hn3sY60/j81xDKRps6dsTl?=
 =?us-ascii?Q?c9GkyfSc8wlJ0L3fxzH3HQeUgcDcSFogoqhBJzlda/oJpGmhKx0YbBRCI5AS?=
 =?us-ascii?Q?X+SsgltSFcQzlorBYxWLd6C33dJNvvWmdGFO/EBjYzdPvKVvS5zXE4ehU9GY?=
 =?us-ascii?Q?GCVA3VlpxJhUCwvlLWzIhYiNp5hqxAJJ/ysWdPKa18d3JvMAueeTPs3Xdi36?=
 =?us-ascii?Q?VhAOY5JWgH6Wndpt0Fxup2YuaBMsGO/iqIKNZ0ibA2nabU85UsTSrOW+1a6E?=
 =?us-ascii?Q?E0aAt+yoTblnranHZlSOp6R/+qiRhRSZoA5ODqBoYSG4AMPpBpXXvnaH+dj1?=
 =?us-ascii?Q?ZjXmqEnZV/mzUI0tnvgUu2mLeeWA3bc0lfQR2x16CH/HGSAv4SjDsOZ8PXYn?=
 =?us-ascii?Q?dZVOkATZiuJ8IGFYgvfOmJbdMzoul7ahgqt9CUHm8c/wEwXpPPgQmk1z3ADP?=
 =?us-ascii?Q?rfAZ721o3WGzzWph1JA+JpGHWPyeOosBifjvpH/Qna6LEgyWLhTH688y3iPC?=
 =?us-ascii?Q?U4hbCiyEac+qNhK36/QOOoBjjrGWQNzuyuCdVUfLa9oriqSLiYYeksgDddl2?=
 =?us-ascii?Q?cERTMlRdvUVY5rLwmcxakj8gEcJWTtoDE0hdq7n0pgoZmgFinff8hNZz0y/P?=
 =?us-ascii?Q?uSQM3rYajytiaezvn7cuR6jhixDTu2xm9eYUfop6DXkorczzs4cjGl4MJvKR?=
 =?us-ascii?Q?q1l6wAec6VAtpkZOX9XA5ZQZ4d6xCmaa3tDgoR4O3Bna3PdZIBKaVbhivd5N?=
 =?us-ascii?Q?xMKfJinzW/F771TJbT7P2Tkygen6LoxBBwU+Oqc8YDNP6MvyvpYBl7WkMkh7?=
 =?us-ascii?Q?Bep1PqreX4SHN3Wibo1HLBNxOzo4LuJiqO32?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 22:08:07.8188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712baad7-1c79-4388-a217-08ddb8ebc2ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409

On Tue, Jul 01, 2025 at 08:43:30PM +0000, Pranjal Shrivastava wrote:
> On Tue, Jul 01, 2025 at 01:23:17PM -0700, Nicolin Chen wrote:
> > Or perhaps calling them "non-accelerated commands" would be nicer.
> 
> Uhh okay, so there'll be a separate driver in the VM issuing invalidation
> commands directly to the CMDQV thus we don't see any of it's part here?

That's how it works. VM must run a guest-level VCMDQ driver that
separates accelerated and non-accelerated commands as it already
does:

    accelerated commands => VCMDQ (HW)
non-accelerated commands => SMMU CMDQ (SW) =iommufd=> SMMU CMDQ (HW)

Nicolin

