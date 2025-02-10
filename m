Return-Path: <linux-kselftest+bounces-26172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD30A2EFA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CCF7A29E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F32528EB;
	Mon, 10 Feb 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rGh8lg40"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F522528E1;
	Mon, 10 Feb 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197498; cv=fail; b=iOMTtg2wqxou4nk46RsXOZu7VI9uwaHnl7Ra15UVCWI886wE+isTVh/fTWn4Hl7ol4wjvh5fBzOFKVeTXCsWL/bTebfJFFimXbjrHYukuEa/4KQPfoCar1vf2bNJGlLwftyUugbNNK6bGHp1BCSDudS3retl7S9D5ie+Ku6KjUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197498; c=relaxed/simple;
	bh=8vggrz8pg1kuLzDPvZZetLB4pmMzilLnFAAp7g6X1rQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nd1Vjwxswvn4ac5v8XYZaZhzl2j0Wh8TJG/wvdpyTaTAqTrvuRxClQhSKZCFd2BA/hhM5lPddr6dMbCtg6yJE1IZBfWhS41JNrXKgasR9l37DGZ6YcJjqgOIL/uaU25ig6U5hOJLA5qXuWgmt7q/2aYOXNvcH9wt/q64jGJ/0Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rGh8lg40; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2JG6xOkTsa5gnf8hbLxPyzEpW6WaeIkIWN/m5Z67pI49ZHWr/ol7TojX1cXRTvkohzjHK5kWeAlEuE9FN5Wy9+sfQeb3a/CPhNjPwayRY+sMTywSBFB+lrg9Qz3HBjN/btLMogNday186WLBS9aj8sv9dPffOvpf7yhu+/bUF/s0vwWwH0IdEuY2T9Zso50G+DxGQv4zkYdxhjZkXyGRq2gPZcVQgfqyaognqbyU3z0GnNr44dYuKbYtKCd7/STn0aSbuluIqI9zFhm3qO+Z6Cj3ex7eb0hVOiXY8WouoFFOPEROWhRY3mpyyIjM+6jslwOPVSsFQIe5APZrvg5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vggrz8pg1kuLzDPvZZetLB4pmMzilLnFAAp7g6X1rQ=;
 b=BZnYR5t5dDDeTXlmRbpuSPz/13UDo3VPOV8jQlvAwGQHuF4Xv4UidOODMo6nYthd58jY9qHDuPpthmJXe2mX6OV+wKdRkXjdpETASvC0XJaCdsXg2G3iN/NXQeosQPP+0BJk/K6rCW9mZPT3TecubLb2HK9jccv2+Dzs4LZko1EmTGnH4PcPgVKNOPdicpxKLbTt/p58cRv/sHaPLCGdBG9QKznCLdkygf/ELoJnXltscWcIi27XDtb06A9kF29mJ7eFG9Hm2QGTRKKPpyWNJqvgqlb2hk2y6FoOg3TXypY3GSuRBUHJ9U5HwNJLyzqDae6r19IGf7CMO95wg+4AhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vggrz8pg1kuLzDPvZZetLB4pmMzilLnFAAp7g6X1rQ=;
 b=rGh8lg401CWn1dqci5Zl0WotmxdQkBOCjK+rSBlZWd95tTD6GxcG9M7CKdq3PNMWXqNhhmdKSYOv0rbf0AI5lm0MHVpB1jReIoYlNAskQn9l6FsssgLsQM2/BbZu9gbwpHBvguiOR06UYnjVUrRhEJTaSJd6LW5wJ7ZAp4aKP9VTPyp3DKbBdeY5b7CyKsF3N0b+Jpi0hpIuP+C/l8X0mdo0gH4rQucX0JTdYCCJT1/MHVus7CLYh63y4QhD+Ubww1HKrPFvhqrqv6GWTimk89kQmmWAi4a+Hm0fVytYMcJRllD1otDphGXQYqCAdhYHP0LsLKVEKoQfqbdlj5tQOg==
Received: from PH8PR22CA0018.namprd22.prod.outlook.com (2603:10b6:510:2d1::24)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 14:24:49 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::e7) by PH8PR22CA0018.outlook.office365.com
 (2603:10b6:510:2d1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 14:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 14:24:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 06:24:27 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Feb
 2025 06:24:22 -0800
References: <20250207184140.1730466-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <willemb@google.com>, <petrm@nvidia.com>,
	<sdf@fomichev.me>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: factor out a DrvEnv
 base class
Date: Mon, 10 Feb 2025 15:24:02 +0100
In-Reply-To: <20250207184140.1730466-1-kuba@kernel.org>
Message-ID: <87jz9xho8e.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d2c357-ce61-4311-2083-08dd49deacee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w7R0+52sShM2CImJiOg7xki5gsXAapgkanmuQYnQ/rrlICn8y9qINkv7+zL5?=
 =?us-ascii?Q?nvJ5KgIxj8uYXjRND8sU39iZw4fztaXy1bbY8IBzZ9sJWrgQoywXHVyaEDGA?=
 =?us-ascii?Q?mcbyPggGDjopw+Z/dMmS8ao6TiKPibbAvlJAa8YRsd2gj2YzkUhq24U60587?=
 =?us-ascii?Q?nu5VYuIE+7yUBIOVDQHEwNC54eAtM2A748XZrBEMy/0YCjf1fFEYGzSt/sov?=
 =?us-ascii?Q?kEhQF57eBDyoPon9r9idl37lzL2WeFVAz3J70qptGE/1vZ70XgxaMHkG7/OP?=
 =?us-ascii?Q?j7Kh/EJhDX+Z/PEMDOACYMwlHdQzo0Xf7cBAXA7IJYwBTk5Ah0ugdar4CBLD?=
 =?us-ascii?Q?uRX8/SAYkTf9CJbeZe0VQlS1m0URq6i4CpEy24KRrwhxG39jAAxiwJe8zPAp?=
 =?us-ascii?Q?RuAM0XD5qQsI3jSP29fRK4Lxl9RoryXCzROX+yO+XeMaV3KwRs9mUFAqqMv8?=
 =?us-ascii?Q?ArGZZ5xJEvfjlK65VYbbqhCtxloK9ymHHu/fcYOdVtIXermW5K8afF+2slA5?=
 =?us-ascii?Q?GBKfk2XbT9192OEkDEkteayy36i4lh4QzV28/XnYqYNURsPYMuyJO4CVy86y?=
 =?us-ascii?Q?qs2l/gSFLN00RZgu+hdJf2QuJfPNSutFXYmeZjJYa2xrq4m4RpsYvAJP04AJ?=
 =?us-ascii?Q?DqFqBn7lVaYbHDH8RZzvKDg2azADO6ml9T7HRJMWyOA5hsK1cj/NDJP4NJGG?=
 =?us-ascii?Q?1fARuLwBUCc99n5poLbGQCgfeN27jbCC6VeQOOo5B0cXe/+76V0nNCc0MWCR?=
 =?us-ascii?Q?EH2lwGRTtRyFZZLFqr7zl+L3ZoHoHEBcZzVjCiR3JcnmDM8lqluS1S/DJVAA?=
 =?us-ascii?Q?J9AEQuGrbLfGt7mkghYmJW0CqdMOB3PBsMj3VNSadsPPa82yhnqkBNhGA5S3?=
 =?us-ascii?Q?4gyi7MFF/V6kR16bjmEywoOD3bTwlB8x3Ryl5ymRStJfJ2jVMIPnN3JKMJ/g?=
 =?us-ascii?Q?q6XqS+sM5JzKr7eYYWoB8OuMgvtUxvH9e5PzGeCJitPWuGp+xO/4QMzj3ddU?=
 =?us-ascii?Q?xcsUtGFFBCTkgDc1lLyvgEKZIbhwZB97hkiOA0wFJKNF19TYGLDI4+6boDCQ?=
 =?us-ascii?Q?cNiswEUZELjL3u0K8nRB0gUHq7D+9lwfmXA0xmFDHDP/WzJ7o99Qw48PJNdg?=
 =?us-ascii?Q?iLOCdYmlJubKfQ/tjesBsOmipxnhziq3DN8BmdfRSOlOfTdoXqEwu7Ux2d8t?=
 =?us-ascii?Q?Tq4SwS2K8huuMyuvp3vRF80IJaFC9uDqoqZQpz8K2eG5NckYyoaPEF+WshAj?=
 =?us-ascii?Q?c4/QdLZx9i/a35jaoaDk94haLzBxxbC0N8fg/O1Oqdr5m6nrdAUg69bhrWOr?=
 =?us-ascii?Q?VPKK1PQu3GRNeERhP350T07DPAKB/HY8R7UCtfv/IP7U2/q7q/WFwOfsQQel?=
 =?us-ascii?Q?Lp+sq6JwTOZCOoOKGCsxcGf4LtYmSfdb6hHy0uB7zl3VuA89QLljgNX9ZQKv?=
 =?us-ascii?Q?kOKJyeQN3mAQJZydl2hnuIlxAp3LwUTuN1YIfUMQB2GixjsZ+1oON3maj+3u?=
 =?us-ascii?Q?ExpeDPus0AktmtQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:24:48.7926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d2c357-ce61-4311-2083-08dd49deacee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993


Jakub Kicinski <kuba@kernel.org> writes:

> We have separate Env classes for local tests and tests with a remote
> endpoint. Make it easier to share the code by creating a base class.
> Make env loading a method of this class.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

