Return-Path: <linux-kselftest+bounces-42400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB4BA0E90
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB781C24E04
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316ED315D58;
	Thu, 25 Sep 2025 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h+T/SmxV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F59315D52;
	Thu, 25 Sep 2025 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821693; cv=fail; b=WQvdMsQvqFW3/fr+6VDeOG5U1h+dayBJq9qOHc1miktxHjxwi/xtR1rjs/QJgliq3u+mcVlZubucGUPalkmWbM283idPMaNeUVhf1I1d2C3mGRusrIrBr8gGbYVlvNlFmqvt3FoX6nliJ5MenQKldxsMM1LwXFDMnNfWBQiJKS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821693; c=relaxed/simple;
	bh=MKblkAJbu7gHO4e3hUBParoV+F2U8FPfU84oAeJ2LSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqWpe0s4k7NJaywkZXJTqKVJ6XgmWjohgfCqcTXc+L1CogbNV3XWjsfHMi9d3IZHSk8YelDYN1Y0i176BEDbORjnMpZGeyDK223Dqq1dKV9X7cHRM8UyxQnVyMUWpSuHcjrhTE2wdQvQMRDeoy5NFjrv0ved5uXQaFvKjOapeQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h+T/SmxV; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCnVst5UgJZwzfbTN6+o+GuoTfYSylm/2cwLJV7iTJZzS4yTSp5sm4lksb2PVnTjsD8TGAGt57NsQWtVZyiuEL5zETz+ZhT16I/0+uAp03T4ei8vSTVbdT8IxvQdVIHx7QBXH2iB0NMD21lz5uJdwAn6pJSCPpBUWd7U2eYoNDggzQVyNz0J5GcSavLW6eUDewHtzbebIuUGV0857Hoki3cZKjPCjflZzujjhpkywzakLiArevoDKH3HWpG4VpNGihblRSDSICbyIVxqejFCpOO7UbvQHn1nr50nAAoTzEwNTaG+Syy6RTQXBrM43/VcGVQ3qyWW22jOKse+bQBmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8DYFrIfmf30MMkI8vDJJXARIMIdG7KEbS9QWoGr0EE=;
 b=K+zZWUEQw9lg/MAshjwoFqw0aA/0hBYzsOVbTOtZL+hZ9UwpkRgqsfniYf9oIK0+0RJkxT3WVLfTuBEG9L7RbAqV1wIfAK6wDzr06m8zOribqsz0vqf1rPucOR2i9i77lx9KaGzzQi51i0t/raHlXb9QM/nWOw5RteJ4TP4wooYxItAG+J/UCq7TO5t3hZTw/rOxH6gx2Gl9jmWQWwz5Zach0CVec1iLgrBR8lRU8B21sGWXgTvnSUhiVaWuZC2XWkYTRPkm7fI/1b9Ws4bAPoB+4Whg69xvS5cv5+EOZ9ZHEFjVqDGUJNtCiVUFwxITiT4KGC+YpM3/Hpd4/UfaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8DYFrIfmf30MMkI8vDJJXARIMIdG7KEbS9QWoGr0EE=;
 b=h+T/SmxVRND++3xeJhNwqniXvi2nDO5VRAXuNnMOVY4lVODGYxLJyql5jBYqR+NfQg9hXbV0IwCVfnd/Ngd6zFNQbG9nC0KCLJCY2PZujhFywzDl98ler8soWi3JIXnOeRgR2wILN7lhy5bjzOh9w/4UL0lLM1VWiqF6A1XJiD/+f+Jqv2jYY0qdyXiKpQtBYnkpV+p0aSqV971JLjQ8fKeNXmlwhEdDboLhGwfvTajhXd6cJlxJQlSiYG97goM5zSLp67p5/kuzXShp8KUsxx3lwS9+L6yJ4+Xd3/5MWd+/npWnww3x9CbwVVPXy7tiWSzANPGhrwmOcx/QCrdTDA==
Received: from CH2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:610:4d::36)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 17:34:44 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::3c) by CH2PR19CA0026.outlook.office365.com
 (2603:10b6:610:4d::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 17:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:34:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 25 Sep
 2025 10:34:27 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:34:20 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Alessandro Zanni
	<alessandro.zanni87@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, "David
 Yang" <mmyangfl@gmail.com>, Li Shuang <shuali@redhat.com>
Subject: [PATCH net-next 11/13] selftests: forwarding: lib: Add an autodefer variant of simple_if_init()
Date: Thu, 25 Sep 2025 19:31:54 +0200
Message-ID: <6b9ee1a7946a36fd32a47fdb1aa9325198ffc695.1758821127.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758821127.git.petrm@nvidia.com>
References: <cover.1758821127.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2ee6ab-7853-45c7-6aee-08ddfc59d0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xn7RJti/ptuE2GuO/HhXVsPS4XkYAl7Pf3OnXyqbWBswPNfToHTHWvWC5oaV?=
 =?us-ascii?Q?pX03kaNiSLJVEmnZm9RpomQi46O/trSpKAaSiy3GWNr0cvi7n1MnAaQm6T5K?=
 =?us-ascii?Q?4uS0FamtrRNxnfmmonMp2d5wq5AGcUKewyYvBMRbaVXVZNUDY6bSVEbkfIUz?=
 =?us-ascii?Q?ie2wJ9Yj4+kyOXKcVNUFmGfQYydKgAhhlrpzS90hBCM5xy5FYCIHQegakX1B?=
 =?us-ascii?Q?72OgN76OmoDwW1K/KoYxvGBV7TVY+v9pwebl+z0DuzVJYX4Xon+DTbLvZgQg?=
 =?us-ascii?Q?MDL6tFH1nq4TlTnWtmAdNY5Kjv0ketTzhdUguPrSTWp0BfNekLYWYKZAZCQY?=
 =?us-ascii?Q?uzUE4OPzIgwgFndp8fVpf3Jmw5oHT05dclKD/Nm6N7uHVwelqhFwmFrv4LOq?=
 =?us-ascii?Q?KrtxWLKMep8NZ43cJLcbyIbQ2Rx5DiBuxRERZHM6M098CDulDlOL68nhySOh?=
 =?us-ascii?Q?82id9HjxBVQrSJkFpQyOvsHchwexYiW4YTNbSv/Zrw32BuDsdDH9pCQ1CXvM?=
 =?us-ascii?Q?rHMDDBNxZV0DYRryMWqsVkz8d3qCPCt857OHROHm3vtJ4FrOm1svmn3DyMLG?=
 =?us-ascii?Q?lCUY/ttb8u8Hj7UnUf4ZF9aJ/7TnxxRVWYNYHbf+5uk/2WolhHHRA1kGHTSa?=
 =?us-ascii?Q?EF/kT1V4N8e5YV64IP2Td7l9AKIPVZS+Iqm5kfN8Jm2BSQ/Bvqyk3Qc6T5Mu?=
 =?us-ascii?Q?FffHAcT0muVwR0sce88Qwmh0wZJPlIHDaKU3A15rwIWxpVVHm92b7LdHC5QU?=
 =?us-ascii?Q?0/C1+yBUU+vqqaDNnwWvrdDvKCFM/PCqQtqVRJh1woTaDNNVmIjoZ954yRqn?=
 =?us-ascii?Q?sW02OBnjBxxGn9+ezdRGSMSvabInQegqkeKZsEgHBf+aoosr0HO6A5wQf9Dc?=
 =?us-ascii?Q?t/KWa/3VW7p1aeyoSy1bytCb//rNKxtViC97xZmDfrL/468AkTfQsK9wC1JO?=
 =?us-ascii?Q?KMWoHtjbiZMWNaJfbaUUwLymjnc2mQwAb69+DGDUuYbiD8PTb2+m7CnmlsbI?=
 =?us-ascii?Q?93W1jcfQjK4nodAwDXr1jK6KiI4JkA78lnpfXUV50UunzjyW0ngA4pVYKHql?=
 =?us-ascii?Q?s/AWC6P29A8u2lq3WN4F4sEYYgr2RgyZzvrDkT3po4HtDVyhBXCYkFdNsNwP?=
 =?us-ascii?Q?hwBD0PWtzwno6cp0++/9YDT0qsDaI92Nn8hFLnkiboZHkCpsNdlysJS6Iq08?=
 =?us-ascii?Q?bunqY+i2AbjdqsNrbEjLaFCDQcC98JoN0zPXMvQcqPO5XiyH8thnqZfUsM8S?=
 =?us-ascii?Q?AXqVKLHb5bKl9GENItWlhklMZyiMGgeDU0L3hie07UHHeuNBUI3ZBPI68xiA?=
 =?us-ascii?Q?ZMvHYEW0e0s2xWXrCJXpIzLZgGjzalssnf5cNab7WI9c+QTwX6VArgK5xiW1?=
 =?us-ascii?Q?dmABjjFcAGK8Elx+ZBLTEsTQ+os1OGIsSQVJ7erPDC9EFH0vRtQgdbCkuroE?=
 =?us-ascii?Q?1DMsQD8r+oJS94c4Y6GD6QUGpVtjXHXB9OQX8329+oejZiOV6g898nCjeoak?=
 =?us-ascii?Q?IF2g2RNj1njDLimoToF1rE5GDrTjv9NKxfvWne5fQshBc9ulWEBU9Ryece6i?=
 =?us-ascii?Q?tDy92ic9CMZs6HD6vOk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:34:44.2630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2ee6ab-7853-45c7-6aee-08ddfc59d0ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

Most forwarding tests invoke simple_if_init() to set up a VRF-based "host"
and simple_if_fini() to tear it down again. Add a helper,
adf_simple_if_init(), which is like simple_if_fini(), but takes care of
scheduling the cleanup automatically.

Convert the tests that currently use defer to schedule the cleanup.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Alessandro Zanni <alessandro.zanni87@gmail.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: David Yang <mmyangfl@gmail.com>
CC: Li Shuang <shuali@redhat.com>

 .../selftests/drivers/net/mlxsw/devlink_trap_policer.sh  | 6 ++----
 .../selftests/drivers/net/mlxsw/qos_ets_strict.sh        | 9 +++------
 .../selftests/drivers/net/mlxsw/qos_max_descriptors.sh   | 6 ++----
 .../testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh  | 9 +++------
 .../testing/selftests/drivers/net/mlxsw/sch_red_core.sh  | 3 +--
 .../selftests/net/forwarding/bridge_activity_notify.sh   | 6 ++----
 .../selftests/net/forwarding/bridge_fdb_local_vlan_0.sh  | 8 ++------
 tools/testing/selftests/net/forwarding/lib.sh            | 6 ++++++
 tools/testing/selftests/net/forwarding/sch_ets_core.sh   | 6 ++----
 tools/testing/selftests/net/forwarding/sch_red.sh        | 9 +++------
 tools/testing/selftests/net/forwarding/sch_tbf_core.sh   | 3 +--
 .../selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh    | 6 ++----
 tools/testing/selftests/net/forwarding/vxlan_reserved.sh | 6 ++----
 13 files changed, 31 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
index 6cb5a7a7438b..e212ad8ccef6 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
@@ -44,8 +44,7 @@ source $lib_dir/devlink_lib.sh
 
 h1_create()
 {
-	simple_if_init $h1 192.0.2.1/24
-	defer simple_if_fini $h1 192.0.2.1/24
+	adf_simple_if_init $h1 192.0.2.1/24
 
 	mtu_set $h1 10000
 	defer mtu_restore $h1
@@ -56,8 +55,7 @@ h1_create()
 
 h2_create()
 {
-	simple_if_init $h2 198.51.100.1/24
-	defer simple_if_fini $h2 198.51.100.1/24
+	adf_simple_if_init $h2 198.51.100.1/24
 
 	mtu_set $h2 10000
 	defer mtu_restore $h2
diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
index ed217eb63cc7..9ca340c5f3a6 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_ets_strict.sh
@@ -57,8 +57,7 @@ source qos_lib.sh
 
 h1_create()
 {
-	simple_if_init $h1
-	defer simple_if_fini $h1
+	adf_simple_if_init $h1
 
 	mtu_set $h1 10000
 	defer mtu_restore $h1
@@ -70,8 +69,7 @@ h1_create()
 
 h2_create()
 {
-	simple_if_init $h2
-	defer simple_if_fini $h2
+	adf_simple_if_init $h2
 
 	mtu_set $h2 10000
 	defer mtu_restore $h2
@@ -83,8 +81,7 @@ h2_create()
 
 h3_create()
 {
-	simple_if_init $h3
-	defer simple_if_fini $h3
+	adf_simple_if_init $h3
 
 	mtu_set $h3 10000
 	defer mtu_restore $h3
diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh
index d10df3a19300..a4a25637fe2a 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_max_descriptors.sh
@@ -68,8 +68,7 @@ mlxsw_only_on_spectrum 2+ || exit
 
 h1_create()
 {
-	simple_if_init $h1
-	defer simple_if_fini $h1
+	adf_simple_if_init $h1
 
 	vlan_create $h1 111 v$h1 192.0.2.33/28
 	defer vlan_destroy $h1 111
@@ -78,8 +77,7 @@ h1_create()
 
 h2_create()
 {
-	simple_if_init $h2
-	defer simple_if_fini $h2
+	adf_simple_if_init $h2
 
 	vlan_create $h2 111 v$h2 192.0.2.34/28
 	defer vlan_destroy $h2 111
diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
index 6aca01ebb1ee..d8f8ae8533cd 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
@@ -72,8 +72,7 @@ source qos_lib.sh
 
 h1_create()
 {
-	simple_if_init $h1 192.0.2.65/28
-	defer simple_if_fini $h1 192.0.2.65/28
+	adf_simple_if_init $h1 192.0.2.65/28
 
 	mtu_set $h1 10000
 	defer mtu_restore $h1
@@ -81,8 +80,7 @@ h1_create()
 
 h2_create()
 {
-	simple_if_init $h2
-	defer simple_if_fini $h2
+	adf_simple_if_init $h2
 
 	mtu_set $h2 10000
 	defer mtu_restore $h2
@@ -94,8 +92,7 @@ h2_create()
 
 h3_create()
 {
-	simple_if_init $h3 192.0.2.66/28
-	defer simple_if_fini $h3 192.0.2.66/28
+	adf_simple_if_init $h3 192.0.2.66/28
 
 	mtu_set $h3 10000
 	defer mtu_restore $h3
diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index a88d61a84b98..47d2ffcf366e 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -100,8 +100,7 @@ host_create()
 	local dev=$1; shift
 	local host=$1; shift
 
-	simple_if_init $dev
-	defer simple_if_fini $dev
+	adf_simple_if_init $dev
 
 	mtu_set $dev 10000
 	defer mtu_restore $dev
diff --git a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
index afce1c964d5a..522a5b1b046c 100755
--- a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
@@ -26,14 +26,12 @@ source lib.sh
 
 h1_create()
 {
-	simple_if_init "$h1" 192.0.2.1/28
-	defer simple_if_fini "$h1" 192.0.2.1/28
+	adf_simple_if_init "$h1" 192.0.2.1/28
 }
 
 h2_create()
 {
-	simple_if_init "$h2" 192.0.2.2/28
-	defer simple_if_fini "$h2" 192.0.2.2/28
+	adf_simple_if_init "$h2" 192.0.2.2/28
 }
 
 switch_create()
diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index 052b2f757ff0..78b6be513a2d 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -44,18 +44,14 @@ host_create()
 	local ipv4=$1; shift
 	local ipv6=$1; shift
 
-	simple_if_init "$h" "$ipv4" "$ipv6"
-	defer simple_if_fini "$h" "$ipv4" "$ipv6"
-
+	adf_simple_if_init "$h" "$ipv4" "$ipv6"
 	adf_ip_route_add vrf "v$h" 192.0.2.16/28 nexthop via 192.0.2.3
 	adf_ip_route_add vrf "v$h" 2001:db8:2::/64 nexthop via 2001:db8:1::3
 }
 
 h3_create()
 {
-	simple_if_init "$h3" 192.0.2.18/28 2001:db8:2::2/64
-	defer simple_if_fini "$h3" 192.0.2.18/28 2001:db8:2::2/64
-
+	adf_simple_if_init "$h3" 192.0.2.18/28 2001:db8:2::2/64
 	adf_ip_route_add vrf "v$h3" 192.0.2.0/28 nexthop via 192.0.2.17
 	adf_ip_route_add vrf "v$h3" 2001:db8:1::/64 nexthop via 2001:db8:2::1
 
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 1370d7a32655..7d506cf81a32 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -717,6 +717,12 @@ simple_if_fini()
 	vrf_destroy $vrf_name
 }
 
+adf_simple_if_init()
+{
+	simple_if_init "$@"
+	defer simple_if_fini "$@"
+}
+
 tunnel_create()
 {
 	local name=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/sch_ets_core.sh b/tools/testing/selftests/net/forwarding/sch_ets_core.sh
index f9d15b2f4615..0453210271dc 100644
--- a/tools/testing/selftests/net/forwarding/sch_ets_core.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets_core.sh
@@ -165,8 +165,7 @@ h1_create()
 {
 	local i;
 
-	simple_if_init $h1
-	defer simple_if_fini $h1
+	adf_simple_if_init $h1
 
 	mtu_set $h1 9900
 	defer mtu_restore $h1
@@ -182,8 +181,7 @@ h2_create()
 {
 	local i
 
-	simple_if_init $h2
-	defer simple_if_fini $h2
+	adf_simple_if_init $h2
 
 	mtu_set $h2 9900
 	defer mtu_restore $h2
diff --git a/tools/testing/selftests/net/forwarding/sch_red.sh b/tools/testing/selftests/net/forwarding/sch_red.sh
index 8f79a86cb15b..f2a3d9254642 100755
--- a/tools/testing/selftests/net/forwarding/sch_red.sh
+++ b/tools/testing/selftests/net/forwarding/sch_red.sh
@@ -52,8 +52,7 @@ PKTSZ=1400
 
 h1_create()
 {
-	simple_if_init $h1 192.0.2.1/28
-	defer simple_if_fini $h1 192.0.2.1/28
+	adf_simple_if_init $h1 192.0.2.1/28
 
 	mtu_set $h1 10000
 	defer mtu_restore $h1
@@ -65,8 +64,7 @@ h1_create()
 
 h2_create()
 {
-	simple_if_init $h2 192.0.2.2/28
-	defer simple_if_fini $h2 192.0.2.2/28
+	adf_simple_if_init $h2 192.0.2.2/28
 
 	mtu_set $h2 10000
 	defer mtu_restore $h2
@@ -74,8 +72,7 @@ h2_create()
 
 h3_create()
 {
-	simple_if_init $h3 192.0.2.3/28
-	defer simple_if_fini $h3 192.0.2.3/28
+	adf_simple_if_init $h3 192.0.2.3/28
 
 	mtu_set $h3 10000
 	defer mtu_restore $h3
diff --git a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
index bce9ab3cb24a..070c17faa9e4 100644
--- a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
+++ b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
@@ -59,8 +59,7 @@ host_create()
 	local dev=$1; shift
 	local host=$1; shift
 
-	simple_if_init $dev
-	defer simple_if_fini $dev
+	adf_simple_if_init $dev
 
 	mtu_set $dev 10000
 	defer mtu_restore $dev
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 9beb5d512b8e..9974a93eb850 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -119,8 +119,7 @@ source lib.sh
 
 h1_create()
 {
-	simple_if_init "$h1"
-	defer simple_if_fini "$h1"
+	adf_simple_if_init "$h1"
 
 	adf_ip_link_add "$h1.10" master "v$h1" link "$h1" type vlan id 10
 	adf_ip_link_set_up "$h1.10"
@@ -311,8 +310,7 @@ ns_init_common()
 	adf_bridge_vlan_add vid 20 dev w1
 
 	# w2
-	simple_if_init w2
-	defer simple_if_fini w2
+	adf_simple_if_init w2
 
 	# w2.10
 	adf_ip_link_add w2.10 master vw2 link w2 type vlan id 10
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
index c564d7a3af0b..712f3367ee5a 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -47,8 +47,7 @@ source lib.sh
 
 h1_create()
 {
-	simple_if_init $h1 192.0.2.1/28
-	defer simple_if_fini $h1 192.0.2.1/28
+	adf_simple_if_init $h1 192.0.2.1/28
 
 	tc qdisc add dev $h1 clsact
 	defer tc qdisc del dev $h1 clsact
@@ -76,8 +75,7 @@ switch_create()
 
 vrp2_create()
 {
-	simple_if_init $rp2 192.0.2.18/28
-	defer simple_if_fini $rp2 192.0.2.18/28
+	adf_simple_if_init $rp2 192.0.2.18/28
 }
 
 setup_prepare()
-- 
2.49.0


