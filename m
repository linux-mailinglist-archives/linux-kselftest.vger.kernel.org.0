Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83F754085
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjGNRgZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 13:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjGNRgX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 13:36:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1698113;
        Fri, 14 Jul 2023 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689356182; x=1720892182;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kae38rPxrj7ZzsC8cLY9x2hnuuVXZYN5+bxmEXTO2qk=;
  b=aXOPzwXgCkB+7iKnkWwvikwuG1FSIs2uSqumVd1rRqB/ih9b2c2C1zj3
   M2TAOZ6NfLS7Y0PRgx0xEbsHg5FE37LzaWhts14oKVfAEsrs1RUqPcHWv
   Ca3yf1vF0ZWpWHWbm0imSVpPnysIhrTV0nBLA1BXLRZFtpiIlixgG7C9v
   j9w0ZX7TYbxER8vt/7s2LSRcDXUBEvcnhzJz2evH5p4eQRpJbE7+lUYx1
   9JOxs9e93tqx+rbOrgedKFOGq25AMdLddgRXkxJuoL+kNwHHs5+FzlJfi
   RFVeNaFXH646fqCvdsxf+fGP+ASn+ufLV7sRcEHNNDNlkxYVLRHwqUg1+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="355471031"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="355471031"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="699753964"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="699753964"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2023 10:36:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:36:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:36:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 10:36:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 10:36:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMPjR1JSC3TO/ufGNs8gbK0puBg/BnCVutcAgM9RroIkQSiuXLKqlJTrM4JEf3kxjHT3i/NrLEMxxYu4qeRgVOVUkS4wMq1JKrNxAOLIijTbSDgPCO5Vwlo9UPrPLuQq+r2mJaLbp9YOhBYriSLwiRnaRb2S4U2ZqUSedXE3+t5ESNRX8VmOxyNKE/AOBQP+OBqixF5jkKwhT7C5ncvfqxbR1iQiV+fQWEvBzjuCi07vb1BTBhfLWN208oizZODssJxl2U77jO8EPVuAOBxrz1nIiKfPxdY6o2F/IBN8eYSzQRg2Gq1pKB3vQ77/uVQUvYaf/Ac7elyA+F1liHVSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDbqtJr3kYFtrO5uE712zahkrpLiecAUXtRqPXrZGKs=;
 b=DqQPS32ITBWAhHcm+m6Vsve3pfY12NJlZ9EOyDh/cjru8Zx1Tg+CUVvjas3MsQbJYjW2yizDvXe0CuJOyVx/2I6xsJJhWJmVf9ZIkqpw+TJ5/h3fydWfJN7nsmC03ZmtW44mEjRq9uf3jwa0tqXexCD93acee8AXF1aZIxxVM5a4RmJk5D/KWsRp6JsYpTnpzyHjWyaBbAXDfLtH86hKsc5ZpsMYt5T9ivMIpijCq+kiA5Szhwsl0uM6FNXwB1g31tzIavdA+U4IK5nbIcXQ/4GLkPUZa49bG0SH1Fmow1YxlamctOuHyMnWKJ0qd/oUsBw4OutGNNtdmwORmN9ayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7191.namprd11.prod.outlook.com (2603:10b6:8:139::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 17:36:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 17:36:17 +0000
Message-ID: <4531fca1-2f3b-0c08-351b-f8e06c5f9f5c@intel.com>
Date:   Fri, 14 Jul 2023 10:36:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 04/19] selftests/resctrl: Close perf value read fd on
 errors
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-5-ilpo.jarvinen@linux.intel.com>
 <a4fa6303-4637-815a-e0fa-57f33babfb10@intel.com>
 <c14286ec-807c-8613-a4cc-d8ac733a87a1@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c14286ec-807c-8613-a4cc-d8ac733a87a1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:303:2b::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a963cd1-d96c-4c91-e018-08db8490d40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VygLLSCr7tCra1guDo+27JTx8tv4sQIP/PCxVnP1+wO1J9VFnW0grjLmdvr/Hbq5GItmJ8h406MFuG+E2XXY8WgkKKkRDbfGhPuN+3FgdZ8/Qef+LHkkAYVfJuLyW9yylQKiz7BM+YqRgsaUKcdZnVs2nZjNm+wIW8jKpzdTRRNMshIkyjRUPv6MMhD5RAcsR6QWUMWSFjXj3lZbzp3jXsFMJcS69lhpxnQLODCt7a1GgoT9To49YJYkv9OJ33fzXZYvRyvl4iKhaQyRW5TcgW8cckrbUxge+Y3GMrnqnEH3lqeKyIAVGyvY1vUSib6UGOndq4nEQOmyCp8RFZb8cUjKIvyI7/ViZY3teFowhgqbGwH/FlsKb+Z9sHkOCUgikoH6eq2zS/GKksiKsSCA01wHd7HfL4hW8sQBjo0JSyTgpAP/4kLX5+ZSTPEbz/OEwQGXlhcE2rRPNiskIKUi+waCeBdrz1y9a5rh5dy7x6PZAhuiDJjgLYTQJPIoX0g72z1X3hs48QqLDZJd9wWi9m1Jit8rQNoGmVMtAE+vt5ueJoxfjdY5zq+11ZXvNa/zLQm2yQgc8Oz2n2jw/axB31+VeGvfumjHhqsWEc2bfd0EytR0GVN8uebCVKbozGIJ19AZrgSk0U0TjcSLbDXHRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(86362001)(31696002)(2906002)(31686004)(66574015)(44832011)(83380400001)(8676002)(8936002)(316002)(2616005)(41300700001)(5660300002)(38100700002)(54906003)(66476007)(36756003)(66556008)(4326008)(66946007)(6916009)(186003)(53546011)(66899021)(26005)(6512007)(6506007)(82960400001)(478600001)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXJuVzBCUDl2emtmckRFMWlhRldFcTFOVE5Fc29tK1pEMTJCZFMvY2k0K21C?=
 =?utf-8?B?VzBjWTZWZ091Z2FUZVo4MUZkNEVQUk9oVWN4bnh0cFNvL0xsSmsrMlZWQkhD?=
 =?utf-8?B?WnJuVXRRaFFKN3p4S3Rwb2hOLzgyM1gyTndPdWNtZ09tMzJXNkxpMEZwREZ6?=
 =?utf-8?B?NC9oUFpxc1Z6OXZyaHFMMHZjTHpTdktvSVkzV3RkUk15TVgvQThBOFF0RlN4?=
 =?utf-8?B?Z0ZoMWVvT1hGTkg3WTM5cDVLUmJKTUpYeDlVUXZHNmMxVGtsU3VMbHFacTBW?=
 =?utf-8?B?eXA3ekVTU0Z4RTFkZm5PN0hudVpGUWdyMzdoU05YSGZodGhJTXRETHBia1lt?=
 =?utf-8?B?YWpDWHRZZlVSci9aYno4RGp5bjZiSFhZUTJBR2MrQmkzRDkvRVVHaUM0ZldH?=
 =?utf-8?B?MG40V3p6YlJ5bHp5L0tNcy9kVjg0U24ySDcwcFNsN1BpWWJyV2lGUzNFSUd2?=
 =?utf-8?B?akVYbXRyK1RRY25WQlR3Ly9iTW9YclhLanl3YWxRMWJHRXFvUHVhbHBIaHBa?=
 =?utf-8?B?aHJBL3lQU3RNUlFCa2cwRkpEd1VDNkxVWllJaG1vM3lDS0k5b2x4VklOeXBj?=
 =?utf-8?B?WWE4RmZ4UWlmV0toc3Y4WmhCb0JtL05vQ0VxZXV0WjN3bDdvSVlrSjhoc0Q2?=
 =?utf-8?B?UHUyRlFZY1hxRHViaHJ3bStnemU2YkErY1hSQ0Njc251a05wYldWYkNpRm9X?=
 =?utf-8?B?aW1OMWs5ZUFOblJQTEpsYXRKTzVub1plS1BRZ2IxeU9veFJ6UG4wUmVPaU8x?=
 =?utf-8?B?SGdSckx0TW1kZXdsUkxHOHVXb0tqRlBLaDlCbzBOTWNpb2xLSnFwV1g5bDJK?=
 =?utf-8?B?VnE4SDFVUS9sZno0azdwaTdaU25OdXdzWVVVSkQ3d3I1bGNPVDd6bDFGRDRU?=
 =?utf-8?B?WFNBcFhkejdDeTRMSXVidjNGdEdtdlNtOW5Rd3RKajl0Mmk3cC9KcUpRcXAz?=
 =?utf-8?B?b0krK3RmQllvandtRzdVUE5qK0FyanFWWndZUzM1L0pRYWo0N3ZEOWc0V1Qr?=
 =?utf-8?B?RUxTV2dNQThmTzUyWENTUGhHcXFEd2w5RW54blk3bTR2QnpKL0Y1SDF1SHB2?=
 =?utf-8?B?d01tQk5pNFMxUDNKRzM2TW0wUVZ1TlFTcld1R1I0dzN2YTNCSUVWU2x5M1Jm?=
 =?utf-8?B?THBWdWIyemJDaEtyaFM2eVdtY2hHMldCRFNhcGRxKzRxbDdJSFRGV1hDR2R4?=
 =?utf-8?B?RUNGb280MnJUejhJYTVFSnkrU3F6aThQSWV1dTI5ZFRrU1pYNUY2UEFpMEk2?=
 =?utf-8?B?eG5GdTFZYVJSOWVVR1lBY25acjRUL2hBVXBxcFB6ZS94eFJXclFFeE91MGhw?=
 =?utf-8?B?QURyUzdVZTFLUFdMOHhOUjc1TmFXdkpRWnN4YXVrWHNVQzdoMzdrMnRyTGlN?=
 =?utf-8?B?MFNhckgzSXBjUGxRNVFLckx1VXpwdVB2cUJTZkFTREhEQTdVYWZhdSsvMHZu?=
 =?utf-8?B?VGpobUZMVW9WUEJPVVI3T0dOSUdld0xtWGp6M2VDcTJ3K2NUS2c5TnBJeFJD?=
 =?utf-8?B?eEs1dXRHdFpXVUYyWkZOT25lTU9Gek4zSHRKaUdoVmJCbHZyTVR4VmRYY25W?=
 =?utf-8?B?dW01VmpVR1A4aS9uT3lWQ1k4d3R6a0I3QnBmdEVPalR2T1dhbnNPUXNtNUFO?=
 =?utf-8?B?NkE5MmtHNmhaQTlKNnk2VGJBeFFTcGtXS2tTR3hUOGhlZkVOVzA0blRRczlp?=
 =?utf-8?B?UEdzWGorRGhVdjE4K1RrNlZ6MmhCV2ovTmRSN1FNb0RlM1ZyVHF2Q0tJMmUx?=
 =?utf-8?B?cTlVb3E4Yk1GY0hnNUd5SEJycGwvZkNzS2E3MDFOamdLZis3blZCcmtqYXNJ?=
 =?utf-8?B?QW52S1NzZ1cwWVdTMk16MEhxcHR4UnB1cVhlWFdmejkxTFpqZllXNGJCaUov?=
 =?utf-8?B?MDZsQ3V1WklneVNjNElFL2Rld2FFODRsRm9Rc0V1VGZ6cEZrYWthbjRpdVB2?=
 =?utf-8?B?NHBwaU5lRGRIQ1pBaHpLd3k0Wmh4dTBmaE9pVkRQVzFNQzJIbEpXbnRnSlNO?=
 =?utf-8?B?K2o2OEh5RHI5SVR0WjhoOXNaQmlMTmxzU2pabzR2YzRYTWV4V3BhT0s4d2ph?=
 =?utf-8?B?QWw1QnQwckJ4L2V2VkI4dXAvSjh6STRBYUkrcEVSa2ptTHNQOHpOUXdzTS9r?=
 =?utf-8?B?cTlNYWo0bnRwcGVWcTJNZE0rck5pVkU2aENhbFlYTGwzUEZzbkZQQ1ZCWkpM?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a963cd1-d96c-4c91-e018-08db8490d40d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 17:36:17.3623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVDnmv9MHWl3MszGr/huI0D6g2EgwNpKf/EAqbmEdzbywsGbh7EPH7TT6BwJ/zS8V+KF7ys2LBT5hwx42Y7K2eXSpzhWwyS4C7Mkwul4IC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/14/2023 3:35 AM, Ilpo Järvinen wrote:
> On Thu, 13 Jul 2023, Reinette Chatre wrote:
>> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
>>> Perf event fd (fd_lm) is not closed on some error paths.
>>>
>>> Always close fd_lm in get_llc_perf() and add close into an error
>>> handling block in cat_val().
>>>
>>> Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> ---
>>>  tools/testing/selftests/resctrl/cache.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
>>> index 8a4fe8693be6..ced47b445d1e 100644
>>> --- a/tools/testing/selftests/resctrl/cache.c
>>> +++ b/tools/testing/selftests/resctrl/cache.c
>>> @@ -87,21 +87,20 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
>>>  static int get_llc_perf(unsigned long *llc_perf_miss)
>>>  {
>>>  	__u64 total_misses;
>>> +	int ret;
>>>  
>>>  	/* Stop counters after one span to get miss rate */
>>>  
>>>  	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
>>>  
>>> -	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
>>> +	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
>>> +	close(fd_lm);
>>> +	if (ret == -1) {
>>>  		perror("Could not get llc misses through perf");
>>> -
>>>  		return -1;
>>>  	}
>>>  
>>>  	total_misses = rf_cqm.values[0].value;
>>> -
>>> -	close(fd_lm);
>>> -
>>>  	*llc_perf_miss = total_misses;
>>>  
>>>  	return 0;
>>> @@ -253,6 +252,7 @@ int cat_val(struct resctrl_val_param *param)
>>>  					 memflush, operation, resctrl_val)) {
>>>  				fprintf(stderr, "Error-running fill buffer\n");
>>>  				ret = -1;
>>> +				close(fd_lm);
>>>  				break;
>>>  			}
>>>  
>>
>> Instead of fixing these existing patterns I think it would make the code
>> easier to understand and maintain if it is made symmetrical.
>> Having the perf event fd opened in one place but its close()
>> scattered elsewhere has the potential for confusion and making later
>> mistakes easy to miss.
>>
>> What if perf event fd is closed in a new "disable_llc_perf()" that
>> is matched with "reset_enable_llc_perf()" and called
>> from cat_val()?
>>
>> I think this raises another issue with the test trickery where
>> measure_cache_vals() has some assumptions about state based on the
>> test name.
> 
> I very much agree on the principle here, and thus I already have created 
> patches which will do a major cleanup on this area. The cleaned-up code 
> has pe_fd local var to cat_val() and handles closing it in cat_val() with 
> the usual patterns.
> 
> However, the patch is currently resides post L3 CAT test rewrite. 
> Backporting the cleanups/refactors into this series would require 
> considerable effort due to how convoluted all those n-step cleanup patches 
> and L3 CAT test rewrite are in this area. There's just very much to 
> cleanup here and L3 rewrite will touch the same areas so its a net 
> full of conflicts.
> 
> Do you want me to spend the effort to backport them into this series 
> (I expect will take some time)?

Considering the "Fixes" tag, having a smaller fix that can easily
be backported would be ideal so I am ok with deferring a bigger
rework.

I do think this fix can be made more robust with a couple of small
changes that should not introduce significant conflicts:
* initialize fd_lm to -1 
* do not close() fd_lm in get_llc_perf() but instead move its
  close() to at exit of cat_val().
* add check in get_llc_perf() that it does not attempt ioctl()
  on "fd_lm == -1" (later addition would be error checking of
  the ioctl())

> I currently have these items pending besides this series (in order):
> - L3 CAT test rewrite and its preparatory patches
> - More cleanups (including the pe_fd cleanup)
> - New generalized test framework
> - L2 CAT test

Thank you very much for taking this on.

Reinette
 


