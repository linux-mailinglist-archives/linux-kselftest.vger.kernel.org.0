Return-Path: <linux-kselftest+bounces-33733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1C6AC2D37
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 05:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4EF4E464C
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 03:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776FD19AD48;
	Sat, 24 May 2025 03:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d/ny2XVF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F94A1D;
	Sat, 24 May 2025 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748057465; cv=fail; b=USOWWnlr4k9pgDwLg5beBH/XaNP/loLcwMEdb4T36LT4y3oTMdoNLqG8aSlTQ6BHuV7VS6s/UkZD6qiM1hZDtkrhHYv3tWp1/hVdSM91u5waoKV4z75ewkvTvfTsRxQNU7wuxJJodtWJh1TMdhvtGw8ie4/S/DdLmPOB0hWvnLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748057465; c=relaxed/simple;
	bh=qsV16cl4s4nZFFEysZFGmfq5FggV9rLio70o1xOpyeY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP+8RbTV5IDpI+c6sqht39L9rxqL42Qgz1MWPwlBsirxwtpKJsFwOa3ZNPu+0t/4Wb4sytjJkHlFYkkOkdx6ndMKhievG3h0m4ZslQK95E/By1scgCW+LeB843X4HE3ZMSGZBOA0QqPrwExOs5Sp+urnX1IhZme0TgI9rwTMDf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d/ny2XVF; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quFOK4H09wvgqjt/l1/rauDylKtU7EdUASDhex/WxjY6MbZ47x1QO8ragfnxK3JvFWzPTT07Mp9FfCXlYKNBTHh6+BUunfk5q8L6pPdWy3RrCDwtHtNzUjUDTPC56UUuQfPBnerlHXXodk2GIVsqIk8YLqR/DEAoyWZSnYEF8cw67bFRttjMmIGcvLkWnifPkoOAXWNx2qRogEIOF4lQsB8bnpDwDpfIE+61Ryfjkhu8FiRpXBCWcTzq/ar3nUjFalljWNHlxjYG28eP3tQ8ohCX1DZwcNPK2boz91YG3Pjk5Qhu3asPRPL9N6BM5zS/6Jmsu2RRPrXdnrS+IoOnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGeg59IbrTyhfsH7zb4ORv1bnacu9xpc+yDTvyzrzWs=;
 b=MMi6vsXgXJFispL1Q/CeYNqzXas2cUq/U6mJ/JzV8lbawguFZjNb+33uIKiQVF1RgeymuucOZwcNEErpEpdQ2mnn7Tv+eUW2v/IILviu6CuWbh7R+wuJp1sFcm9Kzv01Su/+KB1ocL6S0SLJI5Bp3QWPSrsC1S+fql4fxGQVtJ8oA708htpzQaZtqtfESGHDa8Tu7eSk3s/HUbdtpkVAJWQsZP1VYiZ7krbRfrJdkRZimilV9oPUSQh8nRn28NcnQdtVlGUDq2DD7uYKz28eLIIU/DnAWZQcazyfpbPq7VoNnrDYG3+EhxSVv6HQqtRXk8gXkCLaZFUeBnF2HOfdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGeg59IbrTyhfsH7zb4ORv1bnacu9xpc+yDTvyzrzWs=;
 b=d/ny2XVF59SWESwYLbdpU2pdP6XnXBslYptxALoHUl6rYokAPezu2fwSpAxNJHFQZTeaH+S5RCYsqP+9E/Nt6GRQFNgf379+x4835ZPxfZbxQAEVxZvV8Ahfp3ZnOMamAS7WIX4qssZ8tc5cvqdxjKS5Vh7qDhQ0lXsNU27F4Zdq/SafiXAu+aN6Ojx/aLFAheYxfLS5AsoR89RM/G49km/TLZZF0cB9gMFpjF8VDkIYSIHngsdAVIfpbfdBf3U62C4e70adksln9EBMlrPD8oQ1IcboxV4X1SN7juhtrwwHFeC5xSDAbQG/ew4H4Facx+h7pz1f0m5Wz3KSHuCtIQ==
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Sat, 24 May 2025 03:30:56 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::d1) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Sat,
 24 May 2025 03:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Sat, 24 May 2025 03:30:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 May
 2025 20:30:38 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 23 May
 2025 20:30:38 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 23 May 2025 20:30:36 -0700
Date: Fri, 23 May 2025 20:30:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 09/29] iommufd: Do not unmap an owned iopt_area
Message-ID: <aDE9WyUT3z2+asQA@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <3ddc8c678406772a8358a265912bb1c064f4c796.1747537752.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ddc8c678406772a8358a265912bb1c064f4c796.1747537752.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e1da59-9bba-45c1-27f1-08dd9a736533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wZveVzyhpKsOHDEliWaHu5aBISUo3g/gdeFIkux98C5o9U61UEIdQg78Vz1l?=
 =?us-ascii?Q?qkrDwg6d1zwO2MbEKijw4x8yOIa1+Ti9E/Ruc+oR2vNfQ6fmEpQeCu9QpBp1?=
 =?us-ascii?Q?8i78awhmTdip05ar70erSIBuRPDcM3q0Ktygc5bOWywzM+Dc/1wC1PtXhwpz?=
 =?us-ascii?Q?vFpIOMj2LoBMnRnGJMJSBQZ7cc7tzGI0DByTYwaeLC50mWmfY/8Ih5OwpJdH?=
 =?us-ascii?Q?p98SOZcuXZpsCA05/6vVkjuns0s7WksRr+9ToTDxk1a5g6YCd4CuCSakPTr3?=
 =?us-ascii?Q?QGdrH2CfErp3xwvK3gYVHxr+s4fkjlPDvUnQVfIwCNvUeqxrwAEKLynEl34G?=
 =?us-ascii?Q?WCizktSLo01hH1PhWGgDwxpbZji41M38c8Y6CVjsZmNsy1ruz3laXCYiB+Hr?=
 =?us-ascii?Q?aEZWRfqhRNmv0iC+HY4zd/zc/4T52XF3aH22gkweKIPFk4+5QP61y1Cp2eOD?=
 =?us-ascii?Q?44UBbVZa+sFtcVghXm+obrSlRJGRqPx9brGSyUL541KspSEnF3KMM/lOLrLR?=
 =?us-ascii?Q?DqmvMUX2TSG//QSHP1fQNs28noD0K2/O9rzBFbTEg61t2xc+wjghFntaMzNT?=
 =?us-ascii?Q?y4xtWO02MK+MhVzjGYRuQ4jTlWi07TNw+EsAnz99befjLiUL6f30lKvSt//g?=
 =?us-ascii?Q?/SWPe6piHDN11fI0hSEIkAECMzRKxtZ5FjKFkVIe7eo9IyEAPqdtx8/Lilk9?=
 =?us-ascii?Q?oac+01rRDhwmxyjgaKdvBeroPaHDT8u3049iVZtVGPODTZPhXV1a5nnLsbzA?=
 =?us-ascii?Q?WCO9ZX3gL99qHem6bVUa5DSLjgnHBx8843J2eHDY94BlJ6KTVJKdCA+2Hobk?=
 =?us-ascii?Q?BpLJ6GB68eWQIMy6MnG+zgQRaTf7g1hgX/NXyIosRJqzLoTiJt6eCACNCsum?=
 =?us-ascii?Q?mIM8RQrgW8RhnsnphNwsVc/flP3zehMOORN2e/CyM0PBGOcv36EMf2e6FMko?=
 =?us-ascii?Q?+fsmSEV3sw7Bqz+zku67DdZ6PzE5FyANrMq4w2hwuH5ryaGhqHuiZV2rYZ/t?=
 =?us-ascii?Q?S0FAKD82tJtVq4dYYqlTweO8+VOXd34qoGu/tdKgygxJ5IiM1C3mJiGge/aG?=
 =?us-ascii?Q?sTbopiUfdV/n9ua5GsG21nHzCaMET3NtD73FbhhvfCxblE5mNeKoBFS6k7XP?=
 =?us-ascii?Q?tQRcGWIZOplwkcmC50S8GbI4+HZ0CZlkYXIjtM5zyjqR8XatXXNT1YmnbCCy?=
 =?us-ascii?Q?BWRjDYykjI2r91HhS0ayTs8GdcsUkOggqiAvBQ/WbecmM6iKA5moGfv06Hy7?=
 =?us-ascii?Q?dvI7C3KQnzIt4anl++xulsAysdzDROzVJE2yM36mYen6gAelXZzGdeWjI8b3?=
 =?us-ascii?Q?lDBhX1tHngOKWDHLEY7UxhkfnTG8N58KwB/k3308GdMkQcR0gZ5myvFhDmpU?=
 =?us-ascii?Q?KBFRjC16mwqcSwjeGVAF+EK16j2Wz6MXrIM50cG9+9YuRJWKcuhXoCh196kZ?=
 =?us-ascii?Q?so2DwvtuzVkqT4m0jAhJkWoyjdrqFwv/IafhmSZEnjHY42HgGmtNZZPDvQBv?=
 =?us-ascii?Q?1bbEMaXN93p9OBUS0S0P9yKY0sPiU6V/LRui?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 03:30:56.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e1da59-9bba-45c1-27f1-08dd9a736533
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495

On Sat, May 17, 2025 at 08:21:26PM -0700, Nicolin Chen wrote:
> @@ -250,6 +250,7 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
>   */
>  struct iopt_pages_access {
>  	struct interval_tree_node node;
> +	unsigned int owners;
>  	unsigned int users;

This isn't used anywhere, and I forgot to delete.

Will drop in v6.

Thanks
Nicolin

