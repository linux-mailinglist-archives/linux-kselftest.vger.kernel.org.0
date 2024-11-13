Return-Path: <linux-kselftest+bounces-21917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F59C6ED7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047F21F223AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7173D200CAA;
	Wed, 13 Nov 2024 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wGfCjgyD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AF200BA2;
	Wed, 13 Nov 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500110; cv=fail; b=lQ6gTydANCOBqP9Nh4VKqVHu4lj5Mx6rRHIE1VkStP9ChH/Jp/DsYbHfsADDbOUrM4Z7pS/ahjOhTvUIXP45uu3j+p6+nHaB7YW0yxPAVyVaweT8ioEwwWUm99yF7A40tY3la1xm5mLUMxrZUS3+R1OjGzoiIzQsWMXYixQubPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500110; c=relaxed/simple;
	bh=ROnCRq3rhIJHktNzI63tNz+5VzBVybrnF4lNFaJMcUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcMnI25z72cDAmPzfqvRX+CrszKqe8tDNotro8RUxiTFWZyHU91ebT+PlAWUcUKQigwqiVEm4Tw/KLZRlE1lSHENFjT9eHrWV5yOdsY9mvLZINQ5QyX0zR1O5n1rmSiEgeV4++HCzekkaJHdqJTBgQNza22Z6R6gDBg8+v0bcyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wGfCjgyD; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZlMpfLiYLwhdrOxBSDvHZrkH7bmwI4LY3uRJP/5WBt79xmWBt39Y2uN4ROyfsGxYAQxUKZOkSAQmytyKGsVz4rA0Rebl9H0XNEDcqCfFEHeFQr3ymihzHFErnxfjMJcv1Xjkl5Z5hshOTlClx8ZOOY4aYA2XPK2oHCynLuBQSVxdhbMGwNNvd3SvbBrXEjUA2VuNpgIUNuPie/7n/swmntW1qN2CLqNZmXOS3GJJ3pUyrdwQYu9FGRaQmLsRKVqEhqDb5owvLwYrxuZQgM6lhPf4pCKMnTM4f0s5HCkwNnxmg8a02F3mEDhw+vkAFYlqc9HMVeiHLnMnA6FZ2N0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+MPPKYjqNl5bftrtbUU7Xix7feRxOVk21zH7qcZ938=;
 b=lI09nBv2qH+SPVPxwUvkM+TRkLlUzrbjp5MB4kpci5ZOsjoKE7xdLvewlhBTU0tmVZmINdPvsGsLpztFY0Dl8f+vmWiKlSeDRaRoNujHcXVWVavbJdabmGY5DBWw4xjKdgxer5ipWfPapkiJB4BTlOhTsHsQsiqfVUpya6hFcAI9Qs+DbbippPYh+iDTEIdC8QD5nACpOgllO3mEnFktvrZdtFjSd4UyHNo3XFyRo+0nbR5EGrnCtMXJAAqx2o74UpGBhE2iyEnNRMwPmSVF/x5zDfmxknl0ZwiAll/0eLZAtkUaRhIDe/9PTx+dtzvR8EgMWhi9+vrGiXp/IOEkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+MPPKYjqNl5bftrtbUU7Xix7feRxOVk21zH7qcZ938=;
 b=wGfCjgyDQyXkupUyhYENC2xyHWFtvTLe8GsB6duPEoEqUnT5l7d3qU4u01JPQ29iR45h72euW0BYxwL1YuueVa8muPTnhnR083Dmj3NgDwR8EbtCfYOKMUa5eIbISh4LCh+RSN8mYwQhili3WbyOLf7Wv7GaOVftoDdBK4F7QWU=
Received: from SJ0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:a03:39f::9)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:15:05 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::cd) by SJ0PR03CA0214.outlook.office365.com
 (2603:10b6:a03:39f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 12:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:15:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:15:03 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:15:02 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 06:15:01 -0600
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 2/5] net: ethtool: account for RSS+RXNFC add semantics when checking channel count
Date: Wed, 13 Nov 2024 12:13:10 +0000
Message-ID: <43257d375434bef388e36181492aa4c458b88336.1731499022.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1731499021.git.ecree.xilinx@gmail.com>
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c0e60a-2636-4fe5-c16b-08dd03dccee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eAEqL3LLzuhWYLWxtnMnDEni7sMs7u/DD5ZaAuYqI16A7sjjOwamW4yyqaal?=
 =?us-ascii?Q?slT89Z8nVxrMkclKeI8STh33v3WyRnt392m+tF3fdEX+G2tTSg4I5BwycJeL?=
 =?us-ascii?Q?bm1WTcyg67HDmhbY6LHAKRfUGQOG8WPKOLMAKJyhRxUx92nYuj9KHcHmWkma?=
 =?us-ascii?Q?mHizrvMTUEZAdoTMxVYxCgAZMxYBHHyVXVRPfqAacQohDPs4GNz4bSzT2uW7?=
 =?us-ascii?Q?6HuAAv3ZikNu29lw9Nv+gEgy+Q8CRLYq0ooJhNGq6R2wrXwQ5TIjDOMXdyyS?=
 =?us-ascii?Q?Ub5RKAdofYrwL2wjzE9kpt3d1tWliyvtGDe7fqNuvciuTUw/9NKBt/tDC+y/?=
 =?us-ascii?Q?kdqRZl1xJ/0xqSWNYi6bEmaw4fYxRdTlby9BcNYXCaYYxubm6alxBGwlAPop?=
 =?us-ascii?Q?ERgEGdQHTOn+4ujNUY5ae/WPKWHzgJ29I18HlmDt1u1w7xn0jLesUSsxqpfw?=
 =?us-ascii?Q?SkRpPJjep9YRI6CKy0TBpRk6YhMBsCb054gjfyE0KGxS6Fjq3xd5qfcqlbO7?=
 =?us-ascii?Q?WWYvMD5Rb3yKuIPFL/MduAt0nYrKG2eDzKEj/IHyZgaoCMtbOg62iZXcMw/5?=
 =?us-ascii?Q?PqeGZrxxnZcQBrqwMX95nZAVqLb7u6l9XcLP6JvT2teswyANaAzY0/zrD71Z?=
 =?us-ascii?Q?+QMdOpBUosiU9s1VKcIgnLWhc39TN09DTwETCfrXgVqThV6mcgISYSXHU/gk?=
 =?us-ascii?Q?nBOWTE24SjwnyixTBOHdu8YdXxHFz4aAj6p/zRo4SY2IntWbW/XyfvsNTWJU?=
 =?us-ascii?Q?vWJU0e9HmEuw3jXqv8SXE4oVAgbOx6i59t8VYBojBJKS+mpJxgOSIMxHrG1l?=
 =?us-ascii?Q?zsgYEDNSnctGmGr76vKAfxJEKdO0wfZyGaNlqIffVzvjms2V788uaPRjp0Wt?=
 =?us-ascii?Q?+lRUOdRX1lhFjnxnOaz7XjufPkVKCAFWk9wWvxf8yP2jWpSh6/9GSB8i/kgJ?=
 =?us-ascii?Q?RFz44BLTkRuNnymkb612+tvmpbYdVp9BIYnXKH0rihWLJSdG2FS0TGKjQNnH?=
 =?us-ascii?Q?7VvG+QTYTJWqffK0Wjr6hOBBHQAiTEeOEmwhuW7pZR5w2Wd5OY7xwCaXEZiH?=
 =?us-ascii?Q?ttBKIcObuCGLiHHSlJE7+RMpVQAUHUyjaHCMVq3yEonu5kRY3IEZwO820vpw?=
 =?us-ascii?Q?7o4NEHUuhII/tZktr+7KVGjt7gNLP1pnZ1b+ASR8utNeGOGMo5C/zoXSvaEk?=
 =?us-ascii?Q?pTrAxX2r4lDy628lEkCMiWj0MkYhnA4bwmJYlqYaxrOSHQpBZBMckn+I3jg4?=
 =?us-ascii?Q?F0HU65+dNm/Cc1boHzTrrMZ74+kllZXzTvqLc0v4LYI5o6R8b+Fk8i1JRPWQ?=
 =?us-ascii?Q?5nfk8xAqbgL4eCT3Zg++kElHdxaNNW7lNyrQ198Hr55WsZRbA0xVi9AxGfcE?=
 =?us-ascii?Q?qrfe5JOUNMNcxNpDdXBAzdBh4JqAJ78Uj0BtGUUE013/vqiH+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:15:05.2155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c0e60a-2636-4fe5-c16b-08dd03dccee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767

From: Edward Cree <ecree.xilinx@gmail.com>

In ethtool_check_max_channel(), the new RX count must not only cover the
 max queue indices in RSS indirection tables and RXNFC destinations
 separately, but must also, for RXNFC rules with FLOW_RSS, cover the sum
 of the destination queue and the maximum index in the associated RSS
 context's indirection table, since that is the highest queue that the
 rule can actually deliver traffic to.
It could be argued that the max queue across all custom RSS contexts
 (ethtool_get_max_rss_ctx_channel()) need no longer be considered, since
 any context to which packets can actually be delivered will be targeted
 by some RXNFC rule and its max will thus be allowed for by
 ethtool_get_max_rxnfc_channel().  For simplicity we keep both checks, so
 even RSS contexts unused by any RXNFC rule must fit the channel count.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 net/ethtool/common.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 0d62363dbd9d..05ce4f8080b3 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -538,6 +538,20 @@ static int ethtool_get_rxnfc_rule_count(struct net_device *dev)
 	return info.rule_cnt;
 }
 
+/* Max offset for one RSS context */
+static u32 ethtool_get_rss_ctx_max_channel(struct ethtool_rxfh_context *ctx)
+{
+	u32 max_ring = 0;
+	u32 i, *tbl;
+
+	if (WARN_ON_ONCE(!ctx))
+		return 0;
+	tbl = ethtool_rxfh_context_indir(ctx);
+	for (i = 0; i < ctx->indir_size; i++)
+		max_ring = max(max_ring, tbl[i]);
+	return max_ring;
+}
+
 static int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
@@ -574,10 +588,18 @@ static int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
 
 		if (rule_info.fs.ring_cookie != RX_CLS_FLOW_DISC &&
 		    rule_info.fs.ring_cookie != RX_CLS_FLOW_WAKE &&
-		    !(rule_info.flow_type & FLOW_RSS) &&
-		    !ethtool_get_flow_spec_ring_vf(rule_info.fs.ring_cookie))
-			max_ring =
-				max_t(u64, max_ring, rule_info.fs.ring_cookie);
+		    !ethtool_get_flow_spec_ring_vf(rule_info.fs.ring_cookie)) {
+			u64 ring = rule_info.fs.ring_cookie;
+
+			if (rule_info.flow_type & FLOW_RSS) {
+				struct ethtool_rxfh_context *ctx;
+
+				ctx = xa_load(&dev->ethtool->rss_ctx,
+					      rule_info.rss_context);
+				ring += ethtool_get_rss_ctx_max_channel(ctx);
+			}
+			max_ring = max_t(u64, max_ring, ring);
+		}
 	}
 
 	kvfree(info);
@@ -589,6 +611,7 @@ static int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
 	return err;
 }
 
+/* Max offset across all of a device's RSS contexts */
 static u32 ethtool_get_max_rss_ctx_channel(struct net_device *dev)
 {
 	struct ethtool_rxfh_context *ctx;
@@ -596,13 +619,8 @@ static u32 ethtool_get_max_rss_ctx_channel(struct net_device *dev)
 	u32 max_ring = 0;
 
 	mutex_lock(&dev->ethtool->rss_lock);
-	xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
-		u32 i, *tbl;
-
-		tbl = ethtool_rxfh_context_indir(ctx);
-		for (i = 0; i < ctx->indir_size; i++)
-			max_ring = max(max_ring, tbl[i]);
-	}
+	xa_for_each(&dev->ethtool->rss_ctx, context, ctx)
+		max_ring = max(max_ring, ethtool_get_rss_ctx_max_channel(ctx));
 	mutex_unlock(&dev->ethtool->rss_lock);
 
 	return max_ring;
@@ -611,7 +629,7 @@ static u32 ethtool_get_max_rss_ctx_channel(struct net_device *dev)
 static u32 ethtool_get_max_rxfh_channel(struct net_device *dev)
 {
 	struct ethtool_rxfh_param rxfh = {};
-	u32 dev_size, current_max;
+	u32 dev_size, current_max = 0;
 	int ret;
 
 	/* While we do track whether RSS context has an indirection

