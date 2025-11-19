Return-Path: <linux-kselftest+bounces-45990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0260C6F8B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9074B343B39
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BBF352932;
	Wed, 19 Nov 2025 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i8KpVjLx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BD6351FDB;
	Wed, 19 Nov 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564272; cv=fail; b=hY0Kc8j7HXqpk6dg6LhHAT1o1AJ4o+OpFXi1uY3RsTbP37BP+lGKdp0JI2vizpLGI8OHPzM++geL+mLwXbfo0aO5UY4d/8OnL7BfmY7CAKUC9nwLZuTMXL5xSHHwaIT6Hb/UrnKSxgrfVdS0fxmx7cARc5NwYGfEZXEDYoul92s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564272; c=relaxed/simple;
	bh=k82wuTjOvjhSeJJM+ESZzdfBUco6rgv+mQ7PefOLoJ0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=V1j0n4ERiBOdUB+FtxrwWctt/t+a9THxz0MFvu8YGQUJSzthXcpGXsIZaZ3eUBAxpPjo6rAik8+5c6f01rb+cG1ReDeDYy/pWO/JUHWF1HA5/ZtmoMjbj6DlTWy0CC+iN9U1FnYMpVj8O6D0BukkqQqbKSgrIwRFB9PkSZ3SnfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i8KpVjLx; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qb4saloxL0Xt0JtCxSqLt9ygIrwZArC3uEQlhM/pPwrAvy/ZAJzUEAxlnC18uGjqdQTyN5jxaUZsIzozrDmTxwIrt18VYtwDgty2Xi/V6ep3U6AeC0AEXriyojJxnD1Zxcw5W8S9NZrdxEoBGF96sta8MLPAhpGmFUxHxFtg7BArZuRRpS+y9P168ULoDizeo4hkmKMfpjtclrnJfKIfvXlYVwUYmoAnGdVpvUg1A50jMKlob4JwRw/u1dU+pGQLGvfBcZ/tid1vu0OAkcBYFCfWlETScALEbQ95wPd+QuZ6EVpuAvYQNsBAvk3i1pniBf8bWQ8vcs7HaMCuPC2z+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k82wuTjOvjhSeJJM+ESZzdfBUco6rgv+mQ7PefOLoJ0=;
 b=rt43lvmkDN0p+JLPfYk64zXbcrI2wqe0Z6DzxotBcrKLANoe+wS4MpSZCwAItZb30rCRU2bDX2CasA2LTfoCQo2eJoKstlMcpnUNK7+/JXjxC8Di0evIi9Hs3EPdpUkaffkMZjDtDvUyDiX4yZ0zfPKDsP/MD98/OoROtXhHOGVhmnMQY/40LoPZKiGj1TTv7hlLmF6tMYcU/R0nYLiR5/HoWAjl15wtLVdzA89wXTTT7GcXl8sHEnvJsExSZ+bg4vlT6A98T/8QiwKn0K6KMUJpYuozqN0KPf7UVufSjpxlraDW2lFhPXXWR/8T8wdUf4vZFBfj26tBx22jNNNYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k82wuTjOvjhSeJJM+ESZzdfBUco6rgv+mQ7PefOLoJ0=;
 b=i8KpVjLxHLCr7Z7FhblKCL/f8GIQZua2YshgQMzbZyAm3bWV7xh8GdDYTCaX42ns66xQoy9gnWgh/kRlD6Dhl9AaV0qpi8+oJfWCxBDyPU8hbLvXErtwR/c54WnA1DypkZWnYMBLZo9x8w3j/gEJWytxWHAfJgWGBkqPusQE9wRTvr7t8WBD5UonMrss2uPHL+8VTZ83cfTMGJ12iOhwRHef9UqGD6ukMhQiX/nGYINTSwYpYXD2KSpPwzB//GzbfafQ3lHZfHOoF20PjHnhWRfWt78wpdVWRp3+KQIxCaEi/F0QMRW5RbryedrVHcncVuPODf4LrFntS1qQtxEG7w==
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by DS5PPFBB8C78349.namprd12.prod.outlook.com (2603:10b6:f:fc00::660) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Wed, 19 Nov
 2025 14:57:45 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::5) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 14:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 14:57:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 06:57:27 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 06:57:22 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-5-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 04/12] selftests: drv-net: xdp: use variants
 for qstat tests
Date: Wed, 19 Nov 2025 15:57:08 +0100
In-Reply-To: <20251118215126.2225826-5-kuba@kernel.org>
Message-ID: <87a50icbox.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS5PPFBB8C78349:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a6daf4-5cd8-4c4d-0521-08de277bff5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMdG84cdL7/LNs9r+sSEefKbyTJJe+hh5o65TTHv4Ex7Dv5Ju9f2M0fuw5Hv?=
 =?us-ascii?Q?bY4O9LSIin80NvhbI9ySW4OUVMdyPBFkvclriEz/BbB4Y0JjTmhg6f8KHKpi?=
 =?us-ascii?Q?IgZsBeDdyf9EJBSXjocirGtiZwVe+BBVjr3gZzYmNTZxLPn1fZD5bWnnZRcD?=
 =?us-ascii?Q?+Qulzfa0rFA6TrhO5lslvzbv7pI4B0bj+4uev+7w/8t6ogaWmUEyOLMdxeqw?=
 =?us-ascii?Q?OQgvoGqUx9Y7gT5l64vdPrcqGWMgtYIto2AunUxei4+WG0qlLZjCPN0B0nSB?=
 =?us-ascii?Q?9mZPZn8/ojbHEMGxJxqOnBwFTfVhKJafftgYlmS5MWkTfZrrx0u4UECC0Gi9?=
 =?us-ascii?Q?QZOXgimeKGVwVsMu1Giz13UHcNdpHavyS+6lXAGcS1Famr/8S1C38Xh9mbWS?=
 =?us-ascii?Q?+Fma8RbvW1N+HkYBhOEe9PWBOKoSP446aM7nvqrnAdXsoQefOMK4LOGVsuN1?=
 =?us-ascii?Q?i5UZ2/Zo7iCqLUZiJO2AC/iF7lVAXRZFlEvhlG/1a8E1FBp7t0b0b00C8xce?=
 =?us-ascii?Q?hLo+ppSvQMNpGEyK8jPFfvBTBqYf3sKq9ahU14+WDwB25DQB5nfVY16/4SGK?=
 =?us-ascii?Q?VEnFSBIDpVGP/ZYYGLd8HsQJrsknhx5KpnJdVTY+52L/rgt7i4fhLH8bvGCm?=
 =?us-ascii?Q?IJuT9NQ9/dXvUOIXJ3hX4Soi2b1ReWwN4OW/VSv4hzRYbO2+NmS2zMLCFJK9?=
 =?us-ascii?Q?39t0Ph2EhR1uzvMTGYs73PnXcnO2L6gYmVm1utODpVx/UiFMNYXX6bIScXhF?=
 =?us-ascii?Q?OnHhqucZ+CCYntDN4vQJA1tL25bOsy1V+P+COkY3AhT5WYwbakbXLmtXUhsr?=
 =?us-ascii?Q?Uo2cBveeKyYZnRZ0vjOo/3fcucO9DwODpXiiiRRSP5T0yARWg0Nft4Nr1jsR?=
 =?us-ascii?Q?UZhOMl7HmTZlIoXmFBVCyth7WDYQ8+APiKYqpO0Ne0zNukq5LRHg3XV+GF0m?=
 =?us-ascii?Q?CeVCatCVP/KWTo3YsWhMrhCMMHkgmlmPrPR8TjyqMfig1RoVtuJnUrLThmGU?=
 =?us-ascii?Q?TzcOcsFB463ImpMsrtvWyfPHpvtRMYty0QzbIVYOjDyZEwjoFidRyrSF2u0L?=
 =?us-ascii?Q?hczNCo9izGiz+9o2ZYSOz7gvM8HRfJGyZV/j8aLJFQbj4VmDxfquIrChiC1t?=
 =?us-ascii?Q?KMwRjRs5kjsx82cB1R2hYh8tb+EORAZx+VaENuP2+SQl7vUy1ogfZ4CU4pX6?=
 =?us-ascii?Q?nY525NLdzEMpdmzVtM7cLCub9wi4mci61a+KfZ9IZ3B/k7AtbTAQMbObaWoV?=
 =?us-ascii?Q?LBinGhQFwWPCUCYDL+AO40/tFDPOflXlivaa/h0ASD4Fu0rPF+0oiYWG3YY4?=
 =?us-ascii?Q?Tvesh/5zpdZPxfEYf2bbOW2vVZAM4n3Ohqpz6ZIqnLUkKJBBUkaF+CbThIqg?=
 =?us-ascii?Q?kNBcoGKs1SVn13Owu5dkCcXg6rCHxJLveKT14AKxnXxqbpim2VbUhvV0zvPW?=
 =?us-ascii?Q?DBMFQmM5K6bpE5yUe75n3yHwtWIjELbYYLoBS7vXkdt2yncVJLXjbqWxa+BE?=
 =?us-ascii?Q?bAhL1aCUlc27LNrJ8UehEmVPGZb+u2peWY2e62mcplRhJFqx90qcGlR9uTMH?=
 =?us-ascii?Q?7bhkLUsK9JX0hJp9UZM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:57:45.0002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a6daf4-5cd8-4c4d-0521-08de277bff5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBB8C78349


Jakub Kicinski <kuba@kernel.org> writes:

> Use just-added ksft variants for XDP qstat tests.
>
> While at it correct the number of packets, we're sending
> 1000 packets now.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

