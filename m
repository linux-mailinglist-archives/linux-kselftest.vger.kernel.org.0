Return-Path: <linux-kselftest+bounces-35160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7131FADBF43
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAC37A33E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 02:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834E238C36;
	Tue, 17 Jun 2025 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kf8cq3ad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26932BF014;
	Tue, 17 Jun 2025 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127906; cv=fail; b=M+Fe2whr4DDlQbMd20Bk89/0IDwySnmcTamXLjhC9PxTNbjH97CVcyYd7+F2M1JN4MkDpe07ErRYo//M8o7UFQ3esxkuku+la8NWaaC/lU5mwjf2beC7wh1YRJk6JtDis2lasOB6Y3vYFDOX85Q1W73tgrD3ez6HhQ7PJFICM44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127906; c=relaxed/simple;
	bh=WTr1Sa9h4qLQRDsavvMjKM3Y4zefb+tlAitNaI3HqkY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdwGwlSss3Ab4LGfGha0eZ0tHori8OIKFe9Y94v+TbKtnDZhCQ3+XdmkAHf8LWb2AqjHpPUR3y1xgX875mW8HgqRwP2pUW3lp4TLddCOiob0nI2agvWqvnprsepzXzzWv8GnjHxrh933tBnyAlMDkICOwx33pOtDSHeN2qg9t58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kf8cq3ad; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO3hXwpF4WpmpuFVvc8yoQ4KFKjz73MjfoegLua0kPPqbWnd1S9B7oEWyIz5R3cAMsd90Z2Y9XFk9mpb9qCUJfV9S0VIiEepn9F82rvYj2ucm3KghsgGZ+N6HtGvN1v3bQDKHXpL8CyNCoViXkvY6g/U8jeAJFmmeeePuxUEZ4czKEJ4qSjJgVDfltdmIfnqm58DUH+3JcqdhLgnIkLPAA4r6jEVWseca75WVNqfMWN64cBAPMwV+7K5DgSNuiA45DO10C7mrXS8KkQaF1Odcu8NQUPCqGkzQV9+8NgG4EvCdRuopCFxeV0AyAHX+8q0zrqhL0YvUj1bXIXLspMtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6jA5v6fRgHsmHCVLx78rPaYT/+hVNg38KhUJYbMBBU=;
 b=dEDeNIQbnwtApIxw1q5FNFnqwxS1FBzGp/85JiJDefz+8oh9Y3G9xq8xAi10A5zh8y48+C7kvh1mjDqhHblaFhzHfp0PmAROf8URQVzg+mN5uVLcDdQkpQwRTvV2YFTtgj8JcpempuC9WXbCrbZBVHYPYC+1ds4o9sGiFiXqOB6Odgn/BvQ2yVDrPuCXEG9poVJaNln3/QuL/rReYBKTxAgARUvogAOptkNkLnKs59I+QGbj9wndXmdcz/TzczR14FPP9FvVpzEY7WkWXwTT+vNhQSK+PUceNEp4rGuBhkzCqvyrAp8dbxHjXT3vwS0a2LI3UNsTKlvJAub0BtWXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6jA5v6fRgHsmHCVLx78rPaYT/+hVNg38KhUJYbMBBU=;
 b=Kf8cq3ad/IzcCJHexDG5DFiNrkXZQmZrWAvN/lyagP/K3Ce//T/GGephP3UcMFtnmUFNq8tvxsPzgxEE+/Bj38nLbqGSd9O+RJdV9XKA4/4TsZ/4Sib1Gv8a6zIozXuXazelOOIcefJgZB2A5MBqPvSbDUG3AK+7RQyGCQ3P8OvXEnHNxlIlm+C13i0/7x3seW1i8QHElM1H0OktJAUQCBsYHJ3ZO4G8aU4LKfzYxFJYOpsUooqCtjDT2djN0lN7c19kznt/drjaUUDb4OXuiEnBCR2SPOAMEJ4eIXoKzLVn1nXbMmjjsVbO0UKhldae3E+Cf/yMnQGEyJIsollqoA==
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 02:38:21 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::90) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 17 Jun 2025 02:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 02:38:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 19:37:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 19:37:58 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 19:37:34 -0700
Date: Mon, 16 Jun 2025 19:37:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 13/25] iommufd: Add mmap interface
Message-ID: <aFDU5kf9lQmvNDdd@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <c9929e0c9ec6f3f6348cd0c399d6fdfa9f35f973.1749884998.git.nicolinc@nvidia.com>
 <20250616141319.GG1174925@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616141319.GG1174925@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: db24ea9f-4fd0-4e51-07ac-08ddad480659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eVo3y3IywqA2qy5sUtc5/ApbYNneVTL2QJw4J/r/WwBRU/rwpx+pGqDWqcAZ?=
 =?us-ascii?Q?9myyWn6f38Zk5M/he6itX3uu0Q7Eyu1fXiZ3QonyTUQLnTD4OeovnR4ZncAi?=
 =?us-ascii?Q?VP7bl5JHXM4sEL1VGiL6lDWbfgWH7LvfdfLjlEjYy6jP26ueW5Wb0M0ThOtw?=
 =?us-ascii?Q?OBaAaVAtl1KQNRxYIEucNMIfsy0wpYc3tSSnh6Ez4kZsfnqksec6laIPUvHV?=
 =?us-ascii?Q?ZssUWTOlkvAx4cyZkriWFlyZdyWGodcikPWn+N5wVnNeE4LvqNSGzTg2VM8U?=
 =?us-ascii?Q?Y0ZFgQDOX+StmciKe4BWCwBFHI094cPWmsCLGwmjojYUYQYnm2oQDI/upDD0?=
 =?us-ascii?Q?7I7g7Pnr7zG2dA2hYMhRSTDJVAa+2hUlAvTFRPg0meCw0GuJkBM/8VSp+y4E?=
 =?us-ascii?Q?evl6SihIQiIDl/p/MHnH8EStxG3DWDk3C4dnjDVABnkcuE7gWtT9PjldzuMJ?=
 =?us-ascii?Q?F7mL4FnsNi19IKxrFMsiFYVmIhNIXsO0Fsox2+2g/AI9AbojXWWfQO9QGKZz?=
 =?us-ascii?Q?dx0wUUKVjeY3uLgbrU8qr/vGNWQpBbLWsEjZfU5Do1Rwx3BZlmxFyGkgeCYr?=
 =?us-ascii?Q?dwLNy3ckiReq2G+PtDfmpGk7jk97dZrpgWx15hoepYgwskt4kBQmPx0Kyy8g?=
 =?us-ascii?Q?4Kdvi3uORnFgAOVgOdujPyqU8IV7O52FZ2P8tSbcvj0Gc9renprPq2aXjTXp?=
 =?us-ascii?Q?ydsECE77R82p80wJ0BP+cy4i8f21Zv35cnp4YYfXnTcbFqF8hIF8zlFy1JHU?=
 =?us-ascii?Q?w2jmQPAbwP2ig7IgcdANlhiWC/A31gp07l925ZUTifIjLsp5/sm+K8TygMib?=
 =?us-ascii?Q?ZvAsh4cx8S1EypGf5jUvb17vTdwMIjxQPn9vWmxRcQEn76PaTbOJVnigXzAF?=
 =?us-ascii?Q?vaS//o8CGNARMjNjKf3XAhdOqHPO61OET5Opo/jB3rIRoyYdgQD7jBpYP0ZM?=
 =?us-ascii?Q?8QYcFLZcuc8fBVzB+yrd0EV3+clLnBaaTr+LwZ5+wj54gLo8wtfTGqg9jndk?=
 =?us-ascii?Q?M5wO7WHrx6XkbUBe5Z0NhULi3NruhC4DJkIBnRAmX+NmqVckcGyv8aKHZTZ7?=
 =?us-ascii?Q?SCpzMUT0ARd+k78QmCno9aYOPIz/YkNWQWPIy4QTiwdvhM5DfW+9H3vn54zn?=
 =?us-ascii?Q?5tV3+EgYsX/PHUQTZJ+ll5xTtXmCm9NBYetyLQCBUWN4yeIPoXx01hOb8i+R?=
 =?us-ascii?Q?KApKXgblityMsy2+sbdNUQD0cjcn1d4IejWXhpYMBdLX/8x//t/cvNpeEwMK?=
 =?us-ascii?Q?a3amAY7FyCo3je+VOMtNxfSXYEn/A6OdUbd5jrYZ8wvzIWWInGA5T9GGbLrh?=
 =?us-ascii?Q?7EfPrcOLoNEdhold2GaMQ+1XwgKbyCUVpkYWIJxiIUrgSPHNAs3i5mcJMQor?=
 =?us-ascii?Q?qjpCjJgOCe7rHSf9+RpI7gGhKij+KolrFYRY8f+Ddm0Qew0T+PwPm96dNq8d?=
 =?us-ascii?Q?NEUX/oixoUdbM8xfKKvH3FNMr4gT4hl/UWT/tgr3LIZFfpDGSBrC5ADzBxoG?=
 =?us-ascii?Q?0R2Is7eRiEx9Vulg/0gupFGAEQ63U4vOA3yU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:38:21.0304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db24ea9f-4fd0-4e51-07ac-08ddad480659
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448

On Mon, Jun 16, 2025 at 11:13:19AM -0300, Jason Gunthorpe wrote:
> On Sat, Jun 14, 2025 at 12:14:38AM -0700, Nicolin Chen wrote:
> 
> > +/* Entry for iommufd_ctx::mt_mmap */
> > +struct iommufd_mmap {
> > +	struct iommufd_object *owner;
> > +
> > +	/* Allocated start position in mt_mmap tree */
> > +	unsigned long startp;
> 
> pgoff_t, looks like this is already in PAGE_SIZE units.
> 
> > +	/* Physical range for io_remap_pfn_range() */
> > +	unsigned long mmio_pfn;
> 
> physaddr_t and maybe don't use pfn?
> 
> > +	unsigned long num_pfns;
> 
> size_t

The mtree stores in pfn units. Looks like you prefer doing in
PAGE_SIZE units? I can give that a try and update them as you
suggested.

Thanks
Nicolin

