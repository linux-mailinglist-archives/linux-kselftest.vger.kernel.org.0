Return-Path: <linux-kselftest+bounces-6567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B188AD24
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150241C2A77A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561DF131E56;
	Mon, 25 Mar 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lrsii+6/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F4131BD8
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388020; cv=fail; b=giTwsR2+zvfPoE9AFD6CHHBAije8y2mklZ4gjlfifvPN5jwpj6raue6hQa6mwqa83cnlSm6SR3GgOqh1LMzLgrvr/j7tzUPKWiaZX+bbwBcZBsAea6vg8x2sGPkc5imzVAYwrEEyfaammGcI+s9c/GxbLWIUNPVSs7MhUrSJGV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388020; c=relaxed/simple;
	bh=zv0E10TEsyjia4g06g9x0yDea/8AoDOWrXuHKci5zM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyHHgxp9YwXH8kNPCGguF/Q3MlcrUGOSkA3umdengsfyMUmmaK5jbe65BGnx/05BgMq5D8SyNP1lvvwEGY6f3n+FGlvWvG3/d2xip0eSLZrYba/4/55BAVA0wMZukkN9yKD6LE/XwH58BLGIRaiwhZHZU9dQzQJ/5j+S3RMrykQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lrsii+6/; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4DDcH64BVoCsCRykCi9lXZA7VAqMJ4XgM4FcECnn86FSOmbnxZm1h2gOXukscRPZYMHHf+M4/JaqE3B71KBOB7RP8+WbNLbnaO2NOIHovuhBsHCnWCtelRTQza8GRQ7GLGirO6F0rG2B+a+3dX2b5EVjkJ1kafA+C9d2anc32midVZ+2jgQXKzcbvgF0mvZMpnwDAAlzaRpiHkTWa5Az/sJufnQUTl/wm/3NlNf+T5VB2E7Hye1dKbs1Qi0WSoFV2wyrGPj19ZmvBdGj+m4zbvdz2Lbx09dIkWnNDndIms8sXeWbmu/rZMS3OWweXo+0L8EXue6zcpJ5LfITpAAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJRtP0KreHhnjKzBTAkDh7Y+kc+/mjYoR2koFRvwwCY=;
 b=BIV6PXVYSj9GKI9uicUNkG7y7PWMJXXYH13k39S1ekshGN88T0K31pReCaYzIRIMQd4SNOoXx6JIJoZxBdJWWAfndOPoB2KwTHc5/YZjWzJ+07tjP8jeRaVp/9iU3ONRk2FxCWNJCeCDelbS02Nrc9/VeaB5OGRJREJonDYMKb7X4tOWmcSwOpBKLcnclkt/g+YdF7h52ttkHQ0bx0iSHxB7stVqIJfcJknitqFPvA+vjsBfAUW8EHwFy8qbqmQOMCnAICKqcMqbQTMJdIiMosfc/8ooNOSPpFyyiI11uRR0ZMFUOSEq+Uc1VeWqICfohYkbBeSgbK4yxpvzwG00sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJRtP0KreHhnjKzBTAkDh7Y+kc+/mjYoR2koFRvwwCY=;
 b=lrsii+6/wsMWPfMz9g/ZcaXi2Ub/9YDbaYJ6I9HCZ8XnTq0svzsGeHbZ1w9NQkCoMi9+4FQJW/VO+rHaX21OWaCeuF5/jBlj9kC/5G8wkX5VDRbpd04L+E7datlxdtaJQT0eJ4DL/ECQxD8cCFLWGA6B7fK+ytss7B1796Pp6EYezf0Pa9OfjmOSezdpSIFZXyLtfk2UERzVDf8Uu8HFQdiGeJ7R9HLpRDkh73jtQleGCPACmmElCH8oMdw19GZHZlj80oigE/rQKMCPHReLzqw6DvVKWyNnGQU2QiV6FPmYH4wnqR70gEvVAp1SOKl333d6dl0BYUebcXjWw/J/5w==
Received: from PH8PR07CA0027.namprd07.prod.outlook.com (2603:10b6:510:2cf::25)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 17:33:34 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::39) by PH8PR07CA0027.outlook.office365.com
 (2603:10b6:510:2cf::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 17:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:33:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:33:16 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:33:10 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 14/14] selftests: forwarding: Add a test for testing lib.sh functionality
Date: Mon, 25 Mar 2024 18:29:21 +0100
Message-ID: <ee9b8ed1d9f3afad6cdd4e8b0ce7da54e40ac153.1711385796.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: f61c3e10-4673-45bb-f738-08dc4cf1b251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lzxffjydJdFSIm/+LqQTIcLq+1j2EtUoqcrz+1iDHXkNYwnsQW+pp3ObhoOBBRapdcQNeuMlpA8jcXRy6Dovv1s9692LLy98HiEtsXjfR8uqbhAD09F6V9sP9vR32lYJWmzppT/0ED1uzTYuujN1stQqszdPTZ3do1GdxL59zIo8XLYJM2+nO9oyIIybV+YVpEmR+2ouf2XOCNRgOZDwJ8e4ggE72VhqWeSEioGUYY5J0PBuaIkJRpZ1pw9GUQDNi5RC8EvKFxXiSGcA9V+gaq3OXXZTeUMxaRwRpRw9hV811zpjPm4BGPJpDFfMARkJ6F1Wht8JVYiY54nS8cHOc0/u/RatRWFrAdI+xS0OMeZuaZM8zEeEUJoHJ9FvS/Mt5w+cvLHUG9caSXmoognZqvQh/BMxw5uPK58pzO7V+xZMhR9vqgtNTK+w2hoE+3dfPyANPk+TjYk96BtP5ckDCKqw7+PekYcWa6Rtcwq9TMLds6EYV5RnAboYp1ahhpcl1uaM4OlEBW8JLraiZjlZMU1efCDFai+dPo6mFbOKIgOmuqBMO6du2LD6d1cc1TcCnANotDJ6tqlLOlbnnGKiZW8SYBhhq3zDw3R+tQNGpHq5QFmFmIaTkUb/cDI+GWijZSCZkEGOF2UyNL1eCjXucFyJu2cCh+WAw3abGWtfMMHYt/1nJ0lCWKP3F78F3TThsehsieE8M7G9pWrf/NTg5tS/nMHVVhO71xq64/hr2+rXam2ReaUZH8Svkksx8n4U
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:33:34.0907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61c3e10-4673-45bb-f738-08dc4cf1b251
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259

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


