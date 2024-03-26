Return-Path: <linux-kselftest+bounces-6640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8888C9F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8921C64238
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8D13D50B;
	Tue, 26 Mar 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RTWsRCNq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6E12B169;
	Tue, 26 Mar 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472446; cv=fail; b=hDEZMuwfX4e1LRVu6QuhcFbsyCEI+jVtJuYX3RrBApbIgKuuw3rya4aL33w344mzag3oTMZ2HhxsDEgAdDSuEKuyQPSx+b6wSTs7cyq7DH/u9638A2RyII+7XmDoB6kQdX1TTK8HSxGfXho/rCBXwQ3JfzFWq57OJYLSFMMYVVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472446; c=relaxed/simple;
	bh=mTPwOqJNG2Ubgo1VbL8KBG94pbeO7Ct69PxV4ztwl3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7Op97esYH0x1P7G2FM0EpDaaPwigfbEdxsMIlNzJAnj3SNP0sC21DXzNcs8xUuVkY8/zuCm7UzBY4E/py9mUkCxqevgccPFe9acD+W3Z/GRudboiJYjZY4t3RoMM2Tj0cDNzQ20t29U7NEkQg+PjVKWXliN6IPUHKawxJcTo3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RTWsRCNq; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5bsmHI9w17xj3i1Edcph4JQal+K/u5Ih5PdaXwxnjGivS4QzV3XqVq6EIkDGECz7Dohpo/wre2arEDPVzLLPssgKa1DZSHJjkzswJodgGYYMrkLZzQw1ycErW8wmabRYWK395Ckrue7+8Mt6z0NEvcwM8P3fmDWpB0Jim4fJ7iO0kYZjvxcSHYC6GFwXpfNvxVVm6WVUCk1H1+6kAaivliJmaTH+X3z9L5Hk4sR+mROO0Wz4hRXIXvuK2Sh67bN4zqkuiY/gySySXeGwqd8KBYc8ChWg5GmxRHJgdUtXRVHuRoHThvCMC65RbfEHJdmALR8G2YyX5WxwDd6JMKspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2xhSPmedJ8u8jI4x4AuYT4tsV3hpK7epS01tm6pQDc=;
 b=fnNw7MgWdYWm4FCeBqXA1bBi9K49OJiTOgf1APIVI31pUtYsKlMg+O31qxiU1fklf1NTgcVNE6i78AV+W9NXxNGPJMvU4tIJBuEcW3EpoRP9q75Ao32vpB5sbj6D+ZxYmswZ7KZtNN3YsdNg1g8WS0FlvatWwCmhPMMzLo1HRG0ucULxoutMJINl/LiIVbsXPsXFBzTsepf4OUWa5U7qZZ3Dj4TAm3sqvODMDeDF3NWky4xDWyHqMQaf6McNrZNVeIz3Wd8who0/CI6+9bbZryFngJVIvollu/O+MMEFiyS/VXi00R1pmihUXaGN6gDmAoSyU+ava/QkvyC6yuO98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2xhSPmedJ8u8jI4x4AuYT4tsV3hpK7epS01tm6pQDc=;
 b=RTWsRCNqJzkYwMU1KZvNPZKLweTYH/SpBX/hIDaQ5n1jxZbkpRr7icEuu6DWIdBPnRMH0mcV4BOSV76RE76SYfNVzan816t4kNmeAveWoCOevSCTaCp6A3ypMovgiTmS079MUshbFqwiKHhyb2c5qyLVBS9AW60LVcWr72IhHQt1SG1UiEEh7bhgNh5QlX3iNoVC7USEPPKGc33Yy3ubufhUuJdRIfVZlVcfSbo0Dj/9KHEc0HHjjLldJYUth4ZW6pGaXIABzj7ae1niGldKvcGaCt9sdZ9gnFXW18hkzYjYavngQjzuja3O3iIiscex9mtTNx2Es3hkEeSyBCr0/A==
Received: from BN0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:408:ec::29)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 17:00:40 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::b) by BN0PR04CA0114.outlook.office365.com
 (2603:10b6:408:ec::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 17:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:00:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:00:16 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:00:09 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 02/14] selftests: forwarding.config.sample: Move overrides to lib.sh
Date: Tue, 26 Mar 2024 17:54:29 +0100
Message-ID: <b9b8a11a22821a7aa532211ff461a34f596e26bf.1711464583.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711464583.git.petrm@nvidia.com>
References: <cover.1711464583.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 005d341a-93df-4540-4101-08dc4db643de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YcPtb7cPQ5i6iFLmLu5gS/11xCGyYxR/VpcYAG/TANzMi2IRaosu3dE6zs0kC+UYq46S/lV6giUoQZOyTwB3xa0I2y6J1JO54jHKBupZFtCwpjfFY4ijfJ5WAE6+sQIeEl3SxdYknhIO94zB4GG1dkSmiUcV6n2NcB/f5C7jz5PAxgZbGHE0qQiVro9YyURw/2p+izW712wOrYulSxiF1IlqOPYtf9U5cobu8slJ4U7tyW17P87As3tqfIbC5ILtcBAJaCf7LbFuzXjZIH6s+yT8Jz+/au9h6QmgSEkQRx1teT0tKwSaG69nv7GGx1ZgaX6oZBm9xo8CH6z1aYZ/dwyiE691Gopzi92xcpBs/VCtgnTDojTLWoCbXcDP7aTrbLyn+ma/yMYGrGmjQJ0K6BtGiGjwzkhqGUl22Yp38KxB4/DReBEKcPulF9saUlK8tXvTXS3mOFRiHOmDU7kjw/xd5GHDGyhk2mfqjGmxjFN9hIv1p3SyOGpWFVA0//qb73/CujWoAwjsZBEt/L1NzD9YTqc6I/udm3vwffcBc+uz1d/mNrw0BMAEwvXsrvnkuCVuQ4jyZcK6btQ4RqQyPAoVQnlbIwEZlPXHuzjBU2zNm8Lw48PIHUvrwFYByjaoHIJLI1mHzqjukPMC1gx2GNEJapcyFjxfXJnnuV2S269532hF9z38AQoM0hiZZEDufu/dQ3DZqayzpu2Ok1+fwpE/QYi6b1AglY5MWRjQyB9iU95XPa6AXojI0EkBJTpM
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:00:39.5918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005d341a-93df-4540-4101-08dc4db643de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046

forwarding.config.sample, net/lib.sh and net/forwarding/lib.sh contain
definitions and redefinitions of some of the same variables. The overlap
between net/forwarding/lib.sh and forwarding.config.sample is especially
large. This duplication is a potential source of confusion and problems.

It would be overall less error prone if each variable were defined in one
place only. In this patch set, that place is the library itself. Therefore
move all comments from forwarding.config.sample to net/forwarding/lib.sh.

Move over also a definition of TC_FLAG, which was missing from lib.sh
entirely.

Additionally, add to lib.sh a default definition of the topology variables.
The logic behind this is that forgetting to specify forwarding.config was a
frequent source of frustration for the selftest users. But really, most of
the time the default veth based topology is just fine. We considered just
sourcing forwarding.config.sample instead if forwarding.config is not
available, but this is a cleaner solution.

That means the syntax of the forwarding.config.sample override has to
change to an array assignment, so that the whole variable is overwritten,
not just individual keys, which could leave the value of some keys
unchanged. Do the same in lib.sh for any cut'n'pasters out there.

The config file is then given a sort of carte blanche to redefine whatever
variables it sees fit from the libraries. This is described in a comment in
the file. Only a handful of variables are left behind, to illustrate the
customization.

The fact that the variables are now missing from forwarding.config.sample,
and therefore would miss from forwarding.config derived from that file as
well, should not change anything. This is just the sample file. Users that
keep their own forwarding.config would retain it as before.

The only observable change is introduction of TC_FLAG to lib.sh, because
now the filters would not be attempted to install to HW datapath. For veth
pairs this does not change anything. For HW deployments, users presumably
have forwarding.config with this value overridden.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 .../net/forwarding/forwarding.config.sample   | 53 ++++----------
 tools/testing/selftests/net/forwarding/lib.sh | 69 ++++++++++++++++---
 2 files changed, 74 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/forwarding.config.sample b/tools/testing/selftests/net/forwarding/forwarding.config.sample
index 1fc4f0242fc5..f1ca95e79a65 100644
--- a/tools/testing/selftests/net/forwarding/forwarding.config.sample
+++ b/tools/testing/selftests/net/forwarding/forwarding.config.sample
@@ -3,51 +3,28 @@
 
 ##############################################################################
 # Topology description. p1 looped back to p2, p3 to p4 and so on.
-declare -A NETIFS
 
-NETIFS[p1]=veth0
-NETIFS[p2]=veth1
-NETIFS[p3]=veth2
-NETIFS[p4]=veth3
-NETIFS[p5]=veth4
-NETIFS[p6]=veth5
-NETIFS[p7]=veth6
-NETIFS[p8]=veth7
-NETIFS[p9]=veth8
-NETIFS[p10]=veth9
+NETIFS=(
+	[p1]=veth0
+	[p2]=veth1
+	[p3]=veth2
+	[p4]=veth3
+	[p5]=veth4
+	[p6]=veth5
+	[p7]=veth6
+	[p8]=veth7
+	[p9]=veth8
+	[p10]=veth9
+)
 
 # Port that does not have a cable connected.
 NETIF_NO_CABLE=eth8
 
 ##############################################################################
-# Defines
+# In addition to the topology-related variables, it is also possible to override
+# in this file other variables that net/lib.sh, net/forwarding/lib.sh or other
+# libraries or selftests use. E.g.:
 
-# IPv4 ping utility name
-PING=ping
-# IPv6 ping utility name. Some distributions use 'ping' for IPv6.
 PING6=ping6
-# Packet generator. Some distributions use 'mz'.
 MZ=mausezahn
-# mausezahn delay between transmissions in microseconds.
-MZ_DELAY=0
-# Time to wait after interfaces participating in the test are all UP
 WAIT_TIME=5
-# Whether to pause on failure or not.
-PAUSE_ON_FAIL=no
-# Whether to pause on cleanup or not.
-PAUSE_ON_CLEANUP=no
-# Type of network interface to create
-NETIF_TYPE=veth
-# Whether to create virtual interfaces (veth) or not
-NETIF_CREATE=yes
-# Timeout (in seconds) before ping exits regardless of how many packets have
-# been sent or received
-PING_TIMEOUT=5
-# Minimum ageing_time (in centiseconds) supported by hardware
-LOW_AGEING_TIME=1000
-# Flag for tc match, supposed to be skip_sw/skip_hw which means do not process
-# filter by software/hardware
-TC_FLAG=skip_hw
-# IPv6 traceroute utility name.
-TROUTE6=traceroute6
-
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index ee48c4603ff0..dbd4348f85b8 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1,34 +1,83 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+##############################################################################
+# Topology description. p1 looped back to p2, p3 to p4 and so on.
+
+declare -A NETIFS=(
+    [p1]=veth0
+    [p2]=veth1
+    [p3]=veth2
+    [p4]=veth3
+    [p5]=veth4
+    [p6]=veth5
+    [p7]=veth6
+    [p8]=veth7
+    [p9]=veth8
+    [p10]=veth9
+)
+
+# Port that does not have a cable connected.
+: "${NETIF_NO_CABLE:=eth8}"
+
 ##############################################################################
 # Defines
 
-# Can be overridden by the configuration file.
+# Networking utilities.
 : "${PING:=ping}"
-: "${PING6:=ping6}"
-: "${MZ:=mausezahn}"
-: "${MZ_DELAY:=0}"
+: "${PING6:=ping6}"	# Some distros just use ping.
 : "${ARPING:=arping}"
+: "${TROUTE6:=traceroute6}"
+
+# Packet generator.
+: "${MZ:=mausezahn}"	# Some distributions use 'mz'.
+: "${MZ_DELAY:=0}"
+
+# Host configuration tools.
 : "${TEAMD:=teamd}"
+: "${MCD:=smcrouted}"
+: "${MC_CLI:=smcroutectl}"
+
+# Constants for netdevice bring-up:
+# Default time in seconds to wait for an interface to come up before giving up
+# and bailing out. Used during initial setup.
+: "${INTERFACE_TIMEOUT:=600}"
+# Like INTERFACE_TIMEOUT, but default for ad-hoc waiting in testing scripts.
+: "${WAIT_TIMEOUT:=20}"
+# Time to wait after interfaces participating in the test are all UP.
 : "${WAIT_TIME:=5}"
+
+# Whether to pause on, respectively, after a failure and before cleanup.
 : "${PAUSE_ON_FAIL:=no}"
 : "${PAUSE_ON_CLEANUP:=no}"
-: "${NETIF_TYPE:=veth}"
+
+# Whether to create virtual interfaces, and what netdevice type they should be.
 : "${NETIF_CREATE:=yes}"
-: "${MCD:=smcrouted}"
-: "${MC_CLI:=smcroutectl}"
+: "${NETIF_TYPE:=veth}"
+
+# Constants for ping tests:
+# How many packets should be sent.
 : "${PING_COUNT:=10}"
+# Timeout (in seconds) before ping exits regardless of how many packets have
+# been sent or received
 : "${PING_TIMEOUT:=5}"
-: "${WAIT_TIMEOUT:=20}"
-: "${INTERFACE_TIMEOUT:=600}"
+
+# Minimum ageing_time (in centiseconds) supported by hardware
 : "${LOW_AGEING_TIME:=1000}"
+
+# Whether to check for availability of certain tools.
 : "${REQUIRE_JQ:=yes}"
 : "${REQUIRE_MZ:=yes}"
 : "${REQUIRE_MTOOLS:=no}"
+
+# Whether to override MAC addresses on interfaces participating in the test.
 : "${STABLE_MAC_ADDRS:=no}"
+
+# Flags for tcpdump
 : "${TCPDUMP_EXTRA_FLAGS:=}"
-: "${TROUTE6:=traceroute6}"
+
+# Flags for TC filters.
+: "${TC_FLAG:=skip_hw}"
 
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-- 
2.43.0


