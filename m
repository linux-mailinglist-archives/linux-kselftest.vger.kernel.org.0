Return-Path: <linux-kselftest+bounces-10890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFE18D42DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 03:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057E0B21C1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 01:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FB1134B1;
	Thu, 30 May 2024 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q+mgIIVX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E414A8E;
	Thu, 30 May 2024 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032471; cv=fail; b=XcKnyE+GeEAHX1goiEs3EiMv3S794agDmpkp2Ux81R2NjsFOPhMgIK5FP74479NT8EEpvU269WbG2fv+xG2Y9iXUVn19gEfmhmXQFKhgEtS0sz2XzgnE0JYqA5M96LDwP8LAOBSbcwEFFr8ETRj02ZGZTYqPqGxxe0T1viRuMrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032471; c=relaxed/simple;
	bh=MrBAOBJblcK8qcVCIzUqqRLaoZJZzQJQ5B2820quZPA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GWg79o3OoEE/uHiwHmR5DVmeC/0C+1oSsQhzNBoCcdJFFxgR7Ej4xI8LYDmdQSmR7pAXHt3yp7hrpjLIk73LSRgBR8m8YHN68nGmk4DdQs/Rtg+r2zpb1f7/G5Aaz6sfydzkwHFayxx/JHO33RfScpuJE4tt/6SU7rn0yb0CMv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q+mgIIVX; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1G4pVEH1tCeWD1EDnELjzza532eeSal2jPOykZHwBnWz+u142Er5pjWpc/7CkZ5pDrmeI+6vV3IzM0YzMNzs/1HAqi/XXaXaKae9cvvCc4BgWn+BYuEoQrMSyLjsg3nXWR9H1GkfLoRO/P0Xg5JgZLtzp1w/oSC+TUeKC0Q78ohRh1/4vxPXZL04UJspbX6k2M1OsZ25DSKt0eIJOb/M9OZuwWQ/LbZdrV3Q+nK9NBV6+sPbJa60iUQmu04NS3RUGZ220I4uKiV0Qx1WAtR7EaWm6ks0+4GxW5GCIRDxWr/6orq6D/B7i/P9TXpkopTj0pjQAMcf7w5k1OznI/yzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJRes6ayLFnrb6jczay6SLIKilHAW9pWfNSPG1wkZ+s=;
 b=DmDSNs3NOcgLr03CTwLf6HAsWzpYAf8n8j8PJNEeDYtA+Ivo7kAU3+KUNgYDcosfLM9mNcmgsrrRLVauziriD0vscs9aCNoeffYat5HjicOq7t9bwzxJDj2vzTe6JchpoZghrlii+H26OMRd+YRMGeWEIDwFHGjgAZs3RSl2VasFU4AlESfHIxbbv+N9/vyvdIO2cjtoqHNvadOUDO4N/uDbI4YXBtfSo7l221obORCMX74X4im/ixMuOBR0WOdTID3DnJGP7tr//tcvh5mvfjnl07rAPYab3O9MgTrnT0kki/1d8HDTOuqmoaXsuLjnv7048ay3LcFnZ6SWfjsS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJRes6ayLFnrb6jczay6SLIKilHAW9pWfNSPG1wkZ+s=;
 b=Q+mgIIVXLt8J7ksEsSgRJDqZougWPD3GgdNaVVB1mywVJbfSXox2T7WCksMb5zjZpFjA5m120u7LZxXOE8b4vfzhnLxaXnPlen6AVvdI9mWvYfY2QvKfBEf17UqsjVBzeVDgAK2FPsWxxz71D4lUUs4CyCzCIbIV5UAJm5Tr6nWWXp03VpzJBpIO4ZJsFhlta/fc+oGZLcvHiQ6m9WWAAzi3V6Jc8erJR1xk11kEJwBbVkzhy2G0zCuMpp2jjd1UbptTsviwDw+UsjLOTdIJ8uZuA5/9MmP/vg85capMzgIAcrZ5M09tjAxX9nvRt6FDPXc/fMHQaoDDdwH+uS5UNQ==
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 01:27:40 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::ac) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Thu, 30 May 2024 01:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 01:27:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 18:27:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 18:27:29 -0700
Received: from jjang.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 29 May 2024 18:27:28 -0700
From: Joseph Jang <jjang@nvidia.com>
To: <shuah@kernel.org>, <jjang@nvidia.com>, <mochs@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>
Subject: [PATCH 0/1] selftest: drivers: Add support its msi hwirq checking
Date: Wed, 29 May 2024 18:27:26 -0700
Message-ID: <20240530012727.324611-1-jjang@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 733cbcdb-dce3-4766-268e-08dc8047b1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lro8vmWOc6ipVitjtUsbP0hKnp7vQFGL7yhlsofQq6NPE+P5Ln0ZGETlIe8m?=
 =?us-ascii?Q?ZtztJoyytfbHOWRj/a5c9zuO1Ha772jnOdli/lQe8zuDYCxIvtk+rcUALwu8?=
 =?us-ascii?Q?J8nZWcyhbPoCvznQ3vVl6Ykt60qV6UtSbvlVUK/PL2JhNTkGLS1jUzPt0uPW?=
 =?us-ascii?Q?uYCgSWm7SPIu8d0byi083G5EUfscEAWthcpOmk/apzz0OA4NRk/gHfFYPVuZ?=
 =?us-ascii?Q?ZWHbrsmDMLSJ1M8bCgbC07oDrVV/I6ybR+NZE0SAQLDPz6TBIotqFKk7MxyY?=
 =?us-ascii?Q?cEQHn9ndyFifmkqwNOatAiD/Bk2xpEueQhRqe9C/pvtnn3tYPfn+JHe6HWUO?=
 =?us-ascii?Q?8J//YpWSM8ZjTqR0FyhVuy56Rjz8mqPZqN6dEVe/O8bNsWwRa2RzEcEm6Hwf?=
 =?us-ascii?Q?hCTsFKAornuEtf6ZGKocC4d2KT/Lb2FKVR1rZlDnck6WJH+nGn4+Md7FD3N7?=
 =?us-ascii?Q?LLa69D9O7E1wJOWzomIyj3v8SPidFVHObLeTLMiLR58KsB3V3wiFYbzYHRXX?=
 =?us-ascii?Q?qAfKw9Ol6hTwidPIoMuBfGJHSzL8fw4U7f6cZAyBQd53TUN/rRE0ea8a8nGH?=
 =?us-ascii?Q?KbO6RZk731OtNB+8dh0i+y/JRpDgEKw6Ja38pizxYf6n3ZMMOnHHff+v0CYy?=
 =?us-ascii?Q?czp8hBR1NFB+ez+NhDgrEwll2tutxeD+DJhVTtHJ+FaSnbVpcPZgRd1jJC3d?=
 =?us-ascii?Q?fjlCWW1xz8z7M9VQsQOt9ghP9heeimAaGB96/GPSV4KK7fpNRzSx+DB9BxBg?=
 =?us-ascii?Q?fTKFMAwqlEUuOipyWr79slv0CNzTS3+Aeum4XFpx7XBe5qM3WjR4fVM6GOq3?=
 =?us-ascii?Q?H4MApsyH4nOkPtsH7yJlzkgrGdL5oDL/LTF/dIinJ9RET3pGPqFZjFWRrxfV?=
 =?us-ascii?Q?6Xb8DAE0wVX/WKtZSnJgQsEivDPoPAcvkwHE9ueFZseu5tV3VNmCJRabkZPb?=
 =?us-ascii?Q?zbo/t+LuLd4mZCFrDyfCF6ZE9JADhUhmPEy/hz2fwKSJmQhZEiIUFNUtEjtf?=
 =?us-ascii?Q?oc6iQb+Esblt0Lu55YkLXjcs902cBMIJrEmFbzRm01ZOd8no9fGNjKvWmG7S?=
 =?us-ascii?Q?P1QMrNp2UZ6CQpTPIQpuaRaHYg7QEnS7PxPAI3ndKSMTP0oD3U63DHpBcPGq?=
 =?us-ascii?Q?rzZI5QYslt0VkknDCSJXozjZ2QHnfgVtUXhcYQs+6Uqq7L8uy6ulCGotCkNy?=
 =?us-ascii?Q?5zH2TTE9r4iX1emu6iU0/Qw2dc8ifkTrOdIJw5QRs7RrM5Ly1L9LFj/p/sDy?=
 =?us-ascii?Q?zej03EwO1ejlQjPgBtDcx83JNQ2+s676PxZUIIezqy9rCUyiP+n+1V2Q09t6?=
 =?us-ascii?Q?PRkULw5zJFvOhUL6qJEwHleDK10DQXKjECXhXkUwT03/pnPtWDb8+RpXU6NJ?=
 =?us-ascii?Q?4JflyG98pbGpTOMiernLrLLPLJeO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 01:27:39.2320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733cbcdb-dce3-4766-268e-08dc8047b1bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078

In order to validate ITS-MSI hwirq entry in the /proc/interrupts, we
have created a shell script to check is there any duplicated ITS-MSI
hwirq entry.

Joseph Jang (1):
  selftest: drivers: Add support its msi hwirq checking

 tools/testing/selftests/drivers/irq/Makefile  |  5 +++++
 .../selftests/drivers/irq/its-msi-irq-test.sh | 20 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/irq/Makefile
 create mode 100755 tools/testing/selftests/drivers/irq/its-msi-irq-test.sh

-- 
2.34.1


