Return-Path: <linux-kselftest+bounces-19989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E1C9A2972
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20ED01F29459
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2721DE3CB;
	Thu, 17 Oct 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UO4RQZBt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974691DEFDA;
	Thu, 17 Oct 2024 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183642; cv=fail; b=pnmpI+aetf5E9a821nBoyPC0kxUBOrt8PSOiReLJlIpMotCymQE+/iuyQa/80AA/I3oRA2P+1izaYWRuuCjMWJuSgF4JjMpZpYYY9mcE9IrVllAMgj5rPRM+VlraGDLKWfaDkWSzdKVXgHWwW9K6/lgYXKufUPPIlSMa+jP7ZRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183642; c=relaxed/simple;
	bh=tszIbXkBraTqGp29c7/7twATeW0D90xuu5uPIEBuM9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GxB8G1KdI9fhI2eJz83BCc7PeTFCKlfSDhTJQpDvCFrHQn6GC/wrbVXOY4O5em5L0sKIkyr4kro2oNU3yDlL0zVOxIX4/XTR8F9vaYTBdSuc9qAEVik6XmTpRjW8dvKafUloMv8C/olRV3Vcf8hQMNGXm/toVKpfnlqryuPy1Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UO4RQZBt; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J126fekHRcpoJzh3m4AsyiwYBwYhRgwQO3Emmj42SSXcWNlYoKsq3iyEVs32YZvDD4ZfBOOnMgtOP2D+9VkYW9oOYvG8zX4DP+NOv9VbOXCDCPYji+eRax1A2jVAssEuuFWl/fUDDb88oPtWR6THhbwXAH9D76egaEbC4ZLZk6AHQ0MQ4KG1f4+J7sGJS9m0yfu5TgQOEokiYyo2ZDA4GD7DAiS6TrqsMYDMas+rJlMr9Lq6rb1bDTkgDSWyI/I3MybFZGymJOU7lOKuMRBTFMfYjRdksWMm777VBpsLm7W6VUuVksiS6RQm5+sPIL9pSce+2Cs43nfrOErpnsCUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tszIbXkBraTqGp29c7/7twATeW0D90xuu5uPIEBuM9k=;
 b=vHK1aD9GcDYEbRYhUHIUFpYq6P2Pmi3EqQjOHYgG/k3NlU19vcaJokXt1fCsoDYjAH0/OO2wIj6kTVbLwh9YpIs5o1r7Wf56aMDLDnDbsBDYt2rBRF+TzmnnW+B8BCBYXplfFVacA9VF5Bd2NzUHYRCtibmolj52iSwOeWGdcmDhcJ0XMTwmRjISL46R00iqLA86ga3fDbRmw2AP849zZxuXRPu7Xg41Cpyn5Duc/A3RXFikp/F6BIGgG8/NRwWV4qYUiPAfdSRaHjVOHVmfe2oQ0B8+zuicyHapWA6wrs6W9dWqW/tZgrP5Y8YfDgNXhA8EssOdX9N5QpxMjwDGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tszIbXkBraTqGp29c7/7twATeW0D90xuu5uPIEBuM9k=;
 b=UO4RQZBt7j2l7U8diWskVX2kNxk9RXQZuyxe4PffALjjkUY5G97FuvGan+LZ0/h9WvC6sKRHmHnvc0ARqh91gaxVc9M66qUlfPor4tUzrU85wFcysNUgeYRoH6kQFUSJSCzSlQp9pfbKGwlg/IaH6zwcWjiqVwjpozSdZyF0mNUuWG4ZHTADQKbITJIuAq76w0puFqU25rrw7bVxTIoFOnNmNvPZVVqOn5o8YggGQrH9ThVGsIr2S9LxvbXN+zgIiRl/DIIVa8LW836ulLNErpwULsT02Nd0eL39JPmL+U2fs7Jmm+cbMjxDa4KeSg3ScasHDa8y4Gome5hixnj1VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Thu, 17 Oct
 2024 16:47:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:47:14 +0000
Date: Thu, 17 Oct 2024 13:47:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
	quic_eberman@quicinc.com, roypat@amazon.co.uk, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com,
	pgonda@google.com, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <20241017164713.GF3559746@nvidia.com>
References: <Zwf7k1wmPqEEaRxz@x1n>
 <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com>
 <ZxBRC-v9w7xS0xgk@x1n>
 <20241016235424.GU3559746@nvidia.com>
 <ZxEmFY1FcrRtylJW@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxEmFY1FcrRtylJW@x1n>
X-ClientProxiedBy: BL0PR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:207:3d::43) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: c95c332b-48ad-4414-d860-08dceecb5a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o90uudqH/3KsNmyRTgCtTzA3NXzLB3RRW3oCtHMF3zqXnD8tkH8/72IcgYNJ?=
 =?us-ascii?Q?sjuXCuggRMbv9T/P5WXxyrOg/5o3VKBl0s4q5RGeKoeyyqNbFZH78DKaRWrA?=
 =?us-ascii?Q?DSf1PiRJ693BrkSU+8rliLaMAoo/rR7th80zKjziwDZHnJaP5e7vuHKYhFVv?=
 =?us-ascii?Q?h/6jtwoza8ef7sdtTvk5Omp0j81fSInkUzsLPSfK6y8HIBXii2SZU2YnpThz?=
 =?us-ascii?Q?98mIDMjVnTSXah9fzmKfcMafHL/Fb436ka00A9gwlSJ9KFkMSHU9UydUIFw3?=
 =?us-ascii?Q?LxhU8fN/C3Bng+XdCmeg1pQMxBlb5xCwVhG6xgFcynL1ot34nnZYBJmoTqu6?=
 =?us-ascii?Q?v0CYM17rLFsrpkh891rKT+TxYQie3UXURbPMV3UugKyn0xnwRchdHyijbdbw?=
 =?us-ascii?Q?TFPzetu7i1tO861yGDS2WFBC5hFAIJGMzYKBlND1WV+NE5xV8wgpx3f2fAWp?=
 =?us-ascii?Q?FrI9NO5ikDz48ieMcODCe9iz60Sgkoq8jkGcrlK3V4kKlErvAJVuIoSi0iuY?=
 =?us-ascii?Q?uYHLUcp06qhBmsvO5kuFc/BYtrVGOaaitwd07Lzka5OBoVdrzcV1/D0wV0Cq?=
 =?us-ascii?Q?+ffzF0eTXG0lz25NjDS6JjfJ/8fUY2usbg7xT68reFtn156wVCmtB3cOiGPm?=
 =?us-ascii?Q?SepuK6ASjfMdERsRM/0bUAwd35xanBDhR9/FZPe0bvxpSR4c7l574Yx2OgCx?=
 =?us-ascii?Q?aXFZfT0OfaS3PZO9Zp1NRelepkR022+fqr2kvOFxF6mEEhD5c6ONxMVYFPru?=
 =?us-ascii?Q?OXkWo/NClT4DFNHdBw0Wr2dmYwVW3jSh4DMB5+ANZyyNv93NCWKuPeD66ieS?=
 =?us-ascii?Q?sgSg+NfUQn5D58HIbkdHORWaW1VBBi2p4+h03VLPC8Zsft0Zodn9Loh+6/qc?=
 =?us-ascii?Q?Zy132kshZnQLG9akfPsQ9/wqRiZYJufzRSM1AHWpUer0MZ1kEx1MP1860rjT?=
 =?us-ascii?Q?Ng0QiMKxt9XZ8La7oLSQ0/4Xs1I1G/mCyTA+cwBNWIKHVakEKCnrf5xiIdLi?=
 =?us-ascii?Q?KkD4kN2NqGcJyf4xfx8mKkIIi9sch0EXg26rIaF+rZ/B8C0aWgO9dwEkCOBu?=
 =?us-ascii?Q?Q+hR8V0grDcuCfKe3c8yX7pX6OYz8CMCrAyfguKUp5tfmOT5MvQ2zGlBYLfd?=
 =?us-ascii?Q?KO/aKEMzQBfO4UuJUNIScGKhK7XTKzQXcB2vZ5gnLt8r9f3aBKpH/6576jmK?=
 =?us-ascii?Q?lkMNNxACYs7qmACBJ5fhmH36tYuZhdjOLWLJcW4Diea/1qMCw2NkexglStge?=
 =?us-ascii?Q?tSgtA62zcxQ5DG5tFW4G7T0ZSHVB64GSngY6pv9C10NDN8V1uMkmo54JRuO6?=
 =?us-ascii?Q?fa77V/zjOHAuZ9SIil4Zd2yW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CcE9pb4GNUKzyEcxareJMEHhTiWiViMT2FrGGjX4qIUyhh18UMBWR2z7WLpJ?=
 =?us-ascii?Q?Z6umDQ6oJ1KuJgsrdX0Tdh6I0NOuoaH7sHdPPnSKYIKfQ5RK7XX8wEDmr0QC?=
 =?us-ascii?Q?viQ8jeESBYKzTompV+Ly1KQnk2Grvfx4I0ZY5p8c9eP8pjkWxC/5idWxQO3b?=
 =?us-ascii?Q?wdhX+q3vRThlIIfdn/P8wt7TFImQlJnGOnCYC4RKcDcSihR65ohcyQOkM4uu?=
 =?us-ascii?Q?3um+/RxQxnPG2iOXZ6V3UCknrJOiylDHC65FC13IzrAolckYOBiI5Dx6EVsT?=
 =?us-ascii?Q?JmwYd2RDNyfB73wQdDkjlzgpLg7ymOH8z+LT+2466CjBoL8scZ5RYRg4RPI5?=
 =?us-ascii?Q?gO5QwHoN+JjPmFp53MeD5nSY2R+hFXPtVq2g0F30P9YuScHTB1BNJzaYPeYv?=
 =?us-ascii?Q?rkSN7Z3GADZjHhUZjNPZveOSv4VjT9u5B+5Ccot6TsaS4DKkUGPMvx363N3M?=
 =?us-ascii?Q?sJ3BpIxHanovG1pA2uPOZPCwIaD+SmfV7Z8Jol0EBg672RQjWBoc1aIzOZbq?=
 =?us-ascii?Q?bH0uFvcy9EZZYlXdfMuME0WPEXQAnUBhkKuGsVWrCN3tJOaZiUYa3u+fhyIm?=
 =?us-ascii?Q?oBL+Ki0rXj1vZfVRzFCsiKB01FSRcZ8K5nxHF/jvnUAhZum3/jtK/eOFMBrf?=
 =?us-ascii?Q?UF369SJCHyOH/pDhSjbP2Nn/3JpV8ql3NjH/PYkNecOc1N9EbiK7ZbcfMjDI?=
 =?us-ascii?Q?gGj/kyhR6XLpZU/VJKsVf+fvCUueaFtbVNYdNwdFtBQLR/TJpf3+senBHcNl?=
 =?us-ascii?Q?FmwiJKPdnSvhTmQDUiVyiyDL2P3kMxvX0OdNnvAver7xArL81nkliBwYxFf+?=
 =?us-ascii?Q?RLC+IwIKjNx29i2CZBikkk4PdlzmFpTeHSF5ieZ3ZehD8oRXH5UX7q4xRbyT?=
 =?us-ascii?Q?HJypMQF4DQ1OUinkFC5/T0Qygaa3IN1ZQ5XfzX5p3gcRtl7qdIcT7d2PKSY7?=
 =?us-ascii?Q?TXGEwMfLrvrVqD3nDhIBGy/RJivt19uWMWahUCDo/682SsOp5lm5oTnU4VoK?=
 =?us-ascii?Q?i4iSpTQJiCbBIHlcZvR33SEL/oiYa/2SsPBwqD+/HyKe4ga1Sqzgy6ztHXN3?=
 =?us-ascii?Q?uKKXYDxukSQCcPsqIPo2oazvcjKbYBUchjX1xjmMPS9of/xT5v0MbL+b1rrn?=
 =?us-ascii?Q?9cC50MmPxhAzvRhVbA7v9hYXazIxDe+odUR9MGp064MW9GC7QRvMVUtBKYo0?=
 =?us-ascii?Q?VcbG5BN7cnaigDXuFuQuuP0UPP5ClyTn4XhRRF199Lw5nI2XH/wyk4J88caG?=
 =?us-ascii?Q?51V7aUqx2aO16uOXehgGS+lT9M1CSQYrx2ba3xCLf9pUjQWiAEtyocG9ddwp?=
 =?us-ascii?Q?07jd7Or/mK9f/QitUglfFX8DbflOszgqtX6ZoolptuGZQGRV9FOQoGEY6Yhk?=
 =?us-ascii?Q?glo8slOsmik1HgdJx4/wIDoLLst15DRkuhsh+5IxNIMaCbds4JXIEpnabdz8?=
 =?us-ascii?Q?5z9QTR1YvaP32797QCKaAXTlRXJ+QJZWSrBR8TbukJ/nvSL76JNWq7su7u1M?=
 =?us-ascii?Q?gVeTPditKExo0pPKYfn85+T9Olstm6vvr0CIL5SYbRxNCs8fkrROXUd0/9We?=
 =?us-ascii?Q?Uh1hS+Q1HdYbBQmD7og=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95c332b-48ad-4414-d860-08dceecb5a9f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:47:14.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUiKxHze+sFMpXfAWEDTo8/fwzM2Iqpb5k92fKoKCk5hUPJ6Pjcyl7IneTy22WaW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795

On Thu, Oct 17, 2024 at 10:58:29AM -0400, Peter Xu wrote:

> My question was more torwards whether gmemfd could still expose the
> possibility to be used in VA forms to other modules that may not support
> fd+offsets yet.

I keep hearing they don't want to support page pinning on a guestmemfd
mapping, so VA based paths could not work.

> I think as long as we can provide gmemfd VMAs like what this series
> provides, it sounds possible to reuse the old VA interfaces before the CoCo
> interfaces are ready, so that people can already start leveraging gmemfd
> backing pages.

And you definitely can't get the private pages out of the VA interface
because all the VMA PTEs of private pages are non-present by definition.

Hence, you must use the FD for a lot of use cases here.

Jason

