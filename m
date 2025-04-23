Return-Path: <linux-kselftest+bounces-31401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2006FA98AAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889567A3D91
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E3F1553A3;
	Wed, 23 Apr 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eiX8ISg6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC49460;
	Wed, 23 Apr 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414240; cv=fail; b=aPYPIXmA/Ah8eHrVUskPKYxXh305rSa2i3BlDMgdoPOl1Xsd7BAq9qc66CfXqDi8jxSegCQk4oEQUTkzQN2GRsKXbfT4QEAJCMBognJay7BREkJoOHADcOLaGRI3zl60CZCg/J46CifXK0jNnJOHlZSxY9g8dYpBcrxzscneIQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414240; c=relaxed/simple;
	bh=p/88anX7iLqEz0D9mLE6RJJmzjpIyAcVXetFQzKm82M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cw8upVZ9AiIxWqszNkPUxhEV1h8U6xtSQjs8/KnKilpVjF9dj3jJjvU21Bt+gIjTkTZscMQeJ0qYfrnqD9MuODHnZo2q29Wkj44uTEwloElMe1tQFTMveKIjLRSvncHMCW/cslLAgMNJyB+y0XFx+0+HKEy7QlI87ptlnAVJXXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eiX8ISg6; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOuo2wgXhayowU+sVPFhkn+CYNl63B5lAIudb5fDjlViK4KF1qU5jcVdWXqim2zhDVkJN8tTusQ3nJteGW9s8Qg+8LVf2XMjEm3i3mAriufWz/WpZ/JrOrfm/gKh1Pa5w+Lc0R1KRrNIDCYUQBCM2R+71Ze5n5uBqleqqhVJHPGkSlp1Ml8hujw1QJYu+Hk/XVppgbKoID3fo0rkH9HrRKEP9RT0gtqH0dkIfYti/E5o4PHlcqTlS+cxKC1TrXjwzBU2BII3BHQIHeSjfoXhGMwn3V9ih/UCkExMI4UehyvNNlpgs5MHQIqfaWz2RsUMV1USrts22NZpePR4wVuJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXtC3wtI7SBv5JV413QVfjP4g8KRxMCRT2jl0139qIw=;
 b=aQPqw+8vwThjvhoXq4gDjaRxxjUtChLVZHEkyiKipn1fRYqouINyK2RU50rS8+1Z7J4cwG6APTfJYvx9G1BajYqjjjum5im1jr1NYHuJcDmXTKODSZL77eFMaQZZ7R9SE5iDOi+VLzTc0swk061jHzNk02q9dJu5ouUhNrUGiRYBv4SLFfIihiMOyYN5tlAHoM1SI13Qm1UrPhQlPJXf0yzpjXG7u9p7cF6JN1q5c0ROSQydWQheUZcMKcfHw15X3RkvLaB1Z1U7JW3baReJpNJXO7eMTSmQG2p9XEZXtMcdd/LUgPG3ururcWrktwHneSlzouJWTib0/8aBFGbx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXtC3wtI7SBv5JV413QVfjP4g8KRxMCRT2jl0139qIw=;
 b=eiX8ISg6ysOw6sh/FZpTLxlhLSLC9y3elrhQZhVGoR5HI/4WKtwxJZn4wxlb2cZaoTbFENWqKslVd1WkKlePJAU2Q4XrAB5xXx9XkTauq5mUD2P0D64ocvqQz73miHU0IBzC5g7EFHKqZ1C9uUvPqZepPhjW2xfHTe36nbmbx9aLYuzaaLCeq81GI8m6hDBSZsKR9XnTkw31/B6f2g5AHKH1uABcgSWtJqzyLAcZeRhQFnqDuzGIBTdhzT4WYdz7+5iyPfjMH6QiVn2IQAD5TY3iI6/g93ZyhmM9WtTNlTyaqdnh1oZQsVzIilBm6lbVhgHEDqotpX4rBpM9ZSkSQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 13:17:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Wed, 23 Apr 2025
 13:17:12 +0000
Date: Wed, 23 Apr 2025 10:17:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	praan@google.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, jsnitsel@redhat.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 03/16] iommu: Add iommu_copy_struct_to_user helper
Message-ID: <20250423131711.GH1648741@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <65b51f57d08069c9da909586faf4e73d247a54f5.1744353300.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b51f57d08069c9da909586faf4e73d247a54f5.1744353300.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:236::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 1139f765-d79b-42f7-7c28-08dd826928e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h/LXq2ZjkdIBUwpyEby1Ot5dwKMfkd632vDVjATPaTCCu6/3RXvOudBqP6nu?=
 =?us-ascii?Q?M4SETeID9uPoMwvRJFkZHIybb9KhN27svlpi/1q5Jtefxkd+vbAj2HPsXoyb?=
 =?us-ascii?Q?lfX/GWmLYFQavrXh5fHUZMtnt8J2EDeyRRHQ0klJshR/I4gqy5jB9Qdz9els?=
 =?us-ascii?Q?CXnhTZVM0rI0+SCsJZ/3J03Sv6F0fK4GzQrUycGxfHQ1K22RwuKNVU8vg6xm?=
 =?us-ascii?Q?tvSaFsYHtTDQjVtIrS9zs7ux3x5l+8kLLbsMY5qdRdf2oXweQtoomveih2HT?=
 =?us-ascii?Q?00E9Lkwr7MXx68tR6ogVpA87V3sviMjYvpxhxwYPibWGopX35uuUjWQbZrR8?=
 =?us-ascii?Q?CZYio3QHB5TNjgosl2RfoUGIipCvPxdKsv7WnaXnvl4Yyd8sYYw8p2wMG7vI?=
 =?us-ascii?Q?+GU/PsBleXQOq1POo1g+luyJhmlOK+f8rT1bp6nVwbAs89szYP9IuLbfqcaq?=
 =?us-ascii?Q?8vLdjY4z33gwPCzXQZugQGpWB1dcg2Sq5fhNWbrc3T0P7OnjnwJ22/BsBqcX?=
 =?us-ascii?Q?RXW3e8z5gYR9IbbL/T1L5NCCPCGlGF5MZOW1VfsZ4rUub3fimj+oHsC8IPCd?=
 =?us-ascii?Q?71iLrFqOZ9Txi1MXCR+Mq5io9eQvOIkgl8a9DCH2Fn+d0dgOJ6czZ10cxlaY?=
 =?us-ascii?Q?uzwX8UepUEfqlqRRkBR9yUP5v0QWUXKv7Zkcx6o0Si3696O6oLVha6WKL1gd?=
 =?us-ascii?Q?z+UDY3brxzUk50XBe+66Us/Rcbv/uBgfPRnZjM25sEQa6tbyPL1cQr0eLm7s?=
 =?us-ascii?Q?UqYyjcWvI++FevqtjJS0So3jxqNQLOLXaL9/2nvbQY7wjRgQMyb707KMi689?=
 =?us-ascii?Q?jcDTYCR4HQm47XdMbU1IamD5KvBisPpvyDlYz9QXLHQgKjmipfNsN40I3iKX?=
 =?us-ascii?Q?R6R3+Y+JjCpMzbn00tkRE5+KjFUW5n69kQlaHwEH4LFnmxI2uSEQWXKGBevv?=
 =?us-ascii?Q?ie2CYRn1T0viS/zVu5XLY98kSkDi2z9CaHPRAAcJslSRLebFkQoS9bPP5Ca2?=
 =?us-ascii?Q?nJ5e54hMQ87JDW0IOhOu0rbwqMLC9KrgBX+FDRWeH8Nt8SM2BRETq2B5MkHZ?=
 =?us-ascii?Q?r3scvIAkf0VXt5JEjfzLS8oERKiRd3/LBO2qgOm3UACm1n3rvyCgumF/CQPo?=
 =?us-ascii?Q?aLyR/eebEB0ZseRoN1COb6zE2Z+3ms2RhTyzxReiK6IimfyEIv1U0OJN5P0x?=
 =?us-ascii?Q?fu+gukmc4H8WsyCCcSgJDGDe2YULMXFzqUuoRpvyLslbG2IG84L7ZKs9lSiZ?=
 =?us-ascii?Q?JMlJTVkOe8NhRxbTR96M8L2FQjR0ygfTVC2MJ430m/mMoVT9aTtcf25vKPYR?=
 =?us-ascii?Q?jaHPlpFi1HNVK6skQoovqaCyMcDB9H7S1pA5S1Qy9BNpGpZry/yGEOlfL8FH?=
 =?us-ascii?Q?1tlNDAa7igcEWiKm7tLrfG3+drI7vf3ovuUtW/Yi5rC4PI5VymgSb27y+2ce?=
 =?us-ascii?Q?FVgt3UnEDfM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZfpBeyJnI/gpKx4rag/tpQnEjeDbedhuMEPO8flnXCSYa+UDninKhx5xYby?=
 =?us-ascii?Q?bfViqFqPYFdRWVlu3Via4XDp3qQt+xUMXT9DEB0cGwkMsdwwKXvWsSwqNUqJ?=
 =?us-ascii?Q?QOXXicdosuwqetRqw9x28xnZWDduCxlNzuGY01NndnhwFC58ixq1H3mXlUQx?=
 =?us-ascii?Q?a8Yn+OGgsJrw/6LedmwI0q8uPw+7Xbn4d8+FNI7IbQOjzC4bjPN9h8x6Xoa+?=
 =?us-ascii?Q?BBr4cqOTQhB3N5YfASIsucJQpmj9Hj2HjnBm/lrYxkbkEQI4EfU79qrURNqf?=
 =?us-ascii?Q?vKoCqBcsqpzHPrq+Kuz5pTcmWMYluIGpDl2mfKIhUplEyQBclEurVKgGs/Ii?=
 =?us-ascii?Q?SvAMZ6az+t2qV8N3GEg0tQfaGgVeAsu/1mjaCa6pehzT6kemW04ePv4psosT?=
 =?us-ascii?Q?iP37FgpheAmosNaYDbuY3jyf+j4H0TKv0LWcsfzhV38v8SVcUepdkL5Xx951?=
 =?us-ascii?Q?jXwCVRSV/rQYBJJODdvOgFK0R+UNy1lhkNhfWNh6XPmnQu+5od/jxJfJuklc?=
 =?us-ascii?Q?CYKsj2pQo/cNwYALfW1h/xJgaN2AGPKNVzGISEigholi59yi1pjR4gQaEzhH?=
 =?us-ascii?Q?8oiY/D+gllIMqNESIL/ZomonapnlSdPyZaFbn2IV4K7bPGX3GLEgMjTAZR+Y?=
 =?us-ascii?Q?b5R+U2AGy7rpw9mz3sYMP6prNgd9FH+uDtmjmHwCPEWePmsLqHASTizW26dx?=
 =?us-ascii?Q?0sXnlMJ5LwN1Gl56lrOF6XwknQ3pFLDTPDaIymHMqJUNsJC/2f3dSWOY/qc/?=
 =?us-ascii?Q?NXvI7nj5sq7y7e9w6FQ4QrYPkGInECnkskb3Z9B0037TB62LAdsGie4oeZ+S?=
 =?us-ascii?Q?GV6+pBmLmQHtxpyw8bht7rX4vPo3U8CJBy24vzLLaYfg98LOvPTeXpxAZL0o?=
 =?us-ascii?Q?iDkSJ3PswcgtTF2R5x24He3W2r2D2ekU1zHhVtg/jW191tdexHneMBpDQZnP?=
 =?us-ascii?Q?VeQgVBUb+DoGnpeykglOK1GXZpSWLqwKc07ItPArbQP7Ab2J9tJqS9IO3qL5?=
 =?us-ascii?Q?vWPPUDBVeGcCIECCRsLHRQzQWO/sF41t2GuOckRlL7QpNmw6b9uR1FQOQTa1?=
 =?us-ascii?Q?MPofNXSe05wufjR+7QTY37VOZAJhm/2eXkcZ+RScOlR0nB4j8rE1K3VcYfe/?=
 =?us-ascii?Q?myktoptu7ZBom7qu4Saz8Zplnjk8IhsI6MEib9ZI6p/J7674wIO/vEoVPhgJ?=
 =?us-ascii?Q?CGrN0Fs8gTS+o/4MTsgcv+SHGOlBz/k9o9vuSR1EdI2Ps1jZFxUJpyj8037w?=
 =?us-ascii?Q?IMYk3KfSZXrVuILBmUzGKjb2Heqy4CFZQGpoqryKlU+c3nATgmPRaVq9fso4?=
 =?us-ascii?Q?1bMLFKIxGID6EgArTUKRmaLzuiUGGIFMYKi20EptEnUPfuow+b/GhWa6+vVB?=
 =?us-ascii?Q?a21CSLx+cefOhjxb0xMovzQHe0o8huDc9qzkJJ3EjkltSyNnAkNBbdi80woZ?=
 =?us-ascii?Q?jjwvtauI61yxJFvWDeSt/kiq2knlYXiThzVd+GnCsD+Grzmu4kDCVNEaCSM8?=
 =?us-ascii?Q?niiuYemjYdEwM05HIDVKVATxvqjlr8zOqZ4yq1GbUC8nK1MYAyiWxr9m0/Bd?=
 =?us-ascii?Q?2OA4Iv/whz+XzLFnhadQyaL5ndPBDK7QlIFYE/pB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1139f765-d79b-42f7-7c28-08dd826928e3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:17:12.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buYjgT+17pXeojFxGG36ug7THE1TKi5cKl3Ifk1Px1InpgXu8b9Vf3PYJYxo6tZq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107

On Thu, Apr 10, 2025 at 11:37:42PM -0700, Nicolin Chen wrote:
> Similar to the iommu_copy_struct_from_user helper receiving data from the
> user space, add an iommu_copy_struct_to_user helper to report output data
> back to the user space data pointer.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

