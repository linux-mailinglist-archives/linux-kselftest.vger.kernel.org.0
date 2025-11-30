Return-Path: <linux-kselftest+bounces-46742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB40C94CCD
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 10:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84A21342775
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE42B26FDBB;
	Sun, 30 Nov 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QNA2Ro18"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44C14F125;
	Sun, 30 Nov 2025 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764494471; cv=fail; b=rZoy8U6k/coJ76UZpiP0ahXx6FpqNtg2Ls5HNSzjQqwoVXFzAjNuszbT1TU6XExe3PQHxkBooHXHHBn8hluSg5oFsD2SgwZ0Xrrp9BPtPy+ZEpAKnXH5Fzj3mwVX5yebhBH3Sd/kVxu2DmDO/+zjNOmepDJwMkSaPVVnaM1VTFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764494471; c=relaxed/simple;
	bh=bANh1avQO5X9+Au0VCG/+RlIfr7HOZM2fYZO0biYjxI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h9LUWk4cX6938Kljgz8cQ4qjR/pk18zNI7/Zy/uCOwxOczlKoH6dOTb1kuQKWx5leFgHnGmByReEz1RwrQwbziNBuny14RA3Y6pUm+5jVsGETa/+MA40S873GS9EWt4dj0RNzzvJm6a/fP2aFYkZ6Ssu2yFA4Z5S6iXVgYpUG9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QNA2Ro18; arc=fail smtp.client-ip=52.101.62.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcAE2C7sQiobNnqeIxzsLYIw5N1zuGEzwq22Ae6Yg4e7/bhIOsjJu1TShB6COyw58jPOADCHvAQfqHmJ5v5E+Mw0QFredAYG9lRFy6UYkZbhodKV7NgSXSe9ha1KQSDk50nkVo+huiEgNEQK47JYmjFkFTT+LJzKnIaE6we2oOxs3yJ3SxSXaIYJHPAaymsmeXLVYq9AFz8bPBdz41My4ePRUFlYGv25KA0WBZsOEaFIGFbKavqUB0ZgsrMXTIKnwSXiHDQicfn2HUawLpSv2d9s36fMkwVZx2lzUoUmFWYl2P8V4vspgMsSrzro8QPRBc0WJScRXMuAWJhR96gpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rfjm0tyYvs7dNLc/WQOabyZ63tt3fJ5nT7Xue5Pccg=;
 b=v+8o0SiNzxyb3aFc3yGlysFhgCL9uF6mqWJEGDKTs8fZ/e8B8NcbfFoVnx6ZfpyJ9D448XNp3lZ9lcuScofTQ9rrHnWI3HITZspRiQMOtw73Vy3/2vLorK1+zUeovWVGc1gGeBTlGkZvGLOcYlz5Ez9cAiiD1kR+BI6Y/iSyIJp5uNM+P20/k3IPCpd5LssU13yM/z0LQl+z/YI1x25gGDWg5aJ3wXuoikTz4bBik4ldnAMHMYPY13KAQIAUkW5Ng10o5RrSMMQGDAr8xnN+EKTNADM8T2OXWF+6wueIPQen+Redel5FsqGYd6WHEVSTfJeyMxHRRsr7T30nPtNo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rfjm0tyYvs7dNLc/WQOabyZ63tt3fJ5nT7Xue5Pccg=;
 b=QNA2Ro18aqD6mmmlr0eVruA++sDnooT3ynr7+YpkuMbbP57WjcRkrghQr0xPMMi/Y3XSBGEXR2vV/2E2zKCFTNkSc5C/EFp91uU1hyYZlB/VVn36C6ljPalopzaD4tFEsIlKR/7gKNT+qJPHG5Su3dktJuMhzLMGVCa5fepxlbMPhcQobnlbb2QALuFBuobJbiVqt358uVyRE1gHna5eC8GZgHT3/mECJ+DkpF+wWJqzLDr+9weHXFAiX6d59pk81hokBX3DfcGhRpbq77d893BC/B+R6HVhuXblOTaxdX/9wHa55fL9scLEEMV2at7A0QOVtKCgQmv2LfZRv2uy3Q==
Received: from SJ2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:a03:505::27)
 by LV5PR12MB9826.namprd12.prod.outlook.com (2603:10b6:408:2fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 09:21:04 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::50) by SJ2PR07CA0010.outlook.office365.com
 (2603:10b6:a03:505::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 09:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 09:21:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 01:21:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 30 Nov 2025 01:20:59 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 30 Nov 2025 01:20:56 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V3 0/6] selftests: drv-net: Fix issues in devlink_rate_tc_bw.py
Date: Sun, 30 Nov 2025 11:19:32 +0200
Message-ID: <20251130091938.4109055-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|LV5PR12MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: fb960636-db59-4ed5-c590-08de2ff1c93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVlrWDRkTFZEZFgzT3A1a1p0M0F3ZlowbXcyMFJsYW1LMldQQlRlWFhLbEpO?=
 =?utf-8?B?RTgrZUQ0UHU0NE9oaUxZcEdvODhnd3JTY3daRmkzc25DcWJCY2ZBMWRUN1dp?=
 =?utf-8?B?bDBqQUxNYkd4RWZVVnluck9QYk9tYmFUZFgwbnc1b1U5OWl0L3dNaHlaYWtB?=
 =?utf-8?B?L3RUTEl3YU9XNDEzLzF5UDIrRHgyQ1VONXM2czF3V1N1VkZod3VEcXUyWFh0?=
 =?utf-8?B?SjM4Mjc4dFpQSnlxR0VzVUlDZUtOa0FCZE4xSHl5cmdaOHMzRWhmNUlHM0pu?=
 =?utf-8?B?QzRjNEVxbkNLNnhOKzVOdEJOWGNqd3lHTW12NExqeDJGUU5Tb0lKV2xxc0Fn?=
 =?utf-8?B?dnlQTGg5WWpWTmw2Wm41ajE3TDRpdDVtNysvTGs0MFJ2VGtxcjZEU1J4OWhI?=
 =?utf-8?B?aUh3YnhXVmtzazBhOExiSkYvOFh5TE5Kdm52YkJzTG5SZ0ttaUN6eUJkMng3?=
 =?utf-8?B?Sk1mVzNmbTh1Y0t0ZmZOTUU1RExZUkhFOGR5eEhxOVVLc3RQNUVObXJUUXJZ?=
 =?utf-8?B?eGJMZ2xQN3ppbm9QODBJMXJPZlFOWmJOZzdxcWtWdG5DeUNaSVVPaERTanRy?=
 =?utf-8?B?d1JCYjVpSS96N25JY0lnTEg4aVlxam43OGd3elE1SFB2MjNMVmFsYm52THIz?=
 =?utf-8?B?STlkRmpqUXFiUlVVbGhKM0l6Y2czc1Z3Rk9wVlVXeHJER2pzTVRLb1ZtRFpF?=
 =?utf-8?B?SlRJblpqT1NVMVUrWktncnF3eDlhZmxWbzdqYUVIR3VHVFh4dStMQU5nK1hX?=
 =?utf-8?B?dFBQdkNRUWlka0RCMFMrcXAzVXh1OUF0R2ZlQjZYR08rN05paWFYV0JhaWJr?=
 =?utf-8?B?OVFPWmZVbW1USExZa3pqZnY0OEV5N0M2UDhJV04xdHBtaytCdElid0dKL3hk?=
 =?utf-8?B?WFd6a1NJbm5Ublh4enlpb0l3eXBkUlo1LzFGRzUzNEdsalhib2JSOUl6emlE?=
 =?utf-8?B?YS9WYkZFcjJyZlVpdTRGK2dmYy9PY05kNU1WeVNieWRYWkI1eVExa2hDeU1z?=
 =?utf-8?B?UVoweVBLTUZLbnByU3FXNHR6RkwwV1lTc1NSZlN6WDg3ZitSZVpaOFdkK0I0?=
 =?utf-8?B?Z2hkS3pnUS9pYTdGOVpQRE1kTDd6RTU3VHhpT0JFdFVIZWF3SnQyY0U0NUl3?=
 =?utf-8?B?RWR5Sk5rLzY2VFRCVFVTMFNuRm9FSTh4ZDByckFGYmw4OGpFcXVCN2duUUN3?=
 =?utf-8?B?ZXhoMUhhVkkvVzBrMlp3N01Sak1GV2pWZ0l6SGpHNnNBQmVpUG84TFJkcWtk?=
 =?utf-8?B?Rld0RzVxem5mVHM0TkFVdEZqcTZWRThjZi80TndOb0RKV0pzNUQxZFRvRUgz?=
 =?utf-8?B?dW5rdzc5OFMzV3RHZm1UU0d3bmFUZ3pqQlYyNXBzb01SbVAveDJZdEQxZmMx?=
 =?utf-8?B?MFExQ3p0bjFtT2pCTENibFRMNHJPelFpN3pMVmxLZGlPa1ZnNWFuejRuWkMw?=
 =?utf-8?B?MXpuY0s3a1k4S3p6WnQ3M200emVCRTFVNEJvbTFWUjNVUDY0RDNucmg5Sno3?=
 =?utf-8?B?alBRa0ZiNVRYSmRMT0tNdzdrcExVRHhieEVhaFZNRDBUelJ1QnpvQm50ZEVY?=
 =?utf-8?B?VmNCdWZBa1dTeGZUV21rWDNUSE9TRmRaYmdNNEttL0NDUlgwM3Z3L0JXSzZm?=
 =?utf-8?B?UFFmZVZSRXFhOWVnUm5SRk54RkZydTFMZHR4UFhKdCtaUlN2eXRGeStHL2p4?=
 =?utf-8?B?ZmZRcEVXSTZ1UXl3aS9weGJGVmRyUVdFeDgzRTlFemZPRVBEd1pDTGNrNlRq?=
 =?utf-8?B?WmFPUDkxdzIwNHIzWFQvUk1YM3V6ZGw5d1dRdUZxU25IS1BEaTZXOVNyTnRm?=
 =?utf-8?B?VkltdW1CTEVPREN1bERYQmZlOGN1YjZaUHVsaHhWdUU0VCswTFpFYktiTXk5?=
 =?utf-8?B?YTJYdHQxVXpXWDg4MnZ4SlUyUzBZdDhGN2c4dytPUEpyVHlBdXd5Y0NSaFNq?=
 =?utf-8?B?YllrWjJHTFlVVUdycTdCTlFoczhhdmFydGhIY2NHRjduZm8waUdvdTBrL1Rq?=
 =?utf-8?B?QXNya0dCZDZRaGp3WlpMbGJKS1kzbDhic0thN3QyQmdhSnJPb1doSEhOYktx?=
 =?utf-8?B?YUtFMFpUQ05sTDk5dUZwczdlSldRejZHTzk0L0N1OVdaRk5ISFhFY2VTN0dS?=
 =?utf-8?Q?C5h8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 09:21:04.2940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb960636-db59-4ed5-c590-08de2ff1c93f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9826

Hi,

This series fixes issues in the devlink_rate_tc_bw.py selftest and
introduces a new Iperf3Runner that helps with measurement handling.

Thanks,
Carolina

V3:
- Replace generic Exception with specific exception types in load.py.

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


