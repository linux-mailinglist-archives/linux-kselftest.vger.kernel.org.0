Return-Path: <linux-kselftest+bounces-6564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC1888AD21
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD461C3B9EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3F512C545;
	Mon, 25 Mar 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKO+/WCs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D2811FE
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388003; cv=fail; b=BHE2HrsqI+CPwtwmoIt/jrM5VEWlfWn2mb26ijEyH4L72a35mmGBbhE7P+WmwJGjSY/SHOP1X9RZU3OZ2z6reVlbmSZOPj1wNOo+eXd9Qx4Qxn6tqgGfG13iG0GHQYDBn7F9YvrLcoxTfHKh+8EJrVLUNrg3iQsHKuTgRKjILJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388003; c=relaxed/simple;
	bh=J3Dh0PhxUws7O0cLcSHKwVOtL3i4Eee9MIIZJY4ZG8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt9uzpEJhmgO07I+D3XgqhZf+SomLop2CW6WIOu95KIC7CrR5oHxSBVAhi5FriYROsqsd4S5RQRK9YaeeWqVOm1uAhHV9AwJtfk6K+oCe1Lx9Yp1KQdivLPjuF4IxTeJBQss79cG4koPeayDPtxo1r+MFjHIc7Vp5WkzCURpevo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SKO+/WCs; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI7SUcdjpoFvUfCUZeTyJcb0Q8T9Imrd3KmPYK5ZdCwGfBjJCgLm3SDxX8bVhMfWt/Bl89GPn76UBCpA3glK2FvGaoL3RhyiVtUBNRyrSSYEe5FoG2F7A4cDWyBB5xn7r2ThXnJ2NvJhKv41O0wJKdO7sFywbv0UHHZLYUXGiRYhKfC4SqhS82KGDMU2czh88yfEMKId68fnQ26v7m4ETwckqdCg5t3UVxWn5coBWfBg+6p+da5sDxBQka0yR1v4tKtLtRTZWzH/h0i/3rqAr9Rz9loKSUAu+iXVlXAc8wQHAPx/yzlDrY96bpMHvCzYdGWG/+wnPawkXUmp/V4TVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1lpwxUQhTwCR1THjSFR+evqi5WzOvVdmKlLVv/moGQ=;
 b=Esb/vviNqAHD1N2gFS5s7YndKfokGGzu/PfxY6TnPlCjRC0JpOGGBdpfmHBuj4UkwmfW0LGr6/Hr03sn5IIbJ/Vr+FDcjqjIO8FP+xdRziUwP5FZistiRGMIvTfZO7zbSxjgl0NWBPV+kVE9ldNl80RLJmLUSruk7x8WtaqjDmTzzgDyb9L8NsH5yyrZaAN8t7mWW5i7tlbmwhvTP33F0DsxoppRDG9O0O3QXpD0cy+xaVj5cwEW7c7tQifwdamNfTvMpEdHbv7Qqr2uR04OzDJC7bRs2TXqN2OhtFTQY04ZRN8bkj7Efr7xBtzhHErm6nLOM6x42k4P6Q9fPkyi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1lpwxUQhTwCR1THjSFR+evqi5WzOvVdmKlLVv/moGQ=;
 b=SKO+/WCsyenOqPdVv4SUMOUVEc37Hk1xXJPYtq7SO/AZlWEPB/2i6rzohoqmiODtcKPCubSWBfH6nlzcCSLc5h2lmpwnOa+pDzygeF1e8/4OhVjjLoSx+P201cdTgu7IOg2UVBedPrUorI6mY8rbQTTTAWLInpWQZdT33FAATQ8UbQUcCVBoCGGh/AmucC2ysIeIouv4R19KdCWn+IrBHDMgjaDIRNV05tEOnEx+XNt6XGaIbktXJEqtAl3rWrUp6SVS66ER0wA6TDifsVJ9ave9aUpRE9dyfUDtaiow40u+MztP7csuIrkc1lA6mt6t3FwTzuPUJaB3MknvJGtnAQ==
Received: from BYAPR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:c0::43)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 17:33:18 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::83) by BYAPR05CA0030.outlook.office365.com
 (2603:10b6:a03:c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Mon, 25 Mar 2024 17:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:33:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:59 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:32:53 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 11/14] selftests: forwarding: Support for performance sensitive tests
Date: Mon, 25 Mar 2024 18:29:18 +0100
Message-ID: <3d29f0f344f8cb2984440f8d34ceaa94d2b54019.1711385796.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ebee14-9073-4069-2be8-08dc4cf1a8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JQNB3wkXcScH14qbggw/91nawJy8dPpBfU2dSHHG0djBlj+g8evYzXgvyGpL1W0c9PO6lW6o+4Dp367E83TaQ4CEGNr5Szxsu3Fk+HZlq8ojK9oMi6Xw04ZYm+ybTtp1yM9bNd96n9IdX7i4E4FuII98VV0lcLy4Si56FTj0rSh2eRLq/flqesvuOZ2loucrptKlb/snzpRsUzBeHh9iIKSP7Us/2YzWWlC0znNDdsEtlptVmn6JfUyOMimrgjNl639yXDSxxhoQiXJPsdITWsnJUBfDlIRO8+RJEf97Kh63Z/VzHaGHpBAFApIlcDTZ3c3jIvt6piSOrriyCrZkhO16NC+1mQCGJQGKbvAHBIekZDPUMC/tYwcYpN9ObGYEFjgYU0s6ZDGSONgee6DubYDZ6uUoJL6CoZw1MSjyq4Y3tKgarXB8qI6YWRJpmjtdvnm5pffk/EqhtcQ2kJhv5/Su839S1QO9ib0dQE77PnpdPJQ98Vm4W/BWyKDlTM1RVFsCE46czZIDTJAJpUoMWKcORG4/f6zIZ1d+sIViuuDnlir+MxaOUpuaDFihjrZOUcuc0QaDmmimpLMl3qVytEQL5Y2oT6hlPswBczIXXlGmyJG/8VE393K08lgSiT+mlKstKXslB9++jHHrXCMs/1kdnyQCpRHCD+40AykuRr5fL6cMDf3TsMwAIJCtLxOBSBWwOjKGd+vg4Msehj0zP33W2koYF5u5z691Y8TLFmW1NWjG1/MIK/pJvKRAmM68
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:33:18.1098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ebee14-9073-4069-2be8-08dc4cf1a8bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

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
index 942f38988941..cc32bf11739b 100644
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
@@ -407,13 +412,20 @@ set_ret()
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
-		set_ret $ksft_fail "$msg"
+		if [[ $FAIL_TO_XFAIL = yes ]]; then
+			set_ret $ksft_xfail "$msg"
+		else
+			set_ret $ksft_fail "$msg"
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


