Return-Path: <linux-kselftest+bounces-8428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3D8AAF74
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCAD1F23D7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9432129E93;
	Fri, 19 Apr 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpgAz0KL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A336112838E;
	Fri, 19 Apr 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533734; cv=fail; b=U93rCi5YE07FMCZbYMdkX24ZSXEzmEfO9SBEOq70McFfPjEIVvo6eRFmuc/ZALP8Dxajm0KNhsPJ4dOQHUZcKs8FBdd78plZKidDQ+6bcBZ2rapfFQgiRmuZ7aX/cxkiA86VhNXMfi5O+YtxZsmguT2crn3XL6eVBT6WbX/N1iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533734; c=relaxed/simple;
	bh=+RP/PtArGCuOLd3VW1NvlqgUBuiW8084IWPqfMdv/n4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oE3XWmSnv7l1Tz18EA9NWa7AdfBx0cawHlcaLWqEJNoIIqlHyPrgu97kMvK4yugtS5lyJJ+gO9mAvf/P1016tnD4oQjVKzNwiLb3FX9hzcrmElzGghPUHQBPWoC7NKFDV93MqPzNB3GQdtWh+jktO2NBqo38HzRdWH6i+ZM6Egk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpgAz0KL; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713533733; x=1745069733;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+RP/PtArGCuOLd3VW1NvlqgUBuiW8084IWPqfMdv/n4=;
  b=TpgAz0KL82L7tpwzABpM8ia+VFoQePaWhyS/PrvoReNsgdql8L42EW3l
   r0kgYP1aR6U7Xq2+AdxwZuPjDXqEPaimiNg6sqd0sZbkqmcSsZ/5c9DUB
   bVwsShYWfsk38xu34ramOMdnBVcuHiaBu6rIrUYOid92y5r7fKkrwyPOX
   gtrc0h4V2K30oAKMnptPgNQHMwQydUQQ7K+4z+ixcDVXWwm0sZTUxc8pV
   DgLS1RGVXwTFe7n+tio8yi1UtCqBCrJtQbAbA7bsAUjr8DSG4PaEC0+HG
   xhKNkcMVpl4mwwfZstUiDUqEVzSs7ijwiXoYnwEbXZ8MVwRVINlyezI/F
   Q==;
X-CSE-ConnectionGUID: zfcQylpwT6uMepONyodhQw==
X-CSE-MsgGUID: WRa4KtOLRDaLFx+0hlqw7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="34532896"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="34532896"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:35:32 -0700
X-CSE-ConnectionGUID: qWWx68hJQQqD0zktFF8syQ==
X-CSE-MsgGUID: 9CgnhjPaTX65/SlXnMWN1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23313859"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 06:35:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 06:35:30 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 06:35:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 06:35:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 06:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ujwz4lGsHxfPuqrGURYizqft/Vrvg6iFHOTDNx7nloJVj7Fwa8zVj5BHvAKpXdGButN8eKUgl4l472HBxXXcyw71LDRv4ZM0drTlImuagkkWnMPOLp3CtRemG03ksZDYCdW6BU5BsXP4Z0Vh20sbyAWex6pjNzIXqE+gxL95zlM9reGx2lxoEg1Souxj+pC0Iu/t7+Xi02K7AAHc5Tb7Jd/COazNusiKi9HxASC4izJzklsARPBv+AEpjthMA4i7uHE62fm4u7dK7IIQmMpA6Ax0MF3yptn4CYN36JkxDDoF2oPWm+sBs/vHuiWMMYF++OP5+ksno3OoL4vluriFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs6C2LGD/GCbcJ1qHMrqk/5Wfl3vm6ihReJYsxVTVwA=;
 b=S6uXe8lhwohiKqZiKQb+UgXzi4h6F68FQUznlV9AemmhJofKanYXUxniQw75GkgR/dOzf9o4NMrTAJeMWH/3qfjyZiPH/L9SCjah3FfK2Mh8p4Gp2MmTSyoo2jKBDpO56t9nRYfDAAqv4qarUSXGOaOFhAZM2gnCNngDWCWUU9DWZ9gayg83drSTnD/Qq+Mp9XZ2z3iLcWmp2AxcptKwOt9Cg3+Z6comZ9pdQLVj0UypRI3kGK4dnFda6/SWXKVvmJ5mXfVW5sdA68emHOimeuLXRaGvZ7yRVKUeaCJB3HRSmh7CC34sDeL7GT9dB5uCULEpVTzumWe+1h4P8TWYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA1PR11MB8099.namprd11.prod.outlook.com (2603:10b6:208:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.12; Fri, 19 Apr
 2024 13:35:28 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 13:35:28 +0000
Date: Fri, 19 Apr 2024 21:35:18 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <vkuznets@redhat.com>, <peterz@infradead.org>,
	<ravi.v.shankar@intel.com>, <xin@zytor.com>
Subject: Re: [PATCH v2 07/25] KVM: VMX: Set intercept for FRED MSRs
Message-ID: <ZiJzFsoHR41Sd8lE@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-8-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-8-xin3.li@intel.com>
X-ClientProxiedBy: TYCP286CA0225.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA1PR11MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e707e4-8fd7-4363-77da-08dc6075938a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: vOMhDwXiGUUXtDWCfgl6ow6sllxFsDthy50vAkY3Aa8XeZFWonUUoVNk4c7T7inJlOgmaml+sc7cBg4VRuRfBUCMkuVWYrna/6i4uJz6slITt/UpXUZ/4v82uE7DZexFGNV+6Yu9mdjWJt61+W4qNAqismXJf4oQrTGqW77sXoCk6HDU+8HCV6m6mV+4JBTUtvXOjcmiglaZkd+HebHz4WM6/p9YpNML9pBvAxIoq80vWZs0Ch6lN7Yezguh3jKk+YvWeDPTuppaNrgoeTitl6X7fbV22/0If2yeHmvDT9Ct2QynTbgsaEUaxx8YtbuEA5WMxt7/w+24pumsWPkXIVcTlBjulH0L2g/n2rd/QZBuHFxdm4H9tpONy6n6O6hgAbqSXolQ+u7b4bwF3cX27qwBVkzEttCKAUdhMqvR00GowiIxTeLR1dk6lxqu+xmHQWrLpONC01ecsVD/J72/r4NiDN9tGiHaE0GnIHp/ERTI4odSKppTUp9Td4Bcq6uMPUPIoHYMc3iuUn0A+YVWpiDCz+/e7RyBtUDvdO9szvGewxQ+GpYykybc+WWephzsUvBtA8xuNOcsDLsDF1J78Qefe/jp0GD3zZuoNWDj0UXmr0Lklw8JUCt3q94IbZ71COpAnwQlEdKv71VQpkSKOgH8GRN5GLw7GtoQlYnddbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XjeIc/nOl42JLJQEANKULSpDtZsPHcfOZYADUbbIg7GIPg4MRM/16uYwYtzT?=
 =?us-ascii?Q?IT1aRAK9pgzARLN1Y+kF1mBeY0NGMf6Nwf/Q8OKvn//FxFEPF0z0Cwav5bWG?=
 =?us-ascii?Q?GFdzSfQm96AM9S2H4yvPvJMIPImYaMtcV09j/iIyU9ORbQXp0JBLWV2OJ9co?=
 =?us-ascii?Q?0hscreJ0kpxKz3sOZuj3iBK9vBpiZjgu82Y2F1jt2pHljbKKZJJMIblVhQsG?=
 =?us-ascii?Q?x4u0D86lWZ96cVO+uXB/yDzhD7p0YeY6YLmWoDoXO0n5Xf+XO9czKPOC7KGs?=
 =?us-ascii?Q?Nf/w9Da4cX05UqwcuH8B/OXYupAcFDxAttcvOsI3Q3n5zBXntdtHxSPVC/0O?=
 =?us-ascii?Q?NJvqPrgcq8QLXmCyYJzLNmAl7oDIO03JvxRu5565eWpoRDgAu2n6XjrBWcXP?=
 =?us-ascii?Q?PkmZ0TeVo7Go0uv/FjUlGyp8s/DLVQrPVfvV7EKwOwhaRbmhnwJ9QBliBD2d?=
 =?us-ascii?Q?Vc1Hml2I7JrQqDSn5lu7GuhxdKRVAz+7XM8m/jEgwwRbfg0d4+Sv5QuFJXQC?=
 =?us-ascii?Q?6RRhbNM3iOTp84isSjnTnwt03PJEls8rcNaK5+nYLrQuA9zndWTAGjXVPTXD?=
 =?us-ascii?Q?ItAcIfcfKzQQ98es7xEdCgZvXBnOkSBO/bO+eFXf0M1yeMDDzlP/RrXh2fJe?=
 =?us-ascii?Q?++IkcMXPmPjZ8JAUxl9SrXTzFLEIBaeQ0qbUgZnnBUfE0ttSC4UPRSxzthHC?=
 =?us-ascii?Q?9g51KEDHMMOwFAmGW2xB1G6Eb8UPkZ1V47yKOaqtWNaSTBKdgDw1cQQKILLq?=
 =?us-ascii?Q?A+A5x8TFPD0ZE47V3mnYIbmmpeWBkz6W8reaCbiA9EHLk5jkuuBT4OreFBYI?=
 =?us-ascii?Q?7hl6YB2IChsho/dO968vc3pfg00LGLPITIfpKQm+Mfv9jW8JD4gMaNzi9M1+?=
 =?us-ascii?Q?TSIAxw98Bo4yMErs9WhPuL4kMpE/wNLHWgXxPiRpOHeAOiVFM2OaBq1O4N9D?=
 =?us-ascii?Q?Xrord3wUUJntmU7YsW/OByYhm0LzoyZjWOaN+I74LLOreL5+aopKuDyBzv/y?=
 =?us-ascii?Q?OV4UiNmUOwpOBh/X4BHX+E4W4eQl1X9T9bT7YUHCGlRZD0f1PAB+oq0oe0BT?=
 =?us-ascii?Q?YWI+OZ1knI/mmwTuLARZZFP07pU4bWvn4D5R475I1IvV5KHaQDqtcFkX2j4D?=
 =?us-ascii?Q?NmQQ8OFzgL5iNTefHUas+HZI96sx2pBo5o/rQ+IRYMnWubhpTSFQmtTs1sQQ?=
 =?us-ascii?Q?mi17Wim5GyIFfR9Ze0j1sjg4Og9ryVH1RPQctdHDwzHd6Lf5LmNoeNgtQ0U3?=
 =?us-ascii?Q?Nvg3FC2WgW4tIcj1f5t1HSM64U4I894gkG50ditN1jDfeSu5dfIaRU0QvV3F?=
 =?us-ascii?Q?PA7+O7pUu6nOYEmA6rOxuVH8yqOXfXrr9Xzs4WL5PR1mFr0SHvTNh81oazox?=
 =?us-ascii?Q?2NaGb9toQlFeDlQm+p6uBVvRTkCZwa3pTfZWGqIaiC0iVG8hwI421ffbcDjx?=
 =?us-ascii?Q?nPW9euoVf5eSpFFCzVxcQQFB7dDtVI6Z9MFbiYoH6q+V+7INNGhh1B1xhlGq?=
 =?us-ascii?Q?pnIwO6D2XAHuHBMClGGQksvWU7tqwS5kw8Szb1bCSkKWrI+4MFXk+nFr1h7Z?=
 =?us-ascii?Q?Dmx0bJdVowjsPmbK55zz8/BpsUpWhAZiKQldvx1M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e707e4-8fd7-4363-77da-08dc6075938a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 13:35:28.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0o3HKwfTGGCpujbHvIApQRwktDAU+SPwhJ+fzZ2w75xqsLHnP8LKwUW6aftr1TeDAQEXj4NY0dcKk2Oux3VXKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8099
X-OriginatorOrg: intel.com

On Wed, Feb 07, 2024 at 09:26:27AM -0800, Xin Li wrote:
>Add FRED MSRs to the valid passthrough MSR list and set FRED MSRs intercept
>based on FRED enumeration.
>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>Tested-by: Shan Kang <shan.kang@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>

two nits below.

>---
>
>Change since v1:
>* Enable FRED MSRs intercept if FRED is no longer enumerated in CPUID
>  (Chao Gao).
>---
> arch/x86/kvm/vmx/vmx.c | 17 ++++++++++++++++-
> 1 file changed, 16 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index 34b6676f60d8..d58ed2d3d379 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -693,6 +693,9 @@ static bool is_valid_passthrough_msr(u32 msr)
> 	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
> 		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
> 		return true;
>+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
>+		/* FRED MSRs should be passthrough to FRED guests only */

This comment sounds weird. It sounds like the code will be something like:
		if guest supports FRED
			return true
		else
			return false

how about "FRED MSRs are pass-thru'd to guests which enumerate FRED"?

Or to align with above comment for LBR MSRs, just say

/* FRED MSRs. These are handled in vmx_vcpu_config_fred_after_set_cpuid() */

>+		return true;
> 	}
> 
> 	r = possible_passthrough_msr_slot(msr) != -ENOENT;
>@@ -7774,10 +7777,12 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
> static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
> {
> 	struct vcpu_vmx *vmx = to_vmx(vcpu);
>+	bool fred_enumerated;
> 
> 	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_FRED);
>+	fred_enumerated = guest_can_use(vcpu, X86_FEATURE_FRED);
> 
>-	if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
>+	if (fred_enumerated) {
> 		vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_FRED);
> 		secondary_vm_exit_controls_setbit(vmx,
> 						  SECONDARY_VM_EXIT_SAVE_IA32_FRED |
>@@ -7788,6 +7793,16 @@ static void vmx_vcpu_config_fred_after_set_cpuid(struct kvm_vcpu *vcpu)
> 						    SECONDARY_VM_EXIT_SAVE_IA32_FRED |
> 						    SECONDARY_VM_EXIT_LOAD_IA32_FRED);
> 	}
>+
>+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, !fred_enumerated);
>+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, !fred_enumerated);
>+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, !fred_enumerated);
>+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, !fred_enumerated);
>+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, !fred_enumerated);
>+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, !fred_enumerated);
>+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, !fred_enumerated);
>+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, !fred_enumerated);
>+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, !fred_enumerated);

Use a for-loop here? e.g., 
	for (i = MSR_IA32_FRED_RSP0; i <= MSR_IA32_FRED_CONFIG; i++)
> }
> 
> static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>-- 
>2.43.0
>
>

