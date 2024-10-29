Return-Path: <linux-kselftest+bounces-20967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD9E9B4DE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5CD281B6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6054193074;
	Tue, 29 Oct 2024 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DvV6/TPr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0533192B90;
	Tue, 29 Oct 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215673; cv=fail; b=J7ahBJzCPTjDLdq346YrPACzkuDmhSTpLEBdGlbMnmI8z0KF4mNZXqfFKz2rvkrH2lU/zzC0Q68UHMQo2m0QKgGRqYppb4OE0g1/q9oegRH9sDfjD7CIvlvQuTA+PNT8SGMyP4+Gw0501BhJkUWUoIMDgX0UQhNsh0QIflHrGi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215673; c=relaxed/simple;
	bh=Pz0R+8UhI1mSRfTElfI0cF3Rbl7FpydvTDSD5e2d9d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=msOA/BTA3kFHLskBa8f31SU855cQ6eD/rML9Jf5wDiaDX1ZWkO2Roa3SWDO4dkTGLEXQai9ZbJ/lCCzttolZLFwDSJUZeuO6sXgQUV369xXTLwFUS4yMOog4o1X4jbpqcfzwgLazKA5dUgY4N2owcTdy35qpFweTyCT57h3Unds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DvV6/TPr; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoexqP2y8gkaMkWshk4yr8KKronpekyUpQUCJ5wYW6wTUT+n6KgsMZfQJJeobBvD2OpaBBUVnmu3Zk43uOSTdOc00NzdJWHxJGzgDZjLvlE8/oAL0wqPa+dU7GNkETQg9LIjlHkIAA1Ix3JuRHt/C30maBC9StVOiFZ5bhErSc2zGLlc9f0efSFb6OsLsH1G2AjTWOmTPRQFUd57nOazzCwkkv7HgulJGO6hlSinT535vmMKGkSs9NB0r8FF8KHnQeCn5ad+Bn0O0XX/tZxmdCeHDPhWgwn18s0vKWnr3jEdS9ryuxItwrtPNwZqbWFzpZb7yJ2lLXjW3LmAK/bsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKzcCvg8aEB6lId/BuVlc+xGnarJKePp42XmBbyWZVM=;
 b=O6fdTP0MoVmgUiFrHQB3DpEjkF1TJFPlcbbF2iW6XLSIf3wq5gou3PWwOMIdGOii7bMsV+TlL6aTpceT0z43CwKuKHyOcDVHOTUcL7bhk0jVfHDYg4Z1y1fDts4vlBJmHaLeowfXESBQEJpO+B4fiMveUiNLwpcBVDMdUqRVK9ceP/+PVh0/gnKzpbec6X5RKSnuMkHyHWZbZK6/bgeNwhDnD635Cup0rg7NojahNfLiv+xx4XAhCnxkF/cjgcSt8Rl1xB9k8dLKUv0ETePA3hbotizhqx2QXImreM86NnlA6SEABMZzHJ+4JK74vSsh1rcBUhdpjgZ+xIxFbyFHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKzcCvg8aEB6lId/BuVlc+xGnarJKePp42XmBbyWZVM=;
 b=DvV6/TPrh3DErefDcSRLhslW6nq5DDt0+a7EZMYJHlAUiTIJ/vDbGlEctLIbmjU/J/hqrXmLvlJhM7nmGpQojWqa8MMxQJHsetD5SELPteYJa2ghfCURy+pDAybkE8fdGC30o27BgVr/Peefr1cDVITlLnF5/XIjtx/B0bqCysaI0YyaEPUe8a4tv9R6FvpuUwg7chOSmr12QaMDC6JazsI3d8mIcQ2fdwJPI+zvK3smvudU3R96u/1EWquI852lAfFzPyu+W2YSJH4K4rVJ3LWlTqCvQyud5nEJybNXARRZQ+WjG2RiZ/5fBEPD1XJ+Oo5594Ox20zGrIRdtGRGyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 15:27:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:27:47 +0000
Date: Tue, 29 Oct 2024 12:27:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <20241029152746.GE209124@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
 <CABQgh9Gkt5tsw+wr_=WeA+m=Kz2xY5Z7aSBNhHCvBG2r=7O3TQ@mail.gmail.com>
 <20241028130309.GP6956@nvidia.com>
 <Zx+lGr9iD4DSkc8I@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx+lGr9iD4DSkc8I@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0698.namprd03.prod.outlook.com
 (2603:10b6:408:ef::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 90315a19-1226-4ef3-1014-08dcf82e3df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/Js9NaKLtDiWg3BHz4VgWdCP81Hg08pemE+4cUYKJGbT57wXec1MDb5+HrQ?=
 =?us-ascii?Q?iC4Ec82SesVOEuAkjGx2zgZI0YBGK9pDnHQMJccYN9gEwM/prvTLojBmpWNs?=
 =?us-ascii?Q?Te87VIp/7Zl2aM6O1MjbI0t2hdFCLaA0T2gy7SspUqe93DJ5dv8AwZ4doPm3?=
 =?us-ascii?Q?L/UtzQizYnVCcYoL7ZqNy8E2WNr0CtTOy+qhzpB++9Bf7OkHRK5kmK6RJiKJ?=
 =?us-ascii?Q?E9MIiIdJun2IXeXMW6yO14CXmw1LgNdoIM4D4c2WsdVr0bfYknlC6rAV/Xzz?=
 =?us-ascii?Q?EvreclrANc2KzwxuWVor2eDQUhXd8ZnZ5d3YW+NFoNowiPrv498S/y0RFCDz?=
 =?us-ascii?Q?x6L6oJ7matxb+B27tNNIW99gue7vA/i+pyIEliDrm2cXO2uI2MHv/l85ncce?=
 =?us-ascii?Q?XH513Jrz+5nXJuA6/XNcZGLZeEK9b+2Q/3QTSqrYXbDe0nztoQ18ojAqEI6i?=
 =?us-ascii?Q?PjrzKzsqpWlDJF6StnS5q/90nMyhS6aK359TIO0zhVmLB7U71XiltKLIg7Ae?=
 =?us-ascii?Q?M/RywOVjs/badTsCuHDY7K+lWkhh/xrRpIY4hGcDRNB6QqBMHy92CxMu7rhD?=
 =?us-ascii?Q?V2aNePSRJfwHOFXAv/YSONOjsFX9kOyeX8yj2FR15s4oLyXueyB1I7m7VzNg?=
 =?us-ascii?Q?yLGgpwXCfyctDC4nPY/cCB5kubrA9W1twjk6nBx1wBOjfXk0oHJVSfARp9PI?=
 =?us-ascii?Q?mJCxVo1JgDKjjH1fv0EaQkV0hTYT9xm9U6kFOrMPIqIJza6KpVNAlyYGr3lG?=
 =?us-ascii?Q?N8UPCye98yiuZsLVHLOWhv/zCe+n4J62pgDRYGtHzoQvWfqTu9zWOUY3FN+E?=
 =?us-ascii?Q?kkWsElpQUQh8sVVEOqRB9akDMrIYO/A/keEDbUiUAurfMlVZJu79Evas0UXX?=
 =?us-ascii?Q?Sk60wdrBEAuTPMWt+N9nRv+0Zu1SNT4mG63srOHVn1sMBVRzThkmA/I+2TZq?=
 =?us-ascii?Q?Vvhh5GZDVUrjs+h71WvUOxd1hsfdjh2UlNaTj0moaDDIb+YILnSUodpVWEcc?=
 =?us-ascii?Q?ITPurMBpIXvCUG15WdH3MuLxlaBGMRYmWQHEk0fHhomjoQ37b5YziePrbKic?=
 =?us-ascii?Q?5MI/974nh9H+4/ZspIDcSDGwseiihuYXyruQdBnA5ULb2xBtpTnOuDgF4Hoc?=
 =?us-ascii?Q?Z30ofXxhGlV8OXA/2ps04/E9dmsl6n+jRsvT3AFoTiiD01Hp4vH1pHfQ3Z8P?=
 =?us-ascii?Q?2DdZG1oj6hr4MwubJ0ItbQ1gENvijgItf2FvP2p+I8rbML2viSyRxU6kmeZ8?=
 =?us-ascii?Q?14fUQIMipz7RmoPM1n9AHmuPjYp/ox9ZH/jX8jS59GK1w4OvITNAe4tLUGCh?=
 =?us-ascii?Q?QL5fqKnNLHJ0JqQqNIZFmFfA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9q6aNMmarqoeDW6qn0xbPz8YPcZ/umlMWRZYwBunsLNvS4nk/PgHhLQOM7rh?=
 =?us-ascii?Q?PbIVOi/U8pJ8kaVgIdsecGqMYIiXl2gNC/HptUYbt65rQ8K3JHpP5WJnoDe8?=
 =?us-ascii?Q?zlyxMEhz+jdazLG0j4p9HxOqxGNSBLPopoJ+scg5hJ79WFRI3i166GDYhYp+?=
 =?us-ascii?Q?dylBsK0ZI+Swm84ZoX24uN+ai0JN3RLIVpI29xCipENsnAXnAeOfHTUTrdfi?=
 =?us-ascii?Q?09wqAeSWoL7pqq0K8x3pXf0vc7FlDot2jaMqqNoc1gT202GfIW34KO1EeWdU?=
 =?us-ascii?Q?WJFqSUsxnttXRXnxeTG01F0L7CjlZWwr4yRHAEZUL8e6xV2zS1h91BRPAqyV?=
 =?us-ascii?Q?9E7DK2pnjEUoBzKHxgJdgbgnc20bVk/mMcA3RsvlBqAd32d8dB4SvMV2Y36a?=
 =?us-ascii?Q?LJs3MgkFtg/NFMC++YcmCA8fV+P0UMPHfAeTlFqgVTJFdlOvxtDvNZqAEQVH?=
 =?us-ascii?Q?6yRuPmuaJZ1ApkDWIU72r+Sra79zSYIdFmkBHmgENQyu8k8B94Wlc5OhrM/Z?=
 =?us-ascii?Q?efevmD/InTzF4fufR/96qVfDBSkNooMwQbwnvy06rciRFL6OHnskCQ30zDBW?=
 =?us-ascii?Q?SVRUljVgFVzEoAqNx20YIwwbyBgaU42mywrE7YccM8x2PC4I4xcSq+fXSJq5?=
 =?us-ascii?Q?XHX4V45SowMVLodEU6eXK/q8wUH7QHlEKNDmgDxAswYnqbwfoLJ7RuvGmEMd?=
 =?us-ascii?Q?nv7J8TDtHT0hgHGAkEpr7HKSX8R6T70bPiWuYTaEIjKT8Rs3D5UGFF06ZTcH?=
 =?us-ascii?Q?2psICPiAUJTFjP6IF90NxzcpNX1YUMZxEDV1hdxWR4dN/CE89C3ZUvUUGjfE?=
 =?us-ascii?Q?/bVY6wz6zZkoLT3YG64m8oCTWZQWS6m53E+Q7PDCkZZUE/yZ1Hl+844K11Gv?=
 =?us-ascii?Q?dTYt6ANuLARU4Am0Er+Q0dQ9mxYdZ9H1MiJDryascKX7Hz3U1KDAncdULCnY?=
 =?us-ascii?Q?JLGOVFEhg6RAodjZD/8WpTBb8CRzdvh0rmYl4wXvoQGx6cqH8fJ+9YhGaphL?=
 =?us-ascii?Q?AqS57pLqk7mpDQgGvLNT8ZnSMNqZIKc/Ky6SyoXEIivXTlonNZVAICzqn0Fi?=
 =?us-ascii?Q?FXbloCflN5JBnfRrB1JSrQT/NFryqszZl6w+pJUO+0ixNBtWQI5mVS/DQUX2?=
 =?us-ascii?Q?j24NJU650/Skrdi4pW1vAdtzm/XjHDWi5HFPp3kN2+BL8Xvv/BJ5a2JJy3g9?=
 =?us-ascii?Q?GtXomwuRC0iAbth8mtrrgrMA/B5ickjlktq/Gvq/x+6xptib3gF05c05pkaV?=
 =?us-ascii?Q?OeB0AcwgMEi6FVXT1WcSxQNOrnPKnv+5SCgZP1zMf7vReMaKH9xzC7HUtqCF?=
 =?us-ascii?Q?EuHq9TrIYq2zYQOcjvZUFGqVkIHPHu4ZGdyreNqtrbElaQRRnaVO4mvjOwAD?=
 =?us-ascii?Q?dC/RLcJJGkDZRQK/1oCNXGHZFbKFlj+lUyB4qVRzHG03ZBy/er6M0zVM3DwI?=
 =?us-ascii?Q?5nusNvbl34Z0OgEWb4iTfnnFMlCCJIN4X44oef+gC6+CDlI/Lrk/XdrY3vyH?=
 =?us-ascii?Q?fqGxUZvrKNeaFX7rYaTHQ62u4dhvDZ0UuDQlzvyqwaHumI0nBvOUkIHJMnpO?=
 =?us-ascii?Q?bUwUpqBKZgq0L3mijuanQe89lW2WvfqF9VhIuAKt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90315a19-1226-4ef3-1014-08dcf82e3df6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:27:47.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWw746vWgEQh23CIJx+CW+KmQ3EE+MWqzFuC9GHzqMfMvutQv9EuwLpaJHSnhH3m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

On Mon, Oct 28, 2024 at 07:52:10AM -0700, Nicolin Chen wrote:
> On Mon, Oct 28, 2024 at 10:03:09AM -0300, Jason Gunthorpe wrote:
> > On Mon, Oct 28, 2024 at 11:24:10AM +0800, Zhangfei Gao wrote:
> > 
> > > > +/**
> > > > + * iommufd_viommu_alloc_hwpt_nested() - Get a hwpt_nested for a vIOMMU
> > > > + * @viommu: vIOMMU ojbect to associate the hwpt_nested/domain with
> > > > + * @user_data: user_data pointer. Must be valid
> > > > + *
> > > > + * Allocate a new IOMMU_DOMAIN_NESTED for a vIOMMU and return it as a NESTED
> > > > + * hw_pagetable.
> > > > + */
> > > > +static struct iommufd_hwpt_nested *
> > > > +iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
> > > > +                                const struct iommu_user_data *user_data)
> > > > +{
> > > > +       struct iommufd_hwpt_nested *hwpt_nested;
> > > > +       struct iommufd_hw_pagetable *hwpt;
> > > > +       int rc;
> > > > +
> > > > +       if (flags)
> > > > +               return ERR_PTR(-EOPNOTSUPP);
> > > 
> > > This check should be removed.
> > > 
> > > When a user page fault is required, IOMMU_HWPT_FAULT_ID_VALID is set.
> > > if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> > 
> > It can't just be removed..
> > 
> > I suspect that IOMMU_HWPT_FAULT_ID_VALID should not be set on the
> > nested domain but on the parent?
> 
> By giving another look,
> 
> In iommufd_hwpt_paging_alloc(), we reject IOMMU_HWPT_FAULT_ID_VALID:
> 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
> 				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> 	...
> 	if (flags & ~valid_flags)
> 		return ERR_PTR(-EOPNOTSUPP);
> 
> In iommufd_hwpt_nested_alloc(), we mask the flag away:
> 	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
> 	    !user_data->len || !ops->domain_alloc_user)
> 		return ERR_PTR(-EOPNOTSUPP);
> 	...
> 	hwpt->domain = ops->domain_alloc_user(idev->dev,
> 					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
> 					      parent->common.domain, user_data);
> 
> Then, in the common function it has a section of
> 	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> 	...
> 
> It seems that this IOMMU_HWPT_FAULT_ID_VALID is for nested domains?

OK, but ARM should be blocking it since it doesn't work there.

I think we made some error here, it should have been passed in flags
to the drivers and only intel should have accepted it.

This suggests we should send flags down the viommu alloc domain path too.

Jason

