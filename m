Return-Path: <linux-kselftest+bounces-33085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 195C1AB8C01
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB46D1BC4D72
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F821A95D;
	Thu, 15 May 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzMyloEI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B26136;
	Thu, 15 May 2025 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325585; cv=fail; b=iAdaBNIVVwsRwDzlNqtQGCodaLwR+cFEIhQuOnUdkvQhJb5n9Gvb2BEjSJmHzbuAj35weaxFv+4H0zoCX6Qk1ih1VSlNobPS9fSWSC6YKHc+CuVy9bzz6jYiahAKWoqRm84OiqoTksz1otlbuoKwdFYYrh5GAP7IpNL1ftt8j9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325585; c=relaxed/simple;
	bh=c/VpsqQ3Y+jfHQdD8mPDjPBLD/ITrb2aqkExuYjFwmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZA9Po0F+o5tGavMY2NvbGYid9E1eoboBs2ax5JiNwpcgNTXBCjXLYggxIC2CYJPPoFdvVQ0aiKnXp29IKru4qMXtaPAMYQbE5Id8q5Ko9RIKmci2z3v4wygZJyE7wrFHk87zedpXPtjm2tMEP1vkRFv7uOVk964Xru/ekqS3xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nzMyloEI; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRcRilOJEGyYdzuyh10eISFxIDSQORKHdP+MWEa0ADedbIukFyb8KBqnoU7m4G9Hsi4rCQnKkVgXOmaVpCESkPar5xOMQGu0GjuUu7GkKpJuMsWu60WfgamQYLkAp9gH4r4caPyBOx75RLtf5Fa0r4MSU9N8hb0Uj+YaVs/vkb/0ivt5BK/3aci/fGQndmqZbqAj4aARSwzlA9H+Oj6nEEH6duNuOq3EjkNrE5Zaba8MrBC9Re5JZ5YB78xSpsmrqFA/GOQbhPbmWsPkZbs3foL7oXsaUQuowFfowrMqYLuFPzD6JkCudQoUFbn9JNPZfQZLj9XV5MIeGnawJ1VQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zbZqR4goLgTSVRqHdKV02J3yiLXaNsS0dmfi0IcWZ4=;
 b=bI3Qoh+dXYhOfI3w1K288TNeH+vAwijKHWzL7eiJRjJdQMsmJt/cd9cjh0g2brvwSmJuGP5N2V4C635zOcN2hq4D3hgtSoiR9LA8f7Zgc+yKUs2KeeWQd/ABvaOl3yN/rIp1vsmELtwvNdRkZ1oCsaT/Rq5dXyFwoY2jrtvJg9s59zlAScI7yBXVsnclyrkFZc5C6A6B+NuZ8Q8ZV3oxZJ3c8AGivnOW5813JbCMTm7BVDNXNk2pzxBzTT3V0O6hEY54XUBaeKnb7nRi3GKkCBuTMpm7s5RLIuV8eIS1ksnrwW7pYoEVY4555RqMjY55kICeflG8nlo1pdUC4r4/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zbZqR4goLgTSVRqHdKV02J3yiLXaNsS0dmfi0IcWZ4=;
 b=nzMyloEIIqzgeAKQrpPBVE+2fubA5v7Lv3LYx8LS7dl7i3+YIDrIth04rgF4NZU18LqJBAGQii4ZxbYH1T2rDAhtv2df60Rf4ggsQltUMAqbohL9nUq0SfFMHJPbI5F0C+BYCG+Ea7LgZcau74C4h36JJVCMB4FghLr/ujW+nXwSbhQ36uPKOrP5aCoMAy3mPopHwVUILVLdfA/LMLa3qyXBWIIbTOqi+IGpvh4Q3Kyuaqo5HMFCHJQ50EGkVCUFbFervfbo1Xp4rzzmg/3NBt0FHh0b5Lv12A5iP8RmhlldAO/kx/3jxPKvwoqHW8RmNv5YOu8AFR/Fs8VkwRj0sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 16:12:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 16:12:55 +0000
Date: Thu, 15 May 2025 13:12:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 12/23] iommufd/driver: Add
 iommufd_hw_queue_depend/undepend() helpers
Message-ID: <20250515161254.GK382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <3ee7d54d5368ac59822da214000fb25273de0508.1746757630.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee7d54d5368ac59822da214000fb25273de0508.1746757630.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQBPR0101CA0344.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 29838ecc-cc01-4b8f-e98d-08dd93cb59d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pMR4p8aOaEJTnuizE0ZDcAvlO+bP2z+igqboal7XZ3urYEbkLoXZ7vXNfx4i?=
 =?us-ascii?Q?jwVFW6+IbxOIiA6ZR4gMx3mdwkcePyMev4NcOHGHarOrqxMkTfU7ZObrutwn?=
 =?us-ascii?Q?AMWtQtxePODaWmNQJ4cik/ZPQz3buu0CGoGaqfS9p/NCg83JhlhsSNuQ2NaK?=
 =?us-ascii?Q?CEo3Pq6DhChWTCKs3dMSt7EF46I9YdduZRJPm9R5sHJW2IWn3HiZuij5UG7/?=
 =?us-ascii?Q?vR4odu0x1OaTpkLAzTf5K9hjeuLxroQ6BZLCfQfK6FY4E8+iSZAVcofDO5BV?=
 =?us-ascii?Q?nfyZuIDF/W0Aesgxope00MqRprFAsT3y0b8w3vMDuXRCvB6usVbwCiZrChhZ?=
 =?us-ascii?Q?NEAvKJ+4Bt8UPA3Su7RIgIhaaF2BEnw6PYddNPStVv77FJhr1hHhDSYPJvAT?=
 =?us-ascii?Q?nZmENXkHGGd+LK43HHN/2KfCHSffysyB7h6iiGAgzpjQwM7DkgHMaGRlxmQV?=
 =?us-ascii?Q?p+WtNLcJhNJamAHTnUXXpIo9uXcKgGwMRHVllN1G3dQVj/7fsSasl8m+PoVs?=
 =?us-ascii?Q?dclFP+tV48dqF5M/CaCy7zXoW5sw5K/m+39BRC50XFT/JmvK61uKPLe9rWtC?=
 =?us-ascii?Q?8GjLMgxDfH9MlOB2udHfKDvZSPZFf+VWq56VqQug2y/JPgo0LEg2leq10g5M?=
 =?us-ascii?Q?I8gDyFXlI2OpRo2qGezR+dBEWXBukPbb2ck/TZAxcg7Vf/XwrVwIXQhpb2JG?=
 =?us-ascii?Q?pFYW300TA6TK+juXQ/TYGI6evQKBAxSoleYhFDkPnXSUixribin5LZUn2+nV?=
 =?us-ascii?Q?4f5sV4bzQcWBSfX7P7rL5ElasfjPxLB8k5JGNFwTEP0v5wkVewz7BPKgFErr?=
 =?us-ascii?Q?rdLaiacgVppjC4hxA26B94hB1nIyFkzfUE+iPILTFKFO19b5POmquNqTzy6u?=
 =?us-ascii?Q?O5DxFp7FUudXMN7sZ1k2wR6jMA5Y4OksT5sX7zwFAYdel+breacFdosFvMng?=
 =?us-ascii?Q?X1LzmA2f3vaqzfrv/sHb8nXfPLYKk1Sa3f2h/4iItAC/CMenRe3sllA4Ype8?=
 =?us-ascii?Q?lU+2NaY1OmhsQ7Fcrzbmw4yVyvvf/p7ZIRchDq34IC0Ftx298ygSeBYuKcEV?=
 =?us-ascii?Q?ar6gfh46nXULEqPofR2FT0t3pRthu4TMO2UTToPE6olFLnADpSvGB+buO2PS?=
 =?us-ascii?Q?wE8NmskHqov7G9V7ZI+VAgGvVrxnvVHA1DpZYSyzcMI0jxhNAfy0JYjQdEU4?=
 =?us-ascii?Q?dp28TVgW2D3j+ruBUrqeJM/W8O9nWMH/yUJ62WJR+Eqf63GB1mYI4YK8h1tb?=
 =?us-ascii?Q?9rUEmVAE+ezCBJDWTHzkoTyAKq2xVDKDmBtNLXi7QNCfIw5+J7/fBhiGKOL1?=
 =?us-ascii?Q?I1TyKmG9EoSSh1juR26xQ5QmCS+u0ZGEtne5H8ZgExGAcIbzv77kBsgkY/t7?=
 =?us-ascii?Q?ejd+CBShJ7cDsVYO63kOe5RgvUehQ7lDZIyMmw1OyZTqRBDD8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HkqjxHZWXWs3SjzLLuY3Hmzp8nKXMH+AQvnq8dud4Bk/KLvYfDZYBahOSIQa?=
 =?us-ascii?Q?RKPmDunm9/ktG9n4PIApPzMhKvoDmeXsrHvlM2SgsQPNmO7SIuALGplkEuhp?=
 =?us-ascii?Q?Gdav63a3178KKcjo284x2/nfswQQ1h5T7NBrb/9OxsI8TA6xqF0XXuJXVijA?=
 =?us-ascii?Q?QAABgdsuC2Xxx8OrZHfhkB5GpC3Cx9pmnsJTjNPYPAaXsJhHAfYKjDEySGro?=
 =?us-ascii?Q?q/vBpye0qOiQa/Prf/w8wOoK4PSW/L/tmZgo/Q5RplRzohj+k+sGa6y2hRwC?=
 =?us-ascii?Q?v42Ebp9kPwcq9zjHjUf/W/amWky+kdvFChG/xcDrYtCOVR65XAp7WAMwgmuF?=
 =?us-ascii?Q?9TMiPFeWIKtYbYdP2koDggAjHG4ehKb4ypuzb+PDvCdRCfRdqTqnVqdDtCIA?=
 =?us-ascii?Q?rOFUeJIV5ohjX7gIYl62R/xY1BkGVrYxEX06p2aEykEzASh7wicQCitmaU+W?=
 =?us-ascii?Q?myZhMPmpYlb4jNlK2vEnA3bloTAHvPlmPOtTp31pMJvMrPjUqzxEdOCF47/i?=
 =?us-ascii?Q?uE0laHzxQLgFyn3VQbPcGa1LqEAhan/DP60/r9YPR66cRKD9mnRri9atwSX7?=
 =?us-ascii?Q?aVG8Anq2jW0v97Y7QT/5X1FCtXCIOpZu04hbo777LTMN47rukSwp7KUu9vsx?=
 =?us-ascii?Q?RHe8wm/g8oSFi9OyfLOQu7k3mYu1W/XRVYoDDdCWoA80ND4D2fZUtXRHzUFo?=
 =?us-ascii?Q?cBwNBeDic83xt5sfwnI3jfwVgHv7Au3XwUXn0wnEaaeV7zwS97LSc4dxp9e/?=
 =?us-ascii?Q?CbF/jnKclRBORF3aSX+GJS27DLd0uAh95XJ/Dm0FMk2vKyN3mvbIs+oVbbcI?=
 =?us-ascii?Q?4a3mhseR86cXBcUJ3lSttwbnbxoDWXn8FD0XmBxGMTxh9Io6s57KjBtpnTPQ?=
 =?us-ascii?Q?cC+uOYmyt6ifZK+oqaw4PHEblwp1gzPgoB537iK7WybD9IZqQ29VKHK1olpv?=
 =?us-ascii?Q?Npic9acj03kfdNqPHtEXhPBc4xmlJall9Trei7TK2ArrhAiaKH8xquN2qF9c?=
 =?us-ascii?Q?pb3ldOS/ieIEJH7DP5opvsvMLLuEUhjur09u5XKwZ8MGS6sGFd9G6NF65hUT?=
 =?us-ascii?Q?jGLT+DtSHk0SzljaAOckwzQRz7yhuO78cyFkIpoyFHAMzuYiYA1XMGIrd12Q?=
 =?us-ascii?Q?3IILqhZ3cr5KygK1hJJwC0E8PP3LKethYzuBfN2BJ+iKcHrk/7FsdiIl63it?=
 =?us-ascii?Q?fdzDRdLZco7r66tVKcINIB9rmbntZALkKpNTCkpay91W79PuDi4I4XuIkaMv?=
 =?us-ascii?Q?hG9bJMbJwhhQlYcyHoB1saf6rL4e+5YT+1LQSMtnXussyFMlMXsaAsetypSK?=
 =?us-ascii?Q?JkpT0A5WHp28uMMxgE4IiqTylUDwakjXAi6+x9WQe1xsjrpYE252BV4wBR2r?=
 =?us-ascii?Q?umWdk759d71pbhUh2YhK9WCfPTMWnGcNkVnBWRGBpy2PnNV1J7Y2zDiO6rOk?=
 =?us-ascii?Q?mypaXm9iBYi+fFhVMo622VXF/z7PB1svDp2MT2Y8GRgpp0IAsryXac5Wzm9h?=
 =?us-ascii?Q?l3eZncbs0JE5lGAU9zh5nQWcyeVdoE7GxH/bTBIAnvd8w/cOk7b/bO4GBbdT?=
 =?us-ascii?Q?Ns1lQUEJFQEdI42wSMluZCKo7aDtzXB22L8xVMqN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29838ecc-cc01-4b8f-e98d-08dd93cb59d1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:12:55.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe+julpLtv7kkOBEOLE4yDl4MNHtswSq6aTNctAkSx9WKHlgFxoyOzEpiX/hWg+m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072

On Thu, May 08, 2025 at 08:02:33PM -0700, Nicolin Chen wrote:

> +/*
> + * Helpers for IOMMU driver to build/destroy a dependency between two sibling
> + * structures created by one of the allocators above
> + */
> +#define iommufd_hw_queue_depend(dependent, depended, member)                   \
> +	({                                                                     \
> +		static_assert(__same_type(struct iommufd_hw_queue,             \
> +					  dependent->member));                 \
> +		static_assert(offsetof(typeof(*dependent), member.obj) == 0);  \
> +		static_assert(__same_type(struct iommufd_hw_queue,             \
> +					  depended->member));                  \
> +		static_assert(offsetof(typeof(*depended), member.obj) == 0);   \
> +		_iommufd_object_depend(&dependent->member.obj,                 \
> +				       &depended->member.obj);                 \
> +	})

This doesn't need the offsetof == 0 checks, it isn't an allocator. And
you want to check that the two structs have the same type:

static_assert(__same_type(struct iommufd_hw_queue, dependent->member));
static_assert(__same_type(typeof(*dependent), *dependend));

Jason

