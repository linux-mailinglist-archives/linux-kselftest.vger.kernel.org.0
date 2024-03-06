Return-Path: <linux-kselftest+bounces-5967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F9872CA1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 03:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D181C216B9
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFA5D518;
	Wed,  6 Mar 2024 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkYHRoXB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73BB7460;
	Wed,  6 Mar 2024 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691538; cv=fail; b=tqaI6f0YcwG/L3jA7To3cdmqR5dO6PEJ7SoZHvYsWftBQasW9FYWM+0f6s+OHC+UbLYWapJQrEi7h66XjtRU9MyqDtIejP7oCIoBtLyNs0LAD4DpwsSONEUtr6yHDSXWu2aB7E4AuI4ytmXCMYY+icvywTY2F6dG3EKw/pe9UyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691538; c=relaxed/simple;
	bh=FU/QqbWavtxhiowV49K10UC40h3nDdFk4SU990kGbVg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qa9mSRFyRkFwS26224XjKkvMkzgx6g0sX5kEf1OOTpo8KGlsNyUSlU90dsBwNoy2GVclY5CjwqnHTxMr5b97BOSJ7dwDGPYGm+i8/WuKFGDXsCvXcVQeq9qjPOyuld+pUxCWiXrFLlQf0FotEwc9sDobubN05z7+g++A+BzPTVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkYHRoXB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709691537; x=1741227537;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=FU/QqbWavtxhiowV49K10UC40h3nDdFk4SU990kGbVg=;
  b=XkYHRoXB7WaW0Gvj708135hN05toxy+eMUPRdMlO3c/biHVnR1Err05O
   z1j0ovbNJlpetCtvwzXPOFHOoKO96Dl3yEB9kb/ytQHjbdo0OsVZMZAj1
   OkItOVFLhuY9uupSOHi7nuErv8y0JWX9tamzXfP6u1pVCa41V2RY004hJ
   j13tq0w2rFDplmsNxOEX2vywxwMt+sWHs4Dg1CJotBMGreUwiNWSEdNeM
   Jw+6DjHSX+qOgZrBytCrmbZ2RyvMw5wsFzPR4aHqRUqfp0F8T7s096qt6
   41SMZobQ+GHZTNA9RPr6HC2VWNl6BxPO7NsTHsP37YDum1hqyv7KlGld3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15001020"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="15001020"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="10172282"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 18:18:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 18:18:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 18:18:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 18:18:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmPO8D2gn8ftCfCrKFq9aX26psC2s9SleAqfrY3C7CRSyKRtZ4/H0rmtjK6G3i4/NDtn7HhuoQz2PZsowtFgqdpCdfby0nmPZeoZc2BmRJDLMSLOI3JYL7e/hmCT5XowOTCOPaFSJQ6BaD+lmsgF9/+YBJrJjVl2NhSwEbHJzQ/tyWWz0FLLIFam3oJgc9bhSvKKSMI1LZywvJ/Kfe5cbQ2JUqhMnl7rZpF9wweqsd15Sy9eST6U+d7oWzdn/wIPYXYaDE6nzq9EasxISnYwnWJHr4FryP7++zD5yPayeZ1mDPVorprIsOcjbGnqQawhVJsb5GB10lg9kKytmggtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP5VWbVyFNZ8iTKEziTWUXCvnkjh6bqeIPUgMDqzCmg=;
 b=ONMBu0dvp95rmWGQ/07q6+jU8Uo5JpcRVobGWHVmdT4ugwZI2TAeyeVBnkdvqq67zFwsTMSB9yKyrGlegwE3CNBYSl7I5W54K7ZPCiOap7r2Zbt5Wm/JCR8BhzVqepEVgUXzBgsjiov2xZk5dLsZpb6+MtS6zGH6yQu4dcEBFxqWedAhk0y2fQLwx+WgtjwtOkSV+wH8yeqaZ5GyUafvBYhnEyfpLYZZC8AR3KE2gM1ttTLQvNewM+eWuQOoBtiOooW5/LCetN5Exwhot348SpyEF/0yVhBAjMbuMaDMlinKga3TC4BUdezMaD73Hf7k8mntmBn0lkW142yZXmjg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM6PR11MB4548.namprd11.prod.outlook.com (2603:10b6:5:2ad::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.23; Wed, 6 Mar 2024 02:18:52 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 02:18:52 +0000
Date: Wed, 6 Mar 2024 09:49:00 +0800
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
Subject: Re: [RFC PATCH v5 24/29] KVM: selftests: Expose _vm_vaddr_alloc
Message-ID: <ZefLjLa1KAHE0Toa@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-25-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-25-sagis@google.com>
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM6PR11MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 29bf49e5-74a5-4b94-4c83-08dc3d83c420
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHfhWuubjYqfynC6UkiFL/wJuguHFUgUbHDs1pcDM/2WKt5bKCK/6/buj0c6325JwwbI4cgrtaFFHCbfldV5xjugy0a3X0I6y3QaUjjiBiauULRMym60o3eP1brOrZe2h1DWQ8aDdkBwVC7obG06pu8VzsnLMWwLfLbgGd5AFdiGMUquOwnELKfM2p1sVCRlAJ3R6Y6mjLEZpuACiFeEP/1duCiHAWhz6N6HYHLJsKAdpy0baNkrZPlXy/7VU66hBiw27zDu06GJLytNyovavkFzSqNFDEsUirALZOjMYZMEson9EHtkreQWTKRCCMqpMVce5NHAWNQDNkhYaDR7yPqlNdkBZpmkhOi9pEXebSevXGqixj1n2c376JK/Qo+wmkV2YFAEvPVCqo/CLSgcYsGtxXvljP8Zt1h1jWwgySRu/H54g5GtsLjiT7Ntow051PEfhVRmWohWY3FWk9hhCYJz/eaGF8EraCx19+07A4N0Sg19GbfzRr5FQQLBW+4H5TtoiQiAzg7OaqmiIdyWw3ERj8XGNmh5srLU/Kr/NnW6b0oknhnPtxy5H/aM75/e4hASS1XKUmyZjrvNfg/PLEP3UyR6qbbQ4Za0FUM/sT9dM/7bOYBjgprmfyP5pqdFAyNM7IKZw/mJdkL4e4jY6rsyPKNsgqQC4Xp1t03niQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3gdBFs/evYC4N9hImEde5/m7o8vqVGiCXEFByTXhQ1Je2LbKdy4x+L5ZTv+E?=
 =?us-ascii?Q?RhAyeD5zOhq64lZJQjVHPBGQgay8lavXYEfIfHjMAekozoiYOU0iyjA+vmQb?=
 =?us-ascii?Q?xjT/77FDYxSYVD1E7IEBGPFUvCLPW/KJoDxS32it95SXeJT4OI4dMfUHUlDf?=
 =?us-ascii?Q?DlMYELUB6l19ZHNuqPMVAt60UhEQxLJ0KOHZ9r23OWhTu98jpIJyZMxD1a5P?=
 =?us-ascii?Q?O8wYra2mgb4JfXsheo0EpD9yi0LaAVdorPgp1AsPJ55QJ4IBxbIeRn/13FS+?=
 =?us-ascii?Q?eIGqDocMe1TuhRJcfgC0mluWK6zE2TTKOWkAuRABfRbK35c8DWf2/1CvOrgN?=
 =?us-ascii?Q?V8vz9iHjjUtRPilpr5AuzK7oo7QZ/XosOgHoiWOZ1nLeFDvqUGDuv3SeCv6X?=
 =?us-ascii?Q?XNoCboMWYIXGcTPnxAXs5bn9xWA9sK8yqfPX51AeCxQV5i9Jqfj58BZhr6Hq?=
 =?us-ascii?Q?+80htmLBmA/651mhN//auox9xM8zeYdy/r/cAUfNRfqKx8szz8o0lu7MVK5h?=
 =?us-ascii?Q?dQPGajQk26NimBu+pFdoOMixDl1SXxrnqvHHCV9HmM+bzNUcrEMCOH3i8oWe?=
 =?us-ascii?Q?mfW6cLuGLc4pPRF9Uw9ynZrRPwzQTFqvo6ECp7fMnmI5iDBn1GuqJITVKgdx?=
 =?us-ascii?Q?SkrRtyLDnTTVFR7O18EvZl2fJaHaE9pmB5ValNcOSwYYmoeRHbhGBiUb4M/s?=
 =?us-ascii?Q?e9/ArYcbmvItN2f57ZBYgUh0l+rB83mi0dz6hVS45Hu3b/93kPB6FKCD0odx?=
 =?us-ascii?Q?3JLQkLgJMvl9d4rO50H/L2oLT8QNWgZt4rkfZzKY8yWLLPEAsN2ymBwjYsXf?=
 =?us-ascii?Q?w3N+gQXiOOmcpakMrsj6BMlkVd6MbXQx9MXSIvrLUaRf1fOyL35kBzawXxJw?=
 =?us-ascii?Q?LLdqDZAXqSDjrwZUo6KXBz/88+SEIA1xFQQCAKKgMVkQ2JxH7tDnZOoTI6YZ?=
 =?us-ascii?Q?FAYgeAUMfOZmZx0bF8JWRe8Kt8x22XnFGWjO5DkcPsmDiLOI6Dbm6+V0wRyh?=
 =?us-ascii?Q?Tdumc1n/TZKjNKLNgwvtW8FFmM6FHasLL5lT48BJ43vTNJ6h7V7PGrix2SL4?=
 =?us-ascii?Q?ck7QOciVYXqV4aciuThc9ZMhzm3I81ggN/XlLWYNRMFNqOianCO7wwWTVMJu?=
 =?us-ascii?Q?omAStZDoiiQjdZ0W3PgTY4xrC4wple9Ypzpc8I2vsYPP8TaCM+ZPXLY3xS7p?=
 =?us-ascii?Q?wFvqgXug4efjhXgBlh6isbzT7vgPgaQbMY3zX9hAHDLMTPm3b3xSjuAg1hFr?=
 =?us-ascii?Q?eZ4+NfhzTT/KtU1aPkOSOPioJMkMJayWNgkEkxA5iH12h7/6ee7ujtrBEipx?=
 =?us-ascii?Q?syWV3xMJwWIIhOOegFMBRBTqFJxO5Ga2A5MVOCn+f32Z16JnaeWbMMn1QDU9?=
 =?us-ascii?Q?g+AxPhsG2Wuu4J9DMxWy13gRLPs0i/ipH+lFgZ2TXpnoaM+y1tmJzBOT9GLm?=
 =?us-ascii?Q?JmjWHznXe+LN+1C+4H+7AknMNzHmmV40Yn9HnQfmSLzj8ROUygC46fkFL36O?=
 =?us-ascii?Q?l3CjErYf5AWml197xQMjeDPiR802NEi0pny2mpQszpwEtaRpt5g93Njr5+ZU?=
 =?us-ascii?Q?yYnfN056O0FfSP2xZnKEAEzmZLRWwOfpeD/GV3Ok?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bf49e5-74a5-4b94-4c83-08dc3d83c420
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 02:18:52.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVtm8SGqZj/dnwWJHMamWl0Qjuv5Tg/Hln2wCITDC5F2hM0Ng9BdWABOffGis5AXo+H5PC63Ajm55xpGMcm/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4548
X-OriginatorOrg: intel.com

On Tue, Dec 12, 2023 at 12:46:39PM -0800, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> vm_vaddr_alloc always allocates memory in memslot 0. This allows users
> of this function to choose which memslot to allocate virtual memory
> in.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util_base.h | 3 +++
>  tools/testing/selftests/kvm/lib/kvm_util.c          | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index efd7ae8abb20..5dbebf5cfd07 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -561,6 +561,9 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
>  struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
>  void vm_populate_vaddr_bitmap(struct kvm_vm *vm);
>  vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
> +vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> +			      vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
> +			      uint32_t data_memslot, bool encrypt);
>  vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
>  vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
>  			    enum kvm_mem_region_type type);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 28780fa1f0f2..d024abc5379c 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1410,9 +1410,9 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
>   * a unique set of pages, with the minimum real allocation being at least
>   * a page.
>   */
> -static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> -				     vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
> -				     uint32_t data_memslot, bool encrypt)
> +vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> +			      vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
> +			      uint32_t data_memslot, bool encrypt)
Is it better to expose a helper function with meaningful name?
It's annoying to count the number of "_" to figure out which version is
used, especially when there're "__", "____" versions :)

>  {
>  	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
>  
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

