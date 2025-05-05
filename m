Return-Path: <linux-kselftest+bounces-32386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA6AA97CB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D4A3A1132
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364052620D3;
	Mon,  5 May 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NFhV5wED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93298262FE1;
	Mon,  5 May 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459951; cv=fail; b=OOEsP230JrnG8W12I1FL42Pb5jSmNz8IFu804+qpp/CajbWs58pvYm2ZG64avTDQ2Yc+T8CRglc/akeWuVai+ZyGMTcgy4EOCS5vVO54Rd8/hdzU5IKW4NJ0eSXzVgV+2Wxl+glVpDTs1wlwJvhBIskmXtpHJHvZPI+pGSwZ5to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459951; c=relaxed/simple;
	bh=cYbQadj9OIg6iho3ezP5ME9KdFkDRYYFVxPV0kxtWTo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhIUoex4nxpWwcQ6+rTxIhugtgRZEkR7FZzhc/U9bHWxspeSGIPJr2p6+/I08e9xmadNlDk/TOGBt0cZar+hLLOtk2zd1I5UyGm0gW0kdp9e1z5yiTyiXGKunOVXaLoBBvE8E5WcyKZ30ePcoV3uDWBjENo4aGDoxIbXxdKir+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NFhV5wED; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhxqNZuWVhh1cxJFmymjLupM8NEfaFd44DE3kT4XzPnUEAESeHvVFGZLJYNCtg1pE5kAJX/QX+c7+CMzZRbvL/KI751eToMqBzVounMeHp/dDchVbS6nLaKDBBOp2hIX9//7qrWKw3mJtfIRMzliDH0bnBH1u4QFOxgoSEsI7uOCS9aDhoX1HA274P0Ce0eLg1p8mnqoVDxGgGM9G/sI/ngCa2YTmOiE+W2tU4xOMy+Q4IdrM2LSBGE0MW6QwZOoYDDDbNRbtQP2WzZXi4tsYfo5nYSAkbG7nzBQvxuR2OSl9SpaSgisTmhfXDPkIbVabCbYbuIjp57xUUhwqVF7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8knYBdiqwUGKef9IhJFe3M4fBHN1+n+/XysVyvBkmA=;
 b=SlGN/BriYVrz+K1VVmQXRVSNZu0xUW057ZdpvTMkRjtL5vg8Rk25xwOq9jqca0pLip4MNpPeKyzlnu4um1Ph4Z0LJgNzm37JI9/JqEZdnoXqVF72iFaoeH13rJRRFgyuPoz8uwQ3w9eS0SidHBCdERy9I5y/GzWj+i3oxKkevnN6hGSsKe6N/eRaNYrP1Jy3RWJ4f9LaOrg+8o4n76uH+g9lNGhZC4D9Z7+3LopfSn3u0pid4dTrI9gMmOKJEpnsuQ2mqiMHqBear/JJHWwRhtJY6pvIdL8uRBUxY2I2btppgqdhA+aHJ3/8FV/0C/AaoaEWWMt1NMYz8uxzGxUgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8knYBdiqwUGKef9IhJFe3M4fBHN1+n+/XysVyvBkmA=;
 b=NFhV5wEDWHFULqDeQILZmMYt+faapg9UJyVVp/KQPjGTqrVUWEmNLOK6G9xiJMJYea1MYjTB2cl3M4klBpf1yr2VTTy7oDzrwZ2QBOsGHpTpWDy4vqGkDgKeS4kKwJevjBx8knEM2zOZsloJzcqlhRayTfMdY97NEW51u26831xfj+Ua9gqsIDGMMqnIHM7y8ZjQtweIRQ1HMyQeQm6+IwhHtP3cD9dN59HcnjRJVHTq6NOzWrezZCSkDiJaB60inSDyZJqxrOEpv2mvT/cY5LLyWAfdsrQO6tAa9fR8fFb4vqkIltiD+sIzCdr2JOcLBGLd9dJaEtYOGDrlFddXOQ==
Received: from SJ0PR05CA0121.namprd05.prod.outlook.com (2603:10b6:a03:33d::6)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 15:45:43 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::44) by SJ0PR05CA0121.outlook.office365.com
 (2603:10b6:a03:33d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Mon,
 5 May 2025 15:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 15:45:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 08:45:25 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by drhqmail201.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 08:45:25 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 08:45:17 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 5 May 2025 08:45:15 -0700
Date: Mon, 5 May 2025 08:45:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <praan@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 09/22] iommufd/viommu: Introduce IOMMUFD_OBJ_VCMDQ and
 its related struct
Message-ID: <aBjdCnNiqFy03Rg3@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <8bab0069503fa21b48298ed2ffe29a06963f71f5.1745646960.git.nicolinc@nvidia.com>
 <28e513ec-4d8b-4967-a241-d6f63d533050@linux.intel.com>
 <aA/EoEFtbnL2+zAw@Asurada-Nvidia>
 <20250505150214.GI2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250505150214.GI2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ea2419-656e-4c40-876c-08dd8bebe4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kQHCPvFWbU17affNrpVDbvp0d6MDegiBVnyhNl5lvSo0i0BY6AfaCvudXQyN?=
 =?us-ascii?Q?RpzAjI4XOASBST87fUnxgA5fUPDhorUn34Vx8zAyofcNF/DI1LKYC7WtrPKs?=
 =?us-ascii?Q?GjI6u4FEEMzjE5Z+NUPtDjMekYLmOm4anf+5Gq/0eiI1jOytfJSxNw2KQ2B2?=
 =?us-ascii?Q?BZYkCHCQ2RSIh9VunnaITlNweVDgZXcX9uxCVdLLxnUal6eraTH+BixGiVXu?=
 =?us-ascii?Q?ga1zkY7lq1aOIu8kaYeZr7oDDgTDjA3tfonO0MKj5Xgc7CF52ryPnVQ7Ibb7?=
 =?us-ascii?Q?PwxCpxTcyCCxljLMx3QpGYm8+mQUKsb+r7ZCgF9Q0jc7vFo04cdbt0W/LHyJ?=
 =?us-ascii?Q?3R+n2UMr+mfOezOENF/av//HG16WM1je+YMEHEYkbGuqRq+Yx3pem9PeyNer?=
 =?us-ascii?Q?zSQ3jnAnbT1rRCm6V0VjLer+f0ps3ZYwgMyVFj31i1XfPRsrER/zkB/ybdhC?=
 =?us-ascii?Q?+u/jne/EYTcqd4txpn7+DqgKPGLDO3phxD6pqJVFUnJznxxX/vhex0ePKYAR?=
 =?us-ascii?Q?o3VPp/VnEx9iRuQc0PC3Aehs4wL9g/HJltNn0AGCRrMG0clVm4e2YW0G8Tt3?=
 =?us-ascii?Q?6YORtCIy594gYj+IPw4uIf3baCwJDu6Lw+UyNkF9DwaKQ7pBUX8HfqxwGXN/?=
 =?us-ascii?Q?7WVLss6Ef20YAODvHcsufROSiGJf03asPejHab8yVh2HmbRbeHRxX1wf0gyb?=
 =?us-ascii?Q?oy7xWkxYAkkXRqgv8TdEKjME4nehL/+TSF6ZHr8eMbbaex7+ZYgrwC+/cLgG?=
 =?us-ascii?Q?kChM0Y/6TGLDxg7kY4n3CseH/7rRNLtG6+I55tg5v3D4kagrso7dgY6RbQ5P?=
 =?us-ascii?Q?vKpl1Krz79jNvjPTV6d8p+YYoCy8BD2WMCTtLD8mOEkbmDuKDUaq55xqOkIg?=
 =?us-ascii?Q?PBYjuqrOZWwytb+G0Nf/5diGHmF1f5tYidRY9sjwcdQ1zQvIYEq8XrJ1ALwX?=
 =?us-ascii?Q?f+2JTJMcBDq3B5C4CLqmDkDtlvniTnzfVzaFawSC4wVuE0U6F3MwGuBmi2YH?=
 =?us-ascii?Q?RTqLyjaRkEuareEv46XTQoynYSN+vEVpxqx60DQdtM817mOecMzE/B6fNFJK?=
 =?us-ascii?Q?dUvcNm+TgxBlcb8U7bNk2J2Zl2+1gsnWnaRliurqdGbCIpEJup+OuNUiQfVz?=
 =?us-ascii?Q?iYjykPjtu3//06bq69XuXCa6qN5sbQByHnMkV8Zia8VZ2Czl2YSE4IuEjds0?=
 =?us-ascii?Q?A+QcV/wBLyKAvGxE2+bAH6PWJD2Da7iBufJPFtlVWAuyl78ScdXJcmqhkRdH?=
 =?us-ascii?Q?kVad/+HwB8ExiG9B8sJyFwg2LMhar4S1GIQQ4HLAV98zhkb3h3lIFJDROuzC?=
 =?us-ascii?Q?qEfBAXGKp5bnJQ8cP+fXX3phZFeVUevtRG4u1YR/mCKTfGEicnmJc05uzoGQ?=
 =?us-ascii?Q?sRDiIBybReipQcRMco4hxD3Z25HHoYDXksh8LIR+JsThmJvRP6/6TFsvDNCz?=
 =?us-ascii?Q?KtimWYvUhEPyH/gCAh2CF3PGtB/+1T0BDCiXFB3dZmjIekiFj6luFK36MKGm?=
 =?us-ascii?Q?oPmLQHsrEVsOPzAQij3g/lxR/lZl6LA2jTPS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:45:42.7480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ea2419-656e-4c40-876c-08dd8bebe4c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371

On Mon, May 05, 2025 at 12:02:14PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 28, 2025 at 11:10:40AM -0700, Nicolin Chen wrote:
> > > > +struct iommufd_vcmdq {
> > > > +	struct iommufd_object obj;
> > > > +	struct iommufd_ctx *ictx;
> > > > +	struct iommufd_viommu *viommu;
> > > > +	dma_addr_t addr;
> > > 
> > > It's better to add a comment to state that @addr is a guest physical
> > > address. Or not?
> > 
> > Yea. Let's add one:
> > 
> > 	dma_addr_t addr; /* in guest physical address space */
> 
> If it is a guest physical in a nested page table it should technically
> be u64 not dma_addr_t

OK. Will change that in v4.

Thanks
Nicolin

