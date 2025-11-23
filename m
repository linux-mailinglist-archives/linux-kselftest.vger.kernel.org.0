Return-Path: <linux-kselftest+bounces-46351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510DCC7E4D8
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 18:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22593A4155
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55F72D9792;
	Sun, 23 Nov 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qXKxkC2g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155552D23BC;
	Sun, 23 Nov 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917922; cv=fail; b=N/U8SzUotyOSJCfctStKFncEKHb06uzLtLmNCkucDQgqnsiW/w0cMQB5qsFRLS16UQ1qGckxJEXemQ65uyCoDRdH006nA/RW4XEKyED5erjZ3g4Q8jtyoHFg+BsYD+Oeq5JURGLEAwDisU2+e/Pw7wzHqGpbWuEx6qq+N+59R/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917922; c=relaxed/simple;
	bh=NKY2T0ld2DLpsOGzCvoquMtcH8QjzB09tc9xIQgohBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX3mzCi0NzZp3eRStftK+kY2k+MAQdD59sFNEf+F01zqDSgzdA16QtYdW0VPnJNOLZdwyfY9i2D6qhGdZ+0xxhxXT/e1ax8tsc801pNBe6wboAAgnTmNz2S4wLSl1yybN5qpOOu1LovpeXPJLld96wXqiGgcXDqJ+alT2YYxTvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qXKxkC2g; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpeddPW7x+qmydKaqwD9xpZ62u7N4I3Ezgx6mQ2svgo2Yt7gSICCqwzBQ2BFWB73O8nCcpfxuerW56LSRR7qspJtlMNxbBv3bTfGJheJ9Qp4bIkLqq2JrQuAxHEyW4rjDoEHBYkvk/7xBut8To4ojXHtr/MlQVE1AZXP+ydafQwtSYcCCMFRaIKfyFDAAxWaFzzcR/ZyZe/bp8UG2RBW9zwAImNht30YmEUkeseIy3w4/dYtHNzmKIOVte9IPUCbWpi++qFZqGZRTH4QSvOqkij0swPqcS3V1pJwEdhuDHeU1XpF7dMMX+ifuRGY7DAiK1xRqPm5egYS00JcM9yObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4rj5cT6P3KGZ511aluDVpByX8lyv3BrbNOeTQFXQ2E=;
 b=D6I67aHNkP28Dhl5Uwviet0XXvlDWGqFX+gix0yoTylrpfQLZOVhpdR4Pk6NTZZPkI18lOiG82QFqMHl82GMZEnszOSAMALKcEoQmMiBIycqN61HgEAHsRhiini8W77+zei0gU3I065AGOI49jJ9eyxcFXZf/ZBuOuHcSDtac+ip8oyMsrI88hYtcyeL++FImNdTg3DQ1ruA5G2aNwNpbFMayjwaPiVQkvZ0zCG2KsoOM6v4fg4aWMZ9nQdVbDJNO9y/Nliwc5XbN8VHwgqnkbE83zf0HNq3wCeJWHjnhn5QjGjAEu2bh78KaZK/C8A7/bN8QFVNjYPlwarLcnUedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4rj5cT6P3KGZ511aluDVpByX8lyv3BrbNOeTQFXQ2E=;
 b=qXKxkC2gWcRytHEAY/2HiHa5c4lpdlXgjDyoISEJMsxVKWYKvV4bbOwLi1WgSsWrJFkP7lsD3Oe33t1l/8/oiyL8po6+HQC9p2uuTwYKdzSHXfpW0f9Mpx2PygY/o262pTHXTOO4NISsinOUBB1wWDqjikgG1MjTRVFO9QS52PCbMUhmpQCbTmb7U5LzR0NtKfFx70nu5xC1XoSCXl/fgbizBn7pXZLKkeLvK+VmR1zdilYngiTzFpecLeh/n7zpz+YvM5IVWcuBIg/RgrGcaSz+qHRUA6RkxLXg3uzYbZHjUBFFrlepgQz4J69kwcIB/vnMERFmqXWCYf5QBqDlLQ==
Received: from SJ0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:2c0::23)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Sun, 23 Nov
 2025 17:11:55 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::b3) by SJ0PR13CA0018.outlook.office365.com
 (2603:10b6:a03:2c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7 via Frontend Transport; Sun,
 23 Nov 2025 17:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 17:11:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:44 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:44 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 09:11:40 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V2 2/6] selftests: drv-net: introduce Iperf3Runner for measurement use cases
Date: Sun, 23 Nov 2025 19:10:11 +0200
Message-ID: <20251123171015.3188514-3-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251123171015.3188514-1-cjubran@nvidia.com>
References: <20251123171015.3188514-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: c66f44c1-fe3d-493f-ec56-08de2ab36736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sdPtQf1o0/5RSD+isdH+DoNy5YlSzglm3mhiYMWS+PyXFEF9gYmt8mjui392?=
 =?us-ascii?Q?Zt8cqAi4j2JhOxy5mFQY8R0NQql/LCD0wE/IkmcLys/5w1rESOh8IewhLwvQ?=
 =?us-ascii?Q?xi0kscfpvLETpEJdaeOeTv6g6VPHj61Elx+zjwJMraN/pvdsjFPSm6toAVwr?=
 =?us-ascii?Q?OWN11JewORfTSmkmgIdPodbHVxqM/+jzNv7q/jHsGYb2SRl90xvPXpwYCcHd?=
 =?us-ascii?Q?gzFTLjsOxGam9BqDpZ8EEQC6xMQAMNg8x93mzhKixOkqrMYe8cGs6Z6hUIdf?=
 =?us-ascii?Q?i7iQU/uphAAO+fnDrAUpQjnqAIQbWFGtyy9DPu2hdFNms+MCcHd83M4s3B1O?=
 =?us-ascii?Q?F6WsbHKSMPuc+o0Ft5AlE3KeOaBYScngIKoSzV4nHtwfBolIexmTCCZzV3un?=
 =?us-ascii?Q?rgQZ24I33cjb1ZEGvn4+NMkdVIDzrwuOfp083Z4AAs112/0CqHfpddWGiYTl?=
 =?us-ascii?Q?hDUNnTVCz921G1/2BMRAzFY8y4ONoO2xeTS00c1KEiyVlbaBP1kNgwawgrdC?=
 =?us-ascii?Q?nHFCnKU0KcPL63JZqbpUmd36pjyNh1XGOg6JedXXI/V5EXrSab71R7sUwbn0?=
 =?us-ascii?Q?EDi3o3fdy6iPI05ltCQ3EwZobrkClGJeKDkMnWjrRYamBHlqIWLU9a2GjnGD?=
 =?us-ascii?Q?EoAIWY5ev5zwT14JIEMSQgvkP7vHJW1TXY7U9+4eUAg0DcHQ5npQSOqGi38B?=
 =?us-ascii?Q?B3nYSpgoX/YktTu1ACcXnSUIlewRq7SzafZkZ9qjgmKpUTa+WbjRhKGAhNGZ?=
 =?us-ascii?Q?/89v2ASFg9nAMe3ykdHZ+x8AUMYtpgjT0Pfkydjuo4NlV9bpcRyPs0lOJRSM?=
 =?us-ascii?Q?2qcVtVqxiX/gij3eMcP5SNdaVF75ukXCSlQEiR5rP2wrfQMHYj41vlQkSQHo?=
 =?us-ascii?Q?Uolc71oYqYikK0JartkFTwVaMjqOpf0cZez9GMud/G5V1J/iWRIKnCGyYelf?=
 =?us-ascii?Q?7Ep8R1ZqyXB4hslNa3NJNlk/t1CF1V4ul/eNUDIbnTSgdAJ71TSHWEp9ZxMo?=
 =?us-ascii?Q?nfYNmI5Bvt3wgcDkXK7/zQuum3AFG9vGsF2EuVUGyqXyQAdMYyaxkUgVrcq9?=
 =?us-ascii?Q?67yKe78lpukt9w9gwfhHeCeXVZuvEPgemFnPhmEUXQ1hRxvqvwX7cYvOx633?=
 =?us-ascii?Q?b+Jiz1jjc7mzzJhGjDDWfRvqZ5r7uSZdCshhQFhtoIljsKdE9w/tyO/uPva6?=
 =?us-ascii?Q?nN/ZC9rSVcFBs+g/gBQbi0laBpSC9smDzdPaLr04R+zK4n6xsuXc/IH8qTlh?=
 =?us-ascii?Q?3Dhid9YnsDbO9bBXSOJQ7qK+ZdInR/+bBDSccTomhWH2eIV9Z0q/eTztQejB?=
 =?us-ascii?Q?YHRYN7L718I50cLQHmYaN79GKma2w8bf93ztJOMfBQKyk1Ol8u4MdqBr8ub4?=
 =?us-ascii?Q?bO8hLyq6URXoc6cF4FDEk1v3AfbFTFc9z5CwjDOtSO6gbaEmTK7aOz3X9LzL?=
 =?us-ascii?Q?g/j8GxePWvbtODsMzKFUbtZ6gxOSl3/7H1kPm1Hhf+cEU7pcJw3nFzVxiA81?=
 =?us-ascii?Q?bbaRYQaseL733SsitCkx+TivnuG0h4ps/CePIcRTodyQywA8DFWssFH8F8vn?=
 =?us-ascii?Q?/dKpMRyTLEWHafSbKfk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 17:11:55.1687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66f44c1-fe3d-493f-ec56-08de2ab36736
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293

GenerateTraffic was added to spin up long-running iperf3 load, mainly
to drive high PPS background traffic. It was never meant to provide
stable throughput numbers, and trying to repurpose it for measurement
does not make sense.

Introduce Iperf3Runner to allow tests to split out server/client
configuration, control start/stop, and collect JSON output for
analysis. This makes it possible to measure bandwidth directly when
validating egress shaping.

GenerateTraffic stays as the background load generator, reusing the
common iperf3 helpers under the hood.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |  5 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  5 +-
 .../selftests/drivers/net/lib/py/load.py      | 84 +++++++++++++++++--
 3 files changed, 82 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index fb010a48a5a1..7563a49fca65 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -28,7 +28,7 @@ try:
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
-    from drivers.net.lib.py import GenerateTraffic, Remote
+    from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
@@ -44,7 +44,8 @@ try:
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
-               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote"]
+               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
+               "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index b0c6300150fb..65de853e8ac6 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -44,10 +44,11 @@ try:
                "ksft_not_none", "ksft_not_none"]
 
     from .env import NetDrvEnv, NetDrvEpEnv
-    from .load import GenerateTraffic
+    from .load import GenerateTraffic, Iperf3Runner
     from .remote import Remote
 
-    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote"]
+    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
+                "Iperf3Runner"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index c4e808407cc4..cef661ded8ab 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -2,21 +2,89 @@
 
 import re
 import time
+import json
 
 from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
 
-class GenerateTraffic:
-    def __init__(self, env, port=None):
-        env.require_cmd("iperf3", local=True, remote=True)
 
+class Iperf3Runner:
+    """
+    Sets up and runs iperf3 traffic.
+    """
+    def __init__(self, env, port=None, server_ip=None, client_ip=None):
+        env.require_cmd("iperf3", local=True, remote=True)
         self.env = env
-
         self.port = rand_port() if port is None else port
-        self._iperf_server = cmd(f"iperf3 -s -1 -p {self.port}", background=True)
+        self.server_ip = server_ip
+        self.client_ip = client_ip
+
+    def _build_server(self):
+        cmdline = f"iperf3 -s -1 -p {self.port}"
+        if self.server_ip:
+            cmdline += f" -B {self.server_ip}"
+        return cmdline
+
+    def _build_client(self, streams, duration, reverse):
+        host = self.env.addr if self.server_ip is None else self.server_ip
+        cmdline = f"iperf3 -c {host} -p {self.port} -P {streams} -t {duration} -J"
+        if self.client_ip:
+            cmdline += f" -B {self.client_ip}"
+        if reverse:
+            cmdline += " --reverse"
+        return cmdline
+
+    def start_server(self):
+        """
+        Starts an iperf3 server with optional bind IP.
+        """
+        cmdline = self._build_server()
+        proc = cmd(cmdline, background=True)
         wait_port_listen(self.port)
         time.sleep(0.1)
-        self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {self.port} -t 86400",
-                                 background=True, host=env.remote)
+        return proc
+
+    def start_client(self, background=False, streams=1, duration=10, reverse=False):
+        """
+        Starts the iperf3 client with the configured options.
+        """
+        cmdline = self._build_client(streams, duration, reverse)
+        return cmd(cmdline, background=background, host=self.env.remote)
+
+    def measure_bandwidth(self, reverse=False):
+        """
+        Runs an iperf3 measurement and returns the average bandwidth (Gbps).
+        Discards the first and last few reporting intervals and uses only the
+        middle part of the run where throughput is typically stable.
+        """
+        self.start_server()
+        result = self.start_client(duration=10, reverse=reverse)
+
+        if result.ret != 0:
+            raise Exception("iperf3 failed to run successfully")
+        try:
+            out = json.loads(result.stdout)
+        except json.JSONDecodeError as exc:
+            raise Exception("Failed to parse iperf3 JSON output") from exc
+
+        intervals = out.get("intervals", [])
+        samples = [i["sum"]["bits_per_second"] / 1e9 for i in intervals]
+        if len(samples) < 10:
+            raise Exception(f"iperf3 returned too few intervals: {len(samples)}")
+        # Discard potentially unstable first and last 3 seconds.
+        stable = samples[3:-3]
+
+        avg = sum(stable) / len(stable)
+
+        return avg
+
+
+class GenerateTraffic:
+    def __init__(self, env, port=None):
+        self.env = env
+        self.runner = Iperf3Runner(env, port)
+
+        self._iperf_server = self.runner.start_server()
+        self._iperf_client = self.runner.start_client(background=True, streams=16, duration=86400)
 
         # Wait for traffic to ramp up
         if not self._wait_pkts(pps=1000):
@@ -61,7 +129,7 @@ class GenerateTraffic:
     def _wait_client_stopped(self, sleep=0.005, timeout=5):
         end = time.monotonic() + timeout
 
-        live_port_pattern = re.compile(fr":{self.port:04X} 0[^6] ")
+        live_port_pattern = re.compile(fr":{self.runner.port:04X} 0[^6] ")
 
         while time.monotonic() < end:
             data = cmd("cat /proc/net/tcp*", host=self.env.remote).stdout
-- 
2.38.1


