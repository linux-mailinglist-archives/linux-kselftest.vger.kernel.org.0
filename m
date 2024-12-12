Return-Path: <linux-kselftest+bounces-23279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E059EFE29
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 22:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F74916903F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671A1D63F3;
	Thu, 12 Dec 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o2e+Vtt3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D051BE251;
	Thu, 12 Dec 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038635; cv=fail; b=qcs2nxhNBZgaoZ7nt5lm5E4M8n3gTNHNUgplxWHjx1O7HH4adVJHuuSMptlwH/swDaU4PPObhwp5MzOl5hnJtc/qeFRe6a9YYR4Z1AUuyy3iA38AlIgyBRdgKdyNbXGv/oSnlu0coKwqIyc3s8wCNjtNNyN8kUF2rvdYnKYA62U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038635; c=relaxed/simple;
	bh=7VjShGu/Cqzs1GBJW3h1YnX/Rf9B8nAO+R+DEprjUro=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vi7kjDDBlyahMHPv53vUwD15FP/vUMuQ4t2xLubrKanL5SWldStrrEx7CxJF4wU/Ig4lVVd/pexxtysBx7Db7hUFNc/PP1Ck1x0cx2EgyVx7CmvxhMT7I6Du6BIeN7QEhWkyYh2lzZpOLAuKbrUPekzzNkokuve95RfECqX1lH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o2e+Vtt3; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r06p6pqtz+rb9ICzp4xxr22ZWGPfIA9bVtKHc4jOxuMbrjSjbBv4Dszn96KmN4TIyTrSZs88qMGDwPisGjuFqWv9Plv6ZYWGg0xpVU92+BVg+m104NgtURunv9MMRxWscK2qkfLYtP2LUeM8wNYY6KZwFQ1OxPd8Ezg43OXpacj525SFOrGiz8UFL9RDIYsFbLIlQetztwOC2BBlMEj6Gx/K7uejU74m7WS5ZPSh/DI0jIdcAXPrjcBmkNNtOxINV3H+r26M+UJwxHjq514wMeXwFYuEx2aaDCdYx0OY25v+J0goCAp5az0A0TscY9+9xj+8MM+eQ9qmSE3IABlEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g5c1CLfA4A05EW/opTPiWtw5JtK1rKH7INPILmt3d8=;
 b=c9KhCLmLmK2wqSpBzsw+ozBCDW8ZJdLfCNG9qqB1SBC5HI/1YkmSO3uC5C3hOrA+U+SI54RUWhOJfHn95KYClva3pwY6uBhR1i3waG0qn3XyvFawfbbplbPNKbdgrVeLUW4nb5V+SQznDXtrSsDkAA9JQAogcLu4wzZd3pW9WDyF8oYZiCsAtr7oo+JRUOWCURThaEYtfP9OQA1jo6o1tbFlHm1UjwZ8U/vgvMSJuSR4uZ6zZnGV4tbFVjHoOTHHXZVrEtKM1s+yeJTWUn7h9aKcjz5fjZOR0n9dka8zwO4TUf3MgopwOluSmsN9nBMkCPpu2owlruDlIoFcvK+jDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g5c1CLfA4A05EW/opTPiWtw5JtK1rKH7INPILmt3d8=;
 b=o2e+Vtt3QbPMfA0wb6UD3Dplf50Op6cESA6OTk8cILMuelbo6V6kbuaIyP+EIY2oqz+CRnbJ/opnmVTLCW6mvOcWCKpqBg7x1C93NhSERHD9DP4S8LrkstChUImI/j90A87O4yAybd7CdFmRvX2wiewmzWTwZyAa5iEb9pjV68NRmm2FnEPpxdzAD+DlQHXZ9opVuKBaCAikU6B9m8sCsITYjSKwLnt8o5hdD7Ur/kVaSaSG25QbIq1TNvZ54yI0b4xdQPpRDLID+NOGSsy3t311I0FdyXRUeNyhYWI3prnFgFz9tiT8rBp9IH5bG3H5tg7hvKJhQ56S5sqUpeAjfg==
Received: from BL1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:208:256::26)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:23:46 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::9f) by BL1PR13CA0021.outlook.office365.com
 (2603:10b6:208:256::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.5 via Frontend Transport; Thu,
 12 Dec 2024 21:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:23:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:23:34 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 13:23:33 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 13:23:32 -0800
Date: Thu, 12 Dec 2024 13:23:31 -0800
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
Subject: Re: [PATCH v2 07/13] iommufd/viommu: Add iommufd_viommu_report_irq
 helper
Message-ID: <Z1tUU1Nfvyr5zrtf@Asurada-Nvidia>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <7e9842376e6235d9e3471356d035afe2bfe8f33b.1733263737.git.nicolinc@nvidia.com>
 <BN9PR11MB52768F3CBE04513D1536EB9B8C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768F3CBE04513D1536EB9B8C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f34c54e-4308-451b-9ee5-08dd1af3430c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kL6+nQcILic6TCw9r8Asd1hpqElCAgz+u4+ZoR3rHkzNeOGNAR9xLIoX/ltT?=
 =?us-ascii?Q?Q8z59nM7wOAkAmGYUOLgSmASwlYBBR7BEmHiGui1d5i9LnGzdC2MFMdajkBV?=
 =?us-ascii?Q?kfoo0NDSKMop84EIdD61eqVZpfndnMFymbG7d/Q6gu2SxatwkjEDMGpxxohs?=
 =?us-ascii?Q?vdU696fdFF2CKR9OzZql0ABhWE5gZknD2PwgJKVB/SGfQCGTQne1j3GPh1nU?=
 =?us-ascii?Q?NE9KUtxM0gyW2kqy3P4K+tYPuRYN8zPjhFqe7q3QtASZ4KY/fEFVmHnwgQmA?=
 =?us-ascii?Q?BGOcyk/J4zLQnKhNJRCZvmICoK83edH3Oa+dkG7X4oFMheROVgw+dTX4tGVI?=
 =?us-ascii?Q?/5U3HEkdFwUqlbFqJazSIovgSTb+MciofBdq5VrcQKNenpBGRwz+ZPJZ/8zn?=
 =?us-ascii?Q?9O2i7g4PmPahqt7tUBEQWc8Cx+Dh0nUk+gEiD7BIBOkY9nmIJoi9ywaX7WKW?=
 =?us-ascii?Q?U0GfF7kXfkeNWXneIfr0hmuToH5zmT+tvyjprz98u1UbwHH/9UuO/ffTcGsM?=
 =?us-ascii?Q?L9MJCyVtU9ifAbYleqiaFdTPnNdBjxUYuoidpbZ5NCBdV76TnoSjli98M7JG?=
 =?us-ascii?Q?2FQIrPo7K12KSw973tZtYcWX7XTWGT++MTbFn4m1OTuTCjszkqW3MzBPzu2W?=
 =?us-ascii?Q?Ac0FvPblZgviKoteM/NJwNT2Li8a7Lwv4X+SpAZGpQ/9YQoc7Nn1IZHpnZxF?=
 =?us-ascii?Q?nBsXioV3PAwJFXSFgMmB0SdREAY9le6u6lEH+baZ6YDvu94AwbpwUn6S3WEx?=
 =?us-ascii?Q?aII2ztYQPuGSYYmdyA01o4r9NQCqECU4SdNggwdOAnQqDXZHSjDyUfuySpxA?=
 =?us-ascii?Q?CfAI2rb/Je+XyTk+8nFe0p3M0jLmQl9HHHXDoC3/DkU1NJy3yes6DjmmEGra?=
 =?us-ascii?Q?9Qa05ResXlfY8XvH+1XXpsuAa23qdeVypt70qVZnAf0xfhCTDsbL+1QWqEmz?=
 =?us-ascii?Q?6JW8R3TPpX2kR7j0Awg9TPWIeQ/q0w13f7baHA8xkTOehufuiipbHQqdQnM/?=
 =?us-ascii?Q?6Bd8+lrHQAl0EMC8crZjHol6HHyXCA9oTFDbkuFpoz3nr39eJRhDW1kDAhUh?=
 =?us-ascii?Q?HNWcgZRIRe7WbCIe1386NqkqfLwbrMf8Mb3FusRKTgTd7WLVMy9Y1BSMNx65?=
 =?us-ascii?Q?d8L2WNM/zYE6fOAJyvSOabyvjmkAiMNf7ydtb3fqQpJQPJJ0RmJX83hIbw9o?=
 =?us-ascii?Q?ewbf6IiW8UF8hFyayxzenlMH+6BM9ogycpv1Z391LqR3DT0vdOzWfNiyh6Ku?=
 =?us-ascii?Q?c6n+9r3eMiAS5gMRHbE//b9+9w7nlhMMxdghx5uQLdHwayHsvFURIdZ9nPDg?=
 =?us-ascii?Q?1EQwz/8OTBoHp+xXYBdKn4istMyBTX7zkogEAe8KSXnYa8YvzA9zoYnpzi68?=
 =?us-ascii?Q?4rtsUqivfWbugdg12efzY7OhLf9e4rlyhYxiJcsiODMqmhnLf3kF1Q4Exn67?=
 =?us-ascii?Q?92dMtjjJ/Y03C855BDepJaTYTfZ0NJS3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:23:45.8879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f34c54e-4308-451b-9ee5-08dd1af3430c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217

On Wed, Dec 11, 2024 at 08:05:45AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, December 4, 2024 6:10 AM
> > 
> > +/* Typically called in driver's threaded IRQ handler */
> > +int iommufd_viommu_report_irq(struct iommufd_viommu *viommu,
> > unsigned int type,
> > +			      void *irq_ptr, size_t irq_len)
> > +{
> > +	struct iommufd_eventq_virq *eventq_virq;
> > +	struct iommufd_virq *virq;
> > +	int rc = 0;
> > +
> > +	might_sleep();
> 
> why is it required here but not in the iopf path?

It might not be that *required* as there is a might_sleep inside
the down_read(). So, I can drop this.

> > +
> > +	if (!viommu)
> > +		return -ENODEV;
> > +	if (WARN_ON_ONCE(!irq_len || !irq_ptr))
> > +		return -EINVAL;
> > +
> > +	down_read(&viommu->virqs_rwsem);
> > +
> > +	eventq_virq = iommufd_viommu_find_eventq_virq(viommu, type);
> > +	if (!eventq_virq) {
> > +		rc = -EOPNOTSUPP;
> > +		goto out_unlock_vdev_ids;
> 
> s/out_unlock_vdev_ids/out_unlock_virqs/

Yes..

Thanks!
Nic

