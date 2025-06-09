Return-Path: <linux-kselftest+bounces-34463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C43D9AD1CCF
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 14:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F953188CC2E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9095255F5C;
	Mon,  9 Jun 2025 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pHp3CcSK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F6254B14;
	Mon,  9 Jun 2025 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749470572; cv=fail; b=d997yWerJ+Kk7YFdRWgM3fE7R1jPATpQXkt2rUjCWm+aKbxKrLkvwfrPb27lRzLLSou8g5y0okaEG/s4hHtgf4dLHbIgiwWEUJZ53PxH6PDb+Vp98QzHr9bIGvfhMxAjOX4DP1IMSEaahDpTAwOI3i7/mVDUVPdV59CiV63gGaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749470572; c=relaxed/simple;
	bh=Rl3TpWzTFvAY9W6I0a9TldXhS2HYk3Byj6S8PJkTORw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8zUn3HjC73o1+loiyPBL6tuQn7ma8paLixEdyGdjYfQYPe100OJF/SXeT2wQG39UATn+r6EUqv6QZiSN3JURqJHrj8Dp2YCiyke64VHMT0GmikCTGk4Ra/Qf6vVykNlRIVq57FNLHKvPZPhJKQlg26JwriW9JstZfbX4ke3Q+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pHp3CcSK; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNIQbAwPrAqe009V1cw4iUpduGOr1N6w0zDEx0eM92zJwkPqix8NVrkAKZirvIobpEf0J/zy+rTdtkOCw841xBxwYzjTHlJs3EcrVI+blv8A8LrKNYprXoJ6WltP8Sb93TUSmnZ+vhS87ZJ65pB0/A6MRSZiVV3WOakOpk0fpgLoVYJgjegLg0pyUs3GmR7kWEDpBxjgDECWEqWbmyq40om+vQJt80aeEE5bmjjomWnY1krnXU/zyGgCaUvGHxlk2qBuAWwbS//DeLwmgIiOe4723QP0o2hwUOe0KvD6w4cTiDuOsSo6eyFxGShg8C9zrB9nUOI8C6k/oWU5Ec8lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePtbgncqC9qvJEWEdjRTzU+kmPPh8wbusKDf8m3nP6A=;
 b=y76O70UNqqHwGSIsUUM/0MtCv7fkj734OJZWRlFqA7BPBv7wJbEsLQ3n13ogDXTyAM2SkaYGteOstNaoCCLUuFrViYlGSfxXeNP+RH0GMk93rhG+LcBtam+1/xUR0ulitL1FFYDNWAI4mmj3grjg7LITFkVAJJ/PpAGk79QgXIC2splJD9aYt+O+pI5a4bAr1/mdY20nAMj59z+3vITlUsKJb3Il1wSBHHnGexAfFBqQNSk9sAvCYjjv4YTR81Z4YPhOIe07iDukCYXcInbK/iD9uk0S60PaUNwmlzxoTQfmXnn3g6rOSIJ2sQ+6viXyQ+GhWAXto38+0ioorEW+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePtbgncqC9qvJEWEdjRTzU+kmPPh8wbusKDf8m3nP6A=;
 b=pHp3CcSKXBgcgWuljmbv1qiyxaRM6PIg1V6skTxHOk0eLvFBl+LvbE9G2nIiNjwOoHYBujVFkZ9gxU4qDJcNIWZwmOxkQwFs2cls+dNSpXP5wL2xU9ySS5yUvgZjgsJ/fgzKdjLQs0/+c8L0MNBsd+P53BGmmJ3D7DE7oZoihNOQz7Y0ljjo2zEwcgIJBCqNa3q+e/+4mHlkI9DFXO8AUuRwg0wExtEyiccWSGN6BaPuPNfQoy6WTQ6srwBUMuerHFLi6DXZMf5AHzCAlijNeO1q8POa7C1w7WlYv+E9xjWbuqrdFCyOveIKxKPEmo6mMrDceOKNTy87ZDwrXuM11Q==
Received: from CH2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:610:50::16)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 12:02:48 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::43) by CH2PR16CA0006.outlook.office365.com
 (2603:10b6:610:50::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.22 via Frontend Transport; Mon,
 9 Jun 2025 12:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 12:02:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 05:02:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 05:02:36 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 05:02:32 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net v2 1/2] net: ethtool: Don't check if RSS context exists in case of context 0
Date: Mon, 9 Jun 2025 15:02:49 +0300
Message-ID: <20250609120250.1630125-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250609120250.1630125-1-gal@nvidia.com>
References: <20250609120250.1630125-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae45b65-4adc-40bb-e6d3-08dda74d8d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aHTOMIrGsWQHAN3mGcK2O8jaSK6M1u7tJMBKyXovmaJXNO8A3l9vZ7arV/O6?=
 =?us-ascii?Q?iNPtlnAX+qNAblGT1fy7gqYcb5P/ahhhgvJ+ThuN8dgjz2e8ehEG1QeITada?=
 =?us-ascii?Q?duwrp6jTJ3xsdHaPPAulUcnNy6KMuEW6h1EPPKVd10VMzDWpZinJbGaEd1b6?=
 =?us-ascii?Q?noM7xBrLkGLopJK/2in7A66ssQJcY/TFGfnEIhpF7NTFpXNEx8uOXDFdBxFG?=
 =?us-ascii?Q?c5bC0ga1VrpdRB9lcNMg8aXqyZD9J+Cl3pj3mO6jUpi0Kxy/pKxq5gKhu4Ta?=
 =?us-ascii?Q?CadztLyXrhp/WslhepyEgD+kX5LwhidewkbYXw8duifDXqvNoe0B9JXAEA9i?=
 =?us-ascii?Q?cBsxQ+kvQQFiN53aDk1TGE6BTD0s4cjSM6o0y5JpFOz/YvtVORY+UhAZJ8VC?=
 =?us-ascii?Q?YBQd9ZXXtrCGaecufcIcQapYOCyc//r9IhobOZZWZZ2NX3YQ7txzjpvHVrai?=
 =?us-ascii?Q?mGEZTSnuBYoCkC9c6/mmycAEw+vaVrZgq6eeWWTbzVmHs8I7oaRCNAyoWe2S?=
 =?us-ascii?Q?ezFgLKKUvyLKH1MVSUu61dItZxFPK3rtuXUF3/G2BxuxZhtcDt8ndatoqCpY?=
 =?us-ascii?Q?AYNp/vUe46aacQwptX/iVcBzXASvYwxHT5X6fojz8Y5dc+NB4Y48EbnOQ1s5?=
 =?us-ascii?Q?3E4xyS9k4nHq6bvXw3RViUTSA8Xb8D64OeYhGFLa4a4KMHMIFPD3oxIHmL1r?=
 =?us-ascii?Q?+xrIlnGaahsolLBwUzCvyzeSr2JWr7GovdDhHPc5voxlDN6fbj2tNf2yzOSf?=
 =?us-ascii?Q?SZAUTT2mn+L+ZcobI4ZMOt/mxrVaY7Ta7e8VxoMiaR+UR6bdva7YnEq1o7Yf?=
 =?us-ascii?Q?j85yIwoEVVEpFJzm0rVexC+r0qCK+OVyxKy8quXBBtA7AzvBWOPgggfSEsdY?=
 =?us-ascii?Q?ZREeWoBE/ObGBxKzhZnaZsH3rMJz6Os4F11Hohx19pGY4Z7IXS7OrkzrFeCT?=
 =?us-ascii?Q?i8SZO1nnPqeA3Syci9JFg4txmnilWhunh6TalkQDM7mwHen6uOqa/sP6LL9i?=
 =?us-ascii?Q?Z+SJ/SqdixY7i017yb1T5d+Ocr/B3HpT9k5ak6L2pbaQ7tpxp3DrI+bT3ibA?=
 =?us-ascii?Q?CgwKPkJWIyN351Jcqyu8I1tXsqN3/2+S4mZhT5BFmIm8qYMkLwoi13L9SOyB?=
 =?us-ascii?Q?49iQ/BbA/TS0bAu7ekfeeBV/xs9WNkItxlL+AQZlcz5Jiw9jz4iMLgp3VvZ0?=
 =?us-ascii?Q?W2yw+5EG21BUdYAngkjLJNT4wybsC7ABLtbMnkoFH7+ZMd3EwhMzYApirDyt?=
 =?us-ascii?Q?0HW08bghZAQJg3fR23kuIrTU4Tazy+ligqUFxGcuJT0cvIjN9CDcUMcI38Gz?=
 =?us-ascii?Q?N7m2khYFHDbPhJj+D4DHTQbCkQMx7ahZHMmczVT79c758RKPtCeB0hoNX9xR?=
 =?us-ascii?Q?nNIsv0mkFOpTwMrZiCBwXPzM91/TfltkhQziLM0SOVq6GQPRuKzU5icBUsin?=
 =?us-ascii?Q?kx6AL3YF8lbkawK1x9uowZrOQx51v1WoAQpoKAfgLevIKRFSJ8xt2999z4EX?=
 =?us-ascii?Q?6mrY1WVEftTeeMOnWe/xrRe7czecji0zgL9x?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:02:47.8554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae45b65-4adc-40bb-e6d3-08dda74d8d37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620

Context 0 (default context) always exists, there is no need to check
whether it exists or not when adding a flow steering rule.

The existing check fails when creating a flow steering rule for context
0 as it is not stored in the rss_ctx xarray.

For example:
$ ethtool --config-ntuple eth2 flow-type tcp4 dst-ip 194.237.147.23 dst-port 19983 context 0 loc 618
rmgr: Cannot insert RX class rule: Invalid argument
Cannot insert classification rule

An example usecase for this could be:
- A high-priority rule (loc 0) directing specific port traffic to
  context 0.
- A low-priority rule (loc 1) directing all other TCP traffic to context
  1.

Fixes: de7f7582dff2 ("net: ethtool: prevent flow steering to RSS contexts which don't exist")
Cc: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
---
 net/ethtool/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 39ec920f5de7..71c828d0bf31 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1083,7 +1083,8 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
 			return -EINVAL;
 
-		if (!xa_load(&dev->ethtool->rss_ctx, info.rss_context))
+		if (info.rss_context &&
+		    !xa_load(&dev->ethtool->rss_ctx, info.rss_context))
 			return -EINVAL;
 	}
 
-- 
2.40.1


