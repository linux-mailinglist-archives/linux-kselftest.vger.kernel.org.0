Return-Path: <linux-kselftest+bounces-44837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22E0C3764F
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 19:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA6E189FCA4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 18:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A45335082;
	Wed,  5 Nov 2025 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTgkD0eI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7531353C;
	Wed,  5 Nov 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368712; cv=fail; b=FK3tHSXwWRfKoSv/fhVkcdoNeX87AUMaONONrSDT27jnH4jFUStWACz45nOJlUUA0l/Fr1q4buA5yPwvhmgisg0fcR2I8mZeWQYrBzXHPToeYMNHGEgAAznbfhVWEXKBnXw9+Ij93a+8GRAenBUXrxG5kotBmYeN+KXRJsrcMe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368712; c=relaxed/simple;
	bh=fYPfhqRDQwjcNt9eKM9oGkGmDAf6JYi1csBIm613gHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XQ1mkULitl4jCKWWdGP8X86B6y1xHc4vShMYh7XHhH4eUHDany1VKpFt92m91TVK6iobV0/Ug6Siuddvf9jYh13jP4P9lXhlXKynucUpxHqNF0YUsOOgtbfTJFyEtIBwz8EhVmHdnDOhfeSDLirAn/oTlgra2RHUlyprZCkZ/m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTgkD0eI; arc=fail smtp.client-ip=52.101.46.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2ClWoQwAJaOGJjfp+qF5+9TxAL+60awfw2vffAuQN4vI8/6RQhZkjPANg+IjcNhgZ0joBN1fuJDKZp9x263kRwFVuVzev4+MNPdK+lDVmCPlZUj0BhSBHTFQsuD+7OTpB6b+QGH11O+fKkvahtTIdT7238vH5z7RcZ1GSwH9Rkql2bSUmH3hJbs4rDubjjpJLDpG1pJ9sWwHrJ8unJmehK39FcdxjAu6kx6qmdoKpuTpGHrkSxX106HmyVfCAMouql7mvZqFrx2hSPuW+bPQDXVK94BzE9Y4p27gLxTytSGdMCH5OLL+G8tMI19h4zWO+VLRPvfaNtOGMnZMlmf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O++txz3vky9kgcjioTzqPix0QDQ8cuez2QLixcsp660=;
 b=lG5+Kon8dgTGg16yRzddULFo3Sf4oJzt+zo6eZElc6mOS/pzpQki7zTfqIhE4W72JfLgdhwoBw/95r7AccEf6wcjGvFhyWBcOrzeDEpJ+1QEj0i7vtb9pYLI72qatIFH755fWMwaWcGFgwu17eNIcS6mFso1CYmnm0NnAXBHwMn7MMKO3itbGoQIw47e97zttk59QUUhnAwDOhZiQ5q4t3FJwtjZQpZAIoDK+M1tAv05BcCQBEkQHnDaiGstPtj497NY+AvKj7IcEZ5jpsZS2wtFO+pkeKBNV8o9zBc260W85ZIsDeaAYFpFzrnUwg3iUvkufC3+ZqrdmDC+yoNhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O++txz3vky9kgcjioTzqPix0QDQ8cuez2QLixcsp660=;
 b=MTgkD0eImBSCb+oaaDoGvn2Odt2JjA473sn+AFR5m0C1scCeFeNmD1pfo4xL2Fd66GnyMvDkXK537q+/KVnjo0nIY0Fl/uca9BVds/NkBUZj9+hLvfZT6N2zTDv+vQCo0QvHn/IOY9Y1JUsBIfQHdus14IxO13AymjbIgxjaZ0FfECEC4LReo2G6HMcEzW4Mh/qZcaBJNZpw+D6wZa1vmiORHG3ItrqvjKHuUAqHRzCUozGRuG+0WHKy/xHnlNC5lO4eSmgxqqsj6ESQAuW2GE2fJ26iO8R4B/Q0wAtTy1oluleebR4pw02A7wSTVI3huU7kClew8w4eZt3ts+bp7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 18:51:46 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 18:51:46 +0000
Date: Wed, 5 Nov 2025 14:51:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v8 02/15] genpt: Add Documentation/ files
Message-ID: <20251105185145.GV1537560@nvidia.com>
References: <2-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <0792f0d8-0ce5-4858-baa9-c76154c9fc9b@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0792f0d8-0ce5-4858-baa9-c76154c9fc9b@infradead.org>
X-ClientProxiedBy: MN2PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:208:23e::16) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cfde15-7657-457d-4f85-08de1c9c5edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TP7ERz8KIPfEMOyB/2sxHDAeDtjp5NpgdsJI3mFr+ONUxM2dzOl6w0X6dyD+?=
 =?us-ascii?Q?HLMa34TdSKQ/LEPrX6IGqSBJxxFHB9edPKbujEWwsjhxo112hNGwd28U/uic?=
 =?us-ascii?Q?uCYkCg2NXrwf9LXRZxF7pCXJs4b2hxsQCgrE/lzZwQhdi6cuwF75ekkV30PC?=
 =?us-ascii?Q?R2bDQEI+v1+Loh+r0I7zpmIfjVgmtYdB9agft8k0p5QY/4b5sfe4+4kHAimd?=
 =?us-ascii?Q?1KPc30CJpv+ssqpx4V1xswILgwPtMapO/+XB5KHEyRjBqzWJmBzZy0NTGUH9?=
 =?us-ascii?Q?yAekwHy6wWU+nS8MY0N9bhh9vOWU7cp3XD7fw/SVNBTMvrXoXIbabI0bv69C?=
 =?us-ascii?Q?SmZKMNDVD6O09Z28x2buQ9t3cs+FsE981l1QTcbZgM89kXJvoBXiHInRVnPe?=
 =?us-ascii?Q?MaCE3P2k5e+tQykQhJHIYmREPWA/8TdJPnsU2U/TNH7Z2XWdaUmmgbqxCXm0?=
 =?us-ascii?Q?bXBPAdpGtlcTNBnPrJ1x3iqzNO7jTr1vCCELeplOgBfWJ3AxeCmW8FX0e5iy?=
 =?us-ascii?Q?vaUX7ruVCmT3JVtGd0dUGdfaKO0p9n2jmy/D+n3E8VoKJHqXMa9VrHPbHYO0?=
 =?us-ascii?Q?5gupkmt5b7LAARPSGojLn7hkpobliqFJK2CGCVR88jAqpISrduDXfqUxJAtg?=
 =?us-ascii?Q?gIvf1YMTsMIlGJrT0fKBm5KbBe70b0QyUGCHucynvkB7gff4ozP/Lp/lr8Cz?=
 =?us-ascii?Q?ULEypunCrPZ6xt8CU6ZLEPoMfPS+RXvN38e4i8eCKuAsYU7kOvW3dtBNty07?=
 =?us-ascii?Q?lKVP/mSYy0NMNxEHG+qPS9wj7tiGteI6KVGPeFbhgXtx9COxxPd0SJbQo8hz?=
 =?us-ascii?Q?RwxOvIgcBK4jFegXCOlSmQQUojEHgwzRVDu8U2gq/U9Gx8TlQEx65v3El5X7?=
 =?us-ascii?Q?8QmC4pMn/WAiYbsGSQQIdPpNLtnycuJ66coRnT4btuHkoq1phpw4gtkdcU5N?=
 =?us-ascii?Q?M0e+Aoyeos2pM58JEbElgEboPMGGiNUN5cneFVhJAMGnsaJswp7STsF7s5Pa?=
 =?us-ascii?Q?EMJLLaGORoWo2ogc4+JCQ7axJUmGcuRC38o9Dr+Ne+2TodbsFtQb+7ljH2IB?=
 =?us-ascii?Q?y+yTSqhkeg+xOTzMjYODEaXOHH6ycTYtg/Wwu57tvEzMUvZEoeMVCJSJIXP9?=
 =?us-ascii?Q?DbErCK5hbSs3pVVm3JCNC6X0OmKQZChjmyv1S5tS6rj+Kd0skNADFZa8PTHf?=
 =?us-ascii?Q?e+hB1Tqofb1AhBNFntBU8Jb6xgkNOKsprtRFTLjZkYyS6pcmiKSiPZsfXivh?=
 =?us-ascii?Q?j79YB/LpOaM5akQaq3BVlIUltsc+1Rn18/Ua4NWvbqTtIa3B5iKVOnlE6Leq?=
 =?us-ascii?Q?0MKQUDguK2Y4D0/mlBpixpS7eGTxkkRVqkOMO4HV82DD0lkwUaa6GCanoCXQ?=
 =?us-ascii?Q?4RTm58i0tV6BOuDpiMRblzL0Nc+xP/ZV1zZrOlvX5UmMmJPMON7duqAuB22T?=
 =?us-ascii?Q?6gREbaEIaUErJ7gCRP3SObFyIOarLkhY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wPylVx7dZAeIK4VeH6F3mc94jlyQjuryRBf4Ffcju1/amiqAuWD94CnRX3a9?=
 =?us-ascii?Q?9oYpvGF9H2n7YG+QfUfo0hdDi3RF88nCrJTyJ/j1kaAnPlJP3pGW52APOp2p?=
 =?us-ascii?Q?c44hLMIpyXRbZdkqv9HeyFISIZ9YzBtIfJ16gpkU+g2ncvMfXe0ul/v1e+ih?=
 =?us-ascii?Q?eP6XRrukeexqSGCb0AMi2L8SZU+icRd8JcbM0g5uPoM6qaV23ZSnuy62IwPr?=
 =?us-ascii?Q?MSVUvrYKLP3HDHZhoinNkQmGwbazXhJ+5dTmYIfvYBfO4id3f3+4WrpfhXnw?=
 =?us-ascii?Q?2eZph53udukLWYl5BB/3A+EWFSHmKWt5JKvTT21dVPjS7AUJr8aWDEAUZyqL?=
 =?us-ascii?Q?q8oUawnBro32Ludc6jFBWvWNgTKk5uqdzkjem8dCpYRF6CiAj6ruLyev+ye/?=
 =?us-ascii?Q?eFn7xxlvT8eQca3uvgA6r1XwAT+pskcz3Ycv09j02Qti0T6pf7a1eIMGKIvM?=
 =?us-ascii?Q?oJri1A63DKOBU8i/6l9IVNJDYksZESk2Tr5I18vVHkDhhzt/0uX4sdmiTjBO?=
 =?us-ascii?Q?Q8nNz9vUAlhI8NvoDzBGE297fG6SJswxuykvrZZswj8PQcim51LYbuHmQD1m?=
 =?us-ascii?Q?+KhNQDxxwdcQoA1cjXgSsm0r+QV8c6fk6hi8NXzjkM3iksAkD+W/NFjFrEtb?=
 =?us-ascii?Q?ZZJ5wyZXfJvwEbiIRfc/vkwtujWESCr6Tjk7oOh2CtWWqRrn9K2EW7xVe73N?=
 =?us-ascii?Q?EbgSFmU55bBCmUbERhc8Dih1Hxyq0GvLhpBquvTAVRCk+KaQ1n6eenznxlUm?=
 =?us-ascii?Q?/NxexDSD3411fwMQAZNeJVzqnNl9LrydDPfq80sNNiON1vq2+QhyDs3ytZBG?=
 =?us-ascii?Q?ltIPjJP8+GldjpavOAsgVEaYvY44WPeT5Hu8g1pkIdDPcfKFPLzLqogZ44Qj?=
 =?us-ascii?Q?H9X2dYdqjiBio+YWwrJjcf+44iR1jnFrzMtmOqQLX5h5+P3C806fdD5nHxSJ?=
 =?us-ascii?Q?gO68L28uHCHeXB4PZQQ/odY76MeECJuTqj77pKID0PHldK14OAkgfjjlA++r?=
 =?us-ascii?Q?6Uli0ezpsRGnScnNermqckKNf6J3l1S7T7kF8sz0HQEhL+nI35iKxdjghZEj?=
 =?us-ascii?Q?sWuqQSdTb9EtIsOJw1hB2xMVq0SmwgD22AWAe4qbHHaGDptrmHUuuC+wRbQf?=
 =?us-ascii?Q?FrpKovpNuKulfl5izUAbRZL4GGVPRQ33h3LVTFA2n/IZqfwMFKNCSrML56Re?=
 =?us-ascii?Q?tz1eWYij1o0JgEWEjk31Rfb+eQbgLnKLraj6poIB9cqMHfcxIMCF15wdPp7F?=
 =?us-ascii?Q?ty7Jw/A6idtCdjp+bN0MPE9ipIhciDYRf/9t3I+lIEo7TSbtN4MQaWX13YgK?=
 =?us-ascii?Q?OpxIbew7vIjomXDz6U7J9pLzq+FLmaG0tgoGyewB9Xus4dfSG9ArP3G7u0LQ?=
 =?us-ascii?Q?s0MQPn6mpLE7Uk0rWz0wjxTNXRuNoXMdqbliU7MXOXirtsb2YfOW8V+nTpmG?=
 =?us-ascii?Q?606VQxg1yu/WmVV7qPsTGznXP7hw8YGzfmYft2xQ88TMtMA8Oiv7HLQKzLsj?=
 =?us-ascii?Q?sl4VI6hQqtnNrEgPhjAccacaYnJIXOIDi/0lQpBwReVyIHtM6RlgUXYMtkxV?=
 =?us-ascii?Q?/wSRxHtFxH4QRu5g/tc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cfde15-7657-457d-4f85-08de1c9c5edd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 18:51:46.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRFBUr68m7PoEcKJIFU5Y6uR1fJJVj5O0X0oHbXj+QYftwgnp3Ss1GpzPrxoUIrp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979

On Tue, Nov 04, 2025 at 03:49:02PM -0800, Randy Dunlap wrote:
> See Documentations/doc-guide/sphinx.rst for the usual order
> of heading adornments. Section beginning:
> 
> * Please stick to this order of heading adornments:

Okay, I think I got this, it will come in a fixing patch

Thanks,
Jason 

