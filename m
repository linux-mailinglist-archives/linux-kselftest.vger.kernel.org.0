Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA34400F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJ2RMG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 13:12:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:2958 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhJ2RMF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 13:12:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="294169287"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="294169287"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 10:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="530461506"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2021 10:09:36 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 29 Oct 2021 10:09:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 29 Oct 2021 10:09:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 29 Oct 2021 10:09:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGry5ThQPlo7g0YTnLhL8P+BkN04v3GleoW65Oxeujp8Qyz6GEA5uRogoMGwKII/vQ4IG+Gwp34YYsdkbdnhPPE8J+VTI/qoNn5HrScVgEoDZyAtr9JueuctnobtXawkrhRKHohFe64Wq09H8oNMeSDWwKHvxVU1Gt+QxVu62nXmWsG7kIY+LyJqXVqwxLNUcS6fE2XCBq+17PIMdX5cOLQsJlXy/Or8d6dHRjwjJveanjuEcBPUKI7DuHN4ddU23WOZiYdNqZR/DSyixDZFSZUmlhgUe3lcA2qAxha16bmbiQpSWm/6TK+38k3BV6rT7sOX4rsqQ1UhQynR+oEelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9l8wzH9H63h2K+SrsRbXepkax+ADX7hhmyE7xVLFKo=;
 b=ClyIp54wuw3skUbYATHmE9GpwxwoSfW+PJX7dC4dHBYzdRtmoJwfJ8w1FXRNrsp9jF+EBKojcNLjBHSlemU9QkmwhAsWC2f4KDU1M3vlsY4nZ3ZdZtNxPjP8DJ9u5egHOS4JyIMes6ABGoOxyCknHn4SWOXINqqDEaschxyza8+4gL9Vn1xSHPmdrYuZW3Q/F9H5KACL4+sN3nUMSEZqVJDZloTlTTDny2iZ2pfqv3rhCw/OAmTjPCdQJZ0uVTqQ2mlx2AS0O8NLbCtsjvqon5N15gcGSCLSmhTQ1/yX3RLh2vfI5kiYWgX+aNr7Yih2564XgTu07LHJJrWe5bZAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9l8wzH9H63h2K+SrsRbXepkax+ADX7hhmyE7xVLFKo=;
 b=CIj9EXbnWwYpTifQ2ZtWPoVMmE6wTCimbRUKnB7idoIKqkA9sPkyLOxIHUFksghbnIQhrBlR6GXTDOR6wciJF8a3eYcVwcpKcgOt86W+U3JcUH//uQnDm+5OYSc2NTCSN3uv6PcOmoJp/x0jRGM6li9XNjDfxEfZumkeQITfRrM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1442.namprd11.prod.outlook.com (2603:10b6:405:9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 17:09:30 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672%7]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 17:09:30 +0000
Message-ID: <fc40dbf4-2b09-fc06-dcf6-3232ec037635@intel.com>
Date:   Fri, 29 Oct 2021 10:09:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.1
Subject: Re: [PATCH V2 01/15] selftests/x86/sgx: Fix a benign linker warning
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <jarkko@kernel.org>,
        <linux-sgx@vger.kernel.org>, <shuah@kernel.org>,
        <dave.hansen@linux.intel.com>
CC:     <seanjc@google.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1635447301.git.reinette.chatre@intel.com>
 <545aac243037bf5c2640929c4d8ff5c1edfe3ef8.1635447301.git.reinette.chatre@intel.com>
 <d382d0b0-15fb-5e96-accd-c3b59be72dd3@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d382d0b0-15fb-5e96-accd-c3b59be72dd3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:301:4c::13) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR15CA0051.namprd15.prod.outlook.com (2603:10b6:301:4c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 17:09:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 704218db-bb3a-4919-5945-08d99afedf0e
X-MS-TrafficTypeDiagnostic: BN6PR11MB1442:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1442ED588C2F3A3A1A1933DEF8879@BN6PR11MB1442.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDSE1IRsOu4dxwdIsz81D+0zvyLFDaqcAXfcj2JncvH037bHoQ2ZxWljSzD5m+dn5zfPsInGSrU3TARbvBBIqUCcDkT+/yhEpwAbocgBhVi1hFBdFO0XB7DBgrzWfbESBjC4X/uxrBPXuu2j9xjAm7sIH2StFtJ28wbgVlb0BAsKDFHBE1inlOeM+vQbSVVcrWd8PnIPHQh1ksF9HCeKklpXaKk4qEvaA5FmlkDl8y3p1nKUu7K17lAIdMP0fQ7sGMpVXRd9LsSAOOET4SR0moynDkoEawRu1k2BGTLwZIpAtRs9hXFlzL1rD7A1isX6wBQijWxFhpeGwYaxCa2RdNoVe4ENgi78QzBQoaRDwuDu8m1oUZWBsng01GuME+QkVn7mWwvbwq67K39oQxcq/0+qdPa2YvguNg0DgNeKl1PWXzqx+f9yVinirQIxLbCphTzOYl9OCBgHvK4k/rPM5oDBGwlBiqAvVib9ugZRKHX72HFPlBdb8TlMhXh16eD5r9ryuHM1Vz0lBUpNJ8/Ajw4kTSKLJGWdbD01FBqc48aEq1hBbTKbBIQglbrY7onTUTugG68R5U3Re/VveeyRCNegoHgCvjSP608q2AwnehgW1uJ/AES4HC6CThxuxTWZ7oTbduSeqoe3O1vKEILQEcBCyP+h835aY/eGtpqOxX52wUh/aWUOeoiW/WCff+VGxBewsH2Kqy2bJxPmbE2JdCRo81Lgm+TkBSa0v32H16A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(82960400001)(44832011)(16576012)(36756003)(31686004)(6666004)(186003)(4326008)(2616005)(956004)(26005)(66556008)(5660300002)(8936002)(66476007)(2906002)(31696002)(8676002)(53546011)(508600001)(38100700002)(86362001)(6486002)(66946007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpqR0FTTFlXMlYvTlBwd0xFNDhHa1ZRdzB0bTAyNUtEb1FwaFIyUjRicldv?=
 =?utf-8?B?MGVoK1lEZUhWamJ3N0VyNTUxc0g4MDVabkpGWTR4KzlFY2lhU3RsRHJzUFBU?=
 =?utf-8?B?YU5aV2w4NnVlZGowTkFsOW02SFllREFERWcvM1hRZFc1K2xxTThPaEJsU0ds?=
 =?utf-8?B?cmFwaHJsZ3lsVjNzNXVhYW51NjRua0R1V0g5MW1NUzNIQitQMXBXb1BHbFBx?=
 =?utf-8?B?NmNucmdNRU5Mbjd3UW5jNFF0N0VnMXE0VHBMVnBnNm9VZzNSd3liU0ZlbHBO?=
 =?utf-8?B?WlZ1a0krYVlnNTZZYzBsa0VqSWF6bDk4MkRpOVdiNWhHeGVoVWNhcEdSMGZt?=
 =?utf-8?B?MFl2cndyemgwdEJXSllaQWZjZ1RHbHdaV0g4Uzk5Y0UzMjBXL3Q5amFhanJv?=
 =?utf-8?B?Snh5RDUyVXRlekdlODYzNzQ5SWd6WnduMkphYUFnRDl4alllRjZhMThZdFRV?=
 =?utf-8?B?emkvQnNQcjBsWlkxbjRjdkovOGlVVksrT2hwSDZ3RXpTYWQxMEdPckNIajZB?=
 =?utf-8?B?VFp1b1AwQllJY21BMitQcU9SOHlEeFJ6Si9RSzE1SEFNWWVGNVpVaGd0Q2RE?=
 =?utf-8?B?NVRzZlgwL1h3cUVjODF4OGM1ZnBvYlAvaytKbmx6c2lNbDF6RkFpdTFHNVhs?=
 =?utf-8?B?bjVrTEZYTlZwVnIxRmtTMllWRXBHUzdzamtaQWhzWmhqeEhkenlEWkh3RUtw?=
 =?utf-8?B?dkd3TGN1cTBpWk1NZGxRYkhRNVliWjdSM3RBUS8rZ2VPdkZ1ZTJnd3hXazh6?=
 =?utf-8?B?Zk5ZaDJra0JQOWh5aTYxNk9MTk1JZmJQNDBucFpxRWdkYk1MSmF1Zzg4V0Vm?=
 =?utf-8?B?WlBLUEptb2xNczZ2MkJjL0NJUHN2OEZVR3JzS2VTaW4vdG00Uy9tWjZmTTl5?=
 =?utf-8?B?KzVROEY5VzI0Z1VKTUVHcnFaWjdKUmVJbnBucmNOTXp3ejJoODhpS1hVQ2pz?=
 =?utf-8?B?MDFZdkQ0YlJCMXR3Mkh0eGdtSHNWR0cyYkZ0THAvTmd2a2RSakwwT2pYRXdR?=
 =?utf-8?B?ZU1lanNYcUoxaWNLZDVKM2piT0Y4cWpFd0QyTVdCbGxEQzMyU2VrZHhqN2th?=
 =?utf-8?B?QzViV0tOVnloczE1UGFNN3dreGhEQmc1cFUyYnR1Y0pRc0pqSjdSUCtkYU5j?=
 =?utf-8?B?NDZVaC9rekZ3RjQzVko2bUNuS0hQNVltOUJlWUVCOEE3Y29PTTFGaW1BSy84?=
 =?utf-8?B?cFN3dEdyTkRPRTdXd1pBZEVkTXlZN2Vwd01tb0ZpQTRFV0hIbzBmRUpEYjdL?=
 =?utf-8?B?QVpTeEVBZEFoQjE0OFdzcitURXI0dFU3citxS25BSncvT1d1b3pzMnA4Wm9n?=
 =?utf-8?B?V1F6Y1VqNmNDZHZHb2VzTng1WE10bW1FbWZEbWxUandMLzV1c1MxZ0dsdlR6?=
 =?utf-8?B?aExWVUZDUkIxdVdQSHVtTTNZbFBGbXhVd2Y0NmdsSWVRYnF5Q3g3TUxkbmxZ?=
 =?utf-8?B?TjZrK0VkLzN6MHlmOGZMRTZ2a05ZVWhGZHIwcm83eXNKZlk0UU1DVTZWaXlN?=
 =?utf-8?B?Y05uangrRU1NNXRoSGkrN1piM3lrbGlYQlVsZlA4QlozL09BRUhHTUE3WkhR?=
 =?utf-8?B?cGlLLzNudXd5MkI2Q0ovbnJtb1dYY2VlMW80UzhTaytRQVgrb2dlM2ZEcXln?=
 =?utf-8?B?dHFNSWlNVzNsL1hpUjYwUm1yZk54VWZDS2ZSWUh1TzNHVGtHb3o4c2JjaFlU?=
 =?utf-8?B?Vlh6Zlk4TUg3Z0ZsbHgrRndVSC9GcStDc2lsTUcxQzJ0aWVKQlVEMXZoQVAy?=
 =?utf-8?B?U1MwdWJVdjk2cVRuQnNWeVJkT1JsVXQzTDN3ZUIrdExtSk92NlpnNU1GVGNU?=
 =?utf-8?B?QmpJYVd6TVFoeWlodzZYUDNvanBtY25iemQ2UkIvc3R3YkFRQVhnMSt6UkRR?=
 =?utf-8?B?NUdxT05Ib0c2NFZUcTl4ekl1OUZZdEFjemRRWjEzRmFPcmJHbk5WQzRYNGNQ?=
 =?utf-8?B?TzRUVXVBbGlhdmErakNZSU9kMFBSRVBvU2JHSjhRUnNWdXZ0U00rc1dCUFdJ?=
 =?utf-8?B?Y3ZDbXZoVlpKZGtESTExQ3NFL3hsWlVlMlR0OUdkYVpuQ0VocjFOandWZ1ZJ?=
 =?utf-8?B?djBvcFZ2T1FJWUxaVDZlZUlyY1JHNWhpc3dROTJMY2tCbzJJQzNPOGxVYno1?=
 =?utf-8?B?aVhIVEVWWmc2ZlU3VGNJdm1pQWlsNzFlQSthbG9EZDlDeDFnMjlWaHZNVm9G?=
 =?utf-8?B?NmFVY1V5SXVveVo2VWowZ2RlMm5Ebk9VcW9WTkRsbHhHTlZpVTdGNGhxbDBT?=
 =?utf-8?B?eG9kNjJnLzM5VVA5OVM1c2t0bHVBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 704218db-bb3a-4919-5945-08d99afedf0e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 17:09:30.5749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJmP/qsQAB7JzcF2KemUaDeE2bOEaZt/fbwh0RGH7CFN8bQYe3uF8i69MlEKOXMZsaXXkaYXk/iXNG6kTzODgxNeEp3hfQ+ZvpjmVsvHitg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1442
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 10/28/2021 5:26 PM, Dave Hansen wrote:
> On 10/28/21 1:37 PM, Reinette Chatre wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> Pass a build id of "none" to the linker to suppress a warning about the
>> build id being ignored:
>>
>>    /usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id
>>    ignored.
> 
> Do we have a good grasp on why this is producing a warning in the first
> place?  This seems like something that could get merged quickly with one
> more sentence in the changelog.
> 

How about a new changelog as below:

The enclave binary (test_encl.elf) is built with only three sections 
(tcs, text, and data) as controlled by its custom linker script.

If gcc is built with "--enable-linker-build-id" (this appears to be a 
common configuration even if it is by default off) then gcc will pass 
"--build-id" to the linker that will prompt it (the linker) to to write 
unique bits identifying the linked file to a ".note.gnu.build-id" section.

The section ".note.gnu.build-id" does not exist in the test enclave 
resulting in the following warning emitted by the linker:

/usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id 
ignored

The test enclave does not use the build id within the binary so fix the 
warning by passing a build id of "none" to the linker that will disable 
the setting from any earlier "--build-id" options and thus disable the 
attempt to write the build id to a ".note.gnu.build-id" section that 
does not exist.

Reinette
