Return-Path: <linux-kselftest+bounces-46083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CF3C72FDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 09:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DFDF328A8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848730F550;
	Thu, 20 Nov 2025 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TNbEBTt2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F32C11D6;
	Thu, 20 Nov 2025 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629073; cv=fail; b=PevLDdquLOTD/Cjjoo86iHEwDvlYvkTkfOe6P+o1Gv3qqc+pZ6yNZ6tAo7DrvnD6Da7HpaPBqNpLp094Oww45riQPxUWMeGC1a08NZI4/sv8+H317J0frdJcRbgVcz3SQOxh/Jh9OQyY6NpqGqm23UEhBXhx409UeMy4611fqYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629073; c=relaxed/simple;
	bh=UhKpTLnTPFkcAXRqtKZugwzdKHVZsctyFWIk7YzyF2c=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cBl/NlUEhA/7NkqUA20O3n2BcWE+S5AF2JW3hfxcbubPrJMhKjr3dMShyU1y8dgzzISXdYiiddTr/Kz7V/0eKNv+vRgX4tUKUDY/VtoKN47P1IRNIOFE+45xWyGMlkjaCMD9VFIfUIKyuBF81mDDX/7El421L1IvTB/4Zh1wwAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TNbEBTt2; arc=fail smtp.client-ip=52.101.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKggdSXEMu52ZrzGkNYd/oAIwfMyrYjGM+SCkovgkNe++wEO8SzD90j2PbmLP6Pu4bgVb3CnkkWIEmLvNCH0CFnbVwjFMQRUhMCXLTQGF2bFIxKFdIKPr+KgSrX8w42n2IemlnHXZZKTaBhcViOkCkRk8Fwmplre23cZH7zyaCH80cTu2Rdmr7J5mujksVyIeYsBd/Vc2s9oXbh3xcd1X8HLpFupk5JOtEvDPR2l4HzjVeTGz5EEI/YC3BiXIhud3ANTdjasgKprkxbBUWERiJrLwjBy7FXEIS1tsQjxrEkVjMD/0zJsdtPaZgZZlTxg1SrvRevBvrZTMyQh56jLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e12Ny2vFSumwHh7CDX7kiYi+qDXQc/RTm+fYhEm1NpM=;
 b=J1wiBRXp/2R8AlRRFu3Vln60qnQGJKxtZwYGV7qcAwZjt4j/DOGoZxvsgNJkoImZ2hY8BoUqYyjRx3nUY7vvGouo1Vsn4a6EF/x7ekc12Urjz2bWaJHrB3XEk326vZsrqGJJ80l5qXqHt3QqGIP2USxmjWPUyl5kaQ5cdxLS+5x0v4sKUXbfL7rMIY0bipjFAmt3bY8Z5KGJVon/4DqzvrcbiI6feFfG7ts/PB6tSrYZGxMs2PdoKfLspq7hJQMwZl+48XpiNOdB55LPRUh+uXi5N5XsO08Zft0BCH7xb7QpnE2fIC5X5v6shF58wy7Im0oYt6v32n8XxbnYsphWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e12Ny2vFSumwHh7CDX7kiYi+qDXQc/RTm+fYhEm1NpM=;
 b=TNbEBTt20SWx4H9vFc7iQbEq22POCXBsEK/pMSn5NzjT5tTkLvHQoS0yvH83KbJsC6GeRI3brcfPgZUTCXsuTmzmFKKGGPhZCmk9C8Ifbrt8HTDj4kazhPWNl1JGVNWy6hKSrTFKL+kZo9sCq9B7TCmEz2033PHARoGDK0geZRvXxkF6tJ3qok9Nu5SRsk+USKHIR89nb0Q0PKr5hZLLoQ+cj6DMgT3g2xmDgXnKGenBD91/cil0UbxadQATLOpYaSLXmjgE9eXbiifL6YiM9svKy2qOcoGUh1yfnW9PX79OWD1AcTOK8XIqUUktZ9OyLTdHP6pKeW8H/pFCdQmJ9w==
Received: from BN0PR04CA0160.namprd04.prod.outlook.com (2603:10b6:408:eb::15)
 by SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:57:48 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::16) by BN0PR04CA0160.outlook.office365.com
 (2603:10b6:408:eb::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 08:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 08:57:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 00:57:28 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 00:57:22 -0800
References: <20251120021024.2944527-1-kuba@kernel.org>
 <20251120021024.2944527-4-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3 03/12] selftests: net: py: add test variants
Date: Thu, 20 Nov 2025 09:55:48 +0100
In-Reply-To: <20251120021024.2944527-4-kuba@kernel.org>
Message-ID: <87y0o19j4h.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: b0415493-64c1-42ab-927d-08de2812e156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i2etTOBaeQBkgQbP9OuSsJK0Jek5gRlTFZuC+H8Emg71CHWeb9JbmlpFy+Kd?=
 =?us-ascii?Q?FGYjhHA4gjdoiUdiFG7q07puqTXux99TNzjgPtcTcootHve8owdM2WSidDS6?=
 =?us-ascii?Q?q00zcfeXUyWZMptpYdOl9Vm0w9h5Bb4fNTvRQiZmfnilS90tmhhdND1l8ZwY?=
 =?us-ascii?Q?Twr8mPzO4Mu0FUzSax9jZEbrC1K4vSO/5BNIxtEBR0Y8w51sriw9kaDoYIV+?=
 =?us-ascii?Q?5+Kvr4nf+MP9oLtjWPyQVDJPjVEmcUzhVHvxtwUOl1gOoiYeZxd3AlU2oFkF?=
 =?us-ascii?Q?VAvhxMQnWjQOWYHU5zk8oK7xj4K8Im8XOI32UO96o4mBBdPIaWg78u5KRjyx?=
 =?us-ascii?Q?OQ8bBZxTCiEBoX4FgcnEmMHMIC/VYdpzBfJZxGfEC9b+T07b3HeN+S6b+WlM?=
 =?us-ascii?Q?+q9NetYQGeYmyzxevGrMApCDVSRhnX+XU+CN0kaVHCwqNM1LSxryvjWNmRlX?=
 =?us-ascii?Q?MCcG9+oK3HYuihtTu0Y5sr+eCwGTCyXFSwC14UU/eBe53J97YlWpftVMGHV/?=
 =?us-ascii?Q?T7MUnBGf5u4bBlsUCR8ejDOWuUC/SCeQmNUo5wmURTwAqfAzRjSPXNY14ebR?=
 =?us-ascii?Q?nC/eXNZn8tpMvvACrAPh1YKX+iB7WdPXPib7x5nLyNzqXa62RsAQ7HsZ+Yh8?=
 =?us-ascii?Q?DrVKDgPjMQ0mWztBYeXU2rB4MliK72Kg1LwItf3VKVGNIN/NAGaAQA8doBrS?=
 =?us-ascii?Q?qnrzCx3SiQPsmnw7ci9WZp3cyh0oayx8WbABYn5+raX+spRlmmAsBpJI8y+N?=
 =?us-ascii?Q?V+qKybe0RVRk2X5+8zTtBPfDxqPEziF6zFa9WL9RlAWDS0NnpxHEwKm7I9GJ?=
 =?us-ascii?Q?NEPXngafKrJPL58WL/k1zTtzDNeMrHt9huMdFz4TJZaHizD2CfsT2MAi1haK?=
 =?us-ascii?Q?DEmLtxBYzELSt7shBl4iwO32T309WuGN+TbhtQwK4/8CFkvfhiTVbNZM9aTK?=
 =?us-ascii?Q?tkpexAGBLV1Vg4z3zPFWs1zdKb50QtGOGLLdmb2aG+uIttVQoddcbhY6RF2E?=
 =?us-ascii?Q?UaL+JQGBp+cT1X3eKLaCOw40FY5Xyh9R7pYwz85Yjf+goSFUaF2opvNHUl8h?=
 =?us-ascii?Q?zvqYw1Mv1ownbw6RSGgLaBCoYmS0g7uN+I3SURyYnJJze7oRJHZ/YT71DDCM?=
 =?us-ascii?Q?Hc/6ZeKkNyP3MHszu0PlSHElFHB8LPAAzG5BSU7ILXoFaRukfzI0t1sJB91v?=
 =?us-ascii?Q?aSmR8FcXuDho/3NxMt/E0qySqbsTRYioGKKpYoeM2jYwbEYpY2R54o+KUkj0?=
 =?us-ascii?Q?Mb/Zs/kct83ztc9c17t6pf8RUb4ULAxFN/EGyP4792vlrHpC2mNmFT27PVeY?=
 =?us-ascii?Q?QM0rZW7zIWPbo8gOoCUhE2iT4qSt/Fv++Qip9gytWIW4m7+ss6onaTvWO0/C?=
 =?us-ascii?Q?tpBKqbb5EkeHnuN4eW2cVeHriDddUN4dcm/+gB46tQBFcZSipSEP32nBzD9w?=
 =?us-ascii?Q?tvDNhomZnnATp9tHt73Lien/VqCAHQI6a2xkEw1RuMB1rzi6BveyLfmxzrSQ?=
 =?us-ascii?Q?NOL83Try6CcbXtA4AthYlSqaQzsA3T8Hjv3MQ8gxI5dKBxRuHMjcRq4VLdPg?=
 =?us-ascii?Q?RPBS1d7zBL6cPB+rz48=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 08:57:48.6251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0415493-64c1-42ab-927d-08de2812e156
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9


Jakub Kicinski <kuba@kernel.org> writes:

> There's a lot of cases where we try to re-run the same code with
> different parameters. We currently need to either use a generator
> method or create a "main" case implementation which then gets called
> by trivial case functions:
>
>   def _test(x, y, z):
>      ...
>
>   def case_int():
>      _test(1, 2, 3)
>
>   def case_str():
>      _test('a', 'b', 'c')
>
> Add support for variants, similar to kselftests_harness.h and
> a lot of other frameworks. Variants can be added as decorator
> to test functions:
>
>   @ksft_variants([(1, 2, 3), ('a', 'b', 'c')])
>   def case(x, y, z):
>      ...
>
> ksft_run() will auto-generate case names:
>   case.1_2_3
>   case.a_b_c
>
> Because the names may not always be pretty (and to avoid forcing
> classes to implement case-friendly __str__()) add a wrapper class
> KsftNamedVariant which lets the user specify the name for the variant.
>
> Note that ksft_run's args are still supported. ksft_run splices args
> and variant params together.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

