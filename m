Return-Path: <linux-kselftest+bounces-48736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77482D11F1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 11:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B4BE3011EC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F23E2C11E8;
	Mon, 12 Jan 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JAb4OA2c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D2283FCD;
	Mon, 12 Jan 2026 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214267; cv=fail; b=BHPMI4sd6RD0IY7XqJuNG0oSeq792UByHUVqW8GOGhld+Eje4B+m/GzfjnwgI25ZUHpT/W22ckyFdbJMapbtmOAUqof9lzk185gA5AMAhXu6uhKenXHPUEPWLnaV40HaZhVmplzFTxujaHqeBznrpPHCT1ty7tOm4b4Q/HWnEdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214267; c=relaxed/simple;
	bh=rGQryyytYxe2Cs2TNX3SyQ7GanODwkC67B8MiLJPDlg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VLL1cknhM9l9gUa2EvHqi105RyzWC+gVAfzoabRWLKqRshfvHTAamRc3sXV+wtr5bcg+z/9PXzSW704hPEhnL2B8fqTmRMNJFfA1WYTWlfQ3WFMaBSmItXhR0IuXFsqiQ/Q4LXcM2iBvJZXgWn9W2rKpf9+MjSo3ilXRNzNSJAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JAb4OA2c; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+iUOdWkzMPzGs72Bz07kf9WIGtDV3JqTUJb1fiDwCZaW2c5cEGA+5YJ04edfUdarMH857VGGOX5BoaGj2YM0SmqXxOozestury4lti89JnArKjPnaGDNwVFgXpVcU6JIKneh0MyqxEIgWOdupQpyE1+jbuJFYVJvdAvvML+2d6Bi9kixO5M3fAq4AQmzJ4QW34awsoNtWuvYJr7KRYIOuEa6I1AMlJo9Ej4BUO4bbgdwPyD/2HsEvz1h2WT5w1xpM1Xbmbl1TLhRCxQPuO+08n/6Xt1WNnYuFZsbTyXGWl0Ql/NI7ywQwcs5zmHVBxpMdE2Shfa5jRJh972fNurPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGQryyytYxe2Cs2TNX3SyQ7GanODwkC67B8MiLJPDlg=;
 b=XHDvr1WQg6wKn6Hrr7b2bNy5NzF7igHtoNVV6zfsN/si1KPY3vT2t1Ovpj6ntfi6fO9GgklQs+O6HNuiLykWny1mwcjSbRE4ym4sDEVbtYwmO0m2Cadhz8I7x2gRma5E8TUmTexuVpSI2z9hRDHnh0CgZZjFBYOW0hlwJyUH/E4D0EV6g6Ro0kA0SiTzS+YQKz4nu/BtEn3fMTJy/uhqv+U46BL0c46gyUszQRTvn+KTlS+L5cIaf3Jm66z5yCp3/uTerlRxN+eztn/tSSoT4MUJq6VZ3O0piZmMHLxQNn1VAQY/K/JzCRTf4pscbj0XKjHquQo+7q2CIIp7sB3ZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGQryyytYxe2Cs2TNX3SyQ7GanODwkC67B8MiLJPDlg=;
 b=JAb4OA2cGev8T4ngaxzZ0JBaayAN9NPLM+OQxcec1Vtbd2FQHkCH8LlDhGLUqVvmHMziveC1o7bwYFoI7HAyyPMY5DGUCNH/EJrCIwuLXEjjW7QbAc9RqfvqNttU0wX16AKDEzy/hRBgVxHWyRmGZCwZSgSrWTh+7o95M0YDN7mJIrzAixbeUtSUo7CQtIua/l3KRVeetMgK6qBCL9Qg2KNW7Lg8lsDpTnLvnGmQaHSbbbFgqF1ssL7WKhcXGfyLgdwkQqYMNnv2Vd4ZOi3ag3mzZk5x2HTHE1kqLYQMj2bgEAvAJXodA8osUXrWjoSiMFSqs8bSzIz5xnzmDbJRZQ==
Received: from SN6PR16CA0043.namprd16.prod.outlook.com (2603:10b6:805:ca::20)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:37:42 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::8) by SN6PR16CA0043.outlook.office365.com
 (2603:10b6:805:ca::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 10:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 10:37:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:37:30 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:37:24 -0800
References: <20260110005121.3561437-1-kuba@kernel.org>
 <20260110005121.3561437-2-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, <sdf@fomichev.me>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 1/6] selftests: net: py: teach ksft_pr()
 multi-line safety
Date: Mon, 12 Jan 2026 11:37:03 +0100
In-Reply-To: <20260110005121.3561437-2-kuba@kernel.org>
Message-ID: <87pl7f3yn4.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d839f5b-6fa5-4e1a-f1f4-08de51c69d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RDcZxjn0b736yQDJyX6G5FoAahiQwCZqth8AMy0FbAnPkupewmXn2jeYWZK8?=
 =?us-ascii?Q?d08xiapWBylpu/suBLwMVPDl7TH91PBjMiunzkP85/1nAZKoN6tN5V1tLfZ0?=
 =?us-ascii?Q?uy1aEOXiDjFNWX87Il9pcn6BHCoCbzg0DoEVM297R0vhPrchMmLtMGxCaafu?=
 =?us-ascii?Q?lG88Npe0u4QFrmfeFdPCXqlv0etErNJp6K2pezVxvLkXoB8djlBGhKeo7bPi?=
 =?us-ascii?Q?xN4I+FVwTWupd+UTPy8xtQPZQ70VN289nvr0b9z983upHoil9+UKoOY0HE+a?=
 =?us-ascii?Q?BW+m9J/xpNLS+pmbh4wUoSIcTXzIwSGNGuxNc0O+N4QnnF82MrjjoGlNkvby?=
 =?us-ascii?Q?rEy+gHcAl+NsJ0N4hskUYOIEEUXncsXLdwctcl5ZhY5bhkjrzRfm1nw+eTw6?=
 =?us-ascii?Q?seTf4PV6G2j50KBXx1XffYxdYv+f7GeIDTiUvm1PNuFJjZdU+vKN9hdk+0Yv?=
 =?us-ascii?Q?KwYkvQjyKp7Jyc8Sqj5wjbMgt4kVyUgfCPZeMUeEHBUWhiBpCGV3Ru/0Ul0d?=
 =?us-ascii?Q?K427bFTchxMcpU1RxbgM4HrGPMzjZiC7gjQy7yD6kpI8JSRdhNtNrFq8fi2P?=
 =?us-ascii?Q?raUIUhiwQWHvHwaOb7QUKt6qVfexUyqoD43mUDdpLmvxroCKUlzJ4CTYW/sM?=
 =?us-ascii?Q?ohYnhDF0x2vSS/jdd8NmP6CT6uULVVYAiC4XoqdVfxxNQGEXsyUV2UWbzycc?=
 =?us-ascii?Q?S98p62s5JOCZoxkjOsX/c7Y6QdP7XFDhDRdX3CM+AJTySwC3ODym/TgeATNW?=
 =?us-ascii?Q?45STxCFY+oIW8jCmmkVSG7Sq/dmbe8trctdRBD6TlsvUa1EBH7HMFfB53muj?=
 =?us-ascii?Q?rt/A7/hNfur9ATjy3+fw1wsnisxcYZtIdf4qrB6kKbsUft2KF5WeBj7rMZ+c?=
 =?us-ascii?Q?snij3/5k3ssJtpSCnPVNWg4JzKD28y1bXxI2POg5n6I1m++b+M4HRAdFYE8e?=
 =?us-ascii?Q?q/nXZTmkDdfSX5V9cXHNvF+DIHyxfWRV9boEXAuDX7cBUg3Pq5bXcXucQF6g?=
 =?us-ascii?Q?vq7nD0J/afPxxAG+7A1EVCCi0Ed4SUeMDdfi41sivrqHFxve2936eifmDj5U?=
 =?us-ascii?Q?cqz81nyt5+bKklBxiMHOTv6SgI4Mm0SxTRFmnhO7UUmHQpa5lB/DmiCwHUzy?=
 =?us-ascii?Q?pGQYaBALu3tP61N7x4RxOwFv6AgaIwtc12qxs10JHbH96zauTxTaZ5u6+tME?=
 =?us-ascii?Q?s58OqWoHAZG0d0LMUnryGO7Lxi8sOzaDMndkVd3/F2sLriXBEwqT0kXdgare?=
 =?us-ascii?Q?fZk4DpAPPJFSb2A/daJUj8SgilTEEbZ23Fre0G9nOBa/G6avzUZHWdhzoSf+?=
 =?us-ascii?Q?qEKpm+Qf7atM07jIccNHaV2BMNoM67Bvh0hQpGkFubaicBL9exML5/3DWOri?=
 =?us-ascii?Q?aHDw3zQAf5HpyQn4wJcVD1aj2G6V1O4OK0P2xG/hkNiPcU5TraalTxjvsRAy?=
 =?us-ascii?Q?4BhfmLwQuFpQMIGKelkk1SFtaMqYyLPv1A1y/k+SIjXDcHhqby7i4PdLgggI?=
 =?us-ascii?Q?KCcOshgFDF1Ey2b8yfLh4exm6fJGqkbFOkRa98FFI8KwrVPFrgmDd8SI42tk?=
 =?us-ascii?Q?+Xug+2FjpS6lVdxZ2R0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 10:37:42.0937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d839f5b-6fa5-4e1a-f1f4-08de51c69d95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682


Jakub Kicinski <kuba@kernel.org> writes:

> Make printing multi-line logs easier by automatically prefixing
> each line in ksft_pr(). Make use of this when formatting exceptions.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

