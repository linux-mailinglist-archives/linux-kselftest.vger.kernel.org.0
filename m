Return-Path: <linux-kselftest+bounces-19169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6E99338C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231BF1F2457A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03E1DB552;
	Mon,  7 Oct 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SqFThHzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F8EEC9;
	Mon,  7 Oct 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319007; cv=fail; b=ukYbXnMBNBS8M8pWYU2nxBIQDnuzf0JSsjS3AZSSLHng+LPMQl4duuLzQSwEy8sLL4PsxGIzLZ7ZR2Bu6A73ughadA9y1eh1L8re+y2sqoDeFub+ff0KIqL4/D6LN0wLaWY1DsRWy4YmjU94BFKFGEetP3reP9UM2tuNv3hBPUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319007; c=relaxed/simple;
	bh=4Xbc9flYUO+rJp0pUlaKzbxtJeVYl8k9PVWsHvVfhqE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEDrN3/VMHiBVcmfg+heirT2RREte7ev9Zk7htXB22P/56b/34VsTDLerXjHb2NhOYQWzZ5NvjtcfFYwA9wC4woLnAXxeQ09DVYsOA8rLZHsdDueVUl3skkxIe5ugUCtzuj+tLf6vVKjx1dpQpJp9dIkXVYG59OfOYLV5N3S2kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SqFThHzg; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTqaX4ny7CsmDkj0oD/ESxSoq+z/OREhHEGmtyEHBaGzUymDeLQUQi2w8HfQcqp99NQmkI6GVC5OZhwFWkVn5/5cIDxr+yQujdDG3UPphoq8o/CsCbK87431Hz4Rel8Dry+Wnpt7l5OZJ4OR1JHPPyy7hiDwIQiZaWtF2tzFiyRFU76oDdWdqZb6TJ2SjUeyj0d9RPBnfKWZ76bZyGU1RDuTRjoaoQg8V9fEdk9ESmhWLef5Q/QqYVEOIio8IecCCWZKUuiuPj29ADHhVEgfGMvTaDmSRutesQVhEFd41OfRLpqJ8t6qBgrX50TQfcvat+Gi5Ydlta3bbMry9ctixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj5Lxa/mwtFXCKVArj8AOzR1qmsWsFeTiz/EC96OjVI=;
 b=XCqb+wRSPJEIzXUD9vpzlFdtmHOTgJwRssc4nqUjqn95OoER8oaHV0BGpxc+krcLM/7nBIL1Xcza8QyCeuujRJUuXokrTI2PxfDKGeI5Cighvxo45jO4OKGTnBXYV3VREySlBt6VRNVAyL/hyI5Ck1Zd6VelY3JxwnVj6mkhjVg22LUnP5Vsmg3fGMs9xVC03dJgpnFPlvaALK+VlBiErt5vDyYb3Q0llEEioJ2quIWSF2hpzmP55BvlWOvgULmxmEx2nqHl1GLpSN14tvWQppVEOti13CRTEvWkjudDF5MyL8UG2smpBOidN0ALX5ZQvO7yVSsuPCgPAZhndaQ/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj5Lxa/mwtFXCKVArj8AOzR1qmsWsFeTiz/EC96OjVI=;
 b=SqFThHzgY2Q94imPR1VF1noD5ORLJHc4yGk9DYzDyryDAspn3ZXsP7kkSyXdBTPWMk8ITJOZG6sS77OCGmVrgoHPgRm56nAgEK1rAwnx2gXKgsXZ7VO2M1wgsW/L5cKG69iqWKSh+/lSLqACY4QxuHErSRMdGV+xgPZnYkm6Oc2GZfHVW8qYeZbTQRhgfxRleD2DyD2YsBwlX0ZmUinqLoWlipbQcZvbUs/NSSZFuHH0LfoL4HTCyjtgICyHEeDKuSXm6RW/EkF8aIJmvc8+Uyi3CjiH+PB0WiB5poBvq1XLGMJBo20k5VnxPhBlp/EJj1E55GQHeOQYA5tf2qby0g==
Received: from BN0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:408:142::26)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 16:36:42 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::c0) by BN0PR08CA0006.outlook.office365.com
 (2603:10b6:408:142::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 16:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 16:36:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:36:22 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:36:21 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 7 Oct 2024 09:36:20 -0700
Date: Mon, 7 Oct 2024 09:36:18 -0700
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
Subject: Re: [PATCH v2 10/19] iommufd/viommu: Add vdev_id helpers for IOMMU
 drivers
Message-ID: <ZwQOAvoJrMWOuxxd@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
 <20240905161415.GS1358970@nvidia.com>
 <ZtnwG/Kmaf+fZFAv@nvidia.com>
 <20240911231103.GR58321@nvidia.com>
 <ZuJdPHRbMeYFATT7@nvidia.com>
 <ZwDMb3F8/cCFhwcQ@Asurada-Nvidia>
 <20241007153837.GT1365916@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007153837.GT1365916@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d8ed71-bb33-45c9-7122-08dce6ee3930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJ3cGjn3C7/+Mmfverd2vmFWWAIeJjDslA/Ga4JQolp+e9dXa8IIp6RNibMy?=
 =?us-ascii?Q?6j7xntMlw31MP/PxHlvq55o5ekQFICgT2jDkRGg1XnHzHV9tBtdTWNw2bzn7?=
 =?us-ascii?Q?5ET+h6lLu+R/rIXvjTH6PpV7SXmsT7e4EE43qGjfDWJobm/TRiwJwDYuj+/T?=
 =?us-ascii?Q?xi+WjynWwdKR7RGPtVm0jpRnf+UIFK6bOtHKvNeREiHXHUby93DlFTlstjl/?=
 =?us-ascii?Q?gavGayhdzNTrcpkgaigbhAuhLFFC5AZouviLTw5S448d768+3IF6FDVlj5AD?=
 =?us-ascii?Q?IY6GvtUPvZn0Sjf0wMwvJ8kf8gUPD+PHpiDlpEkpuQxv/AVssNlzwx2J4zz0?=
 =?us-ascii?Q?bQiU70Hf+fhKyFJGRZD8Yn4Js+IfSuvABLMXfp0r0jwcH/e9ghrOT2pjUWW7?=
 =?us-ascii?Q?9kDhDOp40TQYlC9q+AkYwRtsCIdm3l5uQpqaU1luWlrfETiUHT2Qm3Ijvs2D?=
 =?us-ascii?Q?2PO7cENt10IqDWNZ4P1uEOAiEsNxZwv2pyhufMIzXMoDTliICYuZ3x36epej?=
 =?us-ascii?Q?5hq5YgPauw5e4c35mO2qmzrwXa7YSf93dVeq7UYkAOizniDADulPmH6lrsKj?=
 =?us-ascii?Q?32osJ7fN44Xx4F7sLezqHNsxJXTUyS1QSBYqWprm/RzR8rTnldPS5/XfCL1x?=
 =?us-ascii?Q?znjeIhFmlZsq+gIIPrzW3uPzhfjUUwajlN01445LSZ+2Yn0VFWVXMNOE7w+Y?=
 =?us-ascii?Q?fTEQl77pgfdXmCOQVbR9yK+85jo6Iqlq17DJsa5iS2v2rFqwEXe5jG/pUrCW?=
 =?us-ascii?Q?uxHrglhG/rbDuNcysF+3PVvWLG4HDYiLKrphhqy8Ua+7606L4e8Xqwcz+o2m?=
 =?us-ascii?Q?HAAsL3bmPO1bUOcR97xZSreFfrUCGLzWQpcYauXWJHBSquqL+nYj1o/+9J9c?=
 =?us-ascii?Q?cAGHTGm2fmFkCORHOiEixzwE0BiGd1YUxDUdWO8AILYjbJR3D8z1kESkqnIo?=
 =?us-ascii?Q?8lECos5hS7t+DhtXK0uHpr/5PLv+nBWIYwhgouVXm1l7/h+2gRRRBL+W8yGd?=
 =?us-ascii?Q?XSaiaBTlsnP8BsNdoaVDvdH2nok/wsqO8+vHL0XTJov4G3ThxJ/5gNf8qOra?=
 =?us-ascii?Q?lRF4h1VxUXzxBnycexxMl4WbGMP0yNLx9Swhf4G2EAJfPV7r19E0ia3Ye8L2?=
 =?us-ascii?Q?k0qKQAY8FPJQacoMOxGj70xA+dVjbKzrfOo09jQeo3gXrXT3/WWR1rvVZQTy?=
 =?us-ascii?Q?GWsEIkJiuyRZNCypwblLcvoB4LULeFYaSsy6MPV/OmxXVF+alwT18+RKOWOr?=
 =?us-ascii?Q?aA54xj4P/tn+4XABJ+wJMhRtzEEEVi1YNjSgmcLbe8EUquJlYYDfB6X85LTp?=
 =?us-ascii?Q?a4T1GySQdrfyVz1T1eU40aLpiOvVsXP3HYBxW/yD12KEJh/tK2OwqhQeQ7wj?=
 =?us-ascii?Q?b9omRVED5stwC3bagQXtnH6fNCrn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:36:41.3817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d8ed71-bb33-45c9-7122-08dce6ee3930
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

On Mon, Oct 07, 2024 at 12:38:37PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 10:19:43PM -0700, Nicolin Chen wrote:
> > I tried exposing the struct iommufd_viommu to drivers, and was
> > able to drop a couple of helpers, except these two:
> > 
> > struct device *vdev_to_dev(struct iommufd_vdevice *vdev)
> > {
> > 	return vdev ? vdev->idev->dev : NULL;
> > } // Without it, we need to expose struct iommufd_device.
> > 
> > struct iommu_domain *
> > iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
> > {
> > 	if (!viommu || !viommu->hwpt)
> > 		return NULL;
> > 	return viommu->hwpt->common.domain;
> > } // Without it, we need to expose struct iommufd_hwpt_page.
> 
> It seems OK, there isn't really locking entanglements or performance
> path on this stuff?

-----
The typical use case of the first one is like:
	dev = vdev_to_dev(xa_load(&viommu->vdevs, (unsigned long)vdev_id));
so I am asking for:
/* Caller should lock via viommu->vdevs_rwsem with proper permission */

-----
And for the second one:
/*
 * Convert a viommu to the encapsulated nesting parent domain. A caller must be
 * aware of the life cycle of the viommu pointer: only call this function in a
 * callback functions of viommu_alloc or a viommu op.
 */
-----

Thanks
Nicolin

