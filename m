Return-Path: <linux-kselftest+bounces-30528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8898FA855E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9159E3B938A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 07:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C9629346E;
	Fri, 11 Apr 2025 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OlmMN+34"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502E293450;
	Fri, 11 Apr 2025 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357870; cv=fail; b=TuF3tT10fqmXyiNbePRSYB5vhElpcqM0GTxwKUU+yy+romGRFP56n7TzTChYdetgEx7Tsu6CEjTnUazbtP3c6P0wP9pnIH213af57ZDiNI/kKl1qzJwyqoFbLAItePb9mCmuU4c64GcdAP6hrvY/AtvUzl214mfgsb2ZrHVeyX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357870; c=relaxed/simple;
	bh=CnbFUE/OZRjtRGDJB0YcTw9Naxna1RKFIWvnQx12EsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoCK/DmloYqYlTCPr8/8ZjM2FInldSQJoaZUNtw6tsY9RgU5zwFL2owtnZJmA8ySoEd2jrb/Q9sAT6T47eSIaE+zzjRnTe9zdV/fY0gotfe2lzcGXjsAOHAWWVvdlV8mHdaz/Q2dUccdGkeXNJCR1XXvBlQwh8HvYyTJaIi7Tec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OlmMN+34; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg9p2GqE7c0I6zVug0Awfw6Vy3DxcraZ+1bv0rsduDjkR+vpz8B7etpvfytEotFOwgWekJ8VZFIWtWU6Qu1rV8ryl1I7ho8ZC984+WgwDYJzs+EomdywLznWVngF6n68Df8jOxjKBzRs4C9MrpxNgpR8IJbmgH4GqWLAKmPJSG98LHPsAZgdC5yE/2wO237HUFBoTIhcYADLseMS+rn8GeXm1ymBp0wOJKbIqKQoWmHkyeKwcg9VjvXRQr/c3X9HKYpWhOiIi+Pkzaxe85yYnQ1eOe8E+l3jJvqzEL8mesxrvI6YvMsdmJc998N7IL8YUkLCu022PdeEQvEnZ/INSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVIXMDIGe6PJt+URsYS7TQpSKdeZN/N1kR8XTluTi9U=;
 b=noBTJN5YRHcfiMK1Vpl6JqQP/D7KDPTtw8KJb4ospCJ6p3019TkiovywOvD1NAzMm0e2jmYst4sTgzqs2NrsrSauz+12rFNQFGLC1Q44OjnJy7krfEGhe2PhxjJc7IHo4kPhvquYa3eZeAbjgIaPQKwZZjz00sDcmROrEJ57xr4rJzh319obg3CGKKMjqs/9nNZ5T9WvD1h4NYA9z7TSb8t7zEBRVKfFb5NMo2THdVR80QfqkJfolSxh4dQDgvqGXcndH7E/Q3Vi5ikCMJg7ynt1UKr9WoX+oUuyIz4r4Bv1bT/8ftG9XixcHOloI5JQZ/qfuj8PzXGruJaiWZgO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVIXMDIGe6PJt+URsYS7TQpSKdeZN/N1kR8XTluTi9U=;
 b=OlmMN+34+vSDI9a3fzKSFvo2Q+iAJRBG6qB1KJsHa8jCv1y5z7zQK/u3jNyLZ+vzTGivB95weHyCG+KPCPU4o3gYuIxowkoBFZbwbm3495EqYlL7rahVs+IR5zf31ESqTMtdjbxUKHg8Ffsyp7o3ap9ZdBXpSZGhblu5lI34U+u7alPVPJNoxIJ3BImlnY8iLn5HhS8z92qmKSrGZZhAT9sVIyDpHtFgsXUUKVt0hAIoCotXZxBUoXvjeXRnySZ2NPOPsVhRhBSCoL/grzmlOWYM2ME2pFIxsciVmyLIoE2t4fCEJfr7WuvVxD8ZSx+MW6Y8DfLXkCbYSKzM8Mgc4A==
Received: from SN6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:805:66::27)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 07:51:02 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::1b) by SN6PR08CA0014.outlook.office365.com
 (2603:10b6:805:66::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 07:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 07:51:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 00:50:48 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 00:50:42 -0700
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
Subject: [PATCH net-next v3 5/6] bonding: Mark active offloaded xfrm_states
Date: Fri, 11 Apr 2025 10:49:57 +0300
Message-ID: <20250411074958.2858496-6-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250411074958.2858496-1-cratiu@nvidia.com>
References: <20250411074958.2858496-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcd9ac8-8fea-416c-74ff-08dd78cd9ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fedv7EdHwWcDgRFgzqK1f0j0qTTC189FBAhPWZyNmqRplfx94xVbQjhwKmo0?=
 =?us-ascii?Q?Gy1TzUX5Jr1kpnlO/ug+2SMs/tEvqp2/ifVHh0KvghNFLxb+1Exb0HHOhyIk?=
 =?us-ascii?Q?kj6tJT41yjAg8OMwaE0Cx6N4RsYY3G4PLsdnv66fRSpQN48kQDs0JhgyDqui?=
 =?us-ascii?Q?hUj5SvTDupaF7mZRj0zF6qzs4f4p5T9QrESAQ8bS/JrV5Jn+xAZfY0uWvqMn?=
 =?us-ascii?Q?K+uKxJQqFH/dmNSrlybbM/27oSI5By/BN9tH/tjyX8beQU85IUzznTW+S8Mt?=
 =?us-ascii?Q?31GCk1NxUSXJi2WH64bGDp4W1H7HbfnWeQ6a17AcCcdqt0+eHeytB7GTvFOC?=
 =?us-ascii?Q?hi2MXA5EBDxuEd+QSgx35rmZT5Y1awS6cVHcqJ7FxVp9rdBQEwbZnkJxGEWe?=
 =?us-ascii?Q?8cuTwENLudT1HyHHeQF6p8VqNy1/NGEgurEz33kOeghxsunJ0dz/pJlA3dT/?=
 =?us-ascii?Q?f2Yvkb9gAg4ojTw3xssnj6PPFVhOeGVwtP5tUnmPZEFBIo/2Z6b03M7w8nYO?=
 =?us-ascii?Q?pJp77ytpKsg8FQgpWTNeDMo4x4f8XVB3iCrt0ANuld761mKuvKzHsgJfrCES?=
 =?us-ascii?Q?pl1QnqUElWWnuePY5Bi04LeZ/UVE2HQsZmRQNcgKHfzvCyUe2AUz+dS4CNfO?=
 =?us-ascii?Q?ZZlsRU3NpRBMuT6UsO83xuwkVG2xDKSr/TtzzFYL1V/BWYtGgINE9FOyKdcL?=
 =?us-ascii?Q?e4rBB+RYrxCqGENzvnJNHl8CdMwpZ2QBSKnAORX4584uUTeQAm1FrNziVvmz?=
 =?us-ascii?Q?lmA+E56pyJa7hYi4P6051VY6Jhc9aWOMir+ctrEikxyHzE4Mi30ZSEBMWGcY?=
 =?us-ascii?Q?Eg0/bei2HDJt3zcx7WR0Dd3TqGyq+eV54VRSwnDAu+CpqE2OV5qKl2uKlhBi?=
 =?us-ascii?Q?SZSsi3Km3IrsPB3n4f8Yi/7jHXH8b/ubkm13F92DeKnw7ujcG6c8L/hWt4dy?=
 =?us-ascii?Q?g1QGmU+cM+AQYhzAZ4ztiskKdO8qR1Hf08Vz6M2uz3T7UOFkKzk5G1oSPEX0?=
 =?us-ascii?Q?TVwQWvoTzrJfiWSfyKgXz07rY1cTzEJ7uyVThF5z8XPqvoDtmeadAfaaK1P4?=
 =?us-ascii?Q?smPayrck8M/9hkvkRoYfAIxa6jk8E2haA/wahkI3XAg5Bq/6Y1yVfLax2/SQ?=
 =?us-ascii?Q?f8XReTo4XKfkM5RIBfjAteFO8Ma732RhW0XTfVTfSEkDm4ZU40UjFMTUVy48?=
 =?us-ascii?Q?zdLsQwWCgvVDqkmDHiIkdkzWB1Y+cMpHkcyBLZhtxIM5KEQcA6U5u/YM/12K?=
 =?us-ascii?Q?1ncXNtqGznZ1P6cY6/1yBq/05iNDOwvC/+DwdtmDZb8g/W4OzIhU1/FF/VA0?=
 =?us-ascii?Q?4qF03oxDw12OMfbZjowLe9RYDIbMmghLxQCSpOY0+WRGBTo4dYYNQ2BQeHlN?=
 =?us-ascii?Q?Qzp5b19YTLt/RQZvwqoRC7um4O74pPFdThjf/k0AkXj/0H7rUKD2mJhifnox?=
 =?us-ascii?Q?Y3eNkVW6+50wK+7jAnzDdplZU3nz6cuwbyC0n/Qro2f8q9hfJvvNT+MRkCTq?=
 =?us-ascii?Q?blV8VasG0HwGR8IwHf8zxmU+SlVVeGkmhWevkXpohTa5QlytKCils1+weg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 07:51:01.5529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcd9ac8-8fea-416c-74ff-08dd78cd9ac8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847

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
index 4ba525a564c5..14f7c9712ad4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -496,9 +496,9 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 		goto out;
 	}
 
-	xs->xso.real_dev = real_dev;
 	err = real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev, xs, extack);
 	if (!err) {
+		xs->xso.real_dev = real_dev;
 		ipsec->xs = xs;
 		INIT_LIST_HEAD(&ipsec->list);
 		mutex_lock(&bond->ipsec_lock);
@@ -540,12 +540,12 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
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
@@ -629,6 +629,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 			continue;
 		}
+		ipsec->xs->xso.real_dev = NULL;
 		real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
 							    ipsec->xs);
 		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
@@ -664,6 +665,7 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 
 	WARN_ON(xs->xso.real_dev != real_dev);
 
+	xs->xso.real_dev = NULL;
 	if (real_dev && real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
-- 
2.45.0


