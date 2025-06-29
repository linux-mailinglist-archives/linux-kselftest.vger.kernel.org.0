Return-Path: <linux-kselftest+bounces-36071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3BCAECDBF
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D734616DDBD
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AC221276;
	Sun, 29 Jun 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m43iUjpC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCFEEAA;
	Sun, 29 Jun 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751206948; cv=fail; b=j8TqSYz5MrciMgPnCyRn7TkPY/xzu+Ureddf5jdwfC7DK8TALWASL3eDfdWs2wa6ZdLVC9lr0owZgkTCdOm6RhD/vYT88WlwIM6TIBKISRdFVfg0iT29ok6+/CMHpX4ivDGCCQQH5Y3zh2rRVNSJBXCU8AWkehUSCEOaUkWz0lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751206948; c=relaxed/simple;
	bh=rw+d81LzVMe2pbLRjwdbUgxkPFXpBZ4LFKSTL5LFAYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWkHskfTQ5cuO3cU4UXusKYJ6As6b3EsknDD+D0U1xQ/dxN4ljSm/pMLiSMCu0yPiPmslazjbFr693jsqr1uWa+YGw4TMHu6USwRdCbmkG/qJD5m0+vr6Iwe1JQZ4l8tx+P2TnoztbsZphwnmdSHhCVFIxloWvZM6GN8I8IX+a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m43iUjpC; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSJKkQ7nNgzEqsCiqY5tDTYTeh/pauyELzqSkzh0+rBqPZLmhjo6eANf3/II4pup25DfOpRc0/+Q7FUx4DQFDk0tpksATEq7n3DciQeKjQbRa2w25Ya1teyZ62AzjuiXaJMK6hNYqADIn6mAuusjzEw1bXvDBsaZJSMafBTgr346iIjKpQIpJ53bECL8rhFh1tTBvppUut5UztQ17iIzdp0I1BUJWShrjuCX+kfgC0vZyq2o7cqJyQ6nOWaQJC+RuOgS35LSbcB93fcj0RWHnn0MUYHY2+SWw0D4RduNih+LMnOiCd7NyOy/0d4GQZLN7WruuiR4CfjXkUT+YQkDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY8V1IOpinlAUVbacXxe6uVAe95YsZtn+MNV7410Dus=;
 b=OPy/m/D3wALflPr4RXIt8vk5b5jdg2ZDMDegx7+BKbkBZKBGpPmVZxg+QdUFxMCut5S0QH7Ms1LyS7INaeFG4SdfriX5Uigpq1AEbfXpDbKbKXPjPbMiX7+YZJNWUmNcuZ4NiwRGPXAbRBeUDF4oR1QzVRqQqipt3YHjR5/S9vxpHxpyWQwyrbwJRAM7ACM32CueDVdUhMS78y9kqbhlMLlvYLOFfBwfSWAL1l0uKv0Yljsx7x0B8DEh9+k1722paicN2XKwn/PWM2CL+PX0eQz8NCpwf9+4YqUk1OLYvuI1mjTU3pKgtDjBUQ0khJHcFboKmyS+WfPHms2OT/BO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY8V1IOpinlAUVbacXxe6uVAe95YsZtn+MNV7410Dus=;
 b=m43iUjpChMp6eDMoh6f6tXRhVmE2hgjEoCE/swlno0rsUHfa/M1JMBArxA0aASF2XqjAOPVTTaQjTcRpWNkjkcuBKRVLuHf+c+/c0dljSZpyy9J4Krv1mNeO8F6eYFldTE3HATHTkVf3kIEgjKhrAztZdNOL30bI8hPgR3EPgXFq+0USt70DEQ6PGZbqgB8wjul5+pVOQIZf/CTlGOfwvqTLheyhwKLhrJmmRm0UwuuuRS0h46MKMxWF7hRy4okBTCiG4UhYEHVjYOjc4su5++nfuNOqFYQkr0diIqUD4wHlvEjsV6tLYzFujIU3iLRUf6b53YgYmL0LPRYwkD9AaA==
Received: from BY3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:254::9)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Sun, 29 Jun
 2025 14:22:22 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::8) by BY3PR05CA0004.outlook.office365.com
 (2603:10b6:a03:254::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via Frontend Transport; Sun,
 29 Jun 2025 14:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 14:22:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 07:22:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 07:22:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 29
 Jun 2025 07:22:01 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
	<leon@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
	<okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, <idosch@nvidia.com>, <razor@blackwall.org>
Subject: [PATCH net-next v12 1/8] netlink: introduce type-checking attribute iteration for nlmsg
Date: Sun, 29 Jun 2025 17:21:31 +0300
Message-ID: <20250629142138.361537-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629142138.361537-1-mbloch@nvidia.com>
References: <20250629142138.361537-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|BN7PPF34483F4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8fb8a8-554c-4947-9d6c-08ddb7185cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oU0PIL/SmT0v9Q1FDxuKbyJAsB3vz8t4P5nQMP70okfgmZHRbE28i4qgLGOU?=
 =?us-ascii?Q?9rzhEKY6y6UXESdGiBP45PUURgdJLhQKe4PTG0Bg5faa/RRUVK43R2w+VPC/?=
 =?us-ascii?Q?9oRE8zDaR7DlhoP9HnNlS1oilgEzCf6DlU7+JbFDwvSJEH1cYsUnPCtc6YfP?=
 =?us-ascii?Q?UEUUdYUyIpwUlyJkwAl2AbPVVYdmv+enY2ujgc3W4qRki2hxcRNXNcVH+ftV?=
 =?us-ascii?Q?PnjBU+hTLwPWP2kDz9xqkzM7KzuhFqPeFU0FQgTkuMOatfw+7AvDqu/jFpmV?=
 =?us-ascii?Q?P9ruXBaj8yn3KwenvIUrrAPzk5YDm42YoWo/DNvZ6V55ag63BHFpRXGK2D39?=
 =?us-ascii?Q?vP7QMZ/B8hZXiousvORLMXh0QqNFOWjNQedTlq8UqmIjj5oLXr5Ck4e+Mpjo?=
 =?us-ascii?Q?Q/AnKg4MVFdfZHapnbKH8y6vG+RMMTcVNkqSulspEeYl0cnZzx4yHqFCO66o?=
 =?us-ascii?Q?ulLHLuFBedNnihBbSl2W/vbGfUbyZH6NdqmAU4ClTwuNmwKrIsiNFGZvbXR4?=
 =?us-ascii?Q?baMCrH0gaPHQl79shU16vJZv8HDzEQ9VfUCBrovQXS1xb0hJc2bW0lXyVL03?=
 =?us-ascii?Q?NTS4VBzmihrMWmUO/N4smRovqxP5waeyp0A+PUKB0O9M2+K84/1ZmLZ2xNsS?=
 =?us-ascii?Q?T1xC5DGW03AzolmHcLgSd/syFlbut6XRpfsWiN2HSDwx/PT76DCOAPqIBS2f?=
 =?us-ascii?Q?8zA45fCHJDRmXNoBHSv3yJs7LCOgcElPKf6US6gBJBwmGhUmLqFBIRJ9GJRx?=
 =?us-ascii?Q?hDkHTSMg9LLLMhxaH+SK2kSQXLcuZeTy+E8eNiLDplloUIeg7eU+Hd/9NgFD?=
 =?us-ascii?Q?Ov/zInQge5/wAUeRp+li0tH8fR9hfdKhkDKPunGdfUB0oAuo9u4i4Dc7snes?=
 =?us-ascii?Q?a4nYDGYGgF/vbP4iW3sIxgzzFGq+334JIiEV4i7DPjXj+ZzRHhox77rCxip7?=
 =?us-ascii?Q?wNseEXHPwsXHeJYBKUgg4SvPDbA6QQaF8eiSViZPNg3o6dgdrtOvO4DAifn9?=
 =?us-ascii?Q?1ZWhWMxQKs4VoqHa7nHrp22kaW53/CrkdZaRN7egZEXiTHyAWDn6EY/0sNa8?=
 =?us-ascii?Q?5Rk31clUWzNxDdobKpEMvEhQKMB5ZPLp7rVQW49JVnJTginf0xPRnserUjAC?=
 =?us-ascii?Q?mQpXajgHpzmbDscTxPxlHh+2X71Y5r2IrokR6nbFHAOeRQq5rQ1Pv+2Y+Dru?=
 =?us-ascii?Q?m7iCGRhMdWu8w68yNKATMmisqzo5v5/OjCyjTBxJaAAAf4TwpI4fx8sRTO3L?=
 =?us-ascii?Q?jKJsnp/qJhAPjmxjrHDLdlpqjr/EP9UBqfC3ekzevogIGno+pSC+ZqQ9xW0I?=
 =?us-ascii?Q?3zsWWZsQINiJYp8cr3nVrr0aS30NrM0ssxtuyt3XN1dLXj4haVX9xX+KSaTQ?=
 =?us-ascii?Q?qk54wxNy1F7xy/yBLVvUXl5MmqXGxHcsPXpFVbS7+d3HN+mtgoKlepwtuPVM?=
 =?us-ascii?Q?iaaoW5F4aTFq+vJR0Gv5nmuZU5m5J+N7NEX5/MAX2nMeW6kE54SYu3adll9z?=
 =?us-ascii?Q?oXJzBR0DSgoR0nQnonaejMMv8uq8eYKZ3ldO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 14:22:21.7678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8fb8a8-554c-4947-9d6c-08ddb7185cb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA

From: Carolina Jubran <cjubran@nvidia.com>

Add the nlmsg_for_each_attr_type() macro to simplify iteration over
attributes of a specific type in a Netlink message.

Convert existing users in vxlan and nfsd to use the new macro.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 13 ++++-------
 fs/nfsd/nfsctl.c                    | 36 +++++++++++------------------
 include/net/netlink.h               | 14 +++++++++++
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 4ff56d9f8f28..adc89e651e27 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -971,15 +971,10 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
 		return -EOPNOTSUPP;
 
-	nlmsg_for_each_attr(attr, nlh, sizeof(*tmsg), rem) {
-		switch (nla_type(attr)) {
-		case VXLAN_VNIFILTER_ENTRY:
-			err = vxlan_process_vni_filter(vxlan, attr,
-						       nlh->nlmsg_type, extack);
-			break;
-		default:
-			continue;
-		}
+	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
+				 sizeof(*tmsg), rem) {
+		err = vxlan_process_vni_filter(vxlan, attr, nlh->nlmsg_type,
+					       extack);
 		vnis++;
 		if (err)
 			break;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 6a42cc7a845a..657d44afc062 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1621,10 +1621,9 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	/* count number of SERVER_THREADS values */
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
-		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
-			nrpools++;
-	}
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_THREADS, info->nlhdr,
+				 GENL_HDRLEN, rem)
+		nrpools++;
 
 	mutex_lock(&nfsd_mutex);
 
@@ -1635,12 +1634,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	i = 0;
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
-		if (nla_type(attr) == NFSD_A_SERVER_THREADS) {
-			nthreads[i++] = nla_get_u32(attr);
-			if (i >= nrpools)
-				break;
-		}
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_THREADS, info->nlhdr,
+				 GENL_HDRLEN, rem) {
+		nthreads[i++] = nla_get_u32(attr);
+		if (i >= nrpools)
+			break;
 	}
 
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
@@ -1781,14 +1779,12 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 	for (i = 0; i <= NFSD_SUPPORTED_MINOR_VERSION; i++)
 		nfsd_minorversion(nn, i, NFSD_CLEAR);
 
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_PROTO_VERSION, info->nlhdr,
+				 GENL_HDRLEN, rem) {
 		struct nlattr *tb[NFSD_A_VERSION_MAX + 1];
 		u32 major, minor = 0;
 		bool enabled;
 
-		if (nla_type(attr) != NFSD_A_SERVER_PROTO_VERSION)
-			continue;
-
 		if (nla_parse_nested(tb, NFSD_A_VERSION_MAX, attr,
 				     nfsd_version_nl_policy, info->extack) < 0)
 			continue;
@@ -1939,14 +1935,12 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	 * Walk the list of server_socks from userland and move any that match
 	 * back to sv_permsocks
 	 */
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_SOCK_ADDR, info->nlhdr,
+				 GENL_HDRLEN, rem) {
 		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
 		const char *xcl_name;
 		struct sockaddr *sa;
 
-		if (nla_type(attr) != NFSD_A_SERVER_SOCK_ADDR)
-			continue;
-
 		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
 				     nfsd_sock_nl_policy, info->extack) < 0)
 			continue;
@@ -2001,15 +1995,13 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		svc_xprt_destroy_all(serv, net);
 
 	/* walk list of addrs again, open any that still don't exist */
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_SOCK_ADDR, info->nlhdr,
+				 GENL_HDRLEN, rem) {
 		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
 		const char *xcl_name;
 		struct sockaddr *sa;
 		int ret;
 
-		if (nla_type(attr) != NFSD_A_SERVER_SOCK_ADDR)
-			continue;
-
 		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
 				     nfsd_sock_nl_policy, info->extack) < 0)
 			continue;
diff --git a/include/net/netlink.h b/include/net/netlink.h
index 90a560dc167a..1a8356ca4b78 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -68,6 +68,8 @@
  *   nlmsg_for_each_msg()		loop over all messages
  *   nlmsg_validate()			validate netlink message incl. attrs
  *   nlmsg_for_each_attr()		loop over all attributes
+ *   nlmsg_for_each_attr_type()		loop over all attributes with the
+ *					given type
  *
  * Misc:
  *   nlmsg_report()			report back to application?
@@ -966,6 +968,18 @@ static inline u32 nlmsg_seq(const struct nlmsghdr *nlh)
 	nla_for_each_attr(pos, nlmsg_attrdata(nlh, hdrlen), \
 			  nlmsg_attrlen(nlh, hdrlen), rem)
 
+/**
+ * nlmsg_for_each_attr_type - iterate over a stream of attributes
+ * @pos: loop counter, set to the current attribute
+ * @type: required attribute type for @pos
+ * @nlh: netlink message header
+ * @hdrlen: length of the family specific header
+ * @rem: initialized to len, holds bytes currently remaining in stream
+ */
+#define nlmsg_for_each_attr_type(pos, type, nlh, hdrlen, rem) \
+	nlmsg_for_each_attr(pos, nlh, hdrlen, rem) \
+		if (nla_type(pos) == type)
+
 /**
  * nlmsg_put - Add a new netlink message to an skb
  * @skb: socket buffer to store message in
-- 
2.34.1


