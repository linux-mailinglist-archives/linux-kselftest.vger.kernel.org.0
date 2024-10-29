Return-Path: <linux-kselftest+bounces-20989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159599B50E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 18:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC771F2247E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270BD1E1326;
	Tue, 29 Oct 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RxjMtadQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BE1D2796;
	Tue, 29 Oct 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223027; cv=fail; b=WleSy01k/biE6msCRk5Ibn3coUURNvzqYovSwRWDfmBiXT2wtymHwmmFfUocrMzfWNLOatTgGGYgMfu9rk6MpPfKoSt+EZiG6xp38dDCUr/pWnLO7VaJY1KvfdXt9VFLzkHJcshZdHkVKZct5MFKq+j3cfQ41uv/97BesyWRoJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223027; c=relaxed/simple;
	bh=c0pzmwepUVMIz1RTZ5p9YoKffsSy7ZND+9rI3Zw0FcI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umPDLq3yBJw4FTtT1KsmexDttMHSr18cBYYeYQBWLpj6BMxYtMKIhfABN6DQc08G37glCSW+L8EtZlQ518hBi0+QzIgoWr9ysnEpcoi2hY5X9Q7yN8Bpmh1gCNqIVztnwhL8vLXRjgKoH0DJYwLNRuJ8tA6BrREjJkqRSWZkhyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RxjMtadQ; arc=fail smtp.client-ip=40.107.102.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTtiVCeYQYLEpkXPN3W0Ue1QBfVdsPwxyPQLAEgDFj9jC7b0qLjks1dJu1kYmMSFQi3M3sMoF26s8oLMYGyL9qqHj7sgrIrk7dKwvcu44eLeR0E7NeL8RuLwLfvogKO2MGoTA1o3q1i42Z6ChpxsNV7dqeHIiClbHp046zXEuvCMzkKTIYrVs8ihaTRqNHv6BrBIVbeIvOGx4ONV1TY4NRiu3ZpxAQzQrrZKNsjMGe3oyEhINLI/54CZ4JK/DWy1+MfUMkMQgzrxBIP5Df0Qhra5uK2Eq2aiV38iBKII2aVmWS9opAxi1GYW/yFwxW1zwtjn8vi+1u2OPFlJoy43lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zDGCH3BgkFFBOP+dYB6uPibGbkvrVGnJKZGtPVhU8I=;
 b=tIT8PnoCsEtSe6eIEzUG6zY5CtsIVBX2ZEMjjO3acyEc++Etxo7asfoK+Hl+OCmJmHUa+bXwD3iPN6cign4fbqzLOefhkIXw6gpinaiy52lG593MwSsWFiPSI+5ary3Lj7tXwERxHkkbK24Hr/6h2FaASQe8ayjtR+IEiKiEwYgqfFZcII0PthXUJrmfZQrDpx1Tesp457qGvcwk0QfRKfiBb3+PMtRqQf8vN0XGkVc4qFOzPH9IyUN10Mp6zPGFVqvuxe6E6qAutiQrtsWc41ocyrKnTbTXL4zBEksGwulRc/4n0J+uh8isjuxLNLdPBEQB716D0+4ejidRL7L9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zDGCH3BgkFFBOP+dYB6uPibGbkvrVGnJKZGtPVhU8I=;
 b=RxjMtadQmXKdp9WnMMGUmy6cqDo69d3oXnOtsDbQ/KWxUjQTlbAinsZhWIcsB6usS4yTbLP6uiR56R0IITWQ1MyPjzNAPlYr8tOEVxnqJEeM8Q4BbBU2jw5j+KimzLIfmBFJhQYOCsn2aN6XSenMQO30JuSfSlp63nzUuBrjK1fwf53WA8lEHsRBMuf6FkhYciNp3RLDPKRktvN3soY5JNH1b8o+Ng151cZxgNnQ1wBYxZ9Adn3d+FEbQRvUmDQLHDV7Ucl3yUzxaCGMUhvRCMd/mIhLyP8ZgU5rZgo9shuA5alpaUOf1f8KdPo46TazNYB4pYB6EWz291QA9hAqfQ==
Received: from CYZPR02CA0022.namprd02.prod.outlook.com (2603:10b6:930:a1::10)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 17:30:20 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:a1:cafe::ad) by CYZPR02CA0022.outlook.office365.com
 (2603:10b6:930:a1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 17:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:30:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 10:30:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 10:29:59 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 10:29:58 -0700
Date: Tue, 29 Oct 2024 10:29:56 -0700
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
Subject: Re: [PATCH v5 01/13] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <ZyEblBMkvuq2rPAT@Asurada-Nvidia>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com>
 <20241029155824.GJ209124@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029155824.GJ209124@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: acf58280-f4da-48de-9baf-08dcf83f5cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/gSc9XZW03fvX9TJHTlDII0UTtD0v8tqrcYM3IdxwxlUDcGECT7ymulm2Syp?=
 =?us-ascii?Q?TThPhtQNWjewDp3DA5WoBS+soViwzeK05XtHbgQgWizEG7R1aMis7GEjdtRa?=
 =?us-ascii?Q?7BOKwkNVTr6dfOh6BfqTpLZfHWkEaEEKtMp3bhYsnuOrX63RJDsUyl578GDw?=
 =?us-ascii?Q?XNeomFQza4AXEAXgDtImYwP9vr+bpYkUL59q+AlJZEa/wJRGmY624hSssxHJ?=
 =?us-ascii?Q?9EIyFuCERsvP0UQ+eR5gTkzRr59Kfkesm/vzeo0LX/pdMXyue4/loU58kbUg?=
 =?us-ascii?Q?IssnkMdK5kGvAImUFzGBKcpq6HM6hHB9jngZ65g3ZrWFCjLregvrt9gkX9Mf?=
 =?us-ascii?Q?slJKj+q0/38/7bmAqr1N4xeNbTpoWurEvB9ZAIKADrUACPO9u+P6vbRxOLt8?=
 =?us-ascii?Q?U+yGOaUKCT7AjaboGrqc4AD3wLn+s75617CuSpVn7QgNrG/wfgTlGssW5YBE?=
 =?us-ascii?Q?PDXNuzUI9XHDM486IqivBpGG634pgZycei0V7IoaT6U57GdezE5kLKTgrmH8?=
 =?us-ascii?Q?aOJzJYazVgaRjXfaqfdwghIh42+mxvlE8aqUtpv/5CC7iNvb3wAr7aEsi5iH?=
 =?us-ascii?Q?qfZo2sAyEbrH4+/tZJGlSNOWmojh9rBAKI+mmpzwqIfUMLXZY6+gp1ZlswDr?=
 =?us-ascii?Q?6KYYaI0qeok/PNWR+N6172HaFTZn4izdQfl8LaeXkop5t3mJuOcZcyNMB8jt?=
 =?us-ascii?Q?EhIecMQpsOUzlIfrnKXeVUXYafMgf+XnCY7PFeFIMYoFDRzelt3NvTIdtPBQ?=
 =?us-ascii?Q?HN3N+c8rypsfPtbPSWdgChICQvJeA4ZqoI0NCHoHWNDDr0bVbkDWoY4kkd9c?=
 =?us-ascii?Q?F1KSWuaFwY24O84xEBBCXytBZIbfYtMbcVkEKzQgfg4mCIci0t6rhQLsTj1A?=
 =?us-ascii?Q?80p9xw9DuVrmfoQkMH8NkY6cYVl1XTrno1Px7fH/b+j2cYvWNhef57CjmDml?=
 =?us-ascii?Q?5Llx9mjQOdJU/povjh9njl47zJlVUO1eSWHwhr2dhbWmI9RCNNJI5eYab7dE?=
 =?us-ascii?Q?mwx8nvxHXGwJk9j1Q8UnUndqtYNYDV+sFV/TOkvJqN+CXp2GPn/qswfjKDsm?=
 =?us-ascii?Q?7z1Wn/0v7QosDgaVkioTDUoLHXAriFDxShjZhPEQMxF3Juk6lgy+yniZ9N/C?=
 =?us-ascii?Q?hwEMypsigGXmO/6QSWob4PUfyThMycExiTpMYdAZCXGUEhkWRhO4OLkSO9rz?=
 =?us-ascii?Q?auveFD3RykXZwHJbeotXXuJYOwSYwOVN8wccjXe5hMekKELZWHyOJavWsoEd?=
 =?us-ascii?Q?ZOq120qwtDSJkDr9S/zLSjTU4o9V9OGNZPvF+F1q1nWz0gFD5mCVcZNWP7qf?=
 =?us-ascii?Q?8p+gjqIKfc3NLxVZPUKJfqy3Wjom7R9Ou9ZpU35sGcT5aUWxxYlZJ7P4C+rE?=
 =?us-ascii?Q?mGG1h4ediC0uEc9SrYNvqjt5/SPDt9LsJf1kju2/tZ0NeOprJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:30:20.0052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf58280-f4da-48de-9baf-08dcf83f5cab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274

On Tue, Oct 29, 2024 at 12:58:24PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 25, 2024 at 04:50:30PM -0700, Nicolin Chen wrote:
> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index 5fd3dd420290..e50113305a9c 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -277,6 +277,17 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
> >   */
> >  void iommufd_device_unbind(struct iommufd_device *idev)
> >  {
> > +	u32 vdev_id = 0;
> > +
> > +	/* idev->vdev object should be destroyed prior, yet just in case.. */
> > +	mutex_lock(&idev->igroup->lock);
> > +	if (idev->vdev)
> 
> Then should it have a WARN_ON here?

It'd be a user space mistake that forgot to call the destroy ioctl
to the object, in which case I recall kernel shouldn't WARN_ON?

> > +		vdev_id = idev->vdev->obj.id;
> > +	mutex_unlock(&idev->igroup->lock);
> > +	/* Relying on xa_lock against a race with iommufd_destroy() */
> > +	if (vdev_id)
> > +		iommufd_object_remove(idev->ictx, NULL, vdev_id, 0);
> 
> That doesn't seem right, iommufd_object_remove() should never be used
> to destroy an object that userspace created with an IOCTL, in fact
> that just isn't allowed.

It was for our auto destroy feature. If user space forgot to destroy
the object while trying to unplug the device from VM. This saves the
day.

> Ugh, there is worse here, we can't hold a long term reference on a
> kernel owned object:
> 
> 	idev->vdev = vdev;
> 	refcount_inc(&idev->obj.users);
> 
> As it prevents the kernel from disconnecting it.

Hmm, mind elaborating? I think the iommufd_fops_release() would
xa_for_each the object list that destroys the vdev object first
then this idev (and viommu too)?

> I came up with this that seems like it will work. Maybe we will need
> to improve it later. Instead of using the idev, just keep the raw
> struct device. We can hold a refcount on the struct device without
> races. There is no need for the idev igroup lock since the xa_lock
> does everything we need.

OK. If user space forgot to destroy its vdev while unplugging the
device, it would not be allowed to hotplug another device (or the
same device) back to the same slot having the same RID, since the
RID on the vIOMMU would be occupied by the undestroyed vdev.

If we decide to do so, I think we should highlight this somewhere
in the doc.

Thanks
Nicolin

