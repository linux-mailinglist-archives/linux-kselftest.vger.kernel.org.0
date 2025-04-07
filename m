Return-Path: <linux-kselftest+bounces-30250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B11CA7DFA3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5965E18910D6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538919CC33;
	Mon,  7 Apr 2025 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S9gtSWfe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50028199237;
	Mon,  7 Apr 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033029; cv=fail; b=X+nARDS1KijAI3gUlgYqKLzA8VWl+2OHjmVVtbhnor9wsv60r+5ZV/MA2u+gQPqwYLYiJXCynbsI4Vuan3cUoG7OdIhYLJc9hqYmOZQ3kV8DoyGzX+UnIhH5RnT89aNgHiU05BaJyc+1Oi/r/cqw1Jb5gme2g6RJ6iC3weYoQUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033029; c=relaxed/simple;
	bh=pgWsVsGysQvzbbAg65QXGtURzS+AJMAYwrcN8CBCD6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbr+2QcxOrDc41gxOJemT9to0tN8vCJAeGhfNoZYEl/wTiqeabSM0koxMnoa2s+2fvo6SapS8gzj65eypnNHN715E5OxE65wF+Ro31KLBEEo0m18itCH2NgdlavvtlcU0DsbXBeg4KQKvzmpA309BpRiKXJk74KRPBh2tQ/oH00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S9gtSWfe; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgwzDYaHAuMLhzvOYnHx+9L6bfTpTrDckL0XviR4AsPQ7uYnbjPKUdPfbRwkDgnu6K3+MJQgt52wWk6U+24YAFiNvVjkF+3qmbjbCC/w44BnPNd8Upu27KapvtXMPxf71SXgN3xNHerOxbo+v+g8AfjiR4M55Ux6021/DEVUakqbseGNCB/499TxTg2fA6/CZ1wamPOHRN2oxdlV416O/tkAXjiCM3tf3yo0FhwLG9mAhZaCh+GUkyRNMgY4BoMp7GcwVtmjWRsazE9Ob5xMBWnicr5fSWw1xQ26Fz3FRSlyraMFt9K7Cdo5PJuh94jXsppfgyFo6ZyLMraSQqN+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgxA6AzYKgsYdzdzwdEWiZhiNqe4nbChHDSFJ+cGlvQ=;
 b=v5klC4kaaNJyH0yE8JFQ9V72/9CrhGI8yDmr5dYe8hKWZihmoxa7TH45Y+eqFPD5GKOQjiCAmFzcvc4/M7lTCkn/hRcy4nXQJQlBGZF6RRF3m8L6u1OlM0uP4FDkrXWN4I1zA8n0xdijXmsCR+R2BQL5ZWQ4UYBecmtjzuAhT8nADjqf+Q4HxLM8MLvK4uAQpZWNsV3USnsTgvXfc0icaL5Brf5JqC7jP3X+/+XGBWDbk+b0df5kIg9nGeFVxuZ10F26KOVbxw+3GdlvF2b/hg2d3Iw6FNy8G6VC4z7dKxW8eqHjzNxq97V6B/JXkedTJx2l5kRYyopviowSSBDr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgxA6AzYKgsYdzdzwdEWiZhiNqe4nbChHDSFJ+cGlvQ=;
 b=S9gtSWfexDinCyp180HTpdPF00MPp/TzGHqUtSjotBN8haGS1jJxKthpclSXGrOVoIzJ8lF+79gIgqvKQQkkVWXeXIjoH+OevsTPeKg6baklxbi+VH5Gy/Ww75Azvn0nGGIBI0UdDGBXrJN/Vq0yDuHbroMpdR4LKjrcYEqCcTaojBTMXTRjZOAWwHs8aGzNW5oJ1Y5yhmq4YKI9cjHm/alBQRF66wNmF0iIsPiIms92ycEdAWuRMNBMru/UI0p6jqESWrn+TKfS6MhOmd7TCQ2ThuQ0Yfy9FSTtFy3n67Oqh2ql1JlMVJkIypPvj3/serijxbTDvQm9YbQzgJ4+tg==
Received: from BYAPR07CA0081.namprd07.prod.outlook.com (2603:10b6:a03:12b::22)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 13:37:01 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::9a) by BYAPR07CA0081.outlook.office365.com
 (2603:10b6:a03:12b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 13:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 13:37:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 06:36:39 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 06:36:33 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Simon Horman <horms@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Ayush Sawal
	<ayush.sawal@chelsio.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat
 Bhushan <bbhushan2@marvell.com>, Louis Peens <louis.peens@corigine.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 5/6] bonding: Mark active offloaded xfrm_states
Date: Mon, 7 Apr 2025 16:35:41 +0300
Message-ID: <20250407133542.2668491-6-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250407133542.2668491-1-cratiu@nvidia.com>
References: <20250407133542.2668491-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: aa13b43e-4441-4ebd-e976-08dd75d9465c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qfhsYT0t/vtxbSlyWkBAIPZcVq6eoxlMpM6pmu8uF/YNKqeZrhLeSkzITFG3?=
 =?us-ascii?Q?8xIqwMvGuRpgH6OtCFaL9MksRX9SVLjqXItc/XgMlH7QZB1/bjzRmEeklALN?=
 =?us-ascii?Q?uyWURsyFA3U00Gfym2upN8DSe1vrbJ+ykOzo2n74EixVQtNrcGyUMoXO3j2n?=
 =?us-ascii?Q?D02WtfZR/buItBDOrRQEHTTnmxu3Y9/WIVG/GXzfMf8ZYFVljkeMtg5X+8dM?=
 =?us-ascii?Q?X/tYeiEXuO91pT3xpF1to7nCYrbjn++EoCpfTgeCXd2+pe9FPWDlLAYDKlpq?=
 =?us-ascii?Q?nUi7hq7vrSTV5Nh/Xs9asUgtEzbOUB4BlZ3ctvZ4uX8+NIyjIb7MpbNNvqTU?=
 =?us-ascii?Q?yqekyiVRlDxe/lZM81H04P2jCefKbj9nlgTCVsRLqPlTpOM1KMMDQFxfou1a?=
 =?us-ascii?Q?uXOQNYsRM5UxR+RczQh2IiMvuI8pbkRFcKcpjLnZ5jrN+GqOg/QnGzTFxqpm?=
 =?us-ascii?Q?Dv23q0aqvirkYG7C/RnAaR/hwUNsG9evHhbi1kfj5ozoHy7PwTIHoLcrH2De?=
 =?us-ascii?Q?jk/gpduKc5cxXMQEtdTZOjGwM+eN6b3jiQCRqMdMgNHhO8STvCv8L40YJkkE?=
 =?us-ascii?Q?UuEEXjtklH6sIQLeR6CgS/XGTDRHURnaKhNPBLNMBjcYtSSH2nmrR3ortQJd?=
 =?us-ascii?Q?Qz4j9YEi1NSWMunphUbrDoh8ERZkRp5sqPfknhH2VxdgkOq3wHIHy3x8FjJn?=
 =?us-ascii?Q?dBVwt8o8eVbj6IuWSw0fE3xGOrklIaSb3OHsenTKSMprwSRUuPJQ70wSV774?=
 =?us-ascii?Q?SZSABA8BO/1GlkbI6BddC74NSGqZOc84KMdxBtcWKrIQN1LCmKmj6T4yAECy?=
 =?us-ascii?Q?5yLzIT+6VsuOlyWJid4rK0jpsOYngkoQ4DG4qL9vQxw9g/oncYfQHrRku47x?=
 =?us-ascii?Q?rBHcjXZxtuWEOvNbMCJgC1OXl1F40y/Q/KWDg1z6aZ9qZ0udapn6XFWRtgJt?=
 =?us-ascii?Q?iif1CjrsDB/HOXTeIMMo7Y78q/f7l4QMo0nU6aedlR6ASPR1GPs5o/aisBTI?=
 =?us-ascii?Q?olGF4cwDnsduBLQECB/p4+fY6/7a6QY1uEzNl4KMNWyeYSIZSz4MqIpVPfZz?=
 =?us-ascii?Q?cs7LnMLFMcT5fCiI6fHznYox8zfJBPDgCagLUjJAA6eqRiy+jgGj2SWa66Nk?=
 =?us-ascii?Q?GKuJA5HE4ACyfAtx48pi7ITjDaX4/oxpHeCVgXS27a7I/n9fyQl5kvAwuk/j?=
 =?us-ascii?Q?7dXHEzzepVgIbbCGf9AzpoGN3RyIraXomdndREtm9NwQxHK2wJJgRQtLhDkB?=
 =?us-ascii?Q?K1FA1X5OvqW8oAcs/+99Ky75d/Er/ncilAEDdm9Vcx8IUzrPsDHV5sa4DkIP?=
 =?us-ascii?Q?w01rVm+A7AZasXCrdh9M5kPjAo2HOJVT7AkzkJ5NA6GQgCwUjMRvDFe7rJ0p?=
 =?us-ascii?Q?5PALhLnBFFsx4NGTOIIXusbPZzLQv5BoB0/UH0n9Q/XNRpw3avldCSJwPTGz?=
 =?us-ascii?Q?65WDtvk1k7ZphHPsQM6bOe1Cbq1taMbijgaCsVme0sfMTvBj7WGOBIcMSW9N?=
 =?us-ascii?Q?GJFZ4fL89K2uazM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:37:00.3919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa13b43e-4441-4ebd-e976-08dd75d9465c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568

When the active link is changed for a bond device, the existing xfrm
states need to be migrated over to the new link. This is done with:
- bond_ipsec_del_sa_all() goes through the offloaded states list and
  removes all of them from hw.
- bond_ipsec_add_sa_all() re-offloads all states to the new device.

But because the offload status of xfrm states isn't marked in any way,
there can be bugs.

When all bond links are down, bond_ipsec_del_sa_all() unoffloads
everything from the previous active link. If the same link then comes
back up, nothing gets reoffloaded by bond_ipsec_add_sa_all().
This results in a stack trace like this a bit later when user space
removes the offloaded rules, because mlx5e_xfrm_del_state() is asked to
remove a rule that's no longer offloaded:

 [] Call Trace:
 []  <TASK>
 []  ? __warn+0x7d/0x110
 []  ? mlx5e_xfrm_del_state+0x90/0xa0 [mlx5_core]
 []  ? report_bug+0x16d/0x180
 []  ? handle_bug+0x4f/0x90
 []  ? exc_invalid_op+0x14/0x70
 []  ? asm_exc_invalid_op+0x16/0x20
 []  ? mlx5e_xfrm_del_state+0x73/0xa0 [mlx5_core]
 []  ? mlx5e_xfrm_del_state+0x90/0xa0 [mlx5_core]
 []  bond_ipsec_del_sa+0x1ab/0x200 [bonding]
 []  xfrm_dev_state_delete+0x1f/0x60
 []  __xfrm_state_delete+0x196/0x200
 []  xfrm_state_delete+0x21/0x40
 []  xfrm_del_sa+0x69/0x110
 []  xfrm_user_rcv_msg+0x11d/0x300
 []  ? release_pages+0xca/0x140
 []  ? copy_to_user_tmpl.part.0+0x110/0x110
 []  netlink_rcv_skb+0x54/0x100
 []  xfrm_netlink_rcv+0x31/0x40
 []  netlink_unicast+0x1fc/0x2d0
 []  netlink_sendmsg+0x1e4/0x410
 []  __sock_sendmsg+0x38/0x60
 []  sock_write_iter+0x94/0xf0
 []  vfs_write+0x338/0x3f0
 []  ksys_write+0xba/0xd0
 []  do_syscall_64+0x4c/0x100
 []  entry_SYSCALL_64_after_hwframe+0x4b/0x53

There's also another theoretical bug:
Calling bond_ipsec_del_sa_all() multiple times can result in corruption
in the driver implementation if the double-free isn't tolerated. This
isn't nice.

Before the "Fixes" commit, xs->xso.real_dev was set to NULL when an xfrm
state was unoffloaded from a device, but a race with netdevsim's
.xdo_dev_offload_ok() accessing real_dev was considered a sufficient
reason to not set real_dev to NULL anymore. This unfortunately
introduced the new bugs.

Since .xdo_dev_offload_ok() was significantly refactored by [1] and
there are no more users in the stack of xso.real_dev, that
race is now gone and xs->xso.real_dev can now once again be used to
represent which device (if any) currently holds the offloaded rule.

Go one step further and set real_dev after add/before delete calls, to
catch any future driver misuses of real_dev.

[1] https://lore.kernel.org/netdev/cover.1739972570.git.leon@kernel.org/
Fixes: f8cde9805981 ("bonding: fix xfrm real_dev null pointer dereference")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2ffde8f672c2..443624504767 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -495,9 +495,9 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 		goto out;
 	}
 
-	xs->xso.real_dev = real_dev;
 	err = real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs, extack);
 	if (!err) {
+		xs->xso.real_dev = real_dev;
 		ipsec->xs = xs;
 		INIT_LIST_HEAD(&ipsec->list);
 		mutex_lock(&bond->ipsec_lock);
@@ -539,12 +539,12 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 		if (ipsec->xs->xso.real_dev == real_dev)
 			continue;
 
-		ipsec->xs->xso.real_dev = real_dev;
 		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
 							     ipsec->xs, NULL)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
-			ipsec->xs->xso.real_dev = NULL;
+			continue;
 		}
+		ipsec->xs->xso.real_dev = real_dev;
 	}
 out:
 	mutex_unlock(&bond->ipsec_lock);
@@ -627,6 +627,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 			continue;
 		}
+		ipsec->xs->xso.real_dev = NULL;
 		real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
 							    ipsec->xs);
 		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
@@ -662,6 +663,7 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 
 	WARN_ON(xs->xso.real_dev != real_dev);
 
+	xs->xso.real_dev = NULL;
 	if (real_dev && real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
-- 
2.45.0


