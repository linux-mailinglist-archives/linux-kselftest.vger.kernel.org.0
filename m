Return-Path: <linux-kselftest+bounces-5271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D5785F50B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8419928BA0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907E38DE2;
	Thu, 22 Feb 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYV/IDPt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724CB1799E;
	Thu, 22 Feb 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595670; cv=fail; b=MgO2q++x1qB46+yNATiF7qG87Q+Rug6MEeVcpHg+lD8KfCDtZ8Xsf1hPp79pJOzSksZptqu1leC84wIftH+vtS9uts0K0UKH+x6xnEkXB1YYfNRZQuOEYgr2xlP+umbDGB4u+gXUwSu5IzZqzX8REn2/vHWVUNt+ZNxaFQ9Vtzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595670; c=relaxed/simple;
	bh=Ojz3zbXi08Q0zE9yiY0V2+Lc8+9fv0M7lMo4VW1uTg4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gBra39rKPUjl5lGxEr4Hiqa1cznSXrK7vDt5Fz4Tb7arBKpxfUxqRhkJEHYcwSSnWG1pFL/4dFjnccfCMOtxB5vKBk+yPVrpKG9CJJ1hI4KzABamOLEXro4qp3MBjC+FsM+rnEei34DvOZZJ9kCEgjDdTk5r5OwHnToqWMvNbyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYV/IDPt; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708595669; x=1740131669;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Ojz3zbXi08Q0zE9yiY0V2+Lc8+9fv0M7lMo4VW1uTg4=;
  b=lYV/IDPt+mFYjyjpOhuzLulCCGZV8V/RJvuryurRh//XEe8qYFk1vz/4
   HqcU4T2u+j0mPhdiXMcgTit34SdAhKG77xpYdXkfsdLV3BdD+5Is7ZP57
   vc/K/COwPRxeZmJjnfdwlFyi3xk+clojoJPfdCJWSzwmnqTj7QcU2xxzD
   25y2KAc2b5qbPbLc0S85W/cMuDfRvnDMXw/mbn23WNcavSARmgCckKSDQ
   5dnpyoR3j/ZcbEW3F+iWn0k0tijDAcBZhlJ98eipmO2psM/HKby2N4b/Y
   hlMQmnodPuVxUZHuyh8lIG91bIH+BqYUanCRPkwPddyxsXZHwzO4nBJdt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13430509"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13430509"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:54:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10133632"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 01:54:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 01:54:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 01:54:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 01:54:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 01:54:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKXw+T/jFpG4ZJBvHVYVSTp62kphM7UjFj+P4Mx3fpmPlcwaTDMgkdHCOi97NPkzXlziWeHEfTNpq98Khb0pi4+6BmBbYoFTPY+rv4WmRmA47SiM1JtHV94u0srHjhc7qhRiX+JSKR60Tq3S5FbwNLMPaEaEx2r2sHeNIca3r6tOpHXRNe8Moj8/cA5Lqyw3ROmIVYsa2QXfkRRAz1+a5UsgrhuFzhfuXPJy9WgagE1pAm+zOV/1I1fs8TNw+OCuc6R+LhEamj/kj8UMFp3GKkU3xHK8iU/SOvYp8ZC55utbGGE7w9I0SH3HdrWtZwjhUAgOqlRPUFaRFFNB0zyWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vypzE2w7ck+pA8K5lYgnYFemjO9FqPbkDKmD3P1P1XY=;
 b=ihoqEiFHkMfFKRZdGPoFi0ofBLeo2/Q4PikQ6hY/fPTN75kbLjPSFYvomLwbZvte7M5t9QQiOZFxoP8CuJHpc5XnGDqAyuVFXixwgWNRtXhuSQk2D9IkGi6k58/2iL5rBygGCe7HE1yhB1zl5nV7zmMR1CD5nYtuwU1VFCnylA376ZL/dGVmTd3PpPdj3rI7ZOtAMz77rlnk2YKj9ojrYomXKFlg9M8PoN8tJxC+t7Oj6pmujE3MJY+d0FMX1UFbkBZd2U5AREWwIPQXoTvJhVGZDUELxcZBeZ3iBL65uj/U9xOqaR44n52sVkEO2sq/9a+evCkfiQM/i7WRxcL2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 09:54:24 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 09:54:23 +0000
Date: Thu, 22 Feb 2024 17:24:38 +0800
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
Subject: Re: [RFC PATCH v5 05/29] KVM: selftests: Add helper functions to
 create TDX VMs
Message-ID: <ZdcS1itARPpIy4P+@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-6-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-6-sagis@google.com>
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SA2PR11MB4891:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b9a5c2-43eb-4d57-f7a9-08dc338c3f9a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SO2HdPnT1SaSraAzBGvaOg0ho+DxrlT78QyMwqK8GCocx8KN3cJwJqPiMsYq0PqSz68W+QDXnDOBMsD/kbBLORf9HAIRIa/P39IRZMwHnM9WWfAPQ/nuJp5mIyV+V/iHWYThMRCnqVQnwzFSFhVG4KLyeYlZ2R2mZkJIbMTq9OTg0+q0Dr5V50R4fQ/j19XRlfgJRXHjwQY+6i+yZ3E313ECGHunQ7crxvvOyJnXOJv+ZvmGT9tdifIuXx8DqOqVC9mBODkGw1Vf4vqbMfPLZYt1rQN28PjNKCVN9DFLoZ/XjQpk9jRQ9QI5hxmyeSrcPTid7ViSLNiRW+eZvxBx0RAHQ17uYxEWaI54Q6fRWo4hBkgvgobzS2E8WzHTP5EzouPkSLTVUE1lgjJ5LgatxSjOGF/Nr4gKTNeWnNUU/NEOt7zK501Bjw5792FTM9JspbyJ0W2IBAknSYMpeYM+diHiUbzOIe9ivvHLDpubDW3c8eDaku6Xe8q4yZ5L0gxxHGcBCnX+z3nE5OS19merZIuQEQTcHjavXm2ltY79zuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sSRg8GBkJyOOgaOQm5norZy8Rz/e0KrBWgEPGUKvzdLzp7mqZ8Pd+FuomZag?=
 =?us-ascii?Q?cDg9rt5m6K7HtT+HLmFHfe6NGdaURaAz94v0OjkTj4iM7WhFjcKhJzh1OM19?=
 =?us-ascii?Q?MasfKWnKyGQSUCwpUiRzlFv53B0wyogSqY+56nkgOZ4v5UEYzkONF839zw4+?=
 =?us-ascii?Q?dJMyDG1gb/0zq+M/nbdJ5wIeWShQksu/JEUjGkJro4b8NTpjGVx20MGBQ9ks?=
 =?us-ascii?Q?by9Qoe82PF8siNKt/g/8WTQ6uQ8XE+bIDtqzQQBdAKpjri/J6Ve7Vvo1qHKl?=
 =?us-ascii?Q?ugdSSFdrU0NQKes9X0w0AJiW6NBiQbeFcYkglOa6IPYJvXFPagviUvVStlqY?=
 =?us-ascii?Q?2IfQ9Ro8Iuj+15kXbjYhH7CiKFd6eY/H2ka81M22lk7GQWdIBfbyQZ2tY4Gg?=
 =?us-ascii?Q?kPWwmhjkcfapFn8SBvm6JUoNtq6v32QjR95M5bwXqMosdxPBghfRbcDSAgtB?=
 =?us-ascii?Q?63eg6hYPVvfXC+181Lp1mMqqwEH/C6ZlJHwVFlyWe6qHL/tgqqoCGZzVfXC1?=
 =?us-ascii?Q?4QLPyoLYsffO/9f4igsMblOwrSq5Kz44tXtwhtpoet4RCXRSyz6KqH5iaQIz?=
 =?us-ascii?Q?v4Kms0CQbE3lqR7uXAYgwhIxy1cw6a2+YowazC5/GJZ0C+QW/AI06Y4dNXm5?=
 =?us-ascii?Q?CZD9lbrCfXukoijXMqAsJj2AePeaPqRAVRm/BgQiyME2+ck0sRetpLddHlv4?=
 =?us-ascii?Q?DgddOBXxi5QRNahg0AAjI89E5Kpjlrl8V80tgafRClWN20d1aFgC7wx2hOza?=
 =?us-ascii?Q?xVzdazlxgFwgQ0x6BsCxfhNaZjDD9TamxnUo14bpdhusS4/pjiJeOxeKT2ow?=
 =?us-ascii?Q?uEs54+ppZPIGWRfItYUHNdO5Ca+A4EAokZ5suQwZKa3ARjrkuiOJUR42DS4U?=
 =?us-ascii?Q?WQEXgQ1O4Sp09X57wlkzSKga/YOdHtxeySxhXBUOP5HrW5X7TJqem/81n2Ev?=
 =?us-ascii?Q?pXpXbEfAnNkb5YY62Os+uYO9IsWC4l+w+t7JvQQem8S9+SNn31C5oT7k51CH?=
 =?us-ascii?Q?O6vAzA2uNG85miAxRwXdcGjtmz/m2XHNH8qnnEQp/CUYT3toOt1nrVi69Hhr?=
 =?us-ascii?Q?iYLJW5Pv7fQWzwb30MCF7GvP+nefQref4vDLD3/msrcK8r4oCH9cd+zQB51D?=
 =?us-ascii?Q?dsQPejAMtsQj0ZZnRFbtHj5cFtb+pAHYQLlzSvpb88gtEGTTnQBrnaRX+oW1?=
 =?us-ascii?Q?bFkJBLHjxzjxroVj0oqBvccMcESWUhGypaDlw7SCIVHbB+ePiQ0IIim/vmdS?=
 =?us-ascii?Q?dJy1vuVVIssfwFBHzMH2eOVGH9svv1jWxGM+frDHHqA2EaMEsZRM8jk+DMt3?=
 =?us-ascii?Q?hIVY/GOk18Z2bE8R2HWBjx9qVP5odM/TEx2u/wMbD99YinLmxj8u9OxfEXcI?=
 =?us-ascii?Q?LAfQkhWC6fn16/e47S/gi1iO2Yku3hOIxyDrGwni6OniYZM3+rz54cWPjfAL?=
 =?us-ascii?Q?5vlwHFTkgst/wedp1GU+ICpoPli9W0i93YFaBEYQPw9H6gf60gQaQJgNOZ23?=
 =?us-ascii?Q?DFIJmAcnSURR2miORqEtG8BX6UXfllTJlivXiaklPdWzskQl9qaa7vfytY9v?=
 =?us-ascii?Q?YueWAD4cgRy21BQeHwNL+HtvhHPC9bV/dRF6BBYV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b9a5c2-43eb-4d57-f7a9-08dc338c3f9a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 09:54:23.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJ4l8SQjaOZqH5k5P+wlnrEbdtg3tClwEzYwYIBV6WuyqMViMEAfqDzQFXI9u5hUEIDcTU12zNYkJ+rhRzoWng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4891
X-OriginatorOrg: intel.com

On Tue, Dec 12, 2023 at 12:46:20PM -0800, Sagi Shahar wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> +/**
> + * Adds a vCPU to a TD (Trusted Domain) with minimum defaults. It will not set
> + * up any general purpose registers as they will be initialized by the TDX. In
> + * TDX, vCPUs RIP is set to 0xFFFFFFF0. See Intel TDX EAS Section "Initial State
> + * of Guest GPRs" for more information on vCPUs initial register values when
> + * entering the TD first time.
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vcpuid - The id of the VCPU to add to the VM.
> + */
> +struct kvm_vcpu *td_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id, void *guest_code)
> +{
> +	struct kvm_vcpu *vcpu;
> +
> +	/*
> +	 * TD setup will not use the value of rip set in vm_vcpu_add anyway, so
> +	 * NULL can be used for guest_code.
> +	 */
> +	vcpu = vm_vcpu_add(vm, vcpu_id, NULL);
Rather than to call vm_vcpu_add(), is is better to call __vm_vcpu_add(),
__vm_vaddr_alloc() for vcpu->initial_stack_addr and vcpu_mp_state_set() only?

> +	tdx_td_vcpu_init(vcpu);
> +
> +	load_td_boot_parameters(addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA),
> +				vcpu, guest_code);
> +
> +	return vcpu;
> +}
> +
...

> +static void td_setup_boot_code(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type)
> +{
> +	vm_vaddr_t addr;
> +	size_t boot_code_allocation = round_up(TD_BOOT_CODE_SIZE, PAGE_SIZE);
> +	vm_paddr_t boot_code_base_gpa = FOUR_GIGABYTES_GPA - boot_code_allocation;
> +	size_t npages = DIV_ROUND_UP(boot_code_allocation, PAGE_SIZE);
> +
> +	vm_userspace_mem_region_add(vm, src_type, boot_code_base_gpa, 1, npages,
> +				    KVM_MEM_PRIVATE);
> +	addr = vm_vaddr_alloc_1to1(vm, boot_code_allocation, boot_code_base_gpa, 1);
> +	TEST_ASSERT_EQ(addr, boot_code_base_gpa);
> +
> +	load_td_boot_code(vm);
> +}
> +
> +static size_t td_boot_parameters_size(void)
> +{
> +	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
> +	size_t total_per_vcpu_parameters_size =
> +		max_vcpus * sizeof(struct td_per_vcpu_parameters);
> +
> +	return sizeof(struct td_boot_parameters) + total_per_vcpu_parameters_size;
> +}
> +
> +static void td_setup_boot_parameters(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type)
> +{
> +	vm_vaddr_t addr;
> +	size_t boot_params_size = td_boot_parameters_size();
> +	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
> +	size_t total_size = npages * PAGE_SIZE;
> +
> +	vm_userspace_mem_region_add(vm, src_type, TD_BOOT_PARAMETERS_GPA, 2,
> +				    npages, KVM_MEM_PRIVATE);
> +	addr = vm_vaddr_alloc_1to1(vm, total_size, TD_BOOT_PARAMETERS_GPA, 2);
> +	TEST_ASSERT_EQ(addr, TD_BOOT_PARAMETERS_GPA);
> +}
> +
> +void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
> +		   uint64_t attributes)
> +{
> +	uint64_t nr_pages_required;
> +
> +	tdx_enable_capabilities(vm);
> +
> +	tdx_configure_memory_encryption(vm);
> +
> +	tdx_td_init(vm, attributes);
> +
> +	nr_pages_required = vm_nr_pages_required(VM_MODE_DEFAULT, 1, 0);
> +
> +	/*
> +	 * Add memory (add 0th memslot) for TD. This will be used to setup the
> +	 * CPU (provide stack space for the CPU) and to load the elf file.
> +	 */
> +	vm_userspace_mem_region_add(vm, src_type, 0, 0, nr_pages_required,
> +				    KVM_MEM_PRIVATE);
> +
> +	kvm_vm_elf_load(vm, program_invocation_name);
> +
> +	vm_init_descriptor_tables(vm);
> +
> +	td_setup_boot_code(vm, src_type);
> +	td_setup_boot_parameters(vm, src_type);
> +}
Could we define slot ID macros for slot 0, 1, 2?
e.g. BOOT_SLOT_ID_0, BOOT_SLOT_ID_1,BOOT_SLOT_ID_2.

