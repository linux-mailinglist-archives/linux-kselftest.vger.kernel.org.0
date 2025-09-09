Return-Path: <linux-kselftest+bounces-41048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D36BB4AA32
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 12:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723E717BCF4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F8931E11D;
	Tue,  9 Sep 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UweKDvSq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A5131DDBC;
	Tue,  9 Sep 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412910; cv=fail; b=ckwVfX+xuxdb1CDuu42W7ilHfTPCM1Mi20GFdDGOt3M83ClLIAIn4+XhkBUuyyfY5ZWB77Dm6XvTLmtFQlkOV1PQ7+qGjNvLzkyC8nECHgvm78rIafJoPh97OiaKPdHfmoADTC1llNP7OUtXdhHC33DAoLYKnblbvPD7R4yuEVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412910; c=relaxed/simple;
	bh=cSjOKHWWZiarktYjC4NWWiRfZMQWp/W7Uc7AmHJkU88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BoSqIsmeuFz7ELqIbdvRY9Z1GUHs/vrnlmvN7ExP4/vn2xeJ8SS5gj1o/CyHbeFS4vv2THv6C4ZVcxMtQQfkgAML+5742/blWzHS4A+sV8HJmFs7qRNkbjYoKRIwmQLSoeR7bdHOE9bMZ7c/B0u5EocR7vuObP38ENYjuDxoZmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UweKDvSq; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZz31sQdZwVW1JCTk9845MFZUGGdTTRAilbnxO3EU17CyRiimvmUBkntSRE2k7ziqEBTIV7OkLhmwjWGPLUQOo+KItF6/7W7ZQpt6QJoMsu79diakUQhRydWiLPSldBHmkKmu/GzQw0AiGANKqDH2J3JiFGkVW+GTYvnrYJiVjQxW54U3vuzNa+DcZlXkXuoa8LkxWfO+muzhA4CHUAsbs59rrrjzbwToBmIkI7pwJnStbueKJ/H+/29QQLH14G6VkCLT7vqMVa4cP5EWEceo/gY0MvvfkRGUi9fzMzjGSjjgYVWz0gJO/Jmn5/24lAviikpWrHXoXIM072yT5C1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gW4cQN1ViU5YxWh7rF64VusI5YamsiptmxRBaQPZOc=;
 b=arAVy+EaigC2naX/+MRDyXIldTaL1kBy2HG77cwdTxjWiTVD5d83lsebNHRFvl0WCKXmsB690NO0UKiLuLWwfB5IHsOP2S5O05t4O/4/yrR/3KXSvLwa6U8RoyjwOTy3jN/yOvO4PqqttsQ91mLRZnkpzAokiyPUdMI6cbXIZOqUSjeSm0hjMcB0aUesXeVZx+0y0sVLlE+1iac95cYfc48JHOp6mJ4ejGSjV3iHkJyP5hhHCOOBLF0aly+AdGgNdA4A/anm5K9lYbq+YuXSfLrlQvTSXU1Bkk+cTmyCizdMSt1SbaQCzkvkQJWV0h1+qrGHM9Vr4saPdvJpmoEQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gW4cQN1ViU5YxWh7rF64VusI5YamsiptmxRBaQPZOc=;
 b=UweKDvSqIJHfBGxXaHBvnd2rigpa45UzZyPUKmk8pDyfRXAN3fcxqLORnDo3Hhi6SRomAqBK+jyfsVu0Jwb8vcCHj6TJtMck/zFCMXLvMaRK0i0bxJiQTI4OuzYN27G6P8Ss4WzGDlG9+AP9dEWC6PQIb102fa4s1smUckycLFPKemZSJD+w1mNM96gycSSC6KviTQX/GPguTK5IQ0zk62+48uv7A1AQC6WSvTw37jBwjMnZzFs0SnkL5dWVEIYA9gq+2fhVmlSz/sydgpDzxySoN0FpBRG/SS1g6+CjIuKGo7MqHtLYy3WQ/2kG7i6ZOxp9Pu1fCvz5ciuwBAeh3A==
Received: from BL1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:208:256::16)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:15:04 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::c7) by BL1PR13CA0011.outlook.office365.com
 (2603:10b6:208:256::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 10:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 10:15:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 03:14:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 03:14:45 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 03:14:41 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 0/2] selftests: drv-net: Fix issues in devlink_rate_tc_bw.py
Date: Tue, 9 Sep 2025 13:13:51 +0300
Message-ID: <20250909101353.3778751-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1ff560-9a27-4f38-03b0-08ddef89be19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXZlbzRpVmRBaDFKM2IvNzJyUzdhSnlwUmdWcHVJNStJTmNnRldRRE1aWklS?=
 =?utf-8?B?YUozcW90QmRRNVU1Um9UYUp1Mlc2THlJTFRHVW5zajlNcG0wdnNUbGwvQjg2?=
 =?utf-8?B?eUJpZGtFQmZwME1oMTVJUFZsQ0o0STg5WmRMOGZCcVl4Mm5ob0hPeElMcUZJ?=
 =?utf-8?B?TXFPVjMzQ0l4UGpyelFaYUs5M2xJcFJyNm9vN0lsOGx0UmZuTWlVTVNFakpM?=
 =?utf-8?B?K1AyT0x3Vk1iVTBoaUtrUWZZeEhsYkFoVGZYTlRKdkZ2QTc0aHBBT2M4RlpF?=
 =?utf-8?B?aTlwblY5ZmVZemJ0U1g2MFYyUDQrelA5OWtiOTFpbW5mSS9iTTk4V1o5d25M?=
 =?utf-8?B?WWpkS2J6YmN3SUVZbmphU2lpSlZSRjNuZnpwOUszOHl1Mnp5d0p5Z05pclR0?=
 =?utf-8?B?Vm5JWklOenBLbGVZd28xRVpMNDhPZWp2V3QvWjVudW0zaFBTdFdUR0RPQkZN?=
 =?utf-8?B?R1Q1M051bUEwZy9DVTN6bXlDMTlPcVRCVlFwM0xvekdmZEU2WkoyTFNGeUxp?=
 =?utf-8?B?NnNlbzl6cHhtOVBCQXplRUI1Y1FQZCtFeVBKUVZIUDYyMWgyYlVGTXZkS25R?=
 =?utf-8?B?QXJMLzJuK0c4cnNGQTBoaUZsYzJ3emV0b21qSGVjK1J1VWN4bGtyVlYyOHYr?=
 =?utf-8?B?ZW51NnFFSE0xYUNHL29sZDZsTTFZdHdrWTlGL3Jma1gyYVhZRFM0Q0ljR1FK?=
 =?utf-8?B?WU1CT1ZyT0RHM2p4VXV1VHNEWEJPb3FqTDJwZWk3WUN4M3F0VVJYRlZkdXJi?=
 =?utf-8?B?azA0YkxUTEtyOURuUHlUUllmNXpWU05Zby83RGNJZUVFUXZndlNvbE1MazRw?=
 =?utf-8?B?bHJpdFNqbUFwVzlUM0NMRU9lWEJtclhFeGgzazJzcGRXUmszcWhyTElKbjZW?=
 =?utf-8?B?ZXFrZ0lmS3RvamN6VXlhdWszenUzUjc5ZWVjSVNsa1RZV0J2MFdadUtwaUlG?=
 =?utf-8?B?ZVhMZHlxYVdRZk9IWENVQzEvZkVzcHNVM1E4cldobWZJMGRaZ2h6bXpmcGd0?=
 =?utf-8?B?VXNsVmtMRFlmNjU4RmZraTJyYVIzRS9sRkx0NFJMTlI4d0hDUlB0V1BPZmlU?=
 =?utf-8?B?MnRPT1VKUzN3T1l0KzgwMWlyZWJVeDRzZzZaVXNITlZuL2txT3N1U3A2K3JI?=
 =?utf-8?B?bk5NL3M1c05URXJ4Z0JqQWlCQXgzcnlmRzBBVlh2OHo0T0p3RUx0cVJTam5r?=
 =?utf-8?B?ZTBjRFdWejdkUlF4NjJyckRtZXZGMkt3ZWNqeTJUbEpGQ1VzdXBrRjQ0R1Z2?=
 =?utf-8?B?U2orZUZTNzFOQzZuclhwaFp4Z3NMV1VxQnAzUGhBTmwwQk1WQjBCb1BiZmY4?=
 =?utf-8?B?YXdiQTIva25pODZDRjd1R29HQnFFT09lK0NFdGZUZmhvMzVnUkZnYTNmbVdP?=
 =?utf-8?B?N0FQb3RXcmdhQ3AxY0dPa29FWStHdmtjNzVvZDBHalRtUGYvNzRrUW1RNWxm?=
 =?utf-8?B?R3FIaDBZRENLWklXTG4zYitETEVOa3NZZVMrMWttV3VnQVhYUlFxbkpPS0ly?=
 =?utf-8?B?UjhBTXYwQ2N3SkRHQkxBVkpwbysyTUpRVk9NYVpXM2I0YkRzRDZzTXUyYXNw?=
 =?utf-8?B?YjROY05kdUd3SnY4MTB0VjZYN2xrdm1IOTFBaU11TnlNa2UvcXp4d0wvSGEx?=
 =?utf-8?B?MHVLVzZpeFppaURuOG52VDUvTW5Ld3lRbmRaMFhlY1l3SXBSWER3dlpoTG5a?=
 =?utf-8?B?L2VVMVVzZlBZanhMN3BJRE1UeUJEK0xURXM2MWJpQnFpTGdlN3J1R01xaDV1?=
 =?utf-8?B?K3lkMElrV2FoNjFsSGtIQ1JlbmZVMnJ6cUlKZS9Gcit6VSt5VS80c3FUWlM3?=
 =?utf-8?B?SWJ0dWlVRk1JZ0xYREVVbE8rb2ZWOXJvR0NjRHNwRElqblNlNFBNSkNTNGxr?=
 =?utf-8?B?SnVIdWRNY1N5SmNDeTg0M0JLUEYzdmoxYmVNNFZTMS9RVVIwMTlZNW93U1ZG?=
 =?utf-8?B?ZUlSNStKQVFub1k3alU0a05lRVljMkZFSXBWU2FtWmYwbXh3T3FPTzJMc2tm?=
 =?utf-8?B?WlpFa2ZmdmtLRU42ZHhDT1lnRFdTeUYybllRcDFMMEdUY1ZIV1IxS1hnbkZM?=
 =?utf-8?Q?YB4pZZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:15:03.2233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1ff560-9a27-4f38-03b0-08ddef89be19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

This series fixes issues in devlink_rate_tc_bw.py selftest that made
its checks unreliable and its documentation inconsistent with the
actual configuration.

V2:
- Dropped the patch that relaxed the total bandwidth check. Jakub
  suggested addressing the instability with interval-based measurement
  and by migrating to load.py. That will be handled in a follow-up.
- Link to V1: https://lore.kernel.org/netdev/20250831080641.1828455-1-cjubran@nvidia.com/

Thanks

Carolina Jubran (2):
  selftests: drv-net: Fix and clarify TC bandwidth split in
    devlink_rate_tc_bw.py
  selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py

 .../drivers/net/hw/devlink_rate_tc_bw.py      | 100 ++++++++----------
 1 file changed, 43 insertions(+), 57 deletions(-)

-- 
2.38.1


