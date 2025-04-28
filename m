Return-Path: <linux-kselftest+bounces-31745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43A3A9E599
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 03:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BDB176447
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 01:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C232C85;
	Mon, 28 Apr 2025 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRGymafH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9903DBA34;
	Mon, 28 Apr 2025 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745802499; cv=fail; b=X38EZn7qWPc99G+0vzxdtFpXFCfyeSLl+ml/pkp3SA848W5G/u5ZAIsc5rO2bcNLbKRB3XDC2v4MZvrrfEH5WHFf1Tff+Y6BcP/rak3LosINgI/U4GkflOKPf9kvh8l3C9Fn1d2XhXl8Rh8De8iwh6Id5s2ExfoMp7T2UEINCJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745802499; c=relaxed/simple;
	bh=3bkPO/C42PLyZ7hVYY/Zrj9KBsfM2+S3SLOnMFK0A4s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c8wcUws2jpcyM2oXJ300q9VuYOxtSu8VLuHIXJLQNv3+gFhFYQEFHzdhx/w2i6gfzuIoDSFZGodR7uWIL9vmRmlfq5kaYG6g+sKKjY7McHyB4GTm8TneM18hqq5bv3/BdneX8gx/Ow+0qYA4cQPrQeuyksC8SIvyN+s30dQFYW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRGymafH; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745802498; x=1777338498;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3bkPO/C42PLyZ7hVYY/Zrj9KBsfM2+S3SLOnMFK0A4s=;
  b=BRGymafHT2NMMNbPkWAdlpV/er9t6mQRCc663kmHN6+t0k9xBU9TcqFk
   z4DvqHOgudBGGeeSB4ezyoQMVYaDYMKE1ptws+fjlTxpiRIhOyy+pQLTp
   lXHqpd5uouyUeGrm5hisRcpeiwYbM+LYqPjAGNyTH/zQAhtPzYXAUQ2c8
   ZT5VoZPk/UPfZKOnDNoh78yCDHdrpZgy/yjbwKmzhEA0bi04pGQt96H5k
   RHglToysZ9KwhXtjjV2PoOqjg8wAnGqmGbMhO5zI0wUCNXIUbIhK+24jK
   2Jc8xdaZLuZxa9AVl58k64/8yqTf/Pk+aOjUFDi+4HHt8UAS9GIJIOsKp
   w==;
X-CSE-ConnectionGUID: 9gu5p3baTWi6Mfe0/m5F5g==
X-CSE-MsgGUID: J0lyJzenQQivfvpKNmvlww==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="46499587"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="46499587"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 18:08:15 -0700
X-CSE-ConnectionGUID: FYYFVoyXREe3HP0p4MDoHg==
X-CSE-MsgGUID: 10rdBWxYREWp0qVnOChJVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="170594771"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 18:08:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 27 Apr 2025 18:08:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 27 Apr 2025 18:08:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 27 Apr 2025 18:08:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSen+Yhro1igoCjTGcfD+HU4Kw3uirzOmvDI1ALtxAob7fFr5c4+cYvAfwolrbFvNCsw78zefhU14FOmRwchDDhqmXUlR4xQ0Dw6X9uyHYeXzp2mvMgo4pVwPVcgXYHVrVYEmRlO0CsuMQkvfZppZI2D6N7Z1ZpDPEq05InENduAM8gJGmBKWAzj9AeOeOpKr5TwcZzM78dR+H9yRgmmmPBqWjjeG07m9AQQfuVj08NWXyeIPZTbWL/9gppfsUHTZFjOXRJATKgOlysiWiuL9LDRkVnfu65BFrK7BCqFQVpyfBEHw1CK2agwgHHbnNKZ9tnzE0wmk+6GxbTX4/vbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8Y3H/dmF+99qMtWOiSsTuW84Lww9d5DpZG3tcGJO/U=;
 b=COnHKrp6R+qtqSxiHMTFb/qYOolFVY2XIuLBB+dOhsLopH2LZt8wBdrj9nVzrClUp2LVv6S4aQUF1+GHgNbwSTWo4LAE7nuBT7r74Idb5y8bYjPelCURcJpiON7hMtj0vrxe8WX5x32eNw2LiJ4Cj2UzznIHEQgpN8Ig7nh05sCrV2usQqwjiWgDk+NOmHAeUVRy5X1TubvMtEVpvnjPJPETbqa/0CCN5bDeV1Jh30Pi0duHYCWNrdt1kGjgIH7mkfd5nsICWCsUbOWCMFU8cMcNM2hwXYETrCfPAKvsOJdtzCxNOxEnabKWv8IJuGh7YVSB/EFkTbmFulvbLSgvJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SN7PR11MB6601.namprd11.prod.outlook.com (2603:10b6:806:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 01:07:39 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 01:07:38 +0000
Date: Mon, 28 Apr 2025 09:05:32 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: Vishal Annapurve <vannapurve@google.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>, <tabba@google.com>, <quic_eberman@quicinc.com>,
	<roypat@amazon.co.uk>, <jgg@nvidia.com>, <peterx@redhat.com>,
	<david@redhat.com>, <rientjes@google.com>, <fvdl@google.com>,
	<jthoughton@google.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<zhiquan1.li@intel.com>, <fan.du@intel.com>, <jun.miao@intel.com>,
	<isaku.yamahata@intel.com>, <muchun.song@linux.dev>, <erdemaktas@google.com>,
	<qperret@google.com>, <jhubbard@nvidia.com>, <willy@infradead.org>,
	<shuah@kernel.org>, <brauner@kernel.org>, <bfoster@redhat.com>,
	<kent.overstreet@linux.dev>, <pvorel@suse.cz>, <rppt@kernel.org>,
	<richard.weiyang@gmail.com>, <anup@brainfault.org>, <haibo1.xu@intel.com>,
	<ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically
 split/reconstruct HugeTLB page
Message-ID: <aA7UXI0NB7oQQrL2@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com>
 <diqzh62ezgdh.fsf@ackerleytng-ctop.c.googlers.com>
 <aAmPQssuN9Zba//b@yzhao56-desk.sh.intel.com>
 <aAm9OHGt6Ag7ztqs@yzhao56-desk.sh.intel.com>
 <c4dae65f-b5e6-44fa-b5ab-8614f1d47cb5@intel.com>
 <aAnytM/E6sIdvKNq@yzhao56-desk.sh.intel.com>
 <CAGtprH-Ana5A2hz_D+CQ0NYRVxfpR6e0Sojssym-UtUnYpOPqg@mail.gmail.com>
 <diqz7c39zas0.fsf@ackerleytng-ctop.c.googlers.com>
 <aAsJZuLjOAYriz8v@yzhao56-desk.sh.intel.com>
 <diqzwmb7yi67.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <diqzwmb7yi67.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: KL1PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:820:f::12) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SN7PR11MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 040e794b-22d5-431e-13a5-08dd85f11191
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTd2c0ZWRjA4TStpeWVKM05md2NFcGNMT0laa29KN3JuUXlMMUpTK05BakYr?=
 =?utf-8?B?QjhsTkdaZjBlNnNZVTlhMUs5OXdOdzhTTm9OV1Y3WnI5Tkc3Mk9EdW5Nb3pw?=
 =?utf-8?B?bG52TzkwZGNLQTNoWW9NZithZm0rMTNRN2IzYUxiblJ3TngyNVBDZzFIS0xH?=
 =?utf-8?B?dVNOaFIwYlp0dGE2cnU0anZXNGp1bTdoWlc0TC9lWCtHenZPRXdLV3VHOElP?=
 =?utf-8?B?L1hMZWUyZCtmNHNHNEVMWnUweVJTTXVqcjNwNWNKc3VTZUVGVUt5SnZSeVNz?=
 =?utf-8?B?RzdndVNHck5MMU55OG5MdC9oWXpJcUVsTmg4Z2lEdmFsRHlpejVwR202bDFw?=
 =?utf-8?B?SXdkSDJlRVFiQTlYdldtaDhLWTQ5OVhHVXh6eE50SHgwclVNWVFMd2ZPeFN5?=
 =?utf-8?B?eStpTWE0QUpnYWgyNmlKVEt5SDFXNEx6VDVGTDBoWTZBRmx5Z2EwYlcrUEFF?=
 =?utf-8?B?dy9wVXVBL2NOQVdBcWZ5bXFFWFduSThVK2J5aXU1SG5tZzNhc2xOVmt6b096?=
 =?utf-8?B?WnV6NnNkMUJpbkdvWkt6L0FKbUd1UGJzb3NKSDdtcjhrcitsNzhQR0ZUSmNN?=
 =?utf-8?B?am5nNWxpd0ZyQ1dsZEZnczZDTURhd2RWSUhyTXRKWGE0aDB4Mnh3b1MxUjFZ?=
 =?utf-8?B?MUN4SXdiWjIveWJWZzlWZUxjSDdIMmVZdVZNaWxLNERuZTNGK05uMHJsUk1M?=
 =?utf-8?B?UzFiQlhKdnJvNHFEQWFybk8yaGh6VGx1VTFMUjVqenpydWhpZ3R1SUhlS1gx?=
 =?utf-8?B?NGJyNWtRbUFqTUFZUmxJQjI5WGpIbFJzcFkxNmtBeUhSaWozUGF1UXdOWUJx?=
 =?utf-8?B?S1R2UEc5SUtxY2w0Uk5vVHRpMG9zV1lqMDhmcHIxY3o1SkRkV0RKUHFTOWN5?=
 =?utf-8?B?YnF0V2lFSi9mRW9jcjhuZUV5UGNIbFNCQ1V3RU02ZEdIbmZsSGpGRVIwYmM0?=
 =?utf-8?B?UUxxaEF2Q21hL3Q2MUlMWVQyeVlYUDBIcmw0NEE3cFFWTmo2Z25ySDc5WDlr?=
 =?utf-8?B?L3BzemJDZSsyU2I1WDRKY3NxQnRVRldKYUdwWjBzbWdDSk1KTXI3SUtGTmg4?=
 =?utf-8?B?dFFtbk9xcHdrSitjVzRrY1NSb3VISDNQbVFCZXJFNTFabFNzMGQvTUtJbGh3?=
 =?utf-8?B?cW1xb3NzbDgzQmRZYWZJampxREF3eVAzak9wYStMWCt1MHhkcUhyNDd6OTlS?=
 =?utf-8?B?N2xhTG5GdlpPaHJzeVBQM3BBRitrM0tJc3ROWVhKZzNPZHRqNlZiamZ3L2NZ?=
 =?utf-8?B?WFJiVjJ1RVg0V3hNVFlJa2xpS3BkM0J0N0pMUjVUYkJSOGVFLzdpZEN5aGpH?=
 =?utf-8?B?TzB0OGhYOTJ1bG1obmhGcTZpbGc2dGpOL2oxS1ozZDF3aDhqNURVU0Z6Skcw?=
 =?utf-8?B?YnFoZkpzcGtEdVVWaEtMUE1PMUU2dXNhK05UZUMxcWVCWDZ3WTRmZnpzbHRX?=
 =?utf-8?B?czR1VXFKZ3RQSWllemhOQWJIdzZlcllXaFNnV0RacHFYeHVydzBUYjhIbWNi?=
 =?utf-8?B?OUtkb3hsbjRaVlhHMUNtTlJOWXhLc3ZnZUdMT0krbm1CY2FoZXM2Zlpjd0xD?=
 =?utf-8?B?bXNDZ09aMFVTejZjTmtPbkdyTEdYOHpGUWZFRm5sbmczTmJXNUFMd2pldWpL?=
 =?utf-8?B?TmxSaUo3T2t2Wmh0dmkxdGNidTZWYXlRSlFWVzBBODhqWUxwWkVtYmh1eUF4?=
 =?utf-8?B?UGJXbzNxUWkwUlY5M2E0Vk9RL1huTy92Njh2emlLU0xja3NJK0VjeENLYUpu?=
 =?utf-8?B?SSt3K2sxMDhiQlNKN0J5WDFpU0t4ZWJ3dDMwcnU0L255anBhOGh5NTFqKy9G?=
 =?utf-8?Q?4Wt0QX+SHtIXDxPgIj+w7NF20wqJRSAGRz8xk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjI0dHhKZWxrb3hQTGdVVm05QUtqdFNmMExQcDl2NEtiZmxLNWxDNnhVRUc0?=
 =?utf-8?B?a1BwV0xWcDBvUVZ2REZoSnBUMVBSYkt6QnlvaXNnUERmZHhxc2tnQTFGeFNu?=
 =?utf-8?B?ZzlVQ3lqclFuNU9VcmlhdlRzL2xOWHUyTmJueCs3RWxVTnRFUWhyNWdPVFh2?=
 =?utf-8?B?UFZHc242YmRScy9zcWI1K1VINjAzZEs4Qkp2czFaS1VhOEZNV2NYYTc1Rzdx?=
 =?utf-8?B?SGE3LzJZNmZMQ2hGcXVMRkFnZklPNW8xRUJrbmFiTW9pblZNQm1UMzE2R0hl?=
 =?utf-8?B?eHlJQmlZMU8vR0dsWWQvZjJHMDJJWlQvY3hUVHZDRWoxQkpGVXhwaWxwZmR3?=
 =?utf-8?B?eWFEdDc0UCtzT1ZiT3lpaWIrSTg4ZFhDRjZYYkxtbkNvV21yZnNCMzV2RER6?=
 =?utf-8?B?aWd6Y3dETlJLcEh1N21Ka2VtKy9VMUNZVUNwZjYrQmlYLzFjTEpBdzNYQWdS?=
 =?utf-8?B?cEgwWWZBN2JlK2tRLzVnU2l6TmNnanBURms1NXdKNHlpTFB4aWlibXE1YUZv?=
 =?utf-8?B?d1QwdVVlTDg4ODJLdm9jR0t1dUZsanVOVm5WN0VXSzJvRENlR29rMWlwcHQv?=
 =?utf-8?B?Q25nank4MjF6cmRpc2hIRXlFWFJsVnR1SnRVN1BLOGhod2xka3pIRk90Yk4y?=
 =?utf-8?B?ZTM4K2FVc25veWg4UU1TeVlRdDhFUk1UU0c4T0ZvOE82SDB2WTFDYmtpcUo4?=
 =?utf-8?B?Nll1bU1XWjRRNFhNSVBSeGJKeS9Ib0duU0xtb0RZOFVWeWMyaC8yY2gvN29j?=
 =?utf-8?B?SklabDUvUU9mejgwNUd1KzdRT2d5akxPYXdONTIvVzc4M0pNL2pBMUZvMXhO?=
 =?utf-8?B?SVJ0MTdLVUJLcUJVcHlHQUdNMVJTM2ROYlg1OUl5b1NYWmk0dXlSSEIrMGRB?=
 =?utf-8?B?NnNNdkpKbXB0OWVFbGE5WjNJbWwra3VGamtrQW9IVkpKa1M0bkptZ2hQSzFP?=
 =?utf-8?B?L3VSUURnTTU2NnZNNjlnODI5NWpxK094L2VScUxNalpkcTc4M1VWZTFManNS?=
 =?utf-8?B?T0N0aWhkd3J2WUVEbHJCQ2F2SFhrTHFFVFR1SHRYUURzaVBYOUVoaDRSZmVh?=
 =?utf-8?B?emRtWFlVMVZTaEsyMmxtbTl6b1VyRFJ0Smdib0hwS0o3RDM4eDZ0SmFQTUY4?=
 =?utf-8?B?WmNoNHh6R2dWV0dBckcvMHJnRUhnK2NQZHo0emZ4ckx1akgwYWpXYzhaYVpL?=
 =?utf-8?B?ZldjaUtlMEVZalltMXo5bmEyMkhvY3U5cEZsNXRWejF6K01WOFpwSHQ5S0hq?=
 =?utf-8?B?dnJBVklZM1Vrcy9LbURuWVU5bHNwY2hPWDV3aStFQnVVeHZBMEprMVBOYXZr?=
 =?utf-8?B?SWdnS0NrLzlwOG5CcDd4aTg4empKZGpRdzRQU0ZnWEtwVkI0czQrSEU2SHBV?=
 =?utf-8?B?SHFBMW5rUlV5RGs2MTdlcU9xYWlVa0FaMVA2aFhkRkVUeUNKVUFlcmZ1ZmRy?=
 =?utf-8?B?UkhZZ25TKzhQT0tOMlNlMUg4V0h6UFRTV0FSUklrdDNJWkFBbTkvclU0WTBm?=
 =?utf-8?B?blp5TEFqVEtneVZMUEwxa2RFTXk0OXhvelBPa0V1RmxGTVZTbzBUSnB6UzVr?=
 =?utf-8?B?bU42SG9yZ2Y0UEtwWHlacjB3VGpsd2FFNHNOV1d4OVptemZySWpETThoejl0?=
 =?utf-8?B?d3prVGpzUDdzcEVJV2xyNUQ2YlVQb0ZuNkx5eXFmM3FNMnliMk0xd1hPVXFr?=
 =?utf-8?B?dDRYaGE1WkxvTjRnQ0ZOcmZqK2g0SmN6YVIycEt2dzFxai9VcVlEaUZpeUd4?=
 =?utf-8?B?Zkl1QjM0K0RobFZxMHU0Vklua0xVVWtBSUl2V3A1dGNIQW1TaFF5WmVza0ZJ?=
 =?utf-8?B?Z29sWWpTUUR5L2FZZGM2b3lvcUdEdTE1WlFtMWdqRElpYm1nTTRZRHQ3VS90?=
 =?utf-8?B?Kzh1SVRxV3Zjb1k5Unk4MXpEaTdxcjlodERiOG5HR1BING1lWUF2L0xjMFJJ?=
 =?utf-8?B?Qnl2YzVic0hrZnVRRS94Z2gxNU9RMXc0L2RMcW1sUTQ4NUw4NjQ1V3VzaGdG?=
 =?utf-8?B?aTNFNU1QVmljYlMwbTRxbzBobDFKVXBIODB5MkcvYVBaOHZjcU5OSEdldHg5?=
 =?utf-8?B?OGVWdDh6SmsyVTkwa29pSEZtSmtqR284em1wQVJlMTJ5N095YjhrTXBrbFQz?=
 =?utf-8?Q?wn8ti1/QiWS8Sy3WKNc9zw/9t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 040e794b-22d5-431e-13a5-08dd85f11191
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 01:07:38.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWlRwHwA1tI1a+/oDBDReHfXOKcL9KBM9yz8n2HJw+pmlIWzcoFUsGWrkAeazYUb0av+DXsn8Oa+1lHhuuL6rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-OriginatorOrg: intel.com

On Fri, Apr 25, 2025 at 03:45:20PM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > On Thu, Apr 24, 2025 at 11:15:11AM -0700, Ackerley Tng wrote:
> >> Vishal Annapurve <vannapurve@google.com> writes:
> >> 
> >> > On Thu, Apr 24, 2025 at 1:15 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
> >> >>
> >> >> On Thu, Apr 24, 2025 at 01:55:51PM +0800, Chenyi Qiang wrote:
> >> >> >
> >> >> >
> >> >> > On 4/24/2025 12:25 PM, Yan Zhao wrote:
> >> >> > > On Thu, Apr 24, 2025 at 09:09:22AM +0800, Yan Zhao wrote:
> >> >> > >> On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
> >> >> > >>> Yan Zhao <yan.y.zhao@intel.com> writes:
> >> >> > >>>
> >> >> > >>>> On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
> >> >> > >>>>> +/*
> >> >> > >>>>> + * Allocates and then caches a folio in the filemap. Returns a folio with
> >> >> > >>>>> + * refcount of 2: 1 after allocation, and 1 taken by the filemap.
> >> >> > >>>>> + */
> >> >> > >>>>> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
> >> >> > >>>>> +                                                           pgoff_t index)
> >> >> > >>>>> +{
> >> >> > >>>>> +       struct kvm_gmem_hugetlb *hgmem;
> >> >> > >>>>> +       pgoff_t aligned_index;
> >> >> > >>>>> +       struct folio *folio;
> >> >> > >>>>> +       int nr_pages;
> >> >> > >>>>> +       int ret;
> >> >> > >>>>> +
> >> >> > >>>>> +       hgmem = kvm_gmem_hgmem(inode);
> >> >> > >>>>> +       folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
> >> >> > >>>>> +       if (IS_ERR(folio))
> >> >> > >>>>> +               return folio;
> >> >> > >>>>> +
> >> >> > >>>>> +       nr_pages = 1UL << huge_page_order(hgmem->h);
> >> >> > >>>>> +       aligned_index = round_down(index, nr_pages);
> >> >> > >>>> Maybe a gap here.
> >> >> > >>>>
> >> >> > >>>> When a guest_memfd is bound to a slot where slot->base_gfn is not aligned to
> >> >> > >>>> 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligned, the
> >> >> > >>>> corresponding GFN is not 2M/1G aligned.
> >> >> > >>>
> >> >> > >>> Thanks for looking into this.
> >> >> > >>>
> >> >> > >>> In 1G page support for guest_memfd, the offset and size are always
> >> >> > >>> hugepage aligned to the hugepage size requested at guest_memfd creation
> >> >> > >>> time, and it is true that when binding to a memslot, slot->base_gfn and
> >> >> > >>> slot->npages may not be hugepage aligned.
> >> >> > >>>
> >> >> > >>>>
> >> >> > >>>> However, TDX requires that private huge pages be 2M aligned in GFN.
> >> >> > >>>>
> >> >> > >>>
> >> >> > >>> IIUC other factors also contribute to determining the mapping level in
> >> >> > >>> the guest page tables, like lpage_info and .private_max_mapping_level()
> >> >> > >>> in kvm_x86_ops.
> >> >> > >>>
> >> >> > >>> If slot->base_gfn and slot->npages are not hugepage aligned, lpage_info
> >> >> > >>> will track that and not allow faulting into guest page tables at higher
> >> >> > >>> granularity.
> >> >> > >>
> >> >> > >> lpage_info only checks the alignments of slot->base_gfn and
> >> >> > >> slot->base_gfn + npages. e.g.,
> >> >> > >>
> >> >> > >> if slot->base_gfn is 8K, npages is 8M, then for this slot,
> >> >> > >> lpage_info[2M][0].disallow_lpage = 1, which is for GFN [4K, 2M+8K);
> >> >> > >> lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M+8K, 4M+8K);
> >> >> > >> lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M+8K, 6M+8K);
> >> >> > >> lpage_info[2M][3].disallow_lpage = 1, which is for GFN [6M+8K, 8M+8K);
> >> >> >
> >> >> > Should it be?
> >> >> > lpage_info[2M][0].disallow_lpage = 1, which is for GFN [8K, 2M);
> >> >> > lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M, 4M);
> >> >> > lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M, 6M);
> >> >> > lpage_info[2M][3].disallow_lpage = 0, which is for GFN [6M, 8M);
> >> >> > lpage_info[2M][4].disallow_lpage = 1, which is for GFN [8M, 8M+8K);
> >> >> Right. Good catch. Thanks!
> >> >>
> >> >> Let me update the example as below:
> >> >> slot->base_gfn is 2 (for GPA 8KB), npages 2000 (for a 8MB range)
> >> >>
> >> >> lpage_info[2M][0].disallow_lpage = 1, which is for GPA [8KB, 2MB);
> >> >> lpage_info[2M][1].disallow_lpage = 0, which is for GPA [2MB, 4MB);
> >> >> lpage_info[2M][2].disallow_lpage = 0, which is for GPA [4MB, 6MB);
> >> >> lpage_info[2M][3].disallow_lpage = 0, which is for GPA [6MB, 8MB);
> >> >> lpage_info[2M][4].disallow_lpage = 1, which is for GPA [8MB, 8MB+8KB);
> >> >>
> >> >> lpage_info indicates that a 2MB mapping is alllowed to cover GPA 4MB and GPA
> >> >> 4MB+16KB. However, their aligned_index values lead guest_memfd to allocate two
> >> >> 2MB folios, whose physical addresses may not be contiguous.
> >> >>
> >> >> Additionally, if the guest accesses two GPAs, e.g., GPA 2MB+8KB and GPA 4MB,
> >> >> KVM could create two 2MB mappings to cover GPA ranges [2MB, 4MB), [4MB, 6MB).
> >> >> However, guest_memfd just allocates the same 2MB folio for both faults.
> >> >>
> >> >>
> >> >> >
> >> >> > >>
> >> >> > >>   ---------------------------------------------------------
> >> >> > >>   |          |  |          |  |          |  |          |  |
> >> >> > >>   8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+8K
> >> >> > >>
> >> >> > >> For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2M][2], huge
> >> >> > >> page is allowed. Also, they have the same aligned_index 2 in guest_memfd.
> >> >> > >> So, guest_memfd allocates the same huge folio of 2M order for them.
> >> >> > > Sorry, sent too fast this morning. The example is not right. The correct
> >> >> > > one is:
> >> >> > >
> >> >> > > For GFN 4M and GFN 4M+16K, lpage_info indicates that 2M is allowed. So,
> >> >> > > KVM will create a 2M mapping for them.
> >> >> > >
> >> >> > > However, in guest_memfd, GFN 4M and GFN 4M+16K do not correspond to the
> >> >> > > same 2M folio and physical addresses may not be contiguous.
> >> >
> >> > Then during binding, guest memfd offset misalignment with hugepage
> >> > should be same as gfn misalignment. i.e.
> >> >
> >> > (offset & ~huge_page_mask(h)) == ((slot->base_gfn << PAGE_SHIFT) &
> >> > ~huge_page_mask(h));
> >> >
> >> > For non guest_memfd backed scenarios, KVM allows slot gfn ranges that
> >> > are not hugepage aligned, so guest_memfd should also be able to
> >> > support non-hugepage aligned memslots.
> >> >
> >> 
> >> I drew up a picture [1] which hopefully clarifies this.
> >> 
> >> Thanks for pointing this out, I understand better now and we will add an
> >> extra constraint during memslot binding of guest_memfd to check that gfn
> >> offsets within a hugepage must be guest_memfd offsets.
> > I'm a bit confused.
> >
> > As "index = gfn - slot->base_gfn + slot->gmem.pgoff", do you mean you are going
> > to force "slot->base_gfn == slot->gmem.pgoff" ?
> >
> > For some memory region, e.g., "pc.ram", it's divided into 2 parts:
> > - one with offset 0, size 0x80000000(2G),
> >   positioned at GPA 0, which is below GPA 4G;
> > - one with offset 0x80000000(2G), size 0x80000000(2G),
> >   positioned at GPA 0x100000000(4G), which is above GPA 4G.
> >
> > For the second part, its slot->base_gfn is 0x100000000, while slot->gmem.pgoff
> > is 0x80000000.
> >
> 
> Nope I don't mean to enforce that they are equal, we just need the
> offsets within the page to be equal.
> 
> I edited Vishal's code snippet, perhaps it would help explain better:
> 
> page_size is the size of the hugepage, so in our example,
> 
>   page_size = SZ_2M;
>   page_mask = ~(page_size - 1);
page_mask = page_size - 1  ?

>   offset_within_page = slot->gmem.pgoff & page_mask;
>   gfn_within_page = (slot->base_gfn << PAGE_SHIFT) & page_mask;
> 
> We will enforce that
> 
>   offset_within_page == gfn_within_page;
For "pc.ram", if it has 2.5G below 4G, it would be configured as follows
- slot 1: slot->gmem.pgoff=0, base GPA 0, size=2.5G
- slot 2: slot->gmem.pgoff=2.5G, base GPA 4G, size=1.5G

When binding these two slots to the same guest_memfd created with flag
KVM_GUEST_MEMFD_HUGE_1GB: 
- binding the 1st slot will succeed;
- binding the 2nd slot will fail.

What options does userspace have in this scenario?
It can't reduce the flag to KVM_GUEST_MEMFD_HUGE_2MB. Adjusting the gmem.pgoff
isn't ideal either.

What about something similar as below?

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d2feacd14786..87c33704a748 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1842,8 +1842,16 @@ __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
        }

        *pfn = folio_file_pfn(folio, index);
-       if (max_order)
-               *max_order = folio_order(folio);
+       if (max_order) {
+               int order;
+
+               order = folio_order(folio);
+
+               while (order > 0 && ((slot->base_gfn ^ slot->gmem.pgoff) & ((1 << order) - 1)))
+                       order--;
+
+               *max_order = order;
+       }

        *is_prepared = folio_test_uptodate(folio);
        return folio;


> >> Adding checks at binding time will allow hugepage-unaligned offsets (to
> >> be at parity with non-guest_memfd backing memory) but still fix this
> >> issue.
> >> 
> >> lpage_info will make sure that ranges near the bounds will be
> >> fragmented, but the hugepages in the middle will still be mappable as
> >> hugepages.
> >> 
> >> [1] https://lpc.events/event/18/contributions/1764/attachments/1409/3706/binding-must-have-same-alignment.svg

