Return-Path: <linux-kselftest+bounces-4350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD48E84E47D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 16:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D87D28881A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856C7D3F3;
	Thu,  8 Feb 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LB7anfoh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD37D3E5;
	Thu,  8 Feb 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407780; cv=fail; b=SDE2P16ycQ5UiOyR06zZPv/vNs35eegeh3faPvMfiOqiLYG+cQoarhKD7ABfWi7L43WLVGVxU0cxHq+eBjWz0fkTf6o2giAv/7wddWHo4WmI4PNQupPrlexPlwtgYnFMKOiWLxS4fzOa9oYRSj8oVnz6XsGmr1YfLV6ehlOcuwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407780; c=relaxed/simple;
	bh=wp6y/GOF+gNA3/6ZiDf/0CERsaIh7jLWsBf46qCEGYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2pMqFQ2mUVSrVX9w0V3Xs7qTROBAvqel2dabocnm+9RhMsA3IrhHLysiGXCOJtUYubXp3mtIzm9fdSMzmYjNg60Zi0E/hySAAL1PQ1WQMJda6aJDClxlY61f6cyDqSAlyG1mQUMz+nOaLm6egvqoQmGj/acIm6OcS1Aj9ofB6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LB7anfoh; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzmwpzYIUTL0u5vfy/kf1nIONLCMMa97z4tIaXolAiQaJ4OzryUT52HVCXeIP+DzlKmZi2IsUmoedHY1ISgzQN0hVk7Opym8mPWd+BqK0rbExxt2QqEXmNp8l5MoNYYXjaa7Ena3xVqEcuAC/plzGugPSYJPE5T/82tItgYkDjOddhgKaxH7Pf0nHOWatQCaNcptQvWci0GvpB7Cf9iAP8OoC1FUjE9BB9O+cRu9Nets1P8cgQ+d7sWsz+jWxDPnK4PAiphCKztg9NiuqZGzLFubmrmUdhSaxxIHpnmDO6SPFQqeSmkHOnvTg0ENrmqx/kk2JYZQ/sqgJYpGEwTJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zf4s9i8LjQzeai0hUoAwR9N5dLly0nG3jMUI3fGN05Y=;
 b=E1ryPGp8QSrmHg6LugiUKELdieEJeVPOcii7IV+LCE04N3Lg082kskk13YnGhF5ejeBC45Wt9sB/le3vZyEcazRhaId1N5IeIVz991ukfjEJ/7kHRuqz7YDqsWPKO/d7bc5FF2ZUVrViH3KqFIiDEsuq7PrwBEoEASGVEGW8XiB5RIuSa0nJ9HNvWy/zzyGKcMJdyThy7OpxrAUOR8LmBJQCxMQWROMluyyzCkvyWEs349ZUDl6eze3uWqU6gASoCgiU+zbC0AUbyn2wmRC4NDMtE5jma0T8SCdFgKge9qPmbSL8WBqxoFcG7keMoOTQuVKq6m8ABs/q65BfPwzKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zf4s9i8LjQzeai0hUoAwR9N5dLly0nG3jMUI3fGN05Y=;
 b=LB7anfohlJdH5XlWkMxrcv0H14rLyYf/wgD0WyK1CqetatwlyB6MRmCT52dj7rUNGA/EgednFjvmRfujLkOIrHKA4bI27jvD04+S3W2+VpHR8bkyyIVORyR1cMBKzvmEgEDWsVScD6cA3Ui3Iq7PTaRuh5OLr8Jkrrg5p6UTIXHJMirdpWBe93+A1wcsj2jeiVqdTwTUsavlYMbIPnL0otbvHuJnuYnDefhL5nxQ1cB1m9lKAtSeddiWfSFLgyaNc4CHHwPFAEBboXfj5+pRObNfgk2frmCLZRzg/tEtVz7zbvThre/ZOmUDJDSB4bAjiO+EAF7q5T0LhBn4JG82fQ==
Received: from BYAPR11CA0053.namprd11.prod.outlook.com (2603:10b6:a03:80::30)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 15:56:15 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::92) by BYAPR11CA0053.outlook.office365.com
 (2603:10b6:a03:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 15:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 15:56:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 8 Feb 2024
 07:56:00 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 8 Feb 2024 07:55:57 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<razor@blackwall.org>, <liuhangbin@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net 1/4] selftests: forwarding: Fix layer 2 miss test flakiness
Date: Thu, 8 Feb 2024 17:55:26 +0200
Message-ID: <20240208155529.1199729-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208155529.1199729-1-idosch@nvidia.com>
References: <20240208155529.1199729-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 818db5dd-ec9e-4f63-44ea-08dc28be7ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NHW2Q+Xpa8lvAR3KT56bYr5/4MDlhZoHfAN2XKtUDVJzytD/t+F4x8IqoYcBgAIylaW1SGtmVAb6OBceHBECJmEi8GBmSRl1GyhsFAPDRvx3wsgBWnNqGNgw/d7L6I+X16CuaQcGtkSwCet1TGJhbwN2BYU8/axM9vQQE5duOmHVBkUVneQeul+26FuyHiEWy+3twJVfJ/tLX+RtqZ2oX7oygA1Djm5senaI5L3Ra7vWkVvZ5Spc05whVZTMPUVfgEJBm5HlPPKJ6CWuaIrV3FQwsY0o52kxmj7HSsRNmK8D+1pLYT1r7k/d6sMqvQbPZr3fISlrJPSNh+5bcGb0UEQA6RxAkr8L+hNtdjMBGyuX36WkTK0MJkMkBo8EbPd3zQp1HgqfgMBar129L6HOmLIeJWyF0id8CbsDDJhD+PoqYBkE+kBWZ/WCsrNALRNFe5uWtUoweuwI8VfEkX9NmR35362zCl97zuoyrzrVM5JImElZcIzxjbORWo8kXiMtCgYNKbOn9kVUJzRGcNaGqqa+RUXuiG9wIbc2hnkiHlS7rqZjgyQTlM9Lg9MwAdMcUJjVE/Rhitrx1uYv6VupK4fzhNpN8CRbNbOfklTaqZA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(2906002)(478600001)(5660300002)(7636003)(356005)(4326008)(86362001)(8936002)(6666004)(54906003)(83380400001)(8676002)(110136005)(336012)(2616005)(316002)(36756003)(1076003)(70586007)(70206006)(426003)(66574015)(26005)(107886003)(82740400003)(16526019)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:56:14.8686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818db5dd-ec9e-4f63-44ea-08dc28be7ae1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

After enabling a multicast querier on the bridge (like the test is
doing), the bridge will wait for the Max Response Delay before starting
to forward according to its MDB in order to let Membership Reports
enough time to be received and processed.

Currently, the test is waiting for exactly the default Max Response
Delay (10 seconds) which is racy and leads to failures [1].

Fix by reducing the Max Response Delay to 1 second.

[1]
 [...]
 # TEST: L2 miss - Multicast (IPv4)                                    [FAIL]
 # Unregistered multicast filter was hit after adding MDB entry

Fixes: 8c33266ae26a ("selftests: forwarding: Add layer 2 miss test cases")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../testing/selftests/net/forwarding/tc_flower_l2_miss.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh b/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
index 20a7cb7222b8..c2420bb72c12 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh
@@ -209,14 +209,17 @@ test_l2_miss_multicast()
 	# both registered and unregistered multicast traffic.
 	bridge link set dev $swp2 mcast_router 2
 
+	# Set the Max Response Delay to 100 centiseconds (1 second) so that the
+	# bridge will start forwarding according to its MDB soon after a
+	# multicast querier is enabled.
+	ip link set dev br1 type bridge mcast_query_response_interval 100
+
 	# Forwarding according to MDB entries only takes place when the bridge
 	# detects that there is a valid querier in the network. Set the bridge
 	# as the querier and assign it a valid IPv6 link-local address to be
 	# used as the source address for MLD queries.
 	ip link set dev br1 type bridge mcast_querier 1
 	ip -6 address add fe80::1/64 nodad dev br1
-	# Wait the default Query Response Interval (10 seconds) for the bridge
-	# to determine that there are no other queriers in the network.
 	sleep 10
 
 	test_l2_miss_multicast_ipv4
@@ -224,6 +227,7 @@ test_l2_miss_multicast()
 
 	ip -6 address del fe80::1/64 dev br1
 	ip link set dev br1 type bridge mcast_querier 0
+	ip link set dev br1 type bridge mcast_query_response_interval 1000
 	bridge link set dev $swp2 mcast_router 1
 }
 
-- 
2.43.0


