Return-Path: <linux-kselftest+bounces-8430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A88AB002
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C11F23F04
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD6712D74E;
	Fri, 19 Apr 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ej2CyVIQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CF0129A9A;
	Fri, 19 Apr 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535307; cv=fail; b=slh2m1S2HvY1m54IqGKYAe8LYmzceNvfIV0mPObEqEz1ET5RLTWT0RaLMgf0RREi+Z/4EyBEJPeqBnYeVLJfmwlRAwrK0aw7LBTTHSpp1LYoIBCAed1kr/ulkTiN6mgp1HVDbOU8GECJHzsY61HXZQqv9axedLYJFn+RsD7wQgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535307; c=relaxed/simple;
	bh=q/weEkUYPiM8GS58HgSQ2y56RZpBQ+LKLPlRykTZbYM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q0szuyEPBQiwhABCUKgBgI7Uk/hEmxdhAs2N9lQtKHYNPfDgFiePhq9LDdgozaoFwOdUEhDDJVaYy4PrT034ln5izQPX+oP2zDHxd0iw5LrLrSA+Peg4forKFvJ6+xWVjoeRaAqRwz2ZREoD5idc8VqnxP7QaOHk3rFqbZrSC1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ej2CyVIQ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713535303; x=1745071303;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q/weEkUYPiM8GS58HgSQ2y56RZpBQ+LKLPlRykTZbYM=;
  b=ej2CyVIQLrfxG+xGxvbzg2+0NfteTkifISDpNaH1OCMxfq7R/Mn7/UrI
   4OsHHjXjMIvw8PozNgy22dLPnhYueHxTkNP7z3iMVLaws7ey64Db3gpp6
   Z0GucYc0n/8tPUptxOEJRNrKhpf6Czqa7iRq4oN4GQVjSCJIjAMYxhEml
   waKvNTeyYfIvRM8rarUV1yXF9wj50+ZHnH5lvRe0VBdouB52RgLz6dF8U
   WPM95egRbjhPc9l8kJOheQRKerZnRdSwUnAMaVUdfJcV5CAPyskQlePQU
   q9d0ySHZRFgVOzRmIjBk8tCpaCFThQO+7kB1AYKvttMHoafvrlQe1cve3
   A==;
X-CSE-ConnectionGUID: kvqfSsiFTuKYFH/lrt/DMA==
X-CSE-MsgGUID: YlEAMnKiTSmmjn6jX7zUWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="8995743"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8995743"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 07:01:41 -0700
X-CSE-ConnectionGUID: kKiTG2jtTteotj9hlZ097g==
X-CSE-MsgGUID: KoK0k6HRTwimLr91tLj5aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27882972"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 07:01:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 07:01:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 07:01:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 07:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afrWrsMveyNSfKmMX+aRlcAVX68ORrHm/F64gWBiFhcSRBmANWad4nOAp2ibHpyyAaUOPtq4scCR20A1hEFYrMcT4sWO8rEd6TLuSbWLNxBd6KnOqcI0NsD1dNwM8xxGCNUdZIYioqOOB21Kmk7fKm5Qqgml4V84nXdfSXMHUMm3cAnhg6caG6XKdowjMdy4KePDrHt1T4NMs65zhc5Mgc/zO2KqPED5K/FK0nB5iT7I8U8pbv7TGR7RELpwfs19DU3JOZ/0BxFxblysj50idGLspsnnOgA2DguZQ9DRvJLO5HbfpGb0aPlvVn7piObtDGm3eXZug//JicAvkRwmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQpcHUkwQrX/We3LpMMEDdlQhJpmWZoIb9SLjSM2NeE=;
 b=YbV/uriHQh5t+jfe6oZZjmTN5GDTP7DiUQOGj7nmr+7T7jaNJm4GX2VTb+dO0EZ0Lysn5tSs5y3brY0CMhgX7mJOt6izN6xwwqtmB2s8xHCmEQ2OVa2StPxKrQVS64YTTILrQOwfDvbkCARgrH3XulPogqbwoJQBcOVGpXGK6M8TtvUfqnhZxG0pVO9+TNdat9S/2087cSPFZy66PuK5DQPhA4Y8VXCBbsD0hqm4jmlAqBT/Km1LopwoD1P3wl3+iOMBXriKP9nPlVQgVzwB/SJYTEIBL5UbM29tM4VhlSIbg4EnBHidMXF6a4EHRJNwTBOPwkj4pikW6m9YFm5f3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 14:01:29 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 14:01:29 +0000
Date: Fri, 19 Apr 2024 22:01:18 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <vkuznets@redhat.com>, <peterz@infradead.org>,
	<ravi.v.shankar@intel.com>, <xin@zytor.com>
Subject: Re: [PATCH v2 08/25] KVM: VMX: Initialize VMCS FRED fields
Message-ID: <ZiJ5LrjddiLticvR@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-9-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-9-xin3.li@intel.com>
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CY8PR11MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 937b5682-b0a4-430f-78e9-08dc607935fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pquWJ8NpFzzSLrpt1+djYu833zBFgTJuXeAScxUVh1sA15nTQbp5Qttfi2pEY2O5LZqLUexUprcyofdx7FuaQ3hYAkFIH1R6SMV8LrFXmn/90Ow6F7mtRhk9HvaORH5IkC8ZmSojFxHTkXb/f+mP9NJJ56vXwBJ+pSkyMIMr2tF1vOiYCjWqwIo8XkTUZWGcVjCYEEmAchKIQZEGhAWOnczRMPRJLxe9vM9ow6uyChnPXNYDGmzg5UY9fBuKAXR2bPA7P4NUMpJ7NMKOGNvJmRrueKrBH+G70QLbO1/lQyvGDq6fscTUuw3zTbjLcNdDgi/wysrk5U9vhSIDv0fmv18srPe7wH2qHYgYh5PpoXpSeYGdZoFvJ/Tm9LD/uV0wjPedYlqmnAKMAF7qruA1bdlaDqLb6SXpFA5E0Psgcim33/HiPqWD8JnfN1/mZS5IMe4CLkLs0c+GwMQJd/tuQ8AVx5bexGnGaLeAqtYNbH3Sfb8zXox+lpvCSJfefET82LYJCAH7wTdtnIOdKZw1QyVAqWZbqB4rDjAmw+bRPoij3tjd3M83vnezwbGMnrsj+Kggb+ZuiCJmWYVliAR9nBPrwb2GFWO+hSsjKtqE0NjM5NeX9JfOMNC+9hTUCHE9Z3v4B38szDRBaZVHJZJ3IH6nAk9fWAMoO9oJ/TKFmVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OgHfZ9B0kceyN0sLODzHNVdd5KxVI30EVSEBAFXisVTBtK+/dYY/VEgSCll+?=
 =?us-ascii?Q?bxaPcglMUPwT5AKR2TL+FzFp6BauNjxRrRE0zSjygNSGH4jn6+PkP1GrMvgP?=
 =?us-ascii?Q?QH8BChWKcF0sff2DpOfgxCwHpeyN9yeg9pn/e0otU4rYJ8G4YHPv+uwSDkXc?=
 =?us-ascii?Q?g1Cl3vMufIG0afXMlgo9WK1EmsKg1WzgJwb2pJBV44fwJgZkVxGRL02cDDMA?=
 =?us-ascii?Q?mur9AH/MeK0wsjiceqpNhTfiyu6qOY/bp+GoYNhbwpUZCPFi3IWgAm6TdPAa?=
 =?us-ascii?Q?jRAyoRp3ATAoDTq7xQMvNJQl5C1McyaUnQuTJ+SJExwsNIsrAyR3hhuZoHUi?=
 =?us-ascii?Q?/3xsTimqeKJY7bi8u5i3rfdStDKx34Kn06NjjvTEQYVlVLOAmEyTWffbUIV1?=
 =?us-ascii?Q?ugJ+zo+Tj1m5uED3fR27kO+k/WByqH/JKYXy+9XgnnQ9EpiVOm2WwavsqelI?=
 =?us-ascii?Q?KBe2AyeSRpsDMbF0bKYh9+DhSzMJ1MrjO05tF4vmzjHi68fetpelUGwEt1C5?=
 =?us-ascii?Q?1pg8tNb0oiOvmzArOBjYuGT7D5IJkrK5ICLqKebZa7oO+EGaMEDgiPOvgyUY?=
 =?us-ascii?Q?/yfuTidFWaqqB8ciDUvNq0YDW+4E/evEW0O1xQPczqfDVzGzN5ffrZ0yRLPn?=
 =?us-ascii?Q?UNGlIjq0k4boEJBTJTRz+a4CgghNzecSzbpkzwgcrMyaY/l9VW4VL9+tnRIm?=
 =?us-ascii?Q?UOoxO+byNHTQmjt4Y80gvVQ/iMOBcuj9r04ngSSEoTnfI8OqWq3MN9pBJPyt?=
 =?us-ascii?Q?OSD5T0eglRbDaSrChU1CvKW7F/jd0gl9zQunzvIzyWCwrltIncmKHzusnujE?=
 =?us-ascii?Q?9qgKH5DlmgMMD4wRVBpQIrr+LHRKRWrupbPp57RjF65A3IjZIh8S7lndwpXQ?=
 =?us-ascii?Q?h22ODM0kBCNPXjRiJoaPtH3KmH2F/kXb7i1aCJ677sAKvUiZeBUdFXtdNHDI?=
 =?us-ascii?Q?YD05oMHh4ymcyx8JAfElYXZjpaKxwvOF7lQ4VE5biJAYdCcBBnJEJOcliIc+?=
 =?us-ascii?Q?x6wGCK+mgPOZIgDdWYtoHxkM1be0x2x5lyqqJQSyy0fMv+yus6spEX5xaMnU?=
 =?us-ascii?Q?JliMqcCYwOQoxUGSnPrChPV9fdbAX9aWYCXloEvvh3RhkmZ10dLpQpSYJY6I?=
 =?us-ascii?Q?qDrmr6WGJ9bAiZPTvLWqDUqDghvIQKKFPl+H8/AL3lCiBWjqhNSLnZcDSnSX?=
 =?us-ascii?Q?CvaaZSTjqexnlS+s/5JDoDTmwBCcKUkU0N625aKMZCffDnF2rctSeWiHyTha?=
 =?us-ascii?Q?w9gdwDiLSpfb5fL1GJaPUOECVe4Lnt4mhLzMkxhbFsybo+9TZesh93QAAjdf?=
 =?us-ascii?Q?IGzBYPm91iDKmLxDKIAe42CoEVe1iHf0gDeXXxQT38mo+7E4T20i0W0jfcVZ?=
 =?us-ascii?Q?yGOitCJzJfhij06czB5hDzUTJN1SwphFlhd+OCJMZeTXBqYPN6MgpaI6EmnH?=
 =?us-ascii?Q?lTjbCZnNmdCynCg4wHSNRnVyNOfCqi6V3H8NGGZ5WirtdijDkL+I5nWrGxh7?=
 =?us-ascii?Q?a8d2/1A3zdf+aTx6aVxI8kUO98X954SkkpKrf/NOoY52ne5vIZC+uEsob8PO?=
 =?us-ascii?Q?f0ExbkoCbAWLOOtLgIcA4UUJ4V4I+vyzFB/4Ny5G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 937b5682-b0a4-430f-78e9-08dc607935fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:01:29.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpRhVHfUuBVt24PYy6pCqg7ppcllmwyEYPXwYuuG2hjtt8MEWIIReLzP3uKJUQGVk1g2yP08FZnkincdDoZAHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com

On Wed, Feb 07, 2024 at 09:26:28AM -0800, Xin Li wrote:
>Initialize host VMCS FRED fields with host FRED MSRs' value and
>guest VMCS FRED fields to 0.
>
>FRED CPU states are managed in 9 new FRED MSRs, as well as a few
>existing CPU registers and MSRs, e.g., CR4.FRED.  To support FRED
>context management, new VMCS fields corresponding to most of FRED
>CPU state MSRs are added to both the host-state and guest-state
>areas of VMCS.
>
>Specifically no VMCS fields are added for FRED RSP0 and SSP0 MSRs,
>because the 2 FRED MSRs are used during ring 3 event delivery only,
>thus KVM, running on ring 0, can run safely even with guest FRED
>RSP0 and SSP0.  It can be deferred to load host FRED RSP0 and SSP0
>until before returning to user level.
>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>Tested-by: Shan Kang <shan.kang@intel.com>
>---
>
>Changes since v1:
>* Use kvm_cpu_cap_has() instead of cpu_feature_enabled() to decouple
>  KVM's capability to virtualize a feature and host's enabling of a
>  feature (Chao Gao).
>* Move guest FRED states init into __vmx_vcpu_reset() (Chao Gao).
>---
> arch/x86/include/asm/vmx.h | 16 ++++++++++++++++
> arch/x86/kvm/vmx/vmx.c     | 34 ++++++++++++++++++++++++++++++++++
> 2 files changed, 50 insertions(+)
>
>diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
>index cb14f7e315f5..4889754415b5 100644
>--- a/arch/x86/include/asm/vmx.h
>+++ b/arch/x86/include/asm/vmx.h
>@@ -280,12 +280,28 @@ enum vmcs_field {
> 	GUEST_BNDCFGS_HIGH              = 0x00002813,
> 	GUEST_IA32_RTIT_CTL		= 0x00002814,
> 	GUEST_IA32_RTIT_CTL_HIGH	= 0x00002815,
>+	GUEST_IA32_FRED_CONFIG		= 0x0000281a,
>+	GUEST_IA32_FRED_RSP1		= 0x0000281c,
>+	GUEST_IA32_FRED_RSP2		= 0x0000281e,
>+	GUEST_IA32_FRED_RSP3		= 0x00002820,
>+	GUEST_IA32_FRED_STKLVLS		= 0x00002822,
>+	GUEST_IA32_FRED_SSP1		= 0x00002824,
>+	GUEST_IA32_FRED_SSP2		= 0x00002826,
>+	GUEST_IA32_FRED_SSP3		= 0x00002828,
> 	HOST_IA32_PAT			= 0x00002c00,
> 	HOST_IA32_PAT_HIGH		= 0x00002c01,
> 	HOST_IA32_EFER			= 0x00002c02,
> 	HOST_IA32_EFER_HIGH		= 0x00002c03,
> 	HOST_IA32_PERF_GLOBAL_CTRL	= 0x00002c04,
> 	HOST_IA32_PERF_GLOBAL_CTRL_HIGH	= 0x00002c05,
>+	HOST_IA32_FRED_CONFIG		= 0x00002c08,
>+	HOST_IA32_FRED_RSP1		= 0x00002c0a,
>+	HOST_IA32_FRED_RSP2		= 0x00002c0c,
>+	HOST_IA32_FRED_RSP3		= 0x00002c0e,
>+	HOST_IA32_FRED_STKLVLS		= 0x00002c10,
>+	HOST_IA32_FRED_SSP1		= 0x00002c12,
>+	HOST_IA32_FRED_SSP2		= 0x00002c14,
>+	HOST_IA32_FRED_SSP3		= 0x00002c16,
> 	PIN_BASED_VM_EXEC_CONTROL       = 0x00004000,
> 	CPU_BASED_VM_EXEC_CONTROL       = 0x00004002,
> 	EXCEPTION_BITMAP                = 0x00004004,
>diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>index d58ed2d3d379..b7b772183ee4 100644
>--- a/arch/x86/kvm/vmx/vmx.c
>+++ b/arch/x86/kvm/vmx/vmx.c
>@@ -1470,6 +1470,18 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
> 				    (unsigned long)(cpu_entry_stack(cpu) + 1));
> 		}
> 
>+#ifdef CONFIG_X86_64

is this #ifdeffery neccesary?

I assume kvm_cpu_cap_has(X86_FEATURE_FRED) is always false for !CONFIG_X86_64.
Looks most of FRED changes in core kernel don't have such #ifdeffery.

>+		/* Per-CPU FRED MSRs */

Please explain why these six MSRs are updated here and why only they are updated in this
comment.

>+		if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
>+			vmcs_write64(HOST_IA32_FRED_RSP1, read_msr(MSR_IA32_FRED_RSP1));
>+			vmcs_write64(HOST_IA32_FRED_RSP2, read_msr(MSR_IA32_FRED_RSP2));
>+			vmcs_write64(HOST_IA32_FRED_RSP3, read_msr(MSR_IA32_FRED_RSP3));
>+			vmcs_write64(HOST_IA32_FRED_SSP1, read_msr(MSR_IA32_FRED_SSP1));
>+			vmcs_write64(HOST_IA32_FRED_SSP2, read_msr(MSR_IA32_FRED_SSP2));
>+			vmcs_write64(HOST_IA32_FRED_SSP3, read_msr(MSR_IA32_FRED_SSP3));
>+		}
>+#endif
>+
> 		vmx->loaded_vmcs->cpu = cpu;
> 	}
> }
>@@ -4321,6 +4333,15 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
> 	 */
> 	vmcs_write16(HOST_DS_SELECTOR, 0);
> 	vmcs_write16(HOST_ES_SELECTOR, 0);
>+
>+	/*
>+	 * FRED MSRs are per-cpu, however FRED CONFIG and STKLVLS MSRs
>+	 * are the same on all CPUs, thus they are initialized here.
>+	 */
>+	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
>+		vmcs_write64(HOST_IA32_FRED_CONFIG, read_msr(MSR_IA32_FRED_CONFIG));
>+		vmcs_write64(HOST_IA32_FRED_STKLVLS, read_msr(MSR_IA32_FRED_STKLVLS));
>+	}
> #else
> 	vmcs_write16(HOST_DS_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
> 	vmcs_write16(HOST_ES_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
>@@ -4865,6 +4886,19 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
> 	 */
> 	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
> 	vmx->pi_desc.sn = 1;
>+
>+#ifdef CONFIG_X86_64

ditto

>+	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {
>+		vmcs_write64(GUEST_IA32_FRED_CONFIG, 0);
>+		vmcs_write64(GUEST_IA32_FRED_RSP1, 0);
>+		vmcs_write64(GUEST_IA32_FRED_RSP2, 0);
>+		vmcs_write64(GUEST_IA32_FRED_RSP3, 0);
>+		vmcs_write64(GUEST_IA32_FRED_STKLVLS, 0);
>+		vmcs_write64(GUEST_IA32_FRED_SSP1, 0);
>+		vmcs_write64(GUEST_IA32_FRED_SSP2, 0);
>+		vmcs_write64(GUEST_IA32_FRED_SSP3, 0);
>+	}
>+#endif
> }
> 
> static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>-- 
>2.43.0
>
>

