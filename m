Return-Path: <linux-kselftest+bounces-6553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F188AD18
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570F21C217D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97F412FF8E;
	Mon, 25 Mar 2024 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cz3iYo8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777484D24
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387938; cv=fail; b=YsTPV3/qgS5um62qflAUMga0FOSGu04b28FIptPb9Mp4PTwMVikVJl+pAwU4Wp6KXfKpF7mf1lQroJKlt5UPqSDKRoYiQHklZkyhZVK4kY3wPsFCBg28NebHEdoQSRPqHqnM0NhbGmRR5dq+UEEWGXjy0ej8dTz6Fzmyf/MliUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387938; c=relaxed/simple;
	bh=MBA2hpBgvNQmNQpzkpoNc5+OqEhoV5yBrt3Q7d7oCBY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aumaZ45hlS45nUsS+2ovVdGb4uDl43oBfv8RUhMCNheFE3HTcResDk5eUHAOlg7Azjb1VKdXB226ChcIX/eyK7KflKfyqLcfyBk0xt6gMyE/hl5ZVC9iwhegoJUh9LUD54ajDEcZ9tIBfGV6f3p1YdDGkqr+Xwp4zbFusF6R8A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cz3iYo8y; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iirHkUvHmVeyO/F5KJGvGBEhMDPxgztVc9axlVgBm3xuuhYquD0/V87tN/TvFmHubWs2KfX2dTZvmO1k6N+oGFiBVXN0eOLpylvMrpvjb5fpRyLM01UMSEIuuLs2oNUGz1AwQMv6dc3Fwo6DjD4C7sW7SrN/nX1aSDrUX04PY181N71Tnb8z5/D5xN4o6tt+cxLxZ6xFLSu2dJ+y3PLYiOLWUftquvEk7l5dESZXNQv8EOg3Yw87v+KRzEwIvah24nJZ9QNQfYPemgF4Tr+lHv1Yf+tktjSLEjgex4DcJD6L2+Tsoz4p6MWPNeAwZFtKVBgfUCfHnoy63xvSWEqSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCT5Dv4ZDmUW09EVxHsRb1DmTlt4TKadWd8UgL8H8W4=;
 b=mFBXnTM7p+8UqbVOi8QBD39BuFDFNk9X7kbKvqdLN8GlQomiigkwORwrCCGjk4677f41bmNk3OSDx0OvsNDlOGBSw7OU6uOUtXFxuDQ76y+PV2yk5OcTXPiI6B2LW8+/uF6nzMoBenP28rP9fxE/L0tjAnmUMqb7l2QQM4qm7cqmh17TGWWCecfwkYJBcOTgkqVlSWKGir87I63n5ofPqPzRCFzu3w/l7GCH6XeGi4gnOrTQBx8wsS57vVgLXxpjwpRCnzre0dsjrsXuT+DrMaq92Z5dVVapKUy5Ujmw65nOfum0vAl0Pmpn404BBmwIQsuHfO9GCD3Bv+Lj4YabmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCT5Dv4ZDmUW09EVxHsRb1DmTlt4TKadWd8UgL8H8W4=;
 b=cz3iYo8y0/FssqiKRJj3XKJDAUxP5FbkCkRtYl3HzR19PX6nZfHp0q/jP7tqSQpd+N60mpTUi5BlgwuL19MJ08wZs1pQgwchDfMtL34KpdKiiyatSSTDe9BXyvfSmB3Ho3pK6yzxRHPpYpLWXquzLagRFZPPdIWzRw1UMOOGJt1E76cL1egvwUq8H1529KNYiOtY3iBT/M2wUqHtb3t4JRUnNDh6Wl1mD+Cy2BrVc6HXAYkaJ28QZCJ1LxRkoZr/pg3NbM/hSXTunh+fW5bKRaNRZj53oUrr1/ybskh7Wh3wkrlsWYCKAYTjssEbqJRuVbcjJkR45qLmkg423YVPjA==
Received: from SN7PR04CA0101.namprd04.prod.outlook.com (2603:10b6:806:122::16)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 17:32:12 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::be) by SN7PR04CA0101.outlook.office365.com
 (2603:10b6:806:122::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Mon, 25 Mar 2024 17:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:32:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:31:54 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:31:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 00/14] selftests: Fixes for kernel CI
Date: Mon, 25 Mar 2024 18:29:07 +0100
Message-ID: <cover.1711385795.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6184b7eb-b791-467c-c39f-08dc4cf18114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q8KhQYd9Tyk6/baSAk1vUUKAwFvX6eMHH/5ahp9d0+pYAX2p8j1e1AJGONvnZlwiXoAfB/tCsxmuIxv8tcBfXLZ0oiflutIqQkfvStmaEzSUHRxYOqIeffTMUNmEVCG3Ltq0mEKHCfWOxeNwDiAlVXi0chfT3uPabOoM5Lx0DqKLAPcN/axIhu7+BnjYBxE3cCztGi7o8PsQXeMhRU7HCqoKBOtmcnuWFXhnmvDCYemVvznh2oF6ksFJb16grsFF+EuFtAU23v7ahgMKiPltT/xLDq8xaKKMBOYejfkMDJScOaqS2QqVXPrN1r66Y5I49t/+1+pdZaK//kfWfeG+cjr36+WT7eqk1Y/s9f6jiNk7VofbKzoqmbN/vMg0fZZpZBLfb9XFmY7QFCWVZU35kmV735QTlk1OBKVDp+JymAICHXpsEDl7EfAi7QmU9MpyV2b4ZcxQ7uHFvPIgIDk8rp6gtPnkRP7sdyWjPevhfY+jV/5mEc/TXDqsgrY1oRTqlQndGnRTdH6E3zMKvjiZ//HS0G6mnx0G+XRMvQn31eCoiBLU0QTEtrS1Tcd4ssl976vyQ2Hw+HLm0zET/k2Q9cD5LNMPGGNC2XS8vGMZHjnVPCJK9K72uMMlWFSFOALihOQyrn8GVXbGme3ST8RP2vHZHcT64spNCxv9cj9lunKCcb+BT2+fmsd/6oEEbL85H83mDvfiTsp/h/8GAs/kgkDJ1CEKctrZOUzqKzr61kgyN0oKC+RAA7LFEBXZFOKG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:32:11.4812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6184b7eb-b791-467c-c39f-08dc4cf18114
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327

As discussed on the bi-weekly call on Jan 30, and in mailing around
kernel CI effort, some changes are desirable in the suite of forwarding
selftests the better to work with the CI tooling. Namely:

- The forwarding selftests use a configuration file where names of
  interfaces are defined and various variables can be overridden. There
  is also forwarding.config.sample that users can use as a template to
  refer to when creating the config file. What happens a fair bit is
  that users either do not know about this at all, or simply forget, and
  are confused by cryptic failures about interfaces that cannot be
  created.

  In patches #1 - #3 have lib.sh just be the single source of truth with
  regards to which variables exist. That includes the topology variables
  which were previously only in the sample file, and any "tweak
  variables", such as what tools to use, sleep times, etc.

  forwarding.config.sample then becomes just a placeholder with a couple
  examples. Unless specific HW should be exercised, or specific tools
  used, the defaults are usually just fine.

- Several net/forwarding/ selftests (and one net/ one) cannot be run on
  veth pairs, they need an actual HW interface to run on. They are
  generic in the sense that any capable HW should pass them, which is
  why they have been put to net/forwarding/ as opposed to drivers/net/,
  but they do not generalize to veth. The fact that these tests are in
  net/forwarding/, but still complaining when run, is confusing.

  In patches #4 - #6 move these tests to a new directory
  drivers/net/hw.

- The following patches extend the codebase to handle well test results
  other than pass and fail.

  Patch #7 is preparatory. It converts several log_test_skip to XFAIL,
  so that tests do not spuriously end up returning non-0 when they
  are not supposed to.

  In patches #8 - #10, introduce some missing ksft constants, then support
  having those constants in RET, and then finally in EXIT_STATUS.

- The traffic scheduler tests generate a large amount of network traffic
  to test the behavior of the scheduler. This demands a relatively
  high-performance computer. On slow machines, such as with a debugging
  kernel, the test would spuriously fail.

  It can still be useful to "go through the motions" though, to possibly
  catch bugs in setup of the scheduler graph and passing packets around.
  Thus we still want to run the tests, just with lowered demands.

  To that end, in patches #11 - #12, introduce an environment variable
  KSFT_MACHINE_SLOW, with obvious meaning. Tests can then make checks
  more lenient, such as mark failures as XFAIL. A helper, xfail_on_slow,
  is provided to mark performance-sensitive parts of the selftest.

- In patch #13, use a similar mechanism to mark a NH group stats
  selftest to XFAIL HW stats tests when run on VETH pairs.

- All these changes complicate the hitherto straightforward logging and
  checking logic, so in patch #14, add a selftest that checks this
  functionality in lib.sh.

Petr Machata (14):
  selftests: net: libs: Change variable fallback syntax
  selftests: forwarding.config.sample: Move overrides to lib.sh
  selftests: forwarding: README: Document customization
  selftests: forwarding: ipip_lib: Do not import lib.sh
  selftests: forwarding: Move several selftests
  selftests: forwarding: Ditch skip_on_veth()
  selftests: forwarding: Change inappropriate log_test_skip() calls
  selftests: lib: Define more kselftest exit codes
  selftests: forwarding: Have RET track kselftest framework constants
  selftests: forwarding: Convert log_test() to recognize RET values
  selftests: forwarding: Support for performance sensitive tests
  selftests: forwarding: Mark performance-sensitive tests
  selftests: forwarding: router_mpath_nh_lib: Don't skip, xfail on veth
  selftests: forwarding: Add a test for testing lib.sh functionality

 .../testing/selftests/drivers/net/hw/Makefile |  25 ++
 .../net/hw}/devlink_port_split.py             |   0
 .../forwarding => drivers/net/hw}/ethtool.sh  |   5 +-
 .../net/hw}/ethtool_extended_state.sh         |   5 +-
 .../net/hw}/ethtool_lib.sh                    |   0
 .../net/hw}/ethtool_mm.sh                     |   3 +-
 .../net/hw}/ethtool_rmon.sh                   |   7 +-
 .../net/hw}/hw_stats_l3.sh                    |  19 +-
 .../net/hw}/hw_stats_l3_gre.sh                |   7 +-
 .../forwarding => drivers/net/hw}/loopback.sh |   5 +-
 .../testing/selftests/drivers/net/hw/settings |   1 +
 .../selftests/drivers/net/mlxsw/mlxsw_lib.sh  |   2 +-
 .../net/mlxsw/spectrum-2/resource_scale.sh    |   1 -
 .../net/mlxsw/spectrum/resource_scale.sh      |   1 -
 tools/testing/selftests/net/Makefile          |   1 -
 .../testing/selftests/net/forwarding/Makefile |   9 +-
 tools/testing/selftests/net/forwarding/README |  33 +++
 .../net/forwarding/forwarding.config.sample   |  53 ++--
 .../selftests/net/forwarding/ipip_lib.sh      |   1 -
 tools/testing/selftests/net/forwarding/lib.sh | 255 +++++++++++++-----
 .../selftests/net/forwarding/lib_sh_test.sh   | 208 ++++++++++++++
 .../net/forwarding/router_mpath_nh_lib.sh     |  12 +-
 .../selftests/net/forwarding/sch_ets_tests.sh |  19 +-
 .../selftests/net/forwarding/sch_red.sh       |  10 +-
 .../selftests/net/forwarding/sch_tbf_core.sh  |   2 +-
 .../selftests/net/forwarding/tc_common.sh     |   2 +-
 .../selftests/net/forwarding/tc_tunnel_key.sh |   2 -
 tools/testing/selftests/net/lib.sh            |  48 +++-
 28 files changed, 565 insertions(+), 171 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/Makefile
 rename tools/testing/selftests/{net => drivers/net/hw}/devlink_port_split.py (100%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool.sh (98%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_extended_state.sh (96%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_lib.sh (100%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_mm.sh (99%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_rmon.sh (92%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/hw_stats_l3.sh (96%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/hw_stats_l3_gre.sh (92%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/loopback.sh (92%)
 create mode 100644 tools/testing/selftests/drivers/net/hw/settings
 create mode 100755 tools/testing/selftests/net/forwarding/lib_sh_test.sh

-- 
2.43.0


