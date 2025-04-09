Return-Path: <linux-kselftest+bounces-30426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD77A82891
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAEDA7B8994
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A485E2620CA;
	Wed,  9 Apr 2025 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="blvLQP+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4BB17C224;
	Wed,  9 Apr 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209767; cv=fail; b=GHHWJrc4O1biLU19MKHTkktDFpo6aecdW3x8DdYJj8y2MvIgZR0C6HhBw39lDH0QuASw46QzdwULe/+6n2Ie63llmkkmfFerlBfKRc6aP8PPUYzFYfQ2S9U3lSJ7zARXh0eeNe0UCL3xOuFF5RRAcL6oZZlotSyO5SbhVbaDXeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209767; c=relaxed/simple;
	bh=CnbFUE/OZRjtRGDJB0YcTw9Naxna1RKFIWvnQx12EsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbcLPCB2KEE/cE/kBGdKzxxOTvL/LAN8qwhH68t6dwSwq7j253QNP3J636s8SbTForUHZEC03X6Pr4MCWYgziu3JAcMp9nrtifQaDcyE5xUdcDq6VjRzuZoAcyGAidSMSRUm28CJUfPVPhr6lRCTE3QLyHnzrWajPDxClEclo8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=blvLQP+F; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liLXUgv/vASGppWcsc3PsGQlum2UbMdqZkejocNMAkS3qmE8FirCZs8Izs7pNKau651gsMESSlJ0QKKN8DRM3drSOrBzDQdFwZkoYlazy3wJozTOrMaiVEcm25bhHfecm0r3asWtdthbVncysWZiE+1G8M4ap3eYGJ7xtcIu9+z0vZtJDOGZIsropmUbX4kAfobgWJCR/643p1F7aaKsUczM7xOXV66dDxnpeHRlH4xkHxguSaGurklq2mqY5ny1ktwQ5vcvzqQjPsw6jvZlo+NjpZ4MbY+z8fPyct+RiqvsnKBKi136OWMUQP0/6LHU/l6LXq5Mn1OLv4wdIKv4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVIXMDIGe6PJt+URsYS7TQpSKdeZN/N1kR8XTluTi9U=;
 b=Yv/X3LJ77Qwt8F5kyUbykde5QDac6mEX02JUhNeh9QLWaHi6BciTtc7RGEd3c3LijB5PMIThlcSYke/Cbi51Lz72E1eSQMlzJLZM7wOVu8GAAAalycocyoxQtZD0jvE/0o+DgtnK54MdZ5R6o2UGcaWzUEhz/1nKw23ezv6XItBEqpjjlYGqa3TG/mS3tZMXo4Eudq7s6uG4yfd++26xEWIhWz6u1bjO04WHIpjVskKeOuUIHGEY1IAU4IXfF7S0dJzFOgxInuSnvevy2RsDrsvxSB64DyqFJyxrNtNegeJvmA3JGiS4hMvCufy0IszOqQx13KC4AG9ImEJbsE9w3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVIXMDIGe6PJt+URsYS7TQpSKdeZN/N1kR8XTluTi9U=;
 b=blvLQP+FM22nw3cIVQuxOftddLjuzAdgHLT5AZxkCdPDV+xB5fEo9s7vNZ1yvBTmU1dLwf6nE+7w3rC44/UtA92wKowpnqrvDJuuyGbZlRJUmZEM2zVWETIXDbVC5TWuN4Lt1jH5C4toyzx88ggUzi2SkVRQOcGR7q7Wh67FwIW35vcmOQZn8tAGug3odEh/cNlAPCR+cFXW6nG3U9wpG7qtJ0NMFpaie5ucHc516/etZfS9fcsTOxm9hXKM1ibqwDQ7Eia3UWzoL3wqZiXqCkkHMp2cVUV77M/ulgr7ajrrnOSI0SGx8tHJllfGzqPrx+NpbjQhurFmeCFb1CsufA==
Received: from CH0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:610:e7::29)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 14:42:42 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::e8) by CH0PR03CA0234.outlook.office365.com
 (2603:10b6:610:e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Wed,
 9 Apr 2025 14:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 9 Apr 2025 14:42:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Apr 2025
 07:42:25 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 07:42:18 -0700
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
Subject: [PATCH net-next v2 5/6] bonding: Mark active offloaded xfrm_states
Date: Wed, 9 Apr 2025 17:41:32 +0300
Message-ID: <20250409144133.2833606-6-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250409144133.2833606-1-cratiu@nvidia.com>
References: <20250409144133.2833606-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2a30c9-7682-4473-3141-08dd7774c873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oQoGlQS/tnOC4amxhcRKWDGweGz/V5Nx4zJDyWSwF39VhPcAhlOBnuj0+rv0?=
 =?us-ascii?Q?+WQt96wzYkzHUhzhcjVdIHFHn0p1RMlxiwYGCwK5a+ZIDcEjm9u09AiQ2Brj?=
 =?us-ascii?Q?6VqGV660scw/QGChNqwr/Un6cj7fpxzZgS7RNzfqu6N+OYjhXt1PAbZMvQpU?=
 =?us-ascii?Q?MeSQi1I8qnccDYhONNfVoWkFQ/wL7zimpVHOFW6qvh0M/Bs02ngqltOwnJbG?=
 =?us-ascii?Q?6Ni7AZUE48f163/ykw+NhwzNoHKxDSvvgI/nEty15re4SFcpAOf6GsofcAZB?=
 =?us-ascii?Q?H1WpsPxzOVyRtrWeFwjmC1fIAA5uDhLJESVLOG7Gqi04kAHIAIXOjV9wRzNJ?=
 =?us-ascii?Q?1bIetVOipo6fFHaj+EzwES6IpyMsAzLaWMh9Mdi448oskgptGImYXLyWiwf6?=
 =?us-ascii?Q?o8gvqIHuxewuybSvKYztzNGj7niljBV3whrZedgaZNsYPFbor53uZExmtWc2?=
 =?us-ascii?Q?mGDPM/Ueq26Sq7K2wGcBINfOcHLLBZM9OO8xA7Iu49NtjzrSlHwCNjbCJFBd?=
 =?us-ascii?Q?uEddVJ7S7fid24rKZ/3riZ+nijU4/XKOkpox54h0BaTq6vGQZxB460Ah4UDT?=
 =?us-ascii?Q?cvPjhsUpmJ9CmJExgONZz1tJhpnNjVJ6j4gXDZ0C/12ZfQBdVxDMQDvSH52k?=
 =?us-ascii?Q?+SRd3BYf2yIar9YFYj4pNAjjL7kb/pVIqcs8mjWda/43UGaz9d3xBFlHriA3?=
 =?us-ascii?Q?Ozjw8XIMdmdkhAZ7qPzRhSm1RtJg6mQdFuBpD1ityZqwQlmE4znaYzAjPReK?=
 =?us-ascii?Q?03uyCMJmZIj8+DG3AA2mCYcxOforngwAAibmC9WYN63jAFs2qQnMQGR8ak2Y?=
 =?us-ascii?Q?sKv48+U+CoUM50rIIpdCib2XcHv4tkXu6Vt9VimFn7V/SHnOcEVP5y0a+uEl?=
 =?us-ascii?Q?UOdMkA3mZL/bU/kWWFOLzJ6XBSZMBVbLsh230PD6lyZyHy9jCLCf0Zjhvv6U?=
 =?us-ascii?Q?/m33pfZjG7jtI5mQKivQD5CU4tlUmyaAy91HVKDNyQ1R8yfQ/RV8ewLkMh9y?=
 =?us-ascii?Q?Fre8ONAb1LO74FZttFPp90mKErw1y2puGSsCFcrWsX2x/6GgcMvYew1TMLUJ?=
 =?us-ascii?Q?5/E6lS/ufMS8vdc16EjsageY4FeMt9ydYEZ5QYWQO6GVTiRsxwQum/JpFLuG?=
 =?us-ascii?Q?PDUBW/sgKcPQWbDbhIm2cPQ+Mx26I12F+8NUgMtNPPqVrYg/9FkjzkLkOoyb?=
 =?us-ascii?Q?Xdgp4HrjVl5AXETIGzBRElyOhz+OyPksXWNAo7Y6i6Od8xQ7hzXlc3nV0lG9?=
 =?us-ascii?Q?OISnusVqeZOEDx6AHx+wUoU99f/H8ozpw77dZMpWVaPWVetewjghz1i1dEbm?=
 =?us-ascii?Q?2b15oB6ljj9NSkjSNW+Xv9Oa0pokoQFbWu/F8JgF8cgm0YxEyIpHomuwJK9e?=
 =?us-ascii?Q?WvGExGjjCkkImRjNDKynlfvOEB7r4R5IpTiEkLvBkijliPZ2ZC07XbtRDjxS?=
 =?us-ascii?Q?7rPMRbXf68jGZ7jYNP+MahcW/QqLyPQ14yyov4x9P2kdynXm1xoZSC0ndIau?=
 =?us-ascii?Q?RtvsR15B9e/KKCltu4rIxu0KJ4QtANC/EDbGibdJpdmWbouse2olNO77Bg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:42:41.7820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2a30c9-7682-4473-3141-08dd7774c873
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981

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


