Return-Path: <linux-kselftest+bounces-30251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3467A7DFAC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF963AB726
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE27A1A3152;
	Mon,  7 Apr 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z6EpuZ8x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB4199237;
	Mon,  7 Apr 2025 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033032; cv=fail; b=MAGoyffF7W2Gnud3mtdppCHU8n+1G1Qj5oU+YRTpOmvlF/sSRoaR6L5gZXj8O1tE152hyEZBuFsOXyyjlz3vIbTZb9SSZ/kqAqr4xO46pOtVA0Bg1CijrGMdxd+Qd5hfG7hptMzZP4zNaUtomoO3deXF4f7TZ1+hRr10knYgm0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033032; c=relaxed/simple;
	bh=767+pZCH2FeIooJR7ehBqlVw22vnxEs1Pbm/ffTPnyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyLLTNSruVISsuEAN745qtGd644SEsfdmACDBUjNESDllaQqkI0TI0cTlr10dZ59fx54AZH00kir27SWXDTFJR08/4VehkBcPkctI8JWD5nUGPe4WIb6is8IXbGRa8bWwedIGDrezEt+ucyKTiAXEyzuwv5DK+uIP2RggHlJIKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z6EpuZ8x; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUivQt23Ys9joIXcmvf982HDep6z3PH+q/C8UU5vwGxvXtsRnq5fJvoBiM4rqpj8HdIkRZnujD6KEC/2N6CuDc94MGqbA6ui6UFih3eqtaou95iq6EwN91M2JTBlYPs+sVvkuE8Rfrx540YR5oBIu9gvqLs0QbXSz0P5RQT0rUQ2iGlCTLOBCelPiae+BbGHjtEIaK3v0w8NXAD6CdprUq03NtJdIwSP4ZDzAxDH/H1yO59VVZjZBqOg2ydJ8PGolb0mTENXoVFbmCMpLZrLakt85lpUMae/T3536kkJtePreXRlBjtKCd8r2pYZvVs+TOewOcBC14GDa33fQkbg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg0KpUxXaSu0HOzgUHKE+5dBSddTbIdvDHzkcyTZcn4=;
 b=fTnOfT3GonE79DagDn3fcjrF1NMz7sGC1tKpuFXEfcQhms7crewlkQtNET4NBGuhWQLjZKBksgEeFq07S6iWD6qtO5C2V4WoTHqtTZjrkJsdJhZNo8IXkMvjvEs8JaaKtXMH8KZJUXe1VAiz2m2X24RQqxJUQIn1hWHwA7GEnuIibYh7mxZuEMhfhiaL7nHumCG5s1kPAZENEtl41RR76GHrxzDFARHlaQfkDNvowVnU3hI9eoQ6vXkceHhdAHaNSPTLyux9q4FIFwrG9F+sRwCMxr1T2N8N8Ddyx/QgWfR6ZrHuNUspl2CrWPOWc3ursawQjatt50a1f2gf1+6NZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg0KpUxXaSu0HOzgUHKE+5dBSddTbIdvDHzkcyTZcn4=;
 b=Z6EpuZ8xTUAdCnM1REiFQWFkq0Y24KDhYZaWIRaDysILZRtfJeBsv1j9Otntv20XKA/i4uQYrP3sKXmiJfURKIHdi5GqR9Gk3dnb/wxmLDW7NQ1JR4VoiiFCwCmYSk0GLZtdqnhaBpiNZqHg8apm9z7Tpo74123DDhK+YxUiEjg0zzJafF2xeCCF6AkAHG93Hd1sE56lnVmzJMAiT4ocYL1iFbq1dQPUjLQGiFnSSy1RkALgIx6tpNHkmGVZGneqtwj0YDbJsc87D32RKc1qCVBkNgpN69Ze1La1f/4UBF4szDls3Kfeq54KH3LLaJUud0nP6O39BmhjJQcH9OuIVg==
Received: from PH0PR07CA0032.namprd07.prod.outlook.com (2603:10b6:510:e::7) by
 PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Mon, 7 Apr 2025 13:37:03 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::5d) by PH0PR07CA0032.outlook.office365.com
 (2603:10b6:510:e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Mon,
 7 Apr 2025 13:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.0 via Frontend Transport; Mon, 7 Apr 2025 13:37:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 06:36:45 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 06:36:39 -0700
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
Subject: [PATCH net-next 6/6] bonding: Fix multiple long standing offload races
Date: Mon, 7 Apr 2025 16:35:42 +0300
Message-ID: <20250407133542.2668491-7-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: d530af1c-de6f-4e1c-7969-08dd75d94836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uX5RhoiE8qGhPS8BRC1c117nU3pewOlpXHBTQ1DAsNfeS9YFDW8JB9n0TXrO?=
 =?us-ascii?Q?EswQVYvgoDZznvlHG7izGy70wACaqK2MySxWtWZqOP0ev7/MPIgdj/ShBkPC?=
 =?us-ascii?Q?VQdVC9VrI+XEbMmXylpjYoUicdSAb1X/ChqWa8lUK6rSZeJV2oLf/biT3OIN?=
 =?us-ascii?Q?1bqplk6/Ha1+uM0nriqavWnnunCK8zJPjg5/fLDQdNd/lkDqL33x5CMnF9rn?=
 =?us-ascii?Q?UtqmfbHdBbW5u3mJUU/qJjT0frIHT3df2QwJ1RSs+260ktXWeqDksA60ozID?=
 =?us-ascii?Q?yiN1UNnoRhOIUnz3gpSWVq1qDUdnLh5UJ4VaoEkd3gIH9lz/dowtzNfR4Qzn?=
 =?us-ascii?Q?ZmxAebFxAwPlgMPZ1oK/I4RXw6gx727J7+HxR9hQYp1L4hcx5ZHXSsGtaJAQ?=
 =?us-ascii?Q?bLR4pyKr61C7qFQDNsq+KLrBp1aVnFJRsYMmjjAGsu2udQ+L16DnRyvhqeaI?=
 =?us-ascii?Q?FiqDdImk2nAdi2n+ZuQTnHMnANOLAkxHws2Lgw/xlENehNAvWKKqjUlFRgty?=
 =?us-ascii?Q?tsjeTcIb5a1D9PP4gJQUc8oMEHY9BISUAF0Q7s44mOJ68gXcIZJdRjhiz+3q?=
 =?us-ascii?Q?qLf1cM8UO9mLLEyNulnMT2UEkRdXyk+22+/Eus3TjgOWubkvDxl/Yiat0pyZ?=
 =?us-ascii?Q?zNrFdaXz9b/8dPAgo8GumbgWco7V8iDFFidn8ug82cgglGDsud7RrvIwdEBm?=
 =?us-ascii?Q?l9pLMBECiLWZlfpJymoKY7PyfWV356S4u7MzKsXESH4z1GeaabZHqFtS1Ywn?=
 =?us-ascii?Q?aBve3UmZFxP4rzhaZYNYE3ynlw57NZDZzPRdbbUzP8H0rFRWykzW0ILEkZEm?=
 =?us-ascii?Q?I6AZ7HoYtyeU8lrpKeIAeuQYA5ZZniWPVCn+DiEFZl6pDee9KlhNaGjDpNSj?=
 =?us-ascii?Q?3K/AesoS1brFGy8NLzN8akOXLgoaQAGI/qRWomxFCb6vcSUDNtPyJBzVyvjD?=
 =?us-ascii?Q?h28VUjRz6grUUP5P4+F7rB1h5ZFLSGehUzsyUTLyZoqWyKuX/ETfmgTsQ1OC?=
 =?us-ascii?Q?KRcXKMOKHXHjrp9r1lnylB+R5cSM+HFAIzumExj6mb54W+NN9cvH9E2VQSy4?=
 =?us-ascii?Q?COKu5qs2DyUxHewHqS6UEhD6KnR/vLBTBH6VCxAV3dnl95wTHxt/dZJKktyp?=
 =?us-ascii?Q?67h6t+tonWZ8ckkAarlwjuEB5sjr+eDxMyxguLtOjBd9DVjDb04jlPNHu/LA?=
 =?us-ascii?Q?HP7KH/AKSLWfwk7O4Y7MbYM0AL3Lu9QgIyxTEh0s9HCVO4yk8ozdcT++H28Y?=
 =?us-ascii?Q?l4SwLYd78Liws0vORGpcv9sXZEblm4YYRIY6vW06959KhwmztHtzr+BIlxlf?=
 =?us-ascii?Q?cIfa0VhfYBmjoRclNiq/UxjzpLD8u9BP2nIgshN7E5XKEX1N2rTINrAJdtmo?=
 =?us-ascii?Q?7QzRsvrY9M8CjkEKaLTwBlc0I8NL03yHcEc8Yk8LGXPQFnL2PtPBVZE/dIPZ?=
 =?us-ascii?Q?uqJhBDNhAuk+K1bokBTDmbWzMUgEsz0Mj/td31eEhTZeerde18Ag3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:37:03.5411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d530af1c-de6f-4e1c-7969-08dd75d94836
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977

Refactor the bonding ipsec offload operations to fix a number of
long-standing control plane races between state migration and user
deletion and a few other issues.

xfrm state deletion can happen concurrently with
bond_change_active_slave() operation. This manifests itself as a
bond_ipsec_del_sa() call with x->lock held, followed by a
bond_ipsec_free_sa() a bit later from a wq. The alternate path of
these calls coming from xfrm_dev_state_flush() can't happen, as that
needs the RTNL lock and bond_change_active_slave() already holds it.

1. bond_ipsec_del_sa_all() might call xdo_dev_state_delete() a second
   time on an xfrm state that was concurrently killed. This is bad.
2. bond_ipsec_add_sa_all() can add a state on the new device, but
   pending bond_ipsec_free_sa() calls from the old device will then hit
   the WARN_ON() and then, worse, call xdo_dev_state_free() on the new
   device without a corresponding xdo_dev_state_delete().
3. Resolve a sleeping in atomic context introduced by the mentioned
   "Fixes" commit.

bond_ipsec_del_sa_all() and bond_ipsec_add_sa_all() now acquire x->lock
and check for x->km.state to help with problems 1 and 2. And since
xso.real_dev is now a private pointer managed by the bonding driver in
xfrm state, make better use of it to fully fix problems 1 and 2. In
bond_ipsec_del_sa_all(), set xso.real_dev to NULL while holding both the
mutex and x->lock, which makes sure that neither bond_ipsec_del_sa() nor
bond_ipsec_free_sa() could run concurrently.

Fix problem 3 by moving the list cleanup (which requires the mutex) from
bond_ipsec_del_sa() (called from atomic context) to bond_ipsec_free_sa()

Finally, simplify bond_ipsec_free_sa() by not using current_active_slave
at all, because now that xso.real_dev is protected by locks it can be
trusted to always reflect the offload device.

Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 58 +++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 443624504767..ede3287318f8 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -544,7 +544,20 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			continue;
 		}
+
+		spin_lock_bh(&ipsec->xs->lock);
+		/* xs might have been killed by the user during the migration
+		 * to the new dev, but bond_ipsec_del_sa() should have done
+		 * nothing, as xso.real_dev is NULL.
+		 * Delete it from the device we just added it to. The pending
+		 * bond_ipsec_free_sa() call will do the rest of the cleanup.
+		 */
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD &&
+		    real_dev->xfrmdev_ops->xdo_dev_state_delete)
+			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
+								    ipsec->xs);
 		ipsec->xs->xso.real_dev = real_dev;
+		spin_unlock_bh(&ipsec->xs->lock);
 	}
 out:
 	mutex_unlock(&bond->ipsec_lock);
@@ -559,7 +572,6 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 {
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
-	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
 
@@ -591,15 +603,6 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
 out:
 	netdev_put(real_dev, &tracker);
-	mutex_lock(&bond->ipsec_lock);
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (ipsec->xs == xs) {
-			list_del(&ipsec->list);
-			kfree(ipsec);
-			break;
-		}
-	}
-	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -627,9 +630,15 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   __func__);
 			continue;
 		}
+
+		spin_lock_bh(&ipsec->xs->lock);
 		ipsec->xs->xso.real_dev = NULL;
-		real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-							    ipsec->xs);
+		/* Don't double delete states killed by the user. */
+		if (ipsec->xs->km.state != XFRM_STATE_DEAD)
+			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
+								    ipsec->xs);
+		spin_unlock_bh(&ipsec->xs->lock);
+
 		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
 			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
 								  ipsec->xs);
@@ -641,34 +650,33 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 			       struct xfrm_state *xs)
 {
 	struct net_device *real_dev;
-	netdevice_tracker tracker;
+	struct bond_ipsec *ipsec;
 	struct bonding *bond;
-	struct slave *slave;
 
 	if (!bond_dev)
 		return;
 
-	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
-	slave = rcu_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
-	rcu_read_unlock();
-
-	if (!slave)
-		goto out;
 
+	mutex_lock(&bond->ipsec_lock);
 	if (!xs->xso.real_dev)
 		goto out;
 
-	WARN_ON(xs->xso.real_dev != real_dev);
+	real_dev = xs->xso.real_dev;
 
 	xs->xso.real_dev = NULL;
-	if (real_dev && real_dev->xfrmdev_ops &&
+	if (real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
 out:
-	netdev_put(real_dev, &tracker);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs == xs) {
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			break;
+		}
+	}
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 /**
-- 
2.45.0


