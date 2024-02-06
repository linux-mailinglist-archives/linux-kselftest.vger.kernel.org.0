Return-Path: <linux-kselftest+bounces-4179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 581DC84AE61
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 07:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A01C227F6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 06:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856BB83CAB;
	Tue,  6 Feb 2024 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZixM103n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DE41C65
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Feb 2024 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707200875; cv=fail; b=b1oLMeg2KOJjquLKNny/cq8+dP9mJ8BIt/lwdfATMKfEZDhhKE7ceb7d+oPh+ZCRQyC9OwWnNvBCSyhOLZnBBO3R3LCYl1NA7Hf1CjVUwtC5oJ2Q8loYay30D7ox11lfwvskDBieFR7U5EmrvzsHXnZ+DcqIWfmsD6duAq1P4og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707200875; c=relaxed/simple;
	bh=gKKZA+MHXAYeo01RzEWFJu7VvhLvIkdt38YPhhVJl1o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qud03/tdfux2Ws/F4EmwVdu+4jMXbnCSoBHAlnilgrwnnRm43Z/YAmfBhfibOG87YeaeLBgHWvRDMm/edX2Q+npsw3jwzWheQOB4owjT4VnQWv3ZCS2MQIaArmF0H0jYM4Y9nFtS+ulJC/jReyEbNIlgrkv8NI3YC4lBdQhhlCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZixM103n; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707200873; x=1738736873;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=gKKZA+MHXAYeo01RzEWFJu7VvhLvIkdt38YPhhVJl1o=;
  b=ZixM103nCSqZlaJxWVociGHxI+Ju2H7bNyjPE5+vwVSpbIfvqwZ9NkMH
   I32PT41vQdlBQC/PyZu1xePx/GP/I9BV4a/SaTb5v5pvhHhFdTDoUcRj3
   5pxJdorZP+liDHlQ3uphhYu9COUbN7bS5/T+nyB0/YvdS0WKf0TxsmVjZ
   Ymj3m2xp6Xbm+/Xy+U6vWb7MYzLlmiAT18tDsxQfyBIVAuad26JLU1gti
   BGBZb/vE2RNfVaKPGOOgzoZhl1M3S4TMej26hkH84aty2bJ/k0UUnqYIL
   SOuwQNT+0FydgjrfhUU2JkL95oBYebB0FoWG8Mj/JP2HfBJFzXyCGxQqH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="831211"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="831211"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 22:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="1210012"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 22:27:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 22:27:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 22:27:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 22:27:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSWG4/745joszWnkUbLgKxQOK4unZlC+EgNavXTYlJJ5aeO6yzLF4q4XAa6tToR88ED1SRti+lWWZwxZ5UX4T/clyzz4hLWulHj+mZeYecYHusmLUz6akNQDJCE7jbpYxBUekB0EFlMGrwg5yaR5FmyWoOsfl2nRN1vxLlxe2yIUqAtrCUsDSXvj23i38sx9QVzdd8URRsaNKwvkNw7YdIvMdfCndzLVMCPWNlCmcALPcsB4GKpgkQjKGaW9aqKmZevrpC0f21WkQOSGrxb9iZKkZlh45i6FqYxxgGAOCobbNsF/UxeWFq0CG3iO48+KZTSlEnFIGCNb7kwE+V9aqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgLRLkAw9J8EHiPKA5ODnUfxkjYQvth3o0VknsBUdzc=;
 b=aS9MjjoWgYqsJUFO5/TCQ3wplgDDQahAYBLqgAtUt9qzXOKZUvG4+lXPDGyJi2+GMY5x5FyRXWzwNIG43pb8CkKp/rzGGL9Nq6O7/TaRXhLNi/HY0mK3sHJMoJtDwu9YyBVI7je387Bm7laVF1EinoAnUp8xH5x9r8QE/v+Nj1VwTXloWzaeh5k4yd6rqGpt0cj4oPbhDlRVhWh3fE7/rzWzBmzbH/Xt9Jysueq/H/Q7MvzegV8sxAXUu+mVZLqJIAdYOk9cTscOrNh8i67PqXKMzkQASqA8T1lP0KiZzwn9L05dDCo7y9ZFOYGjTlutFkamZ52UtTrYpD0vfU2MjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Tue, 6 Feb
 2024 06:27:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 06:27:44 +0000
Date: Tue, 6 Feb 2024 14:27:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mark Brown <broonie@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Anders Roxell
	<anders.roxell@linaro.org>, Kees Cook <keescook@chromium.org>,
	<linux-kselftest@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [broonie-misc:kselftest-seccomp-benchmark-ktap] [kselftest/seccomp]
 626fa92237: kernel-selftests.seccomp.seccomp_benchmark.fail
Message-ID: <202402061002.3a8722fd-oliver.sang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8fa3a2-b793-4765-a2a6-08dc26dcba4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nf4bweUXD9mWsWuo16CUjnuoBSNhhUnjVvlrwCnHeJGE/7t5AaNzh3oxuO4bQwynXdUBd0wFmLQhEEAEbNHIGt2pD06Zzr/B1MlXb0Rr5h2LwFRbW6Q88L9mDuBYl5EbOVjdIPfFDie5ex6vSE12kiNASD5rEJsdS7dWTfeo+9jyWdVj7lRQTYH0AuP2d/68LsHPWfyfRUJ8n1l5ybtcYxQ1AkX5FcjaEbYtiE35vzrhkG57K0kc6gsHHURcAj6xuKTqQTR+uTBij5O5ihvUoQyx08nyaMdpyucMHlcQk+o6NrDjizmQV86qUM9rJP3PlO3biWLrhVTEEpEkRSc4HwShZh3NRKSMxr069au8HLlBDXA6rxqndN6zcBANDScyAMUx0MK4/6HMN3hAvo64P36oWehAj1vbAjZgtg8BzSPRT5elAq0lSHHLLYoxjRynz/83kRM6lv3B+x90ey7jK01O+o7LFLQDJnN+CJvK2nYpj0zYR6uB1SYBe7/9fyrg+YpIdrH5ekaPl+FdK3AyZ6vGWfsJn8P/3RqBsieQvoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(107886003)(26005)(83380400001)(1076003)(6666004)(41300700001)(5660300002)(6916009)(66476007)(66556008)(66946007)(54906003)(38100700002)(86362001)(2616005)(6512007)(6506007)(478600001)(2906002)(82960400001)(4326008)(8676002)(6486002)(966005)(8936002)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjhJbjlOOStWdTIwYVo0aW1VOC82dTdQd2gvY29Ca0ZtUS9Ea2NJRkV0UVNG?=
 =?utf-8?B?Q3c0eVVOZmVGY2Z4M2Y5SVpNbHhZTTFiYzBFdUVFcGhwM3lGQVNGTVBLS0JC?=
 =?utf-8?B?TGdhVm03cUp3Mlp6YklmNXVpK1hNSnlCTjA4YTZTc3dYQWhvd0RLaC9BVU5Z?=
 =?utf-8?B?NG9oVTlRaTdVakJPcXN2d2dGMkkwWmIyY084aVY4RytYSFlBWjQwUUdBeFBE?=
 =?utf-8?B?bVZxQllRS1A2SDNpMVQzZ2xCKzdxcnZOdGl2M3NadTIybk1odmtoL3cvWUhu?=
 =?utf-8?B?eU1Fd21EZFNLQzhFeGlycnp6dnY4TVJOQzZZdlBRU3NuQjhwY2RPL2M1S3RI?=
 =?utf-8?B?d0lOalVnMWwvUitoekY0a1RycHFWbklVYTFQQnlrUmtET0lzQXh3TTBYWHFz?=
 =?utf-8?B?b2RKU01HVzJIVjdJR1dVb21lL0t4RXpRczRHN3BpQlVzbm5rNGFKbGhLWlRV?=
 =?utf-8?B?UkFOUXdmanB4a01HSEJPRDZzUHpsV01DVTJCWWd3N3EybldabU8ra3d3ZHlQ?=
 =?utf-8?B?U0VLY2hVQTBHR2RRN3oxUUJORDJId3RzWmVhMnM0ZTNERzRrY3BrS3dxajNh?=
 =?utf-8?B?SzVPampkOXp1bDZrZGdmb1k5ZzdpUG5vb1FCNURYSG0ySmQzZEVKelR5WVdv?=
 =?utf-8?B?dWJSbzd6V0hsQTRkYXI2RXpJSGlna0JEVWN1TWtFL3J0NWdJWFpjOEJQaFRr?=
 =?utf-8?B?Mk5wQUN1UkFMYm90Y0d3SkJBbGtEejN1YllUeUh3L25qZFNoaEFRcU5IVTdj?=
 =?utf-8?B?Vm5ZYWZKUTJMYndnMUFaTUR3bDg3dWJmenZCUVpzU1lLZXRPRExERGphVkRw?=
 =?utf-8?B?TDZWWkE5NEVZNVE3czJRTWZhYklrSkJNSDFIUmZDNDVNY0JjSVJLemx5WllL?=
 =?utf-8?B?TCtxUlhJakJXeDBUbWZYQzdDdmFISVdYektuclNndFdSekMrdWFSZlY0NGN5?=
 =?utf-8?B?eVVYUDZWOU9sVFdZdFJBTVcvQU9DVWc4aDlBallqT1JBeVVmNllVSHFtNVdv?=
 =?utf-8?B?cDZVOWhkOXdQUEpGV1RHeTAycjZUZ0NFQk41NFljNFBwQURaeExYOU1ha3VI?=
 =?utf-8?B?T1VTdVlLaU1wSXNSL0hydVI4M3JBVlhnMEV3WU9MUEttTlBvN2hyaHFJaERj?=
 =?utf-8?B?OUN6UEM2cE5DRzdLUlRveHBvVWV4eE9yZXhGZHBqQ1JrUmtxRlZmTHBNeEw3?=
 =?utf-8?B?ZnhrRHJqRDlib0twOVU2VS9yOFE0ZGdxUDZiZ3MvNDJPRHZGSkh6b1gzVW54?=
 =?utf-8?B?cG1SSUUrNDdBQnAxZ1puMzlRNnlaWWJvcStKK1Z2dzcyZ1FyeVhOVkRyeGFY?=
 =?utf-8?B?eERNOVFDb3VQVGJkdXBNamxlOFpMZUpTeTA2RGZpY2hiaFVrWk1ZSFlpWXpr?=
 =?utf-8?B?dWNLTGwxRmtZRWQyajFvdFZWMUxSOEpmaWNFUlZZb1ltWG1ZbnlzTElETm1W?=
 =?utf-8?B?U1dRQnZIbGZjUnhHWEpWNktGT0czTHpiamJhRlp1alY5b1VPbW1mc1phbW5t?=
 =?utf-8?B?ZG5ZVW1od3pVM0U0a2piOW5MUFM5b3ErZFc0eE1GWk1CUDBYK0FQRHhZOTYy?=
 =?utf-8?B?aWNWcmhlSEdNUk9nY3RxZklrYVBZYUxycEtaUDQzOVR5S2xFVXM0VXR3MGlh?=
 =?utf-8?B?UDdDdnVHbW9UMFE1b3FUWlpXSzFOelNUaVNIckJpbE9CUUc2d1krT0lPendn?=
 =?utf-8?B?bFFaV1k3YUZ5eWNmQnRCVHFpZ1VEMDNvLzNOS1lOc3ZuRDJhRVNtQXF0QS9L?=
 =?utf-8?B?S29hTzB1MzMzQkdiUzFuV1NlYk1yMmNJY3BrT1FLUFhOTnhUS3NzdnFRbURY?=
 =?utf-8?B?c2VvOS8vckErR2FlM0lieGtrUzdyZVlaeUducE1HWWROUC9mYklVNjhVSVB3?=
 =?utf-8?B?VzVIWHk4QjRDMTBhMU9LMldvOE5ISUg0citZcS9YaVhKNCttbUtMMnlCcDFG?=
 =?utf-8?B?QTdFOWhCa0gvYTZUdDN0UU9ZV3l1bVNPZ0dIVHJRV3V5N3ZXWWtac1RUTjdO?=
 =?utf-8?B?b0RFZEUySHFGdnJLeks4YmhpNndFcVdZRzZwQkFIa2VJMWtXcE1hZkFoa0JQ?=
 =?utf-8?B?Y2lTbE5LRHlRWXI4TlI1SWM3ZlM0YjdOc2VPUlY3dnF0ZTYrQ3gyUEdPeXBS?=
 =?utf-8?B?bVlQWURhVll6WDU2eTJqWUlUQ1NMM21qNmczZDQvenVhK2E1TmpXZlUwbXYr?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8fa3a2-b793-4765-a2a6-08dc26dcba4d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 06:27:44.0783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32gVPyB/Fba1ashv12Z7lv5BPwugRAKQkO2RsEOun82tImLAsWH8rZ9MDDqUjQ/09A3EB4WV41lGcx2xOqBuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7494
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.seccomp.seccomp_benchmark.fail" on:

commit: 626fa9223749db85f03678573dd49ba2c7b6cd8b ("kselftest/seccomp: Report each expectation we assert as a KTAP test")
https://git.kernel.org/cgit/linux/kernel/git/broonie/misc.git kselftest-seccomp-benchmark-ktap

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: group-s



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402061002.3a8722fd-oliver.sang@intel.com



# timeout set to 120
# selftests: seccomp: seccomp_benchmark
# TAP version 13
# 1..7
# # Running on:
# # Linux lkp-csl-d01 6.8.0-rc1-00003-g626fa9223749 #1 SMP PREEMPT_DYNAMIC Wed Jan 31 08:33:40 CST 2024 x86_64 GNU/Linux
# # Current BPF sysctl settings:
# # /proc/sys/net/core/bpf_jit_enable:1
# # /proc/sys/net/core/bpf_jit_harden:0
# # Calibrating sample size for 15 seconds worth of syscalls ...
# # Benchmarking 36800370 syscalls...
# # 15.443201110 - 1.042366576 = 14400834534 (14.4s)
# # getpid native: 391 ns
# # 31.586833659 - 15.443583738 = 16143249921 (16.1s)
# # getpid RET_ALLOW 1 filter (bitmap): 438 ns
# # 47.494976754 - 31.587621280 = 15907355474 (15.9s)
# # getpid RET_ALLOW 2 filters (bitmap): 432 ns
# # 66.262898246 - 47.495560365 = 18767337881 (18.8s)
# # getpid RET_ALLOW 3 filters (full): 509 ns
# # 86.089613909 - 66.263287445 = 19826326464 (19.8s)
# # getpid RET_ALLOW 4 filters (full): 538 ns
# # Estimated total seccomp overhead for 1 bitmapped filter: 47 ns
# # Estimated total seccomp overhead for 2 bitmapped filters: 41 ns
# # Estimated total seccomp overhead for 3 full filters: 118 ns
# # Estimated total seccomp overhead for 4 full filters: 147 ns
# # Estimated seccomp entry overhead: 53 ns
# # Estimated seccomp per-filter overhead (last 2 diff): 29 ns
# # Estimated seccomp per-filter overhead (filters / 4): 23 ns
# # Expectations:
# # 	native ≤ 1 bitmap (391 ≤ 438): ✔️
# ok 1 native ≤ 1 bitmap
# # 	native ≤ 1 filter (391 ≤ 509): ✔️
# ok 2 native ≤ 1 filter
# # 	per-filter (last 2 diff) ≈ per-filter (filters / 4) (29 ≈ 23): ❌
# not ok 3 per-filter (last 2 diff) ≈ per-filter (filters / 4)
# # 	1 bitmapped ≈ 2 bitmapped (47 ≈ 41): ❌
# not ok 4 1 bitmapped ≈ 2 bitmapped
# # Skipping constant action bitmap expectations: they appear unsupported.
# ok 5 # SKIP entry ≈ 1 bitmapped
# ok 6 # SKIP entry ≈ 2 bitmapped
# ok 7 # SKIP native + entry + (per filter * 4) ≈ 4 filters total
# # Saw unexpected benchmark result. Try running again with more samples?
# # Totals: pass:2 fail:2 xfail:0 xpass:0 skip:3 error:0
not ok 2 selftests: seccomp: seccomp_benchmark # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240206/202402061002.3a8722fd-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


