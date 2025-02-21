Return-Path: <linux-kselftest+bounces-27173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079EA3F6D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6827189B217
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBEF204F77;
	Fri, 21 Feb 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ONJDXbob"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8120FAA3;
	Fri, 21 Feb 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146764; cv=fail; b=TbmR0mOKC1jkZBA71JubJ/9R7KZOlpX8KVQsq3bun4+e8hasYQNYiDsfG3J/EI7s5J8z100Vmlf8KIbpvL60PrR6ZNk37Mo/E6EhtVHlzXrFFor987ATkYAFAIgEzSgBkYRA+KZwNkdcZbT12lLy5egbsTFwupJWx44f4pg4jGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146764; c=relaxed/simple;
	bh=0YxkV0qHmId6t9dMZBWPOitJjuOSYaSQCUk7YC+/Ji8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Df+BRz031SXeG6cA4JsWiKMT7P9a/N2T/62FUI5M88GUXwKKbBWsCqv2FEEaoJeand29vzJDJJK1m+WTGljM6WUNTpEBlWyDDRimHMi0uIk39vLn0jHjNACsNq6DjBLebztqLnXwHBHPLPbOXuaP1ThHFv79hVap38MBbyKEbTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ONJDXbob; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOC68uY13AiwLQ1TLrKvPNlP6ZsVDROGRUoM8JKbh5saJDuFdFoQGNMsp87GDBCAGLHDlSdYzmp+9pAupiFRjgzd+jcukwqGGDnvk9f8M1HyRUVzWFea5tbciWux9y2hksFI5bQ8EhhGumH+6GiF9awjYsZCaxPzj1VhLDm6zRod42h368lzeU8ad3u8BITWdMTVqA3Dr3KveBqomcXrUYvcwNRu8HGQFlHApXPgD+8G6h5GhsLs/hWdPffBj231ZZIg6pNQPPJY1k+x0X8phB6hEzYKNnRv42PPLPNqiEFru6zf+SmMYStCE82ZoJNKHK2EwTLuyLTZxxCDFIIMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64eYMEDrlRIxbcPeG3FvwifDl+9+anJdNxRVXm6iO4g=;
 b=GVZZOrCLow23O8nvfnJRdL7lypx/ecKFzCCMu6qCIjoPWiFVJX39H5IccuVbGFJCaqp9HViq099RCnXOfKxikRV3+9LBia/6DQ3s63QVeivYJ5HaB27HvhTHMvSPon/aiPKuJbXLcnlHDldFBtqGjtQf7Yr2kQbwdk+ZAmZ83wQijYjDTmFvBSXXffcwyhpk6DKXz4ukwMTipwr8+v1MNAdLEd5mN2XubvtIDTljYqAQRRuLsY9XcBn/5Y9TN+uhjxjdhx/fXXVnbJ2kEWwNLK/NOGOMowow3hCwKM3Iu04tHvX3aXNtZ81p8Uo4UrKKYj3HmQdBVvxa3c63MUo9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64eYMEDrlRIxbcPeG3FvwifDl+9+anJdNxRVXm6iO4g=;
 b=ONJDXbob5XxZXuS000II7N4H2AgsivXLmY9r2ok4A/Q05PWSxMgOzH/oNSOyUmkzjJ86X8hOtzrbJm+h/TH0Wnl+ZTwiKVbEKc8qZyvBqdhd6a1NCntJ0xiY06gUWxUSIza6v1dset8tDAsV9J2aPsRLestsEc8LeRXVt0AXI6htZHDh4CLcDN7GLRJp0kzYN+sHZ1TIeDzR+eXG5Hg2Qg+R4nttWrmUJ1fpkAkHVSiDov8pKIz40zfPE21j5FvpETh2IVKSH0ndIyUgN0qmpKOtf4ZaCx293iuSXxSvNDevGol/AxAcPESb2XWjoC0P1e/MBoJPgaYkRtnhm5IWAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 14:05:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 14:05:58 +0000
Date: Fri, 21 Feb 2025 10:05:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	maz@kernel.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/7] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Message-ID: <20250221140557.GL50639@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <a4f2cd76b9dc1833ee6c1cf325cba57def22231c.1740014950.git.nicolinc@nvidia.com>
 <87ldtzhcjv.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldtzhcjv.ffs@tglx>
X-ClientProxiedBy: MN2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:208:23e::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d618b7-7b1e-4a73-66e5-08dd5280ddb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtA2NgFRbNCIyGJb6BiYwwbHpa22zbnKLWNK+JRdFwm5FOspaQ4wXrgpcblT?=
 =?us-ascii?Q?5ML7qIM24HITq3tzNqZLiwqQ77/j5EoTL2+1qzCCeA1mBan9hB3f+/yZcAg7?=
 =?us-ascii?Q?3wWMGJVQWX9SaegEPRwWPp0J7wxulUcOlH7dZ54LjTy1V/ty/+0eamfFW0HB?=
 =?us-ascii?Q?eVV53hRThyj7Y1ByyqLXiFEVyMHhdMSOaFfH4zsXV8EYsk0unfpJh4V2i4O0?=
 =?us-ascii?Q?XQ2MAj3z6uBnRZkDNxAk3QxWPWE/f/B54W+wIFklhqY39m3yTmqZBg4AC603?=
 =?us-ascii?Q?xmPxCksrUNfhmLr7vhwhZA9G7rKydPFPByygDaxFY262CDo3sVqfGCe2uJR1?=
 =?us-ascii?Q?7UFcS3h7MvLk15mYxL4QDTG+y4wGoXTdwuFEf26l83QRAjDJkQgOY3TMgZHE?=
 =?us-ascii?Q?61cEyBKsNRnF2kpMaf+K7QvwKVhzZMsgx7q1qbm/q2XUD4zQ0G015gF3b9dc?=
 =?us-ascii?Q?ex18qfyQKLnMhRe2JZFXdYAAj625y9EYiKHY1QMIJYNQWL7rLdNDylI+5jeN?=
 =?us-ascii?Q?NZVAcqeCSK/dcNtpAgUpFYmhZ+FrkyOZiNjya2r/UiYsY7Ei8+WwG40xG0ry?=
 =?us-ascii?Q?9+Ye30C67s2LbcINqMKi906oP30WEJrdNiubWy3Qusrk07DFTa6F6MY7Pmfh?=
 =?us-ascii?Q?nIvWgv9IWDsIJ2mPhQipx8oZjKdXwCj93ykNidGAJLqTFQ04mal8Twpf42fd?=
 =?us-ascii?Q?IaCwTjJniX7MLbvK9dsWb4U2M9BrbWvpxlakYzaTaruG903xCk50QJ4+9NSH?=
 =?us-ascii?Q?qMIJmFJiDcMQyeE1zNhxx7AWuFcfJ8Fvelmw/aapPOKwHBwgpb1hlLrMAReu?=
 =?us-ascii?Q?1ffUWGADXQ9CNbOWBt/b9LA17hCKQe3gSnSI+FQfqO/2zCSZOTqXoZe7cBsX?=
 =?us-ascii?Q?QEMXpWphBov93qUzU0d0nkU6KmqteJb1rUtXzNtGzMYSjGqkQZ+e6HYg8T9K?=
 =?us-ascii?Q?c0CbRNHmtY13iHX5oBweofx2FHkIksFieOxf4dv7clqQPtgVPOjIQZtuJXQJ?=
 =?us-ascii?Q?Go93WJbx35y6iAH3vcxjl1G4wOWkvrxwXLAfCRz91M3SEjuA3gOhczmy5d+i?=
 =?us-ascii?Q?8VSTsC3s+TjfEzYKwJPVt3B2KkaR/w9N90hexRHiriOvLL6RNdR3Xtf34I5Q?=
 =?us-ascii?Q?ORy0gR0L0yyn1r+7Qz2Ozr4IH+JQZLc41rcFsA58Iak+eT/mPHGfCpywcAAf?=
 =?us-ascii?Q?aHJ2eIzFscQO+kwrzcGuiVq+bW+oULMkTFdhgcnSwGC56u95s/FVm6JIqYjx?=
 =?us-ascii?Q?VlmYF+nUW3pGKYKwjqOWBFqet4rwQtcOXWxW6z/iqDAwvr0/FzYWP7L/Fb8c?=
 =?us-ascii?Q?k2gwhaf7yLn7s6jzqvraRTL3QtCKtfjCGdfZ7k1RJYlNlqEdgRKo4M1JIj8I?=
 =?us-ascii?Q?9UdH8EwQAiizUDUGKELI/aPIVT64?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EUY7MVvw6Uzow8drMA1AtP2x2rjmJz+kBWjbFAzMBekvAHjJlYeeK2eVv5lf?=
 =?us-ascii?Q?F3KFeTYXQnpYMsrH5/EfkP7EgUlzdnEZNds57v0qsK3cbmA7uvI3iQnnuBrk?=
 =?us-ascii?Q?Zj4aa4oSCFEKxnaUx00ONy7brB15OaKlf6su6BKZ/vP6S3qSRTRLQDiHoLMW?=
 =?us-ascii?Q?xAqrGNeBfFat1ylTq2a5Oj9o3yzncJ1EP4WZ2smyLM8P8hM968KxiPlD4x4C?=
 =?us-ascii?Q?m0vy1FlHECe6xBVcyAA1HSzI7wAgbSRT7nwaX+UyMqYVuWRFJjsGYhBAyeNk?=
 =?us-ascii?Q?yGQEVwmaVcSMkDrvuIaCDdm0+WKPwReKjBZrCHbEwGRYCeSTMKEmVii8C2Kk?=
 =?us-ascii?Q?x96DJvSMlan6WV1FO61rqKpc2LyvTi+6I1bQinYF1VPmvfFWd86sUdd2M2dU?=
 =?us-ascii?Q?FnLWliCOk88/nghf5IpOAHFPpwAXA8eDfVmKVDQZS2a6jvlAvr/2wzm6DPwz?=
 =?us-ascii?Q?KRkWdeuUSDUxf6OGZ+3tDchC89mnUwEFODIGCMLgzM1ZwSmYk5X5xmAVV/aa?=
 =?us-ascii?Q?GI6PRDK0LZXBrHvnqyq3lqiBOOjiSdXZmtt2wDQkgKGGFKRwmTwq75vVIQg2?=
 =?us-ascii?Q?NTXkqjhaTo8Gq4fcDNB2PpG5MCQ5xGd8TwpbVJt0uPVcZURh9LG1MsNPFd1+?=
 =?us-ascii?Q?tMtYhYhibrgZ8NVsCadSxcx+nYlcWKpToft0zmiOaUYnhPNUI3VebbeVOHsj?=
 =?us-ascii?Q?Cl4qR3aDr7r5FHA1LcnpcwXHEMlWuQGTnXZDIFM5D0eIJyH7eDgxS8eOlkOg?=
 =?us-ascii?Q?SloCRBY7tYfk8fb0w6sntw2lMD0rkwIy8YJTeTjYVYD/xSmcn4OnWn5tora/?=
 =?us-ascii?Q?1QQYcN2w4NVUkih92/TqtQMod++LiD5qIQDS3XGepc25V/5s0MR0hny5A+10?=
 =?us-ascii?Q?lxhqAijgztzgkGEZq7uDMtiiVZH7pU4OVnfDgrmqvj4JAkhf04hTHv1YBoY1?=
 =?us-ascii?Q?YU2ESSEU7xWwffI/08/k3WNqfTes/pnrPDxrw/pFbDspKxwMMZ3BIJ774Be1?=
 =?us-ascii?Q?euXPY5nibYekJoQboHjaBqwhJQacyTaBhIy5vf3Qp4qGmAzTki/P7+x4EgSD?=
 =?us-ascii?Q?bbA5F5CObXDuwFASlAi2hFPsNgpn4CsKnk6qRcTmseXnJ1g1ZYs47JGE8bZb?=
 =?us-ascii?Q?Ry4mT8D7Rl48rNQAndo8H3fryZ/lK6YQdQ6s99nBkOkIldYhwBRcHmk1Y2fU?=
 =?us-ascii?Q?OMCylY0dBHIyTAWoroY/QQC4D6Ghhr3yuH6goZnF03aJ0BBhqm3k5JtU40zg?=
 =?us-ascii?Q?aQquzQNC3mYN8gBrOlp2QS+yLPlT1Cq1dhNOR956jdgl5MBOgPUUe4ua4H1B?=
 =?us-ascii?Q?CFEMuiPNBcFTKnf5AmnsGu/e/kjARde1kciR9rzmeiv/cBx5gFwJZsNqLkuz?=
 =?us-ascii?Q?aVYVZRWLm5RKu4xfLzUC2OfUWpc7ZKTB5pGnP5lTauViEiTdrdlZkE9M8SVd?=
 =?us-ascii?Q?hE0ZvMt4U+7eNHxi8xno1m81IN8roAUl/5jC0jo7VGKwpxsnYYahXx2vnAg6?=
 =?us-ascii?Q?CwK6DBRhSBPxr1Dlu5X70TgY3+uELIM8s7uK+vurlxjHezhr3vZWLXgtgLWK?=
 =?us-ascii?Q?3MfuKYZk4qB9E2kRpY4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d618b7-7b1e-4a73-66e5-08dd5280ddb1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:05:58.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azL3ZB6C5+4mmyKS/pHViSrWZs1YaJT8/UGEgFrSQwkQgTCBybcDzpQ9YurtvfLC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707

On Fri, Feb 21, 2025 at 10:28:20AM +0100, Thomas Gleixner wrote:
> On Wed, Feb 19 2025 at 17:31, Nicolin Chen wrote:
> > Fix the MSI cookie UAF by removing the cookie pointer. The translated IOVA
> > address is already known during iommu_dma_prepare_msi() and cannot change.
> > Thus, it can simply be stored as an integer in the MSI descriptor.
> >
> > A following patch will fix the other UAF in iommu_get_domain_for_dev(), by
> > using the IOMMU group mutex.
> 
> "A following patch" has no meaning once the current one is
> applied. Simply say:
> 
>   The other UAF in iommu_get_domain_for_dev() will be addressed
>   seperately, by ....

I used this paragraph: 

The other UAF related to iommu_get_domain_for_dev() will be addressed in
patch "iommu: Make iommu_dma_prepare_msi() into a generic operation" by
using the IOMMU group mutex.

Thanks,
Jason

