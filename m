Return-Path: <linux-kselftest+bounces-4351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD8D84E47E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 16:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02701C230E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D103D7CF3C;
	Thu,  8 Feb 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h4XHqzU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4D7D3E5;
	Thu,  8 Feb 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407786; cv=fail; b=Ar1aXtgmMaxoq6nLEa6c5JAoI6OPe7oDdhUNcXIKa/xrKo4y9qmUjZXSiTRAmwjrYqehpIiQ5RczIj41+Kf3zQUBjUxAxJfLT5M1nvk23xuvQXlvyJpe/WjXFMqiojxajr+ur25iqk4cKpwDIAiP8hfq6HPHrBmdcNCQGx2j9To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407786; c=relaxed/simple;
	bh=qId9vIF59GPp+vKKgUZJlCx3qRN7vRxTnsMFjycoMis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIn1+ogq6amv1Y/A7LWisWb0vXXPz+qQp/cXp1GtQAYyIY3nq3bVS7dlkIGPSp2UF8eEuy6EEwOa7hRxmrM27XYtpaozYiI0PqMh3Ap6PQ6EgnXy0IQC+TJZBnilGBsPLKfn5DRDid7LzPGbLu8TNjXBMyP1oESPZcvLTYCCH6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h4XHqzU7; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaRBqJMrg/4IaI7YZYnBTsLVnkdtTPlPSq8/SPMERF1QGQqfT44130CG1VjXEImkAgbBqsvhMgexTev3M3GPxnwM6+pGBts3WhbOq0OYKs4SkovIHRNpkMZUutayMzI2uJDLQjtWoUaeF6Qb0wvpsh4nabNiDCYeTNbUf1zRPlRg1arvMgsgFVpoW0Ry77WVimSpdOtPV3mbsaT8jEmYxpjwa1JDA8iETuuJxHOaoF61CXuk0UsJdZzwuLMHIxT1nTdx5l12NgTNWQDqAMDaScG8L2h1Rzn1dOU0YsF1bsHD8hdvpLgIrqtBOA2CzDVNP0LJqx3IE9IdtVSkdCKxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw55dXQKpfEFSBszPoMkCtLnrpAIKyvVz1cBKk6BlKc=;
 b=aofkXfBngJVnSjOyr2MEyMqhgR2UNfd5tKwmnPxxivxCQNyBcNQg/VTIJOki2khvdlNi4WuSxzZA+BIi4dxas/xX9G5wOclaCXRiLaQPGrx7KyOAnGwmYyZygwWZuBGHYxt+fLP9z4jb4IxQ1FUXiKTfqRJdNfLQFDWKTAKUFiM2ktP0Kvcr4/1P5iD0tza06Uvz6et/uObYcuKDAHYt20vCNk8v77p8V11/xoGr3TQjxdK/Ro9a2F+Nuim/RdOgEDHF7kyjCEtq7zFONh8+7lcuDaJ9Dd1gJXykQRxUkgllsaK/JfqBCWVdRs60ILtsFBWfexIgFOBymtRKpXqR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw55dXQKpfEFSBszPoMkCtLnrpAIKyvVz1cBKk6BlKc=;
 b=h4XHqzU7NjYbmx0J2mnhsC+yn3fSjGbzUcVungAzhLF3wyM/jTNVZIGzcB7RlfMNCTWh/s4cPx46aVA3xrW+seeAVffeIaVt0VrrcWqIXRcWH6fYC94DLRqS86O6DVZ4RZkJwn57pw0ofpxxgJ2ftteNpjYsBM7godG1EavEtrH27mjnnxjDPPB0P8kcyyecJmnwwi/sVj3UCY+QjchhEXaBkkoNX3wVS7DAt5sFtzvoMlCp/aRmFp1GHURifJO27JhL6Ktx964pTW9swbWeuIHC6rWBKaqb7BDJ1iHDau4ERzlVyZ6GxyBtS2I2zqPeJvjGxzG6PMYp9fLVaV4J3A==
Received: from CH2PR02CA0022.namprd02.prod.outlook.com (2603:10b6:610:4e::32)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 15:56:18 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::2d) by CH2PR02CA0022.outlook.office365.com
 (2603:10b6:610:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.41 via Frontend
 Transport; Thu, 8 Feb 2024 15:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 15:56:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 8 Feb 2024
 07:56:03 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 8 Feb 2024 07:56:00 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<razor@blackwall.org>, <liuhangbin@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net 2/4] selftests: forwarding: Fix bridge MDB test flakiness
Date: Thu, 8 Feb 2024 17:55:27 +0200
Message-ID: <20240208155529.1199729-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9f8812-5ae0-4532-7d56-08dc28be7d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1G1RzO/btSLHJAKSiKpONxu9A2jcglZAhlGVEMnzQQiu3PA9S0cbpmcwY0nRF/HOo6B34x7NSGLvfG92bqX+Mqv/5Vu2wjxHTGJJWsZn9CxismUukWk+pHJbqNtseHb/OACj2hZ4HFnuKL9P/afJurER4ic4+puCmZWQFf68EKTleTI1R6AiDUjp1BqUh4OlHVNSGHnum0+S68BFrq0tLbforl782aDmdU7xVApfnTdCcNziEX+djjf21LrsrMi7pjuLv+Xz1hT0TcsnbB0SsfXwn62X58TfVcRtKOUW8oHTjoYMGoq3reAh5ILPSr7bKx2iDlqoJP1BHKp8LvHRp621+1tt9W7EmC1ONTCqMq1ugizUNmT1bDrSdoTQvQYQjWMrNpYajFQLCXxLKhJhANep1Wr+LpQ41hhrLkGZAYJjEPstth36J3soaNFtgWZ43S2L27MhZyIrkgEfKQ1dgG/3jBe5u4tIqrKPHHJ/J6EmTSIrzh4VHmgmffN0Hh4HQNf2oPs3S7rznLiZmssB4ClNg2nfoxATixQ6Q558OUeoYp4s+zY/8os2ZssWexv0FnRk2zOUj/RjGBo1E80XwQ6tnt/irlXbQH8pOwjwZUM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(41300700001)(107886003)(2616005)(1076003)(86362001)(82740400003)(426003)(478600001)(26005)(336012)(6666004)(16526019)(36756003)(356005)(7636003)(83380400001)(2906002)(70586007)(110136005)(5660300002)(54906003)(8676002)(4326008)(316002)(8936002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:56:18.6358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9f8812-5ae0-4532-7d56-08dc28be7d22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054

After enabling a multicast querier on the bridge (like the test is
doing), the bridge will wait for the Max Response Delay before starting
to forward according to its MDB in order to let Membership Reports
enough time to be received and processed.

Currently, the test is waiting for exactly the default Max Response
Delay (10 seconds) which is racy and leads to failures [1].

Fix by reducing the Max Response Delay to 1 second.

[1]
 [...]
 # TEST: IPv4 host entries forwarding tests                            [FAIL]
 # Packet locally received after flood

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/bridge_mdb.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 61348f71728c..f94bfb6f45ec 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -1252,14 +1252,17 @@ fwd_test()
 	echo
 	log_info "# Forwarding tests"
 
+	# Set the Max Response Delay to 100 centiseconds (1 second) so that the
+	# bridge will start forwarding according to its MDB soon after a
+	# multicast querier is enabled.
+	ip link set dev br0 type bridge mcast_query_response_interval 100
+
 	# Forwarding according to MDB entries only takes place when the bridge
 	# detects that there is a valid querier in the network. Set the bridge
 	# as the querier and assign it a valid IPv6 link-local address to be
 	# used as the source address for MLD queries.
 	ip -6 address add fe80::1/64 nodad dev br0
 	ip link set dev br0 type bridge mcast_querier 1
-	# Wait the default Query Response Interval (10 seconds) for the bridge
-	# to determine that there are no other queriers in the network.
 	sleep 10
 
 	fwd_test_host
@@ -1267,6 +1270,7 @@ fwd_test()
 
 	ip link set dev br0 type bridge mcast_querier 0
 	ip -6 address del fe80::1/64 dev br0
+	ip link set dev br0 type bridge mcast_query_response_interval 1000
 }
 
 ctrl_igmpv3_is_in_test()
-- 
2.43.0


