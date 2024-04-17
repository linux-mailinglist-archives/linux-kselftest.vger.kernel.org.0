Return-Path: <linux-kselftest+bounces-8275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB358A8EE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 00:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F8B1C213C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 22:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595477D3E2;
	Wed, 17 Apr 2024 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYLfK0GB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601779C8;
	Wed, 17 Apr 2024 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713393718; cv=fail; b=LNJxnahltm/oLNZYiQM1sYFuqlpnmQ83dEIP2GR/F2vkJePsF9QHNw5gtND8bNtw1XwwbikAw3D3PzIA/Ovkq1T0T4QerB8LUFfh4+9Wpo0u2GIGUoO/oAqcignkVKLgcCnVDV303rFlc5ezoXHKmo9Uif3lXdZNoYvgpZMhyzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713393718; c=relaxed/simple;
	bh=dzrQz88HLZ/us3Zzg7rJmq4xuOu9YKe4+QmdAQwnoy8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q80ug5wXGmhv+/LykSAhlbMYZGZ4hBWqh2pFeV3FyuuHElJSIWBAs/hMqn8J/UQIObazIA+wELnO1ScRFZs3k5dRai2Qmlzxezb9jBYkdQ/lmHfKb0KMSbclu3yhy7QmXwAXdY75rOkzFucHP3PUjZGBEyC+eNxb1+pxr3ovVQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYLfK0GB; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713393716; x=1744929716;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=dzrQz88HLZ/us3Zzg7rJmq4xuOu9YKe4+QmdAQwnoy8=;
  b=eYLfK0GBCs6scdhrnwcKH304pYX1iSQVEJGaIABm0VYOb4ZijWwweB6M
   gen1yCNti67Cy0saO7bHf7nkIVg4hLKp+bjec7KpNLTiKyQOwRVd+Z2Zj
   5/0FVJmuBd5KXH+GjCKt1vRE/Fy+pc8MJVhcTLPemuK7I2jJZD3BF0664
   RJmKZZGMMM/wZLcQsRzsZoiqf6893sjmi4iwATUqwDseWYTxdMvcotEqz
   /fL4DD8jpWEGOp0JErrKUHRnYAO2uYlXe1LoXdXXXqeJDxqEvyoPyBN9W
   s8g9tPnII6wTiXUljEMuJKqL+CwF3xN+Qcyaee0YXjVM7wae3M4Ivy4of
   w==;
X-CSE-ConnectionGUID: eHh8rF/BSYOUUw+K3ZAphQ==
X-CSE-MsgGUID: Kkqd9p6ER/2stkj5dhR8gg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19472124"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="19472124"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 15:41:55 -0700
X-CSE-ConnectionGUID: Kw1elCslSh6fnjpdrgex1w==
X-CSE-MsgGUID: XtPzNc7KTSSlYAxPgRWKlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="27351706"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 15:41:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 15:41:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 15:41:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 15:41:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 15:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Melwcjn1fdEcRykmkVSh8AnBsjDkKqcGeDF5yIVb4xob9sCR028zb4vbht/ckUPLzr473Qkmacr19ZFMy2KhIMFCcPeavevJDidjNoZSkhoWh4IOGnCDM/FdY2a0Xm5uUiMWWrNS+q/PFdJvMC6WAYyTbmr3ebhyaVmuGMXBuV7pGqCRYVJIqwvHiSyY/3AYVT63SQqMn5FSrppr6PmgpIEelUiGrStlE9rXrK4nqL6HKqHoXBYAPjs5HzTMbRfFi60kHvixgDgryuh4QMcPuTaThpNPwgciOeQu31F64jtX3xR6oyfE+hyYcvGBAjTqFXr9Lrf6ER8Mbupy6zIa0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4SCowBjsjYE2l7KLSU8y8YvD19FSfStvapNOy+fb6A=;
 b=fGSrhIfBX5Pw9yy5p/iV53Waqc7isWDxp0+pfClsHvIg2nGnSBadtUN5Sgld8QJTLOZG+mRNpOSOLZijCa80gmLwC3s/B8eCTYAmlGqjiszO0q0bojOPL4gLA1jwK9Njp7kxdoTEL8mljVI0WFBsSkEX6StFwW29FN+Mpn83EhL5jgSZqa/rtxVGwkCk1bG8F185gg6iBADXoJauXundSGVhrmnpf6EIiSiJHa7BaZbzS971cP2hvtO5Z0OilUz1+NoYeB/0w1AA2WOM4R7yUT/CH2FTnZVyVNc2963xYMv14uz3vSpLcjreU+o16vB7IHpz6qAWNgHUCz4ipEjfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17)
 by IA1PR11MB7199.namprd11.prod.outlook.com (2603:10b6:208:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 22:41:51 +0000
Received: from MN0PR11MB5964.namprd11.prod.outlook.com
 ([fe80::6977:62ac:420d:3753]) by MN0PR11MB5964.namprd11.prod.outlook.com
 ([fe80::6977:62ac:420d:3753%6]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 22:41:51 +0000
Date: Thu, 18 Apr 2024 06:41:02 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Ackerley Tng <ackerleytng@google.com>, <sagis@google.com>,
	<linux-kselftest@vger.kernel.org>, <afranji@google.com>,
	<erdemaktas@google.com>, <isaku.yamahata@intel.com>, <pbonzini@redhat.com>,
	<shuah@kernel.org>, <pgonda@google.com>, <haibo1.xu@intel.com>,
	<chao.p.peng@linux.intel.com>, <vannapurve@google.com>,
	<runanwang@google.com>, <vipinsh@google.com>, <jmattson@google.com>,
	<dmatlack@google.com>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 09/29] KVM: selftests: TDX: Add report_fatal_error
 test
Message-ID: <ZiBP/j6Ic7hGrbxN@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <ZhkhvtijbhxKKAEk@yzhao56-desk.sh.intel.com>
 <diqzr0f7jbj6.fsf@ctop-sg.c.googlers.com>
 <Zhz8xNpQoi0wCQgL@yzhao56-desk.sh.intel.com>
 <Zh7Iay40VQgNvsFW@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zh7Iay40VQgNvsFW@google.com>
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB5964:EE_|IA1PR11MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c40a7b-cc5f-480e-deca-08dc5f2f8a6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGDi9rPSqRucxtWSWeoX1Sa47saCg3lYUyeUjfFeF4DhkBiDEYkOn68kN6G6nH8Wj1iezuXmkWlhg5bvHtJa2jCc4+XfDmqZySfejLhFW+/Vfoz6eSYLKxIESyqukqJGRuwfoJJIACYAwQGVBJaqORfLt0eh8kdqrf1gnME30RwQLlxdrBS+VUP4aK76YWliI1hQ9FqMjLeGWdkWERk0RqbSABsdIhlcD5MO25IgC+yUQfjQgqjs2vKLE3sMH7dsRO7rOjHWxdibzsTQSLAFwCn1WjXdcylpMc1GBaaLa5iKY9suMlj1Tz6Uxnp7OdV5RsCB35YaMzsfR/sdUf718EG1DMuLy/rdLAac72Z3v1Km84Z1vPhYvvH3dBeS2ssLaoOfhsaQbz0lyI0XtoJFPNr0VDHKKL4nL42Yq0iXtkWNq0cqWc1hVqWmnn+LaxS4KUEsH5ofRndrXfcwZx7rTWURNtl2SMGN7T+hFFkhL58BYnASyAnqgGWMsuT7IpztPURQYJGQpQQ6AE/WYq92LA23EQ6aaMC919DKH3C34ehvUOisijyAC/UAtnkY5bIFJGoPutwfGvaXSkeA0IOFjaOaY2bkaUqIY/k86WJQEmEzvGjzla7zVIsDV/D3fGDs4bseokcs3sI/8rN0x+eoYaBzjxobZo4XdrUDySboQMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Js8wGY4gUZsBmWTwEhjvYsRSUkfQ6J6QB0RNcThqD3vBvrqXjxfi3nQGoJQu?=
 =?us-ascii?Q?OZZ5bqJEBbTLq85wQUWNOhR9cpOcDZR48c7nenSzfjr+t0G/840euMsfA1Iv?=
 =?us-ascii?Q?QC1kM70fKZXs/b5AGt1G9DqWJjaHdZc/dorjCZFIg37EwcffJFc0LqptfEHx?=
 =?us-ascii?Q?9OrKyPLm21LruwGLTRguypsbWram4OY4YP4IVj+qk2LCx57nCvtb0QWfxYjl?=
 =?us-ascii?Q?QznWeXQfqxxX4Qo7Q3vD3d1KxuN4CllDMoHX3iAvN+8wVbXEKOEOjFjHUi+g?=
 =?us-ascii?Q?pLKmEK+IVNl4dJBw0XB0P1RZzbA+bfOztrRaSdlx7ZSEQYm4SBTKZnusWEdB?=
 =?us-ascii?Q?j8TUHG9z3srPQtruVH2YN5dK2R2amKdMNqTlmRWHU4n0BbVaCskCGiL24j+d?=
 =?us-ascii?Q?QlT1R3zjuF1MZo9+enOOEBCh8HfzX3NdO2/KRLTyojIFTQibGNmPPhDjkKxr?=
 =?us-ascii?Q?U0Duj1E0lyqMma2UGI7h5FIQ+oCbTW1cc30t+fpkQAKtrOcE/duGk8UhuxPg?=
 =?us-ascii?Q?g/whMCy439+p76OLitnXnphMLC1hwrJiP+7MFqve9+mDUnEzk3004I3zkmSX?=
 =?us-ascii?Q?Ypbw6xvhkJRuwFWUlxio4cYfmb9XTeZrVLYfZSaVBZOy9MTJoiPLBxCpSY/F?=
 =?us-ascii?Q?svY7FbQyOTHxSELCnXuy66+1EqPeW6uSl4MRmIXQrFrPe6njosVIQ6G1UqsP?=
 =?us-ascii?Q?3w71qT3Ky4vPkAfI+PhFCL0HVVe46TnjisKY+3ntlSsN2PZ/cpvhjPOvRW1O?=
 =?us-ascii?Q?mqs3LWNyyACZ4as/ovRJaum6yqIvAYijnd6/YVmEsDnrdWcGT4tiTsWhdfzb?=
 =?us-ascii?Q?UO74QvQZufE8+jj1zI6AVTlmNr+Nhm4KSXS6WX3e9rNNjq4GlXl7fI0e77sG?=
 =?us-ascii?Q?fduI54gjN0TAbBvBNfHSYocM2wKhxpT2b2ugMtorEd2XHyv7I+MGqaRBhLZw?=
 =?us-ascii?Q?Cht2k8eOhWzi4bvNM+Y2NtTENcQcBFhbQYBo4cm65Zv3v3m+a3mmC0CZhdnB?=
 =?us-ascii?Q?FMRoI5qwd8yl37NdtB1Btpmm/1rI+hu9C/hcJV6dXDj50YDHXw4/fb5Ec7ya?=
 =?us-ascii?Q?nRC1EP9NeIXDfAfJc9Wml1IAaeI9FWSVjJWAMjbiIUhGNbiA0qd4L0wl+FVp?=
 =?us-ascii?Q?3V4HHf8r4j6CNLaoGrfqvCiF508/tVLz7Jx6vkQat/rqEZa9g7zO7+1yiRxI?=
 =?us-ascii?Q?c4NutHzClqdUSqs54xdcWZWE4h3hZvikflaaGMytouDF3zmljBMn0DoOC4Im?=
 =?us-ascii?Q?axxels0K5IW6eeyvVfZKtOIv3lCAN8kY1EXdRXemod/oCxpUN3yfIbi9N1hg?=
 =?us-ascii?Q?VHZjvtYPNcRNKhED1TJBKr1Nb8MC5OOvziHBLynQ6/OB4aLnYFFL+askZrbQ?=
 =?us-ascii?Q?FQGDNjK0rJcWEinONbqoPrPdhFlGWw9KXbOlekCsz9G7RSeKBCtXWnAw+lco?=
 =?us-ascii?Q?+WQSHpxDzrYF2A6uoKxw3rxiZ8wL+6Sm/qyJM+5U05ncmG9mr7Sn0DkbvDqj?=
 =?us-ascii?Q?5l1fdlEMHYvR7hQdMTGX55y7C4U9UxdXCJQ4WS3D+cQgJwGxTABs1dKO0Kbe?=
 =?us-ascii?Q?pwC/DvT+XxlBDlg8cSzrJsix3us/gtorf9mW3pxO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c40a7b-cc5f-480e-deca-08dc5f2f8a6a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 22:41:51.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlOJh6PLYo5c0Azez0Sw6LVq/Ef7JALH4nGkGZaAxew/nx6GyAQ7TdoxgMHG7mbZbQINlc9spQ/dSS9cQnCVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
X-OriginatorOrg: intel.com

On Tue, Apr 16, 2024 at 11:50:19AM -0700, Sean Christopherson wrote:
> On Mon, Apr 15, 2024, Yan Zhao wrote:
> > On Mon, Apr 15, 2024 at 08:05:49AM +0000, Ackerley Tng wrote:
> > > >> The Intel GHCI Spec says in R12, bit 63 is set if the GPA is valid. As a
> > > > But above "__LINE__" is obviously not a valid GPA.
> > > >
> > > > Do you think it's better to check "data_gpa" is with shared bit on and
> > > > aligned in 4K before setting bit 63?
> > > >
> > > 
> > > I read "valid" in the spec to mean that the value in R13 "should be
> > > considered as useful" or "should be passed on to the host VMM via the
> > > TDX module", and not so much as in "validated".
> > > 
> > > We could validate the data_gpa as you suggested to check alignment and
> > > shared bit, but perhaps that could be a higher-level function that calls
> > > tdg_vp_vmcall_report_fatal_error()?
> > > 
> > > If it helps, shall we rename "data_gpa" to "data" for this lower-level,
> > > generic helper function and remove these two lines
> > > 
> > > if (data_gpa)
> > > 	error_code |= 0x8000000000000000;
> > > 
> > > A higher-level function could perhaps do the validation as you suggested
> > > and then set bit 63.
> > This could be all right. But I'm not sure if it would be a burden for
> > higher-level function to set bit 63 which is of GHCI details.
> > 
> > What about adding another "data_gpa_valid" parameter and then test
> > "data_gpa_valid" rather than test "data_gpa" to set bit 63?
> 
> Who cares what the GHCI says about validity?  The GHCI is a spec for getting
> random guests to play nice with random hosts.  Selftests own both, and the goal
> of selftests is to test that KVM (and KVM's dependencies) adhere to their relevant
> specs.  And more importantly, KVM is NOT inheriting the GHCI ABI verbatim[*].
> 
> So except for the bits and bobs that *KVM* (or the TDX module) gets involved in,
> just ignore the GHCI (or even deliberately abuse it).  To put it differently, use
> selftests verify *KVM's* ABI and functionality.
> 
> As it pertains to this thread, while I haven't looked at any of this in detail,
> I'm guessing that whether or not bit 63 is set is a complete "don't care", i.e.
> KVM and the TDX Module should pass it through as-is.
> 
> [*] https://lore.kernel.org/all/Zg18ul8Q4PGQMWam@google.com
Ok. It makes sense to KVM_EXIT_TDX.
But what if the TDVMCALL is handled in TDX specific code in kernel in future?
(not possible?)
Should guest set bits correctly according to GHCI?



