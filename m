Return-Path: <linux-kselftest+bounces-31792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B63A9F72A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 19:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1103F163DDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E80B27990B;
	Mon, 28 Apr 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o40bPQgT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AEF25D90F;
	Mon, 28 Apr 2025 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860794; cv=fail; b=BPTbfHFBhpwRO8G4AXncd7MtslRNlJ4ZIp3wba3ZK/U2yYTOM1y2TEA8DmS8Z9p/IhFrqlRcjnOPe2W97GBpsZaK2eTtNRvfE1ZCCaZnYiREWd3VJ8rowCTbIt55jaoei+ZXel3vRJ1jagk0AIYXlgxGWikAFRBaWh3o4NnkZZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860794; c=relaxed/simple;
	bh=f4hDQCl5SVhl9urqIdRt9ZYtME3LVmrnarwiQQBbqb8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMTCSqRLubP/fvdzYTt2FCfhcoj+BjVvCyMexThDALOkjdrm2dMZS4+ZpgrCqMxUcspFYNJ9ULc9hpSNUInC1H+fhOqzpQPt4PL4iBSOWIXfEKjJS/u7RZtr0yCsnPJMiqfpptaJYNY/kmiZyc9JR3tz9/OBxw6VuV9PTvLu1t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o40bPQgT; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnCESlkvvV8mKWh9MDY5vjsNdBGeaWauVgmrLnIdSuoFuzv6nxCWHiFXT3yJKGSlkpUrMoYMG38MhItCHjY5IV9dH+obqtjsBO69XGYZCDUun9UbOdj2cMjAWzZoiSTt8Gf9WObtr4LnaFkBzeN2hX48wM3okM6adYua1DhwY2qCONLeha1ZSFgqUcsbeEzuCNoXRC075gKz783hWKnYdoYyMnbLR0hZenEbo44/CYhwBDUDqxKakdxsKerrG28qEQ+B26hyo99o86vq9BL16vkoA1q4huKlSd3g/dc4CEamz4REP7wLwLCn03ywd8cKNuCbS2C+Ji2PFx16u46wCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFE3goMOiMRbe849DOwt+y8Hhs2TptLChuhpxn2NSF0=;
 b=rBl2+v9v2XRGf/xP0dVxrx7SRU9y7izl7M/9xXk4Smnz66QQwVWwHLs++jKZw1YDtspLpeW+9/CTWhyrGRw3Ros5rnSiG1Pnuuv3WtNperzIOVbB65DiP6X7wHn8Hl3n5fwgObtI60WpMdurx7WFGh81s/kX8fboQ8A4zVLu6QHZFn/Hz1QVZPqEWklfekyLHVjYe0Vsl62HgXC3XTSh26T7v6UpPfm1AmjFc074Xy+eeUJfzaGwh7MGyT9sofqR4y3RozaMyiLzVMVx5hNIHCn640PNUp8nXngv+2zr9uBSiiJr5D+sSQtWrhghOVaU4LUTAduniaWVu5G7ow6AVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFE3goMOiMRbe849DOwt+y8Hhs2TptLChuhpxn2NSF0=;
 b=o40bPQgTSMrk4PC0EdTqwYh7l8ZmYV7DmV6ggTF/7UIhz+R5nCos91ElqBGWNxZOxGx+ovZDbPw20c8MRb8uRwBf6G6c1cfyScmwElU+HvoKssoPhjts47GmPNZcqgZwfD7Zw+gFFolmTjOMxi+LchdRSGObGTIRU2EmPQQc5glIJqDOdzdxjjJfNj50v12QrYZR9oVVoooBdtQN1AE57yFduqrvlTlkMpiZ0xN5rlS4Gxm0drNgujOxGnTWO3asnYQ5RG0yk7teOQ8N19d8mSp9V8UZGO1aaYjpGeZs+4DjnkeXsxGuEDUgtdfBE1pmYz+tUYxh3klb+ew5opoh7g==
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 17:19:48 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::aa) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 17:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 17:19:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 10:19:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 10:19:26 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 10:19:23 -0700
Date: Mon, 28 Apr 2025 10:19:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <praan@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 02/22] iommu: Pass in a driver-level user data
 structure to viommu_alloc op
Message-ID: <aA+4mRrGuUnpG/dB@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <f985e2802a50b5867c9d4d3182ae7b4944a989c5.1745646960.git.nicolinc@nvidia.com>
 <e569c927-65ff-4c0f-8922-45e404fefc5e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e569c927-65ff-4c0f-8922-45e404fefc5e@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 750ecce2-1a56-42ad-e024-08dd8678e072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4o5OCGo8zYO95f5/bqDroDAu+9Hnp5j+RoZsGZqgDvwnrypiSMWHQOYl+2yE?=
 =?us-ascii?Q?J4hEi8S4cPsNPalD9yMR8HlOfJCmeRcjcVke++ZOmc6BtT6p6wLXWN5vETxL?=
 =?us-ascii?Q?6uFBIcQKx0khkY8J29f8r78frBfTA/DbvxRnFZ9gX+oDNTCIAeMINGWofwdc?=
 =?us-ascii?Q?RnI1ipalp06axZhrIZQsZW+og+GEVz1fKb6g+JCMO2OClVljW4m0nNJq7nVp?=
 =?us-ascii?Q?I6Ghru7JCnGO4fr7bWmKrN2wOUQsqTXqjFqnGCCw2S6O1iecfoF5+vgZsMs4?=
 =?us-ascii?Q?49GGzWlMrQvK9NKHGuePAlGrXb1YbHCjYwZ4Nqe/38Kd7gJ5arAPLi2oHOm3?=
 =?us-ascii?Q?K/nBUKiT8/wp/xa6BFHjaqcTx8zNAFSs8w2vVkJ1Zvd8sEsTuOzdfdROitp3?=
 =?us-ascii?Q?hoe4S+gj9LVXi++rU058gSHB601JJs629SQzl6XIbpWyXnhKEto0emeh2nc+?=
 =?us-ascii?Q?wj30dCWrVjvUMV31iIhSTaMSFetX/BxaWmWlCW6fDUa6niGcbp1skLMEVB0j?=
 =?us-ascii?Q?oJZNTpPuEFxp5t7dDx2/t3Fuyw+l3qDRLiZSWJQ8HaLTpgWsXyuTY2trTJV/?=
 =?us-ascii?Q?ZsPyNsiXSmKAoi49G3zRYGIl7Quyvj0I4pvOxhV2G1b5pF2XdRqP/S5+1Lh+?=
 =?us-ascii?Q?9/+4XrqN4IrnTeOq9ZJhjJ3B1INlIQFoQyOCembHZTz0TOTaPdyyvimx6KCD?=
 =?us-ascii?Q?Nko9CbBPiCzDsHKC3SRTOF1nq3u5OyIavlFqbO8Vwcq9SJD1LZs4Wa34lRcg?=
 =?us-ascii?Q?gXfWZUUBNOYnNJ+ywrQhSSGAt7LDGMGuHO9M9tfpp5mNkT+gNx5AoHXn8THx?=
 =?us-ascii?Q?/MkXNnhYxwJAhdpqeFXYTr3ZpvQE3nsNmI2ufmrEJjY5hORLiVf4D8mNESCt?=
 =?us-ascii?Q?MxDHrIXXc6X3lc5e+SWeyB3/HrM8eLNoiFNBMLTi77CMT+O1S9YGq1EcavdV?=
 =?us-ascii?Q?yGRiD8IaxOy7GUO1LcS959Epxn9GG7ir8ZLI2kBKVkMDZuPfgvbn1Lpp6MRN?=
 =?us-ascii?Q?bMJeW+Til/w00XFCtP/vy0wPo8eW400zllbgplDgKkMfaTnfTA7Uwe8kIhm3?=
 =?us-ascii?Q?WkiHxOKdeGQtCe3Ai+T1BK7eaKhHY8XQteJZuTAsuS1exm3FUNMTSrcDHhQ4?=
 =?us-ascii?Q?KbP/oXtYp6BBf6iSVbmw+DcJ0222Xq1J9JlPbr1CV62aqX9RkGrjKrCqolay?=
 =?us-ascii?Q?l2rrZHwqMVUA3cE7dfkrfOZKx778FSuxHR8Iqx/Ua9pIpgptSEI7ePwla9DN?=
 =?us-ascii?Q?CYFhvpMQdCL5ekk1JqWofvlU7LP+IW2IAwgUqhy8gWTpNLVQxQWpxJ5Cee17?=
 =?us-ascii?Q?kPeLaOvg/ss1EY+RxugMZMbs7ade2A1mtgzmh/fgCYSjlvitMY9jz1q3D+hl?=
 =?us-ascii?Q?YezmTKJZcbmg4IjRMjlOjfwIQt/Kwu3CJ0n8wBDXphdzH5/F6KfYIpqix1vA?=
 =?us-ascii?Q?GmFH/RD5MXBGgrS6pWapypi+JTnbadbtMk+QV82LpM+n7b+YpEle7CnXX4zp?=
 =?us-ascii?Q?LSGuXj9y/njMPZRPpp+sw2I0afR6t78IfH/q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 17:19:47.4785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 750ecce2-1a56-42ad-e024-08dd8678e072
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

On Sun, Apr 27, 2025 at 02:31:54PM +0800, Baolu Lu wrote:
> On 4/26/25 13:57, Nicolin Chen wrote:
> > The new type of vIOMMU for tegra241-cmdqv needs to pass in a driver-level
> > data structure from user space via iommufd, so add a user_data to the op.
> > 
> > Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> 
> It would be better to add some words explaining what kind of user data
> can be passed when allocating a vIOMMU object and the reason why this
> might be necessary.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Sure. Will do something like this:

The new type of vIOMMU for tegra241-cmdqv allows user space VM to use one
of its virtual command queue HW resources exclusively. This requires user
space to mmap the corresponding MMIO page from kernel space for direct HW
control.

To forward the mmap info (vm_pgoff and size), iommufd should add a driver
specific data structure to the IOMMUFD_CMD_VIOMMU_ALLOC ioctl, for driver
to output the info (during the allocation) back to user space.

Similar to the existing ioctls and their IOMMU handlers, add a user_data
to viommu_alloc op to bridge between iommufd and drivers.

Thanks
Nicolin

