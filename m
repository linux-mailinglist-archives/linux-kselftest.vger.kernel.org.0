Return-Path: <linux-kselftest+bounces-42320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A05B9F4C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 14:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20ED43846E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26F3154423;
	Thu, 25 Sep 2025 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HXrTxb4B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9415E5BB;
	Thu, 25 Sep 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803977; cv=fail; b=Qx2Dom6mxHapWcNOodQ+5H8VN1bfoCZA8D/nBDoG07LavaXx18M8kfe23XKZmTMeoiBRed/FiuPMF5tJ1Kt4qvKLGdRxrOg5pYkuIyq8+kZrstHwk9vF5NlAO0fmIVPjSJzzXPE5Swsot9QzmZG+V0jDa6zLo8RBdvud4wEbZIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803977; c=relaxed/simple;
	bh=E3J9oqZfs5/0A6atndvtkyaaFD8ssUI45xoXeXTtqWo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8NXqbC6S7rhIVLm+sURx88wF/6Yc3uZGK36N4IskNv7JS/Ww+1AWhuck7SmkNC3EvjPAjJO/iM9a0ANSMw7vBTyex/X1VGdG4/TgN54R5milHAcXznoAw2QW9RzgXudvcVm3Vx53De4PyeZoP5A3Ut8tCvTari5HI/I6IPoe0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HXrTxb4B; arc=fail smtp.client-ip=52.101.57.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnah3tX2lmkqGS2zVx5sMGRE+b0uPDQcICTrjMuiMQyX8UyroJ6N44XLizT6BG/MFU2PYyqLwzRJ4+LFnYXQN4YCWbvCioSLn3h7iZI2yzIiDvFsKMa/BsTzkC98EiNpoh8JMkRJXqxT0WepEpDreskmduZKIxjhB94YtPgkrPIpbngTlB6HcmA93P6Ws0z7qu5w0kQcFzqbYY9SYxbFTPwkI2AWw9puFBfNaF9KXjdIVQzMQqGsTooWzcOjHWaYq+FMimZmvLHK41jOsgQfB7/SNXZJYZTha/0jQzyRwi7F/nx1CdXQA7BAfDcm+B4lsJ1rpXhcNIO0vUoeCmiiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTpzPwm5c3bHh+setJx8pU1z5s6OaV6Da/LLeL0UjC8=;
 b=LRQrMbEoOJUdJ37HG8Jo/vPcYsXmLEVkyRy6f6aWvw9Jb0/mzGeco+Qh4avHiZbwy8F5t4R/DTcwE4sBHFy0LfVnivogu2uafHY/4TZNX2BzNmyLvuG0b2SeubfD48wESDZUwlulA/7jRBCtNh0DUEbV6IaArHRH/wy9GiV6Vrlr0b3BXTG59zM0R9gLqEWyE79XmjZzZjD5lCYNYLMcvAY0p5GCfwNrLqlRuiwX/31XR9b8wBsNqX6aIJOAl367xRqQJRilXJWf5oUj5SSdXAJOtVtzdwV0b3O2Qjn4Vt7Q9BEIS9Pb+Ei+L75gMrmQPXbwF2tGECHGM8e0mh98qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTpzPwm5c3bHh+setJx8pU1z5s6OaV6Da/LLeL0UjC8=;
 b=HXrTxb4Bla9169gKSi3H3qJXnXZ5Pxa/hUTiR/jckgPdzs+VHgkv9y99bHb69wZGV2N5TN76bfi8zJZUmfY319ObI24L5QEzxCBCoJD/pccfLCJ3evqnR8ga/oEMSiV/jB634gYTYys7q85m2IgF+d51EwXErj21sICTMzV0ldM=
Received: from DM5PR07CA0070.namprd07.prod.outlook.com (2603:10b6:4:ad::35) by
 IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 12:39:31 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::46) by DM5PR07CA0070.outlook.office365.com
 (2603:10b6:4:ad::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 12:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 12:39:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 25 Sep
 2025 05:39:20 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Sep
 2025 07:39:20 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Sep 2025 05:39:12 -0700
Date: Thu, 25 Sep 2025 12:39:07 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, Kevin Tian
	<kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v5 13/15] iommu/amd: Use the generic iommu page table
Message-ID: <myrht6aea2jzaapbojl2gg64p43dufpgzqbmrpyydgfonw6ejg@i4kqafgtmmux>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <13-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <3e7mfy2s535w47z2cafeugv6qcy55wtijnzxeqozjbzhbeto4m@g4hamtjzg7bm>
 <20250925123227.GX2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250925123227.GX2617119@nvidia.com>
Received-SPF: None (SATLEXMB03.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a15968-ac9c-4a13-1d5d-08ddfc3092a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i86K6PDHwIddN405f0ni/gVwIx3KHEYWwMWCveCF7Ikm/dc/CKFa1UbKv9fk?=
 =?us-ascii?Q?bosOAsiZWFDwggE3xOrK6NlTnsdJ/N8TTf66T8/3ekD7jn2v1no76eeuBUoY?=
 =?us-ascii?Q?6LdCj4kit0wMVe7AOvdETGRUxR5tSz2jd/9UNU67yElDQpY+ohQQ0xjpz+HR?=
 =?us-ascii?Q?PclgYilTyXyviiyhmmjtWAKE7OnL5+Cg9Qs8RxXGbS+/nzZXJT398FytlArI?=
 =?us-ascii?Q?DcPNMJ+unAGl7mEFVPivwWzSKwiHblcQgaFg3Vw9XCA82eNE5XFvyY7GBG35?=
 =?us-ascii?Q?Fvf0EmiuG1ikIUK2kLGlULP9oWSdHni7zqxj2jUvgyK9ntuAjyQHUMw82kjG?=
 =?us-ascii?Q?jYgxyC21RATylgm0Bujxmtt0GmkWFUkCOBFzrcP7/CwdB5i/sFY4bN1iPeVM?=
 =?us-ascii?Q?nGsHAKVAjJPlaU6WHhwQgo6rhJwMwbQ7XXPfuLziA66TmzvshDdPJD/UZBwV?=
 =?us-ascii?Q?i8sHce0P4YJXOSh4C/D0EGPzYOkHxUg5NSiw+LhtXwbz8rqXCdUgrHU6qFPW?=
 =?us-ascii?Q?uGNA8e/b0R/meYPLG8VQbnGUljEZqBKbJ59LR1h1PQEd6E4vK5NLgbViIekb?=
 =?us-ascii?Q?DNn5eXKzLLM8eIVy9mkmP7lv3zOYeJEySPF1cAAPlKopDV3ZXjxFEPSApBoH?=
 =?us-ascii?Q?Ov5SM9iXJWt+qRTlxwgRXRWX+CwykZKcY332qrrMiNATy1h/u3aRdku780GR?=
 =?us-ascii?Q?1Ji0CBrdiGc7uN475bYz3VnCPAHcEvBfIWrpMXTkT35j9IqloaHycCpfauEu?=
 =?us-ascii?Q?eIOxWsXaoE71Cx/0SbIRHjvlsSymZPN+e2vMd58ReIBl0sxpqGLrerYs0cUT?=
 =?us-ascii?Q?4V0i9g3KnWldVeywWr/Ufh+sATXLPl3DlaR4At7g/q/RWpKeDpNWcvat3UFX?=
 =?us-ascii?Q?hcmLeEHnYjGAZg4O9zl92L7xPlQb6lg2eUgRSFjQBPAgWJySIlorR+zOfmwL?=
 =?us-ascii?Q?ncsrCCKQ/iXmYN27Tj4YTWL5WX2KHHz0oOZJMWzuOARLrM+zJ+/FF92Xz4Ll?=
 =?us-ascii?Q?fy88xdLgjTpCbNFqFfq1GLawO83YGogCQvyLm5zn/TaeWjCNebD7OJhjJgTJ?=
 =?us-ascii?Q?ocLRV8sakF5bRhxo2iVkKBBYNl9xOZ0tkcGYTl6u4QTUcx3C+96JEnMqXYCm?=
 =?us-ascii?Q?7HX+qYZaKtfndkUY48HlVIxLrQJo5Vvc/KYBMK4NvP3eJcJtMmQQTbSNZ0bO?=
 =?us-ascii?Q?sDLLKX3obgG6vZ7qB/I1oaeqBqAhIgo4KB2iySPJER1f/GM/M2FwAj+mjUpX?=
 =?us-ascii?Q?vH1IHgIRoLmBQYWnvKI1GTU96Fonv/t97CUJH1/c9cmAgCeMr0UK9Kouq0UB?=
 =?us-ascii?Q?dcR1duRkLMgf6dP2iLneNpiO/NTfkxuiXo2uek+nClzdA3mXqA/PNhIvFhZu?=
 =?us-ascii?Q?eniVreDjDaxqvPEqV8A40Xq96WxWEKaMgLBpEEcxUPZaODE4nSA1hG6KQTVQ?=
 =?us-ascii?Q?+lkBN2kKwaJyLMCkV2YmkvTbsgXVl/Mh4fqWwVTQyPy+vz/APbsl1Kh+unnr?=
 =?us-ascii?Q?ePMCD0/JQVeroqC+hUF+QpXGyt9I8EO/zDZi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:39:30.4464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a15968-ac9c-4a13-1d5d-08ddfc3092a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

On Thu, Sep 25, 2025 at 09:32:27AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 25, 2025 at 12:07:04PM +0000, Ankit Soni wrote:
> > > +
> > > +	cfg.common.hw_max_vasz_lg2 =
> > > +		max(64, (amd_iommu_hpt_level - 1) * 9 + 21);
> 
> > s/max/min
> > with 6 level page table max will be 66 and i am seeing boot failure with
> > this. Please refer below fail log.
> 
> Oops, I added this when rebasing, thanks. Just to be clear the max/min
> fixes the oops?

Yes, System is booting fine with this change.

-Ankit

