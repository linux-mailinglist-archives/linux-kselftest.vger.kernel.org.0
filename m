Return-Path: <linux-kselftest+bounces-6218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACD5878665
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 18:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95541F2334F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B682243AD6;
	Mon, 11 Mar 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9ig3wKS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C453E0D;
	Mon, 11 Mar 2024 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178782; cv=fail; b=L7y3Zla9dQNpA8BvLZn+AZoXh6CcolUuzyux/dgk/z4haXU8VDQHRyqimz4gGRyacP2m1fnct9mjo/pF1D6TyO3lRzfp1t+6QMxDClt8Jsxy0puros+fp/XvJqy+xaY3KMfO9D9IQprpUY05QIej5VAhaaFCArynGvT1oE++Rwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178782; c=relaxed/simple;
	bh=0eT7aLijuErCDEBS3mXzxzlLhl2T3qrkx8vyz0f48v8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZadveZpp0dn5y/Vy3x2n5qqLE20zMLWt+0EM0JgXgGG3cA6YRNblw1305eKzLw10MP63HIwgI3r6Sz/wFNBRLPQw5oyIF9SHLk3rxwNSww/9ARjuaCYpzOTAbUIFkTxqx2YvvgI+0tU+4V+eZAkaiYyObF91rSYHRg5iN8UJu0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9ig3wKS; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710178780; x=1741714780;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0eT7aLijuErCDEBS3mXzxzlLhl2T3qrkx8vyz0f48v8=;
  b=h9ig3wKSs7F4R+TqQ8eOYR7R4zhK1nTf3S2fY3Mqxv70HdBfiKdRNdzY
   IAwXEY0nfXwiaTNUivP4KMt08JW1+93VybrU96hVXkOsFJ/576m06Ku3b
   lKQWOoEjvGtJjNJImJFt8GQlPZLibt7F/kxdgn4H4dNfvRg9QJ8vNZxT5
   hWcQGWCYA9de2bEOEl5yhgc/tzWvQtZ8QTkdnoNOpIC8pP5fLR2ap0GtL
   6SVKK3M1ejgVz2fRliqg3FfzZ8+rtJlKHVxYwW/duaWECqLjRTNxCPQEL
   xLdk+5KFFlFZToXlgi2L7LtfERkxl8ZR5M1oFCxgv3pfRU6N+oKfNxGyT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="27328233"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="27328233"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 10:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11312926"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 10:39:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 10:39:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 10:39:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 10:39:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 10:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJPHwuFDVAmbE8pRW1RIAX7Ht/bTg7+rldJ/Dqr523ZFHfe/V1g2YcEbFvbALckd+qM17i86Z/k2/Sa4uBPuY/IwNJAqfeXsgeRyOPnmBhSS1ltHRamOWOxtBimUQT2fHObnQnQ3WF3z/athYMxXi/6Ax1P7hYW/+EcCyDGqCQNXhfRokHrXxp50JydgCZrbKIhnMUj1jSkiqtgix3Gk0T3oJRvQqI08yaSOMcS/zYzK5kger7ohQzwuXOu2Hcy31mJuPGeKvhvt+crN6sZWm5fGgHu3er2IYqIDPUQv3/mLmNhPW3KY6MqpDTFJVSpiHyjD/EAsSw60uUj37AV4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qckV+P0UG3NGxNSj0oqez5Cd88llqKOgv8YntTWjlpo=;
 b=brlzlJDtQGt5VBn6b82qkl9S6//fg1W0QBQx8xSYBq91T3AYNuw9fJPCZjBPJISSm38k/dEWDQJz5SgiPT/IGXKjelvxNPlrA79xwzeNP+K9/O0/0l5ZZcu8q/V2uw+lOxHQAFL8DRua0yzpSFlbY5JdMZqs7BC4+X3xviErvkrD+kX9O7kyfMGXeY8ZOnwXrU4V8KSD8zOuLfcH+7/lXWI19tQG3OPROFiRwQDMrevgAB+/hPJplF/TQpYrOWnzL5Gtvb5gkhz451dZvAn5E+fof9Q0ahhuIgZzGk8VvNqUdoiDvseKUND0W1rDwsw3LeapZNSc2MP+tQDgHW3d2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 11 Mar
 2024 17:39:13 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7386.015; Mon, 11 Mar 2024
 17:39:13 +0000
Message-ID: <1cacbd08-1131-4be4-b318-58c05afda2de@intel.com>
Date: Mon, 11 Mar 2024 10:39:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan
	<shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Weihong Zhang <weihong.zhang@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>
CC: <kernel@collabora.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240307183730.2858264-1-usama.anjum@collabora.com>
 <dc8d122a-22b7-4d17-abd9-66262af0b058@intel.com>
 <c3362840-365e-40cb-80fe-895aa2d979ec@collabora.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <c3362840-365e-40cb-80fe-895aa2d979ec@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|MW3PR11MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a565294-4764-4ae9-769d-08dc41f22a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZ8cFaYiQH4g/lpIo595t1FuHuKYNn2NyPWuVCszZiPn6FG0GQaGyi/N1PJxtLi31Zz6KGOFWUs7ulnj+5itosKrVYTpbYJMaetXDEhV6xiTEXMpPmmZG9yaaaE6G3mVuJkvqizG+AomOvZtCNvJUsR9Yiecksmp5c5XScux0G+Kxrd1WG3JLvvBnpiUtgqOGojBWV6TJDcHgTEJb40v79acqWLg/BXR0bojxqflAcD6TCMRaoCws3P+pDrif9wMFsrH1OiEc688+4Nkm5Nc+7DnMi6c+jvts/TAVfUwFwctGg+hX+n9lrPHTnTInOC2AfpuA3DnopRfCF6Ld7oYoSTpmgVf4YuEX43OhNSQYbiy9QMahjNgEkGayCx8wHdg7nrfTl86lxv+hQFx9HXxiWLVr1gwD14cEAOK9q6b+8tuHDZUOjedrF5wQbpoXnGSLtqvWAmz2TkWsNqNkoccnbaVGERNxBqYjICKWRcVnA4GTqKrLiaBmiLdQ7h+91wHb+xWMq9iAR60u+JMuhuU31qAl50/IMGBWMhsGCt8wwgB/rzP3/IS/PA1ympMxv/CO//VPDbKEVNtw6gdmhM6TkM4kxZDNrq6lFRJSlTF6rELbMwSNYQuQ8chxqckQL0+2TW+T0w23RXOS8VowZUN3cGydu1AZrm5fmUKetJD7Fc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUM3LysvNjdxYVRkY08wa2NoS2ZUaTV3S3p4M3lhZm1RT3FmNDh0SlJENHZ1?=
 =?utf-8?B?ZXlrR3VKREk3YndIWFk5MHFPUG1UeGMrL0dYS2NWejdxdWxHS1J5N1cyb01w?=
 =?utf-8?B?QVpCeWQyUUIrL21nd3BWNE1ldTJjOEtBSkUzNUpPcWNzeWNlbml2eFNleE5h?=
 =?utf-8?B?eC9tZHFieU5DYmVWeXNsOFRmRlBjR3BQcGtWNTg2Rmg4MERtVnpWeHZ1U1VG?=
 =?utf-8?B?QUp0ZWVRWHVLT3pKc1BOUTd3UURCYkNzSUU4SFh5ejVNMldrRnJlYXZMeElk?=
 =?utf-8?B?YUpBQ1FUZEhCMjI0RFNVTlUyaS9BamJLS012VDhjdDlnNEQ5K3d6SFFYcW85?=
 =?utf-8?B?QzE3d1dQNDB0UStIRmpYZHZqT2c0eEl5RHBGRGdCUHE2L3RTUHRtNmREa1Vn?=
 =?utf-8?B?QnhjUll3ZHNqSUZ1Mk95ZWU4YjJKb3NkdGFFY1B3blFvcjdQQlRxanoxN1Vy?=
 =?utf-8?B?MHh1bm4vOU9FYVB3ZWhmUDZYeHpCajZCWjhnRFhhZCtMOEJ3c2gzSUhFNkFv?=
 =?utf-8?B?U0dLMVFBenVZU3crWVVlMTZrVXpHWUMzcktkV0h4Y2RhVTk2amNaU2lzaWRZ?=
 =?utf-8?B?VmJvci9Dd2Z3NmdtbXJTOXBLOW9OM21Tb3Z1UTZEUGpNUHAwRWhObGs0YWhT?=
 =?utf-8?B?NGhaenpSaVJhWDdKYXBnYjNrMEdBTFJMZkJ2UGIzS2I5M3p2T2R0QXBkQ1BO?=
 =?utf-8?B?Y29UN1gwZG85V1pZTENrVDg5RkliRWxzVXJRTHdyTmxrMUxmTjNPSDNudFBT?=
 =?utf-8?B?N0ZEZEFUTTVtcGNKZG45YTJhakgrcHVmRzhGelVUMk5xN2xGWUttMFpCc1Y0?=
 =?utf-8?B?ZEh5NFpWVEZWZHpsNFpvVk1USlZlVGNkeHVhRzhsS3RuZDR0ME53SG4ybm9k?=
 =?utf-8?B?QzM2QU85bnJFSzY1TTFmU01ONUxHclR1ckpYRHN5UlZPdCtJM2g0Y0NHeTNE?=
 =?utf-8?B?REZmUlBoUyt6U2J6bFRUMS91Unp0RXlJMFYybkRZVjczT3paMGN3N3phRFQ2?=
 =?utf-8?B?OEg4eW53UENyZXZOTUlUS0lidlJEMVkwc0xkN0g1b1l3VEF4akUyRWxkWkU5?=
 =?utf-8?B?Q3BHNFg4djZ0N1E1L2FYOU9ibGJjU0ROMFU2ZmpYamliQ3VvbjNwc3dGSzJs?=
 =?utf-8?B?T1JFekRBNHJFdHJRRHNseHBZaEpjVms0WEFHQ29jWE9EM2F6cWZpKzZhZ3oy?=
 =?utf-8?B?U1JXcXhYd1crTlVncElzQmdMYUwrcEREcURKYk9ROTRtcWF2OTlmUDdlUTJs?=
 =?utf-8?B?eFN3d09aWVRpbkh4TjlWNEVVdmNKdTVod3hHUStmN3pGMU0zdldDR3JuY0lZ?=
 =?utf-8?B?ODN4S291elp3TC9oWUJsenZTd0JSYzhMR1Y5aWRrVzJoN3pFd0RLZHA5ckF4?=
 =?utf-8?B?SitYQ3dEVkRzOUtsNFVuM1F4Z1JPNTVhaDVEaWxreXZrM0d1Wm4yM2tqNFlS?=
 =?utf-8?B?MEFEcDZnMUVVZkV2WnQvZHFud0pOZXM5RVF2MnFQMmM3QzBiQTBQeDVBcXNV?=
 =?utf-8?B?V3VWRXNaRXlzREtiZ2V6UG5IcmZBQVFjVnFFZzFWei81SkE0NUIxOXV6N3Rx?=
 =?utf-8?B?amdFZGZ1bFZZWUd1NlJOa3FVQmtsQUxqSWNYajdrc1IvdXVyRzYzU0t1VmVk?=
 =?utf-8?B?WkkzV3dnanI2c01ZdXBzSTBUYVBKUWtDdmdCUjJsWVBXL0Y3TFFpajM4YjZR?=
 =?utf-8?B?SzNCODNmcm5BbU1kT3hZYks3bnlEcEVjeTIrMWVYS0UrOUQ4NjdFRnRqNDA1?=
 =?utf-8?B?VlA2bWFseW5HcWFNMkdpZ1lHNS9CcWZlckQzT1JhKzlFc0RKSHpxdmNNbSsv?=
 =?utf-8?B?eGZaUVNpQmJzaXV0aXNMazA0NGN2N2FqYUU4ZisvcVlGZ014NDZqVzU0dG12?=
 =?utf-8?B?L3pKUmlyaVRUbTkvckJZMnVqWlp2TUpBSmxpOFVwQ2ZCUU9CaXp4cEtPVXVt?=
 =?utf-8?B?aUkxRXg1ZnBLS2hwWXZZNXpGWmlSalRaMjVOQ2ZTTDJUcmtWT3p3NnEyN0F2?=
 =?utf-8?B?MDdGeGdkTnAzc0ttaUt6R3pjaXl6SDBUMGx5MENWV0xrM1NXK2hXcy8zM0Z3?=
 =?utf-8?B?ZVBtSStHaU41OXhPT2tWTDl4WEdUWVMrZ0RHRkRSYzl1Ti96cGNuYTUvellK?=
 =?utf-8?B?b01aSjZMamlJZUk5cDJRUHAwY3hxd2FCQW5hY0ZnNTNCcmJvL0MyaERzbjBs?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a565294-4764-4ae9-769d-08dc41f22a74
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:39:13.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNHJ8fPkVzlqtRwiC9Lv+8hHBcWJ9m62nRwaWg1G7NdODtUfsG0ZydYgvYKp4rZEGwq6zPc7cOzdJ64I3H+P6e0NjmmN5zMD5RtBGLt3WBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com

On 3/11/2024 10:02 AM, Muhammad Usama Anjum wrote:
> On 3/9/24 6:06 AM, Chang S. Bae wrote:
>> On 3/7/2024 10:37 AM, Muhammad Usama Anjum wrote:
>>
>>> -static void check_cpuid_xtiledata(void)
>>> +static int check_cpuid_xtiledata(void)
>>>    {
>>>        uint32_t eax, ebx, ecx, edx;
>>>    @@ -153,12 +160,16 @@ static void check_cpuid_xtiledata(void)
>>>         * eax: XTILEDATA state component size
>>>         * ebx: XTILEDATA state component offset in user buffer
>>>         */
>>> -    if (!eax || !ebx)
>>> -        fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
>>> -                eax, ebx);
>>> +    if (!eax || !ebx) {
>>> +        ksft_print_msg("xstate cpuid: invalid tile data size/offset:
>>> %d/%d\n",
>>> +                   eax, ebx);
>>> +        return -1;
>>> +    }
>>>          xtiledata.size          = eax;
>>>        xtiledata.xbuf_offset = ebx;
>>> +
>>> +    return 0;
>>>    }
>>
>> I don't think it is okay to silently skip the test here. If the feature is
>> available, the tile data size and offset should not be zero.
> We are logging that data size/offset are invalid if either eax or ebx are
> invalid and then we are skipping. Not sure what you are asking me to change.

You intention seems to skip the test when AMX is not available. But this 
function should only be invoked when AMX is actually available, not as 
part of the feature availability check. Therefore, I think this change 
is not relevant. Also, if we encounter invalid TILEDATA CPUID, it should 
be a reason to *fail* the test, rather than calling out a skip, right?

Thanks,
Chang

