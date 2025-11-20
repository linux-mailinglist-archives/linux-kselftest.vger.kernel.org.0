Return-Path: <linux-kselftest+bounces-46087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3132C735E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44062358B2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E3313266;
	Thu, 20 Nov 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xu3CqS9g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886BC308F36;
	Thu, 20 Nov 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632857; cv=fail; b=Z3dqoiedCvvWwGn3jLy489pRgjsnj7lRE/jdcWbNjMj5ke04LbZk+OxDCPbnBJnyQNQVohTiUGLMJcGcZ4mFT9QFcNdDHme3VEJcRqluggvF7NCvatRwgK/Sgwbf76bEWSO0/yUHV0usT35uGOCaYLvggv7xDSJtZrBGc87V/Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632857; c=relaxed/simple;
	bh=NKY2T0ld2DLpsOGzCvoquMtcH8QjzB09tc9xIQgohBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFCBMfOeA1HCNkmD3IfX8Q/zaQre9AaBXsI0vud9peZrI+Npxe7s4NGTEoifc7bY65PjcUFJOPWBA4asuLLsIfbUkxOndDL8dyf5i1Kj2jVdTsnju4UCoZAmkClwGEmow9eC0DophLVdish5Fhc/2RmkTt4T9/287B0NVpU72tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xu3CqS9g; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzQL4Wy2EVsMRyv5KAS97S/i1QdbHo9iF5tVi0OX+UQs8OkV0R5SAZoMcbt5S8YdKEXR+12wLSUgEk/hH+0LnYifKmZJNuKoDcB5W4sbJ86saxR8KeHwoKVW4+nxJzlI0/emtdMNWMIvU7tQdq9wE+WtQpAq9dwDKjlOO9vBYCmGIhmKVJ/exvwNEHoUqMVWBmzBhY7BiGPiCUKJOWbFWtbEWbkI0Uk0Qs52C3TzsJaqbaGajL0ehsmOeDaOsn+JBGUzhCXmZOTjDtl/Z54+0EjCeDRHDe1CAbL5aeXV3fbG6NxJ0UfqKT+xtyWXmF19l+KfVWHLAf/OMzqTkMOA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4rj5cT6P3KGZ511aluDVpByX8lyv3BrbNOeTQFXQ2E=;
 b=eBfz35Xu7zGxXsKdkheHnekg/gXujrjn4mB8GuyWr/a80/6ApbSFv3kgBCRYbvpqq31DDvJ5yu/GI/TMzmRQ8MoWCvWPy8Oz5Q7F9sn3yG5xFP1mcfiD2A+qtqtVKJYPyHG3zes2HmB2CrUed9VUuMiSowDE9LXSqUi+SnEUrKntLxu2F2P3IEdQQWlpbqD9nPZaZRXhcwHYDHbdwcMsxrWOhowO0SmrHosS8HKBoSgo1F2oTDfoILVcBtcvOuN1gS6fDrRBr4Q5GsHIphts4oUpEMbwCs0E6KPAI7cC272lCi91xi28Il7JgwK4+PYYAsM+8mIUirWnSdY+cKBN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4rj5cT6P3KGZ511aluDVpByX8lyv3BrbNOeTQFXQ2E=;
 b=Xu3CqS9gId63vAAZhsab6M5cY6GMp+udoWi1Rn0owQk+DbsYLDKvidbD0lSKxHTiut40nKD85W7sD2Hc6l/igvpjz7TSaRUFFOnMoWVAMtiNhU7dxG8PsSqwJNL8QrXDSvhYU1sVHddVsZe/Y6h6R5GAzXZsU/cDxqA+5q7f9uJhDCvy8ir+cnpylcePDdHFT3QbzDMvFxM+39z7Rn/DUfaXQTY6psKj70MndUlL+lvCCkRo+3ASxytHkFp+6C0ZokVDjiLKfzddB1cWegnqSiZ9uN0Bw99p5Jn+i1UZYePHC70E6OXuCaiDSrtSf40+Dj5x/2AMzIW1gGw+CrNKJA==
Received: from SJ0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:a03:3a0::27)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bda) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 10:00:50 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::4) by SJ0PR03CA0262.outlook.office365.com
 (2603:10b6:a03:3a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 10:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 10:00:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:26 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:25 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 02:00:21 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 2/6] selftests: drv-net: introduce Iperf3Runner for measurement use cases
Date: Thu, 20 Nov 2025 11:58:55 +0200
Message-ID: <20251120095859.2951339-3-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251120095859.2951339-1-cjubran@nvidia.com>
References: <20251120095859.2951339-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: f576a506-45e9-4cbe-fb7e-08de281baf11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BAlHQ98JZjmV0rF5AqqKVXYqWAYvL2D5x06RfSQrTp5MzHeDRZeF3LGZlVh+?=
 =?us-ascii?Q?meIYC2m3cWMWZ4ReqWmSWocgM47xVcsohxSiyIK0OJ+9VmChn4QG+AwhMVmw?=
 =?us-ascii?Q?EVUT47wezqSOylHBeFTZEMKhrQcdbfg95Eg2wCM8Z6A5nY7qwOhHNBn93TQc?=
 =?us-ascii?Q?xlLhvd0TPbC4LTHyj0MYQTBK5cgiLzPPF1eVT5TBFp+KsdYd7Oc7kn+O69tP?=
 =?us-ascii?Q?ncbdan1BIydxck7TJn5MzNjQLApRfFfJcKTADO5gxYS/Vj2vBIbGZQ/MPvzJ?=
 =?us-ascii?Q?dpxhzYYcCKlWGbnt1A/LsE9MZp8TluIsO/FKE6mqFQsmhRn57kt9BLatpoh+?=
 =?us-ascii?Q?xbtRSZM+3YUdSw9iGOnfQNU7sWL/HR+Q5u1dVzlZJS30MKiFu2ieq96MTnYx?=
 =?us-ascii?Q?3dDmoxN3sxhq8jLRsVaTSP9tKw+5iWVhJIr6CgtaX4b9/FX66M5WJsu2bq3l?=
 =?us-ascii?Q?pWllc7jEBZT0cfBFDIdzMb6itIiyrZU+cv0R7+AjQuJVu/VmwzOkMhzGLOzf?=
 =?us-ascii?Q?s2JUncjXO1RXRNP/7HGs0FEYrMJrw/u4JbpK3mCwPjEOZoSYonyO+rNDNQ4F?=
 =?us-ascii?Q?aOhSef3Zj2hqSs1KCOC87Ic4UxonlRerrllbFATZLWsR39Nap00g1ADbsBzb?=
 =?us-ascii?Q?h7xVZP8xA31yF+GLWlLstCHP8h84qUK6Xk6RMQGkQ6SfvG1rDvBXEppkAywC?=
 =?us-ascii?Q?kYIdkdJsgcaLO0Zogpm21lk0wrS0zxpwHrj9AgDZL3Wy0MA+HR1O4AJGdJLC?=
 =?us-ascii?Q?njXoRT0oqpKAlq4ze/Hh1MjUIH44Z+pWhjv1y1jQYZIE8aJIiWJDQi0ZV9tP?=
 =?us-ascii?Q?r0b1MPWVOa2xCQ9Rz8SaEOak2fmIaZjnXwzOqKgYwWbZcjfbYbojYWgDvLF2?=
 =?us-ascii?Q?4LRx9XkFel1z+FMduSXcddmooCYRqaIb1WtN/NCj5S3c+3gzVggn2SZOHntD?=
 =?us-ascii?Q?6Gt5gcXwJUTLGzkE/c6qRPwjrQIVMXeJY5bBR9QHrnzPSSq/LulHWymHmqRa?=
 =?us-ascii?Q?GX264yVkFYbfJALuM4yvpKIkL5U8H0vEfvkxg6CmxMXTiGZwDPi6m8f7Eogo?=
 =?us-ascii?Q?SPIpH/gxYaUo9mT8+tejiDW1B1DyIEESDaT8S6QYD06y9rYL3xcqucpk0CAO?=
 =?us-ascii?Q?x9stxi6JFZNrtT4V1EWfTclGK0ugUI2to/kmu1v33FIyF0hjWHGY7wE/LKnM?=
 =?us-ascii?Q?+5jS7H58ueb+HRg8PToOfTOexMhOkQ3tQaquGuoYCTOZkNSjxeXOrZskTCD8?=
 =?us-ascii?Q?9YPxYXtS/KUnrR81KBBZ57YxOolutbU0BpCtmaqZkKf79DNXFH2kxfqY+o3U?=
 =?us-ascii?Q?ByL3+Z2sT5/1/Ev7SVFNWvPeEgEL4HFw+1dunw7+2iQMBSxHK+HHhxmDBQwB?=
 =?us-ascii?Q?SSPF78JLUWAnDBmUtQltpXi37AzNOIdFdmWnwyqaSnZfg4MMgAr/puxkEJAJ?=
 =?us-ascii?Q?R4nIUYYwxFx5X65dp5bFsi4aJSLWb3uyU6wOOkh53DhzURwbPkxkzUrZMrVw?=
 =?us-ascii?Q?oNDTdAS7KGAZbuS74JQQcNUZ862ff8QXVmFdKGCzgOeRZJOKubW2iazGEPDg?=
 =?us-ascii?Q?HEJOXYMubbxicBMf7io=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:00:49.8220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f576a506-45e9-4cbe-fb7e-08de281baf11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236

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


