Return-Path: <linux-kselftest+bounces-76-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE67EAB6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 09:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9946F1C208C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626A713AF4;
	Tue, 14 Nov 2023 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzDI3ZTo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8D14A8E;
	Tue, 14 Nov 2023 08:17:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A1F1BE;
	Tue, 14 Nov 2023 00:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699949820; x=1731485820;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z7KEnU35348Unr3e5+DghTW8XI+Cs8R8R17LGOXybk8=;
  b=fzDI3ZTo7GEbvgMOAXpe1dZaDXD01tLkY+MTCNWAA1lbNXJbTSo+sMV8
   ZTELrT2WaWdbh7dF6IfPZa9NDywinGTfKuNJCJjUxit5leeFcg1zVkf8c
   VfFVXvLfPS+/xyTkeMePGes8KfP6Q1q+d2+sk7BGU0ctUscJbE7yTas77
   u9w/aE9Uh8NE8XSDVj+ohjaloMqPcVn8FGtqC3FtaiJ7SgZFOz1Ec3Zdg
   uXDv9Fp1U9wkzRHSd5XyeRox1yB4i9MXlpGSG43GBzqb1oRLNeZxWKMdf
   MV7yst88WDwFVDw3bAhABKOeq0/GGlMatT8pSk/CDF0ol8EkspLQLHEOG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="12156186"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="12156186"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="908280583"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="908280583"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 00:16:59 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 00:16:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 00:16:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 00:16:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 00:16:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX2KfH6FsjTIn3HlplA843HogB3n8vLhXfO9IoW9W7QytWSuZndcC1qmkTIpyQIuc7//5QN+K/s3sPAgdg6IWrMXzTraRM86K0SYeEr0751gFrxN63Tljk0yEuh61LPXOiWu6w9rS5sOwGeCK/opqNysujkN23ZitGi0d7MEgzwwHADXgIFWMgs+PONkjSpxoVsPUSAp5173Oz6xOoPxHlVTLZUcNLhTVWHQ8XdAqq1n0UT1S5J/NXV3/VJszClNLmscK8kSecd3Iyvdz7m/CRpgW6m91aQSlHM9RAf4ioRs1l8Mnz9Ma+1bYyZpIxaBAFve3MB2i1aWxO00WPDr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDYpyh/H8894Rrr2DdDBmHRFRQ3/a8rOP4Pdr10pYiM=;
 b=Pfos51/IfSszN0unyBmVjw/ZrHhvSwfdxZz1Kzs7gS7JaGutPvoij4niUnMCU7bhIejBW0t0tn8KBtHoPHoRGCOFBagEt3vNugcjSwgTrhOa2yDTfoJhPga37bnuLX5FMTh9msG5hBFU91QpbR/LX+JOoYLj0+c1c77e/RGrU2UJZDMeRLNYzjcE8Wrk6sW5LRt1rWdf0wHhTR3U/n9CYlr6r34Tv28Ld2YjpkFpc5yWznwKYn6e0kWShnGwmy1xh0ZcktY9cwnYelHpcc4in+brvQUoMA4xaMi5VUYZlBjutDFG0J5bNZ55u5+47NrKGRIatlRHELgK1vEjoIRnqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 08:16:55 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 08:16:55 +0000
Date: Tue, 14 Nov 2023 16:16:42 +0800
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
Subject: Re: [PATCH v1 11/23] KVM: x86: Add kvm_is_fred_enabled()
Message-ID: <ZVMs6vZyoqd2cUiV@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-12-xin3.li@intel.com>
 <ZVHRufhNmVTvJYWV@chao-email>
 <SA1PR11MB6734074A2E482AF6F911693BA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6734074A2E482AF6F911693BA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SN7PR11MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: d7808bc0-ba95-4745-e037-08dbe4ea0fe5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9ZHjtGKDcxBJISDFCvtl6b1UkM4x6CrWcrqsSwtrLasCTOY/7UXd81HSLy+Hq0+Pjr2NXjhSHmM8G4v2AsWGTroCZBmDovXsqtsMylmYrvOYRf28p6oYxql4lI8bBDwj9Lgz0jO9CKFRJNI+5bn64Z/cbfVfsAuNovAPb+36cARrikqJqxY5MpLNQPlV4mRIW64b2scDV/XwXFsea4Xym73GNboUVRVGZ7h9e1uNNnmuL1pBsjMzIcl2TMyY1RM3Bzdjgj0AcOCjrq3hKuS995mFD9n5Uz+wDdIvEPn4br2czHoKkYK1LqS0D2d3QLJDZ9gE1o7FPrhQyM0BErAvQh9QPwKFq0bM/QapMHYmei0F74FJXLzJC89tdr3aDXwNRH9KG9Wq8bj5t0HSjNxqLbnPRRVssBUFtiNLTgN1rTjb/+nCo1E8DwF8jGmyewgPzwXIzuo3nDuOYdywLppZGYq/Giiq7FdwjK/G9CzR1usD/wOA1zRb62teb8H5qWnKfmImwkIvcMgX7GcwZtSpD9aJJGAr+AGy7WRPyg39y4ZFoIBYt2jWsOen2AztQak
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(44832011)(7416002)(5660300002)(86362001)(41300700001)(33716001)(26005)(82960400001)(9686003)(66556008)(54906003)(66476007)(316002)(66946007)(6512007)(6636002)(83380400001)(38100700002)(478600001)(6486002)(6666004)(6506007)(8676002)(6862004)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EjsZmtqbUbYNY+SVSiWnvVrV/U9xn3/ZHeERxoLn9FtvRhDI6vJrZyawtX30?=
 =?us-ascii?Q?hwkchTVvgr05fpM8IkfQwAQK/ODMpuPUd2vXZDCe3rTBY8bS1XyOxG9Tyu44?=
 =?us-ascii?Q?wl5JUYcjZIc05Z5YOxPWOgVLWTyOh36enU6wr9T9lVblRgXSO7spCDP8/Apn?=
 =?us-ascii?Q?TZKOPCmqiSFUVfucn5nwoDNoG4plGXxtzblHzxVdEJOgaGE3WnsnDQIyaiUR?=
 =?us-ascii?Q?QAZT+qunlqh91pat2ZKMV9oHBJ9fs6izx+HvviKNdtdX2FU+ZC1NQHZ3sE2H?=
 =?us-ascii?Q?PF4wUFMAeZ/BBshDMCPiBgDEChfo4PjZwYDrKiP2TNmlvMWykb4GMgz3lx65?=
 =?us-ascii?Q?VtGK4Ld6UT4ebX25OPL0tHweGWc9DQoCx1jJV6NozTJVaEPB4NhFwUB9BpYI?=
 =?us-ascii?Q?6efUFnucj6JGfIHcdhABWg/zM7rpbVVOS4LiTx3HfUJZcPSioU5gVWUCcbDI?=
 =?us-ascii?Q?BkBy2kOwkpmkHFBle/7MjkaQ1xMFXamq08dphFzaumq4rzq2s6m0/IUsb2dq?=
 =?us-ascii?Q?seJKwuaM2HCyVc/HMUX66s3fV4sjxAEcl4qxLkF4skYEHkeomBBUmw5Y9jFa?=
 =?us-ascii?Q?EoKwGICmbDjroCidIX/iA5buKZURW0u7cyJJUfgyEuJxLDqQxdqsjoiIseUp?=
 =?us-ascii?Q?i2kDQNy4QHUBtxVUszU9djS/gCsIU30F8UQCt6a+rmSEKM1H+rU89jqH4BJJ?=
 =?us-ascii?Q?FhHcjLeYD0okfkhQdcBa+F/ORBQLBsxIzxwL6zdZRAsgeJtP0nCjWUeFegf4?=
 =?us-ascii?Q?sa7xKjgPu4ChXCAjEcopWJQ4xQWq4GE/t9/RT6ZaZUXs03kB8RTfiEpdC+0w?=
 =?us-ascii?Q?h49CYjFkCRV8KSeta57mqhEPTllO7L0DQVvxuO3TTsNxFA70xFtczvofPq58?=
 =?us-ascii?Q?sg2zThye3a1yRO+fgyjH4fLG+cWjlyf30FqviYThBbYYKUd16wp63FbHdWZr?=
 =?us-ascii?Q?uMUxqK9cn75i+gS6OdmlNjg7uFT6qyQcZJAe6lYWtm1lNspCt8MZQ2dih40K?=
 =?us-ascii?Q?9Wvh2kYULHMtqVsyHimU//4jl7gbB7sO7Khq2t4kZWYkTGvh4Bz89nvsuZFM?=
 =?us-ascii?Q?UiFVYVbE9jg0H/4ncSWwaGLbhN3DipNsTAO0H8R7Dfyyh5TFsx4xWTTubyTz?=
 =?us-ascii?Q?7BNHAbztX8DS1YMGH7CtU08vj8JMOVq1qSg629EJ2hNUw/S6Oo52hvKQrxOj?=
 =?us-ascii?Q?aZCxdo+KzyrIU9t7gm1nX1YYWNdmIyTMB4TWGHSl8sP6Axkp99QAZu+KorUR?=
 =?us-ascii?Q?aZf0LaV+1v9EhN0UOu/62WOf2nx0sXR9tuJf6mM2nmBs+M0OACVTCrpNqcjW?=
 =?us-ascii?Q?vHgF3SQgRKpI3ccSm2Hb12e2BCxiTDuMs3FTdPiVy3DTpEjJe+mKTustQwM1?=
 =?us-ascii?Q?iVfjVAy5+uZiu5wGk8Xp3UpKOYPOFKPWviCktYJ/cHFF7W+BxQKR5jJWQild?=
 =?us-ascii?Q?Fo3RkZTmu27asRhhF0AOFBxWfKiWCP30qUSZ/89gJ7+/2bcoWsAbbXmw4U7J?=
 =?us-ascii?Q?BhHrruIpBRgePMuJrwODZQZRUf8pueAvVWRiNujRxSU+g2W7Imlu2RkJpjx3?=
 =?us-ascii?Q?i7+B8MNj3SUiOuLuc/ipk7njZgCICPETPmOOpgGL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7808bc0-ba95-4745-e037-08dbe4ea0fe5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 08:16:54.8792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+ia73SwV7XQYyctD+tgrJACrXnGKSueUxUhsEEfOTyK9jFE4zGWZuklgZDAgH/+ZRGcHDvCmg7YtLN8v79pYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-OriginatorOrg: intel.com

On Tue, Nov 14, 2023 at 12:42:13PM +0800, Li, Xin3 wrote:
>> >+	return cpu_feature_enabled(X86_FEATURE_FRED) &&
>> >+	       kvm_is_cr4_bit_set(vcpu, X86_CR4_FRED);
>> 
>> FRED is enabled when CR4.FRED = IA32_EFER.LMA = 1. Any reason to omit the
>> check about long mode?
>
>It won' t allow CR4.FRED to be set if not in long mode, I don't expect it
>at runtime.  Or you have one?

I was thinking about a very contrived case:

1. the CPU enters 64-bit long mode and sets CR4.FRED
2. the CPU switches out of 64-bit long mode

and SDM vol3 chapter 2.5 CONTROL REGISTERS says:

A 64-bit capable processor will retain the upper 32 bits of each control
register when transitioning out of IA-32e mode.

so, to me, it is possible that CR4.FRED is 1 while IA32_EFER.LMA is 0.
and in this case, FRED should be considered disabled.


Anyway, I think we should align with FRED SPEC. If we deliberately omit
the check about long mode, please add a comment to explain why it is ok
to do that.

>
>If you are talking about save/restore a corrupted vCPU state, a following
>VM entry should fail anyway.

