Return-Path: <linux-kselftest+bounces-37832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F61FB0D995
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 14:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67356178F23
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369672D9ED2;
	Tue, 22 Jul 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M6Cdj2zl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5621ABC1;
	Tue, 22 Jul 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187234; cv=fail; b=EMH8rJ0hn02J1zPMPQLqckH/p7uq8N7+HT19bXidhK2SkEGQD8aPMuhonzI9dD7OE/TsmXJ8m/hKpuOOollSskek/fZzWvu5PYWyfqSJGgDA/X+jqF1vYBKgWGVFwAAYFj+i49DbwoTj/xUWCVppfP2+ht9MtEK7/cHBD3RQ9Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187234; c=relaxed/simple;
	bh=5mKK0FU8dE4lOVIom8KED6ULi787ciLNhtLiEWArVCA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZB3nMON5KfjzffLc7EKcgOmkNn+gcGFiEQubrOzw7AdHLfvO/nJmW+WgPGMVDw892RivfOpEEV7ClUC4E3sw7vkX134Lyn8kExlbjPDeNo1YKmqmy3c41J7O5DFX/z9jEdGKw+g75XOcjO49jm6lh9jeYaBL6K7d/njMY1c6wlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M6Cdj2zl; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKE9t+iDOc9BFEIwrkCegTOmdb5e4gknlBXJXiPgR0e1gpl+mLre1hGRKOZ5YkkiA48NJw8T1wzAIsrf+6Ly0FaCqr1QY8/NOrscSW1ew18OOvS33BOsqisKuRALkWnksmwj/mtA4BE7YgNT2f+ZQes1oBxP1irZVLfkAnpAqtqex6kmeeFRbyw+YeTPZlFlKIsUAqYt/p1I114hK4HT4ugMJbHTXvG19vbo5w0PPJoPhLb5OHExUSUuS1ALwPAEWPFhM62gknxXvsq/N2Ag5RpBN4mQe0MP4IDPAwYf2qeDsJe2yUb+jPQXyQUTMw6Ce8glbo45MPV0ow+erLHt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PZrPZPDcpU2qaLTYk6bzRE6nR3GYf1lOta7F+sKAuY=;
 b=JNAdyD3FnvxcsRWT9jhtt5A3Q570/EJeBp2BdJpJyDpnLhtN2cTgfi71k7LDFS2zxukPjgtjtKlnA5fzJ5vAQAhrkA0AbtGBj+nIXYr0KDkag/P1T/aNKntrWKGucnWp1StjH8+ECn2nQ2Qf23j+8kHsTPF5RfTx/HXAVe2YFmOFk633vnTIcTYhb2Lg0CsSj4+LIDQLhzlr41Y7UaK5oH/5sufG6fnGo5aIBsc+CwAyyuxJhCiMq+jxdPbjpp8u0hsm5EVmyPBB2m9ru0q5kVct9WW9EQZ9V0ZnwRBT1Ovs/zQKQWWsLSgw4YAvPBimCOp1Z/nSXvwQYmEllUryQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PZrPZPDcpU2qaLTYk6bzRE6nR3GYf1lOta7F+sKAuY=;
 b=M6Cdj2zl+3epGmpM/pWeYFgET6oidyilZqp00+g1chDNJLYgJzVSooHxlOO0QgsumfWLmy39zwRhhijr+Kaqzm4moR4DvspwM4Fz3tODpEQUFGBMR9QWxy6ehP8iB1+RJWxeMPRODBgjXCsF8AvyBF5jxQwc+Skog4AVFlm9VP49WLR7mCiB6Gai5oFuvE6khBxrZQEfVsWr0Wnb4al+dpyorp+Lsyalw4YPMKLi6eaJZJJgm6CkwYuXYuNTNDCwcS1H2HdR7fTtt0BDHgS3o1bdYkHL99qCQkPQbQXDPb9rTewvd+2D42z4dTcZgGur+VHMrQsG8hNkgdx8lOcRQg==
Received: from CH0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:610:cd::25)
 by SA5PPFB29794CA1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 12:27:06 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::a9) by CH0PR03CA0110.outlook.office365.com
 (2603:10b6:610:cd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 12:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 12:27:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 05:26:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Jul 2025 05:26:57 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 05:26:54 -0700
From: Nimrod Oren <noren@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: Nimrod Oren <noren@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>
Subject: [PATCH net v2] selftests: drv-net: wait for iperf client to stop sending
Date: Tue, 22 Jul 2025 15:26:55 +0300
Message-ID: <20250722122655.3194442-1-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA5PPFB29794CA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adb1206-6496-4a14-e28e-08ddc91b1244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lJc06wDkbrf9a4/YgMLnIH6lui6Rauv2h0dNxex2SqnsnhagmRY/+mI7IZZ4?=
 =?us-ascii?Q?ut4A4jQOgK9S2Lh6dyYlhK3dbjckvw0Fm7ScblMCeWa+e8REFa6giIZ9y4FZ?=
 =?us-ascii?Q?P3u5ci9n3zyLPLsjphPgy89Ip/ylYodQ+YR3bKrjm8JQnVy8ljd3KOYdOtGi?=
 =?us-ascii?Q?wncPwzHjcvf4DBrJCAuD/XYRmxVFAt1Fpj8cWR38OSi0zwGA/hlofBRTAGkC?=
 =?us-ascii?Q?01kH875Bu2uteX7FKosgW2P1S6ot+XsgEud0z5woVEyvxPfVGyXQcsBG0Mas?=
 =?us-ascii?Q?CJXfyolpntA9+DimB3PzjQe7hV+P89ivSPAT+2o1owt/6quyHrKbRsQLP9vn?=
 =?us-ascii?Q?zyxnjJU7EWYZsBk77ltAbDQiWMzqNBZdpFzMEFyA9Jfi6n0gbjSkHgo+E0xn?=
 =?us-ascii?Q?Nt33xKWKsMz/W4KnChzQgDC2xFhOjdBenlMXt3D9EFVxu+Kb9tnMYzK5/fAb?=
 =?us-ascii?Q?+i6s/1hffVD3ZI1SWmo/EAEgAjEhpha+EoqLGQ3ZXAKgcS4VhBJHFcYgBW0B?=
 =?us-ascii?Q?bujgstaNwCiWjaxOxyj1T9dR7XpBQ4vamkCBQs8VBZN6L73A5CPeysK2GEbZ?=
 =?us-ascii?Q?+PbgmpXRSNXo7EPUwgcaPDSEXPI+Jng10U9myFMhLVygpxEnuN+psXZl1ETP?=
 =?us-ascii?Q?L4S+ZD48pYL4A6RTFv7bW/SNvkp1hYfILB/GZo5fGekrl4iYb2xhCdg8pqeM?=
 =?us-ascii?Q?hy0NBxdnHJOXftE4Uf5ogp0fSgIVikYGm8RC/H430SKON22DwTaGHXwBk3dA?=
 =?us-ascii?Q?gsEYD2no8fRUkmbKuzU3qF6JJuOEuL1Iy6VAjla8KeoFcgnO5UACzpVwaQwI?=
 =?us-ascii?Q?YWdoHvvORNwS5tmW0VCbbUf8xbuEmxHzkZkm30b/mlCCJ0tpbxf7uwWfgEx0?=
 =?us-ascii?Q?7HSI3ZHsFPYKbqvSOO9WFyExF/54GRahcL8mZejY4Tz1qyw4VI+2NGu+vcNT?=
 =?us-ascii?Q?DEh47FVne1BzewG4b9ChUslg60F26ycGaaUvX3nbH2Wtt541v0PDYKV2P0Wr?=
 =?us-ascii?Q?t5t4XDlw2vg4TIvMpYCMpTck55uGO6aRPnIzXqUp7Dwfchfx89b1LD6fX1Ft?=
 =?us-ascii?Q?bpsidQ0vHjxa3NJYCvg+PK15WtwcZiZn5c7RNQPOrhZZfLTFVOo88BijIpk3?=
 =?us-ascii?Q?Vymg5KwmdjZG5dZpdA7irYBqT3sSRW7TYwho1rPSLYQfRnBV/2sxfTAp6EX/?=
 =?us-ascii?Q?Y6QryfxToGwYTZfYYO4C25fd1zPAPEKQ+lRIDfckcdLiseNtQ/WIh8rT/AP3?=
 =?us-ascii?Q?8vlsneRsgTQDWrVfBOy3CtW0S/L9R/3LYMUA8/I9xYZuMnGQbTV0n/6B/fMi?=
 =?us-ascii?Q?Bd8p0LEHo2336Yx90oItil8ilOSjJggvRjwOiefrLw1Cij5Qorp/GTIeCS94?=
 =?us-ascii?Q?azd3iUqnRytcu5vaqJPAM4hF9o+IezjCJ6vGhfpJnja3z3n5etfWmZoFUrN8?=
 =?us-ascii?Q?Xf91XlFXvYhsPdt8lfly+OpfXckXB+fLt9y4iUpTByqOO/HQvTdiS6RVxzsD?=
 =?us-ascii?Q?ps4hQwqtmju2+wM1zKA6UhYCeNflDd7fhPd/Y8Wj9r7afqaToarb5iqCNg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 12:27:06.2918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb1206-6496-4a14-e28e-08ddc91b1244
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB29794CA1

A few packets may still be sent out during the termination of iperf
processes. These late packets cause failures in rss_ctx.py when they
arrive on queues expected to be empty.

Example failure observed:

  Check failed 2 != 0 traffic on inactive queues (context 1):
    [0, 0, 1, 1, 386385, 397196, 0, 0, 0, 0, ...]

  Check failed 4 != 0 traffic on inactive queues (context 2):
    [0, 0, 0, 0, 2, 2, 247152, 253013, 0, 0, ...]

  Check failed 2 != 0 traffic on inactive queues (context 3):
    [0, 0, 0, 0, 0, 0, 1, 1, 282434, 283070, ...]

To avoid such failures, wait until all client sockets for the requested
port are either closed or in the TIME_WAIT state.

Fixes: 847aa551fa78 ("selftests: drv-net: rss_ctx: factor out send traffic and check")
Signed-off-by: Nimrod Oren <noren@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
Changelog:
v2:
- Replace fixed sleep with logic that waits for client sockets to close.
- Update commit title and message to reflect new approach.
v1: https://lore.kernel.org/all/20250629111812.644282-1-noren@nvidia.com/
---
 .../selftests/drivers/net/lib/py/load.py      | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index d9c10613ae67..44151b7b1a24 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import re
 import time
 
 from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
@@ -10,12 +11,11 @@ class GenerateTraffic:
 
         self.env = env
 
-        if port is None:
-            port = rand_port()
-        self._iperf_server = cmd(f"iperf3 -s -1 -p {port}", background=True)
-        wait_port_listen(port)
+        self.port = rand_port() if port is None else port
+        self._iperf_server = cmd(f"iperf3 -s -1 -p {self.port}", background=True)
+        wait_port_listen(self.port)
         time.sleep(0.1)
-        self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {port} -t 86400",
+        self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {self.port} -t 86400",
                                  background=True, host=env.remote)
 
         # Wait for traffic to ramp up
@@ -56,3 +56,16 @@ class GenerateTraffic:
             ksft_pr(">> Server:")
             ksft_pr(self._iperf_server.stdout)
             ksft_pr(self._iperf_server.stderr)
+        self._wait_client_stopped()
+
+    def _wait_client_stopped(self, sleep=0.005, timeout=5):
+        end = time.monotonic() + timeout
+
+        live_port_pattern = re.compile(fr":{self.port:04X} 0[^6] ")
+
+        while time.monotonic() < end:
+            data = cmd("cat /proc/net/tcp*", host=self.env.remote).stdout
+            if not live_port_pattern.search(data):
+                return
+            time.sleep(sleep)
+        raise Exception(f"Waiting for client to stop timed out after {timeout}s")
-- 
2.40.1


