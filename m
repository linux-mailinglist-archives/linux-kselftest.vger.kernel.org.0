Return-Path: <linux-kselftest+bounces-37878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9ACB0F49B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BD27B4852
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D5E2EAB6E;
	Wed, 23 Jul 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fnWNmaCl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03E23816D;
	Wed, 23 Jul 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278928; cv=fail; b=plHHYGAuwJatahLsPQTUiyJY8SpYDFU/0XC3AOF78WxCnd363FwtN5lorwJFRfPCYKfgouXtTJY6c9iOzqkxGO03rIzPOqMEf1AmOj3NXVfW0fR7xhllnOBl7PTMjnvOrldBbDf+I+W+bzpMX1ol6xsT5g/Xg0yscugqTxpHfKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278928; c=relaxed/simple;
	bh=VEttjG72E2mWEDxFmJgc6S0/3eJMX06x39Nn1ogTY3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M4xqvlkJE4syTen1UOPTZC45ETNDyywJqLg2+jOD7K8jFVGYeg6CLX6l2n7UKXoWWwLRBDoHwmAdSdLyysYEJilaDscIdaTzDn6GmgeWp17IwEMQilfjFgmIUT/kn0Q3GJxoAxTo9xiwiedOmqpRKe9AU3zU4OiFNjPMikPR6II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fnWNmaCl; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rV79DjipfRIRIZp83sfAqnbjFPEy4lB9dQrIhtspji7F5rHEoCu9JOP5DucJMG4DDBbjIX5CL/ftjMq+hXbo/kUHB+DvjS4qi8wWRm89PEW2b4JwYGD13BaMaEEE0bgQlwzLHwerQxfFh7Zd4IQ/cDnuMPBqcBaKUo4F5X26CjRl+giYVk0KuTikdcrPsVKn2uzU0gk5zr5QpRJAF/42i+6H7EwQJMUlfXiCVmhvq4YqjWhtIiVv6HeiG5L+qdrnRqO+lGO9FEpVr14gnBRqdDtZVIMUqpwvcs/cee10xJid+TwD1lTC0mq111wK3PlQmdSz2lqH9xnRkIoIfcUVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWtB+JcH5JO8mLNnn0Pq5v+T/J9Xze7Iwat0ss0fK9c=;
 b=kNU0bxzOIovNTQLzi2mD+mO/CmVyWU6hPx7Y467ZNNn2/lR6u4duvTXq3rvv4OLPhHvFYtlfsKNE3fvMzDU051upgGgEUcvRbr9Gu0qsNSf7xGPKG+xzvh6U4KxyA45rhx2zPdsr0TQfnoLvnpCBw5O2Kv3g/ct0FoQCepx5GJrxeibdv0LaPZ17isPHt5EhFrO0Ej8I2yLGhP9X3NFOjsw5wZrAlCICeuoLIF18n+fGrAzjp2QwJyFS1LCCZsKW5L3oEIfgCwjvS0YTj5CgX1GxV6LwjhJJpGU7DhstnhIyTA01BabF7a250z9nz6vpohFptHEFqa/jEgtPVjztcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWtB+JcH5JO8mLNnn0Pq5v+T/J9Xze7Iwat0ss0fK9c=;
 b=fnWNmaCle5XTPh0ID/lsZriDDxxlGc/CjES+T1Em4EW9ouG4OuLBWK0pt6Pcp9k2wZjxfO2PUP5cWUpsSlC1dB4amnXLABfJWYXmzxAJv5qaKaeEScGrTV9Q+1QXpDZaGPY7s5Os6XgCFzTzFOFUt4pamkWmPxbiQMct1GASBHZfPUK0kQVjodlxV4dA/v89C9uN0aOT5dqwvM0lF+Kye3xgvwObVQSIS9GzlxgCVFQF+Vue5lFBJEVsnE8LtYrpllWLQAmrAjkj9YB4b9tgVItAHHutLUAlHUg2UHuKCvZ0VzypFuTmAFAB+4m0PzBKdxQw93khBWqKx1miCsML7Q==
Received: from BN9PR03CA0707.namprd03.prod.outlook.com (2603:10b6:408:ef::22)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 13:55:19 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::71) by BN9PR03CA0707.outlook.office365.com
 (2603:10b6:408:ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Wed,
 23 Jul 2025 13:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 13:55:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Jul
 2025 06:55:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Jul 2025 06:55:05 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Jul 2025 06:55:03 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Nimrod Oren <noren@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 0/2] selftests: drv-net: Fix and improve command requirement checking
Date: Wed, 23 Jul 2025 16:54:52 +0300
Message-ID: <20250723135454.649342-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef33a9d-d45b-4541-8d59-08ddc9f08e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HrBSbIRYeE+bwm5O9QsxSonXPIj0znD3xSNn5ilHIgJSqRd7PzY0hvOEEUt0?=
 =?us-ascii?Q?taCw1S2X6qtDelmXXwNqQfN7rzSsGmxOxnSIPviQLNjhFbrwKoxJpPQSe4U6?=
 =?us-ascii?Q?8iirEx4pyn32OrvHndGE9MINZfqx30hVnjJ9ElUcDe1SIbb9V2n9Ci553Cns?=
 =?us-ascii?Q?kOxL2/ufntSF8GwVWWAJ3O6dGzEc6wh8u7mmOXIPTn1H4icuPMgj8YtmAeuM?=
 =?us-ascii?Q?45BBxbcn5gUCFKfWfd6wOBaYkdMX81zeVSJw8hPcEnUTxzP5soIoFCy90yGB?=
 =?us-ascii?Q?zNrJdLlfFYvsL2AjX9hqYxe1pyOODmZdjQjd38aCb3zwiO4pXXnmv94pKXdg?=
 =?us-ascii?Q?qxyjwie6YmftlqNZmSPdj+d9o5I0Va9gcAfwEYGWMQcXwe4bVxkbRQQGIPI3?=
 =?us-ascii?Q?midVxR3H1vQbm69nsrnRxfWtsiumf+tFVAapwwKqP3pz4YIMeyPO9z+x/Ncw?=
 =?us-ascii?Q?GLGkgtI8lEqhh17/eVf5eDrhAxAsZTnDvGxusQzjkv4fJJrlYDyHtry5xUa5?=
 =?us-ascii?Q?laJPcXzTP2BTCIqWgxTNhrxTVFn+egO2XSGOutnU8M8qox779LAJvMoEw4WK?=
 =?us-ascii?Q?cQtggYuTKdD8O269aSmBw1v7mr9J+gAId5p6cUeISN5S+HM7ppivppgzenbe?=
 =?us-ascii?Q?9WFZDWG9wH1V2VbhevEuUhERd/XEIO1ZRynxqSxOSlFw8chbs+tcM52yQvqG?=
 =?us-ascii?Q?8JJk25mPvUeBxaJC0TEwpPShrTxlIU6r5EHbsW4WDPFsIB9Rns35D9uDQkXS?=
 =?us-ascii?Q?0CqTNOTdN/7Ael7FCAy/GLm5SgQu7ny3WsdAUr7R7LmvMM7KObBr93HphNSb?=
 =?us-ascii?Q?1vap6u62fyPcde3MaPHpjZqloC9IQKUx+SSDNoSe/lya1S2hmFP8P3IhC39e?=
 =?us-ascii?Q?y2xtZGQcNYCL66O8yFqfsgajtBrY5w7QXfwfTAuSQuXIhPL/DYhVxO4GVVeV?=
 =?us-ascii?Q?6zEEWdf55MXOxIkKuAz/HTge+AvMGYyEU9p6VWjwruSCuZAPQxGVp2bkSsDf?=
 =?us-ascii?Q?AtQ247/BUgaENWEoKeLSzrdlrpO1GTjQYECAHLaKGDBiBiQNUms9NhDJrPI+?=
 =?us-ascii?Q?DXx2VlMoW7I+yCeeS7d/eFoDgsazj44QELr906MpE1x59HVtWvfNeFTuTfUs?=
 =?us-ascii?Q?DwFXhHzIAOq7brVscofQCN9K9T3gQvHb2r9Ehg1A+uEy1Hn4y36anfHuQuHj?=
 =?us-ascii?Q?dcPKS2X3s5ySsr/yocmaidlx/tHQPKIaZkQs1tCx18ZLjQz1SYFKaR52OmUh?=
 =?us-ascii?Q?q8zEMmiPT82e0xh/wHXmZyqNWNXkFMuBJahZdCLWONAveqcAeY0EjkikGfO2?=
 =?us-ascii?Q?7/GbHV1AvHs31OH95zNNFrbBdrXt4N1h3HQEfFANOLefahFd/xhwB7dhyUDu?=
 =?us-ascii?Q?XOlcbOnz4BNmuZDOGRcs2JOePPIYa+LacNQ2gub7Qg+LNAwZc23Ok2xBHwiF?=
 =?us-ascii?Q?cUph7BjA1Kz/FSBN/6iZ/8yIwHjp9irQxmjIiAQxj8TEwlSAyGdgyFSvWxkx?=
 =?us-ascii?Q?L7HxLtK4+am7KPayx6uTRW4HfByda72Fs1cD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 13:55:17.3865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef33a9d-d45b-4541-8d59-08ddc9f08e71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398

This series fixes remote command checking and cleans up command
requirement calls across tests.

The first patch fixes require_cmd() incorrectly checking commands
locally even when remote=True was specified due to a missing host
parameter.

The second patch makes require_cmd() usage explicit about local/remote
requirements, avoiding unnecessary test failures and consolidating
duplicate calls.

Gal Pressman (2):
  selftests: drv-net: Fix remote command checking in require_cmd()
  selftests: drv-net: Make command requirements explicit

 tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py | 3 +--
 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py     | 2 +-
 tools/testing/selftests/drivers/net/hw/tso.py                | 2 +-
 tools/testing/selftests/drivers/net/lib/py/env.py            | 2 +-
 tools/testing/selftests/drivers/net/lib/py/load.py           | 2 +-
 tools/testing/selftests/drivers/net/ping.py                  | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.40.1


