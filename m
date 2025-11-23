Return-Path: <linux-kselftest+bounces-46349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 28430C7E4BD
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C726E3495E6
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F5A233722;
	Sun, 23 Nov 2025 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WMa4KVa9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF714F125;
	Sun, 23 Nov 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917911; cv=fail; b=Hxv30+19e5ZWetgZt/SL2jLnKGBwQgtZtCek5f8U6JA8FJlcdeBrp1T1wISYB6UgVjZ/r9OnyRRIiJViCvWmoztFbVauuH+OyP7umZVtn+VmIfzziTIXmy4K5b2nQls3q4ZmcLJxyBM5tnNBzQCKgkn5yROxtddUGuVwY/D3EQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917911; c=relaxed/simple;
	bh=vLpetXytfzk0dGAbKq59kwDlJu5u11twLaNNNQNOwZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CxWQpcMWbYoM0dnm6ednAxNQwdOTh5jIwti8BglMU2HaJR6l3ufD1JSLge6mQNdibod0Ggebxv2JgcfXIVUkGh+4irx6EvKVwFGd2RejH3d6V+f4QE3B04gMbUbkHlCOV2JsAEY/qwcfa8VY1yREb7GKe7PfG0ObyKzTeBDLJfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WMa4KVa9; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtnECJ9+wfFWO1pScYb1zBU5ZbsvXtlJMYgi4ocsaUW4BcQEdwjPXdvYI1i6bEKxJDwPSCnzrqGFtS67QOXmd2DirXXuOojbFiGKIu1q/qbknWsYKn3uggzxAScNpWYBLTqc5MUkjvpyJ4IqgQCuitxqN2oJ18cWTwt0P1cxUIPQxlNIm37S5lOsErf4prF3IIPYuRwjte9H9Wm70JiwKmz47GjHRwtUqx6q5sA4GvvXvQEwtEzrNVxYFSVJhoKedMEIRrd3QAOGmQCU6HRaQakA/LwDciKLpgy2mlpkSnhE+6wr13/gm/B0xP1E+vERltl4RDzd2ODUs0i3DA4zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrW0cY+59zai7CbddqzMMKTrHRiZADTuEIVJbkf8jvE=;
 b=o+lWMREzr7W9GpCFJRl80FVrRiff9vI7u5/Bip5NSGOyTQyqS9wEvzi5JsurXDpaCr2ihwpDwxedl0b3wS8xsB7fLvk9BPK6c/kWLbxjLEeojHGpEOvByKWaWUix2tLPp6Qff/MNbtyPBC2AwX0nfG6H5Vr50fFMbAcJ8A+lj1jPjS/KL2jfs4P6nBiCWUxdfdfL1AHmdTvhI7LrVnC5jaURpmS4oS0GtMHRGshkhMd4pUHlQk96AYgySDPXgX1gEK3nQ3bYv8K52Rm/mNuL+hjdNnHCOeErfnUFK1Sndlg00IqSwVpwXLjCN5FGsAfYsFBCHlOzQa5TwbLcinajbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrW0cY+59zai7CbddqzMMKTrHRiZADTuEIVJbkf8jvE=;
 b=WMa4KVa9CjeyRq9HRwFziBGesOaz5VP+xOW6Kt81YUCWOFnvS10MirXjtdr+47MXPWn8EnEHn+0vVFoZbLW36MWoh1/UumJGUI4e0SFd9W5pktk09f2hyNh8iG6bmtG5MStWs7rwSxCd3BpJZcr8MwdEJtU8sPjiJDTO9xKSysJPA374uOmnXJLNsxfngeKDy13ClUk7iiRs3Sgu0gJB+dOZO7AIRPCvMXr4+oP/+O//CppY7NuufgKOFGk/I/K9slj4C/TTChHjCez1UZfD9IVr20KMyI8emPNdh6yvEs+2BLGP2flzZtQL2JqWGPAw6HHK+Z8ZPP+zAoPedh/AWw==
Received: from BYAPR06CA0033.namprd06.prod.outlook.com (2603:10b6:a03:d4::46)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sun, 23 Nov
 2025 17:11:46 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::e9) by BYAPR06CA0033.outlook.office365.com
 (2603:10b6:a03:d4::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Sun,
 23 Nov 2025 17:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 17:11:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:35 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:34 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 09:11:30 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V2 0/6] selftests: drv-net: Fix issues in devlink_rate_tc_bw.py
Date: Sun, 23 Nov 2025 19:10:09 +0200
Message-ID: <20251123171015.3188514-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6a8d59-18a7-475c-42da-08de2ab36220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHRObWh2VkV1ZXc1bm5JcG5zUTNQOU9Ea3VJdDl0Z1hpcG1KalhlVXJFTnFa?=
 =?utf-8?B?UDkxSW9UaWFTZ3NBWTFZdDJuNWhPNldILzhMVXdVSEI5bjFRZ3E5MncwK3hY?=
 =?utf-8?B?cXEyaWFpZXdXK1ovdFVlUkVLNk4xWmw1TkZySWt2TEZCTm1CbVZaWmhKZzVq?=
 =?utf-8?B?MUd5MC9jbGpWdmdYV2xUcWxjeFpZQWVFQzFjYlp6ckZJb0xqTlJ0ODVhS2s1?=
 =?utf-8?B?SnJGejRUK1ZPYXRTTm40VVNsdlMzUVBIeXIxcHFKWWc4TmlIVzFQQlNPNzVS?=
 =?utf-8?B?YUJuSmZxc0xGUVVqemRJMUlrblZ4VkMzOFZZL0VPUEVJNkQ4S2JvcFB4RzZx?=
 =?utf-8?B?NmZReS9NWmZ6QjROYUJ1T3R4ek9DMEd4RU9SemZqQ0NpV0F5YU9lWDFPVTZn?=
 =?utf-8?B?ekJ0ZVlJRmFRRGJQbXBxNloxVnZXWFdyMDdnamxvWEFRT0l0aE96aFhSTlZL?=
 =?utf-8?B?aTd5UlovMGNTN2dMY0pSb25rWGxyUVA0bnVVdFNCZW5JOHJFVmVQWW0rN1lk?=
 =?utf-8?B?c3phbmtLMlNaRFY2d3RvMVBaampybUt5QkQyZTMwa1k5OU02dU11aG9uZ1hG?=
 =?utf-8?B?cHhmZVdtMVg5eW0yY0xWS25tdW1mK0dqbm1BTGE0cEl1ZlBjeCt6M3dnaDh2?=
 =?utf-8?B?cDhKL3RlZTcwSjcvQlFJNnc5UC9pK0ZEL2tuNEVmazY5TW02Z0g2OWk0elJa?=
 =?utf-8?B?bnVrUHhObXZURE9nWlBXaTFaL2pTeXcyTFFFc21CUjlxb2w5alZ3bEF6aEIx?=
 =?utf-8?B?UXRldFNBOE5SODBQWGdkVDEvaWtmTVVzY1FJSUhvYUJZRU9lcm9OckJZUUZN?=
 =?utf-8?B?SFEzRFpOY3RkcUhXYXNoOW5EbmRjRk5wNmhEM2o4aVpVeDFZNWk3SS9qZGxU?=
 =?utf-8?B?d1dVUHc0ZUZMclBFNVFWV25VYmZhdFhpN201d0R0YW9ZRzlSanp0Vm5yejhQ?=
 =?utf-8?B?WEIrTUFHWE1NS0QzTmNHVTFkU2k1SnVRZXZjRVl2QUw0N0J4RDNWaUhxa3M2?=
 =?utf-8?B?a0pHUlpwL0lZL283MFAyMXFTZmR4YmV1ZmFpb1BaUHlEcU0xTlJuYjFIS29M?=
 =?utf-8?B?RkIrQ3U2MEw5QU5iTVlqdGNqUXZPTWNtS3BndExvK2sra0pxSFEyMjd3REdv?=
 =?utf-8?B?WmFZU1Fkek5VMytEdEcwZWdGUC9YL3ZGQm1tYm9URFZueUtLbHNULzYyMUJT?=
 =?utf-8?B?TGYwc2RYQ3hpU1FkTlRMRzlEazd5VDFObU9xbzZLbHFteHY2UVhzN1Q1K0Rm?=
 =?utf-8?B?bHY4dTVGWHg1QTdZaFBBVDIwQ1JtSGRqMU5BaUJRUE9LSkpjd2lWRnlnbndZ?=
 =?utf-8?B?WTZFcnlNakJBOUNvL3krRmlmaFcySWE5OEdMQk8xaFk2U2NNWGgrVE5Oc25k?=
 =?utf-8?B?cmZ5TlAvbkk5OTgrSG02aDllTXZ0K295bkdWVlBEeGg2dzB0T3lHSjFtVngv?=
 =?utf-8?B?c0ZLUU8xREpHdUw4cDNoUkNKMDBBTUc4ekw2VVpiTlo1ZE1yVWE0b3ZCKzlI?=
 =?utf-8?B?Z1EvQjEyWUZOM3JSci9NYmFyL0ZrNTczMTJzaE4xaDM3d25OVThTZ09SNkgr?=
 =?utf-8?B?K09SUU0xVG8za1ZucFJjelcxc25sSVRUdHJqQS9HMVRZeU1xdTRxVXJNVDFB?=
 =?utf-8?B?Y3pKaWhUNklicVRyd0dsTXZiVzY1Sk5PTllKYURPNnQ3bmM5ekQ1THpDM2w2?=
 =?utf-8?B?R21EdVpHUHNVQ2s3aVJ3QnZON1NPZEZBS3FVajhkU09aaEMzaE43aW5xRjk4?=
 =?utf-8?B?ZVdNMXN4eWc5YnBZaDNFdjFCS1kwekRsRmwwSG0rQnI1ZHExcjVQR3l6TVBa?=
 =?utf-8?B?ZklPL1JNekVuK01zVHJ0cjc2MkQ3K200b0xMRkh5Q2hndUg1dk53UlBhYjUy?=
 =?utf-8?B?TExyakltNDUrUnQrdHZRWEEyaFNpc21HYWcxZEJDQUp0dGh1VUFwUG1pQ1px?=
 =?utf-8?B?WWZpelVsWmttTExud0prZ0VnQ3pndndXUUJ4NFhRSFFGakE5Y0JLcUdJUmg0?=
 =?utf-8?B?NjNwTVRBc1BHQkxVNm1DZE5LdkNhVXdOZmZRZlQzaEIzSW5ZQ2Y5VzJmUThP?=
 =?utf-8?B?dVBWZUhCbVU1aVRJcU1sZ1g1SVdFU2lxZDdYVVBlMit2UCs5MHc0bGZlUUMr?=
 =?utf-8?Q?qlIA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 17:11:46.6691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6a8d59-18a7-475c-42da-08de2ab36220
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445

Hi,

This series fixes issues in the devlink_rate_tc_bw.py selftest and
introduces a new Iperf3Runner that helps with measurement handling.

Thanks,
Carolina

V2:
- Insert the test in the correct sorted position. 

Carolina Jubran (6):
  selftests: drv-net: Add devlink_rate_tc_bw.py to TEST_PROGS
  selftests: drv-net: introduce Iperf3Runner for measurement use cases
  selftests: drv-net: Use Iperf3Runner in devlink_rate_tc_bw.py
  selftests: drv-net: Set shell=True for sysfs writes in
    devlink_rate_tc_bw.py
  selftests: drv-net: Fix and clarify TC bandwidth split in
    devlink_rate_tc_bw.py
  selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/devlink_rate_tc_bw.py      | 174 ++++++++----------
 .../drivers/net/hw/lib/py/__init__.py         |   5 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   5 +-
 .../selftests/drivers/net/lib/py/load.py      |  84 ++++++++-
 5 files changed, 157 insertions(+), 112 deletions(-)

-- 
2.38.1


