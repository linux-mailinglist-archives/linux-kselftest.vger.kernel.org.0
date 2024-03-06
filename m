Return-Path: <linux-kselftest+bounces-5973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F86872E45
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 06:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DA41C231CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 05:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414914F7F;
	Wed,  6 Mar 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auXr+KCm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887BF33CA;
	Wed,  6 Mar 2024 05:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702446; cv=fail; b=TDRlaQesq2V7wThKV+yjGx21rNIhlnrLFOCQjzhnT0fn9u/oRWWdgLNaEnuAO3X0pTgJUPMRkQKaO+gbvpR/tPBEgl+wQ3M3eToYYz9P9aMle1A18ENxZfOmL0hZTAIt7q3LC30jBtw8RG8okQKECaukgGAM8/gPhO/PlMnZv5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702446; c=relaxed/simple;
	bh=cDMoqob9KmuCwuvTFaK4+DJpjwOcR4RNVsgYy+7I/sw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JnZ3YksAk9TFOWyrFKwJQzjPDkM/WH12tHHGzJoFbtMTQz1GtHcGWkIlAXXX3hMKw+4QPMvghakZwkiW7Pb8mx05f2UpTza0rvR1HlK7RDpNh1giHfW/EHSRoaXkTFKYAMh/UrLiaTda4ly2DjaesNaOnfIRNBEazbV4Zl6/tys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auXr+KCm; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709702443; x=1741238443;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=cDMoqob9KmuCwuvTFaK4+DJpjwOcR4RNVsgYy+7I/sw=;
  b=auXr+KCm5zrg9CbC3cW+fpOeBc4lHA4vLmLlJIpbQbHJCbRdOAmWeDLk
   bKWRAG9qVjHYaqiJgJutRy6Jx0xD8p88TKqtm/LrAo/0M60eaenX4XPyW
   POs5tZ/WJJQoKu95xbx9whh+aibcc5nRJLslHgQt1LHy6mJBBX6zpZThn
   IKC0GJ8OKg8CjaKvYox/4SaqK5acTchD9t3gOJ2PrP4+uxSWsxop0Uk9T
   kje25CNWlX0O9+Oe6JwQF+AgkGlGKKx2a5x6koRutvHM51N5gOY9fheNI
   6xbTd+F7u0udKlk8wxkI4yXK0faDjx3dPVBC7jLjK8zjhtiPLJ+kqzm5L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="8061892"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="8061892"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 21:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="40626223"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 21:20:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 21:20:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 21:20:41 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 21:20:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIDcODo7WXT8q0SBxft23/iWQLoZCtqoBhk2P497rvE8WDpwNbKPwDkqpqinJLUZniAS8mKdYHPXkmEaudaH9oozXdgqCpjyKNoqvH5UChAcvvk4BzxC+fruIfGAt3MUlhyeYUGALStTlIRinQxv4deF7M1vP4seI+zVRu4g+8jHyx052U1x8M/yX2eGflqUiH9XFhaqmVNuueMOs6+4Ff0wWdGoFj+ILzh/JFFZJxbB6ANuZ/iBdvpGASs45yh7N9GwbNtXjkF3Czk1xeunkuJNFasy9+yh9Lt2DdLMiPlOTlMQyxM5LOpDAjdCIdKvbMFFmE44YYZ9iNsbISmwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmtmpG1/t8bg99N8TK2XQSd7CxQQ5qlLrjX/g6UxiWc=;
 b=WbbzjPqsy0ek/xPJWGdX0G2Q3FSuUIaPpQbn2RS8Yl8NM5cEyqNzhwEwFHfEcHAZ1GTgRnkQ35YBhGTgOcCij4JUDqwE5jCxIjE4quInvHoRQCLGzROJJT1pR3Zpr/VuKBZFCMtNRFbmrpW61dSH0KO7qY+xjp/DrIKaQNx54XNXzuuFZbivfdZOOKyKtIEhfDiLonDpe+xHUyaNvHnEereAIvrqV30+/2GO1xAgSOcznZFiS/la2gmH/2o66YNPgOhMy6digIm0ixAuPtG4XgJrFUxrcFTLXLEq45DCS2C7eeUbYjk4oYkPp1pB11zWV651MVjm1xxEPUNyg0ciVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 05:20:39 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 05:20:39 +0000
Date: Wed, 6 Mar 2024 12:50:47 +0800
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
Subject: Re: [RFC PATCH v5 21/29] KVM: selftests: TDX: Add TDG.VP.INFO test
Message-ID: <Zef2J/ygG8KT5a02@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-22-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-22-sagis@google.com>
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|BL1PR11MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: e26b55e5-15e2-4672-3835-08dc3d9d2936
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33WjOPrR1aErE6j1+QQIRgqZG8GeU6KTppYOmPUphGTgm9w07ew5glZAqkvVTLzDJaNz130fxWuCOpMeQvNdgQrFCIvH+zu0+6wTGAJnkWNuHzXmIJxO1Eq0DwYvdGwUc2g64kxCqaBRU7NOFjNei7aXUiOX7MoGieGR6KF8z2QoN/uMnChOQlS5xug1kybp911lYgLPMUyTdiZKeFahmtAFw2jWJQblhiniXRZW7AhHWMvBdmDwx98EnEjs0VjT5nFpHspng9J4BTVfK7GS7ndMt70PBSmChmjBhO6NoZ0PXCDEB+t+ZJ3G4rRfL9VsGL6UnFLqlMhYm5+BE0sLyIT9huqqw/9O1Qh0Rrgd6WmY5YP0rycJyUAEdrMpqg37FjH9rmoAaPS+Kdl9kyj0KeB3QmOzbvoqkijtFQ2YXqFCi8SwB0++5KvJ0BG1FHGV8nQ7oC7mzXwZZLs2ljp6AYDl4fbLKDyqYMqhVwsZjvSfDnU8RnAP3jwublPqEJzr6aXhLHDfLYv1a1qdx7bEZS9/WnGCQQAayt8weWoY5C38Z4TEwFF2vfomoD3HkGMspR38DGG1xEe7SjA6FdBvdQyIEvwu9NVBu7SrbLk1VtY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6TyOfnXD5udL0qVOpcuFKOKSgXZljr8im+ZwTZ9U5EbgwB7GpCwdDyc+n3da?=
 =?us-ascii?Q?nLe2QTlmvJ47y28qwc8D4Ye7LRDBhhvKqPsigHHsorrMZnfYVXolyQSg6zMO?=
 =?us-ascii?Q?5BcVF4jjj6mXZlTo48azSKSu4BNj1Ers+u5aRDShgAKFsAzoRoolSpneSiSF?=
 =?us-ascii?Q?g60ZTxzOHld3/JdqzRePgbgjmdQQROITnQxb4GI/ijck/20iugXpzfTUVEsG?=
 =?us-ascii?Q?m8okNIUQ1W52HUKUaqC1ObdCwk1BtFYLljVKpR6cLpuY95SRn6wHFcV06dY+?=
 =?us-ascii?Q?l3dgZY/BgHMDVckSIp46fjXGHMo2qTxS/aNFkEqCc79dCw6SP62W83W+hLzd?=
 =?us-ascii?Q?Z9JvgJ1TjIUBdjUKma1gVzhx5okcoJp24rzZw4Ko0lDUYfC9zHBJAkXZWkp0?=
 =?us-ascii?Q?lo71we9g82geyozuCK6KLvhNskASXY7csWAhVvMcFZux0M20ZWLySN98Vm5k?=
 =?us-ascii?Q?MWGD/h2TcC/pvng84w27DrDZXOF+SvgNPE+uTqLgE8sh8C5g/bYJrhaXjwCM?=
 =?us-ascii?Q?87xu9lpN1wabM4VB7paGka5orEYU7A3seKfJIrSv+KR92ZUiTIjnpnxJJhTA?=
 =?us-ascii?Q?uYKWTHyp5BwqITbG2yXt8jPhNVMXS+3+c42RKsBNemSUBIgNujYkCHpnayFB?=
 =?us-ascii?Q?424U4hU3JVY6f/cwiEeqN6SeJsbL3oWohS4qmlzMB+a9SjCZVcSULA57Ro1y?=
 =?us-ascii?Q?r1JhQzHCO695qQq0R35Uw9dYH7WXLlKkIECce48okUQuU3DVshLOskLbVFGq?=
 =?us-ascii?Q?DHydLDq0BAA5g4RFPKP+imgMDdzhEYZlwRNlfwojENWb7disW8uXS/LnDSpU?=
 =?us-ascii?Q?FIdLKd9Q1kMkXPyPDhX6xC0mA4vIvEhOd7mf7Pxsm545EC0APZLURdFfr//5?=
 =?us-ascii?Q?9PdvOon4K2dAQlV+guK/HvoniUwy3uqaeGxGHTc6dHRYGQnKU4hxgMjjUj+G?=
 =?us-ascii?Q?6Y9aPRjO975Px2Mpkv8Z4E0X3NdGJqcoFAaaU0Z12ya+uIUoxobefzL8U5At?=
 =?us-ascii?Q?SUlu4RC7mQPQRTHleWo2wfw2av63llyaK1y/oJxrxaiQZNRSNK8xlvYa2WdZ?=
 =?us-ascii?Q?qurJ4+KHHOjCTsfn0BlFzMr2d1ZP7Zg+D56rqgefH++q7WFGMBx0caCQTV6q?=
 =?us-ascii?Q?vM2HJFImhBZjKUdej185ciUzkLVe+hTy06EyfeENy8XgJzhriZ6zvP3vEWCR?=
 =?us-ascii?Q?MFb8TpYDViBb/1A/QQCaaWvYJCTRjUWqz2tQFFGOnygkWA7rZ+nWL/zUEHCd?=
 =?us-ascii?Q?Dq8WKellczRVgNaDNml4Hdi9H5Q3z5crkkNsLu2O+YxFabATXzbmNJ24RDCh?=
 =?us-ascii?Q?f81syTaNxXzm0MNDAvmZTodzxETj9ZXwgtVvIQ6kL6K3GMlm1U4OULkFUagd?=
 =?us-ascii?Q?nn4NwQRn9g/OmnWu0IJshBO4PINQVfILKOdunXlLj+XybGltIN3pLdMGXyb9?=
 =?us-ascii?Q?r64RmdhHfpDEyWejgT+ohj6QrqCKuWUbUKSuDvCRoiESGPEeXv4Ks9dMWyyN?=
 =?us-ascii?Q?6frLOqmL/BPEXW170vYtYnAifgPOIQAYrVTmxSAiTeb5O/AJK6idgGRVpDLp?=
 =?us-ascii?Q?f1e7bms/QE7WFqDg7b6C1Ibk9OQgwj/8YTGCoIz0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e26b55e5-15e2-4672-3835-08dc3d9d2936
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 05:20:39.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hwf2LKoJSSDuxylax/a57PhLqAu02Cqm5kE7NcSN/8RMjXTTddgSQpw4d1qym+LbJTSx1WY0AzMto+efr6AUEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5256
X-OriginatorOrg: intel.com

> +/*
> + * TDG.VP.INFO call from the guest. Verify the right values are returned
> + */
> +void verify_tdcall_vp_info(void)
> +{
> +	const int num_vcpus = 2;
> +	struct kvm_vcpu *vcpus[num_vcpus];
> +	struct kvm_vm *vm;
> +
> +	uint64_t rcx, rdx, r8, r9, r10, r11;
> +	uint32_t ret_num_vcpus, ret_max_vcpus;
> +	uint64_t attributes;
> +	uint32_t i;
> +	const struct kvm_cpuid_entry2 *cpuid_entry;
> +	int max_pa = -1;
> +
> +	vm = td_create();
> +
> +#define TDX_TDPARAM_ATTR_SEPT_VE_DISABLE_BIT	(1UL << 28)
> +#define TDX_TDPARAM_ATTR_PKS_BIT		(1UL << 30)
> +	/* Setting attributes parameter used by TDH.MNG.INIT to 0x50000000 */
> +	attributes = TDX_TDPARAM_ATTR_SEPT_VE_DISABLE_BIT |
> +		     TDX_TDPARAM_ATTR_PKS_BIT;
> +
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, attributes);
> +
> +	for (i = 0; i < num_vcpus; i++)
> +		vcpus[i] = td_vcpu_add(vm, i, guest_tdcall_vp_info);
> +
> +	td_finalize(vm);
> +
> +	printf("Verifying TDG.VP.INFO call:\n");
> +
> +	/* Get KVM CPUIDs for reference */
> +	cpuid_entry = get_cpuid_entry(kvm_get_supported_cpuid(), 0x80000008, 0);
> +	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
> +	max_pa = cpuid_entry->eax & 0xff;
> +
> +	for (i = 0; i < num_vcpus; i++) {
> +		struct kvm_vcpu *vcpu = vcpus[i];
> +
> +		/* Wait for guest to report rcx value */
> +		td_vcpu_run(vcpu);
> +		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +		rcx = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		/* Wait for guest to report rdx value */
> +		td_vcpu_run(vcpu);
> +		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +		rdx = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		/* Wait for guest to report r8 value */
> +		td_vcpu_run(vcpu);
> +		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +		r8 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		/* Wait for guest to report r9 value */
> +		td_vcpu_run(vcpu);
> +		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +		r9 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		/* Wait for guest to report r10 value */
> +		td_vcpu_run(vcpu);
> +		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +		r10 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		/* Wait for guest to report r11 value */
> +		td_vcpu_run(vcpu);
> +		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +		r11 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +		ret_num_vcpus = r8 & 0xFFFFFFFF;
> +		ret_max_vcpus = (r8 >> 32) & 0xFFFFFFFF;
> +
> +		/* first bits 5:0 of rcx represent the GPAW */
> +		TEST_ASSERT_EQ(rcx & 0x3F, max_pa);
> +		/* next 63:6 bits of rcx is reserved and must be 0 */
> +		TEST_ASSERT_EQ(rcx >> 6, 0);
> +		TEST_ASSERT_EQ(rdx, attributes);
> +		TEST_ASSERT_EQ(ret_num_vcpus, num_vcpus);
> +		TEST_ASSERT_EQ(ret_max_vcpus, 512);

Better to assert of kvm_check_cap(KVM_CAP_MAX_VCPUS) here .

> +		/* VCPU_INDEX = i */
> +		TEST_ASSERT_EQ(r9, i);
> +		/*
> +		 * verify reserved bits are 0
> +		 * r10 bit 0 (SYS_RD) indicates that the TDG.SYS.RD/RDM/RDALL
> +		 * functions are available and can be either 0 or 1.
> +		 */
> +		TEST_ASSERT_EQ(r10 & ~1, 0);
> +		TEST_ASSERT_EQ(r11, 0);
> +
> +		/* Wait for guest to complete execution */
> +		td_vcpu_run(vcpu);
> +
> +		TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +		TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +		printf("\t ... Guest completed run on VCPU=%u\n", i);
> +	}
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	setbuf(stdout, NULL);
> @@ -1169,6 +1313,7 @@ int main(int argc, char **argv)
>  	run_in_new_process(&verify_mmio_writes);
>  	run_in_new_process(&verify_td_cpuid_tdcall);
>  	run_in_new_process(&verify_host_reading_private_mem);
> +	run_in_new_process(&verify_tdcall_vp_info);
>  
>  	return 0;
>  }
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

