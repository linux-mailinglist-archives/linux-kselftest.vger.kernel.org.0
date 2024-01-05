Return-Path: <linux-kselftest+bounces-2658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC54C8251AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 11:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0F81C22EB3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D49F28DD1;
	Fri,  5 Jan 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fy2tney7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5791025116;
	Fri,  5 Jan 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704449733; x=1735985733;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=b344AA7adbJGRrUBqatP2mNk+Sx3GNR+s8BPjDYzFKc=;
  b=Fy2tney7dTPKz7TnoHp6DkKm3W/fzwysqoELSoZTD8l0l1jfvxtlNkf8
   MPXH2+UhPZ1lRLXI2W6PQjmP1ci9qOQiElttHGRpy7uim+HSoWOwXhpJo
   e7j0Xb4msa2TbQ5PqbVjRmMjMfl8cpYLFhYsAvf6Q95qKNj1qQXR2SXwH
   IAwKG3QbiB/mNiaEXCHlpBJsHntN99djWsCl8gX+UgO6gJfNv+yzKPwBv
   US8GRb8cyyFXu857p/ZsErP84+Jvqce+WjAasLdQQE4zODxd0bgErvhdq
   hEro6hE6F81pv8vtr/o8HEYnVjTHJp+s/VC8QNDclsu141F2GO7a0Brgt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="10849994"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="10849994"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 02:15:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1027725227"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="1027725227"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 02:15:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 02:15:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 02:15:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 02:15:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiB1qx2KJAtXI/+7G1ti+qjJyGblN2afBCUpu31+YzpvvUTCYFg4ucICuzmzgG2Gym3y4fNKw/1WV0yrXKR2AyUbIT9lgM+Ye+P7FfnVuUd+bpkEH6q/kDzginoFaqSWSYavVZ69WA6UzAsEiMOx0iPxuX1NuypC+HZmLk2N/BkTLu7b4hKvCS3Un9HAMNaQzaIjgX8repIFYy/C2uwu7ciiD9E1RQ+rISmxL0K/tfvDvW8nhGToCTWsxW6bS21yJ9CSvNdGN0ky/lPEFVHGnqOvy2xEAzov8T2BrQcnTwkPHcEOq5hKqV1S2bhbXTFjXPMN0FakNPzV3Zt2BnIDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G/JALNss/Meq/0/PcBpBD+d0uujAlMfzlKPzpy8ihs=;
 b=JQUnvhSaxC8B2bTchvWMPXKB+u8UtC+bbKRx8aa5MOln8hjifz6iLJQYf1yuTUoaF+dYJTtBYNIQiM6mITu82PRztizdmHn4mQrANq7mILUhWbVVN0opuEwDMaXBDHJSKARJDfEH0O6I1/zapLw2VU2LUiqqvRqf531cp/haxy6iVUm4NRCAFQm5yGdPQ0uEOdO6zkHboFqUj0KUt3BA8J7D2UUgBZLtgFYH+KzfCcXAjWj3o0JPJ0agP54Monjdd08H0bYkiu3t1uheozDsHu/BMoq3kytWvLtm9JF2fxtcPWfbeh4rNF4Ku6Gx7bHioSQo2uyw6gZ4/bOU8SqAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.17; Fri, 5 Jan 2024 10:15:25 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::32a9:54b8:4253:31d4]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::32a9:54b8:4253:31d4%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 10:15:24 +0000
Date: Fri, 5 Jan 2024 17:46:07 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Yuan Yao <yuan.yao@linux.intel.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <shuah@kernel.org>, <stevensd@chromium.org>
Subject: Re: [RFC PATCH v2 2/3] KVM: selftests: add selftest driver for KVM
 to test memory slots for MMIO BARs
Message-ID: <ZZfP3/pYyPnbgL3P@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
 <20240103084457.20086-1-yan.y.zhao@intel.com>
 <20240104081604.ab4uurfoennzy5oj@yy-desk-7060>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104081604.ab4uurfoennzy5oj@yy-desk-7060>
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|CO1PR11MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e0c832-9314-4ebe-d7cc-08dc0dd73b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPibXa3gelQ2KTh2Sa9bQcLkejBYuM4VujO/PeM01xXJxflQofOAMlDx/rlG5WNAz1Iho4xUAx4A0ayu7pwyQkrTYHc/taw5gHSISQhjbsxIBeoCVP+u98rRzWWqlymfiotgrFIS0yy2laDapQ0Sk76uXlv9XEQXwsceOeooxnT7J1ZqmwjofH1WeP5youtrgL2ZZ/RIBK0HMU57+uvhvc6Zo6g9mhbPiOZH547HThf7qD8g77z8Wyag2WMMqUzGrdnO80/uWT0zGfKAof/2NOisL2aGitSrr0rDUavsoHCYIxSjWx3/4ec7QznBWY24TEGJttp7SgxrfGRJL1b1YOuHNGvbXHdG3jdchqdjlaI0EWnYGCSaL3v0lG1aG7wdlqk/rrkDEkSBsAJv+p5IoLq365PmBoTbXsahd4qFaAEcvge/qsNIY1HxTsLCPao+PVTmRIor1iFiV/PRS3FbEMizw5akfGuvd6LZRCDyWTW/NeSH6Irkh7mk5KwlWlkOkxx+iRp6Cjxkz0pt1CWtSEzZcc/VbETSOJA9X82Z/Th20ikMAvibTdmFzR4ESLOz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(86362001)(478600001)(6512007)(41300700001)(82960400001)(6666004)(6506007)(54906003)(5660300002)(30864003)(2906002)(3450700001)(6486002)(316002)(6916009)(66556008)(66476007)(66946007)(8936002)(8676002)(4326008)(38100700002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dZXz0VyE5JNNUiSEARmaVWpvkNHNe/Q14akKY7MQ0LhfHSPuuffONNQ+h56p?=
 =?us-ascii?Q?4QnKPmuET8NVGtrDXZqj/XUeEvNUQ7tGzfxaehFgl7MO+0ooQ+GxybqR8QOJ?=
 =?us-ascii?Q?+GBhYzsqsddOK4VneWT69RcKYHI05yzIRbtv/KRAQ1ZkUlkOvMp+zGoksfmw?=
 =?us-ascii?Q?HLklFuHIF8KQm01XN5iw2oC36Le7nbeVWn71cp0UETN93JnQsofvy4u04dJw?=
 =?us-ascii?Q?wJIjqI8DPmOdYqdV/phZO4WtxGy2Rc+t1JveU65SubqZxex77x0hRn2HNGIo?=
 =?us-ascii?Q?epoBdBqTxzGYaZfoOfFqI033u0wo1BNmpCnXq2iMyNeAz3+hHqNsqbjbinHo?=
 =?us-ascii?Q?BqMxEZaqjp/SlJGbyjXD8XBEmiuseviM5sw9ZOOuEUtwgqmN7W7LMQN1srJ8?=
 =?us-ascii?Q?JDnd9JQeATyt1tMXLqRRjoubYgChyWtyCB9vmi32qg6UrKcZuarNbyg+M2iW?=
 =?us-ascii?Q?Pw9LQPbkQevQr2yYKj62I4oIsivavZFbNaUwN1Eqxve7xTq0jbpqMsKzOVxM?=
 =?us-ascii?Q?IWYtEsXQvKaCIYja0A4u5JV+VCtDL3zp+Vx76v99kCpOz2XVdOxTexxTFQxh?=
 =?us-ascii?Q?kgEGgHBcrPtoJOqYbrgKf5uxUPoCC73tPegAj1nK6CSblITjCrsAUCnnWmWG?=
 =?us-ascii?Q?lKdLlpbVB6B9tBaxAtOQyRwm/VH4S102gvmQKYeEtviVc4dI+a0EYBJa7Yal?=
 =?us-ascii?Q?P5z+XmbpTW5a/QkG1872slKvQlWHp9jlsJ4jfIPcNoIl6uMOZuEs0ZgF8/K1?=
 =?us-ascii?Q?NeYHJWf7w2Lmvl2V/jeGOZqpyvhh7NgWF8/0EbLXi/VD/DFJmTeULcgrf/1A?=
 =?us-ascii?Q?zkZK5CctY3ORxarcQwStCJC70ROpF892afktiMtTrge2pGvozOWeiaMEaGd6?=
 =?us-ascii?Q?GlD62p6JAZl8kVupOtdP4BXNjwCfxXHmNVpm5CUl+A5rBVlofVizOtG6A2vH?=
 =?us-ascii?Q?rdQWA1oU0yuET85RCunGJsqwzVM7e1W6ZDmBOKH6nrVK/Z/xvlC0FIGpCPbR?=
 =?us-ascii?Q?nr7UbVSSmUAo/UAcSmaknEohLbAlnKm+wCddbETVPR07ZZS3jlOZSu0OpAAg?=
 =?us-ascii?Q?jSlzLKFLy5tB5D8X2JaMV7U0amteq54RkseoDnMt8elv16+WNnMntp2NBeAi?=
 =?us-ascii?Q?yS9aXqKAIv2S0TVbnBl+QZVq4tlQvN34vIm+gWHUPxSWnVqdAU5/TbHUUhXl?=
 =?us-ascii?Q?cxOM6CfJPuhUuNbnqZTXdIS6i66Vh5grhriTlGDs3SqoiPWT4R2SsfeJbl3X?=
 =?us-ascii?Q?lGjPMvTghUlpMDoBXb1kWVZowI8dqWEtWQjRzDHyca31Hi3ZV0Pu8IH4zTMh?=
 =?us-ascii?Q?kgG8sJ+E9rKAznhfnQkP0SvoD4i0TjNbztEKVSHLUiLEgaIFzJaGStBcvcxd?=
 =?us-ascii?Q?AAN8Axq4jCpgn37HicBZq3I/yHMiGnhOu8LSaEMbKF/RX0lJX3jhmapcPNlz?=
 =?us-ascii?Q?I4aDXnxaOjKumypRitunKUDhmK4OLL8W4rPCc/4Zqs1roV+YNRdfnfpUlZjp?=
 =?us-ascii?Q?g2rC/VbFVsMWzH50HMKNzJRe3OFVxCvatVxtVrjec757QMiVR3F0495YuDRO?=
 =?us-ascii?Q?KMUY9jkQCHCzqyWmmGHPm1TwMVPECNVF2RtfHAVI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e0c832-9314-4ebe-d7cc-08dc0dd73b8b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 10:15:24.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkigFSXWwmgJ3SuOsUy2FBaqGKjvZLtPZtBf3t3yxCeuNgRC1LnweVpEU7bW9zqqeV0I3SrHtSAsT8jfI4rG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140
X-OriginatorOrg: intel.com

On Thu, Jan 04, 2024 at 04:16:04PM +0800, Yuan Yao wrote:
> On Wed, Jan 03, 2024 at 04:44:57PM +0800, Yan Zhao wrote:
> > This driver is for testing KVM memory slots for device MMIO BARs that are
> > mapped to pages serving as device resources.
> >
> > This driver implements a mock device whose device resources are pages
> > array that can be mmaped into user space. It provides ioctl interface to
> > users to configure whether the pages are allocated as a compound huge page
> > or not.
> 
> I just think that it can be used in other scenarios, not only KVM.
> 
Right. But I just want to make it to serve only KVM specific tests :)

> >
> > KVM selftest code can then map the mock device resource to KVM memslots
> > to check if any error encountered. After VM shutdown, mock device
> > resource's page reference counters are checked to ensure KVM does not hold
> > extra reference count during memslot add/removal.
> >
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
...

> > +struct kvm_mock_device {
> > +	bool compound;
> > +	struct page *resource;
> > +	u64 bar_size;
> > +	int order;
> 
> Do you have plan to allow user to change the bar_size via IOCTL ?
> If no "order" and "bar_size" can be removed.
> 
Currently no. But this structure is private to the test driver.
What the benefit to remove the two?

> > +	int *ref_array;
> > +	struct mutex lock;
> > +	bool prepared;
> > +};
> > +
> > +static bool opened;
> > +
> > +#define BAR_SIZE 0x200000UL
> > +#define DEFAULT_COMPOUND true
> 
> "kmdev->compound = true;" is more easy to understand,
> but "kmdev->compound = DEFAULT_COMPOUND;" not.
>
Ok. But I want to make the state that "default compound state is true"
more explicit and configurable by a macro.


> > +
> > +static vm_fault_t kvm_mock_device_mmap_fault(struct vm_fault *vmf)
> > +{
> > +	struct vm_area_struct *vma = vmf->vma;
> > +	struct kvm_mock_device *kmdev = vma->vm_private_data;
> > +	struct page *p = kmdev->resource;
> > +	vm_fault_t ret = VM_FAULT_NOPAGE;
> > +	unsigned long addr;
> > +	int i;
> > +
> > +	for (addr = vma->vm_start, i = vma->vm_pgoff; addr < vma->vm_end;
> > +	     addr += PAGE_SIZE, i++) {
> 
> Just question:
> Will it be enough if only map the accessed page for the testing purpose ?
>
It should be enough.
But as VFIO usually maps the whole BAR in a single fault, I want to
keep align with it :)

> > +
> > +		ret = vmf_insert_pfn(vma, addr, page_to_pfn(p + i));
> > +		if (ret == VM_FAULT_NOPAGE)
> > +			continue;
> > +
> > +		zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
> > +		return ret;
> > +
> > +	}
> > +	return ret;
> > +}
> > +
> > +static const struct vm_operations_struct kvm_mock_device_mmap_ops = {
> > +	.fault = kvm_mock_device_mmap_fault,
> > +};
> > +
> > +static int kvm_mock_device_fops_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +	struct kvm_mock_device *kmdev = file->private_data;
> > +	u64 offset, req_len;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&kmdev->lock);
> > +	if (!kmdev->prepared) {
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	offset = vma->vm_pgoff << PAGE_SHIFT;
> > +	req_len = vma->vm_end - vma->vm_start;
> > +	if (offset + req_len > BAR_SIZE) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> > +	vma->vm_ops = &kvm_mock_device_mmap_ops;
> > +	vma->vm_private_data = kmdev;
> > +out:
> > +	mutex_unlock(&kmdev->lock);
> > +	return ret;
> > +}
> > +
> > +static int kvm_mock_device_prepare_resource(struct kvm_mock_device *kmdev)
> > +{
> > +	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
> > +	unsigned int order = kmdev->order;
> > +	unsigned long count = 1 << order;
> > +	unsigned long i;
> > +	struct page *p;
> > +	int ret;
> > +
> > +	mutex_lock(&kmdev->lock);
> > +	if (kmdev->prepared) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	if (kmdev->compound)
> > +		gfp_flags |= __GFP_COMP;
> > +
> > +	p = alloc_pages_node(0, gfp_flags, order);
> 
> Please alloc_pages() to honor the memory policy of current task.
> Hardcode to node 0 just works, but not hard to do this better.
>
Ok, will do it. thanks!

> > +	if (!p) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	kmdev->ref_array = kmalloc_array(count, sizeof(kmdev->ref_array),
> > +					 GFP_KERNEL_ACCOUNT);
> > +	if (!kmdev->ref_array) {
> > +		__free_pages(p, order);
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	for (i = 0; i < count; i++)
> > +		kmdev->ref_array[i] = page_ref_count(p + i);
> > +
> > +	kmdev->resource = p;
> > +	kmdev->prepared = true;
> > +out:
> > +	mutex_unlock(&kmdev->lock);
> > +	return ret;
> > +}
> > +
> > +static int kvm_mock_device_check_resource_ref(struct kvm_mock_device *kmdev)
> > +{
> > +	u32 i, count = 1 << kmdev->order;
> > +	struct page *p = kmdev->resource;
> > +	int inequal = 0;
> > +
> > +	mutex_lock(&kmdev->lock);
> > +	if (!kmdev->prepared) {
> > +		mutex_unlock(&kmdev->lock);
> > +		return -ENODEV;
> > +	}
> > +
> > +	for (i = 0; i < count; i++) {
> > +		if (kmdev->ref_array[i] == page_ref_count(p + i))
> > +			continue;
> > +
> > +		pr_err("kvm test device check resource page %d old ref=%d new ref=%d\n",
> > +			i, kmdev->ref_array[i], page_ref_count(p + i));
> 
> How about just return a bitmap to userspace for each page ineuqal ?
> Or if inequal number itself is enough then just remove this output, in worst case
> it prints 512 times for 2MB bar case, which looks just useless.
> 
Right, print for 512 times is too much though it will only appear in the
worst failure case.
But I do think the info of "old ref" and "new ref" are useful for debugging.
So, instead of printing bitmap, what about only printing the error message
for once for the first error page?

> > +		inequal++;
> > +	}
> > +	mutex_unlock(&kmdev->lock);
> > +
> > +	return inequal;
> > +}
> > +
> > +static int kvm_mock_device_fops_open(struct inode *inode, struct file *filp)
> > +{
> > +	struct kvm_mock_device *kmdev;
> > +
> > +	if (opened)
> > +		return -EBUSY;
> 
> It can't work in case of 2 who open the device file at *real* same time, at least
> you need atomic helpers for that purpose.
> 
Ah, right. Will turn it to atomic.

> BTW I saw "kvm_mock_devie" instance is per file level, so maybe not hard
> to remove this limitation ?
Yes, but as it's a test driver, I don't see any needs to complicate the code.

> > +
> > +	kmdev = kzalloc(sizeof(*kmdev), GFP_KERNEL_ACCOUNT);
> > +	if (!kmdev)
> > +		return -ENOMEM;
> > +
> > +	kmdev->compound = DEFAULT_COMPOUND;
> > +	kmdev->bar_size = BAR_SIZE;
> > +	kmdev->order = get_order(kmdev->bar_size);
> > +	mutex_init(&kmdev->lock);
> > +	filp->private_data = kmdev;
> > +
> > +	opened = true;
> > +	return 0;
> > +}
> > +
> > +static int kvm_mock_device_fops_release(struct inode *inode, struct file *filp)
> > +{
> > +	struct kvm_mock_device *kmdev = filp->private_data;
> > +
> > +	if (kmdev->prepared)
> > +		__free_pages(kmdev->resource, kmdev->order);
> > +	mutex_destroy(&kmdev->lock);
> > +	kfree(kmdev->ref_array);
> > +	kfree(kmdev);
> > +	opened = false;
> > +	return 0;
> > +}
> > +
> > +static long kvm_mock_device_fops_unlocked_ioctl(struct file *filp,
> > +					unsigned int command,
> > +					unsigned long arg)
> > +{
> > +	struct kvm_mock_device *kmdev = filp->private_data;
> > +	int r;
> > +
> > +	switch (command) {
> > +	case KVM_MOCK_DEVICE_GET_BAR_SIZE: {
> > +		u64 bar_size;
> > +
> > +		bar_size = kmdev->bar_size;
> > +		r = put_user(bar_size, (u64 __user *)arg);
> > +		break;
> > +	}
> > +	case KVM_MOCK_DEVICE_PREPARE_RESOURCE: {
> > +		u32 compound;
> > +
> > +		r = get_user(compound, (u32 __user *)arg);
> > +		if (r)
> > +			return r;
> > +
> > +		kmdev->compound = compound;
> > +		r = kvm_mock_device_prepare_resource(kmdev);
> > +		break;
> > +
> > +	}
> > +	case KVM_MOCK_DEVICE_CHECK_BACKEND_REF: {
> > +		int inequal;
> > +
> > +		inequal = kvm_mock_device_check_resource_ref(kmdev);
> > +
> > +		if (inequal < 0)
> > +			return inequal;
> > +
> > +		r = put_user(inequal, (u32 __user *)arg);
> > +		break;
> > +	}
> > +	default:
> > +		r = -EOPNOTSUPP;
> > +	}
> > +
> > +	return r;
> > +}
> > +
> > +
> > +static const struct file_operations kvm_mock_device_fops = {
> > +	.open		= kvm_mock_device_fops_open,
> > +	.release	= kvm_mock_device_fops_release,
> > +	.mmap		= kvm_mock_device_fops_mmap,
> > +	.unlocked_ioctl = kvm_mock_device_fops_unlocked_ioctl,
> > +	.llseek		= default_llseek,
> > +	.owner		= THIS_MODULE,
> > +};
> > +
> > +
> > +static int __init kvm_mock_device_test_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = alloc_chrdev_region(&kvm_mock_dev.devt, 0, 1, "KVM-MOCK-DEVICE");
> 
> How about misc_register() ? Like how KVM create /dev/kvm.
> I think that will be more simpler.
Ah, right. Will try to use it in next version.

Thanks!

> > +	if (ret)
> > +		goto out;
> > +
> > +	cdev_init(&kvm_mock_dev.cdev, &kvm_mock_device_fops);
> > +	kvm_mock_dev.cdev.owner = THIS_MODULE;
> > +	device_initialize(&kvm_mock_dev.device);
> > +	kvm_mock_dev.device.devt =  MKDEV(MAJOR(kvm_mock_dev.devt), 0);
> > +	ret = dev_set_name(&kvm_mock_dev.device, "kvm_mock_device");
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = cdev_device_add(&kvm_mock_dev.cdev, &kvm_mock_dev.device);
> > +	if (ret)
> > +		goto out;
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> > +static void __exit kvm_mock_device_test_exit(void)
> > +{
> > +	cdev_device_del(&kvm_mock_dev.cdev, &kvm_mock_dev.device);
> > +	unregister_chrdev_region(kvm_mock_dev.devt, 1);
> > +}
> > +
> > +module_init(kvm_mock_device_test_init);
> > +module_exit(kvm_mock_device_test_exit);
> > +MODULE_LICENSE("GPL");
> > diff --git a/lib/test_kvm_mock_device_uapi.h b/lib/test_kvm_mock_device_uapi.h
> > new file mode 100644
> > index 000000000000..227d0bf1d430
> > --- /dev/null
> > +++ b/lib/test_kvm_mock_device_uapi.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * This is a module to help test KVM guest access of KVM mock device's BAR,
> > + * whose backend is mapped to pages.
> > + */
> > +#ifndef _LIB_TEST_KVM_MOCK_DEVICE_UAPI_H
> > +#define _LIB_TEST_KVM_MOCK_DEVICE_UAPI_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/ioctl.h>
> > +
> > +#define KVM_MOCK_DEVICE_GET_BAR_SIZE _IOR('M', 0x00, u64)
> > +#define KVM_MOCK_DEVICE_PREPARE_RESOURCE _IOWR('M', 0x01, u32)
> > +#define KVM_MOCK_DEVICE_CHECK_BACKEND_REF _IOWR('M', 0x02, u32)
> > +
> > +#endif /* _LIB_TEST_KVM_MOCK_DEVICE_UAPI_H */
> > --
> > 2.17.1
> >
> >

