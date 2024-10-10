Return-Path: <linux-kselftest+bounces-19426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FB8997FBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 10:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743771C23852
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492561FBC88;
	Thu, 10 Oct 2024 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dus/3EQV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958741FBC80;
	Thu, 10 Oct 2024 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546284; cv=fail; b=RP3D/HxEjFxCwDlPdsoTMjV73cNjSZTHB2wwbIIm3r6GRXVkbAHmjsRa11h+d/NlotYrIqOEB4vDOzTtoiOiLElsnm2Z/ECa9//pdILKFqzLPVtvWclmIu5bBAAN4i43qxSqqBIe4JFz90rb4ENXLoxLcqxA2rc/dcbVQtEnLqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546284; c=relaxed/simple;
	bh=kUTX4IDUXi0X5KYWngtqQmovCRUao66RAFPaaDh+oZY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eq9mTJ7BtyIdn9Gbsw+G7k6TO5AVmtDHJOO7cJ7rTNg74RXMJsVTAGgZ55n/r5QjpRok1fZcKi+5KM8MZcasCXAxwgdoE8tRTLMNTMvPAG7XSSAf/l56OFZi/svc1Q8sGuhiRubb9v7yPh0JZIccaZGn8cIrY3tMoRZlSiHnBO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dus/3EQV; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBcjbushtUOWCSXpW49r4/Kv8qPjpXSEbNqVY9P77FKKWVS3sE/FW5hY02rzwcy7OzuuDbQFCUY8hRIZGVDE9Yxt3wReHyA8AYxK1ZyrENyRNHFgPG+WWcbMDLy5tGYpiBGZSM9B4aP5rmotMPWBYYZk0UqYMj/C7oHyUxydXWLmNOmu+avIch9xiI/JrXr8M+fdQIWYJFVIutzz0yQVwu1GaJ50aPOr7jOtgTWum0yZQh6trrkD9g3/XKvPPhUKYdrMe9cUE7jR+mRd/b+SPo2s9IGNTbHwm5AKvgeFzbUsAn4HKonhFkuWAQeTnzcnIoSt/bbP2Clh2rtc7g8hww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Npd3BftTn9h1u+7iIbo2iHELQRhAz5mI71dg2Ws86nw=;
 b=irFAxOu7hapOEXl6pKGFvLMZvL3OZqLsZIQ4SbY6+uTswKwpF+H3aoQue9a1hw1zwJOz68FxgW2NJBTribNUcPnvLU3goZ3fp6KzUHgsy+b2Du3+v6+0w/nMNGgUCmkqVOT6x1QzjR4ljm+FcO/sCnaWWpsdRfHLWYH5NxqLfGVRGBWcYDdMG61aQoVGW+xApe+lioKm9wUO0E4Z5MVwo2dAIopXq5ojWetyWMHhpsECDaMkaXxdP+A4sc1S24iBiZ7NKXv4O0IZV00umhdaNEzHaGNEz/KANDz5dVpRC9eqJWDk6yYDXJRkSDM+q0QtznS/rKjGdpQcpkIsGX+0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npd3BftTn9h1u+7iIbo2iHELQRhAz5mI71dg2Ws86nw=;
 b=Dus/3EQVUqfCndO4VErXgqxpVVl1n/F80GI/SBGYTrHYrw26h/i8egAtV2KYD6jVobQ/pPzoNBUCdyj+/a6reOEE5qFVI6H2vf2Y3uG/2siXFZjGny1j3Y87yzYL08VLx+OlM6gMSDCGIySZZtobGOQ6wzsmr/+1909WjR1b39DNGyGgITQAHefF+hDImTrsL5dJo0MO+0d+louaa4AZ/pGyM6coRZX/koUtJQuwpzxmHHhbLtkbe8sFB8hhwJA34FgEv2uOhr5te1zjnOoapEG1G2HSVXpuM0BTKJkosDbwHcNbRBnXj68gzAxh48nqFviylJ1bpwqC2PZYFBmsgw==
Received: from BYAPR21CA0006.namprd21.prod.outlook.com (2603:10b6:a03:114::16)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 07:44:39 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::fc) by BYAPR21CA0006.outlook.office365.com
 (2603:10b6:a03:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.7 via Frontend
 Transport; Thu, 10 Oct 2024 07:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 07:44:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Oct
 2024 00:44:31 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Oct
 2024 00:44:21 -0700
References: <20241008220137.274660-1-alessandro.zanni87@gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<dw@davidwei.uk>, <martin.lau@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<skhan@linuxfoundation.org>, <anupnewsmail@gmail.com>
Subject: Re: [PATCH] selftests: drivers: net: fix name not defined
Date: Thu, 10 Oct 2024 09:40:01 +0200
In-Reply-To: <20241008220137.274660-1-alessandro.zanni87@gmail.com>
Message-ID: <87zfncier5.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: a219b095-f241-4cee-4475-08dce8ff650c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3TKeXOF+SJc2Txp1Q51VC3pBtoh966QuMXDXOJcIorad/hjR1OoNQNK2+qCh?=
 =?us-ascii?Q?CxG083jv8gez5w3xGH9pS0UmUWcFrfhVh3I1UcVIpBMU4xOXspKe7oq0Tut6?=
 =?us-ascii?Q?oThJZ+xgNzhRfTZ1WqtqsKF202vp8jdgWupRYpTCFnhHrmxm0jJuEGZwtEto?=
 =?us-ascii?Q?49+Xfj2AfVG1KpOIzIVDZ/PVqmAUUF7dFx6xLhacXBtqabMKvELqRlKW4WU3?=
 =?us-ascii?Q?w1N7dduOVozwZe0oz+BROjpGpuI2Zt+f/DpdiZK3GPge7HNg6VProHt94Bzo?=
 =?us-ascii?Q?6GY58W7vyNgbk8VnT+N5pb8rUK3LGIhC5i6TxrAxIcbAo6ThNfjnBxZir+b2?=
 =?us-ascii?Q?nvxD82+zOI9XbmF8GAkYB3Q3FhEANYj33kAge/guc+a1LLuCmejGw02P3WTI?=
 =?us-ascii?Q?Y+THqvs9NpHAaEFvG1En5mAoXIFev44bhQp9BxG5LQcj84T/r6nMmHn8FEAJ?=
 =?us-ascii?Q?U3P3HkaDEnKe78mm6LD0iPhE0Oiv6L5u5qb9MlawwNtNQiOSQ9MLd+VfdTMh?=
 =?us-ascii?Q?Q3Fb72Q98uNMHG5iTAZD+IShcnVuy+lx9JHlWm+EjR9Aj2Fg12hUwtOV20nX?=
 =?us-ascii?Q?q26ZTQ/KJo9UhYlYAjS/o0VZEDuYQ6Bz9FhphAML4WsrqdkXy2CldiNSapYf?=
 =?us-ascii?Q?uULhvBjgWtl88NZPeEZwwamggND8eWhosmtZENlyr+SkHMUYqq0he++IP9Zc?=
 =?us-ascii?Q?9cGTey5TljUi43PUkMiLPQUk/UqSsUgDtbORRVyJJd415Zmpd7dmdeJGeqvD?=
 =?us-ascii?Q?eOIeatLrlxAJXl+TItxpvJs7DT6lWfbU/LE22hwJNanzXbL0x57dFL0hsNzV?=
 =?us-ascii?Q?N9dPAaGhb7cpf+kgOnsvOaQRX/BdQCvl6W3KkdDuXWIF4KjiIRDQmp0kE5Y6?=
 =?us-ascii?Q?D13FTaqvGTt+7N1MbWEBdzZzFNiErWiO5ZaE2j8pVJDZpObswWyEmA7LQykG?=
 =?us-ascii?Q?KYHA94DpqUTs+yYizRIHnnGxA4MbYaO0O4eFQPFQya25CtJu31xHK3bWzBwn?=
 =?us-ascii?Q?HbqnF8+XlXW4wuwvfE0jWQRp5/ZJihvwOnvzqZNcbIAQIVgt7z6tpnfiPTFH?=
 =?us-ascii?Q?uW5B3Asf8ZuZwV/J04MGSJFGugSzA9YbcB8KdhYVqXrSuuHrTW7h/wwZk05E?=
 =?us-ascii?Q?6Orna5KrDwYGdwhM5psb17XDJJPgV9qQhpB06URg5d3ZYZxoJZi+MygA4qZa?=
 =?us-ascii?Q?WdCWPZk1kM3U4cx/1knSeXrcZXeBwFa1ES0QMu5oHXSXDMVD/OONCj442zJ/?=
 =?us-ascii?Q?9m3iB117HYAVOVlyVHplhUjGIeK3hNa7EuPsPD13PYYHa/z5MQzolHCLV7Nx?=
 =?us-ascii?Q?qCwNOSvss3182XDQf6DuxYJKeLPQt9hf7svPs2BLu4XbH4zmdGSZCwKsHJe1?=
 =?us-ascii?Q?acLcAirp5BeTV0YAN81Ou+tpWzbx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 07:44:38.9218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a219b095-f241-4cee-4475-08dce8ff650c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123


Alessandro Zanni <alessandro.zanni87@gmail.com> writes:

> This fix solves this error, when calling kselftest with targets "drivers/net":
>
> File "tools/testing/selftests/net/lib/py/nsim.py", line 64, in __init__
>   if e.errno == errno.ENOSPC:
> NameError: name 'errno' is not defined
>
> The module errno makes available standard error system symbols.
>
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

Insert a yo-dawg meme about testing the tests here.

