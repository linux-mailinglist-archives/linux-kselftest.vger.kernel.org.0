Return-Path: <linux-kselftest+bounces-6555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2593F88B38F
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 23:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F65B38027
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE00912FF94;
	Mon, 25 Mar 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hCs1ch8D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362812FF71
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387950; cv=fail; b=HwmaW18oQi8knAGNNQ1UAgRiqCkxOAQRzBTUj1J7gAAJG4wKq2PWQoPdQmbtkM/hzyQtLBxrZgEpL6Fncm/7MPgOuEvsUjAYMpiBbKbYm7WGTfD6cgjGeA+XZEJtiothK+iUMJ0CEk1LN9+PsWZz3232MxxVsoFIJhMTDTfSOKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387950; c=relaxed/simple;
	bh=mTPwOqJNG2Ubgo1VbL8KBG94pbeO7Ct69PxV4ztwl3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbDzAfJOiym55HqVCs1lEImIdwV2jc9NuvHCdujfp2TNkT0DAIqCECJ4uEXKaJUkK15gfzGoAPZejyYA+OdtMfxbXmaCuTsWjRCMIFOxHBl3vyRMtYQKGqll4BI86i+rd3EN6w+022BErR2rZtk5nMB2UGVgKUR7cVePL/BEETY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hCs1ch8D; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7Lxq68ZFXXjVBgVEkSvIVEIOsU/FDtJToOz2GlCRErnDldgfS7NPcFJQyvgZ1zXCp9u2yGd1TH8x9iKvWjW0nQk9XmJkWYLDbP+LkFm/6cwmLTDsAVZls8KwTMCFQ06sbqPR+OeyTXTN/7aV2ovFSFODLvJbnRjcoR3nqiI5mrch6BK3kZSWPpdX1wBxvZ3nSXJgo6g9vmb/wV/+ETpQaHU7gzLmyOQgGpMHsSDtyYDzVzMuQugdoZYZUYsOLcDVeM5ojllQ1UiuOK9LoDZbD35NlZ8iDaEhukCi91ks0d0JFqOyFCz5y6R+OaUUXOCL+sN8yRB1ROAJhApd4jHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2xhSPmedJ8u8jI4x4AuYT4tsV3hpK7epS01tm6pQDc=;
 b=F+aW75zWwxW0G5GI3jT+fPfaRxhR1gUPvuqrR8+uzWJB/emC7sCK3bzy96N7qzjVtRKi7s+NUh2qtuhC+SDz+RgsCE00chjxZAs5IeLAx9hAnyJ8AUS0owfLfhqzPozEFN67+n/pqMk7QcZrbpcZjDQ+3b/xEO1I2dXGS0bClR2kGCHarZaBX5AaEoJmDLu92DmiSaxQdmE6ltH0FK3SU0ZM0/E3t2YXBkInTMNd3DOUZxxWlljOLJReSKUL5Jl7zfOQp7TqKatf4QVnu7jjwKI0NE/cZWUVmfjoBOsVcliXy+jtGZaUGEvfhiOIo7i+GVbK4+PtUdH/oArTkJ2k4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2xhSPmedJ8u8jI4x4AuYT4tsV3hpK7epS01tm6pQDc=;
 b=hCs1ch8DVt1TnJEam0l6ARlH6ATeFPTskUFt1oRwFt6DPylzTjo6e5iPzWziDwZOiDzMpDxT65UiCn5OO2TZYyoJqmEGA2CDt5ou8Z6xSVnjNnWjGr393Sw+4jUvtjxycjrZ1maUwSfXHQYWrjgNMMrq8d4m5P4MzFdo7kA+30kGJfinc69pX/Q2uh8MPmecl+RlNXRuWGY/aP9g+J4OF07N1DLST2cBlGicDgCmebEs9uPfzEucEn4N5istMtoKBaGZuMN/UAiqGwbYvMC7TI8lUlakZMlYenKymnqGBHBI5pJ4Xu5+swYs/Oil30QRJ5I2sIkGHdTVs2ZG9TOXgQ==
Received: from BYAPR21CA0025.namprd21.prod.outlook.com (2603:10b6:a03:114::35)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 17:32:26 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::e9) by BYAPR21CA0025.outlook.office365.com
 (2603:10b6:a03:114::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10 via Frontend
 Transport; Mon, 25 Mar 2024 17:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:32:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:05 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:31:59 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 02/14] selftests: forwarding.config.sample: Move overrides to lib.sh
Date: Mon, 25 Mar 2024 18:29:09 +0100
Message-ID: <b9b8a11a22821a7aa532211ff461a34f596e26bf.1711385795.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711385795.git.petrm@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: c5818c46-c698-4f06-a15e-08dc4cf189ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BsEkWBvxwCI72d0jFdoRIZMfgBOwTM7f5Et7c4dU29TppNyJp3Rw7+encGAu11aYvVayvSv4h6DC+RfiTa8z6+FmG3tyhE6lmYPzc/jC3XdzOc8S98TJIhKeK/4h3iaeJJibXWoWrAwqEsxBjKZ9HQl06JP/vkeqouWcDRKQCNr/sUaN1rxeiC3nUBXxddkcCmD23cOOrMalDIyX7XykKIicntarbvoRuWSgtZhSMq/KP0PIFBcG8qdJyqeLZtdNjm/YvCeBGQl3UjlaEp7fJNrSGgLMlvbDUdarFffnrY0wfiuGBR5ZFZg6vThkw4J9Org4RIBsB/2bhvXKI1seZRPnYF6LoCb4pMdWTgOAaKyFj9u41696Dg4t9f7HYehm3pBgnleQFyJwy0MTqn/PBe4M9LI/dsDHJ+IzIH7sYeswFk5j9AqjbZVH66WJRBd8fo5q0bJhtjhW2nNX86ihOhRfVu0EQTvZexUrI2SmD3eFCvM6TMKpCzWibkdNg8Bt6h2Our2Nm8Rdj7NMULG0X7QjWYWdMr68sz6lA4kNya3tCxVYWV5US0xZ9pIU2qDYTq3vlwP0rcBrC8IZUPTt0pLuHVTZ4nvawJL5g7WeMXI7FBKQ90LNsWVs6BjeLQLr+/FxbMSzgfCnY0TlKM0GjsOqDnFABan1U0z4jvzpIDY3Ai4nuJykQI/yQttRqA5ACqPPs1SbGScubVJuIWdAnHAflI+XVzG1Yl9/ob+2bTWRIEtZSf9Ls7xLX6KuQ2kE
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:32:25.9073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5818c46-c698-4f06-a15e-08dc4cf189ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158

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


