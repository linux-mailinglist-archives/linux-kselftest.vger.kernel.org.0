Return-Path: <linux-kselftest+bounces-39980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68267B37124
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283F636777A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1C3126DB;
	Tue, 26 Aug 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KH/xaAxe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108A52E888A;
	Tue, 26 Aug 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228736; cv=fail; b=eCdnVaz4V/4jFpTJrWw6Fp8Q4pGcTRVDF69xCJKRZWaIyGkFSPbBuAQm/fOjRFgQJ8KvDmLnqJK7CDp356q0BkCIZjNuXTXn7biLJd2tITKhZ/bK/D+Ru1CA210Vg3uZlTIftxyEp7u+U77hncAAQvEpQXWvjxZ2fCb04CuITE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228736; c=relaxed/simple;
	bh=iC7/Lvsu3BxADWy0djBHqH9aRJEK8sLlT+SxnHdVZBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gyPVOyRGYBETeUFYYmne2o4+KNTdtd+hBh9sScGjytzHJYAOGV8KfH5em65ISJsTNuHKHD+jipZ0mLQUvt9CEtXwP8vlF3yGrkth8a85JLoIl4vr3zmdYi3dXtPjT0T4Ra056Pmvpk5dMcwPePaf0xz58S6aQ7CZPJpXAUJq3jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KH/xaAxe; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKVe3Upe8ph1lgwCr5AFXPJ4pIxXD1IhWqWLSaYwJcLqB1DLtpPzdTpuF6drAPP3Qbgxd3rXj3ZARZ16sjPGoIDqF6IR78pknCWF5vYdbGK/vDEWCsJrGcJE0juxIamfy4/YIXwtYTXJtH8Dg1/FV1uaAH+C+/TNJvooKZeRr5N57sxghcfAF69asWtWnRQ+EHTZ28AEqlle3QjZkKPeU5bCuk3fas76DCrbSGa88HdjCezhn9F82zQZeX+yHpkKd5SbGU3vkWEPBwDwj+JimEOLOvbJmIlEp+7jrTrALD22SViL/mFMzlUMF56rZTU7KG7edYdx3C029YB5M+/Ypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdJBjbxHk4LQHhxQfAQqQCBPYroPQ3gKEi55ZmA7wP8=;
 b=nZ27kzJzZkk8df/IhnYCUvE2Y+3r1R741+XHrSo+ym1AYqPEy6ZFyW7CCInLnuwp4z8Buq0B4wbnWn6zOTaijrs/M7r2w/Whf0Yh+7XWqscFVYFYFUBjtDAxlmPeSzt+bVrw8XFSOiGLnqLw+FpMGQKdWRbneKqdnoP+DGh216VqD+SMulcUlnt/bpbpgYOB4mgJN80JvEh5QObs2ahX7RKo9SKlQa6H6hp/HlNRJ9NiHm5vOsta64egQukNwCL5pYi30Lypbu0a7UWBYnDxDDcCsKUTBEA90yWKDizm2VbzmPOLyBjGPzaMh6BZaOC1EU2mZRmvLOE13PwTtfr4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdJBjbxHk4LQHhxQfAQqQCBPYroPQ3gKEi55ZmA7wP8=;
 b=KH/xaAxeKXBCZGGS+/bew8lehZBen1GZBMk9azw2nc6a9VRjjhjfnDBlzrjpl0E4sW7OSRUBxHD/w9+tL9kChG3aJRUu/+DC/hB4rzjpjUNR9vyIaIY2hIv+2OhAI3Y7gFndRoNq+nzeCsjZe158OkmVmLN2aiXlA3p+8of2u9GzlCiXKzIoYyLLbeOSPG7UVFMaP0Oh8IjIAmAL8FHExMkSKDOZZZeWfBCTkdBkfUXix9iTxPjhhsJQcs4Bs5oML8rogp0NDCxPZRMoud2NQy4Zck2WGbmOV5OTswqCGx2VnAESlg5mo+GE+YCLuCXCzJd+7WhCT1dAv6wQTCmLjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:45 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:45 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v4 07/15] iommupt: Add map_pages op
Date: Tue, 26 Aug 2025 14:18:28 -0300
Message-ID: <7-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0166.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::21) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: fbca7d96-a318-4024-8c36-08dde4c49acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BPqGdoeGkhE1Zwo7FHgN9VURjY37G4fDBh/7d7oVxQEJXfkIGbe6G2WFW4p2?=
 =?us-ascii?Q?11yaoy5sJEKT8NtYnE2uuR/hRp3pDJ8U1PB4FlPl3J7Y0PvfuUX9Dx0QdhkT?=
 =?us-ascii?Q?NpoAl/vc5mjMARk2mh1tCDgi6RILMhg0RfZdNk1G5K9Vcwx4eJSJsojRsTGV?=
 =?us-ascii?Q?7A3rtkapeRn6BGCN+Xf77owRBTzyeSLcvNr6Hh68HUSW5SWC45te6+aoCZKz?=
 =?us-ascii?Q?GguV8X2PpdK+dGFTWwlc0//6+Qhxdj7KMOB+6h6r91ifrl6l55/l+ng1LL8s?=
 =?us-ascii?Q?Yh3w+eAZ7ropRtH/Fs33mPnYD87rJHsBbNdNChtQEpDytcNqof+dzpkojFQ0?=
 =?us-ascii?Q?12jE6yEWqdtdHuG4gB7eNliDqwRvxaFYgPf4ZuxtQf/JXT50eQ9k5TcC0zc9?=
 =?us-ascii?Q?xg/R2l7HJtFIvZPCn0Sigsf7FmHXqSBkaJqlX7QChP2xylL2WNjMhHRpjjUo?=
 =?us-ascii?Q?OGsKG8mDXB7eCJ1ce5deNBTHUqmrj/+B1fzCnorGRQ+lUOja8wcj3lbGgL16?=
 =?us-ascii?Q?2ATIHZl9+rFfKusoLXntelr3M3kj2Jt3opc5wJniMVbVUzp0LCCyoEWveI0t?=
 =?us-ascii?Q?NgjerRSNFDD2k0nusXuo/RS+PxssZoMGj51kaOvCLpPouILicnVFx//MWNkD?=
 =?us-ascii?Q?lpF635reoSrzEU+Ka/kpFAeMw23sL1MOljv2ddUYHQ5WzmhuD2LWFmzIinvf?=
 =?us-ascii?Q?Fi2cOBRFp5NIEAU+FHvoMxJHmquBOOEFbSwDRZHN9oyfhSLsUmpEHF7pvUD1?=
 =?us-ascii?Q?bIKqsWWL2CTlZfAaSC4yg2SEs9RfuYUg9Dl5nc7Ajt/l3/YmZ2yiQDawaZyZ?=
 =?us-ascii?Q?YmIaRcSt+ZonNTiHW293Umd9ZO3z4RdNMC+yW1GwJkcUIWsj+0Z1y5lUwQTm?=
 =?us-ascii?Q?GPQ+mkz7wRd55t7uSzPSDsbRJPynuQA4J+nDNu2nbHNIuUqflsjBE6ik6i6v?=
 =?us-ascii?Q?3JEHNkLwVD1m8PyoHJ6zYlQpIIdLlEuqwvhsLZnyKWAZXn33tUNdqbyEVET0?=
 =?us-ascii?Q?CQLEjN58tdg6tD+kdMxUF0YR29Eqw8/L8L0krna3Dyopr5ukIB0E19XvyZHF?=
 =?us-ascii?Q?yyUBfUd/oSMLMgJFiQAM/4GvQCk/LIBZ4fFRKZO1iRrBWEbPaRpWdWn+O0m1?=
 =?us-ascii?Q?olukwy0m21vsyziomUZI53OxQEo8nO4sQrg7a0LeTUvXWFzzIatIMAUX+qCR?=
 =?us-ascii?Q?QLpgJUPasKEBSwOchNLEjSRrjqO74hg0PB2RMdaCSYkm9vhJ/Zc7pO8P/IW9?=
 =?us-ascii?Q?Oz/+8cPNOVY1mcogMqq2nOA56Edp8TD8pRpE+hfni5wHvO/CzdwzXvB/tVd2?=
 =?us-ascii?Q?gkYIfhjnQJvs5nNAvv6oKLK0H54sLtekcXCl381P2/Y7fjQ/uw4YhlllKVab?=
 =?us-ascii?Q?xKCK7hh5yZRWk+Apiyf0uUVaRRwUlVAUwDZBKNar5/MH46WrwRd1DX241fNi?=
 =?us-ascii?Q?LgT/qILKw1HJdZCc+iTCkKTJvhIcmzpGqPyx0knd59kaJPQDZjwo/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w1uS4Q818bDfWWNn8w/uNOpA/0DfzTCTQBYxxOhKZSM14unuy4RGAH4jerd6?=
 =?us-ascii?Q?UJ2J/QL9NeP2AyiHzJMYzfc/Wg3U17OOJorlrQ7GRe68zmJ5VoZA2W0hM/vW?=
 =?us-ascii?Q?w6PRCArViC6PaB+ATa8Q7kyMA7OkZB5TccgSCIfBtW5zQG6cgoAJ1Id4TUWD?=
 =?us-ascii?Q?YDu/35P2t4fH6fV489SfKWswPrX/dzcC7LJaGbmg5z3UEjFub26msh+KjCD/?=
 =?us-ascii?Q?+YznKYQ/THWd3Nuv0yOSLsWnyImfbCncMkkdVn/hW5ef6qlrU3wsP/aTjXg+?=
 =?us-ascii?Q?WrQY9AJLmSUfBtUEIdp7OCbAjR9s7rcKafJPSUl1HIcRUE+QKBMbin7RFv1V?=
 =?us-ascii?Q?CoV3CNMR3RFiu7y5KZva80hLzkhuZQEWvx+VZw9kXUdRoYBP7cDIS0Np18cS?=
 =?us-ascii?Q?VKwLtIuid2uDRTip+7Rb/N/iTbG8QfjMckWUly05HkrZxupP/D+e/0HsRhMb?=
 =?us-ascii?Q?Urydyyn5fb8Z2ysn+JeVGy0h1Qi/pFYNeUZHUoqxc8GGlR2eU4TffWX2FK2L?=
 =?us-ascii?Q?dIKIMpgCbEeilX43DcaqoICvTBWKs8/RviZuarAuSqdmZTBoN/OjzOjUNfzw?=
 =?us-ascii?Q?Qfe2u0ly8SenGbDxhj6PnvRNycJKjJZKmEmmo0cp2YsEYz+YEy2AmLgxrwqn?=
 =?us-ascii?Q?8x72fM1slvWrq6pWz1M5s38lUZ6srvwj/9caH7adS/eqW0WGDcd9+l4AFVRG?=
 =?us-ascii?Q?usrvQmFd5Nqc5a6Qy+/oxdHEAq0OezFDlF1AuHcSt8WeKkSVYH1juuNIxsQ9?=
 =?us-ascii?Q?ucRxdYVYwB4pNbNAymT/fypff+1RA76HQUfgbIynYW6duFWncnfz4PBLg+bq?=
 =?us-ascii?Q?WW0yYhE2mrLtI1dA4OMJeTkF9NdW9bFIW5nzBJo5JmBiPhQgbDWwaQXWoZYr?=
 =?us-ascii?Q?aZ636yIByLjT6vI6L2HXoQ+s0Hcdsy8AnawheoH/7K6NrMQlmQCWVDYoqzHc?=
 =?us-ascii?Q?Ax/sVcc8+Ll3pGudDeM91ZOO13I8V50TfnFycmPxNglg41V3ca4kRIoemTI+?=
 =?us-ascii?Q?/A0zRmXGIdppXLrWwdeMxHa/ACBdpC7i/EvY7X127G+VmPns6SK35Dz16mLy?=
 =?us-ascii?Q?EELl9SP6MSbRmPx8sSg6EKttRZW9t6viS56ZQQSC9m4/cqejw9afrEsNo4io?=
 =?us-ascii?Q?z02bNRTqwC27nwr7BZ+v75n42SkHH91CzgBiqwUQG4ukIhlU0BcbUtFh9Fy5?=
 =?us-ascii?Q?XZmvSwzAjHlqWXp3RoMFZbUvZHlcmdoSu7MpHPwU3BpWdo6fGqHr0ie/mCJm?=
 =?us-ascii?Q?GVX2xafbI5mZAKP9sGAd+dhiKjZl6zfK4KE4xvKjC4r5GeIZni8yXVOJGv4V?=
 =?us-ascii?Q?VDdHvLiU3bLezZKkoBCGvMuBESkrFJ9BDlTHLM/OnhMt7d2/mXaGeYKeYhc4?=
 =?us-ascii?Q?22jw6S7AbTel+fC2UIO0qSFls9jYA8tJzbAavCPNO8QrLZSxl+s/nHJ7Lytb?=
 =?us-ascii?Q?2LznNv6LhUhwWDLHfWRtdx3coPzTrhhQv8o5lplVja+yFTaxjlYznE5lCxkn?=
 =?us-ascii?Q?JncHD03cCOBxqZl1TFople/VYNSIl8LVi7HbtphLRPz+WymYX49Ed9qwtEnR?=
 =?us-ascii?Q?SYKCfvIg6N589rIacFDXMgRfKXoOsxiahwnqRcb0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbca7d96-a318-4024-8c36-08dde4c49acf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:42.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wj4IshSwEINjHeeKlEAJhK4fmcodNawQi3SykMYTAhSPpORI/rmkgLCTahHHY1+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

map is slightly complicated because it has to handle a number of special
edge cases:
 - Overmapping a previously shared table with an OA - requries validating
   and freeing the possibly empty tables
 - Doing the above across an entire to-be-created contiguous entry
 - Installing a new shared table level concurrently with another thread
 - Expanding the table by adding more top levels

Table expansion is a unique feature of AMDv1, this version is quite
similar except we handle racing concurrent lockless map. The table top
pointer and starting level are encoded in a single uintptr_t which ensures
we can READ_ONCE() without tearing. Any op will do the READ_ONCE() and use
that fixed point as its starting point. Concurrent expansion is handled
with a table global spinlock.

When inserting a new table entry map checks that the entire portion of the
table is empty. This includes freeing any empty lower tables that will be
overwritten by an OA. A separate free list is used while checking and
collecting all the empty lower tables so that writing the new entry is
uninterrupted, either the new entry fully writes or nothing changes.

A special fast path for PAGE_SIZE is implemented that does a direct walk
to the leaf level and installs a single entry. This gives ~15% improvement
for iommu_map() when mapping lists of single pages.

This version sits under the iommu_domain_ops as map_pages() but does not
require the external page size calculation. The implementation is actually
map_range() and can do arbitrary ranges, internally handling all the
validation and supporting any arrangment of page sizes. A future series
can optimize iommu_map() to take advantage of this.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 480 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  58 ++++
 2 files changed, 538 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 53901a4a977935..ee762dde6fd531 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -91,6 +91,23 @@ static __maybe_unused int make_range_u64(struct pt_common *common,
 		ret;                                                     \
 	})
 
+static inline unsigned int compute_best_pgsize(struct pt_state *pts,
+					       pt_oaddr_t oa)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(pts->range->common);
+
+	if (!pt_can_have_leaf(pts))
+		return 0;
+
+	/*
+	 * The page size is limited by the domain's bitmap. This allows the core
+	 * code to reduce the supported page sizes by changing the bitmap.
+	 */
+	return pt_compute_best_pgsize(pt_possible_sizes(pts) &
+					      iommu_table->domain.pgsize_bitmap,
+				      pts->range->va, pts->range->last_va, oa);
+}
+
 static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
 					     unsigned int level,
 					     struct pt_table_p *table,
@@ -190,6 +207,462 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
 		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
 }
 
+/* Allocate an interior table */
+static inline struct pt_table_p *table_alloc(const struct pt_state *parent_pts,
+					     gfp_t gfp)
+{
+	struct pt_iommu *iommu_table =
+		iommu_from_common(parent_pts->range->common);
+	struct pt_state child_pts =
+		pt_init(parent_pts->range, parent_pts->level - 1, NULL);
+
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_num_items_lg2(&child_pts) +
+			    ilog2(PT_ITEM_WORD_SIZE)));
+}
+
+static inline int pt_iommu_new_table(struct pt_state *pts,
+				     struct pt_write_attrs *attrs)
+{
+	struct pt_table_p *table_mem;
+	phys_addr_t phys;
+
+	/* Given PA/VA/length can't be represented */
+	if (unlikely(!pt_can_have_table(pts)))
+		return -ENXIO;
+
+	table_mem = table_alloc(pts, attrs->gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+
+	phys = virt_to_phys(table_mem);
+	if (!pt_install_table(pts, phys, attrs)) {
+		iommu_free_pages(table_mem);
+		return -EAGAIN;
+	}
+
+	if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
+		/*
+		 * The underlying table can't store the physical table address.
+		 * This happens when kunit testing tables outside their normal
+		 * environment where a CPU might be limited.
+		 */
+		pt_load_single_entry(pts);
+		if (PT_WARN_ON(pt_table_pa(pts) != phys)) {
+			pt_clear_entry(pts, ilog2(1));
+			iommu_free_pages(table_mem);
+			return -EINVAL;
+		}
+	}
+
+	pts->table_lower = table_mem;
+	return 0;
+}
+
+struct pt_iommu_map_args {
+	struct iommu_iotlb_gather *iotlb_gather;
+	struct pt_write_attrs attrs;
+	pt_oaddr_t oa;
+	unsigned int leaf_pgsize_lg2;
+	unsigned int leaf_level;
+};
+
+/*
+ * Check that the items in a contiguous block are all empty. This will
+ * recursively check any tables in the block to validate they are empty and then
+ * free them through the gather.
+ */
+static int clear_contig(const struct pt_state *start_pts,
+			struct iommu_iotlb_gather *iotlb_gather,
+			unsigned int step, unsigned int pgsize_lg2)
+{
+	struct pt_iommu *iommu_table =
+		iommu_from_common(start_pts->range->common);
+	struct pt_range range = *start_pts->range;
+	struct pt_state pts =
+		pt_init(&range, start_pts->level, start_pts->table);
+	struct pt_iommu_collect_args collect = {};
+	int ret;
+
+	pts.index = start_pts->index;
+	pts.end_index = start_pts->index + step;
+	for (; _pt_iter_load(&pts); pt_next_entry(&pts)) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			collect.free_list =
+				IOMMU_PAGES_LIST_INIT(collect.free_list);
+			ret = pt_walk_descend_all(&pts, __collect_tables,
+						  &collect);
+			if (ret)
+				return ret;
+
+			/*
+			 * The table item must be cleared before we can update
+			 * the gather
+			 */
+			pt_clear_entry(&pts, ilog2(1));
+
+			iommu_pages_list_add(&collect.free_list,
+					     pt_table_ptr(&pts));
+			gather_range_pages(
+				iotlb_gather, iommu_table, range.va,
+				log2_to_int(pt_table_item_lg2sz(&pts)),
+				&collect.free_list);
+		} else if (pts.type != PT_ENTRY_EMPTY) {
+			return -EADDRINUSE;
+		}
+	}
+	return 0;
+}
+
+static int __map_range_leaf(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+	unsigned int leaf_pgsize_lg2 = map->leaf_pgsize_lg2;
+	unsigned int start_index;
+	pt_oaddr_t oa = map->oa;
+	unsigned int step;
+	bool need_contig;
+	int ret = 0;
+
+	PT_WARN_ON(map->leaf_level != level);
+	PT_WARN_ON(!pt_can_have_leaf(&pts));
+
+	step = log2_to_int_t(unsigned int,
+			     leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts));
+	need_contig = leaf_pgsize_lg2 != pt_table_item_lg2sz(&pts);
+
+	_pt_iter_first(&pts);
+	start_index = pts.index;
+	do {
+		pts.type = pt_load_entry_raw(&pts);
+		if (pts.type != PT_ENTRY_EMPTY || need_contig) {
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			ret = clear_contig(&pts, map->iotlb_gather, step,
+					   leaf_pgsize_lg2);
+			if (ret)
+				break;
+		}
+
+		PT_WARN_ON(compute_best_pgsize(&pts, oa) != leaf_pgsize_lg2);
+
+		pt_install_leaf_entry(&pts, oa, leaf_pgsize_lg2, &map->attrs);
+
+		oa += log2_to_int(leaf_pgsize_lg2);
+		pts.index += step;
+	} while (pts.index < pts.end_index);
+
+	map->oa = oa;
+	return ret;
+}
+
+static int __map_range(struct pt_range *range, void *arg, unsigned int level,
+		       struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+	int ret;
+
+	PT_WARN_ON(map->leaf_level == level);
+	PT_WARN_ON(!pt_can_have_table(&pts));
+
+	_pt_iter_first(&pts);
+
+	/* Descend to a child table */
+	do {
+		pts.type = pt_load_entry_raw(&pts);
+
+		if (pts.type != PT_ENTRY_TABLE) {
+			if (pts.type != PT_ENTRY_EMPTY)
+				return -EADDRINUSE;
+			ret = pt_iommu_new_table(&pts, &map->attrs);
+			if (ret) {
+				/*
+				 * Racing with another thread installing a table
+				 */
+				if (ret == -EAGAIN)
+					continue;
+				return ret;
+			}
+		} else {
+			pts.table_lower = pt_table_ptr(&pts);
+		}
+
+		/*
+		 * The already present table can possibly be shared with another
+		 * concurrent map.
+		 */
+		if (map->leaf_level == level - 1)
+			ret = pt_descend(&pts, arg, __map_range_leaf);
+		else
+			ret = pt_descend(&pts, arg, __map_range);
+		if (ret)
+			return ret;
+
+		pts.index++;
+		pt_index_to_va(&pts);
+		if (pts.index >= pts.end_index)
+			break;
+		pts.type = pt_load_entry_raw(&pts);
+	} while (true);
+	return 0;
+}
+
+static __always_inline int __do_map_single_page(struct pt_range *range,
+						void *arg, unsigned int level,
+						struct pt_table_p *table,
+						pt_level_fn_t descend_fn)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+
+	pts.type = pt_load_single_entry(&pts);
+	if (level == 0) {
+		if (pts.type != PT_ENTRY_EMPTY)
+			return -EADDRINUSE;
+		pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
+				      &map->attrs);
+		map->oa += PAGE_SIZE;
+		return 0;
+	}
+	if (pts.type != PT_ENTRY_TABLE)
+		return -EAGAIN;
+	return pt_descend(&pts, arg, descend_fn);
+}
+PT_MAKE_LEVELS(__map_single_page, __do_map_single_page);
+
+/*
+ * Add a table to the top, increasing the top level as much as necessary to
+ * encompass range.
+ */
+static int increase_top(struct pt_iommu *iommu_table, struct pt_range *range,
+			struct pt_iommu_map_args *map)
+{
+	struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	uintptr_t top_of_table = READ_ONCE(common->top_of_table);
+	uintptr_t new_top_of_table = top_of_table;
+	struct pt_table_p *table_mem;
+	unsigned int new_level;
+	spinlock_t *domain_lock;
+	unsigned long flags;
+	int ret;
+
+	while (true) {
+		struct pt_range top_range =
+			_pt_top_range(common, new_top_of_table);
+		struct pt_state pts = pt_init_top(&top_range);
+
+		top_range.va = range->va;
+		top_range.last_va = range->last_va;
+
+		if (!pt_check_range(&top_range) && map->leaf_level <= pts.level)
+			break;
+
+		pts.level++;
+		if (pts.level > PT_MAX_TOP_LEVEL ||
+		    pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2) {
+			ret = -ERANGE;
+			goto err_free;
+		}
+
+		new_level = pts.level;
+		table_mem = table_alloc_top(
+			common, _pt_top_set(NULL, pts.level), map->attrs.gfp);
+		if (IS_ERR(table_mem))
+			return PTR_ERR(table_mem);
+		iommu_pages_list_add(&free_list, table_mem);
+
+		/* The new table links to the lower table always at index 0 */
+		top_range.va = 0;
+		top_range.top_level = new_level;
+		pts.table_lower = pts.table;
+		pts.table = table_mem;
+		pt_load_single_entry(&pts);
+		PT_WARN_ON(pts.index != 0);
+		pt_install_table(&pts, virt_to_phys(pts.table_lower),
+				 &map->attrs);
+		new_top_of_table = _pt_top_set(pts.table, pts.level);
+	}
+
+	/*
+	 * top_of_table is write locked by the spinlock, but readers can use
+	 * READ_ONCE() to get the value. Since we encode both the level and the
+	 * pointer in one quanta the lockless reader will always see something
+	 * valid. The HW must be updated to the new level under the spinlock
+	 * before top_of_table is updated so that concurrent readers don't map
+	 * into the new level until it is fully functional. If another thread
+	 * already updated it while we were working then throw everything away
+	 * and try again.
+	 */
+	domain_lock = iommu_table->hw_flush_ops->get_top_lock(iommu_table);
+	spin_lock_irqsave(domain_lock, flags);
+	if (common->top_of_table != top_of_table) {
+		spin_unlock_irqrestore(domain_lock, flags);
+		ret = -EAGAIN;
+		goto err_free;
+	}
+
+	/*
+	 * We do not issue any flushes for change_top on the expectation that
+	 * any walk cache will not become a problem by adding another layer to
+	 * the tree. Misses will rewalk from the updated top pointer, hits
+	 * continue to be correct. Negative caching is fine too since all the
+	 * new IOVA added by the new top is non-present.
+	 */
+	iommu_table->hw_flush_ops->change_top(
+		iommu_table, virt_to_phys(table_mem), new_level);
+	WRITE_ONCE(common->top_of_table, new_top_of_table);
+	spin_unlock_irqrestore(domain_lock, flags);
+	return 0;
+
+err_free:
+	iommu_put_pages_list(&free_list);
+	return ret;
+}
+
+static int check_map_range(struct pt_iommu *iommu_table, struct pt_range *range,
+			   struct pt_iommu_map_args *map)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	int ret;
+
+	do {
+		ret = pt_check_range(range);
+		if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+			return ret;
+
+		if (!ret && map->leaf_level <= range->top_level)
+			break;
+
+		ret = increase_top(iommu_table, range, map);
+		if (ret && ret != -EAGAIN)
+			return ret;
+
+		/* Reload the new top */
+		*range = pt_make_range(common, range->va, range->last_va);
+	} while (ret);
+	PT_WARN_ON(pt_check_range(range));
+	return 0;
+}
+
+/**
+ * map_range() - Install translation for an IOVA range
+ * @iommu_table: Table to manipulate
+ * @iova: IO virtual address to start
+ * @paddr: Physical/Output address to start
+ * @len: Length of the range starting from @iova
+ * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
+ * @gfp: GFP flags for any memory allocations
+ * @gather: Gather struct that must be flushed on return
+ *
+ * The range starting at IOVA will have paddr installed into it. The rage is
+ * automatically segmented into optimally sized table entries, and can have any
+ * valid alignment.
+ *
+ * On error the caller will probably want to invoke unmap on the range from iova
+ * up to the amount indicated by @mapped to return the table back to an
+ * unchanged state.
+ *
+ * Context: The caller must hold a write range lock that includes the whole
+ * range.
+ *
+ * Returns: -ERRNO on failure, 0 on success. The number of bytes of VA that were
+ * mapped are added to @mapped, @mapped is not zerod first.
+ */
+int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
+			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			 int prot, gfp_t gfp, size_t *mapped)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	pt_vaddr_t pgsize_bitmap = iommu_table->domain.pgsize_bitmap;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct iommu_iotlb_gather iotlb_gather;
+	pt_vaddr_t len = pgsize * pgcount;
+	struct pt_iommu_map_args map = {
+		.iotlb_gather = &iotlb_gather,
+		.oa = paddr,
+		.leaf_pgsize_lg2 = log2_ffs(pgsize),
+	};
+	bool single_page = false;
+	struct pt_range range;
+	int ret;
+
+	iommu_iotlb_gather_init(&iotlb_gather);
+
+	if (WARN_ON(!(prot & (IOMMU_READ | IOMMU_WRITE))))
+		return -EINVAL;
+
+	/* Check the paddr doesn't exceed what the table can store */
+	if ((sizeof(pt_oaddr_t) < sizeof(paddr) &&
+	     (pt_vaddr_t)paddr > PT_VADDR_MAX) ||
+	    (common->max_oasz_lg2 != PT_VADDR_MAX_LG2 &&
+	     oalog2_div(paddr, common->max_oasz_lg2)))
+		return -ERANGE;
+
+	ret = pt_iommu_set_prot(common, &map.attrs, prot);
+	if (ret)
+		return ret;
+	map.attrs.gfp = gfp;
+
+	ret = make_range_no_check(common, &range, iova, len);
+	if (ret)
+		return ret;
+
+	/* Calculate target page size and level for the leaves */
+	if (pt_has_system_page(common) && pgsize == PAGE_SIZE && pgcount == 1) {
+		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
+		if (log2_mod(iova | paddr, PAGE_SHIFT))
+			return -ENXIO;
+		map.leaf_pgsize_lg2 = PAGE_SHIFT;
+		map.leaf_level = 0;
+		single_page = true;
+	} else {
+		map.leaf_pgsize_lg2 = pt_compute_best_pgsize(
+			pgsize_bitmap, range.va, range.last_va, paddr);
+		if (!map.leaf_pgsize_lg2)
+			return -ENXIO;
+		map.leaf_level =
+			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);
+	}
+
+	ret = check_map_range(iommu_table, &range, &map);
+	if (ret)
+		return ret;
+
+	PT_WARN_ON(map.leaf_level > range.top_level);
+
+	do {
+		if (single_page) {
+			ret = pt_walk_range(&range, __map_single_page, &map);
+			if (ret != -EAGAIN)
+				break;
+		}
+
+		if (map.leaf_level == range.top_level)
+			ret = pt_walk_range(&range, __map_range_leaf, &map);
+		else
+			ret = pt_walk_range(&range, __map_range, &map);
+	} while (false);
+
+	/*
+	 * Table levels were freed and replaced with large items, flush any walk
+	 * cache that may refer to the freed levels.
+	 */
+	if (!iommu_pages_list_empty(&iotlb_gather.freelist))
+		iommu_iotlb_sync(&iommu_table->domain, &iotlb_gather);
+
+	/* Bytes successfully mapped */
+	PT_WARN_ON(!ret && map.oa - paddr != len);
+	*mapped += map.oa - paddr;
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
+
 struct pt_unmap_args {
 	struct iommu_pages_list free_list;
 	pt_vaddr_t unmapped;
@@ -450,6 +923,7 @@ static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
 	memset_after(fmt_table, 0, iommu.domain);
 
 	/* The caller can initialize some of these values */
+	iommu_table->hw_flush_ops = cfg.hw_flush_ops;
 	iommu_table->nid = cfg.nid;
 }
 
@@ -482,6 +956,12 @@ int pt_iommu_init(struct pt_iommu_table *fmt_table,
 	if (ret)
 		return ret;
 
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP) &&
+	    WARN_ON(!iommu_table->hw_flush_ops ||
+		    !iommu_table->hw_flush_ops->change_top ||
+		    !iommu_table->hw_flush_ops->get_top_lock))
+		return -EINVAL;
+
 	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
 	    (pt_feature(common, PT_FEAT_FULL_VA) ||
 	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 382596b70e394e..2ca62812b5a152 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -11,6 +11,7 @@
 
 struct iommu_iotlb_gather;
 struct pt_iommu_ops;
+struct pt_iommu_flush_ops;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -43,6 +44,12 @@ struct pt_iommu {
 	 */
 	const struct pt_iommu_ops *ops;
 
+	/**
+	 * @hw_flush_ops - Function pointers provided by the HW driver to flush
+	 * HW caches after changes to the page table.
+	 */
+	const struct pt_iommu_flush_ops *hw_flush_ops;
+
 	/**
 	 * @nid - Node ID to use for table memory allocations. The iommu driver
 	 * may want to set the NID to the device's NID, if there are multiple
@@ -84,6 +91,52 @@ struct pt_iommu_ops {
 	void (*deinit)(struct pt_iommu *iommu_table);
 };
 
+/**
+ * struct pt_iommu_flush_ops - HW IOTLB cache flushing operations
+ *
+ * The IOMMU driver should implement these using container_of(iommu_table) to
+ * get to it's iommu_domain dervied structure. All ops can be called in atomic
+ * contexts as they are buried under DMA API calls.
+ */
+struct pt_iommu_flush_ops {
+	/**
+	 * change_top() - Update the top of table pointer
+	 * @iommu_table: Table to operate on
+	 * @top_paddr: New CPU physical address of the top pointer
+	 * @top_level: IOMMU PT level of the new top
+	 *
+	 * Called under the get_top_lock() spinlock. The driver must update all
+	 * HW references to this domain with a new top address and
+	 * configuration. On return mappings placed in the new top must be
+	 * reachable by the HW.
+	 *
+	 * top_level encodes the level in IOMMU PT format, level 0 is the
+	 * smallest page size increasing from there. This has to be translated
+	 * to any HW specific format. During this call the new top will not be
+	 * visible to any other API.
+	 *
+	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
+	 * enabled.
+	 */
+	void (*change_top)(struct pt_iommu *iommu_table, phys_addr_t top_paddr,
+			   unsigned int top_level);
+
+	/**
+	 * get_top_lock() - Return a lock to hold when changing the table top
+	 * @iommu_table: Table to operate on
+	 *
+	 * page table from being stored in HW. The lock will be held prior
+	 * to calling change_top() and released once the top is fully visible.
+	 *
+	 * Typically this would be a lock that protects the iommu_domain's
+	 * attachment list.
+	 *
+	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
+	 * enabled.
+	 */
+	spinlock_t *(*get_top_lock)(struct pt_iommu *iommu_table);
+};
+
 static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
 {
 	/*
@@ -120,6 +173,10 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	int pt_iommu_##fmt##_map_pages(struct iommu_domain *domain,            \
+				       unsigned long iova, phys_addr_t paddr,  \
+				       size_t pgsize, size_t pgcount,          \
+				       int prot, gfp_t gfp, size_t *mapped);   \
 	size_t pt_iommu_##fmt##_unmap_pages(                                   \
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
@@ -142,6 +199,7 @@ struct pt_iommu_cfg {
  */
 #define IOMMU_PT_DOMAIN_OPS(fmt)                        \
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
+	.map_pages = &pt_iommu_##fmt##_map_pages,       \
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 
 /*
-- 
2.43.0


