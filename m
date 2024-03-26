Return-Path: <linux-kselftest+bounces-6647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F3588CA14
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D603E32158D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96081F61C;
	Tue, 26 Mar 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHxuLD/T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BEE1F60A;
	Tue, 26 Mar 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472499; cv=fail; b=gF8AMB/4x9Ex+p8Y/Eq3PtRbBV75MUXF+PeJ4hnFAcOa3O8mBJQJXVqVhZdosRtyaaFScj4gp3Rv4fRCEG2wPiBS65WjmaZ5ocpNEXut4APVxDy7nVcAkFVqHryHu5UVVOfWTw9hbA9HpPG7r7oLZ+tgG4CD0b7hOCVVsLCkaIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472499; c=relaxed/simple;
	bh=HDf28ffDoLt2OzHE5NC0EZDQjL9LK9TeToUEyEt1fpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzZ12isXqJiG3PtZuh+XVoFHFXWX6rbR5wZ0h4gx4x/RCaeoo3cw+m1CQgTOZNFrHQ6yQ/0ytDRfLVgs5XCH0tqZJU7tN6xWIgkCvPckEoddDimZ6F2LWDg+JDB83KvZH74bI5oRIl8Sd4vNS5JFf0rc8LsqJ7/FkJwCvcnjrQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHxuLD/T; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpfIEfdccUNdxW7s9V3FQZTjC3pxxMcqVVRgs7U2gX0cm6PEsFOY4vQkWpS/YMPM3w12SlFZyoykRpphHDxontwtLgN46XGA31CMHF4zqxwR54mJGd0R03vEDYwkylvBVEm6I1eAxpAXFIc1DywPcT/R28EQV50vH8nCqhW3PHsvASz9JjYoQXV1qnANm30syPwavA8ZSm9RmlHk1cCuXXt8ZxtxDBegBIJEE44xeq1HYkVnLJILh1p6obP+QQ4iAxae/okawXJQxFEytIAKYJ3NviR++lceJX3ZwV9t7vwyMrN6SFiAzYzaPLq3wOx0Hd0ttktlTPinwa0ZXZRVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmFb6laAYMesL6/V0w2y95pwC3ay+pBzgWlmAeKdWro=;
 b=UuPp8QWyNrnR3uDv0XckyobISmUSjwgU/fNdUqdOC0E39DMIIl8J78E/uG4immZ4AWypkwP2xHWv5MqSvmh40tKZgozRfgicf1HrtugAB2gJcT2pBGB+cYfRUzfSdWLHFcPs8HGo8MQu+OV9Hy5XbZiQuu0DEs/KJlCDoqKiELT0NIcHWcKPNGjeYz1u1BC8qPi5/2gM1veSIhbBjwgE1ibjdN/iKEgyqrJLtFddAqPIxvesMZZicxHMe+VrpoGyGPL25zGpM3XTrSAox8amFkuV82VhQM73Fuyxw0ZboRZasX85DuCuyDZq93RB4N2Sh6s6SgYxCyTwAjGJwwkQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmFb6laAYMesL6/V0w2y95pwC3ay+pBzgWlmAeKdWro=;
 b=mHxuLD/TKC1/ajjIY90TOlZTY6TCJdQCV5eoxgyZ7aSso3wlnSFxb0A6iNWGGfOgg5MCFakqliPJ4sHIl+mf5+3ywYKCAg3wQZ4hhimHBSZKtibklukMdB6bQtIXeSHSe8wYFX2nOeQgf5jOph0hAQ5gGUp5l/ZVpRyO+YgO3zVXeOYhEly+SBMafLeFvrBJ2FH3963HtHuv/B9LEb6bbXLaGcq4lOFivfQZrz9RcNigIvAheQ2RF9AslWIKqF5qr4kjwLeyvqKdG47l9NxYXrgcpuhi1jQS423iSDqbj5z0lhLgNj7n5OVNqFZrcZVBFKOgPNAubPt905J68j2m0Q==
Received: from BN9PR03CA0112.namprd03.prod.outlook.com (2603:10b6:408:fd::27)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 17:01:30 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::52) by BN9PR03CA0112.outlook.office365.com
 (2603:10b6:408:fd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 17:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:01:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:00:55 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:00:49 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next 08/14] selftests: lib: Define more kselftest exit codes
Date: Tue, 26 Mar 2024 17:54:35 +0100
Message-ID: <545a03046c7aca0628a51a389a9b81949ab288ce.1711464583.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711464583.git.petrm@nvidia.com>
References: <cover.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 24124de0-79ca-4064-bea3-08dc4db65fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DhL9lmNro9/vf83zo8HYA+bg5RCzQ+jlnCNTIspTchHZ4uVbXfFM8tvQkFTigTs4XxaxLwmYjF/PrJEV2xiGqDl5FCY1ktLmFWnktilOlLigQiwQv675r586Wny6s+vyM6A2nUJM3AspbKpOAikzYfnub73KqPj/dalrioq7nWEmbybV3kW17dWl1tIX7VlFE/DN+6t+UsSNidTtU2kUldfRUEOTvU4bQOJLIgt/G8Zf7Q5U3BWyliJ54Vf1CJR25Ns+yM2BLcSxfvV6aZGdAaUoB72sOSudpFP0AEH1caHlp2BgwuUzsYWhbRYFsBuPsZQQlf1XwK6lS6G0fKuUmKUlElL7rLhMFfoJpckRO+f497RN514hV4PYoqLtDaQpEG595oIDbfbMlKYg2gciTV6kFMDs9/qrvi80Qv9ORDVumIMJrzEUknyTNWxrkb3fhYCbHfoSv2EskZboRZLEQI6lqypqPCyGnUyl/46k7eSVQ6UFpavPquLHCyemTUbnDwDa0a3C6CVzqPntNcwO1CiWYnHMtsPL7H9Do5FM4rSMSyF9hEGOt8GX7g4T2IHunwa3d7+mv+sf9PNuy4WlOp4o2sQn7YLjlYAzXhqhXZ3LzASOQeKVq/Ev5Du/UnA8DvKQ3YO/l3LGyemyHW5Ge5NUCCdnbdSIezwdrcqYyCIpUABekQkgF5gkAuVbac1185eZsYY1Vd6bRatks5Yq1+ywya3yF+2tVW+WTOig7W3GWo+YPrkugMNz1YR4aiYd
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:01:26.3000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24124de0-79ca-4064-bea3-08dc4db65fb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

The following patches will operate with more exit codes besides
ksft_skip. Add them here.

Additionally, move a duplicated skip exit code definition from
forwarding/tc_tunnel_key.sh. Keep a similar duplicate in
forwarding/devlink_lib.sh, because even though lib.sh will have
been sourced in all cases where devlink_lib is, the inclusion is not
visible in the file itself, and relying on it would be confusing.

Cc: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/tc_tunnel_key.sh | 2 --
 tools/testing/selftests/net/lib.sh                      | 6 +++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
index 5a5dd9034819..79775b10b99f 100755
--- a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
+++ b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
@@ -1,7 +1,5 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 ALL_TESTS="tunnel_key_nofrag_test"
 
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 5b366cc4fc43..d9bdf6aa3bf1 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -8,8 +8,12 @@
 
 BUSYWAIT_TIMEOUT=$((WAIT_TIMEOUT * 1000)) # ms
 
-# Kselftest framework requirement - SKIP code is 4.
+# Kselftest framework constants.
+ksft_pass=0
+ksft_fail=1
+ksft_xfail=2
 ksft_skip=4
+
 # namespace list created by setup_ns
 NS_LIST=""
 
-- 
2.43.0


