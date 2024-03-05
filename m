Return-Path: <linux-kselftest+bounces-5903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6987F871994
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205542831BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA0D52F68;
	Tue,  5 Mar 2024 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgsHeO24"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71850272;
	Tue,  5 Mar 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630912; cv=fail; b=kIaiO5qtsgI9zZDf0PC6YfKN92o9H5A5IUhn1+V+VWeMwI1eL44TVZplntccVc1+ommLR+NOzmyjEXrSCr8RgWiP5lnbC9VJAjG+SGBEiV9mKtWkWHXl+ku8DVCztcCkP3nU5vxzKJFG4bH2fgYegDxtEJ3tVHmwPeP9jzxPHsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630912; c=relaxed/simple;
	bh=GFF4dI6qo3UOfQAqNs9oQ4Kl2cnIazqyOhzCP9Z2HNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SZaDO9JfNsFyxK900dh5NxwW/NRCh7IqBWsYqmzXPWV9mEny8lT1asq0SPk0ZxlLT2RJQ/UVm1Q+/9ymEKyGQGs7uDAwcw9JJS18fJrpE3Lv2WgCcADNQYTQCxHqqxLIR3IO4Px84Yfl8/2u2M1SxwCjCTPA+W/t8zLIX9GJ1OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgsHeO24; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709630910; x=1741166910;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=GFF4dI6qo3UOfQAqNs9oQ4Kl2cnIazqyOhzCP9Z2HNY=;
  b=ZgsHeO24+WPDaHh9TT/odGxfax2sS/715JFA6LRoMzpTeFtyytmKDzNR
   nVgd0C4dTlNgyIiEctYp7ii0KUV86UF+0dVe2JF+FRuTUfsfXhuM2o1Lz
   BBl0exZzijrGkj+NNBExIRHh8dbQ1Q3HaqYxv/sOmovfAP5Auhm0mmN9Y
   dglkuwjliknAnG3JtHzCHHoTDRWBK6fKV5ybZE2sNntvl7gzTotn7YO5F
   biBnf8Xrw1gzWgAmK/33eO9U6Zu/5uG7E6Irj/AiLEK1EEASbNzvO20pC
   QirM/1370ByXuxCKA2/7oju4in/hP/dx2eXRiUcdqQ/NKFUWJpXEQFzSN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4051565"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4051565"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 01:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9283511"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 01:28:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 01:28:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 01:28:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 01:28:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yms3pflbKiifQ+bWRBotRxq5nH3ATXO+ebnHyAxDUBLDrtqUQ5mNvAqG5gKweWaAEQEltzpyxeztQ5ej2mhss91OFiRn2aKvKWnapyqoy+BZolDguAhNnX9B7L5sxwV2BlZ80xVVO0cm8EO8dgdx5WT5X6pfQ3PULxyqRDp69vz9tFH+jSjXmGAFt8Miu00fc59mhZLgPpzYqoRaoxDHlVtWeAMLTKOfGn9aym3FtGVh/t9dFkRIFE6cwqD3l7wFA0Qps91Fjm52OpZoUYqvyoPfHWlNjeXB9TKnglW/Op0oQ8GpEjBLgm7aXI3/b8BAejtwyDM7J+ecjLY7eQrexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax8BDS9amfusw/1Rt1quZGxcjaSjd6GC0LziaeXmbEs=;
 b=CE0IuAYdVMmbOQ1/Q9qlUX7uv6HXnLNxbnSIsMEsHDM0RCwlVRBo421LdhJFXiM9//BPhi3aki9qczOX+wFGdndbSsfg1gfi0taKANrckFcYSXFUQ5FxYVSHXHrm1cRJ6tg/cE4Bb9+llZ7DOTHFGl4AKt6n3+GHXsHJbBZpxyfqrWJp/eqpFPWL4YCHR9XTYY+IcY7mIJ6Rue75QgBDbKZ6YIYZZCj9SHgTarGR6m/ZZhp1jz4rX/w9/RE4WnBfPTP+dvrUtQQnO6leeSzVoD4DIjTVDAEhilfv/WejE57WldjmhwWXbCK3bcLpfgCnMdtDQjS4J8i0T2CaAaQBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH7PR11MB5795.namprd11.prod.outlook.com (2603:10b6:510:132::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.22; Tue, 5 Mar 2024 09:28:25 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 09:28:25 +0000
Date: Tue, 5 Mar 2024 16:58:32 +0800
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
Subject: Re: [RFC PATCH v5 18/29] KVM: selftests: TDX: Add TDX MMIO writes
 test
Message-ID: <ZebeuMoz8izs/SoG@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-19-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-19-sagis@google.com>
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH7PR11MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d80991-40e5-4bef-0472-08dc3cf69bd5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAXgnq32TWO8/gAZ+5pPS/6MSs3TVmZi62OSf4/CUC1y/o+gWp9tVjSkuM6SkfDUSLijHJmUZnrK+5CJCrrwByba0GVz43uWO03O9wNPklq1V2dABmFFoyQOlmgJ3bLzWaKO/ERX8ptceYfjGLAJhla4HyaKNOOlYqa6xe0qQc7amen97MBkwNzyh7iLt9rE7p7xlOVizK7uijRCeuASrPipN5znn2+UGGWUPiK6aHo4c3uOjwWtYX+2Qp1WbgTamMkx9hKvm5qVsKDHwSxDnkIRiuIbr6G3njn0Jc38qgfqxzH44OKLVdp0vNuGjWEZfY5ElzZIduVn5yWdu2aRyGw75HtKSYWCzqvnDr3RnaeGoRHe5rsmIcWHXd5zx5BzEIRj48D0YPXtf0XmPDtb8mphH4VEJKLUFl466pQtZcOwWlghyZXtzLZwDQ0GKwmZHWoPvNzNOjfBCL7s1pu83FYs2+4eKg3oZGcQvDiO8xnwPwRq0rimCN1YWR625SQVK0NyjtbCpDyuGoi8YynWZxBKqFw0z88op1KQzRoeJGPocBQhK7kBH07daBpbdI/OjUySr5vWFxS3uDZZm+bzmLxCR5oOVePBAh7XXWkkQmOECi/aLP2t/tbZPyFyJkO+6goO7A9USp28sgbqCIe+0IpMh3kkja3d0K+Zh26AwTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?55tDXJXnZkwUZ6s26DzYHKD1Ck7LQnTQohGxVBQAwelp2h9ExoeAl0dfnFHt?=
 =?us-ascii?Q?OcF7NLM5fg1tXKyFxQe03l9swNxUqdCNd/B+EhzuwNnRfAKEHGK/LsO/awSd?=
 =?us-ascii?Q?E/1ST74revbF/CXyJUtFl2HGO6NUboc+zOgkUYlW/S9Zb55MOZhFEnn19UqX?=
 =?us-ascii?Q?8zcAM7US2lck40d003yesSWjqZBftFGUDcGovaqo7C/PeK1ZpWhI63Qi1bee?=
 =?us-ascii?Q?xuIHFruG7NMSC95yLuTg+xfdVK46jiP4vQIuxnweODGfFmeEkvcSncNJKgVz?=
 =?us-ascii?Q?CtIQcVS20dYVAwiKAtj385RQSQ3mNtNg0wbn+lROXtCL5K8VzeB1I40FDe4s?=
 =?us-ascii?Q?A25xH8u4/ccsn6BjaPDsTIgFLXvhp2aKhEVAmzno020pw15sy5y3mDIMvrZr?=
 =?us-ascii?Q?HG7weA2wdkoJHLUpo3ts9VmrJ4HFeJupzg470nMoDK7jsnJHfDAf6Ymt3eII?=
 =?us-ascii?Q?98CVk+BhjWYghUAzH/iSMztzUS4XO2s96wI7d045HJ0wIyx4J82z6XaCuIXy?=
 =?us-ascii?Q?WzjPvBZkdWMBlUJqhPjg+EtzSacQPUj4X5J0c+xIpZrsxwxm1Mv1xAK4zsi8?=
 =?us-ascii?Q?piqzeJQ2qigy55G0GmK4vsrsSI1Qyj4zWRiARVv/k/5dp0SDAZVkkpGwzkWh?=
 =?us-ascii?Q?1jq/aSI9KfSNcTw+pvMfwaSyryd1TT+dzi3Zx/lfJ/zfvtPRn6dpxLFVoaqH?=
 =?us-ascii?Q?D3M7NMlK3gP8zKHw2QUZdDshbiuEFPBXo0t4lZyvjbr1wjkh+t/HsnZtxzgt?=
 =?us-ascii?Q?2uVB6G+jEwpAKQ6rXmP34dQiBvVSO3LkYGsCC5Ps8O9poPpv49uVWylrMvPI?=
 =?us-ascii?Q?ZUO8aarHwg+MhH5LbjDeg9cUtPNMyNP6jj3T+hh2kO0yzVvBMYM4PFwoRXMO?=
 =?us-ascii?Q?ZnhcT8ticVXG9dfgekgPLDKIHCyHKzQ7Bq5fL8SW0Szva3Jr4V6K5JDneCYw?=
 =?us-ascii?Q?yUjnDd9UHe8Em97W75bUukU473Lu9sGAOGaYRm93qiU6HSzadXpHPnST7psu?=
 =?us-ascii?Q?QZ89qFBEVhnzSebP2E/Rgm/HujNv9+po2P/Yv7+vLce56H9G9nP8A9+l608C?=
 =?us-ascii?Q?XFMKXO+4gpgGm14XZZ7cZ9tef3v1Tq8kM6KYoS55M1XSKWAJ8HFzFgajVps9?=
 =?us-ascii?Q?6H4TTCL95csuGZrsq/vZO1fDecqbDBejVrMlRt1RuIqCWq5G1rkSW9aowGDZ?=
 =?us-ascii?Q?tojpkUueAjNdXa8MWF3sQEGnY42ToWP/4DSOvdaL/uHI8kcSpsqsNyMVd9+q?=
 =?us-ascii?Q?720e25pzxV2RiKE7I82C855iRYTnQUroiPJhXkb1tBP/sbVisom3IWwIurL2?=
 =?us-ascii?Q?NNSUDtZd4mg4oMwTkd6m74qKAAIO0eZTKQldURmGjhDcJa5JnF1ziaaOOkQw?=
 =?us-ascii?Q?FfOc5KP3yPx2HbtitYdQGGfqGFsHRcsfVqE/7Ze4+vVX8eghVV73LhomfcdJ?=
 =?us-ascii?Q?01u7xHRPsiXtaNeJj4kguoBbbIAW7xmViNqNr1W/tFA7wbZBhUPPIIkR3h1z?=
 =?us-ascii?Q?dC9elubbenTTHsJVJZkufoZxjsuD+nFOjQKM17ximcmIv7Nc13ZEhzuduV9K?=
 =?us-ascii?Q?BPQq/2nn3TXsEIvULmLAfSvMeCcVG/+m3v0lCrby?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d80991-40e5-4bef-0472-08dc3cf69bd5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 09:28:25.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MItJKylEV6cUXucYiUK25iSKA8fuQsjvubmK/6bon4ze9NfqISDQH2CkO6ntJqmZWiadoDBrX6nNz6L4FWQDEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5795
X-OriginatorOrg: intel.com

On Tue, Dec 12, 2023 at 12:46:33PM -0800, Sagi Shahar wrote:
> The test verifies MMIO writes of various sizes from the guest to the host.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>  .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
>  .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 14 +++
>  .../selftests/kvm/x86_64/tdx_vm_tests.c       | 85 +++++++++++++++++++
>  3 files changed, 101 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index 13ce60df5684..502b670ea699 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -25,5 +25,7 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
>  uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
>  uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
>  					uint64_t *data_out);
> +uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
> +					uint64_t data_in);
>  
>  #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index b19f07ebc0e7..f4afa09f7e3d 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -143,3 +143,17 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
>  
>  	return ret;
>  }
> +
> +uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
> +					uint64_t data_in)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
> +		.r12 = size,
> +		.r13 = TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE,
> +		.r14 = address,
> +		.r15 = data_in,
> +	};
> +
> +	return __tdx_hypercall(&args, 0);
> +}
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index 48902b69d13e..5e28ba828a92 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -885,6 +885,90 @@ void verify_mmio_reads(void)
>  	printf("\t ... PASSED\n");
>  }
>  
> +void guest_mmio_writes(void)
> +{
> +	uint64_t ret;
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 1, 0x12);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 2, 0x1234);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 4, 0x12345678);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 8, 0x1234567890ABCDEF);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	// Write across page boundary.
> +	ret = tdg_vp_vmcall_ve_request_mmio_write(PAGE_SIZE - 1, 8, 0);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	tdx_test_success();
> +}
> +
> +/*
> + * Varifies guest MMIO writes.
> + */
> +void verify_mmio_writes(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	uint8_t byte_1;
> +	uint16_t byte_2;
> +	uint32_t byte_4;
> +	uint64_t byte_8;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_mmio_writes);
> +	td_finalize(vm);
> +
> +	printf("Verifying TD MMIO writes:\n");
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 1, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
> +	byte_1 = *(uint8_t *)(vcpu->run->mmio.data);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 2, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
> +	byte_2 = *(uint16_t *)(vcpu->run->mmio.data);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 4, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
> +	byte_4 = *(uint32_t *)(vcpu->run->mmio.data);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 8, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
> +	byte_8 = *(uint64_t *)(vcpu->run->mmio.data);
> +
> +	TEST_ASSERT_EQ(byte_1, 0x12);
> +	TEST_ASSERT_EQ(byte_2, 0x1234);
> +	TEST_ASSERT_EQ(byte_4, 0x12345678);
> +	TEST_ASSERT_EQ(byte_8, 0x1234567890ABCDEF);
> +
> +	td_vcpu_run(vcpu);
> +	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
Is it possible that this event is caused by an failure of the last 8 byte write?
i.e. though MMIO exit to host with correct value 0x1234567890ABCDEF, but guest
sees ret as TDG_VP_VMCALL_INVALID_OPERAND.

And if, coincidently, guest gets a ret=0 in the next across page boundary write,
the selftest will show "PASSED", which is not right.


> +	td_vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	setbuf(stdout, NULL);
> @@ -905,6 +989,7 @@ int main(int argc, char **argv)
>  	run_in_new_process(&verify_guest_msr_reads);
>  	run_in_new_process(&verify_guest_hlt);
>  	run_in_new_process(&verify_mmio_reads);
> +	run_in_new_process(&verify_mmio_writes);
>  
>  	return 0;
>  }
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

