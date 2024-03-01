Return-Path: <linux-kselftest+bounces-5689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 415B086DB1A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 06:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB49282BEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 05:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2BB50A62;
	Fri,  1 Mar 2024 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLTtecpW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6F50271;
	Fri,  1 Mar 2024 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709270908; cv=fail; b=Anuedwz1I1Bt41C2kkYbla3quwIfQn0RU4R1JMJ7xP+9de5oKj01j+MfIvDDlnS1fOjS55TfjGhBpRbkX02GoD5sGeccimc1tw4QLwxyL0aHL/zEAHInApRw00hXGon/izpcBMqen5QBU8GtP3Frs3t++TY2eiLpbtFML3szFXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709270908; c=relaxed/simple;
	bh=fgp9EOmpia6wK/QOi8uq1VeEz8wsYiDxA8KZvb3BlxE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MHG9copL7PqXtKfTYRi1zV1M71ytj/DBnwUsiBwTNarKBAK/nMh9yTp7N5mCWbI2fmfwgWjIn+wOo3lYiJb1NBCdahQZTS2FK6xWVraM6+Txw+hmWjMVzffiaBdYNSRpDuovzxGe+EBCvVUDg9hOeGBbBuzcyRg+uRDceSW6VtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLTtecpW; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709270906; x=1740806906;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=fgp9EOmpia6wK/QOi8uq1VeEz8wsYiDxA8KZvb3BlxE=;
  b=cLTtecpWn4AzfvzTtfY2vjIvFCXiIysEkg+42Fg1KMuCMc3OKnj1KiGF
   mjSNOp1dmmM9tXwJis6clHpO88fpH2Q+gQIs5z2+KsHIx8SudMT97NQ8V
   N2DTPWrFjCMG5sgDzoiT84EfDd9PzAbIM40GtqJXQMXj9Sr6bmK0yX71/
   wWhUB9gnZxflqbf4Tdfbl8WLtukHpm4Bq4AX3ONSjZWKCDzu7zj5goUzW
   JR8rsnMimAjkna8oVopkmJaVZ53t/Yd9snxVwbz1LhqB9HCj5a4XZReNP
   DS/Lxs7qLH4wZH2QI+VHYFBm8sB8g4v1IyWGBoZ1tfWU5/yPl9badxLp/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14937871"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="14937871"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 21:28:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12628460"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 21:28:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 21:28:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 21:28:23 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 21:28:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi3Ossoo+5fZuaBwMdmi71VObn/1hAfBrDjoetJ9bpE6BSDF2c2ZqSsmHTRySGB3jXseThrv3hmxE+zy8ORuDDCpAOYQty3VR6T2YzqjSDHjTKTQEVAtdcOP4J8hcHZ2t7Pgt8mBhtfBm5IK+e7mYPERWxrEgvAwsyoiyYJZndcPiYzjHnpufSZ3ANAISge5n7s78JhiAeMAwarCBdETmg8Zzk7R5SneQ8ppoqWzM2n/b0a9QxaJ37xkAoi+MbyMQ12phgHc/GALVX8tArmtDV9eo8qLEfxOw+EhclOLq/ZLSm/qzJr203cCNzkzQ+fiTMIPI/qQbbpcS+SF4tRyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JC3ibAoXnLDTH/vFGz3T6ye07hoypMZ0o4TYpUDGMY=;
 b=PuklYSsOQqpTy9QKLo823OUkJNWVpxuYBEgEffFAkE/2cqGLfOJYhY5XFeh+X8cDTKTlUW8atV4kv8KiLadDX4iwgpee/X234cyowCenKOUkeVxPj9+k9hdVV0MNhdaRH1sYNruoWwnXg2AviQiq8CEG4wulpCpFJWXL5QoECSXaSkcFOnmn3madwyrg8BUq/bMAvOWxhhvzo72V85ce4O+Q8qqzvenUneppj8FeF0IERLVVFQxDVE3kUMQvnCFkZEXppERSQP168YFHiJtORsiwN64xrOGXFL1i3Bj6cdhgvEq9ulctVXp5bPc7QerVI8eqIYgw+qvGSjdg64IC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH8PR11MB6925.namprd11.prod.outlook.com (2603:10b6:510:227::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.25; Fri, 1 Mar 2024 05:28:20 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.013; Fri, 1 Mar 2024
 05:28:19 +0000
Date: Fri, 1 Mar 2024 12:58:29 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>,
	"Isaku Yamahata" <isaku.yamahata@intel.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
	<shuah@kernel.org>, "Peter Gonda" <pgonda@google.com>, Haibo Xu
	<haibo1.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Vishal
 Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>, Vipin
 Sharma <vipinsh@google.com>, <jmattson@google.com>, <dmatlack@google.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 08/29] KVM: selftests: TDX: Add TDX lifecycle test
Message-ID: <ZeFgdUdV0fAK2Cq+@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-9-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-9-sagis@google.com>
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH8PR11MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f0c6b9-8149-4bfd-da3d-08dc39b06736
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4oh4jLeg42WjBg+gKLK01ZDUaTI5TQ4xaKTsd8Q0JTZaebIaF6QS97KfxBjJCW623j+S3KpW7SYwNY3OAIOFbZC9TC5g36I5U+HUFYZNv2N5HOEocExp12u7p5jHLU+32V3qItKtTGOnxbVTxQLc7yk3fyHDZJ3WtiBa92S5S3flRbGb18H/VZCuNMFuFnzB5gGtAyH5Ixnz5kUGmj7K8xVqAlMqVP3vXkEjkwciza1BYmDy65+6ZVszuQppriA179ZnfVZGqQSRxAFTVfeyFgFfuLddkAxZ/tPkvJJVlnvshj7PZ9dnSoke3/iOhoweMKc86UjM2ZJzq8kFHMPCxoL6i4YxJDOjVuFcbOXEH9RtGQUFvuxzh3HcvZIpWBv1dcI0tqR0oZiO7TAnGoaDpYKRJEJtOVmc1Y+4/R+FIraB8ztgHbMVyPmJiu2xkn69JnHGmyIPHrnoVOqhYoYXg3KMBJE4rf5CZ7dlSfxIOVp77I9z9kT/CpzedyizOyxbhZ02cEqC1kO71dB8NENj1hsoF85mgQHVE/n4i0gNFO+HxBJOpq7ipIP/k56pX73dOwtxyp9na3Ixfiom9Ewx6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PGVJwyjN77NjhWJbSlWsWYKpdhml03xzBE5PuMhN7ViaKmm5GXzE59EbXKBT?=
 =?us-ascii?Q?dN/kp7CTXeXIh1nOSAUzYkdjhzgmTaLxDWm/Ao+ma9bHY/pyT/zFN0NFSHV/?=
 =?us-ascii?Q?Qi5Wu4IKTsBmTJ5w0AzIJqQldwyxobubayYlBA9wK/vn77aCnkvYniIBSL5e?=
 =?us-ascii?Q?z4bp/gD+YijW7fZ2KnGxujyukS2PQRmKZZtcWEfvK9ZkzKt0IcBQhyv7jRwQ?=
 =?us-ascii?Q?oFqKcKZ0Bq27bDBwe/MYgnaTGldOjzHJOR/zNV+0o8WFnbqCND2dTG1DaMDz?=
 =?us-ascii?Q?BGevYVWepov8A2hvEGjchFGV21g87amlYhl0fHKAIX9KNbnRXkhnbtiHs4iI?=
 =?us-ascii?Q?BDZ8SDGktnEAXd6Hg9hLDFgscaYCXvy2umb5e03rOePSkx+1cn9YZu53dn6d?=
 =?us-ascii?Q?4GvPGjlJWuUMv8TyDPCCaW1tjkIe+PfEeVr8adf2kzVreoXr2ojTQXXKoRWG?=
 =?us-ascii?Q?tshsut1ejDV0JtzxaDe6KI7lspWyJSri7Gj1adNh6tDB65cyGErP+DWqp5uy?=
 =?us-ascii?Q?qvCgu1iWPLYEKjt+AMzaX1tjZ3deeWk8VbszvZBBIJtrbhOd1F5AimbrC3CZ?=
 =?us-ascii?Q?YU+HTNNVDIgWpg7v8w5NkpyOYH0q4X2jw39UnOWdK6jlGZ2ZHSxNK8gAluMU?=
 =?us-ascii?Q?Zl36g01QepM3G4hbVy3UnkhKvbRAgx+XkNNuRRNby/r5kWEJO1fFdikS6Niz?=
 =?us-ascii?Q?gi7GA0666G1xuheGSkFyiiiCJLIogikbnJODT9rT1+vz+8FsB02SJwRuPwAt?=
 =?us-ascii?Q?amPm0hYK0lNjy47JRbA0QQSOeJidNXoQ4Z/w5xctmoOP4PCRkH68KdZb3GKE?=
 =?us-ascii?Q?8Cavrt98TEdxZRiQFbVySTFqmWxqLEeZ0WCige0dhPV97bm4zXrr8LVnoiYj?=
 =?us-ascii?Q?BUyjmqr+XwKKnC1OSNdGF4Wje1Mx2EM7OwB0vZsXUddXLXm939d2pori+PAM?=
 =?us-ascii?Q?rIMfbK1G+D9dNxv5JVX3UJXaLva7XM8UWF3U8QrNa6XGS2RFbJBbkVFx5gzJ?=
 =?us-ascii?Q?tx/oWnun3d4LHb0p0d+ffLTxkqPIM9oYknwoqEzVPpnyxnsWgQwrVra2b3vD?=
 =?us-ascii?Q?UJW0LmgiWlZB5TFJe24L7URTtF6u4iyK072phGqXO2+FvKu8Fz06tgWEQmNb?=
 =?us-ascii?Q?gEF0+vn2c6wYLRTw6Jp4rwqmVOI3RRGVq+zu7BhvK+YK7OfUTNTAnVhlzf7T?=
 =?us-ascii?Q?PSFfD/odcZIMQKk9svoQ+MFDTYXattgDA+gMh+tj9Up+aFlHHPvZRBDb3Am4?=
 =?us-ascii?Q?9/U6tqvPMHGS4uHL1eAyEazq9dMywxaVsYgIhudoNuykuEnkA2rT0qaJyof+?=
 =?us-ascii?Q?39BLM3SicAlcOrk3cI+T7YnQzT4FlwMB7Z+uSGEJ6TGxuBMnxkK4PnzCj8dW?=
 =?us-ascii?Q?beDtziv1dXrZl04fzJNUz4wVwhCvIwORmTx6HfbOLlo1JV+mf/obBU8LfEjH?=
 =?us-ascii?Q?bfTSDc5CbGhJKQbTRz1oM4MBV3knq8V8nSksDvxoOiIC+D0CxX2bt2XG3iW6?=
 =?us-ascii?Q?YrVwFL5/Wsj4TojEd6rjJ2N4yTaR6arUNICd4g8qlq6EZF4W5TcehjjelhKz?=
 =?us-ascii?Q?Vu7k3XdVwxyAVIu7GhLE5OWqAAZ4v9kgRSNGxdgJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f0c6b9-8149-4bfd-da3d-08dc39b06736
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 05:28:19.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLRNc9s8yk1IUD7qGbisK1TN0I4D4LR54cz9C503dd+I8WCOFTx7qck0HZOqyEadP8ax0Fbha8lVkxlT2Knydw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6925
X-OriginatorOrg: intel.com

> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
> new file mode 100644
> index 000000000000..df9c1ed4bb2d
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Adapted from arch/x86/coco/tdx/tdcall.S */
> +
> +#define TDX_HYPERCALL_r10 0 /* offsetof(struct tdx_hypercall_args, r10) */
> +#define TDX_HYPERCALL_r11 8 /* offsetof(struct tdx_hypercall_args, r11) */
> +#define TDX_HYPERCALL_r12 16 /* offsetof(struct tdx_hypercall_args, r12) */
> +#define TDX_HYPERCALL_r13 24 /* offsetof(struct tdx_hypercall_args, r13) */
> +#define TDX_HYPERCALL_r14 32 /* offsetof(struct tdx_hypercall_args, r14) */
> +#define TDX_HYPERCALL_r15 40 /* offsetof(struct tdx_hypercall_args, r15) */
> +
> +/*
> + * Bitmasks of exposed registers (with VMM).
> + */
> +#define TDX_R10 0x400
> +#define TDX_R11 0x800
> +#define TDX_R12 0x1000
> +#define TDX_R13 0x2000
> +#define TDX_R14 0x4000
> +#define TDX_R15 0x8000
> +
> +#define TDX_HCALL_HAS_OUTPUT 0x1
> +
> +/*
> + * These registers are clobbered to hold arguments for each
> + * TDVMCALL. They are safe to expose to the VMM.
> + * Each bit in this mask represents a register ID. Bit field
> + * details can be found in TDX GHCI specification, section
> + * titled "TDCALL [TDG.VP.VMCALL] leaf".
> + */
> +#define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
> +					  TDX_R12 | TDX_R13 | \
> +					  TDX_R14 | TDX_R15 )
> +
> +.code64
> +.section .text
> +
> +.globl __tdx_hypercall
> +.type __tdx_hypercall, @function
> +__tdx_hypercall:
> +	/* Set up stack frame */
> +	push %rbp
> +	movq %rsp, %rbp
> +
> +	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12
> +
> +	/* Mangle function call ABI into TDCALL ABI: */
> +	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
> +	xor %eax, %eax
> +
> +	/* Copy hypercall registers from arg struct: */
> +	movq TDX_HYPERCALL_r10(%rdi), %r10
> +	movq TDX_HYPERCALL_r11(%rdi), %r11
> +	movq TDX_HYPERCALL_r12(%rdi), %r12
> +	movq TDX_HYPERCALL_r13(%rdi), %r13
> +	movq TDX_HYPERCALL_r14(%rdi), %r14
> +	movq TDX_HYPERCALL_r15(%rdi), %r15
> +
> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> +
> +	tdcall
Looks there's a missing of definition for tdcall, and will produce below
error:
lib/x86_64/tdx/tdcall.S:65: Error: no such instruction: `tdcall'

I pulled the code https://github.com/googleprodkernel/linux-cc.git with
branch tdx-selftests-rfc-v5.

Fixed by adding a line in tdcall.S in my side.
#define tdcall          .byte 0x66,0x0f,0x01,0xcc

> +
> +	/* TDVMCALL leaf return code is in R10 */
> +	movq %r10, %rax
> +
> +	/* Copy hypercall result registers to arg struct if needed */
> +	testq $TDX_HCALL_HAS_OUTPUT, %rsi
> +	jz .Lout
> +
> +	movq %r10, TDX_HYPERCALL_r10(%rdi)
> +	movq %r11, TDX_HYPERCALL_r11(%rdi)
> +	movq %r12, TDX_HYPERCALL_r12(%rdi)
> +	movq %r13, TDX_HYPERCALL_r13(%rdi)
> +	movq %r14, TDX_HYPERCALL_r14(%rdi)
> +	movq %r15, TDX_HYPERCALL_r15(%rdi)
> +.Lout:
> +	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
> +	pop %r12
> +	pop %r13
> +	pop %r14
> +	pop %r15
> +
> +	pop %rbp
> +	ret
> +
> +/* Disable executable stack */


 

