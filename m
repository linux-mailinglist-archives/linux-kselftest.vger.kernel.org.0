Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C952A454BB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhKQROP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 12:14:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:11547 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239294AbhKQROO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 12:14:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="214715616"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="214715616"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 08:46:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="645928245"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 17 Nov 2021 08:46:23 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 17 Nov 2021 08:46:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 17 Nov 2021 08:46:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 17 Nov 2021 08:46:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/7Q1zQly8Fw7Qw4xEap3u/CGnkxFNt+wOOVTD3U0TTZfUrSoplLkvWd5vrzhXQQhcT3n8erc8l81X0mGOGc0YnsKcsmABGEzOQAGpTfgZqAdqdxFD/L3l+ORAfa10PGdJuw5ydI07IIEMDsvM1VwtVokmoLHsqTBrfhRGA74YDNa+7K444r7lE1BXJ6wPh6iz0CSMg6IUxwaSQBYZq0yAyBLIgqGkSDYbVAxEa/u8mJBoBfbiYZZsdoCOd3B7mVy06JcffjgAv4vJjwwCn6y+h0VEAJNeKDrTOTO1GR0AACN3iLE6PMpU0jDakRCMHgLvSPwCKS6RuU5AAeld1T1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d08PwZyYWA66JcHdCDE2QQkfjP2+BzOoILv0gPNy+HM=;
 b=n4tulgzCBY+wVed4wxNdKhqFg7qEceZ9kFyceNcPp5lFeHeRu8XBeAAkuqcZaVncYnMW8k9Fww2HblJOsz4xE1DdhaSYaGMRJX6D3/476qsK8PzzZFivVwHJMoOcLWoYjePJhq+6l9KMO1faoKEqpsFUAYuyfMQn5mxtonwziK6v8oIQa4Br9f/TiWbHTgo8xAb2ttP1KOEpI7zbEll2damQRYlCmIcRSCax0ALzA7jnrHXyMCHd/4WR+/F9Agou4k17RJN6E3zdh3GUiVw587oJ6Meo6EDg/bnfcdv99ujp9P0MZ/yTQF5fEsnF0W2mYIe4kRnUmV/DM2o9ifUqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d08PwZyYWA66JcHdCDE2QQkfjP2+BzOoILv0gPNy+HM=;
 b=JycPV+iNt7N0J6toSsmpNkIsU85pW5dDskoWYBgunpbBXFtWF6eIMxGlJXrpJIR2qdjeBB8mGcivFnK7/4nUComBfAkrCVRw3SnOt7/KCGLrdqKuZsuWI971HJj8p+joW9hjggPDv7HCQbdtpL7d1jaaN8G4u98qQ3nfWG88/jI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN8PR11MB3732.namprd11.prod.outlook.com (2603:10b6:408:83::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Wed, 17 Nov
 2021 16:46:21 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672%8]) with mapi id 15.20.4669.016; Wed, 17 Nov 2021
 16:46:21 +0000
Message-ID: <c029ea68-e48f-dc60-a8a2-01bb34f692d4@intel.com>
Date:   Wed, 17 Nov 2021 08:46:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH] selftests/resctrl: Skip MBM&CMT tests when Intel Sub-NUMA
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20211110082734.3184985-1-tan.shaopeng@jp.fujitsu.com>
 <c23356c7-3af7-0aba-18b6-2e53ce18a164@intel.com>
 <TYAPR01MB63300DC31AFB0013808FC7948B989@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB63300DC31AFB0013808FC7948B989@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0006.namprd10.prod.outlook.com (2603:10b6:301::16)
 To BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR10CA0006.namprd10.prod.outlook.com (2603:10b6:301::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Wed, 17 Nov 2021 16:46:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c6ed5a5-abdf-454e-ca41-08d9a9e9c88c
X-MS-TrafficTypeDiagnostic: BN8PR11MB3732:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB37323AE6B2E5EE0DAEDE9257F89A9@BN8PR11MB3732.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5NXp9YWSZfpd7BQrVuEuRl8fesYLFhUE/tumCzuqjx206apKu7zI2jCOWJiZOresv4hYr9Z2VXrdIYY5njrkk88AFzEUGDt9gWfwIIMwlvAmFu6bRiJiyijpS/5rryDrTtrI5B47ra3ftZMe+tGwdpqvt+5dtXGYvaATSrlGmV8bcWqflOqwlCR9kVcI0fXzjbGWKojY8KQPeIGwcBPMFTPCvJVgIZaK3bFoBZo6dMGc9DSZ76rnfT9YoFchYQPsEKlcKphgje+Ou+AlBJQ5L+zAmgpVnidFfthmxNtxE+hXGgcMW0MTGgYDj+QKs6fZVif7S8krelobKrZFsphJ8igwljd69jasPjP2bvALa6P6JgtgHJRlPjSs8vv88QtMFvB1pc/ktDoefVdtllpeAJmTjRDp+AnMYvSgIdcK0xSsBMHEgjYYZQpMJ6MDPADovSivQjX+25+XZdhUBvlRgQCjUlcZwrdZ95QiVF3fQsxeVUo6GPT3YLPYwcg+MHWiMmMTyKahKPC91kGTicVWWOpk9sO/dJ1ghLWrjHfYVXgEb9Fc4A/+7iyMcqINUHaMZU438fevcND0QpMmVdYRFc90t95Q2x8C9KNKTLJV5S5chC+zpWEhgmK+dKN65NriEkgTxz46LahayE6MAuN1bS+4CowEsqMNdeFRIHZBKwcOpeWNyW9p1bajoFv7Ztan2j8suvh1USvQgpZrFW8UjMj5xtDEOaqQIbMhatfAd9sCUcqgxHT9+05J34UnORakxVaZyB1DYGMx8YBcfXoxGG2lonVT4yBUlojHUqIUWda6Qq9OM/Xx0KANdDmk0xz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(44832011)(66946007)(66556008)(66476007)(26005)(31696002)(2616005)(8676002)(966005)(186003)(86362001)(31686004)(38100700002)(508600001)(36756003)(5660300002)(6666004)(83380400001)(8936002)(53546011)(82960400001)(956004)(4326008)(316002)(16576012)(2906002)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE13dE9PQ3ZWZ2FrakowQkowNm5WNkVrT1d4ckNSMEFtMkVxbkZTY0lTUzRG?=
 =?utf-8?B?eTlydTNDN1R0RHc0ZW1DM0tvaUlGaDk1cjkrUXJRckFmZ040WWZuVVY4V1I2?=
 =?utf-8?B?dlJUY1JwMVY1QURERzlzK1FGYlk5cDVISXhwaUZqeFF0TEdnT1hobXAvQzhF?=
 =?utf-8?B?eUtKdDliaEFQT3ZJSHcyYU91dHRZdXoyd3hsOHRIa3JCbmtoY3hOT3BuSHBn?=
 =?utf-8?B?RGR2UEpFaHZJUHJrelJ2VGJPOWhZTnR1SFNCcnh6ZmRQNnJ6alB5L3EvSXBV?=
 =?utf-8?B?cGh3VDFyTmVDQnBEaG1hWWxYOWh6SWxuVGZOYVRJVkNSTk1PWFpzdENSblpX?=
 =?utf-8?B?ME5kcEdvOHJ4MERpWVcyT3JyK1FKTzNNTlpLSW5vQUhJV2xSZjJaU0FHQzVo?=
 =?utf-8?B?UFRtWDl5TGI3THdIK3Z2UlZlTlpzOVJRR3g3cnNjTkxvUjJOSmVJL2NqcVAx?=
 =?utf-8?B?STUrQWlEbGR4UURiU3dRMzBKNWFyUFcySTF6SXREdG42TGtaZkNkQ1ZTZENt?=
 =?utf-8?B?TERVWkdaMmNZSmRMVTFxYzAvVmJBdDZvS1Q3UC9RL1JQQ3M3bU9uVk13Wi9a?=
 =?utf-8?B?Y2dsUk9yNmh0V0FLWERxSUIvdVB4c1JkTjY2cXRRRng4YnB3NkhZU0xQdDBm?=
 =?utf-8?B?TEtOSmo1aGtBY0RxQWQwZG9jSFFiY29uMXBJYUNhc3pmc3VBdlBjWDNZYjlU?=
 =?utf-8?B?cFBGSXlQYjFjZm5nbnR6OERjUVUwM2o3OTN0eWNuUm9IdkkxR1V2UFd6ZUg2?=
 =?utf-8?B?dklZT0orK2VsQjd5RmV0TEFnaXZqQmVjdzJ6K3RRYUIzQ1djSmlRYms0ODdx?=
 =?utf-8?B?VGJwUTFjZXJXVTA4RnFBcEs1V0pMVkdTT0dvRmIvbVNVbWpWenlsaVVkc0Rh?=
 =?utf-8?B?ZVZacEZOMDIzN1pqQUdlQjAxZklUbEgzM2hLS3dXN1pQRGZkejFMSldHNFl6?=
 =?utf-8?B?KzFZZU1tQ0JUREtXYnhzWHZSUFZMd0t6SGY4d05ZUG1pZ2ovUlRQNlRZVEFs?=
 =?utf-8?B?N2U1MUVXWUNTMUpIOWMxTlByT05yNUY1SHZaV0hjUGgrUDdYUnQzSkJPOVor?=
 =?utf-8?B?aGdXSVFLTXk1akx1WG9XcWxUN01KQmgzZjVWM3UwckVsS1FJcjdPSlB6ZnpD?=
 =?utf-8?B?Y1lSQmZGV1ZJakxMMEcrbDY5MENEMi9SL2NZRVdJZjhsVHJFRkNldDRmSjhh?=
 =?utf-8?B?V0FlcU00anR1cnhmek1aeGl6disxZk5SYlRRdnhiM1hWY29qNjIxaDYyd3BT?=
 =?utf-8?B?TWpoSThRUEFMVWtDTG5yS1dlaTRGUUFQT08xdys1WVBDSW9XOUQwOU5QVUFl?=
 =?utf-8?B?eHVlbnl1eDNGTm93T2FEdHhQTGRKRllsKzk3Zk1neFRIdHE0MmxGaG4yT3Fz?=
 =?utf-8?B?QmxLanZKOGh4Y2FScWlvc3lheGIvMmRoTCtaaU9VNUxjY2RyYlN5ckZqOGJE?=
 =?utf-8?B?K0IyRHBZN3NEakgyNy9IRjhEY1cvMFJyWmhrcW1FWVBNaEt4cG5UeHpvN1BS?=
 =?utf-8?B?a1V2RVZScmE0MFovbm9RenN1dFdSaG1BL1Z4bUJrbWVRSHZKaVV2RU9McXJ2?=
 =?utf-8?B?QnJURVZaMU9VY0I0YkRUcTBpUnByT0NBZU0zUVlhTWVVdnNWUDJHSFNpMFBZ?=
 =?utf-8?B?d3l5bFJsaG9Uc2duRFFrTTE0OGgrdjlNekt4U1dab09oN1FNeSs0QUJGd3M4?=
 =?utf-8?B?Um1ZQkxwVGc2bi9GMXQvSkdPUzZQd1hzRFAvS0NhTEdsck1sVnYrYjZSanRZ?=
 =?utf-8?B?djRPVWJJaUFZRjBvVVBUT3p2YWpSY1lEbjZjVk5aNXBpZG1sQkVTL2Z2RkNx?=
 =?utf-8?B?Z3IrRlZtSlphZTQ3STB2STRoSmRvTzVYZVVyUWM3TUhTZ2gremp5K3krWE9M?=
 =?utf-8?B?NjJYRXdjN2pnWThnTWJBOEZwYnZOWk0rYWZMdDFHbkZJZkNTdFBjUGJHcXJh?=
 =?utf-8?B?bHF1L2FDL2hwMER0MjFLa2xITjFhcmlCUmtqZlZjRGk4YXJnQVRIRFpyMXRs?=
 =?utf-8?B?bEFhRVVSbE5QcUk1KzN3aGl4eE5TV3dybS9vTkJqdHgzOVdpNWx0RlRnU0R5?=
 =?utf-8?B?QWgwbmhsSUJoRWtYaW5LbThGNjM2amZacVNLa21naXFhTkxZNHFuNkg0YmJl?=
 =?utf-8?B?VEs3RldkazdvWWpSdGlNNWlBUVMxVTZ5UHM1aVM2RnM0cE8xMENQMkY5dVlm?=
 =?utf-8?B?U3I2N1p5RmtHZVhWaHU5NWQwNGRsK0FiMVJQUnNUT3F5Z2RyNU1vU0YxYlBl?=
 =?utf-8?B?amUxbC9vZTgrOXFNdUkrUVl6S1BBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6ed5a5-abdf-454e-ca41-08d9a9e9c88c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 16:46:21.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeYFmbbNZCN9pTpSfjWNNE7Htj+bdV20j8uwBDDywtVr4Ii7mfKTDYFnTpz3oL61aYp2mOjZ0hY1c26ZYcT8dKhN4fhZ4K0zRN7Z0sXrXbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3732
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 11/14/2021 11:11 PM, tan.shaopeng@fujitsu.com wrote:
> Hi Reinette,
> 
>> On 11/10/2021 12:27 AM, Shaopeng Tan wrote:
>>> From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>
>>>
>>> When the Intel Sub-NUMA Clustering(SNC) feature is enabled,
>>> the CMT and MBM counters may not be accurate.
>>> In this case, skip MBM&CMT tests.
>>>
>>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>>> ---
>>> Hello,
>>>
>>> According to the Intel RDT reference Manual,
>>> when the sub-numa clustering feature is enabled, the CMT and MBM
>> counters may not be accurate.
>>> When running CMT tests and MBM tests on Intel processor, the result is "not
>> ok".
>>> So, fix it to skip the CMT & MBM test When the Intel Sub-NUMA
>> Clustering(SNC) feature is enabled.
>>>
>>
>> It is not clear to me which exact document you refer to but I did find a
>> RDT reference manual at the link below that describes the problem you
>> mention:
>> https://www.intel.com/content/dam/develop/external/us/en/documents/18
>> 0115-intel-rdtcascadelake-serverreferencemanual-806717.pdf
> 
> Yes, I referred this manual.
> 
>> What is not mentioned in your description is that this is a hardware
>> errata so the test is expected to fail on these systems and I find that
>> disabling the test for all systems based on this hardware errata is too
>> drastic.
> 
> Understood. It is not reasonable to disable the test for all systems
> based on this hardware errata.
> When I run restrl_test on Intel(R) Xeon(R) Gold 6254 CPU,
> the result of CMT & MBM is "not ok", and I took some time to debug it.
> In order to other people can do the test smoothly, I'd like to update the
> patch to disable the test only on 2nd Generation Intel Xeon scalable processors.

I've been thinking about this some more and I do not think that the test 
should be disabled. There is a clear incompatibility between SNC and RDT 
on these systems and I do not think the test should hide that, indeed it 
is helpful to highlight that there is an issue. Even so, spending time 
to debug a known issue is not a good use of time. Instead of skipping 
the test on these systems could the test perhaps be improved to provide 
more information on failure to help user decide if they really need SNC 
enabled? The test would show that RDT cannot be used on their system 
with the SNC configuration, hiding that information by skipping the test 
may create false idea that RDT is working with that configuration.

Reinette

