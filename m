Return-Path: <linux-kselftest+bounces-32482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C54AAB980
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A15C16E588
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECEF280317;
	Tue,  6 May 2025 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qHr3baVd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C435AD7A;
	Tue,  6 May 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746500073; cv=fail; b=G0wr2yUTXXWn1WNHnYq5xA+712yCq6TaYF33GIh7hGmhgashWLOkJypDFLRRZ2we+OF5VCoI4VCjEDaDVF7vpdh+R4MFNn1WReDPogYKbhWwegG2sQ5G+QfLbBzb/x4Sz2bN5QAimAiL1MIvuFPPCtpX3t+eZcr0LHi2LLp0U3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746500073; c=relaxed/simple;
	bh=J8MDOvgpvmj7O1bztuRNSxjGf6RRdQAoFsLoNlbCHbk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZopBbZgmQlhULFBwD8Ov3bZJyOWA+NhTkS86mABerBSFnFVrNywLxexPG9cvqNYGWAigMZhZq2lLj5uRPylw/MG6ydj4qLVzdtmU8xHJSe+Zvmu7ebsIOeDbLBOCZeu2P/uxsAxseoFG7FwM+s4KnUol3+N2cNWnGurYfpoJaBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qHr3baVd; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6eBExx1eL1zL/02yABWINFupkd8vGrXgWuNXIpvJODat07yMG33YgowKDhCCFC2ZcNiRW5xTjJCiaAIQeQzHCGofl/V1AmMkEJJnrw8FAIP5E5qog+ujONnHfb3O4HeOIkTguYz3CUy3hzI8WTSZgHkzUOlNGWgmF9UYMBibWpEvfpXAenpo1fybnu0XxeLrSDfqj97Te8qLDea1tJ6veO8t/aH2DSF+DcjFlWzcHeIrhI31ekGU2Ts9t8BcnOcKh6iCpTORZIxaJK+OM8H7/r74E3iajsaVk472T5Zfehy1yp6FBmvEMRZ7694cUkZgAgfSVLm1TmE1U5T/mt0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk4xzjyhRxvuRS9iUa8wmhA2oETlZwzpqF+tgsH7aYk=;
 b=LTSKPqDpFs0nsK1mQ3Sw6E40nLRuPWUCUDqiyOIqVbFnJfvzmORJ4ZBWPXBm575qDChEfGny5o2tSE+Zch9linUwqka0OkIQPDM8VdJ5Rq10Afg9wyiTp3mXoacB1RWa0gcHrD4Jbt2kQuKoTSAlzhXGstRxZG2IcAzt+pS5bi2IMCLDO8LAFHznKA+T8tgwy0CqOod8l05U6Q08A+pN6sGkQp+2o4hzxyL5EPtMBS2fSArhhBQLFD7zlx9RZvPzeNcQX7RAmxtFbY8uIPI72vorbm8X3Kjqytm3aQu2V3oNGH/bfwqTx1JYqk21CQN63FCQ+WimO0h8Ja4jRkeo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk4xzjyhRxvuRS9iUa8wmhA2oETlZwzpqF+tgsH7aYk=;
 b=qHr3baVdyD2lSsW+LyewBTM1Mv9tCJqTDfO2GGw09j/k9uLWDBRz9qzjRg4W9qxC8HhdAHMbRqwLSmZuHaNErEI+usm7aE9q1IiyVop+eQLnWRCUfS8NMxLCcZ2hobdRXFIGeaWWzO5ZGMIOsvG76JORhtxVVsUqsd46jn1d2C/YPpyUf4+SsSTmjy6VaP+ZQguvBC/sD5Ayxd0XblI2BoC4bgxkwtriXhp2/XQHXfolNewiJKhjN+yQ/VkgAStVTxVuFOQWOobdg4HjDVWjBZPHn5JMesYUZAaVZ07zD+lWw/smSq/ohFrhGi3f+/kECJshywzwsD/DdURJ3m0wnQ==
Received: from BN9PR03CA0957.namprd03.prod.outlook.com (2603:10b6:408:108::32)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 02:54:25 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::e0) by BN9PR03CA0957.outlook.office365.com
 (2603:10b6:408:108::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.28 via Frontend Transport; Tue,
 6 May 2025 02:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 02:54:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 19:54:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 19:54:18 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 5 May 2025 19:53:54 -0700
Date: Mon, 5 May 2025 19:53:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Alexey Kardashevskiy <aik@amd.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <aBl5uLOFCntuIYYz@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia>
 <20250505170807.GP2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250505170807.GP2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 881c4bed-d216-4ba9-03c5-08dd8c494ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XTKWsnYJZe9EQhNnsgVDuZV76toPNa2/H8mWryRoRQb8iPCZMIG1w2fm8sFz?=
 =?us-ascii?Q?oIgTJglbmNPJ8D+ZdmJclsPHXz/x9oCxYPDIcmpQnQyNrHwKZkMNWVycBorL?=
 =?us-ascii?Q?C0s44QK+TnoLKKc40G7ZiCnMeJGyvm6b9w1PuKxcxMd8e6E3X/TG7dLCqNwN?=
 =?us-ascii?Q?ZtYKgKYw0PCtVSHYZEJNj8lHY6lF0ftKCF8gViBkWSy1rS5w6cK/H7D4OHC4?=
 =?us-ascii?Q?uv/nTlf+Ko04aBeo+25yqX4pcdov69QfidWSZR8DLsJMyXVNy7Jhdnl0hexq?=
 =?us-ascii?Q?RIKKEt3dAbt25Tlodu2Rxs5d9upgB5PeHiIUe8A9bnnuxURTAQOJ8yxwbpeT?=
 =?us-ascii?Q?ooyM7i3I7Xav3tNDDOWViCLfIUyFKlrWyQXXmJ77g+/Y3XzaFHM7hkUnsdg4?=
 =?us-ascii?Q?oLZv14hQ05YxUEM+slNlck6ltcAFMjlOvygfG5I6AZqPCzIeOm/bF7tN0gM4?=
 =?us-ascii?Q?nze/bKKD3PUKUbeeNPscZ9etHMKIJoRbkXALqxEfghOMi9M6qk5eOAe2+Z59?=
 =?us-ascii?Q?MPUBoarTWxIskOr4vUXz4jqwe0ZgRx7tag4W2ezXjDK/cJ7gkWMK6k2vG4Cz?=
 =?us-ascii?Q?WFZn/VSU0JobaCzOO4wrw9lAFlB5elSHrHl9orKSeKsZrzZcI9T+vrHz0w7X?=
 =?us-ascii?Q?Iv497FTwBlaaBDgVH60Mk6T/txCxkr1LMmp0ieUV3f2Tx0KNVoGH/pl/u/p2?=
 =?us-ascii?Q?8a/0fHnkvrfU7dNfdNA8inol+yQySsfBtSYC0F/vZpt4XFbpXgPcTfOTWdw1?=
 =?us-ascii?Q?Xliu5hVwWpUPJyhnM1wwP2AtzU7l8ecQzHek4Wjt+pNOhGYNBaeWWByFYrlw?=
 =?us-ascii?Q?SdrIlqB1oTEit3xlTUXmbDWLKoQKfw9KRU42I2QRUXPaoX/f5LjrHZQpdS5w?=
 =?us-ascii?Q?A6+SKS0OxnYU79YoSRJN+ch/uqdNm8uFdvbR6WAtxX4iHfQHSWFYIPwoPEiq?=
 =?us-ascii?Q?/xQqPSLuwO7gsnIUBoGWc62baRQQCS6QtqN8Xf7CUzXpr8o5DGkJiXCSV+yb?=
 =?us-ascii?Q?5SYxzcTJ7FaCPMy0kMHQc0ruRbkExwT4r64EuCGVJ1BO9YNP0spOZHRqLScX?=
 =?us-ascii?Q?XolQPP/cM71qAwhz7UQah9xGkN6jkI4RcNnpgd3MZIdAXKFa1ddOb9SX4/zi?=
 =?us-ascii?Q?46LRjdsxE2uCJHuAiJVe+Aa/0a2IUCMYBN055KSYOsWfZKsstFbJhr/bIyY9?=
 =?us-ascii?Q?+dnLTXb/tWL40jf5TCanY5WyWzA4P6PJXTHaXVcJS7Se4ub0RksRI+7XRsso?=
 =?us-ascii?Q?ySOdkZms1+fhrPSZenZV5k7AogoGV6u+WAY+CXKwUqs4LVyLA+/d7lLMG9mn?=
 =?us-ascii?Q?72vNbpDX2XHH8uWkvC59GmkpVLCyyDdJQD3gPHE8K+e8UU5Ok5lHFzs0j+F/?=
 =?us-ascii?Q?YZAL5XgqUjdaoVW7JEaEFQ2uwacIt/bfgnF574witj2C1q5yPsadHQADH4O/?=
 =?us-ascii?Q?Auw4b3ZzuX/Ix/oN39sMKU9yGYUSxWRqdid5qwgzpc6pPekQFIcIt9EgRws3?=
 =?us-ascii?Q?NRevBnbPD1qvH3HNeZsUrBD47deFxgFwYAff?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 02:54:23.6166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881c4bed-d216-4ba9-03c5-08dd8c494ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855

On Mon, May 05, 2025 at 02:08:07PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 30, 2025 at 12:58:47AM -0700, Nicolin Chen wrote:
> 
> > > ... and I just hit a problem with it - this is basically guest BDFn
> > > and it works as long as I'm hotplugging the TEE-IO VF into an SNP VM
> > > but does not when I pass through via the QEMU cmdline - bus numbers
> > > are not assigned yet. So I have to postpone the vdevice allocation
> > > till run time, did I miss something here? Thanks,
> > 
> > I have a similar case with QEMU ARM64's VM: so vDEVICE on ARM is
> > allocated at runtime as well because the BDF number isn't ready
> > at the boot time.
> 
> Oh that's ugly then.. So you'll need to add some kind of 'modify
> sid/bdf' operation I think.

But the initial vDEVICE would be still unusable. Its BDF number is
literally 0 in my case. It can't be used for SID-based invalidation
nor the reverse vSID lookup for fault injection..

> The bus numbers can be reassigned at any time on the fly by the guest
> by reprogramming the PCI hierarchy.

Yes. If we take some aggressive use case into account, where its
BDF number could change multiple times, I think it's natural for
VMM to simply destroy the previous vDEVICE and allocate a new one
with a new BDF number, right?

Thanks
Nicolin

