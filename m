Return-Path: <linux-kselftest+bounces-6557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313F88AD1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CA61C3B4D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F52131BD6;
	Mon, 25 Mar 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="smwZbz/T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93E12FF93
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387966; cv=fail; b=Bov+kBVLI2moaHYLOBXS+FlYVS3D8SCFEnHJ6v6+If/yIlqD0e517yxmiuWRDDsaWJmLcG3XslwTvlVY3DTEdYEbovJCsR9Atmgyg8nzd+9zeZt/90upu5ILZOQ2fYGpVMcBDEOkd7LeMvqXvlUaW8JCCe1AerYJFhsHSGCze4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387966; c=relaxed/simple;
	bh=U6IDXaxfmqSNGryMzeBJlZXsnDiUp5VBG59deIGI2Mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4Szt92SfmJ+KVkiboguRQogjRzv0nB8GLelt2Z9wwRDBCqHHYGWsKMXEy/D+4JI80/hsajiq2jBDKTDWXhUnDvcndBQrfXP/Z1vQL262Y2m9XQhlUNaRnEirNyRTmOBtooHUiVtd/yRQJGmbKRck6AaDDSS3kkcK5irheFYZLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=smwZbz/T; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0TY8jS1a0pWi0DUofe0zOFY0EsR0OxVmbqlyP/MfwfVlgWCNRfvmxG1aQZnEO0Vyieexl+2BhU4SXhAiRExyZPJGfYqullQUUBunOqzfHrCcNfbzxUQOAXdniLK1pctT85Q8tWALed+KeeRrdPNqVj4bc99639HwF+exbdoFPHjqCQ2Out//ii4XsIR9XWWEPeA0Z+gGrPA2yt7VwRk9LEGenSNNMMZqDvXu7Ac2EwyrKp0EElatt88J+fcihMclnccZHzWCB2Z60MZA3dx8muIEbpCo8efnarg/OU9UWkP5MBAwLy++dJ6euekr53DpXkDp7AxCh+1aNj6wsufBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZbHvSGkaPZIc+jXFrBUJrlxuSi9YeZoD9csuGvfi0w=;
 b=YLgZhNOyruojhqQmqgcejVxxWWoVazssxRTT/yLO1WWVqJYOkuo5GHcyKiO7KjnM4McmksxFqydcHZAoUG/pJxUKWbBjOO51eeQ5ozDJ7CyB+bw5J08rM7xio/ZCnn/wUwiJkS0mu9K9HxO0ZsvAgHzBe7j4+K37rnonWsJI7RMteQhEYcaT4r36B4OVBeJ9gD4lcFOOoA++bWN+xkdh0Qo3fb+j9HSFRVjnh13iW5sCIxubtGAt+Kp1eboRi3l6lWqUcjTVB2Dlwg+oIaGKR2Ot3EPJsvwd3sotR9OUJncZZ48OLE9b4s0/IZOfYTspdjOuCyZovqNzj0sxRMe5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZbHvSGkaPZIc+jXFrBUJrlxuSi9YeZoD9csuGvfi0w=;
 b=smwZbz/TX+eRbgCxJvRcldXxJKH+Vp0MlZ4ZHOuM579EBxl6q3GSAiCsDcGrKtukudAtyAh7Aa7CaY3gUylWtSRdvmR7ZkoClWX9F5Cy9hxt3Q4otK/ooUB077tVNgYcPMuLPd4/GV7fRgHlSqdheJlzAZOAFigE4mrj4JoUvf7MGPjAYZcGfNrrV5EenWnTgh8BXvBQhw/nL9j+f+RBEV9F3aiPQCqy1hWTOBkZ/sOYsmVY35CnXBRPhOwCAfzGzc9x7aUPbojS9RE5VF2p/GbfaHxmDVyOdqmCO88RPqxv5oFJ/Z9SEveulha7QrRuDCKDb3RuXlNA7OWswez+ig==
Received: from SN6PR08CA0007.namprd08.prod.outlook.com (2603:10b6:805:66::20)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 17:32:41 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:805:66:cafe::ba) by SN6PR08CA0007.outlook.office365.com
 (2603:10b6:805:66::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 17:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:32:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:17 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:32:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 04/14] selftests: forwarding: ipip_lib: Do not import lib.sh
Date: Mon, 25 Mar 2024 18:29:11 +0100
Message-ID: <a4da5e9cd42a34cbace917a048ca71081719d6ac.1711385795.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711385795.git.petrm@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cf1f06-25a2-4557-6f3f-08dc4cf1925c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K979Qq2RhHot5+DvzrVwF1+s0ZO2DaFBenswHmh0POaPhDlaRo+CwEFyKt1gS0VTYWoJZwTaImdkNotmakn1caJrUlWf6iIG8NVV79YhRZCsBMIrxUGpd+0EqctScNoZNV5ehSs1VhgE2YU/xiDmJtk6OMu/Ix8aNRQ/iuNMG8Zj75KSlwevucRrcHiiNHAcmewdyryZ30/gyyoFVpHmZnQM9VXpIb6c9/l7nGK9fvsbeHcS6aB13mkvR25ZpZqmcToJ0L7isXEn/PWhdcnsKOsPrGImiexVXQylGMwv9Kja0DP6ZbLhmR1rrMJUvZnG/LTvpGz49qAV91VpNbtdF2CQd/zx5/Wy4/hqPQR0lbGI+oEXcg1VXCevK/BQfe0F3TBKHznzqXUGI/U+g3bvn5TIcDhK1PwmoY2ZZRArYaPSzxZh/0lOktsmEs6EW05Kbq0YCYIAZygB2d6MYvHN2JJ9NzkgTJ1tyXpGe26VPA10A9LBAGt/nd2ZNPHhx7CCZoRBAPGK2uJPxLnDSAhAj2CPa4ipBPRSRswXW8BzFqyDDw4SGgCjpS/SjR+bCwjmesAZcSqx1Q3ELR179xaLF42uIssWU8IQwRYdxHNW7WkUB0xGEzLkFH0JkWdhy+z8onyS8rqvelDBsrXGRJd2mqPYQvgGZGonTszin16jRo0bYxhAMcZANaaBEsXWlT0JCpwwgesKQ9PpsX7Q2hP+GQh/oleYTYFcumL9LuYc98W7bu9yWl8o1fXRNhkW3c94
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:32:40.4722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cf1f06-25a2-4557-6f3f-08dc4cf1925c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971

This library is always sourced in the context where lib.sh has already been
sourced as well. Therefore drop the explicit sourcing and expect the client
to already have done it. This will simplify moving some of the clients to a
different directory.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/ipip_lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/ipip_lib.sh b/tools/testing/selftests/net/forwarding/ipip_lib.sh
index 30f36a57bae6..01e62c4ac94d 100644
--- a/tools/testing/selftests/net/forwarding/ipip_lib.sh
+++ b/tools/testing/selftests/net/forwarding/ipip_lib.sh
@@ -141,7 +141,6 @@
 # |               $h2 +       |
 # |     192.0.2.18/28         |
 # +---------------------------+
-source lib.sh
 
 h1_create()
 {
-- 
2.43.0


