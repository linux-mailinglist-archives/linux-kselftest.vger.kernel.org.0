Return-Path: <linux-kselftest+bounces-14661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F4894507B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C1B1F23C65
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DC91B3F1E;
	Thu,  1 Aug 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nPQgHNaP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11E21B3742;
	Thu,  1 Aug 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529512; cv=fail; b=D5wV36DYme2IDQyzvjjMR099tajynzy4PRw5yjmySeSvAYdTEBOwurSUj9NJvdpr8OnQzYTse7K40gIBw2F+Wy/kSTXNuDh1kOPI7vebkwtRNptQ+7IhzX4Jrt4pQjQH6fAa1yEGS0KRRUg9vnE7f439fXDRmV9KvR8nr1EbO10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529512; c=relaxed/simple;
	bh=YNV4SvynVtr6/xqamAuMs/yvNNhYhoGAzBEkwvzFueo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AV7R4y4Q6Y4R1ex/Q9wkW9XT3gnbBaKqqx/ZC0MXWXAEOxLyx35QKie6P/st0cFUaSWJVUElS41pIvZ5xmXoelzYISluS/ElxjyEP/bEdfyRW0304AgIfVNKctTkGh9/OKVabL38GMt6bql1lBm9jLwaKcug9jvMr8Qd/o6waxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nPQgHNaP; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSx5Ln+aZY+srLDT+PAojCf24T41QktpVO8lOzz0GgC3tzbUXrAc1c1k92NLm1p6KT6s04qeUHSw1Msx+ydGdVSJIUQG6Qe/lzPE9KHcENmCWW4kxUr5DbDHPi5pUPC5tjqY6UKejHwABxOfNs/LzH8z2VqhbBXft8PPbW8DDPD4xBCnXTfVx1rRs/3ig4L1rSNGKFhEBozkRnQYaUZzofVoh+MwoWmoHebDqX7Pu2GHWckKlbiAUByBEQ1TlAz+vT1EcT5HpE/i+gDFgKTGKgA9s+fe/P1eIWbZMuKzD4Y0iFLyKI1zzz54oxdckwNKtfrqZrV2gwiQWDUvAmwYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lowOvcp7Owz/4IMJ9jReg6SaHu5QgB7Herp48Bc24lQ=;
 b=rIAaV3rGKR9N+tHufgN9W8Q5uWib4xGneXgkdRH0Fov5IilfXPPKqBP4Ox4ywD3z04GxHNh2dRyQ7BR0H6nuNq5oFDL8j2r+HXUkUVG9rqUB5H7NG00orHhkOfrtwJZcBR5e8F/4esU1Q07WZ4toEWtioEVTBCeWANqBFo8FyJRiIXgvUTtzqq4WdTd6iy+ttA58VzT3jGsMcb4tFSBg21P1C35j2Ghc609ohZTKPzCzixUzYe/nOxbjZ4k/DSS2Lyv9gGCpQtlSSJQOz5AaHrd1P/AOCLNpem74+cID8BvSevqy+VIZEj48blMQlzYlQcLij7WmXJEXnNNlEgWczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lowOvcp7Owz/4IMJ9jReg6SaHu5QgB7Herp48Bc24lQ=;
 b=nPQgHNaPxrIGr8+xVZdg7mJ0DLpkHo8W4xFFDr/jXaG60NEMFjnLKCfdbufHTYHrBz3WOgKqr7/xnkxWK9jEHbQPcAlp+EQbObtOVYmE/4q1doSgZ2icfC0rKHBbZy8os04zdF1SQOdQkDGIT0k1nf1BU0yiL3BP3g9U1Sosivsf/Hz0Vteo7IIhEejWLnHyi1cTH5yRSgrcgjlboGy2dNRkrB+Z52qOpFytsbblULF9ajcuy5/YIYhkJ9FEuHwwjGSo3Tyo3QsumNTn8EK5QNyaLnp4coCZPDJl7nK0bdnBDkmv3QTjX0bD34aLhs9XMJST4rz/8jXyY7cZLnzcLg==
Received: from BL1PR13CA0333.namprd13.prod.outlook.com (2603:10b6:208:2c6::8)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 16:25:07 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::77) by BL1PR13CA0333.outlook.office365.com
 (2603:10b6:208:2c6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Thu, 1 Aug 2024 16:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 16:25:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:52 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:47 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 3/6] selftests: router_mpath: Sleep after MZ
Date: Thu, 1 Aug 2024 18:23:59 +0200
Message-ID: <c9b3322a018f584145871588dc9bf13914a67f83.1722519021.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722519021.git.petrm@nvidia.com>
References: <cover.1722519021.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 955dd238-20bb-4f45-1187-08dcb246814b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?19womOp4Gm4V2i0ghj8PUeY37fGewu9rjEo1v76eBQKcVNN397xV8ZwNBjLx?=
 =?us-ascii?Q?6FOCEFt7B9Ry3fXDkEjEERx0zHrRHUgV5Wx4PJMp/SqRCDXGdgLq7FOYtWbE?=
 =?us-ascii?Q?6F4xOJdRC+yQ8cn7gc/zq4u7Q3l6T7xtRosxcffhMftAalsRpUrPfumlLQWK?=
 =?us-ascii?Q?PQL9xRLwTi8vTPCdOHMVWefrSh6/stf679DUK8nY184tRYi1TLNNJVwLTEIg?=
 =?us-ascii?Q?IAARMXQr+2wyrKnwV1L1UhcHc5tD4YEKRjUlSk3ZIE/3rqRnhU62dKucx+wy?=
 =?us-ascii?Q?Li2rro0tt+iNjY/l/teAOh1XXWmwFUor7C4pxCzdk70jTZ+rbldXEbd+TCFg?=
 =?us-ascii?Q?ZUKE2YDgeeH4C2Yq3nCfI/9m2Iz62b7lhFgAyspM9ucWHti/affk0VWMhsgj?=
 =?us-ascii?Q?HD5K94YsjVfb91eYksX5aEliis4SQpfY0nQk0apwa91TAw8/m0oGcs5GYc1n?=
 =?us-ascii?Q?F7X1Rm5YhjQbJLCpOgtaPbBnvxo0hvl8Fjyo7rawyyj+9lBmIyEWQJciMHlE?=
 =?us-ascii?Q?5dMCKvSWLNzTrnzsaZfToNeVY53mEBMmLTaJvWlUnHpR6svLzPQ+XAPESg9X?=
 =?us-ascii?Q?f7dzVRYCu2GBAovDArwKSA7GrWbReJOAZuy3ukKT2lOTNSdDjrqU4U/8Q6Kp?=
 =?us-ascii?Q?NzfFp/2cpF+z9D0mfYM2chd8gVTtnNYYIWguqvKTWbemqQStgXnKpHkoWOfU?=
 =?us-ascii?Q?fzhSv+WGtHQv3yyXSY9oqhmPXwFPg9THDlwFKsxmJojl90T69cQhV95gGrFB?=
 =?us-ascii?Q?V6ZO+JR7DCAf73N3DZpakxTmWXWvqrCa8f2nJsy4pPBlx1w8FtuogRP1la/w?=
 =?us-ascii?Q?uSH7t7LTFs15d5RNhYWSsC4Jzd8z6d1v97FZeDYmj3Q8K1glmappaBxI6Hhx?=
 =?us-ascii?Q?UDYBQV9JUCwHJsXxaVYLF1wgC9fhjny3t19SFvFahCuXIYN5Nue+MImxK8Gs?=
 =?us-ascii?Q?BVaJyD+Qhi0AE0FfoM7EYNmv+tNUfQSqtLbc07ztVZ3s2Ns4LI5vAQ35No0S?=
 =?us-ascii?Q?v4NSGV/xsnG+bvb8l9/iWTRhDZiJGM4yIN2I57Fzgb2R2TAYq2ZPSkE/M7Kl?=
 =?us-ascii?Q?zNUkURlJYY1MxcAbX/ppEnQtTzzfLZ/j9M2/lUVq1Z/jfzdPt2Ne5nxu5jdJ?=
 =?us-ascii?Q?V6MIYz+OsJvuw0pPZvPw48zJt9CvavJZYIS0pnbSJ7zI2RsTchrU6NkngcHA?=
 =?us-ascii?Q?S5w2tWshQCyRd/I1kmlTg3Idk8h09HmkO7yt59HD8rZZgy2j+TiCZeAMkGng?=
 =?us-ascii?Q?DS5RszGnMzJQnGz6Ij1sC2tLMZA67EEq5hY7ljpPnaeYYjp8WYkOpnD+roi8?=
 =?us-ascii?Q?++BsdKTnNOtBguvXdsOJFJaeK+11njtnOxys2pk7l3w72dVGcRhP7sXh3LpH?=
 =?us-ascii?Q?kt7svx34gS9d0Rg/na0gACzbYXkwF2gXUZCwo8snzqJi6xMqNAvEx4mkUcL1?=
 =?us-ascii?Q?QjpDmqy4bTXUhJu/huX2j2IEhMHooW2+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:25:06.3746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 955dd238-20bb-4f45-1187-08dcb246814b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825

In the context of an offloaded datapath, it may take a while for the ip
link stats to be updated. This causes the test to fail when MZ_DELAY is too
low. Sleep after the packets are sent for the link stats to get up to date.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/router_mpath_nh.sh     | 2 ++
 tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh | 2 ++
 tools/testing/selftests/net/forwarding/router_multipath.sh    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index 2ba44247c60a..c5a30f8f55b5 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -243,6 +243,7 @@ multipath4_test()
 
 	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
 		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
@@ -276,6 +277,7 @@ multipath6_test()
 
 	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
 		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
index cd9e346436fc..bd35fe8be9aa 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
@@ -244,6 +244,7 @@ multipath4_test()
 
 	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
 		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
@@ -274,6 +275,7 @@ multipath6_l4_test()
 
 	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
 		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
diff --git a/tools/testing/selftests/net/forwarding/router_multipath.sh b/tools/testing/selftests/net/forwarding/router_multipath.sh
index e2be354167a1..46f365b557b7 100755
--- a/tools/testing/selftests/net/forwarding/router_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/router_multipath.sh
@@ -180,6 +180,7 @@ multipath4_test()
 
        ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
 	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+       sleep 1
 
        t1_rp12=$(link_stats_tx_packets_get $rp12)
        t1_rp13=$(link_stats_tx_packets_get $rp13)
@@ -217,6 +218,7 @@ multipath6_test()
 
        $MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
 	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+       sleep 1
 
        t1_rp12=$(link_stats_tx_packets_get $rp12)
        t1_rp13=$(link_stats_tx_packets_get $rp13)
-- 
2.45.0


