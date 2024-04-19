Return-Path: <linux-kselftest+bounces-8416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178E8AACBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 12:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677391F21B37
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 10:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4937D091;
	Fri, 19 Apr 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJ0Mfc7z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A497BAFF;
	Fri, 19 Apr 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522158; cv=fail; b=gE/Av7oOKf5xNGIEFZqhOIFkOEuS8mMHY0MT4fazzlSNWKt6PNlFJho74SxXOnTudS+oMmctVFMRRyZUmKXsN6JyQIQlhs4W0xX2vBdwLNaFlpq5yIoz4H5zJAJIKQLYfeFy5vqz4lH7Fi6z2l87C0nCqIKVgEIfzzrsIg0UnQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522158; c=relaxed/simple;
	bh=ikLOaTQeNPQYAhvJKI1jjGQxjV8jVU3ECX8HAftbubo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b1y3mMjGFddgZyu+1RnbDD2hGAQZ7GKrH2LXyS1KaDpVmROngXoK0WTb9J+hseWyljsDOntZiqL14JTusFXzttcnJ/shipajj0yIOo8R28UFKSU8N64sYyPabHQ0AXepNkX4Z6S44tOYNoz/lKii2b8GfPHyp857Au0TcnW8bsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJ0Mfc7z; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713522157; x=1745058157;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ikLOaTQeNPQYAhvJKI1jjGQxjV8jVU3ECX8HAftbubo=;
  b=GJ0Mfc7z2+fOgRiReO8lw+vBxsDQfMnxiCCLpOr+qjMhJcEGZgIVpJgq
   N+7cZcTZhqltNrzgc4aI1XEDaJTF21DUHOo2xy2MI5b33/Nn6WqKNZJXI
   RltjaA+SLOscln+mNekYoTRx/xZ5WLrqehZlujjwn8ArIISbLVbmpiY2/
   jhfjPipMD6hmMCdj927gzoxtF7h4pbrhJ/e1iIcSluBvxRtukPetLc/BI
   h76qq9fRu1/YNfPaoxxQGIlF3hOyJ6lG+PZVN4anHvvDoBh0h1nRnV9tE
   f1hnHk8EvTEqR+bnh6MScpMenx/dnqH5iOUCPWLuLf9MFHaHFxay4Ajo7
   w==;
X-CSE-ConnectionGUID: EL3TOM1XTyKCgclZ2qBDxw==
X-CSE-MsgGUID: ipgOGsa2R0uSwLW6e0hLFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19726550"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="19726550"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 03:22:36 -0700
X-CSE-ConnectionGUID: N2DUXlhnSPWGhBR9y2uXHg==
X-CSE-MsgGUID: S6C0UAZVR5CrzvQs0ph55Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23275726"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 03:22:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 03:22:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 03:22:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 03:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWVYPf2KCq30/wWVGTXZ0zDVVPpXTrjhAH21Azob64U3VkpyPM9n6rB/afI0pcikwQKxCeyEnFW7ZESZftQ6RI7OKpTXd2ZlYkoPuR3mgmpkARM3nsWZ68pcwC1er+z2ORZxG4B/dUQL+2EwOWVmlHKDIbQRozHSjj2U7km/PPz85rXzjKtfYFAaCJGPKk3idJIt53/2/ZN6kqjmEK03sAkEidesEg9yuXWqaNh3cTYB7xf4IIzlXEkEsVPoatbMQNPCmD88wbfiMDiHgfpctAPmfK4/Ma95w/HnHi1eHG5doXL2XsKyBM5yHVMWznrr8Kle4xTLstxNw+3Tq2wV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikLOaTQeNPQYAhvJKI1jjGQxjV8jVU3ECX8HAftbubo=;
 b=YqtP6YFNQSLrSxlYNvOSDaQMmIT5vLnZh69qYLfwAmmlOiPkBjskwwxc83DrqoD/H4+9X1NkVhJyjZBxkEguIbF6129ZiC/RRUuJLKbAeP3dv8f8ZXgkL7hohJPSS2HNhlQY/FFB9qtHg2gqQBMPVdU8WMAHydajU7VCqkQTY+daIHRh0zOp8Cu/pJwASoh7+fNgegBr5/iCfpa5QFrqE4VlPgRKspNB+kUtS/utO/mXdDamxOzTbzrSET9bn2A8//eHPOoRtBrdFvPgWJQMfTJKJTk2Vu6v5ETV2TqVnG3RjZ/wWPoOEsBMNTmUcfaeSpv2i8C/YCc6kH5hnukBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA2PR11MB4875.namprd11.prod.outlook.com (2603:10b6:806:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 10:22:33 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 10:22:33 +0000
Date: Fri, 19 Apr 2024 18:22:22 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <vkuznets@redhat.com>, <peterz@infradead.org>,
	<ravi.v.shankar@intel.com>, <xin@zytor.com>
Subject: Re: [PATCH v2 04/25] KVM: x86: Mark CR4.FRED as not reserved
Message-ID: <ZiJF3s1VyigV7lYc@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-5-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-5-xin3.li@intel.com>
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA2PR11MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ec48b9-c4e7-49ea-af6a-08dc605aa05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info: LI9PU8QSDs21dzphXKTI2tfiBGWg6YDVEoNChAaeWlqhcMr/Hi/7r6G6mRExRsvP0TcT4lRzAoD24QdWdTUquFU+W/GOhAQslI7OifSI6d2VdAt3MLdQUkes7QfClWb37NCD3n7XCFsb1Vq6XPfCHneVMr7yPhawdwCobNpwXJIUQmCLR4czCp2H16FDj7DG4pW7RCAbhyznghkbkr0H8dvz8dlvGlIsPl2j6x5fRd2vGDmIOAreZsiowBXbtxGFLkzIzrTru5pyImZuZbxYNzozwu83uycpneM6DRDNsMFeQFkLE2DEAigd+cahyDuYmjttoJKFM/ofsMUoipeslvf2cvO6WjL7GZstFbv7nkYXbDsjVW0yR+isdSqLZU0RbysNjNjdJeYkeaWR+r4xEuV0T9Y4r8bHPIcFeAgtx137Mkf8KATCwLrFalEofxjGef4hJpYAawRQgbcmC5o6XgIXonY2anW7GnBY98QpPCsGs04l7HUK2qI1rEPr7sY0Bjez44CqH27aAUopGFOSgtVnJ2LCM4wu6NZwDTh9Gk/mw/CnssQFHolAJglT8YcJDNsAl8VKwDlBVfQv2SMF/Q5z6syHvyEFenljYaxv3h7GyYb1bvINR0ddbo7/IDIN/FQMRKBVhicfjD2TKGRuRgC2Ub/FxvNfLF/ImFVT+6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+jIp8V8iwLUzszRKcAg5b0OxhUCns/ZZShE3y4Muj+NeTL2ujtB9uhudVX6F?=
 =?us-ascii?Q?FqLdGoiDul0fjc65mXL6tkDMuK28ozQ0U30t11j8WxiABnrcL91HXKfvnuZh?=
 =?us-ascii?Q?93v5Q1XKEr/QkrJ3jzv83hCPoyim/zP9YUnqVxI2aFXGFi1wgx8hi6yTXod5?=
 =?us-ascii?Q?bLEFCTuW1EYWBf6sj9oOpIGlzJmIuNXc1/hsFqCRpKo0PgSaHYO9h9FEfNSD?=
 =?us-ascii?Q?cIoBgkuJK8Da2AYO2HJevu43k1YNZAxup/mtNlTdSTQltu73nM93woap3GDk?=
 =?us-ascii?Q?+jkyX88diXWuuyM3KEbsltGmaC2wkzh2KUH+Ajh6Y9Rmg85ZFMvcSlHPRHJS?=
 =?us-ascii?Q?DjSHyVV/TjAEijM/5TGaeRkUkWcDXBlrtz3nBN4WpQWQBU8K/RC4x+6YZz0E?=
 =?us-ascii?Q?1sdW2t9iC6J9C6057JkhoEU9nW1HLYvYESyDyhTeI+1cQurnCny8XhFIlg4h?=
 =?us-ascii?Q?ExpW23UWzoqVpun0P/QxoKhEY18Cfn15EktMNG/oz4JuZRZQ1CrZw0vWhDBf?=
 =?us-ascii?Q?AzT+4exw1Cj5EBPXCDb+fGWkPmRLuwJCVSJ1P8+BY3KXySzuVKLMX7tcS+CO?=
 =?us-ascii?Q?a2Qe5E4nML0qRIQ8dmAqeh6JyrYCaDbT0+aE70uP4Wdafv55kR5kGpCviLOb?=
 =?us-ascii?Q?DDfJwma1qpyjaH1fvVnIa5HAcSMlNEbC/Qz3m2CKp4BQq+mr8n398R2tOXPB?=
 =?us-ascii?Q?SHnw7zMBWAlTYzM1SW79fiZuQ2CxqP2ubPpjtEMB8gjgRUvYj8JAaE1Kb+s0?=
 =?us-ascii?Q?d/g1DEU3iyCwgQo3YLnaZovP2773wnOkRfORdVgOTyqBxt1Lt6dTnYo7XvrJ?=
 =?us-ascii?Q?gixv//K7EZBhzvnGprlnTeprdtkzCuPgA/v6uJEO4tYirbG6C374oCqs0lxx?=
 =?us-ascii?Q?KxOcl3SU/V1tirrsA1pkdFKKwF6Lu4/1mVMIwKyEkM/8bP6HrzurL2yl/oyl?=
 =?us-ascii?Q?TjNruXbGnyFn6Sbod92QQBxpLjIODYLmBWfsye/6w9ByTKRuSnGCSK5+PX1q?=
 =?us-ascii?Q?T5W/ItUT/QhQZL5QhJgOa/nSckob3wm8gyO6GW4weYk34KIUauAVogKTHm0o?=
 =?us-ascii?Q?t9DJCysnfE2WnmvsPoe+RATAwWlb4mPeXBVQPUZZRNKiz25ZOyQFZ3FjCxB+?=
 =?us-ascii?Q?ALtkum5m4H7A+EhyjFmpKSVSee56bSasaJirh3MKkV0eFSO6HtYgOXCLsyRb?=
 =?us-ascii?Q?siN3+iqSDJAJZ9Uk/2E8P2fzpc/3KjRX70jfdSxuBOg300UwTR5KCbrWowcJ?=
 =?us-ascii?Q?zXNhYKN72AoFcA47LcnjNHx8sVQzJsM9Bl6J7H0mXaTu0wG7vuTS62JA152a?=
 =?us-ascii?Q?/nci8bSYBMIiY87bqpv+P8B0I38tmm9rNX02Q90oL+vjtxGdye9je98KOfkQ?=
 =?us-ascii?Q?WS0QXwUZqQGyDVRaKDhIuTZMDbErx5/CWmY8itGgF0HwvVWeW/Al0SLyPSpB?=
 =?us-ascii?Q?4r/t5/jLDmBQfF4CMpALVtR7tDKtEQU1GecrtJ4CQGduNeI8/RGZN2hGrvcW?=
 =?us-ascii?Q?Dyh5we08UCj6UivZ14Kt8m1VLTV6FJkEbdpPL6Wj507QkufgeJX4JcaqyTUy?=
 =?us-ascii?Q?ghk0aeUbADL8ld71CS7v9srS8GISA5gEEhNBO2P7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ec48b9-c4e7-49ea-af6a-08dc605aa05d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 10:22:33.4645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRPAvxStv8j8og9C4d6yZHPdayLm6WB95rrDVB+zYT7YdWd21dLAlLNkMAIORFQ/yu7xyRxOBsWPtCr8s4yjlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4875
X-OriginatorOrg: intel.com

On Wed, Feb 07, 2024 at 09:26:24AM -0800, Xin Li wrote:
>The CR4.FRED bit, i.e., CR4[32], is no longer a reserved bit when a guest
>enumerates FRED, otherwise it is still a reserved bit.
>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>Tested-by: Shan Kang <shan.kang@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>

