Return-Path: <linux-kselftest+bounces-45025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC977C3D1F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 19:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00A61895EC0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0A8351FA1;
	Thu,  6 Nov 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHbxpbbx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347543502AE
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455500; cv=fail; b=LlKAbEcGBDxophojd8kmpaDnU9iicbJHHKcbeMGkac4WiUuMQZaoDRPMPxmpeJmzFf7oZiPmLNh6M3OFX2dh3SDDFCBfPo7xOyDICPFqQ/0xpi+GMQCqdEPFUed/FlEYDAypDICRmJWydtqQ00UJjCRpQ6wXDEmpFpWtEr4Qo7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455500; c=relaxed/simple;
	bh=SrLaM29cQvYRT7r2/ZzPmLpEt5FyF8pTg7PwJfUVIbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JO99o41U+2Qj1WHEcHKWaf7w9YoccertEtZWV3OB0F3v3IaTTcEXSyjewNZqfGONqoR3TVLNcmTiRySX+5aCUHuSPL/VJQECgOdpWdV0AUR8QphwvJir7umx9NCc4duhCnDZdOjBUtbNa/SkMtszSWc6lZISpPNTjugh3HheHbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHbxpbbx; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gbqb/cS2fQlgz+A6nOZ9amjIkB5CKLuAs8T/MKgjHsFJK9tqEZz7wrmexuBwO3tsEaJHm4ySqmpUDvDVko/Y4XkRQeqQhslBlVtF+W/GkCe0KtQA2pxVtYNUmUr9JJ1dsyelQFubgS3ZlQvq9XGbErELoxspgOMX9Ufxk8rU64ZFQjC1KK3KTrTM8Eg4Q5ILd/rMe+3EkXeRCc3R8wGvvHNIBt5p7s2YNBG1E9xqu/JYx9yiamI568dNI793Tg1CDTKVV7GDfTlai2txEJh7MLTmqWLLvqZ/dIWDO4vgRf7GkfV0nyPl1wDXnD287YrZDdqPmIdiEZYHjRHHEkNn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nj/FAF1Xh7e/ejzXQnfgs5tBjrBodQedyhkzBKgwoWI=;
 b=R9bAGVIpuZWG1viZ5iBbsXIABVR56srwrQC2z8w0NozfDK2jLYuVMAKj5fFgkJzRe82dUYf+yFpInjnmYJqpzz6S5ith8+L1NTGshheSxDWfipybeXpKD6U7yDkvnf89NsPzlrzXfX/aEtcbHFrkZXBh0PfLQxPeCTk1RcGMFLoHbCd6SZSQwwhFRxh6z8ilcovTB3j+xncGHfWsWepGrl0FR5Bi44iPPdFP8ca56c8N3S0eWB/iHTtZs0z09j2vakiIaAasBgkO9hqUn438XfJ8JB6YZ/DZlT6ls5mJ/yHzgS0OdCuaUAcLnw4b85Rvv78ZD38jmA+NQMs6yaafHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj/FAF1Xh7e/ejzXQnfgs5tBjrBodQedyhkzBKgwoWI=;
 b=AHbxpbbxBo4hgdkOI+PERv2hs00ZFr2CJPGkk6KNmFv+jYNOUXaBRM/MLPjqorAMs1sYTQluF8jFWtT0BePkhSO824APDisxhkACyNNWVmVIGiB5d/gCH4NXWbls17WZzGWdzp4OTFXX7LpxmMrwMyUf+qgXVLQWn+tL4kz04YzO2c9qiqilaGDe+jVOTkCbWlONGlHm6J6T31Q564QAl5qQ10c3jlEMmbZzmXTViNcZFu3YOlLphFWX3F7ab/KBoxZkv+IlX5trKoZW4AsTA92ZyMnLY7gSt7uYMWQ2jergvLLdw6RRx6vHtfUQoXea1QRDYfHO+RctYuzd7CXioA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 18:58:16 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 18:58:16 +0000
Date: Thu, 6 Nov 2025 14:58:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: Re: fatal error: ../../iommu-pages.h: No such file or directory
 (was: Re: [PATCH v8 09/15] iommupt: Add a kunit test for Generic Page Table)
Message-ID: <20251106185814.GA1708009@nvidia.com>
References: <9-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <9844d4cb-f517-478b-9911-b6dc1a963b8e@leemhuis.info>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9844d4cb-f517-478b-9911-b6dc1a963b8e@leemhuis.info>
X-ClientProxiedBy: BL6PEPF00013DF7.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:9) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a6b0da-2257-41cf-e91d-08de1d667169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lMuvcmWvRmfYvZCd+qha4WKtVXoz5/Z5dDaFBtGHLVEh066SH9qLmphsryPs?=
 =?us-ascii?Q?UDvSRmMAzAzrLX48HuggVIvW73NJPJfB8z+gFGcZFxEI/RFFfXZDfpb35x8A?=
 =?us-ascii?Q?84Tr5zSK0gtidWqNuwLa1tPLyWiJ1mXjKUSeUWIb7UgkccvdJKfA1PKkwYua?=
 =?us-ascii?Q?ssnqsuzSmeZPZ0A0XALhf7B8kq2tpfGTqoXmENR/0hZYYsfI79UxWTrcRYBf?=
 =?us-ascii?Q?veMPSfwVReBGklhvD9DPzMg78/JTSASofjeF4en0/OemgHc4WC76NkAiMueV?=
 =?us-ascii?Q?ljkFSW3YodE5WvOU9xm0f0yYNJZgb9bvEfsqNgNx3AZRDqkFK9nWmnTBmGgn?=
 =?us-ascii?Q?eQR65+JwP0ZIiHGwvgk8AjWomAyT4YHEi6VKll0bTfldMJZQiWGum5hY4G7d?=
 =?us-ascii?Q?H97eFusb/xSkC35Scy4yuBzmwjBcaAkpAVTg7/Bi2EeJXW7NrF7M7oU9NAfc?=
 =?us-ascii?Q?QFmfP+2eBn2P4mRZFiyGyZrzH5AbnU+43t5SWhVCc1qQQI4PI9nysx+O3VHM?=
 =?us-ascii?Q?McrtPkgF5GJZUYHrjMRI9qjcn4XpF/ilcOExQtWUvwp581BTVqdxTFEvoRjg?=
 =?us-ascii?Q?k/85Bb6RVwTeP34kSIvfkJZXq7g7iE12HnI5k/aai9eKOrl+Z1WLISPHSCtK?=
 =?us-ascii?Q?xXABkunL7MAj8/ld1DzPPLk2o+rbvgYz3AHqJRlPpLALFzpnvqGsUKmB4byX?=
 =?us-ascii?Q?JoDw16xdnuUoAOBYEHpF+3yEiiGNLoI9ZsAT+DkG7j1k9sdIB+FT1x/lyOj5?=
 =?us-ascii?Q?O2pqbtHOBlIl0fQMOabJ4zixDk2vkYV4UpRPUHSTQa1CH1h6fDbpPtp//iNg?=
 =?us-ascii?Q?1cf6AzoOReddLP6J/xYrrr0+USLPb6MyKQwiR9nupNHgV1ssmdomtblB0nBL?=
 =?us-ascii?Q?UbWKmUaowi5wVMKxhz0gzIl+o52OqGDUbRlUD6tXvq5diFYEyS32TH1T228o?=
 =?us-ascii?Q?Azznd38X3crtqga/8m5Ygwnzrjtgaiv++GqK9nODSiaW6T4/rsW+Ac5qRWn6?=
 =?us-ascii?Q?h+FK4KC8oU/A7Zbns6TuvCqmtbSnp+bL4eZ/6vYvDRSaxFaxRa8+OjKa6/U4?=
 =?us-ascii?Q?Jv4EpFbt2gGjuYJHP5uqbMeASmgPPnc/nzxHNRxeMP0JMBfXeAMpCMx9Rh5P?=
 =?us-ascii?Q?F7vnm8u6mvTCrPzo8pFdC8JxgFpmNTab0Sje3IVGa0PxLDippV8eokuNxMug?=
 =?us-ascii?Q?Bf7M7LYIVF79S8GIX19C4ddImrH+/0wfFu+gezd5ehqGso/gJBU1sLDexRCM?=
 =?us-ascii?Q?jZnIiTwmNix5NidBuee7LKoGX9iENAQ7VSd4g/J0ltIMBUGvpsOKMyyVzPad?=
 =?us-ascii?Q?ZNUtXnjbIlX5kxmDr7sVoasie69ikCjcCAb12z2ZbfVJb/EYzwV4pweOFgAA?=
 =?us-ascii?Q?lrYG8EjjAXBqMfwOcsQBRNlIVjGfRWH8IWHAbqSn7udskdrx8NRBWWq9HauP?=
 =?us-ascii?Q?UwFyoc4i1SJxeM1dOCypleSg60anAJCj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ib6eVH3Y+tAImH5VrdSuoilM4Mh0lnU3QvY4qkBjO8MJNPEbyQnDpAb2oADa?=
 =?us-ascii?Q?YTBiwdh4jCwrbgxNuWzWlCEnNCJKX9AzY5mcSUR7FiSuIWf3Na9ASp52YrMp?=
 =?us-ascii?Q?FBjvWDR06Rmx3sn3St+CJcKYroo3E1tK/mZ2apxIoly0m+q/7udRv5R7yb8c?=
 =?us-ascii?Q?e9RXJhkmOG7PIb2bL2yBOXdFq/BYwN4CL6GNBcttud+aD79F1dfNbVn6ba5q?=
 =?us-ascii?Q?uzsQt6jC6fepJ17aPhszUlwPvBSBYhcF0zzXmBW7bMV5zECz3Z9Kn1DNq4iA?=
 =?us-ascii?Q?NcHp/ICVFz6SisHPSQHMTHFfEjK5yZj0PIwLuGg1FB91etzIcx1B27DjBRl0?=
 =?us-ascii?Q?4Z2igtf7w59nB238nwIVKd1QIoqHnKkcHmRy6XbD5kpUKX59y521X1rPnPyt?=
 =?us-ascii?Q?N1Z+GRWy50T4tRmo0hT7y0iSxjbbSmvphBqQjkKVZaPWykfdB0LrE5cIFrTR?=
 =?us-ascii?Q?JQRtq5LucXxqU6SOxEHfQrZkXa5F8c8diDFgLKmesb8W5RRo5gMcRjqgyIZC?=
 =?us-ascii?Q?c/SUxmTuob02239n9qnVmxA6mUxIH4Zjkfup5iweKOggl3vFkLQaNO+0qnzz?=
 =?us-ascii?Q?OElE0kKvg4rkYj4tle+HibG0DlLxtAu/asgMmT+U/XAKxAY+dnHAgK4JHhBq?=
 =?us-ascii?Q?V1cEc1abyEiuj0MsAYlwGqwqgyUoRzIKYJcmczSEGhXNDgKbUig7Zq/0O24g?=
 =?us-ascii?Q?3Fq0/KJ809ukKxojW3Ab9MHPQc+3qknMJPiCdXomwU0jIm0TSibnJdbUEkU4?=
 =?us-ascii?Q?Cd3lVDraXbgKGHvpFpFXOABB9vtKbBSqoABdhljC2wa5gqGIskfiovGs9Hih?=
 =?us-ascii?Q?O8Bw1eVGSje4LTLZX61m0tDks+yVZuieUd+MjuSWCGzWwQ4x5xuvTC7IBpfY?=
 =?us-ascii?Q?Ujt7ijLOvR5UObhwc0ywyQ6mNLxK2A2MjYptnA7+jyzlTwR0bKl/7xIUL242?=
 =?us-ascii?Q?pqhLuxIc54F7YZgEQW/bW3gbkFL/51g6SE6jVXixQ98lVbRbaSOfT+6XW9oW?=
 =?us-ascii?Q?g0q553aO1hLeF5eVgXsMArfuPtkDB553MV9YfHJYXKQ5aOS6b4MQBM8f3ejm?=
 =?us-ascii?Q?CEnxMMxTpWigbxFQN0t+sMwUTbcTowvREBEQKo0TGlfFN3YZAkiqxNktKG1C?=
 =?us-ascii?Q?z8I5Bbo8QoC2TwoMfP6xTZgFT0yeCPOhstodeSbTC+htup6JWN2O3F3vZleV?=
 =?us-ascii?Q?ZCWufEI7MvZsENAYIV3cVbapbgxai2Z1942nGR+s9NDHvE1OlqDTGSUa3CXI?=
 =?us-ascii?Q?nmS8PFE8m3EUVCpf7pSYlsFwSupzEwdUqIS6usZtoWMgYMK4jlrO0DYC+QZp?=
 =?us-ascii?Q?R6BrfNXqJbUpjt6lldcgWeurbfJc7RvobRhI8UHJc1kl35ZGmvY8vs08jX5i?=
 =?us-ascii?Q?9GH6iUfJtD43fAN4IsL0ESUMWLOl0WvDOfzb2Du5rQjosTrO9a8TbYql3lXo?=
 =?us-ascii?Q?r4fCgQuD+EdDSHPlMZZIlgMaOOTTtFygaG7WLk14aVQv9Quhw+PQovVD5Ahh?=
 =?us-ascii?Q?zZ1Xh7exV5nk2NqCPyU8zhzX5Dah28X9IFnVBKperyC/CYIJCpvl3qocil1F?=
 =?us-ascii?Q?ZzZwYCefL54h21ea9qQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a6b0da-2257-41cf-e91d-08de1d667169
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 18:58:16.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjBkjVI+8R9419wYvxnOn4yIcde1KE4V+hlBBtUFQ0BAwyDSqSXCw17cBxvH8Tdb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232

On Thu, Nov 06, 2025 at 09:06:51AM +0100, Thorsten Leemhuis wrote:
> [reduced To and CC a lot for this reply, hopefully not too much]
> 
> On 11/4/25 19:30, Jason Gunthorpe wrote:
> > This intends to have high coverage of the page table format functions, it
> > uses the IOMMU implementation to create a tree which it then walks through
> > and directly calls the generic page table functions to test them.
> > 
> > It is a good starting point to test a new format header as it is often
> > able to find typos and inconsistencies much more directly, rather than
> > with an obscure failure in the iommu implementation.
> 
> My daily -next builds for Fedora broke today on x86_64. From below
> error message I wonder if it might be due to the change I'm 
> replying to (or some other change in this series) which landed in
> -next today:

I think this will fix it:

--- a/drivers/iommu/generic_pt/kunit_iommu.h
+++ b/drivers/iommu/generic_pt/kunit_iommu.h
@@ -8,7 +8,7 @@
 #define GENERIC_PT_KUNIT 1
 #include <kunit/device.h>
 #include <kunit/test.h>
-#include <../../iommu-pages.h>
+#include "../iommu-pages.h"
 #include "pt_iter.h"

I will send a patch, not sure why this worked for me and all the build bots..

Jason

