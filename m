Return-Path: <linux-kselftest+bounces-33416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F13ABE2EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421921BC103A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D72882A5;
	Tue, 20 May 2025 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nlJzx5b5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C7B2820D5;
	Tue, 20 May 2025 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766392; cv=fail; b=o+bhPt5GIURmMd3FKmp7VLEvsqWu0zwXWm1GtDhSpdPSso+4YuDwzqjzKC5is4gGdjYRq1970aIZtSSaCcEUFZpVnNGQfD2ckpLU91xlthpPaKaiFiDQRi2O/M7cq9tEmdj0hD9qL/YLgPuIW/lwazN2AA9FsRLUECKZtIA5m6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766392; c=relaxed/simple;
	bh=aXBZYH5GhmTqJk6SsAiaONCul6p4R/SZvLVEMNBaios=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNtLiNYduYjPoygFWQyYnVaP/0CRiIxPPX/UeaGB6I8hqPSrCBy9PIgReADmGbpk0dM6hRLhQka0ugWUpKvCx0OHdgUvB0mAmaV+ZxpmAaRnz4VHC9s4kAfIXXVJE3PTftGBdapoh73xp4yZKltBSPhJ3kjqWQXjGtJUMpOK6mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nlJzx5b5; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa6q2JfmFIc/6dsLCV3z61NwsoQCL5mrNmpjEtQxkGhypRb9miZe8Jg0lbkSOIpS+u72CtJ1njwwgr6Av1dT4HEaA8PLYTEUoL/xINVuAfx81ViSBnlXrwElS0lKM0CXJINvtUFPICSWZgQbhIP0GHXVCfitJFdZn6pNqny3borHwaW3oBHTzz/XwauB5t6z+9PuQeOCidjJZuIe+5BTkaZtbehIItKRnYPFZ9LznVjUwFEQJyvl0YHoA4NergKpYE/fYR+aRrT6psOwXzqEks7mf/6634QFMvWONgzQWH7YEHeJ9fKv/+ra7Z1WMstkdPQavENB1gGIX4X/Mto+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TRj+4bpwCVMbQBYew7yYtQcRaAXC1ZLuUxK15pqiJE=;
 b=dZDzTGpcDUz2fa6BPFM9LMCNYs1eDB6OQEwuR9vHf4VNw0XP5nSJmOpOm/DnJ/9WSi0sVk2ru486UJmer2cFexoMDpYYlOi+cX0o6uMb3n9oscit2uLt/1aYqSe9hu/AC547zjxPusbrtZYJ8oLe5WakCG50Du0z80+GO8TuWSKKnanGpS0ofaSBoIeVB+yNCxFbd6BrLuLmfXNbC+3g9795TBOV0nLW/pdw83xhn1LnmrbMaOsotUSc8y4B4LZLheDeP3ZFvSadnDjPeMXPybcDOqe2bzzYrcH2udaB7S8FazI2A6xUSYedtEk2LUOZM+AlvY/Fz2p8VSmTLfNNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TRj+4bpwCVMbQBYew7yYtQcRaAXC1ZLuUxK15pqiJE=;
 b=nlJzx5b589/1AmOzQNInLGwIcpITZkosRhjZ3f6FYp3U68TpUFokx0dTAIdabbAeL7Vs5SeIxw+rHXOTQRRFw9gJGYyniu40Uh1D6srejw+Zv01zo2ee6mRnPSLiEFOK/9hjnYDo8DQjLDQtEUUcPgzuhy7jkLwkBbBFUuGqlbFeXjeCZPTmd107evraww2+nh/n6hpMVBbLXhSX1qEpvOMWl7/5faRF13UYRSzL1sucTbue5cUyZ462PNxrQMJ4yJlnjqDNZkePQeXykHWRklOlBhyUqGmmvbZQ+5v0B+mvNF81X/P80pAn4VpnrvIuQ9F5OGoKfiIYesA6jskhXA==
Received: from DM6PR14CA0069.namprd14.prod.outlook.com (2603:10b6:5:18f::46)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 18:39:45 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::c1) by DM6PR14CA0069.outlook.office365.com
 (2603:10b6:5:18f::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 20 May 2025 18:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Tue, 20 May 2025 18:39:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 May
 2025 11:39:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 20 May
 2025 11:39:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 20
 May 2025 11:39:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
	"Jiri Pirko" <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Moshe
 Shemesh" <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next V10 2/6] selftest: netdevsim: Add devlink rate tc-bw test
Date: Tue, 20 May 2025 21:38:03 +0300
Message-ID: <1747766287-950144-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a0ba85-f05b-4bb4-cbbb-08dd97cdb0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SDCF8jyizMr+uVNPUbKUKdtxMB56JxNiYosnRj+UAOMhSREra2NbiHdKSNtk?=
 =?us-ascii?Q?r+sSUgaKxzeZxTsAzOzxF6k41ZsndYfCPY8wVccJLc+gKFD81VMy28fhx+NQ?=
 =?us-ascii?Q?4dQSCoBirW7TwbkIi1n7UJjiNTMbIFG3LBEetY9MCesGhD4nN419dM+dRRaM?=
 =?us-ascii?Q?jGn6ovnYbzXmyFPwz4XhPUBkcPoqlTazpCisVls5w/MR1e8Xe7QFfC5h/u7h?=
 =?us-ascii?Q?BcqjLqwIr5RrBXf9DrE5pM74EmNiPiysgwkr7ls9iZ9ugP9fdj94sEUK9XHj?=
 =?us-ascii?Q?gcFeDcMOM9FMEsDYaO0/QIFiElMVk2osCl+lRBW4dJKgcKfhlHWoMHJfLdYk?=
 =?us-ascii?Q?k6OPkPViEjwLwlPQr1Zn7UDECRdWcuAr3OS1KozZ/XWjgAwUN9esjvee9u5y?=
 =?us-ascii?Q?xX3368PvkUw09hBTnDR+irMnqMDBti0MIi0iGwlc30njE0Yg87Ue+jmVjAaS?=
 =?us-ascii?Q?4bO+dZf00FvfNmhLa4KVbV6yrvJ7GcpECl7kq27y1xDpgNu37TYKT61ns/Ph?=
 =?us-ascii?Q?WufCOVztnvrbhA/paH8eqLzSLDN91VKom4agEUTAH138f5yMGc0MB6qCDjbj?=
 =?us-ascii?Q?LTTiUVAJtPHEi2U+b94lgzPZdCnfVU1ZbYEbT4xwKt0X1BewbwqgIL/Q/7CS?=
 =?us-ascii?Q?+bvqtWz0CDWGbMHFUXJeLsc1v5fI9z4sTdrnoy+bgnnLfrfHfbAN9G36N51E?=
 =?us-ascii?Q?UPpVahJWOEqw21B2fTOlMtfysFGyCRCihtosoXfsLzUhj+FhKrTMWhsNiiMB?=
 =?us-ascii?Q?wOHL8LiERzlfQICo0LodYqOTASPH8dRn5o05hqD9NVYF+/kOpCBr0JVrX7p3?=
 =?us-ascii?Q?f8xgyepekBa0K3gAA0W6MkWpk5/JRomYb+VW8MPMMJpfhvY1ED0NpzTKiJuJ?=
 =?us-ascii?Q?KgoC9V/HG4TplH2ZEHJAtu4s7Q8W34N6pR5FGT86+8p4R1fMTMkAWepzLidI?=
 =?us-ascii?Q?amVY1Y/tC/I+gQAY+SJyf83r9ad9BVeqk+mmVjt5MxtftRjG1zvKTKX38h2M?=
 =?us-ascii?Q?+5A7Jqzaih4cMebYU3V5gxefP6ycZ3yzbpn73i0w2ztudXQqQ/gCVpnWRpqP?=
 =?us-ascii?Q?kdrv0FYBy2uvDA6LeMR2ZPNugjeV1WZ/Sei74M2R6e3f6SLLFLS9n+tFXxH4?=
 =?us-ascii?Q?Mln8ONgyRq+n9wkq8a8tK1c/ljrhG0EutQ8vs/qmydxQ6gpTdcD6b4eLQkHg?=
 =?us-ascii?Q?kR37n8cQLtW8o66jFlm2THkvp6jFPYp990I0+7alCxmChYThAQOJntWzGYDG?=
 =?us-ascii?Q?AbxIEIKwMoMLt+3LEn/q9PGmMfAJ73f3ZEr+Zx+ggcVMimB2go523dg4rBlW?=
 =?us-ascii?Q?KF20LyxXAGGhE7z0k3e5C8ZOsUFjoRoSXj3d3zbaSWdsB9tDrSP0OjanCMAj?=
 =?us-ascii?Q?3JremToZAJ+5wfKo0x4sing87jh0IJjEvpqjk3/kVRd709j8tfXTO6xFkH6R?=
 =?us-ascii?Q?MxvvrKKs5UkJcnKmZY+LY0StT4i/tjgMDyB6Mu6vC04kkmKXiAPca7QQ3e6v?=
 =?us-ascii?Q?AiUd0mxMIvsurkYXxieqB6BCizseIzRDGuhh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:39:44.4626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a0ba85-f05b-4bb4-cbbb-08dd97cdb0c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563

From: Carolina Jubran <cjubran@nvidia.com>

Test verifies that netdevsim correctly implements devlink ops callbacks
that set tc-bw on leaf or node rate object.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
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
index d04401f0bdf7..4ec6735e5af4 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -282,6 +282,7 @@ struct nsim_dev_port {
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
2.31.1


