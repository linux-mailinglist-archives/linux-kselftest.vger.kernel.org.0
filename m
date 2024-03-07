Return-Path: <linux-kselftest+bounces-6066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F019687579D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 20:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72C9287249
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5E113956A;
	Thu,  7 Mar 2024 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKc6Ss9g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361F1139573;
	Thu,  7 Mar 2024 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841170; cv=fail; b=ABELTuKDN3mPtpZSYVT+vEKUAcOO+X5ml6xnk8AVDGxY81B59fD995tByYJ72U05siEPYe7oAO1nE1PoXdQDoSTYtbBcQI/cOQCBanL6HvaV/FAmvC7kC0PhxbjK0tI6c4uRE7FfTI0jaS1GfmJxluH0I84RaZPSE/OiabmtBqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841170; c=relaxed/simple;
	bh=zybWPay2J5jsWPgZcgoyq9JMH8SPcTR8/tNWI0v+324=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V9XD0psS4gm+orAB4EVWPXTCAERa2cuevowve5JSExGSCxJJSxV4y9ddi/sn+f7OmGCcGIwQ4+X3wu38+9PcA7Uq+myzTJ+8F60UMwYi/n4SYKeUCqN2PJdd2tDhwR+yvIqIj4KmzjRYfQxywkCyy1nhAIIW4+xn+xC8eql4048=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKc6Ss9g; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709841168; x=1741377168;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zybWPay2J5jsWPgZcgoyq9JMH8SPcTR8/tNWI0v+324=;
  b=gKc6Ss9g+D5lEgbJ7cYfngCTxbaDYJlMjqGFpiwRiJk7EG9vlXMh0j4A
   dcT/tORL45t/HCZxkFGPNoa9nxsQmn9lp0ujTMbBgoQMlLlAX59EA4Jte
   nOEqle9XY5rcIKHwnjFAXVAvrWSSbMRDtuXoV8paTU6esNCYg3XoFWTnD
   5rlGgkdrxVvrX/prJO/Rokw7NnPBfS3NgcCsNUgbC+9c80HHDTApMnZnr
   aBZgwYTFrb1Gnts9JZv+Uv9lhiXsIhb+q0bM3yldZQcZXnbEIb32B23zC
   qT84FEM0OkI09ZcThyyxMgSBqyWaIDoaWD2bcl853CTbIiq9a6Sh/mmKW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4714005"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4714005"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 11:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="14722359"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 11:52:47 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 11:52:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 11:52:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 11:52:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 11:52:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+1SFYSsbfpD9SGm8t2EKCrgDRbbGHSlE0cWtffYMeLW7a+VZFzsL0k5lc5eikESrjz+MKflxouyIVsn+vR9TRe59+cP0ck8J3YaRr9Pgf8NpBGvMEWKHoBzA1Pd5mIpYyf3NWpYepkKTN7Dxb8X0WWfgs9cTfAROkmdoVhFABt5LH/4bOLrxcOmcETD3BNW1sryOQOO3d1dSoXetk5z40NI0GmtpqPmn9m6uSGyMDNn+9ZtKrYSOWjLFkVxoDuHXp8PVx7Dfxj8Z2+UWsm4lcYy383cEMES4tNldDuMf2c0AM1SQ7ZoI3NFHXE+1DOfxnDWK3vFvslbj6ufTb3pPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UEfNWp7H6Kmcp4JsjohLyMW03KB0cTkEOVwzimeYiI=;
 b=eWH1+Xlq3DObab5dVh9qteQmevNczu2llZPqcvFRju7NSURloC5j1GqU2cAPQsL9L50YGxBxBWon+ekvcxwlRU3oNOVuBadOcCH1LX0/PzerQbZ4tnF7k9rOHi1jmQCCgGaTDhZRfWHRVjKdLXWxBneV2ilbs2ntUFbz9JEKpRT6DpoYvygmdGlL3TLUZm9bB6ItPsY+bSL18u6R4x9JY98aKC9zchDdDtgmfIC7Vn/gfzjIporzhiAuqnmeDmM2EI0dGfIile6vFNXvNycVMoYcAMn8T/QaVI2Ip1OgJKGhZsVVQ8Flxa3q3u6tshq/8HET1bLUEBkMNDZRQ/biMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Thu, 7 Mar
 2024 19:52:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 19:52:44 +0000
Message-ID: <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
Date: Thu, 7 Mar 2024 11:52:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:302:1::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: a138e617-3d16-4993-24c5-08dc3ee027b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zP+BmoGMOmyDyr3maAW0kwOjp95IyKzNRMSwNWZ6Sjl0AJuFepwSosA4/K628VL24EkPp6bPRhWswZn9VROPmVj1Vc7WT+hFQ7cIX78GqLLYc9wazxhqaPiRiKakv2kD7mbBwzRAswonjDiW6f7GdiYAw56q+fkczOhQ6gppJrHwFqs6Ph1haPIxDgacEiqTTO1C2i0PLlHZ4faGVGQaRTJPTycsb5TZomNN66/WH+2j0oyhpCa3l3Rh2sd57DB07tqi9IvIByDMIrns59DkOXt/z1GijNAOF7dNhvdtH0IWfMOzcfDbx3P8nb/bkROpmbXdyf0qdeHOMQHjb7U0jHfsto75Z+0Tnwntg3CcaP8iayXJsXzPiG5+YJZ2ohcCTZPkdbkjIISF+P+PRpEOh5jTlFRS7yqCheEJQGR5rP/Yrn3GVaPzXcEHtuubP+bksdZQOIGtpeJEuvGwzxahkD84ytXO5J4XCRQxGNf5Ev0cmextiW/k2JCMuf+fvhZDbfV7QCSz0hY7uxXXJ0iw+tUBdfXTNByCppttj76E0OwJ4EnAvqOodmWPEKSEphedIuS+Gi5rDCtJ9WYsqamde0StZAKBLPIbvFyqOaebpPgiGVsbl8liyQ4DQiCzeQplM8QCYFnK+tBNX8/5knrJpz/f4/mzee1HNsheiLCKPc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZOZDEvSjJxT3dyT2NQSG5ub2d2MEp6Q2VBeXZwcC9aL0RkM24xSGlaV1Uz?=
 =?utf-8?B?VHNZMGNHMk8zL3dKTmJJdnliUWYxUmJlYTJ3SHRpcTBMbzBOQWhHV3JxVTVz?=
 =?utf-8?B?S3huN21IdmQ2clNqNi84ZXB2S3ljbGRKMjJhRDhUdjZZeTJLWktZR2V4UXZt?=
 =?utf-8?B?SzZuRi8rZTJBd29XL0NNazQrcDRCZEZZVU93OFJzbzNHSHpyeWNNcE9seHdr?=
 =?utf-8?B?cUpiOTNUWFpCSUllYnRkQS82dlJqbHBQZ1FsNXZnWjA3cHl3ZkM1OXQ0L2Za?=
 =?utf-8?B?N2tWL3JZMkZvS0xXdENMWGcvN1htM3dFK2JMNDBUQlZibDVLWEt1TnI3dEJC?=
 =?utf-8?B?V2JUU2hMYU9DWXdMbnVDdnY5UmxvekdYUCtSa2NRMVhqY0JTb3c2dml4SHR6?=
 =?utf-8?B?NkU5L0ZzZmE2L240Wk9iUEhDY0tqVHJtWWpPb0Y5NkxnTWVnL3E2V3FvSGxZ?=
 =?utf-8?B?OWJNVDNnWWZSd2llMjNldFpmcDVGcWYzeGdrZjRjeHBQUHNLSVhvMmtjbTlR?=
 =?utf-8?B?ZVl4Qy9XWDY0Q2k3U2lRSTRkZlFlemhxNCs3MGh3NGNwVHVNdDBucVJHQkJp?=
 =?utf-8?B?WXF1OURvUWZtMlZVSWFUaEhGQi81b1hGTWtFR0J1anJZSkRXSzRZQlFDbDZT?=
 =?utf-8?B?aStHTGg5c3hTanl2QUVCZ1p3NVRRbjlkK3RpTXp0cFdUMFE1SHNzZ0pqalln?=
 =?utf-8?B?WDBtT0s0WCttNlFYRGhCM3V0c3NvNU5XblphcldRc1hCR3BEeHBLcmpFMzR4?=
 =?utf-8?B?UzBkN3RYdnhMdUtmWGFOb0I0T1FCOUFNZXZDUE9ibTRkWVRRMUNYY2tIZVJu?=
 =?utf-8?B?bVplMlhjY1Zna0ZycnlPKzRQTVRZdG9sSm95SDFPZDkzRXIwUTBnVmRQWUdx?=
 =?utf-8?B?OTVpYkw5UmduMllib2VsT25JV0M0L3kzWWJLcnlKcXUveHZyZkdqMkNQY0Y0?=
 =?utf-8?B?ZEJkZnpnd2xXSUVadjNRcm1TT0wzaWJjV2FBQnI2Nll5OEZFWi9lRnV3b1FZ?=
 =?utf-8?B?dXltdHJiZU1qemNMdmNtWlJveVJVMHRzUnlaZjRJRkNTSnFaNE5JNXVIcFd1?=
 =?utf-8?B?eXJGTjFxd1pGcDA3Nk4zUUxaTnp2UVNtNEdLMTViR09HcDErRitQRWxOZFdt?=
 =?utf-8?B?dVdHUzczVzZMSFU5ZEt1MjNwSHJ6SUR6UVhaWEhhYjhDc0VXeE5ESHk0amtI?=
 =?utf-8?B?N2dYRUI2TCtrbGhUTlduT0lZYTJyRlBpNHhuUlViQkg3VThLS0xzdFBnTHZw?=
 =?utf-8?B?dEYvTml3Wk1BK21yVWN2bmppekVVMHJ0d2UxOGpVMEljbEhQbFNTNjg1WXF2?=
 =?utf-8?B?VTVLYjB0R2JrVFVkWjFnTXFNMThoQ0tpT3RNd3QrN2M2L3ZKN3VjZDhsWTh3?=
 =?utf-8?B?ekpVa0NRSHFtZm5IbmdERjB6YUlDbWp6YjZhVVFoZEY4TnN5NVR3azNmemhL?=
 =?utf-8?B?SWdYVk1YWm5zQW5mc01BdUNQanV5enhXQ2FoNTh3WFVOWUtsWkp4QWZ4cWxK?=
 =?utf-8?B?dnlac0VzL3pKZWFQNmk1TkhqdGdiOTR3bkc0WHMxSFNRMy9JVUMwL2RLMnNH?=
 =?utf-8?B?S2txMnZxVzFTNmxZbnAwWnpKcklyVjhidkJkU1YrTWRLaElzVXk1dHpOM2FL?=
 =?utf-8?B?OFNDV0Q2ZVhwa2V4RGY5ZmVnT3FQYnRCd2ZDY1ZnVXBZVXBCdHNJUWxQYXU4?=
 =?utf-8?B?aHZKTmJyUGw1VGNDU1B0eS9qK2ZSbUhDM3VtWW00QVlkYTNJYS9FV0dablJj?=
 =?utf-8?B?THdGRVVuZmQ4UjZqSGY4NmZnWEVLS1pMbFhRb2FpWkViQmxVUDl1anUyZXYv?=
 =?utf-8?B?aUtpbDc2bVpZRnR3Nk5RREdtOE95YW50aFljR2o1bGtuZTMzVTdTUHJmNzQv?=
 =?utf-8?B?RXFJWDBkak5MMHpEMVluYmdPZkEyN1F0dFRXSUJPZ3dDRW1FWjJFN0ZWQm1Z?=
 =?utf-8?B?QndwTHpmVURTeE9CekFQcFJibGMrWmw3cG9EOGIrWnplYnBsOWZ2TkRsWTAv?=
 =?utf-8?B?d05ITFhTdlF6ZExrR1hFM1F2RVYzWDE2cjFKQ2tKMU5FN1VCWkRvOExGenQv?=
 =?utf-8?B?b3J2eFdBNHFRT1MwS3V3U3ZranFaLzU2czVyV2REM0IxM1FBN3kvMHNuWWRN?=
 =?utf-8?B?RStvMndzSWxyVGpBU1RIaDRKem1lVUF3VFRZK2ZCQ0t6aXA2cFdqZ2ZRcWhj?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a138e617-3d16-4993-24c5-08dc3ee027b6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:52:44.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeqVyoG8RmF/wxUFGOvRbigyxWV2ZaSYKIybIV1I/EPW4K+TXhZ7IqhVtfYuaMdCxYZXNw70s/XHDw9P1f4nLmZ4LdBZGTs87DxNCLcbZYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8479
X-OriginatorOrg: intel.com

Hi Tony,

On 3/7/2024 9:57 AM, Luck, Tony wrote:
>>> SNC2 enabled:
>>>
>>> $ cat /sys/fs/resctrl/info/L3_mon/ snc_nodes_per_l3_cache
>>> 2
>>>
>>
>> This would be useful. I believe "SNC" is architecture specific?
>> What if the file always exists and is named "nodes_per_l3_cache"?
>>
>> I assume that the internals of handling more nodes per L3 cache should
>> be hidden from user space and it should not be necessary for user space
>> to know if this is because of SNC or potentially some other mechanism on
>> another platform?
>>
>> I think that may reduce fragmentation of resctrl .... not having
>> resctrl look so different on different architectures but maintains
>> the promise of a generic interface.
>>
>> I am not sure if this is specific to monitoring though,
>> why not host file in /sys/fs/resctrl/info/L3 ?
> 
> Reinette,
> 
> On the name change - sure. It doesn't need the "snc_" prefix.
> 
> The Intel implementation of SNC has far more effect on monitoring
> than on control. The user can read separate cache occupancy and
> memory bandwidth values for each SNC node. But cache allocation
> bitmasks and memory throttling still have a single control point for
> each L3 cache instance, not for each node. There are still some
> impacts on control, e.g. each bit in a CAT bitmask represents
> less actual space in the L3 cache.

I understand the impact but I am trying to view this conceptually.
The info directory exists to "contain information about the enabled
resources" (as per documentation) and it seems appropriate to make
this a property of the L3 resource.

> 
> Maybe move it to the top level of the info/ directory:
> 
> $ cat /sys/fs/resctrl/info/nodes_per_l3_cache
> 3

Thinking about it even differently. The goal is to give information
to userspace so we need to think about what would help user space?
For example, what if there is a file in info that shows 
which CPUs are associated with each domain?

Reinette


