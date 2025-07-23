Return-Path: <linux-kselftest+bounces-37880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A42CB0F49E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DAC3A2817
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D69A2EE273;
	Wed, 23 Jul 2025 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iCt31chU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602FD2EE260;
	Wed, 23 Jul 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278931; cv=fail; b=rUaw/6jmz3rX1ILkPtjKPGyiUEaPXP1e76UglnAJTw/UzC6B01mBfw9dnSuPX2Jkb0X89FHHOyp/6p2NCp6ljhGnouiNbXpXZp2Zkca1IMx6rblJZ91gFWGauoUUVMyimFU8bZuOYkbBIUozjJSS8waC7xYxaFCikv4tre9bzH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278931; c=relaxed/simple;
	bh=Q3pQUHpolXqXEIFr8pnWKOzZMy8SullEjN74eHtcZ40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPfiRds8OQsbvyBHs4BYQAcUiTl3nL0DWlIbKPnRUyc8imJwqYI8kkp6RBJy5zUFzbdw9rBdjOicVlvctjq3+Ul7FZTisCy7gWiwcKp6XkfhAoSYft9NnYOmRge1faWx3AscvphqIo1x06ik3FGsHbiVDVB+HFIdfpy7zaa0LYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iCt31chU; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsVTBiUaJXIB8S3Qxw+aVYI46swXb7/AwyT9uy+Ix9HzhY6OhOAtrm8/CRf79eZanaPq2yr2C6a+miNIMX1G499hwPYhO+YZtwPHHTKaraUUxdF9SNxn9dqlvg3FJ44obizX+PqVPiEWfmeVpbYj+e/YqToa6gsxMQzz4UE57NmJKf1zmwtjG1ALIKIE70SqotTAdNcK1DV9bHaMZLnjGZviMIpG4g9D2zribI9cqJNkemsxWsn9BTRlvP/U3y8sN4t8XGYmw62hafRkHHK1suf6Im/MFmpcMLhk7F34MM/PZAbEnvH7VFfpR4T1ZLxecFqGkUlQZDiVgpbbVROj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COEdzFp2TZSSCOy0d/SdlvI0azs47rq7qjm2F/OZoiI=;
 b=uKUg6DZOB0QFPLeuP1LStOnode94enME/AIpXkqNYxxsSutjH4gRcXxXGGX3QrhkdPFzwwlVOGZV1z7kme6HMZ166g7CUDZVznK/9i9vCI2OR81npxdUBSM7nck+vjq6jjlNTGHAjcoq76zaJz2/9NQzPXscTWFela+dkiRsvCsOFVrD/gFhNYtVCGwzjgpZw6G5KDb/JxPKT53tjQz29OyKw0CZ8cHwd3Zy3bx7iw57b4JeEsFWRq1F4EsZcm+NjDu7Qlc0fF0kcKzkUfGa4KMBNg7jflMHWgpyB9pn971Yrfgko7lz0tGpRlyerBQkt45HkZxQsWBK3zUep/yl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COEdzFp2TZSSCOy0d/SdlvI0azs47rq7qjm2F/OZoiI=;
 b=iCt31chUv0Oo28/f+1C3bxvwlnUewLVJXsiHlcRCPV9bcBT+Az3DPwo1eEDj/fVhcTdQ2raVE2QpP6xx9XW7uj9xY1LBuF8x/1BwUd8TjuKhPnzZCgaMPUL/+lZ41hLGIIj3hWsXhroMe52/ya2ux/CuJXM3lQR7h0ozops0dBDEWAuUUvzuQq33khnPDnORRmbMz6upzLQc2/Q5NdAjXgLRpyoyCpPjr7WrqIPaDk9NoEzLyYCYhgFjdcmVYDN7c/+PAF5dy5/p5TTpeKKjq7HvMuOCDazhwGEijj3WYqQY4pfO1vyB4+t5swf0GO/vN9EHdHhiEB38omI6teB5kg==
Received: from BYAPR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:74::15)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 13:55:26 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::89) by BYAPR05CA0038.outlook.office365.com
 (2603:10b6:a03:74::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 13:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 13:55:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Jul
 2025 06:55:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Jul 2025 06:55:11 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Jul 2025 06:55:09 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Nimrod Oren <noren@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 2/2] selftests: drv-net: Make command requirements explicit
Date: Wed, 23 Jul 2025 16:54:54 +0300
Message-ID: <20250723135454.649342-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250723135454.649342-1-gal@nvidia.com>
References: <20250723135454.649342-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: d36125f9-c3c4-49fc-c8a9-08ddc9f093e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N+H7PWRIrQPpbI7Upa1jhBQ/QLVQhyLLzGZeEoZJtmMF648apa5VKV+wZoe4?=
 =?us-ascii?Q?q9QSbh/7aLPolcBqB49Zc8AXImql/IKeEClAbXDNKnf2jFnzWMqoeAiXu5Ib?=
 =?us-ascii?Q?U8RKkOe96tcFwYkUKWKgNEXVerrfdYa+q0JHi0kwJjfrmMO7b0i0UX5xjAqU?=
 =?us-ascii?Q?AXMGSgbudKxSBkvhnXncg27qaIrguAmHOkrUjRz8ZfImKN/tM/VjHsioplVx?=
 =?us-ascii?Q?Ld89AePDFHWutiOcnIwJPUN2H5ouL29WFAiLu7SmOrHq4VFyL3N6RRvqgubQ?=
 =?us-ascii?Q?8uOXd17BB3EjVyUZCpiV4XFnEwKKdINd8fNtZw8hcIxwIIdd2WoudV+oPpP6?=
 =?us-ascii?Q?G4W8VuC3+KqGH0OR7NqGWffbob2sufYcUKTKPUpsa9ZBeLAMRy/lCER7wNpQ?=
 =?us-ascii?Q?wmcDRlT9UoPYYtRrdlV7KtMzzbxH445wxAkUfOWOYhrfTBF9Z8wbD0ERGoeO?=
 =?us-ascii?Q?UsuP9GbIHLcTEAyXbIXnMsiX2LfKSjOIs8tK2UNGBUmvi+N2mGOV3pmPPevb?=
 =?us-ascii?Q?OIy/TwNHI2YBtU+SfnlP0T0EFSE1XW91oiZfI0/JYluE9So597DjixJWy8qu?=
 =?us-ascii?Q?dhbNRk0RT6ewI6ZdzAKlnfmcUy/a5zFDM+X3Thhk/GgwA0a5RGJNEnsYKbN5?=
 =?us-ascii?Q?VGlG6oR/jFO53DZ76FmUe7qalBEFqN7OIu9uQ6DcAXiw3rVnT/+x9V5BFRZd?=
 =?us-ascii?Q?NdrLLep9LCUpjit45klekeMPEIv9uULl4lo6sy/0ikOq7ujBtWV+Nom8j05T?=
 =?us-ascii?Q?ZVchBlkazLDrTYvG8T4BLhf/3KiOJWVcsJ+wlPiv9L9X63jDSx6Cj1pzbBkN?=
 =?us-ascii?Q?Do3LoRGNKZhAmEnoxk9LIBQrhl2ltq1GXjgytr9rNcA22fZmHsimsbtWtab9?=
 =?us-ascii?Q?E9D+VvuCQrE/6U78oJRzAmyhjYmeq/w7f4+3UK/anMvMSg5/8iPTE+NSn6hT?=
 =?us-ascii?Q?P9jnYkrwj9cKjYCVgoAM66pkV86psOxPgCwGTP2W0doSYAhGNgXAV/I3PXX9?=
 =?us-ascii?Q?lZntBefY/LGxQwiMQnEHK3iWBntTOZOg7pib6o4c64RqZ9WsDxCdmIVfZuCk?=
 =?us-ascii?Q?1/hJ6ZAfy46Ou/cSXzAGU9m3eql/2+SWVHspkOB2yLYKuB4juQt/DgEhaqtY?=
 =?us-ascii?Q?cYlG8ttBMyyP2mdsjFPJMzyNE7nRN/QZkv0J2X7RJUzgE/tp+ZOEy0RLW2Pt?=
 =?us-ascii?Q?Vp+pzNeaigd0VbAnXjXsiqf3MKB0fKADQmdXbMK3QW1k7xjV4IQXiwmlYB+1?=
 =?us-ascii?Q?KaERIsCQIKs+1tLPUp5Pd7b0WZ8zQ0ckUythicMfpGysJHMBug35EhFG1dkx?=
 =?us-ascii?Q?8sby0eV29vQRl1VTHMTqOO2CzBGFcPOYku6UL3Cnr5TfoqC/M0nj5IhaTpzG?=
 =?us-ascii?Q?xyAG6yYfzTq9tsPzDGKEut0N9q8atSd3wJ2UcgWclQLqtTTGnjGa0t5OW3iy?=
 =?us-ascii?Q?F/FhzH6awkOrgnHKFI5C9aMB3RIU1yKNUCuQrDfG80ynbK7uYq0vPlf6eO2s?=
 =?us-ascii?Q?REL8VPaGGcUwZugbVhQFJGg9KUUO7yqGCUp7?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 13:55:26.7153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d36125f9-c3c4-49fc-c8a9-08ddc9f093e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981

Make require_cmd() calls explicit about whether commands are needed
locally, remotely, or both.
Since require_cmd() defaults to local=True, tests should explicitly set
local=False when commands are only needed remotely.

- socat: Set local=False since it's only needed on remote hosts.
- iperf3: Use single call with both local=True and remote=True since
  it's needed on both hosts.

This avoids unnecessary test failures when commands are missing locally
but available remotely where actually needed, and consolidates a
duplicate require_cmd() call into single call that checks both hosts.

Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
Fixes: f1e68a1a4a40 ("selftests: drv-net: add require_XYZ() helpers for validating env")
Fixes: c76bab22e920 ("selftests: drv-net: rss_input_xfrm: Check test prerequisites before running")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py | 3 +--
 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py     | 2 +-
 tools/testing/selftests/drivers/net/hw/tso.py                | 2 +-
 tools/testing/selftests/drivers/net/lib/py/load.py           | 2 +-
 tools/testing/selftests/drivers/net/ping.py                  | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
index 820d8a03becc..0c5a5a382b54 100755
--- a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
@@ -451,8 +451,7 @@ def main() -> None:
         )
         if not cfg.pci:
             raise KsftSkipEx("Could not get PCI address of the interface")
-        cfg.require_cmd("iperf3")
-        cfg.require_cmd("iperf3", remote=True)
+        cfg.require_cmd("iperf3", local=True, remote=True)
 
         cfg.bw_validator = BandwidthValidator()
 
diff --git a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
index 648ff50bc1c3..103cac2737cf 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
@@ -32,7 +32,7 @@ def test_rss_input_xfrm(cfg, ipver):
     if multiprocessing.cpu_count() < 2:
         raise KsftSkipEx("Need at least two CPUs to test symmetric RSS hash")
 
-    cfg.require_cmd("socat", remote=True)
+    cfg.require_cmd("socat", local=False, remote=True)
 
     if not hasattr(socket, "SO_INCOMING_CPU"):
         raise KsftSkipEx("socket.SO_INCOMING_CPU was added in Python 3.11")
diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index 3370827409aa..3500d8f1bac4 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -34,7 +34,7 @@ def tcp_sock_get_retrans(sock):
 
 
 def run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso):
-    cfg.require_cmd("socat", remote=True)
+    cfg.require_cmd("socat", local=False, remote=True)
 
     port = rand_port()
     listen_cmd = f"socat -{ipver} -t 2 -u TCP-LISTEN:{port},reuseport /dev/null,ignoreeof"
diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index d9c10613ae67..20e39095f2bc 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -6,7 +6,7 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
 
 class GenerateTraffic:
     def __init__(self, env, port=None):
-        env.require_cmd("iperf3", remote=True)
+        env.require_cmd("iperf3", local=True, remote=True)
 
         self.env = env
 
diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index e0f114612c1a..da3623c5e8a9 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -30,7 +30,7 @@ def _test_v6(cfg) -> None:
     cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["6"], host=cfg.remote)
 
 def _test_tcp(cfg) -> None:
-    cfg.require_cmd("socat", remote=True)
+    cfg.require_cmd("socat", local=False, remote=True)
 
     port = rand_port()
     listen_cmd = f"socat -{cfg.addr_ipver} -t 2 -u TCP-LISTEN:{port},reuseport STDOUT"
-- 
2.40.1


