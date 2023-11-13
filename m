Return-Path: <linux-kselftest+bounces-45-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91AA7E9677
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 06:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A006B20A49
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 05:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8C21172F;
	Mon, 13 Nov 2023 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XX0wxN/B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F511700;
	Mon, 13 Nov 2023 05:24:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6874A10E3;
	Sun, 12 Nov 2023 21:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699853095; x=1731389095;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e+3r3XzHLCVioUxHm2d75WGjfaSeqq0iaj4mhaNC2Ps=;
  b=XX0wxN/BUOW9zdz43s0pKIisRH5NWjrv2EaUuw50bW7KCqiHHT3/haIv
   fdh4hI3WgHnAlgRD+KnC5vc0G+I3QKygPTMPIoUNZ1dMLOfvGh7di+xlI
   Ccwk2/NU7jwNjI5hf0n0MyKe0w95NPFeUaxrkcMh0vudIom8BEGCb6EFg
   AnOSM5Q5jBcCUjZxO8h0TLjhajw9MneS0GmvMkOEWUtOrHBaTkNh3qgnU
   R8D+dFzywB7Dz4efN6qKGvfAZZFaQG8IFGZuCKXhgCWIk2kasLAaWfGfy
   pzOrb2bctfLRspFH8fxqo/mpOn0sH5q2Swx98bj7asq/IL+5Z5wKZ5wP6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="393244818"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="393244818"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 21:24:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="740667500"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="740667500"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2023 21:24:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 21:24:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 21:24:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 21:24:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnyuGtP3Z/MklL6xZeGszvcaDvCFoOEGw8W25t+XjX5IJemnL/TfqACSl16QNFW+xYzToeMlrKGNG+TUb6paAFiTXti7iytgvwucwGEdnusZKb3FhQmnvsfQZt9cz6aeAnicif/0PIP7rfJcvuW1lJA3fnh0tMgKSefSFi5dgeh+oRmzB5g6JU6usSD0NUs+qE1yYK85ZdfjRonlr93k0LdP/Zh5KuvVSZsiZaJVxX3FYomsKVL3IsCXE50cWS0farae8BtphSwZAjcIGVIY4YeXmJKO/8E7zpUYja/HB8+JtARuibVA0lhuyNgKlMxmicHZIc8Fzzxd8NlmEsOfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKAQ2HvazaSfbtl7n2rNE+0NfxpSB7LIcOWHD/j/P6Q=;
 b=Q6kp1NBWathXpGP9wG4lXCjDSbKVDUExq6h0LhWoITYmjy9nEZlspWPMV4q4VSmoLf/e/MFOMbBPodRjjCqbThLoy0Na+mntvYPa2lCj+v9/pTdfe59hYZ2U/t9lDrhJIXIPQwVkooC3rwUPFHv0ASWSbVOEadNtxLn1+MoAWA6V2tl/TQRcu11nt+ow3tlUfb6nFAc/v2i9CK+wvl84QP+Fo3G8zrtrRRn4n3MIJWp7s4HS0TzOiKdqODiLFmCxk7sfdGDArIXoNRSdaUW+Z4DBJlB/XLi7+UlPqS2HEI0X6BlAtOx2k6LyrY2uGoEGrN58pdOv94gOxsgZcfbrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CY8PR11MB7314.namprd11.prod.outlook.com (2603:10b6:930:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 05:24:43 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 05:24:42 +0000
Date: Mon, 13 Nov 2023 13:24:27 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <corbet@lwn.net>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<vkuznets@redhat.com>, <peterz@infradead.org>, <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v1 10/23] KVM: VMX: Add support for FRED context
 save/restore
Message-ID: <ZVGzC66k0QtJywi0@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-11-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231108183003.5981-11-xin3.li@intel.com>
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CY8PR11MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 15de634f-6756-4b0c-0a37-08dbe408d61f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/Eg+z6Z1X001gNLHBVQ1+axd3btRk4DuXgKL2fVy6vapDMLBjxmGMqeEJCpJBmCPnfloCQx/zHJkci4vskCtvfzhbn69SaAo1jTYA59OQMOiA2uqINl5F9CPPtRK1Ia611DnW6lYoay2BRM67BHEjXptb18UtmQKVAh1Ysdr8tmbwqrgzdsjaq9H11vOTeicxrhJKfV9twOMsSS+XagJwIXJiszPGURY3OAieY47OCcveCIhhCR7K411UldhGZNOX3939Z/E1hegM9hGOP+BpkieUaY7ZUtl6DmwuWVWAFL9buVx5BbZ8tAa0UoSnWtWF8nJMKo8ZCGr0mGqFyRu6riBe1RvgyZOYaC9/LtG9Oz9eCmFKe3Dp/dfZ5imQSMjM9G3iaZK7nM0MvCUExIrLIIfQZNO5A7/iS6NoLSUZmytypfRG+Um2D0aR+WoXFyVk+o80bYW5HC+m8Q+wmaNmaah9PXoEXB+Bn/USHtXRV99hR5fwQubNKT4tnsSQp2T5thIC/VNuQt/sOj6ZKIR3yoMzdExb89EhSHuoeFkNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(6666004)(2906002)(966005)(6486002)(38100700002)(86362001)(82960400001)(478600001)(316002)(41300700001)(6636002)(66946007)(66476007)(66556008)(33716001)(8676002)(6862004)(4326008)(8936002)(44832011)(5660300002)(7416002)(6506007)(9686003)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2HahKhqykNGgojvWpMVRCY6YPgQzE8+lKYwoPmIRgMiGtrzVw/QiQkr+GFlE?=
 =?us-ascii?Q?Pd7AEP4mGLw4pdLgQV+sZoKMpXEXIfr+1qLhhkRAyk2XMxv8bZfJAcUbYFMv?=
 =?us-ascii?Q?Lz6JIaE7G/8as3a7Mnhwr69PrlgmbB/2B1ndmE8SvL4qzdWJiOpHIAzISi0F?=
 =?us-ascii?Q?qlIyijqNBKusv5xSZovVC/rjxYVLPEJGzdLNLUwKuBlNp8IXVHaTqK8umX2p?=
 =?us-ascii?Q?lLgxlmvRBDWhUDqNWkewtG5kecAfauAVQFXu+fl/3WZCWSchn54oqoIxT+kf?=
 =?us-ascii?Q?y3pS8VqjKdUP3adeI7oCcQ5T5c83eg+wq5gA1oNC+Sr2UiOz6XaaBJwc4G3i?=
 =?us-ascii?Q?16wf4wTJc3HSRUg5EWmiufEMOEB/RdSvwwR5LUltfIQCENC+09dp1yqOtTEu?=
 =?us-ascii?Q?SABzNbKtf30h0nsqZ/AfUAfNs3mBlT8dAevTWPFMys7Bx+AZHXFfnqQjADK/?=
 =?us-ascii?Q?/xml6MIORbHsodef1X7yeXUZt4XIRpODyfigRXnkaerGrSsgMpjDYRmKaYF6?=
 =?us-ascii?Q?0vzRajeedm8pVsDJvoYcr4m3X34M95gcEkX0jvb5zY46+irVemubsm5r0LzS?=
 =?us-ascii?Q?8UyThyvCVKnK86tW80oeaoDDlou7wnXY2+biytSpZh63SeJlbV3Kv4OuRNkl?=
 =?us-ascii?Q?EEbJD1kOrXbFzKXwWf2GCqw2/avelcwgmuYEcCDRVJrreMYBGrhaOj6HQ1G7?=
 =?us-ascii?Q?o7gHSf2DbCdZZ3nt7PmnzGxHdGWukCaYuf/jVaRBuyPZe8g8EQEa4hJakGbP?=
 =?us-ascii?Q?jaj5+QEKIjGNexcFX/MPc6lCQLmwpDg66I2QQxrzH3z0yJbl1AAYEnVHqaLF?=
 =?us-ascii?Q?MGYahPoYV9hFJr9AExj1Rf77F46bZdz3XZTCt0GyXXWobutu8PeEHO+mqUzV?=
 =?us-ascii?Q?38HPR6Gu08VTm+wDeOiFV3OkJjW3eMLC6+NIeHonERcyhaDeB0VU1l0PBoK0?=
 =?us-ascii?Q?zPF3XxbCjiu6B2808F49kM4KyupJQWAwBJqeNYOmcOAxGsuFlnINzy3KL2jl?=
 =?us-ascii?Q?AnFN9Zdvz4aRP42+L8hbgPmG4P5kmxB+HJ3rlLcf5cmBVEkp94TSgH8/qUSg?=
 =?us-ascii?Q?4KOQqbQloLi+JXZRUNpj8qNg8mCVnjeV8ag63rVK8h7xeTQlzX82aAaV1egx?=
 =?us-ascii?Q?12qk29sNop6wNMiBsQrjD1B7WjATpOso2kaO/QMEn0ttSkd+TPOPe1LukVNL?=
 =?us-ascii?Q?z8T8her1pUHGPZONHzAfVofXmyvA7sf0b5VeGytR15t6qkvCwYUXgTnX+T3e?=
 =?us-ascii?Q?E/GBTiG/9szzpQd/OMCSpIrLuQ+5yYhDSkbCRt/jF74PzgzR6TO346HTtt3k?=
 =?us-ascii?Q?iatjmF2LcEu+OPWJAUp6m49RW3AV4FkYbmf1pepsgb1FI69EDPJ9RoQiimLE?=
 =?us-ascii?Q?ASlhRq4nehdg6V5QnSemqMDSnpbZe7IkRU5lcP7sPr0q2SQCQFLCdDe08a4V?=
 =?us-ascii?Q?wyfjFpqOgn6RS9TOJ9hEFGQiPIZ+R01yWnR4KVNXVdhbDTbwut+jOdSZCOHB?=
 =?us-ascii?Q?nW+pSlYcwOvLhDqwl8zqab62sSjEQyWnmBHHs+Nkp+HILgq5+B3X0gEaxkia?=
 =?us-ascii?Q?pFn/aG4NeDawzMMk640aQu9ZRGulafwctV3QA8Kt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15de634f-6756-4b0c-0a37-08dbe408d61f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 05:24:41.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCFAPpVn+h4o7XioW/wRP+9HzzvW7huGhlMoeYIRB1x4J5b6bwIXQm9gnF8GrrlG5X1eUhgj7Dl8eg8h6YjjqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7314
X-OriginatorOrg: intel.com

>diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>index 2c924075f6f1..c5a55810647f 100644
>--- a/arch/x86/kvm/x86.c
>+++ b/arch/x86/kvm/x86.c
>@@ -1451,6 +1451,9 @@ static const u32 msrs_to_save_base[] = {
> 	MSR_STAR,
> #ifdef CONFIG_X86_64
> 	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
>+	MSR_IA32_FRED_RSP0, MSR_IA32_FRED_RSP1, MSR_IA32_FRED_RSP2,
>+	MSR_IA32_FRED_RSP3, MSR_IA32_FRED_STKLVLS, MSR_IA32_FRED_SSP1,
>+	MSR_IA32_FRED_SSP2, MSR_IA32_FRED_SSP3, MSR_IA32_FRED_CONFIG,

Need to handle the case where FRED MSRs are valid but KVM cannot virtualize
FRED, see kvm_probe_msr_to_save().

> #endif
> 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
> 	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
>@@ -1890,6 +1893,16 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
> 
> 		data = (u32)data;
> 		break;
>+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
>+		if (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_FRED))
>+			break;

Nothing guarantees FRED MSRs/VMCS fields exist on the hardware here. Probably use
guest_cpu_cap_has()*.

*: https://lore.kernel.org/kvm/20231110235528.1561679-1-seanjc@google.com

>+
>+		/*
>+		 * Inject #GP upon FRED MSRs accesses from a non-FRED guest to
>+		 * make sure no malicious guest can write to FRED MSRs thus to
>+		 * corrupt host FRED MSRs.
>+		 */

I think injecting #GP here is simply because KVM should emulate hardware
behavior. To me, preventing guest from corrupting FRED MSRs is at most a
byproduct. I prefer to drop the comment.

>+		return 1;
> 	}
> 
> 	msr.data = data;
>@@ -1933,6 +1946,16 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
> 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDPID))
> 			return 1;
> 		break;
>+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
>+		if (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_FRED))
>+			break;
>+
>+		/*
>+		 * Inject #GP upon FRED MSRs accesses from a non-FRED guest to
>+		 * make sure no malicious guest can write to FRED MSRs thus to
>+		 * corrupt host FRED MSRs.
>+		 */
>+		return 1;
> 	}
> 
> 	msr.index = index;
>-- 
>2.42.0
>
>

