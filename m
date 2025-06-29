Return-Path: <linux-kselftest+bounces-36073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BDAECDCC
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 16:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872BB1895154
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C4229B07;
	Sun, 29 Jun 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mYqYZXza"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773DE2288D2;
	Sun, 29 Jun 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751206963; cv=fail; b=EQmB/VQfeZ344RifttBJDmdCzumuTd8izChHuxi1oCPSurGhyvv4x6JHx3QYGHRJOB4up289TkCljnc/7nH/3W/OGETOLyWBY/fWSX7gsnh1yFkwtkvrLfyghcwCZLZUmxW0jm0Du9VIiFNCAsWkNGeaAGkOta+Sb1grvEjcdmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751206963; c=relaxed/simple;
	bh=OHSRimuykFlUBViQ1DhKv79dvVYfwizgehsPvMS0jSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bg/7bHvQ1zruDObMnElTVUmBedtS8dY0GKhsqrrjKc75BN382QMYuRtQg/TnhDUQcrS+K8ARNH1xFUjyJFBtMD4pJU6lpEfsKkYLgZyCxGDF8C9vPZX3z9wnaaDjp5JXk6v6N1GC7sx+D8bks9xZ9w7XLDZENL8kLjXUabOxDho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mYqYZXza; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIAXZsbjhC/wqXbHt5nPzzEDKqxFei8o0gGmb55y1zIpeGAvbQVXCHwyqaK7v0Xr0459GwBYbv38EoXlotLGk49laXNcyGWtTbHHGtk6Jsr8FxQapoVZKUAHD/jZ6/MoqIKzZBnQoHC96YJxBn7LBHLaoMBPkAVWgVotZZ9WwtWDC8q4q8LAiMktv+w3NtYIi/Hok3eR/Nc6pCps+G1w1i8eJ4k8gRVF2BNYEjWztX7sQXheb0NvE1bBFG4ND1J4raFq+LkIRTMakVfahvRuop0hDriYs+63opwsoxvkndtgTvC5cBGTuIwBWLvUWHdcMOy9uG1cMQLYGEHtnkW+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrX7bDRgYCd81d4hb5xo10Fd6mtbGY4QFsvctZH0/p4=;
 b=GxnD7H9r0APIeMi56ktWoPx4LZH/rWbl+hm7TWdgAXNEEhwPOpdDPkYc2i8OSWRiwDa2TTx7k5LVhcKohAEC4++eVnL4qYXN31abTFs5YRnPG1Tvly6xWT4ybaVO3iWJrqSFLry6i3S+BD7nkycAov3jlrVdTYz/OzZvJb62Ztgc0jUkq+V7BJtW4M6I5pl6hXsVpu2rLAp1pPdnqQLN6x4KbmSlPGEbWRDpUS9BNZtQ5ILnFUaNTLrluwd4vKlIlcaxRmdLKry40+6TVzU+kZ0NUFmixUZFqds9rcaxKVEoGXGibmRZYMBIKLmhiSzlNmFXjMN2htZ+6dzEnU+FSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrX7bDRgYCd81d4hb5xo10Fd6mtbGY4QFsvctZH0/p4=;
 b=mYqYZXzaCmMoFXkWEc5IIigduFUQGMJEAk2n1bfha4Nw9mvnFIvBWl6Bb+qnzoPaLxIv03CJrXiLn8umkQIpqkRtjLXzNc+JkqoVpPgepNYvqz4yWKT4dinuQymA4UiTGSwp51JaHEfGH2/LVwZ1Si8eyOzZGLJsmdGlQxdbTW/bGdMI23hLZAFrjxfeFYGOW4oTb9KkKfo0Rxx1K18xn08oVeBP+oWUeJ8VowximAf+FuPvu+OXiOQI8hxSOgp0+TTlA8pqyOaFlDUugkcwDCTkabi9w8CqnBbZgOqqKXU8fijWLttB5OrNfsvbBI7AdAdZJXsih5jC81DPkhYFww==
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Sun, 29 Jun
 2025 14:22:37 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::67) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.27 via Frontend Transport; Sun,
 29 Jun 2025 14:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 14:22:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 07:22:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 07:22:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 29
 Jun 2025 07:22:16 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
	<leon@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
	<okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v12 3/8] selftest: netdevsim: Add devlink rate tc-bw test
Date: Sun, 29 Jun 2025 17:21:33 +0300
Message-ID: <20250629142138.361537-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629142138.361537-1-mbloch@nvidia.com>
References: <20250629142138.361537-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da937d7-df53-4261-87a2-08ddb71865b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J0RFTkdR6pUYtObbUkh6FeA2wQTWJycUOaGRZdCmepf2iTF3WXo2k0xsaeD+?=
 =?us-ascii?Q?+2dwtbno/SnZDkSfwXGBFsfwlBwy17fhbXKu46lSJ4tpS6VfYzX6xgdOwWxp?=
 =?us-ascii?Q?qqlx9WixW+lCUlhM084/HUQ6HayrBzxSOCIPl0S9gvtOC42UVNUojMsnv4zN?=
 =?us-ascii?Q?g3xTAj+ipPSts80PaEn/xugqAXEB/LekCvoP1VVBQZzEBeaaItfnSROA791y?=
 =?us-ascii?Q?dA6CotZO8921CQaf0brg2O0ntWdw7PihunA5yrUGHYxdvJUaVg1qJabPPRch?=
 =?us-ascii?Q?VsY02uqfpcuoHMH62lPgycCwY4oxBHyzSdM/SGOSvRFH2XQISgIAzJtVS29p?=
 =?us-ascii?Q?pfsEfX5IDXJ96nxS7dFqYuyHkRltUzAUsFMR0Agrf9PIJhqOCGaQCoTht58x?=
 =?us-ascii?Q?YbfZRdrCXUzRLi1lVfFaO4W3V/c+DKoR5Moek3TrB1ZnF4J/YoSjv/NTBSOE?=
 =?us-ascii?Q?sOUB+g9zR/XbqCcoklIwEdDVpm2hnpt8nI4baoB1ChIdcNvcMIlicLDMvAJG?=
 =?us-ascii?Q?jDkm1T0cu3nAYdCZ8VbK+F3jLzLO6Yr9UEoGuRv5aWWJP7eyCrfb//TCwFoX?=
 =?us-ascii?Q?77mnhrwNIdfPgCitlTdnZlIJXr/jwYdukOn38v9UWMZLlIVa6z9EpDfSC8Jf?=
 =?us-ascii?Q?s3rel0Ro3ReoUNrT8ValZEuU3NN0r0lFXPGkgqpfssOHbAu1PkIHMgwpiCJH?=
 =?us-ascii?Q?Q6soOuszxzv3gUM9H+wJFhNTDQKSjYfC9FiFJyZHOnKLqY1mB7zFIUV+OyCM?=
 =?us-ascii?Q?sSfP6PYcOOips7wwzTJkHj8RBWZDPUCefI5GnRSalz0SUUx67z/NbjDn/hAf?=
 =?us-ascii?Q?jfkRKOmNLaGhI6Rw6YmIiUZbJNtpfYzdIG8lMidVbtY92OXjh4p8tmffXYoI?=
 =?us-ascii?Q?TUJqEVCM6j49T8tRhF9Okzc4NHv+KkyqrKwXt/3E2FlxYf2R4Nbtd0hura+n?=
 =?us-ascii?Q?4vz19jzu1JLAfGxw5WnpO5H74Z0gl2kJObwG07GVd58yDtfrXF3dft/j1wA8?=
 =?us-ascii?Q?K12CDVWpWs+PqMa24XMC5he1UyJIoFpnmAiFQud5RZp5pe1iDscwvMRBOd0c?=
 =?us-ascii?Q?72fykjGneXikAcw3kwSeuMDD94f7t6qKfjBcqHFWnQsoQ+cMnN2ARN0N1g+Z?=
 =?us-ascii?Q?kkSmLW+2yEsYtI5pXlHdeUXNemsv2gHYfqKNAlCpWefLjlzy5AUC8Y3fBlg5?=
 =?us-ascii?Q?/EfUbT8reyM9tbYyL/l9OjC1oPzrP19s6gsqk6I3VwK9S8iBj7ZnLKkpjeoy?=
 =?us-ascii?Q?TDM4Q2xWxRv3s7W9f9m9ZT6DKrHUytRex3+9juxIbAkt0SQfXX/M+Kauf7Hs?=
 =?us-ascii?Q?/HB36geRLecIfWV9yErZRLIdTIS3TfetAVnNgrwprlBVKm8jR+5IOMmcUArx?=
 =?us-ascii?Q?Fsi8/Lb5kb4HrrWDrWvzV3wXoyfKZRjDd4rjroLLPO+5tsYZhqIYGK/gJXrL?=
 =?us-ascii?Q?C0K0e+6BkvByRn5OOr3umejfYR2uhvJy6i9d3hbhdnumRH2BhqIARjmAy+Of?=
 =?us-ascii?Q?6uzS4YEnXuam+2ZMO3BqPIoX2DsI8JRi3Qp7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 14:22:36.9492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da937d7-df53-4261-87a2-08ddb71865b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225

From: Carolina Jubran <cjubran@nvidia.com>

Test verifies that netdevsim correctly implements devlink ops callbacks
that set tc-bw on leaf or node rate object.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/netdevsim/dev.c                   | 43 +++++++++++++++
 drivers/net/netdevsim/netdevsim.h             |  1 +
 .../drivers/net/netdevsim/devlink.sh          | 53 +++++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 3e0b61202f0c..b3647691060c 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -388,6 +388,17 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
 	.owner = THIS_MODULE,
 };
 
+static void nsim_dev_tc_bw_debugfs_init(struct dentry *ddir, u32 *tc_bw)
+{
+	int i;
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++) {
+		char name[16];
+
+		snprintf(name, sizeof(name), "tc%d_bw", i);
+		debugfs_create_u32(name, 0400, ddir, &tc_bw[i]);
+	}
+}
 static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
 				      struct nsim_dev_port *nsim_dev_port)
 {
@@ -415,6 +426,8 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
 								 nsim_dev_port->ddir,
 								 &nsim_dev_port->parent_name,
 								 &nsim_dev_rate_parent_fops);
+		nsim_dev_tc_bw_debugfs_init(nsim_dev_port->ddir,
+					    nsim_dev_port->tc_bw);
 	}
 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
 
@@ -1172,6 +1185,19 @@ static int nsim_rate_bytes_to_units(char *name, u64 *rate, struct netlink_ext_ac
 	return 0;
 }
 
+static int nsim_leaf_tc_bw_set(struct devlink_rate *devlink_rate,
+			       void *priv, u32 *tc_bw,
+			       struct netlink_ext_ack *extack)
+{
+	struct nsim_dev_port *nsim_dev_port = priv;
+	int i;
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++)
+		nsim_dev_port->tc_bw[i] = tc_bw[i];
+
+	return 0;
+}
+
 static int nsim_leaf_tx_share_set(struct devlink_rate *devlink_rate, void *priv,
 				  u64 tx_share, struct netlink_ext_ack *extack)
 {
@@ -1210,8 +1236,21 @@ struct nsim_rate_node {
 	char *parent_name;
 	u16 tx_share;
 	u16 tx_max;
+	u32 tc_bw[DEVLINK_RATE_TCS_MAX];
 };
 
+static int nsim_node_tc_bw_set(struct devlink_rate *devlink_rate, void *priv,
+			       u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	struct nsim_rate_node *nsim_node = priv;
+	int i;
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++)
+		nsim_node->tc_bw[i] = tc_bw[i];
+
+	return 0;
+}
+
 static int nsim_node_tx_share_set(struct devlink_rate *devlink_rate, void *priv,
 				  u64 tx_share, struct netlink_ext_ack *extack)
 {
@@ -1264,6 +1303,8 @@ static int nsim_rate_node_new(struct devlink_rate *node, void **priv,
 						     &nsim_node->parent_name,
 						     &nsim_dev_rate_parent_fops);
 
+	nsim_dev_tc_bw_debugfs_init(nsim_node->ddir, nsim_node->tc_bw);
+
 	*priv = nsim_node;
 	return 0;
 }
@@ -1340,8 +1381,10 @@ static const struct devlink_ops nsim_dev_devlink_ops = {
 	.trap_policer_counter_get = nsim_dev_devlink_trap_policer_counter_get,
 	.rate_leaf_tx_share_set = nsim_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = nsim_leaf_tx_max_set,
+	.rate_leaf_tc_bw_set = nsim_leaf_tc_bw_set,
 	.rate_node_tx_share_set = nsim_node_tx_share_set,
 	.rate_node_tx_max_set = nsim_node_tx_max_set,
+	.rate_node_tc_bw_set = nsim_node_tc_bw_set,
 	.rate_node_new = nsim_rate_node_new,
 	.rate_node_del = nsim_rate_node_del,
 	.rate_leaf_parent_set = nsim_rate_leaf_parent_set,
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 4a0c48c7a384..809dd29fc5fe 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -276,6 +276,7 @@ struct nsim_dev_port {
 	struct dentry *ddir;
 	struct dentry *rate_parent;
 	char *parent_name;
+	u32 tc_bw[DEVLINK_RATE_TCS_MAX];
 	struct netdevsim *ns;
 };
 
diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index b5ea2526f23c..a102803ff74f 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -608,6 +608,46 @@ rate_attr_parent_check()
 	check_err $? "Unexpected parent attr value $api_value != $parent"
 }
 
+rate_attr_tc_bw_check()
+{
+	local handle=$1
+	local tc_bw=$2
+	local debug_file=$3
+
+	local tc_bw_str=""
+	for bw in $tc_bw; do
+		local tc=${bw%%:*}
+		local value=${bw##*:}
+		tc_bw_str="$tc_bw_str $tc:$value"
+	done
+	tc_bw_str=${tc_bw_str# }
+
+	rate_attr_set "$handle" tc-bw "$tc_bw_str"
+	check_err $? "Failed to set tc-bw values"
+
+	for bw in $tc_bw; do
+		local tc=${bw%%:*}
+		local value=${bw##*:}
+		local debug_value
+		debug_value=$(cat "$debug_file"/tc"${tc}"_bw)
+		check_err $? "Failed to read tc-bw value from debugfs for tc$tc"
+		[ "$debug_value" == "$value" ]
+		check_err $? "Unexpected tc-bw debug value for tc$tc: $debug_value != $value"
+	done
+
+	for bw in $tc_bw; do
+		local tc=${bw%%:*}
+		local expected_value=${bw##*:}
+		local api_value
+		api_value=$(rate_attr_get "$handle" tc_"$tc")
+		if [ "$api_value" = "null" ]; then
+			api_value=0
+		fi
+		[ "$api_value" == "$expected_value" ]
+		check_err $? "Unexpected tc-bw value for tc$tc: $api_value != $expected_value"
+	done
+}
+
 rate_node_add()
 {
 	local handle=$1
@@ -649,6 +689,13 @@ rate_test()
 		rate=$(($rate+100))
 	done
 
+	local tc_bw="0:0 1:40 2:0 3:0 4:0 5:0 6:60 7:0"
+	for r_obj in $leafs
+	do
+		rate_attr_tc_bw_check "$r_obj" "$tc_bw" \
+			"$DEBUGFS_DIR"/ports/"${r_obj##*/}"
+	done
+
 	local node1_name='group1'
 	local node1="$DL_HANDLE/$node1_name"
 	rate_node_add "$node1"
@@ -666,6 +713,12 @@ rate_test()
 	rate_attr_tx_rate_check $node1 tx_max $node_tx_max \
 		$DEBUGFS_DIR/rate_nodes/${node1##*/}/tx_max
 
+
+	local tc_bw="0:20 1:0 2:0 3:0 4:0 5:20 6:60 7:0"
+	rate_attr_tc_bw_check $node1 "$tc_bw" \
+		"$DEBUGFS_DIR"/rate_nodes/"${node1##*/}"
+
+
 	rate_node_del "$node1"
 	check_err $? "Failed to delete node $node1"
 	local num_nodes=`rate_nodes_get $DL_HANDLE | wc -w`
-- 
2.34.1


