Return-Path: <linux-kselftest+bounces-47218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41340CA9C9C
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 01:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA8AA305D873
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 00:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE161E5018;
	Sat,  6 Dec 2025 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SS7GZZKK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC45EEB3
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764982632; cv=fail; b=BKcBqO05t8HodeOG7OBRllYri13msks3DTuo6+Js8UUXT0RyBuwy4IsscwbP5VDhqS2xC+oZ030xKOX4pc5wQGRVVWuHYucZM+ln4/5whIsDsfO3MBaSv3yVd5qKtZsKn91G/qyzaRpXzRxdNwYpQHXmSZbQPn49g//DbA7YpUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764982632; c=relaxed/simple;
	bh=QrcN2FEx7g+VXufNs3Il0IHQt7ByW7a1IB/TBaglSIA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdTDrpIYY3BosPtONG8VbNAI2qOfyzTGVwrXHH9zP2oFfvJhlTBnj2oHo50d/Eao7IXF0WupU8U3qABmFUiX8jmk4/qzNwRVhqpM04+AewBjRh/tDC0l83Tw2WEcDtIWF5yfrUMe3E1RPYBbJYk5BDAwnauBnWP04Bm6mqrUcjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SS7GZZKK; arc=fail smtp.client-ip=52.101.193.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKcrL2k8S5zsSWk6tkqvgXAxFzliuHHIh4Pf97qq0joxaRA5xCXhynqc5OG40Yr+Iar8B9aAs2TluY/xM87EmKkBjTt12IRF/UgXeUIm4ilrOuihZ5Ay9N+beME+u60d996SzgQ9UQpbAeHhh8TQujmMn87VHKF8K+k6V1wwFGx09tFEy1+DKHmdwurfgWd52t/VTIestkXs7JXUOFFjp5155gQ7r5z2RMo6lcWlX4wksZL2sgdKPHrlG0QIcQRt9iSKAARWzH9/2UNGZbIQ9qMEkjVGWi4xUD0lTlS1OjwLNIlX+TQDa5E0Ew9bk+qI7D5hPzZJLBGCV/iIWg7bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld4uDx7+SCb2aT6Ov8sdCrjYURyWNqU78l+nIC+K8Ho=;
 b=vVgr4yG2Qn/1DQZWRzVncfcTUiIIaGMkT14T14RXyTBwrIsp54V9r6yE1XHHhgmGJ7paeklQMpJUQneb0ljPvYONOcG28Jylgi2CNoBnjteYX06pBheBnqJDSrggImfJ121XU3jRLyF29fE8P1wyxl4g4np964LHynaI/QCK6daUY/ch9pYI7qNZWrP3B3oRE6jgrNY21QaEO2JtA7017PEPxn9IKUXz6gP/HSP3KLxHRG6qOlXzVe5qd8QHFAsnzyoNrBW7P9XDxeL3VIyRUYMJw2crUeuMwXoErtWNvnhES1bFrQsQV2DBXgfjFkqzEVLaDqnv+wj2r6PtaN8hXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld4uDx7+SCb2aT6Ov8sdCrjYURyWNqU78l+nIC+K8Ho=;
 b=SS7GZZKKB7ag34jSZ/Idn9XwfoFLexgij2H4NNVmmS8KzKUgtwjfaCfeov1iXnsGVQ+3Mq6HUZgRrD9J5yMKEbwYmNvX4/PY05Zf8carmnxb3xA0mIfAYuU2AgBnNQFyl4SD3ReFl4b3sHrFpwSWfSnEkBkN+Fc6Tlg3sAb+YltvVRMk4jlbcVxxmTShq/6Pc9bImPmwP0vZdb5J/19GDSzmjKwlq25Ai90ZCvAH7hfLwHb1qVqY6jf1/EwJNc12A7sTbbaWdwMjEDCqq+uYJwPgOfWO78iqyO6QAqwvAW4+JoTHZPBatLTWQeSZ/lkaChi2/yzGeUUO8BnpRAM8OA==
Received: from MN0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:208:530::16)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 6 Dec
 2025 00:57:06 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:530:cafe::14) by MN0PR02CA0015.outlook.office365.com
 (2603:10b6:208:530::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Sat,
 6 Dec 2025 00:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 00:57:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 16:56:58 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Dec 2025 16:56:58 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Dec 2025 16:56:56 -0800
Date: Fri, 5 Dec 2025 16:56:54 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "kernel
 test robot" <lkp@intel.com>, <patches@lists.linux.dev>, Yi Liu
	<yi.l.liu@intel.com>
Subject: Re: [PATCH] iommufd/selftest: Make it clearer to gcc that the access
 is not out of bounds
Message-ID: <aTN/VuXp5AMOjg5L@nvidia.com>
References: <0-v1-63a2cffb09da+4486-iommufd_gcc_bounds_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-63a2cffb09da+4486-iommufd_gcc_bounds_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: db5b5d58-30d1-4b1c-9c3d-08de3462606f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CYaqJVWx6dlA5VPKwS5WuGmG51TvOJQ+gaMfyO7fmkMgOSJ6TLEO8ptdXNdP?=
 =?us-ascii?Q?Y1iNYLjhwg+KiUWj9R3wAVR2rVDcCSU9jav8wwTFBCLdMBMaQDA0oWzLVLKd?=
 =?us-ascii?Q?9Dp2ttX8jF6X/sJgDqOueHq7i1niKUZ4/cMrbAA77nYVHsP9flIO0Ys0JIzE?=
 =?us-ascii?Q?MU2EZGkVmPz/Rl2VWRovIrLY9dGxSU+lOAgFWGegFZwEFuNxWNHk6OZ8FcFx?=
 =?us-ascii?Q?DA804BdgViNHhagfFB1r6fAgiX7V+KVCYYLdA/1EjfLQSJ7kHLbz/ZXPCBZj?=
 =?us-ascii?Q?M8KH7yblbF/igX5FUxB/IsHGBAIfCn4/MenWYUAUgdcM7qXX66bXIsrb5a9n?=
 =?us-ascii?Q?aN2zs/t/MuUwobxPWakPrqmWpocpLObwwFrtrinIUP0giHcyFIQDpV7NjXRR?=
 =?us-ascii?Q?WR0fPLUAh7QpqB+g6ctXx0uHZR7PAxiyU6JQwRRzuvDVMVdiBmIDe+x1Vx2u?=
 =?us-ascii?Q?eOWLqetgzPW/1T8o4/8lhSS6H6cyh4x40ag3qaaOQqyMbnoDfAHkJOvGh7Vt?=
 =?us-ascii?Q?OPhnbP5BPaf7GK1DWrvb3pmwttlR9iZ1MT1tPebDROhQnDNTfPTp6uSr7Wyu?=
 =?us-ascii?Q?Kg0fQX9BtEA5kQkGCNPhQX5qisnpVki68ZJjVC7qfPuNsQed4oho/tQnh8lO?=
 =?us-ascii?Q?CB4EbzsLasYanx+nayLvwZb6TABaSCapLmMJ9/OnTUcklKEfK8gVpO3Elk9W?=
 =?us-ascii?Q?UCFYzbLhqLpJoaTVSygxXLWGVDv4ktOcD4skfwEeMpv+nhOwHacdvINjXU01?=
 =?us-ascii?Q?9VI7aSIRpOr2zSxQ4+/evX+emg5BWnDwdW4gQEMc9Fn+sJfMvn6lcavesKCg?=
 =?us-ascii?Q?pOOcIH1zqL8GgW/aKV8vbra5gV+U/TTrS0XQtBzPo0oXyj4WDlKODJLk+Nqq?=
 =?us-ascii?Q?p5FZUCiSOndjnvokQBDm3SIFkytgYoCF+R0IO17Z4iEqcraAXmtks9jD9Kmw?=
 =?us-ascii?Q?jTLRKEx3rQXvfF6NacaQCz/nVw6bX7gYMZqSYqJ1kxqwBuJQoq315ZUSHL4Q?=
 =?us-ascii?Q?egRdyqSufNyMlLVqq767EG1G5SzJcQ/4cWxbh3VyuozmHkKdSYmT6GW05zFf?=
 =?us-ascii?Q?TTP9/zNPBxB16zpufshmIp5W1Y1X8U2mhurztrahY3p4cBZWlwE0qyFgm8IE?=
 =?us-ascii?Q?rsavqQcKK1GwRgUGVsOdDsO2OdCmPxIJePX/qNCwL1Zu2CmCAOOkrDNzli+o?=
 =?us-ascii?Q?fREhX+9kX7zVfHlo9f+6labX79mD05JN+Eydy5Hueza9TWH05Nqgu46NuQyX?=
 =?us-ascii?Q?7E2aQ+E1wsHcs9SMzhmuSQ3B267yO1TQHtQ+u9hWFs1AhetOouzLJJusylaz?=
 =?us-ascii?Q?Vl1czmeqzUXRltVyT7ujPEhMb7Lcmo4ZuxkdJwmECKDeyaISuxkanBx0+P2f?=
 =?us-ascii?Q?6aRxxLCZyg8+ZSMNzieHjeIUqMjjv1/c92hWa0R029JgbclHHWvBvszaS3Zu?=
 =?us-ascii?Q?8yfXnxmaEZIwv6WwSsh4dSGhuk9SYMPrpx8EanTYkk1IFg/awJTxvFA0B/Sa?=
 =?us-ascii?Q?ggbgCIbA+iYZ/xhtkcyz2HhhCRgErgs3BhjHhz4nPDRUdY62hRM0N8HD0sp4?=
 =?us-ascii?Q?HRLqiDazdqhrsMG0t2w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 00:57:06.0800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db5b5d58-30d1-4b1c-9c3d-08de3462606f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533

On Fri, Dec 05, 2025 at 08:39:59PM -0400, Jason Gunthorpe wrote:
> GCC gets a bit confused and reports:
> 
>    In function '_test_cmd_get_hw_info',
>        inlined from 'iommufd_ioas_get_hw_info' at iommufd.c:779:3,
>        inlined from 'wrapper_iommufd_ioas_get_hw_info' at iommufd.c:752:1:
> >> iommufd_utils.h:804:37: warning: array subscript 'struct iommu_test_hw_info[0]' is partly outside array bounds of 'struct iommu_test_hw_info_buffer_smaller[1]' [-Warray-bounds=]
>      804 |                         assert(!info->flags);
>          |                                 ~~~~^~~~~~~
>    iommufd.c: In function 'wrapper_iommufd_ioas_get_hw_info':
>    iommufd.c:761:11: note: object 'buffer_smaller' of size 4
>      761 |         } buffer_smaller;
>          |           ^~~~~~~~~~~~~~
> 
> While it is true that "struct iommu_test_hw_info[0]" is partly out of
> bounds of the input pointer, it is not true that info->flags is out of
> bounds. Unclear why it warns on this.
> 
> Reuse an existing properly sized stack buffer and pass a truncated length
> instead to test the same thing.
> 
> Fixes: af4fde93c319 ("iommufd/selftest: Add coverage for IOMMU_GET_HW_INFO ioctl")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512032344.kaAcKFIM-lkp@intel.com/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

