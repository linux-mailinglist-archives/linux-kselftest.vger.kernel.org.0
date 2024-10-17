Return-Path: <linux-kselftest+bounces-19940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A659A1ED2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303DB281957
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887AE1D9595;
	Thu, 17 Oct 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WCcNJDDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052A1D47A3;
	Thu, 17 Oct 2024 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158454; cv=fail; b=KYbKDbYjLe5Jut8/wtpo86SG6JPXjlpXZBBgfKA2GhsiTnaBlR/07TMMbwAJ7MsybLpeWMqShxcZvTwERtlSQ7lKoQCwwNvSF+CB3WEGBUh8eA9wxNb2cFvzFxUn/ylDlrWruVjl9j19f304nA9xWIsAFjslmSyDYjYd4GEfyak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158454; c=relaxed/simple;
	bh=ode908XCLSDd5G+QWaV3cUIGg0Wd4AxpyTA4eXEeS7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqlX7xYRZSb2I3LBmicMLsu/mtD5Ifl1olXltgsqktL0zIdImCSDUvQ0ij0y7kZKPA5+UWDzaCYU9LyFZquZGKqX90J8OBeQ4EVHTKNpWfm0lJxdYwYvWNXLqdFhc8SQAm5NoP6oWIraR6sHOQl17nHc45jBrtZVrKRL9xgxs28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WCcNJDDI; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3tgDSd0cy8EPV3vN+rlHxEY/TCzrMwASg8QdtN5apRya+j63F/Ho/0IAEB9RlZ5CwijOdGrZDuLl2Q0CEG006/pGry286aKlo9F3p+iLtpQC4/akxTDHU0TA1lkI/wrFlnF3u3RU87xsu7mZIj032aFwy5miuTIJHdnSN+RxMsddjM12Fw1oDQs/9/OUg9HFB5OnyiH3TrCb/lryPCjOksw5t3p1MHImuUv4OGsxsNF5jyoQXdNUkf2yGJc9IPw+MmGEa3nEG55w2gaYz8LU2TB9Rnu+FvqEDNBYNeJFPzUd9UtNTHcYgISZD2c2Hr53yvldHwsw8CDoQMS6UCc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb+B/zKUwixV0+EP3ly1AHKv3dETzlNyG43ysfafncY=;
 b=NO7oxLmn6xgqXqmGNoC+ZoR4NQpVu7tmSwdouWRfroGLbromc905/8tgQH5q8s+JE7qU23MoLr42VUL3/dTG9A8slp92oOV9D9nSW6qJb0IN3s7owWsAwDF7paCc3Kf0LHkdUGOIMumwq8yg5IYkZMsBM5ivrWGUs3uRSRW2z2rAV8NZhdFMCXzujHYKfaNAFXhyk+S93XduNn2Z4aqBY03BkCcBVOsQhmY6mx+lA60EgmCcd07etwI1F8q0QjW5Fv7svUn1oTeSlatKtQiOO3ArWeR7REjUKaB5Gr17Ivcj+w6JA/bbge688w99wuRu/o1HYCV7+p1Nt9NnY53cgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb+B/zKUwixV0+EP3ly1AHKv3dETzlNyG43ysfafncY=;
 b=WCcNJDDIVn3dRtzjfVa86URLXHymd7w4vHpiGNmssKPl2katSdTSA37leuee/lcCwK1Th9vTAq9wUI9tlDgwnDpp6e5H8LcjdB1K2maMPJJwWDLQsl+RWvb1BoYL2kXjHrr2UDI4RuLv333kcb0xvAUoXt161yhfCNQIBdC7padU1Fgyc1Na47r4DDWqsNO9y9eAgk4LsTwd/iGqwHjOK8XWdgSJqREnjq4yTM519I9Ph9Hs1NZfAPAroNFRB9KLczbqlvOJlRH6/BeFLusvD1qIm13nyS2d4oTcbRXXhDPAHsSY7z8g+y5yVRAxc0VV0/1jxOk92S8JhybmHDz5nQ==
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 09:47:25 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::4) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 09:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:47:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:11 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:05 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, Willem de Bruijn <willemb@google.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 03/10] selftests: forwarding: lib: Allow passing PID to stop_traffic()
Date: Thu, 17 Oct 2024 11:45:45 +0200
Message-ID: <7e4857d8fa061dc47e3c7684f284b848549c660f.1729157566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729157566.git.petrm@nvidia.com>
References: <cover.1729157566.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7c9a3e-ee5b-43a7-240f-08dcee90b426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4OJdC7lftpQ9YxAaA/r/i1njM7u0hQASHZg4lLbbzDM+4m9JV23buH7PrY9x?=
 =?us-ascii?Q?BevPdesZc0wab4fjdOY3LRgfxQt0MdsyvEcPHfnNMpuu7XvroN0usMPjF22i?=
 =?us-ascii?Q?ZQxYmN1b1Il/TPbqZqinbzt3sOh4LErGvykSYOI8e4MntbmDcy+wCFZZeZpu?=
 =?us-ascii?Q?Ehl7oVPXU5/AJvfkY69nGwqvaAuINM74ykNBC7FTd94OaxCPDALwAZcl3c24?=
 =?us-ascii?Q?DkFbrpB6y0ghJCqOnqprkxYeR+xXaJfLdrLtWUGfL8uiq40VmZ8mptdiaela?=
 =?us-ascii?Q?umqGq5t0ixcFQiO12aT5CGprHj7y9JE63HnXnG/uBhEDmYeY5ry/RupFlHoy?=
 =?us-ascii?Q?TaOa36L/KqC7t8AIVy3pVlS6OF9rG9YdPmvMH8DDayoqobmbZ7v74E5smxjH?=
 =?us-ascii?Q?j49C4t9DeT2uRjaL/5wA1cGLg6bl+S/6YUVHYOr6x48uh1kAnVZ7Tv31Ve/z?=
 =?us-ascii?Q?F/dc/dQB0ZIY8aXkhcxa71c02P1HYqhBKwCzX8nq8TZ4j6Z9tdZYtnJNmgbY?=
 =?us-ascii?Q?tF2c5mQ7sBfmXIeqVN0kgiinHLichC2NfJLCjzcwuCRKmy11+IbhDp0U47ka?=
 =?us-ascii?Q?EtL+dx/C1sl6K6vIHYEn3rUJT83dBsM0x0lDQEsP3sNZUfPJ0xf/W/0bAfD5?=
 =?us-ascii?Q?L0ipa7PvCD+WZ6EfXsdtteILhvHbXNXjrv73BFrZi165tEMXU46iBUjnL7xf?=
 =?us-ascii?Q?aQOkCzS4tdNCf8d6CtPSKfDFlxapp3AYbHvywDIAj6henmxgg7fYkTynN5m4?=
 =?us-ascii?Q?ql3zZAYjnnZ9YH7VyT7CObGdat9htygNN6Wq4ko1QvMKyLNOCuZosp4x0ZmW?=
 =?us-ascii?Q?biz0K4LACo0a5DzIb+RyrCbi4vZ/IIBNnxTwN+3Oos5WHTzepWlJrCgbuFan?=
 =?us-ascii?Q?FvZ0dE5HNfElH3AyvU3b9Ki+wt6x6RLusId9fzaXpE/42+CsSOsJQ9qbtEpZ?=
 =?us-ascii?Q?/md5PEnO2RKqxEM6zSZ8Pcnvd325zjjWGQKqqH4RR1BRRanaY51P9YntMooa?=
 =?us-ascii?Q?scEtpnnvx0dk2zUfBAe/XYGCdOsNgGcPNBSjAPmdumjz3Dp862F8wfvvlst5?=
 =?us-ascii?Q?ZrN89OisvaUU4PHIYb7DX5cO3u6YzidnaXTpc7qAUPRTAQrJFZyle0sV/6P/?=
 =?us-ascii?Q?SBlXm7dw/PK/gr7sE3cVNBnUZMLmwSyJW75cMw6klufN6k0lvMOj1amnVvLe?=
 =?us-ascii?Q?oCWkxoADixRMbB2w7XCZchZhSUtuCqQvnYQ9LEJ/alctOnWU8prmx0kAElSU?=
 =?us-ascii?Q?w2e2DFks61VrlXxL0CNH6X5yyintET0yWC2WugFsp7e0UOeGn+cy9mXVP62J?=
 =?us-ascii?Q?EmLLcsyWdLJ1gjfD0qHjSok1KqHN20J8UUJ/xmxpKf0QNTlpyC8oT4RcCqNF?=
 =?us-ascii?Q?o9yfwkD4geqXntrHeLZ0E/xF2MythMrcTw3obo/i9q9MTMJPew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:24.3461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7c9a3e-ee5b-43a7-240f-08dcee90b426
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796

Now that it is possible to schedule a deferral of stop_traffic() right
after the traffic is started, we do not have to rely on the %% magic to
kill the background process that was started last. Instead we can just give
the PID explicitly. This makes it possible to start other background
processes after the traffic is started without confusing the cleanup.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 76e6d7698caf..89c25f72b10c 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1768,8 +1768,10 @@ start_tcp_traffic()
 
 stop_traffic()
 {
+	local pid=${1-%%}; shift
+
 	# Suppress noise from killing mausezahn.
-	{ kill %% && wait %%; } 2>/dev/null
+	{ kill $pid && wait $pid; } 2>/dev/null
 }
 
 declare -A cappid
-- 
2.45.0


