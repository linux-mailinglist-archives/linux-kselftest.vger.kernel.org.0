Return-Path: <linux-kselftest+bounces-10982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D88D5AC1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 08:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3767E1F253BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 06:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E2580024;
	Fri, 31 May 2024 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+/guM93"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6F28DA0;
	Fri, 31 May 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138200; cv=fail; b=pD5njHSsuSlvFg8CTF1w+/vPXi3cZNOcLgLgZNB1AxT03RWuAXat5wMWauoUpNTB1AzAMhsYhfcFPzf+cornGir/Y4zeNPCcz53xB/4LG3CbQzRQoUvwyZDZsn4GGlyEJQDUikGzfxFyjORQgr8PKG9lq0jHaGuSr06lP4K1ja0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138200; c=relaxed/simple;
	bh=gzqxwu7OaZIo0rqaS+q92k/cTfhtUkgYiduzTzirRAY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SIT8lejfTyGoLTi0zaXbJTUd2EWrusVo9lRl8KnUfRQnZEe9foSkTDTyrwiQ4MbCNFjiLMT5cocXwpSX2DVNitlNqN6MAYAVpubZWuDsj+EcCSjDNFpgGXa5B5+BnugzHzIN7jZ0hmZ1qNj7MZMZrCosPAhuHtSx3KNnFXUGYNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+/guM93; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717138199; x=1748674199;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gzqxwu7OaZIo0rqaS+q92k/cTfhtUkgYiduzTzirRAY=;
  b=l+/guM933KaBI29hH+wGS8qwGTTxGxJGtY5j0jFgdWSm2x86/k6JKCar
   dkIzm9mDq51/u3X4LtyrW4IhmMqZSdu6QugxBMc2Iq/x3ZmtmKC7KniMS
   P1VohgX+fY3IL850de/uKiHeSBkr1xlGaGWibg+CcCvd67LbUj1qmP/ME
   X9Qort4AsHA0V8dm6iaUR50S5WygF2r4FUixZSglDch2DwZMIsX0tJ0DN
   k2tcQFYXSAOzzACSWnRZzTpBH41dbxK1SsBchouYiI6RHiCI7sKBCXLSI
   ztFOH7CbOV7rQ/I7vcjBfOF9oaFeQijJAGsdOC7JomobBu8Awr/kHabDS
   w==;
X-CSE-ConnectionGUID: VRjOwpjkRzGy1UTfX2YN/w==
X-CSE-MsgGUID: 6tnbZF0fRu2kSP3EHD2vOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24790668"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="24790668"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 23:49:59 -0700
X-CSE-ConnectionGUID: bHupAgvhQW2eerk5Fiv1hA==
X-CSE-MsgGUID: rNJHYgAyQKyRO++h3miArQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36645352"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 23:49:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 23:49:57 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 23:49:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 23:49:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 23:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK+tTtNCMhkqIH15QcNqj3mKgjwEY1XRdBZMsWaDCcheChQQiYCbbzOIS3PwlGeATj5zGntp/37Sc6eGPTRch4C82JnBvHJLjCasQ/jcPGeMQ9iLrKVSMmexzfDwSl7o6I7COhQvK/O/1m1/SfsjAfJdf7J7CqRj29o6s0uaiaUSIGmjF2tBiv7bz2OaBgBg/6UV61mtfFqzBYDvJl8fnE68vbRv0kVcdjlxjhaHoht6zcXxGn+Xjrhy9At2Lfc/NApqWMYLQw3wiyO+W903PSfHWa7EY2Dpp88I44BoFYVMys30XuCAeCKwu6Af+8elcpL2QwEZRI79Fyf5cTFQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys29dgacdrfv5cYVmb8lwDxt4NGvCi0hE4MYZjqztPc=;
 b=EI89kR3Kl9/6C0I/01T86RzIzaLCS14D96szX9jll8R1+knVWSs5Tb/FUg9PfWNjNOpdaWaL/QrNMzTEg22nhzjwPcTRJQDnvVShkdKJtEtcPYDcEnmDUFMI+PvFmcQm9OzDO3k/4LQBCOvpxyIV5aO7eFGTJElTE/unVx/R0RRzQeVqqc1/nAb2fuoVfPvqJaR3FGgDORyrqxS8Xf8Hwb16pr3QdSFssieFw28HPgzA/bvq3jW6+ycxxXQwOG2Kal3m5XcAfSfFm8f5dqV9q8tePoyFy2DsFLQP1O2wdevjtECttCumqk3acqF0F+lpOwKlOC9PYhaT/uPzf1nRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 06:49:55 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%5]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 06:49:55 +0000
Date: Fri, 31 May 2024 14:49:46 +0800
From: Chao Gao <chao.gao@intel.com>
To: Manali Shukla <manali.shukla@amd.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<bp@alien8.de>, <ajones@ventanamicro.com>
Subject: Re: [PATCH v3 5/5] KVM: selftests: KVM: SVM: Add Idle HLT intercept
 test
Message-ID: <ZllzCoYvMQOkMo90@chao-email>
References: <20240528041926.3989-1-manali.shukla@amd.com>
 <20240528041926.3989-6-manali.shukla@amd.com>
 <ZlWLupfpODawPX3P@chao-email>
 <b45bc797-9087-4456-ba18-463c3f638096@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b45bc797-9087-4456-ba18-463c3f638096@amd.com>
X-ClientProxiedBy: TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::17) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DM4PR11MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: a922e168-385b-4104-97d7-08dc813de13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NZ2frgopwfyJxn/YQpA3eoyLAy1ctSx6ocT+Ca9uxp/oDaSCGCJP9sZCTUrz?=
 =?us-ascii?Q?IzaWtTKNzQg2CusEqhrfCO4wAPRcRniWTR7/PCABXysr5u5uPFB7i+W/3HKE?=
 =?us-ascii?Q?6ne8HUp3gcarfaSXTRcvej1zWCD0yaI+aY78W1mac8cL+iJPJLOEEok3ZtKG?=
 =?us-ascii?Q?RMKSypxVChP6z9X16Uegme7cWWv5Rj/JeoGEKgYXT5nMcUP1u1S0Ry+vBtnB?=
 =?us-ascii?Q?RILEi7QPKLGt3WyEdrBtjHt7+rDzh3geYWG4Emf9EuYlV/l0vpRBBTOP0Vw6?=
 =?us-ascii?Q?rA0RwE07EmdDLA48bFHMZsAJiv5q5lU5+th0EqdH0RjbWUpzNj8tIlByqpTW?=
 =?us-ascii?Q?Xn0/W5Kv/EcOgs/EveNBeFHabHGRezq2wTy6IYP9mBma6xIZFmslnHH1UZWz?=
 =?us-ascii?Q?zz5qG04MwUx+yiCn+y8gcvcvVoGUxICKU3FLfZcFRWtv1JcXP6gRRmxA5Ugx?=
 =?us-ascii?Q?PuGrCeP6CPgEiRtfi5iTOIgUa1FgrgUwtPAY4x1jFdpNS9HlCe0HLcQzhw3j?=
 =?us-ascii?Q?+IitqwWMrBQ/EBxymEVJ+DllimFsoPKi0IDfDFkOiItAJhjzCGtkvlTdJGPJ?=
 =?us-ascii?Q?XnJBPlQbQ+x+a7ZH+MAgB2s1FnPhPHya1Wz1f2jucJQ78pF+56X4f4ucz4DQ?=
 =?us-ascii?Q?zA7TxeQRrhLcJKc6w4uHrC1IdQHTUqSrudqDfbW+Ta7AwPOXQ3xmMFQwba9X?=
 =?us-ascii?Q?0sIYWb+MAcOxWfleuYM9+/TlEgEvrsR7RhrzKxyCwG7P3dLDyXyk/Jysqco1?=
 =?us-ascii?Q?HcQvaD/AvRQJzTw4C3LmyMeBTkWD48PEUqo2s8FWyZal4sH+s2ucHlEZjgC1?=
 =?us-ascii?Q?E6AbNi60ezQCak/kvVo1pMoHiffAlitlMWgWg+pVxCgcTj2OS4YQ5i2bZ21j?=
 =?us-ascii?Q?tKFC3muEKaJI+xT6vRcq1s04Yf1XoL3xl3txZzlAnlGM1V+kBJVJ4IGHXIjM?=
 =?us-ascii?Q?jCKNhkXKiEXaJwNfrgNzbYyr72ecLtqtgF8NN/pcxlf9jMamIjkIaGkaH7MC?=
 =?us-ascii?Q?4hDiyzNQZ654Ixll7TPuiM9ozANzjdLEI0rL18NjVNS+oFrko64Zz6+uhRXd?=
 =?us-ascii?Q?VsVnkJ9OP7gveT35Hlop9+D9OPrUY9S5S1fs2v8iRYimGMJ1rs/vvZsKG6o3?=
 =?us-ascii?Q?LmuXFLvVQTLmDR3TZxUhIK1wm8eEsKF/GFYsZK1qiM3yjbJn8u0ex6tTYj1r?=
 =?us-ascii?Q?h4N8gXIXmwjT0wGzlJ6MbSycIynZsbxv08umoS4G8HlSEagOTiJcBwLzPfil?=
 =?us-ascii?Q?7bhiytakWkH53N6pW/e2aIuLRlfEQHqwzrTArXoqsw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZxRfzrkQZy1XMyFiti5gxMieIcXfPVmNVIWRSdmuzCvvqtvBfOB8dKIgQY8?=
 =?us-ascii?Q?nQMNJxvF3XR2JFTgspbk6Zg7MUpnBjU2so9zxteRA2cpaCnFYve49a3u5fQm?=
 =?us-ascii?Q?qSXIDu0/BD4lcyrwvoa81eRkcHdhKOzgddbnclFeXjFEGyAq+zfAFoL/DQNH?=
 =?us-ascii?Q?BjsANvtb2vfuNSw5X1Jbr9SFhLP4StFMF4h/SdMWVLDmNXmD3xS6q6m/t1BY?=
 =?us-ascii?Q?ViayAsWaVVvU3o4XWFAqrIb07Wrtyyt0BKuIVK7vRY4atEzwk920iq8wSh1C?=
 =?us-ascii?Q?JUzHuWDcRg/fxc4cqByFQ/VUSG4n/kOulGdVV9Fit5Qauvw+jPfqDoCkFdIY?=
 =?us-ascii?Q?+DocCQdRHoRb7Yfz5+jHdMYBAKjUJFIIXI7Dr4wzZWNCGn1s43rb3h+NUURi?=
 =?us-ascii?Q?YQfG4fiT3bmKLQ1AjnV/f/WenzyTEMkGm6fnWLgLT3TQbemNgt7xGWNtYJSx?=
 =?us-ascii?Q?SVI9yRDuCpf6gess0HFw2yJJY6k2qfFulNITAtYrXq+drnGkGCBCaBDbFxoC?=
 =?us-ascii?Q?eDd/nEit2bHVeujeObaeNJas0iyRekMpvzGjOgSV7hoeVCc/KEeUk7H4gq2A?=
 =?us-ascii?Q?sWSm8p//7dZju4QGr0MYf9zb/K1sRnOQQ73dKEtKCLeze69/7fxxfD7aegZq?=
 =?us-ascii?Q?JBgYFvx6BrF21af5uW3tINLbweKvGAFcNd7zB0xeB/VeTja4Y60cOdsWtTcu?=
 =?us-ascii?Q?fY83OaZuBw0v+NYwdUoFPx9NXvTz2s8xOaT5rNBZgwSeYJESYTRDNDzHCFIj?=
 =?us-ascii?Q?RyZ4HVmViDcPtWMg/PBh7XrAXJDGCbMdVJBf9p3/l1QlhxagnCkfbMI4G6XJ?=
 =?us-ascii?Q?JhwnYcotdf811uOs0yWQsSECxnr7WkJI0FgtFpONfXIK6zZTIWN8Z+hZpJ4u?=
 =?us-ascii?Q?usAcBtm8qgT3E470u2LtlkmkUF+KXPewt3cNDy1LbbkuM0vUiwrPIUCHY0hK?=
 =?us-ascii?Q?7zLAdod0RA8G9Ya0woPFhOzExGy2+W0F2uYShEVqZtOZ7D+PjyCoL5YLZHWV?=
 =?us-ascii?Q?bOJX2FuOFGolxz7zscB/0nMShCmRMBew0ykk75f0rQXMd8bsHoBlq/CHEy3V?=
 =?us-ascii?Q?/SsJ0Tkc5eR4ysusYdu0hit1TC7eqOJDxlnzUR1cKzDf/T9uCyYkP9188Rre?=
 =?us-ascii?Q?MDV4BqueV6Ie1l9T3MOAg2PSqNAwDQlYEy2pqDXN86vmC95eESBaMrReuZFY?=
 =?us-ascii?Q?ZmE/H68hcZwrQe9rG68sPj8TzkfiLM9XgUj5jP6IuE1VLXjyz7ICgiQZoS4r?=
 =?us-ascii?Q?9mDFqh9YJikoqeF5F7bRCMG6+sDYsCY5/9st1OZ2++aftcMcnDsWvHnWJNq+?=
 =?us-ascii?Q?ZCWFo82X1WYc9b67UHVZSnD7+vf8Kqgfw7qVtMOBBvvQlxJZ8GUfbZY5nszi?=
 =?us-ascii?Q?YJnbQncG9UDEyNtYxEN0U1m0/Xd3cBl8gE6jkbou6O/dQ7G1yWNFo0/0hpoK?=
 =?us-ascii?Q?jR/xrhED/Odm1L+bvi5CZpdBjRcWtfaNUWx0uF2MZrLnHgGf2QNhu8K1cX3H?=
 =?us-ascii?Q?jhXTyjrVG85S9gDmamW0HqesgbTmXkaz7qYSma6ZIwOpxYf+/5kvQblKlS69?=
 =?us-ascii?Q?/3cAwnXEhm5yOM23IDmCftyjD9/Yd1XCWpMrfxJl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a922e168-385b-4104-97d7-08dc813de13e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:49:55.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoY6EC+GLGXwI611hZEq3280VIJleRo6qqWJfs4zN+WSm0LqaIPzLUlaETHT+K+/w0+aXn+A7zub851B29GqQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com

On Thu, May 30, 2024 at 06:49:56PM +0530, Manali Shukla wrote:
>Hi Chao,
>Thank you for reviewing my patches.
>
>On 5/28/2024 1:16 PM, Chao Gao wrote:
>>> +static void guest_code(void)
>>> +{
>>> +	uint32_t icr_val;
>>> +	int i;
>>> +
>>> +	xapic_enable();
>>> +
>>> +	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
>>> +
>>> +	for (i = 0; i < NUM_ITERATIONS; i++) {
>>> +		cli();
>>> +		xapic_write_reg(APIC_ICR, icr_val);
>>> +		safe_halt();
>>> +		GUEST_ASSERT(READ_ONCE(irq_received));
>>> +		WRITE_ONCE(irq_received, false);
>> 
>> any reason to use READ/WRITE_ONCE here?
>
>This is done to ensure that irq is already received at this point,
>as irq_received is set to true in guest_vintr_handler.

OK. so, READ_ONCE() is to ensure that irq_received is always read directly
from memory. Otherwise, the compiler might assume it remains false (in the
2nd and subsequent iterations) and apply some optimizations.

However, I don't understand why WRITE_ONCE() is necessary here. Is it to
prevent the compiler from merging all writes to irq_received across
iterations into a single write (e.g., simply drop writes in the 2nd
and subsequent iterations)? I'm not sure.

I suggest adding one comment here because it isn't obvious to everyone.

>
>> 
>>> +	}
>>> +	GUEST_DONE();
>>> +}
>>> +
>>> +static void guest_vintr_handler(struct ex_regs *regs)
>>> +{
>>> +	WRITE_ONCE(irq_received, true);
>>> +	xapic_write_reg(APIC_EOI, 0x00);
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	struct kvm_vm *vm;
>>> +	struct kvm_vcpu *vcpu;
>>> +	struct ucall uc;
>>> +	uint64_t  halt_exits, vintr_exits;
>>> +
>>> +	/* Check the extension for binary stats */
>>> +	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));
>> 
>> IIUC, this test assumes that the IDLE_HLT feature is enabled for guests if it
>> is supported by the CPU. But this isn't true in some cases:
>> 
>I understand you are intending to create a capability for IDLE HLT intercept feature, but in my
>opinion, the IDLE Halt intercept feature doesn't require user space to do anything for the feature
>itself.

Yes, I agree. Actually, I was thinking about:

1. make the feature bit visible from /proc/cpuinfo by removing the leading ""
   from the comment following the bit definition in patch 1

2. parse /proc/cpuinfo to determine if this IDLE_HLT feature is supported by the
   kernel

But I am not sure if it's worth it. I'll defer to maintainers.

