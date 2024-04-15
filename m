Return-Path: <linux-kselftest+bounces-7953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E18A4C49
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 12:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6991F2222D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2FF481DE;
	Mon, 15 Apr 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSS6pd8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFAD535A7;
	Mon, 15 Apr 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175817; cv=fail; b=WlYPuxt0VH45l6bg//Z0vuXAuTSSJ99NT1GsmM27MbTnTp/9C0yQl5lBlAM5KYOxmZFzCs7E7s/fEdkh/f0zWOQXptOqUya/p+bh/jEEiBYPO7YQRMQfcCTATAivzOJlbP1DKlLqenumEc/RN3qDlmeZcNF7TRQtUX4BmUoiI9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175817; c=relaxed/simple;
	bh=cnkca2+vRqldadARITTLfTxuwDXlLnPqipdafeIgBGQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ob3wVZQkV8KF82wSf7bKG8KiWaqrIH/rv00PQALk9JLJiTU9UAz3CkHRvn51irOcfPBEUyjf2ctmK60GbmJKZWCF+orTtG2O+Z5nn6KtLneiv997QaydXzqso3qxLSCCilR50pUUZ6QsIM0+dGNttbgzLu4qleaOqcHJymj3yYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSS6pd8w; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713175816; x=1744711816;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=cnkca2+vRqldadARITTLfTxuwDXlLnPqipdafeIgBGQ=;
  b=SSS6pd8wyktqscNScUsaWF513VVlLNZtFg0cIUvDmV4TVxfgO4rfuJRZ
   WVXS8uAMu/8h1ZXYf4GgTOObvclI94KUF+d1/Dd4OTOIzf9opH4fDdpHx
   b0B/KFa0uV1FycBGZl/uCzcvbTdJz2wBlyFneQPDJmhaXOLQz2yGOtyxu
   s8sTOTu50Xjk586nJ9y3mg95HHKwP0AJMqgdAh5IYSIjkYwWKak1JSFNh
   8GublAYKebDWaLumFOs1qsS/X4ZiCjkHvoLtwd+NPTdlg6la0fs20QvSU
   A42sm4dNsFAQPdzd8a3AKc2thO/u1JN/Clk7/xaR820yr45nUVgWUM8VO
   w==;
X-CSE-ConnectionGUID: m3qKZ5foSZephiyjCnzjlw==
X-CSE-MsgGUID: S9WUmxHbRni2YQbs2t8/7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8428018"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8428018"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 03:10:14 -0700
X-CSE-ConnectionGUID: aEL0WTDYR+CMERV9k9LRdg==
X-CSE-MsgGUID: +/AxuOw2TmCVwfIj1Ob18Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="53077242"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 03:10:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 03:10:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 03:10:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 03:10:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 03:10:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLCRcouhVhnodrxLMxKrhiNMsERq0pEgGeaiL4s0jQGD3eMDZEftAO3oZJXNv9lhmTziUmQ/0yyotT5OznhX8Lbs59+Eq20aXBpTwHW9hDpAW+v7Iu9uVqhc9oPssmBz2w4m4Y6z8XNL4DnDSntqrORUN3VOYw52duQqvVzzDYOo9GL/DOyFVmhRQQpacLuKONzRCywEJEKuIuE1RyvkxQiu+Em7gMvoYDIhSnQhXsg5LKjHPk9Oxx2WdE4aTKsP/ij4/zVOzlhuU+1rMIXD8MAfYP0rv7MY5VrB3xOfAVBecgDwjuw56lL8lK1rYislcv4A2d3ULgkFYwfJuv1kAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtJKYEqqPA3yGVWPmfWndYy6M0D8hAUjf+Imkc1qoko=;
 b=Dznh9gSthV0Mx+eyL5b1LxK7qxc+dhevvgBWorFN6IregDtt9fFrA8Mpng4bGWakZv0YlVhQCzzm2SBnIYpgr/5UsLklbXM9VMY43K0u0WLiydmNZJ6hrQdlU8OaqXsB1xQkl3/xkCCSKQJd3mt5lkYw9U5/0FlnaN3H5UE2mbh2iU9RX3qcvvssC07F/ORdSougYNXMn6TePjQGU67DBhXWyPUScCFrA+Fjbk4MAxx44dEtlCZARtGQkVnpxPt7HCdRdah0/tbRKKxC3ZOIXzUeF9L5cB/eeRtwMn1v6DTklHHOX5xZe/93+U3ZUu9sTaGx3lDtakybE+ehH0Ad6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 10:09:39 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 10:09:39 +0000
Date: Mon, 15 Apr 2024 18:09:08 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <sagis@google.com>, <linux-kselftest@vger.kernel.org>,
	<afranji@google.com>, <erdemaktas@google.com>, <isaku.yamahata@intel.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<pgonda@google.com>, <haibo1.xu@intel.com>, <chao.p.peng@linux.intel.com>,
	<vannapurve@google.com>, <runanwang@google.com>, <vipinsh@google.com>,
	<jmattson@google.com>, <dmatlack@google.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 09/29] KVM: selftests: TDX: Add report_fatal_error
 test
Message-ID: <Zhz8xNpQoi0wCQgL@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <ZhkhvtijbhxKKAEk@yzhao56-desk.sh.intel.com>
 <diqzr0f7jbj6.fsf@ctop-sg.c.googlers.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <diqzr0f7jbj6.fsf@ctop-sg.c.googlers.com>
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SJ2PR11MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f17611a-eb72-4249-13e2-08dc5d34297a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCdeUWduqIarQZIlO6IKqMdm5v9Fgb/O+IhJ5MWvnd0BvmjEk8TqxhBgCjQQNmXAWNz+qZC8NPxWonfpu7AvoheSPBpDy4n3wrOrvo1C5ZLYyGFSNUGmC27LdMyNYLzd4A58M8aAwHn5NFbvu3HXdo8yoJoWWEw3h/nN79B7y/j4rhYpPS38RKrEplRRlVRrMPiq6o6z1HwHrmiEZF72YcKLmZjfjFZjbAmmyefWBfaLqnB7JdBvMlWqk98800yc1bYxez0JluhX4cbvLGT3GuIDPpt01oXD2rxGpJwO7Cc3jeC8ipFuFHUJfVGFU47i76pn8s53a2AW+yZqK/cVOHiFW0XxFh7R9PE87udCHLHGMrHGiN2Ov9p3Of+NxHFiqm+LemqRP1ayjuWZRjqSSsT4OIcQulWH6CNLO2uATLQExBdgA0KmCsrnOiwcR3G6wVlAem6sxFpyUyloXW+SZBCSA2b9ruTpR15LAx+16dn71oiwPY10gQLH2wl9sq9pv0lwX7UW46lNW7GWl4aXLgpIuF0DR2wokudTQOBuNOBODTgURpuVCE5k/fTTnJHwub9bDJMNGjVoIN/IML7ETb6F0dJnpZPeRWSHYSDCGJS7sEpdV9cJ4AI0pwyZZ8zESOLkUpL6up4ru0IDeyDiznEzZoso09CFClsNDOjDvBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6lP3nxQmPwcGChz5Sc66C76x6nCfyrLcgapSxIdnJ78ReGFtdPwyLzRT1rv4?=
 =?us-ascii?Q?KZUn2nWExbdP3YHL3af7S6VjmAE+xO0XbHFsjQB+j4HZ3NWfoMM7n0GDGj0x?=
 =?us-ascii?Q?SutaGSALwZ3EEeHECZ0VEL3xl7c0K4M9UsFGPbnudiOiTTcWiqQWQ1eE3A8t?=
 =?us-ascii?Q?CcXiVGmNV5Wql6m5iIE8D2V1jbIf2p/V7kuo440p2Vg5/pTfaHQQnFTmRsVy?=
 =?us-ascii?Q?ix0RQOjbJUlUqXcjdLD6b2FkjNzAIqf037lWoER3syLzfq34FcbetdGtclz6?=
 =?us-ascii?Q?CPnQUHkp2pCP98AgM2GtdD3jUk1awXJNVzeXFkDQ2hqCxhX9ILaDo8UJSx0g?=
 =?us-ascii?Q?MdjG+JPHchNJdtoNyKA3MebU26yJpmg7rzOWq4uIHi/zLq4YFv7+gOmJCEHF?=
 =?us-ascii?Q?f0Ujbyx7SmYP/p534TaVGs71/sEel66EVdFPr1LiXX0h9QS5bh/IR2xJfkEv?=
 =?us-ascii?Q?ziQ8IYKhT+VftxWY20M3vbRyzvZOKvUOQEJxVWid6OHEkrFNESemyg3+H81B?=
 =?us-ascii?Q?NlFRjuBVhErvnDEdq+ZbtqM/jJjOL/3g9z06cLwQrk8gum5G1Oyh8wWl+/4x?=
 =?us-ascii?Q?Mq3DqO34Ep8USRMUgikkpRbsbHo37k4FHN9Lrzxot9v1j3pp2PsZDnVgTfwK?=
 =?us-ascii?Q?yFMk40hYgtcthEWwEd5oqqxH96BiTlT4DwSsLpWwKmaGSAcGnE5FLVRmK4q8?=
 =?us-ascii?Q?ypn/aGx1M1bCtrIpU6Gs0gbcGfKIiJ+Ca+lXIZc5BVzDs35PTXlLchdXJGLw?=
 =?us-ascii?Q?oOztECv1NuDZRD1jCnZ3ajT8RqXpVA819TtqICcRwpEZ/Mczsi8Nu0Cz/qRa?=
 =?us-ascii?Q?M++3rdNeteCNP3v2J5XiUqo2Li3UM8Rsu4m3NrizKxAaCOczPdP0XZp640fX?=
 =?us-ascii?Q?XVAkr4l3UQEgzKA86uc1x1RNmSvM68taVds4QFcK0X3it++ib+UnUe/528xc?=
 =?us-ascii?Q?ZCtzSP+Zabgj/5iEiECUDZFFvoOxML6dD925tgfGF9Ry01ZF6BDyJOIq6EK6?=
 =?us-ascii?Q?gfR6lvC6ADK/qfoUWwS1nxcrSOh6N8adtQnvAaWABSx9utqLNSpH9xx0su6M?=
 =?us-ascii?Q?2sB/GILlE7cAgPs8uzDJ7RtqRGkiJAb+xCrsJZv48NaW+1GrdDBt2k04L4qo?=
 =?us-ascii?Q?LAhc+Iw1fUdrVkTtK9Jymro0dqeD6doJMNiHXQqli7TZEctOdw7A6rIp2U2s?=
 =?us-ascii?Q?Mkafwu/jpOgUcXBTvVHNA5g4qQKFjqdoWjQxgratwpAe6Ijittu+9i7UZ8fh?=
 =?us-ascii?Q?X/AFTdbFDRMe0tdl1tWv4BKSr9o4t4LX6X4D22nQtrAGra9ggNEzI1ORlAV8?=
 =?us-ascii?Q?ZJhH5GKqK7ZzjZ6oYYKgHL194nMLsaB15qYCAnhSnAmWXsMip4HHPecoyN6J?=
 =?us-ascii?Q?vLMhcExd8h4qRQIRVwuHHCPfijQxgDb++nW8jZnMo9tLTs29GrFe7WDiGATa?=
 =?us-ascii?Q?uaBjA7lwY9zLlzg3CVFOCo/D8JTvHomxavP8r/N6E/hCYnEiwibl5UsgUZ/0?=
 =?us-ascii?Q?+o0WLY9bE/d5PHA6J8hZ3k/0Q0tnXfK3eYTkoaxAV+zu7fAQsCCFZ0zG7vkO?=
 =?us-ascii?Q?L3GnLvcafWJ7PcPS62eScrHZCnxgN1IKxt8WCcOs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f17611a-eb72-4249-13e2-08dc5d34297a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 10:09:39.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoQ3M0UJq6u4Ys+ZTJtZ/P06KhWswHw3mk3v80gNCgdGVhG9DOfcWNxhtrP8mslhez0puWCfEZL0+qRagbKGhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com

On Mon, Apr 15, 2024 at 08:05:49AM +0000, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > On Fri, Apr 12, 2024 at 04:56:36AM +0000, Ackerley Tng wrote:
> >> Yan Zhao <yan.y.zhao@intel.com> writes:
> >> 
> >> > ...
> >> >> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> >> >> index b570b6d978ff..6d69921136bd 100644
> >> >> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> >> >> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> >> >> @@ -49,4 +49,23 @@ bool is_tdx_enabled(void);
> >> >>   */
> >> >>  void tdx_test_success(void);
> >> >>  
> >> >> +/**
> >> >> + * Report an error with @error_code to userspace.
> >> >> + *
> >> >> + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
> >> >> + * is not expected to continue beyond this point.
> >> >> + */
> >> >> +void tdx_test_fatal(uint64_t error_code);
> >> >> +
> >> >> +/**
> >> >> + * Report an error with @error_code to userspace.
> >> >> + *
> >> >> + * @data_gpa may point to an optional shared guest memory holding the error
> >> >> + * string.
> >> >> + *
> >> >> + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
> >> >> + * is not expected to continue beyond this point.
> >> >> + */
> >> >> +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
> >> > I found nowhere is using "data_gpa" as a gpa, even in patch 23, it's
> >> > usage is to pass a line number ("tdx_test_fatal_with_data(ret, __LINE__)").
> >> >
> >> >
> >> 
> >> This function tdx_test_fatal_with_data() is meant to provide a generic
> >> interface for TDX tests to use TDG.VP.VMCALL<ReportFatalError>, and so
> >> the parameters of tdx_test_fatal_with_data() generically allow error_code and
> >> data_gpa to be specified.
> >> 
> >> The tests just happen to use the data_gpa parameter to pass __LINE__ to
> >> the host VMM, but other tests in future that use the
> >> tdx_test_fatal_with_data() function in the TDX testing library could
> >> actually pass a GPA through using data_gpa.
> >> 
> >> >>  #endif // SELFTEST_TDX_TEST_UTIL_H
> >> >> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> >> >> index c2414523487a..b854c3aa34ff 100644
> >> >> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> >> >> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> >> >> @@ -1,8 +1,31 @@
> >> >>  // SPDX-License-Identifier: GPL-2.0-only
> >> >>  
> >> >> +#include <string.h>
> >> >> +
> >> >>  #include "tdx/tdcall.h"
> >> >>  #include "tdx/tdx.h"
> >> >>  
> >> >> +void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)
> >> >> +{
> >> >> +	struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
> >> >> +	uint64_t vmcall_subfunction = vmcall_info->subfunction;
> >> >> +
> >> >> +	switch (vmcall_subfunction) {
> >> >> +	case TDG_VP_VMCALL_REPORT_FATAL_ERROR:
> >> >> +		vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
> >> >> +		vcpu->run->system_event.ndata = 3;
> >> >> +		vcpu->run->system_event.data[0] =
> >> >> +			TDG_VP_VMCALL_REPORT_FATAL_ERROR;
> >> >> +		vcpu->run->system_event.data[1] = vmcall_info->in_r12;
> >> >> +		vcpu->run->system_event.data[2] = vmcall_info->in_r13;
> >> >> +		vmcall_info->status_code = 0;
> >> >> +		break;
> >> >> +	default:
> >> >> +		TEST_FAIL("TD VMCALL subfunction %lu is unsupported.\n",
> >> >> +			  vmcall_subfunction);
> >> >> +	}
> >> >> +}
> >> >> +
> >> >>  uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> >> >>  				      uint64_t write, uint64_t *data)
> >> >>  {
> >> >> @@ -25,3 +48,19 @@ uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> >> >>  
> >> >>  	return ret;
> >> >>  }
> >> >> +
> >> >> +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
> >> >> +{
> >> >> +	struct tdx_hypercall_args args;
> >> >> +
> >> >> +	memset(&args, 0, sizeof(struct tdx_hypercall_args));
> >> >> +
> >> >> +	if (data_gpa)
> >> >> +		error_code |= 0x8000000000000000;
> >> >> 
> >> > So, why this error_code needs to set bit 63?
> >> >
> >> >
> >> 
> >> The Intel GHCI Spec says in R12, bit 63 is set if the GPA is valid. As a
> > But above "__LINE__" is obviously not a valid GPA.
> >
> > Do you think it's better to check "data_gpa" is with shared bit on and
> > aligned in 4K before setting bit 63?
> >
> 
> I read "valid" in the spec to mean that the value in R13 "should be
> considered as useful" or "should be passed on to the host VMM via the
> TDX module", and not so much as in "validated".
> 
> We could validate the data_gpa as you suggested to check alignment and
> shared bit, but perhaps that could be a higher-level function that calls
> tdg_vp_vmcall_report_fatal_error()?
> 
> If it helps, shall we rename "data_gpa" to "data" for this lower-level,
> generic helper function and remove these two lines
> 
> if (data_gpa)
> 	error_code |= 0x8000000000000000;
> 
> A higher-level function could perhaps do the validation as you suggested
> and then set bit 63.
This could be all right. But I'm not sure if it would be a burden for
higher-level function to set bit 63 which is of GHCI details.

What about adding another "data_gpa_valid" parameter and then test
"data_gpa_valid" rather than test "data_gpa" to set bit 63?

> 
> Are you objecting to the use of R13 to hold extra test information, such
> as __LINE__?
> 
> I feel that R13 is just another register that could be used to hold
> error information, and in the case of this test, we can use it to send
> __LINE__ to aid in debugging selftests. On the host side of the
> selftest we can printf() :).
>
Hmm, I just feel it's confusing to use R13 as error code holder and set
gpa_valid bit on at the same time.
As it looks complicated to convert __LINE__ to a string in a shared GPA,
maybe it's ok to pass it in R13 :)

> >> generic TDX testing library function, this check allows the user to use
> >> tdg_vp_vmcall_report_fatal_error() with error_code and data_gpa and not
> >> worry about setting bit 63 before calling
> >> tdg_vp_vmcall_report_fatal_error(), though if the user set bit 63 before
> >> that, there is no issue.
> >> 
> >> >> +	args.r11 = TDG_VP_VMCALL_REPORT_FATAL_ERROR;
> >> >> +	args.r12 = error_code;
> >> >> +	args.r13 = data_gpa;
> >> >> +
> >> >> +	__tdx_hypercall(&args, 0);
> >> >> +}
> >> 
> >> >> <snip>
> >> 

