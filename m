Return-Path: <linux-kselftest+bounces-5715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD486E116
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 13:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992151C22559
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4DA3D;
	Fri,  1 Mar 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VK2H9cER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4C7FB;
	Fri,  1 Mar 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296361; cv=fail; b=amISWsZE0qMvDuBA2+PhMojEW5rLC/9vCkZwJPC+3Mls3seKrjCHLnfddBiAE3cs/e9Jt7/D8TpUcrbWTw2bmxOffBzweS6M0iWvx6feckgkPP5eIXU9sP7u+1lhVLl0asYa+NUkN4RR34uTO2KYTco6MVJptetH/BUzgEOt8ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296361; c=relaxed/simple;
	bh=Jr3ckK4+Q9PPt+R4djAemu2oealbZCJ/kbPgcSkuDog=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eATUNTkErvX2IsXnWw1v7JAk+iz3JEBqjLFM5iNizON3GuLG4VmZAFZQQubpWIkyIrMHAeqX3ObmN4gl2k2H84ha0+8Lj9eRsifH9/3U5wpI0a1Uwp9X9WJ6461oeW4NstBFVvfmdJAZxeBmFs80oMtNN7aK+kRjws3gQNl/pko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VK2H9cER; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709296359; x=1740832359;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Jr3ckK4+Q9PPt+R4djAemu2oealbZCJ/kbPgcSkuDog=;
  b=VK2H9cERk2Bl3YzJFOXS7cZdQXv8fQkRsh+2Ip2bu837iuFHIszH1q5Z
   kvElTsMPSWnN2f6GtnTYlOTvc/gAJzjLy9ke5Ih32ulfBB5jDVvKJ2hD/
   pED/7RAq9enLoMEhUG3xXN27aEVKN8Y6I6mNGTwl9E3r7AUhlnIYNT9ms
   CIxpLbRqhSk98OI7Unfd07wvKfofZ2f+1DxTQlR556OAgrpudemZxryAK
   C9kn/SUId0izf4RvoetT6Pen+g5sVCYJMgDwYeHi0SF46j0LdXfqpHIBJ
   y/UGMj0cH/Twm6E+hfqsoUJ9RRf9u9LUEmlqKekYoe5c7blcMXneN3SP9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3695417"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3695417"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 04:32:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="39048252"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 04:32:38 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 04:32:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 04:32:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 04:32:37 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 04:32:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbKAXyO7x3O+f39lQmv3la1bgqOZu1Dzt0pMkvnjQPwfK52UQG9IqayVeH0BJBR426ecsgw7zX3YmS7OKKMNCwjZeyVldMsYqEHJ7uaLHHp6taYFDT5rf7RMsxDibIeN2eirn74juwOg7H7VtRxZeHTtiCI8gwa8sOYL6LIBFCxSPj7HPkS1/ndCHYwzj1OBoRPrUlAsoOVimjvRLTHjSjaHY3slBEFm8OCIlGGR7XlTAGMH2DG0bXrz0W7MNzy+4fLsNcd7f2Z5I0wxt1B5GhVFJoUI23nzp6xwbEeLu+OIL4j29noPbVRicnPxYcH04/yekvXCwROFua8x0/m5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebwPdqI7Bfe3XU67E6jZuAnJ7Sll1iDqFmoED4kJBJA=;
 b=IlWkUbi1YALSHdgXGqSbpwItK+i8J9RwEPLQ0cveczwFi7fNpjr0W8uydYALf/Q3u9RNJsE83cCqhDFuW4K8cHrIVe+nAHi6FEUU1vXA9S09a0jzFPNUDnegO9CqS0Az7DwhqdqRyZMi6pBTvSPUWHOMSnPofeMnmMJyZEOo8NAGpJnj724JzZg0vtOl83whAuJoAb9Nvo2qNo1Dq/rqnUoDT6E6vUa0DIf3/y4IUQogEK6aWnP7xfyVXNLXGOt6AeGvWNUBmIzDziFONBlu44ciOhaPeGxf5YQiVKYbWValL3diiDJ0Rjne15JKCj9RzBJ/4MW+oVsLTu0pw52dfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Fri, 1 Mar
 2024 12:32:32 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.013; Fri, 1 Mar 2024
 12:32:32 +0000
Date: Fri, 1 Mar 2024 20:02:43 +0800
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
Message-ID: <ZeHD44xpj75ixcUr@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-24-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-24-sagis@google.com>
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: a829d69e-a6b0-452e-ec85-08dc39ebaa92
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhKNCopZH8zNtPtlPaRfTtDtedqwMQkgJNUXCQmDTpADjGA5ZLiy3OdBFbip/Ac8lWJnEFN029XoROHpxip7Cks7t4d6aw8ca4P3nbF4TxjIVnB0y43J09CwoUzrFkrtuw7ZpH5kV2/loH5jaxskNz1KPIQ0vwo2pSxZOiZ/L5ZHFe06oUFjjDlfZbeXTw3LJxd9Fnp6prXkIIf2NJAz4WsiMhMZ+ZgtHu2lM2xBRtmoLogaCTf7yqKZoja9VI5Umq7oDZOglKex9oKIZVc4Q8w2dyIk3+KOkCaBcc4WxeK4wbNUG0uiT57CmVAJxJEgX9d5yyQs6E0O6QSPPBXk5cavpo1hu0dOJ+zazDJyAAQq16DILmIdS3Is+ZJ1mRilpyUEJun6p9qr9IqQ8gJP3O2ua1GkN6X9H84T2zIMlnEptjVrrj1bWvEOO60itRq6AKHlkroYhqiFCj+3hz4RdVHUwPPCRM9Me/IlXo544NTNerTTJrQDVDNekhordUCHzrnlzfrIiwDf6bP/bjwCPTJPaEsWliR/qM3D/9bJjsvA/J0r1QeVWWLjuIo+v/qPj75mZnvAhfk6HUqZ320iG3+6uHT2b0u67cAvJxxdpWy9IwdJ6X3tER6YV1RvgWJQv/VVLfCMf8ajRYjW37cxHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XrQ2guwEqJWTX67hRrYCnOC8lKwmqfvgu3qCcTM7To72wPMTEfLkzbj9zTY9?=
 =?us-ascii?Q?yOTvZIc7eiWFkngiHciVYU6YFIcljvF+Ci3IVFmZHl0a7ORqNT9nL80koekV?=
 =?us-ascii?Q?wRJUs14L9cjndUzcWxx0w7smxpXAZBwgEyZgYzprO8QxzIIJ7HVe2rBmjaxQ?=
 =?us-ascii?Q?nZq0h85plCotLmJ3qarMxxIgDfP+TMtxZzp4kdt3iN3sBH/g9O6ggsqz9kPd?=
 =?us-ascii?Q?0Cql+ftdyylr51Hx2wIM/R2+Cbq9CQglSvBp3BmC/WxLyFLyD+jJA/tJmxl4?=
 =?us-ascii?Q?LDBf4EKmxm7IbQHEmSHEetCUImD728XBn3nZc/eONNO5iDvp7PerCLEdJxRH?=
 =?us-ascii?Q?+y0Zk70s9gKzPrI9FAtVxD08IQYdvY17LI7zjvuTwo3lu+UktQXZNSbThNgl?=
 =?us-ascii?Q?Xclj6fcqPF4uFsyHcTjVPPhiHeS1HFcvUkKGm0HK9CgD4TkPYb01qJ0gdjCZ?=
 =?us-ascii?Q?WDdDywCHWQVQoYVeGiy6TsCZ+6EC68DEqDQJl9XzdHBxej02RBI183ItQrBA?=
 =?us-ascii?Q?BbDpHEnJcFUDlsOrsvncoV/AMA4NX+urAUVaBv9WRLEmEQ9KomMN1euQLt65?=
 =?us-ascii?Q?r3KJChm+QWcNdpo5Eum1onKOt8JwKs/SHA+FloZrK7+HncVqaWCKFegM5g0Y?=
 =?us-ascii?Q?cD/3/j/uW8ex2dPhTucFMWGFn7fp/8ur/C29kuQu1S48NpSZ0kUSMqhVEFfI?=
 =?us-ascii?Q?9bLpbnoXSEFzHJ+zg8QqX+9+jvFTF81CuCppPBIB8JtZTU8AFrqsyJUyqQRN?=
 =?us-ascii?Q?qiaqbj2071E0ueNFqjetbc7VJAmauzlt4TcFYcopTH6plUUJ5Y1Ml2XjhCyc?=
 =?us-ascii?Q?+C84JQWJcGgVOXVMoES3LrzgrWb2jWgbBEnp3/QUOI6lrNFbjCuJz7qTHOpj?=
 =?us-ascii?Q?UrluDK9HpMPNCLfHa8AZQVkiUXETBV1i9t2CSIYLNM5V51Qr/vKyBn+b1Pij?=
 =?us-ascii?Q?rKBcck887VQB2ZiHQcwcQLkBVbcqiUutIMracThhyxJcUe0uhpxIt3I8GkYl?=
 =?us-ascii?Q?9NrRu/dIxc0QyRqmgdiPYX1m/4ny8pKLPyAYRSX1OlbgpUrcHKeTL12dRXiV?=
 =?us-ascii?Q?VKb8yfQJN7LdWoibHliOfsWFGp1Eu5yZkQw2TaOa/WbbeAk/LHaAu4u6TduY?=
 =?us-ascii?Q?UFSKx6B+pS+v8SRnKbA8iOO0jhFiRdyD8YLvQ4OkAgpXLXeEd5BeXrs/Gcde?=
 =?us-ascii?Q?p2Fnfy13y5fKd+lW6O13ykE8kDYTlGRXQKB28t0G3x6h6f2tBgDy3b+xyY58?=
 =?us-ascii?Q?y/kDxyRuAH9ZKJQTQmCO5gjlCT3DpJdOmrt1iGRS4FbdOmWqWpo04NMMNUZT?=
 =?us-ascii?Q?4RbXC/yv7JU1mMLphHfuJHss35uXy7ld76ch3tBsSU95Gu4Zbm4zkiXTq276?=
 =?us-ascii?Q?YpJkUKtxO40KfCwoovkPkUR5GtratglisVok7524NPbwaOesS84U40/2Hxkq?=
 =?us-ascii?Q?HSyBrCjin7qJOHvzOUWyYveuxBPZViwsOApurX9NqjT6wEoaQB8hZtluGDQZ?=
 =?us-ascii?Q?zRiM2zSnWeWyjYqdrDSHYIRW9rXzqhuYV9ElLM2EL9Q5kiNIDU7Wu7WH/e4A?=
 =?us-ascii?Q?AlxsewDSY/90mf/FPJLwbnwm28PAgUF+9O/PrS+9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a829d69e-a6b0-452e-ec85-08dc39ebaa92
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:32:32.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwzbZW7aGmu4Z4weKGUp700ouPeB827wri+dh0ZmuCQ7zbAIGA3OfnqOqWDOl2liE/B3ynJIFx5N/vZmwL2Rtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-OriginatorOrg: intel.com

> +void guest_shared_mem(void)
> +{
> +	uint32_t *test_mem_shared_gva =
> +		(uint32_t *)TDX_SHARED_MEM_TEST_SHARED_GVA;
> +
> +	uint64_t placeholder;
> +	uint64_t ret;
> +
> +	/* Map gpa as shared */
> +	ret = tdg_vp_vmcall_map_gpa(test_mem_shared_gpa, PAGE_SIZE,
> +				    &placeholder);
> +	if (ret)
> +		tdx_test_fatal_with_data(ret, __LINE__);
> +
> +	*test_mem_shared_gva = TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE;
> +
> +	/* Exit so host can read shared value */
> +	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> +					   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					   &placeholder);
> +	if (ret)
> +		tdx_test_fatal_with_data(ret, __LINE__);
> +
> +	/* Read value written by host and send it back out for verification */
> +	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> +					   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					   (uint64_t *)test_mem_shared_gva);
> +	if (ret)
> +		tdx_test_fatal_with_data(ret, __LINE__);
> +}
> +
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
> +	sync_global_to_guest(vm, test_mem_private_gpa);
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
The first VMExit should be caused by tdvmcall map gpa, so it's
impossible to be guest failure.

Move this line TDX_TEST_CHECK_GUEST_FAILURE(vcpu) to after the next td_vcpu_run()
is better.
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
 

