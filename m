Return-Path: <linux-kselftest+bounces-20973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A3F9B4E45
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E7C282D17
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9194F194ACF;
	Tue, 29 Oct 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rJt1duLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA71922FA;
	Tue, 29 Oct 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216496; cv=fail; b=C6526g1f0n98DsUwA44Wl6Kiww+DoHRF8XJQZwSYJXgS93cEhE8RjhROzojmAtRap8ILRt/rawR5LFNXySMvG1Ra8Jk9SI0MAKxOt2UeaEp+Z/2NT+6qvaRVfjnah8Aso73uIDwZVuVWTbiOaHXJ7qXefFUeMhjBqT7eYcVXevE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216496; c=relaxed/simple;
	bh=SyZoaYnz9qxlbWB620tG8j+pnvUYGzVxClnG8+vhnv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ufzceSFFIpzyzycT5kXYGs6NelH08yrpkHj0SahNnDWVnxAuOE6rnfr1c8H2avALRstZkP8/cn0pWXMRUr2g7p/Wt27orDx/CMpRmg6VMSIXiwCcaQgvii3r2/dftPtO8zgz/ePdJvulFPaHnUNL1XhTAtOrTNmc9JOlio/vy2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rJt1duLm; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFepFOICoRCdEwqYwrt9a4xACAf2IUgEdzYu+fbswNq6ldbWBTnr0Bh00ILRa1fXSpHP6H+NVtw+SnkMgpYsQNr5ElRLGslUvHTGRKsnK8xTR4Ikuu0tw3LpTHG9GJ0DSXLh+hCzEI6jzlIjPpRZiEREeX9O9+wEvV80OoOC8e+xYsmH7tHEk9J56avSGC67GN5ZfkWLnW+EqdAYxeu7/4GrxI3a+gkSajV4zGXf6QkVeXrIso+utXiW9H4wkXwQNYlNOu9ZFqSkvXwcpMPltYyJacP+J5LmkMYbkRU2yA/h6GlZI5YC/D7pqs3NZsj/ei81APOYgzH1hgBBJ+6SJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBWtl/Os3ZLSb9wPLGrvLs6Qj4XSVj55IRBiLAkNoPg=;
 b=asSwUfhnYQ+ApMxa5K5tBJVX+jvojsfN4ELVdjuUkiqqIMQuCwXbUbDWXC1JbBlvVdM/P8ZfutzG0NZVqKZd7AFruvpyBKrwmRXnqJ/jTdfm5EW5AVVtzScU1BY3MyrXBzvCMvXj3QdYcAnYqwsgzpCiCMMc7VTd6Z775I1oJ/ceYqdhVPTLX4haYQ8nk/1JuZBeshW1h96rgjN3/pal3aUjfxAXgAfHT19tMUpr5M1bww1l414M9aAmVU7UoPOOm7gMuBpRSJDqpQxDoCOfI5Yf10CbqIAbaJjI/OC/w1A31urboJocOmmorbEEJb8FIek8c/r6C2d3STtIKLZ6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBWtl/Os3ZLSb9wPLGrvLs6Qj4XSVj55IRBiLAkNoPg=;
 b=rJt1duLmgtiM0QHP1Mu5H4J+w7VNK61qGe86+0ktDd32lbOG9+ESgzd52zaNt5eSWxlRijk96z06DHpAIu+fIr2/XVxm26AWWIg5UlVQCEULYHjvp55UfEkubURWNsuR0Be8Z9rznsRd05emvfOkEgXzq91TtVVvGoyDEbYzOWZo/q6ufa5N0mv0QtCCkycDYW/yt1I5eCbj5TYzI+IjHzXcJP7WykcXjRxbxg7xlNB+miyH2ORTPVGLFYb1S4Dn7Wz7+Htdx4+OBRlxDIcKBWV5fQCp/BZuUyFSd2od5oP+/XtXEZWuWdcL7+0kJRh5HbM8ef3aBY+4Xi/AHSG2Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 15:41:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:41:30 +0000
Date: Tue, 29 Oct 2024 12:41:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 10/13] iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
Message-ID: <20241029154129.GI209124@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <30f593e688e881b8cfee007e2ed2eb7a190a01d5.1729897352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f593e688e881b8cfee007e2ed2eb7a190a01d5.1729897352.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:208:52d::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c0dba3-b0f8-46be-c74a-08dcf8302891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jCWSYeKBdt7pQbN+Rq2Kam3IsV/mLzho+98oCHQmWe8Ai56kQhMbgPRCnkN0?=
 =?us-ascii?Q?rYirNmlYfvUz25qX4pVaMJprEZqdYIYn1g4WhVhvuJewKYhwlQSJfb1QE2Ch?=
 =?us-ascii?Q?OMRXj3dynvT6Ux/GRkYE5Qr3c+WZjH+SBInmiiUZvNJkYukAiTn8n+MDOkWB?=
 =?us-ascii?Q?NcfRuOYMs+gckdx65WySbN43GzH/abRUZenOnkyBxcpZLTJ/ozlAqeQnYyLX?=
 =?us-ascii?Q?vQhrELtg1IQDWpcWZ//+6PbRk8nibglU2Qbcaoozo1tIuXNdCihMibLOovin?=
 =?us-ascii?Q?2TKhX4N+chpr0UtkjK94fDg5bUmmKRiIlQZWeyZNQWxJQmsbhTTm2P5JiRZv?=
 =?us-ascii?Q?+MxZaY8Dt5g23jCLmV8oCF4drZFg4NgU5xmWMfIrOe1EMvl6ERwQ0R1uZerG?=
 =?us-ascii?Q?l7YBnzq9kYOs9u1nImKlTPVyp0gxzhSSVqWjCw0goNpIlxKg+g7b6Sirn989?=
 =?us-ascii?Q?jSVLs7EVDGdGSD3/7/ugbH/0rysQ2TXw82EBCv8DxiQSuoGCSNkd0PARAkgd?=
 =?us-ascii?Q?gQH0SG+/IPasMB5loAi2MvYCN61J15lnpD2SqEepl0LeG1l1wTkViNV5PKXi?=
 =?us-ascii?Q?kjMqpVBO7VGsc9e514erVO8kfJfSXBlroOuxKZ2d59EWr8ZCkeFtZZjhuMpE?=
 =?us-ascii?Q?uyOOnTB1hyI7Xwvprwr+Yq5ZSnFA6ch8SKIDtfjdTgHZDt2XnPxbKf7iYOsa?=
 =?us-ascii?Q?PZgWObdQbt5FOLPltg1fJrM12lhki6ib5QK5/3UT6ZF40pVbLvqQQfuXxEnX?=
 =?us-ascii?Q?fsYl6CMlTg4kFlf2gL5mNlo6UDsrTcXRs27GSSi8hZEbxaG6EC75SBU4SAYZ?=
 =?us-ascii?Q?W0RGuVXqjjMnzXwE6ddIXVXRXod9Q1qYSO5mfmx/I345cW7KI7AJ5pWQPhgb?=
 =?us-ascii?Q?j3W7S7R2snQVy+GNwhwa9jOeYtC5BzCnRQjMWTgXVNoUCN9c5UkTWVYUpksw?=
 =?us-ascii?Q?oLYUqOWrqx3owgeF6jNWmnQHMXlBDR99dKD/Q3EYPocVPK17tbE0Pt9tAs0n?=
 =?us-ascii?Q?TKI1A1s4h2o0QRt6ysoCThsEBBDGXKQYdxx+ovpxPRnpLxz/Pw+yzkI0JqEx?=
 =?us-ascii?Q?cp61ygnh2jPZOQTf+2WIe/ybmV207YWV8rhX+Yn7iDVCIrCBkLxdBeYwBbO/?=
 =?us-ascii?Q?pUhCBl9ZMk/7JkidrNddIj6kKfBMHfQTjuARI/tcqPNss1+XErtdoZqZCLD8?=
 =?us-ascii?Q?y1yH2n4lj6+0YLFLvTJm5KObz03d0S6DQ5t8x+YkfQpwNtwywm5MzhGtGTM0?=
 =?us-ascii?Q?k2C5qngRwSHlGpGhsDl4Bx2WwyYyIPT7CG8IteXCapdSKu54YEXAa1KAXFpQ?=
 =?us-ascii?Q?ydiBd6ouGjbclfsJmpGWEZtF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?htF4zGndzzvkTEgp6cUqqK4SP5AnIEjv6v6KAutvdn9gapysvzl9/183XB6x?=
 =?us-ascii?Q?BTObZHEWNrn09/TT7gtiqeSKU8fexLVfri7mJNSwWvTFIfYQqJQYLiwZioQo?=
 =?us-ascii?Q?xwM8s7Z7dmWgSq3wO6feB8B9MX76VFn0AyHNY8S1OZMaBE2zBk+0fw7Zgnmq?=
 =?us-ascii?Q?Ao/u8fDOjMyVFLysBT7A2bihtMGmZ4zJjRNB4XeJU5+rNgxymrPK8m0L0ACQ?=
 =?us-ascii?Q?B6VlWw2K3n0xN+4dzL7Ncki1Z6E28ZQhEGJDZri3yF65kQ89kGNgnAEND76s?=
 =?us-ascii?Q?ts//qxZpEkWz9+WS22EJVyYaCb4MK//PX+n5V5Z0qYQSQ/sAKRJGrvw6pkKa?=
 =?us-ascii?Q?K8c+87jCHZuCzogGnuoNJRA7iOZYgvqtmHxEq+D1Ppy73/uXy0oiv9xEnd2p?=
 =?us-ascii?Q?Jx8vvMszNMjfKM405fEu9jbmo4LJcLkXgU7OF4N0KsvyEmgoBmYrvezSq3ZN?=
 =?us-ascii?Q?bXRhg2+IuIj+W0baeJ/oUcNojVxa6+km2FzM4MNIGjOyf41EXm6+fAXel3G/?=
 =?us-ascii?Q?nzElBKI2XxN4/3B24ETh1iSeymHPvrkDl6crDYCukMCYeIjxDto+EM7Ymlyw?=
 =?us-ascii?Q?8eZZbjXw4c+DFHMOlfG+H69sb8xqysvBAD1vCrC0H1l2cRYblyfU8bWN6T8c?=
 =?us-ascii?Q?1kJH/4PGaK5X2q7pVuvG+vs+41YM/lR5CwaqIT4IHDw7qKUKCsIXmI1d7+rD?=
 =?us-ascii?Q?i0S1MI27MnciQBBUTopGQZMeywxXw/DHdEGq6Gj59E4fEPonY1bg4QxY1DYo?=
 =?us-ascii?Q?jLNQbFJTVHKxrkyGy28szk64QXp4J2ZPjwFyTJJ8POXWnK/fgL37TYvYvvd0?=
 =?us-ascii?Q?eq5AV7q00OsQAp7w/YAE999jxzbKYMZ3rvqQyESE4T6+U3+y45lRd8NUZJEI?=
 =?us-ascii?Q?X4hXzOndq72h6hH7t7G70a8AwkD4LR/tYa1pSxrFhpJ64R2btwRZOhjvT+DJ?=
 =?us-ascii?Q?sI968P018BOEGccBzympgJPpIfY+d4r5Cmrv8M3p2A71x8GXecE7DUCNwDu+?=
 =?us-ascii?Q?z7Df+fcgyNd84gBkbjCR32QChrpIzoKcyvOz3NfBtJoyqB94DO22G7CfOL9x?=
 =?us-ascii?Q?zqsOEZl3C1FgVaP9RRanqFpoWnFm2S++bOTywPEneMxMmCcEOonFMmwSeSf/?=
 =?us-ascii?Q?D9XfvK+M398LJnEWYDdUV8KFH/c0eOg+Ay4QADhLUFQpbQyC0iE9WVa0cdPA?=
 =?us-ascii?Q?CdkvsISqJY3R3AEG+J7mmS3ZvIC7OMJO08Vd9BnSH/sky/UjzVKTyBr6fxqh?=
 =?us-ascii?Q?F7Zm6GYVro+kIsnvCok0cAuTQknFXF8SA/m+eczUh3k8rUEtJMBlXH6K73qC?=
 =?us-ascii?Q?6o1NIwscfxMX80cruU1i9OuQDJK2QW48pW0D8aW1omng9BljlcBBhNAVWRpf?=
 =?us-ascii?Q?cn2DB7LgrlKbxvw5oPiLPDjrk2J6M2uxx0vgQx/r6HJuqXXvsiEQ05q28cb0?=
 =?us-ascii?Q?XGaa3n3LoSwkkkokVdkvzIHrGTPhncpxLK3M6HlmywzwI0gBfYXqZcR652PO?=
 =?us-ascii?Q?XIJMkvzhEGe6ByMownnlfbiKcFJXTiKnbGzZV84dGbYaU/4t+lYWuoY8PRm2?=
 =?us-ascii?Q?qbakQ/OVv+iJVbDkl1o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c0dba3-b0f8-46be-c74a-08dcf8302891
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:41:30.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5QCMLl+rXO/wc5rCvrvHKMzYJWd6XDegSV6MIk5gAb7OhbWBuDAk20s8zqpp6Bw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457

On Fri, Oct 25, 2024 at 04:49:50PM -0700, Nicolin Chen wrote:
> Implement the viommu alloc/free functions to increase/reduce refcount of
> its dependent mock iommu device. User space can verify this loop via the
> IOMMU_VIOMMU_TYPE_SELFTEST.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_test.h |  2 +
>  drivers/iommu/iommufd/selftest.c     | 64 ++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

