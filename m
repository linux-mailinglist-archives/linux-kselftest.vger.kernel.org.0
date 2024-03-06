Return-Path: <linux-kselftest+bounces-5965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82717872C5B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 02:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61151C21775
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7610B6FD9;
	Wed,  6 Mar 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft8ZWW9J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA169DDA5;
	Wed,  6 Mar 2024 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689839; cv=fail; b=YypUaD0iOtlo2oB08yW4kYbkWb4OQtj5ynz7seRY+YwXJl+X8ANnfwU57Rad/723kRxFfQr2VfA/oCypOHTI3Esb6pikN0bTxWeXw5q1WTgXHByFX3PYb++1oX3E8deR1h2bwt0qPOOIGEdgoQsixGmf72wQPEqM7tWFcxxVhQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689839; c=relaxed/simple;
	bh=uTL8b3lReh6YYErmSoZXphjuJ9TpZTk49k2rF8otgoY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ACH9DA8DfOB7HNGpIggz1EHrGOYNEFCxeYhVz9pICTp8nmPIesngU45wltYUAXH/qIvQ0/EZy0JYrz3KL2ToI5wmLls4TGXh07u+kNVjd5BrSkrjCURc9W1hLP1tqFr+GWrU5eY6d6//hbs7HI8aTl3my9chbuqMWsN7bVAfoic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ft8ZWW9J; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709689838; x=1741225838;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=uTL8b3lReh6YYErmSoZXphjuJ9TpZTk49k2rF8otgoY=;
  b=Ft8ZWW9Jwl7WZWCEeURchAGkJ9IF6UCOJGmqOOzH7XYsdO21Jmgaze/p
   2L3CIQ8Cily5Dcsz+KCv7AHU5HHwiImKTnFSS5dZ5kVkSpkreMSvwViQv
   J392KxH94aeyWqDChQT8pstNyDSMaKSzJnrkbq7zTjSwC7xt6TwhVn3X9
   7kh+ZMqo8ZBMzzCNmxda3Egzp3gtYP2dvpfyGG0AyirM17B5XWUL/r/HT
   G5Z7+cg0fAvawpm0Iqd09j9ThtqOOsCCSE8YQbwjdlAdSP10x26hutH2I
   yIX6Pozdh34TqB5MvFQb+SMllcy7cBAeIuAb3335doerWR68CdD1VmPEF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4139828"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4139828"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 17:50:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9984118"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 17:50:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 17:50:35 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 17:50:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 17:50:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 17:50:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbqULSu2zbsx/ajCtw7p8n6Il2Uhbv1Vk0TXtvbuUPEftVyediWnHyRjJStYEMwuDuy1CzMOgMviu3WJjS8e7nIkAqRVgVuDymeNm/kYClhJFc3nK8v+QFLcbeCVQwGHo+Igzv5j/DogZ3o5A2jTGXhOb9T8hzh5YX+cLZhoqhWeyoIP1iS/xxZa88903N/IUc1IB/cKibePQd3VFH+eOM6K7XKlAgr9QvaGbRPkfbuEnQSy08d2njQenGA8I7Vv4T60swhTugy55CVMc43YTRtMHJHCX6WaWtMhk7fNwtWiPdMhmnKVhCdOS3J3s4CsV7ReRR1i61bZPtHQYg8X+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxJ3y8ZOXWq4dfVY82p4QeOuTYPRRH7rdvux326er4Q=;
 b=E7NMtjZvLnzxmxQSe4yX1cTjGxONFDF1TLv4HXmbQMC0J6324MEGOWSsVWykUB/LuTbQmgJTu4INPmlxEEx/9+a5ktqgtsZF/wu/4u2rd2SLigBA8N2zlDHw9tRr5Y4HClsqfkEjciaB2lN5UPmrY8BQcSBtGG0intQXdoG4L9bWXHc9EEMksczSHyPGTlhNTEhM9fyg6YLpzaj4PMudf0QjnZHbKNoNAGUUgK5QoiJy5s/eDhSWwe0ef3aq2vCtTE0IBfqXRRdujoiX9i2Pwean4TxGHMk6T5lYanFulGnA9vZIOOIfjPhk/xGSodbSISRfSqouOAZ6pYwNLVykRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SJ2PR11MB8322.namprd11.prod.outlook.com (2603:10b6:a03:549::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 01:50:30 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 01:50:30 +0000
Date: Wed, 6 Mar 2024 09:20:35 +0800
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
Subject: Re: [RFC PATCH v5 23/29] KVM: selftests: TDX: Add shared memory test
Message-ID: <ZefE4wq1C2nA/Saq@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-24-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-24-sagis@google.com>
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SJ2PR11MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: a11b06dc-7aa6-4e07-c0b2-08dc3d7fcde9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXfogLzZI8OVzSAQ9hnk+F5XNkTOoEaULyJC6tkF2Lybb8cVuZusGetgp2bCsbvf3gVgfhMy69FDODJoYiYwGa6zS3m8oCqCPOsGPasgrRimxaiRrzTmgtsHQUfIDwoGlrHfwpLgYAq7akEh7jJZWpaJKUXQ0rkygxbEd8NqLcfuqjs7jwWiW+0BKOYmvhnnJ95HTNAhehYf2pe6SPAyeg8AhcdAybj72vYijuVtJtl1Hfr6UQzxpJJggzRxgCobBtcH93S3tUiVIOFEfFgCCZc/4ZOTuzA7dAjWn9Of91xGpq/VxFwyETxGF0PIh+5SbegJdKMawdFL6BiZyi37vvg0Y4QeQWwuG73S3hpJU8e6SUMBHbMaxDQn873aRF7dQgWHbytngf7vRU19RTtQuxGTU+U1j6uV+rJJdeh6lQDoHS3e5hTXQv8E0jZJqa71RnRfzzVMdevvOQgJexpdET6kEpvqapg5mUm8NvMAGM88Nsxt322HJViUpvx+P4osErq7VIqzKNho7tsT+amdabJZQ7Bg8aOxNOmTNuw9Xj7hgbGTSBvWu7AN4sPsTG9AIHXVnzDwGM53xbvj6gyHOt4JiKifihZ0UbB3/megGUez2PsWxqulBJwoLEcPev/fmNiNsHnelRGHXF751WeXS3uEPti0VYAIpt17ugHKr2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wg7SyciJV1CfWidUgeE6ZhL3CM5/s0PK43VSBBqExA/PHQ9qxPp67npKp3Au?=
 =?us-ascii?Q?9ars2moMhkVWoo8x7k9xhvkcHTE67gsSTTJlq8C4YcP6QtPPRv0xnyAzV5fR?=
 =?us-ascii?Q?TjCaerFffGcU5V/J8Q6g+wI+Tas4gEemOnFM0iaBze5LDvAyg0jUy9bxekAF?=
 =?us-ascii?Q?/sI7nYw8eRIPNjBknaOGB8XC95KAs3OtXDwYXKYJVggQ3WLCIBGsoZFLlfMb?=
 =?us-ascii?Q?mn/zqgyCp+8x+aCfqbYPjAov4NSMpjnAzOxYcejBpXOdXVFPrqXdvRQKqiJX?=
 =?us-ascii?Q?JGlJ2PkHyKrJKijOw2yOJBb1GvUao/+tfFPKQs9zhiBr7XgkfrSM27+p1w0l?=
 =?us-ascii?Q?xdU3K5CASfWdN1cnnvPvIv0GRaMEtLOlV6NJWWPXz/2j7v9zJ4gMNtJ9npQd?=
 =?us-ascii?Q?SglUZkP2W+fFSC0HSN4suaEoBGsCJE4SX8bsIcp+SFkJOoa5/lTRxKc7fCdH?=
 =?us-ascii?Q?sqTRhFobF5VZm59AmmyTemdtV3P9mSGhN9LE5OoffBITqTg6J0ygn472XSoM?=
 =?us-ascii?Q?BVklmj/x2gwcGhCw1uxXNzbBtUjLaaVyOgvzYjG+FbQE+2NzQCx5zZHgrOZP?=
 =?us-ascii?Q?d+9HeKDreLZX4oM6TW5E/uPIs3FdUMLAOjHme0UyBpXkVlEAsvANV+deFSjQ?=
 =?us-ascii?Q?/jAfcrockvq0COZZ5tGPSnt/8i1QrtTglilMefxQuZ/xrT1vsyxr8OR9+yKo?=
 =?us-ascii?Q?5QZKEFy66CKtu2EDsoTW4XSAvOub4kBobgjuruyHywiwq8uOqxRR7Su2ximY?=
 =?us-ascii?Q?nwsZ0apTZoVp5jIWhrMet03GGHS9lXY+LRDIxtE/jUGzejViz4nOhzlO6NJq?=
 =?us-ascii?Q?VJICyEqyEewRbAdsL5zHSASwky2SAqnQH2UjhtTrG50FiG1F8AOO0QequB1l?=
 =?us-ascii?Q?uR8hVU3wP3XlRW84Og0rIRH8PtaOVW/C8xc4tSWnQpM4/v0vENqK/8oOSqDU?=
 =?us-ascii?Q?9vN/Gm62Sl9NG5ciFvkW3BsiZrV9USNAbYXyDuOFRMw1ZKkHbUfEpH7Nv+Bs?=
 =?us-ascii?Q?e62+3O3dLebTITefL2ySFQosl4CaonTVedrqYO0pMqr3cFURIlg6/b7hV6Yn?=
 =?us-ascii?Q?5kPWrrImZw+cOQC4hUhVUSbUpLUoJtvFe9jXMFuL4eknELr8Tzjmt0hL/o57?=
 =?us-ascii?Q?zGNGqDlo7iM5UcGg1gQxfjEbSAhTs07Td9IYNQrJ3k4DdAZLCl8SrnJqD/z8?=
 =?us-ascii?Q?ZEDIlo0cL+duQNQjMj+TO0ib0Yre1yzA7fCd4GN1CPwiXOruws0YIovx4CJ8?=
 =?us-ascii?Q?Dq428ntIVbBRSwCgikS0ckjNBkHGL2o4A5GneHSMoBrAHWaZTH/lthynBRPs?=
 =?us-ascii?Q?eiPGYLWQ67/PfEx2ErUZ9DP2rbqv73g2gBQKQLsIH9cEP+XM5QIObnr2BwqF?=
 =?us-ascii?Q?c/BL9Dyb7T8R8ODNUqIZ6y3z40w1CpNG4VhG2L7ER+fr38RHYFTIaeEVZ3PK?=
 =?us-ascii?Q?GnLVveZ2YoBLmR0qFk3tH4HRb6vwjLxKfkpI6d9f9ohrKWMa4cdfpDx4nSix?=
 =?us-ascii?Q?8DI398sZI1s5RWtxHnecmj3w4Dzky0vYeSaBqfMZTT2sMqCpS6+y22WfzOt0?=
 =?us-ascii?Q?uTRU+UgOFqgEvkD+YBB+US9FHVb695IuFhIq02uW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a11b06dc-7aa6-4e07-c0b2-08dc3d7fcde9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 01:50:30.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQoebdl4u3yhIci4VSY7VDjwnicVVHOCelLgAb175yNeJNV+/+7B6cIuzb2oCNoTArjwOC2J6zNHjlBYeSJoxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8322
X-OriginatorOrg: intel.com

> +int verify_shared_mem(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm_vaddr_t test_mem_private_gva;
> +	uint32_t *test_mem_hva;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_shared_mem);
> +
> +	/*
> +	 * Set up shared memory page for testing by first allocating as private
> +	 * and then mapping the same GPA again as shared. This way, the TD does
> +	 * not have to remap its page tables at runtime.
> +	 */
> +	test_mem_private_gva = vm_vaddr_alloc(vm, vm->page_size,
> +					      TDX_SHARED_MEM_TEST_PRIVATE_GVA);
> +	TEST_ASSERT_EQ(test_mem_private_gva, TDX_SHARED_MEM_TEST_PRIVATE_GVA);
> +
> +	test_mem_hva = addr_gva2hva(vm, test_mem_private_gva);
> +	TEST_ASSERT(test_mem_hva != NULL,
> +		    "Guest address not found in guest memory regions\n");
> +
> +	test_mem_private_gpa = addr_gva2gpa(vm, test_mem_private_gva);
> +	virt_pg_map_shared(vm, TDX_SHARED_MEM_TEST_SHARED_GVA,
> +			   test_mem_private_gpa);
> +
> +	test_mem_shared_gpa = test_mem_private_gpa | BIT_ULL(vm->pa_bits - 1);
Why not use vm->arch.s_bit?

> +	sync_global_to_guest(vm, test_mem_private_gpa);
test_mem_private_gpa is not used in guest. No need to sync.

> +	sync_global_to_guest(vm, test_mem_shared_gpa);
> +
> +	td_finalize(vm);
> +
> +	printf("Verifying shared memory accesses for TDX\n");
> +
> +	/* Begin guest execution; guest writes to shared memory. */
> +	printf("\t ... Starting guest execution\n");
> +
> +	/* Handle map gpa as shared */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> +			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	TEST_ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE);
> +
> +	*test_mem_hva = TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE;
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> +			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	TEST_ASSERT_EQ(
> +		*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE);
> +
> +	printf("\t ... PASSED\n");
> +
> +	kvm_vm_free(vm);
> +
> +	return 0;
> +}
 

