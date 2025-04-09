Return-Path: <linux-kselftest+bounces-30425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BFBA82884
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C671892589
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5E325F7BA;
	Wed,  9 Apr 2025 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FS/JGWlw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229CB17C224;
	Wed,  9 Apr 2025 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209750; cv=fail; b=HkLhv+hn6r8wWdh6ejxyD01FyKItxfLAUQCit//sPR6K6fAqfZiP8xo7874sEnFov3UqOsnUSdKNsjp3rLJQIm4CxkyPanqNd3I5HdF1eTmbOPf1adMny1fWY+OldhYRBHT11pu5ZB2B3HLaq5Giizl/JtgHvQ9qmjwvht5+P9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209750; c=relaxed/simple;
	bh=iazEz40QiClbJxAIKlFR2LeyEukHV9LvwHNFn1LzXaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgJ7IYWWrDt5yCrnpgUuMl27uBDPMBaSQ9XtPC6xv1nCJ28tm+9ymW7rNrTgipuUXE+czI9tv7vIMvNit+Si9XqclETRqMn5vgP6hkrX1JhlyE2oAJc/23AsOsDFFL2mnTmQ0gJGWLPXq8RpdYBmYV6C1INSnEHhMxOtC3dh4Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FS/JGWlw; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eu5YUFM+wIo4IKsBfYF6L9npqJqaRu2dBsW+y8nOxedPPEGm2ZTF7FV5MmHSZaUe6nPbhdShGe3go5Cpcq2e7py1bgXwLTeTo5UMVaLZsfromuGimnIKBitcjmf/PtnhIJaeFeOCO/FaDPgJXtn0T8PIz/hq5rfjC186gOBF4qARROrfTqPyUN+VTXu0WgEe8kIE+o5Fb0N9npq2MG6DTNCU5nTifjEMKnnLO70kpnbPJ7Iitv1YEfNVOLxiabCM0boZ0WrbeEnpZU1sLtRVKi7RwzYQGpsBCd8MFT0XF3dYRSvK9E2An+txgrF2fhsEMGBCyzWy6TRJ1gwgoGr2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtZrrL633P7mD+R159+1dgIZxXtl2NK0stD0V2JhJV8=;
 b=MZY7Q7+4o0hVX0O+1DV8seHA4ZSt+tGlD/4iQyG5lzKN3pk95zXhNWZ3oWm3l/aA6HAHUSZ5JgJRcT90L1bOQoFj0GWI6DNoz79DmFpqUuf35AzZ9MlD2yIY+17mrHtpGbKDn2BzDakh/y2UAw7mnxB/JPI337w5hUB9+r/2W7W9xmdIu2xBasswmRfLrvdSUz7ImKf8k2QwzzI4T9kA34EnwTMer7nzwSQrCBhlaRiI0oHZphBi0ZiF2lGOLqM0+kLTcZLKSPfqiNU5JK1F6mgLxXgUf9eaQiLeyITZbWSZvNU5RJHLrlavM6rmBMcplKz7Cpk6CMls6E1iEeJ3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtZrrL633P7mD+R159+1dgIZxXtl2NK0stD0V2JhJV8=;
 b=FS/JGWlw33HV/C052v3vtBvqEMGWnFs+hGGFFYf50MFVbU4W/oPelhMLJ74fe3A3juMKT4jqwLmBRpiIqvk76FSNCJsTKDXw6ABFCt9zRiWn5Ts/fjk349YWkjcIRT2GzCzM4hHHvfOOIMnrcB5V/o7qCa5hQq2eO9AlARgZrEno2DJZhxgTMZPkutrwG5IDNI4/Fti046IuvZ6m/5y3KglRWC7Y8STrz9oFNIoVe36w6lxM3XjbU1Y4zlpoJlP7gcNM/QpEjnM663iwtQP2JBtcWqfa+MJmhRm+6+z4BaFqzcMfO8KRXfK65Jw7/5NQStCRn8o+NQLUJYwsTWw+mg==
Received: from CH0PR03CA0079.namprd03.prod.outlook.com (2603:10b6:610:cc::24)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 14:42:25 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::c2) by CH0PR03CA0079.outlook.office365.com
 (2603:10b6:610:cc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Wed,
 9 Apr 2025 14:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 9 Apr 2025 14:42:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Apr 2025
 07:42:11 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 07:42:05 -0700
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
Subject: [PATCH net-next v2 3/6] xfrm: Remove unneeded device check from validate_xmit_xfrm
Date: Wed, 9 Apr 2025 17:41:30 +0300
Message-ID: <20250409144133.2833606-4-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e995db-e309-49dc-5b68-08dd7774be9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jBfvnzQ+kJtHYpMkozfRrDtVRDz+Se79bmrRwjxObFMsmvnMkODRnBKomNdP?=
 =?us-ascii?Q?bA4cteS9mZVPQ5ZnE8kCU6wb9MZUa4939FKRYS1Vo4n3kkAuis3yw7FqIenO?=
 =?us-ascii?Q?9Ul/e8nqlwtuW7HaJnETJ0Tj/hVZkgzlhZ4r/HmSLMJ9X3fwrJkQyXFMdOKS?=
 =?us-ascii?Q?uk3Cgs7mOfi8P16mLUKVQWolnTQS0sWEIQS2lZab5iviJPolFQ6OO/ln5eur?=
 =?us-ascii?Q?qjS11FwuO++/3DOGcHH3MLEKqw0mAA5IIVtM1gq0WTmfT2LqiwHu5nMQLSsX?=
 =?us-ascii?Q?jeAw9hrDuE6WkyU8L2vQSkR8/C03EjPwR7EbJ43iMvlVRyz/CNtI7mq+hPmB?=
 =?us-ascii?Q?vx1Ng3R/1se8VdXqTkCMR4a5kHrE8WJLANYtwP8JoOlJgAAP3XTYNwazlqf7?=
 =?us-ascii?Q?jotxtLnBWA7oUyaO68bNyslsUl2ycIPadVHb4EVDzelhFJJmRsKmxP+h+haC?=
 =?us-ascii?Q?MuEzxzLUxGkknED3bWKBFauAcKLEppzBaTm+43YHR+6cUvA7xXwsOd75FLMe?=
 =?us-ascii?Q?+7blEFR7F4qqCclP4YeIfsCiD2zJMwmn1XarimIxj5AgcwfH9LRsH/LgpjSM?=
 =?us-ascii?Q?iNPORKRUNqgRpXOMDD75R5oLX6fxfNapHrgyM9hrQ4ZPKUh87/mBbmOVE54f?=
 =?us-ascii?Q?9DRZl03N0pb7NXFfJq1jBK/DvIfjC7xXM9hlzpeHHa/cC1sDJ+AfEaUIsvBk?=
 =?us-ascii?Q?2JJa/09tY8AMUq4hvIC/G3BVwoMBDN0r5zWmtUcjoVd71lOSIK11BTWJZRcG?=
 =?us-ascii?Q?sBa5XfjM5l4wQ2L1IFCCgA6APS0i0/m9srPslTMuMMJxb1DtBk3fK0gRmNCc?=
 =?us-ascii?Q?gCSi+7p1GH/8PEf6nEbszkeLFBz1DHCgn3RjUoMvTYO8pw0PKee3F5acO7yw?=
 =?us-ascii?Q?NZCYgVSMEpAYodGpUr+Wkq2BUh4rWJ9ktH0+zFD1YCuTXAkEAdCS2LGiLbfP?=
 =?us-ascii?Q?jYRlwrvfwHg7YLzCTCsVNViiJw6TENom73z0Rg1TeF+97/rxPYUzNdAkf4Om?=
 =?us-ascii?Q?dAi3iDQe8QNcLOMuJ5g04UBFA1nmQo1MPNTTy5zaAePvGySuVYGh0OrLIW2+?=
 =?us-ascii?Q?v/v6m3ETFJ13w3DftP1AKvyBfwsvjzCs99Ef+Cts6h481oPEoqynzRPJOkyB?=
 =?us-ascii?Q?kDdzMLrbNmd4nvQD3Xu1781g7HeaZHsNFRVKXXk8BgNIcUf4CAyQX22av7wQ?=
 =?us-ascii?Q?aD0qEA/meLoXoe66EtbxI9ZVWpGEehp/U/g9/2ZfRIQ0/qdojdVyW2uiVM9X?=
 =?us-ascii?Q?yLl56GHfCFGZegy7/09w/c8DdoUF/JWmStbKaTqhdnOOoLOLrOVKdp0Mo0dU?=
 =?us-ascii?Q?6hbHVzuPwQWpOeK/fPRPb0GLzvbSySP4E29wUip/VGzsJTJKCdvUX6cAj/Cz?=
 =?us-ascii?Q?vRhhPBK5xgYUWwDFv7R6ceWi9kpp3KS5eJTZl5IBWrBzz62/itKB+6wkNzuQ?=
 =?us-ascii?Q?//J5aKCDlqzvy/+2TwyOnDPpS35+spWYgdRpR4sETURKonnJL/hZQq3zYROD?=
 =?us-ascii?Q?84JYltYlHbxSjqQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:42:25.2680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e995db-e309-49dc-5b68-08dd7774be9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732

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


