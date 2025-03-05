Return-Path: <linux-kselftest+bounces-28302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF91A4FB89
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 11:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CD73ACBD3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 10:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0F207E1D;
	Wed,  5 Mar 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ijOk4kW2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88472066EB;
	Wed,  5 Mar 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169733; cv=fail; b=mIE48OypJfhzcOvfU2Hmm8hXOTm6mwqDj2YXyD236/SdQ8mTwbkfOcuJSMapMHUyEsnohPCyGqDXOm+Cbl934M7UEvpNEgCuOAE/QfAydzLdJCPzREMehIMIboelXrt7AVaXxis7jQlldAohhF7zFnGjJ/woo8iDDo2VSutHLT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169733; c=relaxed/simple;
	bh=A4nn1JgijMjX/3HpMxoPXOIe5CCbwnSsTqfPDrLaflQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JBiS4leh8bJsaru0rkAz66XpsHHWTP3btAAG69v1vdertY91B02Ae3CwiOpt1nqbS/q8Zwtel6ZcKNDI4PvK8w3QUlSX74eENaaFEHoo8vRF4AFQM1hZTBYxkWGb1Iym2X59BgIrQZB6uFqzhWeJelU84x26XgynReOUNO3Oc90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ijOk4kW2; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdveG+M1s6Nu/O/KUKxId7YF8L1IhplqLss/F0mlnJzPOeFZj3WtJxaFhJnR7xYfMdY6Q+iaO3pii3UvneQ+HpKHEbN/JoUCSUkiru06WCUeASYWkRqlI1tlpkyNg8w8KWTpkEqZE3BhFdv2NgerZqCXqV4DzAOXjVX+wksDGXahTJsKPzJpA3uen7inivjafLvoQtzY5WzBLX25vnfnvB+tzVj/L2bhxWlkAeFG8uj0S1wJVFsW2ldfv2t/gaDWZIgYcH7wIxQqc49PgfDGrt4nH6cy8yWg63T8z3x4h+Xn7rO0D1ohT2br8jrw9hbSs6X5aWhou8LEdhwdYPVhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8FJAjqNZkSi6BdTI/IvZLhOqHzd8LTHYHDnAs8suro=;
 b=BclEptcr/Si7ldA5q9R1sjsLCCUaB3n8739/LCoKqecGmOrWbZO2rZ+zq4Gmg83Y2FWC9azK5M+HtIw7F1rVW9Qhbsj4O5K9zetpJ/KPXZAE4wOyOi4n6ezdv/Js724BQfQY3pmYN511s52mCHSROeGzBTUiRuDvqHVtlyZLYm+so374nvNgVT0fmi//YgU85QhOBdyLdild8mPkQoFCu9vOUoKsxo3rVEzhSR4tYvy+FZDA8C7lx4GH5z+9z0fH9sFVuJngv4oaVJHagIIgCcBAwskuw9z1O0UI1bfTFUzkmsNtZ5NMZ+J7V//bN/sttyk9MDO5x5C3PQp+v8FrlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8FJAjqNZkSi6BdTI/IvZLhOqHzd8LTHYHDnAs8suro=;
 b=ijOk4kW2wTuQzD9NGLsn2O3qNnqPtOi8//OoZl/p3CbNf7j2j8ft89+eKZGLfAzoIwecYnxZxhRpJoeB/uze+z3lKbXtszrGbTab4P7jjQdZ5AO34v+zbs8dcBZK6WKsX16VfwsbCnibDs/c2MLtLq524g5NQXtcAneb3Q247Xx+YThiBz+LG60a8HY43Wbhe5rmG8b/1kDIQBze+fVgyrA4rQWEhY/+pux5LlktBDF0TcnPEmerqTIBaeuC4r4DDxWinxqBL6Bt4TeV7NeBAJiILbCz4RlegGTsZh1iVpjoGQXdC8dFcuf9PP6rq3jF9ilgBK20mMMik/E31sDaCQ==
Received: from PH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:510:5::29)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 10:15:28 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::62) by PH0PR07CA0024.outlook.office365.com
 (2603:10b6:510:5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 10:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 10:15:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 02:15:10 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 02:15:02 -0800
References: <20250304131120.31135-1-liuhangbin@gmail.com>
 <20250304131120.31135-4-liuhangbin@gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, "Simon
 Horman" <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Jarod Wilson
	<jarod@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 net 3/3] selftests: bonding: add ipsec offload test
Date: Wed, 5 Mar 2025 11:13:30 +0100
In-Reply-To: <20250304131120.31135-4-liuhangbin@gmail.com>
Message-ID: <87zfhzzsv1.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b31d46-4c7f-469e-e852-08dd5bcea6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v/zvk8l8YDIZ7XOgEKusTWfl79R4hAl1VlRPeWlAfoq6p0juaaHUCK3hHKc1?=
 =?us-ascii?Q?u6QAErMzpokkIcXnUu16SsibdZxXOOnSbd6RibvXl3BvaM4ZG97a1isCJ2Lm?=
 =?us-ascii?Q?RRBlFqczamQcUlCDYRkwnWxpi2gVpZt/vbR3F00/SqOifMPM3ooQtKI1p94j?=
 =?us-ascii?Q?ryTJ/Lq5jb9Qi3MOmgrZ/hah0RQ4yipN8gGomSv5d3QkfH9Loz2bYzxpYDf0?=
 =?us-ascii?Q?/s0pW4kWBR9E+rGRIAn9u1RibseDQdC1QUvb3LUXFKm1ayb5eV1OjTEIGbaD?=
 =?us-ascii?Q?oQjywishU9Wu/zcsgEF2CAtwp+INJK6+bFQB3doD8xYpMzE8/NbffLR+/nG/?=
 =?us-ascii?Q?rHahc5X9DzyxFJgm559ShrpfB4gVYhfZc//KwHKH/jw+qNf0wqxO9JTnCYO9?=
 =?us-ascii?Q?deeEJJIezNnQn+UFxW4sJtQAUWEF578zB3QWDvAXjqh/Oz+SErwDEgMkzNmt?=
 =?us-ascii?Q?FQVjU5L2Go6QX0RaX5D+mq/DECpAfU2EziJA3n8MidPbCHlkFaGvMLGJ0ZFI?=
 =?us-ascii?Q?47yVnMeqiraeYfHIZBFN5qUc3gAfPNL764+NrcfVvjKfx68DsNWRnBiLFKWw?=
 =?us-ascii?Q?619wqdMNuXqJoa+BIWoBmVWcs1wlQvY5RnV+0kpXbTFeTky+yU45XuYZY3Xk?=
 =?us-ascii?Q?UsyLQwtNj8XdMQMhi3E4PTM6qmHol54yHEn7R4lMl4KHoi+b14HTsODw7UfQ?=
 =?us-ascii?Q?s9iMzLnSYs5DNUgzPIxkS7n1TpoX2JW2ehyJE2dfGk4OsFhHJYPzM0wWvETW?=
 =?us-ascii?Q?yfubtJiMIpuxTfz0AVHmDP9l7qfrVT6oZVMNOfV6ks2paxoR8QUMVekNX4xJ?=
 =?us-ascii?Q?wu7NlYk0UzD2dfWvQhNn1D0P5b7fy4MTjqokPxc9s0Ajna+dS6/o5jkzEKLp?=
 =?us-ascii?Q?mXh4q0wnl+JFPUoAnZEwR5L47+Nx/LIMDmYxsyNW/boELXB1LSwCu/mdvgk0?=
 =?us-ascii?Q?SmsR2DipXBklbPETc1BvXsZDC7FHHXF6jQ4L01SKlU4IDoZBgSxK4BOnvtcn?=
 =?us-ascii?Q?j6Uko/Y7xY03r3RtR9wsQ/zB9RYzDwkGAdd7i0RwVlB7bXe0av2r5g0HWrat?=
 =?us-ascii?Q?pUucdMyLbJWLnm4XKt2QsiYcGDxfyssQucqwwOoIlVy7YD5FP5snXRo0UOMc?=
 =?us-ascii?Q?MSNDtpNTv/Hwbbi26bUOkm1XnZkFKVwVKDRycT+QBBMxg69FR/Yo+IwFDw9X?=
 =?us-ascii?Q?vc33gnRIeguM1viYt/FAHts9BcpTOwrGn+pl1eEbem+BSrgYtKv0ETUdrz+V?=
 =?us-ascii?Q?BCmKYJdc6la6tK+8Vde5rLYmMwufUzBpgmwRZWrAAQ2FPAbiu94XCC/ILoTg?=
 =?us-ascii?Q?PGFxgihiuul1+uPLsgfwGh/kfwNy8MROz/LqDpyB2O8QYEKbbj2RlllNVYp+?=
 =?us-ascii?Q?w8cKK5ttZcuTlXVauXtI/vDUYIy+0iVEIXejPFNMpAknv7uIG9p8+JIYzfLQ?=
 =?us-ascii?Q?pSd+7/DzouIAcXVzsFrUeyODA4RtAV5PkPvqIo5HFxsx5Cfaa1DwXDhXo7hJ?=
 =?us-ascii?Q?NJcyHweg7Qznggs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 10:15:27.3336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b31d46-4c7f-469e-e852-08dd5bcea6b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870


Hangbin Liu <liuhangbin@gmail.com> writes:

> This introduces a test for IPSec offload over bonding, utilizing netdevsim
> for the testing process, as veth interfaces do not support IPSec offload.
> The test will ensure that the IPSec offload functionality remains operational
> even after a failover event occurs in the bonding configuration.
>
> Here is the test result:
>
> TEST: bond_ipsec_offload (active_slave eth0)                        [ OK ]
> TEST: bond_ipsec_offload (active_slave eth1)                        [ OK ]
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

