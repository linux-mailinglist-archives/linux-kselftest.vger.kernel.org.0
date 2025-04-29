Return-Path: <linux-kselftest+bounces-31940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56401AA1CB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E8B1B60901
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 21:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708A26B2B1;
	Tue, 29 Apr 2025 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IC6SDFkt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16553253F25;
	Tue, 29 Apr 2025 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745961180; cv=fail; b=q2sxvx8XnKVgGPYGMirc+6cUm18FqBmk1j4nBh+JrU/PjWIFlq22GUn1lbORGgLwualB7SDMzZQ1+052XhwZQ7P9nT2SKVqsm1ihL9czN7YC0Hl68YyXcLsvmGZF7ePOnsqDksmGcerNCJeifbvj0AxjOyhshyU8xZqFAHZHCdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745961180; c=relaxed/simple;
	bh=VxLqrXaVqHNZPSoKe1t88jv1vTacy7OCn5dVDr8raXc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGcPKIuvBrTs3U66QxqLFmns4V2Xx7Ofr1ctOXh2AlNIEK62xH0PgM96K+CfJReDzl1Ri5b1fanRJhJvqsD1fEhKzDRk1mpUhlC3Ns+F1DfvicFyqXogfed6XkwCvIqBCJhoIpbm58mr5Yyj/w7h7E2uAFLRdgJgsuUVztc9wp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IC6SDFkt; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ2yHG+uFVo9p1nDKLgUTIrdLqfp/fA1IpcUUCrLYB7qWh+GW50ZuRHb1ES+MrAUcJOHvMsWMQOltiMxA5uQy+mm/6oDJxO1pzPyih8xmdbvjhgD79eHnCm7gMenvy0zEOjX43TCc0TFO22jyDrfwOfM2v0tOZYxmdrcijZIWExCnEpJUKItr0gmmYHTwhBBw7Gkcr9QXGSs6z5RlUI6YPxWVyE+bZWi8Qu1TiaXsgva8tLXF68KQivQf5F+eY1O++1++052ErBMJzqmWnLb2CyapKGuFchXGYM3rGcCNACNw+7kxE4X+fHzGDZZeGLzubwuSe9Uf1RhxoHAt7KpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0FrbLY+rHz3YBtwiTXqjPJN8NcbHf0UhtbppuIe1cs=;
 b=AP2JjiOMVx69zq980XhGLvDBbpNY58LhTCPYIS0gSQEIoxaU5rnm0GJIdjVd/wGh6rY6ahIOSbOuTcI0uHBEbjXedip43Cwpc+3cN3hwKWir32Tx7BgzMPlGTtQU1tE4b0tIhHwH8ljc4Qx5oPDl5sBheKF848OH2xrIpFzW4JJJbSA46EMsZKAO/4ZDypsw6nAMeufZkJeYINOn2XBnIyunfqcvsZUeORADSQD2yIhH9ejkcy33DsGZYH6u6dYijKbWvHgx7EIFvKMQG5004KpxA/803jrOVTJpksugJczq4jxoFzyzdns/rp35odqvBDZep/9zpBiDNMa6VB4Txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0FrbLY+rHz3YBtwiTXqjPJN8NcbHf0UhtbppuIe1cs=;
 b=IC6SDFkt+MlmzWNzEwhdoc0+C8DO3BgUKvamSg2TgG3FA93m0Shy0UYsvcZAekdME7rC18ioL+0EXNQOwwM6tHOSVFMWrF5kPzT9y3xrRHSson2FVhvUD6pOpatnrDt1KSOTOvkz2oqxylVxulvghf2hnG4HXFXHx9JY3809w8H9b6GvcXAk0cEdu8tuZqVkyX84kJ9+GDgXqr0H0SFMRTEbHiBgYaDQeyqLFB2BGq56/wNEOw9weqWnQtrYk5s3wOe9lpjD/OpmNgosz1DxvcQrMAvWdQB8XvMZwr6lJ8HqsLun6t94n8tQkk8TJTCLrwfEvEa/hk+auGd/Ol4ixw==
Received: from SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::30)
 by IA0PPF89A593F05.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 21:12:55 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::8f) by SJ0P220CA0026.outlook.office365.com
 (2603:10b6:a03:41b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Tue,
 29 Apr 2025 21:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 21:12:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 14:12:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 29 Apr
 2025 14:12:42 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Apr 2025 14:12:39 -0700
Date: Tue, 29 Apr 2025 14:12:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <praan@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 21/22] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aBFAxWo4Ud1LRaTa@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <b81b2332f793a9ffccc528d821f2ed3ac051f9e0.1745646960.git.nicolinc@nvidia.com>
 <39fd41e0-2218-4c70-b79c-83be3eab30e7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <39fd41e0-2218-4c70-b79c-83be3eab30e7@oracle.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|IA0PPF89A593F05:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c3cc3f-ba1d-4e2d-9e66-08dd87629be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2f6nzbAf2RhaRBfahVow13rcxaD+LFOQ84r0dRavmhNI2cbtsEDqeNHna9eO?=
 =?us-ascii?Q?P215TnHncZ5VmXi5zutKtvHc0kM+PZB5jXVh31T+ga2TECQrQ8wLIBLITVmE?=
 =?us-ascii?Q?QLV0MGQVQUbOTutSptyNU8lw7tW3uLyr0ajzQ2Cj0r6/f2SLOYHlSUS95diD?=
 =?us-ascii?Q?uBslRgdnJj76qfhu17LXOmpaXZxSQRxvFC40Ace4Wyoy2dWCCgsvqmwSVbKc?=
 =?us-ascii?Q?C+VBJZXnDJyYyZCAuRamFIel3LojhsyL3Yw6gcwoRGBlhpqsFFdBVj9iVCzL?=
 =?us-ascii?Q?rbACkauCdrTGBtQhK9k+PS1MAG5g12f7tSd3VJlORp5Je/eNUQPFlPJxul6D?=
 =?us-ascii?Q?yax3WQ+026mKMb5E9ja+Zwbr32Ft+q/625bIi8+GEDWWn+GIcyaYmFRF0fmi?=
 =?us-ascii?Q?m0BNj5o3/1fu5VpON0lMTeMx4J7BeEEzzBoVW9FUCfI+Vq7RrNknusqSvhU7?=
 =?us-ascii?Q?luZMIhEOWDnvEsd1OKVCcx23vJL4TD5/ZNpJSLv77BfjtxHfktFy3sT/q6E1?=
 =?us-ascii?Q?QSrGchv90J4JQptR5ZY2qSdijiZs1bCjuNAj2mxQQ5XEgEYRKO5vQE4yA2iP?=
 =?us-ascii?Q?LizS86+kpDMwZE7wLkqTeNopwtJ/rFCDFbJ3iIQ5P++nrz/wXbJIVyM2HeSd?=
 =?us-ascii?Q?6tsDP1QVoVKlpqJM5Vtvh4Z1M4SVz6huHVYV8VSkfg4UWj4PLyqJvUU7Ljqw?=
 =?us-ascii?Q?++k4MVriObNy/e7QkEdL1ZFI/NT9q1qwB4WYS5cjiRiEOd8Uwrlc4knshGzU?=
 =?us-ascii?Q?aQ+/XLaUPJB5oPRKZ99xjeMpHzfSTrIeem0UEsh8p7GtZq07+74+aYlAEoDf?=
 =?us-ascii?Q?KETP8WrN8KV1O2yZsT7ZLHtcJ18S2qln/0kkGklECtph+tMpn9qXUCmsgzRc?=
 =?us-ascii?Q?0mL3Wmc/uYHRgIb7RyPil8YaFDjYBzro9bCxf0smVtRFHAuoTMYS7BUA83xw?=
 =?us-ascii?Q?7PgwJbF8S7+ik3hsb+PRzzJuYq71Ah1v8pSmDbIgc86RX2X93hgq0e/n51w9?=
 =?us-ascii?Q?qzQMppU+iquIKMskMGkK8ihRlPPq+ELFT0m11aRt2znG5uV9UDZrFsLLccYz?=
 =?us-ascii?Q?x3ckO7Pksmaegg3N4vuPnF74a1vaTW+q5PQU+XT3ysCiZ9kgGrn6HM4c4tqN?=
 =?us-ascii?Q?8gUJqzUDnUOnRXzJr5uHR+7avQQ2JfA28Ej7QZNaXgVwkkbRTtv4X98gohsP?=
 =?us-ascii?Q?/3Dl9gHt9GaC19dkKK25A+OwLwgEgWJ+HB/8bKtmPYYh+fwtIbtcDh3r7mC2?=
 =?us-ascii?Q?HI2rhY5w201cMK0FIxlOazeJ2PoS7FifLfLFGqhGtFGxy9UUrBIsJDvY+flp?=
 =?us-ascii?Q?ckSD8yMn0l4QZ+B62VIAyv/Nq1qQHVLWlJbNSnqv+kKtW2gMdcI3rkkjhm8O?=
 =?us-ascii?Q?2DaDrCYVtBNlsb5H8USbnSbdlukrWKrRTDJhgjNloiqYqNV+UUF8eCY//oGz?=
 =?us-ascii?Q?JEtPJqtGDn40t/E3hLKCJYVeACbZvd33ghFhNP7FUGA+zC6b/6Uv1XUSmTih?=
 =?us-ascii?Q?jvV+pNz+UeLb/m4HrB/CbT0wv4agIZknmIt2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:12:54.8054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c3cc3f-ba1d-4e2d-9e66-08dd87629be2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF89A593F05

On Wed, Apr 30, 2025 at 01:17:48AM +0530, ALOK TIWARI wrote:
> > +	/*
> > +	 * @length must be a power of 2, in range of
> > +	 *   [ 32, 1 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) ]
> 
> 2 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) or 1 << idr[1].CMDQS
> 
> > +	 */
> > +	max_n_shift = FIELD_GET(IDR1_CMDQS,
> > +				readl_relaxed(smmu->base + ARM_SMMU_IDR1));
> 
> 
> LGTM, aside from a minor cosmetic thing.

Fixed all those and the typo in the other mail. Picked "2 ^ " btw.

Thanks
Nicolin

