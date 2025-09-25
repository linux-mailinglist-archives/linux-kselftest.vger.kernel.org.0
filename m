Return-Path: <linux-kselftest+bounces-42398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2FBA0E96
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317237B9EE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4E3314B7A;
	Thu, 25 Sep 2025 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bhw4wvS8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053A315761;
	Thu, 25 Sep 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821677; cv=fail; b=r+sIT18212g3vxrYOlrdhxU+EZmw6ENzgwwDLywQFggANX2OxA2uBILoIzYyMI/yTfPNpbwbqv6rQ0oNuZHklYBWPL5EaIEAYUmqC+TwvMhaV8VVPck1e67OBOERpbgQmVnI6omrELNyyFkQbavgSl/kxDDxlKHL75iYy1X5uhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821677; c=relaxed/simple;
	bh=JQLwVOMkPnnRAoCTORErpT8WEya+69iCgFetonCQ/CM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHOVRoW5p840wUpLiNrWXopvDuG0lxnqlSZawcIULKTzjlW+TuFvMpTtSZpL87ZoVXJlbgVxYTxU0UStE41P+thhQcR6qM7Lq5gB1U9L3arUl2NeJ1Dzp2srCieBNvdAX5cyKiQxg0dNCVwu7stQHUpANHjpjvIBOrX4PtR9Cj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bhw4wvS8; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClwvlRKjNdOhmKBZpSqM+s+KDqI5fE7Cce/9HUwXQHzFSufnQp5jRLOgNnKw9ED+ZQcRs0Bi6eDRkCf8gok7Fnvc9RY3Icq3Pt3xPs0HBbhXgT9ABGq9m/cXh/uORZGxQfr95GnlfKwlBZHy/WKTUgSZXYsOr2SRPqZuzNcCS2cSyb3kkq/sKFAysO1ze2URUIROlftvC9ICS+2xEwPkfQC6GhV1fM5iMmjwZ1la1lUFKdNqZ5bmVwXsAAiWAZ376Q5/BprTY0GTOk5mH6XBzwUgaepuKeLeTLY5/VH8jwJf1DMLo4WFFIbhQRVuwnTXOiJ7avHJUQ8QT76NxZ40Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+HM0Tl62LR5uaBBNXIyvEIuH1RuUu1ItqBlB8V5kYQ=;
 b=broVj65UFWTRof9LSFO+iSuBZY4WhViQheWn0sLiqCt7oQv1Qr0nXYzsbDSOkMgrLW4Vjd7RI3Wv5a5l1caOI/Yu1HPSOY63ef4YRZvIIehYaeDF1kIvp8FzfIzqxqtfQ82UgXdwJE63U27qba8v94ELseSGAewx+X0eufuw1a/2Rxzq3LKFYEiejpwEUTndGGrMuKT0M6TZpZgpzUp8SKp6UEPaO7OOi0dh3Kvg+djzTS+SpRVtcothgyminWYln/qhWbPBzyKsliC5Xfg7T5EyX3FoTpd0vfGWLUlJyQlqljTHzS4RxWkfolNrStjBArBz5hZBVLIazeXmG12mbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+HM0Tl62LR5uaBBNXIyvEIuH1RuUu1ItqBlB8V5kYQ=;
 b=bhw4wvS8h+g+9JHzMmNivNpGZFuJYdxC2UN2FvB4utG5MhJklv4F4UJ6rEcku+mYNLSwtSgQu0ne/vFi4EJdcfp04jghhLUJziqyEzwSW8v+maVpM40aia8fJzHAXm4vq7sj8IiVAL+VmTaIQNCVIwvB2pU9izB+mIokpccd9OgOUhIn1hH/pZEH1OlB86utBtImnPDdYih8GiBVhqM2U+5RQZels02x1B5BnXwtnrv6KCovIFEZ5PKQBO/JlhHv13TE52enmmFn8KVceAic7ijfgt+hF5CWDbHeC78z7kO4VQASSSGu5cGluBoGQy1fxq/2hRThwaGuxTzFoIOyOQ==
Received: from CH0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:610:32::25)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 17:34:31 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::f4) by CH0PR07CA0020.outlook.office365.com
 (2603:10b6:610:32::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 17:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:34:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 25 Sep
 2025 10:34:13 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:34:07 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 09/13] selftests: net: vlan_bridge_binding: Rename dfr_set_binding_*() to adf_*
Date: Thu, 25 Sep 2025 19:31:52 +0200
Message-ID: <5f0c81b39e9e1f56f706cc4b53f82238a1d1e2f9.1758821127.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758821127.git.petrm@nvidia.com>
References: <cover.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3aac78-9e68-4c1d-6b5b-08ddfc59c8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BncF6r4mXbIcJtvnShLpO1fir9EJgfdUoLrCc3HWKL/8IuvOaWRciz0X3dQA?=
 =?us-ascii?Q?Tv3JMqaA31gPm5MB/56M8nzA3t79kxH66mE5AmEV7TQ9AxgF50bBu8rvEH/J?=
 =?us-ascii?Q?QfyW13176DOAbmQ7xQSCxILi/Rve5t63ulMkyoORpixvQgWJNZqokwO70i1X?=
 =?us-ascii?Q?Ehi1kptc15h7YHzIQkEh9/2secPiXXJXBN56VAeWhaPM5+4hmGf5Dm8hHm33?=
 =?us-ascii?Q?mCKvUd/dknhxF3DIEyJFU9rxipmpjYe3Xfi2cNmW4G6K0gf1Efrh0eSV5BZZ?=
 =?us-ascii?Q?Yh0l+GYfz4jWApBqBdphw/xT73lpcxIJVnM4iMqlHQVdZiorWY0YYQGUdIu7?=
 =?us-ascii?Q?QxILUknVxAEQBk7ZRDr2lQvATm0lk1peypC5XaZVVJJzHgJfH4n/MZhrB1BJ?=
 =?us-ascii?Q?36v8fK2fyPisC2jNZrZ3smYjsRXsSNOVoEaJqfVfAawH+XZN+XMC+zNScN1f?=
 =?us-ascii?Q?YtDGyKsPdeAoSusQ7CFkfAXtOjAZkQRtB3mn1CXOM4FvKVWBrRiBQ4SU0hmu?=
 =?us-ascii?Q?dgaGJ0pVdR/RdZkElEWfJnQrnlNWqoo2CD7Law7VF1WzdHrb0tTJAS8RKCxl?=
 =?us-ascii?Q?RFXXytNvEYqs7+tdnf5AFqP3xeGbf2AENwidfV2AAItTAzK6g+/jnLK9pAVz?=
 =?us-ascii?Q?eTEIihQcU1GMaO/Ipmsnyw1xj2pN2Limiotkzf6Fhn0l6Dk2p7ldmHkp1rrK?=
 =?us-ascii?Q?TNGP82mLjlCw9sSQ5Zf+u7BAh0mazTZ2Yeg/qAMpJ9EE+Gjd6DFiC0JNZxAS?=
 =?us-ascii?Q?O01JTphuSlt9+20fVKl1FgsrPrvPjwMXRsTqyY+exrGzP77/phZo5IP5aT2p?=
 =?us-ascii?Q?QwSr69hF5jb0XzjFHzWxx7kAyu7oMV3xlYR5suNlNuVLjGmXNDj7IOaD/MSL?=
 =?us-ascii?Q?Ix0D61kxBGNtsLYqVbQQ4rtvvRm7xEOfIk1lyFrBZ7BljaiOnMxZyiLpQ/0f?=
 =?us-ascii?Q?ohKNcCZ2d4o66u8wApCTc1z9C3LJfV7XMitRNv+TvfWbcyHgOGG77ezCxPnE?=
 =?us-ascii?Q?a28LiHrSQjdiaBa2XM3oZ0aJCSpHCvt60hd17z+xGfABNUy7j4XTCGsBjP5b?=
 =?us-ascii?Q?gPuCguJUTrtZ03k2fJVE2c+VoceJ2TxG8Xdaq2sxQmBi1T06oIlLtPDkvyHK?=
 =?us-ascii?Q?aC5G8vp3zBpmqvZB8y8C+4dZOtOe2GfJ8LQrc7Hj4wBJClnqW5eDntpcBvbn?=
 =?us-ascii?Q?v6Y7cgctlMz/aI4LplWjAZgDNmGMY+B93JYV2EEJWUz0LIhVB1qFmHm/2YZ8?=
 =?us-ascii?Q?63/bgEQGjyx9MCa1t5TXqJ9890oqhmlseRUGJacE6+4DvC5fUndS1vZLj6oL?=
 =?us-ascii?Q?9MpZgwETXPW34nwXPnaAJsUxHJnj1Btzylau1Lo+Bz1tM+OV5RoDvyBDyHgX?=
 =?us-ascii?Q?udM7o9LNP3/aOgHP7LDW7EJqvCp8JEroWM5y69iPbAofa5Ct7S0wRQJtVCS6?=
 =?us-ascii?Q?z7mpR0efYl91EUy1u84quXzLBj02bHAneJMI4OoqPtWhMWs37Id4dmTg0Iuc?=
 =?us-ascii?Q?Md2oKo79aAEUgOUygtSVyyOcwiFHfCJ7EESCXqQOA92tUyGV3gy4ujbrBP8B?=
 =?us-ascii?Q?7d7uOkV/iqzn8jmWI0w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:34:30.7909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3aac78-9e68-4c1d-6b5b-08ddfc59c8e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418

This test contains two autodefer-like helpers, but namespaces them as dfr_*
instead of adf_* like this patchset. Rename them.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/vlan_bridge_binding.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
index 794ba71c45cb..db481af9b6b3 100755
--- a/tools/testing/selftests/net/vlan_bridge_binding.sh
+++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
@@ -207,13 +207,13 @@ test_binding_toggle_off()
 	do_test_binding_off : "on->off"
 }
 
-dfr_set_binding_on()
+adf_set_binding_on()
 {
 	set_vlans type vlan bridge_binding on
 	defer set_vlans type vlan bridge_binding off
 }
 
-dfr_set_binding_off()
+adf_set_binding_off()
 {
 	set_vlans type vlan bridge_binding off
 	defer set_vlans type vlan bridge_binding on
@@ -223,14 +223,14 @@ test_binding_toggle_on_when_lower_down()
 {
 	add_vlans bridge_binding off
 	set_vlans up
-	do_test_binding_on dfr_set_binding_on "off->on when lower down"
+	do_test_binding_on adf_set_binding_on "off->on when lower down"
 }
 
 test_binding_toggle_off_when_lower_down()
 {
 	add_vlans bridge_binding on
 	set_vlans up
-	do_test_binding_off dfr_set_binding_off "on->off when lower down"
+	do_test_binding_off adf_set_binding_off "on->off when lower down"
 }
 
 test_binding_toggle_on_when_upper_down()
-- 
2.49.0


