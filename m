Return-Path: <linux-kselftest+bounces-6554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F87588AD19
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987C72E7DE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFEF5476B;
	Mon, 25 Mar 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHeHiTK5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E112FF71
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387942; cv=fail; b=Uk6X4qyaUNuxd93P2eAvHmApcxp3UuHl92HH19lHlxyjwKPOIwC08AwYG48B6gaNStgNKYrprGdlfw35A1ZWtnV8h+EFhc8TfpvAKTNmRKfuAJKTB5kwzROROtmCffTwAPls2l/MRFGPEYA9UKPzs9JZMqEJXIfJgk+MKHEd43c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387942; c=relaxed/simple;
	bh=8v9FNUijUG7xwsUH31jckIZPoH1RDSaL9/RZEHgFc58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4ah+YFIPsTGZkNE45dbeXWd0zq0P25B/KUN/5MD+q4YtIs/fgBvNSg+HlyWN7oAPC8gvzeiouuM0h1+t0s3j0a8Ql0pXPnxMtKCDqyVMMghhtLEttsK/ZW+QgPR4Vl/L3VrKcXvPDS44j+mJllHrLN5uJaymFyKfLzbJVZz4sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHeHiTK5; arc=fail smtp.client-ip=40.107.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYo+52WdkKfdjU2C5dcaNyQzraGkBP+zftsdvd/nYzhM8NAjG5bLciujUkSpmApUUPEcZFGz9bPvHMuWnow4hXT7magy05iQu5RT99huRI/eBEe7H83ZQaprhB8rJgmFTwoTQb7h2dmnDMPI9aK8uFRHm6fqLy76muS3EtoaGDnR1GaOKCq9hGHFoAq6KoxUZpiEQG14J98cRdPL5DFdHELQWD/FBjp6VqIdJifLl1ryqUEIJJvI4Qev2SsX31idESdjaq3IDHFcJzBOTaT0CWJHA1CVZfWPoJzREloeBDxZY1kHo18vwdnfYIt0nFBCLYrk9rBGD4JYvUBgGY4Dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oevsx6VRQR1iRkez0iT6MBubXdmcpIs/siOpkqu1w+c=;
 b=XBMxXz1OYCoZI/oPPK3ji/4P8ZZ5mi26swdC6MBfeGXBlwSmvGXHFqkaG7meyy6Vw+n0Ce14MZew6Nao/agBfpXRWysIiS/hZhWB8bdYuZrWowJj+EOQkWPTNaXuVYSaU/lAObpYuIVclIwCoAtcp6vawizkfsQFD6q+yeK+y0ExwpsWW5xh0g+4H43/bP3Xxq1Lpw4DsKt0QdFN7gesoG9qiLUZkujlhwAEDD03G/pECl8NchH5pf809UJ59wamq9ze4SPk0IWPc2xpbekzd0mLF+KWbOwzZ9PgGPvEsozOMmZ34N6t3yNbGjvLRpY3fCCVV6KACDsdfV67P8PDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oevsx6VRQR1iRkez0iT6MBubXdmcpIs/siOpkqu1w+c=;
 b=fHeHiTK5yK1eqWLP+JLSMNs9O5j5EHrRQmFaa24QfzQNnXUYVZ4EEx/6erqWZi2dzXSEHtnpEAS/D7h5//FBZCpEgoJxJ0DNRzkW+Yprd4sDVfxdpGM/vMFQbtiyz7meM6we9x/PbSSEsXz/BaxrXlUBw0owgKwPeX1VeTbYzhCbblbxyZbU9VBDB1Wh6gnAPdKxG/eeKoM7ByUKoZ11US6OTe7y94kAGW+jV10ka2cmlTMxajXfpawDADR/FsdzJUXq+CLPNriO7bHPGR74boMn36AIF0D3fzEhG3BnSg7/Vm5Ks3tpq5bnh9KCj3qlNWWKsipVLPEIoUdiPLbMKA==
Received: from BYAPR21CA0014.namprd21.prod.outlook.com (2603:10b6:a03:114::24)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 17:32:17 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::b5) by BYAPR21CA0014.outlook.office365.com
 (2603:10b6:a03:114::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.10 via Frontend
 Transport; Mon, 25 Mar 2024 17:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:32:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:00 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:31:54 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 01/14] selftests: net: libs: Change variable fallback syntax
Date: Mon, 25 Mar 2024 18:29:08 +0100
Message-ID: <1890ddc58420c2c0d5ba3154c87ecc6d9faf6947.1711385795.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a858cb-04a3-4ec1-3165-08dc4cf183ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JBci0XxTJXY8PET0g+9s5Dn4+C0FgQBc3BTgAItHnt3VUmMdo837A/oD/v0PXte3ZlGTVMnKIxi1RXiBMrFI7PlIM8/mv+6t6KaOTByXT5cf+8uFolrEObWqcFTsLBfLjU+mDtNjeRzob2fyfewQg6VbxlYK0furCpGW9BT2M2UO7wRhaitQUNUmsi+uHrOC2wlMEgEvJGZbxNVkmeoxfLy47FeiNbSIKixXZLyA0U+n6uwK+RUkxrAQKsIQR2S4hB14wcZE2BvWDEgloMFW7x5Lm0NVHzcLav2UizieQUbpX3mjIub4FRXmou4yjSE3cemPRtUHv3oY11CK8kLNk/ivuqEw0L2ekw72Q9Fjbe1iCAYtrdU2DXmUrLF00zDnwtw4lemrsnGr7xNlHUxVYKG82xaPWDGQpL7efX5bAaAGWLbwUboa/PdQuV9YNVkxtaGl5jwA8udXkWlOMBc23uubBK64N2NBMeNCFrKVaGIzwbraLTot202+9soofEdRdcn78XmZ3hHOcl2dDuMqK3yBe0PWw4e4e7+4J8fwplOWfKMNxwA/50B/osH6RJETEPR/Jj33EBlSnoEZjlaJenOqzq7N0LICENYIncmy1eCHZIiQKqG5rSBs2wOY+45krDYREGLluHt3baqiFsHjBDcO7IrAUX6SdbuV9yonjh4vnBflBz+JNNI7WhUQ0+RZSRKIA4ZWwFykiAtA7HB18N26fMzvUSgNNIqi98ntk+Z99rU18RL07+dgBpCoh/+Y
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:32:16.2354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a858cb-04a3-4ec1-3165-08dc4cf183ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280

The current syntax of X=${X:=X} first evaluates the ${X:=Y} expression,
which either uses the existing value of $X if there is one, or uses the
value of "Y" as a fallback, and assigns it to X. The expression is then
replaced with the now-current value of $X. Assigning that value to X once
more is meaningless.

So avoid the outer X=... bit, and instead express the same idea though the
do-nothing ":" built-in as : "${X:=Y}". This also cleans up the block
nicely and makes it more readable.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 48 +++++++++----------
 .../selftests/net/forwarding/tc_common.sh     |  2 +-
 tools/testing/selftests/net/lib.sh            |  3 +-
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index e579c2e0c462..ee48c4603ff0 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -5,30 +5,30 @@
 # Defines
 
 # Can be overridden by the configuration file.
-PING=${PING:=ping}
-PING6=${PING6:=ping6}
-MZ=${MZ:=mausezahn}
-MZ_DELAY=${MZ_DELAY:=0}
-ARPING=${ARPING:=arping}
-TEAMD=${TEAMD:=teamd}
-WAIT_TIME=${WAIT_TIME:=5}
-PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
-PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
-NETIF_TYPE=${NETIF_TYPE:=veth}
-NETIF_CREATE=${NETIF_CREATE:=yes}
-MCD=${MCD:=smcrouted}
-MC_CLI=${MC_CLI:=smcroutectl}
-PING_COUNT=${PING_COUNT:=10}
-PING_TIMEOUT=${PING_TIMEOUT:=5}
-WAIT_TIMEOUT=${WAIT_TIMEOUT:=20}
-INTERFACE_TIMEOUT=${INTERFACE_TIMEOUT:=600}
-LOW_AGEING_TIME=${LOW_AGEING_TIME:=1000}
-REQUIRE_JQ=${REQUIRE_JQ:=yes}
-REQUIRE_MZ=${REQUIRE_MZ:=yes}
-REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
-STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
-TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
-TROUTE6=${TROUTE6:=traceroute6}
+: "${PING:=ping}"
+: "${PING6:=ping6}"
+: "${MZ:=mausezahn}"
+: "${MZ_DELAY:=0}"
+: "${ARPING:=arping}"
+: "${TEAMD:=teamd}"
+: "${WAIT_TIME:=5}"
+: "${PAUSE_ON_FAIL:=no}"
+: "${PAUSE_ON_CLEANUP:=no}"
+: "${NETIF_TYPE:=veth}"
+: "${NETIF_CREATE:=yes}"
+: "${MCD:=smcrouted}"
+: "${MC_CLI:=smcroutectl}"
+: "${PING_COUNT:=10}"
+: "${PING_TIMEOUT:=5}"
+: "${WAIT_TIMEOUT:=20}"
+: "${INTERFACE_TIMEOUT:=600}"
+: "${LOW_AGEING_TIME:=1000}"
+: "${REQUIRE_JQ:=yes}"
+: "${REQUIRE_MZ:=yes}"
+: "${REQUIRE_MTOOLS:=no}"
+: "${STABLE_MAC_ADDRS:=no}"
+: "${TCPDUMP_EXTRA_FLAGS:=}"
+: "${TROUTE6:=traceroute6}"
 
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
diff --git a/tools/testing/selftests/net/forwarding/tc_common.sh b/tools/testing/selftests/net/forwarding/tc_common.sh
index bce8bb8d2b6f..2e3326edfa9a 100644
--- a/tools/testing/selftests/net/forwarding/tc_common.sh
+++ b/tools/testing/selftests/net/forwarding/tc_common.sh
@@ -4,7 +4,7 @@
 CHECK_TC="yes"
 
 # Can be overridden by the configuration file. See lib.sh
-TC_HIT_TIMEOUT=${TC_HIT_TIMEOUT:=1000} # ms
+: "${TC_HIT_TIMEOUT:=1000}" # ms
 
 tc_check_packets()
 {
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index f9fe182dfbd4..5b366cc4fc43 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -4,7 +4,8 @@
 ##############################################################################
 # Defines
 
-WAIT_TIMEOUT=${WAIT_TIMEOUT:=20}
+: "${WAIT_TIMEOUT:=20}"
+
 BUSYWAIT_TIMEOUT=$((WAIT_TIMEOUT * 1000)) # ms
 
 # Kselftest framework requirement - SKIP code is 4.
-- 
2.43.0


