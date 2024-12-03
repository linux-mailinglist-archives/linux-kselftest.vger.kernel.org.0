Return-Path: <linux-kselftest+bounces-22747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0853E9E1F5E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B601671C7
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2721A1F756F;
	Tue,  3 Dec 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CqYGXnWQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBEF1F7561;
	Tue,  3 Dec 2024 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236459; cv=fail; b=op+P5Ya0FapDmWs+Nxko2aQDWwTegYVlXsGdpUfKkflM1m4epTwHhHpn6aTkkdTEPdgRBWBy0/QeYCDDNRU6j2m1hoZRAaccPU975kJjT5crNvMvH1tXoHNqgNdnskfvA5fpPx4/xjC1hijuv1+axmV0YdAMhIILr74VRkvSZvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236459; c=relaxed/simple;
	bh=cVfKjVqLaxBjvU8xsYDqwvrVmkq7fEKbZK6IxdezcGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxdw5q+Wj2ac1LmzHB13z+tu9zgUz0yAQrPR/pRdU17AGIYdCyhm4D70NCWaadldWzAs96U9GTy4JsqzTOMHGzQEqXkhQn9l7IE2MW3oehLTchTKt1Jt7V2+tIjXW1lDC+V0XXvtFEE2ap4QWOToVbpcZPpH1C5S+FNsnLVelTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CqYGXnWQ; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yp3ldFOG5Ihqli8QOJG4ISdOcYhxz255cLk6V+K93PtAOdikAZgRxT0YGkaKVaCOLLbtaOMKfmqfLZtgA34m3BvDiWRzAQCdyYxik3O6YWVjNAQpk+d+uTi4jwv7D0CXo+4sGCyBDV1E2ZcfdzujjeAEhSdomvNuiXSF6o/nrb3aer8hpmB4/di4SEKUjueOhCS4iwjQZl5GqQtcIHEiI3bIvjQceJO7lWI5rMYNrS6etQY4m5ZbmXt64uvOCYqVFfY+Q6FurgZSJloRupIzzwZtzYMsMVx8HPiU8KHO4NdhBUlg2EHYU5DVBtHKpKS7aMtQcPzL9hyXNTYs3mVeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVqdvTshHxNki3bZ3TKLjG68UTcnAHsRVq2A6Gcb6kI=;
 b=bZEYb9NB2krTMgvmxQTdu+Kb5oY/RaBGvUJtLvyC2hemTdoe90QbrKrRS+eo7/SpdV+wLV9BCylLgVUBzn7W5TnfOqWCFEEvs3BBwy5ytLqgxF7nCRaODMF8mXmYGDDO1RAo0AjF5lzE1r8Brq0LXEriSQXoySLXf96B6bViGyTdeaZ4k8AEyMj0s7QOUcv+X1y16muQ+kwxgLXYOshE3bt4aYh6iLEKnvMHfW01YlIqq7z+UKXK4HTUjofkq5+jOFUqwGpvXB/R/gq0OW7xX9AME++oyHchyvZxePohdM0sIbwgR1aWyjvc9hvPB42GImLovPsfHlyZcdtMVEFoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVqdvTshHxNki3bZ3TKLjG68UTcnAHsRVq2A6Gcb6kI=;
 b=CqYGXnWQ3Ms+ZIjAFCoaourT+pqfcCBlw3eY1+zw+e2UXcPWU6/Uj9rwSeJ8X0dmzazqOMHjz0Bh80e/d0j/tyR/MjmU2AUaxPtGkWc4G1AMKoUQQJi8Kat4BMi5eJ6B9q56MWVszg9RQxxDgRGOq8U9mqRYU8sRAz2okFu08FIzMADui7F6ToATSmxueuYzPQ2mbS5tX6HEiRPveNE52M/Jy1DNwasoJujLRJ5ByxU7e41b+j3GjFIIx0uYTcNAo4fYzPUqgaja0i3rLhLHMIAz5g59b8WB3gzKkmrQ4O7ocaXeZ21azM+iC5GNSdkVdTsFso4Arjx5Wi3Xjo6Yaw==
Received: from SJ0PR03CA0081.namprd03.prod.outlook.com (2603:10b6:a03:331::26)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:34:13 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::e3) by SJ0PR03CA0081.outlook.office365.com
 (2603:10b6:a03:331::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 14:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:34:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:34:01 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:55 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v1 09/11] selftests: net: lib: Rename ip_link_master() to ip_link_set_master()
Date: Tue, 3 Dec 2024 15:30:35 +0100
Message-ID: <ceef47b660a3e89a5fc4ab07ae7d6296e0553251.1733235367.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733235367.git.petrm@nvidia.com>
References: <cover.1733235367.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: c20b1ae8-d97c-4f40-cfea-08dd13a78e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uCeKIVrP0Op7T+/FeGIBPEibBlgeN3x26+huP8LDDedseHDSw30miEHpdO2g?=
 =?us-ascii?Q?AF8CDNZdp1fYOLdWjLyGTVTANYerrE0g3DuF0MGoBPvYyda151P8sQug4Dag?=
 =?us-ascii?Q?NM5yUC65yuCUXePDFbqEIK9hxCj/btSqgzmY2OTxm0tvo6F7A+5j6w3/rZLq?=
 =?us-ascii?Q?yiP2SIThOp26/JPgObn/9KP1+Dxbnhjh1sllnAqsH4Er1q80riVmlN1REHC0?=
 =?us-ascii?Q?+EOiirW2xPFnYE02fjQjVBWAXxkgwG6vHC+xEgWIa+VzARph08G+j/3i5Z85?=
 =?us-ascii?Q?W80+kXfVTvVlX2uF23wLralAZqbNXSFS7KlSPANLpY0d3NzSGmUh+m8/O11B?=
 =?us-ascii?Q?ebOI07o4cGBKGAGWXYq3oYDHrn7YClIQKJ+nJE5o+W4T+gJkM3vicPUYfL3W?=
 =?us-ascii?Q?FOFbqAlqs6TcG34HoG4QowcHVfurKR8oudeYvP5PNw6VRFBdOL5fia3qY4Qf?=
 =?us-ascii?Q?whpFO1XbPabS0XYR4ffLK/BM1nRqCaNVshEIQbL3u8NZ36GN2k7kTH7aDeHA?=
 =?us-ascii?Q?NjVbhQIZNGN+IjaR1WQZ/M3NFyEMvrypgdblBu6S6HwZ5lztjWv3znBg5TVA?=
 =?us-ascii?Q?60KGQGeX/bM3UMHV8aMsveMZFFSt3BE7YhX2CrZALjvfXlrPN3sBm5+sF2X8?=
 =?us-ascii?Q?RSSS0QiLqyBatrirgGLh/9JIk8lMCW6fsbH7NhqjnxPh3qTNGa9idHy/3TPM?=
 =?us-ascii?Q?xF0bTkjTYIx91wyFH0ejTX5ui9zz/lNGEeOyXY/9DQ9A/v8tEeI68r+Js+Nb?=
 =?us-ascii?Q?XOpJE2i4TD2BA9U+nxJb91o0rLshKz+Di7gyaZ9lwTWUbLCm8Ow29oqFlU2X?=
 =?us-ascii?Q?+pn5rRHJBXQvz5lfUN/qXkffqUxFuN904uSJX/Q4yeIsrF/GtjKqdtfPkSoG?=
 =?us-ascii?Q?GX5NmZ/GRbqnbmFBlaqf/dswUdQgTSH78fPVPxIvpNyHOq344/QlzYJ5xpR6?=
 =?us-ascii?Q?0K1ChFvrrBoVQ+5RI1s3a+bEb6jUxQIh7fRLEjkw0NTOepKT8MtHrDyBwY+r?=
 =?us-ascii?Q?OCIeXIVXsPL8J0ZLccav3h2J16sMOZKMWtU3HCPivaynLfSJz4sg9YPKbsyc?=
 =?us-ascii?Q?VrO68OdWu2IHn+usn7SqTd6BpDuyU0nIM+e/o8Rd6q37CLXjGxGHonwLHTB9?=
 =?us-ascii?Q?SsRnOTdfTLnis124Iww0sisFtLwZZxWjbf4/CyYX0SXgJswJ+VyrJCvjbSAr?=
 =?us-ascii?Q?bqelQo/+lzplEqgdzJrKpWlGxLSEZjhLoCBZLH7LTss3SiaYXwVCox0+/49x?=
 =?us-ascii?Q?KNB2cw7niW/zQ7WB7hsL8GS3B37gXrGy1/6BY8Efd/8AwsLFiScCN5fFUKC4?=
 =?us-ascii?Q?0owooWr9+2TeccjHofBVUe8N4oodLZZioshv1qM6RwxMAxCMhXSJgPmJn9bq?=
 =?us-ascii?Q?c7Pun0L+Ti5u2VgaEZumh6Dni0cHzR9f6ed/evJuDpEB5tOKNTCZXP18sK11?=
 =?us-ascii?Q?wTPWpFlDGZClIZQS6kbSKizPZBx8GjnJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:34:12.5467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c20b1ae8-d97c-4f40-cfea-08dd13a78e75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348

Let's have a verb in that function name to make it clearer what's going on.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/fdb_notify.sh | 6 +++---
 tools/testing/selftests/net/lib.sh        | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/fdb_notify.sh b/tools/testing/selftests/net/fdb_notify.sh
index c03151e7791c..c159230c9b62 100755
--- a/tools/testing/selftests/net/fdb_notify.sh
+++ b/tools/testing/selftests/net/fdb_notify.sh
@@ -49,7 +49,7 @@ test_dup_vxlan_self()
 {
 	ip_link_add br up type bridge vlan_filtering 1
 	ip_link_add vx up type vxlan id 2000 dstport 4789
-	ip_link_master vx br
+	ip_link_set_master vx br
 
 	do_test_dup add "vxlan" dev vx self dst 192.0.2.1
 	do_test_dup del "vxlan" dev vx self dst 192.0.2.1
@@ -59,7 +59,7 @@ test_dup_vxlan_master()
 {
 	ip_link_add br up type bridge vlan_filtering 1
 	ip_link_add vx up type vxlan id 2000 dstport 4789
-	ip_link_master vx br
+	ip_link_set_master vx br
 
 	do_test_dup add "vxlan master" dev vx master
 	do_test_dup del "vxlan master" dev vx master
@@ -79,7 +79,7 @@ test_dup_macvlan_master()
 	ip_link_add br up type bridge vlan_filtering 1
 	ip_link_add dd up type dummy
 	ip_link_add mv up link dd type macvlan mode passthru
-	ip_link_master mv br
+	ip_link_set_master mv br
 
 	do_test_dup add "macvlan master" dev mv self
 	do_test_dup del "macvlan master" dev mv self
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 8994fec1c38f..5ea6537acd2b 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -451,7 +451,7 @@ ip_link_add()
 	defer ip link del dev "$name"
 }
 
-ip_link_master()
+ip_link_set_master()
 {
 	local member=$1; shift
 	local master=$1; shift
-- 
2.47.0


