Return-Path: <linux-kselftest+bounces-46085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64EC735D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2C22354240
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DA82BE62B;
	Thu, 20 Nov 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X48+nwIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA72309BE;
	Thu, 20 Nov 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632849; cv=fail; b=fQsmOBfoxvLFT33/Vn8AmBtXwusvPg7MVXXdjtDzHAp65sBHUopU5UHkx3PCMaKAL9GPX7QHpHlhum+rzVuZjgIRPxPi/yml//D2meCPyJOFVDhehCGpniTgF608PCTUh7jj9MQ+ZZ//Ybs0KYi+xSCoH1yRDgvYocr4DbU4bX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632849; c=relaxed/simple;
	bh=86F/f4z+RUGaQQArL/JJ+pLQoxeUiV5xx2MwJoJwPrc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dL1VLd/qsdGkDd7drmf7fxIZ8ctvKal2oWZ5FQuKl74dkCEA4mtLBuzMsHXYYIGMURu6fn7M4HYgozQmzLTIEuwa44qoGTy+feciavLxbW+hnbVDm+P1+OjYFiBX3dC0T/9b9W0LWFYzR0vPwngYtUN7Aox4kEZiYUPmgSG0DdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X48+nwIr; arc=fail smtp.client-ip=52.101.56.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw79lcMBICgq9AVGBCu7zX6xWhkQlwGZMP7vILHwt0e99C0/LN5fbFFTB+ssiKVC67YaHdJKE/9BvmZoD9VUsHosOKAepJm47g53mcXBg4bjydyV/esq5+m6zYs4sJyqQ8fO6If4eeXKk0NGExGnl/dXKQaC/5DpAmwhV5gAQjdYOj57ALjGJ7qX2sFHH7LEPe5nv7FjiL95qrY0Mow/VaO0jwKInn93l1D7/+fPyDFPZNbKwtRkiqVWjdGiYeZOFmSYT3XME+klyfeP0dEEgUX8xcwEMl3Elelnkyw9uOxCQ/5mvqQ1BA4UtiFGIE1kqCRG7Dqk6gwVbdJWi48uRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THiBaaovjy0shIvZNUmohGjicK080R2Nq778yMbqbMo=;
 b=Yxl3j4d03gKGqZZZYeplgunf8mSrAPUJwrGEM0mngUukR+jLw+HNHhGlfe4Ks6e21x35wIe209sQw1FKue5qHHWtCZ46EDtgPPeHR4EAVzyoEGLk6gjn0Mn6eFJvgYAV00qCfxDEFc/idHAmXIQWU0Xr85QON5G54a/uphRc5Abyi9MSUdVtdjF63AmDE85fZPLkHPHctHlVa+roWx/AoqkWtIAF0hnE40vH9Sd+XM/Ke74ZwRP15FdNeWXzoWx9zn2rPp+sh+g4P/J0mOwlP4HVGpiA4tp4zV2UZIBvc6Z8eGWia5op8m85qeMGaFd6gAGC1a75QHFsGy1+hwQhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THiBaaovjy0shIvZNUmohGjicK080R2Nq778yMbqbMo=;
 b=X48+nwIrk+bmN+3WLDvyEdn7JJ3Lqb5haTOgslWzgs/5Zk5lcsXeaCZuoEhQHhImdpIW1lGBAlWNT4Pemdmzv4KLCQlzHfPUnX7Zc6404p/WBgN12OMFyK1LRkPrqnwDfWHbXzc3tmwpEodmwFB/kQtAqfzDz1lU+6ihMTnTOyu2LlbnbXJHJDbm04s6OSNGqI51kLmsFLVc/EG0FSpUlWeCXJCVDAVqo9oWwfdcjiHHu848tHu+CzjQ+N17wpB/WcsXxgt6AuSOsGl3J/3yWA9dRFbt3Ltu3QaJ+7rjoIZuGNuB5zoUCDmbGLZvQl0AL7NcAEhVDsV8PX+fLn+kPA==
Received: from SJ0PR03CA0365.namprd03.prod.outlook.com (2603:10b6:a03:3a1::10)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 10:00:41 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::fe) by SJ0PR03CA0365.outlook.office365.com
 (2603:10b6:a03:3a1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 10:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 10:00:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:13 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:12 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 02:00:08 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 0/6] selftests: drv-net: Fix issues in devlink_rate_tc_bw.py
Date: Thu, 20 Nov 2025 11:58:53 +0200
Message-ID: <20251120095859.2951339-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: cc206a25-f1ae-49df-7247-08de281ba9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXlhK1hwSnlacjcrT2V3RDJ1WDY2Q0dCUEV5MnlXR0JML2JhK0pDRmxnZU9j?=
 =?utf-8?B?S3IxTmJ0djdtQmlqYXVPU2pFWVl5Z0tXcjJuSUdvdVNaM3RjK1JzUFh0YXhS?=
 =?utf-8?B?ZW5XZE1xSWZGT0IvTTdRL2QydjRLb1B6RFVNdjNUNWlFTDNMeDNrbFh1ejl0?=
 =?utf-8?B?SmhKTnVvdUZUd2o0ODlXeGF1SURDdjM4MmF3VkMvZE9jMDJXN1ltL1kxaHc0?=
 =?utf-8?B?S3c2V0JDaXYzRjZ3ZHRjQWFmVmhKUmwza3FNaDVTRzQ5T1l3VC9tZjdnU3RM?=
 =?utf-8?B?R3NobEZlbkRYZTA4MXdkTmRtcFVjUUFQY3BObmNiRW03S0dRaEwyenNzbzJv?=
 =?utf-8?B?a1cxU3BaOTd3dEk2OGF4ODlrT3gxU2pOMDZDQ0h1eFY0ekY3QzZtLzZQaXJo?=
 =?utf-8?B?RlQ0RGZ4MjNqbXljNjBMc0tEcy9JU2JDOVlTbHlZNmhuU0g3TGxMZTBlV3VW?=
 =?utf-8?B?dUpxeFpzTmVTMWNVa2pTUWNWSytZRXB0ZmIrT0VMaGZNbEtRU05ndzlXK3VG?=
 =?utf-8?B?UUlTb096WCsxUkFiOXIrQmVLRHVkbnNGc3psakl6QzhsWXlWTlk4QThzVXVl?=
 =?utf-8?B?Zkg0QU1TTDFtWVRxc3NNYW53ZlpsVmFVYkNhMDFjQnVPZG1BWXVvRE8xTWNT?=
 =?utf-8?B?djdLR0ZVYlk2bTZFVWIrZnBDcTRqbjFrdGliN3ZtdmhiV0lFcmxiZ1lVRnFo?=
 =?utf-8?B?eTQ2Y1ZvcnZWT2t4UXkxdEFkNGFqOHZSK1VOVEplUHJkZm1SM2tHUU5RUlhw?=
 =?utf-8?B?RDBPR2VTVlYwdXpvelJpMW9oZ0E2ZWdlSmtPYTBiOGVJM2lUaWc1d084TEtw?=
 =?utf-8?B?WUhWdFl0ajNXTUZ4M0NGYWh6Zk16VE1wVFBnWnZjVk5sN0dHcHUzclRLWWdY?=
 =?utf-8?B?c2tpR2c0NThJME9YN2lENzFxVk8vOWFxc0NMN0ZYaTBNL2dDZ2wwM0dlTDJD?=
 =?utf-8?B?MVZyd2pWNFJWbGxxVkpKVlBreThyWC9MZXl1VlVxekhITi9ZR2hCdTZEeEcx?=
 =?utf-8?B?Zkdxa0Q5MWlrcU1CdDAwNjNDN0NWT3N4K0N4TnIvVHFOZTRRVXJtZ3Q3MWV0?=
 =?utf-8?B?dWtQLzkxTWtoN2VlUjRMTjYwQ0NPUVVrdTlKQ04yN0FkN1dYSW5NTmgyZ1hY?=
 =?utf-8?B?WVdQYWttSDg2YmViSjhlckVhM3RwaDlWMzhoM2xGZHFSYlJ4cEE2Z1hJYi9k?=
 =?utf-8?B?VnJ5M0NnMW1ZTlRRUTRrVERGZ0V1cUsrQlR2QVlFRlBqK1RmWUlQWUNNQndv?=
 =?utf-8?B?SHZQT0FGbjFJdGYwWGV1VUpGd2FqSm1SUmN2SngweGNlNEVGT3BGb0g0N3Nq?=
 =?utf-8?B?TnRFQmE5YkRVNmJEM2E0OFZ1VE1nbkR6NENXWkZySEQwSDd3MnNvYUphRDZh?=
 =?utf-8?B?V25KQ3JGeGpEeHpLekpySk1od2VYOUFqcDkvSFRCRTU4cDZxeEx1VjFOWFdj?=
 =?utf-8?B?SHpvQjREUGxjRnVoajlnUU5tSU0xbUNQRFg0L01VZk40bU40WkwwYXUycWMr?=
 =?utf-8?B?YkNvUnFQTmllUTRxT0diM2VFc3BheWMyRWFLNkU5NnFZRWZpdVI2Q3FzcnBD?=
 =?utf-8?B?SzBLVVFLVFNzbkNoRFhvNFJnUnBQQTdoKzcrMU5CV2FPNUVUVU41NEJ5NDBG?=
 =?utf-8?B?QmFQZ1VtUUtOR0htSW0wMnVsSHVxSkJvbmpPWFJydVRLYWE0VUprODNkVXN6?=
 =?utf-8?B?YjRWRVl5T1ZWLzUyZE9MK3ZkbERIdUZudFF6TUN3NVNPT0g0VnNLKzM2STRw?=
 =?utf-8?B?NzRuSXBnckpHL0F5NG9LS3dBVVVVc3IwcDB2TEpBWUw0MDZEMDFraHVoaFFx?=
 =?utf-8?B?bHNVcjIxSFZKRk1CSGZqYnJNalByOWc4K04xWXl0ZUFsclAvakxDdnM5OWMy?=
 =?utf-8?B?ZlNVM3U0UmZZeVFZZnlLU0w0NklSSmtGYy83NUFJTEtVMmpJeVBwNzk0RGha?=
 =?utf-8?B?VU5ac3pjSnFvajVVeGtSVlpVcFpQMTZCV1JqaTNGcGR6TmhCbnNSaWltQVNV?=
 =?utf-8?B?NXZOWlJZNHgwbjBXWlBLak8yODlyamkvbWxCdk5sR0x5UUpWME1lU2pGM3Vi?=
 =?utf-8?B?L3lqT2g2QlpBU3pVZmlDcmdFM3NLblI5U3MyS2pxekgxNTRTVHdpb051Y0dy?=
 =?utf-8?Q?xPlM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:00:41.0453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc206a25-f1ae-49df-7247-08de281ba9d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996

Hi,

This series fixes issues in the devlink_rate_tc_bw.py selftest and
introduces a new Iperf3Runner that helps with measurement handling.

Thanks,
Carolina

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


