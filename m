Return-Path: <linux-kselftest+bounces-30526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB50A855DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4B24A4674
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252DF27E1AE;
	Fri, 11 Apr 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fbAJsKhE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB227CCCC;
	Fri, 11 Apr 2025 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357855; cv=fail; b=NPXP9vqnE3GkwieiUzjdVOh8H3yR2k8Oz4OsoV7wnFJfghQ1696KuyncdWYhg6Bv4VWDLR9lU6RP+pxOguKBQ0emuqcnk59M7U7XRdWIg5+CNqppL6aPzEVtexIOmmgpxrAcVVQMDVDJSfikFWWpfB8C4J6LYCqRUZfXhEg+E9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357855; c=relaxed/simple;
	bh=iazEz40QiClbJxAIKlFR2LeyEukHV9LvwHNFn1LzXaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uH6GBh94Ziddu1oVi+Nh51yVvclbsJF2hFTVXLooe0UT7c178Q1br0A9iu5PpTiKpjbz7ojbAreUMuTT5uq4XxgGZ5SgxhbC9sqwzkiym3bpBxyJbE7O/DgedsczEHh9roiijjY9ZHkVMIq1e80PwtdArKhXRIH7I4I/QIWfPnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fbAJsKhE; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSm7rteG9bmY0vIesYVH7qZvwPtZ30RqYxq2pODd9AKtAl9Nv20Hiw6ZoikDq8Z6fgLHTroETwyIilrj8d2MjdVJbw7qbeXVsHX6xe43moPlt2e5gbHiab7XGf2CPCyZuXnmCLCQIkNtYqx9DbQxkL6p5c/BAnA5zjPLgexjyc6ysdJdjgeqjg4t5WHvTe/d3OevXMjeF75etD0p+epugGDQ30C67aHAc4t9zua0JeWYFwSmy+xFvS09TCtx4JWO3KTiEmsZwdlTQOvBk8gvSIChLo2DdlAQmRh7pbk4mrmVQyxk8mloWsEIvz++ru/sf7yHlJ86ZPj8QGBoNlJ8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtZrrL633P7mD+R159+1dgIZxXtl2NK0stD0V2JhJV8=;
 b=gF30ZlaSzs6YNcoZS3Taw7U502F+TtR+yP1Y9/LeYKNb2mDOaC8Yne8/eFvMcyuLtsBIhWyg1MwIlLZ50kPUUEKMboAhIWkP2CgaO/pQfonVmC1u7w535m4WEez5OHWL9JW3mfRRwAQoSmj/MR+0P9fKkA4FZF+8SnEtCa6b+/A5lwnuIrbAzZYz0Wc3hfqgVfvJkXOtkC8ONe6Y/zGqooyblgDmk7KcWvgFiX7sMBl+9udTbH6rXo2KWgfk6YOK7whONf9kjtY/SjdOgyg7qLNzXCe/w62Rk0CyhTnopK6NZWgcuRoDlETbAGoq4LwpSMkQ2RkbmTJVLjr9mDanxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtZrrL633P7mD+R159+1dgIZxXtl2NK0stD0V2JhJV8=;
 b=fbAJsKhEiYtxXMe0g20rYnbCfjHeRNi8r+TOzpLtDSmkFPB2uvZxA7OCSbCiuXbCSBEXcSgeqWvqHnt8HRhcGKYDwFTpiHo3qfqNa7Q+Z5pyfU3lkGY2wmYMUhCwxpMf/gzRfy6TK2v6JpomuHIIHZJqp2A0R21xEfBmt60zmXzsrYvedqZoocNTl1Bx53ea2I5WzpYbMYeVVFVgA4iovMJnhj9YOU3F5xW/lLAMb/ZYL2Z+QnwuF5Jv5MMn4zfeAKpeRECuSAWSiOGO94Ku4+gpTbBersoNFkSQVFxRBf4f6fKm4w46LgEBSjv6Cs4hWAfYqSMehGQK1KoAoCJuYQ==
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 07:50:49 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::a1) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 07:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 07:50:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 00:50:35 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 00:50:28 -0700
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
Subject: [PATCH net-next v3 3/6] xfrm: Remove unneeded device check from validate_xmit_xfrm
Date: Fri, 11 Apr 2025 10:49:55 +0300
Message-ID: <20250411074958.2858496-4-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cfcdf7-96fe-4275-77ca-08dd78cd930f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?10YcD/2H/t4XbMahy6ju86Gp9eBBpLGyHUe0SWQNakWbPqwQttUgKaHea6ZO?=
 =?us-ascii?Q?CdBEgN6KPJO9aGdb296WB83/xw3iBy2ihO6pEv6FuBMtlguRGtX9+2UC6KMb?=
 =?us-ascii?Q?6GFA44JcS62L12e71lcNjk9cWRjNWOWvrMwrL3bDq8sev1ualBL51N+KfXH+?=
 =?us-ascii?Q?eTy3kqeRwnrkI4a1Vsw2z0MT80Y1bi7Ne12iiQ7p1PHMRHINPKmVsZw/GEX+?=
 =?us-ascii?Q?/xXRwYwjTQYO4R149oO/dnd9wjCbNvZO424zby6IYenSLAKBWX0PiARJsxab?=
 =?us-ascii?Q?zkSXnnf7byOmQCz+i/wYP3WmFiltTeyUfE792UK9G0/395kFWZpyY1sYgZ74?=
 =?us-ascii?Q?o195wy+40KLGqlQaAO5hxyFgrfxf/Bqww2V3YZVofA81snTtr9X6f6mvszx4?=
 =?us-ascii?Q?OjP2HFNH6NyGgycjoKAa6XB6xwl2QIBwY5zMI8rpno5tGaYRfS+HDPD4OSCI?=
 =?us-ascii?Q?2YqT0Ho+Ad3rBS7nbbutII4SiNHYEgiY7xddQJanfDyPARlpErp24X/cHUma?=
 =?us-ascii?Q?TLLkisHrvmAjvq63gEPSV9cSbcTPFcjJirPJvYi66MwfzlfE8+UatLdFu/dt?=
 =?us-ascii?Q?TqHC8A4U0w7QJ1yy6/uo++NOUgwSUXPc4s2dVwadKAFGJT4CMevb3jXoSiY+?=
 =?us-ascii?Q?+Hvs9AJY5SmvrM7GxHVlJeZ015lYKKJfKa9DrCI3uVVLZxi4+1phXsUbyrYN?=
 =?us-ascii?Q?Z7ztGsmnU1s3PWImaslw/TkdCOyJcSZbAbcfpxFCsVk2W+X8t/cW6TYobsWT?=
 =?us-ascii?Q?t6RT0VuUI5QoUxcYDaTp0Pf2s8vhuMX9zhBm3VRfGEeolk9J1vMH0Fo8HGLx?=
 =?us-ascii?Q?7WPWMjJrxBZdLezy7vEGV+NdfVYnZ25Q5xolZ2growq4sLaYrgjcpXTuwXy0?=
 =?us-ascii?Q?Lpxs+rRKbJlV6qyva+xxfJ3XMaKnL3Cxo45HMibffdKOLE1HaYzJVRfhZUxk?=
 =?us-ascii?Q?OD7MHEKCov7jeVD9iOY0Dq7YQRC+cWhvk5cSade5YH9dHewgZFPiAEN8apUE?=
 =?us-ascii?Q?o1wPTd8942gZ3kw/LDtrxwX6govgYM49/wOO7FTUPv6vf+m+eJoXWp3czsrC?=
 =?us-ascii?Q?oAb0AWxyxUOSls6BvmDlstoxDA0rmvaUHiJeD7hj+PpU36SfgahfPT1IqU34?=
 =?us-ascii?Q?nonuacRLevC2nS1Ug8oT3DJZMdJn/bXp4gIv0MpJfdI1VhOkc8ofqVSNgaUE?=
 =?us-ascii?Q?y4HW1LmDEx76qbdPQPeY4uiw/rYvihr9nMMEGLmNB/ySuq15UOst5CiJ2UCv?=
 =?us-ascii?Q?9WxxVv0P+pbiTU+gNlGrA4BJVay8xaTh9RjUoRF4R3pCaQ2ao2Vnk95zTJ16?=
 =?us-ascii?Q?Cr6h4Hf0sdvLNDVKoj2884qBKoSL9zGRUMkltieR2/WjX8vJQwhMSgeRjHUB?=
 =?us-ascii?Q?IbchnIwxRcyHTBp89DnYOHwVHAbHx8ORwUiDnEYCDC70oM++BiR/iKKIjQst?=
 =?us-ascii?Q?PhcQ2rADlUnJATHojexTETobndbL4ipPUm4bqgAqMV5fl+Bya0v7a7ThiU0q?=
 =?us-ascii?Q?04DEuOQByZ7SihUROwzCC0FzjAhGFpcTUvzc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 07:50:48.5809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cfcdf7-96fe-4275-77ca-08dd78cd930f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446

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


