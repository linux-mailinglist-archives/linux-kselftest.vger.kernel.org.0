Return-Path: <linux-kselftest+bounces-20560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8139AECF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 18:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5D31C21AD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19641FBF45;
	Thu, 24 Oct 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iuD4m0q7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DB1F9EB4;
	Thu, 24 Oct 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789155; cv=fail; b=tuIPncnL6oijDP3O4fIDoconuQOC5a5fpE2ZTcWNrdVYJ4vRIsAbJQ3XnSpC59mWrcEC5b+JEQxcvxxJsmzpagyRTfIyu0qWrq0bO87DzFMJudQGU8LtvMSxLaDWC9tY88p0Jgdw2VdgLJUl9H0bJzOCncXGsL2yCbUjd/4opC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789155; c=relaxed/simple;
	bh=Za/wZNUdZpKGdGfqsUXM/Us6k9nRkv9bLiBP//c+rYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STUQ1Z7S8BGUcwknCgIn25xGfMsDkZcJU807OSN5odqphV8GdMyQOlunGFtMhkzrlvktR1S/Sw9xaCMgMWPlET1+sretVxR6IRFTjffZAMcNbhrB47H0DlRbAkSTajKQqQnt/acqTCQs3he5kBPHKxu/nUcxc98rAxppoc5Apro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iuD4m0q7; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no2kuGHg8EUX5dxFIE//SuLnx4p1gkkYMeoUGNsa+bPK8fsZHxiZZsc1uXeqi7NrLJuJXhbmkQtZMq35hVDwdFEc5IQ6Tpj6hf7mMlY23GY2NDn/PaUzquN6uMcFv/lhlCN4f+vEUvdXyCguwO36pEB58bSMvY7+7o4gnppgAvLp2UsIwWWoIvf320uVw0PmEPyOakMwBpPhU3JjlxVQjP3KtRjQBpm4ywMI8eolsNprnmCFiq5U7OYIQqzpHVVF+fji6/YPdCS1i1YQ+XSjk8erdGgQ4SYY2M6/rBbD0RjqNRSO7mgCaNXZi10Bhr8b46+bkydSuBhhj0beYQxiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rq6vivG0V/8Xg5flvI8sdeUp8jHh7+IgZY+tHhZ3HeI=;
 b=NvO6/pGLkbENmMAWp771m4GUuEDPN8kgN7ii5NjcSc1KGr0Q7LpXdj+1gnN4dDYzKR4YGWvxjS1VbiMx2Q67+aJmBa7YA7Sfjqo4Xu9br014r83k4wiSMg58PSFInCleyQtyfp4cAjKRdD4UdQD90r3lNOslos+w7N/ig+I6JmOxtm8yx6pVs59YmQDrdFpJG4Wzc3cyff7HH4ucqXBfjiM/HSao9l0b9fnah2GV7Ci64pUnVh8TvK9dip69EKXhWu8uwvdVgnRa7FaM1KXTnemt33hUhh0N8/1hchTfC5wUDM7EK95nw92RFeaMmw9/ZRXieu46CTcNmNXcqqJsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq6vivG0V/8Xg5flvI8sdeUp8jHh7+IgZY+tHhZ3HeI=;
 b=iuD4m0q7YveBbRJOL1jUVAWVluaOZx54MPsX6PLcM7kP/6QYISO2/sm31d7Jnh5zGVIFqB7ekDyeNtD/wB3ruhC6m/OvoZOXwH6+0pQu6X3IaaBrNFRLrfsP2Tu42xqvKjjuuEWc12VPq+SaTZaydEPfyVr2zcUK2RAO1h53sth2EwDWI9y9UClYZKpWTlu0EiFUnSe645qS9pTbzpTtFQcotdxRgzAgBFsvBIgSR9Ybj1upb0VcZjNPVh4plzEB8kiQsA32coRVZq5/1Sl3B0yc0ZSriEFfXo/Li25fiFB2qBttJlugFslHwVD3It3lHBcZUU7C0eMX74O9Fu93nA==
Received: from SJ0PR03CA0390.namprd03.prod.outlook.com (2603:10b6:a03:3a1::35)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 16:59:07 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ba) by SJ0PR03CA0390.outlook.office365.com
 (2603:10b6:a03:3a1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Thu, 24 Oct 2024 16:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:59:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:51 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:43 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Andy
 Roulin" <aroulin@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<linux-kselftest@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Andrew Lunn
	<andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 7/8] selftests: net: lib: Add kill_process
Date: Thu, 24 Oct 2024 18:57:42 +0200
Message-ID: <b016bbab3250c60aec6b4dfdad854673845cd4b5.1729786087.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729786087.git.petrm@nvidia.com>
References: <cover.1729786087.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c5eeae-48a8-4f13-de0d-08dcf44d2c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ykhgk9PJOCSuaK1s9Rjzfl87dB6SvudTNQiPjP+egWU53Rilpuabli7Bb1xV?=
 =?us-ascii?Q?+WHM7/8uYfchk2MIAlUANGv8tQhH3ClbjJChqqKpQJr0qo4TdmoWbYCyFh9e?=
 =?us-ascii?Q?puFS0NaWQqJV8Lo56OkIFWq2ZXGP0PdNWDBVfEk8v/1guhwPIHX1JZ7ltZwY?=
 =?us-ascii?Q?uO1pRUbBPCHN3mCVijRKxUQEPt4NiLGyJbXL8gjFjcIJPlouvTOSOQz78tlt?=
 =?us-ascii?Q?wYVjxvZdDH4WBtvJazS9+8+t4NXiKz62WoLJPboyhvQrnC4etC9WMITS0iXA?=
 =?us-ascii?Q?TStFukte+lpfUlSa5jN16wCeEiac4hQGewWPeA5++i9Y1hK2Ue/nASHyIGrP?=
 =?us-ascii?Q?bkClis87egwfasJ9jsSVrn5rmZjnHK2brlgGbIowkdp2QHtj8+Uvp1cpk6yq?=
 =?us-ascii?Q?54nij619mqsj3u5sf6i7yOQPmL+UIuKIBde1+SM37X2WB7NH5131/01b6iOK?=
 =?us-ascii?Q?d5weB7XkZMnFl85h1ckGi/ed19M4l4GMIEEnV9csSl6L6kWe0DO6cVgSo3gN?=
 =?us-ascii?Q?G/LEdsRFTpeNdgM3kGkQeYucc3WHxSyFA3bs6QHDFk0U8iG1UhDAcfKvO7f+?=
 =?us-ascii?Q?dpzN1psFOx1uuE5/OAYat4rI3y8ifc+3J+NjFUiC06d9fuZ/FcBK/BVngBCu?=
 =?us-ascii?Q?Eey7jxNE0fns7I1JVetfHfahI6cH4MKE2pMK+62HHMEsmqc5PisZ77Su5cgf?=
 =?us-ascii?Q?ewxbfAjjpcWDVVhXgoPYxbjbyLyKU2STr9BZjisVfekK926QUBNEvgZi7lee?=
 =?us-ascii?Q?WgFV8Ek5aTOevvK85fnVBwRLVHsMp+mklpTal0l6lLLNH3PRiAuuRDPHViGZ?=
 =?us-ascii?Q?8FUU5G3AungAbfoWt/H2G+DsjwwLqJD2CSOgP092UYUAXSP/6Ufez7klY4zY?=
 =?us-ascii?Q?KfGsZLMyWvjrhAZ6EDbEEV7glL+sz1Q8RBEeAqcKkbilzhtIHb+S0q8xAZs1?=
 =?us-ascii?Q?kv2t08YszNcG3YiSuVUdG4fuLfmp+jbT07zzxfl66NUtruusDTXjm0LDwySZ?=
 =?us-ascii?Q?VO2rQbB3fnDzrvPq2gkeGn6u5SuTaynYytE17GbKhucyXQl7aWwa5FttUtqm?=
 =?us-ascii?Q?xvUZzgSt/tGzWPkbJfxgzM8r6Xd0LlZlWQC866vZ9I8rqLVtSG5nQEKrjvtZ?=
 =?us-ascii?Q?psIphV+PMeQcR68JP5dfVcCoYrtfQEh8n2law+nMmixSUIhgo53gOOhaPPTU?=
 =?us-ascii?Q?o6gLzSafyubJPt4mSLuK6eF/ttHbY3+SMX0vMvqjcV++D7ItpuPEhj7v9Gdk?=
 =?us-ascii?Q?9P9jBequIpqdkYCYyR+Ymt/+2XVdmBIADE29F/4zm7JsAbe8aM3Bv+qCuBhb?=
 =?us-ascii?Q?EnQkX6QpG7aE/r9I57YP0VC3OqdW+UgaCMPcoHyoOJO7CjH1AdYlDDO/fB3T?=
 =?us-ascii?Q?ceVD+TajDMFKI+8QGNlGh5JfNRi1owncJHJprXH4fZTOuaUhHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:59:06.8800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c5eeae-48a8-4f13-de0d-08dcf44d2c1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750

A number of selftests run processes in the background and need to kill them
afterwards. Instead for everyone to open-code the kill / wait / redirect
mantra, add a helper in net/lib.sh. Convert existing open-code sites.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>
CC: Andrew Lunn <andrew+netdev@lunn.ch>
---

 .../selftests/drivers/net/mlxsw/devlink_trap.sh      |  2 +-
 .../drivers/net/mlxsw/devlink_trap_l3_drops.sh       |  4 ++--
 .../drivers/net/mlxsw/devlink_trap_l3_exceptions.sh  | 12 ++++++------
 .../drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh    |  4 ++--
 .../drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh   |  4 ++--
 .../drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh   |  4 ++--
 .../net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh      |  4 ++--
 .../testing/selftests/drivers/net/mlxsw/tc_sample.sh |  4 ++--
 .../drivers/net/netdevsim/fib_notifications.sh       |  6 +++---
 tools/testing/selftests/net/drop_monitor_tests.sh    |  2 +-
 tools/testing/selftests/net/fib_tests.sh             |  8 ++++----
 .../testing/selftests/net/forwarding/devlink_lib.sh  |  2 +-
 tools/testing/selftests/net/forwarding/lib.sh        |  3 +--
 tools/testing/selftests/net/forwarding/tc_police.sh  |  8 ++++----
 tools/testing/selftests/net/lib.sh                   |  8 ++++++++
 15 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh
index 89b55e946eed..36055279ba92 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh
@@ -116,7 +116,7 @@ dev_del_test()
 
 	log_test "Device delete"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 }
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh
index 160891dcb4bc..db5806d189bb 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh
@@ -595,7 +595,7 @@ irif_disabled_test()
 
 	log_test "Ingress RIF disabled"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	ip link set dev $rp1 nomaster
 	__addr_add_del $rp1 add 192.0.2.2/24 2001:db8:1::2/64
 	ip link del dev br0 type bridge
@@ -645,7 +645,7 @@ erif_disabled_test()
 
 	log_test "Egress RIF disabled"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	__addr_add_del $rp1 add 192.0.2.2/24 2001:db8:1::2/64
 	ip link del dev br0 type bridge
 	devlink_trap_action_set $trap_name "drop"
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh
index 190c1b6b5365..5d6d88b600f0 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh
@@ -202,7 +202,7 @@ mtu_value_is_too_small_test()
 
 	mtu_restore $rp2
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $h1 ingress protocol ip pref 1 handle 101 flower
 }
 
@@ -235,7 +235,7 @@ __ttl_value_is_too_small_test()
 
 	log_test "TTL value is too small: TTL=$ttl_val"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $h1 ingress protocol ip pref 1 handle 101 flower
 }
 
@@ -299,7 +299,7 @@ __mc_reverse_path_forwarding_test()
 
 	log_test "Multicast reverse path forwarding: $desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $rp2 egress protocol $proto pref 1 handle 101 flower
 }
 
@@ -347,7 +347,7 @@ __reject_route_test()
 
 	log_test "Reject route: $desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	ip route del unreachable $unreachable
 	tc filter del dev $h1 ingress protocol $proto pref 1 handle 101 flower
 }
@@ -542,7 +542,7 @@ ipv4_lpm_miss_test()
 
 	log_test "LPM miss: IPv4"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	vrf_without_routes_destroy
 }
 
@@ -569,7 +569,7 @@ ipv6_lpm_miss_test()
 
 	log_test "LPM miss: IPv6"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	vrf_without_routes_destroy
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh
index e9a82cae8c9a..4ac1dae92d0f 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh
@@ -176,7 +176,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
@@ -207,7 +207,7 @@ no_matching_tunnel_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh
index 878125041fc3..fce885184404 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh
@@ -176,7 +176,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
@@ -207,7 +207,7 @@ no_matching_tunnel_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh
index 5f6eb965cfd1..7aca8e5922cf 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh
@@ -183,7 +183,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
@@ -253,7 +253,7 @@ corrupted_packet_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh
index f6c16cbb6cf7..4599c331240b 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh
@@ -188,7 +188,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
@@ -262,7 +262,7 @@ corrupted_packet_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh b/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh
index 83a0210e7544..bc7ea2df49fb 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh
@@ -218,7 +218,7 @@ psample_capture_start()
 
 psample_capture_stop()
 {
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 }
 
 __tc_sample_rate_test()
@@ -499,7 +499,7 @@ tc_sample_md_out_tc_occ_test()
 	backlog=$(tc -j -p -s qdisc show dev $rp2 | jq '.[0]["backlog"]')
 
 	# Kill mausezahn.
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 
 	psample_capture_stop
 
diff --git a/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh b/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
index 8d91191a098c..9896580c3d85 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
@@ -94,7 +94,7 @@ route_addition_check()
 	sleep 1
 	$IP route add $route dev dummy1
 	sleep 1
-	kill %% && wait %% &> /dev/null
+	kill_process %%
 
 	route_notify_check $outfile $expected_num_notifications $offload_failed
 	rm -f $outfile
@@ -148,7 +148,7 @@ route_deletion_check()
 	sleep 1
 	$IP route del $route dev dummy1
 	sleep 1
-	kill %% && wait %% &> /dev/null
+	kill_process %%
 
 	route_notify_check $outfile $expected_num_notifications
 	rm -f $outfile
@@ -191,7 +191,7 @@ route_replacement_check()
 	sleep 1
 	$IP route replace $route dev dummy2
 	sleep 1
-	kill %% && wait %% &> /dev/null
+	kill_process %%
 
 	route_notify_check $outfile $expected_num_notifications
 	rm -f $outfile
diff --git a/tools/testing/selftests/net/drop_monitor_tests.sh b/tools/testing/selftests/net/drop_monitor_tests.sh
index 7c4818c971fc..507d0a82f5f0 100755
--- a/tools/testing/selftests/net/drop_monitor_tests.sh
+++ b/tools/testing/selftests/net/drop_monitor_tests.sh
@@ -77,7 +77,7 @@ sw_drops_test()
 
 	rm ${dir}/packets.pcap
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	timeout 5 dwdump -o sw -w ${dir}/packets.pcap
 	(( $(tshark -r ${dir}/packets.pcap \
 		-Y 'ip.dst == 192.0.2.10' 2> /dev/null | wc -l) == 0))
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 5f3c28fc8624..3ea6f886a210 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -689,7 +689,7 @@ fib6_notify_test()
 
 	log_test $ret 0 "ipv6 route add notify"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 
 	#rm errors.txt
 
@@ -736,7 +736,7 @@ fib_notify_test()
 
 	log_test $ret 0 "ipv4 route add notify"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 
 	rm  errors.txt
 
@@ -2328,7 +2328,7 @@ ipv4_mangle_test()
 	$IP route del table 123 172.16.101.0/24 dev veth1
 	$IP rule del pref 100
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	rm $tmp_file
 
 	route_cleanup
@@ -2386,7 +2386,7 @@ ipv6_mangle_test()
 	$IP -6 route del table 123 2001:db8:101::/64 dev veth1
 	$IP -6 rule del pref 100
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	rm $tmp_file
 
 	route_cleanup
diff --git a/tools/testing/selftests/net/forwarding/devlink_lib.sh b/tools/testing/selftests/net/forwarding/devlink_lib.sh
index 62a05bca1e82..18afa89ebbcc 100644
--- a/tools/testing/selftests/net/forwarding/devlink_lib.sh
+++ b/tools/testing/selftests/net/forwarding/devlink_lib.sh
@@ -501,7 +501,7 @@ devlink_trap_drop_cleanup()
 	local pref=$1; shift
 	local handle=$1; shift
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $dev egress protocol $proto pref $pref handle $handle flower
 }
 
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8625e3c99f55..7337f398f9cc 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1574,8 +1574,7 @@ stop_traffic()
 {
 	local pid=${1-%%}; shift
 
-	# Suppress noise from killing mausezahn.
-	{ kill $pid && wait $pid; } 2>/dev/null
+	kill_process "$pid"
 }
 
 declare -A cappid
diff --git a/tools/testing/selftests/net/forwarding/tc_police.sh b/tools/testing/selftests/net/forwarding/tc_police.sh
index 5103f64a71d6..509fdedfcfa1 100755
--- a/tools/testing/selftests/net/forwarding/tc_police.sh
+++ b/tools/testing/selftests/net/forwarding/tc_police.sh
@@ -148,7 +148,7 @@ police_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 }
 
@@ -198,7 +198,7 @@ police_shared_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 }
 
 police_shared_test()
@@ -278,7 +278,7 @@ police_mirror_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	tc filter del dev $pol_if $dir protocol ip pref 1 handle 101 flower
 	tc filter del dev $h3 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
@@ -320,7 +320,7 @@ police_pps_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 6bcf5d13879d..24f63e45735d 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -434,3 +434,11 @@ xfail_on_veth()
 		"$@"
 	fi
 }
+
+kill_process()
+{
+	local pid=$1; shift
+
+	# Suppress noise from killing the process.
+	{ kill $pid && wait $pid; } 2>/dev/null
+}
-- 
2.45.0


