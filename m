Return-Path: <linux-kselftest+bounces-1215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1206F80611E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 22:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968761F216D2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 21:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA26FCE7;
	Tue,  5 Dec 2023 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miZjRkXh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE0D42;
	Tue,  5 Dec 2023 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701813464; x=1733349464;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xo34JQ7PNGxDLeerFMFEhyI5Bdn5aBbBlG86lXhxX8Q=;
  b=miZjRkXhRRaciIHSWu9sM1U5XVOCzjaFgoCVmEgTXeZbR9USs8Y1zSWP
   Ye5jBt9ZAoSHl3/u0CWvQ0dQ46oejdkRMiWEZzC1IaPmt4vo1FH64zBxj
   6GRyfMj6o1CBEKHGTz/t5mvAEMth2lKSyzV5XaQRQCu8x2SVaqO7VHfmt
   DJqZPeOU9uSzEkqrlHEKc9xYny262xu9vah48AezH4CAPqODjNPW8pzJ1
   T82IK+cdaDrxXM9LsCny2H5pL90D/Q1r1wX1qnbmAljSMyP7C8h3r2tiN
   HRBFAMv1I0aA4RhJoImgaRe4TfhY4piJ45BdoAF0OScUvKZAW55RtgXVH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="859671"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="859671"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:57:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944414356"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="944414356"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 13:57:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 13:57:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 13:57:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 13:57:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 13:57:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkRh3HOiGwJ0pRd0dPn6UrK5tqUITdGYPasebeFpFSMGq5R82930FmZQQOXD2QO6HZEoi4QjrHZsZLlBTevWPRfLfTqDGl4z2/rBtZUogmlCyA9Ptxty5K1g/RUhKM+uN8KNNLd0PTmnqyo3t9mT//wmwID++m2KrUr4dN6aTaMKndCb0rzkUgynw9z8/xyAE4P1mYtba3IQoOG7vAuN7udvN55pLm6lydrDmJSYBPjG2jCrWcX/YpHUid20wd3qgR8MPRLd2uu0B1xL4qT4PSx+mHCxhTErCCODv8pxxU9wgfrcVctAFRG5Htg5e8h1w/Oz47zf6fZG9djZ8ecCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqhxCgQ0ALS+OEnLA1jn6c7yBbdcydrCAYKP/vitFEs=;
 b=og9A19ZYap9iLIRq0bCKt46SOXKNX89Q2p9Dav/04rG8/uIy6sTCUZCF2XMKGP2FV35LDe7X4b4YnYUBdXpfgSiY2MeWWTlFtE/kN7iXOAOXWrc8UAzxVX7lpu2hB+18xlFYbrVtoLHZvYeKNBdD3Y21eC6+jKdlecYTCVJ9U9kPK0TVoDnk1e4cFQpHcMXn2n1JTvYZPQSGX6g8W5MSJWLuMbf21rhdi41MgS4SZX+7NM1HN3iBzpw550mupihqHSc2c4I5x5lcPPxHeTXk5XQvILll2VxaVGn5ANbWc7O8fp8TJ3doAh7AF5XMeT6FaeGu9Mec/16qCTjxzp8XOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6748.namprd11.prod.outlook.com (2603:10b6:510:1b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 21:57:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 21:57:37 +0000
Message-ID: <e4a77e0c-a31c-429b-9de9-3cadd704ca34@intel.com>
Date: Tue, 5 Dec 2023 13:57:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
Content-Language: en-US
To: Peter Newman <peternewman@google.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Stephane Eranian
	<eranian@google.com>, James Morse <james.morse@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com>
 <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
 <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com>
 <31993ea8-97e5-b8d5-b344-48db212bc9cf@intel.com>
 <CALPaoCiPCxUeGKjZytxmse2oNs=qDBbRY9kH7AZGG6iXf1qtJw@mail.gmail.com>
 <04c9eb5e-3395-05e6-f0cc-bc8f054a6031@intel.com>
 <CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vdSLp70=SA@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vdSLp70=SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:303:8e::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6d37d0-c8e7-4ddd-0225-08dbf5dd31b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXXql9l6mH1cqmRKYV+89CmM4BKIFQB+WvC1qm9yADF3dta/eGPTrCAYatbNnfKe1G1p1pnKoUCp+JjhpXI25Q33NRpZxBfBJEVnadH25cxDnU8gQ80USt278gH90E0nFMBZ4ca6X/cXCDLQNEJ5hF9+b75d4QdfSRZJQ2ZjZuFr4DwKTBJFPswGsMCh3a7WPjs5FBcCn6kPZux4Hun2sHi6IG6BER5ApvPJGzCFF3NV+yuidnGiBwWddR1aBI1E3jdisdOaHFa9SW5V1dSaw8c9IlcNdEd9zCDJ7NwjKOcxrrSl1yk+AT79bgusVN+m0vq7Up3ftFprnRMPFnXL0JUYlCYvBMjCaDSG8rZt4Bo2GXyOaJplVvVLSbonNO9Zn2LoJ7Ib73uIuH6ywP3ijgJGq0jrQCVy3F43G71qx1vsLfybdX6bVmToRL0OpOmzoVZrFNXcUniN9sBu6rn0/DgvbQU2NHf+ZfoB7kn7+u9h2821EF0QIAQHg+s/3pKPR15LMgFTvzrI0oiJmoDFs4ygEtWmOdwmdSM5t0RaV9gIzj4JeHLoH7d4jmvtSWKv5qI9MgxodW2wnwKs8+GKoNKiahV83AxrMHac6ioe4Wgz1hMt6egJoB0F/R5Le+iFkyn8vBKqvnyoyyNtLEQ6mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82960400001)(38100700002)(31686004)(6506007)(478600001)(5660300002)(2906002)(7416002)(44832011)(83380400001)(86362001)(31696002)(26005)(66899024)(53546011)(2616005)(41300700001)(36756003)(6512007)(66946007)(66476007)(6916009)(66556008)(54906003)(316002)(8936002)(8676002)(4326008)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGplT3BEbUN4T1JGUHRjTGl4WkFLU2YxaXYxTk1NdzJYZ2hWd3hJRkQ1bFR6?=
 =?utf-8?B?S0tVcVd3L0tuL0pnR01hSFErNDJleERQeWhiWWxLN2ZVMlpTUVFZa1FDVmpV?=
 =?utf-8?B?VGVPbEdWTWo1dnFSTUsvWjhnSHM1R1RmNVRlQ1FXazY0Ym80d0g2NmJBaHVj?=
 =?utf-8?B?ZzFIb3IyUjNSM3lodUk2dmxhaE9yYzNXcTVrRTg2RFBqa3ZKdGpVQkJnenFG?=
 =?utf-8?B?RFBreS92R3RBVlJEZUNZa0RyaTZENFY4K3V3WENtb0QxK084WS9CVmhlYWI5?=
 =?utf-8?B?UDVtU0VySmd5VGFyd25PbnlPS1lUdU1taXlzS2EvWVhYdGdlZXhCVU1NQy9Q?=
 =?utf-8?B?eVZmM2pkNFBnTG1TUk5leUh1WlZad1ZnQkgxZEdLTXRUazJ2UUtIbUtKZVN1?=
 =?utf-8?B?UWhFMkd3TEttMENlZ0xKdXRmMWlZT0pOZ3crZmhWZEpRVzZRKzh2NGs4dWJN?=
 =?utf-8?B?VUthNHk0ekNjUU45K1J1ZTIrVFZrMUZpK0NGbW1BTWxJSDEvQ2xBdFBUck9D?=
 =?utf-8?B?dXl4clZZelBiYlNYZHhVWjEzODdzVUU5c05FOENvTFhmWDJTbFBHcnFWZ1kx?=
 =?utf-8?B?Z2FxVVJmMkJJRThETVFqOEliUmdIRCs2ckMrRzlJc0IwTHhpYUppdUd0QnNh?=
 =?utf-8?B?aU03QlFQUEtzcnRpc1lRUDNnUy82VGtZM2tRdVlqaWtSNzY3S1lNVUFTQ2M1?=
 =?utf-8?B?ZHpjVGpOcWp5Mmg3NjcwYndnYXM1ODJFUHdEV2xoeFl2QkJ0WUNUNENFS2hJ?=
 =?utf-8?B?Yk9NdFVOdkpZN2VLcjVCeUlQWHRvWTRERWQ3aHY4YkNCb3R1V1ZGb0VDSmRG?=
 =?utf-8?B?dWJ4UmhiUnNZNHNIWXh2a0dCQ05GZlpidjdScktXdnFJdkNGWVVmQjlINzZr?=
 =?utf-8?B?N1JYaHJ3M1g4L2k5SjB1VXVnd0k0dzNtNWtKaHJYeFAzanIvek1GNnVaOEFM?=
 =?utf-8?B?UyszS2t6WlZFeXBXdnJXNjhjUXE2UWM5c0ZTMGpiUVJmR2VVdithb3ZlQk01?=
 =?utf-8?B?RFF0ZlZWY1ZtM1pwcHhJY1F3bmtQNkVoOW5QQVRZZGdxWC9qb2p4eEwxYzlD?=
 =?utf-8?B?OFRtOHhVS3dtTS9wL2lRbGR0cmE1UHROZWttVDlycTc2S1IvWFV5aDhmaWEx?=
 =?utf-8?B?RERKcG1ZQklYckViWVFUaUtNcGIzdzVIbExrVFJnN1hEU1JFVlFrV2pkSWZQ?=
 =?utf-8?B?NzRJS1ZneUJOL2R5MUwzT3NacVN1azZBeGkvK25ERlk5NUh0dHp6M3l6cGlT?=
 =?utf-8?B?d2pVelhpUSsvK1dNWUc0dkZ0ejZnMXU4aWlHYkxMbkNWbGFVTTc2cFJNTGJx?=
 =?utf-8?B?VHNVSzV1WGJOTmNWaEgwYXRrMDhNcitaQ3JlVEVqaVc2cHoxRVBJSzRPb1ZN?=
 =?utf-8?B?N3FSQVJSaVBMc0REUUVjdUR1VEh0bjFvOGtNQzlseUhBV2dHaU0zVUVkZ05V?=
 =?utf-8?B?RnI5azJMVEcxVVZzS3dQek90VHE1RTFiMFRYWXhCK3hRNmptWGptbWlFdXc2?=
 =?utf-8?B?Z3lwTUhZVHM1YS9vYnlVZWlUUC81WUppVEp0TkhOUEpBYjZNeTFuYm9Ubld4?=
 =?utf-8?B?MU5pMHY4WVFqOTcyQUNLSGFRdDVyWFR6NW5mMCtaODBKandrR2JSNG84WXZS?=
 =?utf-8?B?cUFNQjNLKzF0S0xNclpReCtDSVF0K0Z5MU81WVNGZmtDOTJMeElnWjFmSWh6?=
 =?utf-8?B?czl6NFBJdUc0eU1sSzdwa0h2cVFaU3E0QVNFRmxsM1NpOXRXVGJ5cnlkZitT?=
 =?utf-8?B?OW5zUnpxZzBPSkdITmd2bFVJU2h2TFkvNnZYZk1ndkVPYU5uZENsNll0a1Ry?=
 =?utf-8?B?YXl3bVk0bysyemc1V2swenlWeHMyMnJwL0FCU290d0E2aVM4bG80ZkxOWlBW?=
 =?utf-8?B?NWVTZmFXMHdDRUZ2YVMvZ3JObVpuU2hVQnl6OS9zTk9oaG01VGQ0WHNLR1pR?=
 =?utf-8?B?RUxTb2VEZDVmRGNHRXVuQ1lRYTAzTmZxZ0cwelN5RXZTWE8vYmlIajBEblNn?=
 =?utf-8?B?bmpiazMrUWxlREhycXpwTkpOMDFIbkVUek9xdnU4ZEc2ODBVL2JLSy9Hb25D?=
 =?utf-8?B?U3o4QXJYMjJlSjBaUXRHZ3JaZ012ajBVVjBZSVRpeVovK0ZSOHZqanNJSjhl?=
 =?utf-8?B?ekdUSDA4MjZrK2djQklmVGRtVG9mZXlud3JzYm85ZWNiMC9LRWxyUlphQWtp?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6d37d0-c8e7-4ddd-0225-08dbf5dd31b7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 21:57:37.5207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKWBGjyjGQ2nLjSJ+vts3LrZxDLGCgQGm/ri0Uxu2wLaUa43f5Xfdu1IuZ2uSb2pVG1PSSYywePbyDnGEwINO72h5QuIIqQF+x+R3MjHeaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6748
X-OriginatorOrg: intel.com

Hi Peter,

On 12/1/2023 12:56 PM, Peter Newman wrote:
> Hi Reinette,
> 
> On Tue, May 16, 2023 at 5:06 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 5/15/2023 7:42 AM, Peter Newman wrote:
>>>
>>> I used a simple parent-child pipe loop benchmark with the parent in
>>> one monitoring group and the child in another to trigger 2M
>>> context-switches on the same CPU and compared the sample-based
>>> profiles on an AMD and Intel implementation. I used perf diff to
>>> compare the samples between hard and soft RMID switches.
>>>
>>> Intel(R) Xeon(R) Platinum 8173M CPU @ 2.00GHz:
>>>
>>>               +44.80%  [kernel.kallsyms]  [k] __rmid_read
>>>     10.43%     -9.52%  [kernel.kallsyms]  [k] __switch_to
>>>
>>> AMD EPYC 7B12 64-Core Processor:
>>>
>>>               +28.27%  [kernel.kallsyms]  [k] __rmid_read
>>>     13.45%    -13.44%  [kernel.kallsyms]  [k] __switch_to
>>>
>>> Note that a soft RMID switch that doesn't change CLOSID skips the
>>> PQR_ASSOC write completely, so from this data I can roughly say that
>>> __rmid_read() is a little over 2x the length of a PQR_ASSOC write that
>>> changes the current RMID on the AMD implementation and about 4.5x
>>> longer on Intel.
>>>
>>> Let me know if this clarifies the cost enough or if you'd like to also
>>> see instrumented measurements on the individual WRMSR/RDMSR
>>> instructions.
>>
>> I can see from the data the portion of total time spent in __rmid_read().
>> It is not clear to me what the impact on a context switch is. Is it
>> possible to say with this data that: this solution makes a context switch
>> x% slower?
>>
>> I think it may be optimistic to view this as a replacement of a PQR write.
>> As you point out, that requires that a CPU switches between tasks with the
>> same CLOSID. You demonstrate that resctrl already contributes a significant
>> delay to __switch_to - this work will increase that much more, it has to
>> be clear about this impact and motivate that it is acceptable.
> 
> We were operating under the assumption that if the overhead wasn't
> acceptable, we would have heard complaints about it by now, but we
> ultimately learned that this feature wasn't deployed as much as we had
> originally thought on AMD hardware and that the overhead does need to
> be addressed.
> 
> I am interested in your opinion on two options I'm exploring to
> mitigate the overhead, both of which depend on an API like the one
> Babu recently proposed for the AMD ABMC feature [1], where a new file
> interface will allow the user to indicate which mon_groups are
> actively being measured. I will refer to this as "assigned" for now,
> as that's the current proposal.
> 
> The first is likely the simpler approach: only read MBM event counters
> which have been marked as "assigned" in the filesystem to avoid paying
> the context switch cost on tasks in groups which are not actively
> being measured. In our use case, we calculate memory bandwidth on
> every group every few minutes by reading the counters twice, 5 seconds
> apart. We would just need counters read during this 5-second window.

I assume that tasks within a monitoring group can be scheduled on any
CPU and from the cover letter of this work I understand that only an
RMID assigned to a processor can be guaranteed to be tracked by hardware.

Are you proposing for this option that you keep this "soft RMID" approach
with CPUs  permanently assigned a "hard RMID" but only update the counts for a
"soft RMID" that is "assigned"? I think that means that the context
switch cost for the monitored group would increase even more than with the
implementation in this series since the counters need to be read on context
switch in as well as context switch out.

If I understand correctly then only one monitoring group can be measured
at a time. If such a measurement takes 5 seconds then theoretically 12 groups
can be measured in one minute. It may be possible to create many more
monitoring groups than this. Would it be possible to reach monitoring
goals in your environment?

> 
> The second involves avoiding the situation where a hardware counter
> could be deallocated: Determine the number of simultaneous RMIDs
> supported, reduce the effective number of RMIDs available to that
> number. Use the default RMID (0) for all "unassigned" monitoring

hmmm ... so on the one side there is "only the RMID within the PQR
register can be guaranteed to be tracked by hardware" and on the 
other side there is "A given implementation may have insufficient
hardware to simultaneously track the bandwidth for all RMID values
that the hardware supports."

From the above there seems to be something in the middle where
some subset of the RMID values supported by hardware can be used
to simultaneously track bandwidth? How can it be determined
what this number of RMID values is?

> groups and report "Unavailable" on all counter reads (and address the
> default monitoring group's counts being unreliable). When assigned,
> attempt to allocate one of the remaining, usable RMIDs to that group.
> It would only be possible to assign all event counters (local, total,
> occupancy) at the same time. Using this approach, we would no longer
> be able to measure all groups at the same time, but this is something
> we would already be accepting when using the AMD ABMC feature.

It may be possible to turn this into a "fake"/"software" ABMC feature,
which I expect needs to be renamed to move it away from a hardware
specific feature to something that better reflects how user interacts
with system and how the system responds.

> 
> While the second feature is a lot more disruptive at the filesystem
> layer, it does eliminate the added context switch overhead. Also, it

Which changes to filesystem layer are you anticipating?

> may be helpful in the long run for the filesystem code to start taking
> a more abstract view of hardware monitoring resources, given that few
> implementations can afford to assign hardware to all monitoring IDs
> all the time. In both cases, the meaning of "assigned" could vary
> greatly, even among AMD implementations.
> 
> Thanks!
> -Peter
> 
> [1] https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/


Reinette

