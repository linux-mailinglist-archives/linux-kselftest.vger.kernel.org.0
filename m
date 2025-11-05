Return-Path: <linux-kselftest+bounces-44827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C02C36FC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BACD95008F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0F93431FF;
	Wed,  5 Nov 2025 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S6wwQDoL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD150309EFC;
	Wed,  5 Nov 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361859; cv=fail; b=q3I/M0L1Y2rprB0tXw2YVwsED4rx1TcHO1DvYhAP+75CnAgfBBepgIj5dgQAJdfHYYropcxvAcMM00O8fL92aON17JKjfsXAHkzZfRLhZa6+IF97PJlhgY7XLgKu2Z9chvIrf5ImCnDKvP1uXJQ8XMcPAeuVpKy9dOBLtx9rrtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361859; c=relaxed/simple;
	bh=RM5TcQoloArnJYmHLnzaKbJ1CioLPwXYk/BsANpWA0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AlvrSM+yMR8HouFahCRX+74x8SpL5x2oOuAbz9u7h71uP4cVHY3Vz88xKQinPziEnIPt2625Z4UeNDJo/wQC9Mqwz0yYAIXQsoEBmta8t91K21d+LpEZtBeZrq3glWHm/2fdx4CrU62YO13woltdfDYMdsMC+P90PsCCjyLE7zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S6wwQDoL; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0xtl1SM4q4yBtduRYCOTVl22Z1rTojk3hj99onByNeyIYoOkZXg8n6/sR//QPsPKz7J4hag9yn0RNovyUdPSLJzXgSn57xAmrUetxa7dqZ8SWHtuRsMKFRygPTp1mdImPF6Qj8D4JM7rlSIzJVgWL+doWaLydPM2vMtjQBN09iCBSZomXuCSk45Es/W1/GTFtZFxXgMhKDbBKugAZpv0TvgDtpveuYV2qRaZJ5q9NPfS9ydu6wKzRmqzxcdamDJ95XKT/w/B41zHJcSpujPuRBgvxjh8iJLCLbJVWFBYTRqVkqPOusghyzUCEbMMt3whXtpZnxldZkljSjtIwNDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv2s9gL4ZHKozD79D8QUvGWISwoNQ9ZUZZ7pidbngxs=;
 b=TgD8sxk7L/NEnQvZY9YE2b3rgwPGLDonz/IlWcSGXF8p0qQrdzpuQ140a1kYGlBEBSyt9kLr6yLsXJmWuaPBqryzU8ALdbJFRBimElXblIkQ0HaNZAaT+zNzk1UXMx8nMCKdNhMY95eQFOWb9FmF8Dk1cgFntIO2YcrDn2JXB7EGhTMb+oOKq/KVfnFABA9LocHvtie7nk4HR4b88RvB6DM8E2AGZIEQ3J1PKYeDQX+pIg94XTG1ktf4PBXus3x+U/He5mYhyZqI5cPvbFcQ8szf0rAAKjSwMvuIqAUCWpWEZZPIdJsNb7rVnotDhFnpYi+zidJiwkwA6C3tkfbZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv2s9gL4ZHKozD79D8QUvGWISwoNQ9ZUZZ7pidbngxs=;
 b=S6wwQDoLaBQGFtAKp8mA7vWAHfA/56CHW67ufYQ9ZdJ+Pr0RGJaz37NKTNFrOXOHkIPjsLfAGVE3WuyK2eGyQL5bqzc0KxV/a51/H3APuok+88ZEVL9hokcMCb8miiDUv69DDV3UhTeJ9Ie4gYWdh0iF1qfFdyxp7pN2Z9IWe2y/JtkeIAkxXMCL7X0qtBMf2fEl96y/RuOqnMyFZPbeKiK+jKmEezAk58ycJjmM/TrUxpQDIR7dOocl1KmXd34IWtVc2+O1HnBx16PT9Hs3OUx21g9P4yTGa7eKVGK0ebLMHLcZ38O0OcsLdan64V5rr0Hh6sMoD76H7QWem8fMDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 5 Nov
 2025 16:57:34 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 16:57:34 +0000
Date: Wed, 5 Nov 2025 12:57:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ankit Soni <Ankit.Soni@amd.com>
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
Subject: Re: [PATCH v8 13/15] iommu/amd: Use the generic iommu page table
Message-ID: <20251105165733.GT1537560@nvidia.com>
References: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <13-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <lgdkkszwjsupu57kjrldslqs7wmsjozswiu7apcrsg7e7issge@xfqlnzb5omld>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lgdkkszwjsupu57kjrldslqs7wmsjozswiu7apcrsg7e7issge@xfqlnzb5omld>
X-ClientProxiedBy: BN0PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:408:143::19) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: fb359647-3b2e-4819-8996-08de1c8c6a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QZ27rEsS5JnFhea/SQVaPfYc9i6OcBSGpBCV5jPo0YjW56uQgzYZmBvr9H5o?=
 =?us-ascii?Q?eamSksvGQZfy4KHtrnU3Z/Y02PbYFy5O9bkW70RQllXb7hkjnlygQu4dVPxh?=
 =?us-ascii?Q?K49G8Yr9APZFWRLGWt08eGRg8DCkvyFPOQlFQx/Yq3+NdWX7nbQZlb9RT3JD?=
 =?us-ascii?Q?8wBgKbnSf60rrl9ygo5DcZPOhWdMH4+RprkxW+AI2k7ESbbWLBoqaWlgnQpx?=
 =?us-ascii?Q?zq7W64tn/+bfI7+veQMGoYj3isvD+ahJRnF9ZjqJKQi2S+ZqwVy15bEbRsEf?=
 =?us-ascii?Q?dnBWq2MBtM5JkBZz29jtLPO2lK6yxbualGpy2b2hl0I/G9jGShj/mv1e2mpW?=
 =?us-ascii?Q?4h5qDcfsE9obbU06GmR5AJrR++bpbWdWmNGPyJC8egemUoNDwu25PDu0q0R7?=
 =?us-ascii?Q?6uYFCVMPTi89wZfjgdO6r1a4MDAQOFEYo6tL2TsK8dHclG8G5WCLuLHLfE9f?=
 =?us-ascii?Q?tRw8mqMcnAA14+7WdzVRi0zlD35lXoXv/jBaPhEErrfg+f/Bg9O/TpIP2jXP?=
 =?us-ascii?Q?wfV3lO338t/JRYCb0eJQMfxNJg2Yhk0ygE6KXL1QsBBZ/zCPpAs5tJ4LHhoM?=
 =?us-ascii?Q?qYrf1Ir88I7WNeSFI/pSvEIa1Qo+/zfxjubeLuM7UyDAwFqkpl1CE5mVUgfG?=
 =?us-ascii?Q?wXHlp+TDzTb1sz8p2qexSl9eK0bfk+ZDpzyCk8tFwG1bA0ZVINepO/vtLPIb?=
 =?us-ascii?Q?CND5RuuKm9+4IvHelnzdSy6/YB8VxqnDOxJE141cERmy2iq9E5Va2W5OWzwU?=
 =?us-ascii?Q?hE9ukyk1kfLr3DKx0xBR4BS3iyIBNe71HbQXa24fWpIjoMX3o8/HsXJtSL27?=
 =?us-ascii?Q?wn61GTTzSmxRtvVm8zlakgjyfwNi+BmMf+X5wfq1DFr6H+qjPeb4vpa/Bp+4?=
 =?us-ascii?Q?F9RQ4GdYujYEqvkXT6LT0LPXBoI+URqntrR3CYy6Pr7v8JPwtzC2LdP5bbNI?=
 =?us-ascii?Q?EPdeCvKRIFT8/rqFsvrD8O1dpa2epZMrM9BPfJDJIkbFpWNwxHHTn+ypmU4g?=
 =?us-ascii?Q?Y+P/JGr6GMRT+EyJ80CljFQ5vp5SHCYNajiBdeRLZENYUIwh4uN28E0Z2B/Q?=
 =?us-ascii?Q?kguSFiIGuQEjMns8fsuJrdQbrL1paWA9RGDgWSjkj3ewECTshr+abvkuRnKl?=
 =?us-ascii?Q?Qb0AX6p0zkZTzwxqXDmBT9XNf5G+QlNrdFbuJEHN8da2U3jDC8HyXSGKmC0A?=
 =?us-ascii?Q?N4HEOqgkA30v9KFUhC1bid+XG2kvLcFzKaO9VnU8RIzbYz4wl243miXtcrBy?=
 =?us-ascii?Q?197AQegQGEriClJz8tFwGLqC4RFOMQ8P76D3JyWtJxA2URJ/Q2Q6fAIoj5FG?=
 =?us-ascii?Q?/m6xJskxa3tBDw4HhaLrdLLlgJKM3kwsNGklxi30+v9DB+H37ZswawTyiA0n?=
 =?us-ascii?Q?mbCtQJf5sr+AMa/8BAzt0rNDA4+b7Uqya5w0mwFpoLg/+AqRH39oHpayiEbu?=
 =?us-ascii?Q?593EEnVw7GQEYNUS+UKaG+xd9qVs5MKC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YkPH58k97KvOAUSeCyWibkE0TdN/KuftX+ZAQ4EpUBII8uuAtyozIqrV+glQ?=
 =?us-ascii?Q?Gvg4xMEV+2G+jdH12gPjYvOa1UU6OmPTpGczC1J3wlroaWvYJ+OXPyzMtok0?=
 =?us-ascii?Q?VeWE8L/NkAv1grIcyF+s54byLVocOIVfZuIuvlNAe24fMPIriRKwcDj5P/I5?=
 =?us-ascii?Q?IkennY5u/LT3ddbgL+kvpRevr0Qsid/AjBN+FFCuaoLhGcpHN5+sfcDGjSYv?=
 =?us-ascii?Q?HiKKP1l4J+9zeUfcqcp+2M+emclF4m+/mTwj6iDItlOkI8e+kSZPt3WG5ag8?=
 =?us-ascii?Q?9VxUpEj6vDhO+W0PgaLcobKwEA2Yl3Dph2O6wYyqo1Be8aDVbeITM11CPF6u?=
 =?us-ascii?Q?5SBSN6MdqnLGJUYPaV2oUNZgWqZwSEJKE462usUoZXBquxz4n7TIJfFgJFi/?=
 =?us-ascii?Q?DI0WAUC7KVzHpmevzbY8XWC8A9wG0gbh2PCOiF/oRcnIUhxyFtQNWuQx4/4J?=
 =?us-ascii?Q?zE51pr5XA9H5gG13WgJDIA+8I5Ge64FCxL7oeDKanrZUOPY9n16KLvXxSR2s?=
 =?us-ascii?Q?jOqc5S08BO/EY97orYI30QRAGuEoWBm+DFoFFCc72bqC1plFYklnnc+AeihW?=
 =?us-ascii?Q?slkh3HRyg/fmFAdkJ1MO8slFPWYNBpa57Ev/YcDAEobMO6PoMxkNy3aNVBsp?=
 =?us-ascii?Q?jqZ3/cmTPnSwkUjtVqqfNStiEf5RttYmm2N/ViCH1l0JUj0SZlJqp1rcxpUN?=
 =?us-ascii?Q?x+c0B3UNoSt5FtghSRIatjdOXbHC2tsjggAgumu337ixaWLa6RyoVYpmdJLY?=
 =?us-ascii?Q?YOSE7zMfyoD4uG6qgisjkjAX2PhbT8bkjicdopgwC2DqnX3cse6jWY58EuYk?=
 =?us-ascii?Q?DDWb7gz2JkuGlmev2Eq7uiroMAdmUUr6i61lIMTsLzLSKRh0lMnHEFrsDLqy?=
 =?us-ascii?Q?1yv1yHMeELUEUbUh5zAnIG9FQL/V8ZpVHt0cLKnyWxsv7/6RAuZrQZrIlQ/C?=
 =?us-ascii?Q?lWBKNpZCv7WmpXPDyrQ0FYebWs9H8plqtCZ9mdHgtOemsZ+iM/AfX52txSTz?=
 =?us-ascii?Q?/9EthZBb4pw3alJD7Di93JABkXTAMlEysBnEPUMVZM8U7z3k6/eYqbEI9HvD?=
 =?us-ascii?Q?J2MYPuKPuuorTDoDyu58RaLuSxq/taUO7wVGq5OqLkVNBxkySMs6QXWDmcN5?=
 =?us-ascii?Q?jrqK2Bt4hOtsKF6ZUw1jei/Odsse9DV5T/o+uDlA1qBIiP+W9OB9ukpy3pRW?=
 =?us-ascii?Q?CEMCVGocno9pWcz2iAYDizg9hCu0m9EGvZ/vBNNXrWSGxpkFypqnuRXOXMDc?=
 =?us-ascii?Q?rLld5MpyduLObKsACiIPFiut7skz64s1J2poHQOEsXf6R4QrT3kFdyZXypd7?=
 =?us-ascii?Q?ikPOYsa7mq2yYr+tG7WMclOZGf7sqyFRezvJJrFxbglmsYFkhSv8PtUYS6n/?=
 =?us-ascii?Q?ngVT/Y8W9gncQspbOpv8U6YQpDOcBCwurQH+AQFTHtGLNX+Eu1ZEV/DDAsug?=
 =?us-ascii?Q?dngjXy1y0Jc6OCKNrOOLbmiF7IOntnAYWvzdMUHkUn5XM1uYMHO4BVMs59Zz?=
 =?us-ascii?Q?OU7H7lGZ/ff6hdtICYEn2Mq5aUm+CC+rQoxJXc4Y6L2xeMl4bK4wvpf7eNC2?=
 =?us-ascii?Q?POFq5bJNfP4sWXycRcM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb359647-3b2e-4819-8996-08de1c8c6a9a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:57:34.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emkUvmaMWyRHweOS873LB9fVnGHrhiRaVke2v612ij5gaNQzWLU0+S6eVrJgy2eK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C

On Wed, Nov 05, 2025 at 04:01:53PM +0000, Ankit Soni wrote:
> Tested-by: Ankit Soni <Ankit.Soni@amd.com>
> 
> I am little late, I had tested this patch series in both v1 and v2 page table 
> modes using multiple benchmark tools (FIO, netperf, etc). The changes work as 
> expected, and I observed no regressions.

Thanks alot, your testing gives me great confidence!

Jason

