Return-Path: <linux-kselftest+bounces-5920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4590E871E1A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 12:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3991F274E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3068156B8A;
	Tue,  5 Mar 2024 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duVoZa9S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E34C59B5B;
	Tue,  5 Mar 2024 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638754; cv=fail; b=ry08swafRlzWPFRIHkSuIaH8DfLLjpKdO+5qEl07LhvJE3r7abL2Auawz35qGw+HUdk+1fqgEQ/z97vbLd+pyWTxpamL9d445U+7ENSes4ch6IK5hkcP1Vy2rOPN9pL5+kPwnJreTWYbvG2LjDWkZtWkWWMYpcTd97ZrspGZ8/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638754; c=relaxed/simple;
	bh=DeC0cG/7DRQIr3reOTuFnloEcg/bTFTtFYm8UX00WMU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dGStHnSUvwbWUILQD49USV6YY7hrk4I+/djTqW34PNZTRSPDcg5NmRjVOZN/xbicPnnFOJQz96f3BmGldprF803jYZGE5mwI7J38tGq/02V8RnYXP7IFd1iA4M7LB/HnSWXQ3+EtmxjRl8X5YXZXiHLpVSOC1bh85CLlwWE6pFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duVoZa9S; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709638752; x=1741174752;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=DeC0cG/7DRQIr3reOTuFnloEcg/bTFTtFYm8UX00WMU=;
  b=duVoZa9Spt9X0yavvsMru8cyODqZtyeILpP17aWeA2qrmjREKHZiJQIx
   YEbLwlp03uEAUrRmuUNr2ZhGIy38DnguDcv2DIDaLmnWpLaaUeT46H7UB
   UPI1ouiiZAQgalPEu1Ej1viTTRUvEZc19L2tYmS91QpVWBFrDWlQWdmOy
   oeGpLNAPxgPoMRLSP50h2nJRvoHG8zwbIXLLqoiT29aYCPW5WUNcOsgLp
   4bvQKs1VZ0reKEHsJDi7kATCbJcPjAZ+Sl+veDuTv1qVe2bx3x1zMImxo
   VCO30/5kl7YbCQ4Wfbbbn86gqNPiw7kwKY11+6XCe+LpxXpMdHZKlnilA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4043251"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4043251"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 03:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13833260"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 03:39:10 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 03:39:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 03:39:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 03:39:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAl8E+oh8JDKTiKs/4PZngBauEgcs0Z6Xv1sUxF5lFKaYKs+dskjDCVrLK90T9G9CQlRkoReZDVkbdiFCwofPnwNRzqUgZPboLOh+zPfKDQ2NT2qddWlI5NJ6V6hq2gvli6Kuog9Xjr3jp/VbcZAtegm+IyPoWxcISuu1RuEjpUYXiuMj3C8hAO2Wq1vmom/ttNTbBIB9h6FpUX///cplHDz7bpMC0GaurskZLNdZsZQc4mJMXlM7rpzxKO2K0DSSDQMBO+OUD9b3BygQPggmOavBuk+0Xtfu0YpCL0jjcWzHBjo2+APnMPQLcKISU5y2WWK/vRfPdR3k+qQjelJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K26aNhBJ5GVhE6FbuPTzk9IPtvjjs7rs5TGsNhGpNfc=;
 b=nDuBfbqXmDYD/YAFLq8J7mJwi0HQZlD+nhO4rjFEixPbP8RXC8+YRCFWLF6il+E9IGvQOPVCOm1OeComqm/bPvhExxCXKeOa7AtVHVpFZj3Ow3GZ26KPzEEymsPPFdrCHbmu/reTMBg1qvidp9bR4eSHJ9XcAEzjwXT6HOzB1NGSOZKuaKbXkwzYp6C9+4L3D4TOPi0Egm2tt32DFTurlTf5PCgOTpo6SVMSQXXtwPrZI2rzBFBUEe0glnR7dQpUBIGvD+vWXe0/+5uZuUXOU1o5b1cfVX0PkEJOkctM5pnLUuiU4j89ivLjI20SM9TYKYmlg8jsNYGULL/7LnYLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH8PR11MB7071.namprd11.prod.outlook.com (2603:10b6:510:215::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Tue, 5 Mar 2024 11:39:07 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 11:39:07 +0000
Date: Tue, 5 Mar 2024 19:09:15 +0800
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
Subject: Re: [RFC PATCH v5 22/29] KVM: selftests: Add functions to allow
 mapping as shared
Message-ID: <Zeb9W1ig6dFKXAgj@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-23-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-23-sagis@google.com>
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH8PR11MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 037e96c1-0d2e-4dfd-2c2c-08dc3d08de02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/SwQ1dqwpvAeguIwH2ZhLmuligiI0gCiaSvTU5grqguf+7GXKAu0wbjjsICNPjmQsHYJ6aqIXXCDsUgFSbIzczgBvHcOEEa92EZV/BFL5pn73XUERuuxI0upDo+wywDNrNX1II3NymK6H4yCnFC3tyguw0E8MjqNS8Hj1lwIkiWVHMVPxyRN7ZPCbOZdNjGji/EILFOgYhoehX/r7z16F3w48smQTikAeJ8j/3MxgiIIDTdSxiksrG6CpEmOPQqanfvNIy0QMdwIbW313i9co3kszAJNPfg0FE5HFMvk5Hm5yfIO5Z0TtyblNZf++fDA0bnvtng43zTBmSzMfR+aN8m7fttMRmoCyebgBni2O4Xw0NUqFtIR+ntHFeeHADGyeqNw5LGP0urqZWAmPl91xk705hK2B0lf4KX3xp1fvMI3oSZHGXQslVksP1xnIWSNcSP9oh6N4n+JzUyNIkpWWRUVuSetJ7a7IlxgDt0PUz7MpLJsW0MGjpVnKnC57F4lyOyKM3kt0sT3utjrOyV0h7K3ATnWEy/5vKbnwh2S4weu83OM9vBBJ20aDokTGdwFGQOa0qP8FB8yZwBZDeHjjz7+HcwnSdmp8ZnxxDsNTldFbNlVrHrozSFr0ELDH3cfFK6SkHUS6GGQekoV3YOlIE0ckkEbqiB+I7c029N/qM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pdmVSu93Kqt0/9kDeV+FEtcHVGyk2T++tm42l1V7hSMSDwZEZ16oS4Ly3p/q?=
 =?us-ascii?Q?0Oxl5LUhuR8lJN2b96tLSM2hEVJpnDpL1VO/OZ5HJxD+Ozft6i7339c/Yxq4?=
 =?us-ascii?Q?P4D8GzTnzlWrlKnvWIim5RYuzhcq3/NGQGE0k8D1wGML2ufcSLETX95tR7v1?=
 =?us-ascii?Q?sGftuYVQrqrqYr/cilcq7Zc8Zq50iDfWdlFyru1DU3cA8tXiRN9Mq/Nttkfe?=
 =?us-ascii?Q?9yvtocTqYko03we2sNhp7nswl3PUUoWCJZ2OLU0YQdKxFIGwb1jh1W/xGQYE?=
 =?us-ascii?Q?kNQBmmohQ5uONaLIrNVbuvo2W8N/wExkIWYt918gz5yIkOdJ6KCyrN7yOgFO?=
 =?us-ascii?Q?AbJlZS+h7uRsQNJ05JVGMm8iyubBNMDkoAl9649pSvWF5DYBDngN0nO/X+D+?=
 =?us-ascii?Q?ijT2Ur/51JuQ+6eoSeVq0yXlY+Y62eRGYZrXg02roF58ypTeZFPDnkfHid0j?=
 =?us-ascii?Q?iIfJK9O/nh4PAG19ofyRSw2sM8LMtO0kwD2+819b4nNmCB0m9Wje5uJjO8I4?=
 =?us-ascii?Q?kyKvpZJP2gSdkMaWke06OSTbMT1A4ZVrBojvn/HZv6INOvg/AkI+rxPe2pZT?=
 =?us-ascii?Q?SpLHQp6wrN3S+gZR8YifTYg8IIn8gel88hkKQYvVdBuwF61tPNKBt6qoLJmF?=
 =?us-ascii?Q?uzC42xvZy81uy7S0J9m3B6+DiYACSZxtsJRWot8yuKFbW4SvAJwLxfgQj6s9?=
 =?us-ascii?Q?/ZEcFl5+OQwwvehL3LlkG5kiTAxoz7a8ynkh8XVN+tJ6e8trogzR/+uIk8yt?=
 =?us-ascii?Q?QMknIufhsZij/aXHgU2QHiMG9q+I2qnKTa38U2i3ChHR1tXiM9CmEv33L1Qx?=
 =?us-ascii?Q?7X3hAoaSc7nbSq3pmLsJNyYbziA4jWLaiGO7Si8AHyU9//xbiSJxf+FcTfUU?=
 =?us-ascii?Q?Vk2CxYT9yPuIk0TijDa+l1h0HKFR5fSomLSOd1s0VIUoVtEc/N2nIxvoDvxx?=
 =?us-ascii?Q?9OXDW5MDGHJdTL7eVYcISB7NmbM8T+RRe+LogGOQbZlHgCUhLC80vHhpJ1fP?=
 =?us-ascii?Q?ezP77x3zEMpJMMS6TE4JwlBSn0V/pBE4JS/GYC55DI8BTsi26ya/pdVAYPfa?=
 =?us-ascii?Q?a+darqnjhLrqZQLS6fNeRWWyrMBJvoqccoVwhv1swkxVuzviUf9Uuvbq9mAt?=
 =?us-ascii?Q?fYIVvwF7o9CAnYo8JRiY3VAwU57asbTtnvG9cBrhZb34/TZqvbzHhYIOmRL3?=
 =?us-ascii?Q?frfeQzKTGD+mp0Vr6D7RmL2KHjTrbnaobsgF3UYsFlmUaOzYupfNEZGtHN3d?=
 =?us-ascii?Q?tG3wKY3Ir6VU0lGp+VPMWEM9DnMNNBb3E2hsGw3TI2+WWWjb4pzYXPYRXv2/?=
 =?us-ascii?Q?0OjdDJ6DQGXo1CbWZwWVtemb7FrZYwezzvR2773YEt/9bmVVxl5a5DztPft4?=
 =?us-ascii?Q?j7IoRULSGiZreWFMJtWEyeHrnoPmx8In4aNNdwIxCElgo2vRBmxl25yGFf+G?=
 =?us-ascii?Q?xcAzvOcFVf7y6iJx5ufY7ZwIm+P7XDJQ2pgOqU1wMcFa4kEqPgQxLeRV2HNc?=
 =?us-ascii?Q?dxQwch89yXLA+XuuKiLSXBoUqCjKUUKVNWczgAPLaeNAWxuagMBNV3UeKDH9?=
 =?us-ascii?Q?mj0Zhr5ipvHqUjgoqc017r084OrrsNCx/kvcx2ig?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 037e96c1-0d2e-4dfd-2c2c-08dc3d08de02
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 11:39:07.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXpC8icWmQgRUZ1UOCyrXTRmPpV0jag3xRs7NfYhFLYR++oBY+BlfvgLKGLzd6iTxxiXJ1qJdc2I9oYgXJfsAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7071
X-OriginatorOrg: intel.com

On Tue, Dec 12, 2023 at 12:46:37PM -0800, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h     | 24 ++++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++++++++++++++
>  .../selftests/kvm/lib/x86_64/processor.c      | 15 +++++++--
>  3 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index b353617fcdd1..efd7ae8abb20 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -574,6 +574,8 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
>  
>  void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  	      unsigned int npages);
> +void virt_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
> +		     unsigned int npages);
>  void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
>  void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
>  vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
> @@ -1034,6 +1036,28 @@ static inline void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr
>  	virt_arch_pg_map(vm, vaddr, paddr);
>  }
>  
> +/*
> + * VM Virtual Page Map as Shared
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vaddr - VM Virtual Address
> + *   paddr - VM Physical Address
> + *   memslot - Memory region slot for new virtual translation tables
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Within @vm, creates a virtual translation for the page starting
> + * at @vaddr to the page starting at @paddr.
> + */
> +void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr);
> +
> +static inline void virt_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
> +{
> +	virt_arch_pg_map_shared(vm, vaddr, paddr);
> +}
>  
>  /*
>   * Address Guest Virtual to Guest Physical
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 4f1ae0f1eef0..28780fa1f0f2 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1573,6 +1573,38 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  	}
>  }
>  
> +/*
> + * Map a range of VM virtual address to the VM's physical address as shared
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vaddr - Virtuall address to map
> + *   paddr - VM Physical Address
> + *   npages - The number of pages to map
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Within the VM given by @vm, creates a virtual translation for
> + * @npages starting at @vaddr to the page range starting at @paddr.
> + */
> +void virt_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
> +		     unsigned int npages)
> +{
> +	size_t page_size = vm->page_size;
> +	size_t size = npages * page_size;
> +
> +	TEST_ASSERT(vaddr + size > vaddr, "Vaddr overflow");
> +	TEST_ASSERT(paddr + size > paddr, "Paddr overflow");
> +
> +	while (npages--) {
> +		virt_pg_map_shared(vm, vaddr, paddr);
> +		vaddr += page_size;
> +		paddr += page_size;
> +	}
> +}
Set vm->vpages_mapped as what's done in virt_map() ?

> +
>  /*
>   * Address VM Physical to Host Virtual
>   *
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 566d82829da4..aa2a57ddb8d3 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -190,7 +190,8 @@ static uint64_t *virt_create_upper_pte(struct kvm_vm *vm,
>  	return pte;
>  }
>  
> -void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
> +static void ___virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
> +			   int level, bool protected)
>  {
>  	const uint64_t pg_size = PG_LEVEL_SIZE(level);
>  	uint64_t *pml4e, *pdpe, *pde;
> @@ -235,17 +236,27 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
>  		    "PTE already present for 4k page at vaddr: 0x%lx\n", vaddr);
>  	*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK | (paddr & PHYSICAL_PAGE_MASK);
>  
> -	if (vm_is_gpa_protected(vm, paddr))
> +	if (protected)
>  		*pte |= vm->arch.c_bit;
>  	else
>  		*pte |= vm->arch.s_bit;
>  }
>  
> +void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
> +{
> +	___virt_pg_map(vm, vaddr, paddr, level, vm_is_gpa_protected(vm, paddr));
> +}
> +
>  void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
>  {
>  	__virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K);
>  }
>  
> +void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
> +{
> +	___virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K, false);
> +}
> +
>  void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  		    uint64_t nr_bytes, int level)
>  {
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

