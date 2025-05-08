Return-Path: <linux-kselftest+bounces-32653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FE9AAF5F2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 10:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0446A464FC2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCD720F089;
	Thu,  8 May 2025 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0+k2Suq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E471CB31D;
	Thu,  8 May 2025 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693924; cv=fail; b=YlX4++WpNMxLwH+1UksTbG3xSofOzciJZzX7qVYpv4zNr4VK2RUsOHJynYoKvNbGkVPOzKrpWlJZf7kY9YbOd2EHboBUPJgjzDnRCWpet45ZoMkwD2yu/adQExgAI283PetkMYP2oDpjmN/KgPBjR1juzRPb73B4fAuxnY9aq+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693924; c=relaxed/simple;
	bh=OafJ7131loMDRin2T4IAtVJBzggHZAvc0Nh9qKoF7fE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u/0PvAJOtDBBsM7dzM3vNRG8w4J2D2vtuo0AXMCixsXM8XeSIHUR3BJTeIXjlO7y0d36PKz3rVcFvrGnPAuvxDLCNxEQt+EyM04D1xU2bKr1NcynMGsXDWsUNMBffIG3UeAt/N/1Vb05KI25b9gOdTnIaoHafad3ORFYaqSBsnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p0+k2Suq; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J49opGJs0IOWNhKtPhC76MChcrqpO2+qNMfjlkCn5tGi/bpHItLKiypvcxHOuKSZDkc3TYUS8cRcKmqCNWh+01p2UG+dyvkE9mHgn3B7NymtbUFYOm7rD2qVM57MpvwTC/nL1oO4r9vufBbh1ROGzKBOccxRoZKv/ws4oa2TFQ0M++20WBxBJEmMl5w2MEUSPs1p+wQabfP9tVlOQshijJyc5it4lijTm7rfeVH0lg+A2Wg0Ne9hKqfW+REZSs1QOcRoKWJltwcqzdpNgy1JRet67XjjYDD7uApzymWapGw6tI4t8LxUpvXtsz97H6/J21WeaUhALN9Y+bB3n7A9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Uoa4J4Q26Vv2zK2ZuNwGAnSlcPd9GoYwOlYzdm+KM4=;
 b=Lrd3GQnjCB4TAFdn7DttM992BeyMuqfICe8f9Ehji05IX8GqNuJDU/H+vLdQ308tRRuzBBgWE5+GxNV093njK8zPZDBDCwM6OShculvDrEovfbFdu/+6f45hMhxRDJGr05gxHCW4YKshiK/9qFfp/3IXDGyRje0QAsjhQw1qY/+nuWmlBNAC4ZKuligz86Aua2DGfHRTpnF24lRYF6SvzQ0Ip6B7qf7ktqbftLVgV4Rq7QmrcQiXqp3uWoXfHkcT7lGjJO1u3ET3OMuPPtcm7Srqikx89CMsW/wnrdj+qV3/nKQayevHDOJWHRDUIkEK/7To6Ojlfgf0V6ol+/DjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Uoa4J4Q26Vv2zK2ZuNwGAnSlcPd9GoYwOlYzdm+KM4=;
 b=p0+k2SuqS7M3vuKUD3IFoN+uQ7lZeapUMaokVzJN79yMkmUTPm/XuMqdSteHK0VOONFtXYGH38A8ccnrHTZd8SegV9GVYyh+gbxaI2mCUmmcemrQ9QAi0J8PKG2Ugl3M5xO2RGqlIiVxRpTMtAaEZ8XY0Gbo15zZhKKgmnTXdj7P/kYbOR7xpns+naTsSWXxEgtYLViwJkuh7AIUxmEkpvm9tiEzYkDT/j2nBV1hJFir2urOSFyysU9a8o57Y4jKsoVvwrYnomfNwyTD5xe054EP6TGOG3dKMFo4p+0uiB7dUkIQ1SG7fC7NFG4Lo7B5bBoPaZ6WxI3NbEfocflAvQ==
Received: from MN2PR08CA0015.namprd08.prod.outlook.com (2603:10b6:208:239::20)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Thu, 8 May
 2025 08:45:18 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::87) by MN2PR08CA0015.outlook.office365.com
 (2603:10b6:208:239::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Thu,
 8 May 2025 08:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 08:45:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 01:45:00 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 01:44:56 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, Joe Damato
	<jdamato@fastly.com>, Shuah Khan <shuah@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
Date: Thu, 8 May 2025 11:44:34 +0300
Message-ID: <20250508084434.1933069-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 14dad2dd-179a-4422-eb6a-08dd8e0ca8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kl41C6Vkz4EirBYxR86lFUdukPptzxYRryGTns7NuYn9bH8MTgpbMJJqwnoa?=
 =?us-ascii?Q?7pn+FSBvw7rXX1rzzyeXMG0jsk3IaqvGObTUiLkqx5+1DnBEWGXJ+zld0SlV?=
 =?us-ascii?Q?R8d36n3b1GQByH3eCTHwOMraq9LcskvurHiBL8IbRmV/GEMPQuuDSYSj1G54?=
 =?us-ascii?Q?l12oek1VZVjTpNzUQuBP+M7CFV7RTl0OC9RcKmJfGf9WWD/EDmwFD2sIKdxj?=
 =?us-ascii?Q?AKyfJZX12lgvc0w+LEJbjET4CaEU9q1bOeNGzn2hCem6d6Woa9Eu8fWgYQyK?=
 =?us-ascii?Q?OaiVmPMYiH2pTNyHBdlWYcnea03WDQAcBaePlJCOSN9V5dbXzL6dSWPXfa5h?=
 =?us-ascii?Q?AHSwUqbzfNV39o6akDclvR1BMgjOSh6RTTjLsZaO6UkBXZGSDUrpqPpl744f?=
 =?us-ascii?Q?u1vnWN083nELcp0cc9E22bJ/DZi6SHOL16q0ZDbDh41cXqa0RVJQu4qKDP1q?=
 =?us-ascii?Q?Alw17Eba/bNlHwYM+n2RAujI6hwWAcGf7HoVp6OB9coiiIVsswzi+Hwvc8za?=
 =?us-ascii?Q?p7v2W8yTjaFkJyZ8Vv7FlNvuXl6xP/kXXtcGaFneHswc3z7LIANkplu7+xzR?=
 =?us-ascii?Q?HPoHDMt5nJmcAo28j6qjbxfUngH+TmHfnGgNtP7LmHECN+F8X0rjiF4N078O?=
 =?us-ascii?Q?ihubUoBwFYbAoBADXLm2oj9sQ98JHTrSxpMqVrd3lDid7CLyRaltyQYm5KnN?=
 =?us-ascii?Q?P8ck9WUZozUFOFkFKQqmk5gkkrGvf430J+frKTOUpWFDhvJOv+FnL/93lqtV?=
 =?us-ascii?Q?Pg85MeN0ZoDfLwzZlrKJvPuRKuIAHEj1RkT5vbWpXKYabCIHPfqc81KUml68?=
 =?us-ascii?Q?TSB8jX8VfNDMozrLJjuRgciILASfAtC1HRSPC+szcn1VjAKLQjwMiHOrgMI6?=
 =?us-ascii?Q?OsQ+MBMcj4ZduIrKmE79yrLw6DsMiZajUr9ynJEWKHqf0IwtYPkbdCjAlrol?=
 =?us-ascii?Q?5koWeocyoaWTggjtnHibllARl33yDOc7+l/SKiBVmZI6RbJaLCrXJ3qEjQ7i?=
 =?us-ascii?Q?8L7ysvv1tt7vg7O7dvTHquEeADRi3wmeuK73uTVQNs8mpgs9OP7uvtHQOH4D?=
 =?us-ascii?Q?saUmcRXJPd2vT4HIXvtzrXt3IDMLIKM8Upnc9CvqqVsA8NCjM9JcDN5KrsKz?=
 =?us-ascii?Q?p+SZHzKu7ZtNRYqON72NI08Nv1NFJFA+YAkCyzEiQWeZWCVOcv7h5vZifjgW?=
 =?us-ascii?Q?bYp2XRhS/nwzQQmSfX386NRbO4mumvvFYlwVQFCBSNg4e1g0aZYlVdqdROcU?=
 =?us-ascii?Q?5gg7ySIxIfrww0L3PSaO9BrCBzwbTB2uESGqtUo9wdsX0AyjXdQmtdNe5yTe?=
 =?us-ascii?Q?aOMA0IR3kaykEEjhgt4TLVtsZYfwJ+NJEwYcCvIBoYMOyuzXW5mQum8hsPhD?=
 =?us-ascii?Q?nH5vepyCiYvy/iN4HptZPC1mTeQsUjIHGlK49ME5JrJwlm/g63o9uSYu+S3I?=
 =?us-ascii?Q?IJ4d9+ZuB1LqLUDvODXo0GuSHlYzWJRw95Zlrx5xn2lLxX/CA661uZqWUChc?=
 =?us-ascii?Q?Iywafb5pwNRJLvlY9Y5dhl4X4XEsp48mgd2r?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 08:45:17.9474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dad2dd-179a-4422-eb6a-08dd8e0ca8ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074

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


