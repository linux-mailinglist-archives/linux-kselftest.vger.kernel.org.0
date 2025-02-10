Return-Path: <linux-kselftest+bounces-26173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E0A2EFAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E9F3A3F60
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7EC25291F;
	Mon, 10 Feb 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUIiRLl0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D02528E3;
	Mon, 10 Feb 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197512; cv=fail; b=AXIvQWIo7Cp0Iye1gUI6HC6M+7iw8rPEzoEWvaCTvkqY1v8MTnIB/hCpnyUXWb1hnzyEh9rP1xYjpvY7/IQNI+mYsS2xDLv4OTWi8HXcncsOe2c6zD2fGv5zUv6wkgB1j7GUI6TG73fhbcpQDgOw0xUNwDMR08Fiw8FX3nl5vu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197512; c=relaxed/simple;
	bh=NoeFt/OVJWkkd919ymS3pqjosgCacEN3YSjxb2WEqjs=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hqvD2CR33SoV5yVieA1z1TFn190P7gLKuY1iuW3i+KZc0hXbgybFPdG6h1JQCihRxTPvV45EZFr+q+BkZDE+o7AQmxDJOeZvoWBME3HIe3QJsXSBIUn3WRnJO6LrJlLqk/XFXpC66wcyVmJPRBgvjtwmyTWLMzxKioTQlRbUI70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUIiRLl0; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8GzcaaTCbYmuFcI9P6zqT7qEQtMlfi+0YrpXet53CAK5dMx+xgX5ldnxQPB2AOlb56ztaNxPjDNENGjOH/3aV3ERy+TLdHCmqbv2SloiMthf38vDLBwZsHScJ+E4adNycn77BynYMj42nCgKMl5zBefOoXC091XXEhC2w1jCzxvtNW+7SdCOmOVjQQ4cKNi8Oy93j6F+ETu5rsVVnlBJELblUzhe38slfR9ImU34MwvvU29nyNRNs05+MUU9KkI3PhauEnJb35PslJGGRwkzhK5yPp59YVmfj0Pui/A559dqCPtklRgc/KcmTd5UK4Jso29r7U32R3JAW0yEOQPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoeFt/OVJWkkd919ymS3pqjosgCacEN3YSjxb2WEqjs=;
 b=gzMm0Lxh23Y3bNkh5VK2w9tyLggkp4e0ojPTrRur9fWgt5icDxqRigRuu60ZEIEHBLnCi2yuwpcCf+VYsq32Bxhl25/YM4TPLcln9Q57VWLJBfZWPhNOYDsOg73z4MURzHt62/FQaiOxhdS33MsT9e9Hd0XryDV1nmzZMu4SypM+H75RV7OdODbFlsz6szxpCvv+VTO/2JJUeLKAGFlsPJmZIO4WwygDB4usL2UkUo/b85KO4IL45SYCZrtYQqlqPAlyusp4o6VvKcMzCAKQxPE9dSBthDlcqPMfT2UNdJ2b5ykGVNLcnRW5MFoezsfgkysS7xbSFAW8+6/eLR90lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoeFt/OVJWkkd919ymS3pqjosgCacEN3YSjxb2WEqjs=;
 b=YUIiRLl0RyAGtpgm9oWWR6ggTnhkcR9fqnRVD2pzuPNdRnEHd3pSwtUM0R6NUXoyIXNhLIfSlH6a/IWzsKUr2WKoDqCjklgIEXtBdL6hm/E6NhzhDaUuz+03ZYQV7U2QeDVMdNNg9u7VTqgZvnmmF6J9jvYMN/EfDeR6PtpUd4FOWywXyc/wiol5JcbZ5G+mKiavMoTJtY2pVaGS/2Nxd3wqusoVcFcXezlA7VrbN5smCAKNDIEUNcptXSW+3ez1nf6Q/B/TAfU2YeAX3Fz0nbKKgfvlq95+CEXcmRchIW/sztJUYKCEJlF93nu7gW6xvXr++x78E3QCNNw/S1whag==
Received: from CH0PR04CA0077.namprd04.prod.outlook.com (2603:10b6:610:74::22)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 14:25:04 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::f6) by CH0PR04CA0077.outlook.office365.com
 (2603:10b6:610:74::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 14:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 14:25:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 06:24:48 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Feb
 2025 06:24:43 -0800
References: <20250207184140.1730466-1-kuba@kernel.org>
 <20250207184140.1730466-2-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <willemb@google.com>, <petrm@nvidia.com>,
	<sdf@fomichev.me>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: add helper for path
 resolution
Date: Mon, 10 Feb 2025 15:24:30 +0100
In-Reply-To: <20250207184140.1730466-2-kuba@kernel.org>
Message-ID: <87frklho7x.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 59863c74-31d1-41d5-b787-08dd49deb5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KEjTFMU5xp5SaFDf9rB8bAUOc/lQl9e3JP3MiSQSuEAk/KWPZgN05ZaFGVwp?=
 =?us-ascii?Q?GyIS9Vamen5jwKyl5zY93v8J5vRbfZnovMgrnHC7H1afH2H6+IAl32Bze6Ik?=
 =?us-ascii?Q?LcUtz5cFRFf1qE19Njfp20sTQgE/Jq9nMEIlb/56yD3YdMz/L3Y7W8Z0r0k5?=
 =?us-ascii?Q?gSGZaodv/AM7ccqoBCohuQyB5E2aLkRd0c8mJMcjHKd+OzW2hw/Jc9jaD3tJ?=
 =?us-ascii?Q?fwOEjd2nGGSeZ2r015AetzL2Kg7XbPv4T+IF4Iz/M7FTPCRl5xiugJSPC8Br?=
 =?us-ascii?Q?St555/+APueqWRhzEokzqhG+9jVbynTEgNp1UHVf+6oF/8rGPOw4Guie8TEZ?=
 =?us-ascii?Q?+QfIfs0YW+x3G0GNblzoIi9FvB3YvDlqcdS5bZkEkcBRyMZynt0EzaQ9grdY?=
 =?us-ascii?Q?edfAQPR709SZHBB/wGYIlpMkhVmXrfbUobG7INhniVJc1eX4gFXVG146k57N?=
 =?us-ascii?Q?uUzIx8ye8BE/SPwnrsIlOeSUPPy331ihoqIvLdzqdzNtxLpQG3BkilitGzzS?=
 =?us-ascii?Q?7wGyjDpOHVrJiazJd12U1PLGZqVjes5P0fYh5U9D1yXdopWFMUGyU93sB9RN?=
 =?us-ascii?Q?L+mVNWyERNl36EnZG12gUk8fp2ZaYN3h+Z7L2GtSmg9sqO8co17U98OwulLu?=
 =?us-ascii?Q?CzSM0gIEGixpGXZJvLZOCRibqCl/T7WpyjRd4rD1nYa/lgTvl429hHVW8lyz?=
 =?us-ascii?Q?rIo8CR14cIaObNencP+C1xeA+r3LqpylpiBoSI53wiZjAUDTf3ziMj/Tge2L?=
 =?us-ascii?Q?F9JM4nUVFpvamGNUZ5GqSX+tzxpBgszjyoXrFkyN87MPjgDkUqkWX99ndK1q?=
 =?us-ascii?Q?9ChYKBCfT3H3K5iee/QSV0IK0Ofy5XBYP8cnLgXzI1HgIwNqXVJKCUm3R3On?=
 =?us-ascii?Q?kGg1diAGv4zy7WT3cpx2tzZtjacPyWV29Zwjqcb3S0140UNtzaEivz+A2y56?=
 =?us-ascii?Q?sDqu/zhU5Vse5IjwAfoIBQcr4Zql3ltqyMZ9BHQX8ZbDZFVPo2S6PJ8ky4mw?=
 =?us-ascii?Q?X7QfXLoaahAV3TBNH8ZCJYYNcb2WRD7zI4PB2LqLzOfesrUAzYNPgNXF0FSA?=
 =?us-ascii?Q?KpSUEgztjcaJ/vXFRY/kFA2KOOX1eJcUTWoryO0AB5gXTlPjM+ALWDUQbkH+?=
 =?us-ascii?Q?UxBJCYFDx3oTtfdh0dB7YE64NUUlsjEKByHOQf+NAUBV0PZ/PXQm0XTm9ouw?=
 =?us-ascii?Q?KKQPQOPPpqwJFSTBaL+JOGmZReW56Wm2hltCRFwJtJ38ElJ2Nfnd8XDa89QR?=
 =?us-ascii?Q?F+2SEFR1zi7ER1Ld8imhiztoB8VG8a7C0lPyhk7Lmf/aoebQE1twkx/p4FXx?=
 =?us-ascii?Q?Cgjqi4Gtnw1UqsJ3Woz05fAHxVp9esf3vIRTn08ao3RHNwFQT2h0/nrcr5wC?=
 =?us-ascii?Q?w1ITR+33zFIKt9mYCaf9eXESperIT5kPFl+uV1oVda6YCrzcLPggQDSMYEEi?=
 =?us-ascii?Q?fNcikI3XGNUJcOWDr6IBe5n50KuN8iFDiOv4365DI3Mg2T6CH6ADw9YwU6HI?=
 =?us-ascii?Q?wgD9KPZKne3svNk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:25:03.7951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59863c74-31d1-41d5-b787-08dd49deb5e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786


Jakub Kicinski <kuba@kernel.org> writes:

> Refering to C binaries from Python code is going to be a common
> need. Add a helper to convert from path in relation to the test.
> Meaning, if the test is in the same directory as the binary, the
> call would be simply: cfg.rpath("binary").
>
> The helper name "rpath" is not great. I can't think of a better
> name that would be accurate yet concise.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

