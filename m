Return-Path: <linux-kselftest+bounces-25590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8ABA261F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 19:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92003A1464
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C320B1FB;
	Mon,  3 Feb 2025 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z6hzo3cK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797F61D5176;
	Mon,  3 Feb 2025 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738606133; cv=fail; b=HIH4sINcvg3j4YC2WbnuNzZjksL8D7HELUQHNPQvkleH6srUzBvAWP4kI5Y3v2PgCJEjWSVpl17ARHYNJ90pse/Y7yaAtzBNScoVcPAncHo/7osSFNG4oN7uM3D0N3KTL0OweM7qbpbEjWvmDF7OX+2zhZG/oA9Yp6AOjjdEOM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738606133; c=relaxed/simple;
	bh=cjIyg4J6dsfS0UNkYo04Vkp/p/1z/+KmDvonFY/d3eg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbqZNgmpefyX2FKf0cH7ajk25t7eHATuLT2wsfNrzOCxJnuuhgb9u0SzUFQIgLEk8D1g3i4sa5wYm81S8XDoDU3cpzexJIsOhd7VYZUKu6PNO+/wphmIHN0oJ7aYvG04B1VV6jsRwvTznkCuJHPuzR9gaAZp3fC/Hp9oJJhVdtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z6hzo3cK; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcPR0jSQ4sbO/WCcf+4cvo7yWuH49Z8cRIo7sMI8oezk0UnoeErrdAfwigP8GgEnTdy/t7MNrC0uJsK5S86OVt2W5QspYjziTJaCWQEukV/ISWELQHVlAwSXO8LETjJPsRPXnl+ADDqw/WmYOu+XrwboTr/iemt00LdoYcB+IOvKz1UZiwaH80h3Nx4wQnRPU5gKEQU/skvTk9Dj6t7JR20rl4mdF4Rkwl+5j3J4BXP/2rsh8ltMXJHW0YiYVCu5ZFxAPUqDxbTGV2CYPGzXA+4ieTFPp834kTm1LjwwGv9VI5006bgjs9LeOiN6BumyNs+NE+C1W80wpe0RsA68/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsKgvauvsT9AEyvvS+/g77KTQCjZjUTHTc4HokMjeYA=;
 b=AVUKOG6Pusbj55Nav7dCOew2GKiSc8fLb5a4TihRNDLBcd0xaKdzYb9QmbO4vmZUESMlmNoDF7oDS3DZBSefDQTD9tGpQm5J+QXKSxa8awv9KQ3tpsCtN6nDqK7ynU+lMoE+SHBrLoOkMJ97XVpQBhdwmSJVnVDTRgyU/lK0AQOwf9MDXtmtxyI/wx65jwdfkBdLh+hLZVFFVNNwQJnFiznUeRP18eQUzO1TUboSDuJ+3x/qFFGMUFOnGBSaU0oQtUA9yyiD8alIH5esKhamweDs+KQ4IfB2TdvbwT2SshoVQn2+izRqQBn3nWCdqyt13X7AXJ7SAJMfKjHb2UI/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsKgvauvsT9AEyvvS+/g77KTQCjZjUTHTc4HokMjeYA=;
 b=Z6hzo3cKBMLFheseQy8VCwxPNwrmEcPk9IbTEvDUNP0k1iGHBJqb7shJKXiOe8D9dcbWvBQcD2kmbDL4DA8f4mrrN25QFzGG+vDGZRojlnDSwmTyvLfaoqPCUME8EeSVjJYGtD+/ReGTTfDg86FMyIGLnofaU/Eh9cNt6RjiYBseyvwp6Q/hm/U/xEW31K0/PfbTW4x/jIz/A4bjHSorvtoGdtO1TWg2Mj9igQXMsNF1fjZ3zsOy2DEfdl0rACTWVgAY2z0S0JXnNZSohCDnyWECJqDkrPzIPJDRuUso5hwnPKlQYUbQf1nOE13/Poo3pN+XwMK3ouwlT+hoWGKbxA==
Received: from CH0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:610:e7::21)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 18:08:47 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::e7) by CH0PR03CA0226.outlook.office365.com
 (2603:10b6:610:e7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.23 via Frontend Transport; Mon,
 3 Feb 2025 18:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 18:08:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 10:08:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 10:08:30 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Feb 2025 10:08:28 -0800
Date: Mon, 3 Feb 2025 10:08:27 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>, <joro@8bytes.org>, <shuah@kernel.org>,
	<reinette.chatre@intel.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: Re: [PATCH RFCv2 06/13] iommufd: Make attach_handle generic
Message-ID: <Z6EGG1lAwsqoNfpF@Asurada-Nvidia>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <c708aedc678c63e2466b43ab9d4f8ac876e49aa1.1736550979.git.nicolinc@nvidia.com>
 <2b7f6c5e-434b-4f36-beb1-94af12362c8d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b7f6c5e-434b-4f36-beb1-94af12362c8d@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: e70647e4-b0cd-4574-1508-08dd447dce02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H30iHMEntTdDHR2iLXp8QSmG/B6r4IzdsgrLYk880pJC5hUuZO/fuIMDtddn?=
 =?us-ascii?Q?mmcl0LHF74Qxn4Mfr39EDnQX1bMFcztiSk0yC3F9F7qMWXdwOB6dRN1NL6uI?=
 =?us-ascii?Q?E+w2zeHgTW8bLldtJD59tRGLt4D9uCO07kYRnIYPWEFd0ZJpCbKlatoSOiE9?=
 =?us-ascii?Q?zNraaQGrziHh2PGW/8otbz/YHy/cPMhOyZSGm42lhxeFpl8s6mf/NyAnMiOT?=
 =?us-ascii?Q?vJsk/IQr9ByhbjpyPNQAMGhtjQsZG75iP4WEUQQeXhUVTSrhLQjbMgV8PQGc?=
 =?us-ascii?Q?jK48W0JSvsNoKLaT94xSnwl+zEqY9j4sk2D9NwMKdZBPs1+1SkO+11kK7ZDM?=
 =?us-ascii?Q?EScxipQJI2ig7oiwHCAQqDjjDuykqTBYsB+xVEYOkvKcDIxmEvKYcwKLjy9w?=
 =?us-ascii?Q?WpFq7dU2Q7FUzFm++VM4TEDQ7pXK3FydSjIdg7ZAS93gMT3vqCv6HTSY1EzI?=
 =?us-ascii?Q?NxZIFGOLeYpvmOkCgVpIBIVKXFtY3+kBJNEVTvYva8yHVcCdZRRK0Zlm6qlb?=
 =?us-ascii?Q?4GQkAYJ7rmpu1/lWq9NofaJFm+hiIFxNnljYxuIt3XCPYcjzIcT7AXK+44nO?=
 =?us-ascii?Q?X3at30PepZadU6Ra5j+1RiYUnhUGP1Io9BCfJc3CUWzaA/OdvJlIFBRNGYoT?=
 =?us-ascii?Q?zxYBVbmfZb9EycrJtI51SRfkg889TtIqzzmUiPfPfPTKWoM020twNvxwphBH?=
 =?us-ascii?Q?afLqR21RUvRcmgdQ6li2qEdxAcZOlelCQKSI1xg31x5J85jaC3fpieKbyofB?=
 =?us-ascii?Q?KUjFij8jxGmorUPY2RAXsjKkbs5ZtmX1i3otiDlQHr+6tTcvN8QUk2KCZAIM?=
 =?us-ascii?Q?/wzWd5ZZt4tW1QkB1cVkC+XLRwdrknNEB1tXDFJtSb71lHwWZ/sK3I5BeS1D?=
 =?us-ascii?Q?XyF/akf7pz48F2hf0/6Kx86iFWgpnGSes45vTL9wE0qvjq7GKZKI1AQlm0rN?=
 =?us-ascii?Q?2BnX6skOzcUVtyNBXTv58E1WinL61HbxCFo+wOc+FmjDcIqTZYHLT0KwzBfc?=
 =?us-ascii?Q?sfXbnPcfXqLNDdVh95msM45USJWbvRdaAdY1NttOheMD2hh8FH1Vh7icTtq5?=
 =?us-ascii?Q?XdEe0kGMWEb3NhC4AvYNWSWiuT2LXL38px5NLyVEVCYssBeqbmAGbv9515QA?=
 =?us-ascii?Q?+jmeVm1eo+YoAqWRlxtJgc7XnGlLRgF3FsYSx96uSQsI4+FSfGRj7Hz8+JGc?=
 =?us-ascii?Q?SQRlzS67Ud/WHh0i5xbTXCjBHrGL8JOdgZMIMxgxvCJSYL3kavWotL2LGTvi?=
 =?us-ascii?Q?G3IcoEwwKMbVY1Y2djEizLbhruj3gvX/RINEKq+d5Go63Qh0u5LNmq5nF4hu?=
 =?us-ascii?Q?t8CiFvODwuHTlcFmFbvyNmaTaiI6gzV7iOaiJK5SZbeKK8mL0na9BAVSo/Jl?=
 =?us-ascii?Q?iJg9eyrgxa10l8EQCqHn+aslnWgH22A5ncROpf0rrHkbKraTWpTf03Dg5Fot?=
 =?us-ascii?Q?KrPmmqsbfZQhiloPivbhyCqg73D0DEpJ01UreSmx03WiCXKx4AMCKzXuFjQe?=
 =?us-ascii?Q?Po1dsEPH3WU9aFs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 18:08:47.2759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e70647e4-b0cd-4574-1508-08dd447dce02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331

On Wed, Jan 29, 2025 at 02:14:47PM +0100, Eric Auger wrote:
> > @@ -352,6 +352,111 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
> >  	return 0;
> >  }
> >  
> > +/* The device attach/detach/replace helpers for attach_handle */
> > +
> > +static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
> > +				      struct iommufd_device *idev)
> > +{
> > +	struct iommufd_attach_handle *handle;
> > +	int rc;
> > +
> > +	if (hwpt->fault) {
> > +		rc = iommufd_fault_domain_attach_dev(hwpt, idev, true);
> why don't we simply call iommufd_fault_iopf_enable(idev)
> also it looks there is a redundant check of hwpt_fault here and in
> 
> iommufd_fault_domain_attach_dev
> 
> Besides the addition of enable_iopf param is not documented anywhere

OK. I will try unwrapping that.

> > +static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
> > +				       struct iommufd_device *idev)
> > +{
> > +	struct iommufd_attach_handle *handle;
> > +
> > +	handle = iommufd_device_get_attach_handle(idev);
> > +	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> > +	if (hwpt->fault)
> > +		iommufd_fault_domain_detach_dev(hwpt, idev, handle, true);
> same here, pretty difficult to understand what this
> 
> iommufd_fault_domain_detach_dev does
> To me calling iommufd_auto_response_faults and iommufd_fault_iopf_disable would be more readable or rename iommufd_fault_domain_detach_dev().
> Also compared to the original code,

This is basically a cleanup call for the fault specific items as
the patch's commit message describes. And you read it correct..

I will see what I can do with the naming.

> there is a new check on handle. Why is it necessary.

It was to avoid the error path that has a handle=NULL entering the
auto response function. We can change that a bit to drop the check
to make it slightly clearer, though it would waste some extra CPU
cycles on scanning the two fault lists against an empty handle.

> Globally I feel that patch pretty hard to read. Would be nice to split if possible to ease the review process.

This patch is needed by both this series and Yi's PASID series too,
so I was planning to send it individually. I will see what I can do
to make it easy to read.

Thanks
Nicolin

