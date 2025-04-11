Return-Path: <linux-kselftest+bounces-30529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAA2A855E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E708E3B4262
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 07:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DA728FFEA;
	Fri, 11 Apr 2025 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyaus1EK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D201E7C0E;
	Fri, 11 Apr 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357879; cv=fail; b=mtAXucq2YazbxGbQm4M9X/9Rt3e7Zx21q68PmcklVOgYVAdQ8E+UbxGSp8EHdPdYwsUQi2e3YED4D2w/5PXDcWy/oslSHip7eoAcdvDqpgBnWHn0LbLA3kIW1WeXWD+yNWpTmLvCNgvX4w+KYZheuSvtL/G8Sg0Oyr5ImYOyPnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357879; c=relaxed/simple;
	bh=FRH8B/I51FzpzGdbYbEKjOIVlyf1FTbljkk7AES0u4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E54HHaWuI94Fxc1W5d2D6akY2Lx2VGPwAYjLXYrzQ2xXsaTan1IGIGzU98EGjgEtdSUHCE+xCqi55kZi3TaSOQIUQwEZnUlMATuIDWm4ALBlP6XDYzo/LpYLSEgdWMrpW4o5H9DYFEIG7Dl5H0UmCrTJ5mPxPRB1yHPXXGXfE1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyaus1EK; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kxr+rnl3dSRoUFKUnZUYgNgMUKfht/ZR8FVPKki2HauVz/jHeB1DIFtpE7bz2jmJZ/PDbNA5ZKJliIZywjH1BkbbdRDfek2wPTEArsjDNE2KEuZZXC2y05EyVkfgMOpC7zRePy87y3RozXTtzw9kcPguDS8ZTlC8axKbIhfa8nE+LFHqKNRjyYX4pBOqeLCZHhkcQKh4KjvVVCCHtygl301okZa8QzYcjCBryjW1DcgcNVnfkNSWqs4eQb+QXtmW2eEyYW22kq5aLevjdpeJzDxVnYc1PN4VATSTRwWbuLwAiUJj5Vesj0ab/eAW1RN3EAsE6T5R5sXhHwhYWRTVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNTlSEQluFAONVtWkRGaX1Zd1gL5EwqpO2cwFZRoiCw=;
 b=OkgNRGGnY72LGK/8zh3ms2MMksk7SlvkkeD6Sscw031J4N+Zm6wCBsXfcemIiZl4e+qJN94aLRvI62SVTgLgjTiQad/Gpcr90BmoE1tcI+HtUA2rSI+oq3noJXgdG2QCsZDKa4u3WkzLWTfH6zIjQTRBRWQaxLGzJbcRXGRmSNac0Y21ITfiU9JnIci1kpi8go7+174RtPiY8P8YE/waVOmUUe9vG94XIUg7swrq4HPF4yRKJehbFYT0yF8kww8nrVFLR+h58BWFIajy20CbHIbx0RJ6kvlu2Zv0Bc69ofFPerqx8VT3Hvop9uky10hnw2pqNdHgjj0WOQimSDwc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNTlSEQluFAONVtWkRGaX1Zd1gL5EwqpO2cwFZRoiCw=;
 b=tyaus1EKztwS69MmCr2oxcohv+t7LCe7X8/2HFYtYpWlnsanIlX6d0rfmiHg0LdcktTrDn5QQOtXIRjgi8/0frEkvhqDtHRClpk0rWyc3ojVAO2wdoy3YEFd9mv6nYJsXDqnCjOpOKwC+6MwsywMOVTFOJTwDixygT9D1hYDVkhEuaQnMY4NUb4zlayh/X9gGS6C5IiwpxoxOdyScEqWeG/qSmOpR+zgRF089u/XLrUE5LiaETbJClTgxjI2TUhKKuWBThIGzK0WYRghwVqVT4ouxO8svOfe+CrmA8pUtGB80i9dW4rbnYK2Ev2sxaTZ0+T4xP9IxdSqeS/GT9f0Iw==
Received: from CH5PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:1ed::28)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 07:51:08 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::fb) by CH5PR02CA0011.outlook.office365.com
 (2603:10b6:610:1ed::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 07:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 07:51:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 00:50:55 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 00:50:48 -0700
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
Subject: [PATCH net-next v3 6/6] bonding: Fix multiple long standing offload races
Date: Fri, 11 Apr 2025 10:49:58 +0300
Message-ID: <20250411074958.2858496-7-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 88266203-d39b-4974-aa39-08dd78cd9ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cK6SUg8WG9pyAEjPp4+cC43MsA29sXFZc2K6F0UuUVRIYF4dfL+nAubfzi7j?=
 =?us-ascii?Q?A0Et6H/MaZ+mOTCQMoN2B5pxUH4Td+HeupHAQS1OQIIJQHxzM44vVMpiNhdy?=
 =?us-ascii?Q?jEUK1USCJonSwLrshnvRIVjq1vrHalzDV0uz78DdXpltRAI3OYHd0Awomk0T?=
 =?us-ascii?Q?fFA9NfMI9JoKde32BGBSR5pbDZ8IaxdCXJCqbDishk8GoJqRVt2Tm6S+f/Jy?=
 =?us-ascii?Q?NVdRenimzr/MSt4JIjGSJ0EoXdqZAqzk0Vta9xB3NXHdkU+FLb9yUgHggwZK?=
 =?us-ascii?Q?W2dTzLbY8aAqID49uDWsh7gJGKxhPT9yek4oVYj9V6cndwG6ozkquwsY3LkC?=
 =?us-ascii?Q?+iSyatFDN8dYDnR3bwGk9hzw1Q0XCZt3fTRTYIpB3p9Gbpt0K6VeBkBk0/RX?=
 =?us-ascii?Q?N45zAnTuU3cfHRXbqGR0S80CJmjP210wlxY532UbGHhwVgUwCUDS1FdNNLwE?=
 =?us-ascii?Q?aMSDj6dVVdYPkCS5EiEMRIDUqQ9v8E8rkAVZ4F6Hj52I2wjOtModjI8Qjm6V?=
 =?us-ascii?Q?wePCai4WwZvF5UrCdj/Yj8hDo9O6bpjTtZVKUxbjD5guwebD4n4qL9A2MJyD?=
 =?us-ascii?Q?LIoJPsd9x0tRoEtmfkWsZ87CF9tew+/5JkhvuIWKlRuTd1roQkKvNLmB9VdX?=
 =?us-ascii?Q?YYW1KIdmsVO/RWJ6pxa7kWcwOofY5nvqzaCFHHW4ZSpSVdtVT86a0teCelPt?=
 =?us-ascii?Q?+oD7hB1eQF61xFmAqVixMkqkaIEFz2rV3dFeyl3B09b07uvw3xEs+5+Rdjsb?=
 =?us-ascii?Q?4CWZL7RydwVSHbm0tqGi0nq1xh2pmxO820NFE10mQLLi+oxaC9m516XNm7TS?=
 =?us-ascii?Q?vujc49l3MI4oj2FRjUNyUSAc0ETidh0LoYvbysA0vLSpGt/KO+f/xiW5oLhV?=
 =?us-ascii?Q?OE8dub0PokjQUj+jh2SwIzkAhff0lva13lCLi2Ofo3Bldm6bxI5VR2VH9Je/?=
 =?us-ascii?Q?cFmZ8Mxb6dOSvltfHaEt7xkdV5tqFY0afnDa2qH4molIO/br8DEeoRqJZp8w?=
 =?us-ascii?Q?k2lPwypYz69uxkRpob+OwbbqFD+S23x5pKhMOPRkpYLRIxqgp02Lhu7AJWWU?=
 =?us-ascii?Q?Mt4XY1ZKU1dBDM5unwuWDlUzl4JPGrEKRnrh3aAAufvCGCVZvtvc1waz75o/?=
 =?us-ascii?Q?QdlZlDSBojg2TD4qqpT7TQ0IpnmxX4/mLoBNeAcgJxwH9cBDMyLcODQ95NkE?=
 =?us-ascii?Q?Vcdj8daLQ39/Iyew16jdvVUvnPkibqU9gj/FToadyGOSeocIpeyzBrsjJnh2?=
 =?us-ascii?Q?WhNX30vAlAamBA9xlo6wAArfAqNvxMcd38YhAtv1qg7cxuXL8sYA4kxlvChp?=
 =?us-ascii?Q?HKyF8ScKAZf7SlTuL2YcnQfmF8Hu6x+q0wwqRxY0x5il8qPtXQ9wk9rVm485?=
 =?us-ascii?Q?hgbbRPePmumpNihqJTgBt+8ESPHfrFuiMhIV1wkEVFyA6ApTiuytrVbXRgqR?=
 =?us-ascii?Q?Gj3LFNvVTP8z/RX8XrMaPC8X9h9H3vI8paX3ckfoauqcq1QhKJzZ4MAPIucB?=
 =?us-ascii?Q?nk2fW3k6Dp5+Xje02/gAc599kjhHU/snS3Je?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 07:51:08.0161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88266203-d39b-4974-aa39-08dd78cd9ea2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673

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

Finally, simplify bond_ipsec_del_sa() and bond_ipsec_free_sa() by using
xso->real_dev directly, since it's now protected by locks and can be
trusted to always reflect the offload device.

Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 82 +++++++++++++++------------------
 include/net/xfrm.h              |  7 ++-
 2 files changed, 41 insertions(+), 48 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 14f7c9712ad4..8ed8c29659a0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -545,7 +545,20 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
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
@@ -560,48 +573,20 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 			      struct xfrm_state *xs)
 {
 	struct net_device *real_dev;
-	netdevice_tracker tracker;
-	struct bond_ipsec *ipsec;
-	struct bonding *bond;
-	struct slave *slave;
 
-	if (!bond_dev)
+	if (!bond_dev || !xs->xso.real_dev)
 		return;
 
-	rcu_read_lock();
-	bond = netdev_priv(bond_dev);
-	slave = rcu_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
-	rcu_read_unlock();
-
-	if (!slave)
-		goto out;
-
-	if (!xs->xso.real_dev)
-		goto out;
-
-	WARN_ON(xs->xso.real_dev != real_dev);
+	real_dev = xs->xso.real_dev;
 
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
 	    netif_is_bond_master(real_dev)) {
 		slave_warn(bond_dev, real_dev, "%s: no slave xdo_dev_state_delete\n", __func__);
-		goto out;
+		return;
 	}
 
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
-out:
-	netdev_put(real_dev, &tracker);
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
@@ -629,9 +614,15 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
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
@@ -643,34 +634,33 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
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
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 3d2f6c879311..b7e8f3f49627 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -154,8 +154,11 @@ struct xfrm_dev_offload {
 	 */
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
-	/* This is a private pointer used by the bonding driver.
-	 * Device drivers should not use it.
+	/* This is a private pointer used by the bonding driver (and eventually
+	 * should be moved there). Device drivers should not use it.
+	 * Protected by xfrm_state.lock AND bond.ipsec_lock in most cases,
+	 * except in the .xdo_dev_state_del() flow, where only xfrm_state.lock
+	 * is held.
 	 */
 	struct net_device	*real_dev;
 	unsigned long		offload_handle;
-- 
2.45.0


