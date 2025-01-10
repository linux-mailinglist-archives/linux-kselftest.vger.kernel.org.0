Return-Path: <linux-kselftest+bounces-24225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200D3A0986A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 18:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999E43AADDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905782139D4;
	Fri, 10 Jan 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MpNiGTVM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA22080E7;
	Fri, 10 Jan 2025 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529918; cv=fail; b=Kc4KYgUBzIBbv69nHQdl4Ljm2bE1f3mkn8lLBNsSA4wTiGeROmsjkNud1GlOZpq3t77wm9PtWFKVqYGcBNu//H10xClWoOR1XDZx+CfLKgVdGA3/7d2elPDR5MC+xnSNIuzeeaQgyC6bYDvTcwtTLleBOMXepQuWfnlR/RasmIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529918; c=relaxed/simple;
	bh=3PfggbdGSNmNgB3vzV48iBnprKJODZGwHz1wmrQNDSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PnUKLNsSUAi0+BkBYzbqNaUQnbYLVbS+Yg7LoG4nepCdIL24qTzga+I0ROuNnxM9x5w7O/IvSvEyaYH0RRY9oCvzur+wfT2TJUASEhQddTkdbgnNCUGGzFyUAgXI4Js4JqQtQft8MN+97txcNcI5rSSSemmO4GBd15Ti3+gwiAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MpNiGTVM; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipr0Yj54eup9piqPX7JPXeGbIOZpe/3OzmVgWcn9mNTF/1NkFTUUgCcPHLhXuYWQu1dNzeWaekNU3ohTWfTJr9/bNdj3xoHuxOW6p2xi079H6VIXb8Mu9Ivt1PY4ma3D6Mm/mxB4cwOhFKJ1rZpKFWZUDfjaBy4TFYhXLAPJNU/4f6nq550BbIG6I/bS0V7NdqVMU6GPSiz0NmqQ9MEuXs9PkVUq5xS+5XzHPS7YV6/7TLMbvRrwY/Q54zV3QzrU9NE5G/2f7GHpPxVtLVZQ+TYuaFihQwEqGzEncYIHe4jfzCiYMaRQWDItP5VPLueBu7pye1iVrK7pw7LGxMNUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8lAwwXfFrP80o94yrhWjlvxi+Ho7poqO3T0fFZUW+I=;
 b=gdytibYWV/tr28FytL0v3YVszGnMY6QOoqI/jNdPqO1+ndr2EAXDrWFOTWUw0q44Hf2Avw5NQaVvO3tw+n6xWzpNgXDH0ou7+p6VYkfCAvezIo34PUvyLq+Oef4u5fWG+92TuOmui2NNXDhY0YZ/T2Es+PZexfs19PHLL0GU/meIFCOZhP+SucPAHySzBLQKVCzWg9it++mRR1n3djpxoIx2Vb0psiJivUU/Bc5+WEk3pnFhSFiyu1/PzaHgk+CaF9JYLpLnhnVMyohtwwMvE+V5Ii9a3ovq3+fsrX4x7HdNMDkKmEJxEiczR2FUDrS2C8eiUGdtX6N+NBdZVRGyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8lAwwXfFrP80o94yrhWjlvxi+Ho7poqO3T0fFZUW+I=;
 b=MpNiGTVMHKfwTOUCA7q78QU311AIkGrvnnS7sfGk+u+OBrpF1CANHEvIgNs89gtORTNU61cbqzx8w6hsn83Z7pAanWzj/WTAfaHae5b9mMn0R1i+ZxFYpCZInvgBjy6fj4t5D+keiKGtvk8CiWCdLxIkzEcYEh+rjTWBftdxUYA2whAxNslhy48ZY7pvQjIfbLDp3qrhS9prjbX9n9yRFtgTtTiqaGpZXZsu2dGrdX/AjQ5Yn1JkUNd69GPX+IHm8Zs/XCwzru58BA8scXuDxzQeoT/Q36ounUVsLV9CURVHS/SJU0P1H8oPP9vYzrZZTiAPPxq/zqrhv3XOVqhZXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Fri, 10 Jan
 2025 17:25:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 17:25:14 +0000
Date: Fri, 10 Jan 2025 13:25:12 -0400
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
Subject: Re: [PATCH v5 02/14] iommufd/fault: Add an iommufd_fault_init()
 helper
Message-ID: <20250110172512.GD396083@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <bf5e260006d5f14011e6dd27ecb3ea0a8f062901.1736237481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf5e260006d5f14011e6dd27ecb3ea0a8f062901.1736237481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:530::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 206ad627-e39c-4fdb-03aa-08dd319bbe60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LsftTEmjWKGbUvrpQnG2gkalutVnqqlO4qjoR+/7ONndTHtTIkVuDAAS7xid?=
 =?us-ascii?Q?RjvmAko+F9EV7ulqFdMQTxMu5xTWDdueyn8au+lBZ3MpubUTpGvAPorPbUcP?=
 =?us-ascii?Q?rBFq+NJB8Oe8HwtOvTFj0I33wp75w7gIDD5n+b4Kq57VJz91Cug2itHUH9/G?=
 =?us-ascii?Q?eMWA2aax8/xsVGhUlB9dXH3SAfn0dWaUKq+2vMAD/jxCKfYb8mu+6aZoG68W?=
 =?us-ascii?Q?ERaoxbjvPfexkWJ66nPrIj6OTxgfeNfy/+BAIMaZY24/jg+pQ+8NASznzwxb?=
 =?us-ascii?Q?R9zUHWULplY0uPyYbPFgddd4vnlRro2rdybgRb+1GGRzhSd2oV/tPIocXvEv?=
 =?us-ascii?Q?Xd0TlrI2ZxRe4qg3z4mOsYjr5pLR21oa0sXbphUvNcA06EsN/RJvJRAU5S3R?=
 =?us-ascii?Q?n9H0QZkn8A35jnYtO3yg5GA8QpGNq2LQuLo8xvlFxyC95ZFmTjvGMJQHRP9p?=
 =?us-ascii?Q?9CYK4I5ILabJAd8eKLZDQNRglp02sSMmvvrQoPd9VjZh7HY9Hy5iW+w15XgN?=
 =?us-ascii?Q?89Q2f/QyER0WatfkUvxqxde/YjHPOSMoSOk2udIlGM1XnyQsJYfZQJOHOpdU?=
 =?us-ascii?Q?uHTS4MLzVowAKU8EEYaPqB1EdAVcB6HrjCMskzWGltWquH3BQazQwqvDHC/j?=
 =?us-ascii?Q?NgaD8G0ndzOgly7hPPqAco09Eb+thHJFRMx0j1Q+7Jkr9CT2Wyv2uLCITR/n?=
 =?us-ascii?Q?TuV/Gbxo7duBvvlG90neKGUfDqndPma7ZSCC2qsdZWuSB8o8EgvIOVkW0ns+?=
 =?us-ascii?Q?+6E9Maf6DsPxglHejP4uprzvDj9iAEvhYfO9CM+pZULFoX8c1raSbds73HAR?=
 =?us-ascii?Q?kZkbfO5cTGKBHqxHgXXQMW+j06L0h4RRtQNKHtDV6L3yla1SmY+J9iB+6Epa?=
 =?us-ascii?Q?5fKOQWTbag1JFUm3+yPff/DJ5Wj70ktflU2GIrVPhSg78IkroFDnMSOB0C7x?=
 =?us-ascii?Q?xIDRCqKzSUXhUGx7jLNzh8/fGGlRjP1AUunKt0JM6Jdr3EC9i1e8aE97yfyM?=
 =?us-ascii?Q?GQ9OiPK6ECaWo+pdgws/Dx8uhO+Dq7EUl/OnQsBkKhhAMyOZWBQQXPNMmzCQ?=
 =?us-ascii?Q?owIIL4W76lrAh8GWzcS+XMyUGt0zkHdrXX1i6OWbgMvLAaQ7y6X2MA1A01ra?=
 =?us-ascii?Q?sXAcygfQ5Uec44AQrRTT7u3SASRcGvBDEaw6dNoBQruskkGsjiVofh0uCKhl?=
 =?us-ascii?Q?mwjImxmUv+Zy64tzeh/Jm13TVIeEVij2Ug2iG0Sz9R/qM4QM8BOyHLwuG/S3?=
 =?us-ascii?Q?bjHSwDe3dBldtaAuUKnmOXncVnncPOohNe5VGoaW8vv/h307AlDuQoBAb1jI?=
 =?us-ascii?Q?eeJ95+HAsQ5erSBuzDg/yuwkUNCTWlwHewuYAstNmIO9O6E2OeDyyx+grtIP?=
 =?us-ascii?Q?KVWVPrC5aL1bb+Fo4jM+CtI+yLwU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zj2hIwLhphL2ghbgR9uN2hryhbtwKFIGjA1F6VB8tq2PAYGPFeNJBYaYIvYm?=
 =?us-ascii?Q?fEoArxvENjFRqMXyzJzciew7fub7fxYZHmG+W/7hiMwWjTXe5HUmnM0Mqc0D?=
 =?us-ascii?Q?CCMSgLBgkmFPx4sJO906L3j6JunDKvm7CzKohnMzbf1QxAAB79FYkILBMWaB?=
 =?us-ascii?Q?e5+mfXW/SH39WhMCkd+T012pLWq1z5G99GRHT7f7EVC0CArNKp7hcaZaaDdm?=
 =?us-ascii?Q?jYWelttgHnAy5+eI+Soj8m1y6icvX/l6sMc9WtcSfpBLifFI8Y3iRorhoGTr?=
 =?us-ascii?Q?NGpRVEaW8l3WI7R6WNqdBaUHJ/nRpbb/iCPzUt2gUV2KtspkGCcTfl1mT+Gz?=
 =?us-ascii?Q?hKH5tS2Z47YCG0HYEtLAc6aAGcNliGt3WURROGs7xf8bDvh72A69mp9HnxId?=
 =?us-ascii?Q?liXZOmRKtXkBvYSuYzsyJ3VTboKUzgXPCR5jTIGtG630Hn4T0A+AGKGvxiOM?=
 =?us-ascii?Q?O9ydeuc2zw4D6Ypdm2Y8ub5aOKh6QLdPtZrfXhVmh4HxwkoLqFNtm0MnU2ek?=
 =?us-ascii?Q?DzU8w93pv+a4g9U794YxgtIY8FTajDKV7tCckPzsRKUBZFWaOqK+2pD3MebM?=
 =?us-ascii?Q?32HV93WPxF8KAtrVKEDKgU6rB0FMyRrfgwmcvxSatmDEBWkAu0aVNplfznzT?=
 =?us-ascii?Q?t4C2lsn9UajMnuwmETDVfayxKDMFCFkHrpT6dYS2GDYKOYL5qv5C/TKhbDxX?=
 =?us-ascii?Q?vJXTg7JE3jDVJ+D6WVptBXol00iWI6Eok9Foc++ZM404Cy66fxzaw9yR+rpk?=
 =?us-ascii?Q?pzNPMWxYLmDKFA89Ou3g+MPurHJx/TH8zWSbKSCHOl4WOc3Q8sRAwAvxjpZs?=
 =?us-ascii?Q?nKEAKGvJ3jskaZ8gOvP6aQ5ewuibWy0AmRHwyhFTPEQZPkJk0zlLmesvGg8Q?=
 =?us-ascii?Q?KNrCqQYh3gzLcCKan2i/lknFU/6k13i3Aeif4z87SkRYFWKNC+kJ4TqvQF8v?=
 =?us-ascii?Q?ZKr41T5ztAQA93lryNYwXaW2Db/UqbU1u7NDevV+fOe6PTnvy70udRIO6w1n?=
 =?us-ascii?Q?415fX6pruG6GmvxYP2HtIzTAO+kHsQpe5D1kQMQLn2LpaeWxNAdNsvFqi4v5?=
 =?us-ascii?Q?2IN2DyPS8bDkUCwV3THSUmNHE5LoLa6ElO/P8AFDYw8d8oineHJKs1fLvjEl?=
 =?us-ascii?Q?/Z9rlSQu7F98h9RIffVqcnSJs550pi6t1Np5dqnoy5f4dF3KTCJMpvZhvxK8?=
 =?us-ascii?Q?bOPsLkngFG3VooqhUkkDug+vG++O0ha8x25OxH+Cxalrz07ghAnzzO5BJ22s?=
 =?us-ascii?Q?SVNiim0y2B0NzvilXAOUMewDwWzZ1zIChtili/kU5/C0Bk1LSMluHNF4Y+vN?=
 =?us-ascii?Q?bXu+2KSd2qpLaL/qnGt9HEZAFE1o6ZQ/Ne2pKjZzrxg1kwViEc8x0MhnoJlh?=
 =?us-ascii?Q?q8IvCqHM8CtR5S2L3KLy9S/FmC+7pe8pVrYxGRQuai+nUf24JOrNT+Ng9twL?=
 =?us-ascii?Q?YltX0n4mwhCp94+78qxGRrBMFb0+BvjSN+rPEMhYbh5TN0VsWAHrR+8I57ol?=
 =?us-ascii?Q?NtaalUYSf3GHMrDZJzBr3tJASlIDfWF3oxtYrPV7ihFpDi2JSUQMWe0WHEgO?=
 =?us-ascii?Q?1AHxSmYFRLLCV5QdUTmp1wJqDNE2yFcaK1o3zS8U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206ad627-e39c-4fdb-03aa-08dd319bbe60
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:25:14.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVB3sYsln5Ybee9YCindt0jV2thw6AVGXjyGnTDHwdQrLe93XlJnMXHY3DfzcPvL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879

On Tue, Jan 07, 2025 at 09:10:05AM -0800, Nicolin Chen wrote:
> The infrastructure of a fault object will be shared with a new vEVENTQ
> object in a following change. Add a helper for a vEVENTQ allocator to
> call it too.
> 
> Reorder the iommufd_ctx_get and refcount_inc, to keep them symmetrical
> with the iommufd_fault_fops_release().
> 
> Since the new vEVENTQ doesn't need "response", leave the xa_init_flags
> in its original location.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/fault.c | 48 ++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

