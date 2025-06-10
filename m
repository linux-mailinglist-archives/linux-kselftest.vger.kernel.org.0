Return-Path: <linux-kselftest+bounces-34608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E873AD3EBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 18:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFCB17A14E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BE22417E0;
	Tue, 10 Jun 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kYJwfzmX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FF23F43C;
	Tue, 10 Jun 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572604; cv=fail; b=rDGFRkKkHwlCMHp7d3Jh0m7+YEZPpBON3SSUUHSVnvib8TmBT9kL1ANiYU099ZSKobwjbbhY7hkoWCoHzbghAXGbOoJjxgS6BAa1zq+wCJ/rYs4t2Yr/1qqN1j6D2Hx6NbsB0u/ZneGZn9VmmEGg2YeialC1iUzM5I9A9grGr9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572604; c=relaxed/simple;
	bh=urU0pp24u+LyuJIsUBY84YTPSsgPPy5w3n+3AKlV6dg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=F9NEx2pbr9HCs0xk1j0z/45dSyLfoVxVfw8nbLY6DaFaticXN3HwEhILd1XmEZNss1jtXlUg6+hIpt6B51NnX33g1IMb74gMTl+/5JNycSKUsIl+Yy7Sv+p6ZxJWlu+PT3rmNR+ooXrg/ofIM38YKEqz5gioQCrvQ8wkQFlMYu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kYJwfzmX; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nxd7ik6xmg9dfXRcfaObkxTXqxwbrhyObCIOXErgVwE3IwVyDgwWHpKzFjuTJZWhf8tGeZ4Fh0fO/sCnAQS6oL6WGwa6gGI1P2jGxcvk05W/H7UyKZGsthjqyV5hSs+PggFbExq/ffcJN0KDi80NRNWivTXY0d6FraFKKIBRK7NvYzT3iJu4JBNUFfeoNB7Y++7/PBkyA7bGfj83YFwXZ2uW0B8gdOFAE8kNN228k8FGMk/oocdzZUaAdM5N180BsQNJ8NTTbLaiosICJCr+63bXu55XyrUxWTzKA+TcdIGRsv/EZjBNlUQ2wqXxHe793OwRtdk4bJz2Hosa1FD4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urU0pp24u+LyuJIsUBY84YTPSsgPPy5w3n+3AKlV6dg=;
 b=YquVqpczY49/nNtqluuGVGKlBZrzDgCisLHx/F4DBpbdlYa9vQ6mfsu1tYz1/oJDLRTLR3IawIf3onNdfaSy8AzyWAi5b0Qcb7Jxx9MBD2LAUjf5pmfQFS8rPCGlOfO0GTofxIjOix1iklD83QdBgOxPYi+xIsmuYL+ZDDr0wR0qTDENXOh0HZ3hjPm2vmYxNcNF4zllMfGBKDoQGwADCAr11o2DlrMtInRamXLsPWnfbeVlg4B0kHzcjC5ZLscQBz13c2xCyaABT+o7Kk+b/VD2R7l1gldwr4szFygRvAkAlMMBrLfLxxoztrSOn0XjbkZ+h5YNXLnrBFtcspDNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urU0pp24u+LyuJIsUBY84YTPSsgPPy5w3n+3AKlV6dg=;
 b=kYJwfzmXziW/jz7sHrDQrWp/w5zhZNuYT5ZonpjzF9pidZREtwcWzVitfK9huk0Lt5d0AJzi/E0zzYPPLobX3bgVj31ZYlpqqbtJ8g+bo5VDAlJUaF8YTSRbRxrDoGlpdPRTkngKXNkwoVz7Gxul2iSVVwJML3tdYsANI/nREtJDY5d8eZxHFTJiq25EdzThlwAM5ryZum0UUxZZlHvzTY7I9rG3U0sPp+/OpXW50QE4jtEPyyUAfXaXUSdIGaVBj8QkAg/K/vhE1vKpw1N5cNHwD8gzfWCUWXH+NZclekEl5tBO7A02Jw/i9aVsQYn3Omqn3tIEixccZISf5qHTEQ==
Received: from DM6PR05CA0043.namprd05.prod.outlook.com (2603:10b6:5:335::12)
 by CH1PPF68E8581EB.namprd12.prod.outlook.com (2603:10b6:61f:fc00::611) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 10 Jun
 2025 16:23:19 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::9e) by DM6PR05CA0043.outlook.office365.com
 (2603:10b6:5:335::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.10 via Frontend Transport; Tue,
 10 Jun 2025 16:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 16:23:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 09:23:05 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 09:22:59 -0700
References: <cover.1749499963.git.petrm@nvidia.com>
 <d47a5edc84638eb27e2f57655a619b06051fa7ae.1749499963.git.petrm@nvidia.com>
 <20250610060259.00a17ce8@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David
 Ahern" <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 14/14] selftests: forwarding: Add a test for
 verifying VXLAN MC underlay
Date: Tue, 10 Jun 2025 18:22:32 +0200
In-Reply-To: <20250610060259.00a17ce8@kernel.org>
Message-ID: <87o6uvefc1.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CH1PPF68E8581EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 84468d36-2222-406f-18ba-08dda83b1ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pqC1cwad6dz/CnnzynuiE7oOdonFMtCRkTMShNDE8PagihpA9BKPZ4qgU7ZU?=
 =?us-ascii?Q?bg1Z8Mjb8Rm/ZpEa1ccLWptgMea/L3YGBfIf5SF4LPNR6/EGm8JVb5kKLLcH?=
 =?us-ascii?Q?D4Zve+3c7S3qx0niXgTd+xZH/4GvZTyl3q3+AmtPZvBaiMAenIhqcHJAY/xl?=
 =?us-ascii?Q?KrvB7dLTUh2svcLWmI96ihVp+kZ+v/QyziTORajdDySgB4JXtUexzgcGF4bM?=
 =?us-ascii?Q?SCfx0/P+nvu7IQtEzbbn+a6RCpWTeW5y24G1PfPLlpXH/RKFj6uAsFsuc/gJ?=
 =?us-ascii?Q?DfRC5vAOPmyEntMVkVcc1tCOmD4yyWJqUFNKEI5xDtBcV9bN30Xj2v+I1lgx?=
 =?us-ascii?Q?XqRhahBOks8d1ojaBQ9z6CFWAWEoSa/HpJrCdV5J3ahDoQ/eei8kYo0BIM01?=
 =?us-ascii?Q?Oc4piip4hhvilKnHrqGq1AkacNtMMk+96m8zhJ4uqMgTz9rbkTSDOSPMZSKH?=
 =?us-ascii?Q?Rp6ky62SQQH+mZhY0sjn36lHnLvbqIR+qsPvEFIc1BSXkqEehdIwSyaxMMWR?=
 =?us-ascii?Q?ziW+5N+JKiwg0Pg/JfWnYL8zWeMsufPA/0vPD3OHG0/ZWSgbcUN7TChKHek/?=
 =?us-ascii?Q?7n+x9LmChEdgr6TU5nlui4558wKYXYsZdHC6a3cZygfHeHlpR758/VKEZZM0?=
 =?us-ascii?Q?4GAvsvgrqgP4TxlLLwY2y2KKxHg7Jzw9WZ6grK05xYLbjKKq+Cmwin1W+X2j?=
 =?us-ascii?Q?7LBydrpYxaI4cgHaJmNipCJoLGwGyuKK3uIKKP6btOo84v21wGOrP3hC0o32?=
 =?us-ascii?Q?wwhNCKi4x6NPjwr8+6seyb/oK4vi/BseVuCMY8BbpHmdAZCuALb1mFlfULS6?=
 =?us-ascii?Q?XmLl3yripxz0pja4gxRumv6l0qn6eIvKig2nimklJJmdafpMUq9Kc3JUwQP5?=
 =?us-ascii?Q?d/mkITD6+4JHndDTQAoIOOysDFMqgF6alPCvIlB7yRf1+uTsjkImoa7YI6ZE?=
 =?us-ascii?Q?HUCu6ARbrl6bUyy2ZHrnBHIPwF/IniuyE1IxNlsVLM1nQajZyHTJGhE6w5hQ?=
 =?us-ascii?Q?yPz6nXewAlDDWiMFXGY7Ti5ZJqs+ucI80HwRVkkBpKiOuzuimzGvKpM09ncv?=
 =?us-ascii?Q?7SpMkrCTR9dzRmF0NOTYECyvVTlbHHwnX5stN6gMhk6GOGw7Uh2RzoMsnUEe?=
 =?us-ascii?Q?vnt1zQiuzxU0wu2yWx2G2HRs67e4ZsjQxFOxAEkeSuVFyNc9i8ZZ6jiYeGeb?=
 =?us-ascii?Q?8YbTotv+8QdVjszVjo90crEK/otLne2AQafU3ZDGwTyoy7OFYgepRoshJQ1t?=
 =?us-ascii?Q?htE+gLYnFZ6cnOmMHsWnXGBz0BrlrPdZ7Odrh6WZiklh6rTSD+Zkc/WqpYfl?=
 =?us-ascii?Q?cIlq3QHt7PHPGR/ywwqk1y49FfhmakuFmBtJcWggjPgQmFrXbVuckrNKYZF2?=
 =?us-ascii?Q?+Xi9ILNRDwjlm4tPuGgDAQfYPnOk2coEvY0kzAfEV1bcy/ewy+soMZR/K0XI?=
 =?us-ascii?Q?3btk1V89Erv2YULyFkdOpTtpGelzLsqi0vAYTyELvU9mHnBYolTKlpry5Jtt?=
 =?us-ascii?Q?G621sBCcbGRXoTAljTaU/23RAISCQJGPqIkM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:23:19.4765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84468d36-2222-406f-18ba-08dda83b1ccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF68E8581EB


Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 9 Jun 2025 22:50:30 +0200 Petr Machata wrote:
>> Add tests for MC-routing underlay VXLAN traffic.
>
> nit: we started using shellcheck, may be worth addressing the
> warning-level complaints?

Sure. Sorry, I noticed and meant to do that, but it slipped my mind :-|

