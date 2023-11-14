Return-Path: <linux-kselftest+bounces-75-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C258D7EAB14
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 08:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4DEB20AC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BD125A2;
	Tue, 14 Nov 2023 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B11K3XnB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B68D11C8F;
	Tue, 14 Nov 2023 07:48:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E762CC;
	Mon, 13 Nov 2023 23:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699948087; x=1731484087;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+WycadlpkAunAkV81grEErTWpZoFNwsA9cwidzBUpXk=;
  b=B11K3XnBFFpfdaDUkwBsyDJLCRqAIAqW0XGmlqvoekvlREmNxTjcQkSi
   VPJoA99DvvY1+x/c3//b7Cm7xlCyPV3oMFf8FXp7/jqh7GPp1MuntasDd
   rqZ5DrztX3gNbkInT48GSrrQF7Tc+H2WrAruUJglaQtLpgrlYTT7I1xzR
   qTZJ7MtY7x4QheG30LvlfcwggnFx57+TCJKUuFMEZrdDk14MgtHTjds2S
   l1NNAj7TbXhWozi/HAOpc5/JONHPKNzXHMcx48rx1LWM5poFH0/6gzcqD
   bs+Mk44rjdhp8y4pP4a7Q0rsvTOisCkfiiAfYwy2Y9Wx7pNStPmhCxyys
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3705489"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="3705489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 23:48:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="793699032"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="793699032"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 23:48:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 23:48:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 23:48:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 23:48:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqtN1U15DHUQckdYWXATXkP1zIfmj6GqHsnKKbT79lrRbka/N9A0JlWe1YqToryEE/gZ75PGifJI5qND6l7h5Up6OG5dTg5XbD+/SbN45JsFdDFSpnA4F7FEk5cfAdsM2D8mkPwrVd10UNccNtVJOn1ks+5JhfrcGyh1RDw8voZg+n8C64oxeVMs0zA8E2xKsrhkTKs3lQQIfKauldoI9feGbAjxK3IRk3GCPGA5suA0OE+u90Vio8fVa0e3F7eAmmdwFP2WBoa7oIx0pt98mHN0g+5qWL9Wg6y0hy+48MxzNlAm/+fTiY92sFgxuhjuI51Bu5WUXElPALBSwOD3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBMpb82SZN+46nhvx0SS8MaMb2QFKOqQViBRPRYa92U=;
 b=YW3QWxIoER4cA7+SqTk25uvfF7C8a59vwsTUad2efOWpEqEAeBgD9Ir+akjumBe+bu8qOfGSUhHxUHqiyGPYrzO11QHn/yrWUaClUFyAb10xEa0HMf3FkCldmNLqqDVvGtKH14ukpXiUE/Y/vNgo+P4S9NgRy5grPKtBhniTIb0otOV4egKvgyhVDTa+o15aoA6N6AlAMW+dHLsliWrTdQz7yDa7EpvF1GRAsabZQtzl08KpKGmglEeHI7OCVkHvLhYYFGO46hjI6S8CvkczpN3M7TL/R0ia3SPXpDSPhxRYxesTn/AtWtXN92rKKzKiPA1pJtpNwJ68kEcUuTSB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 07:47:58 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 07:47:57 +0000
Date: Tue, 14 Nov 2023 15:47:40 +0800
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
Subject: Re: [PATCH v1 09/23] KVM: VMX: Switch FRED RSP0 between host and
 guest
Message-ID: <ZVMmHNHadleJfkGL@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-10-xin3.li@intel.com>
 <ZVGcaxYtabZxGt0s@chao-email>
 <SA1PR11MB67345297BC929DB49B422D2FA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR11MB67345297BC929DB49B422D2FA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ae48a3-bd67-4310-4ba0-08dbe4e60479
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nmmg+MHrJrkVM2ri30+y3ULwzXxTix8vFI5eC4LoOCsDfeC647MnJbn/KL3wPL01ddPZigl+1roGi+i+RhHZ4BrH2gO6ZITjW8P7SzUhyDbzuTXg0oc5QBcdeb2blOVFbWC22iOq8M1LHQYOVBgKW7Vr93wAFnUhvJdIBGuy+qDP0jnXXVkkk5mPbToTQ+2KPxGnyStBcOKKOqkoYOujaHW7EvokJnovA0+4cDZ3av1ELbfY2E4xgEEwyT8BHldgdS3gal8s4MJIrTvMs7zMoyN6dw1cEI9fU2v5x0y/o6QZIzzMadqXTqyIBWNqKly39z5DcR9rnfMoeawsNrIwplQX9tlvXXlMvzhQqvGnkLYmahAXF/5Qy665SuftdamEyjO8tfBcIn/AH6ubrXTIKxitEFK6h8zk5zXSzLCq9kA3otqrbZjjgoAiboNXb9PPQ1tsQwLsWwxVudE2dbF3Ft0iXR1isCCUWRX2MB3n/YVZjnov8Ank+7H6VvdCUB7SoOp5qRVpmr1uweyCrD4PgEZk07rYklvOA6S5Vw2O0fHmH1hFrJy+V3NV1Ja55BaM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(54906003)(38100700002)(66476007)(66946007)(66556008)(86362001)(82960400001)(6512007)(9686003)(6636002)(6506007)(7416002)(6666004)(33716001)(2906002)(41300700001)(4744005)(316002)(478600001)(6486002)(5660300002)(8936002)(6862004)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JYF1+OHzEstiWUkIuYkFFISk9cw32nkHDUg08TluM3iGaqQUxfobofWUwUkK?=
 =?us-ascii?Q?zjsIydu6wnykt7P6VJiq0vIYL75kzBSoy142NTr7vuuPYa6yK/vDDjENXB7B?=
 =?us-ascii?Q?0p5x/XEGf625VR0qRth2P7SJEBtWjfMX8ePRWFbW54+vco5Hi0MeYI2vci5k?=
 =?us-ascii?Q?nN5xD/1i648S/hyXxeV09fy5tPxYLOdiVwLLcXy7WGIm2EaJrlVW19L4c5Q2?=
 =?us-ascii?Q?2d7ibsAm9f51twIAu87l/9EPP8Kv40NIBT7Fol8JqltZsd/ugWwYvdLzD6+k?=
 =?us-ascii?Q?aHeThs+a1EvmGDJS6uHv4UYNrrYbbL0aJKtSFPKrvip73P4NS/h9GBnlx9D1?=
 =?us-ascii?Q?tlr85vZ60MsuvDwk7mIXAyyBjckMSn61MYWm5+pONKQgUabawvNk1efiacrG?=
 =?us-ascii?Q?iDcTrLeQ9Q632eaf2iHKV2COTVOuY+zJc7J3XzPztYA3ZeTc2g8F72dmESYN?=
 =?us-ascii?Q?15BAvKMQkRCHr8ze95MoVuUr154wQs0eV17XzxPlWsImg3Zt8jFfpOJLEKK/?=
 =?us-ascii?Q?kz+aB6bdFff80F4obUPnKK52pkK8jSCZk9+lkg0ckkb9NLY3EyaHDh8k0jxD?=
 =?us-ascii?Q?L37EArgIp40C5hrx7uBvFCKdBDBM2Pm9rBTgxw4OvGDt6y1ZfuQBU8i8Jb8Q?=
 =?us-ascii?Q?/WOgHtwbyZiTaEqcyNctgwkfxbw+67MtKFrGXwXLAINs0H4GrUc4yRwqfELR?=
 =?us-ascii?Q?64CTP4BenmIPS+lJgbLPhw00vJu/MVmi48LQ9cOujd8bAwuXqfnEEKfv+Bn6?=
 =?us-ascii?Q?2YCiZ7txYRd3TaG8pj8dO8XB0pi2sC2fQWMDAE2bfTdmpar6vZOuKeyCuul7?=
 =?us-ascii?Q?pmK3FCifJ2/EpkNrC3HDYnnVAyW2T1yoZb8tMOK7YqWI99P5d+KxX4xXNQdu?=
 =?us-ascii?Q?ytB6vk7PMvM6MU3ZJQYxktVhQppzO/mUl1AMaXcc/O50J/AOLdjKZkbXxUQe?=
 =?us-ascii?Q?iWRE1BMtwDqdzLhOzHHqCnrVWW3GYatqdjcl3yqcZrb8TynxHicS1CX3RY8r?=
 =?us-ascii?Q?nRHQe5WuE1gP1Wlt1KT8aT8MtWy774wNQntU6WgGPP2Wz8Fxj4f8XuCI2+0h?=
 =?us-ascii?Q?SHK/BFObjIbJ62Dd+bxiowRl0udFJus1YL3KDhBPVsyvzhxSjo4IuBBUCxN6?=
 =?us-ascii?Q?k8d9jV5hXUXnpud9fhr4Qv5DjvKbVbrVFgW+BQq/nQaQISZ1WOFViZEnen1u?=
 =?us-ascii?Q?E9hrcLsT4Ur8SGLwzWbceX3prRmahoNo3tk9fJtFp3EMCtfvg8AwCBQhAY4O?=
 =?us-ascii?Q?IFvGi/c20PjLU/RFOD/oX2Gbht0TtCanNXtc5CnYQHzCfadFYg7BRsRp/0Ka?=
 =?us-ascii?Q?9OtL/paEBsrG5AW1plsOHAe7lt5GBYt6Sjf/SN6ngM+5//sJ/DubKvxxUjWZ?=
 =?us-ascii?Q?LL0boukO4rNVS0RybQlNlrMtm+65pHBFKreN4fQCZQ56/fCsr9K55wdFTiGg?=
 =?us-ascii?Q?ZK7TGrmYDd7llMempe9wBiqb8CeOxaH0NVxBbFFReIrjXPRq4onsHGmZC2Ra?=
 =?us-ascii?Q?LbbqABgQDLuDvnQQGWIBe/B/QxphjS583uFIv4eykXmwG3S0ic88nO4mv4Kb?=
 =?us-ascii?Q?sTeucCebXJiRTq4h0lshZ1JVV3deVBHDb/ZeIN+3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ae48a3-bd67-4310-4ba0-08dbe4e60479
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 07:47:57.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zXOQGWwmPZHBS44I+erK+2ROceR3i6afb16nGWPfDO14Pccz7dVI9usLtwzkXqVr3vtqUHfqhZmp+u8aZrSsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com

>> >diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h index
>> >f8c02bd37069..328a3447f064 100644
>> >--- a/arch/x86/kvm/vmx/vmx.h
>> >+++ b/arch/x86/kvm/vmx/vmx.h
>> >@@ -276,6 +276,8 @@ struct vcpu_vmx {
>> > #ifdef CONFIG_X86_64
>> > 	u64		      msr_host_kernel_gs_base;
>> > 	u64		      msr_guest_kernel_gs_base;
>> >+	u64		      msr_host_fred_rsp0;
>> >+	u64		      msr_guest_fred_rsp0;
>> 
>> resetting guest fred rsp0 to 0 during vcpu reset is missing.
>
>hmm, I assume it gets the same treatment as guest_kernel_gs_base.
>
>It seems we don't reset guest_kernel_gs_base.  No?

Yes. But for fred MSRs, FRED spec clearly says their RESET values
are 0s. for kernel_gs_base MSR, looks there is no such description
in SDM.

