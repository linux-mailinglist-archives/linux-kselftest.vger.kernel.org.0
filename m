Return-Path: <linux-kselftest+bounces-23277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0939EFE1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 22:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEBE188789B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C341CDFCB;
	Thu, 12 Dec 2024 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGLRj966"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BAA1AAE28;
	Thu, 12 Dec 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038451; cv=fail; b=P87HRz0u0hdn2/Oo2E9tQaa6T3xy8MBYbZTwzwL0iGQ7N685zRjJdbV4Px07peMLPh3HIXRcaXLPYPG+qlZxzG3q9F9L1+73eWiNMvrQHzJYj1iIKqiyinb/isOcmrvpBbty8eijAidL4jZb+twN2CCyflN+wz0XMPRmdhkb0Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038451; c=relaxed/simple;
	bh=vtOhtBo+CleexuDoZVi8cDi8TNodiGefPuXZS4Gp1t8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHbofOAzPyX5JT+MTqAmsFrZ/NJfBoiMVseNNnVP+8J7/Pyn6SyyjtTElUd3Bnb3PqHmcFxp065ei9pXhLk1LzR0EoFfkjO4POGWeOIrlvpb7Zb5VqZUg8A3hf3lCE03wOMnAKq/du6DdlJ0nHuFBOBgfPb5KZfqLnaJfb9p/JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGLRj966; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxPavZkhvzllZz9dvT3lQ9blHYhBHZKbWBah/Je07C7FrnGlY13o/oHDo6QKM5wgLPUmqoQcc4KYZfE7JydKChC6ojIBrxDpN1N+GRP6MCeS3lcuqktcSc6mGeuu/y52Ym22bpZwOaRK0dvlv7i6ruvDCHvA834MksVyugonhbihBZpmzIQZIKDt41j4XJAF7KtcMVeTTXRffXFFQ/WpjDuiGxoBy8a7Mi/kRBhWegEI7z3OuRCvS/FBOX+8Tn1QNPc4YZ6cixkt/foH7JpDPuZ74H5rLnhosXZptMWJzTQSvOGhLiop3S5GhcR9VHDR9+MW8qsB+J9w2Mx81P8y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl2WXRgOJzhrnr31UPvr7k5wWZyej5bBaYSpoSmMqVA=;
 b=pV4TFhauaGg4Q8SmpO80YHP3DSdQR1LACAXx2m6FjN/8819XLhi6pQzQoby/325y9n2FtUaSinjlMrDSxUdHx3tinQTmGjTltWNb+nTefuludB3U58+XDyWSX2zV4j9OxOZI3WVqQpQRYLs2psOiljTJMQFuCIaZT9GagnDaw1dOuf0jRtj9axNxvx95hFPUPfD9XRV3oa2m/yPIwZQbGEW+TwQGcxN6B7c5wct5gFSfS6h9w7xJUip0K4xQB0HkoVnxDywrBy0Z4RyLDGQ4Tk+ATRTYMdvdHlMoIXHYVcUN6djf9PSxD4Ts0wlkVBFgTKKjiCXTNlxlY1HInDs7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl2WXRgOJzhrnr31UPvr7k5wWZyej5bBaYSpoSmMqVA=;
 b=RGLRj966b2N1mYJtuOlVU/ZrtOVow8CGt/+pzd+WbX2P5jDXmekQ/GhOnO6tjNszLfPWhQBHAlQVsaQYhGv33ikd2VqZ2V4Swg7RmyHDgHKlxGAvPW2DE6KUiZL9ob6I7Gd24L3DzWNU4IEnO/pD5w9VW25JYM9XCXcZmmb0ez7qZ/2+fycqfJYkT2dOSb1w0AJ3idc0w1ydeiGw6VGvavMBqcH7L4dO35cgpR9195NbrB6ErKqVyQl2t5uFvaDu6vuHe7kyXGmADAsESuTgAHz5p+4mb4pC8+GWd/MJzFLL/QN6LuZ+Bdu8Q84R0lW1QlDv2n+PuctJJb1vYai3Yw==
Received: from BN9PR03CA0552.namprd03.prod.outlook.com (2603:10b6:408:138::17)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 21:20:45 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:138:cafe::a2) by BN9PR03CA0552.outlook.office365.com
 (2603:10b6:408:138::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Thu,
 12 Dec 2024 21:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Thu, 12 Dec 2024 21:20:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:20:16 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:20:16 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 13:20:15 -0800
Date: Thu, 12 Dec 2024 13:20:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: Re: [PATCH v2 05/13] iommufd: Add IOMMUFD_OBJ_EVENTQ_VIRQ and
 IOMMUFD_CMD_VIRQ_ALLOC
Message-ID: <Z1tTjaJ2dyueFjWy@Asurada-Nvidia>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <7f5f7adc2493c7bca7edf76ca15b377c8dc0d397.1733263737.git.nicolinc@nvidia.com>
 <BN9PR11MB52767F481C7D05EB1BDFD7D48C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767F481C7D05EB1BDFD7D48C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0a65a3-784c-4ef9-8dd1-08dd1af2d6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VB5NmS6Ic++fCCuFUUL2cwTeCjvuZBHNKTtPzFbxe4GiEtbPJKAvHU2nzTMI?=
 =?us-ascii?Q?RJzCHJ5BO7sTb8etnk69daDNjVNOL7PgY9PWUecLpyrihqepkVuAixtqToid?=
 =?us-ascii?Q?0XpzRY0BzEuJ6gW4MlxM7hok7os1vqdASUr9c2DQCwsSOYVslJknUd4zJPyV?=
 =?us-ascii?Q?p1Q4CAa9j2fYyJr6sPnHkVJ+v0YrPfiAI43b9rjgZH630kNfYaCSeTySFJrZ?=
 =?us-ascii?Q?2c2SkCbquNlMZz4lNmY8nb6C9I1Nv8UqT3VMhHimLcixSO772xCOZ8p3E5i1?=
 =?us-ascii?Q?ksZDMdy/Q4F1sqR7VSXZjFlW+T1npisDNqjeVZbe6eqSVmu5WGqZ3L4ZjzQT?=
 =?us-ascii?Q?KC0CK1m6CeQINaU2l3h75/q/pXSQ/T1CpghNRMmQFucZn9hhEdvWbsFv3vUW?=
 =?us-ascii?Q?K1PWvKYvlGvmCePOXGkXacn7o3Xx/cvF/1eVTlxXWxxk5xR5TFwb+EyTK57q?=
 =?us-ascii?Q?w7SKOKvtSp8HmfoBA26e6Z5p5EE4XXs87LrLUwNv9JOYcOq48IcNjq/P7p39?=
 =?us-ascii?Q?dL4TvOxfVCkr7biAcRfwApNuXfdUJLsaCxDX0vyBBlw4NvX1A7Iag26gQ0iI?=
 =?us-ascii?Q?R90LLJGa9XMvHFEnQ65mn3AezdojdmPGbqdiXHVv31X34d9UIMGaCVxaERtI?=
 =?us-ascii?Q?LszmB3UIAIBCCxjbt4q52nkXKBulvAcCBL+68CUBpPmv/0iB2yqo+rJep00b?=
 =?us-ascii?Q?SSJN3cR4dz+3yHg+wYY7TiuCnG035ZrXqzGtqEqjtPMapnlxrPLr2uaSXI+7?=
 =?us-ascii?Q?UfJMPj9mGUPbtffPxXn19CfVJoxrmANlKsk+rk44m54vMv48df8T0r11bgpO?=
 =?us-ascii?Q?6cRkm61b8WcwyDdTMLokU3+CBroxUWjUKbgBpHJEO39Qm0AsPjwxquSJdhBS?=
 =?us-ascii?Q?V4M6fbNhFst79PD+PhaqE1Kk58+pruVN4VJDLOlXeIwqAVOK4iBy4hpnAlYq?=
 =?us-ascii?Q?QWgVjUxd5VH36gohIoTfWJRNxRJqglYmASw7/C2kTtcglB+dqyObv+q4d056?=
 =?us-ascii?Q?JW4ZLSHfA+EQz96rg2uCGMyX/9MZDWjgMTbl6vIcYL/BSQbSBy/fFE4ifzyY?=
 =?us-ascii?Q?Lap5YVpzbPEW5xFadQNGZA4ZoPYNHIE69ZNayVvBRy8LBSuiY4wy1DGQCMe9?=
 =?us-ascii?Q?t1k5lTPYjJyeLc29KjvCNp4QH8MYfzZGaV9gDe4B+Eiqzua51A97hZZfAJR/?=
 =?us-ascii?Q?5LbndUvgdoLhVabH5O16chjohtPrD8LYzC5dWJNj9c0uivPw8m30S8LfjIsI?=
 =?us-ascii?Q?PRdLKdPW6flPffog4dKKiaox0tSZjmRF7c6tFeYHMlwk90SCnotqmJI0DceJ?=
 =?us-ascii?Q?NWwRxyIdn7yB/sapFCHwTAiLWl1HKei9nYY4sPE8H/4tACsUeWY447HU0YTh?=
 =?us-ascii?Q?tIKaRBIxxtSRkJVxIsIHEVO7H89gxtW5/xdwUg/3wxYH/slN44km1URwkdlt?=
 =?us-ascii?Q?Qb8oNpZs3YOr6/I4qG9CTeorVsUFlkFN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:20:44.5468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0a65a3-784c-4ef9-8dd1-08dd1af2d6f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

On Wed, Dec 11, 2024 at 07:55:53AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, December 4, 2024 6:10 AM
> > +
> > +/* An iommufd_virq represents a vIOMMU interrupt in an eventq_virq
> > queue */
> > +struct iommufd_virq {
> > +	struct iommufd_eventq_virq *eventq_virq;
> > +	struct list_head node;
> > +	ssize_t irq_len;
> > +	void *irq_data;
> > +};
> 
> looks the only use of eventq_virq is in below:
> 
> > +
> > +static inline int iommufd_eventq_virq_handler(struct iommufd_virq *virq)
> > +{
> > +	return iommufd_eventq_notify(&virq->eventq_virq->common,
> > &virq->node);
> > +}
> 
> If there is no other intended usages upon that field, it's simpler to
> remove it and directly pass the pointer in when the handler is 
> called. Anyway iommufd_viommu_report_irq() needs to find the
> eventq first before calling it.

OK.

> > +/**
> > + * struct iommu_virq_alloc - ioctl(IOMMU_VIRQ_ALLOC)
> > + * @size: sizeof(struct iommu_virq_alloc)
> > + * @flags: Must be 0
> > + * @viommu: virtual IOMMU ID to associate the virtual IRQ with
> > + * @type: Type of the virtual IRQ. Must be defined in enum
> > iommu_virq_type
> > + * @out_virq_id: The ID of the new virtual IRQ
> > + * @out_fault_fd: The fd of the new virtual IRQ. User space must close the
> > + *                successfully returned fd after using it
> 
> s/out_fault_fd/out_virq_fd/
> 
> > + *
> > + * Explicitly allocate a virtual IRQ handler for a vIOMMU. A vIOMMU can
> > have
> > + * multiple FDs for different @type, but is confined to one FD per @type.
> > + */
> 
> s/handler/interface/
> 
> > +
> > +	eventq_virq->irq_wq = alloc_workqueue("viommu_irq/%d",
> > WQ_UNBOUND, 0,
> > +					      eventq_virq->common.obj.id);
> > +	if (!eventq_virq->irq_wq) {
> > +		rc = -ENOMEM;
> > +		goto out_put_fdno;
> > +	}
> 
> there is no use of this wq

Oops. Looks like I forgot to clean it up.

> > @@ -335,6 +335,8 @@ static const struct iommufd_ioctl_op
> > iommufd_ioctl_ops[] = {
> >  	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct
> > iommu_destroy, id),
> >  	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC,
> > iommufd_eventq_iopf_alloc,
> >  		 struct iommu_fault_alloc, out_fault_fd),
> > +	IOCTL_OP(IOMMU_VIRQ_ALLOC, iommufd_eventq_virq_alloc,
> > +		 struct iommu_virq_alloc, out_virq_fd),
> 
> sort it in alphabetical order.

Ack.

Thanks
Nic

