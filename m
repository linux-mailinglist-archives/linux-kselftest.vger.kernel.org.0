Return-Path: <linux-kselftest+bounces-48189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FA3CF2E96
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0D523027E22
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49B62EC086;
	Mon,  5 Jan 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SkMhr7pE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5897918DB1E;
	Mon,  5 Jan 2026 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607517; cv=fail; b=XWt4qmYGQcysBOgKd7tpqXMCeAnNyCSruniU4/75HU1oa5iDdPkK4Hf33diYyvHk8TMLiTinYlgbI4eAwyl5aBzotWV5c7ke4Ryhgb7808l5VzTbEk0wDGhKS69k1WAj1K67UW05/NOcxsqBnqR0dOq2AY0hxGSHBzefqKcpVt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607517; c=relaxed/simple;
	bh=+rXO73OyvRxEUreXpgaZzJJOU4p5VBwJFDadwsf7A9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJo3idec7iKs84CuE209yhpHOjSsPXUoMFdV+rlQTkpC2x+7w5iPLBzCil+FZ5P/aYzsaH+JjyNrKATvKGWeeFXu6MKjPOl4tbUSzz3brxb3NYEMKBGBrRT7j1qAI9P9uGGcoujLKGx6Qecs+nLuhRIGOJjL1h0xcA9kWqjOnMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SkMhr7pE; arc=fail smtp.client-ip=52.101.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxzcXPODoBW/zUJhfESYAHSfei89MOW6J/brrC+JhdWkZUZnPFTTXT24Nax0SNwR26UCC0HewRybbeSYNuqOFXYmPkJ6ilA5F/gpV3z4JiEfdkhNKyDuBdRmQIzEeaf27/9sYY6U95edM4iBUZCg3bCTLLqm8QIJrPN4iv6LQcafLJXftWVrDY2hkPzFLjda5GMnDVGGv87QmxXFYIh0i9onf2VwNc7VlyDzFlTw/Zb3hW6g95uqER8oHTVbp8xeWaRunsxdLas54tVB4KslIB+1o96/HEEjq9vkU9PxCgc6BCo1fXt7QfJx7hYNmV3ThLGScWD0uvDccpj8Ye1cXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V74bbif0s0cGb2ZsmYY7oUH6rxm3cmdjXVf+til66Lk=;
 b=wAL1RTNmc/pwI6tGoJU8jNtSd8BC9kl7aadW/Qe48wn02DvhPtLOO7unfqqzyxUT6bTIEqU2laPfguoggSWHAlxrSZBvLgmWxseQp+BoVI6vvCp8HZpamiHoIQS664WHV+uBltQDYIfnl26Of211QRakWnoU53O8uhFQn9jr5t1VnqeZM08GeWBRlx/j3j23CuPZP71q2mGk4wi7u1+WP2gIe1lfPieI2suSHni/9zwliU+FviHIhgdaxutn3w/uf1woxiTDJkeHYM909teKI/boRbQKsV9vgKw23RyoxwvHWEyh5uB5rIH4mFsvxpA2roIV5km2G0goeqmI6tpy5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V74bbif0s0cGb2ZsmYY7oUH6rxm3cmdjXVf+til66Lk=;
 b=SkMhr7pEE6fedoS9x/gCfcq8gXsZJm0cIRhQZVt6imUh/nLQ7i7uLSPFb/+TGEn4yBqx+zXzmlovWHVNsar3y/pd4z7PuiYYXZI1rWRRmOJlPqVug0VOBjJ4gAr2ioiOSwTZHBbAV1fQjsQ+nCyWZgukLq5ONPoUpng4JqBjJ73Q6CZRgeqVuvG3zMEoHblbc2eGyBTyL6vkLDbp4tpAoGBS4ajkbXnI90iwE8V5eakI1/WdWEPxFxRI+TYxSZzSRQ0tCIbCg8cftoEdpBCK/yGazd4Wv6nIro+FmrdaLZnaNa7FRBHDy5Yjv97YyO3IBkdk1X5X3K4ATj7rURBVXg==
Received: from SN7PR04CA0052.namprd04.prod.outlook.com (2603:10b6:806:120::27)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:05:12 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::a3) by SN7PR04CA0052.outlook.office365.com
 (2603:10b6:806:120::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 10:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 10:05:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 02:04:59 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 5 Jan 2026 02:04:55 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 0/2] PSP self test improvements
Date: Mon, 5 Jan 2026 12:04:22 +0200
Message-ID: <20260105100424.2626542-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfd759c-e99c-44fe-a3d8-08de4c41ea30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DM/AUEM7RKVEVlcyqWrl2SCfwHnghiekNVl+0THJHHGsCQTdYxmVBSjGfIAu?=
 =?us-ascii?Q?IXFlbFjFCPvqVGi3vvUgv1/kmnq9o7Kt76IBULi4+92pvGFY6so8OcOYgThD?=
 =?us-ascii?Q?CiKhB99O2XPlqlRK+cxZldO6Dw0j/UPpKqK23ixiTTIExEqmeSfMiJxJRT7Q?=
 =?us-ascii?Q?ho7F9sJaIRodjW6dlnoL98LQYRKJ05Kv559kdV0IBp4bIQ9XBg5ru32fy+7+?=
 =?us-ascii?Q?rbVoA1nVAup7q3Cm8z8eB2g5veYBZhPPk1wb53mDGB6rQ8RxxXGkFoU3m0iK?=
 =?us-ascii?Q?2jPyWzNASZG0cmWPUHY/zkUMs9zuxT7SbgR5gKitXaDGp5SkNH4iiE7pzm7R?=
 =?us-ascii?Q?zZco8BvwKrBfikpq8XT9nUFc+4p9Hs/T6Esa548dLvptcypcL1S07gM6LOSr?=
 =?us-ascii?Q?Dno372hoYoFv//8+K2sLhW0kSkbXeErpUqUxCfXgLAZcTxTz7/f+3jUVgsRj?=
 =?us-ascii?Q?YH8iICu1/9D7Wh31veqvRQIyGJDi71KnYPTOyDD9BhoGZeyAwIeAj3aWY1rY?=
 =?us-ascii?Q?04cHoMoh6TmjVV+GUL8vYrkhRxJWUxXiteknvMIzV9yhjYUTZhSdje5yVIZG?=
 =?us-ascii?Q?FTx1GRyK8rwNUADN9C59Mg5lhSbGVPJ8cqD0ul8EgYsMV3q16CnCObwTppJG?=
 =?us-ascii?Q?BpyupFfxiuCd2egObuVFQ0lpsBEydPgSHxLxV6O0jkdMG6dmnb2Go16TTY3A?=
 =?us-ascii?Q?m0NpNu/+76895nS4j8r6bt5B5noaG0yyNDZoRgqmwCaqhIcCXQnv4X6nuzk5?=
 =?us-ascii?Q?ppMzCPifUNo2myzJvGVv2zb4jiwgSO/iy7AnFBHeD7qr4PsYJiLHZJdfjmFH?=
 =?us-ascii?Q?BZ5i5UjzTj77Ho6b6alEMg+O1DxN9eyDpUSTavPyH9I3LM+CiX0jTOQJfF4k?=
 =?us-ascii?Q?95zWJXPAeBp9mOfiJd8jaw+F02zIgMo1aR1ALf/zHrEGscVLkKqwkaz9rAMl?=
 =?us-ascii?Q?f8fnn2bNgrWl5HspBHadXTsJm7ypZhN2qIKV91cX66EsTXpQY19nD2P4Mc2Y?=
 =?us-ascii?Q?QB5Kx882ZhEN6WRc4w87YYsobT5RYPyRGM+JzG+t3nkCw3MN7tRa5RWABkUk?=
 =?us-ascii?Q?HR8da+td3C4s/y9K+rU+Hkn+EOVmP1tC0DzM/YhRnNDOZOjeqr7h0OtuEVd0?=
 =?us-ascii?Q?k9Xi/Cgp7YyoaEeq49YEPH8YpQipR8wKeHssPYOm0xiQIBtztA0o4F2XHc7m?=
 =?us-ascii?Q?patjJnIbWFLv/3fCoPQSePWOkdBJ+ES/L9eKKNhbEyhz57KJz6tvgrKdl0Pq?=
 =?us-ascii?Q?IxhPnvJkEXUUzKTD084A9sl4iuJNCvLSsckqLXHYVLAHU+rH+qEPhH2bXAfq?=
 =?us-ascii?Q?uUwP4hyh785gSIkpQdY+cfUuqCFKc9yjAjG2YUGDUCwPrBkM7BwfHbOYJK3f?=
 =?us-ascii?Q?hbYjbJ2EdSw6L8/bj8rtHzI3kz30BSJTZVL+jVt7ggzVxoxOf0Q7/V4kAP2/?=
 =?us-ascii?Q?AZD9r1PkPsnJmT5IMZkh1Y6mNni7uR+3e6GGhkUKC9u5WRG7Y1BFbRJI9qwa?=
 =?us-ascii?Q?BOheN0+PCghjhX0FWkbUhxtzBQTHfNRPxlNmqrYbhfgSFhz0j+i8Kw9kG1ll?=
 =?us-ascii?Q?MrdprxTXv8NG2gu0vtY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:05:11.7285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfd759c-e99c-44fe-a3d8-08de4c41ea30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

These two patches improve PSP self tests when there are no PSP devs
found (test failures instead of Python exception) and when there are
multiple PSP devices present (use the first one instead of failing).

Cosmin Ratiu (2):
  selftests: drv-net: psp: Use first device when multiple are present
  selftests: drv-net: psp: Don't fail psp_responder when no PSP devs
    found

 .../selftests/drivers/net/psp_responder.c     | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.45.0


