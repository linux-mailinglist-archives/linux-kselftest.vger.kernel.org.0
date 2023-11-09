Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9F7E65B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 09:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjKIIxn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 03:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjKIIxm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 03:53:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FBA1991;
        Thu,  9 Nov 2023 00:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699520020; x=1731056020;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l/hTwtdMUcsDJEO9k9mkp6MnK2Y0+xPsNC5BcCNoEUI=;
  b=Kd/iKV8qa2Ak8b2V5LD7WU6pnPV0P67GoTrxgGaAOSZcMaCHcYclYDtN
   GmLN5PEXAV95IY+aqoumdaoJPStKGZteLjiG9e1M1RpzFaf/P+wjMt2Vm
   V/ZLX+xxHzWiKoWaLqVeeSp3VcZjGg7brJagi9hKCsy2Z+zm/wjEHUIF9
   F8EZCZBxUk99Y5MBGfqxm5UbtXFNAOm8Z/7lV89wWiuYzzdnU9YVR8l1+
   I/4mgQ72AWnnMPchz41cymFyfKIe5wATmUch54Y+fe/NFBTOys+J/XSwO
   nP17IvdNOAbg77d90wUtQwXC7yYLt0LYnkBngXPfWgy4vxtz9EVHgAGaV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369278527"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="369278527"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 00:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="766929860"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="766929860"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 00:53:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 00:53:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 00:53:38 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 00:53:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY2t8KAShQI/7hLrFLoc8WXMWiPQMrfzVCoh8Ou4kq2BKS9Y6HCCaHZ5kIAsa+SQgFQG6FL/TRHRCsitznkUyi9DvCDgs8RsO00MPxqln9pGb2xgniEq47MkXz5HwPdEgKYbOzf29hi1Oins+fz024iMxy+fnor7pyS2W6feMhCQImkJD4G/YQxWADg3je5bKRNOw6qvX6n6FVDg1bJrh2FPZMVLqtQiTqdQinNE0kxZcgHqWlB0iovXVHHizy595vmWb3WA4G5ToFyseymqkfuJeVN0pob3C6oOft5uBlBiuIKW0toGu72HxV6QZ7H/Mz2sf/r67/VhMuKnJM3mtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVBx/k+1nxLGRDVRZ5wR7vFBS1WXAmzmCgyE10wnAhw=;
 b=Nr1LtNSl4lNo23oOoB9IVEkqWciQZc0tk67VxekSEcryVXRYJ2OLn9TA0Bqkr+5cxKrXh6dloT5y6lYXQgiq85PM7+EHoHmH/X/8uUK6y+rCL2a28bvQfobSE+eHTk94OUzZR58b2vaAr99FCHPoYRzWgGc7OoGN6YPpa1lxZ4CMQB/7BT6TiEvT3CwGWxEFQ3VM8nfTMRCW4eqSC+0vZbbnF3FDYKGEgxldECtmQMyvrdnOTzox6orNtWLrk3u+SWipA+ANJTVsK8cIvCtaCT6JCajKrALWCySQekrU+ZeoqEBpT8aMQSOCIR/6kSZhRDbd3C2XvF7vXM2eVppQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DM4PR11MB5440.namprd11.prod.outlook.com (2603:10b6:5:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 08:53:35 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 08:53:35 +0000
Date:   Thu, 9 Nov 2023 16:53:21 +0800
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
Subject: Re: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit
 controls in vmcs_config
Message-ID: <ZUyeATu4Fd2xI0+h@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-6-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231108183003.5981-6-xin3.li@intel.com>
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DM4PR11MB5440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d98b655-2de3-4738-d747-08dbe1015b41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pTJmuFtc4j4MeDtxp+yEQJxHg1Cd121SyqC2USYlmXDeeZTTM4MiHxjYR8XA7AHdNJHGRLT0JeGLX258kchs/I4CaImA+Hs9/XvFp4UrQAn/2lPRgW1jUOTYpy2bGFtj0SylLPuh4eEseqssCrdKkZOZZzj67XJc86TepPK06U4szzsW7zqiNPBmwUK2tZgqqtwGkGy/JttYL5NtH9BDwGVdmA4CJeHdxqbuy/y2ib2dOidycHnlGQ2O7jGeiJ7NtbsKT1M8TLWyGDi+9eldTfMrrgLkNo0UzyJXov+8bzK4Yj1TkyPSKAvFqnKijxwX9kwlOENJ2yRvEFVUXwQRSrfN/TVgtSv9TKzmyQu7KwNy+SydQRbfXzlRbf23n3NM8HWAPeixNoiH2S/idjz6whW55g3JdzcrA6TEl40TtC6o5Otoe4yhpNkhyRVObrW7QxrOLszjfs0iQGIkUXbNdssv/KwFf7TnXtIPMNEO5yKhVKV+yfJZqhWGFtyAL+7kSxyyHnDVtI3moDYGA25gPhN5sue0dPY614DV35+sQWh2VFskXCc7QtTnn0hT2ZvI/0QAqdCMeqiGsORBZAhyTQ5eQoH9+zB99Gz/E+s0WTOU5iW+Gia36dfpTumjrcSPvhli/t8SXoGW3+RWoUxng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39860400002)(366004)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(33716001)(316002)(66476007)(66946007)(8936002)(8676002)(4326008)(83380400001)(6862004)(6666004)(6636002)(26005)(66556008)(5660300002)(41300700001)(9686003)(478600001)(44832011)(6486002)(6506007)(7416002)(6512007)(2906002)(82960400001)(86362001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6R3MUrDXtKENuXOYn/ZaJ4WUa/NeoeD38oxFQ+4y0ZGFLGRUHdhcuH6H2E/F?=
 =?us-ascii?Q?QTF3PW10in5Be/RdhoF6a0u9mdpp/Agk6O9mO3W34PKfmgfBGLA4W/YyhZ3W?=
 =?us-ascii?Q?bLdoEClMcfdS6ZL49kvUL0pQrePq5nn1ZsUxGg8Dt8k0IbyeaW5nxKpfY3DZ?=
 =?us-ascii?Q?aT6rkSMmIi/l+JMDCMbhaXHLg08XZE+o7TyZUXgO87l8lXlWzOhG9Lylwtmo?=
 =?us-ascii?Q?o5o/HA6v7YtFQUJN/coDpDPBj5xv0F4xdpt38uwlWr8SmNR/MoS6UYLr48rh?=
 =?us-ascii?Q?eSDwUru3BFjqLmmsU3OKfwRkWXXvNCnqhTyr7ICIBT702sRV1hOXAynL7Jth?=
 =?us-ascii?Q?f8OAr5+npLK5TexI40vrAXpkmj42+ZO57MTy4j9ySvuATdSeTJEuwKBi6IqT?=
 =?us-ascii?Q?UVF1Dy50BGgoUN5azVNO68l8S/H+YPCZ4soJUoINrpugxT7hO3CvPJKRQg5A?=
 =?us-ascii?Q?kYWmRfQt9U39IiVxQtScyIo33TLr5s4rqNg8NN7QxuujhbRsf+zkfUKMBLj9?=
 =?us-ascii?Q?cyzuwc9VvxOHJr+UnyfJ8aByP4qpfzXOF20NshVAk0Q4ZvzFoIKycyoVxvav?=
 =?us-ascii?Q?h8mo06fm7d3FrUZWO/Gh3d+RpmzoFMBz7ace3VxZmZgB/xh8ura9EhL7Hp4V?=
 =?us-ascii?Q?joQMDRj6DXFScg70lLx/+0xSxYdMioZoaN4+9Bw0Sl+qgolAP6iKKWh8Zjm7?=
 =?us-ascii?Q?fWIeyT3sJMYZCv0YHHlbHCazr8KVMt8QIue0viaAwM9Pa4S+lRbDYbGxD2da?=
 =?us-ascii?Q?l7FXc0UMvsUb7GfvFyqMufiZicLrEVDbqzN+yNHP4URpj11DvLhKl6aoNCU1?=
 =?us-ascii?Q?PUz4Swvf1bqjRsB+w66bRWQH59SPkqEDDDWkDbAn/8eVBO4YXWsreD6u1RCG?=
 =?us-ascii?Q?zFrHLZHJKxqa4aTMT4HezSfE1NzkrucBf1u5i/dpeJOjutYWJ8lthIhSLAH1?=
 =?us-ascii?Q?S9lt7D+6MzKt78qmOVcR6kEfEbWx5EMWm7mStBGybhQrqfi96dIv9gRPjM8C?=
 =?us-ascii?Q?WGsnC5DbOxyR3pS2naVqLn+Jj2hgKmJUBuAnnshINyHjGnPLx6sHZ+6j8XrC?=
 =?us-ascii?Q?TS8A7sTRfe+vjpYpa7vrMwRxvzSErvHw/0kfoNu2+fb63WAVEPFRJN823dS/?=
 =?us-ascii?Q?uC1sun46Pnw777yK0YlwgAci3hCtX4GEDqK5mzGd+8c579aPHDjmp4m9b0Ye?=
 =?us-ascii?Q?5tFpViv/ogdCWYiVlHzV3Y31BucEnav7E9s+udXKiW1cZGKSnVhvp93NdZXj?=
 =?us-ascii?Q?GBymORIbEJBkLm5OGJaTGLX3l171VeMmP1bF4rH2jBQF/BB9gDZMmHdGlk6A?=
 =?us-ascii?Q?6nAwO0zh+Pmc8V1Sbm78odcwXymsOPBaF4Zt2MWVfaFA0Axzi6R2eC5br2Le?=
 =?us-ascii?Q?sY+4azzyjoosUbLDn+E0LhYJ+gT9hhGL8EmFuGWwVPnquVxuNkSSz0a9nP+y?=
 =?us-ascii?Q?xA8x7AVs6nvgGqTflPNAeJAB/vDKcdrzJPq8KnJrILVvzifAXUGjalJSk0R9?=
 =?us-ascii?Q?gSPXSmr6Vr9wuJJ9iVcptS2xJgirn9g99YDKbYpVb9ai4dXIDbURR8g3udOi?=
 =?us-ascii?Q?0rRb5vzq2zZi1IUbdpPBd2ccEI+/HWSfETnvjFpI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d98b655-2de3-4738-d747-08dbe1015b41
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:53:34.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETKhw0rYyEKHC6r9YI4vh+U6R+1jHhPu9A2RsYf36kHBtET1BKn+NjObWN7/OTvmxRZkEyQEI4e1rVqzOdgDmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5440
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 08, 2023 at 10:29:45AM -0800, Xin Li wrote:
>Setup the global vmcs_config for FRED:
>1) Add VM_ENTRY_LOAD_IA32_FRED to KVM_OPTIONAL_VMX_VM_ENTRY_CONTROLS to
>   have a FRED CPU load guest FRED MSRs from VMCS upon VM entry.
>2) Add SECONDARY_VM_EXIT_SAVE_IA32_FRED to
>   KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU save
>   guest FRED MSRs to VMCS during VM exit.
>3) add SECONDARY_VM_EXIT_LOAD_IA32_FRED to
>   KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU load
>   host FRED MSRs from VMCS during VM exit.
>
>Also add sanity checks to make sure FRED VM entry/exit controls can be
>set on a FRED CPU.
>
>Tested-by: Shan Kang <shan.kang@intel.com>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>---
> arch/x86/include/asm/vmx.h |  3 +++
> arch/x86/kvm/vmx/vmx.c     | 19 ++++++++++++++++++-
> arch/x86/kvm/vmx/vmx.h     |  7 +++++--
> 3 files changed, 26 insertions(+), 3 deletions(-)
>
>diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
>index 4d4177ec802c..41796a733bc9 100644
>--- a/arch/x86/include/asm/vmx.h
>+++ b/arch/x86/include/asm/vmx.h
>@@ -106,6 +106,8 @@
> #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
> #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
> #define VM_EXIT_ACTIVATE_SECONDARY_CONTROLS	0x80000000
>+#define SECONDARY_VM_EXIT_SAVE_IA32_FRED	0x00000001
>+#define SECONDARY_VM_EXIT_LOAD_IA32_FRED	0x00000002
> 
> #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
> 
>@@ -119,6 +121,7 @@
> #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
> #define VM_ENTRY_PT_CONCEAL_PIP			0x00020000
> #define VM_ENTRY_LOAD_IA32_RTIT_CTL		0x00040000
>+#define VM_ENTRY_LOAD_IA32_FRED			0x00800000
> 
> #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
> 
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index df769207cbe0..9186f41974ab 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -2694,10 +2694,27 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
> 		_vmexit_control &= ~x_ctrl;
> 	}
> 
>-	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
>+	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
> 		_secondary_vmexit_control =
> 			adjust_vmx_controls64(KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS,
> 					      MSR_IA32_VMX_EXIT_CTLS2);
>+		if (cpu_feature_enabled(X86_FEATURE_FRED) &&
>+		    !(_secondary_vmexit_control & SECONDARY_VM_EXIT_SAVE_IA32_FRED &&
>+		      _secondary_vmexit_control & SECONDARY_VM_EXIT_LOAD_IA32_FRED)) {
>+			pr_warn_once("FRED enabled but no VMX VM-Exit {SAVE,LOAD}_IA32_FRED controls: %llx\n",
>+				     _secondary_vmexit_control);

if there is no VM_EXIT_ACTIVATE_SECONDARY_CONTROLS, shouldn't we also emit this
warning?

>+			if (error_on_inconsistent_vmcs_config)
>+				return -EIO;
>+		}
>+	}
>+
>+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
>+	    !(_vmentry_control & VM_ENTRY_LOAD_IA32_FRED)) {
>+		pr_warn_once("FRED enabled but no VMX VM-Entry LOAD_IA32_FRED control: %x\n",
>+			     _vmentry_control);

Can we just hide FRED from guests like what KVM does for other features which
have similar dependencies? see vmx_set_cpu_caps().
