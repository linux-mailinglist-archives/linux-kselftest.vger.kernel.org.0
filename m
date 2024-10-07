Return-Path: <linux-kselftest+bounces-19180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DB9937BD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 21:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231181F226A8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 19:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3601DE3C8;
	Mon,  7 Oct 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oie7h3r7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E6187876;
	Mon,  7 Oct 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331025; cv=fail; b=td4e0thR3JO+PNvfXJeIlZH14fKnEXLdvLmWWCNGHjmmDsYsHp09dr+MtED8EJVEvvqxnys1Y6c+oj0eHDhBIu4L/txEYWTSRLqXHbwojR31uicPfUVWDROkdTaA//ZKF5nxuulE+2bX/WHEFVxgdhGKAIIZMxdLIHIzvX496dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331025; c=relaxed/simple;
	bh=GPoG/jyTA7IpWnUOdyH3STBKVB/KmgZzex14AW6Sl5Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaU7h6bRlOHvpML3oxLnoTR8bGmlBHIOZW4+Xupsk+Bi79Ut4y7AAF25667zheHTW5pWVqLhnQeV0XlFy7+h7kNwGxaKl3vclTPdSQHj9ctAfan7Ped4PX/qqlXKFOixvFsrpF67PsBZ0ZPZlQs9qJd3rJhfhfhOJlytMSvtFBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oie7h3r7; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0+z3HBW14MUaRpusOuHFUb45IgJE8FROJ7cI0/jJSgeM5vcfjDDBx84Q7vACdAtJfIXmIlLH1Tp5bcTDh83QUXLjjAEDmLZS3hTTTpIyMr0Q4eLIafOF9cxkL4WaytzAOmMwdgt7WXSoFSxV1C1RJPpUqHFs7HFMAWbWcR75RERrxCigC0RNRXnNgxJLAq09RhnQ3EIQjdFjBubXP64zdqfoLf3cxbTfayY3f1x6PcTe9PO05/d3RPwdlx8XYDwsKFlINZALBCskzLUKMvANcCqdROZjoHsnNLY4/a2Nwe1pLPb0D5ZyuVFIcTkXfMVJNpTsudYE9uoJwD+KbJyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmLlHnO+N2GqhTILqJcG0bE3a8yX4UvGbFaSjXni4J0=;
 b=gYHW40nSPz44tBsUBWcMIWjsx7CLnPvCGmvDeGomhe2egkUMbVFHaDHDvQiB/95QTQqYmnZ/Zql3soGHjHncJTy0HgvN+SMLjB0txM0263vz8+vl1nYIRWZZmJuumdYPfkxpKdgowyDvmd6qchrglUhkX/CXY63MocmE2ZRpj9DZlp6v7nbHC3K4+fONlk4I785hpDJ1hRTntTGbSmBjlOZxpSFQW1EdwGivfD13qQWjclV8nIJcdVJVMEUxUuarK+9FQ8BIiCrlkIC4axr5X8Xe+hyen25HeAIt3v0gQNOIcHNvqmjDlTzXJGKZmJ6XXNdPWnAf2l6a6YVq2RZo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmLlHnO+N2GqhTILqJcG0bE3a8yX4UvGbFaSjXni4J0=;
 b=Oie7h3r71gbsokKbwUxrPV84neONPeWJnJdnEjBx9vEXa+LHqkpRIYPwvXx3Cq49sJm6Pg8N1seVFKViK7vrMk9obQG2yiIhfg7s+RnyKhQTJO2Ecv8W9MpJtxAUziq4CaSfwLWhMNPY285LFpsiz45EVWG/n6NiC0ZCwJ14IvSNZ+9R7L9eqey/NzZzRmbgTFlbmCyGJGbHeI0iurWo1W7zR2UTMYT06kK1JmwEaPE8Y7yjSAtoZ3YYxMIkPinr+xA2eZ8mS3tgzuhrfDKvU1OoBSBWIosis3r7p8obnndXwYpgdGmczhBAfR4LZJ2FWyfgpOeZt9MxZWD98YqnJw==
Received: from CH2PR11CA0015.namprd11.prod.outlook.com (2603:10b6:610:54::25)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 19:57:00 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:610:54:cafe::79) by CH2PR11CA0015.outlook.office365.com
 (2603:10b6:610:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 19:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 19:56:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 12:56:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 12:56:43 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 7 Oct 2024 12:56:42 -0700
Date: Mon, 7 Oct 2024 12:56:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 10/19] iommufd/viommu: Add vdev_id helpers for IOMMU
 drivers
Message-ID: <ZwQ8+ENkxSEaDem4@Asurada-Nvidia>
References: <20240905161415.GS1358970@nvidia.com>
 <ZtnwG/Kmaf+fZFAv@nvidia.com>
 <20240911231103.GR58321@nvidia.com>
 <ZuJdPHRbMeYFATT7@nvidia.com>
 <ZwDMb3F8/cCFhwcQ@Asurada-Nvidia>
 <20241007153837.GT1365916@nvidia.com>
 <ZwQOAvoJrMWOuxxd@Asurada-Nvidia>
 <20241007171119.GY1365916@nvidia.com>
 <ZwQZbYiCdf6WVGG5@Asurada-Nvidia>
 <20241007182816.GD1365916@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007182816.GD1365916@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbd344f-c9b5-4053-3bfb-08dce70a3489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W3ZjSCyKDfhztkL1rrAppoyHSHWyBJesl3f4VDi3hYz1a1P/NuFi+6WujcMw?=
 =?us-ascii?Q?W7Jtn6Le7Qf8z94ieGqJwBqfdDvevZ5aSchLY7Nf9OdWtrCMYD7CMu5c1aGe?=
 =?us-ascii?Q?ltyp7uy/JbyHruWXVmH4hk2xG7AWex57DCjcJVQ+gNsMrpxScOw9ttPhoo2s?=
 =?us-ascii?Q?CGzfLsy4BC6eQcLP4XXMkHKbgU5UVgV3wXYnjj6G+PJ4HNnvtjfUvJeK8eek?=
 =?us-ascii?Q?tRFH2KNuX693K2TMKzOj5d1SVdQ0x6MCwwkWJnOxm5d3hatjqB74ChIWwyFD?=
 =?us-ascii?Q?w1Zfhc2np7pbYllJc/ePrCdI6qZLVQGjbB68GdfQNymIv1q1D/QwI3HspVoX?=
 =?us-ascii?Q?bRxNHPoAM3RjGiKqgxjHxXdfmN6X9dRo9t+K+EO742jX7mbptwL85I/8cgE3?=
 =?us-ascii?Q?5i3yuajb8eOzXH9MbuaoIqevX6hk5pqM0qfJ9WpfEef0DLtry9Ys15ZWJKvs?=
 =?us-ascii?Q?nxTw8SDgLExPPjkWzQxURLORXzqiuUFVFm65mD+QFP2fR/JV3XiLQjMZkjJI?=
 =?us-ascii?Q?koclDS6CAO0cs2biCQyrjHOJfqnSK1at+9kFb5hDBmKuMQpQnMXvwRmzO+Yp?=
 =?us-ascii?Q?m5/TFAPVMOg04bpHDRaxF5jVPuK7vYqu8QMld8d7MfnTngR0Prit9cuNS8z2?=
 =?us-ascii?Q?uXaqHbUg66ipxOSl0p4v+pzYgnPfJgyXENNLiLk4PXwE7Kf1wXJJef8YNcjS?=
 =?us-ascii?Q?94xjIfPhf6Jfg+3ein90uAoebMeVjn95BQjbXUNadKtj8Ol+WDUILLaS/VYc?=
 =?us-ascii?Q?hvmj4saSgLlGAsAPjDi6zHPtq2K/csEi9cgh+f0/zLFNeyAWrqPNxIG8qnNn?=
 =?us-ascii?Q?Q+wfv+SQy6NGFZhwL80AQOGSoOprLkMO4jbcq2TtHyxVF1dX/z2gVgVZ0xyq?=
 =?us-ascii?Q?MUFXchw/22RQBiFf2t/o+ipocYZiHGVyOCdEJOynTA7g4wGsHd2ey+tM/HHS?=
 =?us-ascii?Q?LJKyKMk80u8zaaUht1fqfLp7DX4IunSfhWjLJQ987mpA5QIkjdiX5yF/JEF6?=
 =?us-ascii?Q?HxvSJp0cyqFGu5TWov2Z+Bo10CJMr+T+UIW8mgFintFkFaQMqEwY+yDQHFt9?=
 =?us-ascii?Q?1wBzuyDFbrrG7MGQFwDCG0r0JU3MqfFVk7lzGozqdPY26DvnrqCSqSnb+IPN?=
 =?us-ascii?Q?hjD9bPdigxBtEa79VN7QbWuJjtFWIBvMZV41x24+3SwefubOHQwwG9zztYM4?=
 =?us-ascii?Q?3jO0LckEajbniKzLCzVyx5buEe+e8uFw6974O949NXB74DvU/AqaMctiNMUa?=
 =?us-ascii?Q?2O5SFUrTrVqkBGaRlZ8raCespVnrPPwQqk9zlpj3aI1aaG39uYCri6aoX4jF?=
 =?us-ascii?Q?PJw0v6+Sg5dRMM2NMFgsMjCVCDYN6zgffgjn3JqaB51NSS6YMtYU5U3k+KgS?=
 =?us-ascii?Q?2ODziWsjZioEjD9vneys3i9UscX2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 19:56:59.5772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbd344f-c9b5-4053-3bfb-08dce70a3489
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733

On Mon, Oct 07, 2024 at 03:28:16PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2024 at 10:25:01AM -0700, Nicolin Chen wrote:
> 
> > This is for vdev/dev v.s. hwpt. We need the lock for viommu's
> > vdev xarray.
> > 
> > Yet, giving a 2nd thought, I feel the lock would be useless if
> > a driver tries to refer the returned vdev (with this helper)
> > after the vdev object is destroyed..
> > 
> > We could only note something similar that caller must be aware
> > of the life cycle of vdev itself..
> 
> Yes, I imagined you'd use the xa_lock for this an it solves both
> problems at once.

Ah! We don't even need a rwsem then..

Thanks!
Nicolin

