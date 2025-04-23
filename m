Return-Path: <linux-kselftest+bounces-31425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0997A99411
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747741BC0EA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C62BF3EE;
	Wed, 23 Apr 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FBtwxawS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F926772C;
	Wed, 23 Apr 2025 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422554; cv=fail; b=Lj61S31CLVDcywkBD26Jg1lpiOTVqtn3wvK+kkriixhN/82HzAPG5+GK7/3y+YcdNMqEjs0Mb1antx362DfZ8WJd7Ijn7bqNImMq2967RwcKkCNfZU/Pd1odPuuPAVxoCt7rq3EtgbChWCEyM+338EZu3lVdWZ+PXeky5eMFPfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422554; c=relaxed/simple;
	bh=OafJ7131loMDRin2T4IAtVJBzggHZAvc0Nh9qKoF7fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GR5h4vmqgnVveuMp8MDN7qAYGUVo1P61MioABC1oZNk2mUykb0JXiGQ/+Wsh/5XEvnSu61V1PufRogvIjOYrZfSe9BtX85hWz/0QQO+uuNu6WmHMNkzDqRcIxj07ZBRBLI40aHWdLfZY5mi9ov6kL2I3Urx7f2lnJmL7CM6H5R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FBtwxawS; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksrGidl49vM1Y+9s98cDsUEvoJG9PHbEQ1AskEWmVFdwZ5puHRPvNtVAeM8jd6r/ikPK+xrj6mylPkiL0v8Bwwal/cqvojAKaYmI19iw54wdzYlXb4r06mE3ciOYWpeDsJdd8PiIylq0YecTiq7yvowaEd5i/XTH1GQMy6ExKNdq5vggaWBD62yMS/hdJNav9ssCk697IleT9Z/tAS47tdj4GK4DRZuU2Hc2uTXXN4CvkRGYEgrV9bTTSZ+8RpuPLUgVQR+ktwA03jF1IOTehI3Xp4gbnxkwbpynIIVK3Njdk5hE8QWD/zqyEofUeGDoGs29aiWQ3FcvNRGCRtvRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Uoa4J4Q26Vv2zK2ZuNwGAnSlcPd9GoYwOlYzdm+KM4=;
 b=ET3Z2QZ2YEZubD27FQKI1GS2dX7CfUGRWU5VbrG0aWcPEkrYCm8D6uNRrq6NccVgdPjvsVNSZCqJC/VVX9rzUhUYM0RnfcsbTLaXogELOmiN5IzAKjB3cYWpg3kLp8fMI/Rvdk6KfiipJcOIRHxkn6B46H79UMsReCNW7J3W7RAqkxFLfpIj/nRuOQHE2LTTv9hge2ph/ISpB4s7jUPbidesoHKqqyjJthIQZ6sPonfbTRwhMo0QilFyu73thPKKJx+U2KloazzeKyD33gA6+QdfOBgvX+x9lDjfABTxstaclaoQQM05yiSSsuWkIM1SyntH+4cMY2wxeAvXu77V9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Uoa4J4Q26Vv2zK2ZuNwGAnSlcPd9GoYwOlYzdm+KM4=;
 b=FBtwxawSchcNTzzR17XbTzjt4VEjQh+hwSEOM5ZROZLsssLkKCccG72qobPhBK6M/iQhi87+wrmS5qSdCd+UBc9xW0Uesbocf0RMH0ZCYP0iD9JgHT4sGhTmta09gZOE5fE3pnJfbmDE6LbuTe8TpnzU1p+EFMD4KsgMLx5xTE4WSm+OL5LLhVfTsXnpWJhCzJ1DTJc+Mt9lwEhNFb7X5UAJvrkGH4C3V7GGQS2bxR23RUkNZ2iQEdExZezQN1JzWQQa8PhKIg59nn5wk6IK5OEdeCrL6ixP+73uANoB8cw+j+Kg+A2XF+/wWF7bp0zjI652PCLO9XWOvWxvH2SPzQ==
Received: from BN9PR03CA0370.namprd03.prod.outlook.com (2603:10b6:408:f7::15)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 15:35:49 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::b0) by BN9PR03CA0370.outlook.office365.com
 (2603:10b6:408:f7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 15:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 15:35:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 08:35:31 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 08:35:27 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net 2/2] tests/ncdevmem: Fix double-free of queue array
Date: Wed, 23 Apr 2025 18:35:03 +0300
Message-ID: <20250423153504.1085434-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250423153504.1085434-1-cratiu@nvidia.com>
References: <20250423153504.1085434-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: edd41a9f-3334-4db3-0b96-08dd827c8626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTVwisBKEHV7StA7Wpx7qMAwdxgZp2vG8EunzHKPnPq2cKq2VtvjkhmjZZkj?=
 =?us-ascii?Q?ksa7CAXJ+pROuJle59LBVL3qwHuW4YGkf2kEEWma0JslrNyjnzjAZ3L2qTbS?=
 =?us-ascii?Q?LOBHXUJgoAxkfq3G+bkBVU2tHTzFkXxoBycILZoZmTV5wcHA7WbwtRMQ96nj?=
 =?us-ascii?Q?iUvFe3b8B7Ir4hy9kQZXwv2QRwY4LfSmR0Pq32ShhYFlubtY4uFB/oxu9FdE?=
 =?us-ascii?Q?ozEuZ3+mXxcaNN8GFEi8RA5ydeYc+G/tLajbDYmmjEjWHNeFlshiNgif26vf?=
 =?us-ascii?Q?T+eRMRpt9lmG3RB2eYX7gKyBs4Zc7axcYKwGm0skzXPUXWCpj3NfBH9ic07z?=
 =?us-ascii?Q?1vjnSdpbKrehR/VzPzm7YNDe3Wyuoq0+3PsLIcfV1GP8hgEWChdQ1X9KdzlJ?=
 =?us-ascii?Q?Z1DRw9ziZ4bV8xm0ak+eEay1+KxWsyhquAJ6eno+OxZz/9it0awwDU+7ns6X?=
 =?us-ascii?Q?I7ShwI5mKznjqGvFBjvtAsWxoNXv/XrcDi2Ve4yNe5frziLOFpuxwMdeYHwb?=
 =?us-ascii?Q?BIiOHoMKF1mut+tWvjzyikiwKFs74yNnR96RKkR32S3Olvcbn5gu97elvPiK?=
 =?us-ascii?Q?4/2KaCDMuAI3bQn4wQAPjvRC88xUWXkopUJrtacYF4XvyMMwbLb+EvFk5FWR?=
 =?us-ascii?Q?bCXFVlgcYAa1E9lFvtPSRiDr8y8Pzj1YJDgB6JpI5WvqOeHT/rDBin8com2q?=
 =?us-ascii?Q?vuASFCOHSPX9WZprD7LgtsGsAI4MDxIskzdvU8kW7Ih0i8btyfBYA9LJNDiN?=
 =?us-ascii?Q?rAvgrEbp+GM2BK5QWpxo06xNoXpu0LyrpUU59UsuYtMyXPmj7kxsk3Mvo+5/?=
 =?us-ascii?Q?hP9AcWYIx40KE7gW8Qu/fEn6+1x81ZWwnaI98YpgF3oHvhrG91ln9hXEh62Z?=
 =?us-ascii?Q?TjXn6wN2jpN5be0IAQWj+Nwrx2LYveS25NrYg11VoFF7Kx1FMryWa4dIaSdy?=
 =?us-ascii?Q?9oDphR9zLy1CqUzaHhGqYcA5Gj//qqjk9aIgZfuULu/ligv7Y0ZRArm7tWY5?=
 =?us-ascii?Q?TDtm3PjiCzD8QK7tAeo59cJd/HwrLh3ghsm4DVvFAdJuo0zf2VP996tjX/Ly?=
 =?us-ascii?Q?ueQPWkerjKuCdjxYixmX6JnZBJkS98BkdlcNJ6JoTKXzrqdqc4h1O5PuBH9a?=
 =?us-ascii?Q?WR7xov/ePlISCvMr3S91wj6BEyzclTYJGRIYalivZWe5EBkRGvnA8m/auCwN?=
 =?us-ascii?Q?NRb+N4vTNviB7u5mb9AoLZxb9DB62HCn6TdYTBziOVBAEjkpn8LpspYVF9fo?=
 =?us-ascii?Q?vOAIw2Xfo9WIse1Z8xHkhbStOiRsrCv2T6LsP7AC8Ic4bxoAFzS5OMWGkZzX?=
 =?us-ascii?Q?oEXz4ZZJyZyL4Xrxio2eyN7ggSEgxzCjU7aGFP1hj8ziMLEVkwk3/l0hVB2T?=
 =?us-ascii?Q?P05CU1l8Phq3oQV1jOEy2lmnJO7o3DwWILhEhXxqdT+7P55gBItF2rm/pVLf?=
 =?us-ascii?Q?qSgdIJ3f3ShDbiP1WFhv15CVpB5sNvtNeYazkIvKk/x5iNeka6B6UXkx4e65?=
 =?us-ascii?Q?ipmeCIp6m3tndyBGSkH+/s4Ap4YkWILHRpg8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 15:35:49.2794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd41a9f-3334-4db3-0b96-08dd827c8626
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

netdev_bind_rx takes ownership of the queue array passed as parameter
and frees it, so a queue array buffer cannot be reused across multiple
netdev_bind_rx calls.

This commit fixes that by always passing in a newly created queue array
to all netdev_bind_rx calls in ncdevmem.

Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 55 ++++++++-----------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 2bf14ac2b8c6..9d48004ff1a1 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -431,6 +431,22 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
 	return 0;
 }
 
+static struct netdev_queue_id *create_queues(void)
+{
+	struct netdev_queue_id *queues;
+	size_t i = 0;
+
+	queues = calloc(num_queues, sizeof(*queues));
+	for (i = 0; i < num_queues; i++) {
+		queues[i]._present.type = 1;
+		queues[i]._present.id = 1;
+		queues[i].type = NETDEV_QUEUE_TYPE_RX;
+		queues[i].id = start_queue + i;
+	}
+
+	return queues;
+}
+
 int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
@@ -448,7 +464,6 @@ int do_server(struct memory_buffer *mem)
 	char buffer[256];
 	int socket_fd;
 	int client_fd;
-	size_t i = 0;
 	int ret;
 
 	ret = parse_address(server_ip, atoi(port), &server_sin);
@@ -471,16 +486,7 @@ int do_server(struct memory_buffer *mem)
 
 	sleep(1);
 
-	queues = malloc(sizeof(*queues) * num_queues);
-
-	for (i = 0; i < num_queues; i++) {
-		queues[i]._present.type = 1;
-		queues[i]._present.id = 1;
-		queues[i].type = NETDEV_QUEUE_TYPE_RX;
-		queues[i].id = start_queue + i;
-	}
-
-	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
+	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys))
 		error(1, 0, "Failed to bind\n");
 
 	tmp_mem = malloc(mem->size);
@@ -545,7 +551,6 @@ int do_server(struct memory_buffer *mem)
 			goto cleanup;
 		}
 
-		i++;
 		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
 			if (cm->cmsg_level != SOL_SOCKET ||
 			    (cm->cmsg_type != SCM_DEVMEM_DMABUF &&
@@ -630,10 +635,8 @@ int do_server(struct memory_buffer *mem)
 
 void run_devmem_tests(void)
 {
-	struct netdev_queue_id *queues;
 	struct memory_buffer *mem;
 	struct ynl_sock *ys;
-	size_t i = 0;
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
 
@@ -641,38 +644,24 @@ void run_devmem_tests(void)
 	if (configure_rss())
 		error(1, 0, "rss error\n");
 
-	queues = calloc(num_queues, sizeof(*queues));
-
 	if (configure_headersplit(1))
 		error(1, 0, "Failed to configure header split\n");
 
-	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
+	if (!bind_rx_queue(ifindex, mem->fd,
+			   calloc(num_queues, sizeof(struct netdev_queue_id)),
+			   num_queues, &ys))
 		error(1, 0, "Binding empty queues array should have failed\n");
 
-	for (i = 0; i < num_queues; i++) {
-		queues[i]._present.type = 1;
-		queues[i]._present.id = 1;
-		queues[i].type = NETDEV_QUEUE_TYPE_RX;
-		queues[i].id = start_queue + i;
-	}
-
 	if (configure_headersplit(0))
 		error(1, 0, "Failed to configure header split\n");
 
-	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
+	if (!bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys))
 		error(1, 0, "Configure dmabuf with header split off should have failed\n");
 
 	if (configure_headersplit(1))
 		error(1, 0, "Failed to configure header split\n");
 
-	for (i = 0; i < num_queues; i++) {
-		queues[i]._present.type = 1;
-		queues[i]._present.id = 1;
-		queues[i].type = NETDEV_QUEUE_TYPE_RX;
-		queues[i].id = start_queue + i;
-	}
-
-	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
+	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys))
 		error(1, 0, "Failed to bind\n");
 
 	/* Deactivating a bound queue should not be legal */
-- 
2.45.0


