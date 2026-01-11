Return-Path: <linux-kselftest+bounces-48685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D11D0F80B
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 18:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A521E3001184
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A533CEAC;
	Sun, 11 Jan 2026 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="idQZsNAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312C824A3;
	Sun, 11 Jan 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151831; cv=fail; b=Y8tDGLR/VkOJmbnjeYGkXXSjOXQULRq9MGV2eeic07akNPb9xxYlUo0C0j0KzJxVxmAUzsnSyjQ07Muz0vMglIzf4nVHlTKIJtnybCqRzMED2tsfkgGRsvKuhI5vdWzKLRzvdEvc5Dg1s01IQmEwpyVVcyz5TJFxfujunVDcJDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151831; c=relaxed/simple;
	bh=XVmF0ojEyBcxqLwH69SEmiS9lBd5PCHGPX+N0abDoZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mojv0UBrwXTtRl3ux/zcSXBkXnUT/uQkSrF7oZmv4ucc4cLmdd4CB5Yo32pbG+p1Pf12+geRB0pJ4zgXxlsU9Wn2JKuKKmxQQuFaIUqk+2RGAVKJHCPR4sjcDTgxL6BYbVOGGDm/tJqKN/X462ZB4EA/wg8xjhYD0OReBZ4Rhyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=idQZsNAT; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtz4zJdE9eLgtvblNVEeGQfC2IwR3l63hyTs7QJOCHckgvW9tcveCHwgaP+0GmHG7R5UrxkMzJYFlN1BVJ6DSgoG5G/qtWIgiaFOWngKuMYgu1wNxdOFC7r/ehyDuJ2FDBBqr86x+JHk8UdjQ7mZIPfzjPrQSZ4R0TnWgoVQDezeZB4MwAuDQuJ/tAhBPXjCKv+wGUCEjM876aXhDnt+IxRRosHZsZ7VYK8ov9BtOdOjMMgnnwoZY3/zzhqPA0mhdfxVEH8bFCIR2t828/0NR6qFjRm9DcF1u++P9BjtUGQVGE/q3/Rt10jskN71Ik48BYEjttt/cXqCN4uu+CQZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0POEgEEbCOJEqsdzJ+ytWmwpyzk7Xn3hKkmJ2IHSDU=;
 b=J7aG4DRMe51cXUqoMIWs4M78iOcsRy9HuGnQbEJoYBtUgQnr9Sfx1fOqz19drXxuWzv4BfgDUfAz7POSJlx9IrDROHfab8fWD9MsP3APeZx/YcETN/sroaYrzZGVUlJTIreo1ocyHOucQpad9sVMfAsGlvPZUos7zE6dfa1dSqStyv485y6Gi6WhkfdUUgCSbqGT9HObuQX7mP7KDgACPjYSgSMqiF8WkhGJe7PfM8iGdnBYaALM9OM1r0WflJcUlS17G+n2edh6yjPIgmlBSPd5ttpxXYLhpM+/z8qUqpbvKjBPDI2GzN230LMrkNKDxwpM7ztCJteX0Flg7gctxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0POEgEEbCOJEqsdzJ+ytWmwpyzk7Xn3hKkmJ2IHSDU=;
 b=idQZsNATVdBxNgLjY+xr+qvmX0tIxmfCtrKioNY9sTxYsAZqaCLDnBWrydaXrecRg3BPmOsIKB6DitDvv5D2Xll/rFnRRmgn6g4KyTWrR3uht7j3lB4KpdzYa72x1BYKUyZnvLQt3RwPj985IAkqyOGKSsLHHHVudqzh0R4y14PoAyP9gp+0j0ujV3AeA6X5mvEI8yhAsWsStf96eEBnUPOQh08Imxs7qRcUR14j0OXQcv4TvGV9CU/dJhH9dAcmJyNl15Pfq53mr0UJqTtDE5BeyAXa1CRdelSGWQmUtFp5BW9UqAQEfDyXpY1QGeIoFtOv1HG8VrVzJOKwoGjAmg==
Received: from BYAPR11CA0069.namprd11.prod.outlook.com (2603:10b6:a03:80::46)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 17:17:06 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::d6) by BYAPR11CA0069.outlook.office365.com
 (2603:10b6:a03:80::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 17:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 17:17:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 09:17:03 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 11 Jan 2026 09:17:03 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 11 Jan 2026 09:17:00 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	"Petr Machata" <petrm@nvidia.com>, Coco Li <lixiaoyan@google.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 0/2] selftests: Couple of fixes in Toeplitz RPS cases
Date: Sun, 11 Jan 2026 19:16:56 +0200
Message-ID: <20260111171658.179286-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: db3c7a6d-a4db-4854-8ae1-08de51353e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ai+2XhAT97hvyWhFqe0wcKc+D3JaXrbFNktPbw3drkUONEQKiVIO8VHHs1FI?=
 =?us-ascii?Q?rUq1KUk9gwv60W3qEVj7SOfleYNNsZcNEw4hxInHLJwmNhplkilKDu05MQIt?=
 =?us-ascii?Q?yrphMBDa84osWEbj7Leq3zmWukOXOvi8QQf/iW2Npy8loZrqar+BzN12N+3N?=
 =?us-ascii?Q?G055qOjooJafTuXHikkomgUn6GbYYyCTaw7cRmE574ZdDXcmnPTQMv2m6CuO?=
 =?us-ascii?Q?Fl2OOWd2JhbKUiI/1H4CEOCU9vu10kA57WIvhVmxYPPFN336ryewuPozSqDp?=
 =?us-ascii?Q?WWcdcpCG9xMRFIkigdbjftgpPQT60LRT6F4WlcMo8KTkSH4yQRUoRUplR4LY?=
 =?us-ascii?Q?eZJdUWEQkWYBsYbGfzi7B+w/IlsWXJ0hv2WmEmn+sCr/3kbuiBuJXfTzjhU1?=
 =?us-ascii?Q?DoflK8SAZUO5JHnVD8/RasmrOG8Zr1fm+A26RBiLWS+fwBKfgx/3y8Q1kpjR?=
 =?us-ascii?Q?Em3HimLFzK4CFBMGaX8Le6TKQqp63N40g84mpumATMqqRjA0s2TZU0J47tfO?=
 =?us-ascii?Q?YzftCV4SasWv5xbbn0gYPYfLMTc820Wx/FawiJAegTqzXfdBcCQQHF+DLzuJ?=
 =?us-ascii?Q?mEZdnxJrAwZDzZ6nDs90FGHDb+ZK9jRTrC4cqPMkCtdmjPpPe8hxeBOZxG9v?=
 =?us-ascii?Q?QhPkCfILktV9DC07IR3Bl3zMRgpDVsHbxwqLLWVde1D8OdJY0XGAyNERSWUM?=
 =?us-ascii?Q?KW2mYg9Aw/64Cn9DTELJW+yKN/yJOsY0mxFc1RL0E0vPnd83E6urJouur4Ra?=
 =?us-ascii?Q?VGDmYtpiPbDSJ/smGdUjB8nSsQzSrr8+yjmR+2FotEdcH33p9AnGW9sgTJ7F?=
 =?us-ascii?Q?6+Nw2/IzT9dss4O7MC3dQ3DZSMSyBf0LFpp0iZySUrHLVJ5fHJJumw1j/c+t?=
 =?us-ascii?Q?9tCy3rAkJ61EaCUUwKfCbR0aYKyC87RruTNZ8OcjUTAYqWo+Gj93J1FRWwxs?=
 =?us-ascii?Q?wcRmtCfEy+OobGxUftbjS3eicqmOmTlwBYgsCVqG27gALd2wMVvOHPWgKJJz?=
 =?us-ascii?Q?TFc1/sdEJesDp5cmomArphpRdC0RCfspQ1iM7Q7u4lOI6PBVoBD2x9RkUOO0?=
 =?us-ascii?Q?LRPPhBa7PiCW/M/4kJszauwYZGTXX47BM45hr8Dm0MWnN116wQmGX/L8M+lS?=
 =?us-ascii?Q?NSzzOX72PrckWM6fUJ11uMw43f4t4gcuzDi2NuJ+NyFdfCLtaTCSg3zEPbm1?=
 =?us-ascii?Q?/7TaBf28O+QeZBCMd1CWhCUd7HhZrvfBg5+x1156DuTtY8aq9/U9o9eLPzVp?=
 =?us-ascii?Q?dkXBUGBUQOcOvbJS9H9hYceo72VrFnTEViFsVv2EfmRRRXjSMPi4QXqCk8gd?=
 =?us-ascii?Q?bhhXCo3cYGl/tIjSU/Eo7UhkL/JrYmzFHsraRE9HWJhB/AviJEPPauUfXgiU?=
 =?us-ascii?Q?gqXr3U7R7+wkhE9vfE7YI9bQSqZtCRIvj0Erb/toGLSkORAxmqnfvFA/o1Om?=
 =?us-ascii?Q?BnjMD/UN8GmAiQ+uHhCoNE2InvBp9OOmI7lU+xwcVjiJvbdjp35pieUnqe9m?=
 =?us-ascii?Q?DiJ3ZQ9rN5d2bp+5wk93oBI+JZ7U4X73hPU9ZadBl4tCLpBQTKfxO37XqEWg?=
 =?us-ascii?Q?OoaT542Px3vCsY6h6u0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 17:17:05.4261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3c7a6d-a4db-4854-8ae1-08de51353e5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188

Fix a couple of bugs in the RPS cases of the Toeplitz selftest.

Gal Pressman (2):
  selftests: drv-net: fix RPS mask handling in toeplitz test
  selftests: drv-net: fix RPS mask handling for high CPU numbers

 tools/testing/selftests/drivers/net/hw/toeplitz.c  | 4 ++--
 tools/testing/selftests/drivers/net/hw/toeplitz.py | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.40.1


