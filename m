Return-Path: <linux-kselftest+bounces-30248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E338AA7DF9C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 15:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6106C1893567
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C1616D32A;
	Mon,  7 Apr 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJNMJBxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AF1519A3;
	Mon,  7 Apr 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033012; cv=fail; b=n5w9ArlBhfHLxmYZUwOh6b+eHSoFy2LZsxViEVwHThDLeV7rTPQ0eX0yPNCymDFa2RXMaVR25VvGPAsfBsx/AR6J7F+AomBTw4r9tzZiZTpQDb4EBayvHpzsxhSwf7DhDUya+/2jssp1vjNTuVwrMR7U6fnEB3qpyVtE5xQPU3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033012; c=relaxed/simple;
	bh=iazEz40QiClbJxAIKlFR2LeyEukHV9LvwHNFn1LzXaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5CtNRxv2uQk6u7yIIwfmpRHfmVyIZQTo+NJvcIU+Oi2EDPv39YBJtTOE5Vbk5Cq7pwP1pkwzhVF0ltZKtSGAsQyhyZob/NLgEBuK4pl6BAbJkcld75STa2SGj6ml+jiqyTFmFcJVxGOcsjmPRzE7mvgd6Pogrdu9f/8osV0QpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJNMJBxw; arc=fail smtp.client-ip=40.107.101.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7CHD2/Tr3nZ7u5H9DNgfz/RKiOUXLPXULczEuBEIH86h08rkahEncS0njjOQQWKz0t2cbotC9WWCvQdY7gVXIbfyifNFxtX7B8aEnloM28NWMjPruG9Hvcac5H5XDhnioJJrnal8BezzxxGj16UQnnoRROFKVohVCMFZzt5S8nthh/+1PZKvb/zr0Q8xmPSuavARtt+2/nZSDtddR/SYym99e17ZZOHAbwXhHGb/WHoTEBgXB/j/E74+GKfZ4ZFL1i4p2I02+BqncQEuy2ukHyR4C5yCthWg7p1p/YtdOa62sokgxVTf3ikOxES/s1MnqpH8pY1Kw6qAPrI8tImXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtZrrL633P7mD+R159+1dgIZxXtl2NK0stD0V2JhJV8=;
 b=mUJzTsTeTCVhYKl6oHcH/NqahzIbqF7LduaHy/FNoRn4TKW7lS4yi2ImPAEWHY9iElAdh2W81ALf8zBkloF8yqNEdWpqonCHXH70GgLab8f8Tg0biarsH5ML4pBhQb38wIGo+jVNK5Ixh9p5Ysd219uZYcwaboovt+PMbPVXuNsom5VYGQgHFBZGqHgrHwswmJb1WIkKPBhPZ+ny4G/h6arG3d8D6C63JjPoaK0Zuv4TkU5G9qWapm7oW4BeBnWbiEd9xInHYop8T3nWCJ6RT+0ND3G9t71OYg63VN/Gw84YtNShijVcY9kFOxpP5xoaPP9elnLRuvhrSAaVhiJMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtZrrL633P7mD+R159+1dgIZxXtl2NK0stD0V2JhJV8=;
 b=JJNMJBxwNTZvqwx+JkjA+BpfugC+ogqGRTtdCjT6Y3r431aoxF0SLXrfoW6IFj9A8j7UYHtzoeLzjLZq0MuDY2jeanPN3R9skFgBj0NKxq8vWiE+uI09GVnJo9CENqKOXZw7cj0bZ0/a7PBHTrUl9eklSn5Mk24DTLN/FxFUwcYHHlAIUWcMjnGpgl+dNx1LYTDbj9+iXKFwD5vlSUtCIN0X8/4QBf9Z4IcU+lhzDw1uU0C0j0CmTuubW9cyLIUIiLI+1qs4sEPaHpB6jtB895XANHm8Qjtnp0yP40wHX7EiqqlPxfPZyBY69h70u4Si5PtrYN2d5cSh0PwlyMjtpw==
Received: from MW4PR03CA0309.namprd03.prod.outlook.com (2603:10b6:303:dd::14)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Mon, 7 Apr
 2025 13:36:45 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::dd) by MW4PR03CA0309.outlook.office365.com
 (2603:10b6:303:dd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Mon,
 7 Apr 2025 13:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.0 via Frontend Transport; Mon, 7 Apr 2025 13:36:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 06:36:26 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 06:36:20 -0700
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
Subject: [PATCH net-next 3/6] xfrm: Remove unneeded device check from validate_xmit_xfrm
Date: Mon, 7 Apr 2025 16:35:39 +0300
Message-ID: <20250407133542.2668491-4-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a6d3b2-fba0-4535-a195-08dd75d93d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IZlIh7tS5V/piPMi9qSbwerfudO1a0QmWNDYPlsuIFTsH/m1XKR55VAtsG2i?=
 =?us-ascii?Q?ZNGc7VwhU10ceRS6PwoYNLgeB6Ahkn1dL1kt6LPGfHEoElPO+M7KPVKYi9ye?=
 =?us-ascii?Q?9oD4vH5yKF76DRkEpE2NBxhqTAGscVIvn5q8W3y0/ZBC9ferUB1PpUhDUXkh?=
 =?us-ascii?Q?KQ8LEUh+lMscOL/IkbSqVdKhgMhBCz+3CPq4ZjPEv3bvqHk5lv7sozyPJExL?=
 =?us-ascii?Q?3iw0rpJfW7HNsCfvP3V/PhW7jd4+7SSCy+ai2nKiedzkhTwrUhw+AL0Yj3Oa?=
 =?us-ascii?Q?Wv1iXY9B1aL7eF3nI2CpCi6MNTBEndqiDuGWypCZcpf92mpn6yZY7IoErTvz?=
 =?us-ascii?Q?/Bft0kHpZ9g8AXldNp8EHXJsjQRApdqvZkaz9kXCpptz7mG3DLALmJCeIlfB?=
 =?us-ascii?Q?6osLTpS/m3JfQ4AebwgYDWdKm1Fl1y0mRFi/e3AJzdtLQnEy64rIARZ6L8Mc?=
 =?us-ascii?Q?3MGSablMshj3wzdRcNPOenSmyc/yPbA+TVhuDDRvdJTDJZ2sIKuGAAd+OE7R?=
 =?us-ascii?Q?1Yyh9eaXkRZ4er6frgEiBDT2WXxSiIzpELILnXTenHdzYZlCrA7rpvtox/YZ?=
 =?us-ascii?Q?QUsfs3eGJBw0Yyfdn7AS4kDXOg7kmHYlzMdTnHXhV5j0yjT10ojqiPo2KUko?=
 =?us-ascii?Q?HK/fSnmAMYrNufS4sILhMScKUSXR5KrCFgyFHgux+nMSxk4BZvduYNvPZqb9?=
 =?us-ascii?Q?T865DUVFGEh7M3HfQdNhSpvCvkcYDM146kojT/6Z8Worq1//+sTuQcKk0MOG?=
 =?us-ascii?Q?nqX3hIE7Suzx68DA/2bELgHqRw7Ha4nQsZauw9MTWAjys1OYL3gjoF5TG32U?=
 =?us-ascii?Q?IY2GSC1mRX+jgxmxNwjIkPrIFLhPO70K1TfO7NvJCZVJK+gCo/MY2uaiYocK?=
 =?us-ascii?Q?twaPzrDjgm+7XlumIpXpxT6aKZigB6hcKOOgi6LCTsG2vFKvewhAJXyZpyv/?=
 =?us-ascii?Q?MqFFWCu1X2fOq8Qx/UPIfQigrWYjLICB7PA0SQ4SPpfhEnArvQMlQVqwWf8z?=
 =?us-ascii?Q?Tst3d52y7/LqWaqTxEkfBQ78v5zGC19i6n6fsYNSFhkSAMqhGAJEowsB5kmy?=
 =?us-ascii?Q?zLOzKsOg7m815kumRA+H/nMIDct8JFF6AO3Y1/HdOZ6MDwkMAYVDgvncCpgS?=
 =?us-ascii?Q?bvcHnl6G87k7H24hRHD1MC52ezgYMEX3YE8CPfm/15umVKpTccOIfLklKoSW?=
 =?us-ascii?Q?FlKVDB5JEBaOtKzEdnfwjGyi/utyNZp5NydOEJhQtFwaFv8A5gN6m4nh7hQs?=
 =?us-ascii?Q?3o7See33gLOrtrmaLqTeaznRSixS8k0/zno3D75+6IkVcuf8GuZLBgurdCVD?=
 =?us-ascii?Q?xDKabcpLYn5DEMrsVOg3OeirJCeww2+IrwKM7QSKHQgsoY34JNOS40O1/y/M?=
 =?us-ascii?Q?rAM3gEn6aVPjk1xh1ckFWr2OlPWkQcNO9J84smyWdRUpqsTN48LV8c23T8zf?=
 =?us-ascii?Q?7CBzG+MM7jAIMY3+RBCrkqUNJPnYZPqnBbV1ytfwX2N9ZXUxtgR6aEi2vqdn?=
 =?us-ascii?Q?uDdQWhEnezTnTB5DmIv5+Y8aWp511Oudxdh2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:36:44.7814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a6d3b2-fba0-4535-a195-08dd75d93d07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131

validate_xmit_xfrm checks whether a packet already passed through it on
the master device (xso.dev) and skips processing the skb again on the
slave device (xso.real_dev).

This check was added in commit [1] to avoid tx packets on a bond device
pass through xfrm twice and get two sets of headers, but the check was
soon obsoleted by commit [2], which was added around the same time to
fix a similar but unrelated problem. Commit [3] set XFRM_XMIT only when
packets are hw offloaded.

xso.dev is usually equal to xso.real_dev, unless bonding is used, in
which case the bonding driver uses xso.real_dev to manage offloaded xfrm
states.

Since commit [3], the check added in commit [1] is unused on all cases,
since packets going through validate_xmit_xfrm twice bail out on the
check added in commit [2]. Here's a breakdown of relevant scenarios:

1. ESP offload off: validate_xmit_xfrm returns early on !xo.
2. ESP offload on, no bond: skb->dev == xso.real_dev == xso.dev.
3. ESP offload on, bond, xs on bond dev: 1st pass adds XFRM_XMIT, 2nd
   pass returns early on XFRM_XMIT.
3. ESP offload on, bond, xs on slave dev: 1st pass returns early on
   !xo, 2nd pass adds XFRM_XMIT.
4. ESP offload on, bond, xs on both bond AND slave dev: only 1 offload
   possible in secpath. Either 1st pass adds XFRM_XMIT and 2nd pass returns
   early on XFRM_XMIT, or 1st pass is sw and returns early on !xo.
6. ESP offload on, crypto fallback triggered in esp_xmit/esp6_xmit: 1st
   pass does sw crypto & secpath_reset, 2nd pass returns on !xo.

This commit removes the unnecessary check, so xso.real_dev becomes what
it is in practice: a private field managed by bonding driver.
The check immediately below that can be simplified as well.

[1] commit 272c2330adc9 ("xfrm: bail early on slave pass over skb")
[2] commit 94579ac3f6d0 ("xfrm: Fix double ESP trailer insertion in
IPsec crypto offload.")
[3] commit c7dbf4c08868 ("xfrm: Provide private skb extensions for
segmented and hw offloaded ESP packets")

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_device.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 4f4165ff738d..0be5f7ffd019 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -145,10 +145,6 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		return NULL;
 	}
 
-	/* This skb was already validated on the upper/virtual dev */
-	if ((x->xso.dev != dev) && (x->xso.real_dev == dev))
-		return skb;
-
 	local_irq_save(flags);
 	sd = this_cpu_ptr(&softnet_data);
 	err = !skb_queue_empty(&sd->xfrm_backlog);
@@ -159,8 +155,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		return skb;
 	}
 
-	if (skb_is_gso(skb) && (unlikely(x->xso.dev != dev) ||
-				unlikely(xmit_xfrm_check_overflow(skb)))) {
+	if (skb_is_gso(skb) && unlikely(xmit_xfrm_check_overflow(skb))) {
 		struct sk_buff *segs;
 
 		/* Packet got rerouted, fixup features and segment it. */
-- 
2.45.0


