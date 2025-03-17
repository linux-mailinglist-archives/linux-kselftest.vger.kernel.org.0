Return-Path: <linux-kselftest+bounces-29217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E260A64EE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64643170AFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A3C238D25;
	Mon, 17 Mar 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZWBcU47C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB8EBE;
	Mon, 17 Mar 2025 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214735; cv=fail; b=rgYVDP8NIKyaZiKd9XB3s0S5H4wQZqmVlvl1eKIXFFAtWU5mxelkP3M3q9mcYlq3v8kI+TkBF0eLUPwJRFp2AOVjoLHyKxqgMnDNhmDxz/Xh52Awhrt8tcVa6S55hF+Ltq2Ls0gyfFVnUJwkNc7YfRdTfQjUedJlKDoyz9iPh5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214735; c=relaxed/simple;
	bh=JcylJ6pPCI+1mHDIpKBQeMbL91lODukuFPg7WYBbt78=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cwyH3SJGuFBzP7V1apmvxkMkOmMuSJ3SVgyedlfBKrJyvGkNzit5YHbPjnR0z9tiW/MogvgiuSYrTAcCan/8j/JWWO4CKuC7Pxbw1WzS/8TdQhZqs2Ulsz2vqU5X3RJuyZd3I7/btAIoqx8gr5GLI5JueZpTvg//PLODAXdL3RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZWBcU47C; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hptkzYFEj8vJS20WR2zWhWJOH955/yrpVsd5Tlzucmf5i2fa93Isk7ayrmJ2xCWnAZz6zdY7AKTJed9s/tLPuTE34ItvpsmdTpkEjbW6o42yAx5N6QgHW3OYOnnJPkeiptNSkLqGMjKcWZoWC/tPzTWfgpMGgjCCJBbXu+35NVdx6FogXaXthlfVB3XHgkmySrpbTVgvIRNO23ZSTMEkdVIPKSKMautPzayJY5ISnFntLifa0io1uTNBfG6v/bz4kxg7WM1Icpw8rBUGCnTqCKz2HwZ1LSN8UHcO2HAUFjBqXxWi6317KjE7dE7fWwPKgkPYFKUGhwPYajKFBOo5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4p681lO7ReacbdjNLTMRMbFYYEcK7ZHFAijmPGdTEI=;
 b=eaAOvzhZD0mgX8DivxvYg37/hraLwvtFz+sqVIZOjaWr9Yh9D+UP2klRSKeG8DRtQUfFJAtgSIGDri4bAROkLZ8tY9nbt35HoCFkwN5hHn1esmReunFE8xzY30zs4orDoGVl9M6QqiHrGpOr28FUQuzFepJy70cethZ/6nrQXehqEsfjJ5PV2kKm/m1cnJsFkQTQbNghF6Tw5QmZ6ZvGsMArXlGJ+jLGpAegtNi8eUZ7uLR4fBa2bzRkEBMwDGLj4Foj6APYZJ24r2NOnPOmAjE3fqtoIcFMbSippIV9X8J2ubt9YwnuSzQqQEwYk1tdoxo0j5HeaKwokfEqhDCEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4p681lO7ReacbdjNLTMRMbFYYEcK7ZHFAijmPGdTEI=;
 b=ZWBcU47CmdW5dIqY7QmQaaSG4ftI+bzDuiPJQBYIorhpygV59fA7qLAR3mASzWywG7bbcddfIJTpkdXCEDLwX3xseeMBLTtov63YoiZiU2WvuyRXy2xomNQh9ooquHtoNB+bibZQ/JL8tUU/S7O6cyHpsnjyRBYh86DwvXPaMbNNISJXQXHNQ9siwMjzm15h0jfyYxi25LJGvyPlbAPk/z6EesXhBaowBw66RiB99T5jkIQPmUluFFu3yLiTVB85n6XuOATXCTrqkYjHyRSqfks1wAz6Ci/rg957OhD84vZFIRQMcyb/3xtS54fZYacR4LzQaPggcKiguMjrfbytqA==
Received: from PH8PR07CA0036.namprd07.prod.outlook.com (2603:10b6:510:2cf::9)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:32:09 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::14) by PH8PR07CA0036.outlook.office365.com
 (2603:10b6:510:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Mon,
 17 Mar 2025 12:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 12:32:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 05:31:58 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 05:31:58 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 17 Mar 2025 05:31:56 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net-next] selftests: drv-net: rss_input_xfrm: Check test prerequisites before running
Date: Mon, 17 Mar 2025 14:31:49 +0200
Message-ID: <20250317123149.364565-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f334b6f-a746-4e37-7578-08dd654fbc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lSB6MO47BtOsDGVLR3eG44MvRIVwAQKTvPue+On8X92M1SkrjALOQ3qzz4o6?=
 =?us-ascii?Q?e9bui1U64Aa3mFePMi+z66Y+CFQ6CLY2Rm66CM8QLXWH2CEVXVyBrk3l1vhW?=
 =?us-ascii?Q?2xkQFAl6R6a3Dzl/WNKZTdI25PsBxguq7SvHFklVa2eXry8ai92wfXbUZ33t?=
 =?us-ascii?Q?SykIPXmSRiTNS5Yjz13blx9UVO2IPmJxbhOZRYaGp8VTtAhUwlgrGFhE9Pp9?=
 =?us-ascii?Q?6i9TcTxh+yrZrz2Wls1Xtv7FhurQi6p3Eoq7DP+EyMSmhbfcJwLRYJwAhgi8?=
 =?us-ascii?Q?NX74sGXmWX8waNfGBpQIU2ZjL61M9ga/tfJs7J+Hyn0UJeetBzdIBFS4f5Th?=
 =?us-ascii?Q?5JiC9r/GIQhyCs18SOruS7ztrZ56S/+KXLKycUCB/48xMU9uOzcOXGGyL8/E?=
 =?us-ascii?Q?FTL5Iv/MfdFDdbA6ZZu3OXZfeEjd05GZ0vZgCuxr4h3EUUyiAqqkA6nfmQSP?=
 =?us-ascii?Q?OPGUX9VqUFvA3FAgaySliwDldNqgLcXKctLUwvhyrFG+STnRDhEog1Oxr+Dq?=
 =?us-ascii?Q?lqJMSEx4g5Y8wuJLvCbBrTT9MAM+SwIGPORaHVebW7truZOEA4+EmfmyOdqy?=
 =?us-ascii?Q?ZOWReS4PoVoyetU+0t4ltZWGZK/xQAUPEUgXvkE82XTRuadtmZt+tAuwpZLT?=
 =?us-ascii?Q?qK5kNl9lLTS52x/4kJ5bSoh9xkicwmAAzxVBc/p4lW8XH/wG/2dIupRdKtjc?=
 =?us-ascii?Q?xEwkjbwqaIQKBrdh4dKlZoECqyZ/n6Dog6Vl6OKwg7ZiEPGxQXFtAjPGsCEd?=
 =?us-ascii?Q?gLmDUQT8fqwAk4F0EHhfUJuSeUH7Z9G3Z2mBUo282sEIouwALNMKlBkpjCxG?=
 =?us-ascii?Q?uVM3gngR95vT3L3Th/M15jCOTEvu/cju7becZe+2oXxt1QeVVsVXm6q8GSNa?=
 =?us-ascii?Q?ZbPbH4YswzcgwdLcJGGbR8jAlBQasMB5PZLagf1UARSsOhvp9cmTVL/xf2Je?=
 =?us-ascii?Q?Q8Oth4pK6CRXQEi7rU28wo8JCRWY8XfLU1cpF+Q8OypnV7Y70VDWWDOcgL8M?=
 =?us-ascii?Q?eILxFJiPHqJP8h9CNo1aaAvcA93VJMyvpGDnzkQihaHjWR1eUTotoow6GczB?=
 =?us-ascii?Q?qQX1I5HuPtthqUVOGTSd02puvxRMh+jCSGhQZwCiEFTJgKwycVrij7MdFCJP?=
 =?us-ascii?Q?QzJcF4ftMpE8vKgpRQQd9nX8Tibt2TI+Ju3M/rTsL4OlYvW9e8X6BiEPD7UP?=
 =?us-ascii?Q?uY+nYJYZJFxIKrJYGpV5EVubkNn39U2YTFkVtXBEhrfMgvlTpb+YBs0Szu1H?=
 =?us-ascii?Q?Q4GXAO6Bu87Zqu+LnOmNm/iXI/5ud6H/AQAQvfu+ErRymkryKYWO7AaRcQEt?=
 =?us-ascii?Q?7tfsP0OcfGN3XxcOoMnXtxcZ7XYu6yY20Frxburfwhj8MNNUt3f8SnZDiPBR?=
 =?us-ascii?Q?BEFxYoCko4RR2vc1F1QLdhh7z/EUOTZIfenp598LdI753SjkDwdk7kOUGkMJ?=
 =?us-ascii?Q?NGV5JEsjSAUXqcdhQIui5du3D3Be2Psj72aLEs7YQqgsu6FdvbG3GhVd1I5R?=
 =?us-ascii?Q?8cdF6RFrJC6iRl4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:32:08.6040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f334b6f-a746-4e37-7578-08dd654fbc00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034

Ensure the following prerequisites before executing the test:
1. 'socat' is installed on the remote host.
2. Python version supports socket.SO_INCOMING_CPU (available since v3.11).

Skip the test if either prerequisite is not met.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../testing/selftests/drivers/net/hw/rss_input_xfrm.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
index 53bb08cc29ec..58d74ba6c343 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
@@ -7,7 +7,7 @@ from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, cmd, fd_read_timeout
 from lib.py import NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily
 from lib.py import KsftSkipEx, KsftFailEx
-from lib.py import rand_port
+from lib.py import rand_port, CmdExitFailure
 
 
 def traffic(cfg, local_port, remote_port, ipver):
@@ -32,6 +32,14 @@ def test_rss_input_xfrm(cfg, ipver):
     if multiprocessing.cpu_count() < 2:
         raise KsftSkipEx("Need at least two CPUs to test symmetric RSS hash")
 
+    try:
+        cmd("hash socat", host=cfg.remote)
+    except CmdExitFailure:
+        raise KsftSkipEx("socat not installed on remote")
+
+    if not hasattr(socket, "SO_INCOMING_CPU"):
+        raise KsftSkipEx("socket.SO_INCOMING_CPU was added in Python 3.11")
+
     input_xfrm = cfg.ethnl.rss_get(
         {'header': {'dev-name': cfg.ifname}}).get('input_xfrm')
 
-- 
2.40.1


