Return-Path: <linux-kselftest+bounces-7837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969858A3463
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B56428585C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CAD14E2F9;
	Fri, 12 Apr 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NVZrI48+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB914E2FD;
	Fri, 12 Apr 2024 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941580; cv=fail; b=ZEss15+HIbeQLldHXCdmM8CYOQUDhhPNjTzaPhby3hVSLm7rDsbkTueOsFvyjAV41gJKZjG0RK0WeVDjW5dl8sHqs5Q16qaJAa3ix1CNb8KMSYr55IU69V7O39VHuHxVkBZf5QPIxNCNeBOroyCr35TwHmDM0mGa0kGGAxamP7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941580; c=relaxed/simple;
	bh=6bIFf1z9WBQX5FUb8QkTBbv3CN4kzUaZtw/GnAlu1CY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmiaNcF4PiEtC3qd3G/RwickzQj7AreK0rwhPakxD3Ow1trDJ9T5RNXGXEWqGEK5BqaIDqTtI1gqDofZBoEz8EdXxpDE2k641oofFUBK/hDR0aIOmkejLZ0ZlQjQ9YBRz6dut0acbssZKF3PLJhc2J2EkPnMtr6FnhvTDCtpA58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NVZrI48+; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9Ssyg/pFcikqCnvyBpC8kI1DBVXA4pjPsmtNCpwqAq2hq+xMy2WNH3imH8pf1LHVbDeuHCTmyWwzasGSzZsppx04ONIZnEHSdRz95EjMq2PC9u5Hp3DbENS0iC5DgthEAHRKNxcA6WWlzeB3YsVIvWimznLuM3Du+1XsHMT0J87SwBNiSmeHexJfkF1eMDKHDnY+ku8UL281rr/UmfhV6qEiLObLH9ktF68Ld5wgJDrMFdZe2PDNBFkfMQ1NBgb8IwYeTx0iRjPlWu6s61joXZXbHoFvYGenNbFEpEVrqh5zL2ejnUEYnRHlntjo75o6NQMal0UZaeKF3Q1BkHXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFwcgmFMwihHZj/7XLqErIOyS7Jeu1KoZQ0EhxRX2VM=;
 b=SbqoVhW0pIuTlY2BH1HCnvWuDIEbUMr8mBycETFTeT3jUYfhnNR2ktgQLPjYMk0TzIJQ+J2zjniqWu8ozN9Oi2wcuHMHaDcQrrD6BM0mKDsDZ0SBdrZktpyfcskBysk/Jm6uW8T4kf1/oJ1xBZRNED0qvWaFs1G59td6pTIs7Qz4Qo9epuZeY/Bs0WwChqViQK8iazY2SydhQxDGVDZuL6PnSbpwNX7rR+cNZP++zbjbPvOVcTdNHGwd0oPK2gcCAs+ktSFLowEvPMLF8sfeOXclEjNN9rK0s+P6IfKVtgG0TWQrGudzB8RD5OtZnPfZVNQ3yvKUrxD1nb6+aHRjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFwcgmFMwihHZj/7XLqErIOyS7Jeu1KoZQ0EhxRX2VM=;
 b=NVZrI48+2zi30YTVwoc7aWKSwfMBovZyWtPFrkwMG2EEoaM3U7cKktTkHrw4Xsesko9tvlYleyanERTIqg5l1+RpZh6i3E1VJUqi2zubH75ujY3z4M4ZBseNf21ZKkoBEwNsvdR1eVtzCNXDB+SP2x9JnGLQKVt66DJi5UXiJCLtzTvgAHSQ3Kn0iA4sbaHD1U3iXRoBOEPR6ECZo2MfzFKR0NEUjpf37lHSbi+BpF521mmscKNxJ0m1rNlClZX9804dMfT/lVcbfP0VcAvzV320DIzVFlPUQ0vTxWm9wi4Ytmn/hONuJiHXeD9+IiNYZ5lpfgg7SL1aIAOgjSyjBA==
Received: from BYAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:a02:a8::21)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 17:06:15 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::c2) by BYAPR03CA0008.outlook.office365.com
 (2603:10b6:a02:a8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 17:06:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:05:47 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:05:43 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>
Subject: [PATCH net-next 03/10] selftests: forwarding: bail_on_lldpad() should SKIP
Date: Fri, 12 Apr 2024 19:03:06 +0200
Message-ID: <686eeb760a35f228bde1392ffa3f59462223db26.1712940759.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: ae524aaf-1228-401a-d3a2-08dc5b12dca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	asmaxS9Ny4wgcxqx+t227s9ygzbKcYDOqwR7Rwgx4OXxCRBjRbn1W9k2honT4Dzoj79YZW6Nl+3dLVeBypilT/QxrObcEvxspQsjcvrB44JsQhqC5iTbVam7+numoqrCOZxbMZ9zHQV2D6kDb3/cE6AFqJ3Ddc4CKnYm9drRpsrpoOg2N+7wMUZ/6jlD9Xl+BuRJWb7CQO+KDvb8UJO2kxTStYeP7n1TOtT47VfdvvEmqdBs0CkHv65cIYiGfo5hYN0xt1dBuFe6jfmYVZrWtMwGjA2+JyZOdQgeQ0yViEL6qGGzb9fRIlDs2dVVHz76xRnb3H7kOCbz9LOwnzjCTPDJ1KGWZy+tS+DU43RtlNIK42rv4DFls7tlE00jZtPRQUsNMVJFWMB/8FAF9YLO8f6r8uwyr/UCVNo+hw+Gef+NS8/xSFnjMubM4WbuigFmtv7b4d9kzEbnxkMt25JY/qaU2iuzOW8ZBnmWQH08QW+F9ndeld8rKs5nAA3fm5+hGLjA6ygf1mAuLaJWmjqGkRzIIU8u8JdL0pD3fFB7i69OoG3KS8eetBfwUt1k3e5MlGpVLsHFMtPmuZzsPw4xw4H6Jgq4miQiZJSubBMmfj5JotAnDq4LjKiiEGe2F+UdZhkrbze/YxqzkK1Pa22FHOdhvccWWXBM8V0iUO5U2vgSryLs7PYnlnXIR9H9N6/duMnT3R0cyp6zoCjUojAtHey1cB4jXCcRDETTn+pVpDHRnyBSCXPtORlZ4kUPCAqp
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:06:14.7312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae524aaf-1228-401a-d3a2-08dc5b12dca3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

$ksft_skip is used to mark selftests that have tooling issues. The fact
that LLDPad is running, but shouldn't, is one such issue. Therefore have
bail_on_lldpad() bail with $ksft_skip.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 3cbbc2fd4d7d..7913c6ee418d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -2138,6 +2138,8 @@ bail_on_lldpad()
 {
 	local reason1="$1"; shift
 	local reason2="$1"; shift
+	local caller=${FUNCNAME[1]}
+	local src=${BASH_SOURCE[1]}
 
 	if systemctl is-active --quiet lldpad; then
 
@@ -2158,7 +2160,8 @@ bail_on_lldpad()
 				an environment variable ALLOW_LLDPAD to a
 				non-empty string.
 			EOF
-			exit 1
+			log_test_skip $src:$caller
+			exit $EXIT_STATUS
 		else
 			return
 		fi
-- 
2.43.0


