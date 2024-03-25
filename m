Return-Path: <linux-kselftest+bounces-6563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC088AD20
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1111F3752D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D74130AEB;
	Mon, 25 Mar 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fI45JxAE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225412C545
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387996; cv=fail; b=nbx8QxgU+hpn6lDnWj0Y5EKZU6nUwbhg8quaT+Q4Xa4DVUJPKlKF0VGST/pg6Jk09jnF0Te7V2R44uwiHqpCiDhqeqrXbkizsjbkohFn/eSTOsp4O90rzwqET9JKH9C9/oTMVOR6My5TJgCKM3aq4X/bZ59PwGskow2Cv8Ywa9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387996; c=relaxed/simple;
	bh=Z2UsHHfIZ1dfSYQOicILd9VGYKjI68UbAs5c2qIZLP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2opLdItDkwwxf/StIBdFI8wZS2mZvUvGaME5+F7I66dA5PcbckG3ua4CdNnjUEgwJ7GbUxrHC9zlhpD0uZozNa0InVMCNHtTnTOBbAm0+gV9Sk/VAt/kRhbcQWP4JamxLZ/Lt+mloXqQS3mZCfEnbmEMS3DVB7A5HcKrDxUJvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fI45JxAE; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7lPHU6PdGFEaareJoC+v3ZsHM2NYvHBop8nYf3+xNnwK9F3ICjOWr7m6XDARNHrQfT1ULCBMhx6gGU2K12mnIUMGrOdCkDoEdN+PcRknKsYpWXo4mVVS9/k9Nd0p/2Q8iowgDadAGz8U0lwlr5WUd2iIf0RAj+1Xy2IU9A2n1A4oK02XYSAUtcs5Wcln482mIgRFOIs122XbkjXmnhG9Nj1cpuwiq5+7XtVVM6UmNEp2eB2zwBX4TGGjeLs2etLz0rHfnE77E21pYySlKYzHaKI/HUhS57i38h+DinyCHSQjv8pQA+qweST+JFxlVc/SlPq0q7fZzQy9wwvHcJZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaubpYhMibDQ6SdKpL9fTZ9ADyHIA00Zw3380a5t9+c=;
 b=GQsYGonDIdgzm/d4l8ssIzqFWdcEYxE0TLq16M7EmkAYG8Ppy3JQXklC9tHBhHdm0v7idH4SJVPY42tTP1lZl7gt6B9250rx7R3DXTns/O1+IE50jRjECUfK98YEyMIUc863HIiqlfUv5lrZfDXCFc4cVozdXdpJg5SNANOie1IcdVG2IARE50zO2wdCj5Lio8d39r2cJHNb1DOy7Xelfb+nZTFGP1Z1S5LoS3YUVdNW+IboweQo6KR5OSETBPx64zIbpLIBNVazZ2zn4iZSZkkFsVuMgIkctvEqjBjCu84yuM/z47jt8yDHkmmGNBbJKeFt9hNIAz3Tqi1zRnfwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaubpYhMibDQ6SdKpL9fTZ9ADyHIA00Zw3380a5t9+c=;
 b=fI45JxAEX8pNfLBUHzUjJqPbOwJyW0otow5USJ96ofLKbu9EHufbwDyiV1AZyncgzHzwnnrbt/BpFfJzKnLsB9pdsGEF1AdHknLiCT1qZgJkeLIcUBHqkvEAKAzPu2l0bJsYxRXTatZemM+jtmkoOVv6wUi9jYqNIwT95NdzpvZfzOgbtXDY82T298ZXbmBc3pCz+ZeJexue4TZ7e2ZKFZbdkTzTj10Clz9qnuZGgZQBgT4cy52GXTOuw7/d/EBQIl3jwlFb3UYk0gqrfE6eQK4tcPxsbHBgM73x7Q58BhJKGsU7gWw+9i/Oc3W2HTrNlJTIowQPSWs8GI060+dbMA==
Received: from SJ0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:2c0::35)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 17:33:12 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::10) by SJ0PR13CA0030.outlook.office365.com
 (2603:10b6:a03:2c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Mon, 25 Mar 2024 17:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:33:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:53 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:32:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 10/14] selftests: forwarding: Convert log_test() to recognize RET values
Date: Mon, 25 Mar 2024 18:29:17 +0100
Message-ID: <a73c7706b6e6138ffcddeab63eacf71c34ce797d.1711385796.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7e2494-04d8-4f76-59f3-08dc4cf1a4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+9CWir7KpHTg2HBCbpz0N3VyaN+gSTZXaPkqJqtUxRhDC+5YJjZKiqcbI1/RGlm8AC3qLO1dZRVSPMfv5KUiTKleFe5WLXICTJjCp5nTQ6dqKJZED78pEss+sG2wZnHZ73yQFSnfSRTaEGET/Mb3WYpMCn5cRWBaS9QSynasMF9L97j2B8Dzfmdcy0Qtrigr6E0xC6lO0MTRfzmhvt/TUYKiiiDYptFLeuQAYjCtOxoeAw74wt6lFZA+7kBeR7O7/pD2/BQFz6Rfh5WfxcB65RK4W5ljdZM80XLovGYlHfw5dS22aXy/knWa1G3lgNnG5sGhHtA6qroRPxhz2vXMokqdSOMGuXMyUml1m1Hlw/eDN1gF2pbEoxCeex7rR4h0AP9+DuVs0s48Hx6l+Fo4yVgboM5ol+7dP9kad4GKDlVks0IptYunAgL7HYi1cbCcSXlySYIaVbfP/A2G7U1I5lePD4zCsA6A3+6Ep1fuOrTJFmgRDNUaHx+CH509bsOK8rvy3L9JJln75gkHMLp63EW/6289pAqxeNGMAMerE/HSTE5UfSA6Zcd5KxELY8IIIjzH9dRpsGO5OuiMkMbw4fJkIjFYgnXb89JBc+uKI+FW8mFe6NV/T4i66mGPD+3TiFutyaN1vi48FIqL0WduwAksT4tqQjuhwiWE9kuPWlvIsKKwMCohqyILUq1i08iJhE4TyVkHCC47pEcrpKmEL2uN32yf2/Fcjw0mxnJWqDeePuGX4CMMQiiDgfePVDJf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:33:11.3476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7e2494-04d8-4f76-59f3-08dc4cf1a4b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

In a previous patch, the interpretation of RET value was changed to mean
the kselftest framework constant with the test outcome: $ksft_pass,
$ksft_xfail, etc.

Update log_test() to recognize the various possible RET values.

Then have EXIT_STATUS track the RET value of the current test. This differs
subtly from the way RET tracks the value: while for RET we want to
recognize XFAIL as a separate status, for purposes of exit code, we want to
to conflate XFAIL and PASS, because they both communicate non-failure. Thus
add a new helper, ksft_exit_status_merge().

With this log_test_skip() and log_test_xfail() can be reexpressed as thin
wrappers around log_test.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 92 ++++++++++++++-----
 tools/testing/selftests/net/lib.sh            |  9 ++
 2 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index e72b2370238c..942f38988941 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -438,6 +438,62 @@ check_err_fail()
 	fi
 }
 
+log_test_result()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+	local result=$1; shift
+	local retmsg=$1; shift
+
+	printf "TEST: %-60s  [%s]\n" "$test_name $opt_str" "$result"
+	if [[ $retmsg ]]; then
+		printf "\t%s\n" "$retmsg"
+	fi
+}
+
+pause_on_fail()
+{
+	if [[ $PAUSE_ON_FAIL == yes ]]; then
+		echo "Hit enter to continue, 'q' to quit"
+		read a
+		[[ $a == q ]] && exit 1
+	fi
+}
+
+handle_test_result_pass()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" " OK "
+}
+
+handle_test_result_fail()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" FAIL "$retmsg"
+	pause_on_fail
+}
+
+handle_test_result_xfail()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" XFAIL "$retmsg"
+	pause_on_fail
+}
+
+handle_test_result_skip()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" SKIP "$retmsg"
+}
+
 log_test()
 {
 	local test_name=$1
@@ -447,40 +503,28 @@ log_test()
 		opt_str="($opt_str)"
 	fi
 
-	if [[ $RET -ne 0 ]]; then
-		EXIT_STATUS=1
-		printf "TEST: %-60s  [FAIL]\n" "$test_name $opt_str"
-		if [[ ! -z "$retmsg" ]]; then
-			printf "\t%s\n" "$retmsg"
-		fi
-		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
-			echo "Hit enter to continue, 'q' to quit"
-			read a
-			[ "$a" = "q" ] && exit 1
-		fi
-		return 1
+	if ((RET == ksft_pass)); then
+		handle_test_result_pass "$test_name" "$opt_str"
+	elif ((RET == ksft_xfail)); then
+		handle_test_result_xfail "$test_name" "$opt_str"
+	elif ((RET == ksft_skip)); then
+		handle_test_result_skip "$test_name" "$opt_str"
+	else
+		handle_test_result_fail "$test_name" "$opt_str"
 	fi
 
-	printf "TEST: %-60s  [ OK ]\n" "$test_name $opt_str"
-	return 0
+	EXIT_STATUS=$(ksft_exit_status_merge $EXIT_STATUS $RET)
+	return $RET
 }
 
 log_test_skip()
 {
-	local test_name=$1
-	local opt_str=$2
-
-	printf "TEST: %-60s  [SKIP]\n" "$test_name $opt_str"
-	return 0
+	RET=$ksft_skip retmsg= log_test "$@"
 }
 
 log_test_xfail()
 {
-	local test_name=$1
-	local opt_str=$2
-
-	printf "TEST: %-60s  [XFAIL]\n" "$test_name $opt_str"
-	return 0
+	RET=$ksft_xfail retmsg= log_test "$@"
 }
 
 log_info()
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 88f6133ca319..b7f7b8695165 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -49,6 +49,15 @@ ksft_status_merge()
 		$ksft_pass $ksft_xfail $ksft_skip $ksft_fail
 }
 
+ksft_exit_status_merge()
+{
+	local a=$1; shift
+	local b=$1; shift
+
+	__ksft_status_merge "$a" "$b" \
+		$ksft_xfail $ksft_pass $ksft_skip $ksft_fail
+}
+
 busywait()
 {
 	local timeout=$1; shift
-- 
2.43.0


