Return-Path: <linux-kselftest+bounces-20685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576949B0A77
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 19:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBE92833C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28D71E501B;
	Fri, 25 Oct 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZV1CMZq3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5E21A4BF
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875633; cv=fail; b=nO1Tjn7VJrQtkDHg2T/ECovRjC/4UFnA0eKHobiIdU2znwwVOWuTf5s8n6Qkg6D2H101qF2Hjd32q/zLrB/fCeen5eSvYs4YQDQLrTILYHSU56MKd98wqZC+0JFHqyEMs/bc3CDxZMGgCsRUkNiusN+Va3NO07jt5FvEkxYDoGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875633; c=relaxed/simple;
	bh=VUF0yKVGI58WybakUsObzlDzE0ozuyfx1Z5kd0MWiPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFyqH/RNkVDvIyBmim7IvjPSCD5jj2enyna8yev4y3jrrfBM0hJxYn/UXwfy0V0gSB+P1Y2y8HcdfgGoORSg8nb2f5F9eYDlkAcMgHXjYh9UL2mP/i4mvWZhJYRgqGUuhP3y/yluJltqYXxV+A7G26ozLLpzCk4I4UGrAxsNjHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZV1CMZq3; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO1wb2O4TiIxY8r6d5JMk+gmwOCQazt5PcpuRKLoIuaLBPrlsvwZR0HO8onGb1sd+ECyCAC+9Sh7/Dt/4BxKoCtnEyczhp5Yku81cG4vXYgKK9A6JDL9xUgCCPE4SjMtu1Va6h+xG26lS0fT5r9Y3m1DnjUeW+7z2530zZNflH8MlT3xwCu7VcuwSZszOEULSngRz2oHarIPdpLkVDqDFzmdEgPCvEKc8H5EfceYwZ/EE/5McHbbJfg30UbcnPRxSBnjoOAxsPJXm9MzDxKS+m4xnBgmDChay5QI+3tEgutTb5g+G8S4TDHpe1hztvUEc6Lc0cNfgJ/sIZKLdC38yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUF0yKVGI58WybakUsObzlDzE0ozuyfx1Z5kd0MWiPM=;
 b=WWQrFQ5QMl2L+MEQK+gEAByEwt0KTGZVVTaKqM0EI5DeuTZs6dWLMe6eeebD7uMWjd3B47l0AwHZPJrMvUKSRymi0r56jpE1iFzNYwc1cl50j7qFeAxEQ0lcICU9jMVQe7Ejh3bDOVMR8x3RfbsrV9IIkgoOvjUERo7EJERDsUPpfM2quaMhY3/Df7+ObPLC8WH1Lg783byGb8aRcmjhILWPPmgFI+wyfQdfvbq86ph2Wcc9apM+KZ6liVFENVTJ43NzxMfFSb/2Do6akiS82ilmkoeNnAmB8aL2AuNSuGWxGg7VJLYDEXUMzkwphiqHCSLrc0csI07HyV7+uMVVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUF0yKVGI58WybakUsObzlDzE0ozuyfx1Z5kd0MWiPM=;
 b=ZV1CMZq3t8Pmma8C60WYBvsNwIzWuxsoa/bmXypI4oL68UP8h6cP75+iWls7GUPX3spgb+j9Y9dDqbAQY3ZGErMVqu4yj8XD4YL0in3tzw6VdqJnQBzN4gxHuXAFhFJRctfq9MAz17f4uoaMVUbcTKbFn1X2PqdxFcBB4vbDdKlep1mlVozf7XYk/yrJ0jLJFHQZfX9mWRbmhSrSYqxk8TvYjEShE2h6Y/OfCx4fdaksBmVtyHsiRslhvW+m5F854QDQQxP8eutZm2oHltwjYZXhz4K9T6VRI7+R3+qYExwslxHDHk3Pl0kAti553C8tbHN5OWbPmdcChnc7wOWHpQ==
Received: from CH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::11)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 17:00:27 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::e0) by CH5P220CA0009.outlook.office365.com
 (2603:10b6:610:1ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 17:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 17:00:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 10:00:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 10:00:14 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 10:00:13 -0700
Date: Fri, 25 Oct 2024 10:00:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
CC: <linux-kselftest@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	"Kevin Tian" <kevin.tian@intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH V7 9/9] iommufd: map file selftest
Message-ID: <ZxvOnNQy38OOSfmm@Asurada-Nvidia>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
 <e9d513bf-3e6d-45c3-be10-443f7c8b07da@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e9d513bf-3e6d-45c3-be10-443f7c8b07da@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: cf05a687-34f5-4dff-33ac-08dcf5168669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qidDhkzzN1lwQ1YjKL3flbhI8xBBYtUeZNhdsYZYIg5nqsWBYQFwSoTQU3VS?=
 =?us-ascii?Q?Zwv+GRKRUyC3lMdsurXxHtuXYI+vMm3J7iCosmKpyMLUPKf5WhTF/4l/7R62?=
 =?us-ascii?Q?OUjzyPO9X8TJq0INxgZbQZlr+m+Ry0zFtUCoVW498AOWWyM+WXP8oLH2+A7e?=
 =?us-ascii?Q?7SCRqfUj5MrLYc+LLhoLh9ZEsf5/whVm8AVtXcGmlgQDZsTw/65bzm5EEWOC?=
 =?us-ascii?Q?OotHdN2TqisOR0HK3tEApelpOKP0aZGcZHf79nHY/3VNb5dQLCPwXSBOb3TY?=
 =?us-ascii?Q?9pWmQssHr7lo0ukK/qr3x05HbCNh1dTv11iNYZ8nZinkMfBq0fongVZ4I7Fo?=
 =?us-ascii?Q?/btnGm3eEUuzH47HaUxZnF/o2D4JvMGBPv0eG0FP/fTlepmTQYFm8lvnmUXj?=
 =?us-ascii?Q?KjRUdkrV1EdeGPsH1hL6o7qUBjLW1Ttrke1bvXo/6STkKC+31dsn80s7GqXr?=
 =?us-ascii?Q?ih0wcFY99til4sDmZq/izGMwtF3BDn3kYZ7SHGdKN2AQ5fxUQbsCG6VQFNFl?=
 =?us-ascii?Q?UQRrruC2Rld94l2xmJy4DazaE3PDuhtOY/sLJTjI8MvL6thNLX40mcznYrMD?=
 =?us-ascii?Q?Jf/X+P0f9ySBtFElD915PRA1rGoBn73gQgv1mkNsf5SFdDCqSTuKYzK5kn0Q?=
 =?us-ascii?Q?JrbqPCGRLMXUniqfcbKUIS6veH7ZlYwCZGkSE2zaRun46omICMm/Kn6wuPiQ?=
 =?us-ascii?Q?D+qVCHaWtgS43Vi4lMd2LLYGZRQ/aFfOyLIpr5W1h0pzZc4bce6qgg12CXf9?=
 =?us-ascii?Q?pSHQDbztZGFbHAkCz5MjeP8B46FkI2wLI4+rlyl73KxeksqdrSnG5Fnir/we?=
 =?us-ascii?Q?tV1BOvgL1Gh017E6Rg08Y8urbHefUfqMUqF0ehLAbVlSuHqHDX0ndfZE07W4?=
 =?us-ascii?Q?7XkJry9+fKVe/KtRzgZKJajfJd1WvbOnSwDIBTN+b0ZYH8Y+2AwC18QiStzD?=
 =?us-ascii?Q?OhNxSElJqOS6vePqgfnMsf4LNPQSnHyWV6Q/dNwzjQdqzHRAuKfsdQr5o4m1?=
 =?us-ascii?Q?i8owbIV63Vog2cGWcyy/dpWLZkuQRR+CJkEvtB1UvzG6nIoYbmBLRK51c2hr?=
 =?us-ascii?Q?Sk1iY8xRo65nVgJH4+RuZgiZmxKE34yocxpDikmA26UfR3nCjBPjnr/uR1H3?=
 =?us-ascii?Q?D4q8X9yOOnEM/Q7XVE5lHBfPUQ1dAWvHWefvTCYq1E6q/oUcfhQoyaG2a3XV?=
 =?us-ascii?Q?zIBUBnoUYOsE13UG0grEcKgWkKd/Kpr2XSuEeihsBBK1mW/rtDT9MlLwYp+C?=
 =?us-ascii?Q?Y7DiYcolXCiEPvEqb3vkWM8ODH3h95MIOtkCCiYyxHMAdEBAUgahyIqwt2ON?=
 =?us-ascii?Q?bfeLlP9105aUMQiIApALVNrQHdlphxS4X8c3oL7RGRzWdyACHTC2jAqjx2XV?=
 =?us-ascii?Q?gx7yzqTzJ/IC2NJC2yLLfuU0y3jrduoC+bkQ/GWefC5+BsQzqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:00:27.1332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf05a687-34f5-4dff-33ac-08dcf5168669
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703

On Fri, Oct 25, 2024 at 09:14:44AM -0400, Steven Sistare wrote:
> cc linux-selftest

You could just send the entire series to that maillist. I think
that Folks also need the uAPI information to review the change.

Thanks
Nicolin

