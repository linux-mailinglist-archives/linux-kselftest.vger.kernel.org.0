Return-Path: <linux-kselftest+bounces-5929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F370987231B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 16:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9C7B222B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3D1127B5A;
	Tue,  5 Mar 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzj6v1cB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3D1272CB;
	Tue,  5 Mar 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653707; cv=fail; b=T2jfE5tUGNXflk2VufCFqz/pj1IcMbG8EeXxAVjNnxEJpRSM+yJ7siXSCU49P5zvb5bXhWHB5iprjcekUsWJavOpiLcxIxVeCC+5nsa/D14mXu68MO+sC0F2lKfcNk7ciExJdn24aE35rA0JY/APpW3OodCr2BQ5FRriJVRcCs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653707; c=relaxed/simple;
	bh=qHVOOWRyXenJi1vX4j08RZljDSrUMdc97LxxCpG2/RY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J+iz/f2it17N6anzzGSCPz0t0Bz54DFYEs3R29/q72J/rGp4d+bNGdkQsFwjkugbbV2++lOMyvyn0FHYCU/HsDsznskgCP/qTTFN6Oo1wS9OHioifiRePUW9KJgh7fb84Qh9tAK5npd5+sgAACNu6g2xkBasvBX5rGP6nkxianQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzj6v1cB; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709653705; x=1741189705;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qHVOOWRyXenJi1vX4j08RZljDSrUMdc97LxxCpG2/RY=;
  b=lzj6v1cBN92VHIKGYGIYVgSgzxUZoSW9ppkwsm/8J1A4+Yx38CQSVp4g
   nYYlqVB6Mn95l6njcJyMWQViMOezjVEzd/88hfAZcJihKEmve+wDoDG2s
   Y01iNJrLvxaBxipRKDEsl4HYBSJxjF1zhTFA59KeiayL7vyu0dm7SVsmV
   KIMz+bw6arIAOudks4UXsVpcr3m/WZHja9e8TA1P4k+EY/ehPwEBEsyQM
   JHrhi3aI1k/f/8SKjBm+MpQlhXBIlV3GsqGXcduiHnLXJ6srg/6fJJzs+
   bvDafv5VAh0SMi8f5Lrab1tFH7IecS6c6mPoG6dIgLGaBB85itamUTWuj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="8022923"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="8022923"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 07:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13901871"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 07:48:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 07:48:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 07:48:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 07:48:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 07:48:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsqzKtoI+Enk3Hvp/iILU0Cbozz8Wc37G+kOdsjTthYRUX/SjpH3/h+hPaoCgLdCZHH/CI5phe3lnF3sjBvqqQWngPWw5D5jHOUJeZS4DFnnUMcg9CnRFyqgDoaCUk0aiBqOjLzNEjBNPUWVdYfLZp4Eiln258G3ag0/GYNVDonwsKJdR+lBIG5VTt9O6WILHXJ8AQasGydguAZCrHWzHHD/LlvFvaOtl4ZgVxXep7RIrVqo2CfT2N/LgkbfRsaVcpcPpiCAHD6HDnVAGqiBEQz0PZuSUSJqaaofs9gcueXww+qrNlh6Bx2pDTnudx9Xks2TDWCygU8QbSSJpjx3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa0B+ruwCX6tG3ouIM72E5GqkFdn7zvnnVDOu/et/Tg=;
 b=Qx5xs1W5uQaIugFpfW6FbCgcrD20hubAcYFCdb/t9l11EhLe3zlF7Y4aR4fcZgsi/FUyHii2ECtUjYrJta+L3h1dymki5tHoJgMuK18de/t+lkiYKWIhoyXEoRy7h9xUeSBObRvXJIot/awdXQGfWIzEZ04z8MUU9JyFfvR0YBw5VLa1ajpKuRfR7dlxnade8pSlxgA9PpakMf1KFfRF7nQR00G+qskc/PkCoY8onKAw3Iw1zNoisg0JM8fhHEv0DBJHURLR7tdcMm3f0T+UpPfcFLympbFkqi3rzs9JEmLNEbCmlia/z2qBHz+29wpwnQgT2Sw8YN45SbqC/DtV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6698.namprd11.prod.outlook.com (2603:10b6:510:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 15:48:14 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 15:48:14 +0000
Message-ID: <7bb3b635-9fed-47ab-a640-ccac6d283b54@intel.com>
Date: Tue, 5 Mar 2024 16:48:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	<keescook@chromium.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mic@digikod.net>, <linux-security-module@vger.kernel.org>,
	<jakub@cloudflare.com>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
 <20240304150411.6a9bd50b@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240304150411.6a9bd50b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0a6f16-0a51-41c8-5ce2-08dc3d2baae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uninWjlZci9D601AVmAOHatNHz/BdZ90dOLPuKb84r2qB8Bh1sGOytd9g2ZW6i+kNm5PAip+Bxpk0oS1c8Rp4QRaen6uSoSTU4ABcPAH70g8iwh0X3F4I9EB3/62CbMk3ivzBGhu2pVXqpascAOc4rXdWfkdE1szd/juY7pNEHGJqIg2jtwQz+j64tUbDRP9ECgjDcuEh5DWRA1VwQthfxmBlhKwRBIivKo1D+wQF6K+pKR8gaWmS1etLRvxUC4sfs1daAdd0wkyqg7KWGzSaF43BRWPu5QHhT0gsvaOBRQ7WWE0KQyb6d2XFlz5/eUy01acIkOGBCfEOo6zI6l6p4xtmnzMsQAR2nBnxBlp+74et9j8Me5D4KQFbWHeMVMMlZJQH6M2Ktr/BDYesVfUbOfjDdFAS040w9M/jjC/cByh+s2KkCpnaRdKmEgLsiyMTSG6phlY9tvSUNhUNph2XVv4RxT8QnjaDkyi0gvPWRxcTXeDh4aUwv3d/7SxApvqhho0fmhcA+B/mUwg4YF7EO6WA/bgkbW/Ph8dj8XhF3AhWjBH40WCo5cSw2AawDNTC5wt767taWAY94wM+eTrslNLvgKCD6tzmaSS8Xctgj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejk4Nno0TDdCNktHRkg5U3FOenRrTHp2MG1CNFpqYzhoNFVCQ0grVldqTVhT?=
 =?utf-8?B?SXVWVHRxOWdqeW1ENkxISFVMMjR0VlY2NlFmZGdlNUhNTEcrd2s4K2VLaTNG?=
 =?utf-8?B?Mkg0L2J2QTN4SGd0eGxvblJSNnYzYUgwSkE5ZU5UNko2MGlYQ1o1MFJkNFFJ?=
 =?utf-8?B?N0xEUzk4MVlvM2lMcFU5bmtNSG5JWFFpQTRlcEd4cllieFVSS21Pdko1dDlY?=
 =?utf-8?B?SzhMTFVOV29vOS82SWlQRnJUMXU2R3pkSXp4MUF0TlRGTjIzTGl2U1JPcEx2?=
 =?utf-8?B?N1M1YUFkSytHNXhlTjZpMDhvTzFXUCtoSXlBTEptWmNPdzdwcDl4TFdmUUFS?=
 =?utf-8?B?ZlRROTBwU3orMy9UNFc2WmoyVjVxYm1RMElrclBiZmhHYmpQSVd3QW1TZE8x?=
 =?utf-8?B?UFh6Q05jNERpbUQyRjl0SGM5MnpNbG9jbHBhN20rVm83ZXdSNHFKRkhTK1Zq?=
 =?utf-8?B?dFQ5VXpyZmpXWDhVVEtiLyt1bURsTHR3QjVQK3MwMGxVYVF0WFlyZzI4S0px?=
 =?utf-8?B?Q1pjajVXNmFQNytMQlA1Y3lsSkU1NEp5alE0UnVBcHlQK284bkVCYnlCNlRK?=
 =?utf-8?B?bEhQaHBNZU5SM2F5ckw3Q2J6UFIyTGFQMm1pUGtueHdZV0lDdENYVFFLd1V0?=
 =?utf-8?B?UmQ0WjhldjY1R3ZTM2RTN0RpbU1FM090NklDN2F1b3BsR3BtL0sxZ3VxeGFp?=
 =?utf-8?B?NXB5WWZLSm1qZ21JOVR5SWtJbWN6RUI4V0UyQUQ5V085NENlNnlERTdNODE4?=
 =?utf-8?B?amZ2ejlEMkszNm1nZzl4NjU5aGZnTldCOHJ4bXhlSFVHZXRidkpuS0tTMWoy?=
 =?utf-8?B?SGZjMElndWNWb3VaQnZOcksrWkxqblF2NzdML1pJaDBzVDY5Slg4MjViZjNM?=
 =?utf-8?B?ekJtT25BWnJvMFhqYlRKNm04OVNmcFpLNlQ2RklBbTE5alhjUzF4NjRLWDBU?=
 =?utf-8?B?bFlhYzVZL2dQdnhhRGFVQXc4ODdiaCtsSFIwVjQrcEswOGFRUzJnQWFPcEJw?=
 =?utf-8?B?Si9QYnZORndPUy9MVVZxSzZpRWt3cjdvMlhzeDc1K09vaXVoUFFXYnJlNk42?=
 =?utf-8?B?ZjZReTlqaTBnYkdVSCs1Z1cvSm9xZmlCL0t6ZFZ2L2srSjloMlVqYmR5bm9H?=
 =?utf-8?B?Uk05Wmx2eW50bkJreFBiY2tWK3JKWTI2T0o0cG5xZFNpZ0RBSnlrc25tNGRO?=
 =?utf-8?B?TFZhWkN6UTd1NWZBSW84TGJ0ZllkYnJYbzN5ZGtjTjVDWjg0dGg0R0lUcHE0?=
 =?utf-8?B?Tlo4Qjc1SlkrTnp5d2NBMmZxNktlK1dlek82dnc2RUVDU2MrZWhWQ2JINk1I?=
 =?utf-8?B?enJUY1p5NTFUMzViSUlhTHdLUlExZ2dwM3A2Y0ovcG04L0pacEFXV0FPMCs4?=
 =?utf-8?B?bFdWVm9LaU95bW41TjMzQTFsMC9kT2lqaWExM0FtYVFka3lQNFltT2JNZXVI?=
 =?utf-8?B?VEJJd1NaSXhmdnREMnR2WCsrY2UwczlDUzgra0FTYnFaaU03VHM4QzZNVXZ4?=
 =?utf-8?B?ZzdHUElZY2lFcFdsWU5qZUNmWXFxNlo5ZU5mREFQZE5PRHBuc2FuQUxaUk5R?=
 =?utf-8?B?ZkRxTG1qdFRycHcybWovUXhlUElpY1pwMmNtUURGa1VGQmUyM09wRVc0NTRQ?=
 =?utf-8?B?QitYVlRJTzAvbE1CbGlKMzRKSVFXQndxRHJ1Q3ordHBXSUZxOTRNU2Nlbjlk?=
 =?utf-8?B?bU1iMGJvWUwzUjd4QW5tQ3RlVE0wZTRNdWdVRjZiT2xFM2RESVl5elJUMk9S?=
 =?utf-8?B?d2RwWVBoTElxSUV4S2VsYU81UjVyK25wMUVvYm1zbDBkaGV4UnNjaGw0V0FQ?=
 =?utf-8?B?dlZJYkZNbmRaZ2UwT0dZd2Q3OFpNWE8vd0RDYVJqeCtHbllBeXNUdXkyYndH?=
 =?utf-8?B?S1BCMnQ5K0pzaTc0U2wrTTNaM0hocVlvR2lvQmxuUWpaUkVDaXA4c3hBcmYx?=
 =?utf-8?B?a2E4STVrQzlHMkpxREY1NndneE9tMllCUTI1K0dVR0FteUpNT09XRE5uY1dt?=
 =?utf-8?B?SE1rTUhVV2FKejZxM25EKytEWHJnNUd2anpEbFlJSGFVcjZlalJEcHNrU3Iy?=
 =?utf-8?B?NGFhUlR4U3BPNVY2aWV6OXpyZDY5bE9FVktBbTVTNkFCZ1BTN0RkbHhSVjFh?=
 =?utf-8?B?UE8vTjF1TEhjZlNFTGlKa0RUcXBsWjdaanlieDdLRkZZOWI4V2o5QlF6Q0Zh?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0a6f16-0a51-41c8-5ce2-08dc3d2baae4
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:48:14.1640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZaRZCDqK8T4sALYxGihX3UaGmOfdFQoaIOLFEDOREHt25PFCANsRS8NmzgT1DSx+UqZkgMw2iwvhJrqxTbW5q4vTzcRDedkqEB9JViznCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6698
X-OriginatorOrg: intel.com

On 3/5/24 00:04, Jakub Kicinski wrote:
> On Mon, 4 Mar 2024 22:20:03 +0000 Mark Brown wrote:
>> On Wed, Feb 28, 2024 at 04:59:07PM -0800, Jakub Kicinski wrote:
>>
>>> When running selftests for our subsystem in our CI we'd like all
>>> tests to pass. Currently some tests use SKIP for cases they
>>> expect to fail, because the kselftest_harness limits the return
>>> codes to pass/fail/skip. XFAIL which would be a great match
>>> here cannot be used.
>>>
>>> Remove the no_print handling and use vfork() to run the test in
>>> a different process than the setup. This way we don't need to
>>> pass "failing step" via the exit code. Further clean up the exit
>>> codes so that we can use all KSFT_* values. Rewrite the result
>>> printing to make handling XFAIL/XPASS easier. Support tests
>>> declaring combinations of fixture + variant they expect to fail.
>>
>> This series landed in -next today and has caused breakage on all
>> platforms in the ALSA pcmtest-driver test.  When run on systems that
>> don't have the driver it needs loaded the test skip but since this
>> series was merged skipped tests are logged but then reported back as
>> failures:
>>
>> # selftests: alsa: test-pcmtest-driver
>> # TAP version 13
>> # 1..5
>> # # Starting 5 tests from 1 test cases.
>> # #  RUN           pcmtest.playback ...
>> # #      SKIP      Can't read patterns. Probably, module isn't loaded
>> # # playback: Test failed
>> # #          FAIL  pcmtest.playback
>> # not ok 1 pcmtest.playback #  Can't read patterns. Probably, module isn't loaded
>> # #  RUN           pcmtest.capture ...
>> # #      SKIP      Can't read patterns. Probably, module isn't loaded
>> # # capture: Test failed
>> # #          FAIL  pcmtest.capture
>> # not ok 2 pcmtest.capture #  Can't read patterns. Probably, module isn't loaded
>> # #  RUN           pcmtest.ni_capture ...
>> # #      SKIP      Can't read patterns. Probably, module isn't loaded
>> # # ni_capture: Test failed
>> # #          FAIL  pcmtest.ni_capture
>> # not ok 3 pcmtest.ni_capture #  Can't read patterns. Probably, module isn't loaded
>> # #  RUN           pcmtest.ni_playback ...
>> # #      SKIP      Can't read patterns. Probably, module isn't loaded
>> # # ni_playback: Test failed
>> # #          FAIL  pcmtest.ni_playback
>> # not ok 4 pcmtest.ni_playback #  Can't read patterns. Probably, module isn't loaded
>> # #  RUN           pcmtest.reset_ioctl ...
>> # #      SKIP      Can't read patterns. Probably, module isn't loaded
>> # # reset_ioctl: Test failed
>> # #          FAIL  pcmtest.reset_ioctl
>> # not ok 5 pcmtest.reset_ioctl #  Can't read patterns. Probably, module isn't loaded
>> # # FAILED: 0 / 5 tests passed.
>> # # Totals: pass:0 fail:5 xfail:0 xpass:0 skip:0 error:0
>>
>> I haven't completely isolated the issue due to some other breakage
>> that's making it harder that it should be to test.
>>
>> A sample full log can be seen at:
>>
>>     https://lava.sirena.org.uk/scheduler/job/659576#L1349
> 
> Thanks! the exit() inside the skip evaded my grep, I'm testing this:
> 
> diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
> index a52ecd43dbe3..7ab81d6f9e05 100644
> --- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
> +++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
> @@ -127,11 +127,11 @@ FIXTURE_SETUP(pcmtest) {
>   	int err;
>   
>   	if (geteuid())
> -		SKIP(exit(-1), "This test needs root to run!");
> +		SKIP(exit(KSFT_SKIP), "This test needs root to run!");
>   
>   	err = read_patterns();
>   	if (err)
> -		SKIP(exit(-1), "Can't read patterns. Probably, module isn't loaded");
> +		SKIP(exit(KSFT_SKIP), "Can't read patterns. Probably, module isn't loaded");
>   
>   	card_name = malloc(127);
>   	ASSERT_NE(card_name, NULL);
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index 20294553a5dd..356ba5f3b68c 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -138,7 +138,7 @@ FIXTURE_SETUP(hmm)
>   
>   	self->fd = hmm_open(variant->device_number);
>   	if (self->fd < 0 && hmm_is_coherent_type(variant->device_number))
> -		SKIP(exit(0), "DEVICE_COHERENT not available");
> +		SKIP(exit(KSFT_SKIP), "DEVICE_COHERENT not available");
>   	ASSERT_GE(self->fd, 0);
>   }
>   
> @@ -149,7 +149,7 @@ FIXTURE_SETUP(hmm2)
>   
>   	self->fd0 = hmm_open(variant->device_number0);
>   	if (self->fd0 < 0 && hmm_is_coherent_type(variant->device_number0))
> -		SKIP(exit(0), "DEVICE_COHERENT not available");
> +		SKIP(exit(KSFT_SKIP), "DEVICE_COHERENT not available");
>   	ASSERT_GE(self->fd0, 0);
>   	self->fd1 = hmm_open(variant->device_number1);
>   	ASSERT_GE(self->fd1, 0);
> 
>> but there's no more context.  I'm also seeing some breakage in the
>> seccomp selftests which also use kselftest-harness:
>>
>> # #  RUN           TRAP.dfl ...
>> # # dfl: Test exited normally instead of by signal (code: 0)
>> # #          FAIL  TRAP.dfl
>> # not ok 56 TRAP.dfl
>> # #  RUN           TRAP.ign ...
>> # # ign: Test exited normally instead of by signal (code: 0)
>> # #          FAIL  TRAP.ign
>> # not ok 57 TRAP.ign
> 
> Ugh, I'm guessing vfork() "eats" the signal, IOW grandchild signals,
> child exits? vfork() and signals.. I'd rather leave to Kees || Mickael.
> 

Hi, sorry for not trying to reproduce it locally and still commenting,
but my vfork() man page says:

| The child must  not  return  from  the current  function  or  call
| exit(3) (which would have the effect of calling exit handlers
| established by the parent process and flushing the parent's stdio(3)
| buffers), but may call _exit(2).

And you still have some exit(3) calls.



