Return-Path: <linux-kselftest+bounces-6638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F22D988C9EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1931C63680
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3127B13D2BF;
	Tue, 26 Mar 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aovy57vq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375413CC45;
	Tue, 26 Mar 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472421; cv=fail; b=PQot79ePwjxuPb86QjyKKBgGNT7uiVf97nBOyC5i8q75EgrytotJNuQDhdtw4An8wOibHZCNEShgDXCEr3n/9L+pQam2uS/YevAvS2dL8xxDO2ai+EcdIZXL7eNKmM5Xy6zQAyJUS7IUEeeiUPp3z+GjXVCwVMb01XFC6Ls5JYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472421; c=relaxed/simple;
	bh=DySJ6Edk7iujm9Lie52WbYyT5clS5bT2Y6nzp3I+Sw4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRIrxr9Y9dhppkSU4IfWa/oeTLewKxWV/f6ReXjBh5nRMKY/edwBxgBZwJ3Tlwdiyw6KtG1ESOnVK2gDjCqQ1Luwk/izZo+8IA8L1MVPnYHeT23fulndXb1v9O7ICm7zY5EwzKJZkouJ7Jhp/r5Q9pXDd0lohkffCLQ9p81FW6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aovy57vq; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfU+I5isqPwyQyER9yliHetY2JTdhfZ/ECMHuLHZ7Bvm1kyMI9sg2xu2DLL0MB9zZc+SnDjh1ZxcX/tfntMWcS/P1GGY1hyq8YRjcRPTOdVpNZVPfq0Nt9stW4JlCwvd56W4SBfMWxd3+U3+7SUNMW455FYNkm46kaRKkYJmHhlLNDS4X85YuVwdBLEQ61Ev9EhDTjZLLfW+RVXQIqGudL1hTyO/hQAjAIPoiJPyCBBoF2OH3A10dfnql89ANwVnpqv2T1gjMV9RghQcILMSqV6T6kB6x01UFVt4dIoiDZgZ8OXr3Gv8UFdMlPAJH/WUPP0VvMjc5OSxsCBAoKnYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iehVLWae0CZTFySjJUhoDWJ5I/9dD9Z++6kXSjhp7zA=;
 b=WeQY3iSqway2ErZ26luj3uVGMKG0GlZ33v9+YXnoTPimxYsW3Gxo2kltDDPJJ4DAdvbv+uM4fkMbkgSnvw1MORrDJGFnhRe3iEgDhYHOEvkfmXWHf66qSQENQOP7F5xtk52+/oxceX6x1twmwaz0YdQ6PpxzIUp9Z4Q+pHMrD3QSnUxbAKOaJ5q5MMFZcZMlDF1smPZMOKW+71ImV+/AB6QgZ/vUhUxuE4UYLN1PqfwLcw0JWEP0GNVy6wKtuSPfOiz1e9IXWgD3viGG//Ue2CrDNY+3jlghQvei3phHZ/A0HZeZwOd2ehh3IvXEeroEIbdZUx8mXuWBOYTijHzRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iehVLWae0CZTFySjJUhoDWJ5I/9dD9Z++6kXSjhp7zA=;
 b=Aovy57vqIgmU4SmyluTfd1oaoDp9Fek+zJQXoe/mfG6tUKzsX9zRXGYfBE1bzOMkiGElVGS2wcTAjHCSqO6EUgLPCS9SYYrhmmfB+DpSFjt+fvCj9iJP5gcGzlMy2/boTq7IEuuebPNFiT2oc1UaDgzxakBoJZryxDjjMNVjfsMHXlryd5bQ5qBaqyPwCwn4sOTD/YUq/PPKJJnq05T4Mlchs9lzOO/c43EzGs3w8nblMIa7m3hAYdyr5NJa5MKk74lm+OjTcWxCr7+Fr1jOtWifaydRQUiPoDY3mfl6HGKtCXT+GYo++fDhLWsj/YcSFWWpz72h0DhU00Un7B9Rvw==
Received: from BN9PR03CA0330.namprd03.prod.outlook.com (2603:10b6:408:112::35)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 17:00:14 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::84) by BN9PR03CA0330.outlook.office365.com
 (2603:10b6:408:112::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 17:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:00:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:00:03 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 09:59:56 -0700
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
Subject: [PATCH net-next 00/14] selftests: Fixes for kernel CI
Date: Tue, 26 Mar 2024 17:54:27 +0100
Message-ID: <cover.1711464583.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaf26a6-775d-4e87-48eb-08dc4db63469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u/kHsDjhiEFMTIy+tVKfKpSWqZZAXug+817ARpq9FN8SeCBghW0HswNW8xyf7ly8gxIrSgute//GQ8+yrFu2YvLlSyzuxnDgAZJoXaPG8o8DlaVLeWzxdsrWEHQ3FZKcS7Tx3FYfrl7W/IuSLLQJ3NJY9g0ytiIfszAoqZTA8k5iTFGUJYqHGuOGbhoMn6ReHqyzS6XBHcqFJxkGavLdndPbeG1EQrx5cJjAAeMn3drfQez058IgUbv2ZSy2wMII2CleSyp3SVeKioUd7dA9FwPenvHBMesrR57ebxtBdWDD+TxVQi5YU48XFqekHiERO59EcoeUpe+2qPZD+2UXYl4fdJkDRHkoAcoaD1ab6RH8P1/IMIr7YmUbvVYbRHCms4hwDI59UNEIVbYaoBIJpD6e2RCPeBU5gXNieEF1BgTnmss1iuPBPn7bqUzbHP7Gv9jOK8QIn+LMYyH+7GxAI5D2E477OH9NfI6Rp2YHXVBHnVlGHhAqND+a/ELqOB7zU18Qb/lxEY8NrVne04GDRmQq3tA8HY+w/CTQfl61E3ZKTEKk90YSRIitJDQU67m8cc1bIohTdwoAx6qNjRnPvNIQ4MEhqI4EAVO273Wthl0IjadrIctEALvDsT1CcD02KVP3+4Wk5qVLO8OjmTeETHLi3rGZG174mP+x3DSMSXyTkjikdFVzEp/2bhD6OKsiUjzWXguYd+goRV3itFdJqlgLLoHvdl5KCyV4PxTB9K7c6ZZ/P633A0vpyEvm6WlX
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:00:13.6438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaf26a6-775d-4e87-48eb-08dc4db63469
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925

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

v1 (vs. an RFC circulated through linux-kselftest):
- Patch #9:
    - Clarify intended usage by s/set_ret/ret_set_ksft_status/,
      s/nret/ksft_status/

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


