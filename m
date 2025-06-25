Return-Path: <linux-kselftest+bounces-35792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F2DAE8C73
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 20:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E96D37A324A
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5492DCC1D;
	Wed, 25 Jun 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tuJ48BFp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F52D8DCA;
	Wed, 25 Jun 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876274; cv=fail; b=Ez6zn2BW2UqU4GK4C2q14xat+qMnipjFFZO4PDaf9RvWSg4fP0108n0Q9f0nxOwuz8Z53BUjA2iT3xkDqQQg9+27XOp6wxAh6wLVhQVj4jM/uucsgOE5p5BZ+5U6WoOzSA1tVhiKapHT3NQ4FAI/UwkcNKKaE9FPeMq2gKJdHbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876274; c=relaxed/simple;
	bh=S/9478NNuBV/d57vZxKzxE7ooe5RfgfZqKqlsGZR5A0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kN8wi80QUEIecFUT+17VvvDWd+VY8fdUmCBhLrPyUMjsjfJsJd3Jbbde6F34DVCAByNm2dm69+pN7QhTJJPVyzprpNf6H1rlDsV+yXCQWTmAi+3kLTTTvQ6qBBn4Wqn5F+/wNp2frxTdmhgKPvpSIltEG+8lLw+wuBDxiWxFNrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tuJ48BFp; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulevFoHYHHYaNsduBfyq5hTIljNyfMTrfa3yYw9sX08px3EEZnz2hr8QXjXSG1lI4Y20CesgeAXAYF+0uf0/kIDwGYk0TMHcDPM1m6RM3NHCe3xok1T34XkNjhcSIL8eAOiAyM6j+pD2CoksPwx73RzX4osgCozCEKfBMijm+7EKfW0BHqkxKvY0WVDfx/ujJ8fOWhtqUWFbJx41uo0zQEoExQF8jONjuqoZ6+IR9ZrE3+8/YRUnTOqML2M4HSWSIoumapO7hXs7logPbQOpxhRJ7xaEDCZi8yJAny4mM4EoARm79idlvBoN7hKqTl0lnzk/rLe2yt03CuJe8h6Niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi2FYyJf55lSBYaFSAAiOcBFLaZBq3PT1rHHqQo/gpw=;
 b=bEqPLB880PrnS3HkhCAURdPE8XdrtYRglw88bhMufQFeDTXYMvrwDCe0VLnrkByKOFTymx9InMKKqdHxXvTelXb3GnrN7M+xQpi0HFtvcwT8n7NEf4X5rLqMOj43qFTdYCqCFrk70BI2ZLR0CaB5GGB8VaqaX4PWl76LOWM7dWhWHRpqUtRoNh2ykepInCDkdPsTwLFns54dpAXZAdn9WD1BzNmHasum7RJ1X4qQ/5W4kFy+b/lHrDnr91NUkezOsWS6N75AKhV6kOIYfdq9aAKQIhbJY7YeHvBnUrkeYTRsqtlWTfRacmNWGptJRbipzjKzybjqdxLSvJTmTefmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi2FYyJf55lSBYaFSAAiOcBFLaZBq3PT1rHHqQo/gpw=;
 b=tuJ48BFpQN/wd9zZId4/p+bNSfadJmRdJkm6ud9+0JBzUtPe9sul9GKPjsfqgOXnkjZ+/hG9Q5Cy2X4R+YSimEt5Zc6m5jpvH3fJp2iza7Pc3we4yoos6k2QMj0WUNhC/GIndwkpUj/LPEDY+mZqeXda7N5COcEeZGSh2r6MkKfM+dKJk+smtrPuV5F4I4J9AHnwsXS0OuoKwQ/Fftxpd+wtE073bvANP5qgSzpLp+C9kivGRSTNfChlPMb6bbQS3JhuRKUwCB2YUuAs7fXfe69K0+4FCr3pmHl/26ngyoym35sotMxROWfxfMwD22/DosQ7sOSROR/OofaFE2RKeg==
Received: from BY3PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:39b::23)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 18:31:10 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::1b) by BY3PR05CA0048.outlook.office365.com
 (2603:10b6:a03:39b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Wed,
 25 Jun 2025 18:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 18:31:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 11:30:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 11:30:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 25
 Jun 2025 11:30:42 -0700
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
Subject: [PATCH net-next v11 3/8] selftest: netdevsim: Add devlink rate tc-bw test
Date: Wed, 25 Jun 2025 21:30:13 +0300
Message-ID: <20250625183018.87065-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625183018.87065-1-mbloch@nvidia.com>
References: <20250625183018.87065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f8492f-1b1d-43bc-8b65-08ddb4167490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqQpfaMdm7px6liIuFwWJPi/PgK7NYqe0IbfJu+LY2NlV2ZEcNSeco4SaT+2?=
 =?us-ascii?Q?NwKMSXxW7Z8ZT2wHTVg/FchANkk5+hH+6rmztMVK4LvyVYQKFPaxx7LbrMMM?=
 =?us-ascii?Q?rz+aH0MByg7bLBt8UcJ8EAcyrrwcR3AvBU66AtkfIBfX4/L4G9Q+nih7i+Fr?=
 =?us-ascii?Q?edh6VG0vCruG9wQNYybgUrbTZp9jhX2+z+56ZYVJhDjSzmONwKy0lXI1J1v3?=
 =?us-ascii?Q?E43DrkNGmV0d72VZVfu7724telTNSM6jgoojHal5HXi5XUt3c4Su57rVARnL?=
 =?us-ascii?Q?8vRK7jdNI8m5/qRpz3X3+tpj2U5grSiS45rMRnxoG9op/k43pf5TcUDCdIQy?=
 =?us-ascii?Q?HZFhfGm6hGhTzTFBX2lAD2+V4mclYkh1iAYtCvkguqPmUXUH0xAbhJ5OKJ0K?=
 =?us-ascii?Q?JmPUmD/AG/gTiZW353QFwgMI45NkzuON0KVkZOi3msCYeL4VcuoTc5YpO+T2?=
 =?us-ascii?Q?KVLwW9NQnnS5CnQkzrn6t6anbL3qPHhUsLHLTzwoYZsZBeLfYmduKpktju1x?=
 =?us-ascii?Q?JH7N+4oxsItzTrPDsv3ccpttzeefzHB/Y2MRbzUrbJc9oAH6yPYmqNQk5dVq?=
 =?us-ascii?Q?Z2bU8WvdHzvKvoPjX1n5BaYb7/rLAhfX4swcwyQZVwkN4RPG/6o8Pgu8y7Rw?=
 =?us-ascii?Q?O3M4Iyj1Epqp20f12k0q+2CApQtc0UKsjqk3K/sWYXD7rhC515HznU8h/m/S?=
 =?us-ascii?Q?sbfl1mGu208++yE+uu9jeqtjel7v6uxduIf0U2N04DokXCZwmPZ3J33yo9OA?=
 =?us-ascii?Q?BXgJOb6+YmoGV/3ljNd4EFPdz03b3jtxlB/ibl5XiuOa0m7rkLFeoNq6s7uD?=
 =?us-ascii?Q?jPE4EmOcPI68Qbl7d8c0PYmpgLUgGMrjfO0iAE3sCUo01m9yNX6OJL15sH+4?=
 =?us-ascii?Q?z1cjUbiCkTm7GGeLLM3cJIvCQk8oL56FaerGjKWv4ROWgtgQaDf2AZmRgBJe?=
 =?us-ascii?Q?MgUbTiU42LiilfC0ttkZnb4nSKaFbcp55ec7B3ccCGABo+avZ5GCZRrpfFvt?=
 =?us-ascii?Q?dqawqRf/2YUReWQG5Ls5Y7N+5yg2yZ6hYfXtRWfd47+/AGpox2aOW+fAmkL9?=
 =?us-ascii?Q?bYZlnTT196weP3azbZ6AHbYTHF60xE+tlhV9fhQp6jxIv6/X+/e1WndHb4Kd?=
 =?us-ascii?Q?vZh9aGqJkxMAjwYZxvAhnEtkv93iy86ETZtPPCxa4zysb2sjTDhAQqvWKAgY?=
 =?us-ascii?Q?ERX0S46hgHDcHzHSOEi48NWQh6WuS3yPgFLkquLft/Mt6iZerAcEHqD5OhNL?=
 =?us-ascii?Q?F8Nwl55aHrAaw4HZXzzVXdk2C8xsbsUch10osgLA8zDrp3lkMQRNVLpq8XZe?=
 =?us-ascii?Q?21M5ZzO0LXl4p3fgNj/ep4jgMhddz28g7fybp6XbjTamYlD4N3m9lmONwL9X?=
 =?us-ascii?Q?KQgeL1uIksha15ew9gg9FjZago4WxL2upqOwWXwDjq2CIDN67VYvNu5tkPOm?=
 =?us-ascii?Q?pV94y3KfR87iGahvebaHOFkxbHl6Q/hUSDEFiRrEnfgdOaiEKDMw/W/tU72B?=
 =?us-ascii?Q?fq3wo0EnAiP4SH3U9GNiP0pZZ4KyxHpTQ3NC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:31:09.3076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f8492f-1b1d-43bc-8b65-08ddb4167490
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199

From: Carolina Jubran <cjubran@nvidia.com>

Test verifies that netdevsim correctly implements devlink ops callbacks
that set tc-bw on leaf or node rate object.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/netdevsim/dev.c                   | 43 ++++++++++++++++
 drivers/net/netdevsim/netdevsim.h             |  1 +
 .../drivers/net/netdevsim/devlink.sh          | 51 +++++++++++++++++++
 3 files changed, 95 insertions(+)

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
index b5ea2526f23c..09068d69d2cc 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -608,6 +608,44 @@ rate_attr_parent_check()
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
+	rate_attr_set $handle tc-bw "$tc_bw_str"
+	check_err $? "Failed to set tc-bw values"
+
+	for bw in $tc_bw; do
+		local tc=${bw%%:*}
+		local value=${bw##*:}
+		local debug_value=$(cat $debug_file/tc${tc}_bw)
+		check_err $? "Failed to read tc-bw value from debugfs for tc$tc"
+		[ "$debug_value" == "$value" ]
+		check_err $? "Unexpected tc-bw debug value for tc$tc: $debug_value != $value"
+	done
+
+	for bw in $tc_bw; do
+		local tc=${bw%%:*}
+		local expected_value=${bw##*:}
+		local api_value=$(rate_attr_get $handle tc_$tc)
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
@@ -649,6 +687,13 @@ rate_test()
 		rate=$(($rate+100))
 	done
 
+	local tc_bw="0:0 1:40 2:0 3:0 4:0 5:0 6:60 7:0"
+	for r_obj in $leafs
+	do
+		rate_attr_tc_bw_check $r_obj "$tc_bw" \
+			$DEBUGFS_DIR/ports/${r_obj##*/}
+	done
+
 	local node1_name='group1'
 	local node1="$DL_HANDLE/$node1_name"
 	rate_node_add "$node1"
@@ -666,6 +711,12 @@ rate_test()
 	rate_attr_tx_rate_check $node1 tx_max $node_tx_max \
 		$DEBUGFS_DIR/rate_nodes/${node1##*/}/tx_max
 
+
+	local tc_bw="0:20 1:0 2:0 3:0 4:0 5:20 6:60 7:0"
+	rate_attr_tc_bw_check $node1 "$tc_bw" \
+		$DEBUGFS_DIR/rate_nodes/${node1##*/}
+
+
 	rate_node_del "$node1"
 	check_err $? "Failed to delete node $node1"
 	local num_nodes=`rate_nodes_get $DL_HANDLE | wc -w`
-- 
2.34.1


