Return-Path: <linux-kselftest+bounces-27088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E61ADA3E06C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 17:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1CF188C799
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A061FF1B5;
	Thu, 20 Feb 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PYFr4gY9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225A1DF265;
	Thu, 20 Feb 2025 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068396; cv=fail; b=Ctf6AIZ06nlF+sY2Sr0yRvru3mLNeDIDsPynqcghZzgpQWEWKvrzvyqajgyz74ZqkDeBPHZRvIQZSYNFIhcSZ4RCrLeBf8nsxDsJkyiUA5r++QmfExGdqCxFy5PXbdxHg//tAqky6AFf6oLuJuI5SSXtXP3XF7ccFYeqt/LIfDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068396; c=relaxed/simple;
	bh=tSzSFKKQXY3GflDBfpnBEc52yA3bC8Ironi4Yceft5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JTInCtvrH48d1N0EaxWy9UWP19wIEmgZEBdtfyCeeP3MtSgq1ue/rjQLpPxZDbkzp/5kFNc7Z7PLQ6XUkhvzW6zV0FNkeDnojGJAEiYW4BQNo0JfUz39j0Tq9otu3Gx6kV/O+EuTCpT8hyzJzIsC2T5LtsY422TCug9tO0g8Ugw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PYFr4gY9; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwTe3isWenwY/FLPbvcDdsoPqqNCbfiBTUq2Z829bByXoaz20ho+hHCumwgzurQ92DZLo+gsxOZc8udyDqjExdHrFZMZDQKbsrOdmUOl5tki8tREFoeU3B73mJFlMXWY7jP3yZJ9TXqnnohcrko5WaL7CDW+dm+h2XfNVrLyNfPNphIkocVt103bRENsT+DUiAt4U4ODOBgvWsCc8SDVCfXBFSSWrYDzWS4KXvx7fvvYAmL5Ygu0O57/DT/V1Nj56yVgq2lrGCCt/xxSxT18ZjtnYk1SYH3qTbU7y9d4/4i3Wc99whtYlvkuxE+EMoKe1jQfrt/zevlE1bdLG7Nu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I77ZRgB8avhZ/BD1zgwCsSVXVSH7s+4m0sJKEpbBRFA=;
 b=OcoSsfHBLOu/UjUyxTVi2J0yh+unExNiZYjpImETK0ihzyUnyjSup6uSMZTGRAht99GMpGPHcWi4UHizlUcZddZrLaEWHmMMmWUnAlbSvFsIk22yrmw9f1DhukmpX6go4Nty6B6aXGWsp59L+EWiGOJ1q+Mzy/HfjjDU1j6r/wR0BV8zQV/3EIcRBeZfQQEJt47P3v02MaOh41urfEApYYXIPgAqjc6Nb8MN9lPG9PyB1V1o1EKV7suty75wKNKteIQg78v+Lxqas3Pa3/SjaP2rcp9Snm6kms8aCUmjDwIVdONu/1Xacm7wWNTQvihBtkIu1GaDLg5s/ZO4yKDMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I77ZRgB8avhZ/BD1zgwCsSVXVSH7s+4m0sJKEpbBRFA=;
 b=PYFr4gY9ZLvbU+mCot9jJBToQiJ1UZ7WOnMDqnhuVbrkEugnHFfNxioY938KJRuoyA19X8vB2b0TXVBfkcdhGYCxkxCzXiSwrNuDgHGf/hJArkWm+kjt9yaY/wdwTvylCyKdmZdhlat4bIu8rum6/oEgII+JzIvyGHuj9yS+bCJvBRswz2kwjQXqalAun6FJaFHQpxBXvHN0FNQeJBDEm7Te/GATTTeCwHT7ynGWH0GR2bQr+CTLOXqSJRowPla768niZuag1s8A5x0fAZ4Rf9rQsFguBCCJBsyk5peFdP6oOG7WoTXwhjvQtudEaX4hLZZvuUTt7I3/ygozje9ylA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 16:19:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 16:19:50 +0000
Date: Thu, 20 Feb 2025 12:19:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 06/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Message-ID: <20250220161948.GD50639@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <313a27d92bd63e9571bf0f053eabfc3bfe4bfbae.1737754129.git.nicolinc@nvidia.com>
 <20250218153154.GC4099685@nvidia.com>
 <Z7a63pqKaIpCC7MW@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7a63pqKaIpCC7MW@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0711.namprd03.prod.outlook.com
 (2603:10b6:408:ef::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: e27095d3-3304-4a48-d327-08dd51ca6668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YjJYKWrqZZ8jgKYI+eTBbwhTZeEgEAvr3I/POztFai5eWJcx6ytOG4rQrinJ?=
 =?us-ascii?Q?RHi6pn97YAdBtuc2F8gVs0PNeY+utaA904txKq/jYHgFXJ3m8IjgejqSw5Mx?=
 =?us-ascii?Q?8Ieeb6wuBboCgYtmoLMAIak+znjIlHpY3oa7nhSw6BvQEA9ldFzAgm2tXqa5?=
 =?us-ascii?Q?gET+hmCBsavpkk6ighLX9djflAbNTXx+LzlNk+QQ8s+zRCSxLiP45DQA2in9?=
 =?us-ascii?Q?n8bOniGdBfQBYiwi8lPviFzm0Cnbbcp9QIvqDKzj9sMfkgnI2bkbnMIw4lfS?=
 =?us-ascii?Q?HPMt84TPlazP/AarCAzcFV4Wq+5PnCzgvROtQu1P2RQ3ZGTgKUTiQtdRGU0p?=
 =?us-ascii?Q?FAoiAmSJhjXDBwAcLM7cWk3SLVQJswoIsRCi93MPr0Vf6NAiM1+mBrWaCqYx?=
 =?us-ascii?Q?Ap7e/2Vzp1qXImO5gZq5896daESOJYy2PYvSLb4aWHLpjB9X+FLJDH307eAD?=
 =?us-ascii?Q?5BcJr4R7Yr2QlwqKYeZSu2Db7jFWJ3xJWhuSWW+jDjaWcPtKXnOKK+/0ZW1G?=
 =?us-ascii?Q?kYSE7e9fkPi1F/b5k8k0vMVY7Wk/0RdwlunCLejfRKypsiWtis2RnaXYqxI7?=
 =?us-ascii?Q?CibxPdvnrGvNB6s1Nfu7TWcLPacYwtJTwbcm9o0ONLe6giBMRFgWHnC9ZbZ6?=
 =?us-ascii?Q?blwPtaqw42qtCWuOJkXEbkOpCAnzi3Zkc/vzNBMan0ubvHAyC0OsdUaXWRR/?=
 =?us-ascii?Q?niNPDX0DI1vfuGwr0AQzzWhF4xW/7MzXzrYFi9OcqU4vxUwDkr7f9BqvMIHi?=
 =?us-ascii?Q?qGQWMnFQD6cbbMJj/PHGKsjpMMYBYKLL9UY43liMnQW6LczAq3dKOslm9evj?=
 =?us-ascii?Q?9ZJ7NCjU/1TlTgZrV7yEAh7WrPeYQmfjjxByPqwd4D4FliWEjhmJejGJs28a?=
 =?us-ascii?Q?3NIMb64tt2c5Kwgw9TyK/e/4Hy5tJ4GMiaM4HilObEPlcsMc9BIjGgMoFVji?=
 =?us-ascii?Q?RZEC7TCYNdqxPZjMI57qNExsT0JYs4nOT9aAkjrrVwNV2mjKtGp+b6z197yJ?=
 =?us-ascii?Q?GY470naNp/nTt9rT6MpZUZsOQ20DLozhhy83Et8X6DevYq5p6WvayIT27ucw?=
 =?us-ascii?Q?favzBZ+AMRFxwvdp8ASuFkmgiL8pJ+O57wCv2kk6PeWAmOdT82R1QpxZd2Ec?=
 =?us-ascii?Q?1We6vgWOzru+18ro4jimR3Cq5cIn25Bn3gDjYjL+qXDlKncEYFGjGvyAxM5e?=
 =?us-ascii?Q?EreMmF9fTetTnkBrjWN3teVnVlQRtZPgLzC/Go80hbSYh7xRSnAKdQ0N5sFC?=
 =?us-ascii?Q?qUmtXzo0J/t1QJ+IcjadLdW+Gd1x3fsP95CKIHLwi/BWandeNdMuPoNS2cOG?=
 =?us-ascii?Q?H19yGgPzDyBu2saLbCK0gps/Epq3oojGRt4558mbPh9GO1Kj95yD5AbJWuZ5?=
 =?us-ascii?Q?8DgocGfzVv5YVnGzFaHfFGTgbq7d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fyAFY5aYb2qSCgBl6AQjhhxh9xszE1OqLrE92+zrP6qVnr7v8i7GKQbTiKLN?=
 =?us-ascii?Q?PgmdsudZiYWuFq0y/SsGnWLcrdE0hh+5gZ+fG2HSiX0JMgb83qOAaBtxM/EL?=
 =?us-ascii?Q?weORG2nBUcG5dd19CP5oa0j6xtB41g3S9zEVCXHBp1v7xsR0a5lVR4OpRzEA?=
 =?us-ascii?Q?AXSGoIAiKLCuKlxqwip0o6UKZfjHM9IsZ7/UAtVlT6dRfo/U6MIKg+D1jpNJ?=
 =?us-ascii?Q?gmK8A8ue6Uay9fJM2NmilfqzIBl3ov1hU0ZKSe/AUMLjc/ssoyRr26UIaa1d?=
 =?us-ascii?Q?6EXqSBPt2yIH3+n1qc662PGzr91VseydP+umAFI2uQKUMYupMwU9A0bCHrrj?=
 =?us-ascii?Q?Q8I+PoQbv8+SfyoLqy5yicXOQRghLj5v5RbLaf/b3cvuHGyI8/YTu0S9cUOq?=
 =?us-ascii?Q?J/FnqSLHrpWXJF1WFlHMwW9libIkBO8/nBiGc/Gv/fkR3laSCjnJY66PP7Pn?=
 =?us-ascii?Q?1HabldntrBcDAtvPLBePaRBYvyzXHMvJwUuGLTVKul0Q1GASQihi0Vb4LH4u?=
 =?us-ascii?Q?sowFcjjVWg6GyQV6RpZ13cFj27/F+H/Jpe9dhT7dYi/DX3i46oRvQvzFLkA8?=
 =?us-ascii?Q?q7qyxN6Y2be04HOYPnh6HWqcPX2Xw+dFQWQGq5v+ksdpYpkcr27WK+6/cVoG?=
 =?us-ascii?Q?Z9oOE2lY59BTRj+eYJk2CL1Jw/wqBTjBvxnu2ctmlB4bnF8XQqH+UAiMfTAP?=
 =?us-ascii?Q?FmRRvJyHnHEWGOAcDwhsWbYJtURmOOL3czA+5042Ut/EmOqaXZz1yw4KGZkd?=
 =?us-ascii?Q?Tr9y7179Vght52XtOmaOcYwzYQKOQQJQUWiUE707NaENlffbMCoZXdcFCBOw?=
 =?us-ascii?Q?A4c6TdRQ5XVX/9A5YGDFGbcpx1B/KlxR4pTz3iXJjCKKP9ScmWYHVKDr259o?=
 =?us-ascii?Q?2ao6JMLyvKXMjdmEjjKKJsIbCkV8heevwCRXCld75mf3EqSTgqzzuwWAY1zR?=
 =?us-ascii?Q?UapXbHgzu3jOAX0K71iXCQmm58ZbnY0i+omN9K0o+XkbySdtNTBnvyb1O5yC?=
 =?us-ascii?Q?ewsJHHji2uUh0HaL3woqpJW2ZM47BUa78JaRyu3WwCb5KcHVcu95/LP4t4iV?=
 =?us-ascii?Q?WCd0f7Qer9/TjssdDXYPn7bjzd7lPEoNFtxO6HZLimH+wcz/vUvBNCsmhlAD?=
 =?us-ascii?Q?Brxh7R/72tO/nTF96pCLeRk3/R56sN+YFhzEA8jNKYFtTSqpOZ7H6mqHV8fA?=
 =?us-ascii?Q?nOdu42p17JP8mDd03DL4ZkGg20EjoNbHCMTGlLqjAIx6nzfKJrvqSKm/raDs?=
 =?us-ascii?Q?s3wrdfD4vNrs0eG6aYQ84T3A99QKq0Zo9BEc25ewl2OzanSHqAwiB2+htOup?=
 =?us-ascii?Q?WugocC1e9WomjlLY/EEjaBsqOE1aQV2xGMOLjT0B0K5ZNOXUbvgeq3KCPPui?=
 =?us-ascii?Q?bBTI/w9rls/suR1+zAr4tHF6wDFv0A9cy9DCTuvN6Enm5ICQrQPXR4UPl6bk?=
 =?us-ascii?Q?AtXaf1Fy7DISRjC0y44mruyAeup72WWwJZqFgarZiUutLSfe55lLMgyE5OKj?=
 =?us-ascii?Q?BMnDVYRWUa1FXXqfDKqdkLDTrz0jX2EHmFQNFA7M2EcwglOLR6BMSrMPfGx4?=
 =?us-ascii?Q?DrX9kmGfsYn9Uvm/HLh5gS9azSoNhFDeUpW2RkOg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27095d3-3304-4a48-d327-08dd51ca6668
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:19:50.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++LZacEZHMXNiHzgFGMX6NAk22APsVciYe+ELlfN1Quh8kRJ+tMW7yPDze5MZnFu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134

On Wed, Feb 19, 2025 at 09:17:18PM -0800, Nicolin Chen wrote:
> On Tue, Feb 18, 2025 at 11:31:54AM -0400, Jason Gunthorpe wrote:
> > On Fri, Jan 24, 2025 at 04:30:35PM -0800, Nicolin Chen wrote:
> > > This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
> > > to convert a struct device pointer (physical) to its virtual device ID for
> > > an event injection to the user space VM.
> > > 
> > > Again, this avoids exposing more core structures to the drivers, than the
> > > iommufd_viommu alone.
> > > 
> > > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  include/linux/iommufd.h        |  9 +++++++++
> > >  drivers/iommu/iommufd/driver.c | 24 ++++++++++++++++++++++++
> > >  2 files changed, 33 insertions(+)
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > > +	xa_lock(&viommu->vdevs);
> > > +	xa_for_each(&viommu->vdevs, index, vdev) {
> > > +		if (vdev->dev == dev) {
> > > +			*vdev_id = (unsigned long)vdev->id;
> > 
> > I don't think we need this cast
> 
> The left side is ulong for xarray index, while the right side is
> __aligned_u64 for uAPI. Could there be a gcc warning when somebody
> builds the kernel having a BITS_PER_LONG=32?

No. The kernel is full of these implicit casts

Jason

