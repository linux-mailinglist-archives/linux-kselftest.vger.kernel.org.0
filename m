Return-Path: <linux-kselftest+bounces-23953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC5A02EB1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 18:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC623A6018
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D931DE2A0;
	Mon,  6 Jan 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gm+CVgx0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71B1DE89A;
	Mon,  6 Jan 2025 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183704; cv=fail; b=Ra7OJcAGbdooiIxO+ZeP+VVyW2RlU6XgigO59zFgKjoNWRaTTxReg1R5ZuEfWxqT2mtvMceJBMh47a8JmhNWa/r/UXxZlx0BAIoxphcsbiT9cOHl/1lax6q2JLUfQyF3J4yFWp4AT5EvinyxaDYl39yreXXOE7l0rp3qV8JqVJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183704; c=relaxed/simple;
	bh=hCJoU8/HojrA59zxx+TqIygm8M1WDLhcX8TWf0Gt9BU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BRFMZqsDIQvpbxW0v4XRKFtHu8xYXK9FGXyt9YjXB48DzA7NJc9+OnLozWjo+Nr9YW6/2HlFUvY9o+wjEmM8bYLgQwtHKihXXR98PnY/n316sV0oFL3So6BhzpHRprPBM8e1ohY6Wgt9UfjvarhYmO4V4UuNwXIvBA5FJ2UmDwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gm+CVgx0; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rg+rH/y5ItOluO/FoGMJuUiT8OYeqXb1RkBhJmf6foth7zaujgS1YNGCD/tkwzebt7P9EUiPv1c/0oyeqShDA8ESys/OWcMwjxWqhX/Poj8j4MxPeovbq8n4WuYE6P6oWty4+bLHQbAjEXPPm6YIhOQ0OWH0YHW/Ebta7Rgbwyi9B6SBPGUzazWZNu+NGtBGjqjuVj9EvkAW8rhMTzu+jyXsk7c1SLr0ukbI0tMeNr7BZEqUyhyX85txQi5UV6TunlKcsyMbn6gQCth78UxlbmBqIopIxSg9/4URP3hDY0UbCP1rYPg+Hvu2v43SdyDv4d/fJxC7gnce2ZfyhNx/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EB7LGUYq6ITeYJb2yWoDiGtSHSm8WJvNhRj/7T1qxho=;
 b=y1Ot9gSlc7a6QFFDAYD1jcAWnj1A/sPAta97p9oG3zu/hfXi/QTUIxb5VdsbZS/a84Trnm+aRUchfeYNXlkm60LX6/n/iBqlBHqJFsmC0oF7vFqegkqR2LnZ4BG/+E1C61d2i3GjmDmaKyS4qK3gGhqxwSwIgWnWg5/62PJDaMhtpEvo3MHWlHXkUoQrTLoXxIUMZeX3VlCW7uqza+2VbcEu61DdB2prPTp+7/5i3W46jG5iHAHmqEB+44rJUa7VPwp0rAbKgjFCXxcJ1P8JWdo9kQSeOABPdmy7Ef6QVc5XlYGPEtHGYtfQ9/1KgEJC5qIV+TuZdcUWkRx1D0a7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB7LGUYq6ITeYJb2yWoDiGtSHSm8WJvNhRj/7T1qxho=;
 b=gm+CVgx0rvxYKeZUu+C7NVKPPi+KG4s9ZNL7mjFIHwPWd/olp8pDqmye3o6OlPkjPy+Wltm4hTWSpJcB3+p1DZU9CUUQYXBoiuQqaRNVxynyZxmWkDb6/L/uF8sdGR3p9+5DpqoDe2VlMyPkpFQov+k16kD6OlNa4BzxHTUYljgMzaCqRnLlyytp6nevNM9JgDE9GIeL5ROwKdAISiOZh5Nqa1W/BMTpyHcaCaCfGlD30AGL1JwJmhvnwUGnuNK4PISfjOy+WI6TllDSs+DctEQxSBCUl8ed+GidCmZty7Qo5ItV/azuLPP84mGUam7DDKZKaOmzviaONqrpFpRZmQ==
Received: from MN0P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::7)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 17:14:56 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::18) by MN0P222CA0002.outlook.office365.com
 (2603:10b6:208:531::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 17:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 17:14:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 09:14:42 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 09:14:38 -0800
References: <20250105011525.1718380-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <willemb@google.com>,
	<petrm@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: test drivers sleeping in
 ndo_get_stats64
Date: Mon, 6 Jan 2025 18:14:22 +0100
In-Reply-To: <20250105011525.1718380-1-kuba@kernel.org>
Message-ID: <87plkzlv9h.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b714a70-9543-4033-7a60-08dd2e75a43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ypg1GrE1m3CgpEpmdgIwuXj0tB8roO7ae3JVOtLZGwAfa5k8pzIiwlO/kQJ?=
 =?us-ascii?Q?ATGwwuXN0t4jSArqNAfNyLdIbinSjyDWLz5gkvRgEcKlA7Z/yByXzPiPpAhF?=
 =?us-ascii?Q?GKWJCIrP5BN/5gxJGOe3SgWan3QGjdqZ+Hi6oVMqxC2IFGF57h7W3akKjMVE?=
 =?us-ascii?Q?v7kFsUSgUj+CMSTSflb+ZX9krLSVZkG/l44BBnZJwD3uysp08Z2m7uNL9wQr?=
 =?us-ascii?Q?s7mnHszlB258izxFaowKOEwxKm54rreHKaZDApXgBLqZJ4+/Sok+VNENbPhJ?=
 =?us-ascii?Q?i2F2n0Uidp0wYAVxbxJ3R8saM8BQYAXV4CjnXlcewRfpZf1RBpkQ+2ypT15S?=
 =?us-ascii?Q?jQ4MWJbX+g/dc3yURdhb3DI+WzjrBj38HOuxAtA4ryN/uZ4J7Es/4M0wwOkF?=
 =?us-ascii?Q?hk3b6SXvgmHv+QV3XvL/Eqnecr5AgoBz6GO5R4tI9Tc1WYuAXdBdEdWuWS2d?=
 =?us-ascii?Q?PbL3W1MUMHH9hpSmGHu7xycAt8jAYNmvKVhxzDOJ8WC39PZq2wvhrI1tCKbZ?=
 =?us-ascii?Q?/DA4zB5GczwiY5AsYysqARwL+glGVNMPu+vfm4N38Xk1RlUJd0IsvN480UCS?=
 =?us-ascii?Q?RuHTqa6WiTPJETN4Tuw/gdRgCaHgfBXJpY0lGUdpSwPu1aQdRkpWyZk+I4IA?=
 =?us-ascii?Q?ZnJjPKl/eLVDuxdEzn/PmiOCIlaNUv4wIrX5xhG7mCPO3ldsfumGDKDa8pWf?=
 =?us-ascii?Q?eADtGeF/TMSker2JZCkKFqvRVI5BzgYB//n15JgW5tlmmFmHCUydc8Jsta20?=
 =?us-ascii?Q?Zb2kW43EBlA9ei8ZblpqAYCCmdcgbSM/fjHsUZ79D6vSEIDDboHfJTKl2y6v?=
 =?us-ascii?Q?Jbc2JdoqHSFEbLsg5EIA3JZur7g7HUF3kuuWGU78AQHgtbZsq8LP9l0//L70?=
 =?us-ascii?Q?d20YebRD8JKLtBrGAvz4gFw/quUduNyHBWhmM9C7jqosTGSpfI+efIGbeXt+?=
 =?us-ascii?Q?ZR8dOJNb1RxR0ur6pUmK4nQKbxS09TFB3FZ5FRnQ/drbwpvWveYXMX+bmpsg?=
 =?us-ascii?Q?1LpfPtd5WrOqsQnFNizV2zLYQkfx9b9av3M3noiNM9RypVIvMFLrqAM1Ose/?=
 =?us-ascii?Q?qO+VsbvAHOtgU5cTHZ4Aesc6F5u+9CV8medli2TlOfFYUudsuSojodVaKMiX?=
 =?us-ascii?Q?CRQZx3ffPYpd6x9yPhd2Fm6ltqsKpvS/2tq8kUKvmK+gayH4ykjkdvqGbfyK?=
 =?us-ascii?Q?K9n5avjhwFtYffOY7VIZfQHO6ONUQ5tHW4o4E6kPb7EMVma0dz/ADQTetLbo?=
 =?us-ascii?Q?CP2sKdrhQ5/LM8IRSp4k8j/qjfM/myBd7krl2QuZYT3lF8NzQW+9b3Tfx19/?=
 =?us-ascii?Q?UetjMzMXCtYfREtGXJY7qs0imloQoSurZbaZJ1igWpm3+KETUqMtPQNp/+yg?=
 =?us-ascii?Q?0by2J5+9MS8dmVcGjLoduDbEqjQkz3XD5sIX+vKrl3VJRRRcJUy3JeG5lDRX?=
 =?us-ascii?Q?Lfu52IYEiYYQhYOBzeTk87P902i1QZOFUPZjWP7G0E80s3Xz238osm4cu7JZ?=
 =?us-ascii?Q?oYfmsPFx7xAuB+w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 17:14:55.6122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b714a70-9543-4033-7a60-08dd2e75a43f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015


Jakub Kicinski <kuba@kernel.org> writes:

> Most of our tests use rtnetlink to read device stats, so they
> don't expose the drivers much to paths in which device stats
> are read under RCU. Add tests which hammer profcs reads to
> make sure drivers:
>  - don't sleep while reporting stats,
>  - can handle parallel reads,
>  - can handle device going down while reading.
>
> Set ifname on the env class in NetDrvEnv, we already do that
> in NetDrvEpEnv.
>
>   KTAP version 1
>   1..7
>   ok 1 stats.check_pause
>   ok 2 stats.check_fec
>   ok 3 stats.pkt_byte_sum
>   ok 4 stats.qstat_by_ifindex
>   ok 5 stats.check_down
>   ok 6 stats.procfs_hammer
>   # completed up/down cycles: 6
>   ok 7 stats.procfs_downup_hammer
>   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

