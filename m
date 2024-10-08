Return-Path: <linux-kselftest+bounces-19253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F89955ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 19:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84871C25333
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5720ADDE;
	Tue,  8 Oct 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GnN39nFo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E320ADC3;
	Tue,  8 Oct 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409534; cv=fail; b=Jpq0gitbyGM+so4VgAQ08SikEO0th6xkX884NBZf0S7JztGS+rOIB7aV46vSIB6pK9CdC6hbqzuflxpVkFc6ycCVQwRp4soCz0rKBUu+BbtUEe8EHIcchWhf/Uwf9h4I8mScl3XxeQ1uABtJx+qBA8ypwpqjy28bW0jyY39+ISo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409534; c=relaxed/simple;
	bh=xmStieI3445wyD5wk++U7p48kupAGm9XGkPTzHiC3Vg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+CMovfPj+RPvQ0bn+mT+WF9Hf/QlcCFkrpuNZg8I/JhwyGFyzGFLsSEBmEXCUva/1CqoAWe/Vqbov/04vjZVqp2NG6QtV4AasgGHr6yj+UAsRy5YxCA/4YlJV4rzTWn/STmE0rfY6Os5gvxi3tL1vteajZUpkxw0bPeQ2aUstU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GnN39nFo; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eT0brvZ5B/iZDzIRDecgsU3ifiAbCfDSaiYx4DerPvhq/O9f5X9npXVz2UAqiAfxByhmup6+J7q6GEAEUaCY+thvst5vEt3FgDweInFO3TPyw4qhAgmpzEVMPqz3hsiZoxtnvTCtvwjqEhk9BSlLBBDFdFXvgwPyWDWiNBhTw88qWq1dsGmV/KfaKumXPh1wH/Na/FgMUvUCCucaPvT3MRmKCwzhMV0PKGambKtTg8qwMNbucqxG5WWP156fMjSrAGupxA9edCEsri0su2eEhEcvrsCZcQo6/ejOZonx/wHIPWAqENU8D/8ds1n2WbSkK+RLnd+xPzqsw0y4DVzeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g75loYJGrlrNYKec8uFM7iHw525JSE/mPuJ44JHPNnE=;
 b=J+xxVLCVcTiUaDNRxGseKpiYRKf5o2N7ZB7vg6EGfvu/F4T+r1ZOqjyEkahZ9wkcu2B5aYFc6n9HbKmyXtCTeJgNH+KT+45wCdVi09f2kYjYC/ZZpn3hqiBgl2eRg8xsxrOMbwZDCpHhrMo9EXIR8iDPV+vrKiLxfB9YOLxmjRn8g/P+4O60OltpTMwX35PvTxOpZBzxYTpzSdlVKh/g/5ZmzJAx1z4ETjXRAPqP4vp7CW5fdjJaXynHpmECjSDhUln89XmoNg4OBaWex7RZ5u7tzFHEKwm4rmLy4JsCroXFdvDsepoM5bnHuI9fXZ1G7aepY/WV234GdJnf9Y+LBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g75loYJGrlrNYKec8uFM7iHw525JSE/mPuJ44JHPNnE=;
 b=GnN39nFocNaqyiDkZ7ZtbXCtz2Vz91H90l4F/jkP35Y8tkz2nUHmEAI1B/w/33coeICG4wuVmiMA66A7UuYlJWQerUH7QnJncycqIetNCAvcciPsQeHDHBvZzdPkMrOdfJiF1JzulO7g2jx4Xc1d5xMqYDjSKHl+xFqQd0mvo6DcJLcNQ88qc4L5EMYwEMyGHFr2QbsLN/EqofVR3JZUFohrQjpWO9vWd2CSdtY/Y9uV4Y2prkGfEBu1f69m3Yq0DQ1dPx6hUjSC+RKjszwDjIAWFDPngtwwsCusmCgpOy6juvE1fhq2BZAWXLvtISK8k07B7/r3fU3QEwnzv54enA==
Received: from CH0PR03CA0224.namprd03.prod.outlook.com (2603:10b6:610:e7::19)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 17:45:29 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::e4) by CH0PR03CA0224.outlook.office365.com
 (2603:10b6:610:e7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 17:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 17:45:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 10:39:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 10:39:46 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 8 Oct 2024 10:39:45 -0700
Date: Tue, 8 Oct 2024 10:39:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 04/10] iommufd/viommu: Allow drivers to control
 vdev_id lifecycle
Message-ID: <ZwVuX1MB3Zr4UDdm@Asurada-Nvidia>
References: <cover.1724777091.git.nicolinc@nvidia.com>
 <3ab48d4978318938911d91833654b296947668ad.1724777091.git.nicolinc@nvidia.com>
 <20240905180119.GY1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905180119.GY1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b8fc3f-36a5-4d13-5832-08dce7c0ffb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?io539s+4lA7jjJ55nObUat0baf8kBu0HgdNymA4ovh8n4SjAMJYAUMHvBwu7?=
 =?us-ascii?Q?PVv9f68oQrGy4876XiLll43BE0Vl9HOJMv/GnYrnOFYhorMXJ4HU55G2qRLd?=
 =?us-ascii?Q?qKW4RNV3vNtrpURWyuoP0j75Q5fiG/9aI5zFNqRL1L6oaveXKTvRezS1p/Zv?=
 =?us-ascii?Q?GVGVTUSKaii+qsqfWHZxkxQt1EMVIpuERpgL6ghqXhhGq3eIl+vTsNTS3gOO?=
 =?us-ascii?Q?XYoConIH68lvwBL0VksJOAW9C7LbCi9S+f9o5gZ6hkdax9121MgiHLBzq4QV?=
 =?us-ascii?Q?g81m+QAa0CzczD8oTyUMttrBO0Fd6l+XTzDGpLjAkvJb+W4kj50ynORnumwO?=
 =?us-ascii?Q?lEvmlAfSTexxGv6lMS8UdyebRDRtG92zE1zrdYUpu0g7LOwIm+dH3kfopft8?=
 =?us-ascii?Q?Gifulog2bEh/tIBO5vVaWK3wwm7PUfO/raJQKnIBUpvEcM9zvp6FwudXftE/?=
 =?us-ascii?Q?iqSWZIz4JlVMisswau5fagREuII5fKYqRj33d9gLQdsFFQGyYS/nkRsVy17Q?=
 =?us-ascii?Q?+KeVmbWN5ZXCSTJETPL9qO2OMhlyHXWabdN6/3sa14d0YO8PLxfwWlI9/Bv+?=
 =?us-ascii?Q?2R1YlRJ9kqT61Yt7TTPoljjmrnc3kaC8U4UuGTdezlsrcH/1o978+7W+0gLc?=
 =?us-ascii?Q?RrrW/PKyK630YDUerLg6WuBHVw59BRihK5vfeeDN4WK6YNnr04QVPJPxVilQ?=
 =?us-ascii?Q?n6loTiz00fJC1DWw8skfsSYkO5RdQ7Bnw7w4C6ejBLSzDXf1a22XVKP4ULu0?=
 =?us-ascii?Q?28NlYGRLZZdQRDPtw1iB3v36c3hKQ14VpbqWViztRRBgkMMuEuQRsRPuFF4n?=
 =?us-ascii?Q?myxv7RA6+xucY92+wjqf+sp3GgB9WCnfDD6qz+ekSlOmxuE5t7IGlGczYt4F?=
 =?us-ascii?Q?2mEKLgsgVobhQu+l4Minqk9JDOFid8YROtvEiFkC7SoUMuaCTXUekjQypdbu?=
 =?us-ascii?Q?AyCiuKdxtrTMGLq1GvyQUMAV1FPN9hnfSqVFRk1xj2A9EQiETjDktOi7hwUb?=
 =?us-ascii?Q?4PE/F88QcTfmkTl4guzB+L7qsfwoEytx1jA3jJt/1QuJ/s8E2j933JgB8tf2?=
 =?us-ascii?Q?e5b69N+uhL7F5zXa55y/Jln+mrLETW9V4pW/Qu2yQ2TSAe30RHlJ6l6vXC9z?=
 =?us-ascii?Q?9EQQ/1iWDl7cUkO/NJcr1LdgIIfbgjGWRLPUiG1Rdqb/XnIhUERMz+49UPhg?=
 =?us-ascii?Q?3cW1yjEqk02ezo0/QYVFt9x71V+y8T/UDM+0oL5XlMjF5RCsIYKOSCH7kYwl?=
 =?us-ascii?Q?AgkPsglpk9HuxfTOkPJVcEkRX4niHgJ3Fl7FGEVLacBxc7c/ch2S7Bhk9/ZG?=
 =?us-ascii?Q?QIgqWlbCMni2nUijO4f6fknzn4PAQmm/pc0p8AIK054PwvetQq47H7hPFIE/?=
 =?us-ascii?Q?UPKD6nDQjX/C2pWvNINZaETOSwME?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 17:45:28.7754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b8fc3f-36a5-4d13-5832-08dce7c0ffb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592

Sorry for the late reply. Just sat down and started to look at
this series.

On Thu, Sep 05, 2024 at 03:01:19PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2024 at 10:02:06AM -0700, Nicolin Chen wrote:
> > The iommufd core provides a lookup helper for an IOMMU driver to find a
> > device pointer by device's per-viommu virtual ID. Yet a driver may need
> > an inverted lookup to find a device's per-viommu virtual ID by a device
> > pointer, e.g. when reporting virtual IRQs/events back to the user space.
> > In this case, it'd be unsafe for iommufd core to do an inverted lookup,
> > as the driver can't track the lifecycle of a viommu object or a vdev_id
> > object.
> > 
> > Meanwhile, some HW can even support virtual device ID lookup by its HW-
> > accelerated virtualization feature. E.g. Tegra241 CMDQV HW supports to
> > execute vanilla guest-issued SMMU commands containing virtual Stream ID
> > but requires software to configure a link between virtual Stream ID and
> > physical Stream ID via HW registers. So not only the iommufd core needs
> > a vdev_id lookup table, drivers will want one too.
> > 
> > Given the two justifications above, it's the best practice to provide a
> > a pair of set_vdev_id/unset_vdev_id ops in the viommu ops, so a driver
> > can implement them to control a vdev_id's lifecycle, and configure the
> > HW properly if required.
> 
> I think the lifecycle rules should be much simpler.
> 
> If a nested domain is attached to a STE/RID/device then the vIOMMU
> affiliated with that nested domain is pinned while the STE is in place
> 
> So the driver only need to provide locking around attach changing the
> STE's vIOMMU vs async operations translating from a STE to a
> vIOMMU. This can be a simple driver lock of some kind, ie a rwlock
> across the STE table.

I was worried about the async between a vdev link (idev<=>vIOMMU)
and an regular attach link (idev<=>nested_domain).

Though practically the vdev link wouldn't break until the regular
attach link breaks first, it was still not safe from it happening.
So, having a master->lock to protect master->vdev could ensure.

Now, with the vdev being an object refcounting idev/vIOMMU objs,
I think we can simply pin the vdev in iommufd_hw_pagetable_attach
to ensure the vdev won't disappear. Then, a driver wouldn't need
to worry about that. [1]

Meanwhile, a nested_domain pins the vIOMMU object in the iommufd
level upon allocation. [2]

So, what's missing seems to be the attach between the master->dev
and the nested_domain itself [3]

      idev <----------- vdev [1] ---------> vIOMMU
      (dev) ---[3]--> nested_domain ----[2]-----^

A lock, protecting the attach(), which is in parallel with iommu
core's group->mutex could help I think?

> Generally that is how all the async events should work, go from the
> STE to the VIOMMU to a iommufd callback to the iommufd event
> queue. iommufd will translate the struct device from the driver to an
> idev_id (or maybe even a vdevid) the same basic way the PRI code works

My first attempt was putting the vdev into the attach_handle that
was created for PRI code. Yet later on I found the links were too
long and some of them weren't safe (perhaps with the new vdev and
those pins mentioned above, it worth another try). So letting the
driver hold the vdev itself became much simpler.

Thanks
Nicolin

