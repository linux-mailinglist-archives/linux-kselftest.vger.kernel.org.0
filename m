Return-Path: <linux-kselftest+bounces-47-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFFB7E9711
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 08:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F7F280A7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 07:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2E154B0;
	Mon, 13 Nov 2023 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjB5D6dn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065213FEF;
	Mon, 13 Nov 2023 07:35:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9127A10EF;
	Sun, 12 Nov 2023 23:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699860941; x=1731396941;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SepDojjrQ8PITemLNMvPDDyxv0DKdE9A0fJ8P72tZWY=;
  b=MjB5D6dn2BkaZlTZMP6guWKbvBMfu0ZasC3DeoNJAjaHYmjO7+r4321a
   nGutMCO0+xNw1B+nDoj1Th0odvbaM7CBiG70TRXO/BJv9ThcSoiq9Okma
   QPqm+otovzIwptgX6pSTEYfbul1nTZcg1iQ9nee0Sspl7EQQa5QkSnMg5
   O25dmahws0QGd2/ZoWv7dNpdehoVJQZvwPp2B354P4dOcfPQlspS0rohA
   3JqSuSdaquj27Hw8Wwchl3uDTotQfe+Nc5+mD0Nk83onD9Fvp6jEQD+GN
   Tb5GSLzDTuKu2VMEVvRsDTMzuqn6xR9iGkT3aZaqANqODQO7qNQiS1c9W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369718742"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="369718742"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 23:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="881583779"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="881583779"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2023 23:35:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 23:35:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 23:35:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 23:35:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 23:35:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjXIEjUv3xh5dxkNkAOpdIDkUU+LPly7UkYG1cI1FkYtLljlENyRPUZqcZBx9s4v3TQQ4wQR4kpqvW0HuFd4CG1gWwZhMzl4LyPNhQzQ6/PyRFpMJ3Z+8zb30byeVunAvzmbf9NNov3mHATqZVtenr1dJkschs/1PVxfS7EjIdHPF9yu851ZNdHC6UF836Y8agGH2GJEkBiN5UGrXzq7AFGzeym3y1OS66VtV9D0PUX3NFgs+zjH/hOqRZl9UuxYr4JMgFE/EvRnphEnxw/QJfJs5imXrxdT846wBZCgsYeLAcxS57Wxug1jodxoqGN1TzbeLVBYB+1hhiG9CqJAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWBLdGttmWKab373xDqKDgLSToDD/Fg+XMZ6C+8CUgE=;
 b=Ntkhr4UQ8TgrHwK+nbdOOtCrKefjkosdQC5hwHkd6zoXLH7UG1WSal1vJZtMX5Py7lXWKoQ8t8O7ALbJqQke5pqHGuIyVDeK9RnWqLpuHpzZnSYBfLma9Ec3m8sl/M7sMyEk5NMAD3DPfThkbDc/aXnSwpMET6xk2B9F2PkF9GlhV/CAwky55r9TQvI11UEd46KyRTEpDMLf4bEeIqR6KD4XB4VP31JMC4olGEnwhfDrWi7GxSZFvVDbIDpO8viW5d8xvU3cJw3COMzJx3CIevtBJSXM/CpQZaTox3iwkB0wwhnM3azzj0r6ZHgz0+n+36EFxTcULcy/GxIgJPn2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by BL1PR11MB5429.namprd11.prod.outlook.com (2603:10b6:208:30b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 07:35:37 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 07:35:36 +0000
Date: Mon, 13 Nov 2023 15:35:21 +0800
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
Subject: Re: [PATCH v1 11/23] KVM: x86: Add kvm_is_fred_enabled()
Message-ID: <ZVHRufhNmVTvJYWV@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-12-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231108183003.5981-12-xin3.li@intel.com>
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|BL1PR11MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1e7a13-7412-43f7-57a8-08dbe41b1f01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9IPHVSMge1h2Ca9YD/yX7ufV32Wr2zKStmADbHkTyNWh6alebYTK+94Vc4id3wXIvSs/CrWwPpAu5lcAlORaSixfRaB3mAXmmnsrBhGxsvrKlwS8fnKyFmS4BCWCPXDsxclLQFN4AwyKZ03HwJbh5HgkDzrfQB+gdcFXzqJo1v7aG/qIMFSRbXBhwj/UZBLqTJwB60kj09RsP9f6c3Cn0zIPhVYCK4/y7s5c8w/CjfugaqsufER/P0oop1YnZ5isZFHWA184K7crMelLCB7DotU1n/7k238a6B5q6Xa+CXSZnAz+s6MiNIYDH7KW4kbrVZ9YujTIzY8z02z+s8VYmJMKfBSlbFKnK+y/5Row53j7S4JQxZOWBRWyIVTkxfMePdkpAMLFpVgf0HRD4QCmIBkE370zy32NkU8CRRdCR3JjJoDDIPyu4f51ByOYlbUTGqyKzCNybBsvsdACtkmVOjGMdV00S1p05JUTAmv2lM6s3p37WMZvVxInzsYAiZ86RvBcPgbhfrXAsFYANWx97H9GQbBAfGqCvCoCJM8IHgBOF7YSvry4lIFtJ8Cv9HiIuBeyM7D/JK9cuPXBUQIak16YNLQGrnEqD3zith+JvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(38100700002)(33716001)(86362001)(82960400001)(8676002)(8936002)(6862004)(4326008)(6666004)(6486002)(478600001)(44832011)(6506007)(41300700001)(316002)(66556008)(66946007)(66476007)(6636002)(5660300002)(7416002)(6512007)(9686003)(26005)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vue49DZfrY1FpKud6gylr6+VlRvZ9RNLIPujJEOY82I1BT240Oqn7jL7gPd?=
 =?us-ascii?Q?9eA0lIZtYsNgmMgaXULPOvmtG0dIbKx4CcVojtcGsCieTz7q1Igpw04GkpSr?=
 =?us-ascii?Q?CofiQWt1/grSSAgiTQ4QXEKcviev41bkh7jqSHmeCh4tneu6t4SKrSWEpmq4?=
 =?us-ascii?Q?4hoknrX3GrGyKQA/PXebHXdOosGS/9yHPAjF2cRGUTTYjXVxIQRk0nN9kZ58?=
 =?us-ascii?Q?17uU7iF0PKXvf2LBQJ9wRrYhzhceGiqREOOITIsfn05qUiBI/iVfq3mYGr/N?=
 =?us-ascii?Q?s7oEWfYVEuu2avpW8uerqu+jeT5RdWCxxx5JJKBPZPI9iQH299sEj0OXf3gi?=
 =?us-ascii?Q?Y+CmKKG9eshBiyBkTZ1bheh+9TVFJpKeVXr/m+ie63jZQeJbjFhnjrYlhRpU?=
 =?us-ascii?Q?KvxthD9cXj6QJ6fVqQhjRUu8VxrR57URr3gkWxfr5zaSSLmXXm1uWfb6lVhq?=
 =?us-ascii?Q?Ym/yPc5Mv74sJHPySC6bCsPMr0fPYsVgNVQP6d8cvhqQhlz67xVLIhOs7cDN?=
 =?us-ascii?Q?eYxUKvp2ELnDm+XqOENBZwlrOyXOvpR8wVLNZCkPPQe5MjTfVHRXYbG+xPyY?=
 =?us-ascii?Q?mXR2ljJm7W+TB8P4UhB+LS0hxzETMbSUSsy9Ru4G8HaRYzZKb86i6Nm2of0X?=
 =?us-ascii?Q?jQSolhOubIcIAkeqV9wsod6pZ/6TnscTHcF9gP5WI7KbmDWHJ0MFpnW6IrCC?=
 =?us-ascii?Q?ivLPSkImkk0AOMr2rvAoE+HjTbVtq/JJKdYtk1sWZXp3coHJhJs/oHORKTsm?=
 =?us-ascii?Q?wUhsNbc32M0jYOCQJBNetV/eBT7AY9nT9X5WKHF/RyR3IeheR7brUpFdEuBw?=
 =?us-ascii?Q?Ze5JVa/zYj3u54Q1aEOB5OKzaLRIed4SdvRDT4adp4i3LzVnH/JJLdKCyTqj?=
 =?us-ascii?Q?rquDOkM4zZWC9+iHnUGYSHsoVNeyuNV8rMlm1VRpF0tcn1sdy5ipMQW0tMv6?=
 =?us-ascii?Q?Cro63B7XgvwDefG/QpzhZITfclF2m+D7Z4bM6ZWn6VaT42WhTh/CBzt/woZK?=
 =?us-ascii?Q?E5Mv3RNwx6Wo8yMkKttejG0PBS2DsuWiDZzbgTmoMWIlkOXwbuOEsHosW3fi?=
 =?us-ascii?Q?k1pY+TRz6XrHECz7iveRjvtueYVgY4pOmV5qOiQSbjdtu3Il4tEwT7Cc0tOF?=
 =?us-ascii?Q?Gs9vi9bR+/u6y4ChTovZ/q+7ewUrjoR9KLGZBikfQeePp8iOT7+vk30K8wZL?=
 =?us-ascii?Q?/g8GhH8KZbckP8kFvUg7aSFUz46Ovap3YerDozc/PyYmP2WFDiIQWMznFKru?=
 =?us-ascii?Q?Pk5fJpMwNnAV3fh8HevQY/ZksouWV9eakKjBAkacMAxv/S3gZ0TdBg9LhhKX?=
 =?us-ascii?Q?QFyguyCMhwu0NGGN/dkXAI0zLDNKA1AGmfNfXyqbDSQFuX8WCUaIbmaUQHQD?=
 =?us-ascii?Q?w/gaezQtfF5ckBXpOBGaVdmsTsIYKm5hSVPlF/5Mf6PISUXJu2hWcaYJ4XHi?=
 =?us-ascii?Q?i33wx3zIIaNfQ40GauSQyOohhH+kZzDzJEdX6sORQuVeKSGUQBCfYHcDKQ1d?=
 =?us-ascii?Q?inWFP6s0aixpDW9e2U6EYPs7o9Bzb3idKaS2dE1tjdOmIHrmg+tDNGG/7D8g?=
 =?us-ascii?Q?JgSqxhDkEZNcYzLpLGsDpG6FY43m6TX9t4Sf2buY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1e7a13-7412-43f7-57a8-08dbe41b1f01
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 07:35:35.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcdnCZ8yuQFZTLr6wfGX9Rm4Au4FB1HL9JwKzQ4fNeYGWA0568tmHzE52JdkGGLtSiMrGPE6Vn8yW3RMoLV1oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5429
X-OriginatorOrg: intel.com

On Wed, Nov 08, 2023 at 10:29:51AM -0800, Xin Li wrote:
>Add kvm_is_fred_enabled() to get if FRED is enabled on a vCPU.
>
>Tested-by: Shan Kang <shan.kang@intel.com>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>---
> arch/x86/kvm/kvm_cache_regs.h | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
>index 75eae9c4998a..390643e8c532 100644
>--- a/arch/x86/kvm/kvm_cache_regs.h
>+++ b/arch/x86/kvm/kvm_cache_regs.h
>@@ -187,6 +187,16 @@ static __always_inline bool kvm_is_cr4_bit_set(struct kvm_vcpu *vcpu,
> 	return !!kvm_read_cr4_bits(vcpu, cr4_bit);
> }
> 
>+static __always_inline bool kvm_is_fred_enabled(struct kvm_vcpu *vcpu)
>+{
>+#ifdef CONFIG_X86_64
>+	return cpu_feature_enabled(X86_FEATURE_FRED) &&
>+	       kvm_is_cr4_bit_set(vcpu, X86_CR4_FRED);

FRED is enabled when CR4.FRED = IA32_EFER.LMA = 1. Any reason to omit
the check about long mode?

>+#else
>+	return false;
>+#endif
>+}
>+
> static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
> {
> 	if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
>-- 
>2.42.0
>
>

