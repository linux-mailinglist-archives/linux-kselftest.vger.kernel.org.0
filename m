Return-Path: <linux-kselftest+bounces-12857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C81191A9C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09D91F21B07
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F291197A89;
	Thu, 27 Jun 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k+A1E1Ue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD9819;
	Thu, 27 Jun 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499797; cv=fail; b=D5uIEwuTbYdIlL5lV2uOKgXdd19KA5STGTUIvH21lGnfGL2TDpv1b9ar47IvPsvgf0UtZVZRw56VgPSF6kTpPxxFbmHkgVxgfxlYWZK7pkiIz/BnGQjSx5hcqJZ8Xf+M7AhazLAnwrRWEmbgAO5NdyzO8WEw6Byb4pQ+PNhPMPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499797; c=relaxed/simple;
	bh=Ib1PbLewjHiscj6qGvgIKQYrFvuTweaS3v6zdvtnpZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sc4NDfv71+bjJGtRNZ4FQogea7Ru9yUZGeTMJ2aesbFMht141zJZToEGVpGSWfV/RKhSWTC1IEZCEG02tDuCXKP8QWhNfHSaQLO93uYatR81SrxSZ1zVuYUu1Ii4pSwcfpl53K54STMCYFkKsYXv7KtJ7C9v0YIaam+FkfMvkno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k+A1E1Ue; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glVQD/PYO2CJ9BWu4FS8jUxE5Q9TSyubTahc4K6CwwFyXD3OS5UXZ3z1HbLDEhoXk/mY68TvLz1IH4Axy07t8ToBXlyXKxQic5Sg4K5dUqLoWBTbqz+KfwHwChPioXvkawekJ8ucXZwQinwFqFcVUw4lyypdGup09fkzW6YaOu2Fuds4R6zkn2X9pQNQCGNe3jH8tareM9OBS+C3UrBnARSQ5ZevgConXLy5MMppnpuP9ubEuD5wEDVXaYGJc8PZM/pAzR4R9atPpjdY+c6you2UG6qzK3CPL2+wTxIA7/EDNg1KvCw9z3VijbfHSx/GcFkRahZNnp0AP/oQlPQKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5s+K8ZKA1hedFit9gCB6a4eVcsdM+11Oavr2t73Ifk=;
 b=diNNK5J2mXJFhZhZzdf7YMxzdN6A/qJPmCT1zJprY24DSEXJZyJLhECHP6P3Stovb2ma//2tq5E+JZ05boAkcaLnIbE/w5OSouXi1UYiqOgi7L5T8xUhjsroE+/sJNUQ5KM3ijHKGKV7KKCZo6E9f+spg2r+7pxHPetdUJ8pdJEgERM1+ZwkwqZJHHO4ZBt2Hko2KR3BX1nlKymZMnMI6UXqRs3OzwZkcB5tH+NnLxV7b9ayx+beFlXVBjZQ+nXXC2rJzIPNHk35NszfBMA0UNRSlpoodz2YOx9KHnbb7uqMUiP0kE1YXR7TzgfqfvP2gYvlqoq15UW/cWYXK91ISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5s+K8ZKA1hedFit9gCB6a4eVcsdM+11Oavr2t73Ifk=;
 b=k+A1E1UepuFxz9yIM+rvwpSKWR/IwwbvohKFg8NCKMtxL/8Cd7S+3M4cUF/rG/egTEYO56fqd3M8Y0ccqbi+1dtfJCYs1kT7qbLgmUj/yYKuOfO55BFFhRyjnJAV9vo4IstaM7T3cRObJdeztRxbWTkmhavaWu4UX6BuywEnw/BZkjJG3fv7tbo2ocDVNXe6q0wrfofkjTpZWWfyVgSljUagqMeyYuRCLqoJPxBpcorB6shkIopTqvq22TvFX9dBMJyy2AVJN7hdtTWsOjqpQjhUA7CQRNEgOMwcimCTv3DujrQon+AE+ZURk9kXXHHnVM1qyEZ3Oe3MY2bA31U00A==
Received: from SJ0PR03CA0157.namprd03.prod.outlook.com (2603:10b6:a03:338::12)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 14:49:51 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::a1) by SJ0PR03CA0157.outlook.office365.com
 (2603:10b6:a03:338::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Thu, 27 Jun 2024 14:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:49:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:36 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:31 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 02/12] selftests: mirror: Drop direction argument from several functions
Date: Thu, 27 Jun 2024 16:48:39 +0200
Message-ID: <7f68e3b2af05768722b15dd97ea9f01430ab9f81.1719497773.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719497773.git.petrm@nvidia.com>
References: <cover.1719497773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: a7dd343f-34f7-4f65-7acf-08dc96b8651e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gVC8l69GnB0hogJJSoUHroJ1vgicGL8rYVpYV12esJBa5Wbi9xICQWkBfBVk?=
 =?us-ascii?Q?H2fh4vkpzIluSlmFgVowdVJXGxT2lZYuU5/XS+akfP+shMuIKPHy+tMBueVh?=
 =?us-ascii?Q?xtROLlaEYqFAwwAQrvF3LTC+uiDqFzF8mNqRzGfiiyqrcbbHW0oGckb2tBwI?=
 =?us-ascii?Q?OzZdPDGgZm2Fn6noCeifhFynkb13dYpLFCywRZM/yelentvtzDNpaY5V1fB1?=
 =?us-ascii?Q?NNiqCDc/zyFgerLKnD9172JF8Vb1JQPqdgAgwEXzPz6aI7YKSqhVKTx6Gnic?=
 =?us-ascii?Q?b2NKPPwGojobK404MkXcn/mM0jR3tNsMVypjBiz0n4xqFCwNmLgFsizI27pq?=
 =?us-ascii?Q?K88aWXg/tzyvOnw9qw82hskvsvO4wy1wS6Wiyz8iX7rubPu9TB3N7b3FQVQ3?=
 =?us-ascii?Q?juUJ387LaFEzC/Fs0flw2rs2BnBu8VMJmcYZsibvNxzYnDprwubV2npiAijP?=
 =?us-ascii?Q?sKalJeqbElqV32y+N0qeJ8oMvaAigKwz0dwfogS2Q3n3NKtJvdnudyhVUPEF?=
 =?us-ascii?Q?DKbFW68/v3G9gVWcBRlvMK5h58H4Ot/gDcnnQDr7AAoCRDocSloC+++WNlx6?=
 =?us-ascii?Q?mHrBCJb+mqoaVrD5NMfwM3I0QUmPbAze2ANheomz0ahAnnSIduLeuwBhCv1+?=
 =?us-ascii?Q?MyietaAgsRNAYPR63xu0yoK1K+asc3PYqBbghXslXyd+pEYx3mYLxycH2ld7?=
 =?us-ascii?Q?VOvRpzKN4uMG/pBhWgnVuMFBZVEUolyDX1TX11KFaQjgw56tkvDUNj0fTWrA?=
 =?us-ascii?Q?CpbEhK3I8+ykzj+WXrvgvLfLGdM+jdPje/qLv7XHsm3qXk6+8Q+Xxb3LnwY6?=
 =?us-ascii?Q?VNzWppIZIL89VdjhAtc4pdYaTUJiz1THqa/aDFESP1TLBZRn6hw3ZZroK56c?=
 =?us-ascii?Q?hdhKXKh5FOv88MIixryUq4ZGXDOB3BGVDD4TdcPBti9hWyShKU2w1oVuhtKy?=
 =?us-ascii?Q?5B1ZDp8UCreUU03ftmvqtkH0bJqq2Or2kKKhqUDUrl9NeZoO9MpsetLqQDVe?=
 =?us-ascii?Q?O1VhABPhHBlKcRzDsducVH/ozlCQrH/5R9+L+0MSGT3wt3MvzFmA8LcxxUtm?=
 =?us-ascii?Q?77nCMt8elpNDKFBxMWVwokR6tKTzfBLm2NXfIEx99j8c+ftyaRHblihiXgbF?=
 =?us-ascii?Q?bv2egV8UVlg12O/8s9vqBGlgNZ01fL2StWD3SJAIUUbBRQEosy/MNp3gGdcG?=
 =?us-ascii?Q?gj/beLKNguz5c703da2O1t0UgDNMSdeqxszfxw9jlw4c+DqfqDKjhzgYQej5?=
 =?us-ascii?Q?XeXUtKCMYR9q5iN/aKLhz48OZzUpCIlIaTw445wdTtveZv3lKd8TyHABz/sP?=
 =?us-ascii?Q?6h6rA6aQlfnP8oLYZBfuhu/SZ2M8xdw8kWGIoZvAeywNl6+EtykSdajCiBT0?=
 =?us-ascii?Q?uK5+C548k50wfmXH8VysaCVxhdeWl6YdYGKgMlQKx8GmB1OjZKObnN2IMTV5?=
 =?us-ascii?Q?/nmtxZjBfYYovRXAaxvXgPcBrREzzgvI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:49:49.4256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dd343f-34f7-4f65-7acf-08dc96b8651e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380

The argument is not used by these functions except to propagate it for
ultimately no purpose.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/mirror_gre.sh | 12 ++++----
 .../selftests/net/forwarding/mirror_gre.sh    | 12 ++++----
 .../net/forwarding/mirror_gre_changes.sh      | 24 +++++++--------
 .../net/forwarding/mirror_gre_flower.sh       | 13 ++++----
 .../net/forwarding/mirror_gre_lib.sh          | 25 +++++++---------
 .../net/forwarding/mirror_gre_neigh.sh        |  4 +--
 .../selftests/net/forwarding/mirror_gre_nh.sh |  6 ++--
 .../forwarding/mirror_gre_vlan_bridge_1q.sh   | 30 +++++++++----------
 .../selftests/net/forwarding/mirror_lib.sh    | 25 +++++-----------
 .../selftests/net/forwarding/mirror_vlan.sh   |  8 ++---
 10 files changed, 69 insertions(+), 90 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh b/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
index 76f1ab4898d9..47be3b269088 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
@@ -119,11 +119,11 @@ test_span_gre_ttl_inherit()
 
 	ip link set dev $tundev type $type ttl inherit
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	fail_test_span_gre_dir $tundev ingress
+	fail_test_span_gre_dir $tundev
 
 	ip link set dev $tundev type $type ttl 100
 
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
 	log_test "$what: no offload on TTL of inherit ($tcflags)"
@@ -139,10 +139,10 @@ test_span_gre_tos_fixed()
 
 	ip link set dev $tundev type $type tos 0x10
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	fail_test_span_gre_dir $tundev ingress
+	fail_test_span_gre_dir $tundev
 
 	ip link set dev $tundev type $type tos inherit
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
 	log_test "$what: no offload on a fixed TOS ($tcflags)"
@@ -158,9 +158,9 @@ test_span_failable()
 
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
 	if ((should_fail)); then
-	    fail_test_span_gre_dir  $tundev ingress
+	    fail_test_span_gre_dir  $tundev
 	else
-	    quick_test_span_gre_dir $tundev ingress
+	    quick_test_span_gre_dir $tundev
 	fi
 	mirror_uninstall $swp1 ingress
 
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre.sh b/tools/testing/selftests/net/forwarding/mirror_gre.sh
index 0266443601bc..00def4b04145 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre.sh
@@ -91,17 +91,17 @@ test_two_spans()
 
 	mirror_install $swp1 ingress gt4 "matchall $tcflags"
 	mirror_install $swp1 egress gt6 "matchall $tcflags"
-	quick_test_span_gre_dir gt4 ingress
-	quick_test_span_gre_dir gt6 egress
+	quick_test_span_gre_dir gt4
+	quick_test_span_gre_dir gt6
 
 	mirror_uninstall $swp1 ingress
-	fail_test_span_gre_dir gt4 ingress
-	quick_test_span_gre_dir gt6 egress
+	fail_test_span_gre_dir gt4
+	quick_test_span_gre_dir gt6
 
 	mirror_install $swp1 ingress gt4 "matchall $tcflags"
 	mirror_uninstall $swp1 egress
-	quick_test_span_gre_dir gt4 ingress
-	fail_test_span_gre_dir gt6 egress
+	quick_test_span_gre_dir gt4
+	fail_test_span_gre_dir gt6
 
 	mirror_uninstall $swp1 ingress
 	log_test "two simultaneously configured mirrors ($tcflags)"
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
index 5ea9d63915f7..3796f4256c9c 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
@@ -99,11 +99,11 @@ test_span_gre_tun_up()
 
 	ip link set dev $tundev down
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	fail_test_span_gre_dir $tundev ingress
+	fail_test_span_gre_dir $tundev
 
 	ip link set dev $tundev up
 
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
 	log_test "$what: tunnel down/up ($tcflags)"
@@ -119,7 +119,7 @@ test_span_gre_egress_up()
 
 	ip link set dev $swp3 down
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	fail_test_span_gre_dir $tundev ingress
+	fail_test_span_gre_dir $tundev
 
 	# After setting the device up, wait for neighbor to get resolved so that
 	# we can expect mirroring to work.
@@ -127,7 +127,7 @@ test_span_gre_egress_up()
 	setup_wait_dev $swp3
 	ping -c 1 -I $swp3 $remote_ip &>/dev/null
 
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
 	log_test "$what: egress down/up ($tcflags)"
@@ -145,10 +145,10 @@ test_span_gre_remote_ip()
 
 	ip link set dev $tundev type $type remote $wrong_ip
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	fail_test_span_gre_dir $tundev ingress
+	fail_test_span_gre_dir $tundev
 
 	ip link set dev $tundev type $type remote $correct_ip
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
 	log_test "$what: remote address change ($tcflags)"
@@ -166,9 +166,9 @@ test_span_gre_tun_del()
 	RET=0
 
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 	ip link del dev $tundev
-	fail_test_span_gre_dir $tundev ingress
+	fail_test_span_gre_dir $tundev
 
 	tunnel_create $tundev $type $local_ip $remote_ip \
 		      ttl 100 tos inherit $flags
@@ -177,7 +177,7 @@ test_span_gre_tun_del()
 	# and verify it works for the follow-up tests.
 	mirror_uninstall $swp1 ingress
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
 	log_test "$what: tunnel deleted ($tcflags)"
@@ -193,13 +193,13 @@ test_span_gre_route_del()
 	RET=0
 
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 
 	ip route del $route dev $edev
-	fail_test_span_gre_dir $tundev ingress
+	fail_test_span_gre_dir $tundev
 
 	ip route add $route dev $edev
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 
 	mirror_uninstall $swp1 ingress
 
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh b/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh
index 6efdd944f59f..c7d532e6f31e 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh
@@ -65,20 +65,18 @@ cleanup()
 test_span_gre_dir_acl()
 {
 	local tundev=$1; shift
-	local direction=$1; shift
 	local forward_type=$1; shift
 	local backward_type=$1; shift
 
-	test_span_gre_dir_ips "$tundev" "$direction" "$forward_type" \
+	test_span_gre_dir_ips "$tundev" "$forward_type" \
 			      "$backward_type" 192.0.2.3 192.0.2.4
 }
 
 fail_test_span_gre_dir_acl()
 {
 	local tundev=$1; shift
-	local direction=$1; shift
 
-	fail_test_span_gre_dir_ips "$tundev" "$direction" 192.0.2.3 192.0.2.4
+	fail_test_span_gre_dir_ips "$tundev" 192.0.2.3 192.0.2.4
 }
 
 full_test_span_gre_dir_acl()
@@ -94,13 +92,12 @@ full_test_span_gre_dir_acl()
 
 	mirror_install $swp1 $direction $tundev \
 		       "protocol ip flower $tcflags dst_ip $match_dip"
-	fail_test_span_gre_dir $tundev $direction
-	test_span_gre_dir_acl "$tundev" "$direction" \
-			  "$forward_type" "$backward_type"
+	fail_test_span_gre_dir $tundev
+	test_span_gre_dir_acl "$tundev" "$forward_type" "$backward_type"
 	mirror_uninstall $swp1 $direction
 
 	# Test lack of mirroring after ACL mirror is uninstalled.
-	fail_test_span_gre_dir_acl "$tundev" "$direction"
+	fail_test_span_gre_dir_acl "$tundev"
 
 	log_test "$direction $what ($tcflags)"
 }
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
index da2fd028e2e3..2bed2a4013aa 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
@@ -5,33 +5,30 @@ source "$net_forwarding_dir/mirror_lib.sh"
 quick_test_span_gre_dir_ips()
 {
 	local tundev=$1; shift
-	local direction=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
 
-	do_test_span_dir_ips 10 h3-$tundev "$direction" "$ip1" "$ip2"
+	do_test_span_dir_ips 10 h3-$tundev "$ip1" "$ip2"
 }
 
 fail_test_span_gre_dir_ips()
 {
 	local tundev=$1; shift
-	local direction=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
 
-	do_test_span_dir_ips 0 h3-$tundev "$direction" "$ip1" "$ip2"
+	do_test_span_dir_ips 0 h3-$tundev "$ip1" "$ip2"
 }
 
 test_span_gre_dir_ips()
 {
 	local tundev=$1; shift
-	local direction=$1; shift
 	local forward_type=$1; shift
 	local backward_type=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
 
-	test_span_dir_ips h3-$tundev "$direction" "$forward_type" \
+	test_span_dir_ips h3-$tundev "$forward_type" \
 			  "$backward_type" "$ip1" "$ip2"
 }
 
@@ -48,7 +45,7 @@ full_test_span_gre_dir_ips()
 	RET=0
 
 	mirror_install $swp1 $direction $tundev "matchall $tcflags"
-	test_span_dir_ips "h3-$tundev" "$direction" "$forward_type" \
+	test_span_dir_ips "h3-$tundev" "$forward_type" \
 			  "$backward_type" "$ip1" "$ip2"
 	mirror_uninstall $swp1 $direction
 
@@ -70,7 +67,7 @@ full_test_span_gre_dir_vlan_ips()
 
 	mirror_install $swp1 $direction $tundev "matchall $tcflags"
 
-	test_span_dir_ips "h3-$tundev" "$direction" "$forward_type" \
+	test_span_dir_ips "h3-$tundev" "$forward_type" \
 			  "$backward_type" "$ip1" "$ip2"
 
 	tc filter add dev $h3 ingress pref 77 prot 802.1q \
@@ -87,17 +84,15 @@ full_test_span_gre_dir_vlan_ips()
 quick_test_span_gre_dir()
 {
 	local tundev=$1; shift
-	local direction=$1; shift
 
-	quick_test_span_gre_dir_ips "$tundev" "$direction" 192.0.2.1 192.0.2.2
+	quick_test_span_gre_dir_ips "$tundev" 192.0.2.1 192.0.2.2
 }
 
 fail_test_span_gre_dir()
 {
 	local tundev=$1; shift
-	local direction=$1; shift
 
-	fail_test_span_gre_dir_ips "$tundev" "$direction" 192.0.2.1 192.0.2.2
+	fail_test_span_gre_dir_ips "$tundev" 192.0.2.1 192.0.2.2
 }
 
 test_span_gre_dir()
@@ -149,15 +144,15 @@ full_test_span_gre_stp_ips()
 	RET=0
 
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	quick_test_span_gre_dir_ips $tundev ingress $ip1 $ip2
+	quick_test_span_gre_dir_ips $tundev $ip1 $ip2
 
 	bridge link set dev $nbpdev state disabled
 	sleep 1
-	fail_test_span_gre_dir_ips $tundev ingress $ip1 $ip2
+	fail_test_span_gre_dir_ips $tundev $ip1 $ip2
 
 	bridge link set dev $nbpdev state forwarding
 	sleep 1
-	quick_test_span_gre_dir_ips $tundev ingress $ip1 $ip2
+	quick_test_span_gre_dir_ips $tundev $ip1 $ip2
 
 	mirror_uninstall $swp1 ingress
 
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh b/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh
index fc0508e40fca..0f2c38eca2a3 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh
@@ -66,9 +66,9 @@ test_span_gre_neigh()
 
 	ip neigh replace dev $swp3 $addr lladdr 00:11:22:33:44:55
 	mirror_install $swp1 $direction $tundev "matchall $tcflags"
-	fail_test_span_gre_dir $tundev ingress
+	fail_test_span_gre_dir $tundev
 	ip neigh del dev $swp3 $addr
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 $direction
 
 	log_test "$direction $what: neighbor change ($tcflags)"
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_nh.sh b/tools/testing/selftests/net/forwarding/mirror_gre_nh.sh
index 6f9ef1820e93..2011dad06cf4 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_nh.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_nh.sh
@@ -81,10 +81,10 @@ test_gretap()
 	# the traffic to tunnel remote address. Then add it and test that
 	# mirroring starts. For IPv6 we can't test this due to the limitation
 	# that routes for locally-specified IPv6 addresses can't be added.
-	fail_test_span_gre_dir gt4 ingress
+	fail_test_span_gre_dir gt4
 
 	ip route add 192.0.2.130/32 via 192.0.2.162
-	quick_test_span_gre_dir gt4 ingress
+	quick_test_span_gre_dir gt4
 	ip route del 192.0.2.130/32 via 192.0.2.162
 
 	mirror_uninstall $swp1 ingress
@@ -96,7 +96,7 @@ test_ip6gretap()
 	RET=0
 
 	mirror_install $swp1 ingress gt6 "matchall $tcflags"
-	quick_test_span_gre_dir gt6 ingress
+	quick_test_span_gre_dir gt6
 	mirror_uninstall $swp1 ingress
 
 	log_test "mirror to ip6gre with next-hop remote ($tcflags)"
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
index c8a9b5bd841f..b49b70416e32 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
@@ -154,16 +154,16 @@ test_span_gre_forbidden_cpu()
 
 	# Run the pass-test first, to prime neighbor table.
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 
 	# Now forbid the VLAN at the bridge and see it fail.
 	bridge vlan del dev br1 vid 555 self
 	sleep 1
-	fail_test_span_gre_dir $tundev ingress
+	fail_test_span_gre_dir $tundev
 
 	bridge vlan add dev br1 vid 555 self
 	sleep 1
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 
 	mirror_uninstall $swp1 ingress
 
@@ -188,17 +188,17 @@ test_span_gre_forbidden_egress()
 	RET=0
 
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 
 	bridge vlan del dev $swp3 vid 555
 	sleep 1
-	fail_test_span_gre_dir $tundev ingress
+	fail_test_span_gre_dir $tundev
 
 	bridge vlan add dev $swp3 vid 555
 	# Re-prime FDB
 	$ARPING -I br1.555 192.0.2.130 -fqc 1
 	sleep 1
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 
 	mirror_uninstall $swp1 ingress
 
@@ -225,24 +225,24 @@ test_span_gre_untagged_egress()
 
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
 
-	quick_test_span_gre_dir $tundev ingress
-	quick_test_span_vlan_dir $h3 555 ingress "$ul_proto"
+	quick_test_span_gre_dir $tundev
+	quick_test_span_vlan_dir $h3 555 "$ul_proto"
 
 	h3_addr_add_del del $h3.555
 	bridge vlan add dev $swp3 vid 555 pvid untagged
 	h3_addr_add_del add $h3
 	sleep 5
 
-	quick_test_span_gre_dir $tundev ingress
-	fail_test_span_vlan_dir $h3 555 ingress "$ul_proto"
+	quick_test_span_gre_dir $tundev
+	fail_test_span_vlan_dir $h3 555 "$ul_proto"
 
 	h3_addr_add_del del $h3
 	bridge vlan add dev $swp3 vid 555
 	h3_addr_add_del add $h3.555
 	sleep 5
 
-	quick_test_span_gre_dir $tundev ingress
-	quick_test_span_vlan_dir $h3 555 ingress "$ul_proto"
+	quick_test_span_gre_dir $tundev
+	quick_test_span_vlan_dir $h3 555 "$ul_proto"
 
 	mirror_uninstall $swp1 ingress
 
@@ -268,13 +268,13 @@ test_span_gre_fdb_roaming()
 	RET=0
 
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 
 	while ((RET == 0)); do
 		bridge fdb del dev $swp3 $h3mac vlan 555 master 2>/dev/null
 		bridge fdb add dev $swp2 $h3mac vlan 555 master static
 		sleep 1
-		fail_test_span_gre_dir $tundev ingress
+		fail_test_span_gre_dir $tundev
 
 		if ! bridge fdb sh dev $swp2 vlan 555 master \
 		    | grep -q $h3mac; then
@@ -292,7 +292,7 @@ test_span_gre_fdb_roaming()
 	# Re-prime FDB
 	$ARPING -I br1.555 192.0.2.130 -fqc 1
 	sleep 1
-	quick_test_span_gre_dir $tundev ingress
+	quick_test_span_gre_dir $tundev
 
 	mirror_uninstall $swp1 ingress
 
diff --git a/tools/testing/selftests/net/forwarding/mirror_lib.sh b/tools/testing/selftests/net/forwarding/mirror_lib.sh
index b5b0a6545d75..ee0fd71ad2fd 100644
--- a/tools/testing/selftests/net/forwarding/mirror_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_lib.sh
@@ -59,7 +59,6 @@ do_test_span_dir_ips()
 {
 	local expect=$1; shift
 	local dev=$1; shift
-	local direction=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
 
@@ -72,11 +71,10 @@ do_test_span_dir_ips()
 quick_test_span_dir_ips()
 {
 	local dev=$1; shift
-	local direction=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
 
-	do_test_span_dir_ips 10 "$dev" "$direction" "$ip1" "$ip2"
+	do_test_span_dir_ips 10 "$dev" "$ip1" "$ip2"
 }
 
 fail_test_span_dir_ips()
@@ -92,13 +90,12 @@ fail_test_span_dir_ips()
 test_span_dir_ips()
 {
 	local dev=$1; shift
-	local direction=$1; shift
 	local forward_type=$1; shift
 	local backward_type=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
 
-	quick_test_span_dir_ips "$dev" "$direction" "$ip1" "$ip2"
+	quick_test_span_dir_ips "$dev" "$ip1" "$ip2"
 
 	icmp_capture_install $dev "type $forward_type"
 	mirror_test v$h1 $ip1 $ip2 $dev 100 10
@@ -120,11 +117,10 @@ fail_test_span_dir()
 test_span_dir()
 {
 	local dev=$1; shift
-	local direction=$1; shift
 	local forward_type=$1; shift
 	local backward_type=$1; shift
 
-	test_span_dir_ips "$dev" "$direction" "$forward_type" "$backward_type" \
+	test_span_dir_ips "$dev" "$forward_type" "$backward_type" \
 			  192.0.2.1 192.0.2.2
 }
 
@@ -133,7 +129,6 @@ do_test_span_vlan_dir_ips()
 	local expect=$1; shift
 	local dev=$1; shift
 	local vid=$1; shift
-	local direction=$1; shift
 	local ul_proto=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
@@ -151,36 +146,31 @@ quick_test_span_vlan_dir_ips()
 {
 	local dev=$1; shift
 	local vid=$1; shift
-	local direction=$1; shift
 	local ul_proto=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
 
-	do_test_span_vlan_dir_ips 10 "$dev" "$vid" "$direction" "$ul_proto" \
-				  "$ip1" "$ip2"
+	do_test_span_vlan_dir_ips 10 "$dev" "$vid" "$ul_proto" "$ip1" "$ip2"
 }
 
 fail_test_span_vlan_dir_ips()
 {
 	local dev=$1; shift
 	local vid=$1; shift
-	local direction=$1; shift
 	local ul_proto=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
 
-	do_test_span_vlan_dir_ips 0 "$dev" "$vid" "$direction" "$ul_proto" \
-				  "$ip1" "$ip2"
+	do_test_span_vlan_dir_ips 0 "$dev" "$vid" "$ul_proto" "$ip1" "$ip2"
 }
 
 quick_test_span_vlan_dir()
 {
 	local dev=$1; shift
 	local vid=$1; shift
-	local direction=$1; shift
 	local ul_proto=$1; shift
 
-	quick_test_span_vlan_dir_ips "$dev" "$vid" "$direction" "$ul_proto" \
+	quick_test_span_vlan_dir_ips "$dev" "$vid" "$ul_proto" \
 				     192.0.2.1 192.0.2.2
 }
 
@@ -188,9 +178,8 @@ fail_test_span_vlan_dir()
 {
 	local dev=$1; shift
 	local vid=$1; shift
-	local direction=$1; shift
 	local ul_proto=$1; shift
 
-	fail_test_span_vlan_dir_ips "$dev" "$vid" "$direction" "$ul_proto" \
+	fail_test_span_vlan_dir_ips "$dev" "$vid" "$ul_proto" \
 				    192.0.2.1 192.0.2.2
 }
diff --git a/tools/testing/selftests/net/forwarding/mirror_vlan.sh b/tools/testing/selftests/net/forwarding/mirror_vlan.sh
index 0b44e148235e..074165f46a9d 100755
--- a/tools/testing/selftests/net/forwarding/mirror_vlan.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_vlan.sh
@@ -64,7 +64,7 @@ test_vlan_dir()
 	RET=0
 
 	mirror_install $swp1 $direction $swp3.555 "matchall $tcflags"
-	test_span_dir "$h3.555" "$direction" "$forward_type" "$backward_type"
+	test_span_dir "$h3.555" "$forward_type" "$backward_type"
 	mirror_uninstall $swp1 $direction
 
 	log_test "$direction mirror to vlan ($tcflags)"
@@ -85,10 +85,8 @@ test_tagged_vlan_dir()
 	RET=0
 
 	mirror_install $swp1 $direction $swp3.555 "matchall $tcflags"
-	do_test_span_vlan_dir_ips 10 "$h3.555" 111 "$direction" ip \
-				  192.0.2.17 192.0.2.18
-	do_test_span_vlan_dir_ips  0 "$h3.555" 555 "$direction" ip \
-				  192.0.2.17 192.0.2.18
+	do_test_span_vlan_dir_ips 10 "$h3.555" 111 ip 192.0.2.17 192.0.2.18
+	do_test_span_vlan_dir_ips  0 "$h3.555" 555 ip 192.0.2.17 192.0.2.18
 	mirror_uninstall $swp1 $direction
 
 	log_test "$direction mirror tagged to vlan ($tcflags)"
-- 
2.45.0


