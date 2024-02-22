Return-Path: <linux-kselftest+bounces-5269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4871685F4FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FAE2B213A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733338DD8;
	Thu, 22 Feb 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THTUJLWl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA713770E;
	Thu, 22 Feb 2024 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595364; cv=fail; b=g0j0PgClRzRXA7hC/+RRfYoPJXwtV0jUN10BS36YmmdCLMY8EMObpqW7jXFiqSHj8fTBNWRpB6YNh4duVEPNT842WOdkYwZ8/h0K4e1bRV/6SlG8a/nXOv5z5ODS+WFpKikvK8xW7JhHQtmpIAuyU+rth7ibyhXfL11QkC2GA+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595364; c=relaxed/simple;
	bh=TcbddOW0PmGv9TbuxP4H64tkXi3ekFM9uTI3FVKJqRo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PzjpzIRo+omMkWPDIU4VneZv5mWAj79uAfDHuj0p8t/4uP6hwvSMVs2RF5oZ8x/X7bj3Zpez1o1xv1GZiAOY39pUUMlsIneEIyotrh5mQ3HMffLg9NYF706e4V116kypzAWhYLBLwydhOZKmJ2jSLZmWynZA5aQ3h/wC3IzGcUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THTUJLWl; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708595363; x=1740131363;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=TcbddOW0PmGv9TbuxP4H64tkXi3ekFM9uTI3FVKJqRo=;
  b=THTUJLWl8W1aCdCJsHo74fbVZaceqSLOiVrhi2r8hbWU6EadmeVqcUpu
   KvGeDb89weT1vmpxLRSB0QTvmRzqOcCoC69Xp7xrqNFHfU5g9DisCnDKi
   v6JPZdLzXi0oRd5gxonYCsUOexa1CBWm6ti2N+8ju36WAo/Go7xGzoxzh
   jS+JndYTVdLV113j4t/w/HCzoVWf37gpvcjZkc+uuieY0eUBzow+1FJnJ
   Bbwr83NKbM+3blC04dYCwIRHFcwjEAKy9dQHOnZd844ggCrEaPPbwWahs
   fMt0sguTeJBbPkaEc6jOmsKRFj5w/iIsZx1aBdoMPEuj0dt/23pjo8hTb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2960361"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2960361"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:49:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5599699"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 01:49:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 01:49:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 01:49:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 01:49:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvWqVd4TwurtO2khtZEN6j4LI6PEeE0+gqYndPbaqKKidOCe2GFywkAinYGHjMPSzA2pweUbjb6HoLHvrCKJJMQJ5px4rZOyKBatAP5kCZ5DFVdaYnM7cNGGOgAHhUCBuY71BxPK3E4oOaHW5o4mEeLuZMQyQWa8aYcble8tHsMgLhpR8WdpbpO9PJbEsr/UnaZYu/feoxdwEPO8GRu5aHiWHpwa1zteBgqhcV9wpTOjuFTI1AMMs5651SbtuGWQETvzPd4sbxsTOKW0Gfx2Eg9YhQVVr1FGSm7ZTKn3KXyIOQgwXwn8E8qDYG83lyghoJBGNF6N14YxgMOqxWw9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4i9K2mAYfzaBW3StavZfOlLKdJYGjI3CKpj58bprPY=;
 b=lAmZIw+UNoCRwCBIlBzucCY9R3C9io6RsZNfZgp5RHj5YBlb3Mo4eplGmfz0Lwd71fl/LPyfwBwlu1US6b0je6DFzlAN8ZUCuII/SvxRKe8qSvnhTq4JXbIOxMK2aNVYvdRHMiSflvnBxMRfG1Tn7Od5t4IGllmqmC+/6B3Q9TP7OhkggHtip7N9Sg0r7T9fHGWkPoHsG48JMSPvGLFfxEiNIfJFcEZStytft1jc+PJ8nH3ACStfHlZ2Dwt0RTuRCCau8AMsvWD3IIJfNFuQwR5rGwW9/q26TsqediA7F+n5AlJRedF3qOE20TCcqnEilEcA3OQhKyTDFIoIttQarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 BL1PR11MB5365.namprd11.prod.outlook.com (2603:10b6:208:308::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 09:49:18 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 09:49:18 +0000
Date: Thu, 22 Feb 2024 17:19:32 +0800
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
Subject: Re: [RFC PATCH v5 07/29] KVM: selftests: TDX: Update
 load_td_memory_region for VM memory backed by guest memfd
Message-ID: <ZdcRpHB43OxY8mpX@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-8-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-8-sagis@google.com>
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|BL1PR11MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e430a9-616b-4ba5-bc8e-08dc338b899d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gt/rf97YpOW9gvQrnWN8sn8GmwZ2SekmlA0Ze0t+5bG4aSsCRO0dfVaqvyv8LV2rz+OCEbcaejXmEKwASpssXK4WTIlnfZF9/vSz8bnSE4hQQyW65/CY++1OOd6ZKlGIJvnL9nJobYrhP3vD5G4eHaUDu/skaPKkBQPsGUwa98WYTfdUCD6D68BugPtBnSMMeSynC51SUhUtbIzvagnm3wSAUUds3MKiP3LzS3OLSS/tWvToy6tjR4pq9TllVrzMagz+d43D3uhVsDrcgwrlXEPD7oJZxnKwrgtr2J0VHRwZUY9JZIv2YlP6/ii4SJ9BwCUie2tJsRuTOQ0FXLQAGYhFzmZJH7SnihCzNE7KTbHTHODReU9Ob01G8/YkO4PSwJhwFqtTUSPrPqSKInbbNkIVK4mYIsdmVhETV8tmD5/aGihVMySKC5pgDrP0QXx1TjsX6axTndDTJCig8wzq9ZCEBU2pSLwI0QHjsrDRF1HbeNarQPC/rsL6bWLy7JTVdRzamMZYqMokKhQ5CK418KoQUhR6o2qu+P7ba6UP3tQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TdxBi4l4VM3swG/lHdvz+7feu2/7q7+Q7XZckDa7srhz7UblS2Mj7VsClLRE?=
 =?us-ascii?Q?A7ddyWGCpxx9MEkVkg+1dswCsWzE5yQ0q0fompEWPPyKQgJqVULa8wVDhGDO?=
 =?us-ascii?Q?c0ml2RiicFjIWkTSnaPONwRXUUQhQ7MJN/fuQbmJqso1Nrajk75bOMhFaFSg?=
 =?us-ascii?Q?vTy7/lNTZ2xn3kI2kEYar/kI9Rn0I3XUYGe6TKcULN4lm2EdUePzEMHc0y+2?=
 =?us-ascii?Q?GTWqX7AZbPeO9PZuJQs8nEJrmtWkq1sPHLgOqHqSoaP4Gzjm3l4bZuFeKitn?=
 =?us-ascii?Q?IoN85XOS9hN7O7+xg75bY3Snh37Yvavu+orc/63qE161ZbtIUBAhi/bTR88y?=
 =?us-ascii?Q?c0WG/KeSTxeN4OhRBFbCl2+joKeAmCfmk5QVFpr2t2IZ/mnY/fP9SOxk9I5m?=
 =?us-ascii?Q?HyizPyWBo2c2XErPU7NcBMD/Uqzwm9mArAmuxILVO8+vKGpGVEHIhv95ozo0?=
 =?us-ascii?Q?7nxVvEwxzXiBw1z0s1KtZpk7VwCDtFa+4hA6KzSnYPKG8jvkur/buRD8Vpq4?=
 =?us-ascii?Q?AdfhwHYbhodKqjsM0ZuIfvkVqlh6UdINELTnekeNT0Ls1IUJJOdJgO7TxH0w?=
 =?us-ascii?Q?dEM53pinzN6lR+QvBvs7KYSpQEHzJG01/T72Kg+pXM6UvHFSgEzIP3rZyLrf?=
 =?us-ascii?Q?ZJrPJp1KIB5FKUSLZmHipxluHZKfRTfFN+8jNSlKEWFqXWSuA4q0pV5J4zmr?=
 =?us-ascii?Q?/K8SNdvinuQz0ggVj5blKqOxRob7t9C3C1HnM2Ct8nHs2dAwQfcJWZ9aHHHP?=
 =?us-ascii?Q?7OhDPp/yOog32OuTjtVqmO615/cJ7PDVPEtdgOWaH5AEGJ7N1lRydbmpElgi?=
 =?us-ascii?Q?QadbAcbEqJY5Num3ZdMQxXTXhUPcmqrzArkYZJYOTReVZHyP5QPsCxc2k2Me?=
 =?us-ascii?Q?BIemS3t7bsCrz8oQUCNwCNVYF8GZ0s2Z8Hzu0kM81lI1fK8DnVmHjPMMhqB2?=
 =?us-ascii?Q?vyPpeqF2urt+fRw/A+WxTIbOsKFb/Sc/lbe8M8jGWazA1Yv8KeXhZ0vlN610?=
 =?us-ascii?Q?2/ReJeoUhkMKBsn5EHIjjHf2iuWyaZx21+bFyM5O9HY+ktYJVIP+L2ayZ3SS?=
 =?us-ascii?Q?uQ5nUG6GRDXsoimkj6gXmhmo5XrN3hnHn+XOzuWDpe0DilKAoiJz94LvD2SX?=
 =?us-ascii?Q?sSup8tW17H2NEIuqoWl8B1wWKpkwaQrG3f98mpDY7j/sOTbMyyiJUw0DVxmD?=
 =?us-ascii?Q?VIXMCwCQnzJwJVQAfc1mwjKgH3Q+2tAOxZ6XC12DeTmlPkYSf3FXRdJ+XXMw?=
 =?us-ascii?Q?LW640AqOOVeNwXGXK3qBlyzOYYK3a+IvLrrLSFkRKb8GyNoA6NCLEcZElq9k?=
 =?us-ascii?Q?RNl743k8WocA/u6AyZk3uq6Vb/KqKXvsEoo8iJH7UwkQ6hJo6eDd/r0KcJKy?=
 =?us-ascii?Q?keXQrYnMCJ0eAlkZhB8QUaox1tHxgUPjaMy/ZxkktIu/8wrzgY2tccy1XIZo?=
 =?us-ascii?Q?RF0mtIQAhbdBf24mD2JofaabgykkY5eoXCmAVGRuR5iqYSm3HtdWpueBR4CA?=
 =?us-ascii?Q?iotacAp9jXgVxH9af9q8o5Yd2B2Nonlb8liQBIBBFU4keMTY5da0TNVLxqVA?=
 =?us-ascii?Q?blg2RnoF/AklIdWt3cucUZcnchIusuZ/Gxq8JrRA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e430a9-616b-4ba5-bc8e-08dc338b899d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 09:49:18.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EqOYKp4Mjs61ygcxbZxRhU7aPMzfCO6JFdgYZZQaCO+EOwHzqM+Si1amSPbT6VZ5qwrMBJ2zKkuNeMjvUNXZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5365
X-OriginatorOrg: intel.com

On Tue, Dec 12, 2023 at 12:46:22PM -0800, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> If guest memory is backed by restricted memfd
> 
> + UPM is being used, hence encrypted memory region has to be
>   registered
> + Can avoid making a copy of guest memory before getting TDX to
>   initialize the memory region
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 41 +++++++++++++++----
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> index 6b995c3f6153..063ff486fb86 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> @@ -192,6 +192,21 @@ static void tdx_td_finalizemr(struct kvm_vm *vm)
>  	tdx_ioctl(vm->fd, KVM_TDX_FINALIZE_VM, 0, NULL);
>  }
>  
> +/*
> + * Other ioctls
> + */
> +
> +/**
> + * Register a memory region that may contain encrypted data in KVM.
> + */
> +static void register_encrypted_memory_region(
> +	struct kvm_vm *vm, struct userspace_mem_region *region)
> +{
> +	vm_set_memory_attributes(vm, region->region.guest_phys_addr,
> +				 region->region.memory_size,
> +				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +}
> +
>  /*
>   * TD creation/setup/finalization
>   */
> @@ -376,30 +391,38 @@ static void load_td_memory_region(struct kvm_vm *vm,
>  	if (!sparsebit_any_set(pages))
>  		return;
>  
> +
> +	if (region->region.guest_memfd != -1)
> +		register_encrypted_memory_region(vm, region);
> +
>  	sparsebit_for_each_set_range(pages, i, j) {
>  		const uint64_t size_to_load = (j - i + 1) * vm->page_size;
>  		const uint64_t offset =
>  			(i - lowest_page_in_region) * vm->page_size;
>  		const uint64_t hva = hva_base + offset;
>  		const uint64_t gpa = gpa_base + offset;
> -		void *source_addr;
> +		void *source_addr = (void *)hva;
>  
>  		/*
>  		 * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place,
>  		 * hence we have to make a copy if there's only one backing
>  		 * memory source
>  		 */
> -		source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
> -				   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> -		TEST_ASSERT(
> -			source_addr,
> -			"Could not allocate memory for loading memory region");
> -
> -		memcpy(source_addr, (void *)hva, size_to_load);
> +		if (region->region.guest_memfd == -1) {
> +			source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
> +					MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +			TEST_ASSERT(
> +				source_addr,
> +				"Could not allocate memory for loading memory region");
> +
> +			memcpy(source_addr, (void *)hva, size_to_load);
> +			memset((void *)hva, 0, size_to_load);
> +		}
>  
>  		tdx_init_mem_region(vm, source_addr, gpa, size_to_load);
>  
> -		munmap(source_addr, size_to_load);
> +		if (region->region.guest_memfd == -1)
> +			munmap(source_addr, size_to_load);
>  	}

For memslot 0, 1, 2, when guest_memfd != -1,
is it possible to also munmap(mmap_start, mmap_size) after finish loading?

>  }
>  
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

