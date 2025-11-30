Return-Path: <linux-kselftest+bounces-46744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F5AC94CE5
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 10:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439EC3A52B4
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825262798F8;
	Sun, 30 Nov 2025 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Td63C/zX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6662773F0;
	Sun, 30 Nov 2025 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764494482; cv=fail; b=qurlkeeM5GMLhEcdeKPSIfxdj4kq0ZUFen+/SD3w44Qrr0uRc/Rcb3ITVJidiPadOquWT67DY3amcuTuzg7CFoakXmpoQvVJk+1EIe0nx5hR+4Bu4b1DNvcbJFpQe6eNXizJbOe3ZeR1QU2kfojmgD6IDkakX3lW+v8U3+cJ3s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764494482; c=relaxed/simple;
	bh=C0ublNI2iZD55dLt5usQ7u5Y6z0X8SlSPeFp/VC8pHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYwGG02wn1DB1zFQRfzeoy2RP12sw3UsWcxivrJRJB0cSEC2m7PXcYzsPxxKT+A3+Vcwg8LoXqSj1pkhKBKLjiN7Q+oeZRL6G2z4NquHt2GH+WXWx8wwSPGNyGjTid3lrpebDKZHRYcqUuDg4WIsQ4svznWtJYg5FnRoa4NW+9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Td63C/zX; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJIiOBYPD4gurIBcCMO3KfYg+4DGjkq/Lr7pbaTLeXdx1ryHxzJS0QuQFfcuJTQ6VcDfEIsBAMa3nGa2T3oT38WXPf53D9udmtH1ivw9mV+4hqDYWzeNyqX1VDuwSCEFYdtSDUyLjtQHXl198m15AicoCLoGgRBcJOSd1UwJJrZVMJ4yF2rGaAi4N6pcVNX6VJLRg933rVx+yMWuiWePEgKNaDsR5R9zr1XBY5y/dYf7sfSmSzBy6K0zwOv79MqIAIL4IHbbmW+nd1U3Ka7q6NrnnhL/uJWCLzKM+Gc0jKUQiWH4UgHulCUManBNCplAt2O3pl6yMI7CpRQ838m0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HjVY2dx/pUP07YBrQlmsjKB9ObKbShVadQdBUMwTs8=;
 b=n24WEBj428O2yXm4Ds+ci6ZC376iv4SW7aEPHGzelrE+rTyb/7MrEP/Tps6oBiFBPxpfY9ii/9tXxVvFei3xXbqwH6p3JqVk21XMUZVmTR0kPBWnfISurC041djBL/iMBjsC0vATg6h9wkpUWPIUU7sS4v3E0FSjh5I67pZvjW3w8sehYDxsI9EjjNL8nJHgmLgntgTcSPlgVIM+jGP1GYsYPMl/lKE8nYpt1ZJhZwDbWsDuunKbqIqV2NbjeOE+0ehAtaFKs0f8j1bTZNdCW6VjyZkG4RbvZ6WpvFZ2LzyInbN6wv7z+cbpYQHZb5u47BAKkXXf+O05FNm+RjvnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HjVY2dx/pUP07YBrQlmsjKB9ObKbShVadQdBUMwTs8=;
 b=Td63C/zX76e+kmvkvdA/CzRGFw3Aefem/I6GXMYMc0pbwNkyqDYt5I9x5gSOa5UO/qrVJw9Syug9Myw/roJk6W9OeYElHY3SwaXKaLwAO3tjXhsEddkfpwjl5dwGgxrByPRL/9MuiXOTXWEm6/FigP20kz9JHe9Wk7bv66bf39UTlAdsnTNCGvn8jJsjBQ5Unb400Qjn8pNf/pbgiOx7tZGyn5PwSQiwVbn6B011PUz/dJNCrJJUIpwHgTVrOjPeQpprvjpw/XXJVB/1l2mRtkf1usTaonJBKGbRPeOs/gAQ9SfsRMYHqy/Zhz9NrpoL3rL5i7+4odyF6P1LW2mgKg==
Received: from SJ0PR13CA0080.namprd13.prod.outlook.com (2603:10b6:a03:2c4::25)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 09:21:16 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::b2) by SJ0PR13CA0080.outlook.office365.com
 (2603:10b6:a03:2c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Sun,
 30 Nov 2025 09:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 09:21:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 01:21:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 30 Nov 2025 01:21:09 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 30 Nov 2025 01:21:05 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V3 2/6] selftests: drv-net: introduce Iperf3Runner for measurement use cases
Date: Sun, 30 Nov 2025 11:19:34 +0200
Message-ID: <20251130091938.4109055-3-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251130091938.4109055-1-cjubran@nvidia.com>
References: <20251130091938.4109055-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2c71ba-7d5c-4c9d-707b-08de2ff1d042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y+4sCNNgpH1hMSHS7q7EHCD6xRMvcTfuAFrZ58e1txlaWV2kf9RNRqtOspq/?=
 =?us-ascii?Q?4Cfl30e3Q7o2pQQ5c1YhnMjIDEkf0SioUz0UwX9P42wW6i4COMHphQC5odds?=
 =?us-ascii?Q?Tti/wViyH+MJNvVDerLn3QrY9gSI7d0Tk1MRZAZVtXbHZTsOKWu8ZAV52SFW?=
 =?us-ascii?Q?XET+D2iC2yX2Q6m+av/DLGGOrBYuCbMA38v0zELD7Zw3CoFJ/swk/gfkChPG?=
 =?us-ascii?Q?B94b/rNkgEz3fxtbjTU4qgWzws7h4oN+/ZAwZrDkaZ4QtNnhleNAD9ubmfSZ?=
 =?us-ascii?Q?VvnQvJFaDpkgssldbhNpHYLMaviQhoi3RbZjf1ZuSFeT95s5AWxvvJt9Xe9V?=
 =?us-ascii?Q?DswiKyhbVp73HmoaS0csK3pmkxFMOeag0OwK7BbRVJbwA7qnnicaEFh9wktz?=
 =?us-ascii?Q?tWdrVpsvdoxPEvn1rgdbDYk56ILcywHjX6njPNh3C8dZUT5SxyNXsiJOSWgo?=
 =?us-ascii?Q?ilx8OcCDJcnXXWqr0bgXr8X7aiBN40JG+XBWUPqvRaJWZuWgtodLzVSh2By8?=
 =?us-ascii?Q?VgsN8rsrbPodTJ4B13Fv8OJm6b3plbtU686agn4cy5gXJJdqEztaPIXHeEWi?=
 =?us-ascii?Q?Q2kjuImVyi4Sm9EtSf8zHP0mjwHVu61KJ4U2j7xLQLCXFcaT7kGtbWP5NiOX?=
 =?us-ascii?Q?Jt84bg0LaONKnHFBBHK9folSnBfu4hNmacU8qG5Joh35J67TSENPJdoPtkEr?=
 =?us-ascii?Q?MPHkoQu3vnJi38pGtW6KRpbD2ncPqgvpiWW8s3TnCh6Bgkz9vCgz6qKoXCse?=
 =?us-ascii?Q?CGZPkaXGh/uL0U99dEVEQIQolr6Rzk55ct8jAwJ/qRf4h7BnH/qPnaXsvWZS?=
 =?us-ascii?Q?9MyMOCEEYvswgAYCiJNIvcsvU/NlW4JfO04eJovR/Q8TazvroviDn9Tf4UNb?=
 =?us-ascii?Q?bi9sDUTMYIsvWjvLzSx0gmbIT1jxxgCl681XtUQLPNcaGfHuB9KAPoaMmV1z?=
 =?us-ascii?Q?3MiSNyMBaB1EUiFW0Q2NDLCa63reLNF4kLUDPM4G6LuIampUiCIBLkm2BS6I?=
 =?us-ascii?Q?QI4YpLYsgGN4t8b5QHjPcAiBDqrCkScuofOWszlJrsU4WAAJegkz65Q9BKdo?=
 =?us-ascii?Q?k/EzZBACTdko6oJ2EYjoT2rWK6/8/OI8exVLoFBkSwu7wRxgpLMw64vM2IPA?=
 =?us-ascii?Q?Fl5yQm4t5zqo3JYLQtAxWhmArUh0i8xioQ/4ao0EbiWgZVjEik3H9C3VD+gI?=
 =?us-ascii?Q?kaiEZbPs6jKesmeoaAT0JxQe88f93h5Ed1PHgub9nqH+jDmakTPmNpVNScWS?=
 =?us-ascii?Q?MTI0oPkhaUAlt8boJ7CKV5oSxtMCLucwJr9KxsaG1Ea1QHzl3YO8fuh36x+Q?=
 =?us-ascii?Q?RdbJbT1Jvfok4AySJDQET9qsFicoe+V0IzB7ZvXspj6qCG0Ft8sc/bb+cg+M?=
 =?us-ascii?Q?M5KJiUSIMMWB+f3Vht+pe07mvRKccS6N7vNmnBYylMRuHLqWr9Ekm2xUZ6rE?=
 =?us-ascii?Q?VAJ95SggeuUv9vlkJ2NFWjiW0SkEO3NJ5RsS9rl4FuDtSnqSS/7W8FQsuyH6?=
 =?us-ascii?Q?//LjLFK8CoztlXXghi+YXGwKDFSrfRMTrVve4LvILU/2+lifz0d9VRSuF0fe?=
 =?us-ascii?Q?IqBz242oNoBgAcNnwdA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 09:21:16.0655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2c71ba-7d5c-4c9d-707b-08de2ff1d042
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34

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
index 0c61debf86fb..766bfc4ad842 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -28,7 +28,7 @@ try:
         ksft_setup, ksft_variants, KsftNamedVariant
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
index d9d035634a31..8b75faa9af6d 100644
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
index c4e808407cc4..f181fa2d38fc 100644
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
+            raise RuntimeError("iperf3 failed to run successfully")
+        try:
+            out = json.loads(result.stdout)
+        except json.JSONDecodeError as exc:
+            raise ValueError("Failed to parse iperf3 JSON output") from exc
+
+        intervals = out.get("intervals", [])
+        samples = [i["sum"]["bits_per_second"] / 1e9 for i in intervals]
+        if len(samples) < 10:
+            raise ValueError(f"iperf3 returned too few intervals: {len(samples)}")
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


