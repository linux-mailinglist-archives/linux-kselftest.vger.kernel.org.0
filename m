Return-Path: <linux-kselftest+bounces-35051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C8CADA8DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 09:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6907B16E067
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E7B1F130A;
	Mon, 16 Jun 2025 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EG3iQg49"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCE1DFD8B;
	Mon, 16 Jun 2025 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750057486; cv=fail; b=mY32vXhMhj6KgJ56oyqaTIHkscbX+azkm547G7M0q9KtZU6flWKAfSpomrGkUi7txRD+CL5ZgmX2eHB68BLG+C/oOwPAOumReejKtnpiqVbJRQDIY7Ut4M16+CuvOtxl6PLBfICf4ZbOWhUhGu7jxQe0NzNskAl5D5H24uxFLB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750057486; c=relaxed/simple;
	bh=eY1vo4mCyiKtm/s8E55g3wOjlM7ciuGHyeP2dzmsj1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMjlg2diYnWQZcq+svl835DW4+jAvLsIEjcu+iH/xiSCIoeXr/sM+BB7oTudyxxSesFKTreo1c1aISH7BgKlAYWl09rtTgSqxEo1VBb0daKrNkGj3Bp6JkzLGdkLj+x7bNGBcd/IhBzstwTndzzW2mHsDpCn7uOdxe6TvV06geI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EG3iQg49; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrM7SzdOs7HldoTADzZcirO+lfETlTykSrsv13HvaRTluunwhEZ5w0Cru2mkcpnQLWhTrFP2cZXFJDCk7YC5JLj5ixDiU7I2338Rcd1D1+chRYfaq78zitZSnWW/k91O7VyQh37OWBSJ/dxtec4stUPvbPUhEQol0tj0brNowU0Y1vbW6t4wjogH06fQgIb7jXxzdP7oZSQNbxqTlfXKOcA+/bMa5lUphsn5tNgq/IqeIgIRb/iF9p+pmYUfZluNJEV9BJQNbFfNmbbVb034sEbWlKiV3zc7l/NJIqZoHd1kBvAizn3R37xOVdhOAUArINkOSuauUlw60IcYVVtSuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRidCw3ZxXKUOQ0x2x4jih+5EMyPE8YikgSMCV2Orok=;
 b=m0bVcxutmoY2YimoJ3DmFM6th4ZmwU+hMWUaYdkyEiUFfkH/McUQxuYpZPN2PaRr2XBOOUYHQm3Z0rUAgmKbNJNGXPJsaY0r8O6YmA1Pyu5dswTMRokWGOQjO7IHhJ8M5sXLwnXp3v4tsc2g5FaIGMccJiK7ae5Vr5t9i64Do99TwjaHEHoZ5ScUXG0BNZzltkaiT3TvsTEjHfa39jcJh+tQIr9AHeuWiX1fJqP9jvQIKYMz/fmFGkt6WPEGpGMYzWZ+46Xmyl8k1EOdv7Fk9eyE5zrTCaMmnm3SZtQApP4fvpv1ycScL/Csou2K+kUYDSsvHOGF1MD18bwE8OZ75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRidCw3ZxXKUOQ0x2x4jih+5EMyPE8YikgSMCV2Orok=;
 b=EG3iQg499+NMxbVtn3jYM1QJ8CL/NRl34k2GsGQgTIf1zgy0GwZqiduPRKYxs9OMENYeAcZuOkoUXC1gyHCkBuQkfVPl2WwcYX/QJLxUArR2koMN3SwDjbV4SmWk6FskbTQ2sUc7hFu11fcUyJCY+ZAjLmmCAp1jPihq9oUy/l1x2P+NjdYmWCSO7Tiu+HLGUrfAJGgpyS+pCSANEpJjTXmZwIqT4Cj5JKWke4b6AIiDxSZFBJizo4TWdQl1ZJjCpYDB6l8TsJzuEJtf8BGec4nKuyg2wNDdijFccAeEQJyHTsffChcLhiBLJi2yv23X4cV08FIhBH4IgWPEKkPn5g==
Received: from MN2PR13CA0027.namprd13.prod.outlook.com (2603:10b6:208:160::40)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 07:04:38 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::b8) by MN2PR13CA0027.outlook.office365.com
 (2603:10b6:208:160::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Mon,
 16 Jun 2025 07:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 07:04:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 00:04:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 00:04:11 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 00:04:05 -0700
Date: Mon, 16 Jun 2025 00:04:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <praan@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>, <dwmw2@infradead.org>
Subject: Re: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aE/B40NRb+GecpRi@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
 <1ab8030b-8d2f-4ebe-a280-6d0e4e1d17c7@linux.intel.com>
 <aE+976F9zPsjtfry@nvidia.com>
 <b9a7ae65-edc6-46e9-bea0-163a51459884@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b9a7ae65-edc6-46e9-bea0-163a51459884@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 594c09f5-bba3-4950-96d2-08ddaca40ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ww5G02/TLOvFPsYElWDyP0OJLE7fRG4snxivwP5DCjl8dc2vU+fLTJLu7sQz?=
 =?us-ascii?Q?NBE8PN0u4Lo8g1ZdFTGBZtNeZRBPvcgXklSquE1NSznscxpK26thAOuxxuBd?=
 =?us-ascii?Q?N0bxcavzkqVO0ZNdf2h+jokqeLftw+Sq8vX4yXhRb+CNVlN9sLuYf3ZNNCiT?=
 =?us-ascii?Q?WsqnDf6LhBwV97FpZ874/IatxZ0VwZzbKJ+Y6v7iJ9mPp3qTVhbyyYsWL0cU?=
 =?us-ascii?Q?g7+YFjCE40dDp6jDfIu/FGa3LnMvbW/FPuFpJZHcz836z4XxrE5233M4XOp6?=
 =?us-ascii?Q?sJSPFBUjXS3oXAhI79GN2iYBxjyILAFLiM9EmjuJ3QmWCqmvqAeiDVYWd4zs?=
 =?us-ascii?Q?FcmdPJ3SL2zFARQfwzd3ntzArRTdRQ2Ap2s2WKFDBP6NADEpB8j41joGGqrF?=
 =?us-ascii?Q?dMsiChlEOnVDqJQ/dWadXSyw5pnwiZSWAN0AgSKKtPPpxIFToZBgABiiDoxy?=
 =?us-ascii?Q?lri9dl9ZTm28YiXSlJXt8nRAkPAB89u80KxYm1njuHKTJswomNSRHIGPR1hW?=
 =?us-ascii?Q?PmW9jye/wyuL2cC5qaXrJOEfdQmrb13SSz7WZP8Sv3Xl12XnWnJmfVrSbeCl?=
 =?us-ascii?Q?9ghYSyMk1KZ3wReEL1id7jTlzRDah5biyuM6Q63THjD5B9OKkyNEqAV5VV4a?=
 =?us-ascii?Q?6cd4Xo92ip0vVsLLk/+fSMvQoE9hKn05+kFwsnD2xhcS59Gi2BIQF93a8FyN?=
 =?us-ascii?Q?YKq48z5LbJ37pYEiWQQEnIeoMo1F9VFZqEgpF8si6pQZRunMQ7b4gIV8Todn?=
 =?us-ascii?Q?HBl4y3zBdChkiHnSOWdrFDeiGvDu9+OFP9MGvKcryel0xzGEwwcrMnNhoE7b?=
 =?us-ascii?Q?C44/PyMUJQH2DRNTG5TMJqA9tggoV6LYibcz6yoL5G8DJRYL3LZxj4Uf79tj?=
 =?us-ascii?Q?3zEUVzZc+k+fPRyhCNazHIYE65q/XNcG0eV9UY6S8QmjqopIomywdYo3cIHc?=
 =?us-ascii?Q?Z5Z2BhACvgW8DKI3sMqOyF5OGLPGvvn5iHRAUA0aOI+B+rc5sMKLzp9+p+Pu?=
 =?us-ascii?Q?xS09tmZRWsxogtNYfUGYWaT5J2YMeN+4+maha9vYVOff+zkvdmz01JRK7EMh?=
 =?us-ascii?Q?+6zjdYVCxEkwYCQhBc5DW1exVhhiv3ksunGQCpA1tE+2BajuZ7R5Ds9wFjap?=
 =?us-ascii?Q?qCKC43LnRB12g2PS8KxIcTFqQqeHhHxBGJD/qfdOdvYPM386FMv6RDYRjC5x?=
 =?us-ascii?Q?EdYa4LO0MsO96A6QC2fKQGoSqe2VECM3XjXVq3Ad/7U1A/fHGAepZb7zFtw6?=
 =?us-ascii?Q?ktGl4XMzihXjtLt10Z/qPS4Lf001uf1i6bMKrSK5qEGjFitwmCfVh4+VbLdI?=
 =?us-ascii?Q?nqqWnc3fZsGU2nOiu1TjB27ySwTeyHvU5e5bWoVHIo8O59VgtjFKyvssHf69?=
 =?us-ascii?Q?Ph4qHTPfofAV0gDsrz2i3ArbM/7l+2EbrFVNEHkgWpjletuxkF4aBRwNdXjE?=
 =?us-ascii?Q?VPmBAKf2mGbhagK8I0i5b04/qjAr9zfFYUuDyQz6VtURJAfQULWA9n2vdJmk?=
 =?us-ascii?Q?XuK6ZPdikxqL2gUuZeqS6VfKVi8bFElVGsBF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:04:37.7054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594c09f5-bba3-4950-96d2-08ddaca40ec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749

On Mon, Jun 16, 2025 at 02:54:10PM +0800, Baolu Lu wrote:
> On 6/16/25 14:47, Nicolin Chen wrote:
> > On Mon, Jun 16, 2025 at 02:12:04PM +0800, Baolu Lu wrote:
> > > On 6/14/25 15:14, Nicolin Chen wrote:
> > > > +	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
> > > > +	    !viommu->ops->hw_queue_init_phys) {
> > > > +		rc = -EOPNOTSUPP;
> > > > +		goto out_put_viommu;
> > > > +	}
> > Hmm, here it does abort when !viommu->ops->hw_queue_init_phys ..
> > 
> > > > +	/*
> > > > +	 * FIXME once ops->hw_queue_init is introduced, this should check "if
> > > > +	 * ops->hw_queue_init_phys". And "access" should be initialized to NULL.
> > > > +	 */
> > > I just don't follow here. Up until now, only viommu->ops->
> > > hw_queue_init_phys has been added, which means the current code only
> > > supports hardware queues that access guest memory using physical
> > > addresses. The access object is not needed for the other type of
> > > hardware queue that uses guest IOVA.
> > > 
> > > So, why not just abort here if ops->hw_queue_init_phys is not supported
> > > by the IOMMU driver?
> > .. so, it already does.
> > 
> > > Leave other logics to the patches that introduce
> > > ops->hw_queue_init? I guess that would make this patch more readible.
> > The patch is doing in the way to support the hw_queue_init_phys
> > case only. It is just adding some extra FIXMEs as the guideline
> > for the future patch adding hw_queue_init op.
> > 
> > I personally don't feel these are confusing. Maybe you can help
> > point out what specific wording feels odd here? Maybe "FIXME"s
> > should be "TODO"s?
> 
> Oh, I probably misunderstood the logic here. For both hw_queue_init and
> hw_queue_init_phys, using an access object to pin the pages for hardware
> access is necessary, right? My understanding was that pinning pages is
> only required for hw_queue_init_phys.

No. The access is only used by the ops->hw_queue_init_phys case.

The ops->hw_queue_init case will use the cmd->nesting_parent_iova
directly without calling iommufd_hw_queue_alloc_phys().

This FIXME means that, when adding ops->hw_queue_init, add this:

-	struct iommufd_access *access;
+	struct iommufd_access *access = NULL;
...
-	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
+	if (ops->hw_queue_init_phys) {
+		access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);

Also, the other FIXME guideline states that these two ops should be
mutually exclusive. So, add this too:
+	if (WARN_ON_ONCE(ops->hw_queue_init &&
+			 ops->hw_queue_init_phys)) {
+		rc = -EOPNOTSUPP;

Thanks
Nicolin

