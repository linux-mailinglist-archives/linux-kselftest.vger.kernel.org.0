Return-Path: <linux-kselftest+bounces-22188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DED9D14F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 17:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87062284053
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762B11BD9D9;
	Mon, 18 Nov 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UAY9d2Dc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2381BD9C8;
	Mon, 18 Nov 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945743; cv=fail; b=SirjdEQwXRGwy5CNlYEYG0dj+IcI7s4rB6W+wObZrJZSi880QTa/nLmWyK38kn1+BGv4wIpdHSe/Se0jnKF5AB36FU+enyeSSBw9hwPh1j29PCQQUv992BTaqKZIpdG8cY9G8zIwDcShM21qzy178qfrlisnoWxbWfQ+gnJ5CHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945743; c=relaxed/simple;
	bh=cVfKjVqLaxBjvU8xsYDqwvrVmkq7fEKbZK6IxdezcGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdY3/z4/6B6BRDDPlwBYzV+f0bLCar4tKVD2eeZNZsPgGKTaD7kccQxox+LzszeYJMK1X/eZKREwXbgwaHppbhRvhYU7MYagFfNq65icUCuutc89I6rY7AO7I/SQtmxJVmnXy0n/2JioVw79l7SKepEdllZy0G7A3u64Sff9Tq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UAY9d2Dc; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuM6vRtFoHLvD/EbCKDIw4kzwZpfspfPwWszcR+ad9MNVcfzeLvW7HJVqRu+qcwT7I4+YR6ctg8/rikMZ1uyawsD0cyiMq+CKkeqZ4PG6HO31oQdlNYNxkix3JdhbVX1ZC4R9OyWWEVmTgEVfo3Dy6OVIYBnzKbqnhiyupYxesgRQHeAIlwEe5lSjsQ3Kiq57K/SbTR0/FATnMsUBj0dUHtfk8Y6l2cNQFLq7JAPpsUveYJffIOjZX3N+DarG32tgEU9wMjv8tKx4BBY4J7LIInaDjGHI4DUtsJlz2HjoZ9m2D5XRLf2szXI8qXN0l7uBK/DDurmJJ1N1EJMPCszPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVqdvTshHxNki3bZ3TKLjG68UTcnAHsRVq2A6Gcb6kI=;
 b=Sxi1rs+p4owKYwfKReeezEPskG7XkRjYmzA3ISsCyd8U7byBLejwuFpdROgkVKtcDNoXx+Q9IeoVOfOlJ9v143Xdwnb3veqMHQkjI2+yXxWzTvYxforalDjYN0B/RNnSC0RD8o0NMiOHZdMCeO+t21Pjdmy9UxLfWcg6x9LFubNioZvwyM/8fIlTz6lU1Ya8aE0G8ug4YQB9pOaWSxWs5j/foSYqJVATkB/grT3qkcluKI39oo3z/EY1z3YVlJvSRnH0m6v360e2GnDhohFhPGZyMjnsstjTa157VnwL+d9vsbiSuZmhfiiQJyLpQRwAc541kwp0QvpAYpD7wrER3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVqdvTshHxNki3bZ3TKLjG68UTcnAHsRVq2A6Gcb6kI=;
 b=UAY9d2DclhTTRl4IiKShJMLvIdKuzLk48CP23YIkrNkh3Jjx0vkfOCCXXW76VJP08kNlb0DrI/prMLCKcYMjABSkV8CYwwkUrUV+yUO3V6Wyqm6F1Z92kiAnrJpJOibEI43/2DWlqtNB/bDYnxj6M/FlRwFZiIkkZCnwZ4Se6Tdl44Z5TGXF5V4No7FfuL6ngH3eJ8sQCBsEIX0qCeLbKQhQag2dambajn4NvnRJnHhrBz12dxAohMn59b+qnjNiL2PIrSS96s8Soi6u3PSSmfiVmAg4F5aSpypg3moljUWOkAIQ4bRwhMB0T3S51kArIOJBThMgHAD7E/gSOpJ0NQ==
Received: from CH2PR20CA0001.namprd20.prod.outlook.com (2603:10b6:610:58::11)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 16:02:15 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::b9) by CH2PR20CA0001.outlook.office365.com
 (2603:10b6:610:58::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:02:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:02:00 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:53 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH net-next 09/11] selftests: net: lib: Rename ip_link_master() to ip_link_set_master()
Date: Mon, 18 Nov 2024 17:43:15 +0100
Message-ID: <8d336cf9b91f5faa99051c75655a1c0eacaaac72.1731941465.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731941465.git.petrm@nvidia.com>
References: <cover.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 4170f378-9598-490a-ab1d-08dd07ea5e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kdUgCBkOA9iax9jCt8lbS3C45vBXjrNSdvjwM+grIZHfEjgCTWsBMChgw5bg?=
 =?us-ascii?Q?2KieOIFXSMsOpvzt1ZP1VJ0lc4nZ2eeTFVLCwk1fpf5rSysSZI0SvCVgO5Tp?=
 =?us-ascii?Q?TNDqiT4in6If6F7PYfnKXQy5ZjfiEWVfXybEItEL+ZwIc5RYm1v9jsEqUaVo?=
 =?us-ascii?Q?EOh3GlRIpCVQKkQ/2ZjIy0t6MeMtW0UEFbzFPpZ8Y+3rJfFdKLVQRkCrHcoj?=
 =?us-ascii?Q?T3FI16xUDvw0G1nPiYY59xLOigXR+QefeHUn0BuJDSkW1YfbBpFBcPoYKH7M?=
 =?us-ascii?Q?QWfVvSX81QQ3zP5AZCn3SFhWBXvOA02m0ZRvNmvlbeLgwyYm/66f85B6+erW?=
 =?us-ascii?Q?6ZtF/i9UrPUgOTtXeMjpBp8H0RffiZx7lFT6kJJYQ4WapI3Gbs6lS1J/rNGW?=
 =?us-ascii?Q?e7DK97OcNJFgu0dUhET5h7MSAoxbKmzlnvVhR8fpb+nPxiorAPz8bQbWR5BC?=
 =?us-ascii?Q?AsmYmhnQfdfB4AvK6jQN/g13xL4A8k7uSLe6g78D9ZUfJQwtX3KQUF+NODBl?=
 =?us-ascii?Q?flVTLfptvhslWLPW4hht8ojIgHV1iqyMebj0mPVPFgwbefglWT+6pYD7wlMb?=
 =?us-ascii?Q?bg1TapQO3cKwgsZyVaqlN8j1Q8NPP8DqKFuctMFRvhnS2CHIZOL13vjGQVAH?=
 =?us-ascii?Q?yAB66m7mUggvKzRSWiBuNWUTInZoPvAIS5cewEqNIlucm8N5oo4gcHCm/3RO?=
 =?us-ascii?Q?qfpG4AYjbSe43Df2Ba+mzhFHXFbg+OXBdTYUa8omhPSbealbWmq2YWQdd7lu?=
 =?us-ascii?Q?0UJf7OMHVp7+y18BQKrf1rKZDFyP+RdZffK7S5XguVddWespmebo/VIfWOHh?=
 =?us-ascii?Q?xk5l4RWWkxUoatRdxTegTvc+gtOpbi5+LMSYc3gz9sqzhTHTfq9GhJefTHFM?=
 =?us-ascii?Q?qYQo0wPwhf1S3DPsWGiDzX5G689/pKfzq0pGGrq5BlbgZVRUR3Wafi5eKvrM?=
 =?us-ascii?Q?7JIbb4M6yOfQseK+66S8Wx1Ra7ft4u9338s/WEBTRTfG9GVAs8yEZ/BmwE+6?=
 =?us-ascii?Q?MxSTcV74ihynVLmciLR5dy9JUoyybKyL5rFa+uUeu2Ssih/y/feC+8DRI/2t?=
 =?us-ascii?Q?bKgEft7OitLFCgCbevgRy+f0eBZwE7+KWEfZYs5TxNRf6MeeLjddV41CNV7e?=
 =?us-ascii?Q?n67GBEEoYOaiHKvfG5XygyGXAhHibzyzsScrHAQNSvs8i7f0gMVA7Fpi9Zd4?=
 =?us-ascii?Q?CIlhQUlPfn0Wmy9LaYbQ8ciL3dWX5LyQtoAR23e+rPRRg6Y4s83HXNE5dgzs?=
 =?us-ascii?Q?ScnYhZMlJ2uWj0AxTAq2OSlqmyQq/PCs/wvPCnSHXr3ZhjD/C91vZBMT4+Sd?=
 =?us-ascii?Q?o/4LSj+QIc/Xke2adkadiKKBs+C8XuEeLfE/apeDXtPsqTGmqSKgzOR6l1Eb?=
 =?us-ascii?Q?udjmocI8W5wNS+ornffFlfsGegRpWxleR6dKMIhHvxwx6/m2uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:02:14.3392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4170f378-9598-490a-ab1d-08dd07ea5e7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599

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


