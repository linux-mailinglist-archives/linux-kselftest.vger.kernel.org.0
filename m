Return-Path: <linux-kselftest+bounces-31823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D7DA9FCC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 00:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39EB1A869BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD3211278;
	Mon, 28 Apr 2025 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ui/j/S94"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A815687D;
	Mon, 28 Apr 2025 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878371; cv=fail; b=sb5i+yIKMslWDFZXFBuD5QJGn09LedgxBnvoo33lUILA+JaplqXEZE5bxu4K0dJE/SDJC5y7Wnr6NsCS6BnO46Kkt2C/B0MOQQIL6vEZG7YpqRXq4KZLhBmHxOTSlvSgjVemevmG2wtQQuA0bdajIHSXr1geKoJzJwXsHyZleDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878371; c=relaxed/simple;
	bh=JA13sP0GcwIBE63NkqrPCDWpD5tKr3T/bTZGMbvTb0o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFnAOT774Qma6rmzwJJ6ud/MMpqSlFyEUKalmJwn2ulgdFXurGQ4DF92g9bdaLuPRY4kiawW3OV7QDJ1U4PFWVbAzAuPKo0aUrTn5xCZKl/+8ZDjlTtTYzl1tBegmK3sxY5+4OhlBJlrQkMM5mYCZBwQP9/6oXFgbVjT23hO2Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ui/j/S94; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEm7btUQPoqFrSUTOj639S5qfIBVpdUu1x5yBTyVElaGDe8arPFQvzw6Ys1gX98z+nE/Lp8VojV7ChxuGIaAhKpPTaPIRVmakCK97W949yCFjk79vJzdTM1U+nS+sMlgOMPavSKoRxZKF1gMRtwHd11WLiRIqvh9gmClzH42KnUQkoySK/k7IEHbR0pTlE/Juyt4I0thkJgE3z7vD15QWsSqjEEM2fSx+X7cNIAZJXlbNE7Cq4wVy06GjN9sJmhqF1Y/YMipwNyEYYzNuySGbNha+eDc2cZHAfBlJ8S4P5YuX4n7c5tdgAoszKLLBh3nW5nRhKWOFVm/o6FYQr5Vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb2EcoRg6jaM2ibrKTd0COtu7vhLgUO2VifOQvAJf3s=;
 b=ogdsc6W1GTCj4ltM24zQKhnPnEKgsvAEG4xjY07OtvKKTHIsh2sFx5hOhT0cwLR34G7HCWD7Okwg70R3CBtWN2OwMZVqU+Os62c3InU7MdWDQYsFJlbz0yiQYhYsDO6WieQZF0zKo762HxIz9j91lGB0TBIFrBc0hfQB4RmW3lTetEjHELNDDujHJuQMhZW+Qc7WEl73kQto9NWhB7T2dyn5yHR0FaypYh+YTvNgu+u/H6J0sCH1fxt+DpkJD8kp+5c0Ib98gQz2JB9Gh7cLusnice1tTkthrwJnJDB263OpO9Act2ayFyepB4GnzQU9m4KC/7aHxH03++Go9tQK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb2EcoRg6jaM2ibrKTd0COtu7vhLgUO2VifOQvAJf3s=;
 b=Ui/j/S94JkiGrJYbRr6WkLfZ+k/kZ2a9k1t2Dfg1JHsDdFoDRsH91aE0VbmjZkPtaecenlAX9NndXP1eSWaVXxSRu6BUo2yiMgufDLMNJlj7VregXBV7Bir4auNtWOfNXctYGxJ6o/uBog09Sj5wT9VPfvZdPodcL6GETJ9cat42PUIuK6nn4zHf7U2oeLhIKMjNZhwWiplNCylHuFTTCY/pRL0uPD+oZZzUPjxk6RIT1R8D51h6WVl7kX3HRn/No5nai6rxtw/VahJtZXM9b5ABwLaHKIgaEZOtjpdo76DU2IZLdK2PE+ovQy6MldoDdBRsgpqqMnfkDdD4bmUCaQ==
Received: from SJ0PR13CA0217.namprd13.prod.outlook.com (2603:10b6:a03:2c1::12)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 22:12:47 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::c4) by SJ0PR13CA0217.outlook.office365.com
 (2603:10b6:a03:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.17 via Frontend Transport; Mon,
 28 Apr 2025 22:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 22:12:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 15:12:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 15:12:33 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 15:12:30 -0700
Date: Mon, 28 Apr 2025 15:12:29 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aA/9TZq99TF+MRYv@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <aA_hm_AD4Xzm3qJZ@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aA_hm_AD4Xzm3qJZ@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: bef927fe-e002-4840-107b-08dd86a1ce6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Pri3Y6tUQF1pKdLr8WDSB2EaBja4FRMGBvOnrjvtygxdq0gc7Ivi2HWhS/x?=
 =?us-ascii?Q?qn9k7S6ddLJDkZJRx0SeLJQ8qT62g3V5wrdIb7bfTBJcTMH3crDmtlUyXOWi?=
 =?us-ascii?Q?ZE7xhWtpHxJVnl0xWVWWIqXR2q/LYSP2bubgvwvu2FPAEdJCuEaRhZ9UcEBP?=
 =?us-ascii?Q?ryzA4FziR+6T6fPaRVGTodRNLVk/8eEUDkFks+0rhaSwVdS1peM7aD7DnzAB?=
 =?us-ascii?Q?DjaQiU3oW0MPMmJGMsbo7WVR3GpMn9IzuE5wihIv/ESE3162ju6wTbYwsNRe?=
 =?us-ascii?Q?CmIBcL8AMXHWswVq+iMgcf2KCFw4ehmSeVRfaGb1Teo7QY6PvKN/R5JTYja0?=
 =?us-ascii?Q?y6jr/nNyfzwQU8KqWzxlGP6BLDDCi2dwc3wA/zY5jsKCcvdAe9IYxnFl3ATk?=
 =?us-ascii?Q?wRrAUZOKjbhyXh7JsMJXn3dckTDbX6I3QzMiTHfV8AXaodMIYvvey+jFVYDN?=
 =?us-ascii?Q?cK2PNW4Rz0Pigdj3/lIp6zcX+1H1AneVlcWeSu4fi6sMVNdQkRZae18FtyYJ?=
 =?us-ascii?Q?+d0whIQkdT/OhRgRpVuQg1JFbSyFt6cXaq9l8qq4O/bCN7kqb2XbBPMVWMYh?=
 =?us-ascii?Q?ChMEGiiZtyA40C6uFvFHft37WooOvKGVn9Ih8jk+THrmTWUGHrKjpNZxxbEQ?=
 =?us-ascii?Q?M1CH42rSner+ufmija88ujYJaFfwLEdyjJFDcLwdBuw6Thl8ddKRWC9v61Bw?=
 =?us-ascii?Q?V9Oi1Y01B1HgL2BiZtBgxf7pn9FV6i4Fg8lxWnGXp8MG3B2lp16ULyw1zWzT?=
 =?us-ascii?Q?K2zWP91A/IWYB9Z6YSflSLGJ2/oT16RQM9GbFGz0Ot70Nw40aLUUp9OTUx51?=
 =?us-ascii?Q?t/Ic4+rTRT56JdPRxMW2mz1NqI5ld8iuPSz84CPq84dps5GQnj5VbQymttMl?=
 =?us-ascii?Q?uS4bnNBCRaL0bN6fXhoTxNx/jtD+lqc0KXB9/HBDf/zAMO60/C+FgCSzEnvW?=
 =?us-ascii?Q?Zb1h+s8Mqdz7ys/O1pqi71yvJimD9butx/pArTZMcWKcem1Ugz09Fy8X8Zks?=
 =?us-ascii?Q?izFPHW+5tY4r//fZmAuhJ5arqTsJ9HMiNrKKyAePGL46ijezybTSFARjdD3p?=
 =?us-ascii?Q?pMP4h4QqbCEHWWgUCAeTYPr5++Yxzrne8BNbG0+gVIVtrKqYVWgVU+CH0PRO?=
 =?us-ascii?Q?2IGUId2JrUQTjgvpyW1rQsuTN/py7Ly6YB2mg2QpVY5E93qhF0LlzQKB+nTx?=
 =?us-ascii?Q?zvHNhl9hKUk/9bZyydBs7AD1k67kT3Q/Sp4q/De7p+cHKvdOimBvMjmhV2u8?=
 =?us-ascii?Q?A18KBEMcTJhAAmF6IBN53h5Hx8nS5nCsfGhmt9pmw+ZaJPxrUb1yBH2D3pH8?=
 =?us-ascii?Q?2H9PSlKBEx8RF5vNQgBzgjHwfiOLsLcT0UWLjBkbndYwnb9EhlIwupxFzpbn?=
 =?us-ascii?Q?hBt8ZtTcVjMR62RWMnLk50PiqGMwimZnVc8If73TzgTLoXeS6CpoTvL5j1Wc?=
 =?us-ascii?Q?YhYmRLIvF7mH1Ir1f3jt0mdGED21po4JDPI41hS6A/ypQBdnumXeITYppVmV?=
 =?us-ascii?Q?/1vMn0saU6NQOmZW+uSTRCyQ5B6cNM7Mt6uC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 22:12:46.6937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef927fe-e002-4840-107b-08dd86a1ce6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979

On Mon, Apr 28, 2025 at 08:14:19PM +0000, Pranjal Shrivastava wrote:
> On Fri, Apr 25, 2025 at 10:58:03PM -0700, Nicolin Chen wrote:
> > +	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
> > +		unsigned long last = min(last_iova, iopt_area_last_iova(area));
> > +		unsigned long last_index = iopt_area_iova_to_index(area, last);
> > +		unsigned long index =
> > +			iopt_area_iova_to_index(area, iter.cur_iova);
> > +
> > +		if (area->prevent_access ||
> 
> Nit:
> Shouldn't we return -EBUSY or something if (area->prevent_access == 1) ?
> IIUC, this just means that an unmap attempt is in progress, hence avoid
> accessing the area.

Maybe. But this is what it was. So we need a different patch to
change that.

Thanks
Nicolin

