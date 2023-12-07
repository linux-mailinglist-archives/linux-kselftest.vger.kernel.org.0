Return-Path: <linux-kselftest+bounces-1340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59013808360
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 09:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC89283D77
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78879199CA;
	Thu,  7 Dec 2023 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luEkdGRC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B5C126;
	Thu,  7 Dec 2023 00:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701938565; x=1733474565;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0OmbIqT+PTEKJSPGxj4pijNqjiR20rOKm1WvhAtu2XE=;
  b=luEkdGRCSAq7cQFqDobtGM+Lg/p3wF1QCRGu1Co8Gu1PJW+NmZfdXbKr
   PeK6XqIoWSfJXiePARxZmQ9U0Sgp946z1ZQ0AUMzP8L9n/04qwndgJNfp
   9wydHTkQJcdMMjbq9GmT8yD2RUFlkRhcIHn+CA3oWdaVG/4yjBSvhV0Kj
   kDcXS1CbxyA4Ke6s6aZcfCZ/TCB3jNPPPOqial1XUFHpYe6uHmXBDtjGA
   OImr+U4fgeXw77Kr9aCTCc2Gsz0duYt0Du5RewCqizeUUaT6kwpvtwTJ6
   gQ6pq7ymzQeCUwMXsowyE44iTx/OJeAatz36jKY1vnGoEySQu454eTk8o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1027483"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1027483"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 00:42:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944958259"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="944958259"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 00:42:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 00:42:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 00:42:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 00:42:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 00:42:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GezHs8DcsytXyn17Zg7AQ6bwNVcAe/nuKUevRvvKwl4u2P0vGFBGC1sVjCmzP+n56jMvQpfAUybBPtlFwA6WPL4AqdFz7m2Ez7bi/xeJXSBO5gD43V1DPy5Obzev0NPUqZ1W8GMhkNqxDHU4odSUheh15ck9D8c7aYNDRpnCrx7R9+Zc9J8qVioMSpRP3NkEGf9KNFhpepeB6QA3bOPtPuJgIrW6Eh1EmmXUkGushzL32iFQWipCekuEVvRWph3M85vuHV+733mwaecob9ZCJcEl/Vo0cMgPl+CmImfJ9OtII0Jhggrb4Wi1s0ZeGgYPjbr34fJ4VJnrMPIOoDvnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCkB12D745cAhgyQzurpj4p18eyDoUPZpajMmpLfUH0=;
 b=BnaespaOHvdQNl7G0GpOQZWD++w+uKgulL315KuIRIdWi9NqZE3C4uejtNYA07WRrz+Qw1ihpiB4pvfbhdowx+cVg7BBLLPoqnxeAo4bEP9B3MJpDos9LioIOMWjOxkAxnkvd26ySU4+xSSikiliwOiDiYQUmWb/yeNXOzPhh1wP+kyjQjy2ziR+optxANNDUPB7tHUQV6GL6c1b0xz5KaeeGUngZmaxG6gouGoLFGt5ro49h+HbaPGFWCk0qNXK5K5GWzlNf24MmK4LuwjlIwhP3Ig9C+44BF0ymeIDKsjpnRdouMS/RhQYbCumCl6FYUzmT9kiHvhUuBCwnb32Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA1PR11MB7854.namprd11.prod.outlook.com (2603:10b6:208:3f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 08:42:40 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 08:42:40 +0000
Date: Thu, 7 Dec 2023 16:42:26 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Li, Xin3" <xin3.li@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "Cui, Dexuan" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
Message-ID: <ZXGFcuwwmkBlqq5s@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-14-xin3.li@intel.com>
 <ZVMkVmBPVfaMjDTL@chao-email>
 <SA1PR11MB67348D3637C2BC6B107C5CCAA8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <SA1PR11MB6734EFF17E15C68AAD12A227A884A@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6734EFF17E15C68AAD12A227A884A@SA1PR11MB6734.namprd11.prod.outlook.com>
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA1PR11MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f54bcb-62fe-4813-8a0b-08dbf700781e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvkF2kIBNiPeItxUvtUu1IlzUjv2+2/Q+YAO0k/8zQpWCuXuIycN45f4GSLuYZ+bZECz75o1B70LhYAlqRBL8IhJwbpvWiQpDct44/MK2/dlAED8umxIcTso2Zv21IsKlAkOQqpD0yFGLBDg6ZrrO8WqihtYWftXX+EwsgI1MXLWJvStNUscUb/sGcLqBUBnjNzJh0YAvP13mJRO1PYzo011A6rZFb5W/9WQMEO4qrg8vZU2gOon90+oElZ+9+aWjgW/wievjs3Ialv4TWmndIVmpS5ylVo+EaKGt+hxE/OtPTaLqRO7ctsztSuYKtipjkMVXsf+a3TwP4uJlxvTG3x7F+rm/vk5PY4BCWAb+qRG4RbGGl3LtKb7ygqgQyPXu02h9169OY+Oue71tMyc91heDwvYLoZJ2rpuY0PUmNHVI9J/2wGFH7oAATuESzzuHJDeUmW1fsTT+6ltN6+Q/3qX26ZmxSIw0mDhVWnpRkiRvyFZ2u/LulJY9j/7WVJQoHPqpJ8AodMWHs2PtsKdOSPzPhU3FjMbZWEW960nu9UGiXLva2g4xQYWohBEAVJY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6862004)(4326008)(2906002)(8676002)(8936002)(44832011)(86362001)(7416002)(5660300002)(33716001)(41300700001)(83380400001)(82960400001)(6512007)(9686003)(6506007)(6666004)(26005)(38100700002)(66556008)(66476007)(54906003)(6636002)(316002)(66946007)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m+FzD0dX7jSCYMLPwVL6kA4XWP4UPhv0hEo7W9x086U4FRWX5aMHxxEjKKlD?=
 =?us-ascii?Q?P93nHodfmsCpaEQvpwjnwPKWP+JT0LxmS3QbXXWeI5XJcBOosmtlttavr6AQ?=
 =?us-ascii?Q?u+TMkSWHoTK7lLivru4ekQHU0cQFhOupCXaDFKdJ2j/62G/qDYjpBDD3J85m?=
 =?us-ascii?Q?kRa/m2itUhe1KRkwjaJBTJcU8WA+XaFrn6dzcR+OfO7qjNFEyADReHMHsaR+?=
 =?us-ascii?Q?nfGkBMPMusul4BSVb57H4xeaol4unYVLV46waFYV4bSojUHaWgUI7m98by05?=
 =?us-ascii?Q?C3rZulEE8DU8Z90RjGOyRahGg7oaAXkBGkXvrLTqdU8edryg7RT0UgViygyl?=
 =?us-ascii?Q?JngZF+bLZrtB0EXhlKIpJah1+or4Ipb/V/nT3Fr3b9xnC5krgxw+D7X43y3Q?=
 =?us-ascii?Q?+gTnDaKJ6Fnpk7E8KvIvq03c4gdpHbu7JXyySrKDbIfzwcVCDb/rcUrGU/Xb?=
 =?us-ascii?Q?67Hd9sH1WhIKb58/tW8ldmlg+NOdsCnXwYxGiCWfggWP5MToOJzNTlnLUOA1?=
 =?us-ascii?Q?ntiNsQNR9AYHMOD8QG+iyRVi9/xGqEZ8aEkOYlovu1G2HNx6hwwhAuvvgjlg?=
 =?us-ascii?Q?7XGFrilSC7XsdzAD8boM87r+pk7l4AY5COS41gxet7oc+11uOQtIFWpf/dFM?=
 =?us-ascii?Q?7BpNZ0jwUU1uWbAiP+ZnAUfo9OPTQ47FbsS7gA/c6ITUJSfhnFHFIN3gLCw4?=
 =?us-ascii?Q?SrUxmYr5s62js7ckb5sFdy1J20pyhC27MBNaR1BdMnp4ARvmxC/cZAILonDF?=
 =?us-ascii?Q?0R5GS75fVYoFXV0L1Y2dCHjcJObBg7ZhUVoV8XTPf6TvGF/2rPFL0NCjeNAg?=
 =?us-ascii?Q?oAO/OjWUhB1TeFgSPB8boTWmcNBa3rc7Isv2YFdMzPdzLctjbu6lMCK0wJKT?=
 =?us-ascii?Q?AWPDfTTYpJ0HGOfyXTOA96tct1q3sXNeA8nkVxdpO6vitpGXp/hZGSkLWzgr?=
 =?us-ascii?Q?NwDKEwdVVOvuo6s5wSplh5BQKYzVp7WMY3TUxtrnvkgsa2ZfjWv0WomxzCaR?=
 =?us-ascii?Q?yTh5H5K9Nh76O1Gvs/eYd4n7SGWMO+CWqLiDaUkt5A+01bGhKEsu7QpUmDzI?=
 =?us-ascii?Q?DPYSkFI4uqZ01L6E87Y6qYq+GKf9G/kTaOlss2h0Uy8AL6qwNCCE3UVl8Eby?=
 =?us-ascii?Q?P+LOMGJvD93PialelM5gHmoRravxcoX8hEmpGsLHqUKB9OPfDOZNDuN4bVBq?=
 =?us-ascii?Q?tjTVUPLghHbXheFGUwROJkVBcUKLzemTG85o/6R2+m4HG562d90WqJDhMkye?=
 =?us-ascii?Q?BsSkmxwLftOT2l0TOzFzER78B0yf42Xz9xwGwEpc4AMkT9J8bCZTAq6aEYl2?=
 =?us-ascii?Q?3L2Hgn7hS+v17X4DIIfU01k8ZBTZLsWQbgCxrYbTquea7m7iK8yN83h12/SZ?=
 =?us-ascii?Q?ZLeKRaofYcv3cqsTsbxliMBJrJT3t1kYp+DBlLBDlp8MqjT9N7+iGhmV1BtE?=
 =?us-ascii?Q?Z1FYWbpeCdxnA5NjehWTkpMwGKc/xxcBtuPK/HINdJ6/AFeeu98Fnh0toXnU?=
 =?us-ascii?Q?KLtolLwgIYSmLHRuJCMUQ1h7xqsm6Udn1XkFUkkNZt6pby3wHbTu4+QZLB+x?=
 =?us-ascii?Q?Nv7Lq3mmF7ESph7Fl3EdAJbH+y/23qhLA1A/JbgJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f54bcb-62fe-4813-8a0b-08dbf700781e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 08:42:39.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTYNz6Ug9m7T6FUcx7NEyQYtQ/dBSLDDfKDLSsljypZDTamECOcuHhoAPoE5p7aYJhURwNCAqsUVzaL0hp+xeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7854
X-OriginatorOrg: intel.com

On Wed, Dec 06, 2023 at 04:37:39PM +0800, Li, Xin3 wrote:
>> Subject: RE: [PATCH v1 13/23] KVM: VMX: Handle VMX nested exception for FRED
>> 
>> > >+		if (idt_vectoring_info &
>> VECTORING_INFO_DELIVER_CODE_MASK)
>> > >+			kvm_requeue_exception_e(vcpu, vector,
>> > vmcs_read32(error_code_field),
>> > >+						idt_vectoring_info &
>> > INTR_INFO_NESTED_EXCEPTION_MASK);
>> > >+		else
>> > >+			kvm_requeue_exception(vcpu, vector,
>> > >+					      idt_vectoring_info &
>> > INTR_INFO_NESTED_EXCEPTION_MASK);
>> >
>> > Exiting-event identification can also have bit 13 set, indicating a
>> > nested exception encountered and caused VM-exit. when reinjecting the
>> > exception to guests, kvm needs to set the "nested" bit, right? I
>> > suspect some changes to e.g., handle_exception_nmi() are needed.
>> 
>> The current patch relies on kvm_multiple_exception() to do that.  But TBH, I'm
>> not sure it can recognize all nested cases.  I probably should revisit it.
>
>So the conclusion is that kvm_multiple_exception() is smart enough, and
>a VMM doesn't have to check bit 13 of the Exiting-event identification.
>
>In FRED spec 5.0, section 9.2 - New VMX Feature: VMX Nested-Exception
>Support, there is a statement at the end of Exiting-event identification:
>
>(The value of this bit is always identical to that of the valid bit of
>the original-event identification field.)
>
>It means that even w/o VMX Nested-Exception support, a VMM already knows
>if an exception is a nested exception encountered during delivery of
>another event in an exception caused VM exit (exit reason 0).  This is
>done in KVM through reading IDT_VECTORING_INFO_FIELD and calling
>vmx_complete_interrupts() immediately after VM exits.
>
>vmx_complete_interrupts() simply queues the original exception if there is
>one, and later the nested exception causing the VM exit could be cancelled
>if it is a shadow page fault.  However if the shadow page fault is caused
>by a guest page fault, KVM injects it as a nested exception to have guest
>fix its page table.
>
>I will add comments about this background in the next iteration.

is it possible that the CPU encounters an exception and causes VM-exit during
injecting an __interrupt__? in this case, no __exception__ will be (re-)queued
by vmx_complete_interrupts().

