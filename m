Return-Path: <linux-kselftest+bounces-31934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F0AA1C4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57972461B6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425F264609;
	Tue, 29 Apr 2025 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pynHXuf0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD9155333;
	Tue, 29 Apr 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959168; cv=fail; b=myp0C82bhCx44rcgauG0yzzt7tPWcrFmQ+FwB7FRTAV5z/O39kK4hd+1CIcyXE91Of9Q49L0dC4vCnOyAW4UANqb4iu63BNa3qMBOaP5LkDlqYioq4hKSI2NwxkpuLb38nka/WCDzMASRFictetYBEQ9Doq0Fw/ss2lAH38Uyw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959168; c=relaxed/simple;
	bh=hAFn2ekQjLVookayjMEb/jsm8KRKnK5posDpkNeUqsU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU/PyGbkwqKr512lgebbkEnpOt56vSqNz2sH5WGytAb3Yw1WZZ6a1Tb91VRzajoh/2tYM3oZExy6XRtUZhiVGg48oAlcqhj/aW9cRb/NBBQcWpHkuiy20GvoVPBf6jce0NKJLih0aHam91PDgBMHdyxCWmqAS0lYQklHdaP4mTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pynHXuf0; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUqaE53g2/c/lAMj20WB1aHZkgB6t7UOVfymDTwhToJKpw75Ye49E9o56IWgJgspqWGEPbD5NiUyrl18HA3mdIYeHpXBhCLfbJqlRa4ME96RNV96PjwX0reyY/CBEz2GNcSYjrst4fXyO4daBTt5rru/uzyPZY3wW6M7DGU9rzZx1rqC119bBhfPg0huypcVLHw6YEmmiUKnQLLRr2juMKYs4hHqihUZBkT7jEZqR2vnBoNQGpr5JGnJ/JrTGyrSZAi1G6gunPxjHptnN9IwzcojWuWRUJQWHxiGFOrOc9azPQcJJKi4dg8SMTLN2OurTIy3v8Hp0oGhp2mn5IuYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5r3woOPXDalVu4PsqVoHXSHDzj8C57E2cFopfWiB+LE=;
 b=tAWLQnl3JOjb3A3ryOeQEquDKodU6XPnvAoVg5jXjkxpojwcBAF7AsEufTJrjDDsWoZwQl/ZQGAaOfMNEmTMgRSl//Un1r8Lxh732oOn5TnQ4nKtG6GtGjJROLdhTAXXyWS1yCmtVwGe9ytDWeO8oymxat4UfSWNFTjIrbdlMVyK6qB8HFQL7ZiqVlTCC9qck4nrze1o477KkP4zzgDTqO/YuVSH0fFdc9an69mf/MRZJCGa5IeT7FYuoBtuNsleTgOoqZm6hBPb4J+TWSE4JBDpGWHCPHcILAzdkbglUrStxRPOceEtML28MUmAETXcUj6ZQD8KsCrsvsNF0fGOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5r3woOPXDalVu4PsqVoHXSHDzj8C57E2cFopfWiB+LE=;
 b=pynHXuf0m0w7xy6X/gdQY/yWwarip8PccwODKhv33OQ3yctilpafpznmZTnHdVpylbgIyooVDDkUJ4Q0RERBQL47u5lEBqM+CVzIJD41mjydMwp2ZUWHX1n/nJiSJfon3/jSNTnPJ/5b+Mv2uiU4bMBwnTgo8NV0Iq6dJtepu+UKEiGQdLqTCqsd/+l3BXiz4xI+slFz1R6QNQuFtG/IZClscLjNf5OUNL6zh0E/fFUsXPVJ1iqdE0Ape5HTsW6q/8NM9X3d7Uj3DD/uUcjlSd68cl9XcT3rIFNStMwu31D5i7FBbnZX451WCAUErisirde1fKYO8bbfej9Gd5Dl5g==
Received: from MW4PR03CA0010.namprd03.prod.outlook.com (2603:10b6:303:8f::15)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 20:39:23 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::6d) by MW4PR03CA0010.outlook.office365.com
 (2603:10b6:303:8f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 29 Apr 2025 20:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 20:39:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 13:39:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 13:39:13 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Apr 2025 13:39:11 -0700
Date: Tue, 29 Apr 2025 13:39:09 -0700
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
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBE47aySzDp2lsAz@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBE38GwvGBnpRNLc@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b09f0d-63db-402f-13e8-08dd875dec86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ALelWJad3ruw0i5Jsx2taIuVlZyZcmaYAQjyT8CtakB+05jEblB3xT7BBq4V?=
 =?us-ascii?Q?gzauX9tK3lLXzrNFU1k6uQvtpTRMK37O8VasN7TW5xtLBW+fVTW+oPVWfItb?=
 =?us-ascii?Q?SjM1HZKb7lh/JqZSdzvX5UoN8+8qtH/qY8BB7wRJgo9J8r5WCNNif1XBj0Pk?=
 =?us-ascii?Q?Uoqa4aTfgQpf461ZSa9bawJO44N1q/JfPWvAb48CYQlqzcdpLamzfb1l8MZ9?=
 =?us-ascii?Q?GigMBxoa8cAguoTGxFnNIJW7C/s0UXViEcIQhAtpvBylFOqdbuHN/NMKefW3?=
 =?us-ascii?Q?cWl0qupembBbT01M2TUZBDB0jriPGDwJ74BbNfSUlD7t+x30ommE4F2gA89+?=
 =?us-ascii?Q?5uZA9LEylX+8htv4bKpt8L42E5Q/0kMyuJ6Fgfme+Ldxb6k6YxqP7O+lEvyH?=
 =?us-ascii?Q?y5Cb8V0aRhYvqC7rlyYY4ckgYRwjNEIuM4gWqWIPLBIExUwpT4EXLhQylHpH?=
 =?us-ascii?Q?JlNID7heWEgxe+LT8OM2J6w0iYR4kFlzlhm8AyJU4AsSeSzpo9wTIMMQ1deR?=
 =?us-ascii?Q?yrw8JL35xjwMX/IXu7r/X+VYZNvhbB8RY32qdk7ifKwEaRfZz4KNpDMM08xi?=
 =?us-ascii?Q?WfbYa3CHD6A5jq2shvvIPzXF8yXRmCY+H3QTfX8ngMHlHG+MeTG1pUw09hqt?=
 =?us-ascii?Q?HXBcn3/X99rxJTa27mgh1HhvrF4Nciw2aoGLahKcRktOiKBiIf730ZjO1ryu?=
 =?us-ascii?Q?Tu9/vxBiaJNqx3oTRRtnmZTwuo2JCMeRzgiPnr1g/9L8vRhAtHKOue2N6OCp?=
 =?us-ascii?Q?aN+IO3DoAEt2jVL+bixhnvT09P0Oqc/lTUpviNldCTdVPYTSoXC7DMD8X1aj?=
 =?us-ascii?Q?Xgo6wjNq0sIYY5W+tVG8T4ObTSGq+3sHuWbY0AlZRrAS5D1R0BdKSL6rZMjo?=
 =?us-ascii?Q?rq2Vp4fDZp3x2iBFfC/CeEEj+w/T3KGfhnlA7pBdABuk94FORHhYWXG0TGUB?=
 =?us-ascii?Q?g2zkUcYVYiDytOTaUyQcBy/kSe8vQ25pc25r+bHx/S2U+xKy6CrDwfg/GfQ6?=
 =?us-ascii?Q?46icCrMBFQBgrX38wI5rIeqOrSWQ65q1cPxRZwa5rLY9W4eis538wZUYe030?=
 =?us-ascii?Q?CjC9AYRe/MbUKadqWW/6rD11CzgmCT7cn0h5OlKW++aSFNZ3hdY9Igre6FY2?=
 =?us-ascii?Q?FiVWreGyliH7P7vK2MAuf0S3csU8MiuvNT9xAFQPXbaCSpbpBE0N8YshA6t2?=
 =?us-ascii?Q?AdPAhDKPs5sn+T4kCPKlxCC5JLVbyTAw66bmv21Xu1wK/I/6NxT/tafORULt?=
 =?us-ascii?Q?H88iZfK4WWkOTLvVm8EODhn46OoReOqKF7VHxLUJ8p7xZAYiHyLFl9NPPeeN?=
 =?us-ascii?Q?MMc/sIBGRYEHv3bK0NGmJLRQXEA+27pX3UUwonmb4PwEyY/amgb5mWCO/JGj?=
 =?us-ascii?Q?dAUlR1oyudXxjH6vETm503ikysx6Sb1S9znlzKfu1SAg86ydDDYzuHuAY//j?=
 =?us-ascii?Q?J17URUhpcQQDURIkj6haT0zrA9rXhGAuIRK8o0VP4PMoRxaRm8/Xr5XTNg82?=
 =?us-ascii?Q?k7XNO/2+QglUL9c6fJ7zO5TtpZQa1nXIAH4x?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 20:39:22.6084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b09f0d-63db-402f-13e8-08dd875dec86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011

On Tue, Apr 29, 2025 at 08:34:56PM +0000, Pranjal Shrivastava wrote:
> On Tue, Apr 29, 2025 at 08:24:33PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Apr 25, 2025 at 10:58:08PM -0700, Nicolin Chen wrote:
> > > +	struct iommufd_mmap *immap;
> > > +	int rc;
> > > +
> > > +	if (WARN_ON_ONCE(!immap_id))
> > > +		return -EINVAL;
> > > +	if (base & ~PAGE_MASK)
> > > +		return -EINVAL;
> > > +	if (!size || size & ~PAGE_MASK)
> > > +		return -EINVAL;
> > > +
> > > +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> > > +	if (!immap)
> > > +		return -ENOMEM;
> > > +	immap->pfn_start = base >> PAGE_SHIFT;
> > > +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> > > +
> > > +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> > 
> > I believe this should be sizeof(*immap) ?
> 
> Ugh, Sorry, shouldn't this be size >> PAGE_SHIFT (num_indices to alloc) ?

mtree_load() returns a "struct iommufd_map *" pointer.

Nicolin

