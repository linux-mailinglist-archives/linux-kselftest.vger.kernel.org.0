Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDA67E666D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 10:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjKIJQE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 04:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjKIJQD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 04:16:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA64225BB;
        Thu,  9 Nov 2023 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699521361; x=1731057361;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=52mkSp8/KsbAWxxR8V5BCMtyZjMQqvmRusCjuWuNF54=;
  b=neNNRJtfmrrFp1LZLY5aWvDPZPq47m5Vg6O/UCBpels+oAgOOdf0MfbT
   D/C15/yMdk8QU6/X7eyXo6B9O00DZkJwlJDdGJR+62tYoyfuQweuvoKpf
   lVREMs6I0NaWfvv81wvOxEf5zCNHvYRTPgcLrqlwsfA0tUT9MnmacRyzF
   sfaCxuFI792q8YBswj3b7/NYavTvDSvQdvZYKGybBC4liU6svv2Y46ypl
   n93umNwF7NhzlANhI6gGqXsK7YJbohfkKC4jVilJ6dvN4+gQvxSwN/b2x
   s3lvVfWantU/iE6T9lXOI0ZmJNew5mzUMkSW84EWzai/9S0MmkVTTS+zM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="456442326"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="456442326"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 01:16:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="792478465"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="792478465"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 01:15:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 01:15:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 01:15:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 01:15:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 01:15:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0gIBvfsg5FOv8zGBfX1XiysGqMDQ7XpaYwxOgA26PaEXx5qREiPqXj3P5c8yOoEWHVOcY4QyWoGQBAC2oE/5ipSd/7+B/oHxwXS/0muZbIc5zJ6bx8PK0l6EN8To1JsP4LSo3XbCPqH8wvl6TUZc1RetEx1nUPyjybbGelD1//USaCLfKoSxk5AhKFZhVCG0cjXM9FBe2vjxW2/AqJb68Fw2bpPzHK/aYnnn4i/yDslfrdwZcsCY7lCuO7D/v2z6LJgG5xV7xrft3P7CbPpnGHkyEvlMpoKVLAr6Es7LW/kZJOQ0myjx62UAyS20tOu2FJW8aRysDjzD8Pu3lSLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svItkbB1Lyn1TePmofbb5o1tCnrUxnLykHRNJpJWtrw=;
 b=GWFtoV5N8pM1UF3fxAwLAg1Yo4sLf0QFoMMFiqNB+/VgCu7QpLvbqVvIeTGZIyfW1P0FDSPoa5lXx4kcaxhdrozWdcv7n9L1ubmguzj5rM/Zl1nNhQwkV4BUFqdiMoU5lR/uhTMDyVCDiArius6o994CG0L453/22rBsht7LrKE6h7j9DGT27jnNieGSEc2VXPDx8KlmCGakNYMOz5xEYOyJqjH61iMRI3Qrp113vUABOL9Aung3G+qEoD5jQ5W5+qf+rJ4f3Cv4yPHw2nmKL9hRiRbxFTh9mMcFnwlY0SEsqYkHGWnTSO/hhvcx2njFkcxPbaL+pLFTZUHZT9qfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 09:15:55 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 09:15:55 +0000
Date:   Thu, 9 Nov 2023 17:15:42 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Xin Li <xin3.li@intel.com>
CC:     <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <corbet@lwn.net>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <vkuznets@redhat.com>, <peterz@infradead.org>,
        <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v1 06/23] KVM: VMX: Defer enabling FRED MSRs save/load
 until after set CPUID
Message-ID: <ZUyjPtaxOgDQQUwA@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-7-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231108183003.5981-7-xin3.li@intel.com>
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA1PR11MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: ef44fc04-3e8b-4d31-399e-08dbe10479c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtOUZcN1/M55GxfXeb9odsGOG0jZ6mo9qBqYGhtx/j3psa7CniWOlCKI5E1VINmB6LztojFZtzf4hT6PPNeN+vAfZZfLivpMCzdg4HGHMVCtRYOqdGLMHNPRqQNlKs/nd8EgHED/BK2yT0l6CmushX0949RfsIv437VvE6YgITDQKV+GFj8KxbHIQVNBSx7L9ctEV04jrjimGWI+HqeCaZ0pcJo1UIYv3y532GhIGUmvW7d1JnkpwC0UVOK3Kqt/6FWpCezbLoLB2BRRzf1CKfTVptQS27R2dI/UH36ZEO1wkA8EXoMXtv4C9vRfhy0USkVrdwmCGIPaQh6+Shru88Uzu/a9lz4s59Pp9Vi+4Atjs4Dx04kUFf/nf4DF1bBa447SrOQJB9u+3v2JzcNX0rUT+fis9iEsrjTdCMObwSeKZJoeLOZR9bYFf3jUOG7GIvZV67vaMwteXwZfGpdhkLsVTkAY/dBnwzA1alXXUsl+d5bRnTVAvyagae0yCpRupn8OKoremsVGx9t32gluJQwoXXbRLbvPZo6vCgiGh/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(5660300002)(8936002)(44832011)(6512007)(9686003)(316002)(82960400001)(966005)(6486002)(478600001)(26005)(66556008)(66476007)(6506007)(66946007)(6636002)(6666004)(33716001)(6862004)(8676002)(4326008)(2906002)(38100700002)(83380400001)(7416002)(41300700001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vmLCo2G29P2gY50/Q4K6OTsCFt4VY2Gu0LOsYT7utUnKXtBOxNp+BEsW536S?=
 =?us-ascii?Q?1gdIVb0s1Kmdh4M4GWMsfA0FyBUrJ6A8VvhLEzh/lNU+wEUy5e8Da0hFOqZl?=
 =?us-ascii?Q?bllgtdNtQCwD7CIvpCWamzFy7J02POULuIEVu+YRvuZReUtE0PXA3AgmwX0T?=
 =?us-ascii?Q?ObtHTKc4i2ySF33rJdwDYUd1TFolihd1Qa4YSH0cqU4N0o1STA3nphkHKV3p?=
 =?us-ascii?Q?btWFwDlcmkh8mBAJdM0b5U0P71XhXw3v8NiwJN895hmITtqfCGWZzb8OOwBv?=
 =?us-ascii?Q?tOxBQyC5cUqPTg2ayLqdsilFNd9NbIaV0zyoH1kVc0t4IsfDysq55FzalHYr?=
 =?us-ascii?Q?VoxZfC4AAD4sw8mVOhcnIrOMm8nT1L6ZWeszgv/vyr5LJAFaYkSETnmu/h3+?=
 =?us-ascii?Q?V9hIcRt/BKQqeRfl+ErKPSWedes3Qe5WvvtfMZ7Su39rrFWuvTnPvIUYAC+6?=
 =?us-ascii?Q?TmsNbfJUT+SOEP+rqthrlOcL7NOv+WV/XGyC8J09GXpbiv/DtoPHgrQDWL4j?=
 =?us-ascii?Q?bEmx4kJfzVrg6dOGgXtRK+XpLH0Y1geZ2ukWgEsBDZAyCgItvryvuIYshRLo?=
 =?us-ascii?Q?pN8SXhtXheJdmoHJaXLskJJc7HBx8Qcvyl5+BIGsJ4XpCc90QOZYhxzjOOv4?=
 =?us-ascii?Q?oGfBqewdwr3tXxGVq1P1NWjiD5y57u2Zqew3YuuHDpkgOydifWttxniWrMJw?=
 =?us-ascii?Q?H9WrZ0WjaF9frvbsnVPoOLkOBAoAaVO42uNqm2/6UWaONKHSaywo+ts3okfa?=
 =?us-ascii?Q?4XM51bemHCiupNXRcSC6ylCToq9P3fP5ombeYl6cCOZgxyAlmllrRuUBxxm/?=
 =?us-ascii?Q?j4KRy9cPmXD/ZR/p/QujFeZ+1/Qo2EQPB07rGf5I4bOmLtSquskPpEua5XYM?=
 =?us-ascii?Q?aeoqcpF8DpJNkX0RNWPQEZRNc7NZLtz6DjjU33TLVxrju7KzmxnCr2/tX883?=
 =?us-ascii?Q?J08sZsxs0G2kCSpEEycqlzBWIwk+1pfTn6YjI00zxZ5zX9BYnAZH1GDQ5DsU?=
 =?us-ascii?Q?udU6oIQgHbLMPIEhJBzj9ACKbLZjgJYitZTpCzovMmnYScc4OXfPNNhctAo/?=
 =?us-ascii?Q?NH+YLjkLUnqlTolUa5RIUHzgDubaxFeRlpAImI/QBH8/tf0CAFlyZPCpazXa?=
 =?us-ascii?Q?WrKn/87977b05JU7ZEoi6QaragJ5M9gRrOd1amEHCm/P+8eqgDuH8wDmQdat?=
 =?us-ascii?Q?08dqHLsxwWyJPf/Onh2qNcAFwA/paRd9OmSuBlFgtxl3uJtHVZY96wo7+z4X?=
 =?us-ascii?Q?WprBohKtMwz89P673GiXbuZE1OtgnhLMVeeFzlX1cqEGjPlijacEIhFzcY0c?=
 =?us-ascii?Q?FjeTb12zhqraSpfeINmo/PK7HwuVlgs+XMdwKnh218DISWsfkwd/pmDU2S7z?=
 =?us-ascii?Q?vChYDsu3/tQuWU/zwZwUY4evvrMZLqhtpAqg/TQjz4128/TmeOvXgnENqRek?=
 =?us-ascii?Q?PhI5YF7hGJlfS/JXKlZoXu3V+XbUG4F5MxlqgiF2Lz8uWO2kxfAoVkNBmmNN?=
 =?us-ascii?Q?/p/HQCcKW2p27sjTELREeBKCTLzvTfNdNTFdy6QbrrNpt1puvsXezhdg8orh?=
 =?us-ascii?Q?NSqx1cxHupB7dAnHLEJPo1JJMRzBoT0f7R2dOKad?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef44fc04-3e8b-4d31-399e-08dbe10479c1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:15:54.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59wTPq+LmacbB1HdYeeTaE8oGXqf2Pm7bCBWRO6n2pROEYZtfCTRNFxvLp0Y4UOPIzXCmTQAXqJykYGpSVffSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 08, 2023 at 10:29:46AM -0800, Xin Li wrote:
>Clear FRED VM entry/exit controls when initializing a vCPU, and set
>these controls only if FRED is enumerated after set CPUID.
>
>FRED VM entry/exit controls need to be set to establish context
>sufficient to support FRED event delivery immediately after VM entry
>and exit.  However it is not required to save/load FRED MSRs for
>a non-FRED guest, which aren't supposed to access FRED MSRs.
>
>A non-FRED guest should get #GP upon accessing FRED MSRs, otherwise
>it corrupts host FRED MSRs.
>
>Tested-by: Shan Kang <shan.kang@intel.com>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>---
> arch/x86/kvm/vmx/vmx.c | 34 +++++++++++++++++++++++++++++++++-
> 1 file changed, 33 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index 9186f41974ab..5d4786812664 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -4423,6 +4423,9 @@ static u32 vmx_vmentry_ctrl(void)
> 	if (cpu_has_perf_global_ctrl_bug())
> 		vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> 
>+	/* Whether to load guest FRED MSRs is deferred until after set CPUID */
>+	vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_FRED;
>+
> 	return vmentry_ctrl;
> }
> 
>@@ -4458,7 +4461,13 @@ static u32 vmx_vmexit_ctrl(void)
> 
> static u64 vmx_secondary_vmexit_ctrl(void)
> {
>-	return vmcs_config.secondary_vmexit_ctrl;
>+	u64 secondary_vmexit_ctrl = vmcs_config.secondary_vmexit_ctrl;
>+
>+	/* Whether to save/load FRED MSRs is deferred until after set CPUID */
>+	secondary_vmexit_ctrl &= ~(SECONDARY_VM_EXIT_SAVE_IA32_FRED |
>+				   SECONDARY_VM_EXIT_LOAD_IA32_FRED);
>+
>+	return secondary_vmexit_ctrl;
> }
> 
> static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
>@@ -7785,10 +7794,33 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
> 		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
> }
> 
>+static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
>+{
>+	struct vcpu_vmx *vmx = to_vmx(vcpu);
>+
>+	if (!cpu_feature_enabled(X86_FEATURE_FRED) ||
>+	    !guest_cpuid_has(vcpu, X86_FEATURE_FRED))
>+		return;
>+
>+	/* Enable loading guest FRED MSRs from VMCS */
>+	vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
>+
>+	/*
>+	 * Enable saving guest FRED MSRs into VMCS and loading host FRED MSRs
>+	 * from VMCS.
>+	 */
>+	vm_exit_controls_setbit(vmx, VM_EXIT_ACTIVATE_SECONDARY_CONTROLS);
>+	secondary_vm_exit_controls_setbit(vmx,
>+					  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
>+					  SECONDARY_VM_EXIT_LOAD_IA32_FRED);

all above vmcs controls need to be cleared if guest doesn't enumerate FRED, see

https://lore.kernel.org/all/ZJYzPn7ipYfO0fLZ@google.com/

Clearing VM_EXIT_ACTIVATE_SECONDARY_CONTROLS may be problematic when
new bits are added to secondary vmcs controls. Why not keep
VM_EXIT_ACTIVATE_SECONDARY_CONTROLS always on if it is supported? or you see
any perf impact?

>+}
>+
> static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> {
> 	struct vcpu_vmx *vmx = to_vmx(vcpu);
> 
>+	vmx_vcpu_config_fred_after_set_cpuid(vcpu);
>+
> 	/*
> 	 * XSAVES is effectively enabled if and only if XSAVE is also exposed
> 	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
>-- 
>2.42.0
>
>
