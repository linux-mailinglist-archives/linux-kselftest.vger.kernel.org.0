Return-Path: <linux-kselftest+bounces-35789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BA8AE8C61
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 20:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC06A1BC5D06
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24952D878E;
	Wed, 25 Jun 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FSv7LzpL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB571A38F9;
	Wed, 25 Jun 2025 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876257; cv=fail; b=U0ly2+m/B9s6gTc3UR0pHtyf1f4p34+u/NFbCiVq8DwbBjTZwqWbpWPJ9uEORUs8Ej61vFr6xWV9VJ9cJUj+JvT/6Jo7+EQWc5Q/2otldu51TYZ+7zBM/Y5tN9u6KNjUYkNuCaI2FzrQFn/tP6wccOa8ohrqxtCl/BT9OsAr/B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876257; c=relaxed/simple;
	bh=cIkFRDfdjDCIQL6yP2Tkj3QMdNZ956VFLKh6zJbPIVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k462JL65l0cEXUU9k7fBxeOBv9f2Paez8mkCvTQSYPj4MnmvcIs2b1+BtUGq6JmItbhCy6lka0EduK1pRdXmdeNu9ia+WjIGgyBgvLjNXigIct8HiK2mchlvRW0lzLu+eVbh5wbpBSQBbeXnWCDFFMjD0nvLfm5p30CJ2KD2bvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FSv7LzpL; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vboxoBXrPqtDdQqHm0eDvfgmJ2KclRKyPGWIrMWB5e4BskRsqaLJF1lTTv1a34oV1S/b2pcaSPs67ObcWmFqxTeP4D/aaUUHBbPnxTEbhmnP0XHV8g7996pn2jHj8FGgbPRXRkhjbzcxPxALzagYq9NFxougOzjpXdLoTfue1lnpbrv2F6a5+BgBgK4FtsQ9u8d9yJhjuQYdjguaivl7+yLJAYKyPUwGg8eeb6hi353lrtG+2tsCpnIPUfKnUk3m4E3ZsjsKLKqeqVWjYbCRW5r7jEvsMJCaaO7LaxJldNlF7cAgWWsNotrchSTJ7uxePH//Yk4LmymILgoeKUy06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsOoUnNyXuyEKIN16p4Mt1R9D8lUHvTANLjcb55U+0I=;
 b=wgzrBKVuGWado2NB/JW4gMi0wSG0fUvmRjTdvTOT1Uo3kuRh4pnOeOZXrj+gtcpRIQy+mqzEj65SPInLjZi0s98BpgDOR30oCGoQZ/zRTC7A37T3s13d25hSr57ZkpO0KJiX0/ljX+tmAj9gdE7oNN7lOL13glCYK51BeBaZf3A39woajXQXr0Ugp3hkRJ8PjzXKwu6PskBVbxL3pxknb4DlzCd8E7lqzQPHWdK6tANlSB+bafuwNv8KXUbRcRdorqRxuPiKZ43u1rkhkH5EiyZ0KVt5BCZay6bY0zDC5CAmFgK94Y9y6ylx6cVi2hm68IAdcPjq0BexLK+kFWrKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsOoUnNyXuyEKIN16p4Mt1R9D8lUHvTANLjcb55U+0I=;
 b=FSv7LzpLE6wncySr+Qok8gBBUHdgtAAtO3SsnIre7Xu3InyEpg+uQSxJNzSxi+KJ7ciIhfSmgsAOgNK3r8VRIVQcF7olJGDLz6A++hwcT4kwjzfqcKAPpzbW5PkJu/+XY95cIR6dT3b1iS+iPz9rE/VvwnRiFBwLLU+j196dIpJtqLX0IKu4SIVqqSZygg4SJliRFLj+NlK4TwzfBs62OYDcW0Of7a9JXJw7R2QBJFVR1RYOBSfXmYJXdqnb8/BTcm91EqFsD98CrRWyHIap6EhOv2uQPo7s2yakL6FeQqdX31Yx+SEseqHssrNkBsifleRxkYmjdxxiwV3eyh/l6w==
Received: from BY3PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:217::14)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 18:30:53 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::78) by BY3PR04CA0009.outlook.office365.com
 (2603:10b6:a03:217::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 18:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 18:30:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 11:30:34 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 11:30:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 25
 Jun 2025 11:30:28 -0700
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
	"Mark Bloch" <mbloch@nvidia.com>
Subject: [PATCH net-next v11 1/8] netlink: introduce type-checking attribute iteration for nlmsg
Date: Wed, 25 Jun 2025 21:30:11 +0300
Message-ID: <20250625183018.87065-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625183018.87065-1-mbloch@nvidia.com>
References: <20250625183018.87065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 43705ef3-c1ec-4e51-4d5e-08ddb4166a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?49G6RgOZJBrzAAwS+2tUvxxz1FLRxdttiK7asSeAN5j8fb1OMwFDTZLf0Won?=
 =?us-ascii?Q?prGlbipG3qZSie/dGPSoNLtydDDLaGA78KR3MNZ3rv7ElWuOze2XsTpY0Rr7?=
 =?us-ascii?Q?QcEc1lhSD1hEun3SXl3ebELmKinb4CVPzdjV6QD/xZRB35RHPs7sZ2BPiU/B?=
 =?us-ascii?Q?B2BMzD0KT5jdhxHkxRKHQfNWwwnvVznUIHfkVP5aMs6gJP/y6eVDiEGsTS8a?=
 =?us-ascii?Q?9ljX6785qBNsmXw0/o6P93SCeBNJut0SEkDWM/J1JWPTQ/OYhg4OjC5ksIQ0?=
 =?us-ascii?Q?iv7BbAYq1IPC1sC60P0DDrwILv2AHOtDqRtGMTrvFMEcF1nrTq7Uc+szeKue?=
 =?us-ascii?Q?/MS2L0mvEylU38deA90+Vyg6JKhoXeFF9l0nXTeD4EZISffmdmi8MFiEfSOv?=
 =?us-ascii?Q?zC3pW0df4zwwa+kNxd3MIiPZ+GBzXBea8be7syZBXG8AKj8nIe54TNCggHNu?=
 =?us-ascii?Q?qCVIkyfSwTeJH+s2+Oju7rVRpo7g7NepjcudruhEhNbedFh0Ixt7Qeaz2LBc?=
 =?us-ascii?Q?HVg/mr1Ddawftkr06qoQY6dV2s6OogrFgusDKdorPNLa4/huWs6NEzPCQw7f?=
 =?us-ascii?Q?N2rCPSfZbRg/Ix7nKl6SHF2L5RF28Wr6rFZxNYiSBHIlk0NKSOKKg2sYP191?=
 =?us-ascii?Q?Q6q1pCVH6Rpm1Xh/f9GSnrtp1x6CasfOb5Zx2xBcB54VhA7bwdvBwlGK2B96?=
 =?us-ascii?Q?aX/rt1SsSC8WpqARiQ79lmfnEes/knTEOMfX8tawLHbrvvKI37lm92xdVnUd?=
 =?us-ascii?Q?lqopuvrMUtBA4DYHOQHym6RqwqSZOiUTxRxfN08drRlamyFSzI3d1Cv6wG+t?=
 =?us-ascii?Q?V9M9yJaPfDfTKijmfCdHJ3PBPIsc/0NG7na5PBJ/dg+YoqXXh8CiFjQSNXqy?=
 =?us-ascii?Q?8xIMZctM5T9hpvyYQTWUryWorRoyyJ+/na1cnuzO202rJq1xa+8lobvottVi?=
 =?us-ascii?Q?tBasqQ4TJ4JP9LhtEugRszHyYob1V/r3chRtY2DbmJz6ybDMcs9b79BZU103?=
 =?us-ascii?Q?uuFYZPwrDhweJnBpcSHYaICKnYbGipoAEF3HqBHEhyrkD3ArzAI0il+khWmB?=
 =?us-ascii?Q?Y6PdbiI1w63S+XCumZuGIt2xqOZMhZC/tfhfpT4Q4z5CIzKYJjTK9RYcD5jZ?=
 =?us-ascii?Q?H/HXz9UJ0PotlrNyiV0XTjiW7vfGKPDYVZqj2FEQ6u+lEC66Ja3cqsNk/FBF?=
 =?us-ascii?Q?fUmB8SxJMEp/htJPJxGqUiNMm43QJXevrrv4WOKfdMMbb+pWjtzktO+jx6ak?=
 =?us-ascii?Q?ydeo99FdlMbdGDBKZ2oBXwAOiLXoTLhbhhgyHXEyPOiP0qj1ZDbFfMg6SBK3?=
 =?us-ascii?Q?oDzK4d46jMFexcJQOlk3HOgJnSuFbJhA5Nm2zo8rRx2SuXpzsJRqP3QGLbJT?=
 =?us-ascii?Q?mrMq8yoF2q8xhmAqRcILIzJ8M6t/BuKrBi883zsTwSdgDL6hKxFux/4uWBPT?=
 =?us-ascii?Q?DOa0+KVg5cEr7026zdjcD1sCn+/6z3/RvksSLgOsKqUR8hMRP65yZcBGUXKY?=
 =?us-ascii?Q?KhcWEXeZC4utner/jdiu35LsYejZrmRZNLUG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:30:52.7092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43705ef3-c1ec-4e51-4d5e-08ddb4166a9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557

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
index 3f3e9f6c4250..786dbba0d7aa 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1621,10 +1621,9 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	/* count number of SERVER_THREADS values */
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
-		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
-			count++;
-	}
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_THREADS, info->nlhdr,
+				 GENL_HDRLEN, rem)
+		count++;
 
 	mutex_lock(&nfsd_mutex);
 
@@ -1636,12 +1635,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -1782,14 +1780,12 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -1940,14 +1936,12 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2002,15 +1996,13 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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


