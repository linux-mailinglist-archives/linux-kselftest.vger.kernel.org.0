Return-Path: <linux-kselftest+bounces-7836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9468A3462
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4ABB242E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473FC14EC40;
	Fri, 12 Apr 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G/G8i2RK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176C14C582;
	Fri, 12 Apr 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941575; cv=fail; b=atzdc3s55eRrrQtf3fWgnKrRx7CMhQWE58TMelDOAv7rVZjiSnu/nR7NP5//eQWgzBIvzkzJqKKYldxbWsTpKx3ykreF4QnqwnmnFfynWILLlCCSqHi4mByNqsEUKs2SyrtVznpH/F0LHfhHxWSVfdxyL2mKDXVnOguSe/M0ets=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941575; c=relaxed/simple;
	bh=M2uZ/dhBefUrDGLiBoAQP0/VwhnYBnQZyg1uKLTPekY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFkNm1xPViApIBIKjaNV7xAgsBCtMw5xXLOJnbrsL5siuY3WSb1RSOSnEldRDfMTf7wv6eZULCsvw5GjC6Z/ikbA8gvGQ2SkQxpalPZAnpaisfFeY5guALdn/E5l3vXf9TAliIXvtx2FolEzUbtwr4XfBA2WCnylC8rJMHMRQhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G/G8i2RK; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClfHmgcys3gn6DntmkkEprSQdEzj6zvRhIZDmg7l+6btW+0LTtE1/7AnH1OBSorK04Z9zPBoGNjsSWsCITAf4okhdF6mt5qinwExh5O2alWPa9qbH8nKUK8DP6wzlxHgRzIQ3Xvp6gfgF0CSI/J1dkoAiDJ5DckyhxKjnkYivsjE8bNOTtLWu4H9caVvNQheVH2BmP9T3UtBExhmXwYNcpzQK1qnwC4FT8M4hxYAAcFAiGu2XlOG2HIlW/IPlGjNRfW4KTlCVPIQjrbqNpoQR3sObS8QmzoBsuz/XD8BeBqgq5O6TXM1gu1Lk/G9tDes2NCgTp9KypMSzsR91r3+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhmgbFPsRkFsd2yIHCyzpsdvRKy5pvZzDJMwYqjJyfI=;
 b=ghapg1+vSOohcR3YasmUmfNuOh28IQOrcwI/kLuSY11lMsBs4qSsyhTPkkwoFeBLHpgQ2LxGF8OIYkDaUZKcxlVKeGbOZgwCTtH6hJV7QeLd5rUA0YZPYiOYVieY0i07pjzi961k3Fks4jzgPj0srIvaiDbzpMA4IcDy+HtVdRJVrIwrdSBuKYV25DgvfKBDp2zx5ob1w3oftifCNavbgDvF8MZAttWeegmBhTZ5HK3frWPZOlEVDARvNDriCN9caOwxkRTNQ28jmSD4DbdDd1aRdDn+REcO3ojaZIybV3yMJ36DDk2lNmvD+hclIOyfGLD39ttv2G1qM/d8KngmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhmgbFPsRkFsd2yIHCyzpsdvRKy5pvZzDJMwYqjJyfI=;
 b=G/G8i2RK8prTBeEG7x91F4d6850A910rvefPFVeB9bAeyJq9ON4AJuuEMIq27IQHz6JqCdxqWcTXvCAStPQ5XqvoOHW1xMV9mbVEu15gzZpirA6xQJizdUo447Z6nk8rWYYcq22XOn1BSB87bypOeepk+BrhQ7//Q0mqkmrNm4tWiOPHzAIKQ4CoStK5TWIzF0ww//1BaX8MgfBasdrC7C2Psc+BVXFIAym6RCpP0gX8aRS+2eLADUi/gEmTvFob6gfAYnG4O9U8oWWJbnwgtLwuf7tPs5LeOfdvReNyYhkq2eMl9jVzlcNuCHTNNeiN4CFaFjsKO65OkmnmVO984w==
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 17:06:10 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::c9) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 17:06:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:05:42 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:05:38 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>
Subject: [PATCH net-next 02/10] selftests: forwarding: lib.sh: Validate NETIFS
Date: Fri, 12 Apr 2024 19:03:05 +0200
Message-ID: <4a7602678782a1f526bdcc895de437bebc96a695.1712940759.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: a13e32fb-0df2-4999-1a15-08dc5b12da12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9T0Qvnx3ughWLAD9f4JQEWhP/aX5utl5OVhoxAO9qaPOIPSr9bHIdqkWda3YFKV+Vrf4Upz1kC9/B8m9Jd2NjM7BU+DYxW8/tFTB953dGCSnNGp+AVNS2QDD8JjiBB84xGokiO7EOBVjstgAK/wnyLOpdfp5Eki7nardHTcS9C3mbQv6oW6Xrwpz/hKpVyQeaq7e2pavoU5q4hMwgL7waq1rhTZj8rTcdj29FMFxaVy8YeDo/Ix1fFo5Aw8xF74Dox+E2rwJQRsQCZfGqDiP5R8kE0XzkfISsZnEYZzO/ELAkMs4Asb67OpP2wzses8HX3JgzPPZahEp8VZ6/qHeD8zT4YtHISd9ZMMkpEkqWhNWkEqLT8el/RBVizX+aigwO8PzWfnu3MGBEQuwdVOyr5OUqI4HVdiWL0oYkkw/NHOk+iKqbXsrDKXPktBraSL3TeSdtzsJQGFZJJ6EqMkjqmBdlp8REmsoJ+XhtJx/icLuMTldY4rsFwCKpDXSsNGXJXGWDyeLgto0WLmXhj+cPUWNMhcPx9iatVVIFH5zmIJbSmSDBZ5QS8KILo9h+H6wB7QYVwJeKDdtB/gEgPLlESuagZBoSceO/6VnN3uLqX8P8YFJmkfz/h2JyAKZHfCoFBVwTTPu/SsAuP2kHEret6+VXb/HctAi+kdPtJQU6eM/e5fFlfSiYBRDdj8TehWid7/rpUzKrs9cu8hoa/+BO5Zwk95NA38aDzmzKursG7RMp+POBms5UKIhWeLpy8AO
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:06:10.4988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a13e32fb-0df2-4999-1a15-08dc5b12da12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952

The variable should contain at least NUM_NETIFS interfaces, stored
as keys named "p$i", for i in `seq $NUM_NETIFS`.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 658e4e7bf4b9..3cbbc2fd4d7d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -273,11 +273,6 @@ if [[ "$REQUIRE_MTOOLS" = "yes" ]]; then
 	require_command mreceive
 fi
 
-if [[ ! -v NUM_NETIFS ]]; then
-	echo "SKIP: importer does not define \"NUM_NETIFS\""
-	exit $ksft_skip
-fi
-
 ##############################################################################
 # Command line options handling
 
@@ -296,6 +291,23 @@ done
 ##############################################################################
 # Network interfaces configuration
 
+if [[ ! -v NUM_NETIFS ]]; then
+	echo "SKIP: importer does not define \"NUM_NETIFS\""
+	exit $ksft_skip
+fi
+
+if (( NUM_NETIFS > ${#NETIFS[@]} )); then
+	echo "SKIP: Importer requires $NUM_NETIFS NETIFS, but only ${#NETIFS[@]} are defined (${NETIFS[@]})"
+	exit $ksft_skip
+fi
+
+for i in $(seq ${#NETIFS[@]}); do
+	if [[ ! ${NETIFS[p$i]} ]]; then
+		echo "SKIP: NETIFS[p$i] not given"
+		exit $ksft_skip
+	fi
+done
+
 create_netif_veth()
 {
 	local i
-- 
2.43.0


