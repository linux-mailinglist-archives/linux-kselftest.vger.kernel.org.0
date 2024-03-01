Return-Path: <linux-kselftest+bounces-5694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8D86DCAD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 09:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BEE289352
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F369D0D;
	Fri,  1 Mar 2024 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNoEEHUJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97B6930E;
	Fri,  1 Mar 2024 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280397; cv=fail; b=k5B968lVsCjdVFayY3CXr/wphkjK2mr3ySdG+0wOM4Co15rTHKW8jh50Ze2ye0W4HE85NKVNo+HT0qcOFoE7cHEueMczQJMHQrYX2IlnRlqA5vPrkXw1o0YYbgPlmbhrnxzkrFq8Xbdrftej8YwgQuMVEIknFOsKCCI7nU40WFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280397; c=relaxed/simple;
	bh=aZbFo6XpJFAfppkmfJn/pWWENlEJvWU5dL6/smlyP9c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=buaoKM3vK8V6gdUIlkH0bCov3+HVmOkEapf+wSGGb11WElfq3VuG4YUwt9LEFkEr/eQ6HjT/8mRaMXOQmHI9pTSZBAm9yiMeZVGMuXfDQGK4RQkYaH0wHvUqcNtmDEmq20jniSX/fBtBYiv+/NrSSEXdCWKyKUkiy2v85rYAzqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNoEEHUJ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709280396; x=1740816396;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=aZbFo6XpJFAfppkmfJn/pWWENlEJvWU5dL6/smlyP9c=;
  b=SNoEEHUJYalFLFhbBy0G7x2Bdcw7A92JyEfGRbo/PdPRjGx0GPqqh9+Y
   HbQhNEuegwj/0p3P1B9j0jEnrCyVYoTJ1adi/03qzw+Qo8f3ID1a5vbk/
   qnjjdS9CvykakBC0PuDS2eWL4wneVkImpxgc8mNMuQP69MwipnxR19k24
   3rJS0BTzsnDWU0F623W5elyDgQxjncxagutrWhV9llrABRL+D9m7OiJ+8
   MKuKZfXcWmF2RDo6YvxYpiJuaz2NKewA7936T72BJA3/u0wsCmHHNpDAE
   mMQLksIxx7gGqcegan2rCelHTeWMRC+w74FK7b2YBmyyQAYrEyOT8V10g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7620010"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="7620010"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12809574"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 00:06:34 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:06:34 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:06:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 00:06:33 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 00:06:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH2xemcemA6mrSBCRCbAi9r2X42xfm8X2Uu72G+0dZOIFD3L7ueaMJffqcKRuWU17yxXWu/P+YCA25H7yV/G4Oon8bZ6EbEdvphGkaElxq0NvtPXFr8hLjz0mqTesdYub5Z6yomaaAGu2q8edtsnOdGE1KL8gl6OmyJXo9F8Jxj8qtXfpdFszC+XdRPwaFbPeYPZItcOjEdec1Mk4y5xzSNSUswSUO97zi8BqgO4BYKgcG+lAbpFLeBGLFF2eWmBxFeMomHf4jVrP0hxqJbD7i4U+RA2KHhVwVsXYrVfpDqavu5PvPeCe9Q5EaSlAcg3Px3d0CAzyH1fGb8ZDOuXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f4oSD7xcpbYJEjjiqfWpvtBWkADHjXhSQGmQ4skr9E=;
 b=WqwKXMbfnonqe37+kseLkPRKSvpgYoVL6jPZvvzLgpMQK9gRN1EHjMZ9mEgrwv2bL+E0okQFo5yYqutwRUMX8qjdp/DEltv5CC5cZoe7+VvFj8MCJ+62Gt08NTIkmFb2gnAR3LmDik8mXjIFtS7p3ypChehjXlBKtTOGORMis4OTppPlxtn9J++7pFplYcdDQry33zMfvgDZtDOKjU0gf65Sk9WzYC9TOpgJZUbOwsayQzIeSfd0mtguOUF7JEn/xRGaUUu6fdwuRKK55LtI5hiHgNgNxCzzM2ynpzMA4anoNJZrUaywMCsLOoxCr7RtBz7z9Y6HtsUBwgCbYbt/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM6PR11MB4546.namprd11.prod.outlook.com (2603:10b6:5:2a7::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.25; Fri, 1 Mar 2024 08:06:23 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.013; Fri, 1 Mar 2024
 08:06:23 +0000
Date: Fri, 1 Mar 2024 15:36:33 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, Isaku
 Yamahata <isaku.yamahata@intel.com>, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter
 Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, Chao Peng
	<chao.p.peng@linux.intel.com>, "Vishal Annapurve" <vannapurve@google.com>,
	Roger Wang <runanwang@google.com>, "Vipin Sharma" <vipinsh@google.com>,
	<jmattson@google.com>, <dmatlack@google.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 08/29] KVM: selftests: TDX: Add TDX lifecycle test
Message-ID: <ZeGFgQQU2WL7PUO9@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-9-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-9-sagis@google.com>
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM6PR11MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ebe84e-d5dd-447e-a89b-08dc39c67bbe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krMk1eCIr5ha77MEXC82+NuFWxNGnGB8XYnmToaFDjcGDEBiuTTCKN47hA9hk9OSDVqr3p1lIfVCTR8rJa7MzTbUfqaUMa6eIg3LrCMyUAGviT94C/+d++tWISGs8vx7nkkueOlEqSV0zmLVA87SZNSHZE433FjlK91vbRWpDHV7iY8Hk9xLPi+Lz6ChYyMZlZKFzFckBboXTtqPCaATj07VXINkKgbWKYsgQ8Pp5eSWaP473R5NOQVHmt/T8NxwtPzK7lH3eLi5ExoX/wn/wG3jUHtZma1kBKPCAI2i+3GXx5zgEpl5PTb5W9lP6F8ax1yX9rSpeI8Pe6J9wbCDNY+UOlIr1PcioYZmS6de92p/J8q7bRJiXQyIx7XGeH2QKePlYMhR24e26tieuqWdviCw9TYBT0/KNcGhqS1m6FdTaG/L/skTcSKVhylimS/mMdlymBlr/UpIzGFv/4Qyg2S3uBt0xQBb2KhdZZXeQGuiSHY0p8Q5fznk4PlLzlAwLK61syyiXr02ZYjnggZqVsdDEVkhmAZWrV15pdAfVfAXoumnR8yJcjrohOYz28T5Z9oYDLGQCE7dMlE9ihI7kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oPzGd1vgagoMWFlqMUhlGCoV1dxc5RGoPQXkSLjud+Qo+/YYc7ZG2IUgsBzv?=
 =?us-ascii?Q?iWgEGXBzc8hSYkn3GzyGT9Y4ClYHARHbjwmrGeZJ1aV/nHjBw5+ItqbAHG3d?=
 =?us-ascii?Q?Cy1nHSEzxRF2fOr8WFv8GSpKPSDHcow9rulc3kG/lCL+eIHv+irhIV52khzh?=
 =?us-ascii?Q?7A0p7Vj15VelaEC7Mk1Ku7Trsa/+QhJt/ywEbdqDBmrYZvd2EZEHKJZBi8XF?=
 =?us-ascii?Q?aY1rrewjz5UGZTuptRXJZhFGPjojjOrkRlr2+GG54vi/WY8qYJ3JmayedI+o?=
 =?us-ascii?Q?2A5CTbPqMmfDYdAUFlj0vKY8IUnmn7174vXwfCoXr8n7AwzOl8klVYmH6XIT?=
 =?us-ascii?Q?AqAgost1S4l0YjLwXp08o6s1vdvG74y9EGX13/C1QDPEeBCYu1ZK0T/Wfgqr?=
 =?us-ascii?Q?QlT+Tkl6QNCIrv+Sdkxnu1aNV8xjNIuX/qS9t+7undPs/MYVnT+dntwh76Cv?=
 =?us-ascii?Q?2E1JhLpI8uzrlGqTkVQpimK8S5HMwqDJn7z5J8Ur34EXslU60Vz6OSyAN5Ig?=
 =?us-ascii?Q?2YfHtwNXqYkd42AsLTc4r4i+WFMKjkzEy3j2B/QxLI2ItL4L0mTsuzrDUztL?=
 =?us-ascii?Q?jSPxbaK9UVShYgR/jJb2ARlySLQB/4nIkoaaRIvv1x7336VFpwakdXt7Qju1?=
 =?us-ascii?Q?cnrpM6SINxxDVjveU128kukxu1rmHRFU3jTfE8wp2rQaYRzwLE0GduCq6eBl?=
 =?us-ascii?Q?5mmJU1ecP0xnDt/4gX/qgC1UWnjfHt9V52uQevGl4Lh4CAzaHWG+C6rlRZZc?=
 =?us-ascii?Q?tbKDdH4A6wqTBoRpwQLqmJ2OpJuHlNlkynvnImaUIXVoWRQGq5EE6/TqnsRq?=
 =?us-ascii?Q?9FR06AVmhED4AzmG3ns6jJjH3a6freRt2bRTAD3P/lxBG25fRthklcYnOwJ0?=
 =?us-ascii?Q?BTEtb4lRtFgnol9VHrvJ57dw+cyrmfkPMjby4OK6KvPlozchC5bydufqKLIl?=
 =?us-ascii?Q?QgfB2/F/hEUMYT+OAYUPzt6onzMFKp/Lx7q/WPgiPcFNLyUd+zgN1in/kOep?=
 =?us-ascii?Q?mY5gOUph2XDBEcm6zLqY0P4YCqPf8hFCiPAvfCX+zE0/0PJqh7ZoUqhCyQN3?=
 =?us-ascii?Q?FGA9jFngRenq8L5fuu0WkB8gbdTQg3ze6A7jbqikSZ0ddRL+34y/e1Lfm9or?=
 =?us-ascii?Q?DKue48k8SdK64qj7WTOH7r7nAhmhr5/NUcpKQ7Afo1fu9PEXjneEV0VIPZgo?=
 =?us-ascii?Q?lsd2++byBJB+9i0nfpUycFFSCMG/s9rKC2y5wqmtfsAsAFOwsl0anRXD5fPS?=
 =?us-ascii?Q?BjcAllGMKGSIAxQoB1/98dGbEf8mwkJsEMTaTcu5ybF1/ds4mwoGqDDdZ5zi?=
 =?us-ascii?Q?rt0I1tgK5n2lttFe2MHmVvzdKEMJDBbfGXRdXvo95/5ZbPTsPoXy5hmhvcvY?=
 =?us-ascii?Q?GG9+H7xvuHTKsdlI8nx9JrUQKfByhOxU+0Pl/Ujb6f2Dv7QSlZC2yLnhzIYq?=
 =?us-ascii?Q?gRQcFUd22129VYitm+d4gEWrqA2MO1pIQIMkPvgNv6wF45QhLPmxgKC2Xqfe?=
 =?us-ascii?Q?bGl/4ySrs/Wlz5grqa0JCVznqSGhY2YulhbQUfRSMFQ97BjUp9FXjJwrKoUc?=
 =?us-ascii?Q?TsErHQJWtObNHaeVCn/JVkwY38bwjxxYsagOICqu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ebe84e-d5dd-447e-a89b-08dc39c67bbe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 08:06:22.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVN5UuCp2RUjdUpUD3un8gCT4VQgMhJWKFi9k1rzc9dQLtFOwT0fLwOyQyF/95vtZdj2KSmM5LO15glTb2zqTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4546
X-OriginatorOrg: intel.com

> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> index 063ff486fb86..b302060049d5 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> @@ -224,6 +224,7 @@ static void tdx_enable_capabilities(struct kvm_vm *vm)
>  		      KVM_X2APIC_API_USE_32BIT_IDS |
>  			      KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK);
>  	vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
> +	vm_enable_cap(vm, KVM_CAP_MAX_VCPUS, 512);

This is not a must for TD life cycle?
Though I know, currently, the selftest will fail without setting this
line, due to TD's default max vcpu count is -1.
But I guess it's an error.
https://lore.kernel.org/all/ZeGC64sAzg4EN3G5@yzhao56-desk.sh.intel.com/

