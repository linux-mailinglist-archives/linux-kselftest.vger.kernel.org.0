Return-Path: <linux-kselftest+bounces-3688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBF584051A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 13:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CD7285B2A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6260EDA;
	Mon, 29 Jan 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vf8/UhSc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385C60ED5;
	Mon, 29 Jan 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531863; cv=fail; b=mYw8rAtHI5eyMUJKffwU/f7oAI75URiCVLJlyGPtOUWlHBSpFr3rI2s5tw9ChcbnSYYh33TNYCH6dBnIM/eZ3DI8f2eHoIO8UaR/CJlEes32QMbZZqewMD3hSH/m4RuvYS2ZOk8Xmx4axZdqsPFVRZk+3BOfDzzEEHuRUjZifBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531863; c=relaxed/simple;
	bh=vLDeMQyWajycnoM9pTgA7OL9sSYSp8hbnTpntbjRwh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L0MiYoriI0YIHJxIDCXBTOIe95RICoysylkUZ+CUnQgncjF4ybfxzC8M4YjMjXwTWrLlBi2Y+vCSfMWA0X2j4rCS5xdwQKkDKEnPkGnPRmZoEI9xJXZtQVnpPQRHp6JO+DO5aMamlM5UmLEPcAgProtoei/BgrkMZjN7rl8p1o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vf8/UhSc; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tbzd4JFNYkmlvZLUvygkDUZd9DDKp6wWosXaP8Z16a069bPt58SCwnhuMxdW/7gL5WmYSCOT3grc3HrV2sHBi/cqqxrWUiIzRETyVJcT4yTVT5CNu++60ZWh6LA6GQgY1kkY/YiItDzsf1mluuXuLUgmTInW3X+E6J8bXuaipMB8IvtCzDuYljX+NM93eRL9Cy1811T0849LWjn4A3bxDC4G3zewAuBV3w3zvzZ/ofaHGBqgLbUbc0gLaWUv6Zm148N98xhj1IZCNnkPOIyGcDLy/KhnJ6grI1MQ2J6SpcN9W98sByhGRt0VSudxHXm+nGLC8x7f4MWkXv/NbnnK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDP+CJZ2CVjaDWzdmqMknTMZKOKjZXWYBb8bAHTv5Aw=;
 b=ELQmHb/95lVq4AWwGh7+icIvHMFtdhdKYYf4pSoH45KOhinr17d2pkKQXMKxEk/Jn595bckgju7gjKbmGNTzLzLnN9FKoi+7mXJjOVDzsD0mp5bxWKvp2giam2H03JnYDJ7jkvAF/UyOMIWPg3m91pzeRUoa4mFYTJm2JAJyvwHEqD+2zNrNbcQI9jcWG2OflvbihU++ZFqStuFo7RLfW1tyvu8qzV6js2V0xV+GlZZg2bO3dvx+vAYOtCHw64u3zvRZCwawnG9A9k8GfMhOzZy8GNxcrY82iIHRqFEwrfhiysIDiwckHrh4CEAVnL/lCJMLY3DPmGLljY+Fb6WxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDP+CJZ2CVjaDWzdmqMknTMZKOKjZXWYBb8bAHTv5Aw=;
 b=Vf8/UhScAv3Lr4ENCzbU/m3Wr9jHVHY0GarzFLoArEMMFyMjYi9AVZ+FTQtzlOwBDqsHKaDMqhoS1jV0D7ktv9mB9XADhiVV9HxCFZeaK5C7xeAW/xS7228YsSwmmbHC8Qx6Kw/j+d1EOL1pSbjQY+p2mlK6+psFrlCrEtrYQEvng3a6zFPlYORl8gddIK+ybUH3qRvhdGAXSC55pqtsN49xsldQD+Iln7VdI1gKgssfiNDhkDAcXXTDCbhmCB7098DcpqiSZCFBrpFwH1Jihrln5nvtXNjKFvZgEvJWg0ZuM6bJ50bFMiqT9wE6AU1ccJREL4dZwS329u76JXRmcg==
Received: from SJ0PR03CA0104.namprd03.prod.outlook.com (2603:10b6:a03:333::19)
 by CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:37:38 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::df) by SJ0PR03CA0104.outlook.office365.com
 (2603:10b6:a03:333::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 12:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Mon, 29 Jan 2024 12:37:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 29 Jan
 2024 04:37:23 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 29 Jan 2024 04:37:20 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <shuah@kernel.org>, <razor@blackwall.org>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next] selftests: net: Add missing matchall classifier
Date: Mon, 29 Jan 2024 14:37:03 +0200
Message-ID: <20240129123703.1857843-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 405b1704-0c65-427a-9eb9-08dc20c7141c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cEVCzRm3seF/pynznsvtm+8cICWrU9k47USJYYO4fSyh3GHaN3oWgy5krh2hfyk3yQ3HrYeVyKNCYVWHYM1afJwgf4mqMDH80Fmzt+23a1HqD534LhvQANlooH8MdzNPzJITUN97r60EKX3CoiV0jQRqVp2P2+m7KHKYYbQ1I5tHc/H/OtjANhtICukqmozXcB+PYU4cLcYmgDbbmJPX5sZB7+cshHH2ibs42yNQ1+A6wckqZ7m+Q5qfNUjbz11AjWzr9mCLxItt1deEuWBBGxu+u9ukpk5nP7Zr/12lGCsnDNHBxjKfRf1tkB55AHJFiWSNtBhQh3b0OwOxUR5akNwgVXO9RqqYeyOGTecNReXKHahzDuOqGiH6WnE2F8b/0/5DAd1wfc9LaoVSLwKz7E/DSFE13LohTF+Ggp9NbNbKtS4tifiTom5e3XPot+KDVNk+Qdt1nA7glYHv7FOK/EAmhxW52EuDfVmuKBDPFVPaL+3X5qCVjbjeIvB6o1yyh+RcMgeGeOCnEumw72VOf6L82Jflll9dHEBRWfTCs5q6OqoSQ1wWDQISxW1ohUgboMf7KFHHdAbn4DtZ0zqW8d6pqE+T/uO5E521wGSRBVWce9aopTPIc5pwZiW6tC8qVyLgkGA8Wv8C99amHLpO94zb7zV5sUcXgRnps2/6bqO3/IYxkomSvnLT0KldwSP1xo9nEeZG5S5QSfMSo5vXVIBbA+UmZ7t+VbGWyfjWBR5TogMRb00+KHmgnXnvWq/S
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(46966006)(36840700001)(40470700004)(41300700001)(2906002)(5660300002)(36756003)(110136005)(70586007)(86362001)(70206006)(83380400001)(316002)(47076005)(54906003)(40460700003)(478600001)(6666004)(40480700001)(26005)(336012)(426003)(1076003)(107886003)(2616005)(16526019)(356005)(4326008)(8936002)(8676002)(7636003)(36860700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:37:38.6518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 405b1704-0c65-427a-9eb9-08dc20c7141c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021

One of the test cases in the test_bridge_backup_port.sh selftest relies
on a matchall classifier to drop unrelated traffic so that the Tx drop
counter on the VXLAN device will only be incremented as a result of
traffic generated by the test.

However, the configuration option for the matchall classifier is
missing from the configuration file which might explain the failures we
see in the netdev CI [1].

Fix by adding CONFIG_NET_CLS_MATCHALL to the configuration file.

[1]
 # Backup nexthop ID - invalid IDs
 # -------------------------------
 [...]
 # TEST: Forwarding out of vx0                                         [ OK ]
 # TEST: No forwarding using backup nexthop ID                         [ OK ]
 # TEST: Tx drop increased                                             [FAIL]
 # TEST: IPv6 address family nexthop as backup nexthop                 [ OK ]
 # TEST: No forwarding out of swp1                                     [ OK ]
 # TEST: Forwarding out of vx0                                         [ OK ]
 # TEST: No forwarding using backup nexthop ID                         [ OK ]
 # TEST: Tx drop increased                                             [FAIL]
 [...]

Fixes: b408453053fb ("selftests: net: Add bridge backup port and backup nexthop ID test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
Jakub, you can apply to net if you want to, but I'm sending this to
net-next since I want to see if it helps the CI. I'm unable to reproduce
this locally.
---
 tools/testing/selftests/net/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 19ff75051660..2bd5f9033ade 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -68,6 +68,7 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_ACT_TUNNEL_KEY=m
 CONFIG_NET_ACT_MIRRED=m
 CONFIG_BAREUDP=m
-- 
2.43.0


