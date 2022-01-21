Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787504964C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 19:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382005AbiAUSGh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 13:06:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:57919 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381908AbiAUSGg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 13:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642788396; x=1674324396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PKeWfgYdBIHLOX4DBrtMZMbD+P2iyhr2qa5QPIeVnZw=;
  b=jPQ7j5Ir3JRDaxYQ/fTrpQKKnsIQgSFazO4TdVDbBUB/tLGpS4UT7Tha
   kpc8FBppY6dzjf5bv1w7+COEKAqUSSvsSABeNa05O9KH0itTSfHx98dys
   QzsYP/pSJybS1ZlTYtGUzOoRlCpd6PiCQosTVPC/CuXBSyQnMO+fr7pwP
   NyaWRJ1wr5woBB0awDGmA09GiTgQkVJqVOC33Xc4LU3gtoWHfH0PQhZLY
   MHdsZv24ztHan6fBmA/bncYMmeWHe68Et4QO5z7nfpxZaUO2YP2V/FeU1
   1vd5H8Yk5kWEf6GgnEcz4Rh4sIQEg/n54C106dDqk1r06buleJkEAENwy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="243307591"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="243307591"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 10:06:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="561957995"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2022 10:06:18 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 21 Jan 2022 10:06:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 21 Jan 2022 10:06:18 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 21 Jan 2022 10:06:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q18Y9yxhqhPZz/dYrIp6MKKR8HxAizVmUv35l1hxkx3oej3AfqxHhb0L3DJri23Fbk7MkEnjx1JaHXs9cu43IWq1QQExq8GIrrvCCPHGRakuJCkCB04soH3cJp6DIQqxph/99XGqdF7i2o18oyx7sJTPm2XkX7QvN0vVMV+jjLN0hRLIxjB8F2SZ62Zkun87JQMq7GFTBBfk+OZsfi2QZrGGO7fyvQlEboLXhnzJ17Q34zPjALyFSGu4FPJdwQtRSySixk/iQw9uLUEsOCLsR1BuTTHO2p4w76Jj+GiZTmU1roZnPxNZe2SyR5OufYhaRC03i9s+Jrk1/614nAYXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNp/jc6IbEuOlTICCINXqSk89QiRQEosPNp+OWqJ7xk=;
 b=TLEHAZ62Woe79E/gZ1q6D+hByKqjaR2MAxxWCoh5FEfw/vjed74DIUY8B+UoWgULGX/BeDSkS5JCfnYy4QE0NXBOO5cLjz48Ac56EsN7pQxNhkfoFm9j0PncOmqRQQ2SkeCq83GDkr8ljuSJZv/f67+Z/3wif/yWNy7Rnkt/0I8jpZ0OsVgsOZKZd803nc1r3n/5s6WNqOjceVEPEe9Bwdmn3ljF8Pa4HAiH/pyDRsenLA3Rzq5YDYKfVgD9Na0VBiJJErgNSHLV6AEh8quqneeJDRmLf2pqaaIMVciBoRkDFVVqBmjSi6va0ZRNpQwwq6tVAmgSJdV8f0sOJN2hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SJ0PR11MB4925.namprd11.prod.outlook.com (2603:10b6:a03:2df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 18:06:16 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 18:06:16 +0000
Message-ID: <db556fff-90f5-a513-e823-db33b121f3e0@intel.com>
Date:   Fri, 21 Jan 2022 10:06:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/5] selftests/resctrl: Change default limited time to
 120 seconds for resctrl_tests
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
 <20211213100154.180599-5-tan.shaopeng@jp.fujitsu.com>
 <c8fd3125-b61c-8182-d7af-0f7a85eba345@intel.com>
 <TYAPR01MB63301CABB489B1A764A9E8718B5B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB63301CABB489B1A764A9E8718B5B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:104:3::11) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14c04d83-101a-4178-666e-08d9dd08b795
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4925:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ0PR11MB4925F0F484154C5CC6913727F85B9@SJ0PR11MB4925.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRbXg9eM3ZgzOrE8ZpUgcMvzREtZ+Q/v+OBgtGogmnkUIRH5MCh2njT8MrQQOSaHLJWoIquf+2VbEZESrifVt5Rr+8UhcvKgXTkacOSZlbTEtu3U5r9nrv4x9cWepsLZw5xJubM7jtz4r8qMVnx2ghIgIEO21upX22el2ahfGqNlZ0+MQVNEDQgrsaNw6CalgND3jNog3CIlbVnsFOVzZF36SAWEWtYvKCex/e+cNLkrd9P8a6BnTZosSOyQJNdYyoQy35iQPhM5tInu2KNc+8KB7uYnG2/SEKP0gGRE8N9D4b+GTIK9NxejsfiAke7MexxcsIEvczLZ4LIUvEKsse9gibVng0EBVTM79QYG745/Uk2n4ra1GquJ2eO09wRuO9LeIDbI6KMNgbl+7Fupz0OeL754ZEu68eoqGvus7bhabXIrwPGTCacH6zsT7ObuM7aoo2XrR2F9EiusCta95m2FmtORPhBAuhHjBhPThPuORZCUzEIxaMSVdqi5kRJhzZgCnYDLl5J3UGMX9eiaAQ4dTtszlDjztbC+rmoZaI1Js2sPXoszIW2HUyzB6j98iI6Yg0OSoBwuH+dIR9986JC3CrZJL0x9ElDQFOWZWaQCa72cfF4P936ah5FD92A8LQwU9dzUpLjQV+gTOctYYZplhB6Bu6pKizEhEW/ZHB8aDQMLSn4oIW9iJzyFE/0j9NVV/2lefjk1+zEudVWb2om+xjU25jmXQocBUOl3Hew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(6486002)(26005)(36756003)(86362001)(31696002)(110136005)(316002)(53546011)(6506007)(2906002)(54906003)(8936002)(38100700002)(82960400001)(508600001)(66556008)(83380400001)(66476007)(4326008)(6512007)(186003)(8676002)(44832011)(2616005)(66946007)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlAzOGI2d1BYUDBiMDBLQUpKbWdFYmN4Znh2ZlVRa1RsU2pWYkdYSUcvUFZW?=
 =?utf-8?B?ZGdyN1JvdC9iSkFYWnh1aUI3cVozVkY0Z0NlaFlBRk16YVVWMkMrTFZNR3RC?=
 =?utf-8?B?dWgvaG54WDZyTnJRSVZDRHE5M3hxaVp5b0ljVUhySWphTnkwZmxsUGRXRjdW?=
 =?utf-8?B?MDJKVFRUczY4RVVCUzNvYW1ySW00aE5CcE9FdlgrRnhISnJING1pY1V4ajhh?=
 =?utf-8?B?RytnSU9MOUQ5ZG02RTlrYk80bDFvQUlYUHFnbEZINlFDTDI3bFFyRUJRL0NU?=
 =?utf-8?B?N1AyemRUZUhNQ2ZtbEgzTTA0UDVVVmI1cTl5YkprbzRZYTZXeUMwNVB2RzJB?=
 =?utf-8?B?V3FuM25XYUdyUmF6UDMwWDIvWUwvNWJacUduS292UHJoMGkwMjhKT1plRHMx?=
 =?utf-8?B?ZUNXYnhpdTlZUytMazhrMHdrbHVpUHFVZ1dYL1JpZjNmR2owRUYwdEhTNnlv?=
 =?utf-8?B?Ky9PSzZMYzZMbTV4MHZKOUV5RUpqbnAwQWNBQk9IYWQwdXZTZkU0WDlZSjJw?=
 =?utf-8?B?OHdQU2V3NzF5MmdicWxmR0NnTjhJdnlucU96eU5iV2xPUnZwM01iRXJJS3JV?=
 =?utf-8?B?dU0xK041d3gzb0xGekErRmw5NEY2UzJUWGtIMWVXb1V3RGw3M1ZHdDhVQlRy?=
 =?utf-8?B?bC9oSkxoRXVPOEhlR0RFSjNPYXpMN2RpelRnTHJaMDhXTk5CdUFMbE0xNFdw?=
 =?utf-8?B?T3BIRGdmYVR3UVFmUDV4TzBhN0c0c0F0a1c2TUNRdjVBL1RGdDJ6RDVpVXFp?=
 =?utf-8?B?TFdoRnRPM0swN3B6RE1tY3d6WWs4eFBjc2VMQVhaa00rOHVLNnk1aEpvajcz?=
 =?utf-8?B?dThYRDY1T0Z4U05ZWDc1UGF0U201QVlBd0ZTRGwwQTdHQnZUWTY4YWxFSWxt?=
 =?utf-8?B?UjFVamFqQ2s5a0VqRDQ3Vk83cko3eWZubjc2akRkUUphYTJLdmtjUWc2Uzkz?=
 =?utf-8?B?a21qSGhaWE9TYUFISnpvc1krWk9FWnNSWUhRZlN0N2dnaElQaVZLbjRaODZB?=
 =?utf-8?B?SW0xQXQwSUU1bjhhMDVINjZVVUZYRjhta0M1NGtiUzZHQStUYnZReGF6cDcy?=
 =?utf-8?B?ZEU3czFYejNJKzRyTW9UOFFLYTdBdGFraFFWc2dmRVFIMTRCMkkrUkwvWUZH?=
 =?utf-8?B?b0JTYUVldW1GR1E2dnJnYmlSczMxcUs5VWN3Sm15cFZOaloxN1B3R2VXVThO?=
 =?utf-8?B?aU1BYlJaU1lIYmhueDZLb1g0Y2ZtVUQ1QWlwS0hDbDJVdXNsU1hQM2t3M09U?=
 =?utf-8?B?S0VYZWYxUEJUMzIwOXlad0RPMkpJdjBmOHV4dE5yTlRZZmw0NEEwcCtzNE1C?=
 =?utf-8?B?WVJteklXUE5JQTA2ZzdIRlJoZGIvT2JsVjJWblF1elN4bWtzK2hFMGRkVktZ?=
 =?utf-8?B?L01VcUozTStOZEhTOXp1STdTK1FiL2pza1l4MW92MldwK2ZyZWl1SjJLYkQ1?=
 =?utf-8?B?cFRDZXZQS0JQblNiK2RJR3c4VlVrNGI1ZkU0bm5BSGttQUF5eG5DSCsrQllS?=
 =?utf-8?B?SzFkcEQvV01hdzZnRjQ3NDJxQS9QSGR3UVBzR1MzYTFyTWl5VUNwM0QxSncy?=
 =?utf-8?B?a3VNOEFJQVJLMUpTUy9oSlhWOE9TNi9mT0hpVUZXMmZKcUcvVVdwVm1abklY?=
 =?utf-8?B?aG1hYmo3SzhEa1B3eGU5TC9NeEt3RVVMUSsvNDJ2dlpOQnJMbEtJL1RIZFBs?=
 =?utf-8?B?R0I1QnFoamdzbGlyTEF2WnFGYVdTOUtQeWFOWkprNVdqVWQ4Ris5VmkxWU01?=
 =?utf-8?B?WVVlSytmL3ppNU1yLzJDT0FjNFVGZk10TjFqbk43N0JGZ3ZwWVNPZ1pFNzVa?=
 =?utf-8?B?dFVLdWNoYklwR0IxT0ppdUJITGNDeWZmbnlidm1TaGIrTkZLc3hYS2ovWE1N?=
 =?utf-8?B?ZmZkN0FsMHFZWVZDaDM1TWx5SExFbGpDUWFyWnpTSDZ2VEFQK2NWcEVITkNy?=
 =?utf-8?B?OGFvQWVVWlBkcWJBazJRNlhMQmlnY3I2UUlGelFmdS9ERTBoSkJrRlRsKzcy?=
 =?utf-8?B?Sk1VVmlhWEhKejlsbGFWVUkvM2FFWjVWR1EwRXZSMGVUamdHTVVFZ2Nmdk5t?=
 =?utf-8?B?S2NFOHNwM2RNWGd0WTdUajY0SGlvWkt3WWZIRHBORjJub2NHM25yNEt2QkNZ?=
 =?utf-8?B?enJqeWh3bjJFOHViTE84ZS9QcHZCU2czdFZoS0sxYU1lZUVqWmhsM1hzcStu?=
 =?utf-8?B?QXNKZGhzM05Sdmxaanc3RWJFcEU4ZzBhbVhCNDNzcmFYNjF5K3dGWWozcGVa?=
 =?utf-8?B?RHZhek4xVDc0QVg2TmVCZkpSbHVRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c04d83-101a-4178-666e-08d9dd08b795
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 18:06:16.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBPdKvnuGigSjeIcEr3NnW9EXtyOgKWmzYqMajRqpCzIu1QHcuun1RX4pS/uDqX0sc//X2Dq1Rhbd+PdufFlF3xrGuYSmmwPXnwoQX7WssA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4925
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Tan Shaopeng,

On 1/20/2022 11:59 PM, tan.shaopeng@fujitsu.com wrote:
> Hi Reinette,
> 
>> On 12/13/2021 2:01 AM, Shaopeng Tan wrote:
>>> This commit changed the default limited time(45s) to 120 seconds for
>>
>> (This commit)
>>
>>> resctrl_tests by adding "setting" file.  Since 45 seconds may not be
>>> enough on some machine environments.
>>
>> This sounds very imprecise when you say "may not be enough". From what I
>> understand you have already encountered systems where this is not enough so
>> you have established that 45 seconds is too short. The next question is, how
>> was 120 seconds determined and how do you know it will be enough?
> 
> It took about 68 seconds in my environment (Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz). 
> This test accesses a fixed size(250M) memory by default settings 
> which is used when run in kselftest framework. 
> I think that the execution time does not change significantly in different environments.
> So, I roughly doubled the execution time and get 120s, which I set to the limited time. 
> I think it is enough for any environments.
> If 120s are also not enough, user can freely set the limited time by "setting" file.
> 

How about something like:

When testing on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz the resctrl selftests fail
due to timeout after exceeding the default time limit of 45 seconds. On this system
the test takes about 68 seconds. Since the failing test by default accesses a fixed
size of memory the execution time should not vary significantly between different
environment. A new default of 120 seconds should be sufficient yet easy to customize
with the introduction of the "settings" file for reference. 

Reinette
