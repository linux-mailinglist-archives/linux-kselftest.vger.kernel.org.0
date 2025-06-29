Return-Path: <linux-kselftest+bounces-36070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B179BAECDBB
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 16:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B3E3B0346
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90521A443;
	Sun, 29 Jun 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TyW98Ib7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF451EEAA;
	Sun, 29 Jun 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751206938; cv=fail; b=jqRHXKPkoxJu5NYSqJpCRcbrgufC6Nwvk0N/a9q7lmL9pR2aYtx5BMREH0BSgK9Yp7noTPpxlkl9lnyGhPEA4wrk6DLMQJBVv26ci+s9TrhmgTmlvwiWd0r+iQRATy2VW3wEEBE5vOLkKmql291pmMeNwqtvZK5Xg5sY0uxSCyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751206938; c=relaxed/simple;
	bh=BguI7W+CJOFrUhR1uymRN0C0ibRSkddLNbjlZ9akdvM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qofTQBslNfu4pKaQ3jmU0Lppn3sYgM2inTYcgjtZd75W779qsi0gmNAIQjaOJFZGKiwtRs5yc/wUiFrK4pinh2r4n5iZNt0qtmldgdj23/cW6fwB1ju3jtJagAmMUM/dgdXr27wyqhB+TJ8DYYfEeMxzYJBMcOpbzgo/n4TfwXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TyW98Ib7; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXOHQmO3oY7ueUOImRw9GZxX8nfgpiUee0y+Zw2RPkuhMbsf5+2+n7nSo7Y7O54pzGVxjvYos98vgKXMKT10o7Pc6udAPmEBeGEJSYOJEVUH93nX8Cb25+SAvBwl5/LqgVMiiDAObLGV8V0v5KL9tDyHYNd3AMK2bn/rowtpr4pZV94a8lKZRich5Gve6mht4RAsIwHvFzelsWLsoEgfYHtLt8l8t+uBGVYiTiVRm6kxaHZFWL14jjFnvNYEn51JrP4zXObVXseaGije/0Ew1uVItIKHy6MWkq4wCYrXmi0M99b9d46hoO4ukI+N80ytxM0NH7etm58Ak6TsXJuI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z79gqoUg4C4xurxqSSZKjsmYQ0dK4WYNj/G7ujveF4=;
 b=FicnuPJ3tuweQmeFCAydJbXhMfxs2eQ2TStmV6USyhG/heZnopLri//iDGWJX6w4qKXt0tdVqxZHasx42EnSC8puJTLR+UDgNYOpYxyzPicMR4hok1cUT5xRYZWWnJMk6+kjhYVJIEvyvtoLN1F9kUCajOgwyOuZWdWBsVlQTID5MMxbxNOpiUnol4NMO6VnVcmNq+pPQeOXGmfgzrDpj/dMbnpJe4uoLKcHTy8YkUcHPCl/7Q+d0PQ6tpdxhPu2fRvfmBeTXNWT4/cO4ctZh5yPsFEdhgEzZCSGToZqdE4Ecpz9K06MfGk9n+oJcgj/VTpeqtmg8ubd/DMD/tX2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z79gqoUg4C4xurxqSSZKjsmYQ0dK4WYNj/G7ujveF4=;
 b=TyW98Ib7Ha0lOOb5a7r5b/EWgX/o6gExlfeHCZjst5bWZ6LodDcuSqC1tiDDXD5E7pnTaCNf99YXJlyGhScQ9cgsZh/TA1/mqWRpDU/w0IGpgRU13F+4qNzPr71Wc5BLPv+KvigULdVLwFuhMi7PTbUHWdngHQfmZuaCkKvJ04rbOY7hz001kDVmXsxp5ER2jt/pBCRewz1SjuOoiTDNp2f5fuKuceHhK6nucFsiaro4kdAsjKqCpQzqrEVN0kwClDrR07UtAndbfzzCsdlvoQyvR5rs3UBloD/o+9wolrTPC4dzYvvV4IvetCCGKn9yTzu8XJPeJPOyME/dOPWM9w==
Received: from SJ0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:a03:3a1::26)
 by DS4PR12MB9771.namprd12.prod.outlook.com (2603:10b6:8:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Sun, 29 Jun
 2025 14:22:10 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::25) by SJ0PR03CA0381.outlook.office365.com
 (2603:10b6:a03:3a1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.28 via Frontend Transport; Sun,
 29 Jun 2025 14:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 14:22:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 07:21:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 07:21:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 29
 Jun 2025 07:21:51 -0700
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
Subject: [PATCH net-next v12 0/8] Support rate management on traffic classes in devlink and mlx5
Date: Sun, 29 Jun 2025 17:21:30 +0300
Message-ID: <20250629142138.361537-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DS4PR12MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: b4eb55f3-298d-4002-727c-08ddb71855ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEs4ak9SSENnbWNPME1LRXY1WE00MHd6N2UrTnN0SlFGL3ovSEVGd01Dd3B3?=
 =?utf-8?B?ZUVUUUp1Q2RZaUM2VGxML1Z4aTE1T3JtYW12NWxaU0hhZHJwcnljOW1DcUl0?=
 =?utf-8?B?d3crcHREZjBRellscTBaNmRlR3BnT1FnbE51aVI0YjAzNzZrejZZOHRRa0o2?=
 =?utf-8?B?NHlwRUFmTDFINTBuKzh1Qm11NHgzR09mdHVESTVBNGlEa3pYWjMwbjVoM05v?=
 =?utf-8?B?dGUwMGpRbDExc00wbmxPTXNSc3NaTHVOMFFVekdYeDRkWTFVZGJYaWhrWllt?=
 =?utf-8?B?eGc5c3dQYU93dXJYeXV5N1NEbkRJS1hwVTUxMTQ5MVpIMTBwL2pTa1pGbVps?=
 =?utf-8?B?a3Rrdnluc1JaaWEvc0JhOWVESm5JRjA1MXdMOVVkVXFDZWZ3WG15N2hxd2hE?=
 =?utf-8?B?aVQ2NEdwZXdmSXN2ekJvY0JKS1QzSzNTK0VVRlc5b3AyeUx5NUpiSU5UdW1v?=
 =?utf-8?B?aDZhZWFNRUlyanR5WHZHR1F5azRERUlsOEw3U3FHSXNZR0tIY2pha3p5bW5t?=
 =?utf-8?B?VGZCNFVDOFlEQVVZWUpJdlJhSHFSK1RLdzJaZUlvQ3ZteDlPTm9VRjY0SlNC?=
 =?utf-8?B?SG0rUVhyS1dWNFRIY2d1QmZnK0tqQi9ocnArZEFIcGR6TnVnT3VNdVUySXVT?=
 =?utf-8?B?Z0kwZ1l3K1UzMmRMZG4rcFdhT0ZwYjR5SkVYR0NPb01mM2pqRzFXQld4WHl2?=
 =?utf-8?B?OWxiY1VhZ1VYeHpuN1pEaEdmaElDcExLS3B4RGErUUFPWEZGYlpyaUhZQ1Bj?=
 =?utf-8?B?VUdOaG9XOHdOODFRcDFkTUtlbUx1VnBLcWF6b2twMWZya0xmb21pQ1JPZ3dX?=
 =?utf-8?B?UFhKOEtuNlJUc0gzNUN5L01jdDRpcjNVcndrTzU4N1FPUXhJK2Exa3ZXUDc2?=
 =?utf-8?B?bEROWDFqKzhHc1lLeDlNWG5mYm5mcTJiZ3ZqMkFIenArM2hBblpsWUV3REM1?=
 =?utf-8?B?RzdsaG1pODkvUG1aOHJjTW5xSUV0dmlZRkI3b3NNNVNCQVJyaXo0NkNvaUty?=
 =?utf-8?B?QXFEL1N2N3ZZVmVka0MxVFl1N2tFR0pKMzVuRHdTanFPR3k1dlY3ejBhNnFx?=
 =?utf-8?B?QXB5VlJjV3JYN1NueFE5S0tNN1Bxc3FBdnVJMjNmYnVUQUNtc0tpV3F1SzZ2?=
 =?utf-8?B?OENwQ0ZXSXVXQlB0WitMek85dytBNHU1Vnh3d0p2V3ZqQlg4MEd2ZGhMNzJk?=
 =?utf-8?B?WW9BN0w5TVB5ZGRiR3AwZXlKMTAwYVgydjRBR2pTTUQ2YitLbVF1WXpjV25E?=
 =?utf-8?B?Ym10cUhDTnBUTUM0cFRTUk5yM0VydUtjY3Vsblh4WndTTmhseWVUNFkrYThG?=
 =?utf-8?B?a2hPUjVsN3htdWU0VFRwOHBBakR6VFNIM0t4aTRkN3g5ZWNGdUZhUzM0bWow?=
 =?utf-8?B?QnRLWGd2Y2NpTUovcjZvem1FcUhNSzA4ZERoRitCSGdlRWxLL3NwcU9EOUor?=
 =?utf-8?B?c3hESW5JeUhYbWUyVC9HZnNwQUNkc3dZL0wxMWxJZEhPTmtlR1RqVDNKdkU2?=
 =?utf-8?B?RkxxWTc4NnFuK1JGeTFqT3VHQjNCeHA4enZibUZEbllHdmhhdDl3UWRQYmxv?=
 =?utf-8?B?b3ByRmQraEx6bys4UW0rRThCRjJZbG5NT3d5VjNTbHFjS3V1VFFERkZZRDRu?=
 =?utf-8?B?Z3hCRTF4OURDR2lpa2JIQWFaVUwyQjlEQ0g1QjdHdERXT081bkQvYTk2M3lJ?=
 =?utf-8?B?THhxTS9DWW9HYnBPTGl5TTJiVHRrdzRvUVdJVDJHS0JCOFk2a1dHa1pMYVdV?=
 =?utf-8?B?b1JWYVUzTXRUOGhPT0xwZkozNGdNWmZSek9mK0lOdzRNTHlwYUJ6cjZjSWJ5?=
 =?utf-8?B?U2FmS3crL29OU3NhNElaUVIxTXVxdVdyTUx6b05KVnorOHBLUkNOek84VHcw?=
 =?utf-8?B?U0loZjVaSDFOa3c4SkNNbFNMWmM5NVdWRWtaMi9JOG44VytrVksyV3pDSTho?=
 =?utf-8?B?ZW9HbmpYaU45eWxrTVpVYlp5RVRwcXlmZEpReTNkZ0s1Z2cxQzQ4NDJlc0w4?=
 =?utf-8?B?U3NRRXIrbDBWOS9aOHk0U2ZneFBjSVl2U1M4dXFqcUc3Q1QzNVZlV3h5dzN4?=
 =?utf-8?Q?AlaIOL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 14:22:10.0072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eb55f3-298d-4002-727c-08ddb71855ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9771

V12:
- Fixed YAML indentation in devlink.yaml.
- Removed unused total variable from devlink_nl_rate_tc_bw_set().
- Quoted shell variables in devlink.sh and split declarations to fix
  shellcheck warnings.
- Added missing DevlinkFamily imports in selftests to fix pylint
  warnings.
- Pulled changes from net-next to enable these adjustments:
   Inclusion of DevlinkFamily in YNL test libs.
   Introduction of nlmsg_for_each_attr_type() macro and its use in nfsd.

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
 net/devlink/rate.c                            |  127 ++
 .../drivers/net/hw/devlink_rate_tc_bw.py      |  466 ++++++++
 .../drivers/net/hw/lib/py/__init__.py         |    2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |    2 +-
 .../drivers/net/netdevsim/devlink.sh          |   53 +
 .../testing/selftests/net/lib/py/__init__.py  |    2 +-
 tools/testing/selftests/net/lib/py/ynl.py     |    5 +
 22 files changed, 1825 insertions(+), 73 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py


base-commit: 20a0c20f82acf46d5731a11743e7c7ac4de25db8
-- 
2.34.1


