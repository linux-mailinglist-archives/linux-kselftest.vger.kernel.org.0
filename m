Return-Path: <linux-kselftest+bounces-7796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0869C8A2DD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 13:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E31C21127
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 11:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A855783;
	Fri, 12 Apr 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iH1fEoIf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C41C3FE55;
	Fri, 12 Apr 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923109; cv=fail; b=Fs45sFKU6J3Y/bXnYlcTm9+AwEceMdZ2JyEDUWA0bUYxWHsvZ5v/+iuxBZ9saj+SGFiBancDUL4L+qN/8nnMG6Xl4sTf86kAgNV3D5qa4G8sIcuJiOYC5scOz6xgLYjgbPY7H9YF5fdGDljtGWt4BzWPVsVBAf0QmnCiSNMSr0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923109; c=relaxed/simple;
	bh=tj6BYuGFlwo5BVeonyJod5tXysM0BiDe5MsOvmzb1cs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WD2oslYuM+dZR42DE8nG4x0LepfMe5ULC7yvGiGM9Lx14TZNP/jTJdOSBbAY9R6F/3Ole2Olp+aTQ6tKr9LvfVSkfneTel1eLfIy/aC2kGAaTooZgNVmWr3rcUTiyKkFi8EnhWOWGyisUG40+Pw3wHhLSNAbYyptAhE7Hmqpgt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iH1fEoIf; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712923107; x=1744459107;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=tj6BYuGFlwo5BVeonyJod5tXysM0BiDe5MsOvmzb1cs=;
  b=iH1fEoIfBIIdllyZHRPFrO/OHES4sN5N+XIu9nv4np8Ch/jGmlY5BrCe
   7XxaJtxGSSu/QaMters2OjQXGJTy9hVYIioDLNiU0FUZcUOuheJ4oq+Ks
   lLvuRP6N+PJDPsS3/U8LHhYJEPutc+ofMVS0z4st4pmOC211hNEnmkMzc
   4292d9M5gTOtD6V9gIBaxRoJxayxBXvmFUZ9HxyEUy4AiHqabgX35//kC
   EqPRkV9SpN9SghlJHYo9UdMyHCE5WicAfg0T8Xmd8+0NF3rxaNhiZG3NU
   vHfsU/Zxs6yRZwn2g13u1kdEoVyYt7AAVIXpz3n1j1h/2+gDIOtK6Dw3z
   g==;
X-CSE-ConnectionGUID: C5RVa+3XRBmviW0Hp+WJKg==
X-CSE-MsgGUID: IkP0907LRaCAeDXVFOoUrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19770031"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="19770031"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 04:58:26 -0700
X-CSE-ConnectionGUID: ygmezDUkQHyQEphMYmgZiQ==
X-CSE-MsgGUID: MW2R9ObmTmqOvfHboH5Yww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21190623"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 04:58:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 04:58:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 04:58:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 04:58:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS2fPt307S7c7L1G2EwRtWon1uz+rPy8V/ozXRVxpOCw6AkBEVpHbp/63XRVb2N80hh2ksJQT0eBJoAmxvmELQBcqZL0UsnGIMiEJDL33FnUXS+rQ6t4wPHAcIMpv71a34Ad2DzCo5g8dXt2bLGwerxk+NiBzPdCGDIaWi2m5xnUJ3VP82xAkcm0memTZ0FolPRBZX8AvoS7eLArCB/KYC1pRBOh3yjdY8JKhEkdIXTgRpDpIn3wd0T4HZ400+0qSvuVHU2n98M2DMwH+pNB4BJ4AwlOyoTuYJerPw/ZmnxV/Vg+jR8XZwu7Gmx0bP0dsgISjsjJeYcfSJlseuDniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2PAv8IVmPE/yS3mQ4rL6zN1JM8d0uW0WtYKOt31890=;
 b=h9HX0WQVhdI/NOnIaIj+hVFJWOnzh1J2m0juLhdcGw0tJTnSm+LylMhh4wGVRiXNH0lq/DXnDTmh2VF10JL2yFp1UxRZnp5FpBw3OhNw478cl3FEaJdX2wNDDakxXWo5drMHfRGJBzAjXTZoOfO1+ExWi/+x5cyLEIvUFFJ35J0AAvhvoj3Bcf2zBMvdpamCIbZnu5WMdEax+SSSKN3EsZJ7wQ4aUP/tIFobUr9ZE87gRQPaJ2rXTdZ41pcktQqhcjWXiK/+9VAq8qd6Qwqva3YlS5pgcPss+8M1QwyIhttftzmBTPVVAU7Uzgcp6dPChHMWQvWo0xjRQXFh7A/KCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7430.46; Fri, 12 Apr 2024 11:58:18 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7472.025; Fri, 12 Apr 2024
 11:58:18 +0000
Date: Fri, 12 Apr 2024 19:57:50 +0800
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
Message-ID: <ZhkhvtijbhxKKAEk@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <ZeHFlsrBKWR6bfRZ@yzhao56-desk.sh.intel.com>
 <diqzwmp3ji0r.fsf@ctop-sg.c.googlers.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <diqzwmp3ji0r.fsf@ctop-sg.c.googlers.com>
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM4PR11MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 103cef75-9643-494f-b476-08dc5ae7d7e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMl7LQbGmm85ZeoK647Dh7giisOj/gcvtLRsDpbeOzveb6MzLdLckzOyI/1KYHLiRxGpWXDYbkohRzzQfBg1zvQYr0+/fdnB3hYRL9iiXzJ2qr3xekBul+dEzEHfjs6oCWUyeWg9Tu/G9DdwrC6iZ7Lfk8/R+XGYrywYvwIDS2n171/pEbtXkH35LcNfXSEqTOj57vcYHMhVi/P2t/rmdQpSK1MPteB8ZwWMLQ66D+cirnKZpWI+k+RG04m+Hvk5SSGXrv6MBhr8gmSnK5eFRGmWyHROQP/I8pzJfTnm77UOFDU0l6QDfw8bvdaI3XfWgWKRb3W36Zy3zdjruKRjv2ehx2Jif/sfokuXs3IDxyzw0Y+crEfi2JuolhjcvVlFWXVpSkvZ3niqLD3P6orE56zqGpg1WRfSUg5sglsrPi+85v+C1fxcq7vFypBOGCa/MOeNO4lJiTBIqWR5Ldj6UedMo7ryygJXqAEWNjf/ECtaSZF40G5LjnnugUptgsuDuC7pMQAozHRMZqAUWnEUUYx9qhG+jabtY99H5AVkSDQl7p7e4O0aU+J+XdUr4MdWe+hrAXnz6rW8zRVtyfE+P0zIXhZQTLzO0/Hb7UysV++WJEiAj9EVHdeZR133b5F7J3Oe3MgBoLOB+wMw79jgNBVKzdj7zFDaz1TVJ1GPueI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m1dKb71r9T9N1thuLe0qtByWU8hRYf8iU00IiSv+4RaFTmFstoBzqDKFcsY9?=
 =?us-ascii?Q?yaL8F9gYu89lAnrkNHeYr3xvprJW4y0xd1qYqRh4jJoCW1thOlhkSuVvmh3q?=
 =?us-ascii?Q?LlDbKnNZU13x2ljkH6FaHOjssq0lHWffdIrZGPcQ348Yv3XleUlDhmIov33m?=
 =?us-ascii?Q?XWGWQjYB4BrfPjfL/wABOUcliVGIliR2nKVppiWY2KSpH4CXiC7nuy/EpiWb?=
 =?us-ascii?Q?sqA6NU6EShOhWCTAANohVLdQnzIHtAEt0+1Rwo2gDvboHXbSiBcHB0IobIga?=
 =?us-ascii?Q?nYxbDp854g7YREvgV55nhGK4TW8G5kVZp1prLZkM3gJYUsozjQ1jxrcwOO4V?=
 =?us-ascii?Q?W4AAskLKEO9sHbGnS3Ox4GlFWaZDDoCP6qsugbAUPgt65L9kCqiUgo4l0VXW?=
 =?us-ascii?Q?i0y47bnUJ030h0erw875SmW7AbdRt5M6pTP2XbkjE3KJbl8n+r7zVl6xkJnS?=
 =?us-ascii?Q?OrbbSx9n/WpiUrEhDGOIO9FZ801Sj96UYZRK+NVT4+kzsNATg2KWEma7tOsX?=
 =?us-ascii?Q?BIQl6bV9ddPxSlnXhmYIszf4JFoukpCsaYPSuvoj3QnWJs7mRrJzuptP1jsT?=
 =?us-ascii?Q?hoMFZJVJAX9RAeVrNg1hjoxVeJyhxzZyPtip2f+aDm8gXc+ITEsjN4S5gRvC?=
 =?us-ascii?Q?L0E9tEKbjfEywu52eaLSkaPVoGS8+A4AmYj8odeM/R0ZzHo4Rd9eCuJHNqEg?=
 =?us-ascii?Q?n6cWuU1d1xph3nq3kVAKsp28HEzG+/Mqgowo+WDheNsEKwWHmlzfzjFG/w3s?=
 =?us-ascii?Q?y2ChPMoQD9NMxg++IrOldz6SKxJogZM19cFeQp6epEa7uyw8p4V4STkMyyfL?=
 =?us-ascii?Q?jjIPOwmLl7QrrDIB0TteI0yXdqv8wDSMh/pknrSl7ruALgZlUz/FuLU8FYft?=
 =?us-ascii?Q?HqYOYIjk80s7G3zBky9kZJkf4BNux85XG+cxgSMfoITs/+UG9YqLnTOjudpT?=
 =?us-ascii?Q?oEGf4U+q3UhHU2ubpIpUmWRrXisjEjUKoAIbRQlS9AbHQNove0z+gnHcnyA6?=
 =?us-ascii?Q?WlD0dEYHB3o6+o6zZRsEivbIB+SSHTVUISKAhgHgRvYQx31vLMpTf9P4mWs8?=
 =?us-ascii?Q?buEWHJAGAovMAor9E/qSYBEuYMsw3GcgKsLg6A8bqzTpsWQ263osgvNVmGqc?=
 =?us-ascii?Q?GYYrwK3HkSWjAjhjdhRQT8gcQZxXXLYsDugjcWBYtd489JhKWgqsDW7j4Wo/?=
 =?us-ascii?Q?LUkQ5XtUIO9FpAA1D1MUZP3DMQ7q1DLilebO+hbeSln3fI5dRe9ie6YbUV7I?=
 =?us-ascii?Q?QPlw0gAm5xKvyCf7R2jY1f5kKqS/fNgPaoHOvYzc/ZH53j4LJKBCOeGrclaW?=
 =?us-ascii?Q?1kVOtcizvpvebKFSEuwYH2ImCn+VTcwHCmqTgeKAVTTEpshzHzXqgy86NdaC?=
 =?us-ascii?Q?SoTWZr9+IwQytUmZY5u5YNiHdCktmsAgZJwCL3UJLLQ9mczgMowgqPlr0Jon?=
 =?us-ascii?Q?WOEPrI1rThizOZS3ywEy3Hfzop9WJjLV93XLZvXg98MYGqbKD85uugcYEJAO?=
 =?us-ascii?Q?g+n4fLYEOTY4V3Ua4lSutZCtV3kxdsL4sEpTzTqniuBCq5KGRkQuVLj98L5L?=
 =?us-ascii?Q?Hdlw30Rcu8aKuarF5Z9KnWNp8sEepCU9PmI43eVX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 103cef75-9643-494f-b476-08dc5ae7d7e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 11:58:18.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nj2/AhWtZjnMeT2/lv7RmYW9immonWG4t/MCGnZwyXP6JOso/9WLXgdMpwg0khg0nCkPmdx6qIWInSITG0vKpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
X-OriginatorOrg: intel.com

On Fri, Apr 12, 2024 at 04:56:36AM +0000, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > ...
> >> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> >> index b570b6d978ff..6d69921136bd 100644
> >> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> >> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> >> @@ -49,4 +49,23 @@ bool is_tdx_enabled(void);
> >>   */
> >>  void tdx_test_success(void);
> >>  
> >> +/**
> >> + * Report an error with @error_code to userspace.
> >> + *
> >> + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
> >> + * is not expected to continue beyond this point.
> >> + */
> >> +void tdx_test_fatal(uint64_t error_code);
> >> +
> >> +/**
> >> + * Report an error with @error_code to userspace.
> >> + *
> >> + * @data_gpa may point to an optional shared guest memory holding the error
> >> + * string.
> >> + *
> >> + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
> >> + * is not expected to continue beyond this point.
> >> + */
> >> +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
> > I found nowhere is using "data_gpa" as a gpa, even in patch 23, it's
> > usage is to pass a line number ("tdx_test_fatal_with_data(ret, __LINE__)").
> >
> >
> 
> This function tdx_test_fatal_with_data() is meant to provide a generic
> interface for TDX tests to use TDG.VP.VMCALL<ReportFatalError>, and so
> the parameters of tdx_test_fatal_with_data() generically allow error_code and
> data_gpa to be specified.
> 
> The tests just happen to use the data_gpa parameter to pass __LINE__ to
> the host VMM, but other tests in future that use the
> tdx_test_fatal_with_data() function in the TDX testing library could
> actually pass a GPA through using data_gpa.
> 
> >>  #endif // SELFTEST_TDX_TEST_UTIL_H
> >> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> >> index c2414523487a..b854c3aa34ff 100644
> >> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> >> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> >> @@ -1,8 +1,31 @@
> >>  // SPDX-License-Identifier: GPL-2.0-only
> >>  
> >> +#include <string.h>
> >> +
> >>  #include "tdx/tdcall.h"
> >>  #include "tdx/tdx.h"
> >>  
> >> +void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)
> >> +{
> >> +	struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
> >> +	uint64_t vmcall_subfunction = vmcall_info->subfunction;
> >> +
> >> +	switch (vmcall_subfunction) {
> >> +	case TDG_VP_VMCALL_REPORT_FATAL_ERROR:
> >> +		vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
> >> +		vcpu->run->system_event.ndata = 3;
> >> +		vcpu->run->system_event.data[0] =
> >> +			TDG_VP_VMCALL_REPORT_FATAL_ERROR;
> >> +		vcpu->run->system_event.data[1] = vmcall_info->in_r12;
> >> +		vcpu->run->system_event.data[2] = vmcall_info->in_r13;
> >> +		vmcall_info->status_code = 0;
> >> +		break;
> >> +	default:
> >> +		TEST_FAIL("TD VMCALL subfunction %lu is unsupported.\n",
> >> +			  vmcall_subfunction);
> >> +	}
> >> +}
> >> +
> >>  uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> >>  				      uint64_t write, uint64_t *data)
> >>  {
> >> @@ -25,3 +48,19 @@ uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> >>  
> >>  	return ret;
> >>  }
> >> +
> >> +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
> >> +{
> >> +	struct tdx_hypercall_args args;
> >> +
> >> +	memset(&args, 0, sizeof(struct tdx_hypercall_args));
> >> +
> >> +	if (data_gpa)
> >> +		error_code |= 0x8000000000000000;
> >> 
> > So, why this error_code needs to set bit 63?
> >
> >
> 
> The Intel GHCI Spec says in R12, bit 63 is set if the GPA is valid. As a
But above "__LINE__" is obviously not a valid GPA.

Do you think it's better to check "data_gpa" is with shared bit on and
aligned in 4K before setting bit 63?

> generic TDX testing library function, this check allows the user to use
> tdg_vp_vmcall_report_fatal_error() with error_code and data_gpa and not
> worry about setting bit 63 before calling
> tdg_vp_vmcall_report_fatal_error(), though if the user set bit 63 before
> that, there is no issue.
> 
> >> +	args.r11 = TDG_VP_VMCALL_REPORT_FATAL_ERROR;
> >> +	args.r12 = error_code;
> >> +	args.r13 = data_gpa;
> >> +
> >> +	__tdx_hypercall(&args, 0);
> >> +}
> 
> >> <snip>
> 

