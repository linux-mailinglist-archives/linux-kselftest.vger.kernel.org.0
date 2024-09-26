Return-Path: <linux-kselftest+bounces-18425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7524B9879E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 21:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710E4B22824
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BBD183CCD;
	Thu, 26 Sep 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GHUELVkn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C5183CA1;
	Thu, 26 Sep 2024 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380721; cv=fail; b=ArMuUwSq8iZAXQWrjRBmPh+ugx9xTtxzcT1cuwpVBZ/lYoDVR7YLk9vGDKHzeNr/FvDpB2SXs+8ShgTjjUh2ALj+6HrapmPmPoL2umiXrDASeWJF68BqpAYj+VNIL6fhSpetut+dXqY/FhH96P3kuuB2E2GhjmwUU5WLR9meMmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380721; c=relaxed/simple;
	bh=ThVoZ9zbB++XJSNgAMWiIc11plf/2mK5imObYG/qUok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XRzxLGRrB7A2/cJcdRr9NI01xPAKwqSXYYxuoK6RcQ+wiTN+E37BNITG4ndZrYkYpTJ0s7DaQTV077Tr/GUlbJoD2FmMPHxT4PM0iqDmo7uQGbKExLEMYLOwAIg1RsE1weBPDx7kwwmGDNtE3KRXvY6VSSNYl+mSXI5GdAZdvhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GHUELVkn; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTkyiOyhzgKZYSdddGflmIutMfMlsf4G9n/fWDWGo5TysgPCxqcjSm2Vyq54IvM8W04jLzoyEGYWjNmqFCZpQpAiDV+nq664S9jhLJfMdxkNPA2JAoH3z5rL9NBti0U8wY2M1BZpRYWG/vLSpVWtseCFYinXRm6p3lLse0CObtWY56UfvlzOl3Ngwq9d1wwInKEk1POT650ZBE+2/N4V7vvOq3HGglZ9CLHczlVAhhLwQVZoMV/GBLiDaKhbfF2fcvcmC6hzthDqUND+boX0ug723rlOs0Y3sCJRQMKMV0FYH64IJ/agMyQzvEOCwmf1EeEVbC6+70QECnyJQbQAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueZZNIGFwgaI+J6QBvHnCJjIs4R3jBqOKt5C1/r13Pk=;
 b=EHXv070RLpC5DKpM5fv6+mRDjmhtgU1+NwBpCap4roYf9fzDdVaCY7N2tPw4PtvP5KHLGisSu1q7H7K2ZDyfOBPdTflwqWloTzo+7qnxhCEa26gx1XaJp2q5vf6B0chz5rI+wR83B2jNkXQmYzsn4jXMfHOXEqyriOvQ5sTmcLL00C3VCQiH4yDsdAXV3dfnuijCYGnaWTuw+EIfcwWKrQzQtw+bAEsJNUMRhLUVoyHSumrSYgA0xyNpXPOiWy6p1MtnPF4KtiOA0F2NPd4lYKDc5CHZEphHJD4EZf3qDx9triy+i28NQ86+VpbSvlj+uiv2pb8xVj6yfVidZ0sOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueZZNIGFwgaI+J6QBvHnCJjIs4R3jBqOKt5C1/r13Pk=;
 b=GHUELVkn/GJGWL714eB1e2hoV7dDFs4AmGMjQKImcVw1IK889HGUiyRgMhwY1CJLUwqrxMKLvskZr/KPKc9SW24I9Ic3UOylYEwCiZaiWt3ti3mwPUDQJRRYzAPKmSNaApz4X5R0Z6HPMCjw9K70im3wyV5CTxxQ6u3PvMVET/0l51auQNmw0yTmJqeMfbju7+uiSYTq6FqEEY6VKICoIysvkXti0nfT1/KslZ8OF103WJc7z7ZKK1fSXn5vn4brcKmL46+sbuu37ax3p4u4M7gPHhqC1jqDZ2uuZ4xbrwUQjnXYRM5Bc37nVKSTz4gOqc9LYf8Sar/3Hmo8ma0YCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:58:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:58:36 +0000
Date: Thu, 26 Sep 2024 16:11:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	alex.williamson@redhat.com, eric.auger@redhat.com,
	nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/4] ida: Add ida_find_first_range()
Message-ID: <20240926191132.GK9417@nvidia.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912131729.14951-2-yi.l.liu@intel.com>
X-ClientProxiedBy: LO4P265CA0135.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 6476e8ac-a9ec-4802-d6a3-08dcde659b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aTA2MsRE5/jrDCug9xKkNSNJwNxsQxqf9x8S/pj9I/XJQVVc+LwZoiLqSZj+?=
 =?us-ascii?Q?2th2zkC7VQrzJ4SzQUElsnZw8mW0BkqrrYmwZMNqJbWdjXocKGGFhEwJE3jr?=
 =?us-ascii?Q?IqUDkXuZpafAm8tgdxzG0IzP7+7yrQ/wfdIeHLFmdrILE40uQwvsRgaQC08o?=
 =?us-ascii?Q?qrUJp6UHGSBvO+yW5PwISyNhET2CJScNryXZO0F4YkuPbrMmlPiETG3hK8Xi?=
 =?us-ascii?Q?FfiirRW1sVCdmlTiPLzT49xbQuf0OIYUo9rx2WDFmOudYB9Ah0gtRp2l8Tdd?=
 =?us-ascii?Q?auQDpCrRjbQRYrCUQiPk7F3D8TOm+4uUNWV77x5pBk8sLJEK/giKgpYNxOmz?=
 =?us-ascii?Q?Dunwvz8u5uyoCD40ejE+ezCFyk2h9n2VMAOfouaoA8CEN53Z/v44D0VB0Id/?=
 =?us-ascii?Q?rCCAecWo1m+DEMOlx0FDgFRP0Z00TTxD410uHCI10npgozPpFlPPaU70rCL8?=
 =?us-ascii?Q?jL3M5ch84ZoqR95nvovdubyOtMdsXxo6iZXwCM2J4zNYibG7QQyU43HHdl1Y?=
 =?us-ascii?Q?Hp5kaegaei+w20ir6t2S9qDTIpoWouqiPVXp4vd1H/BXqsK4+24KH6vfHeJd?=
 =?us-ascii?Q?Wpa4dc4DzvWymakNFinE0CF/RCGO9IE5d0DvRhyD5W7LLHehbX9crSrbDvlp?=
 =?us-ascii?Q?lBmh2BS8K5Q+RLMhtxra8MFIz6eUk9y60HOQRfSCQ/nFd8JTLEu8XPYhZ3ze?=
 =?us-ascii?Q?SXI/s+Ms2NNIhflVAf0pwDcXdNPLBkysMdmRBVda5CmIx+wREiqA7bhPod7T?=
 =?us-ascii?Q?Yh3WKRPKowgx2KkhcSaQj+uRpyYElKUKk7ZRWzv4ZxK2EglPIukM4+ltGkAy?=
 =?us-ascii?Q?B0jrjEVHJ4B6+mmo/Sx3w5X1o14ecE6XBAmQi8P1zqfvbZoc62ygUUAS8w+d?=
 =?us-ascii?Q?Dx672LGMeMUDttf3sdYBngZvcwnccRUJAVbTFFils75YPmL1I+kVmiwbn+6p?=
 =?us-ascii?Q?+tl+vDYQ9nHnXjWPxYFQ1gtNx+KQMvWE2RrEBfvAbqW3dGHsRDKBktucLsW/?=
 =?us-ascii?Q?8dbZJZ4k+0/vB4nRPdgA9pSdEAVFM1WTOEkbJihRVNUWuflaCeeyReZOn5DF?=
 =?us-ascii?Q?vZ5boL3qBqyCeBm+ScpuNqJobIwBOk4a8/fwo40D3xfo74T0XBm1FaPj9dAW?=
 =?us-ascii?Q?un2qVOMYmjP6o44g5OIQX+5gDKt2WQahnTW+QCSJ9/rsqOY26m6T4odQEa3M?=
 =?us-ascii?Q?JiPM1Qg9IqXu/uB+DDwqrch8WcClyoi6OW2RNov0RFwaTnbYtz85TzlF9HtI?=
 =?us-ascii?Q?f9WN3/mutIbm173xU0eHRSJN8sX5h2Q2b+ThtFLQVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LKCLgMEV/pKvTLQmZHqyU3CTeNLQAYfQIKxnVKMV8f8+obkKZ8b9WaEaHkGn?=
 =?us-ascii?Q?zUBMZ38vufgP4OTFUrDN4CkCkwN02xvQrkxZSIARbN1hbguQObYBKBDQKbyq?=
 =?us-ascii?Q?0UU6FjG1zl/9LatFlNk8s7F053uJJkjXegNlF2M0zHwRKd16xjGf/1meZONl?=
 =?us-ascii?Q?kASKawVoA6VncjWRzKiGS1xQgIyBJsHKUtQ4GPVYeM43KU/FRZ1vAJecKmOY?=
 =?us-ascii?Q?pBwS1gtTfh2htL168sRA+qlnzgb7err2LbRZGA0s8+gC1lwz0OPYmUZEMsik?=
 =?us-ascii?Q?YRlf8tNi8+mnN27FzZERKt19cvV9VuSEMazd7unP38Wc0XWbdfYJU922LddE?=
 =?us-ascii?Q?qmI7O9u/hcP/oVzARnfukGYSKls2sD6+ttWB6s51054k0uHxByzi0fN85R79?=
 =?us-ascii?Q?8l4ZeC+qMsp8xvfoc6zijZgdNj8dbZqvRA6FCCr5Me6TwQ7S1p6K9itz8otG?=
 =?us-ascii?Q?LLc60qfPZjxME5MGhs9oPsoUdCFtOmRjHEV5kCk29VCyNTJfICRvd3ldDl9Q?=
 =?us-ascii?Q?Of9zkTTbKG+FABJ6GMccdulwvuyairGCkqpx8tGUjM3TvULh8v8LqfHEV90r?=
 =?us-ascii?Q?zhoGPVT7462tVDVpulzHwR9Hd+jGIoPv7f80WnZwhuu8PoZYkYnCRPobGdex?=
 =?us-ascii?Q?eLd/glkjT4gkao5UOjEJvczcRWkYvrAPSQmNm31tWjkhMVTOlfrgRpwcrFth?=
 =?us-ascii?Q?GeiVDiecVJszrivTV+JUj9dDqGotM4BnnEu4B1SvGlwUgxLclwdexMb03A6t?=
 =?us-ascii?Q?HWtn+GvGGR6RPSpG3Yht0xa84lQi9evbgGe8SLkOWEeQ1tptfoHpWb+JBGiJ?=
 =?us-ascii?Q?HDAvGoBxAupKiZ866JqL3PyIiLt/ybQV8MsrO+m06lw8+1OwMPRYZTGrLBV/?=
 =?us-ascii?Q?pMRLtUcNLQN7EzWPVPHsc/41rzaB4Rwr/ikkQX1s46VX6m5CsdIPygLR3rmE?=
 =?us-ascii?Q?ZenoAKxce7trDJHSFt6fAtnTHkvN12WtBViKa+1UBmLkSFz7D2ImiPo0GRJr?=
 =?us-ascii?Q?As5td8JugGxg96VG2D71ZhFaoBIaMC2TLLcD927KU0ms3O7k52vkEbAPQINQ?=
 =?us-ascii?Q?TCszueibny6b7kbYB/qDVDz/GQabLzlNaAZYzeRbygp4Z9UIQXBNXqvLDItU?=
 =?us-ascii?Q?sBqjqP2wKcI2Ld7TRCR6gvDj0UORXqw6fgk+kEgqNwvQAneCeIpvy0tLnQCr?=
 =?us-ascii?Q?Rd/ar0CoIdAUSHLen4FtosjDzVM43hNkZczwCJHFDUGWvoiIx8z+86oNl36b?=
 =?us-ascii?Q?CwXc20r5OszkGHnEz+OpVmjcYsBhHttp8oIcdGW4P1cxupjDSjqDOaCH5myK?=
 =?us-ascii?Q?9wqp4x/UQqXHj1e1pCz1B6mESq7cbaFObz8D/NBquGJbfvcB+34qAcVYxw/M?=
 =?us-ascii?Q?kQmH7M7Y7Kzg6dIULJknHHkAztkwncgcHEKRVi1d///s+UiKzwKiJOUirbVe?=
 =?us-ascii?Q?FR5wBlR0mS/IBbPKm0VnYFpBTGEFWlOFRYtTKe9I9v0GfT/klILlQL/kVrsb?=
 =?us-ascii?Q?ej1yuvu53Odi0A2192MXf6snS1amz456ebESgLq/jtj22+ZLeRI5xtRqudG2?=
 =?us-ascii?Q?reDKTXKBjRpcaAHU193/ErbqS6A4pH3SGNowaOnj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6476e8ac-a9ec-4802-d6a3-08dcde659b87
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:58:36.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxEYeazdXgmbNt61kfjsmJcdYWmLvri/+7M50rgA/+mB4Yz8X9SvTlM1bZJ7pusG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

On Thu, Sep 12, 2024 at 06:17:26AM -0700, Yi Liu wrote:
> There is no helpers for user to check if a given ID is allocated or not,
> neither a helper to loop all the allocated IDs in an IDA and do something
> for cleanup. With the two needs, a helper to get the lowest allocated ID
> of a range and two variants based on it.
> 
> Caller can check if a given ID is allocated or not by:
> 
> 	bool ida_exists(struct ida *ida, unsigned int id)
> 
> Caller can iterate all allocated IDs by:
> 
> 	int id;
> 	while ((id = ida_find_first(&pasid_ida)) > 0) {
> 		//anything to do with the allocated ID
> 		ida_free(pasid_ida, pasid);
> 	}
> 
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  include/linux/idr.h | 11 ++++++++
>  lib/idr.c           | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

