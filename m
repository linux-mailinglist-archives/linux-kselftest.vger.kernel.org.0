Return-Path: <linux-kselftest+bounces-23401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DC19F2E44
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 11:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850911887D3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EE52036FA;
	Mon, 16 Dec 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M+nqXdq7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BE1FFC55;
	Mon, 16 Dec 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345516; cv=fail; b=FLxS2dwPsFEoe+da+F2q3bw7rTA+W5Ei+53MidbXLjurYXBzZpkK93G5Xzfuo1Ty9UILDgjlFgk0kjiqGyNLXdQ3p1Uchpy4SO8CRoSrU8rphuhmAjGrieFsQFyAE07NpnBmM7BOAe5LVlrTQU0kl3YQlcL8Z7ewH3bEUc/3YrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345516; c=relaxed/simple;
	bh=qmXJDX6yVNWzCAEGfzWBhe4cXLMUt0acoi595yiXYB4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dlyT4yzRnyalYzdeROYgC+AH06yJ6Bp3zcf2KuXaytwqNGvqmwL+Xf9EqDE+V6p/bVfodQI9UCzw9syNJjE0/PaDgBBDLdNddC9CzewyMHyBPrWAsp2r4C+b1nDiEyqiV2Zom5SijHIrNYYiKLhOkJwMQIs/XJP80YLP6eaIOQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M+nqXdq7; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr4FT5i++dYFrUabGOncl1qWkDU3wAQxXvOUGs4Cpwl65DidFeWzFTXYZcj+TBayoJAR414W5BeOOSTy4tWMN7fNudp1rE+oWEkH9uVaULpWl8hRDVTFIC7A/2i4m6cV7TCp5UjCMxrZA+YWA8qdtT5Dd2belTrJLQ65eTF/mRFS4zWulgu5048HwXVc92MrKPkyo9/ikbW3o4Kl7vNax31KSbLowrhFaoP/tb7moMQpBQYi7/de3hhLSJaw1/MAK8iVLgqVSGVgNP8jABfKkwTuvwL6OlyqKYUmPNkx/UQSDIN4nH4lRG/1Z9TLCuiF8lpPe8csDeHuAI6IWXSfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmXJDX6yVNWzCAEGfzWBhe4cXLMUt0acoi595yiXYB4=;
 b=NxmkZqtRZvXfDayGat0bHeYEzRAXpXKYK0Y0g/VaS4Z/DayHwO6jbaBECff5X/MukCPIh+YrIdvVfdARQvVDh02d4wO/m8c6tZ2l4vqLn+eJIAtY2jmYSvKEBdCYMkSXJYi5qUg5EcVhlDtAqsB+xW05a0HdXgXKJvdCbf30E/OsyQgZVjmubCemTGlI907LJnU+s47OnoGwV8msyIUb42LNqJ+vUrklxldRs0gwjSX1tgavUqixZF4J1xB6rV8StvGVOFkuLGSE0NE43NuQmj7vDpkkmKKHic2jqD//a1aIe9bqm2wi4E0aZawlq7eL1gELKBzj2qMhSjHeLPRuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmXJDX6yVNWzCAEGfzWBhe4cXLMUt0acoi595yiXYB4=;
 b=M+nqXdq7Zkv/PD7VMIAwGokS77V7MAeCpLwE8oVNqmuwdYUCthtwWBeOaCjYIMlzW99mNufhDsBELHmkdg53vPDfWBoAZsj8O1BTnNvDO+abzFyPJ2UsCpD/P5pn7NlwPImpkEWQh+hJgzXfbzvIb+VSEpfd0LOuDty7yYba3JR7XwigYccrP5rzb9XyqT4RkfHslbkrIXZSqgXoXkVhYuCAZRuaVCySdiaotN5jwJyD5hLkFmlXr1ayi6VYr0y0hSBNekG8DWBxUGeSxYqutBTwQCet3inPaGKBNRSouNNzqmjenw0ik+9B0Gu/WPp+bKfqVXZDYkN2bu3nimw8WA==
Received: from CH0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:610:32::31)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 10:38:31 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::3b) by CH0PR07CA0026.outlook.office365.com
 (2603:10b6:610:32::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Mon,
 16 Dec 2024 10:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 10:38:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 02:38:19 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 02:38:14 -0800
References: <20241213152244.3080955-1-kuba@kernel.org>
 <20241213152244.3080955-4-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <jiri@resnulli.us>,
	<petrm@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 3/5] selftests: net: support setting recv_size in YNL
Date: Mon, 16 Dec 2024 11:37:51 +0100
In-Reply-To: <20241213152244.3080955-4-kuba@kernel.org>
Message-ID: <87frmnvrot.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe8ac8f-e15b-4a7c-0d08-08dd1dbdc8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J2PScz+0v59dARA4NMaEFog6/CQbEGgMIYGgEJ4zUu7XaQhVBbvIMGv/6lZK?=
 =?us-ascii?Q?AQyBCJKkWzgL9g+sp8tKtCsLJK11ZswnKPMgCg46XZnJc5lqWj0vhc9WEIhh?=
 =?us-ascii?Q?cH3EbLmGbvcxEbAkNIJfXsHX0m51K8S/vzwtJfk0jpHu8dFRAduunIOaYkO/?=
 =?us-ascii?Q?oadEHZq7+ppubJvt/CStA2RgVifmdLERX+khWiFiQPN8SWL4YNlhINlTY6HJ?=
 =?us-ascii?Q?XpHySb6/3dwRfWy3Z4YkQYDJ80k2guHfFUKY6wIlnViZ0Fvv1adkyR18HCWF?=
 =?us-ascii?Q?CewMcQDvJkwwEsQ6oEUOK0W5p99WN/KSoLr8NaoBr3crwrbOkZRyFJXF9rsV?=
 =?us-ascii?Q?sn5e+NCcEGwVIthFrcynWn0tfnfPn8MeHf2oM8Z5N0y/sDwLzM7gf0iu1LUk?=
 =?us-ascii?Q?OjBzaVZTK4E1zeIg5UIsvIRGgoP6+ZJgFZurz65M+DXGys2+edAZu0NhqRnV?=
 =?us-ascii?Q?HQU7C9rYCGtcvQremgFM03pZNS2UxudZrEjtO09umzz5T4cOAssjC51WGXp5?=
 =?us-ascii?Q?pVeoI3dzNfTbXsFplVzILqkiNjEeg5NQ6Mn9aDBfJtCBbQrAtot3Pfx3tElQ?=
 =?us-ascii?Q?2/17pzgBV/1vwAnrhgfwxyFsSIP8mTvM+t5kCZr9YOE2QKnZw+J8cNL5Yxaj?=
 =?us-ascii?Q?dpEhex0l7iIzMvb4SeI6cKGJx2/4URGCaSGWoLpcaWyk37Y8OFGJ5Oi0vVa7?=
 =?us-ascii?Q?XpXkPiQFQNXrDZees2KDBapb+U5t3twHut9CN7/Qw9rCUzvywbfM10jkMDI/?=
 =?us-ascii?Q?CHbEUBFpQ5IAi21k2aPWtYaEHH5EtivjUgzmVWS9+NaAc367JDx387m+qDgL?=
 =?us-ascii?Q?rPPbqtA/R7agp/nF6VfScERm0nRhmH2Rzjh7obqFovqO/MMKyvPLhbqF7ezz?=
 =?us-ascii?Q?YHt4c8cmzxvY1ntuMCExj4yyJU0i8SD5Ux3pEg9QYms7vov8MZdmVqY4cUef?=
 =?us-ascii?Q?JA+y2ip54cjv523t2mlPa4aKK19z5av0l496I8in9bZpygYuLYoNxLxh7+GT?=
 =?us-ascii?Q?gsh/ayjYcbn13DovnmFECkV79iG43Hb1XWsuPGkRC8f9t2eq0CC4Ajd66Nt5?=
 =?us-ascii?Q?kwn/zfHD0ulxwkPebWI9RWkt5+sXIYSRI25kBJaHW/fOTJBTrUyj4oNc/KFi?=
 =?us-ascii?Q?QicroxdNtgtUMs96oj8VFdu73YG3SP4ycUA+TB4hdZ3z6GffKgw+RblfNmff?=
 =?us-ascii?Q?1ir8BRSo7fQIpC2FcmXIvFqly8I4fS8LgB8tYQZURELmqDF/T9smDdwOecVz?=
 =?us-ascii?Q?GenNZBhL3w5SRTlMRqw/3tt26sgPodpdvzCc9kCYiaDg1IVMijKMWTABVngh?=
 =?us-ascii?Q?a1myDs7mZ/f4H8aJ393NV67rFkjiH4ZeKNv3m4hAEcnOo5kiupivfj6GBQTz?=
 =?us-ascii?Q?s9++X2WZhEo84qgVsrx1uvOB7uNwpE8MY0ADYbaylfpJjEhAPFx0OodtL9lN?=
 =?us-ascii?Q?I4D+IhlvvJDfvJg6wUoWieUvIhoYaTCqgbbOYqwomSXTyZFkHXYWidz7hQDO?=
 =?us-ascii?Q?Yd869V8E7/htjG0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 10:38:31.2796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe8ac8f-e15b-4a7c-0d08-08dd1dbdc8f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601


Jakub Kicinski <kuba@kernel.org> writes:

> recv_size parameter allows constraining the buffer size for dumps.
> It's useful in testing kernel handling of dump continuation,
> IOW testing dumps which span multiple skbs.
>
> Let the tests set this parameter when initializing the YNL family.
> Keep the normal default, we don't want tests to unintentionally
> behave very differently than normal code.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

