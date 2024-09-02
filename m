Return-Path: <linux-kselftest+bounces-16922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28219967EC1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 07:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CA6282258
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 05:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C20F14B970;
	Mon,  2 Sep 2024 05:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UzemSSEF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19B14BF9B;
	Mon,  2 Sep 2024 05:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725254855; cv=fail; b=gqZrE5sombjeaimPnkK4BtMJKbq0dWKEqFi54ViGB2+SUrrSKLl4QdAD2VbPq6fcJRdBFlhtVVLnN8lPRATBu1JSvGbRXnJNbsFBPDLywQFkyd7uf3MEyGlnh37W0O3BWhrKSYXpNcZ3jv+uZ2HiCiU4wUfJS7QPted/2if5Hb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725254855; c=relaxed/simple;
	bh=9uuikjnBZ5QO2rI0RX+rRwl8Cut0n25HXTIiH21FfOo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0v+q5O7UpIjcSOCaAkjEXRzEjZpBXuVvfSM3HzS5efKHgPJm4mVAnCkwCrEOXq93YD39amfdz8Icu8kOLOSgHtulHR17oaUBv3UNsycZmmgaGi6tHRnyYdiX5wjjZNBEg9I4hcnEXP0JSohzLzQuoFMmWmG3avTPExbPo491dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UzemSSEF; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlwLfk+1r/tIKJP8laJB2OqTftigDq9RQccqK+8ckCg/9awXuVe7Shkl0COfCrVS/1JTHjZa9ffGjRiphaKP8Ymu55d6YAf1Jpjvyc1DfYzV4LXpL5nmXchEDGoWdwG+61kVPKy+fPTXc8tlN47KmPnSbl4Cz9eBEXGw6xS/2Rrs8Yq34W6nK9xv+OR3okhThDjzMJX+vwHkv8AVj7TpaaI3dHI7fH+jn/J6H0qTKg+b8hguZmGv3XbCK5dCDldqgMTTrTVwbFHHwpdtqB9DttrsioOhp3YjNOkiu4LWuzy/rCY+Y3S/n69zZBgqSt19gNzsPVZ7BZqvtVKJYEb/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWbJipH6wegUxrNBlEgsRP8++HZbPz1wc6xCqMi7yCk=;
 b=AZSf5kF6gj/LUUHyZynqckkV6fPTvAgT+NoyxU1kEA7TsEzTPuZglNszisq1xeMdH6Heg4VYvZexbgtbcymta/0L2iKK7AcNeBoQ58zh3Y/d0f6iMqpf9BADheQLDlhtV6NnRgjz16IrPPTdUXMpln6vi61VcjMuWYW6DUFj3uzn+7ECgggItarZMIwkxJyHvcHAK21zzC2ddlvn33Qh2sbA6IIekldQqTmsv2fvNkwW48r5v4YRklQnM4XuWOLvJdUkzRgKIwtDhyfJjOwfwIvjzJdxe/PQ/Lw+LqBCTm7jYWvseokya+NOmXJH22COn/lO3oypIlFsTTu5IBAD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWbJipH6wegUxrNBlEgsRP8++HZbPz1wc6xCqMi7yCk=;
 b=UzemSSEF9uy02XNWD/wLWXzcYsP/diNy+Q7Hf2dooHMOvsAK1f4JQFUdIRO8xuhVoUQagQ526n8vVYJ850iVOx78nYu3WS+zte4M2IF8S37ExS0cmkwYFNEVqSsefi1/J2475SXny9dxZy+8b14e7hYin4PtUVf4NggjTT9eNM4u33J4nrqE1eITVf2ivXrlxvKp08EZlqHJEdnG9HX7celGI2NaNWOQDpcPCVF9CYUapdedschn8HbFXsco76czIiptrdYFY5K3j/wYRNuBaoyMiELbL56Zaqv61ZkgzCPlE8ZxjOWtjM9nuWQ6F0Vyxx7Mg3SI2CRuI7bpl9KM6Q==
Received: from SA9PR13CA0162.namprd13.prod.outlook.com (2603:10b6:806:28::17)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 05:27:28 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::5d) by SA9PR13CA0162.outlook.office365.com
 (2603:10b6:806:28::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 05:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 05:27:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 22:27:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 22:27:11 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Sep 2024 22:27:10 -0700
Date: Sun, 1 Sep 2024 22:27:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kselftest@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZtVMrXXESy/RfWVi@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
 <55918c41-65c4-435c-860b-b2a177b0d364@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <55918c41-65c4-435c-860b-b2a177b0d364@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: d31ca81a-f9f9-4c69-2f17-08dccb0fef6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g+kneiUg2KHJWXMQfrvIfJLB5u9WJdndcJK6hoUK9gC07O8Yte/2P3Esqsz9?=
 =?us-ascii?Q?ewhJN+7VS9kxoeLtPezyIM6lHNuaeEysrf8ZmptWOOB+A/aJcY4k//Q06bZq?=
 =?us-ascii?Q?iOK8MelokMkt51CrGEe2eg4AT0vLsrZKIMqmZbHXaKn2vq4u/sA4NQuAJ9AE?=
 =?us-ascii?Q?OZThpzRMzFbKPSeorZITQQZ3Uql/wcslwkUYV4HDSIUIPDdr0ut4vzcD1RPi?=
 =?us-ascii?Q?L71OGFCrPqQrCEDmiVvpjdtuNMOLra38MIgNfkqd1bnwjhchQZcDwNw3pDw6?=
 =?us-ascii?Q?Nm1/iTSIoM6zfqRA5gt8i5utAFDTMEzEcfMmwmFxKmLuHCzEgEDVq/rnm3UH?=
 =?us-ascii?Q?s2y7ly93+J05L8UqNKhwTgv46sCPkqHPDZzxEDHHY53dsBvVbpup+iCDDTc8?=
 =?us-ascii?Q?QSe5l5KrruWmwQL8kAyV6UtxefHzmCvy+qCmOZDFXY7mCuK6Bhq9AlI9jL5p?=
 =?us-ascii?Q?VEhwVMq4AQOYizo/wWE3YChQyCtaQm3GMl2MA6xJxI+eMdoMP4qHaQSfIKqV?=
 =?us-ascii?Q?Ai5XfwsgwxQX7bI7Mt2HU/JbDJBBn1m0LFfM5YyasOevX67M4QoLFvdzMx45?=
 =?us-ascii?Q?EKnYKzf6P4GPbiQxBYX6/7guS3GsLXnhoK8ZUwYKhguGgwzCRLnJjDayfP17?=
 =?us-ascii?Q?NqTJMTUS2sa63sU8krSmW3+VaGzFIgF9mSMaFc6GheLn7Rtxy0ZwEprJMjEX?=
 =?us-ascii?Q?HhzckuZYQe8ZG5mcxMkSCRWbdYFIn4pJJt2yQ0+oN0VFEWnkCXZlGdkO9ifk?=
 =?us-ascii?Q?gtDDAJZf5u2HZZkbTjk+rQXEEFlWARvJSuyythETvhDHa0unWQIc/irfWMZ8?=
 =?us-ascii?Q?b52b9MjC3/+mcrmkNyAAaGwrFPvnKmag3JUNmtKiNIJiYrxDz6ghCzRL+PIr?=
 =?us-ascii?Q?BwZIbEt5pJZ2KM0UzRwojiu+wJsICdT4axh9yAqCp9Sbks7jKwm3299WEleA?=
 =?us-ascii?Q?g/CO+HH7AGDFGICNMo4HMNFClVVCHEIECrd4iKCq2SOMiWFGOXJxkXd6o9qK?=
 =?us-ascii?Q?xVRS0B2Ut+OD6b1yqSTqpD9sfmupiYNVZaig5zxOYn64RJ2fbaOtp7H6FBUr?=
 =?us-ascii?Q?oP1X1M5i1pL/SOzrGgVoElKIWHzBaoSve7ZY4w3Z5i2mucESzzYwcbLfK0r/?=
 =?us-ascii?Q?tC+hnS/xKoDxpRtACme4spBK0iMBZkJcfaoudbc/8+GpaFU8LrmbM4O+t3PF?=
 =?us-ascii?Q?rKlwmWlBKvuNYlu4Ca8eZPIxVqP+W+NXN4R8Xv5VQezSgQHh/pdpXTI17W/K?=
 =?us-ascii?Q?N/agyPSA6VYZdj+8bGhPwc2KliZmBzqdHdnyG/tgxeyLU74GaQ2AtJ4YWAaP?=
 =?us-ascii?Q?QxHueISsXbU7DmnGtTsNFL/XwaPLdPqKWaW2vtIGWFCCLuPo8ZSOR6LWEdpo?=
 =?us-ascii?Q?XJUP3KMN4ZE19qrEliRkUmXg7gvaRJCqlgtP2HetIG7gUrJvaJdLp1DE6+6F?=
 =?us-ascii?Q?LiNa8F8PZgN5FW1uGXfaWHbcKzqpHHnV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 05:27:28.0088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d31ca81a-f9f9-4c69-2f17-08dccb0fef6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980

On Sun, Sep 01, 2024 at 10:39:17AM +0800, Baolu Lu wrote:
> On 2024/8/28 0:59, Nicolin Chen wrote:
> > +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +     struct iommu_viommu_alloc *cmd = ucmd->cmd;
> > +     struct iommufd_hwpt_paging *hwpt_paging;
> > +     struct iommufd_viommu *viommu;
> > +     struct iommufd_device *idev;
> > +     int rc;
> > +
> > +     if (cmd->flags)
> > +             return -EOPNOTSUPP;
> > +
> > +     idev = iommufd_get_device(ucmd, cmd->dev_id);
> 
> Why does a device reference count is needed here? When is this reference
> count released after the VIOMMU is allocated?

Hmm, it was used to get dev->iommu->iommu_dev to pin the VIOMMU to
a physical IOMMU instance (in v1). Jason suggested to remove that,
yet I didn't realize that this idev is now completely useless.

With that being said, a parent HWPT could be shared across VIOMUs
allocated for the same VM. So, I think we do need a dev pointer to
know which physical instance the VIOMMU allocates for, especially
for a driver-managed VIOMMU.

Perhaps we should add back the iommu_dev and properly refcount it.

Thanks
Nicolin

