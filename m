Return-Path: <linux-kselftest+bounces-14746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0046D9465A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA698283B07
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF89139D16;
	Fri,  2 Aug 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YrrKbo3P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127158120A;
	Fri,  2 Aug 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635889; cv=fail; b=V0kjbBp1X32esk4nd6OYQBxf2QKzPUHGr3rKrQz+Mw3kmbK8vhCslK/MnwmfKnnqGx0il9J3rtIfvjESM/e7aZsKsX7U+2eNIQqZj10DAsOHRaFNGPp9vQaDmNbCXLO8QdmXe3MRYOMN0OA9WhO+dVz28KAbnfCxXMEXodNNQyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635889; c=relaxed/simple;
	bh=yPPkz9bSOSuwFFdsQJ1/lIRosuuxoqkuB0ynt6iauWQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQ5NhSuVvUNXlf/NzMG5EorXUth1qjtFpyAGngYzQVgaPMvS4VeiDZtvcKSkGlCT0XphpBhWQAYlGV8CbHywyb6+GaWRM47h6QYzWQnHIHN8ZxBS/BtKxCW269CgPbkw29KKHMKJLFuCPe5x+D4UV4c3eGuHz9PLh9JEZ+Tpavs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YrrKbo3P; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6iDiIien95lyco2xDR2fin2264Y6DtoX7mxQsmLOP0XuUTV6dRnp+wTPVeWNFLFoPq1+7b9XydDHPe+KD2PiY9sJryKJxaCdDUA9yT7viRrtQifRcS1YpTyGU5u0V256xoBDWTeq4453opzGkWH5RTP07a9VTQMgDnAeIHFwKvoC1b9+vkSxEUDmmkC0uFCDvkImHl+kPe8YuQ9tis7js1dpOoW/lSf79sEESZdwsyZ/inyYPc0cHTra4p5+2pGX/aEa8ORzDo2SHfC8cnO1+R4D9gvdX7LDQbIbdGoWqX6cVYKbTS/xddzw2KbDUNtPi71ma/oJFhl5EMLVK9f4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nGHxcM51WUlppGXl5gYkvUstK1FUDbH8YMpPwF0D10=;
 b=l6BSWDxTxzUjVngN4hNN2GlQc5irmsWd1k2DJqcnoSCB+VerDIg9SibzJpHgNppalaztHFrrRTYJpmTWizLFv/YUASoVdpDeFxyIXbffg4BdigzzUfMyi+Khee9q+5G0vs4votZ6GMrTrzklfouE3j2Dt6asFzQxf6fMNUA4lqb0ZpRlHY/u58nhSsMRJ+CfaESr0Kpn+44jVPldUtfgpxOigVYePjtXNSxD2I7hCqXYgoDGjJEmIl0WzieNXHfLOZIZUO2ok341cosXRdQ30amq8wnKP9WmJPky3Y+gYKu0L7V7N0YPOalujyKVC9y6/qhczjLz6+4ewigwe+fY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nGHxcM51WUlppGXl5gYkvUstK1FUDbH8YMpPwF0D10=;
 b=YrrKbo3PNm6g7NPAcRI+cO4gd1DcXs3V7Rny+u5Dqhvk4MjS5kAAjxjTe8aBsR3TWehlZ5y6OUwwI3Gv5cHCEiSB5OwPcgs0r/jZ+f0bvi54l9IifmqVnb8WPiJG1635wQsB/umPdVtsB0v5fmJt5pVmpD3MVO8dV5pjYNdYfj6KtJwfLo6TylmSTIy0ivqCXSkGPsb56pW1MtvheezHsaTze9PzoIQIw9FYtYDh52rDNDlYpE7AAQEfSKo8thbECTu8RauTGRfpWmEW2GBrotlY6QSLhy9JG5xelCnXKZRLFmLwJlAfcbCOB6X/vZ3tJ0RBMLaDlTIn6cE6SncHVg==
Received: from CH0PR03CA0104.namprd03.prod.outlook.com (2603:10b6:610:cd::19)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 21:58:05 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::b2) by CH0PR03CA0104.outlook.office365.com
 (2603:10b6:610:cd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 21:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 21:58:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 14:57:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 14:57:54 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 14:57:53 -0700
Date: Fri, 2 Aug 2024 14:57:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 0/3] iommufd: Add selftest coverage for reserved IOVAs
Message-ID: <Zq1WX11elvpTB//k@Asurada-Nvidia>
References: <cover.1722633199.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1722633199.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd0f362-f85b-40b2-4adc-08dcb33e2fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8dfj4r6uHtnC3nSao6BqTsrl1mgL7edlHV5UKO+BwCAOBB4xo3zlelAVN25O?=
 =?us-ascii?Q?ymtMAS95RwdzFMoBtGXm4VqxkjyS18oIdX5ibWHX94yU/Diw0nEq+LrRYLwL?=
 =?us-ascii?Q?Vfii9L1pONxNa5D+lCyuCV2Cc64Ev6PGeEuUn5VaDMku4koj8ZxylbFHht3N?=
 =?us-ascii?Q?1VbAumZwjoLU4gcm0f9nPJ2Btz9EpTfAgO7dXKGL0p3xfTB6CHF1nXpO1KJs?=
 =?us-ascii?Q?9lKotFGeXV/9dGsWrbqZuEh7fENhf8KI3yg5DVsHAK6f8WqvIZa6ToUU56X5?=
 =?us-ascii?Q?vndwQQo5fvNk5Hk2SjYSKEFiQ9qYK9x8IZ1GD8H9EfSXInfN0MR4JzFYqPGg?=
 =?us-ascii?Q?JVSxUSxBGgiEDT1hlaO5vX/uNbyIZSGoESJdyfUAYu9kMWyGXE/4NKdZ8gqf?=
 =?us-ascii?Q?LuXIS/KLn5IFnaTvBtL6SucaQk3IumTjX03XzGyjEYhqUyVYq82iicJLLcs8?=
 =?us-ascii?Q?dt28phW9Xhi63ds1G7vWhFs8xjXC4WroFlog0BDlPv4KqkHVzeekkxXbjFGv?=
 =?us-ascii?Q?fgjqTLmyZ+lFFhs/kKwp//3BtUT0eE5jX42LkVGPlL2r7vWbRAgTyZVMlJBX?=
 =?us-ascii?Q?mjA6LH+rWRSSKnHDVpE81hnfs8CKFh2c2G8TRiDdpLEanZJ0SWH5RNu2aO2t?=
 =?us-ascii?Q?qE7kqd+bP0OqvtQKUK+VKqP+smRYIlFv5hqTRnBoDSAu7amUm1r6b9nZcj8D?=
 =?us-ascii?Q?yrfgfQMt6DNND5tjmJlNW/+fFQFRbNhb+1LFLE7yBbcJhNrLRRpmsesrKGon?=
 =?us-ascii?Q?BlD76TNz4Dx0pFtcwHXAiLRdWAh+DiTXdEuJ0Y2J1zuqwSMzmUlq6SjVowqv?=
 =?us-ascii?Q?/oKHuv7JONXkAgxsmjdroai+dkAiBgMs+XkdOSxpZG6Anwqj4jkp0NzaAS6z?=
 =?us-ascii?Q?P4V+JEaB1e7QyajgLBEVn3WsZaeiSPcf3We/XFmd5UB/GC6NUppyqIyPR2k0?=
 =?us-ascii?Q?+03F25V8wfuL85ebzK5b+nJYyT84/r7d9rVQDpDkH19v+svfRzZWpIIOZ9gv?=
 =?us-ascii?Q?1E4H7wiUluSsvOuzcDm6s5SnfYVPMDSOOwundoeQek/1RxLVQ43I/bHpfOOQ?=
 =?us-ascii?Q?QqnZy+eTZpEVECYG7CVS76swrjZSRHP6ZQWn25DPueOzsJnQItNLD3+GK0g2?=
 =?us-ascii?Q?OpTPBpbw4tpkMe4013fhdtIAfplvJ+bijAHb0kbpQsw4XPEW95Sy1XLsWZs7?=
 =?us-ascii?Q?GEaPoiFuO4wr0+B9is2k+9WsZMHehHy5stbcQe3LFwf3kgLXImScDXO+8+sE?=
 =?us-ascii?Q?xcgMOkYo7xFWODD0hpDiTmXRRTfoqlH9IbEsgpI8/D9b9nEgcB8XnASiDpGe?=
 =?us-ascii?Q?jvnqpzaf3kk7xKmOzLw+E+PurBr3mFiUMvMChf+ZWD+KoTR0JXBsm4aUWmp6?=
 =?us-ascii?Q?OZiNO5+i+iM60kyE7rita0vgoqUqZEm1YK6ZVWWaMlz8EX87w1BqF2NXvdpm?=
 =?us-ascii?Q?5YSdRyM2Y+KcKAbndzZZ4zFH0Iq7aNiThAsl6QfrE1U+qB09IVCidw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 21:58:05.1629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd0f362-f85b-40b2-4adc-08dcb33e2fed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194

On Fri, Aug 02, 2024 at 02:23:45PM -0700, Nicolin Chen wrote:
> This adds a small series to cover the reserved-IOVA change:
> https://lore.kernel.org/all/20240802053458.2754673-1-nicolinc@nvidia.com/
> 
> PATCH-1 is an optional cleanup. PATCH-2 is an essential infrastructure
> for PATCH-3 to verify the loopback for IOMMU_RESV_SW_MSI.
> 
> You can find this series applied on the other two earlier patches here:
> https://github.com/nicolinc/iommufd/commits/iommufd_selftest_sw_msi/

I sent this too early. This is some issue in PATCH-3.

Will fix and respin. Sorry for the noise.

Nicolin

