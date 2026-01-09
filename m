Return-Path: <linux-kselftest+bounces-48593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1473D08D4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 12:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F695304F11A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 11:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54AF339B44;
	Fri,  9 Jan 2026 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dBmot0JA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52433B962;
	Fri,  9 Jan 2026 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956982; cv=fail; b=ks0D9TqvNbNITZgsN+dw0x7wwnzDp05aic2bHcFkHREnRwDFkgb45BT/2aIg7PwnVm/CPXGw6dlNPxl0/AB1gltnE/f4QJubQ0/rlQBtBnZhGiwHozIgtGyzJrnKhvdkt5oomaLVbdfuEfHllJ62kwY7sqieK9sGcJGAceVzCeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956982; c=relaxed/simple;
	bh=aziUNcS8vmchlSthCKBFb0wqc81jeiJs+1/qvXtF91I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dms9bzGP+rIqFjV4ff7BC0Q1d3EiYez36qTKxVXLXnQLSVagueABFQe33Ao6Ifa6aNBjUpfVaNm7YY5b0AA9rkCxtg9xNf5FBQsxRalJUdBAElImL8QcAqXczPy2mVQ+60aYsfUuf9xCvVYiKvmiEdtsIsxtCI+cyHA44K9C0SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dBmot0JA; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KayQ23orOGWzBuo3PymzQ71xe8IvuyikSryuriYgiFzUHNzy5jlWZinhBfSYQAsfOdO+x4lPjU0zpCnVrIe0rKCrNf/G0DGXGFiZV+R65Z2nWZ7QtW1x8ufQ2DggvGhPp37fR1fl8iwKQE08XJ/CkNJJRc/l3zoeJX3/d8eLo7oTmYt67NLmHbzjKcGvv3HIl890SsLpg8YZjQoOfgZDWho6TlUg+AeAC0dJGGAyeJeRPY+8GW5pab8RRhLIo71gwUpuzPZGOmFaiQFmvUXziH+7LSOQjjQxkc+dPo3azmBSB/ADIsYLD41TctVi80nLC/sRVOw3sJFfLHwuudorGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcbBLFckhoJ7RTSa3xK4n1qSwLCZ2HniZr8cLT/4wxA=;
 b=QBPZixEyL2stkXYQdeRc60h+2fD8NVic3LADc8DuyzuLL8TUS1aRAlpz4tqSyaezTUE3d06+GUao/Xyic5YGKXQuRUzr0U3f81gmX97fL6UWVraT2hJDA2CFkRql5R/2z2m1ZL0tp6U1Qe9EpYuCHcFKC9MRdU5mTaGEG/IVWkImVqeWVJPoVCPTGCqMYf6WIkhkA50Nnq4P27nhlA6xdtSuDWfAwBDSUisNmhriqhgABtaPu+/fRpCRoYbvSbe1pb428/SZJU8D2BTCHTRtZTEqAUQgTunZEJ+X9NlsqAJG05FV5mQ0Th4mdMBRgroqvPpM/l2OhGGNRprrlNFdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcbBLFckhoJ7RTSa3xK4n1qSwLCZ2HniZr8cLT/4wxA=;
 b=dBmot0JAnX/KVWU6/ASJWSM2zvM0WRTCvugRR7W8/RXT999/O7VxUY+zR2W5FKC6WJe724KEInEKGaMOtyLXJ/654f+xpHJOZnALk9EsTCRScanGhTyTh/6DoJn60+KbFLRsnWsMjJiHwxTs+uXQSv6RkHooOXaJJexKwuKwia5vkmlaay8fNN57NnCO3lMpXncS0yTgYsC3cEs34BjaQBy80ReluDICuZDqfEKWNQlTIcxBab8N0IkJ3Pwf5YsSdEPW8lcO8YyfWarjLUiEMWLCsJN69nJAjT2Gjctt5mLxpYrwChUdQT3TDXUr2kyxLbBulXwZ3Lm9zjQIb7QSJw==
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 11:09:29 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::a6) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Fri, 9
 Jan 2026 11:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 11:09:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 03:09:17 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 9 Jan 2026 03:09:13 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 0/1] PSP self test improvements
Date: Fri, 9 Jan 2026 13:08:50 +0200
Message-ID: <20260109110851.2952906-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e2055d-b098-4249-e1b4-08de4f6f8ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?du9Z/+6ZI8e7WWdGcprwFK2VJ99LgL/jC9CUxGr1Y74+CVBBRc+LuYkU2+2k?=
 =?us-ascii?Q?gBuz+F5b7uigckZgQNli3ZU2DfEaYesShDqUnhQv6IO8BCm6VAxSrDUkgjSI?=
 =?us-ascii?Q?UHo+kbHucxXmK7AhL+VKuKs8j9ibXipND8lRCPpBYey1Of9rbqxZ28pgg0sj?=
 =?us-ascii?Q?8FR+WxbtYYK7mzC0635rcBaU0QVKogDytc3Iaa6yRcbX7+qqKAwPJGm6spem?=
 =?us-ascii?Q?rqZSLf5zHErSYW+K1z8hIexw1ZhKkxmX7v6wTF6Zs0EZGVan7BT1yVCE2r11?=
 =?us-ascii?Q?0EPbYsX8i5JlaKas69WbB4z/Dcny9eYb9YiQQqRd0/QJ38ycie6TwOmjXLj0?=
 =?us-ascii?Q?HRlJNqLgPn/g8G9yW4dGPY3WjRvFtMxhrqohSEZTnKDZM/Z/O5USVF0z5GAX?=
 =?us-ascii?Q?tPGrlSxvZv5lhgg0UIeJr7N+4DC9Om6DET6Vz43t6UxU1PpLy0P4i70CeUOr?=
 =?us-ascii?Q?NmjFipgLiU2BmCoHAgEiF+PsGPYeAravBlPIOBSv+0QSPdKobjqsCMyFZy5v?=
 =?us-ascii?Q?uKTl37SV/aJm2/eL5fLc0747CgaB+tvrscrr0l6R6NqcTvLVj9P12R6WVNZ3?=
 =?us-ascii?Q?+ZwzW0Il5v83kZdU/y6SbZY+wyjYr3DUVubneXkcriouMfaaWOtKZILCM0Xp?=
 =?us-ascii?Q?3p+fgyIkkhotyow1zt/Zmmck2a+cxh30U/hSi/3NMZZVeyRCnZA5aDxEqbEA?=
 =?us-ascii?Q?LEaoTPp3VaFl7R1qxiTLRZ84nAxwGgFjSwq3Krvq9hLET9xaSWsbjasS+YAp?=
 =?us-ascii?Q?57Q85xY4Opmw2zhUUxh3i1l1sQuN8YXWzT2XcdUA7LJPR/PrfkdHpMu4Chii?=
 =?us-ascii?Q?KA8qtGxWTJYmo9095WqvnuHkixgLTSpADHQvLXyIC1DX1e36JpZXppvBt0P8?=
 =?us-ascii?Q?FGcBFixpcLfd5Q1V3FFPG45nfr/XnyNwjdPWIsLIf5QozQarGJl7VDmz8kDn?=
 =?us-ascii?Q?xVZKQXu0kRFr8IUD3OxJ2MUzVeYQzYAkdYRz1ei5eTx0X6tzk4Oi1TQCRtC5?=
 =?us-ascii?Q?aFY2oEzO289UurBzo+p74/TA+Ks8jW+z5pfkqf+gmXS64sqbW6keTCYh5vid?=
 =?us-ascii?Q?UuXm0yxMRXH/s94J4Lht1s/sVfH1bNkpSUXjHBLF/6LB/6yNTu00nU5uj904?=
 =?us-ascii?Q?gD7LGklDLfAoCC6p1HRWtKI4eK4Gq5Epgvqe8ulIPfmWYHBL3SsofXKX9uV5?=
 =?us-ascii?Q?OLG7cQ62PVURefUKMdk5I9oFMBbGAvPoRVghsqmGYelXatVhGejUnxZsnjPs?=
 =?us-ascii?Q?S5uCoEs+AU1D+r7iIX96EbikaB77ivm8T8q6O2OJ5hB7WFMX0C6C2hoaPJHU?=
 =?us-ascii?Q?mdEQ3P31+sra7ywkND6hS1fD/mI1ACCLSTBl4PMIHt9X93kakr8YE2Z0pV5I?=
 =?us-ascii?Q?fV+seaBw8OnEzLQWEo4Pae1UI5yzzqv3z6WnlgLpm5x6WBuQNpwLqHdPoPLt?=
 =?us-ascii?Q?OUjcoIwANkk3w4w+77OqmwHnxCjgn0E3R1Zj31wwmsNLpcggXdYdkLlFfzAh?=
 =?us-ascii?Q?FPJPRdlp2Zvr/DNE8/LGihqkRPsCM7NjBiFdxx+nBzocVwTcEpNSsxnMXVY5?=
 =?us-ascii?Q?bCCc+tHvvxAYv9cHF8I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:09:28.9964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e2055d-b098-4249-e1b4-08de4f6f8ee1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443

Changes since v1:
- Used ifindex in psp_responder to select the PSP device
- Merged the two patches since they started overlapping too much.

Cosmin Ratiu (1):
  selftests: drv-net: psp: Better control the used PSP dev

 .../selftests/drivers/net/lib/py/env.py       |  1 +
 tools/testing/selftests/drivers/net/psp.py    |  4 +-
 .../selftests/drivers/net/psp_responder.c     | 50 +++++++++----------
 3 files changed, 26 insertions(+), 29 deletions(-)

-- 
2.45.0


