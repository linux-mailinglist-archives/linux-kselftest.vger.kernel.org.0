Return-Path: <linux-kselftest+bounces-46014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC308C70638
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 18:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C290E4E50B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436FB3019A3;
	Wed, 19 Nov 2025 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="alBGeSgC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3FE301710;
	Wed, 19 Nov 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571985; cv=fail; b=mWWycRyp7bYGybkcisCxGpegPO2zPdCCmnBTchxmSND0UdS4JDWJl77zgJ2Sx45J8GAKMAFB/X7vnF7GFCcZ2VvkRU/8WTCju25TLjYEQJwLO5BfukU6GwT5u3KZ41dxEDP+cLI64TVtNHAjnGwX075hoHWOyDEr/YkETVg0hWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571985; c=relaxed/simple;
	bh=uQh3IhU6iZCqWq6XE8N47t8sf0OCkd9m5fFpP0TtOlo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nLplOj5tjnnec/Ge4bFbXq8AZnLrDd4KrnmGEhw8aQCPoBPxfSN6FOAnn/EeZml9HVBOJerYFKjKdr5K1xbTzlNn/SpTWVThgBSJBJW8ksglsrfpvmahPU47D6qbqOrk6IERgLq1ZO+1q4893SeEX4dKaZropj03wDvKDeiA5lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=alBGeSgC; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qopgryFlLCJIkcpQLFsx+QSNV6ec1ZKIDgNhtmSm86BnXN+S/5o5nTfmQsh6U46eVqHJYpSWfm80d5WpuYiuLCoCjQ0ypT1V6c46hc5kLb0VVLE6lL3ZNllthVRxLFZhV6SpH2SNarpdTYtM9g3q4Dj0uVcUZ/xbekazbO2V2XLmPBZM6JwHGiQ5w4rr36t2TqZAWzmCszRlB310OMknz006ipgyqeOAmNii3BH6LR5bYzuTx53qTD/N6xnVkWwC7LlgAFIMYsvXZHzhMO55OBybDbXcECb74vytaTTvt8N2ige3eRtTB4QOEwgT9T46qbtbNmfFqqRxlrzLYDRdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwVE2NJUkIsQVWZsT2nagq/W/eqNrOamyAVYF4OyzI8=;
 b=ruhXXcUe2XZs/0gDig0IKqL8ZQTbykCcgOOuzjaukZp7iVVU6GbAtACKZX2pgX7t18Pn9KE21uATllWvj6ktta5PZVUWe7g9Q9i9g8S3QAtJDWYF69NqhDGnryhtS0jODtalGbSsiZoYbbc4EW9BqQBiFj797IGfvQp3FRvcDOQc2VIV8mPg+wzbhydpDHqTEZaioGReRrRUHQvWGTMIrtsPT8crSD26wXbc/ZzYP6D6Bqy/UL5p8CAQ8x1DSko4KS0WjZw91u+hv8gQ2DNUQpyjDpZXEDKbn3WveFRlHlW3oOG5PrEKzCYwaveQCsO2vumz+QlYGIr28zkuQfZDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwVE2NJUkIsQVWZsT2nagq/W/eqNrOamyAVYF4OyzI8=;
 b=alBGeSgCl1Ecd7oYaHyFhg1A6UrHNjc4jkLaoecVqqWyCOSkeYoMM+Hxp7TXdc77lKI7M5EG3gISkD3VbhPUadKTiLjHUctEA8h7vzFC/NzexXaZmyCLPxXbBiGE+yC/D0xq+oKmCAURKA4mTIgtFz1GP8t/dBWb1TVIysbD4M61tlt3CgaGJeUKipLEcak7nbivTNb0rotylhF+sQWnLvTKsTP4RHImKBp3zr0kptnHDzoeTH47vkUE+oxO0IOPOfkOR8UCpr5TWyJIreDfrbHObYlhcKb1XKvKxzvo6aP6O4NouZrdNE24D1Yq25e3WPOBVZXTiX3CY5Z5mwxt5A==
Received: from SJ0PR03CA0146.namprd03.prod.outlook.com (2603:10b6:a03:33c::31)
 by IA0PPF89A593F05.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 17:06:20 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::f4) by SJ0PR03CA0146.outlook.office365.com
 (2603:10b6:a03:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 17:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 17:06:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 09:05:54 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 09:05:49 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-13-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 12/12] selftests: net: remove old setup_*
 scripts
Date: Wed, 19 Nov 2025 18:04:55 +0100
In-Reply-To: <20251118215126.2225826-13-kuba@kernel.org>
Message-ID: <877bvmar6d.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA0PPF89A593F05:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f75053c-0912-41ca-6c19-08de278df606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DhskSzaZ5mKwT6+Q0VtlP8t/zZTbHh5qSbjEtpJqlFKLKk8bR2kL1bqrP+ER?=
 =?us-ascii?Q?m/L26i0E/kwDYNKYhbdbvIf9ovre/nhyE77TNPCWGwnjawXOTTFajiHuipPW?=
 =?us-ascii?Q?lKVOnND1lhFLr7XGze+FWAt2rbbM0g9zbfhpFeIsXYTaDEWD+Tf7rnfcKksv?=
 =?us-ascii?Q?JyXjtcbxziLETDQQXAVh6dIMB91vwg7SmRKTcrbiDYLC41B0xq1fNx1/Znh+?=
 =?us-ascii?Q?tI0bNP2tIvIOFFOaaHKLGK36T9hCl8WG4let9IBRIOhKqo18grWsHoI9PKrI?=
 =?us-ascii?Q?y4HFYeub63UTABUDYtvk7WXYPdFhPYtTZ/k06nqwACD4uKdw22RuauBUPLSQ?=
 =?us-ascii?Q?1X4hZlhwf6E2lNW84lWCIj8NoQRtbyQuRTHC+rmf2Cvw3wImdKQGp5XGsUp4?=
 =?us-ascii?Q?5AK15ZdrId0LEY28YUZg7epzwwO5X9Mvp01aHCmJirgao1WwAVuyL94PZNcU?=
 =?us-ascii?Q?g0zY94oJfz7ZPSY7EP6/df83pn48/HraK8j5kTr1tj33lmFkM6P0e0bgpkde?=
 =?us-ascii?Q?5AwjhM6VE7o8lQaGYPySpMmtMyZ4EQ7C28QnV8Qk9T3KX2zFNCRSfclUkkQZ?=
 =?us-ascii?Q?6WkqeMrfWjoOqciSoxW5LrLB8EX7LXH/W7WXJkaqfZ/qcdBHnq0xVjnVOC6M?=
 =?us-ascii?Q?RbLUeqW1sMXXj3sLAkx4pF4YerpUt/Pl4VocB0a2KnYY1cLdFp5j6+b1Lj7Y?=
 =?us-ascii?Q?7cPo7MlggzgHr42SDOhbTN3zeHTNV/D13ydbkBDRctLcnzFsJ2Qn3YfOZaPN?=
 =?us-ascii?Q?YQv4uU6/NqTZBPmcjl6GdSKznLDN6gxI10Hv6O0mcfeHFzikM05Hv9zXBCat?=
 =?us-ascii?Q?bIGATPUt5p9Inw30XxT0Hqs1+wWQl1qRTYaLRh1mPyAzE8G7rJov/e+SPvEj?=
 =?us-ascii?Q?YDWVDMtbvSiHirJcqJFZcDld6Cim5AQY9BB7eClu22fF5GxYbK5fxFwn3WkN?=
 =?us-ascii?Q?iGA2jzVvcnLytPhEGne9qhsHcuT5X7VcpikjBy1mIJfsGgjYXt3erV+BKKmC?=
 =?us-ascii?Q?G09zaKwbS5eD/kU2AJRYar8F7uAOoziKZ2HXm78fNyMmm3uQLeoVMjCAoHSS?=
 =?us-ascii?Q?e6MOuZIoDo1XIFv1nlDiZWWtW2msUPzQ1sMkYLMfqAHh6EArg1XrTUnUP2jd?=
 =?us-ascii?Q?vHH+MJEQ482JeLA+1DZQyIlvQ95XIXzsbuv2dBdYpCZi1X1++F+Mkt/MBjiX?=
 =?us-ascii?Q?hv/c6EDNxFEJj2gInTgPq7VRs9xccJ3tIJLAc7dLYWTljJWHJvCyXsx+bIwS?=
 =?us-ascii?Q?iynd5aqZgA9TXHq/bZ+xS7RYHAcAqALUUSO/ZBCPDGYhjwgoE2gk2f7s48sw?=
 =?us-ascii?Q?YeBSfV2VM+7/wYIToTOTVJ2rbt7Om8HqszlJltXjmvFwujBgUoE8vTsC8jL9?=
 =?us-ascii?Q?CzuJT8FUZHsYKbi3DAZVD921qneDWSXBs9ZfjwWmIGW0xGkOn9YhZKtYshDn?=
 =?us-ascii?Q?VqBftIlMnRGmp/NaTGDs/Df/9RDAsVzL/W0qYSM/a2I94ZubGCnBTLweR3Jz?=
 =?us-ascii?Q?qrMkFxZgyX7wvcAFq+3DkLJoVc4hqd1NYR1gQnBlRAd6oyCQhFzwQCUnzPC9?=
 =?us-ascii?Q?HPVOxDfPYrwWUAfpgCA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 17:06:20.3422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f75053c-0912-41ca-6c19-08de278df606
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF89A593F05


Jakub Kicinski <kuba@kernel.org> writes:

> gro.sh and toeplitz.sh used to source in two setup scripts
> depending on whether the test was expected to be run against
> veth or a real device. veth testing is replaced by netdevsim
> and existing "remote endpoint" support in our Python tests.
> Add a script which sets up loopback mode.
>
> The usage is a little bit more complicated than running
> the scripts used to be. Testing used to work like this:
>
>   ./../gro.sh -i eth0 ...
>
> now the "setup script" has to be run explicitly:
>
>   NETIF=eth0 ./../ksft_setup_loopback.sh ./../gro.sh
>
> But the functionality itself is retained.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

