Return-Path: <linux-kselftest+bounces-1322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5A807919
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 21:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573CA282105
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 20:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141841874;
	Wed,  6 Dec 2023 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZ6wyBnq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC2FA;
	Wed,  6 Dec 2023 12:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701892971; x=1733428971;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d1OTPpPpYq5HODFAqCPWA6AAbhwFSl6FoUGv/JgY/lM=;
  b=JZ6wyBnqRQHfIkR6wjyB2Z887XcB6ZxiibnlgV0+gyXRkM10qCydfvUN
   mxDtA1fqYaMsdX3ogCTvRwPTLz0VV+vQ5igj3+N3hnH5WaOokyIHmBetz
   Up1a+ahQoe5E0P9GbMeIVl+yxtxJLuFhrIJ90iIRrTToqxI8Ov5uFnCOG
   2fyoUKuV8U2DLMfWDFCrrTaiSTxbQ9F4fDghut2oW6UbXMw94rElukECs
   BYxeahaOfvljW8RM5KvnGVYZdoY57dmQskFlg7l8cia+JPr4yZkrt/4YN
   rrxfaGUPhuuFVuRQkqcnLXcU2EY4fiFK89ai3X8iJr0rF7BmSoTmRHTyg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391288861"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391288861"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 12:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="764842289"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="764842289"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 12:02:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 12:02:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 12:02:51 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 12:02:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs96aTLliwhVDLoQ0/mo6g/0SDzVHIQtNHF/2/hfsuSAfsZG8yTAcQOUfR1+fuwQnIAmpdRhE95R+OVEZCvNQNhOW0YNMcPbNHcSHEJ+WbKvWrX4H3+wKpzIrf8xozVhpwQAn72Xk7rpgmVvTxkz08+EcBcXDyLr9rlob6EjEcOQBpcBWcTCQ00eqRWiozCDnmBsxmkEenssOrt8+Wll1rwsTNtoa2xLQEjooE7BHGZ75Oh9iiUzpdvKcKc0bAPgoEgx1lSFEGGBP9vKsyYbBS5rBofx51srHtUfTcN5IpT0cnYsarRuAOqmurncoNkW3ikop4XsThGOs304Kq+UkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7VmC4qqwlzYWNxISPoNwxzosToD+dOS1Xkfa72FgSw=;
 b=LSQZd9TTCd/nbvrjZ2vMrQ7GVDRPUtNWIemByqWzLLMB9up9JbleQ8fms+5k8ph1/C60tJIOTW6xvgRaz4eT7iRtBAVKtYrUGsThenJA2tEuyZpCUPJWnyV08OWkRqApJN3oevJ0dwofI7OZ8aguPuqWjJWylbbNEhLuekYCp/wG9LuaBXHMOZnrb21D76VmC7DyDu1Gx2ajIgGFfzAhjEtTcdgaRR0Xw/gETsuHO0TyOZJ0MglRBO9qo5+pyZPmidJ+WRCcnCrH2Wnq0FZyE3kN3F5wSk7gH99lQu2soF//yefPK/caifEIGcvJIqjB12J5nHu21S8xZyjus0Bddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 20:02:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 20:02:42 +0000
Message-ID: <ce1e0d48-d1c9-49bc-953b-f79679fb8791@intel.com>
Date: Wed, 6 Dec 2023 12:02:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
Content-Language: en-US
To: Peter Newman <peternewman@google.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
	"Thomas Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
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
 <e4a77e0c-a31c-429b-9de9-3cadd704ca34@intel.com>
 <CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com>
 <101c0235-c354-43b1-afc2-1332bd8b453a@intel.com>
 <CALPaoCiLB99MDdMuVR=U6dA8hsnRJkdb2FrHvwXzQoQBHp_qNA@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCiLB99MDdMuVR=U6dA8hsnRJkdb2FrHvwXzQoQBHp_qNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWH0EPF00056D04.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:c) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYYPR11MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f7805d-5481-49c1-d838-08dbf6964e6c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvCSa/35sifvbfLP3d/1n5AbMbHA9FTHemdqDAdsrR77+z1Xj3t8jLoUa1lQ3yDAdC7flXE59QO9eqcbjFgQ2YKLZ6YEZrL/XZBMpZWIj+yF+lmkU+0m2beg/c1jH1W/jg6fAXhWRdeVNpxSd0dpHXnplunz59HsjKnGKk/b9D/A/OeC9dC3gO6JlfrS5CEDpIlTw60zq6FNI2cFxD9Fg74y9fWPCqJZO5rqFTZo1nHOfFolYdTt2JZwzjUK9nDOI3g89BdqZNZrP9MHv4kR1wqTA+FtMiLLQeaf88G464BFn6bQdkMXZziPlHkEjVVtu89CpKII0MwAbtvWC/kDhpxL4Mjq6atP8CoAZvWRg91VJDNA/aorU6+pBgjawR7j1Vkx6W+qvQM2DIVCoXZDCtMf50AQgWV13iN1y1t+Q2ZpoWsnQDtmhG3Zk915mDQdOf5fNb5KDZdvtjO0U2ATmDdJBGjK1vrB8Y+TBhzWyGWbldyN8Ovnn0asFzQGNjlDteGtWBeTVcJzOFlIE368CJtxaJO32E8btgnd6+DiZFuOzKIot6yKcPqrSv30di7CCJwhKDaGOcnKcE6ep9obGmPMWW1z3T6kIfjYKmwynmbhUSU1L9WSWkhW5cIn9S6TB+UOCXwkyXiJtDccJAFYSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66899024)(41300700001)(36756003)(5660300002)(7416002)(86362001)(44832011)(2906002)(83380400001)(82960400001)(66476007)(6916009)(54906003)(66946007)(66556008)(6506007)(53546011)(6486002)(478600001)(2616005)(26005)(6512007)(8936002)(8676002)(4326008)(38100700002)(31696002)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCtTSExsa0NrWWdtQUFVY1VIdVRzdHZBOTdjNUFRbEVZUVhVNGM0bVdsUzRz?=
 =?utf-8?B?MFRHcTlQTWxlVmNWY1FENStJUEg4RVJyRmpnS25jelRIMVV1dEhNY1NIZDZH?=
 =?utf-8?B?ZVc2NTR2R1BFa3ltdWQ0NDVGRzlqUUp2N2dzaTdoUVA1Zi80RFdjaUVNUTVu?=
 =?utf-8?B?MitzaVlWQTIra1dYMmVzL29ZYmtDZjRVdDYySkt4ZnNKM1ZxVzdXSWFleTE5?=
 =?utf-8?B?Q1hKSld0dzRhaVl1bjd6TmJrZUk0L2Q2NUdFN3QxVzRKRnA5M3lmL01EdTRi?=
 =?utf-8?B?MjB6RVFucUJkRTZiZDNVanhBb2JJZ3RVRm5jOFl0UTJoZXVsYWdKN0R4T3RO?=
 =?utf-8?B?V3dhdjBOWG93OXhzak1aNDgraXZ2K0lxbC9GWmk5U01zY1JTL0pUcDhleTVv?=
 =?utf-8?B?UldGLzVVU1FiWnE1NWdkeVpPOHZDNTNOL2J3TXVPdG9DblVwVkFWQTFibXZn?=
 =?utf-8?B?MmJSOGFrdnZ4QUdDY2hTN2prcVRuSXJUT01Yd00wTi9FRTRsZ2p6Q2J5M2dX?=
 =?utf-8?B?NzRicGhONlV3RVpXSUdlMk56ZVM4TGV6dnY2aXBJVzI5cjdPcHZEYThvRFFi?=
 =?utf-8?B?cEJRZExmSDB4V0d2WENpUXMvK0VlR1BncFRlbytMeXFPOHhFenV1a3Vod3NS?=
 =?utf-8?B?VWFEeDBVR3R2V1NXb3lEbkFPRElaNVhaN2hYY1JUM1E3Q2l6VXlmY2pkUjVp?=
 =?utf-8?B?b1U0TTh2bnprMmMzTllJcU1zY1I5R0NyY3BvVWt0VTdRalB6SXBnMjRkOWQ0?=
 =?utf-8?B?UWk0VWVrSVBXVFhBS3Q0aGRrMjBjZUFiSi8zTGd1MkhHZGNIbUlCdDE2Wlhy?=
 =?utf-8?B?VVhkZzZSVFhxeGVzdHRPa2p5UGhBR3l2cmwyMEE2ZkdYbDdEL1FOUlppWXor?=
 =?utf-8?B?SWRhWGVCeHdubTJybnJpeS9UYmFMd05IWklPNlVUbFBleU40ekNoV1J4VzdX?=
 =?utf-8?B?MWNtVllNRWxLWGZqdFFybWo1bjRCMkdSR3lMYlM3YzlIa1ZxL2pGMlZzMVZk?=
 =?utf-8?B?OC9LZ1lHd2VLSXlpYTV0L2VMV0Z6STBKYUlpWENDV0MwcGtiV1BEMnB2YmdT?=
 =?utf-8?B?aHErSnFVeTVSYXFHU2lTYm4vcEpYZ1Z3QmZlWXRacnAyaEdMTnBYSEcxK05Y?=
 =?utf-8?B?V1I2SzE2MnZwNGFueXVqQU9UM3J2aVhWL01UUE1LZU1NT09qRGlOcTFWSGVn?=
 =?utf-8?B?RjBvVnJIaVpXVEVicGV3L2d2SjMzalR3bUl3OHYwV0RjK3V3VUt6NU1leXk2?=
 =?utf-8?B?K1EwNTlPY0g3ZFBROHhwZ0R0UWFLaWo3amVaajEwaG1NTmRhRTNuUGpDenpz?=
 =?utf-8?B?STJVZHYvbmk5ME9NeU9oS3lUMWhvKzlPenBlMmEwQ2daSGdDWmhibURHeDZy?=
 =?utf-8?B?TWdBQkZhTXRqOTE0ZlA2L0tZZzdNQURvaWo4THA4Q3NtWmlFWkJlTDIzcnVx?=
 =?utf-8?B?UUZNQ2xHR1Q5UThtZ2FVdktPanY2ZU1ON0xmNHBVVVljM3FVMlVrVGg0T21a?=
 =?utf-8?B?UGQyYUJHNTFpTjFQSFRra0dRU01zT3Q4dm16NkZqL2NaL2pQL3ErRG96cTZY?=
 =?utf-8?B?NEhxOGJTZkp0cWJBYjFtempwanVkeUt5VHMvMGRUUGJtTHFFZHJ6Wmg0RmVk?=
 =?utf-8?B?a2hHNmw2dm1rdWFxcmVPWDBOMUY1ejhWTzJRbndGZ1N5Y0FPTk1iQjBxUW9D?=
 =?utf-8?B?cVo1R2VjRXNpblYweUN4dmpwTUVwTUhreTdzVGN4d2lpUHZFMHZGUHJBNDVj?=
 =?utf-8?B?U2RxMmVsSzdVNkFKa0tkTEZ4aVhrZHpyaWtkaVRJSnhwb2pjZkRIcVR0SU9D?=
 =?utf-8?B?OE5yU25jV0RxaVhOQXM2Zy9aUXBTejZ1NVFwWDEvUHhjNjIzOXVzdEE2VU94?=
 =?utf-8?B?MjlGeFh4a09Pc3VGK1oxemtVSkluQ0ZSY05BVkRSRWQ4dlRRQ01mWFlqQVRF?=
 =?utf-8?B?Q0hJeXBMejYvY0l4dE5aMWN6Q2wvdlIva0tYSmhod21mckRmemx5TDF4aGY2?=
 =?utf-8?B?N2o0cWF2cVFhdGVSOTJYY0taeDFJMk8rM0dIK1dnQ2QrZlV6SHh6ZExYS0F3?=
 =?utf-8?B?WHRvNXBFTzdlQXB5RnB2aldwZks4MWlQaStmQTJlVVNrUVhlUThGQ2tsYkpD?=
 =?utf-8?B?UDRDUHFPOGlHM2hQUVlkdmgwVG1XRmUzYjQzY3hHVWxuSGNhSjBXdmlWQ0Zr?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f7805d-5481-49c1-d838-08dbf6964e6c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 20:02:42.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZipLMzV839RWox9/eRHxYF6t1Zm1ZnQbliHqEzXfbIju8MqOq/0PCTGVvEJeiMlGCOfLVtCMj7HwZtxoYFihHdIUA0CxkRQCBW4UmWFxeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
X-OriginatorOrg: intel.com

Hi Peter,

On 12/6/2023 10:38 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Tue, Dec 5, 2023 at 5:47 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> On 12/5/2023 4:33 PM, Peter Newman wrote:
>>> On Tue, Dec 5, 2023 at 1:57 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> On 12/1/2023 12:56 PM, Peter Newman wrote:
> 
>>> Ignoring any present-day resctrl interfaces, what we minimally need is...
>>>
>>> 1. global "start measurement", which enables a
>>> read-counters-on-context switch flag, and broadcasts an IPI to all
>>> CPUs to read their current count
>>> 2. wait 5 seconds
>>> 3. global "end measurement", to IPI all CPUs again for final counts
>>> and clear the flag from step 1
>>>
>>> Then the user could read at their leisure all the (frozen) event
>>> counts from memory until the next measurement begins.
>>>
>>> In our case, if we're measuring as often as 5 seconds for every
>>> minute, that will already be a 12x aggregate reduction in overhead,
>>> which would be worthwhile enough.
>>
>> The "con" here would be that during those 5 seconds (which I assume would be
>> controlled via user space so potentially shorter or longer) all tasks in the
>> system is expected to have significant (but yet to be measured) impact
>> on context switch delay.
> 
> Yes, of course. In the worst case I've measured, Zen2, it's roughly a
> 1700-cycle context switch penalty (~20%) for tasks in different
> monitoring groups. Bad, but the benefit we gain from the per-RMID MBM
> data makes up for it several times over if we only pay the cost during a
> measurement.

I see.

> 
>> I expect the overflow handler should only be run during the measurement
>> timeframe, to not defeat the "at their leisure" reading of counters.
> 
> Yes, correct. We wouldn't be interested in overflows of the hardware
> counter when not actively measuring bandwidth.
> 
> 
>>
>>>>> The second involves avoiding the situation where a hardware counter
>>>>> could be deallocated: Determine the number of simultaneous RMIDs
>>>>> supported, reduce the effective number of RMIDs available to that
>>>>> number. Use the default RMID (0) for all "unassigned" monitoring
>>>>
>>>> hmmm ... so on the one side there is "only the RMID within the PQR
>>>> register can be guaranteed to be tracked by hardware" and on the
>>>> other side there is "A given implementation may have insufficient
>>>> hardware to simultaneously track the bandwidth for all RMID values
>>>> that the hardware supports."
>>>>
>>>> From the above there seems to be something in the middle where
>>>> some subset of the RMID values supported by hardware can be used
>>>> to simultaneously track bandwidth? How can it be determined
>>>> what this number of RMID values is?
>>>
>>> In the context of AMD, we could use the smallest number of CPUs in any
>>> L3 domain as a lower bound of the number of counters.
>>
>> Could you please elaborate on this? (With the numbers of CPUs nowadays this
>> may be many RMIDs, perhaps even more than what ABMC supports.)
> 
> I think the "In the context of AMD" part is key. This feature would only
> be applicable to the AMD implementations we have today which do not
> implement ABMC.  I believe the difficulties are unique to the topologies
> of these systems: many small L3 domains per node with a relatively small
> number of CPUs in each. If the L3 domains were large and few, simply
> restricting the number of RMIDs and allocating on group creation as we
> do today would probably be fine.
> 
>> I am missing something here since it is not obvious to me how this lower
>> bound is determined. Let's assume that there are as many monitor groups
>> (and thus as many assigned RMIDs) as there are CPUs in a L3 domain.
>> Each monitor group may have many tasks. It can be expected that at any
>> moment in time only a subset of assigned RMIDs are assigned to CPUs
>> via the CPUs' PQR registers. Of those RMIDs that are not assigned to
>> CPUs, how can it be certain that they continue to be tracked by hardware?
> 
> Are you asking whether the counters will ever be reclaimed proactively?
> The behavior I've observed is that writing a new RMID into a PQR_ASSOC
> register when all hardware counters in the domain are allocated will
> trigger the reallocation.

"When all hardware counters in the domain are allocated" sounds like the
ideal scenario with the kernel knowing how many counters there are and
each counter is associated with a unique RMID. As long as kernel does not
attempt to monitor another RMID this would accurately monitor the
monitor groups with "assigned" RMID.

Adding support for hardware without specification and guaranteed
behavior can potentially run into unexpected scenarios.

For example, there is no guarantee on how the counters are assigned.
The OS and hardware may thus have different view of which hardware
counter is "free". OS may write a new RMID to PQR_ASSOC believing that
there is a counter available while hardware has its own mechanism of
allocation and may reallocate a counter that is in use by an RMID that
the OS believes to be "assigned". I do not think anything prevents
hardware from doing this.


> However, I admit the wording in the PQoS spec[1] is only written to
> support the permanent-assignment workaround in the current patch series:
> 
> "All RMIDs which are currently in use by one or more processors in the
> QOS domain will be tracked. The hardware will always begin tracking a
> new RMID value when it gets written to the PQR_ASSOC register of any of
> the processors in the QOS domain and it is not already being tracked.
> When the hardware begins tracking an RMID that it was not previously
> tracking, it will clear the QM_CTR for all events in the new RMID."
> 
> I would need to confirm whether this is the case and request the
> documentation be clarified if it is.

Indeed. Once an RMID is "assigned" then the expectation is that a
counter will be dedicated to it but a PQR_ASSOC register may not see that
RMID for potentially long intervals. With the above guarantees hardware
will be within its rights to reallocate that RMID's counter even if
there are other counters that are "free" from OS perspective.

>>>>> While the second feature is a lot more disruptive at the filesystem
>>>>> layer, it does eliminate the added context switch overhead. Also, it
>>>>
>>>> Which changes to filesystem layer are you anticipating?
>>>
>>> Roughly speaking...
>>>
>>> 1. The proposed "assign" interface would have to become more indirect
>>> to avoid understanding how assign could be implemented on various
>>> platforms.
>>
>> It is almost starting to sound like we could learn from the tracing
>> interface where individual events can be enabled/disabled ... with several
>> events potentially enabled with an "enable" done higher in hierarchy, perhaps
>> even globally to support the first approach ...
> 
> Sorry, can you clarify the part about the tracing interface? Tracing to
> support dynamic autoconfiguration of events?

I do not believe we are attempting to do anything revolutionary here so
I would like to consider other interfaces that user space may be
familiar and comfortable with. The first that came to mind was the
tracefs interface and how user space interacts with it to enable
trace events. tracefs uses the "enable" file that is present at
different levels of the hierarchy that user space can use to
enable tracing of all events in hierarchy. There is also the
global "tracing_on" that user space can use to dynamically start/stop
tracing without needing to frequently enable/disable events of interest.

I do see some parallels with the discussions we have been having. I am not
proposing that we adapt tracefs interface, but instead that we can perhaps
learn from it.

Reinette

