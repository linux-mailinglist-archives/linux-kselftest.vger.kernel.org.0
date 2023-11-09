Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A327E668B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 10:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjKIJV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 04:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjKIJV2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 04:21:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1B2702;
        Thu,  9 Nov 2023 01:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699521685; x=1731057685;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vEishIoYq6wnSkNNYjPoV9mUbQCFvhkm3rTJOXudaLo=;
  b=V8s+91y1RQfbe7LsqWfxb090fGJDIH39JF2x7MBeGZkUWPhCAxkBkxpt
   CbEuktE6IPn/+7VoJF/Z14yl0gCV30f0WhbKxYxVOp9zuMJQq61LOpPB2
   fVH8NVp4ol3owI8x9NSHweppgIk07tMH86fRwvh63qXDvl0haY+L0WaKz
   P5Srj/jgRm9+2VP8sVbbPw5q8USuZJcuNq8TT8oeUjbh3XcVv93IQuOpR
   HyD9k6vZPkmrNZlq6oH/mu+tvO/J/OV8j6chnrpj+0u+NeGFgHXfN5xKG
   r8XHZThmTLouMOV+ugEg9I5zj6bezjcsiuA6/3xhUPGa2aIyg7TogcxLI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369283039"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="369283039"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 01:21:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="739793433"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="739793433"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 01:21:24 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 01:21:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 01:21:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 01:21:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ac3C8dqv4cBTwG5RGPa78O5VBq99znNcue1ITSyDFWwwEGmbiemRdDz99or5vmJRk1LPZhrZ0vvSP4CG/FVQ/ytl7vXm7KB0ByBKSMmuQc2pAxIiRa+8fri/YMQt4QbNtZoo61MEj85iyGU5xvX5JKOCI6w1Iu/eUYwrctPTIUcnG5tdQgpJb+hmP9ZiU1bG8dcvLyclnJZtV9YpNJF/h3GBFk1Bw/Hg5aMcbEOql2PfYs1qH7xyv1a81WxxiEweWAgDFpZqgWQALND4lGxaNqZlWHxiIJbucev5Sw9ZEkaMzH8BUMOvA9vvX2Re8iM5SfvVAa/SKXccCmW8X2tKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLHVWfBCAVUbl+8OjhIs1vvj1O9ki9BFZ7R10kcBjEg=;
 b=TM/LZYGPGQq+uj4oOoXPWE7jCZHNaf0N8afRP3DzzvEBMqWISSpjFxwBVQm8CRWASCQwchzelBL8atGEHrPtub9+G5AKXSTZfaSrYVxwnKaJaiHgVWLThTP1/T1FlyiQ/rmwRHESbdR6ffrZu+hWhGazI7IXuhx3dqzpUSJgKUEZhdX6DvdvdBlQVPU3/WcZ/Kx3hmLA+XSMgm6LoSFaNBwfeWmT9NtfGJUDOFT72V4RlrA4r7c6T+V6OoARIoN0Q0Jg01yjCasLuxhUfGNj71WaqASH9yqaCsYsmMY8xrv2FnEs07Y1USyIEjlnzfNdLHQfg/EhUWI7tRXjJGQtbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 09:21:21 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 09:21:21 +0000
Date:   Thu, 9 Nov 2023 17:21:09 +0800
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
Subject: Re: [PATCH v1 07/23] KVM: VMX: Disable intercepting FRED MSRs
Message-ID: <ZUykhb7TMJntdl0w@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-8-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231108183003.5981-8-xin3.li@intel.com>
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA1PR11MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab18278-ca8b-44f5-11a1-08dbe1053cae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4E9uAJfS7MByN5NL+uJJ9E3fniPKAbhwzTiAikY8x1ORg/PjtWBYk/sKNNuqJ71bDZvacJtN2TBR1BT8m+8sfCGte81GcQ9JRv1gf9yVQP8i8OmD2Y/ksrGU+eyA/ftaiZP8mWI3xPBu+WxFDTkryock6l78K0Bqhr4X8gxPCw9M9BKxpe8dyhMkH+qdnmOeXIahtX+QQU+bAR+s3GpEWj8uG1Tn9qFPSFfYWcmSeD2pGd9xPXkMcgm7LO5Wf1KCYNT2pdGqeb43CJ/zPDozNAMXb3Yhi6i/xFfxw53BGB/6V3d2emFH65ONzRvW6ZNJPjDgUIzxKXhDy1GptugC9nrkpQkst8SmHGw+NtXYfZB2gcah4ecgfcwdqz8eizxnWfLirfRc4B2wWx5bbF7aVXSLx8hNPNyTfi1f1XwAaUiS7vKjtQnLyxGyjkrjca6JoMDyHysby3z400TF5Lkmobnx91ZfMgelCLLgd/lF3PD05v2d74Id+AUm27LmGG0nPd6ttR71NnE3WO3No3MXOHxWCo9fhFzVD11o2PcgfeeceWGWUqQA/X9XAZfCBT/Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(5660300002)(8936002)(44832011)(6512007)(9686003)(316002)(82960400001)(6486002)(478600001)(26005)(66556008)(66476007)(6506007)(66946007)(6636002)(6666004)(33716001)(6862004)(8676002)(4326008)(2906002)(38100700002)(83380400001)(7416002)(41300700001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l/6DRJcJFsge25Z/Sp6hTQGjvhmBpmSi8fv/k80wkuADlCEXY5grM2zit+G+?=
 =?us-ascii?Q?O6MUDAnaZmfM4DZId8fNWwjH/IysGUim4t0smjwBylGrTF4VOP52hE1dhkse?=
 =?us-ascii?Q?DlIVcWJ29/OU3zeSNx7+DC978xZWjtgENoraFTOKEIa49pCwYA+Ls9YQvfTy?=
 =?us-ascii?Q?RfluYxLieYg1r2PtmzYT/893seEE+i+5G22AKqSsuuhq+wgwLJWiTtSu1DNt?=
 =?us-ascii?Q?ZFxuGUfEgA8e08Kvbc+iq5k2ILfk0vS9g2OaYLw0Y4AYhQzToCQnKRjXrGdp?=
 =?us-ascii?Q?mtGnUFdEsFz5Lv0wttjPAvyZepvQOoSAxI3F00dER+TYOKHgXTaw4IA4wmvC?=
 =?us-ascii?Q?2FCrhlC6z/uhPQwjpqpgUj1gqwJShsSktF9zsdcfVm/IH+RU26JH5npd40Us?=
 =?us-ascii?Q?Szvo+OFyPQ472iY9yTGb6Cv3e6kUDI+rlinF+7ekFWD/3nkRsljTtFF/qdIq?=
 =?us-ascii?Q?TV7akt4F2XGqxUDnGvqxSFO8WpKkVzS/fGv0QpDT63Q86klWBJ8lMiqtgZms?=
 =?us-ascii?Q?GmGIwAiQmotfDZgbPhAdowWA96alXZr6oEpNR3slmeuhegy67/mKD5TQIhi/?=
 =?us-ascii?Q?+34rhkvdncBiXD4aEW3DF3kfgZpsZfHiw/zqzL+sYOpPHkYTGQkNgCAo8JgL?=
 =?us-ascii?Q?9B22BloGrz4e2EkX5DtvAIi+kaTGpOhvBBOQnisrnbvHQ4Iu2jSF8eZqJJtm?=
 =?us-ascii?Q?tN6HJU9pCuPK8WFM9Gn9bT8G/O3P9CZgwm+qjfvK2066dXYZ2eGLbHw5O2/k?=
 =?us-ascii?Q?8UMPH4OpTQtBrYs0lF/rvfElxi0do/hz8L+72VD/A2aAql0FRbLAurc2XlAx?=
 =?us-ascii?Q?rLaxsKrAG0Her8+9yrGTD/KJ6HO2rUVC26N7SQNnrfcpDnipHEBJx66h2T5U?=
 =?us-ascii?Q?+jT2guE8m8XVoEizhIVeyT1dAKFbivFZBIKwKrOb6G12df0Pedk0+xzMkv9w?=
 =?us-ascii?Q?6/7D9sf3MzFZU9CqUo59c4+PxiXJLoR/c98Ku6J7X/W1l1GoU2EQldRiZfAQ?=
 =?us-ascii?Q?6+gwZ75SMNVN60wPocZvXdkww2sIOgzcarplMVlyKzpvZ9bS+jjiK/tTR112?=
 =?us-ascii?Q?rS8DalKvRugw01BLoR5CTtyJyU9re+TkgqwQdEV97XBo6mXrr8oSDv3Ojmp4?=
 =?us-ascii?Q?sTlMbeg3kHTAkUQhsvpw7Hzs13eYgJO73gNaHbF8JPNiIXj6aijbb8a7lkpL?=
 =?us-ascii?Q?aDb0UD8gPIw9PabOAfrnReFk4UmKCcKnq6tXrhq+hZIWsUEcmXS9JL3XmJBg?=
 =?us-ascii?Q?iwgEGvXX3qSQfjYusnylFjDJT1jCCTHSylwtSZkA/254avB8RnukwN+exQBt?=
 =?us-ascii?Q?ytvm/gWDSAkL5TdUR0pXqBBzXoSpRrt/UzH22QRALgevcVpqszfGlOzifzMD?=
 =?us-ascii?Q?OiLlVKp+7PrDJOh7Ta4gy3E1ZgGFeE+Co0Ii3hNoezPnfJne9BqJgDd2UfbU?=
 =?us-ascii?Q?YRNZ8zzPX79gh/707uSpxKfSLMlsh/MN+DyIH1KliBzEnHgeUFlYO8BWIezp?=
 =?us-ascii?Q?F3LQ+JpbyGB+nQQ6SvYEx3n9Yh/qDVU+G1OrtJovzHfgFeuOve5iC7SV6Fjw?=
 =?us-ascii?Q?PnHf3qYgL48vRML7K1ywZjUr2JB6GljgnOkPWmiv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab18278-ca8b-44f5-11a1-08dbe1053cae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:21:21.3353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZVhB2ZuvcqTvEkjJclvfHkafFI+w2eFKMuHrFNlkWgTNXHTBV2V468Cq/fGLx2lZJXU+XUnFA19tIMzsrY9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 08, 2023 at 10:29:47AM -0800, Xin Li wrote:
>Add FRED MSRs to the valid passthrough MSR list and disable intercepting
>FRED MSRs only if FRED is enumerated after set CPUID.
>
>Tested-by: Shan Kang <shan.kang@intel.com>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>---
> arch/x86/kvm/vmx/vmx.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index 5d4786812664..327e052d90c1 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -700,6 +700,9 @@ static bool is_valid_passthrough_msr(u32 msr)
> 	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
> 		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
> 		return true;
>+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
>+		/* FRED MSRs should be passthrough to FRED guests only */
>+		return true;
> 	}
> 
> 	r = possible_passthrough_msr_slot(msr) != -ENOENT;
>@@ -7813,6 +7816,16 @@ static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
> 	secondary_vm_exit_controls_setbit(vmx,
> 					  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
> 					  SECONDARY_VM_EXIT_LOAD_IA32_FRED);
>+
>+	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW);
>+	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW);
>+	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW);
>+	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW);
>+	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW);
>+	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW);
>+	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW);
>+	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW);
>+	vmx_disable_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW);

this has the same issue as patch 6.
