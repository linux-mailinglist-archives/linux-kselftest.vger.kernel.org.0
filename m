Return-Path: <linux-kselftest+bounces-20972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BDD9B4E2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7F91F21A94
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387419413C;
	Tue, 29 Oct 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ko8lGjYY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D52BAF9;
	Tue, 29 Oct 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216288; cv=fail; b=O2MUM6fhrM/SJEK3wGuuSLkAhuIKavZQm8LLqTpn+1oTf/yYVN80EUCADuHc9fI1wAaxAZ9dxHTGc6XS0X4qKU6aDWtnBW9e4kXDCAQY0vbPT3W2JGPBzEftjAF185OYUVjF0x5uOxtvMGMrh1LnvYubAE94/WoBnc8AEx7U+Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216288; c=relaxed/simple;
	bh=/fOVDNbT8jQiOD8niKYlL4naKGuILKiTin1ZPVY6e4M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUvfMBBvQEfowtvjCJtz8Vas7Kp55FqZEcAHwPWfpdJXiISjNcBZS2HJL+BUdBDNkkJs7VGGLuLO8wD68UOGfQCDKHJ8K5/aYXOdmZmipMSDFw5pGF3Th3SDsuYYCalXQZ8yfOjj7OpS/YVzX96e/rt73DI6sWmSZ6Eu7SPSBTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ko8lGjYY; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAexEXzTBbKNo2qqy5SzA749Fm33AWx9ldFIynkUQSqzFZUAc6LF6rHj3kd29tdIJwFGz3vkB2mrnFe6yKa6ULIX49mZAKZ20g2ro3jhWgyrzRF8XnP2FaRINjdm8VhMzwQwl896wjdP32vJojpBgY9KDJVsiqGBHrqv4lHgwJR0SemWG+0iRdAzAnxArgRrwaeK782KrGu4i+OEiGxj88V+dyL7/dhGy2CHM61rOXOudwtDSDVshUQH8ZndXaqMi6Ux0szgazn0j1V6UlKZIzPUgR68t0F0KBt1NaoUL/UcF8sHGB/Mtqh5VSwbXRGyBFEz3p8PsSszMI/HfZO71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF7WjVUhiNWRfRao/FjOcJx2urwrB/VgRjQNzYi3BwQ=;
 b=vEVRDl6YRF/9ZrNZq6pLcrZy/pXt+OMkYiPTucXckENriDYq0/lxH3V5A+WUFN22fqT9XG39utxiy5LtEmsT/XMgGl56pVQ37N7zTLDHlI/f5FnF2QNCo2ctwTve1uHIY9eFuIba5Q3oHoDzzDbqtFzT94wZQrL1M4jNLXa9Y+FR5tGBIV7k3b8V+n6VJolRU7Pw1/XraM1N5hzZp8n0N2lHfBvDn3NRC5sLbaRQYSkxTVHU1Ikvo4SeAm2LF9m+SFo2gxR2xB+nzpE8c0A+NcPUPghyovOqjcKQeBmpF0GPKQ2aVq83blXmSrxRmec+/S3ueg4di5HsqoCARL3xPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF7WjVUhiNWRfRao/FjOcJx2urwrB/VgRjQNzYi3BwQ=;
 b=ko8lGjYYzA0W+PUVd2Z4vpsOIZBDTG7YlNv1p4EctSUo4F0PuK1kBGFRTr+QX3f3TaifixuoI1oLS100pY0m0dnVz3SkSddPtYDiHH0Ltt+StjQVp9PMaDWAvzfV+KWbTeH+wQhHipX5BEPw00iGgqRuIcrQdStRHi0nF0ikN96Qifsk6zYk77jgoMThfBY9D8yMVuRVKIGGKUU0B+IYp/tRMVJ6frTHFbAAAku9EN2RZ9sNS3FtmQPoZ9XBRzizzOeUWXoqzMLi/y317zt8aily0nwrudc+ltSJXivml26etNW3SAXh/3N0IASY0/QdoPvzPQynx4ubbkWhWj+zNg==
Received: from CY8PR22CA0021.namprd22.prod.outlook.com (2603:10b6:930:45::22)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 29 Oct
 2024 15:38:01 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::dd) by CY8PR22CA0021.outlook.office365.com
 (2603:10b6:930:45::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 15:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 15:38:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 08:37:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 08:37:40 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 08:37:38 -0700
Date: Tue, 29 Oct 2024 08:37:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 04/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZyEBQPmOiF8IoQOw@Asurada-Nvidia>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f24628d774181da6df6e62bfa3376fbcacef8906.1729897352.git.nicolinc@nvidia.com>
 <20241029145436.GC209124@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029145436.GC209124@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e488636-2481-4f92-010a-08dcf82fabe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?63WSMKwXgeDX16v7rmqKCBtEOCoJzP8lQ70ckdYNYQwmhxCpx/IqwdgQpC15?=
 =?us-ascii?Q?Gdk28YNGm1AtSCjjCSXxK8nV9HLXL9/1NaTM2BzLnHUDVz1W0g3tMjmjknLV?=
 =?us-ascii?Q?dVaDgAD3unPUw8HE4lMwaVdq90TGeilSJi/npTAjTOf4ZjRb0vM/IcQVLAjf?=
 =?us-ascii?Q?XscYYSaexOBXfwOSa7ji8GjmAK4MiaPEuyaIPMseBx0gKWWi4rDXImg10NHc?=
 =?us-ascii?Q?KWnfvU59r5mX8z0DZwHTtmd2vWjV7WGyerSIF7GFrw3FX0Bg8T39jyP3AvOb?=
 =?us-ascii?Q?kFv5rhrrtQtoK93CewVikIyTwZmFVi4ybPa80ndj7I4esFHf3ySXqq2CvNKT?=
 =?us-ascii?Q?EiZJ3XVkPomfE6gafr3nxt2akK7vIFXtuFFZ0SBd9ViXUJzQhf+pDGQxhBRJ?=
 =?us-ascii?Q?AEMIeYoDymyHs1H7rsQZwPvGL4tOGg5f4PtAaW1xBi4nHvvRC1PDfv7Da+6G?=
 =?us-ascii?Q?kr24L94/BB3ctne69eCHzX1pAiSxuzntLxKi0qVLt+YXxDjlXg3P7t8NSmv1?=
 =?us-ascii?Q?koDWyK0vwTjDnwyH3EZjjrQ2+kapwCURqsNwVGOmasFLXLTtUjakqx6J8+4F?=
 =?us-ascii?Q?lQzbEiqQDfX5jxRHqPv4xHL8Em07gsTEMhmIfjtwTutiFhdhdiOmv9KAcUmy?=
 =?us-ascii?Q?i07oZpOmLAm7I+iA70vWdaL8UT37CIpRzV4AIIwP3MiL4W0tTXAZnoHiNRtd?=
 =?us-ascii?Q?yjEVlJ3yZl2v5+wpQDie/cATlYNMtifwykt0J5eAteezADuFlJg+zyzrv/Mk?=
 =?us-ascii?Q?5YMn/iEyI3vTCNE3lfEyT3/iiW3VXa8q1x7FWoBI5DFpspMiPon2u4dYrt8T?=
 =?us-ascii?Q?M+EessaT/0q05v1CXfsCBWSI+Cl/cnZ1adxZd6ryIDAhkwoV3Lx6rNykgKGw?=
 =?us-ascii?Q?rLTiZz1bLOmm/J81HTIdLkObKCveZWsiNIjsgjh8HMCNc+TlO/aw63ePA0+o?=
 =?us-ascii?Q?MVAt+7AEsPQqMFIIGapDW5ETp0akziVo3mfZ6oqfbOLUd0ATg8xod5uY6SQ2?=
 =?us-ascii?Q?HtJgb03WoK3wwFXy0ieLAyxTWZxhd91gwGUoU2zetnd3ZhjdlhOMWFJqOZy8?=
 =?us-ascii?Q?Lq/RuL+aCwBvW3NNpcGpUYerCEFBh9Iz3P4844jlmcI6MW4OZiNVBIsIglcg?=
 =?us-ascii?Q?Wf+pS/+tF8M7cKz3LSDg9m0hU0jZCCVtmM0MJJ4CxVsvdTW7CPADjAe1rM4Z?=
 =?us-ascii?Q?KfQTEbp01NazRJIW05NSCPe4atdq1F2WkCuvdVEdFRXavoUtF6hmChhkKx5F?=
 =?us-ascii?Q?X06tS867x0G05dKKpGQ/kb48zxBUEJkB5lJXXF6vlSpvcqwI7Bd1GNmZeUK6?=
 =?us-ascii?Q?WU93TjdrFSxc/jlIEG7SUXe+jygELSLogit6ZRx9+bwKtFMYg7UNlX5TABqH?=
 =?us-ascii?Q?j4aakhqOhvVT8zKZJHfXMJG43coHL+2E5Pq1EeuceJ2rHZkkXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:38:00.9490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e488636-2481-4f92-010a-08dcf82fabe6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

On Tue, Oct 29, 2024 at 11:54:36AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 25, 2024 at 04:49:44PM -0700, Nicolin Chen wrote:
> > +void iommufd_viommu_destroy(struct iommufd_object *obj)
> > +{
> > +	struct iommufd_viommu *viommu =
> > +		container_of(obj, struct iommufd_viommu, obj);
> > +
> > +	if (viommu->ops && viommu->ops->free)
> > +		viommu->ops->free(viommu);
> 
> Ops can't be null and free can't be null, that would mean there is a
> memory leak.

What if a driver doesn't have anything to free? You're suggesting
to force the driver to have an empty free function, right? We can
do that, if it is preferable:

void arm_vsmmu_free(struct iommufd_viommu *viommu)
{
}

> > +	refcount_dec(&viommu->hwpt->common.obj.users);
> 
> Don't touch viommu after freeing it

Drivers should only free their own stuff without touching the core:
"* @free: Free all driver-specific parts of an iommufd_viommu. The memory of the
 *        vIOMMU will be free-ed by iommufd core after calling this free op."

Then, viommu object is freed by the core after ->destroy(), right?

> Did you run selftests with kasn?

Yea, all passed with no WARN_ON.

Thanks
Nicolin

