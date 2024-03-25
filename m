Return-Path: <linux-kselftest+bounces-6561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4207C88AD1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662B01C3B566
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA0131BD9;
	Mon, 25 Mar 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pojy8MmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D4131BD8
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387992; cv=fail; b=d9e0WWwK6imIFRDfPqUPGoVmsXCD7+LyPkZPFNnu/ASqyApcL+rAw0d0b9snyD1ktU1C0YNaAivnYKhDjrnZ4kGBmd77bGepipoaW3aBJRnhrHiTltgcovkzQtkAeEMFvWGb29k8RDE1DL7LUWXWB04sG9CvSr/IQiW2gTBC46A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387992; c=relaxed/simple;
	bh=HDf28ffDoLt2OzHE5NC0EZDQjL9LK9TeToUEyEt1fpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJvIDGVTGAAeJdeIA0vaJui/bsmtnoq1vMRVUOJds19jgwN6iKzSvghlGvnpk0+rMMcGD/l3BhN7y3LE3eqwhh9LWS7JYXrH3dNors2RFjFXRlDV0DoHq5Zltrqjt+N+KBXU9pGsIY7qe8aNsKb3mLlfKQRP8+5RYhiu8dGXZ/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pojy8MmW; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvqF0DIk0Cq59XTE361sNDfxukPQ+B2WGJ3EXJmgCIluRzEkKHhND/csTTuaphlBTGqrtwe4cUm+ug24pyfisp846rcDWw8CBsiHuMBWOyqbtickuVpVe8nCfCnIyCLfE7smkanutiDU3I2kDtDrns20rElbyCd1pc8Dm4kmvX/PlAXMG4Y2W/8r3u92Jbfqw11zmxAwW6BXF1GOsXIieyEADVVDkdozg46aXBNKceYMmJ9VPkHUyMGqs61KwmeOd2reGMi6+Djq648Wl9IxwLo6mEBGx0S7G85BiOSlfUYsrWwx+E09NIiOquUavrFNe8KFdVkQrSI40NkyWXLxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmFb6laAYMesL6/V0w2y95pwC3ay+pBzgWlmAeKdWro=;
 b=Mdx2r9XdodD+fC0UK7XwhwP3Dzb7DLw0LAJFs/fN5p9B7gHLhYQ/jJGIRAtFohg7dzljAaQQrArLOVqOEuCoQ7g700uh4RmFMfYAguK36w1OWLl4vElhjXdFEBdZ+bBPTCTI+y5aKksYUy0bxURhTMp8yqmQcxVdxW4IWEZtvZUcmOHQhcgJS2ZLskQXchmOlOTJW9LrA+jlAWTu4pc/sFjO+lsxBJzIxXnSOJKtFdzASQb5ogyrHdPMBgNzGH2CJJyZbwr4366h0lErhxIt8jHyuLpkoe3sfakRSAbNsenyfDhhQkFaclPrTaOENMeM64J5qM/X0+8J1uMbhyVNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmFb6laAYMesL6/V0w2y95pwC3ay+pBzgWlmAeKdWro=;
 b=pojy8MmWF8eopH6QlCuuzL0WciVzB+AY+jSPalc8ZDBkXYO4R5IEb+BRfwexLd3LDE9jtFg7bD3wbdMN064eFtf27qye2w7USsFTJTk/3kNfZMbWMoXk8BL+vhLV9WD6BJ+rjswG1bNfi7BZ1u6AN0omdsQLIQOGNtvT/l99XYftG2GnQWjrLPEQks+HEfvPMtoggE1N1gn1iw/edmu9W7RM6EEuK9Jp/mUuFaJTUgeaJU0P67BNccW0k5y6J9OiIar1v9J64jfKxr9Gy8BCaSgrcsd7Mj7Is0jwvxC5Dd0n8ipxwVcFa+Y8vUvWqFQIRclpxsze9+OYJpgYXijTQw==
Received: from PH8PR07CA0027.namprd07.prod.outlook.com (2603:10b6:510:2cf::25)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 17:33:07 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::6d) by PH8PR07CA0027.outlook.office365.com
 (2603:10b6:510:2cf::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 17:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:33:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:42 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:32:36 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>, "Davide
 Caratti" <dcaratti@redhat.com>
Subject: [RFC PATCH net-next mlxsw 08/14] selftests: lib: Define more kselftest exit codes
Date: Mon, 25 Mar 2024 18:29:15 +0100
Message-ID: <545a03046c7aca0628a51a389a9b81949ab288ce.1711385796.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7012dd-b4f8-4929-e29e-08dc4cf1a200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/z9iExj3YSVLEu8Xz6gHdwDO9CNIo5znoiLUfXlvG/cWREPgqj6+qqg9ZYjel9zMFTp7lwM7FFhP6I17PTD5maJTICfuCyMz0bJu4Lkm4fpfHOadHrr0X70oz8TlMMe+j0niXHFFQ1SIdal1EDISlN4z9IHwflgj9hli4JvOfsx86o7RQt7VH96XvLjst+QleasgH4BNlSqF/sl7GDlcM+mJSZ0RurEsFfE+pA3bRM1WHsoC0yKNOzgzPU8fTEuUiN5EYBcRfhWqQi6azwBhY5g+dfQYIuaeyV0wc8GF4BfF1V3P9JnNp0/24AcBv4QxGdFOQi9P5sD8WeTtbxDe8Zfwu1ffpJZtrNSgT6AB8wpGeGW2lt/72Vyc9jr05Cqrldod8G7P7OmkwJZ2bG/DrjrpCfGB+dWKVqEtF0Tqy8xiC86D/s4WcYKaHLTgyLBiOEyUkXe5QnHuivwmpjNcrDNyKSGB0mBYmvj9vk5iXShGIIKqcftRkEF5poKTDoYFnujtqJbRVt/Fp2kDzF3pS/VkHy5XaaXblE/IYVUqaWtYGR7md6gRuPYVicAcY9kklumMThBFLRlLFGFpcY8VqLRWyMGl7fYyTXrzVyQc10oPHN/pIiHV0sXb5r/kUKqNnNLY2c2kfmMMVnqlKyAeF94NJ2dx63qMepuXVdRr8W3WZb6kWwORUEV9lvPA/DpLu/htMsMqebdUfzJ9d9iiChqEgfAeYYHtvGtskEVaoJ9aEE6sg4ox/rOfAhJ2IqAp
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:33:06.7157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7012dd-b4f8-4929-e29e-08dc4cf1a200
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751

The following patches will operate with more exit codes besides
ksft_skip. Add them here.

Additionally, move a duplicated skip exit code definition from
forwarding/tc_tunnel_key.sh. Keep a similar duplicate in
forwarding/devlink_lib.sh, because even though lib.sh will have
been sourced in all cases where devlink_lib is, the inclusion is not
visible in the file itself, and relying on it would be confusing.

Cc: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/tc_tunnel_key.sh | 2 --
 tools/testing/selftests/net/lib.sh                      | 6 +++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
index 5a5dd9034819..79775b10b99f 100755
--- a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
+++ b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
@@ -1,7 +1,5 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 ALL_TESTS="tunnel_key_nofrag_test"
 
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 5b366cc4fc43..d9bdf6aa3bf1 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -8,8 +8,12 @@
 
 BUSYWAIT_TIMEOUT=$((WAIT_TIMEOUT * 1000)) # ms
 
-# Kselftest framework requirement - SKIP code is 4.
+# Kselftest framework constants.
+ksft_pass=0
+ksft_fail=1
+ksft_xfail=2
 ksft_skip=4
+
 # namespace list created by setup_ns
 NS_LIST=""
 
-- 
2.43.0


