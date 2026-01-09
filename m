Return-Path: <linux-kselftest+bounces-48594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62322D08D25
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 12:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64FB130010E9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503FE33B95B;
	Fri,  9 Jan 2026 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="khLJaFvL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8E22A1E1;
	Fri,  9 Jan 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956983; cv=fail; b=KzOruYdV3KtLgYvsy+3xazfzV9L5qmgL7bYr+Gr2LS7CZe7WzgFNeiqphuQ5wLQTvHhIKr0rFB9RmOJ35j9l5iZvsgInINtSLvsVl5yrBFf7k1AXREAJYbEiJ5aOzp5Pzeq1Wb1gS19ViGfLBRnDXeEeawG4BlRTlfyJ2Ncj0mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956983; c=relaxed/simple;
	bh=VrRGgdv7Rrd/rVUCIOkGufJFXIbe3/Opy5qnRl1YdXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoxXBAHOm/xP+rRhimXQBId7iPet6EPFcCbAADso7ulazm6LNt33dAekznxZRO/UQ6FG/C5KDpEVvQEYcKCADMBruKCB5yh3X3JXBUJgFIKMzQOjBeKO9h1fveuxL3cxbDh+p3Sh2hBSHjYZDTtHsWfv4oo2LQOJMKDo26UOCgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=khLJaFvL; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIYIsvf0xFdA7OSwrBsMd5IGiZlwvi1LM4vQr92TbhpNQJPiNFm+uOTVFFccIE7PPQINlkYNKGq3YKuopmWgtujekj7daIV30EeTUEf0hrpe7W/R7Wz/mwqX82GMC+lx4Fk7Bu+PDIjcIkzK80QCLdwfdGiakRIDCnDaF8Z0Hp/WbkrdEgUweT2WamGnXtN2CaqkLHxRcI0ZwKsd/81g0YrIEMfd0g8htfPBQjaWz7qZjd1+2BGCfuvJp637gjgGp7snk2yr7xEW6CdgRs2/GUFD/oQrYDsZ5Jhu3NczrH+nxuMtPcUm2JuQ1sj7m+wfuzWxbcYrJ7U6sNVQ1Iowqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQchdsuNjnu5O9AMwUoomXYbsIe3G+CcN1GI0Hq361M=;
 b=Ptn8b6RRDrnN7NMX/fCUz1UjhkI7EP4NqC5n+9C0TwrOeBLXXRBymurq7KTbccDumGyEV7hu9VvgNMfWqd5OaRzAcd4Bqr1CdwcqtpEYnwrcAOTgaf/RQFJahncosgQklHRZliVtu8wxGlAyAnBVJuWQfbdZ1ZBDMpvsnDzNwvuTQAvUtu1IcVEYrJ9nJ6lLJfsjcpCj8vlxyrEezV6YVHdyTAEQ5FqZXl5S4iXRnSlCSh3lqw4MAUmgrgVQo/GrxeScYpRL01YGNlz+Z4uZ0JAxH1zazdtgTeQl+QTsY1eEMJ0xbxqJHes4ZfDbcQTD45ABdVmb/iIuQ0CyoGobhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQchdsuNjnu5O9AMwUoomXYbsIe3G+CcN1GI0Hq361M=;
 b=khLJaFvLlYNC2bLv/HUKZ00LWQq1GGJ0ihsQ6dQtQcKaw7oUQWzjMuQ2nuc1lwdUXnvNJw8Pr5NfO8uZpw7NIpdzpDo7qPw4A9zWecLD+JCY5n65s3YWqC7kdArqUj0kzR2esI+TJnt+YLWJgvIvuUHTVDg4t5v7GXymUwKHRFwvSbfHUjfLp8TvtBVja//CA9pEtbtgJhPzYDA6rUa5IvlJsxmS9/Vlz0A+c2Goy1sUJikn/+ewuydNIJxRiZ97bdWz0UTuJHpSb0fYWy9OM8gZBPgFRmtWnpKja3JKJLWKmDu8hqdU1AEiU2ot3Sl+nLpyRehdXI3WaGK4q3BCyw==
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 11:09:36 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::be) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 11:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 11:09:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 03:09:20 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 9 Jan 2026 03:09:17 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 1/1] selftests: drv-net: psp: Better control the used PSP dev
Date: Fri, 9 Jan 2026 13:08:51 +0200
Message-ID: <20260109110851.2952906-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20260109110851.2952906-1-cratiu@nvidia.com>
References: <20260109110851.2952906-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 90aff22a-b877-47c7-4ea7-08de4f6f9305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HkMdVjqRbPZ+dBmARf7SjYHaCBQCdRaq5exkvFlXvxX+Cp4Npk/krjuExTXu?=
 =?us-ascii?Q?K2+2IK0saM0f/TAENuc+4tCVDgM+IUvAqiFleBwoqZ1z5zvSunBbureS0DTE?=
 =?us-ascii?Q?ZWivFpGzdDCzlyrO+4IEOPjaFYDfwH6Mn6rp4gaFl9tE2w2BCrBYwLupA47f?=
 =?us-ascii?Q?x9/ZcqD/9ZgiHohGKZspXW+u3SBoH5WMFwHzBTeZcTXmSvvDQhHsW/ZkzWI3?=
 =?us-ascii?Q?x45QAeSHh4J3Sdvh/9XWhjhDdzVUClwxvgpJfYwuZsZ2pqu4Li7amvgp4uBJ?=
 =?us-ascii?Q?uagoDLhwEmEMXgEG4nwJk3AnliD73R0fu537N6gbmZTBX6anI12VntYpOsci?=
 =?us-ascii?Q?bLE3SeHtZgShTzdAvNX+LbpztlxE7/J5BbqjEjkbMazLR1UorbWEuStu4lNG?=
 =?us-ascii?Q?e/38wbPPE9jnoPyLum1f15bN+xthKDVjtNbd0qFZc+v5ZLeJCJOEvAfkw245?=
 =?us-ascii?Q?n7YS4v3UoF9BbCiI1qCzv75K8Sa5TGNKuaz1Ep5g2zLr3v7s+BeHg+CDA6nB?=
 =?us-ascii?Q?AH6I/eRYw+iHTXWMR6VHMpE101+33Zg/ly7BlZHBPQAKsdLPhD0fjTUL8pC2?=
 =?us-ascii?Q?UYoM6oz/Cplp+Z6XD1d9/mkjwnD8kIsIh59vmCbBdzi+5jh83AapwUDddTdB?=
 =?us-ascii?Q?gfW275F7RbAcKltHTAWbBDjKiWkawi+13JUyaf6zkB8FhIiRt4DEie4y3ldy?=
 =?us-ascii?Q?b7L0zHMbEhP4hwkqZJZ9zBx7YtDqQzJt/TVqpEU2KOXlheYckFocJW3P7ik0?=
 =?us-ascii?Q?qsJl0QDJItEwqNFH47dnJlFxzGjX6i0DgOSn9E6pVD4g38AnQT8w/7zjjWjK?=
 =?us-ascii?Q?R8TFlSSuquV14aoIge4EvW3pp7E+AtRuPoMw79CWj2Ux3qCfww3SnW68Qybu?=
 =?us-ascii?Q?IqV+Asw24KXC4rW9FjI2KAxgLYU0gYytYOswpJ/OB4JIWQkZqijseu6kCX8v?=
 =?us-ascii?Q?cWMRJhnM6HPX7xsfBFpMME8vFNzPbGg27OUDT3AV2DlBqiF7XZfhV2kUvKET?=
 =?us-ascii?Q?dLpWMpEC7WySSUqQLkQ1PcKUxlJ+sXrX9DIV9S+4d5rQfAe49+FLLYcd7KnW?=
 =?us-ascii?Q?B84WvlB3OgP67Hlx9adDMHsqzRgf1WfPICaZdEkLu5JI9YUDrMjvVvstFv6C?=
 =?us-ascii?Q?VV6SWhQZ+CsReGWjPp3QaRvOlrEs+S1jorrpnlQBmcnT2U9aFs/ngINEhufM?=
 =?us-ascii?Q?bOgHsyq5M8wA0TSheMe9ph6Yw8ZzqtWGRRnruK01grczU/nMYoY+WX2NpOsC?=
 =?us-ascii?Q?dotAF5OWhefLsmh+x+qHYjkACT57AV8mYpUYc6doPzY95x8NQcL+jOhMPkX7?=
 =?us-ascii?Q?qJq6jZmaJdYog+ZVR38IwXzRgReT3GcXYAMEIAfeoxK9TqjCGPUxrLv6G2VL?=
 =?us-ascii?Q?zQfuA+WDUjvyOy474VUHfSB86z2w2PYJ+rWkWMNL91KpAZWwVPPZeJ+NcfS0?=
 =?us-ascii?Q?Ov51a0pruqEjAHg8HdNdvRCVSAMNcR8iqktpScJ9CXull5z70W1zP30dEhO9?=
 =?us-ascii?Q?OMPZOZLkBdZUnMg4/idbQUtdfmGpz54Fc1WquensFC++yD2cB1Vuevd+iPE4?=
 =?us-ascii?Q?pFQuK8tq87Y5+8N457I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:09:35.8303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90aff22a-b877-47c7-4ea7-08de4f6f9305
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

The PSP responder fails when zero or multiple PSP devices are detected.
There's an option to select the device id to use (-d) but it's
currently not used from the PSP self test. It's also hard to use because
the PSP test doesn't dump the PSP devices so can't choose one.
When zero devices are detected, psp_responder fails which will cause the
parent test to fail as well instead of skipping PSP tests.

Fix both of these problems. Change psp_responder to:
- not fail when no PSP devs are detected.
- get an optional -i ifindex argument instead of -d.
- select the correct PSP dev from the dump corresponding to ifindex or
- select the first PSP dev when -i is not given.
- fail when multiple devs are found and -i is not given.
- warn and continue when the requested ifindex is not found.

Also plumb the ifindex from the Python test.

With these, when there are no PSP devs found or the wrong one is chosen,
psp_responder opens the server socket, listens for control connections
normally, and leaves the skipping of the various test cases which
require a PSP device (~most, but not all of them) to the parent test.
This results in output like:

ok 1 psp.test_case # SKIP No PSP devices found
[...]
ok 12 psp.dev_get_device # SKIP No PSP devices found
ok 13 psp.dev_get_device_bad
ok 14 psp.dev_rotate # SKIP No PSP devices found
[...]

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 .../selftests/drivers/net/lib/py/env.py       |  1 +
 tools/testing/selftests/drivers/net/psp.py    |  4 +-
 .../selftests/drivers/net/psp_responder.c     | 50 +++++++++----------
 3 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 8b644fd84ff2..63495376e654 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -170,6 +170,7 @@ class NetDrvEpEnv(NetDrvEnvBase):
         self.remote_ifname = self.resolve_remote_ifc()
         self.remote_dev = ip("-d link show dev " + self.remote_ifname,
                              host=self.remote, json=True)[0]
+        self.remote_ifindex = self.remote_dev['ifindex']
 
         self._required_cmd = {}
 
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 06559ef49b9a..de3dfd85edff 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -599,8 +599,8 @@ def main() -> None:
         cfg.comm_port = rand_port()
         srv = None
         try:
-            with bkg(responder + f" -p {cfg.comm_port}", host=cfg.remote,
-                     exit_wait=True) as srv:
+            with bkg(responder + f" -p {cfg.comm_port} -i {cfg.remote_ifindex}",
+                     host=cfg.remote, exit_wait=True) as srv:
                 wait_port_listen(cfg.comm_port, host=cfg.remote)
 
                 cfg.comm_sock = socket.create_connection((cfg.remote_addr,
diff --git a/tools/testing/selftests/drivers/net/psp_responder.c b/tools/testing/selftests/drivers/net/psp_responder.c
index f309e0d73cbf..a26e7628bbb1 100644
--- a/tools/testing/selftests/drivers/net/psp_responder.c
+++ b/tools/testing/selftests/drivers/net/psp_responder.c
@@ -22,7 +22,7 @@ static bool should_quit;
 
 struct opts {
 	int port;
-	int devid;
+	int ifindex;
 	bool verbose;
 };
 
@@ -360,7 +360,7 @@ static void usage(const char *name, const char *miss)
 	if (miss)
 		fprintf(stderr, "Missing argument: %s\n", miss);
 
-	fprintf(stderr, "Usage: %s -p port [-v] [-d psp-dev-id]\n", name);
+	fprintf(stderr, "Usage: %s -p port [-v] [-i ifindex]\n", name);
 	exit(EXIT_FAILURE);
 }
 
@@ -368,7 +368,7 @@ static void parse_cmd_opts(int argc, char **argv, struct opts *opts)
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "vp:d:")) != -1) {
+	while ((opt = getopt(argc, argv, "vp:i:")) != -1) {
 		switch (opt) {
 		case 'v':
 			opts->verbose = 1;
@@ -376,8 +376,8 @@ static void parse_cmd_opts(int argc, char **argv, struct opts *opts)
 		case 'p':
 			opts->port = atoi(optarg);
 			break;
-		case 'd':
-			opts->devid = atoi(optarg);
+		case 'i':
+			opts->ifindex = atoi(optarg);
 			break;
 		default:
 			usage(argv[0], NULL);
@@ -410,12 +410,11 @@ static int psp_dev_set_ena(struct ynl_sock *ys, __u32 dev_id, __u32 versions)
 int main(int argc, char **argv)
 {
 	struct psp_dev_get_list *dev_list;
-	bool devid_found = false;
 	__u32 ver_ena, ver_cap;
 	struct opts opts = {};
 	struct ynl_error yerr;
 	struct ynl_sock *ys;
-	int first_id = 0;
+	int devid = -1;
 	int ret;
 
 	parse_cmd_opts(argc, argv, &opts);
@@ -429,20 +428,19 @@ int main(int argc, char **argv)
 	}
 
 	dev_list = psp_dev_get_dump(ys);
-	if (ynl_dump_empty(dev_list)) {
-		if (ys->err.code)
-			goto err_close;
-		fprintf(stderr, "No PSP devices\n");
-		goto err_close_silent;
-	}
+	if (ynl_dump_empty(dev_list) && ys->err.code)
+		goto err_close;
 
 	ynl_dump_foreach(dev_list, d) {
-		if (opts.devid) {
-			devid_found = true;
+		if (opts.ifindex) {
+			if (d->ifindex != opts.ifindex)
+				continue;
+			devid = d->id;
 			ver_ena = d->psp_versions_ena;
 			ver_cap = d->psp_versions_cap;
-		} else if (!first_id) {
-			first_id = d->id;
+			break;
+		} else if (devid < 0) {
+			devid = d->id;
 			ver_ena = d->psp_versions_ena;
 			ver_cap = d->psp_versions_cap;
 		} else {
@@ -452,23 +450,21 @@ int main(int argc, char **argv)
 	}
 	psp_dev_get_list_free(dev_list);
 
-	if (opts.devid && !devid_found) {
-		fprintf(stderr, "PSP device %d requested on cmdline, not found\n",
-			opts.devid);
-		goto err_close_silent;
-	} else if (!opts.devid) {
-		opts.devid = first_id;
-	}
+	if (opts.ifindex && devid < 0)
+		fprintf(stderr,
+			"WARN: PSP device with ifindex %d requested on cmdline, not found\n",
+			opts.ifindex);
 
-	if (ver_ena != ver_cap) {
-		ret = psp_dev_set_ena(ys, opts.devid, ver_cap);
+	if (devid >= 0 && ver_ena != ver_cap) {
+		ret = psp_dev_set_ena(ys, devid, ver_cap);
 		if (ret)
 			goto err_close;
 	}
 
 	ret = run_responder(ys, &opts);
 
-	if (ver_ena != ver_cap && psp_dev_set_ena(ys, opts.devid, ver_ena))
+	if (devid >= 0 && ver_ena != ver_cap &&
+	    psp_dev_set_ena(ys, devid, ver_ena))
 		fprintf(stderr, "WARN: failed to set the PSP versions back\n");
 
 	ynl_sock_destroy(ys);
-- 
2.45.0


