Return-Path: <linux-kselftest+bounces-25373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1844DA21FF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 16:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D6E167FF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A21C5F2E;
	Wed, 29 Jan 2025 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I5UskM+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9149191F95;
	Wed, 29 Jan 2025 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738163102; cv=fail; b=gmNjW9CB8y37SuuvFnbrTez9ggam582s9gBFVlmhY46yWgqHl8Ae0ZU1I0BAgHE29+VwkDRA6XUGdUQq13RzcwmlOSg0qlA1EiuwPAXN9vKhgEgb8boYGKXBjvyMepG6ZM29/t/Bu+3PYUk3g2gvA4Tn24EiInT4yP2DvSTB7Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738163102; c=relaxed/simple;
	bh=0whQIFeja3ZrDHFoygu4ScfvPOypjP28pTrm1jdyVGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S82+h77uZFFFr+1DfempoN4Sa8Ot2qfv8X6+jU32nIDy6FW8YnE7lpk4Dakb5G72z81pfMnlUBrFDt4k6D0xwDFm7IgmZN7MDpDHQj7zvZwnQD16QajkUXfsHJS0EMU8Q93z/eips1HpFhubAM2GYZbRXGhH3fUspIB9oj+whB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I5UskM+Q; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vp0Hz+NOHVzv5pu91hyp5hUljcR475eynW0KpUEqgHneg+xAYIzO+PojAUWeKJvU3iTGyJdGwhGPqUCjg53eOxXI1ccpE3ghNJJrg7RdAC8OPA6ckWsrbkgC9roRLffZ7+x76nYBebLjxAC4yP3pcA6wtPbK1S3yJoY8niBbxcSMQ8PMnR95sgP/AcSpmJSHBmWwsXgYlf/4y1wRl6u9Lknck4zI3YgsHuMw/zLrmPUCP58AIiVyUupHUJzgROlF9mePvLgLbABAqwt5l1J2jPTIVBsd29COKzcpUwpZ+i3HjnQxULDbdcUA26+geo30ky+1qCzbZF0Z8UBF29/7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IqPx2Rx/d1YOeuO44aMecifkEHj+YYlNTb4U/tWOq8=;
 b=psJDA3ld5dMjzavYycNSaTeYG8G+phl9tl44j10JI9w6p8bEzHLHu5lIIDP0szyOcr/PeZz4x1PecJ+vowP3A8USi3bbr+tX8PrvHat/zlFB1dirZnBUVBYpnB34ecnQBjVCO+6QG09IAXY5Sf89xDABKGPYLgI9OP7DbIGr5LtJz3TuoOckIflbOtu1cj+aNX5RCguInSSW76sMZGt2qe0GJCWsiyIUIMZ4dCN1MMwWZVPnk91H/fWErCp5PftCw9FqZ/3uiPOpJ2MycDTue/5JSyapLAfkJIgvLpnpmi3vhJWAwuiu4fBMkncYT1fEcdlXraTI46Jy7stac/tr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IqPx2Rx/d1YOeuO44aMecifkEHj+YYlNTb4U/tWOq8=;
 b=I5UskM+Qu3ZEpu+OfkSw/sQyvRtsKJ60+5uc2AbgZsjdvA8t7nfDYqTX7e91ghpJBLpUlwr2jljopx6dukyMXNqor80BkwAUhOSzk2x3YkzDagAIIqkL/GzrOfN6d89BrS2/fPWvKyWEamY4KDYvE/mtkHWbjThk72jc3QXATYjhYC3br5PGL59yaDGjwjFogiu/Il5tm6BXNAcBUvxwmiK57utJG60/s4nBL+NdQhHlXwWA3YvwqNp0AyDde+Oj4jhB2+fQBDDMl9dgEv69A/mdxkkxuvsT0F98N3yPw7NLvECA8NN6Jd6MhX4V47Yn4TNX4hvAUW+R4Q3JOePYQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 15:04:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:04:56 +0000
Date: Wed, 29 Jan 2025 11:04:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"maz@kernel.org" <maz@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"reinette.chatre@intel.com" <reinette.chatre@intel.com>,
	"yebin (H)" <yebin10@huawei.com>,
	"apatel@ventanamicro.com" <apatel@ventanamicro.com>,
	"shivamurthy.shastri@linutronix.de" <shivamurthy.shastri@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>,
	"nipun.gupta@amd.com" <nipun.gupta@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>
Subject: Re: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested
 SMMU
Message-ID: <20250129150454.GH5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <4946ea266bdc4b1e8796dee1b228bd8f@huawei.com>
 <20250123132432.GJ5556@nvidia.com>
 <de6b9dc1-dedd-4a3d-9db7-cb4b8e281697@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6b9dc1-dedd-4a3d-9db7-cb4b8e281697@redhat.com>
X-ClientProxiedBy: BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1285bcf9-0dfa-40f3-74a7-08dd40764a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KRb1pEmSAfZCt7O256KeECPlinVg9a6JRpxPG25RPrt9I9XSHqJxJDfwJGrS?=
 =?us-ascii?Q?B7ZN6JfQST9Kk2nxd83jsIwsA/FweYrF6dLMjhIEf64vryxxUcDxtb4eC0MH?=
 =?us-ascii?Q?1pLJxh0PROKGsbNQwKBkkZiDODj6YQNaZprd/iwbS/UpviXcCjkKHzseQt01?=
 =?us-ascii?Q?AY1k9xUmwKRvbpzEqpVCHStgpeJi+3S1i6Xm50SI4ACNGNozYiHUzkvzl/22?=
 =?us-ascii?Q?Y7PERGiiZ3O+Ad1UdbVl6R1sPPjobkJfAv48c2VBoLlDqshqms80rUls1F32?=
 =?us-ascii?Q?vNFkaFoMCDXKyy4hN3hSQgeeyGkhO+CBNIJIdUsGh0QWi+EibOSbcZNemtel?=
 =?us-ascii?Q?8/hvFHCfoLiaVhKNlEsIB+o4m3Xdleoa/QmRB0Xlbn9wJHdzUU9mb5t5ZkAS?=
 =?us-ascii?Q?G3vNhPrjTW5fggFIpgCtytVcqGgB7KRuAr+KG7GX78ueP/7Edm8RqQstDCbs?=
 =?us-ascii?Q?i15mwSqXoRfUFxIrVXTky9m40M8TUqLkW5Mn17YxqQiRTQUw6wsQhQqJvJGv?=
 =?us-ascii?Q?FjYnSVJgqn0E+UaXL6Fn6OB8PpTveoYmI/mKmx+/N12Cz7n2Sxt48Vd5Ld8l?=
 =?us-ascii?Q?J/5O3ZwJ1RTnN9aX7gYav9RFQxkE1On0mzed7GCHufdH5NklEltDQp99LAAx?=
 =?us-ascii?Q?3aJ7eln05kwNRw89o2a4PJ/Y+yW6TJVi6IzVokukCNUzYbQua1IMHzEYazQU?=
 =?us-ascii?Q?bqh04njV/kzUs6gBpHrjVZODSf6DIGTZigWGPxW2mAJ0Js4lXeO5ihbNkc83?=
 =?us-ascii?Q?tN4k2fz+NX2wUNztKbfUM8QBJCz2AO/MggW6DZFfcLr6o5yrUUIkyRRSvNA9?=
 =?us-ascii?Q?jiXRJr5CaQXju50P4kTZm4pgKlrztsNWx06QCdie+eThIQHp6fOz7KoQt7LL?=
 =?us-ascii?Q?wJhdpMubrNn1ncnXWt7oIooaI6aeDNYj3AZujgp5eCQELBlcqPTeV/Qz72e0?=
 =?us-ascii?Q?VzoJLwOBFAXoZgtLERUfj0OOqJqxtsWBIrclCr30+Hz11aQoNFqrjW8a/zuH?=
 =?us-ascii?Q?0/lJ3y1kFy9ICYiY3+Y57+rQJbV9GzZCxLsFJQmz1yckTu+2MYFcNjPbx58P?=
 =?us-ascii?Q?SnShmbqYkfAdEpXIfOOllNUE3QWm7nBW3YTJXkTQ0hYAZF06JF3PqN4TFAL/?=
 =?us-ascii?Q?d30oZMwwZQp7DSwcnpeaSRwoDIRJCIM4qbowhRa4ygJ7LOeFDqtTlUuOHnvC?=
 =?us-ascii?Q?xDC19u7KIiI5XIeiDD6PDrDpqJkc6XFCvqAKrfjNXFeBrd59Xc3JY/AFzLRt?=
 =?us-ascii?Q?VCRDwOvQ83RAmNqrX+WPR/bzIKn/Dt6+VhVi4ma+yPuOj2jswf7iDMfqdiDa?=
 =?us-ascii?Q?BWbGm2eqvaGTDgpoLkH5jE7pk616/i/8a4apCbCn4xw5L5S0hSdi09NGl6V8?=
 =?us-ascii?Q?NXqjmGXumByJxQdA58zGAyKRN+Bs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p7MCclr/O+h5HYaZiqcZT2f6rDb9kJdRi9MxBa7etGLc7j60rqkIa/8nawVi?=
 =?us-ascii?Q?ta071xLV8R39sSvm//lGzsQql9LDzUhhQ+vgSJlylMnOssak9kjvWFMGezy7?=
 =?us-ascii?Q?1bIVjndMypU9In61pOPnFrvrSVONS7UOW/7ok9tsP0h4vcG4jfM0ury2SNhI?=
 =?us-ascii?Q?rldyQtTlSJJtix0Tv+3ccZs3hSnw1/MA4+PK/4ve+mdZqSX7hbvhVZoeecxa?=
 =?us-ascii?Q?vqSu9gqs/4GR8mBsDULVHz+TWLAbOyUmS86Ionad4udZZQXU5BqduT/TGW4R?=
 =?us-ascii?Q?fLCvr1SwUnVGZvxYzaee98ZLbuO/jtengz3Gs4C5Dz3vu1pHJ9YEgqu97eRw?=
 =?us-ascii?Q?lVT0UVKePn89jjIV6bbKlK7zLMDWGzHKLAsGxb/oW37Ba1MQCtPmYRK5rmsi?=
 =?us-ascii?Q?K3RYEEWMkaSietNroRT+IPbqp7Ddb+jybYWhbsEVVY6W5xFGjqkilGNOgUeI?=
 =?us-ascii?Q?CMj4qht3tNeKQqaRR3gIALII352EIEz2ijDsnu9BhUYWL8tvu+6Mtw18Fsa7?=
 =?us-ascii?Q?0zsjiMsOzUmy43sXooOm8gw8r0lLt7+QHAVNYhhvNHftqEAsaH98VqGAWxgX?=
 =?us-ascii?Q?ItDCdunqzNms67s8xa78vKSZN0Tr9rm3xFnkTSMwBGcVIwRCzg+2wmReeRjh?=
 =?us-ascii?Q?XafSh5YRTfk1Qqqq+PIYbqtse51jsbCZNKNyJe/CsMPI+rMqujIkKh91sgb+?=
 =?us-ascii?Q?nNYCk0k4Y/vAcNohCZqQMwy4SbB5cPUzdhZYwpP8EFVrTDjhOZGa+zd3k8Lp?=
 =?us-ascii?Q?WMuCeEl69b7AWTLx/b2ek18KFxA++Un5FzBaiMBGG5lQMFWfbERFwKRGcfPB?=
 =?us-ascii?Q?tggi3kL8mtvmXLuwmed1l0ZrOgwQyLwC1S96dz0dkO5U0c8R6Jas8lp+6vkY?=
 =?us-ascii?Q?8PUTVGe1PCcxYiIPo3/iTP6bfqRY3PSZQaO7P+7XEIjuL6FywKPcOJkiWTY/?=
 =?us-ascii?Q?Kl/BcLL92Unb7/WBE86VTUrY0dZerULcBhWk17V/P+6yPcyiEqPjwsIYUC9U?=
 =?us-ascii?Q?c6m0zbxPNoxQ55YEsv+rrCzjgEKA1IFLYTfxw7WsS3ijSXuWekFsSz0QVWBK?=
 =?us-ascii?Q?ZW9WaHSpk+erpRWue8tI2YkOdHNd8ZglEhrkqJ6yUUZs7sybODpQQy09tfbt?=
 =?us-ascii?Q?25IUGdrj1w3S2Vmjusrtsu4F2wNUVtTrid1rjRmOsV9Zo4OB3Ewoa9/RNyZk?=
 =?us-ascii?Q?vJ1Go2NGu2aDprU+03L18YnV12cTUVK/Cjrkt4+MrMblMPrSPgpdCG3ojyzP?=
 =?us-ascii?Q?00gdX9gG+WvPFLMWAX9XOUZam4l9WR9qBXpRwKS/nS1EtKSH8G+Kb1Xzhvsi?=
 =?us-ascii?Q?P4ZMTevH4T3oBDl5yDvGvbOBJzeBJ5h8IwJwt7LDNwFNCs9SV7z3YW0BUt2R?=
 =?us-ascii?Q?/sdnYMBQpZJ1hH4Cm1kS5t2zXWoNtRe+g1CmsaIkCpVOdg0rwDJJqEXYR7u4?=
 =?us-ascii?Q?sAAhPZ/F+HQL5w6kU8ifvtSVPuX2WiK1tDTSE7f6DRMBZLZudyyumQYQbrHm?=
 =?us-ascii?Q?uU/hUZfH0TLEcrRxF6A93x0Rpux9pkpGkZE86pmvQwGxqAwUxNosEqZPZ0NE?=
 =?us-ascii?Q?667frgPO/zQPNoxKS+EP8tcz8XnzcZu5bUa14DxT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1285bcf9-0dfa-40f3-74a7-08dd40764a82
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:04:55.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJ0qPbvprkUiVK2MJQTt4PJU3gTrWMOw+08xyKhe8/i1+zCCcvqhcFg+gAZujyct
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456

On Wed, Jan 29, 2025 at 03:54:48PM +0100, Eric Auger wrote:
> >> or you are just mentioning it here because
> >> it is still possible to make use of that. I think from previous discussions the
> >> argument was to adopt a more dedicated MSI pass-through model which I
> >> think is  approach-2 here.  
> > The basic flow of the pass through model is shown in the last two
> > patches, it is not fully complete but is testable. It assumes a single
> > ITS page. The VM would use IOMMU_OPTION_SW_MSI_START/SIZE to put the
> > ITS page at the correct S2 location and then describe it in the ACPI
> > as an ITS page not a RMR.

> This is a nice to have feature but not mandated in the first place,
> is it?

Not mandated. It just sort of happens because of the design. IMHO
nothing should use it because there is no way for userspace to
discover how many ITS pages there may be.

> > This missing peice is cleaning up the ITS mapping to allow for
> > multiple ITS pages. I've imagined that kvm would someone give iommufd
> > a FD that holds the specific ITS pages instead of the
> > IOMMU_OPTION_SW_MSI_START/SIZE flow.

> That's what I don't get: at the moment you only pass the gIOVA. With
> technique 2, how can you build the nested mapping, ie.
> 
>          S1           S2
> gIOVA    ->    gDB    ->    hDB
> 
> without passing the full gIOVA/gDB S1 mapping to the host?

The nested S2 mapping is already setup before the VM boots:

 - The VMM puts the ITS page (hDB) into the S2 at a fixed address (gDB)
 - The ACPI tells the VM that the GIC has an ITS page at the S2's
   address (hDB)
 - The VM sets up its S1 with a gIOVA that points to the S2's ITS 
   page (gDB). The S2 already has gDB -> hDB.
 - The VMM traps the gIOVA write to the MSI-X table. Both the S1 and
   S2 are populated at this moment.

If you have multiple ITS pages then the ACPI has to tell the guest GIC
about them, what their gDB address is, and what devices use which ITS.

Jason

