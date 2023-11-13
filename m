Return-Path: <linux-kselftest+bounces-42-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101857E95B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 04:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BBA1C20963
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 03:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D535233;
	Mon, 13 Nov 2023 03:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlEWqRbl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B358BF3;
	Mon, 13 Nov 2023 03:48:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7CA111;
	Sun, 12 Nov 2023 19:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699847294; x=1731383294;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z38840MYc+2S4zMCSmuXj9ueb3E89myNCIJQGAd22sw=;
  b=QlEWqRblf/tJWjY6jxsWw7ABbEVDyS8iarySjV0A0sJM7HfCvt4jAa1/
   3qR2YYHQLjene7r04j67zisn+CeU5s3p3AuRdR6GT15s7+6RT4BJ066Z1
   2Am2z787xmAdfvGjaGtJyuVyWtM/leO3njKdnjULNWHP65CwaR/FwULQs
   iTfbkcycGkntSIwdhTMEZVu2wVtxnzPvENvQ3DXNKbDUzMKekVDazK/2z
   1dpTipsSWUyRpyX/MiBIyIJ/wg4q3b/bvmPwVS4lclhnzNyCQbvkiFxzB
   JoP21EixoVwz+trtWSAp6tvywaNJ1UKeE89k5ml1MZuxgGZNHVrh6IYsf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369702210"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="369702210"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 19:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="907928727"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="907928727"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2023 19:48:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 19:48:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 19:48:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 19:48:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 19:48:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvlLCKFGnxSB2MWr/QOwL+ycySW1w/0GwOTi8sXSSi5T7EKJ1AAGdouddIkYs+r5H/RIxOyteHbm9J5fJPSHsZorS9Bj3RD3/wvgDk9depbkxfo38osDkLpw5pyqG0XX+c7Vf3RZk80aCZC+Ofu7vQAmcM0wJ+vzLh/bI/g6IB84N2tnsjsj/aS54i+xTXX5DNJrq8fJF3OktTsOup1YY/RqiTFwIvRvnP/Ln+xg4ffHjHhDKe3kYIjux/mKpbTl+TIAeA6DfWlpdczJ03HLI+WlbO6PCodINY1L57qmCNFtPaN/k97c4HLhQc8OA6YW8Ix7u08PUmbxUgJZFVaPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dlqpo1VIiWRPOsD/Rc3lyNo2loUAnUwrRMIY9tOf9rc=;
 b=SaOPsjSPk/PWPPaGeI8QBKYQXJZjCz+dka+/+zni4eBBIX2b0Jlnc8bKvWKcjwkPLDibZByWBUUjdmdNBEIW0tsmRctKbEKN5xgcW4p9Zq40EQFAxCvo0SlGBEe7y0gJiwhoc///ZG2QGfg+/Reg8LNRGNdsOWtR4vtbvXcZiHaCPbvBLi3+QGgESuYjCF5NoA34HBeamg8wozu8abbnb/vzKTjDKbd/lgabPbBjHZE7J1y/cLG30nd7L0TW/r3TiVUoGJ9eqxL4Lwu/4mg4NRfMiI6Ys0Jl0aV9zylFnNf7mtynUu42/QmiO0aamJfZOYV19sBnJh+ZQpy74ftwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SJ2PR11MB7713.namprd11.prod.outlook.com (2603:10b6:a03:4f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 03:48:09 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 03:48:08 +0000
Date: Mon, 13 Nov 2023 11:47:55 +0800
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
Subject: Re: [PATCH v1 09/23] KVM: VMX: Switch FRED RSP0 between host and
 guest
Message-ID: <ZVGcaxYtabZxGt0s@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-10-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231108183003.5981-10-xin3.li@intel.com>
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SJ2PR11MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 869c30db-2a69-4992-b8c9-08dbe3fb58ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKjhn7V1Cid0RR963q0jIkkQAOaUf8M2cg8Wb831cHF+uRsiJflNALVV5a50FwudBTjFQKYEl3MWSD9v1ql1OsWyQEc5Adfv6zf+d5KglsUhNHTXUe3rVLhAgrhzKXCWMl5TKjE/Ue6RjYvGkwt+mXQ4PdLiuiM+/0AuAU4oJJVfgbBX/uebKYPFTa1tElhlFcj8Qi+nNtma1Xoj6Ihd32buAgKTRabPoHy2vFS0RH+hXRlFtJLQQ15ymhna6hqzvPxCDRLorgjeW42pLjtBjxUoOk7uQUWLSlwIY+Pm3lD97gaoSK6Vyyx3KoK6Q11d3fNEiR3QvIk3BDgardOZIyI1rXZyWWU5DmCd8tdtj5J5UWDIGeCcpMK5g7O4h8ZNELLXjwR/ZAVN9uCSVLb2Cb9Cv5KlsNry1quUKCm0v7JVC2D4ph6dRrdPppLQ/D9GA5hObdMs8Bekr2zvsQ749Xosl6SI1ng9i7HfTNsA9Gb1aF8d9kG1eoxR8wSDWkgAdJxyxmVXqkeqCPMZtfmmkyaGhNqvrxAIGjtn/g5U6DXXkjgNRcw8OP2voeKZLxs5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(7416002)(41300700001)(38100700002)(6666004)(82960400001)(86362001)(478600001)(26005)(9686003)(33716001)(6506007)(6512007)(6486002)(83380400001)(6862004)(4326008)(8676002)(8936002)(44832011)(6636002)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/houEZ3JJLZrJnhjLJr/BvOYzDk8IAP7yG0gGrmjOLFT7I8PRSRXZi0xzIb/?=
 =?us-ascii?Q?Qvs1uKPSDuv+urOuJ4OG82Y8F53yL4A8PbGhHUDcSyFup39E3qS3i95YHWjF?=
 =?us-ascii?Q?iDKDQruHcjUzmoO9L+2ghAdQtFRNznBIbfdiaB5/YmBF4bvZ7jaeQWEGWNEP?=
 =?us-ascii?Q?NAkkoJzQF+gaHhG713ZzHCbFzsgTuI5bcQnMzBD0F8Z0QGODVY8pmRlNk/pg?=
 =?us-ascii?Q?z000pOcBuZ1LCDvfq/HTOvHGoBR7pUUT3kq97pegd+VDs+dGIQHfRRW3vnot?=
 =?us-ascii?Q?TRbcCZlGKez0b/yPA/gDrJmfZYRfi5cm1VIL9fWUtSUnE6m724t52LlYPESS?=
 =?us-ascii?Q?Z7jyLjv9fNOeC3FrEa0sIwJUXlJF4j1O4Ab/CQb3jap1321cTjuTgw7/7Ap8?=
 =?us-ascii?Q?78hHIBtU9lskyZuEjB6ZQrD57I5ixOvZS1Y1VJ6hhxKmmwM1mbjzRF7V1Z1X?=
 =?us-ascii?Q?0q5XWM1yAOS/yDA5n2wn1hrRf1OBdHvuU9dXw6iJ0blsMhsQJilp3Du7vgBr?=
 =?us-ascii?Q?8OzcwFq5StP9P5lBc9b2Eh1PVA3ulGkPFTf6aY2sAryVe1I5LN264grrIgZ5?=
 =?us-ascii?Q?U811okmSOYSP/fqzdS3kwNvCKrrLgrQAhqX3GIazJpNjYlWoxgNBZQOciFOD?=
 =?us-ascii?Q?+X4TmZ0M0q2Or5Ve3AOWepYfEikSiGYtxl6FVteLX8RLkoY8IKzcxmL5eYjO?=
 =?us-ascii?Q?535kV13VUuayWF8Srn9yFcr2qKWB/K31luYkUxpfFQZQPZamsqPeP0LIz08o?=
 =?us-ascii?Q?o+eBk/3W2UiUnyWxSMg0mzsjgxNgxFDGRT2EL50AgPKmvEsR4KOgUdJz8TIl?=
 =?us-ascii?Q?UlPyQh16LD1cuiz2mP4znobaldV5rDOwFoVsCDgCqd3pcJ6V+MFrX13x+wy6?=
 =?us-ascii?Q?bGUgdOyoco7hSlsiW6xu6Rk0AACvlg5VFmGxPZThHHEaWkIS9JMOUVvgmjG1?=
 =?us-ascii?Q?XAfOof5/Qr0mtDk0Q2THSz7qtnK5iFHGNX8h1V3GChx02Vxf8PLM+l5ffyed?=
 =?us-ascii?Q?tcn7kb4BczG2AUqJ050zamT3YZQlLMBCiHlU2tls+huzzIQfLGgGYddcPcJ3?=
 =?us-ascii?Q?DUoFrp6BxY4OTb8m1s/o0WQtCMdJFktgprxNI1VJ5VaWDsp8cc2jQhcGIY0p?=
 =?us-ascii?Q?+pcbv18qeYsW/qpDyFP3TfyYmO0NQIFE8Gp45cdMa9surg/1uMpeUe67B4of?=
 =?us-ascii?Q?HaVSBzRAaGbSboFJfLMa7A3FBzg0zqk9yrMxWHfH7XIGMfkJ9M1x0kj2kiQ4?=
 =?us-ascii?Q?9W3EQezolK5jIB1uFdwNMoK9psUw9EEsJrK+/Ttz2jOs1PjgH8ff8mS8Bmom?=
 =?us-ascii?Q?trJ2B5WXrgSm/lW1CP9CLSVcChspRB9prxUnK9C4BWM3uTVGT/D5ujDdwEu4?=
 =?us-ascii?Q?oyfNkRWHPqTip+9qIUsoOC+eWD4Q4iGWL2bkSud0L4U6wmZDJELDC1gOvXF9?=
 =?us-ascii?Q?zJFkvDCQYbeRcSejL8MlyJ82fapVYk8RidPmzC4VK6u6JSVGsUrSJoEZAJgu?=
 =?us-ascii?Q?e2pHaxxM3kRR5kHllnMjFOUhJ+U2ev8+RHdRgLl9BWpPAX0VaQ5m55Yh+qoO?=
 =?us-ascii?Q?1Ut0lCesCkrp8qWhfu3MNqf75vrEwsPLhzkT0Ctc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 869c30db-2a69-4992-b8c9-08dbe3fb58ef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 03:48:08.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57U8U5EbuQR0PPh8HtdGdI2TMBIdUwBWCxTGgtEag3kKdINNIKZzqDHlEWK53q2zsTZJLz3Y+gFVF5Dq7602mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7713
X-OriginatorOrg: intel.com

On Wed, Nov 08, 2023 at 10:29:49AM -0800, Xin Li wrote:
>Switch MSR_IA32_FRED_RSP0 between host and guest in
>vmx_prepare_switch_to_{host,guest}().
>
>MSR_IA32_FRED_RSP0 is used during ring 3 event delivery only, thus
>KVM, running on ring 0, can run safely with guest FRED RSP0, i.e.,
>no need to switch between host/guest FRED RSP0 during VM entry and
>exit.
>
>KVM should switch to host FRED RSP0 before returning to user level,
>and switch to guest FRED RSP0 before entering guest mode.
>
>Tested-by: Shan Kang <shan.kang@intel.com>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>---
> arch/x86/kvm/vmx/vmx.c | 17 +++++++++++++++++
> arch/x86/kvm/vmx/vmx.h |  2 ++
> 2 files changed, 19 insertions(+)
>
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index 41772ecdd368..d00ab9d4c93e 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -1344,6 +1344,17 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
> 	}
> 
> 	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
>+
>+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
>+	    guest_cpuid_has(vcpu, X86_FEATURE_FRED)) {
>+		/*
>+		 * MSR_IA32_FRED_RSP0 is top of task stack, which never changes.
>+		 * Thus it should be initialized only once.
>+		 */
>+		if (unlikely(vmx->msr_host_fred_rsp0 == 0))
>+			vmx->msr_host_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
>+		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
>+	}
> #else
> 	savesegment(fs, fs_sel);
> 	savesegment(gs, gs_sel);
>@@ -1388,6 +1399,12 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
> 	invalidate_tss_limit();
> #ifdef CONFIG_X86_64
> 	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
>+
>+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
>+	    guest_cpuid_has(&vmx->vcpu, X86_FEATURE_FRED)) {

IIUC, vmx_prepare_switch_to_host() is called from IRQ-disabled context. using
guest_cpuid_has() in this context is not desired, see lockdep_assert_irqs_enabled()
in cpuid_entry2_find().

>+		vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
>+		wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_host_fred_rsp0);
>+	}
> #endif
> 	load_fixmap_gdt(raw_smp_processor_id());
> 	vmx->guest_state_loaded = false;
>diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
>index f8c02bd37069..328a3447f064 100644
>--- a/arch/x86/kvm/vmx/vmx.h
>+++ b/arch/x86/kvm/vmx/vmx.h
>@@ -276,6 +276,8 @@ struct vcpu_vmx {
> #ifdef CONFIG_X86_64
> 	u64		      msr_host_kernel_gs_base;
> 	u64		      msr_guest_kernel_gs_base;
>+	u64		      msr_host_fred_rsp0;
>+	u64		      msr_guest_fred_rsp0;

resetting guest fred rsp0 to 0 during vcpu reset is missing.

> #endif
> 
> 	u64		      spec_ctrl;
>-- 
>2.42.0
>
>

