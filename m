Return-Path: <linux-kselftest+bounces-28758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB5AA5CAC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 17:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E42178168
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4EB260370;
	Tue, 11 Mar 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qpajQCdl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23325F96B;
	Tue, 11 Mar 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710442; cv=fail; b=SJuS4jfw4LghJxNXykMUaGh8iKF/UINx0p8j7D6MWgJEx7ZbFkyHdeP5/zpTHJkhe8jgAPyYib2pOKIrKRSRor2NAl/m5V6ksTLboRmrabdDW2MD9n9hKwmW50EzLrBIJiLPwSm7shbo+60vSHVC8N7sxNCser5LlpalnbTRnLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710442; c=relaxed/simple;
	bh=7HddlVWRnRfrcGuYnjLXJdSWyqW3AcAOOF5MdxXUFd8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2rjto5smP30a6tyEkphB9Z8IqeZThHoCV4gmfQILS5tIOt0jSvFaNl1R/FWK18mop5XSPGNJBKin82fwXWN93iKw7ljc1i5vkPy1jA7FAzt7wWEaZvrZAvv/S/Ui/6z1cRcQxlmuH2PGgzg7ZAm7xXy6OU0eK43rUIsTXzLcjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qpajQCdl; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwxPuZEvjsEI7qJpEKyTiBojCCXRtEJ1FlcycEnnxaEQYDy+Y39hqfbBJmYWCIT/A0dKLxQTHxViED4ijV/1hKOKQmckIt70K7UZan4vAAduUfA0qn3b8DxzV5tCwQ6rJap0v3MpxFIvHl+Eos9kbOqO6AbBTqfwxY4blTAl1EUqhlzAywaE4XdxqZC0kZkMP6CKf7tExfCpe2pULwrFXIOnUQUyjsgoDI2P7Ir2lCfEWIIL1jjyt+0WJ/0lKt4X8fsLWbJM1+Cwr/cBykVENH9KPkHc6xpIHeemRj5eHU6AtonE8uIyEVDYg6cqncBTpne/0mGMvrhkoyEZat8VKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8BeUv4Pov969PJQN0kZUlpld4OjQ0/3bHLnGNMoO8M=;
 b=FJx5+SHN7BFZqjdcQuW0CvX/6k0yCfjkAvTaI3U5qeQtEk2Eg/FKJmvv/cw2QoPRtqPRX1bbUciWIhJciA44Ou/KzeiuHSgH79pT1PsV4oOc2EGiTIHho9bdktIVkD7lgvjNR4RFnWANSAkS+zzVs4RHGZRPRkK6KesdOfx3Hn8nfMsAOzaod4+Nx+hfHIWYOqY8N+i7oeDdFqAmkQOloHC41os7oR0XF9JoeRbTz7x+evBDeqK0FCbgmuQUqDdHLJ95LN+jVK3DwMTQYeztH3wRllfAH+Ta/4PM7aA51fvqXTHwS2rNCSaS3xDtloS24/qHqAsiLsXpO2H1A2o5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8BeUv4Pov969PJQN0kZUlpld4OjQ0/3bHLnGNMoO8M=;
 b=qpajQCdlp8HPzM8n4GW0RQWNAsmfcwTsM/J8FQeyxoAe5WS1d7IS+pGyLZBXRm6fLVBK5ViXGwM2f3rAuQ9kfZX7fyxQRn+aWCZMlZd4kGZe7p4Vil8+iC6s6+KowhRrjrhryyKIv1eJlyLk8UptaQBhT+PDzdqxHVktr7akpWER8F9W4qutn+65tODjmZ9F0Qy7T3NvWO7bJed5wHvMuoBOs35tgrr/Dk6pTybtAf5zzqOdjuBNcV+0O8LmfuxUYPg5C+48o5p+P8YTKmrB0rT347vsZy4wZmxcykh4liKqwvOmhPejbxJWBB838379i0vleJZvsitMR9oErysNpw==
Received: from MN2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:208:1a0::27)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 16:27:15 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::77) by MN2PR07CA0017.outlook.office365.com
 (2603:10b6:208:1a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 16:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 16:27:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 09:26:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Mar
 2025 09:26:54 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 09:26:52 -0700
Date: Tue, 11 Mar 2025 09:26:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v8 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z9BkSq6nLhzsMguU@Asurada-Nvidia>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <7f6813dc2b62f5f396ac3172dc2a7d9bf3b47536.1740504232.git.nicolinc@nvidia.com>
 <20250311155637.GB5138@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311155637.GB5138@willie-the-truck>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c55c2a3-f7de-4c38-382f-08dd60b9951f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yt4p0/ZF/4sPyezB+rXAWu6fZg5zDk/H3ekyIny+YddgShQHi4iRA29AH4rS?=
 =?us-ascii?Q?gObpE/4yBvpUZrB3evkEHbubs7UX2eVNvUBnNnCc2dP+/uFfUzSZZOBgYogs?=
 =?us-ascii?Q?LWn/1O32s5QXynmefayCKVIQYSJIlY7QXzuEG8bWe5zJFYLRn5MKqoVWKHJp?=
 =?us-ascii?Q?0a/fDog/vMWMrrmVK4aeRXd/Elpc2XRmXU3+RbOtMHlngRB2+ig+PA/SbMzn?=
 =?us-ascii?Q?muVgu+v6Zp7J/3aEQQ3xw5j9WYcUErvgsANZTKDZQCmFczg9PcrS0aJIcVl8?=
 =?us-ascii?Q?6TysYLaxwY2b7e7V8Y38qiMpFyqnT4N3RuidoCMokxzZcor2EmCRN64KCrCE?=
 =?us-ascii?Q?a18cGcRuw7QO8ExsEM2f6WNENqNtv52kb61MfpM5IS+ke/GB5INHUDx91pMl?=
 =?us-ascii?Q?fwK9vNoN2mIO2+a+cn56COXc5hvyZlclgWvEabmNy2/1mjo4oj/Lam5p8Wcq?=
 =?us-ascii?Q?AAMGrXND2P1GeqGp9MF0kE7sdyoPVmLpZHPkl5a6gtCpQ5RiTgl6V2+ArjFj?=
 =?us-ascii?Q?YS1aamsv9ZRBzZXpP5PJM+Nv+aCFdKPlx3/lmBxIt2clwzVFcRM4g2Wq0EIy?=
 =?us-ascii?Q?S0/c7tuPQqelSmonFOoYjxOEBTSxV5ufEkRNHV5FBBBTYToIERlaYkUp6uR6?=
 =?us-ascii?Q?ulZLRBDWgY6TmN0bZHrTCSGNIcULN+hMw692NMoL9TC7Wsj3DIpe23Y5mZ4x?=
 =?us-ascii?Q?t/84Q7CQCDecfNF9frQoOpcVq+W4iRXmiLABGvoRzBDqL7feBMYao+KPLklm?=
 =?us-ascii?Q?IFAn0TsRJ6zfD/YpE2nE5zCb7XtbEptYhNTLxRFYKPhqN2JMqsG5MmaKwjI7?=
 =?us-ascii?Q?1ojds/Mhtk4ZbaSnhXO7OxXHpKL+pFCswrYP451yoK/xpQCjuRBa+tYv5t/W?=
 =?us-ascii?Q?CF0GZtuFVrK0IGGo2f6RiodU8B1FwOkGwRAF/Nib6tVzpdir5ng7YlqgnP5P?=
 =?us-ascii?Q?yS8G+dQ7BJ/m7ULPnwEDS3cQzbLGemqpgQTFhwnEpYORPhtRuQvWp3ErWAV3?=
 =?us-ascii?Q?K4Hvh6icwdcYFq6vEe0XUkmafPAxhNCjVJjyIaO3Xtpf5IdpEGnVdScP1gR6?=
 =?us-ascii?Q?XzfFGVbDr1e1lQgozm9DtPF0bd/b+lcqfW92rIN3uPeS0z64hlaoDV14ghz2?=
 =?us-ascii?Q?RXk/S1fwrLXepB1WftejyP1DJz6GHZ+qFSYlL27SHWCx5S3YQUsdlC3KtUZL?=
 =?us-ascii?Q?xig8XfOftrbgypxIPluyWbwpB3nFeLwH4/aPmMM1X43Kt6UPjTde63ke75Xs?=
 =?us-ascii?Q?AbGtErX63o/BMfCFddSIqrP0p9f8WEjfgJ4zm4Ryt53Rr8N/+fVaJ0ZFXPxn?=
 =?us-ascii?Q?oQcpzjf7nGKojb5oyiy5NFI2nECqImL1uUjSswQYRjjBkBiWm6vHmtB7YXOo?=
 =?us-ascii?Q?h+ul92Z8ua0A/FdlaRRHywogIR3sU/TOxYP7viG1R17YjmYquGUiJjUYapW0?=
 =?us-ascii?Q?3/brw/v7k1+ILvLiNM8hQvZAcNgQ2YUega/iMnbYOlvULSnbm94wRIE8U2dK?=
 =?us-ascii?Q?oIEnvUOJznUfX/g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 16:27:14.1514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c55c2a3-f7de-4c38-382f-08dd60b9951f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305

On Tue, Mar 11, 2025 at 03:56:38PM +0000, Will Deacon wrote:
> On Tue, Feb 25, 2025 at 09:25:41AM -0800, Nicolin Chen wrote:
> > @@ -1866,7 +1869,14 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
> >  		goto out_unlock;
> >  	}
> >  
> > -	ret = iommu_report_device_fault(master->dev, &fault_evt);
> > +	if (event->stall) {
> > +		ret = iommu_report_device_fault(master->dev, &fault_evt);
> > +	} else {
> > +		if (master->vmaster && !event->s2)
> > +			ret = arm_vmaster_report_event(master->vmaster, evt);
> > +		else
> > +			ret = -EOPNOTSUPP; /* Unhandled events should be pinned */
> > +	}
> 
> nit: You don't need this extra indentation.

Yea, there was an extra lock in the previous version.

Fixed with:
-       if (event->stall) {
+       if (event->stall)
                ret = iommu_report_device_fault(master->dev, &fault_evt);
-       } else {
-               if (master->vmaster && !event->s2)
-                       ret = arm_vmaster_report_event(master->vmaster, evt);
-               else
-                       ret = -EOPNOTSUPP; /* Unhandled events should be pinned */
-       }
+       else    if (master->vmaster && !event->s2)
+               ret = arm_vmaster_report_event(master->vmaster, evt);
+       else
+               ret = -EOPNOTSUPP; /* Unhandled events should be pinned */

> Patch looks fine:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks!

Nicolin

