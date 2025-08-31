Return-Path: <linux-kselftest+bounces-40374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DA1B3D14C
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 10:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0D0189C85A
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE79244660;
	Sun, 31 Aug 2025 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KmKsRK9C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEDFC0A;
	Sun, 31 Aug 2025 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756627650; cv=fail; b=M84AUSyFtMOs7lDpntVPzUz+aFqKlEexJKwpQANnxb6QrEd4uv1WV04Bba66N5ah0VDCXMvicEsLFfBqF++xIdbvkRlHweWpsXG0rM6O2FcJSxnQ6BdnBI0xjM+KUuWBPMr4EndazLMzkBNlZz1CwQeI8j/6LA+WJoHqsrxWo+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756627650; c=relaxed/simple;
	bh=uYGLG2TKhZQIcMFT3ev6fX+gIPfuiXxkR/5/TWj2JjI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cWDx/bm8XFCNd6BQVjl2qMUx6GRu71g4HCkgdHGhx2EZ/jfKjsaJhWRwNDaw4pCE/Gy6ZBhmabzlvqC3blX/8H0IPgCMxiX4RCDHY4gXB58O+7n6Wva9pf3x6KlxzsIaoMhw3E9Lo8JIXcQvAM+RMIHF0LGfwFhQn4GHhjkvoLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KmKsRK9C; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbuZ91NmEUj7g6uoo+b5qntCvmjwkEYO5dPGg53ItyNyflrhSPbx1VGSzbj6vh2pgPZKeMMVcWOx+na9HXOEvxXmRHTaWAR1/LfB24sY/lDNtv7w27+fU3NSrZtwcgf4soZRyYRZeBMuPohCwQZVIRREbbZoPK2JWuz6dAE6SlFJklP8ynthjqdDQTMkjxzaKF1fu9ffvObDofxPHupbV99fXn19bLjSY+97thFtg5u1cKjQgLolMI4CTgVGlY5nAcycgKBs6wHGaVMBXktG0TXEYd0GmjLACxfpUryN/65K80E2YseN6vjUrPev0fIg6f1cyxgNdrZ6pc2ycyp3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeeelKBCgIUQXqH6qQq75UAphD1IyhjnPxqqgOi4NyI=;
 b=OzSSj99Rjg/CLl2NwqEPfzz4h6DSO1Z13fu7GEvo69weyqbGsCBgcybPeqie6ZGa9zNuASNj0PtsE+HXcahS+IA4geyWaqx43XVY3d73wJj+2MESkonM8KCRIUU0U8pHhreEB30OeqmIYzj52wqzMNaSHpr7fYzpHcaJcLnoHINRVgEkS7hFaOC1C2HT38ZSgf/4RrXoZNHzBL2TCKL8TwiHs6ZygrhG9ByJCD7c7EjYuQeW1pgtLoygdx8UoV6usPDTsEhPsVe7fHYGdDGQfXmzrQvBM9g2YdNwgZSHs6BuN/e4dEv+tCydRgavT/ftFVd012+VkFYIGLyg6tyt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeeelKBCgIUQXqH6qQq75UAphD1IyhjnPxqqgOi4NyI=;
 b=KmKsRK9CRtT6Y01mKyd46tPdLhoyP6m0Usej+wM6fT/m6Y0GvKfGUG+vtoHOb3OqEIU2uCoKrqJ4bnoRG41v3YnpeJbKj3jIdt2DGIi/Qdh1qrDGsr2KIQegTtmmvqkouZ0enJjFQtpnfYcVJ3L34/tLlRUXtsIIKNT4afWCRr6DBgeCvvJ/YtM0IjwRXzmBKolBrlKtfxe0QJf/pIA4Jadvo0eFcvMP5KKxA+gwaFEEiw1TLDkTJsXsbJ2r1Nf0bmwjKT0iRKEAtB63J+Y0rOe0tOoqMv4ZCGHmcgVS/5zwdx1uuHOCKtTBAGa/1mrA4iQO1zbvjN2J/tPUlrhhGA==
Received: from DS7PR03CA0291.namprd03.prod.outlook.com (2603:10b6:5:3ad::26)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Sun, 31 Aug
 2025 08:07:25 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::5d) by DS7PR03CA0291.outlook.office365.com
 (2603:10b6:5:3ad::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.25 via Frontend Transport; Sun,
 31 Aug 2025 08:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 08:07:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 01:07:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 01:07:04 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 01:07:00 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 0/3] selftests: drv-net: Fix issues in devlink_rate_tc_bw.py
Date: Sun, 31 Aug 2025 11:06:38 +0300
Message-ID: <20250831080641.1828455-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c8f344-cc9c-47e0-c251-08dde8656b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RExZeS9XMWtycWRzNEpLd09reGpPcGV6Sm5GOHRnQ0pTUlVzOXZVL0RIUElM?=
 =?utf-8?B?T1YzTU1hVTZiaWNtZHBQQy9veWVpU0RBOWV2U0g0SGdsUlZUcUNrRHlnU09S?=
 =?utf-8?B?ZFAza255MU1NaHdVUXcwdHoyaDB1d0QwK3JIRFFwNk9JaS80TGM4bGZacXov?=
 =?utf-8?B?TEpneCtPMTNGZitYQkdxQmpvVmxxS0c4b1BOdUVwNUoyV1JHTm9XckJKcHZG?=
 =?utf-8?B?RW15MkJCTWVtcXhCR240djZjT1dVeXBucmRyYU9oZllQRm1NZGY3ZFNFUDdh?=
 =?utf-8?B?dFc4eFYvYUt3cExsQWs5aC9tTzliU0Fuc1Z3MzVBbURPTUtVTWsrNFE4czhp?=
 =?utf-8?B?U2oyQXBVZ3M3MjVQejJJNVJOL3V6TDZJQ0N5YjcyazFBWm4xSTc2eXRzZkh0?=
 =?utf-8?B?RnhhZkNsWDBreGVneXNHY3lrczYzK3diS0UxazJ4OFAxSjVMdjRXbWFCMHUz?=
 =?utf-8?B?dWRmREFpb0p1eURVTHg3VnNjN1BQb05TVTRZejEzdzhTOVpFODVKV3VJdjcr?=
 =?utf-8?B?eHBDSkRiQmQ2bk9CdGtCQk5jbTRYaG5CZkdIRDhCeHMvRDV3aUFPbUNGN0Vi?=
 =?utf-8?B?aDJZbWFUaFJORmJnU3g4eG11WGtxOVpBc2JEd1diaHRSNmFVQnc1R3V1bm84?=
 =?utf-8?B?S3gyZ053Vm9Kd2hnbU9LVXFvUThjNmFwR2NVcW5sTE9ldmFBMzdNcFhOdDV2?=
 =?utf-8?B?TE9icmZkeFFFT0NyR2hHMXNOMVZ6L3hWU292elNvc0FyK2ZlZU5pajl0cUFi?=
 =?utf-8?B?Ny9kdmg4ODNOVWJ5NWlmcmw4SnZTUlJjdUNoSytNTWtuYjZZVlZld2JuUmpD?=
 =?utf-8?B?YjJ6MEVaQVp2NnNQUlV4Z0ZZWnE1eVBpOVlmNUdhZG5xbDVmMFlkSDcyZDhq?=
 =?utf-8?B?dHhDUkFDd0dBK0U5aEdtVG9YOTNXTG8zNFM2QjFZdlVoTGZlRkFIQmNnRlc3?=
 =?utf-8?B?ZDIzUnFVZ3QzTmRmY3NEM3pXTUhHM090Y2JoMWRQVWpBUWlvM1BsTXFSdzdJ?=
 =?utf-8?B?bDRKUWNEeDBZRkNCN2FyOXJLNjBOcmdnWElEOS94WGphbFpQWFpVSGlzR3BT?=
 =?utf-8?B?OTcyblVrQ1lUYnk0MDZpR2ZZMkw3QmVUSmJkNEVnVmpib1pQc2V4TEk2eEZo?=
 =?utf-8?B?dmR4TjhjRFQ0dlcvSjM4WEhzY3N0NVR2aWZpRUlMLzZHWElZWUtPZVZrNXpX?=
 =?utf-8?B?RnZBRVBaNmdlY1RUVTI2QytMWHRROVM3UTR6ZXg0WmZadnk4WlZ0V1BjRUFw?=
 =?utf-8?B?KzU0K2NjVnVLY1FJSEdTdFBGTkU1MFh2Ump5SFU0R2J0Y2daQ1JQekRnQUtW?=
 =?utf-8?B?dmx1TEZubUNPZWF1SHk2SFhJN0dUaWZvZHJsY0wxWUVOMi9IdStYV1dPSzRy?=
 =?utf-8?B?ZEwzYlFxdUZDNS9vemFVUnhNWUk2T09wdEZySVhWYTBzTjJtajNrMmYrNkJl?=
 =?utf-8?B?SU5wam4zd3N4Nmphdk96dTk3K2cwSVFIVnVPQ3NsY1RGYjlkY0lWT05aamRr?=
 =?utf-8?B?KzgzOXNGbU5PTm50WVRDTmJneXRyWWF0TUxRSU05K2YxeEtmaXVWeWNWQmFF?=
 =?utf-8?B?WU1wZFh4QXYwU29va0NydHJNNFY1RlRmVk5BckFZR2xzRUUxQXJ4eXVNb0lD?=
 =?utf-8?B?N2Y1eHlkMCtLN05Uc2YvbThXSGxNMStDM3IxSmI3Vm5ZNkd0K0plSnlyVkJS?=
 =?utf-8?B?RHBBR2VOS0JYbVpXUklucGhHbENDbm9SNGN3czZHWGFteVJzS3JUTGZOdUpJ?=
 =?utf-8?B?SkxZY0E2UzFVTjNVckJMVWJoWjJVMmQ4K25xTUVtbERCY1gvbUZNWFBSTlhh?=
 =?utf-8?B?aGxHbm95cFBaNWRacWRERjdnTXNNOTc0b05KaUcvUGdYWGEyK1lWZEw4RDB1?=
 =?utf-8?B?QW9ESm1hWUh6WUV4WWZneHFhK3A3d2FpM0djVGVlbDRRazJ4NDB1M3lFWjAy?=
 =?utf-8?B?RVM5OHVwL0dBNHJzcFZGUE1vMXFocDczY0FNMkVxcjlsYlJkSS94ZEdKc1VV?=
 =?utf-8?B?MXkxbWdQQUwxN3ZHc1V5NmhqWHhldVo2VXFtVTkxSXNHN2RLK3VkY1RPc25N?=
 =?utf-8?Q?HssgFw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 08:07:24.7764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c8f344-cc9c-47e0-c251-08dde8656b93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

This series fixes issues in devlink_rate_tc_bw.py selftest that made
its checks unreliable and its documentation inconsistent with the
actual configuration.

Thanks

Carolina Jubran (3):
  selftests: drv-net: Fix and clarify TC bandwidth split in
    devlink_rate_tc_bw.py
  selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py
  selftests: drv-net: Relax total BW check in devlink_rate_tc_bw.py

 .../drivers/net/hw/devlink_rate_tc_bw.py      | 102 ++++++++----------
 1 file changed, 44 insertions(+), 58 deletions(-)

-- 
2.38.1


