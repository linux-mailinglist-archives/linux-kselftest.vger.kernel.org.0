Return-Path: <linux-kselftest+bounces-35790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED98AE8C65
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 20:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C047C1BC61DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6F2DA759;
	Wed, 25 Jun 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VcTLptKK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DCB2D8DBD;
	Wed, 25 Jun 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876260; cv=fail; b=o/35ovdJyt843AfpWEKQXIz3a7NggedrfaXepC0siQCcEpTQBorPmzRYIjHSOqzLlqhdBYMy+CSB0QU98cdi3YXc4eQP5sgTT4enpQxnz1e4olO7XQ5n9i8C622PGtomw/cLggN0CCr6adEs9d9i7gW2aK7Lo41OIOY5jxQb4vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876260; c=relaxed/simple;
	bh=5LIJVIBurrFXH9Xqp8gZBvl0Y9J6Up9soWxc5yghu4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SZEu9P0TxgW/8e+kZiNV+KFyRH7rLF70XPA8GMpyE+iysqjwc6kMuzAAjShg1zmht7h7vWCr1C1IY2WYcaQTDk6gLLF4xirAmG4vXlH0Hw54RvS87I2YtZHaI5GgE0FbrCyvWyFfPEed5hEmo/dy4xALyNIU7Ev6HKq7pyjd/9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VcTLptKK; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAqD+FohXFL04UK6TT6cUvkOCGj6tk3GhNXPoSsmpFZ3f/EePGcdDl08VAgfHpL/4HTVekMEfHQ1Khe0tPNIGNEyGumP3DysemMI1bb9rwrscgSLjI+FFrI3/c6DInJo10tBKYDQN5ZF5hah7Xvw04zh9W6ptWknIICMZMJZwJDJqtk6HiMCDTMTJP/PX1mrr6VDYm0smr0CpJe9125J4bv2ftsSuJEV1LYEu4e5Q7AZutWlxSwzrKB12D4IRd5Lu+xAEa7ui0Huz24m634xyRre8Vmbs85usfcAoxO9SJYaOZi3ZzhW8wHcQqM8ICFXX4UGpM0hDxCkRC77iOKeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbzXMkpouc+mIYHMIF0trCD5Z4uJyghcl44Ay0BWKt4=;
 b=G8GMbYXYgYTjESz/+tc/DjQZD/v0BJ5AvYETCGWwjAzOhwhNiRSLUScYKUKW0q6Xlvby5uh/9pqtFnjPdX3FjddIUamEc4aGIL3PQKlK2db4KkjxuDCVVsmq23PQa0rFWw+b10gIfiLKJSJmiZQ0KI5+x/N4DA9bGbOZYzCIjfsuyOqW2Jy2GYQUsvlitQXKNkTONNB7Jmh6lRZ+T+ly9vYNrgNhxMTOzvWcjLafLpxH+WhiM3A2DxD4E0UcbsBBTHsVkeJOFI0SC4N/MC0ZNGuL28oRyfyhP6k5to77fYINkp34oUPe07SJd29pj1K/yCgpMhc1H3MD0MgXAr+M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbzXMkpouc+mIYHMIF0trCD5Z4uJyghcl44Ay0BWKt4=;
 b=VcTLptKKDFNkfWBrXqfSZx3Srg5eXZoI8a0Jj5fwwn4cMAYVVMSakaS4B5Z65ETrHRoAOYAiTHyKEzo85tFYRGCE1dp0y9YLlpp9wgRKxK8N3W6YalnGNnSu8xpauTCSoJWRLBT8K+vD4lnymPyf7Ce3ujQQnutpp2FfhaY4O5SFZk7K35JH/TksP5In0UGLJHA1dUFZx2EBl/P6d2BwQ5oeMDkB9kAtarvHwLhQcIeDgGeueq6jAspZZwbpa7Hdx7dhT6eixAxXChpToQ+rs3A/2Ajk+8MnN+Kv8+IVKe6v3sHSGZpZrHu7RxOLVSlPSARcF6BVl94YqCJHEiDrPg==
Received: from SJ0PR13CA0201.namprd13.prod.outlook.com (2603:10b6:a03:2c3::26)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 25 Jun
 2025 18:30:54 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::41) by SJ0PR13CA0201.outlook.office365.com
 (2603:10b6:a03:2c3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Wed,
 25 Jun 2025 18:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 18:30:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 11:30:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 11:30:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 25
 Jun 2025 11:30:21 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
	<leon@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
	<okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v11 0/8] Support rate management on traffic classes in devlink and mlx5
Date: Wed, 25 Jun 2025 21:30:10 +0300
Message-ID: <20250625183018.87065-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: 120ca019-7131-4397-0bbe-08ddb4166ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWJrQWFmRHk0VDFKMkU4aWFWUnl3dTYyTFE0WWVWaDh4dnkyS3BoRDRqNlgr?=
 =?utf-8?B?Q1gzdXJ0dkp5UkVqcWZ3RHgzajdYcWNzUy83QllOaGlQQ2o1Y1FpNWFFNk4z?=
 =?utf-8?B?bzhZUVVUZTZaT09GYUpRL1Z0aEFKYXRWNWdYMitHcjErOGkzVXJUY25jNklm?=
 =?utf-8?B?cEI1UTkzWHdwZU9LeVZuaEZpUHgwYTFNdTRMUlFtbkdlT2JES014SkNQYSt5?=
 =?utf-8?B?T2JQdk5ScXJhNHpDYnhJVENWWHpyVXFrcFdVTVZLZGRBeTVBMUdXL04rcWp3?=
 =?utf-8?B?UGUxTDIrSmsyM2RjeHJhTEhMSU4vdmwvd1pTTUhhWEtpa2xobmk2eVN4V1F5?=
 =?utf-8?B?OTZzMWxPTkVxMTFwSEhidFR6SmoyYjJST2tEYW5taHhyTUZkanFnVDBrZk5E?=
 =?utf-8?B?Y0o5ZGNrM3dMSHkwaEJHWU9Nbk5sYk1kR2tscmhWNmxUV0VyWW5TNnVUUUtt?=
 =?utf-8?B?MGNUNkkxNmR1dytpYmtqSWNlZHlnejFNTzhZRGk3U3hyUS9ua2JuTjBRc28x?=
 =?utf-8?B?Y2gyYlZoeHVrSHdpZXpZakpVSnRwSlBnK3lVWUVkU2xyZmF1aFRZTUZNZVhG?=
 =?utf-8?B?bHpzTUNjWVJLY3JYb2U3eU1qTEY1ME05c0VleTI1Njd4RENnRXhHTkJQMSsw?=
 =?utf-8?B?RzlDbmEvUmpSWmRNRCtTY3B3N0JDOHNpZDd4Q0JvMzVTWTdQY1R0eThzR2pP?=
 =?utf-8?B?UFVlTHZJSkZsSFpIVzRJNTNXWUwzWGljZjVpVGF5Um1ORThpeVcxMUEyd3g1?=
 =?utf-8?B?TUVOVGhBcGg4dGRGb0VZL3dSN1JTWklpeXZFbWlZTDBJSGxXZ3FHd2JoT0JC?=
 =?utf-8?B?UC9sbmhtVkx5cjVhVDF3L3NpUFAyNUphRW0yUU9ZdmZjWVh0YzlLdHVFYnRi?=
 =?utf-8?B?Y2l4Ry9wZzk0bURxSGVGcVArTlArMGExR3hpSkl5QlFKSEZBV1cwRmliNDJj?=
 =?utf-8?B?V0Q5OEdrMmozcW9CM3RSUmU0ZnBLVVlBWGh2Wjc0NUtTZWxQdlJVY1B5ZDR0?=
 =?utf-8?B?OExQRFRackplTDlPVlhuWWlYc1VGUWZrV0QwdnpMeHNZSWdCMXMxYWpIWFVI?=
 =?utf-8?B?eTI0eUl4dkRVdDF3RXZBR1k4WWI5T1I2Q2RMclc5a0kvZ1JUVEF5eStRQWxX?=
 =?utf-8?B?ZUhiMkFsWll5NWZHbTVzb053Y1NwemxyOEZDaXpLTm9YQUFlZjNJWjBQOTZi?=
 =?utf-8?B?Vy9XQzFMZ2kzR0krS0d5aGtndGFsMzdDbVZDWVlyRHZoRlo1ZGt2eWIzbXFk?=
 =?utf-8?B?K01nMU1zRUZTMXhlc0tLNW4xMytlREViMEt0KzRNRzZNdm1wQ1k3SVFnbkFC?=
 =?utf-8?B?c05vVEQzeGVSeWZxcTZ6NnRsY0RjbzhnbElNN1hVQXZFZ3NJQThYbGtWeEtO?=
 =?utf-8?B?ekZ4Qy9GSjZKUHpibWFDRnVuWGJ6WnFOY0Ruak0zZ1hGQm11djFnNTg1N2dq?=
 =?utf-8?B?L3RUNy9iY1E1T0M0ZmJvUzAyNHlXMjNQa0oycnhVbHlvMXIzWEVyTU9XdFYr?=
 =?utf-8?B?bWZpcjByeHRkNzhTT1ZlTW53Q0RqT0xRTWlncDN2Mk5MVmxGbFQwZnFISytB?=
 =?utf-8?B?UjkrVnJhTzMwNGtnRnRqcU1WVTZvM3BWVTVRSWZqNnNjdkJoZVhtWEhMU0RB?=
 =?utf-8?B?UXlSSHI5UCtmelRwOGdmcnFvY2JENldTY3dGKzdzVjM3ZCs0NFl3NE50L3JL?=
 =?utf-8?B?bkNsY1VsWTNGNGg2cDdpeFVEa2pKQXBtUlZXMEM4OUJ5NlMzYXUxOHl1bzhJ?=
 =?utf-8?B?alhhMnhKRm1WRUw3Vk9JVUdycElDemJieVlweHNNVjNNMENmeTZvUmMrNDlw?=
 =?utf-8?B?QlFKK2h3Z3JYTTVOQ0kzbUlzVHg2eDZXaEpIdWRCZnBGWitBU1A4cjRsa2pK?=
 =?utf-8?B?R1FteTBWV2lTcGQ5V0JpS2liVVdwcjRGUUJsSGVtb3c0SGdBb21JOTE2VlNn?=
 =?utf-8?B?ZENneVVCWW14WXQ0SUhIZGYzY1YzWXprcTVSbE5aWkVKazhkWXQ0bjFTUkJ2?=
 =?utf-8?B?VGlHSjc5SVowR1J1S2pOZDJhcmVCZ0dNUW4rbnZaSkY5SkNaL29TenEwWU5n?=
 =?utf-8?B?alNaVklaWGZ3dEFhNkIzQUZXNCtmL3hFbCtuQT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:30:52.9433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 120ca019-7131-4397-0bbe-08ddb4166ad4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637

V11:
- Refactored the devlink code to accept relative TC bandwidth share
  values instead of percentages.
- Updated documentation to clarify that values are interpreted as
  relative shares.
- Refactored the logic in mlx5 to support proportional scaling for
  tc-bw values.
- Switched to `nlmsg_for_each_attr_type()` for cleaner attribute
  parsing.
- Added a hardware selftest to validate TC bandwidth behavior.
- Refactored esw_qos_is_node_empty for readability.

V10:
- Added netdevsim selftest for tc-bw ops.
- Dropped header: field as it’s unnecessary for local constants in
  devlink.yaml.

V9:
- Defined DEVLINK_RATE_TCS_MAX as 8 in uapi/linux/devlink.h.
- Replaced IEEE_8021QAZ_MAX_TCS with DEVLINK_RATE_TCS_MAX throughout
  the code.
- Updated devlink-rate-tc-index-max spec to reference the correct UAPI
  header.

V8:
- Limit line width to 80 characters in mlx5 changes instead of 100.
- Increase the scheduling node levels to support TC arbitration.
- Ensure parent nodes are set correctly in all code paths that extend
  the hierarchy depth for TC arbitration.
- Extended the cover letter with the ongoing discussion on devlink-rate
  and net-shapers.
- Extended the cover letter with the Netdev talk link on this series.

V7:
- Fixed disabling tc-bw on leaf nodes that did not have tc-bw
  configured.
- Fixed an issue where tc-bw was disabled on a node with assigned
  vports, ensuring that vport->qos.sched_node->parent is correctly
  updated with the cloned node.
- Declared a constant for the maximum allowed Traffic Class index in
  devlink rate.
- Added a range check to validate rate-tc-index.
- Added documentation for the tc-bw argument.
- Add a validation check to ensure that the total bandwidth assigned to
  all traffic classes sums to 100.

V6:
- Addressed comments on devlink patch #3.
- Removed first 4 IFC patches, to be pulled from mlx5-next.

V5:
- Fix warning in devlink_nl_rate_tc_bw_set().
- Fix target branch of patch #4.

V4:
- Renamed the nested attribute for traffic class bandwidth to
  DEVLINK_ATTR_RATE_TC_BWS.
- Changed the order of the attributes in `devlink.h`.
- Refactored the initialization tc-bw array in
  devlink_nl_rate_tc_bw_set().
- Added extack messages to provide clear feedback on issues with tc-bw
  arguments.
- Updated `rate-tc-bws` to support a multi-attr set, where each
  attribute includes an index and the corresponding bandwidth for that
  traffic class.
- Handled the issue where the user could provide
  DEVLINK_ATTR_RATE_TC_BWS with duplicate indices.
- Provided ynl exmaples in patch [1/5] commit message.
- Take IFC patches to beginning of the series, targeted for mlx5-next.

V3:
- Dropped rate-tc-index, using tc-bw array index instead.
- Renamed rate-bw to rate-tc-bw.
- Documneted what the rate-tc-bw represents and added a range check for
  validation.
- Intorduced devlink_nl_rate_tc_bw_set() to parse and set the TC
  bandwidth values.
- Updated the user API in the commit message of patch 1/6 to ensure
  bandwidths sum equals 100.
- Fixed missing filling of rate-parent in devlink_nl_rate_fill().

V2:
- Included <linux/dcbnl.h> in devlink.h to resolve missing
  IEEE_8021QAZ_MAX_TCS definition.
- Refactored the rate-tc-bw attribute structure to use a separate
  rate-tc-index.
- Updated patch 2/6 title.

This patch series extends the devlink-rate API to support traffic class
(TC) bandwidth management, enabling more granular control over traffic
shaping and rate limiting across multiple TCs. The API now allows users
to specify bandwidth proportions for different traffic classes in a
single command. This is particularly useful for managing Enhanced
Transmission Selection (ETS) for groups of Virtual Functions (VFs),
allowing precise bandwidth allocation across traffic classes.

Additionally the series refines the QoS handling in net/mlx5 to support
TC arbitration and bandwidth management on vports and rate nodes.

Discussions on traffic class shaping in net-shapers began in V5 [1],
where we discussed with maintainers whether net-shapers should support
traffic classes and how this could be implemented.

Later, after further conversations with Paolo Abeni and Simon Horman,
Cosmin provided an update [2], confirming that net-shapers' tree-based
hierarchy aligns well with traffic classes when treated as distinct
subsets of netdev queues. Since mlx5 enforces a 1:1 mapping between TX
queues and traffic classes, this approach seems feasible, though some
open questions remain regarding queue reconfiguration and certain mlx5
scheduling behaviors.

Building on that discussion, Cosmin has now shared a concrete
implementation plan on the netdev mailing list [3]. The plan, developed
in collaboration with Paolo and Simon, outlines how net-shapers can be
extended to support the same use cases currently covered by
devlink-rate, with the eventual goal of aligning both and simplifying
the shaping infrastructure in the kernel.

This work was presented at Netdev 0x19 in Zagreb [4].
There we presented how TC scheduling is enforced in mlx5 hardware,
which led to discussions on the mailing list.

A summary of how things work:

Classification means labeling a packet with a traffic class based on
the packet's DSCP or VLAN PCP field, then treating packets with
different traffic classes differently during transmit processing.

In a virtualized setup, VFs are untrusted and do not control
classification or shaping. Classification is done by the hardware using
a prio-to-TC mapping set by the hypervisor. VFs only select which send
queue to use and are expected to respect the classification logic by
sending each traffic class on its dedicated queue. As stated in the
net-shapers plan [3], each transmit queue should carry only a single
traffic class. Mixing classes in a single queue can lead to HOL
blocking.

In the mlx5 implementation, if the queue used does not match the
classified traffic class, the hardware moves the queue to the correct
TC scheduler. This movement is not a reclassification; it’s a necessary
enforcement step to ensure traffic class isolation is maintained.

Extend devlink-rate API to support rate management on TCs:
- devlink: Extend the devlink rate API to support traffic class
  bandwidth management

Introduce a no-op implementation:
- net/mlx5: Add no-op implementation for setting tc-bw on rate objects

Add support for enabling and disabling TC QoS on vports and nodes:
- net/mlx5: Add support for setting tc-bw on nodes
- net/mlx5: Add traffic class scheduling support for vport QoS

Support for setting tc-bw on rate objects:
- net/mlx5: Manage TC arbiter nodes and implement full support for
  tc-bw

[1]
https://lore.kernel.org/netdev/20241204220931.254964-1-tariqt@nvidia.com/
[2]
https://lore.kernel.org/netdev/67df1a562614b553dcab043f347a0d7c5393ff83.camel@nvidia.com/
[3]
https://lore.kernel.org/netdev/d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com/T/
[4]
https://netdevconf.info/0x19/sessions/talk/optimizing-bandwidth-allocation-with-ets-and-traffic-classes.html

Carolina Jubran (8):
  netlink: introduce type-checking attribute iteration for nlmsg
  devlink: Extend devlink rate API with traffic classes bandwidth management
  selftest: netdevsim: Add devlink rate tc-bw test
  net/mlx5: Add no-op implementation for setting tc-bw on rate objects
  net/mlx5: Add support for setting tc-bw on nodes
  net/mlx5: Add traffic class scheduling support for vport QoS
  net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
  selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution

 Documentation/netlink/specs/devlink.yaml      |   32 +-
 .../networking/devlink/devlink-port.rst       |    8 +
 .../net/ethernet/mellanox/mlx5/core/devlink.c |    2 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 1037 ++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |    8 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   14 +-
 drivers/net/netdevsim/dev.c                   |   43 +
 drivers/net/netdevsim/netdevsim.h             |    1 +
 drivers/net/vxlan/vxlan_vnifilter.c           |   13 +-
 fs/nfsd/nfsctl.c                              |   36 +-
 include/net/devlink.h                         |    8 +
 include/net/netlink.h                         |   14 +
 include/uapi/linux/devlink.h                  |    9 +
 net/devlink/netlink_gen.c                     |   15 +-
 net/devlink/netlink_gen.h                     |    1 +
 net/devlink/rate.c                            |  129 ++
 .../drivers/net/hw/devlink_rate_tc_bw.py      |  466 ++++++++
 .../drivers/net/netdevsim/devlink.sh          |   51 +
 .../testing/selftests/net/lib/py/__init__.py  |    2 +-
 tools/testing/selftests/net/lib/py/ynl.py     |    5 +
 20 files changed, 1823 insertions(+), 71 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py


base-commit: 8dacfd92dbefee829ca555a860e86108fdd1d55b
-- 
2.34.1


