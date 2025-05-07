Return-Path: <linux-kselftest+bounces-32610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E0BAAED9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048BD3A9B2E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE4D28FFC6;
	Wed,  7 May 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eTb80V4p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133DB1D6DB9;
	Wed,  7 May 2025 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746652202; cv=fail; b=rqlY14fYHdjrdIVKavNPr1sT4aDnY5C1rixz8bySkxH2czebk8Kez77RfwnbD5ay0h0AMe1jcTJ3V+Lv4YvX4D+r2Nyih1IlMT1Bxc+q3Naf1smD2hK+mZkEmPKXOZNYa8FXkNPIO+XOYav1HT+AV8fRMKj7I9qQnxfhtAnZ4vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746652202; c=relaxed/simple;
	bh=JwoDFIdvUd2ZOQCAt6CnL3L3oDch0bFAqOJgjTjaVfE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4cGeoF3MkMhc5sBqyNawv6MpEf1Qpq9r4osUtO3ZdkNO8l13Nr3VmigwGFLKNgnu31QMITclHzOacPSBsb+hUOilFJy3bk872TFgRJclrqwX8s6HZDC/1/+HNiJreUQ1+HsJZQdTXLoqg0bra6rHWxQYpWNE5vmbY09WKz+euU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eTb80V4p; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJBOrBh3LGzReMTjUQqbJ+Zx7a0rMtOwR/zaSbGRR6Wjm5cTVvvvDWnwPgEQtrMq1hs/tAU4DtcxwXvG7hlJow9fJaWaMUH1undsSYHJrbglDJjxJe8bdarUQFPDatj2TGJi194dBeo8Yz8g/JHhyfo3RQoC5QghB3NLGsDftiZ/uCLJkRNqsP4bHHM0TojcHauEYDBUOjbdOhvCd1tTaM7gubuGZzQsfUJ8t9Z9PxvuafdXZNa1Kvm4qCJdOiW1KaXnRzLdAZ+V6t2rPP9GvQsulNnSGMPfwmatSxIepvDPVL3r9ZR4Xbsk10fCzTI34EwCYfmPV7FtYwEYXw1FLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIrmmYrV+AC9wM82x4BjH9q/r+1ItWuMKgWIaVHFD28=;
 b=wZ2PPzgA6ymQ75pJc9pGDjU+Pbs1VYGI8nxT925ArUmOwOCJcqZTP0xeYt2eImPvDnpB95U4JdPW+XDd2Uj5h8CxdVL4scTbI7vjbVtQJMYM7J0R8MPf1mCkiW5jNNAC/rOkJlpYpKTdBqjPW4JWIYpvaAeqsb6ISwd7AUdhGjYONQ6WsGkCWO6h8bEottZUdD0pfu2bWwdGpxDoksqWOgScuetvklgMhXR+ek/CQqoDNcGXG86wQOiIswImKGWNB8OtBWmtVpRvd8E2vWhdg9VdPntGXfj5uNE1qvKl1Ve32c8p4mGvA/CnMl/SeVXUi8Lq9pNmz1qbW4cdp7NFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIrmmYrV+AC9wM82x4BjH9q/r+1ItWuMKgWIaVHFD28=;
 b=eTb80V4p1OC1z/yxrAlRBO39EXfxhehuQiDS9TSg2GaMUlYsTDG/AMdge8Q9iiEClOr0G0gDfOc0Kbx2tABKafdnxym+Gg1T+zwCGjL+x0PmdAs7DQSizRhhjK4a1io8AhQ765JiNPmZQKo1bSTIH7y5R6Q7WXDF/D+dBMSsNvRTr/w5ChcC5++7kGcHKvyBSvFaiJPXopOraSf/J7TgQUuqEAM1voYncZqFat1uza+GcSgkLldsprHIJc6Ob1Nt7nGUVt0Sj/i/yL+mgel21yEa0+kxlYDFvQPvum6a7ZeB+cwnnNMFux5wF+z4JVBCujSHbZlr+gVgHvakHvCidg==
Received: from MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 7 May
 2025 21:09:53 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::48) by MN2PR15CA0043.outlook.office365.com
 (2603:10b6:208:237::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Wed,
 7 May 2025 21:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 21:09:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 May 2025
 14:09:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 7 May
 2025 14:09:38 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 7 May 2025 14:09:33 -0700
Date: Wed, 7 May 2025 14:09:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBvMC7dnYghoX5Aq@nvidia.com>
References: <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com>
 <aBj1Av6Xaj8flMN+@nvidia.com>
 <20250505173101.GT2260709@nvidia.com>
 <aBkWoH23VysYake3@nvidia.com>
 <20250506125222.GW2260709@nvidia.com>
 <aBpjbtRgR1nK/LIm@nvidia.com>
 <20250507123901.GF90261@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250507123901.GF90261@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 7614b3e0-f743-4f43-ee17-08dd8dab82b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uhBi/NrWFo1UbsIt1ttcylzSbiVD0K8gP5k9wYM7T6CoF2x7O8BdVycFMs9E?=
 =?us-ascii?Q?2mwpLnoj49NBED74o+KslBseX1xQOhmycRqkoCTEdI22Fw7qaa4mRYlkROxf?=
 =?us-ascii?Q?VSfPxTomA4lr8QvXIL4IRh3kKVns0+F7PiTlHFdIiNUz/u0HSxaLh47aK13n?=
 =?us-ascii?Q?813yj8FZVDK6PJ51hWbXbNfTK0Zc0FjmGqLS4N7p2nQ4KD+cfaBKe9WNsR2g?=
 =?us-ascii?Q?yc1jNBUjDoE8pAOm4Vl7jrp3tb4KHR55gSmR/cWtDYV612f7EGROt58fTfX+?=
 =?us-ascii?Q?zLM7e+B9lk0bAxnOW0EwslOZ/4dEBg7v9qzV4jkEr+EnluCeQoEYYx7K55DO?=
 =?us-ascii?Q?SQv9YQzeKcwQPkj62blW8PJYBR8Hgu3AG8KYjg7jK1yY6qaaI2VTSYpTOcCX?=
 =?us-ascii?Q?lDiuPMUvYABr0t2jq8zh6f9Iqm6SDRAs5aQuGQeYTrN4aZXIs53/78D92e0M?=
 =?us-ascii?Q?+qXNWtpXJRu7BUW9Yn02+AKcFh3S9SPmRFLdgvrR1PbXiKNFa36Nt1675rMI?=
 =?us-ascii?Q?zHXinXtaPCVCoI0oQQkBQTs5b8r2fLPfBUjpBP9edpgnWEAldP0QobZiHPie?=
 =?us-ascii?Q?PdKI5nTGCHpig3Q6p6eb8dGEdi2C2UO/bs/F1YViujPYV9Pi3/BPW8BG1jdV?=
 =?us-ascii?Q?ARPA9BaBTDh3aw0uMS1Er4Sk2xOP0FkE7lKuroL+gfVZ/dOve+nLba1F6kUe?=
 =?us-ascii?Q?6hh+IOIH+cZA+zVq2WEwQztWwzSJ7NmbOozmq7ZgVY4OPoKqojDkNkW0K2cS?=
 =?us-ascii?Q?8UztU0mMa6YGzejSlvjid96aWlfj+OL/GimmXNQNJ6eGbqAq7Sqsk7gMCCYa?=
 =?us-ascii?Q?fl40OAcR7gvcGS+IHglYNoSGARZ/8Lsc6xp5+zHyrNKCVSU/qPJsWcwhN+AH?=
 =?us-ascii?Q?J1vNI+1cjz4DIcuu1R4CiWg7+4Ft8sfLCG0K996Tj5b5uvO2gTn/J09v5dKa?=
 =?us-ascii?Q?muxYECJg7V2ueeNisB6KLDKlVjsKWGVrP61E1tKNBjX/TeKzZQZG+O7d3zYW?=
 =?us-ascii?Q?rRdnnznJZ7FoKSRiDBj1cX++RVu05xsbFLtfIi+v+NQ5A2aHFZH7g2oBSo6I?=
 =?us-ascii?Q?pMVJ7SENStscC2gkPCB5l9nGN4JoDy0IwWmZLY7SrHngpszvdJzaOVKFQrcB?=
 =?us-ascii?Q?miomGqEtSznaVsoE8tKiCiESbuOogmDm1GA56MAnRAKEIINzSNtwLabQaYMV?=
 =?us-ascii?Q?v4NLWR/EGj2+B7NpQIyyoL5w2T1kIDR6pNZuzkxcvo8zav7L7FiI1G5vaSEk?=
 =?us-ascii?Q?BLDCOA5PQc/ruGpCkRP2EJrRWfWr/oE4fH9FcpRswWPx3vfqkmSKJ8LfCthL?=
 =?us-ascii?Q?CNA+DvVgyIvsT94sXG3wlih5IsIIaGaxPmCS1nwT6H2p5hNFqG/YSX1/aE0i?=
 =?us-ascii?Q?2BvzfSQGfn759ZUP0JhJHPTYEyTvqFptP9oJE1IEM2ZoTBaaXrAmYCNuMDlQ?=
 =?us-ascii?Q?o6mjC5WrkYb8w30TJk6HgpVh/DDadPRsi8Pz2KdfJEfSSgXovhFC+S5kdwix?=
 =?us-ascii?Q?eScAk6gXTfpnA6i7rCchUVHDYD7N84cCrDjN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 21:09:52.6195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7614b3e0-f743-4f43-ee17-08dd8dab82b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644

On Wed, May 07, 2025 at 09:39:01AM -0300, Jason Gunthorpe wrote:
> On Tue, May 06, 2025 at 12:30:54PM -0700, Nicolin Chen wrote:
> 
> > So, if I understand it correctly, what we want to achieve is to
> > have maple tree to manage all PFN ranges. And each range holds
> > the same entry, a structure that we can use to verify the sanity
> > of an mmap? Let's say for PFNs A->B, the tree should store the
> > structure between index A and index B (inclusive)?
> 
> And tell you what has been mmap'd.
> 
> > If this is correct, mtree_alloc_range() that is given a range of
> > [0, ULONG_MAX] would allocate the PFN range from the lowest index
> > (i.e. 0) instead of PFN A?
> 
> mtree_alloc_range() returns a new range of PFNs that does not overlap
> with any existing range. It should always be called on O->U32_MAX (for
> 32bit uapi compat) and it should always pick the range to use.

Ah, so it's like an address translation table. mtree_alloc_range()
just gives us a virtual address range (i.e the cookie) for mmap()
to translate back to the real PFN range.

I have another question: while I don't think my code is handling
this well either, how should we validate the input address is an
allowed one?

Because mmap() is per ictx, i.e. it's a global translation table.
So, the following might happen: let's say we have two vIOMMUs in
the same ictx. Either vIOMMU has reported a cookie to index the
mtree for the real PFN range: call them PFN_RANGE0 (for vIOMMU0)
and PFN_RANGE1 (for vIOMMU1). What if a buggy VMM inverted these
cookies between the two vIOMMUs, so it would end up with vIOMMU0
accessing PFN_RANGE1?

Thanks
Nicolin

