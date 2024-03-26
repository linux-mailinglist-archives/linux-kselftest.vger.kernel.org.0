Return-Path: <linux-kselftest+bounces-6652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E28088CA1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55878322581
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07B013D618;
	Tue, 26 Mar 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3FYD8jC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2217BA0;
	Tue, 26 Mar 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472532; cv=fail; b=lDeFH7HnaEUqhtIo9VFQhlRJEZKdW1qYXCzBGVLbHNoYn1tKYTg3aSdoKPCxLh5/jhgSBWxvSIuYaRR1CXAtGmelS//7VD9oqIfiXlXpljrZlMAYAwtVSnNpJ3P6oIqYpT6b8m8JnPJkc7PnbvZjJzVEyI2hv2bjXAUr+NnRIMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472532; c=relaxed/simple;
	bh=zv0E10TEsyjia4g06g9x0yDea/8AoDOWrXuHKci5zM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBxe49K6ZSxcrGdSUxp5CeW09FfHyAcAGmFJiNqEfKKGOlRKGVDbfgAAx9HXnfBabhY8CmFQ4aerQpMv6cEYXkN34iyAzwh5rCfCHfdZMGOZZsvzK+/ByCQIG5CCDceU3vwwKkE70b/p/UcE+9+ne8NA1be2VbCSZ63n5bS/T04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T3FYD8jC; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbgHPrSSykmmpNANy8S7uSP83shdt5jAeyLEqLfCIiE9fd5U9lcQIKWu1XgITMdrsTIi5R5bQDrGS/eri+zY+4pq5O68J65xYaqIOTzHZqlUvPzqXSiriNugacIGmsywE4rQscdH3ahGRYeE1Rn3QjzcR3zBYoShYmX/T/f6KC5Y/Kx6XP6EwJu+mnG+S21FJmesVgtzjHxz1AvreOT4V979s7d00XpUDkeYO31HgVeXqXodkm73UsQOTuxmXoChW/g28jnSP5VU3wV7fHRak/eVKIZv4WI9gfpePCetAinSHgTtGGYlIzsTxQZ6t39JMdgGzEkbUktkH9Lz0Bi4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJRtP0KreHhnjKzBTAkDh7Y+kc+/mjYoR2koFRvwwCY=;
 b=nYoP6zqdS7UAutXJsMc9fZTeBAsFm/uM6wfGDdCVm+QDA7ft03LT2jbe8qUMUNdAk/yLnFvPtsqurA+cFTKPAjHQJiEA9myWfaJ4O3KDrW55i7DMAfY886MwJsu9MVNR/zHtgXI5cfqkH72vjyRKWYL8jk4UBJQ3n2+lL2T1efEiSQJpHqYnmNKeeyw9PQjGtjkLVP/1ul33kjL0wqiDBHw1FmbGqKvEWXGT+0iALax1co62TJg0M2EAsNsvFXrLzqs0vF8FxwzuMTxa8KHbTxIDH6gBo//ZiVe8nLFb1vIWDXA6KZI8CVO0Mqb1M9cZkhYIbpDrEl1BKnKDwzmVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJRtP0KreHhnjKzBTAkDh7Y+kc+/mjYoR2koFRvwwCY=;
 b=T3FYD8jChHId+DbnC6qecflFp0JCo/raYc/dAQS7YI63jf6HRPuyy0Gb2zXBbRenR5C1ihOmORGybvBcT8Ji4xsEmKB3fcrbH9d8GasRq8gDI8NGv26q/FMNXA2yJRzJv143yTeNTAhXYhPt3INqC2riGTEcFfvB69GvzpBTXtjXKI7ATuwgXm4rA3yqBVHbFJlHN+VfsXyNrToXvZmy6/hvcDHJo0bHOmmGNgHfMzgRsPqYvHjjDKXAfaNBdV/hSTiB5seOnFDA6WH1YhdYH5OcEwrgi4dKn5IM2utJwktHUu1ZXCUrdQyID2SQWjTR6oJBuqVFefV68zDdvClxEQ==
Received: from CH2PR10CA0030.namprd10.prod.outlook.com (2603:10b6:610:4c::40)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 17:02:06 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::8d) by CH2PR10CA0030.outlook.office365.com
 (2603:10b6:610:4c::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Tue, 26 Mar 2024 17:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:02:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:01:33 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:01:27 -0700
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
Subject: [PATCH net-next 14/14] selftests: forwarding: Add a test for testing lib.sh functionality
Date: Tue, 26 Mar 2024 17:54:41 +0100
Message-ID: <6d25cedbf2d4b83614944809a34fe023fbe8db38.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: db1252ee-5fa5-45d4-fadc-08dc4db67759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oO67PETlEGgjlI3GylfyM/98WWoyfmnt73ZJIoJN0ne7eDNXnLK/LhCz3cBLLBdZ0gfaS6c2mNZfL2wKXMkc0iQ57ttjgeGqbEdzGuP5mTs3PC3heICuNYQ2kolbxXN4mQwRpOKSporpm5McrO+SHbNUOMHvPH0LwiInt38AxvpEHdtlfbfulUU7WMrxWX9PfK1CTKy3sqd3kaCmKbyummI8srgCgTL3u5+oe9k6V40kkyUwNNkYJc2xnjSdMa4qCG66maQh0Ij+lDhmtTVPcOfghsWNqMzJmAapNVyic7Q7IXM9ydGObjLBbbpLBCxxA0mAnFpHQAaRrVvjm+Rq0r3R80CzltEG1GhuJ06SurJXHmlJ6IlEbH/m7gZ4ducrsTcOzBD6NEuFcSwSbbX445qCRT95Mzc317/UxvU57wBaKHQHnN9bleZ4QUqRxcaEp/BtAfPpKQ+vHSTolSxKSu9UUXSFStnGSPPSQIg0p7MybO4WeeJ5t5qCeh8wMWfXU75V1O2lw+ywE8ffsU/VlvuqLrB4e6vsNlonr8UnW4Fu1wWonNdGrWob0azxaQyShhF15jzCt8CYmx0P5bZb2r1Dq/ufbbUgnakpCdvBdcC9guCSWAbdezUXHVxaKdR7o3SwMQBJpkGtnk8e4UQP2YxkjsFhfn8Tuc4lpocz7e0B6oUhzukSzvv/zX2alpqckYYPIWoZillS0FPxrMBZaVzgZiWdEtZF0Qnh1s1qr9Ll1HlIfNARvaW5tB00eEMQ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:02:05.9821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db1252ee-5fa5-45d4-fadc-08dc4db67759
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044

Rerunning various scenarios to make sure lib.sh changes do not impact the
observable behavior is no fun. Add a selftest at least for the bare basics
-- the mechanics of setting RET, retmsg, and EXIT_STATUS.

Since the selftest itself uses lib.sh, it would be possible to break lib.sh
in such a way that invalidates result of the selftest. Since the metatest
only uses the bare basics (just pass/fail), hopefully such fundamental
breakages would be noticed.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../selftests/net/forwarding/lib_sh_test.sh   | 208 ++++++++++++++++++
 2 files changed, 209 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/lib_sh_test.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 56e3557ba8a6..fa7b59ff4029 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -37,6 +37,7 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	ipip_hier_gre_key.sh \
 	ipip_hier_gre_keys.sh \
 	ipip_hier_gre.sh \
+	lib_sh_test.sh \
 	local_termination.sh \
 	mirror_gre_bound.sh \
 	mirror_gre_bridge_1d.sh \
diff --git a/tools/testing/selftests/net/forwarding/lib_sh_test.sh b/tools/testing/selftests/net/forwarding/lib_sh_test.sh
new file mode 100755
index 000000000000..ff2accccaf4d
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/lib_sh_test.sh
@@ -0,0 +1,208 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This tests the operation of lib.sh itself.
+
+ALL_TESTS="
+	test_ret
+	test_exit_status
+"
+NUM_NETIFS=0
+source lib.sh
+
+# Simulated checks.
+
+do_test()
+{
+	local msg=$1; shift
+
+	"$@"
+	check_err $? "$msg"
+}
+
+tpass()
+{
+	do_test "tpass" true
+}
+
+tfail()
+{
+	do_test "tfail" false
+}
+
+txfail()
+{
+	FAIL_TO_XFAIL=yes do_test "txfail" false
+}
+
+# Simulated tests.
+
+pass()
+{
+	RET=0
+	do_test "true" true
+	log_test "true"
+}
+
+fail()
+{
+	RET=0
+	do_test "false" false
+	log_test "false"
+}
+
+xfail()
+{
+	RET=0
+	FAIL_TO_XFAIL=yes do_test "xfalse" false
+	log_test "xfalse"
+}
+
+skip()
+{
+	RET=0
+	log_test_skip "skip"
+}
+
+slow_xfail()
+{
+	RET=0
+	xfail_on_slow do_test "slow_false" false
+	log_test "slow_false"
+}
+
+# lib.sh tests.
+
+ret_tests_run()
+{
+	local t
+
+	RET=0
+	retmsg=
+	for t in "$@"; do
+		$t
+	done
+	echo "$retmsg"
+	return $RET
+}
+
+ret_subtest()
+{
+	local expect_ret=$1; shift
+	local expect_retmsg=$1; shift
+	local -a tests=( "$@" )
+
+	local status_names=(pass fail xfail xpass skip)
+	local ret
+	local out
+
+	RET=0
+
+	# Run this in a subshell, so that our environment is intact.
+	out=$(ret_tests_run "${tests[@]}")
+	ret=$?
+
+	(( ret == expect_ret ))
+	check_err $? "RET=$ret expected $expect_ret"
+
+	[[ $out == $expect_retmsg ]]
+	check_err $? "retmsg=$out expected $expect_retmsg"
+
+	log_test "RET $(echo ${tests[@]}) -> ${status_names[$ret]}"
+}
+
+test_ret()
+{
+	ret_subtest $ksft_pass ""
+
+	ret_subtest $ksft_pass "" tpass
+	ret_subtest $ksft_fail "tfail" tfail
+	ret_subtest $ksft_xfail "txfail" txfail
+
+	ret_subtest $ksft_pass "" tpass tpass
+	ret_subtest $ksft_fail "tfail" tpass tfail
+	ret_subtest $ksft_xfail "txfail" tpass txfail
+
+	ret_subtest $ksft_fail "tfail" tfail tpass
+	ret_subtest $ksft_xfail "txfail" txfail tpass
+
+	ret_subtest $ksft_fail "tfail" tfail tfail
+	ret_subtest $ksft_fail "tfail" tfail txfail
+
+	ret_subtest $ksft_fail "tfail" txfail tfail
+
+	ret_subtest $ksft_xfail "txfail" txfail txfail
+}
+
+exit_status_tests_run()
+{
+	EXIT_STATUS=0
+	tests_run > /dev/null
+	return $EXIT_STATUS
+}
+
+exit_status_subtest()
+{
+	local expect_exit_status=$1; shift
+	local tests=$1; shift
+	local what=$1; shift
+
+	local status_names=(pass fail xfail xpass skip)
+	local exit_status
+	local out
+
+	RET=0
+
+	# Run this in a subshell, so that our environment is intact.
+	out=$(TESTS="$tests" exit_status_tests_run)
+	exit_status=$?
+
+	(( exit_status == expect_exit_status ))
+	check_err $? "EXIT_STATUS=$exit_status, expected $expect_exit_status"
+
+	log_test "EXIT_STATUS $tests$what -> ${status_names[$exit_status]}"
+}
+
+test_exit_status()
+{
+	exit_status_subtest $ksft_pass ":"
+
+	exit_status_subtest $ksft_pass "pass"
+	exit_status_subtest $ksft_fail "fail"
+	exit_status_subtest $ksft_pass "xfail"
+	exit_status_subtest $ksft_skip "skip"
+
+	exit_status_subtest $ksft_pass "pass pass"
+	exit_status_subtest $ksft_fail "pass fail"
+	exit_status_subtest $ksft_pass "pass xfail"
+	exit_status_subtest $ksft_skip "pass skip"
+
+	exit_status_subtest $ksft_fail "fail pass"
+	exit_status_subtest $ksft_pass "xfail pass"
+	exit_status_subtest $ksft_skip "skip pass"
+
+	exit_status_subtest $ksft_fail "fail fail"
+	exit_status_subtest $ksft_fail "fail xfail"
+	exit_status_subtest $ksft_fail "fail skip"
+
+	exit_status_subtest $ksft_fail "xfail fail"
+	exit_status_subtest $ksft_fail "skip fail"
+
+	exit_status_subtest $ksft_pass "xfail xfail"
+	exit_status_subtest $ksft_skip "xfail skip"
+	exit_status_subtest $ksft_skip "skip xfail"
+
+	exit_status_subtest $ksft_skip "skip skip"
+
+	KSFT_MACHINE_SLOW=yes \
+		exit_status_subtest $ksft_pass "slow_xfail" ": slow"
+
+	KSFT_MACHINE_SLOW=no \
+		exit_status_subtest $ksft_fail "slow_xfail" ": fast"
+}
+
+trap pre_cleanup EXIT
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.43.0


