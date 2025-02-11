Return-Path: <linux-kselftest+bounces-26407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C3AA31494
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 251D47A26F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB7626216A;
	Tue, 11 Feb 2025 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="olxA8RkO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F077253350;
	Tue, 11 Feb 2025 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300675; cv=fail; b=qKv6AEvOAaghAx7qhNK4ov8VDs42fEEbytXkzQ8WNE9ZRbDM7jF3xuXyIlJeFbrHxofGR258gO5sajkz5GWCnGRETxc0r8lXOaRU41JGJv3+EjP3TueBPAd0jDCU2TvXSAxO2992q90Rqwss7/H7dRqeQh0xLvozJYTtyy011ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300675; c=relaxed/simple;
	bh=DD9d3J1/z0HhTo1xptuy0+0khorBmSRP4EppdcKjDOQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7DxzhYjeu+rZv/ve28z5zAWbcIsJe93N81AQhx1kvRb7B5Dv4JRUJGN5X26t6kBcAqdJMWNZCA5kfApOSAQGf4TPwdA28zQ2ZdRI4L4WfB73I3MLHRMvsPtBwucmmmDZpZaz46v8LO8hKKBIjP3n2IPE+C7TQaX54MRLZEnqGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=olxA8RkO; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6lKTouvwdBaJIONValmTTxMxJaoDHjgBZnYmvrEHeHQp5IERKSFpQtYX+qeY/9gqBu3+n/t6EVAg/jjjtG8gAWMHP5X5nz62uLGMm9KpSifC4oF+grrS6T/J/mryMk82LzlBkbUnZFGW4HFViY8IO07lbS8+a9lI8UXuz2SD8jyC/GzFl4v1AA+Am998n6vZTLwwcadDuoERdyrAovKfHXff+sp9z0pJ0ch3colxe8P6BNC2hTECch8RjImmSPRf5mCOZyg2gEuMCK+4BU8obHb01RB0iG6innScEfr7NKjJpseyFlVTSBeLAPwiX8WAI38UqST7KNj8+bgaSjD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uivz8WzV61sV8IlmyMzcue/6mBNTCzsA2l0Imspvdc=;
 b=BxAP1zWuIiETx1GeGcu/yr/1fv8pORTk8VYAggBtcF0U7bzAtj09mKk57AHIOlzmQjLyj8BZ3mJG3CQkrdL8r/bJ5ADLLDZZ76UeqGYDi1N1MTLCLF5+i4+h8yzOkJidmGnECauwHMzTh4u6aKEu+PQFY+V59r0tofGbSxT1jiP90sS8DUrFm1ZXfiNTC/sHqyh8ZVw3ubZQVXmsqDogINMfyZ/eGF7creh7Mogtl5dS+OXY9+81yLvh8x1+8qAmScYomeSD1NpwoHV4v4/hJH2cMyebhwXiu0kzGr0g4ganzoVSIdEBjPqJUTXhf3HQOY3C6FCkTpYOgKi3o2QVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uivz8WzV61sV8IlmyMzcue/6mBNTCzsA2l0Imspvdc=;
 b=olxA8RkO5O7YQ6rYccD231lUUpx4SfBD4kDf33kQPkQe221ikzs7Cgoxa7wHDVnihZdYnFmKLoDfMrLMb6lYFydRAxqb0CovJwDh5Be0IffsFyxCGS6St4LHRPIxaf3DZ+brsu5YhH6CPiAHJGYbgS9mOR+Z5RFsyRC9AlmzMEkVUQEhzF4ZZappdDz7KAGYYwoHBVBBTEQaDfV61aexIut8avhHBr3UnlWT9uEYbrzwdc+oAywwZ7QOvDtevFejkZ/SCmcbSI50dIydBfTY8Z+nS56ozOJqgRQfBxzL2AthMjaAcvBvG5eQ7VgFsgDfEpzGQZwz/Ap5HEAySLD+QA==
Received: from SJ0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:2c0::6)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 19:04:29 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::78) by SJ0PR13CA0001.outlook.office365.com
 (2603:10b6:a03:2c0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Tue,
 11 Feb 2025 19:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:04:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Feb
 2025 11:04:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Feb 2025 11:04:03 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Feb 2025 11:04:02 -0800
Date: Tue, 11 Feb 2025 11:04:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 06/13] iommufd: Implement sw_msi support natively
Message-ID: <Z6ufIbqkMqyMZFwY@Asurada-Nvidia>
References: <cover.1739005085.git.nicolinc@nvidia.com>
 <98233d5817e66bb7363090526b53422436894051.1739005085.git.nicolinc@nvidia.com>
 <20250211181620.GK3754072@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211181620.GK3754072@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bd8faa-91f9-4ca9-e3c9-08dd4acee8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3d4hlQtKWLYq1TN4WfEFhDbm12HPXzdD6yebTQ3W84BV5rm5EBppdgDd3uR2?=
 =?us-ascii?Q?lcjlXGc204qO8NVTcGm2RdqY3FaB6Px0uJ7xAkgr21pl1so09VYK58RixrTw?=
 =?us-ascii?Q?OKm+GAGnT5Zs5yVLBSwKSAnJPe6mTjJDJ1WVeAXPPn9pSR1r9HsBzo6Oat/c?=
 =?us-ascii?Q?KwmFf7BAl8I0dYeM5VKs6ABvncfuCWYLVUVoGaaOTIGreTcY3E2oYYxiCirG?=
 =?us-ascii?Q?8XlILSXhrkSjKggxBSruJJwA8zdv9qrd9omUb66JqCX2wy7eEuxWD3LCFRHF?=
 =?us-ascii?Q?fs4qhZoeR3RQzHohQRotXrl/ygViCy0+TYF7zffynLFL3grY0jnmtXmlcXYD?=
 =?us-ascii?Q?O/PNy0+5OvvgN7H4XJ0HFp4IsrCeewgCh6uX5QRIs5Lwux+QwoEk47bEnjw2?=
 =?us-ascii?Q?5sZAdqa7T7Krpzr/4lPo0ZftfaACAxZUNhrx70VHf31EmjBDmzQ0FoJH7dtv?=
 =?us-ascii?Q?rvI58lWTfYEH9EvrFM842K5f5RJYVPlvMOBCpVGK3yXeNCyipngYTOTc9Wlj?=
 =?us-ascii?Q?d33wdNynRBCAGhVcUdnyuZO+O7uE5QslUyGzuaMt+EK+44YBnmS+s2cm96lP?=
 =?us-ascii?Q?F7d80RZmqnsvjc47o5RfSy+vjOUlSSrCusSgpX1CISXncRwtGQcJsJRJV9nG?=
 =?us-ascii?Q?FwyymXJH0Xx7v5Mk3wekks0lx7wqEn8/+o4zM1lxUQRmswlN666JbIrZt70j?=
 =?us-ascii?Q?2HBx4hufEBsniPRH5WxDwgkXvj+tWYEH8FCIXMOVqhPnLBgqHxbBCsbZAmil?=
 =?us-ascii?Q?lDU/ySPhYD0nUkk6TiwHoHl5vmbOj0JNpBSYvgujcVW7WCum6CrR4Ylz0nVv?=
 =?us-ascii?Q?nca707VncJy04GJOWImAyjJxJGO1NRW2uxfWm67PCuzxva2L/Pr86/k3bZYA?=
 =?us-ascii?Q?15Y7/z+DIJV8b7J98UuVLz1dGzHzzyrHhpPEsLS3Htn5rDdMn6Cr3xPYaiZy?=
 =?us-ascii?Q?vU41IPvQyc93Bek4wsXrG03B7tYnhssKcayGBr7ieBjy0QJhrsSCqMWOnkg+?=
 =?us-ascii?Q?x4MVZrPeBNQK8JcyRoDipnJz+vY//LBQByhRbycOkor/vAxENdqk28z9QDPq?=
 =?us-ascii?Q?Lf07c2mEthkI0spUhMlFU9WYE+eGMilbtugHchdVip0fwP/25rPk83lydAoa?=
 =?us-ascii?Q?P7jqhtBtlq0EdyW10q/T91NY9WNJR8Qc8v6/r77Ed2KfG42xnZJ1PXBamXJU?=
 =?us-ascii?Q?XsmyjAzTQjt41jwwZjgT86mrUhI+E/hpQGH2F4BBgxbvyhcJqpPq0HNZzaam?=
 =?us-ascii?Q?Mcmo1W7n4RGTnugP1g2VGTx/lBOdkmRmBe8xybphaULiJRLHbstvbY/t9T19?=
 =?us-ascii?Q?qDXJwQNp+mj8Xqg0Mm3mRYW4hbn4Rh9Cc5HmNEuj6zVK0Ehn1LaAwdzIG01D?=
 =?us-ascii?Q?uFyBD7Q+0SMfSs7EZ/kj09yT/uhL3ASnIqMKKz879OqLJVVGQ2QLhz9IbYqI?=
 =?us-ascii?Q?dJgnuDLbEErgIgVQG/NsnpnKzKEaECOJifOvR+IzMDL9DS/qREpTI4tZi1vy?=
 =?us-ascii?Q?FlVfF1pUYfXSEs4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:04:28.5132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bd8faa-91f9-4ca9-e3c9-08dd4acee8ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

On Tue, Feb 11, 2025 at 02:16:20PM -0400, Jason Gunthorpe wrote:
> On Sat, Feb 08, 2025 at 01:02:39AM -0800, Nicolin Chen wrote:
> 
> > +static struct iommufd_attach_handle *
> > +iommu_group_get_iommufd_handle(struct iommu_group *group)
> > +{
> > +	struct iommu_attach_handle *handle;
> > +
> > +	handle = iommu_attach_handle_get(group, IOMMU_NO_PASID, 0);
> > +	if (IS_ERR(handle))
> > +		return NULL;
> > +	return to_iommufd_handle(handle);
> > +}
> > +
> > +/*
> > + * Called by the irq code if the platform translates the MSI address through the
> > + * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
> > + * allocate a fd global iova for the physical page that is the same on all
> > + * domains and devices.
> > + */
> > +#ifdef CONFIG_IRQ_MSI_IOMMU
> > +int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> > +		   phys_addr_t msi_addr)
> > +{
> > +	struct device *dev = msi_desc_to_dev(desc);
> > +	struct iommufd_hwpt_paging *hwpt_paging;
> > +	struct iommufd_attach_handle *handle;
> > +	struct iommufd_sw_msi_map *msi_map;
> > +	struct iommufd_ctx *ictx;
> > +	unsigned long iova;
> > +	int rc;
> > +
> > +	handle = iommu_group_get_iommufd_handle(dev->iommu_group);
> > +	if (!handle)
> > +		return 0;
> 
> I think you should open code this and leave the other function
> alone. The locking rules are different here.
> 
> iommufd_device_get_attach_handle() should be locked under the
> igroup->lock
> 
> While in this context we are locked under the iommu core group mutex.
> 
> A comment will help
> 
> /*
>  * It is safe to call iommu_attach_handle_get() here because the iommu
>  * core code invokes this under the group mutex which also prevents any
>  * change of the attach handle for the duration of this function.
>  */
>  iommu_group_mutex_assert(dev);

Ack. I reverted that part and added this piece.

Thanks
Nicolin

