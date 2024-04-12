Return-Path: <linux-kselftest+bounces-7838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2F88A3466
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D177F2858EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0E14D2B1;
	Fri, 12 Apr 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LUMEibmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE314A09E;
	Fri, 12 Apr 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941589; cv=fail; b=fRrT/uDJfwe8KAsIwc2xs94PzDA3nvNJLsIjg8Xf43GA4p4+L5PQmbIxRxMLd5/rU6Vq1a4lN8JYc1iEsre1f4GTZ0ZkbJlXrRkL3pA6kzrRq4uEbnEglhlK5mbJx2LWA/CUwWQnCC55CFPKtD0TfsgfaMwZ/uukBzopXPS46c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941589; c=relaxed/simple;
	bh=OyEcnQeAkWWdRUVtd2StHXqQ+LTpiMBSZSmYlCM4tqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfE9TOau6FBLt8G3ZmRgswqPXZdAcnkxBVv2GehsyR8cnoKY+M6eRmoeLbgulZCe/iDLJzRuvTPED5KcfAe+TnRCEWXSKq8dmzOW9in923lPonbCptNT9B9DiV0qS5sNmAUUD6sykhopwL0yCGnliHnKUTrV2PC9yXIY4cRc+YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LUMEibmY; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h41wT0XOgscNWB9FS69IQygPfDF4L7othLtFfrU3AgSGDo3blIcN4xG1IIalG2zthMCTZlEB2m6sB4SKZT+CN6EhkKyiK+I6BJxVnHRQFKayTp9m6ZouRjCybnumgpDdGt5OSWzcigpn4NmyY04snolUnOcnwCrOma4zMgU83B9zI88LuDulREyAic9+v/tY2T9GM2St+vc8FLkAz+RRc2Urf9+4nedLldfirUClaCENkGolzF2hsrM5K6WMTo2Oysk5+T4rCN7mKcldJA+6p2D+klZHTuI0SIcqUm9OeBpDQuklGIGuq6oi8Qf6AC8YmFTrBiXeGbxyrZWpB/Plxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq2/PqPSTA0FJq9h54nrGBD1pqEih4yS6eT3b7b5z78=;
 b=bsGAd1xSMvtU5F3j4LUewdBry61mzH0tUMk/r+Q8cCn4LkQyxlBkytk1FpnBHhIWTQAe15/AaMwuGpAPTIHMwvWi5KK9TcxV7C5xQHifkbjFvQU1yRT44WjdIkJcI4RkAFxRA88DeJkbJUGzCN1BtSQ/ISzchz80DobMqAFb3W2vFpi8tr5m5O2kBgtUfUOqwgEBBk87x4lUsafvvW8282N6K/fOUI1HtzK6Zv0FVM9u0/6isOjK7yD52SxE0nO6HZd/RmVUtOl375pnw3vmGNN0wO6NW2cJUeWG7/IZAkvus96tp1j1a0rjkGB0cWkui2lGEZICL9Kwwkhw8LVWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq2/PqPSTA0FJq9h54nrGBD1pqEih4yS6eT3b7b5z78=;
 b=LUMEibmYhxhgx8EJsWGxJw2tBKfuIVlaJwOnBjr0uGsFqKaq+S/tO1G8+L0OBj/M5wNjCpwqtP/eU6LdvYfvvnOroTfjUiUUgt+m2pKs9LXIweTrk6F9j2KQHcHrldTFgc9ChVr0KOdROXLDHvywMJxGo4Y22hxj3wEw+chR49y0PLeUNUJIOHqtJT4KkH12kxMM3pcf7G8OuapudqgPn53Jh86USp4laxP00HR5Q2CaWztkpuexLHnFIQXwEi6RcCmWRW93hnq73L0Jpm5ETi/OvMhCAGorgvCqWf7goKz+QIQdm6fcuiVdG/zH88uWoeOljbSS+3J4z+OpMeI2Dg==
Received: from MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Fri, 12 Apr
 2024 17:06:23 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::31) by MW4PR03CA0186.outlook.office365.com
 (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Fri, 12 Apr 2024 17:06:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:05:52 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:05:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Tobias
 Waldekranz" <tobias@waldekranz.com>
Subject: [PATCH net-next 04/10] selftests: drivers: hw: Fix ethtool_rmon
Date: Fri, 12 Apr 2024 19:03:07 +0200
Message-ID: <837240b7d73895731a3e66a2affd9f0aac74cc10.1712940759.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712940759.git.petrm@nvidia.com>
References: <cover.1712940759.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1a1552-9a89-4384-6a5e-08dc5b12e142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	amXQzgaKcDaDpv/JoS+uAKrSe3ecANlLrOF7Ofcbl0arDAS0r6pYlOEAYVmq1Su6FmloRsiOX9gwa4cPC+fifysHMGVdHrZix/z3gmQ0aGQT9DCoGHpalKJXApacjKVE/T1TxII47YrC+Q40KfYYq+s1WJcHs4bFnFlaAr/jYjXtaImAuMEPly1slkSEXFA7SCJDvnJOLRU4dpAsacaQPn70xvqAjMAB0rhO/UAyECtyDztfO1P2hjl3tKWz3GtNQ2PHthA0wd6G8cGd0V+PEA1hJZlGAtccZIpietjUdGhO24gRP+jHxC5eKFsFYEAEw4paNxTr2Tshe8z9eGDtEgKXCwI6ArChYgRRo5sNO1qb3sGDT7QBJ4Mj8OsjcphjA6trsyqyfrUMWkSiPIksAhe/g8PmvsIUlFyI/7U0TbkX6yBqx4vfvDh3eKH2Cn/KCmHv4WukHGBaHRuH4u+hVtDPjO6a+ZGznsFe4a8yWzfg5RFU1QTU8mVgwyEnO7UgArRoOHSP0Cl8jinXiv7tEfaRNDPWxxZ1vRYepnUQMtwkBKcj0bbTk5bOwP2hyJHBG5mODir8ZZI63NeCkxOhxdXvIZBIIeAq6dv0UCUfkbexLbu70i2rmV/ewIsWGg/9VSu1heYfKcWhKTwo8uRc1/u0Vpy1gkz6Ao9PzTgbQm0g58RSVwT02JRs/knHFPM8eYgO4B1sgDW1iRgT0Lp4NYrDPkyaLiz+Vo3B1djVv38IWAB1Qe8jx7mueUEqaWx7
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:06:22.4970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1a1552-9a89-4384-6a5e-08dc5b12e142
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421

When rx-pktsNtoM reports a range that involves very low-valued range, such
as 0-64, the calculated length of the packet will be -4, because FCS is
subtracted from the value. mausezahn then confuses the value for an option
and bails out. As a result, the test dumps many mausezahn error messages.

Instead, cap the value at 0. mausezahn will use an appropriate minimum
packet length.

Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index e2a1c10d3503..8f60c1685ad4 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -44,6 +44,7 @@ bucket_test()
 	# Mausezahn does not include FCS bytes in its length - but the
 	# histogram counters do
 	len=$((len - ETH_FCS_LEN))
+	len=$((len > 0 ? len : 0))
 
 	before=$(ethtool --json -S $iface --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
-- 
2.43.0


