Return-Path: <linux-kselftest+bounces-48777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D6ED1467A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 18:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCE323007C3F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615BC37B419;
	Mon, 12 Jan 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oPJYrtda"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AFC364045;
	Mon, 12 Jan 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239462; cv=fail; b=sTcrrfbvTd1vpRurso6FoDYWxB7HWTaCjkokHd46hG9WHXclaOK+DFCflU4j6AOV7ta4GhR/Nko7r8F1GeZYoXvj+75mwMHf7GWtYMHdM5O58tPBWn3SY7CEkLziFcfe036qRUr5IsUu48O393yfgzw6PrJqDnY37Hy+opAFTe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239462; c=relaxed/simple;
	bh=OUtGW/9R4SxGmbxKqjpjz6K7sFPVohVTA8FH7f8jF38=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NEXmcC5/lM872D0iuSQctCqHi1PmHKtI/64hPoJDEa48KMvZDsGq1sJMNxHc0BRLkUuNW+jWY+nW+LQtovoxqh7B7NQumX/uyNXWs78T671R5q7AkXGfeEeFeOJJYKsup9NpFaUtG6zCaDpHGWl5iPe+Gw2kxnSgAGRkQ3RNNF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oPJYrtda; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSZs+Y3cGFuAW3l0NqfP7yzm4IwHuWDE3MuPVUIOPvpNy7wMxlX02aSJQNvm9QnDn1Jt6ZyQt760LfS3UjALqt9eeMXqibFt93L9GnirymobztWtK0EVFLPpN1ylAuzBdHqvw6IeaorkpwRLp9SDOAinPvl/2GzTFvpCIjsSYST6o9dsPI0HL4B2Y/G0Jv8E6BwS+PNXtPfYOQijdrtyNR8IMcF097NYiuc84cX9rSCYv1aQ11ys9DZckW+VDdPXCnffROAn0j5DrXBYWqf8of9i4HoHPzXUXfz1lyPlqRfQY4eM56ADL9bVDxfLv4tlGpYh910gFtzUlPwOyGMMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxU6/gGwJwoj+PxnogPf22+bTsdeSLWEe3sRjesf1so=;
 b=MTtFTYjFlM45jLab38YNP2t2y0OpigsiP2E4iJzCwYeQGR7rwjf6KpoJxEROQTefAinbSwP/WR6K9I6jboyAkFbwkN+4R70RymN7UQZ+ABgrz4QNlh/ZGo7/VMo2rr4XQLpxiZzshb4catee0+11Q+3JuycFU41ttNFNO7JmJx2cpyFtu9yjD1zzX7uN7TPtXpeObr9sWpbxetc3kgP1j5FAHpbIqwtsg+AagwEYHKck0UwygI+GYKPW/g6kBdgQYLWSNxKZfE8o7CIS9xU8lUVdpw7M3c5yBzn//Z3riN1Zi0aGUfqbg6zTWAgrxAYKxLUPozjGxtVp9uTrccDmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxU6/gGwJwoj+PxnogPf22+bTsdeSLWEe3sRjesf1so=;
 b=oPJYrtdaA9d1OIkkWbU5soe4Q2UbEGTPOZzrojglF8sUEFdOt6rFmQxow9qcdhJS4r1T7mTi8XfIEODuhNmDiylk7Qfm7sGdbLGZ4vg21kVrsUicA4jfi2R7JR/lgHzLo37Wrct6MsiiykemVc779aSWVmSL9ycWu5XeMLLO16gIJuzJ1yQPcqQOFgiqS++fp4X0ZT+GsuT4yetItSrPLFhRIEA26D8wpkBNQQ79wOc4o5iVktXARPKVmgG6rmciEzlej20/lh+mesxD7sqB2yA+QPd4Jr2txQXdCu4No2kheTcWCw3FFecd91WI13PVdBQoDdvckV+BM1agmSmA7Q==
Received: from BL1PR13CA0356.namprd13.prod.outlook.com (2603:10b6:208:2c6::31)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 17:37:37 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::88) by BL1PR13CA0356.outlook.office365.com
 (2603:10b6:208:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 17:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 17:37:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:37:16 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:37:15 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 09:37:12 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	"Petr Machata" <petrm@nvidia.com>, Coco Li <lixiaoyan@google.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net v2 0/2] selftests: Couple of fixes in Toeplitz RPS cases
Date: Mon, 12 Jan 2026 19:37:13 +0200
Message-ID: <20260112173715.384843-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: f9efc97f-1966-42f9-2d05-08de52014671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MxWl2ccsUUUbPuuximtiZkzZM1XWS/HUI9sAfYCr7zB5QXKQU8GJpMRImbhq?=
 =?us-ascii?Q?Xa1MJNXfzeToyS33PuNB6hdWNnij8FqCbeKcfOpPKUPwsnlZgvKOVHdAGlLp?=
 =?us-ascii?Q?hJAPGNoyFTljNK9LXxnYoN6HsbeVYf2Nmw83j2WW+9IjfgRvAz2Szmm4TuCk?=
 =?us-ascii?Q?CbWJO+urp9gmwlH2lqlFEpnAnOjJYDJFzw+Ezy/W1/3+JtImb9G4AAozJWed?=
 =?us-ascii?Q?D0d9CjwGyEZJdGIglf0gQb6w03dQJReFhsSKmZJeQn5yvLTi8BYXOIthQmGd?=
 =?us-ascii?Q?jJ5aX1VfrH4T/tIxLnvGvc0zVieut5li3p81Ri/GBP4DvXo5mB6UjE5VNqQe?=
 =?us-ascii?Q?tvBQZL8h+DO77sK5j4vMTtSq9hqjQchrK1+dsTArjHfy/9NddZwI7D8mBVt6?=
 =?us-ascii?Q?ELG2kBYPQtzqyPpN2ZgylWSwkufbW9IEfxo2YZCx8cTBGbd2FpiObRSw0zJP?=
 =?us-ascii?Q?hq+x9UJDMuKDdk5qvIxep6JhOQaqUGwj8TjPJbjp4t77sca9uhKnvXWqq/VQ?=
 =?us-ascii?Q?9glnf4/zDQKwtHAxjJmiFL0AYqeiw+YKZbCgX1enZWbdkrLJb9tcxE+wRAh/?=
 =?us-ascii?Q?aWPPsjon7MpazdVCgzMJrW9S/vvva6+3zzOVkfdmmE+nsGWK8JuFplOhQjSx?=
 =?us-ascii?Q?ynaFQsK7rg+sjnFwggVwA/b03QLCK/ENuGo82GRwz9jsSPaWKBg6uEgDbNm0?=
 =?us-ascii?Q?NGnMD2ndZvn1qGSg3I9rPehnNwtt5s8JFIjCVOhOAZiVCymxJyuMHSbV85Cy?=
 =?us-ascii?Q?3Wvk+9D2Aotm8lk0tL/Fwhh7wHeRSOioEMrSw2TNIc11OV6TcehPAT0kYU2g?=
 =?us-ascii?Q?X89QcnE2C36HT5b9LgL4hl+YqZjStOv4lJNF16B4mktYesFNpsFXIZ2FT/+x?=
 =?us-ascii?Q?MQ+mh+UiMa8keNHe2fqNGRAn1tOEvmJy08tSxJ3fJ5vSEh4gWhpu/Q2Sm1ry?=
 =?us-ascii?Q?Tb9oZhZKMB8chnATE5uolndDtv2vKHywlveDaK6ix4gfYjeHCE1gKSmjvMEJ?=
 =?us-ascii?Q?/MFO3qrjxKyqrtG0+N1c3PiZOtSuy3mvjJ4ysgdcijSBZ2E3ITWDLZ/ehAOc?=
 =?us-ascii?Q?cegWsDPRqr6xeYujdxi5mIG+ZnxyhuZuJzrkq2Jtd9wleq0qu2zxh5cI6A/F?=
 =?us-ascii?Q?AlIWrDcF+nYEx33bKN/bVk/JjCSTcuhpRnogVmstS7PjbHHClO+JrIO444jw?=
 =?us-ascii?Q?2DrDH9EIsYjA91HdmWBI4jkPLqRAiNz9bxXJw+GGoSRn6TN+g9XwxYqfD6EZ?=
 =?us-ascii?Q?MiqmblC/ho4vhQlxrc1e5nwVccAyscfHP0Fy8WVHuFWGvgRwYGuTi1TgEBss?=
 =?us-ascii?Q?zlnqLYAcmZqoHWBo1mnp8qvWwbvrgJvjx2LZzktU0xkSdqCnWZV9C/LLegt8?=
 =?us-ascii?Q?ZhnQKCDHl2jKTI3+e8EqBgJOiuTltDpQgta06TcKFYoTb4YpT3iAf74lAHSv?=
 =?us-ascii?Q?8JPLPZJGSD2/ETXijlVnDN1b22KcYImuCpRnsji+b2m5Nk9aHZI0bcBMqUY/?=
 =?us-ascii?Q?ATYh4/qsDW95QEAuR4gjovsmlhC71tL7lbTuLT04CWuDVdm78MJ4vsQjQXhE?=
 =?us-ascii?Q?C11C+3sCuYGgACKBe2w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:37:36.2094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9efc97f-1966-42f9-2d05-08de52014671
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

Fix a couple of bugs in the RPS cases of the Toeplitz selftest.

Changelog -
v1->v2: https://lore.kernel.org/all/20260111171658.179286-1-gal@nvidia.com/
* Use a single mask variable in the second patch (Willem).

Gal Pressman (2):
  selftests: drv-net: fix RPS mask handling in toeplitz test
  selftests: drv-net: fix RPS mask handling for high CPU numbers

 tools/testing/selftests/drivers/net/hw/toeplitz.c  | 4 ++--
 tools/testing/selftests/drivers/net/hw/toeplitz.py | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.40.1


