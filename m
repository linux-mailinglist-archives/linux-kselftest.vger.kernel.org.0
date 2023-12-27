Return-Path: <linux-kselftest+bounces-2454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8E81ECB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 07:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BABB1C222A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 06:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F82E3229;
	Wed, 27 Dec 2023 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWMYlr8u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9635228
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Dec 2023 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703659351; x=1735195351;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=9/UsX1DcHxRcjSeY25Ny9nEXmJcbF6SEBidUBmE5o1A=;
  b=TWMYlr8uuErcvWJKNZWtBexvkpUWIfI2PYask1BVmk0IjpBvoe6xRozV
   DbeTGGfGFOORh5BJjqJ/JuMhqYjURzb+hhtOtAvho2pYHxybQdXKsiDKf
   ck9zS7VH8bFxTOISHECEqT1vBJkr4Crdo/HAr9vPLSXrD0vAK+k6hGQ99
   6KqV0KJOH4GO7EOCr1Q4OUNzYD8zym5UyAzFSogVJMm60LGFBjptPwW8U
   IP08TI+c47tvIwqCECrfr2HagjIXbQhWXSz2fKSF8PPeYj9kN/nY+q9Tm
   GKbvkIv+7VQ5Oyvkd1Ko+9XqdGez/M4d1+/PRgKQhdiIlMUoCLo4QrACF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3707799"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="3707799"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 22:42:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="951423540"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="951423540"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2023 22:42:30 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 22:42:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 22:42:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Dec 2023 22:42:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOcgmL/edX0yCjD6nCrj4a+RVCg3pc2cn2xm4KE9HUKanTnHoUPfYcrGpGhOhQ7+rHdBuq7ECm23sN8a5mGYUMhgvHsWafpbMWp7P0em5041Ck1+fwJuaexlBsqWEf/p5OhOLnKKj3pSuQWqNTdFYsLvWlugO57YB7OCPEHoIGuaikiCvRepJ8XJTWsgK4ZpzSiu1xsd3xkqw56EV2lO40aDZNqTXwiAPRL/NYjQ/1PZISoXj4+PYpkWO+QB2jq0I1mR4SWKiEOdIkOgs4PqFvWfs0uxQdKcxyjiMLhpNvqqb3PvmrzfHeR5wEwMIroP7hyY+CG2SP6aJU3JO8bH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJQApIrjWCA0vq45RRk3kTwfk2xALj9Ztg+rPKC6YJ0=;
 b=D3XFO1y9JtYCaTAyEnn43Ta8QIdVCo6Bg1/an9xcdv/eOJgitrXPEpPnw8bZcM7Laf7HBAU9NjqnSjyxQrW2sqbxCKMHDqCGjjP06TdM71kfRnBq7jmwKm4YLGZgt9JQRu1ibBjAajEdCCXJUQR7sOuk0h/Efubt15ylH8ooewlEDucg0k1Hs6vnnIgXn2KW0ynXJDpgzRrdBUITyNpMOjC1RPAT1bcJX28W4rXYWJ+/LTtIYe6t9uESB540I0CZ7+nwkIPdMc0wo22YBI0HgqHAj74MBlC8M5hFa96mOAc9WcirwjbwsmZg10IWEkTCRS/leSUlN6V207R5FUYtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Wed, 27 Dec
 2023 06:42:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 06:42:21 +0000
Date: Wed, 27 Dec 2023 14:42:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mark Brown <broonie@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kselftest@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [broonie-ci:kselftest-seccomp-benchmark-ktap] [kselftest/seccomp]
 bb94019905: kernel-selftests.seccomp.seccomp_benchmark.fail
Message-ID: <202312271441.2e64d159-oliver.sang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6a5f9f-61cf-4587-a2b1-08dc06a6fa73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a79kjGQyLQNMMXVy3pzWEERyoDuImhQYrvro9SdSE/bE/CP1juNz1i9a4RQGfKdhuNq4B0grZdFHpG2LE2YV/o10Udkxe64GIl+e/cvC+pplcS3vi2367DbqgKIG0quYqGtyNS+tG4z2rVtpA/ihRv7b91d6jzXpf/0Xo5YgWDjbJB15cDdWLpGwzmAI9UU4x2pk1fOv14jtQwa8XVWsH/uHep69L1FVVxVHZXHL1qJmLNy+VYwk/Pg4CPc/KvgRvy70PUNpAdR2FflqL9nn+KLQlemWFo7J6W+qZ8bVy4iSSdpjYCD2ig2vziKcgv4SRjLto65iIVjid+G/HhlKtXb27BhfJoQTZV0mPqU0R+a1HpX7F52sdez80moeLZE8neJ9hjsu61GI42jpLxb1JUCRrbBulZQND+1UhDDet6u5OQ8PeaFqvwFnYjZN+C1fs8eFImB6Yaee7VsOyDMEcgeLvwoWaPt15u4vgCQqBN9K0EnZTaZHqWWGKwByL9WH0CAWuA+t4LIdCPThcekIUEI+8SlbWDUevdz//U/FCXlvSH3uQb/3MW+F1G4nSI28aXvAumq4rkqSaejCQiJJ7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(8936002)(8676002)(6666004)(6486002)(36756003)(478600001)(86362001)(107886003)(1076003)(26005)(2616005)(6506007)(6512007)(966005)(38100700002)(82960400001)(83380400001)(41300700001)(66946007)(6916009)(66476007)(66556008)(5660300002)(2906002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGZpdFN4WXBFZlIwVmZVVVZNSFA4QUV4MDcvRklSRnVRNUZJT3IyZU1Uanhy?=
 =?utf-8?B?eFFBTi9YbEdQVDc0eVltQzY3dmZXaHZLbTZHMjFtUERQTlJDV2JnTEMrZFJk?=
 =?utf-8?B?WUIxdW5FMEFXeUI2Z1lrUW1qU1lqU3lwaUhBVUMzSXRwTThmUGlMNjZwdDQ5?=
 =?utf-8?B?RytGdlZSUFhuNlVRRmJGc1NHdmloRHdGWnhKcDFVdGZHZzlMM054alZnV3Bs?=
 =?utf-8?B?VHlBV3BDRExKRTRYVnRDWTNvSy8xQWJxUFNwMGF1NytpZVhFcjNTc0NMMy9q?=
 =?utf-8?B?T1NtZ0tyUmtyVGJhbHNTa2VZOEVjS3UyQ0ZiL2VNckNNa3VmZFRIZHZGeXgr?=
 =?utf-8?B?eXJpSnJNcnZKbEVHaERVVkNYb3dUdXhqMnk4MHNwNTlLU2Y2ZXpUTHJPYjRG?=
 =?utf-8?B?UGxKYUMyMW9tREVub3JlSStmT0s2cW9RZmZwY1dSU2RpcjJibGFoSU55L0FN?=
 =?utf-8?B?SVhkazlsT1NwKzZhMmJ3d0lsa3ZpSUVFTFFVQnArUVpqVTQxT1krNTZqZ2VU?=
 =?utf-8?B?TENlZitielBRL0RwbU9BOWZISE9DTUpsN3lQclNTRTN4aENzUngzZitxbmQz?=
 =?utf-8?B?ZG8waFlGbklaVkNlVGJRdDU3UU0yd01MN2JNMGNmdWhKMkkzdmswRWVMdDFp?=
 =?utf-8?B?ZjVEMVdjdVRSL3p0VG9qaTZBL3BLQ0Vva3dlRmRyQjhyNE4xQU9oZUluSEdV?=
 =?utf-8?B?ajZrblJGM3hNL1JSd1krNGR5TnpaVHRGYk9DMTZ1UHhjUzFEU09mdHFxNXZt?=
 =?utf-8?B?UEgxZGo2bVRxOGNUaDBDYllSU1UrczVzdk1kUDl5UmYrZUJLQVBzN2xwdU16?=
 =?utf-8?B?dDFlTU16N3RaM1duYWVLMHBPNmFvMzFzQzhZcU5XSmlkSjN3Z05RVWtNYjNS?=
 =?utf-8?B?VTdXMDYvdVg4RlRWKzNkWnhPY1RvTlJST3RsdlhQSGxxMm5sNmdYLy9hMkxz?=
 =?utf-8?B?V1NLYnB1UFRQZ3JMcUVRcFB3bjJ3eExlTXVYMzVCYnpFYnV6L3F3WTk3ZGgz?=
 =?utf-8?B?UTF1RWpRcHRUQmxXUnJ4ZlhUcTcwaURmVlNOODhPVFdkdlY5N3VpSDFJK2ZU?=
 =?utf-8?B?Mjd2NTZSUUQ3emNwTVd3enhGa0k5TXRsaUV4dVc2Q0tjS0tPbHMwVENlMklP?=
 =?utf-8?B?M3B5RXptVi9BS3ovV0M0cStERmQvUTE5QmdnbTFZaVl4djd3L2h5KzcvZE40?=
 =?utf-8?B?cXk3VTFpSWtHaExZbU1udzJQZTlHWEl6ekF0eXF4TUc5U3dwS3pJV1prZ29s?=
 =?utf-8?B?Yk1YWXd5VXFPMlR4ZUtEQkZyQnF5QUFYcEs2YXd4VWxVTytjR2xLOXFCdzE1?=
 =?utf-8?B?VkRaTkdlcEtUMTUvMllSSklOVE5ISURYS2wrYVpqaFl5MzJiR3IrWEt2dmk0?=
 =?utf-8?B?NDQxMFRwVndjcVl6b0JxRm1jeVV1M1pLc2tUODVEZ3JybHlWUGlXQmtXeE55?=
 =?utf-8?B?TGlEWW1GNCs2Z2d6TVRhMVZVOTFydVdjcHYxUmhBSW1rTnNmQXRvSTJhTDIy?=
 =?utf-8?B?UWkwajlYN2YrZ0V2L3V4U29aREx1YzdxUndDVXdqZnIvWlJLT0I5aWM0VndY?=
 =?utf-8?B?WWxRWXUrN2VIZTE1TEhxdDB1QlZ2SkJ2a1hOWXpkbWNvb3U4MjhNcEpiejVS?=
 =?utf-8?B?djNCc1B5WGVSN0h1NllMOE96VFVBTWI3akRITEtiMktLSVByTHZabzQwTEVM?=
 =?utf-8?B?RThaQmhEbHVDNUFteVZLTUtENjBjckQ2VFJkWVRKR3BnbkdqMzF1WnhqQTda?=
 =?utf-8?B?bkpkZm5tZVphRG1jeCtDRGFLOFFFcmFYWldHRkNUOVZLSmMwb002ZEV1MEVl?=
 =?utf-8?B?T0x6V1hrZWx3QXFQMkJEQWhCK0pCdVVZWHYzU25rR21JUUVJa2ErZ1RaaW40?=
 =?utf-8?B?Nnp5Y0RNRk93dGJFa3RaeXNldjBBM0ttaWdITDdOWDBvYW0wZFRMelhFOUoz?=
 =?utf-8?B?eUs5S2VpbDQ3dmNzOEdQOXVIRGN1NngvYjVQb0F0Y241UTJWRXc1RUxYV2Z0?=
 =?utf-8?B?S2Iyc3dtZHVFekJLM3dQQWUrZDNPQ2JURUQvOTZNaFh6c0lLaXJJZ2I0K09o?=
 =?utf-8?B?ZEppbXVXWjRpMVR5ZEhEQ1l4R1VWTWJYWDdIV05ZYmU4U3llcUdUOWV3cGtr?=
 =?utf-8?B?QnpYTEN1NlQ0U2p0Y1NjQm5qMGRtSGZXdWVTd3A1aW84OUp4M3QzaU1uWEZl?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6a5f9f-61cf-4587-a2b1-08dc06a6fa73
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 06:42:21.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTBEZEN2kSH8HgiE6j3ZOhhFBY+ITgmPB+TRE6ajs0uTSrOrqbJ6utVUdkRne8HTGb0wVBrykUGsq/jAJjT68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7608
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.seccomp.seccomp_benchmark.fail" on:

commit: bb94019905757de0ddac22e897b7648b55aeef8e ("kselftest/seccomp: Report each expectation we assert as a KTAP test")
https://git.kernel.org/cgit/linux/kernel/git/broonie/ci.git kselftest-seccomp-benchmark-ktap

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
| Closes: https://lore.kernel.org/oe-lkp/202312271441.2e64d159-oliver.sang@intel.com



# timeout set to 120
# selftests: seccomp: seccomp_benchmark
# TAP version 13
# 1..7
# # Running on:
# # Linux lkp-csl-d01 6.7.0-rc3-00003-gbb9401990575 #1 SMP PREEMPT_DYNAMIC Mon Dec 25 09:40:50 CST 2023 x86_64 GNU/Linux
# # Current BPF sysctl settings:
# # /proc/sys/net/core/bpf_jit_enable:1
# # /proc/sys/net/core/bpf_jit_harden:0
# # Calibrating sample size for 15 seconds worth of syscalls ...
# # Benchmarking 37997130 syscalls...
# # 15.768643565 - 1.028667802 = 14739975763 (14.7s)
# # getpid native: 387 ns
# # 32.305042795 - 15.769439484 = 16535603311 (16.5s)
# # getpid RET_ALLOW 1 filter (bitmap): 435 ns
# # 48.595567892 - 32.307930690 = 16287637202 (16.3s)
# # getpid RET_ALLOW 2 filters (bitmap): 428 ns
# # 67.773953317 - 48.596835421 = 19177117896 (19.2s)
# # getpid RET_ALLOW 3 filters (full): 504 ns
# # 88.068486378 - 67.774726217 = 20293760161 (20.3s)
# # getpid RET_ALLOW 4 filters (full): 534 ns
# # Estimated total seccomp overhead for 1 bitmapped filter: 48 ns
# # Estimated total seccomp overhead for 2 bitmapped filters: 41 ns
# # Estimated total seccomp overhead for 3 full filters: 117 ns
# # Estimated total seccomp overhead for 4 full filters: 147 ns
# # Estimated seccomp entry overhead: 55 ns
# # Estimated seccomp per-filter overhead (last 2 diff): 30 ns
# # Estimated seccomp per-filter overhead (filters / 4): 23 ns
# # Expectations:
# # 	native ≤ 1 bitmap (387 ≤ 435): ✔️
# ok 1 native ≤ 1 bitmap
# # 	native ≤ 1 filter (387 ≤ 504): ✔️
# ok 2 native ≤ 1 filter
# # 	per-filter (last 2 diff) ≈ per-filter (filters / 4) (30 ≈ 23): ❌
# not ok 3 per-filter (last 2 diff) ≈ per-filter (filters / 4)
# # 	1 bitmapped ≈ 2 bitmapped (48 ≈ 41): ❌
# not ok 4 1 bitmapped ≈ 2 bitmapped
# # Skipping constant action bitmap expectations: they appear unsupported.
# ok 5 # SKIP entry ≈ 1 bitmapped
# ok 6 # SKIP entry ≈ 2 bitmapped
# ok 7 # SKIP native + entry + (per filter * 4) ≈ 4 filters total
# # Saw unexpected benchmark result. Try running again with more samples?
# # Totals: pass:2 fail:2 xfail:0 xpass:0 skip:3 error:0
not ok 2 selftests: seccomp: seccomp_benchmark # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231227/202312271441.2e64d159-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


