Return-Path: <linux-kselftest+bounces-6648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB45888CA15
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA711C6090F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9A1F941;
	Tue, 26 Mar 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OtWVLH23"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D34DA0E;
	Tue, 26 Mar 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472513; cv=fail; b=CFbKH/Wqdhs062fs6f96Us7ElrKZgMtey+kSWx/ItPOmdNdR72EN2OLszVlYxn/4aDX7//vewIXTr8AYJJuHZhab3MmxDkaB0v5HuPHWSriHVIwe+HBDZP5+Ie7CtsHEllSd6UPlz86pOyEk/MhA5vhL/D0otX17jhC41p4jiOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472513; c=relaxed/simple;
	bh=alPKKQmFZK/MjzQkgYuO5XDPT8deYr5TqtlE/AVOcHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7jPSVLZAlkxZtSNwHfZ//c/ETspWDKigXy7RklM0ePeRiBZxI16dXQCZT5aRHeIcpjnqTQaufU0wnq3VFCko8yyPNyR0KuPkxBhFkkY8xZ/1eLs3QU/RU1wArW89rmmp6Gww7nArJXhVqMeFLB+S3RJBICxWAzH+1MREEF/RHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OtWVLH23; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNVDbr48udadTVrinjGnj7SMzHRS9XG5WC/i5K/wmKzhoD6IUIzga8JVvZUzY3TI6/5BGr/71Z9PoqsZ3gSJu3BaWcgkbpJsrFkw8GpKlVSrmqRhQDQvxqyonwCLHRkA/pJ+8Y3tliMQ9vkS24xz9HqL/AHrwtWdYfDGrurmwKL2UO0LgF/vF+mYqWq9E7jgdLUsGRCvRmo4n+FXsf9sreAgpemLMYmVGYQDGC2vNyAR/EK8l34ojt3EEtovrAJYtABpSJhu6zNDXLeeB7YqsI1HlQwmTQcEJSSJhX8ezJVvvTQGtXWgrWzV4HfX4e4a2hAufBBjNvAe0RmcK5ty7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeG/StRSGKOdgGrgOT+M6Ke9nKFrPhwQAizDaYFKBvg=;
 b=RZliXNUOFUq7r5qIRbDXfFBVxxPJKoXck42MXGAIZbrdOfKMM8nAN84OTTTDEM3yWjNAFfiRuTQ1zFwxAs3wrfRlN6CyjUv60o8VQfBKVD3KqP5L2XANRnGbrue0q4SZnOY8zDob2XrLo4z7d7u4nqz6yysE3Jek0daRUIoe6yO8QE3dR39Kh3JaxWHDRgWaQCA6sQbNIV42+vOP3cHq2kcfKUZWuS4ZzXpAtntvUnpGElvU/N1C4LwIRzspI1hd63td5zh5lODRdqzfJnL7822bgZg3dexzIsbiKwFCpQR4xcDDqWDRMZN8dkHw0wT28KU15z0jMssVXwvR+54siQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeG/StRSGKOdgGrgOT+M6Ke9nKFrPhwQAizDaYFKBvg=;
 b=OtWVLH231BEQJwqAO4L1c68kuVTbCNZJioM4EDkhV/VIlbG/PxPM4Pi2TGLutSqY5XS6g331twylFiWA8/NiIrid00xHQDA6pMNsRPfN8yQ1V8MfXUjjYh37hYpoxEH9b8FMshOe8tiJplhcY2Zo4hWoXE4V862ZEAamivaUH446QFt6kMj5CibTxLoK86IkFoSBiT60sHjippC6Qjn+sFJEKv0YA24FFuW91YJlUG6x28V5ZYv2lNxYrtxGKKV8JEM6FbklOV71j/Os8plb/lk9wJNEo9XOFmL9l1Dp2RFI/KqPWKh2SC2WZCbxtOmgLoxENPuYa+eFimCry1Afqw==
Received: from BN0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:e8::33)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 17:01:48 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:e8:cafe::ae) by BN0PR04CA0058.outlook.office365.com
 (2603:10b6:408:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 17:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:01:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:01:13 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:01:07 -0700
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
Subject: [PATCH net-next 11/14] selftests: forwarding: Support for performance sensitive tests
Date: Tue, 26 Mar 2024 17:54:38 +0100
Message-ID: <99a376a2d2ffdaeee7752b1910cb0c3ea5d80fbe.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: c63ff331-4821-495c-cdee-08dc4db66c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ii5yI0xCxMyS7y6qvoaGrXdJgCjmuIMsraQDbfE5KUJ2njubgh8DSNqaYehizwr8X3IeWZuJQj9PzyF2X1iDC8oE0UlkNogJp8T+QDQ+JN/+Gf1eMYOBY6fpPaZiyGyFsROvaP+urIGz7+A1hS89sZoTLIbG9CXsbRnr/MlgEhpPemkfqvfxm39v7UzwclSHhwEkaTs9c5kPj0WDTToUexcKgEp78zkQv4IYjljAB5L809Kc+qcAjcowty+9kXAwkJx9Lwgsm6m6x638JxtYeScZzvn3r91x/H1/vBMUE0/JbfyvgqNqVfBQdHRrcD+QYLdtQmObyQmEZojKpSR5J9z16UJT3/Fcb4n5dNdfXZYY0Gv/WLJFawDyBKNrKEJPhyBF5Gsc54Z85LNNUPVlC/jOZbRvN8XbopUwU3LJ3QbhqruI3ICiePwkd/stsy4o4DFwbz/C6NQGT4vmmKy42pEN1Dcan3SUCKeLxej8wXEPeECRw9R0mhptp1BLvkGFua/PHuiEU7RHNbATdW1PqMrVni5d3pqNLObk4di7MeWPwF7fFwxIi+obaB6/Yc3ySNXaf37SZ/ViTjZLF9BN0u8PSUrRekZrF0vv4x75eb7zcgQfIopR/8Syd2wqUwHUi4OJp81iOIWjqnyrPzhmD5cJIkylqGS7+BTCepV3ky399j+rmbPuqZ8m2yRBEj8rXp62cU5FQ+vxZMIW981AAJqSk2InEU+U3LwDjCQW9JVSfGkhV2f/ZtnCxWO/5f2m
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:01:47.5693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63ff331-4821-495c-cdee-08dc4db66c62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760

Several tests in the suite use large amounts of traffic to e.g. cause
congestion and evaluate RED or shaper performance. These tests will not run
well on a slow machine, be it one with heavy debug kernel, or a VM, or e.g.
a single-board computer. Allow users to specify an environment variable,
KSFT_MACHINE_SLOW=yes, to indicate that the tests are being run on one such
machine.

Performance sensitive tests can then use a new helper, xfail_on_slow(), to
mark parts of the test that are sensitive to low-performance machines.
The helper can be used to just mark the whole suite, like so:

	xfail_on_slow tests_run

... or, on the other side of the granularity spectrum, to override
individual checks:

	xfail_on_slow check_err $? "Expected much, got little."

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 370fc377249b..58df57855bff 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -79,6 +79,11 @@ declare -A NETIFS=(
 # Flags for TC filters.
 : "${TC_FLAG:=skip_hw}"
 
+# Whether the machine is "slow" -- i.e. might be incapable of running tests
+# involving heavy traffic. This might be the case on a debug kernel, a VM, or
+# e.g. a low-power board.
+: "${KSFT_MACHINE_SLOW:=no}"
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
@@ -407,13 +412,20 @@ ret_set_ksft_status()
 	fi
 }
 
+# Whether FAILs should be interpreted as XFAILs. Internal.
+FAIL_TO_XFAIL=
+
 check_err()
 {
 	local err=$1
 	local msg=$2
 
 	if ((err)); then
-		ret_set_ksft_status $ksft_fail "$msg"
+		if [[ $FAIL_TO_XFAIL = yes ]]; then
+			ret_set_ksft_status $ksft_xfail "$msg"
+		else
+			ret_set_ksft_status $ksft_fail "$msg"
+		fi
 	fi
 }
 
@@ -438,6 +450,15 @@ check_err_fail()
 	fi
 }
 
+xfail_on_slow()
+{
+	if [[ $KSFT_MACHINE_SLOW = yes ]]; then
+		FAIL_TO_XFAIL=yes "$@"
+	else
+		"$@"
+	fi
+}
+
 log_test_result()
 {
 	local test_name=$1; shift
-- 
2.43.0


