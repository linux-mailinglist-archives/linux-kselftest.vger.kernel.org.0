Return-Path: <linux-kselftest+bounces-30740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A92A88AAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31FC165E78
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680128B4E0;
	Mon, 14 Apr 2025 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y/jlWcoe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC61624E9;
	Mon, 14 Apr 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653864; cv=fail; b=Os8UMxzpr+cL6DurwbgScs2lQeWZq7dlZi05ez8wSM70hSu1rDxpRORsk7Vo3brRemJ1a0xjZOvpsH2UefoYUP0XJS8VdjG+gP/hV8BKCmnWeG1wFcag9g9SGUG9LK6tbcZK3AalSiMqjTSglIPtcopR+Qb5IgrTr+nMOsrEF4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653864; c=relaxed/simple;
	bh=AI60pU4M9G6DR9KCWLfs4fabDmdwrFYuxdk5LvZdJMc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcJMIJbRr39ld58RjFEqcLqHeM1Nfy58osupK917KiEzhOQd2cEEUHcZ+fYNqkUfeHjXHYRujstDD3MsuUjLuufurV+x9SeJmr5VPbSYG43FOg5UqiFDTCBLKeiG+hBOoPvmKkHzm8HECNxQrjWXNqJ2VU80bxtIxgwoe5g9ZZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y/jlWcoe; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWIHcFKjTum4fMeFcgBqUEUrBgjYFBKnk/D+FwiBHLMCOoLc8wtprfEh8h2g00KRY5ywIo+h/G3i8g+gxFz2D6yHYWqK1zfIUOSELxg9YkwhDDu0J/FpxjNpgNSGNSb2nlAJPwITbIsLTI8qX/WOMEARGKaWPHvJMoJTJqmzWr/aT3jE0zxad3kHpqzC1wARXJ6e3KS2WXGAhfOIopY034j5eWSFKEzhuJk2i5l0tu8SisWJoLWW5d/CQT62utbpxsYeZVt3KOyCVeBG+ElqaWn60hOZfAOqjFfajweB2GLGpLjxxZuNihloTLpzLWGBWpnKfb3BgkOcc+Oey6/kNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1KO5KPGeFnF5imdzk3sXi/swkvTqWyhJAXDTq4weYk=;
 b=uTL5uiuLlEsqUx/Xs1C1qEZkH3qiQGWQTU6RFIkUvMfTEZu8sN0mhqOWPrzQNjeFInKqamGi9UrbFhSTxc4dK8hin8DveAFKrW8ZjvoZP24PbVcqDfS7rMHJfY3wZfDptw44Q+V/vIwC+nH/y1RriSOWKNw1oRe04S+lghXAriYhYjRgxmZHW001gxoH/IP+jKgiMNLWxsBnruKFgE/tMq7l3B9jBugl35LWl31IJ4hNcDB4diOSBzR7iO+orCn1KNZIezAkcEhWRsVBCtE09M801CIemTvENxq6j0Ub9uKXcAmUJuVMOc04O3ffCjUiou1bgkhce8BsWLDCnMkh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1KO5KPGeFnF5imdzk3sXi/swkvTqWyhJAXDTq4weYk=;
 b=Y/jlWcoeKUFga58Az7zk5kNxGBTBRiC9rqfbUhtmxrk6WLc9OX14sTw13nI6jvqa/ILtakxDugBLWMpsWwRMAnNzRZtg1RF0z4aFVCJesRTvWIlKdkjIkt/lv2hMr39lNk+68NrApIDXuZJuFxdz2Y05BWWoeobI79BuKg5zV4gQhhyDCkBOg5XHXV1vOVPqdIfFAU+CFSxD03RCsnLlI1HvGey8GgV/+XOdpT02WK3QkM6F37b1dsBXhRwWEswD8LmjAC1WNP4U+B5ZvyekrXAy4cn3V6gS/3NzapV/gNCoejadE+skxiSkzGnF37QnhgVqcM+pw6Nl6mWQoQC4dg==
Received: from MW3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:303:2b::20)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Mon, 14 Apr
 2025 18:04:19 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::24) by MW3PR05CA0015.outlook.office365.com
 (2603:10b6:303:2b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Mon,
 14 Apr 2025 18:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 18:04:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 11:04:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 11:04:01 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 11:04:00 -0700
Date: Mon, 14 Apr 2025 11:03:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <praan@google.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <jsnitsel@redhat.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v1 03/16] iommu: Add iommu_copy_struct_to_user helper
Message-ID: <Z/1ODlyv7CXpMRXd@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <65b51f57d08069c9da909586faf4e73d247a54f5.1744353300.git.nicolinc@nvidia.com>
 <480536af-6830-43ce-a327-adbd13dc3f1d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <480536af-6830-43ce-a327-adbd13dc3f1d@oracle.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 983e4fb2-51e7-4adf-afa7-08dd7b7ec6de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?29R8euF/Gq+7yn6NDddypLmokaD6zjXGre5pBiOMVjX5a0wah264qfxg2wYQ?=
 =?us-ascii?Q?QNy7Urvvqbo9YelkHgSG3AcTf9YOHjN+LUwEVTkI9YEXCNp4UkR4yzMC0DYL?=
 =?us-ascii?Q?QFMih211paC8VPNSfSQ9S/cTSdrDXxW8wAcHMncfwIul2XuTjhLMig/o64jG?=
 =?us-ascii?Q?nfrXtBo1rGHiQFrDFNToKjHM2xT93SRtgzYn8leBXFPOS1v1P97NhByVvftW?=
 =?us-ascii?Q?vw2U7FpuL9d3FwMBfTIRo5msKY4LKpIoB/RmvcZaS3u+ed2D4O/qJVpyPOCt?=
 =?us-ascii?Q?CCeuIhNpqCB1kGZdvDYlv89gSKFYxn1etApoP/O0vHyqwTVMP5yoB/+LGp6o?=
 =?us-ascii?Q?qMSH3oqHftTcoFQ0MKIVD7TWVuegr9HOObEavvLnlzuBgLF1bGRsbUaOXjI3?=
 =?us-ascii?Q?amynTqaKzAYQt0bkrBcSIr35rzeu4NkW7PVHUyopEGHv9uBmHtOOiXpRHIYf?=
 =?us-ascii?Q?Pt9gzF9rDh1oiYlCeJ354Vd6Vr2N8DZ3lFlyfaYof89HXfD+mjajad0u57eq?=
 =?us-ascii?Q?mR03Z6u2rn5xnx00md7VZG/6NQT9su9YTT0eUTWeGFK9jtdUX6FndimZeO46?=
 =?us-ascii?Q?0+aPU3sn+OkXPKu80VIJWQ61e4GkwCBSggs0Bn6hqsDRww7oOcg0qDrp5+rq?=
 =?us-ascii?Q?cWtXqHF/b753plwDLlQAr7RkGqix3+1K1wkql8RogfEBCk2SNO/R3kYcJzyg?=
 =?us-ascii?Q?cr/G9ck7XlO58kUqsJQ69opMnF6/vPHNphBTYuMlVo5PbxsxRheTEWqJAun3?=
 =?us-ascii?Q?rDV2oVUwuUktHkMDlUVrjHd8NJwohdCumqxXOsWdNuGNJ2uE7TZrc6RipeVS?=
 =?us-ascii?Q?AhlS3f66sfghPwF3zJGIb1d1EH2/iyJU0U9mBkGRDh3YQAIdYvHpXeDYi7oS?=
 =?us-ascii?Q?TJVbgx1JQUosciFPgRoA4ncqyVXiq2jygwbw4RIUWa/PIp/VPtl/rFBbVMZe?=
 =?us-ascii?Q?p2gjDurUyoHCdSlcmP84OSqozUyeEtGTT0aOiaBYOZ9/KtyV8Jbv41/g6pYz?=
 =?us-ascii?Q?dn2Dqd9ISrnm+OLXdhNMuWFpm1wHXw9q2QAL6/b+RpkuDtV44HkNNivV3uQC?=
 =?us-ascii?Q?Q/C2186Fd4UtxQwhxNJYr0kyDpjUTmlMtrouI1p+hYoPl/Gomz7lDdQR9vqN?=
 =?us-ascii?Q?+9oS1eeY/sCmORl9U7QMi7V+RTdICs1EJrBMZbF6BtkaaQOmZALnsDUgnXOy?=
 =?us-ascii?Q?LJ4HBI9G+7l2IXRtv9g4eO/+UpNbDBtLO3qycV42LfEbmklvdLSdIfBjMr9X?=
 =?us-ascii?Q?FdI2HyfHL3xKjGqSzS3EACLOdf/zRcoH1tNIfwySvdSNAEFt9/eGO0GPtiGt?=
 =?us-ascii?Q?oD+TD2te3auW8Q7LlD4qukefhww/SczxfM84mcUVWskI10BW6FkkKwLxXE34?=
 =?us-ascii?Q?XDvGrmxyXLB0Wpz8KcIQxkIHBbzGU2L8WL4Sew4XnoN1kdbTuDo6BanNefwU?=
 =?us-ascii?Q?k4jrOLCLQKFxaKIFRN+v2wxBJug4UugndBqMuMfsRP4MBVPyf1L2u8OpoQvR?=
 =?us-ascii?Q?rk5AG4ZypeA25N7j/23dnG+xRcDd7/1yyNbO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:04:18.7494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 983e4fb2-51e7-4adf-afa7-08dd7b7ec6de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249

On Fri, Apr 11, 2025 at 06:05:30PM +0530, ALOK TIWARI wrote:
> On 11-04-2025 12:07, Nicolin Chen wrote:
> > + * iommu_copy_struct_to_user - Report iommu driver specific user space data
> > + * @user_data: Pointer to a struct iommu_user_data for user space data location
> > + * @ksrc: Pointer to an iommu driver specific user data that is defined in
> > + *        include/uapi/linux/iommufd.h
> > + * @data_type: The data type of the @ksrc. Must match with @user_data->type
> > + * @min_last: The last memember of the data structure @ksrc points in the
> 
> old typo  memember -> member

Fixed for this one.

And yea, we need a patch fixing iommu_copy_struct_from_user() too.

Thanks
Nicolin

