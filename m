Return-Path: <linux-kselftest+bounces-24239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD7A09CA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 21:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE454188CD63
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 20:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094B2135DF;
	Fri, 10 Jan 2025 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OiapR+FU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392B206F38;
	Fri, 10 Jan 2025 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736542171; cv=fail; b=erMRam+WIQaa689ZjawftKpThZI9uxiyUWVmIe+WkvWLe+IVTXbvlp0316HkmIb7EzDia4DWcxrev6gU4VYPygWRBO/U64Jp+3VsRBVXbbxgw+aWITcr/O3Mhfxq3j8NDMP8PYMdctWOQAxEgBLVQN5gKNf4AZWafruxZkyLy44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736542171; c=relaxed/simple;
	bh=S8xhm9UsP2hkgBgejTt//YbQNkZ8ymBjPS6EmSaKmsI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvdWl+KlEo0BvE1WYBNVPYf4BXAFTmImNb9tKhE9MqpYi3scfQE0PchK5y4x3mX1oY6z8MOKVS6CuVmkvcqNYpnrNGD7wVsFZ5rjn/Ac0PWCErcjAqdcQPJogvUZsRoqRdLPsH5Dfn2ulSXfXWYvoN/7aAg5QYNUfqFtSp/cgqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OiapR+FU; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxfUOCYJmH08XxwLYJJaN7dw4n+K6wCHy+g+GD8sFWtG7dy/ZxFodxcvZ1agTwhp9eH1Q+zoQnLyV+MZKK/4NJPUed87ckoTAZ/969tecdWPNMSocjZDnynPJeJBKixPpRn77jQRhy6US7Rv/+/a3lZxFigZufUfV1hkqvn62xAgWKwZNZ8I7sdMG5gyfEwE2Jxo7qn4XppRP+DP85Z9o1tjwePJ6H/I+OmFXej+UtBCzrbDjJVTGXjyD875lHj12qGLC6otpl5l60PMVzysehbD1ni93Spnz6MltMf4G9mpuxeCIGen+GWbl4ko4au5HDMhxg6efrkfFlUGA9EAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r646W0emSrOlAfgl9qOBtB5BAx+cWSG3N89zxs/iXUM=;
 b=VY11p6RfUMy5rIMrvdA2JT8Xa+IX17jmotWrCokLwnW3r2SRm/YniKlq3zvc3agH2ma0ZYqh1L5ZBh9bFxrTazBz1vrBT3jmW4v4nqd8ukveL9jMft5wCJ9pnwIO7xPTl9ZbHf3A9q4jNfWv3KgLqMH6RRXwaUhQ9tlN4dZsMq2+7JwPuYkHm/Qa3S3AQa5YqMQDwSRv7Ghu2ZyXMtLx8DgoUgWkDbKeIp3XWqmjv+VwA9THYsA5IR30eSrvf2/0ZAv4zgSprZ13/Wkht2AndzCxkogSXJhaOGrolChHuTnVA5liIv6FAEuDlk/zLSYEfruRjNSyLyzLxeovM+XomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r646W0emSrOlAfgl9qOBtB5BAx+cWSG3N89zxs/iXUM=;
 b=OiapR+FUg+NPMWWXqx1msNth/bu5hzqmoVU6acyrPMZcSSwInCSFQIk3A5r3+ibGgDbwH8KCofdSm1osx1CDL/rlC7KeFawGrpYxyQgeQeGhZ9po8eiyuK5sT7egcUyDA8B08n5r8oEH1TUXYEUjk44d0lfV4v1GNFqYed1T3KbEl4+9aoNAm+UtTwQk7lrgqrkYW3x07baiw6U+eCZt8LH/CTXdVXm/Kq9KZPNb1lZzZ5gzQOxkgYC4tmvVbWGnz0NR6aW0qtkbzbJpyDRPlsgxjYAAVObc7JMXg1vDJ0FQXtbIFDdXMwJ1er4PrXqEbXa6tkzFOC76UNUJEqJSWw==
Received: from SJ0PR03CA0216.namprd03.prod.outlook.com (2603:10b6:a03:39f::11)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 20:49:26 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::9c) by SJ0PR03CA0216.outlook.office365.com
 (2603:10b6:a03:39f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.15 via Frontend Transport; Fri,
 10 Jan 2025 20:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 20:49:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 12:49:04 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 12:49:04 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 12:49:01 -0800
Date: Fri, 10 Jan 2025 12:49:00 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 04/14] iommufd: Abstract an iommufd_eventq from
 iommufd_fault
Message-ID: <Z4GHvIeDWZzt8265@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <a6490048ab3df78f648e3ef0d217a90b7213d47c.1736237481.git.nicolinc@nvidia.com>
 <20250110172637.GF396083@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110172637.GF396083@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: cc06df64-5cff-40eb-8537-08dd31b84524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4QJFjDoMwmJXl07PP9ew2uB0hhZlyJtCV49WOP3+W4nhHIn8hpX1qOnbjvTn?=
 =?us-ascii?Q?1a3rQFtJ0uQZZuMtXrVY6HBoBGhV+BcJWIKclGnhmwVieL7cBM8+qH6hOuU8?=
 =?us-ascii?Q?zvceSFOJDRFa25ZhKgnMtnli6nCPjl8QBRrKybu+awQRmNNWKIKAXkXPZiqC?=
 =?us-ascii?Q?rwSDjRpksEvtCE4Id1UCj8u1K2Lmxwp2h9I7VLEkdLixAyIZSneXWZWok3pz?=
 =?us-ascii?Q?IQI4VKa3xWkOZD7WcfllzLmcLDIbWdAaf489MClvzYTSVXJp7NN3E82Tm8nm?=
 =?us-ascii?Q?SpHzFEmqNDOiqbM37nmofpu5l8uljrWm8DWTXzzbSxJnYCNOG7SAZZyn/qhj?=
 =?us-ascii?Q?W87uIgJGGudwD909Lg2ZUR3gWkhsR8A9EJekshy2oFZWHBNTt/xUDKVQ4WVd?=
 =?us-ascii?Q?S+1OTIOvLLIpyawLro8fmWxrf1ypcepMTjq0fJicZYGAFHUlleuD9wnxw7QY?=
 =?us-ascii?Q?zctmhjnCqlfQFBeAqg30f0Al1eifK+MmJkbJ9cNokOKWw/GMQZ/l0LgcA2dG?=
 =?us-ascii?Q?DKMGYQqHHyg6gg3aEXseW92VDOu2hlaYddr+s+9uvJDB547DknwxE0lCe7Ei?=
 =?us-ascii?Q?Gb5VMfIXVcpnZdqY7+heFXuQni+6WSOVAF1KHS2wJJxj9b0aa11QR5ieFnpg?=
 =?us-ascii?Q?W3szC8FNaKD/3tbOzaHRJRLTvpnRM/Ayd0VwU/BGfyeB9v8KsD/ghNYWgk12?=
 =?us-ascii?Q?dg6G5EMj2J8/XFYNNXjhxjN2qkXFuVw7PR8ZJO2sT1ra0xBWPw9C2NRWtrS7?=
 =?us-ascii?Q?1Cr66+GleToMY2uUPqHZRDccmkJnLG6/R1OfZ3pQZ7COU5tThkz7etX857Om?=
 =?us-ascii?Q?/VTafG1TPfpXyOQrHdiIquZYa2KrUGYGbdjuFBJs7NC05UdMdNlN3XhgSBAp?=
 =?us-ascii?Q?fG7x89RMPKPTzCfRaqrNAkv+P8FYBecCg1/tJuLQAAGmgdKs6tBcIEGC6A1a?=
 =?us-ascii?Q?a4uKh2ilP6pOkSBkbbFt1ULKWO2E2O8vu50nu59dGiweW+wQojPcw/8IM0jL?=
 =?us-ascii?Q?crAKBw4++ytAHil5s0Xw5IZ98fJ7AHPGXQ5jW5e03G69qMSsJ7DBu4sZz8/u?=
 =?us-ascii?Q?leX5A7k/p6CK83npVUHt24s/NJAeK1C8HOIgBVUExPHj+gZ22rKLsSnK2Uzb?=
 =?us-ascii?Q?mNlO3zmrSJ7Sl1680mKBhCYfFaq17gDguCAtcIHAm+llnj2ZhF3E3+cZ7RuL?=
 =?us-ascii?Q?YnuiBpSGGINRsZqP7aZMbdY6tQESCCEPt6P7A9Ojwh2hf+C/i6R8ALSIOhxu?=
 =?us-ascii?Q?QoZ3XiCWq3paCqphz0UnIIPVr1RPTW/6XFbiZtnvXLc9Isq7JCX7hQoPNxXZ?=
 =?us-ascii?Q?Zmx5DItsQz5QQKgrax9qxZwxNZckFcSDEqKA+C2tbhNhI12d7ix5TbOQ/oei?=
 =?us-ascii?Q?nuI1QKyr2nDECq45h/xu5LXGo9vbZZAwbKk3C9raF2bCsq5+17rzZh5ex05N?=
 =?us-ascii?Q?G0wMMWTN8lSlSx4dq7SN+bY5jW5/VBmicXiLaBo00wGoRv6NUlqntJPke/KJ?=
 =?us-ascii?Q?7SyYmxmVLTbw+cA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:49:25.8836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc06df64-5cff-40eb-8537-08dd31b84524
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505

On Fri, Jan 10, 2025 at 01:26:37PM -0400, Jason Gunthorpe wrote:
> +#define INIT_EVENTQ_FOPS(read_op, write_op)                     \
> +	(struct file_operations){                               \
> +		.owner = THIS_MODULE,                           \
> +		.open = nonseekable_open,                       \
> +		.read = read_op,                                \
> +		.write = write_op,                              \
> +		.poll = iommufd_eventq_fops_poll,               \
> +		.release = iommufd_eventq_fops_release,         \
> +	}

There is an ERROR complained by checkpatch. So I changed a bit,
and squashed it to the previous patch adding iommufd_fault_init:

+#define INIT_FAULT_FOPS(read_op, write_op)                                     \
+       ((const struct file_operations){                                       \
+               .owner = THIS_MODULE,                                          \
+               .open = nonseekable_open,                                      \
+               .read = read_op,                                               \
+               .write = write_op,                                             \
+               .poll = iommufd_fault_fops_poll,                               \
+               .release = iommufd_fault_fops_release,                         \
+       })

Thanks
Nicolin

