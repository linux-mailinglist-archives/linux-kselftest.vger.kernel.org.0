Return-Path: <linux-kselftest+bounces-45597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B21EC5AA95
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 00:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0F4F724142
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F6329C43;
	Thu, 13 Nov 2025 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+GES6PO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA232860B;
	Thu, 13 Nov 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763077412; cv=fail; b=aXf678dAB+pT199Hp9pmEXt07TV56p3aedPmbzkWEWvDA+QTpvdOwHOP78v3/7vqcDZnQVn2bzDlgpCuCrs7FGLa81cn20uaD40aIUprz/FCa+Rn+QKI5k634S2qmLfr6WIDBmk8kWsU06g6VrlUNLI6TNb2Y0nw8ef1HKDsBqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763077412; c=relaxed/simple;
	bh=U3vVTwZzXti3NrbH5PjANdSJvEzBf8Iqhxnft+QWzEY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBlIBW/7SMgAwQPwDckGljP+eDgQn39qymrOjzY25dZtRVox8SkehHH0pcEkyHulXaDNVVEWlJ/4yLYzU3KpO4rBrR86wdFuGOu1YVzeG3AOwCZML392PwiFsDBMV9Yf3brrEMX9k/WwnwWAM3OviFfrzg3Agl59MvrAmRO//tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+GES6PO; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0A0dEeaXMzPT6z36FNCmS+uD0cLp2dYE0JASYE2f/wQY2sVe4vcKiW7ZvWxSuekkjKPng7mtU/H7vBRSsmyGUFnTKk/TEbms+2hm+UBw/GHHqAM1LTS03K7uMctcK51THsw2RD76sPmBg7yAzk6rMfiyPcFP06Oq07Sn9YSSaGy0j35Li36Izqwnj4M9jQYCIPp1/G+5df/2TPqoXtfX83cr0VbYWVzou8Tg0jSx0S0VZGCdvwoCTG0jL/oeu6OVaV4886aG3exTEoLXR7Tp/JFPqLhFGPIgRx7Y9nEirblPVoYg0wxiahvWub5nz7xBQU/SxniM7Mh5zq/G2AX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlKyalEL0AHvzxr0hV3Mx7u3vZp3ZsPA3WIpw5nm59Y=;
 b=UGsOjWNX9YWFg+nExSdPEZxQvBg8rav5wZvkJzUrfC6MkggCq4SMVnbIq4tLUv53BG48/oaDH5W+79IyoXEqUM+9CUyZ4KdWeWG6zbt7d9LSKvXAdRTpU+uR+d6ootoE5NFyrfvqa40rVIOrDMeNrcz+3psu8BJ7Rt+WleK82M9cWUVffZSkYt0h5IeuqrW8O778FIlpVSYWWwG+sg2HTu2Q4Iprs2zx9M5B/R0RJ9KMEGCSlZtgzcoC/3Y50bmT7A9V2cMyy/bifxj7GiMMN7HK9ivD9zmmv38LxoZqK1IQllXZz4vTYMRg3eV9ojuhA5wDewZPGIbtThbL8Hgw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlKyalEL0AHvzxr0hV3Mx7u3vZp3ZsPA3WIpw5nm59Y=;
 b=t+GES6POBluGD0UkN/zBRFfYS+zdyIE26Ggj2KLjXAqJyhyA569n/TLO6O8d7TJIOnFkWyw1EbqlIg9juPzrddBtKqaFq+O72kdfdGug3nK6EOcfen4IckksqHvRtL3thzfcryMvduHU9dqTz03PiLNn/xjh8nYN1l3R96dNezuRRmzrNPkT1sh3ckE/nbCH9Rty4C7sSfOF2WpwZO32hk0+RSHux4h4azcOs1NXSJIKIPV4mqx++haaPuqR2gZx93hZ7InCr9ZggoTeJaRh42Ai7o788Wzwdf3eW1Ex070JyrdWhdncMTaoG0TzbW7HDjlOtb13oWE9cH1Wp50saA==
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 23:43:27 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::6) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 23:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 23:43:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 15:43:13 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 15:43:13 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 15:43:11 -0800
Date: Thu, 13 Nov 2025 15:43:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Alex Williamson <alex@shazbot.org>, Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <kvm@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Will Deacon
	<will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Matt Ochs <mochs@nvidia.com>, <patches@lists.linux.dev>,
	Simona Vetter <simona.vetter@ffwll.ch>, Vivek Kasireddy
	<vivek.kasireddy@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 7/9] iommufd: Have iopt_map_file_pages convert the fd to
 a file
Message-ID: <aRZtDl5VI1YP0qAm@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <7-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: c45362b9-0d5d-45e7-3778-08de230e715c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tuZc84Jsh8Ewk4CO4umSUlPlOPO0fWWK0DCUxrumS0nBVcD5WcO+RT8DrCyW?=
 =?us-ascii?Q?BV9fXOOIKt4ONZAPAiCdZX312E82RPc5rgnhW+/3E8z274RHUPZrwx1NB5PS?=
 =?us-ascii?Q?jzaRajwbWEj5kbJbM/pOJmYWGL2Una6sK2ovHXjzqwt8Oj+1DVU9rh/QL45g?=
 =?us-ascii?Q?G/SQZXI9YHvJC0Jqsvf5/41NP/rD2TAWSPLG56jiXr94QXh+iU9bOkG55SBd?=
 =?us-ascii?Q?0vukTPYKi3Id09iu0uXIZ0hyWfdDpsTEbBODw1ZUBv5m7Vb1mNDx+UAJya68?=
 =?us-ascii?Q?QlViKc6+mA730W2ikWxETIpO7irFKNVgSp/5B16FopOYnRHU3cEnvkXlQaGt?=
 =?us-ascii?Q?KtKWO4AUl+AIu7X0KqV3MxTWFtUt3CgkgQQejfpxtzhB5BwJyepEvIcd+arI?=
 =?us-ascii?Q?zi7H8BzSBcCJd7JVqARtYGSzgrcvGoBOfq82u7cTJ7orRT6OnGkwbqq70/0X?=
 =?us-ascii?Q?GPnzJHIowDYb5aYIInN1WGngf5qZl1ii2jXpmYdbz5etDNM7QbO9BFtPcobh?=
 =?us-ascii?Q?KvjguRpVw9keKkyLRqchWZVlqAue9vNBy86THm86SVC57z/Qlc0xCKBpCjKi?=
 =?us-ascii?Q?3kIKo8DHzA1C23xdxya6UKvEYPnQCWvKYJ8a20znVwzkdxol+msMhXNOYxD5?=
 =?us-ascii?Q?NRAa7eeq5vA081Nq3vv8MmbV/lVhdw/bJBnaiMtole1BpiGDBuFjVWWDsekY?=
 =?us-ascii?Q?BSrbczTTialrp1axNGy0cmC7G3EkrJB6fYHL7Dipclswoj786FbWaegKmZDw?=
 =?us-ascii?Q?xrkLz9SFcG3W1da+Rb3lVxxlud23uovREPpEAOIi93/QlHgyG3u/mpxGDejl?=
 =?us-ascii?Q?LdmlfxX3I7/JT5eoEC4jaS9g8PbzLsnFZP+auZdZhWdtXm+frvu4Dw8vCrOo?=
 =?us-ascii?Q?PUqdLc4N56ta4keUXmzrB6l7BwGWICWZamcz15zB/mgsHwsCXzEJxPBPiyPX?=
 =?us-ascii?Q?GSiKLFIcTUtoUzd7ZfC0IHDr2TwzawdDcomNmMxZZv2B01RNTVrMsLRm59LB?=
 =?us-ascii?Q?uhab0rlW2gpY2Z/BSiHgUDwf81p+BW4QaF8xDR5ODPmVARUBf1r20Oezv1SN?=
 =?us-ascii?Q?XEaTmZREl4RviR29zRJQn4guX8kOl6P98t/lTp4uQ7xKughhFixBJJFjh0GD?=
 =?us-ascii?Q?XNO8CZMrIznjpRAJ8gOOudAuCNL8NmCghEr1qPYBz3b5HsRXiaVOV+Lslj19?=
 =?us-ascii?Q?BSVayUD/w2cWq46MjO/39IdbacxMvsR0VPIvunBeVTha8f9bydYcNZ49fDO0?=
 =?us-ascii?Q?i2To2FKdzU/pjEMotk5GfEhqSqSfJWbn/x+o+WvDQTmFH9YbHdJqrKEBgVKg?=
 =?us-ascii?Q?pr/rt+PwdVPbl44tFkE+uwKldz7cIVcMSbgYcWvRYuisB0XfKSX/EfdLKFfX?=
 =?us-ascii?Q?bJtpl12dD3W5Wo8oSQxkQI3VyKgolsCx5tey4QLOF1J1ZoFliKXx3C/f8pBm?=
 =?us-ascii?Q?hqt21ivFEmZi34129TltPiQftth9OSBubtHssHF3LLFjqDpvemYrtdRj7ICh?=
 =?us-ascii?Q?z0tck+fxX0zxPNAxnHzxW2ao5fGSUGU3rdeHeV70jJFQXyvJIWCZipciwRX0?=
 =?us-ascii?Q?JubZTM+P7rZ+8jr+ZRg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 23:43:27.0023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45362b9-0d5d-45e7-3778-08de230e715c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318

On Fri, Nov 07, 2025 at 12:49:39PM -0400, Jason Gunthorpe wrote:
> Since dmabuf only has APIs that work on a int fd and not a struct file *,

"an int fd"

> pass the fd deeper into the call chain so we can use the dmabuf APIs as
> is.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

