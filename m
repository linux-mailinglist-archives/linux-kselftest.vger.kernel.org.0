Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58178478E95
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 15:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhLQOyv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 09:54:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:43804 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231971AbhLQOyv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 09:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639752890; x=1671288890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/0Zc/vHTggxK3+Tz1HiehIu197Q75Ih6njHufZwO28I=;
  b=HHsG8aqoCjRwr5AAbVc1rUuLKoSom6Xo5NOMaGqBVW9CvbvMg2aiIQJI
   jhVRMR1nTYCyAGJsI4hmLtgJz/4m3v/+ZQ4RGHxw2EYrGzQrTm3h/+0jd
   hl57XJ42CfN5OnKe26L2csbVEqkEm5+z6fc5M8al4nYVfoLuNj+DqTSS9
   IMkRSuyqaTX909xRdvz65dnvy5m/8F9kEK1DmLEvcug48U+uPS+t1o+Fz
   5EobYY5OdyFQd2UBfjtGR80jGWp6ogLeSsRkzl8ODQhQf8X73rjyDTXlS
   FLydiLB57ZLKOD8rlQETsQKRt6dvOD2HiNiXAYB+uvXDnxi519Vb1oh/I
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="303141556"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="303141556"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 06:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="756497574"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 17 Dec 2021 06:54:50 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 06:54:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 06:54:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 06:54:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1Ij+e0PIbJObOC5PuOKSk/Ao4S4nAvQ0POO9eWokfLPYzKRSqYV7ZCaEmZUJyi92g6+Si+XV+X2ns8F0WrOVA4Vxo+mCAzJz8Xfx1HErHDEHY0PWXYrNTAnB9DCGWD7oK56Cy5I7TPG46F+Y0AZAvej0uiFtC5m/1Xpm9HruJmk9g98kO0OWgYhMYB1KNgdBfo3RQUVXLMSCwvMfppoGaC23qR6sU0eEI7oaEOARz7MM8x4uJFsHHqa6iw3Tnnxj/uDgzcfi4QoIvqPrq/oOOL1dUFu93nLj5H3EWP+/VNRfCcxzllsy6dek/edb+aALTvur9n2ebWhJGT9/xhGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu5LvzcwQC28JOdgjcWpp3A1BYFTWLOGEb4+iF5ekTw=;
 b=Oy16VjhkWT/vruwUwZXgiLiRHQn07RRO62Fg9g5JiyX55pEkDZw7zqQzrNyvtmP3XzFeUS6j3Ib0Yz6FKnS4/vnuoCjC/XX6Gy4SQpVvEdaHfEf8MERFuYIvx5qHgp0RzsuGLf11PcdhrTJohVBHWUyB15bWpuF2lw54YloMuRoQ8CdQoN29U5WO/JoCUBfDEJ8bWXRkBd5P8Mcz7+TsYfnR0cPW7FG3H88Mwnw4d9tUduiLE0mr2PvQQLrJdvXcxThQgUY4iit5ot0NMmvSvJPsO78GZ2V/iY5RuYP4O36y8Ieus3GeaxmBmaR+Z/SFlZ66nVIqeDrityxwubYtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by BN7PR11MB2625.namprd11.prod.outlook.com (2603:10b6:406:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 14:54:41 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 14:54:41 +0000
Message-ID: <5712df5c-5985-4327-5d62-ddcbce1078d4@intel.com>
Date:   Fri, 17 Dec 2021 15:54:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH v1 1/2] kselftest: alsa: Factor out check that values meet
 constraints
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kselftest@vger.kernel.org>
References: <20211217130213.3893415-1-broonie@kernel.org>
 <20211217130213.3893415-2-broonie@kernel.org>
 <f0caf4d9-5e1d-4b85-9d2c-00b65fa97638@intel.com>
 <Ybyg+x636Y2nMcVb@sirena.org.uk>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <Ybyg+x636Y2nMcVb@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0330.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::30) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f5730d0-f31e-40ff-a4f7-08d9c16d2777
X-MS-TrafficTypeDiagnostic: BN7PR11MB2625:EE_
X-Microsoft-Antispam-PRVS: <BN7PR11MB2625D7ADDBC5145983C5F0E1E3789@BN7PR11MB2625.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T98FXdf96SqerASTWuTSs0kgllhVVu1744nsQa71kUbOCiOX/WyZo8jv32nSs09jmS6GOmNS6mrJcajktMcJFHD34lPIhHUCm1QbnCU4s9IxQjpfkWg5ZAiOCppDKGMZyWk+pwHIvOKf0vXTIsWDcAuPaNL6oZyguHtdqxV+wppsp0vA3Ttn6/r91xec/NUfSPF4aH5E4IdFlkZpNYRFIYnMPF/PnUiZWVMijebjMuMSPyF934MaoA2Wdi+xwFpJpG7jsjQqzPdkeh04Kc2MoTDoEyxP5dkd12pDgPzIAj+YwooGhI2F6brKR4tCqllmD4e2/e8AUV3JsbaoZyiHk7bb4Znbz7eoiu1EI4Rbqj0gipoS+e16SbAKoZ7Th5u2O8Po1Kvkm7c1c9PGRdjDNf4U1F/H+b8qDW1l2AzhmUnu/I1QkxuaqkYlbZn8CuRBN3hdYzbci8ZgnPdpgvZsFe9OM1ESgl7+8OeT1zaDv7/tmBcGpc9tWon8dHhDXAKXKDU/WdLZ2KUGDcL5We42RJytLhixxEdf3A0fqVydchJ0yd4QEMVejc+VMIIqf2XWn6+uIdWB80QJwv4lXh2v6r/0AnL0piqRaUtlF/9vQj2QhhK2kYJI3J1cgR6ZZG7zflrqbeerLgSSHsDGkDFGkBhbMArD2sphBgzPngUcwgTsFfJ3Da8s48sY005YeJNyW6x2uVjQqqqYL1jjqQvGYBNK7LRXDBm9XErCRF6h1ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(26005)(2906002)(508600001)(66476007)(316002)(8936002)(82960400001)(83380400001)(5660300002)(86362001)(6916009)(6486002)(44832011)(66946007)(4001150100001)(36756003)(186003)(38100700002)(6512007)(54906003)(6666004)(53546011)(31696002)(31686004)(4744005)(8676002)(6506007)(4326008)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWt6cHU4WlhqTHNHVjNoMVlLS2ZvTTFaQmE0Zk1ORmZMc3h1eUNOSWdEVGZZ?=
 =?utf-8?B?VEUydXR5NDQ3alYrK1VtTWdWcStYengwaGMrWVBFcHRRS042NUlPQWMzU2F2?=
 =?utf-8?B?aDdBRXErb0xyQWR4SHhsZEdNQ2RQdlhuNlZuZHBTb0QyRURvVVpxdzZhbjkz?=
 =?utf-8?B?TzZMRXF5aENHQWwyTkFNbDJ6dzUyZGJoR0hwS05heXVFUzIwZTlRSDRxMUli?=
 =?utf-8?B?aWZmNHpMV1JtQVR6ZnhnaGYwZVBSR3poL0VqTGtYNFkxSWtWYmNOdE1OM2ZM?=
 =?utf-8?B?S0srcGwzMDhnRGQyTzJpRUpzRTkxLzUxd09mQWJGUjlUZkpOQ0JVd01vVmtI?=
 =?utf-8?B?N0xaQUxJR1ZFazVWNEl3UXN5Q0lZUmhaUktNV3B6SUlabldsQUhUTXdWZGdQ?=
 =?utf-8?B?bnBNaW14WGFVU3FkN1gvbkpwL0dDbWgwR1VtZEcrWUdza1BOZzVQOVFRSitE?=
 =?utf-8?B?dEtYUjBYRWhiNkdFdmZMMUdLaVFvTFM5cExyek44U2h6R3lOcUNGOGtWblF6?=
 =?utf-8?B?OWU2cU1KeFlrdHVxZmtsemIrazZVQ0pMenNmdUNUSytJT243SEFPT21CcGxF?=
 =?utf-8?B?SS9oTHdoVzhvRVA2M09kTDRLWXJoZ05WWWtqK3RFb1RCYkExYjYrY2lmK3lY?=
 =?utf-8?B?WXpLOTRSQXQ3V0FsWE92bUNKcnVSN3VVWEN3b3ZuSlh1RlhGNWZLUUF3dDB0?=
 =?utf-8?B?eHk0cW0yMFFxU3BVNDVLcjZ4bzhjYzNKYk1vQ3FmRUJuOWFYVTNkYzdYU2RP?=
 =?utf-8?B?NDBGYkY1UG4xMG9GS0lhT1RDMU5vRXMrTWpNU3NhaDhlZmhtNmcwRERrYUQ2?=
 =?utf-8?B?VURtdXIvTkNKaUNGL3E4OUNOTnFMREt3bnRCaUYvOXVXNmw0Y0huNzJtUUll?=
 =?utf-8?B?bnpWc3ZBS0N4MmVTK2NNeWNPTmZhUUo5Qk90TFFkbks3ZkwrTVV5bDkzY0VR?=
 =?utf-8?B?eG05R3QreDFXdjlNcEQzM05scmFTaTJxNi91SjVqQjdsRCs3QmVHeksyV3h1?=
 =?utf-8?B?eGhVbjJuRFBkTUplVE9VVXlGazhaMXZHMXhyM3NGZ0pOMWp6aHhZK0o5alNG?=
 =?utf-8?B?ZzFQdUpzRU1OQVppUFhjSVkyYUdMQTd6NmFEaFFza3lnVllJRU9oMW1RTC9G?=
 =?utf-8?B?N052THJsdFM1L2JmTGcwcUpYZ25Da2U0Q2ZFVGhJUGR2aTlSRFRKNmJvaXJE?=
 =?utf-8?B?dXJodFV1VTl2MWdZYjZocHlkWjRXdHd0Z0RneVU2RjEzMGN6TThvMDMzbVcw?=
 =?utf-8?B?Y0djTXptd1JlQ3RvNE1LYzNPVWZkbEMwa2E4TnFJcE4zR002R3ZWTTcyZHF3?=
 =?utf-8?B?UUZCTlgvSGFudWQzU2pNdFJJemUxei9OQ25aUzB0MVFHKzBJWFJNMFFNQy8y?=
 =?utf-8?B?VjlaeGUraEM3djdJV2NVdFQyMHkydWRKOGtlRUc3VUxFVGNzS0tnOEpIcFhU?=
 =?utf-8?B?NTJOSWtWSVhDSzBxczRyb0paUDdQbHR2L0k2dEN3eWdjdDl3R21xeEdoSjNp?=
 =?utf-8?B?YWpVVjR4aHpSVzJEWGR4Y2RseWdCQVlCUHRSQ09yMDJEMFhZK3pYTVd4dFJ1?=
 =?utf-8?B?VVRjb1NGSG5NZkVUOUx3U3hDVjkzTkw5dklCckJ5V2FhRW1HVUhsTGdzZ0dk?=
 =?utf-8?B?RkFQODlYNjZJNWR0NitqbURSNEFPYmJXY3lLMTF5N3lGOFBzT210RWd6TXZy?=
 =?utf-8?B?M0lyOE1wd21pVnZ1N3QwT0syU2tTQ0o3Y3VBeXpRSXV3SG5BSWViQ0h6TnZ2?=
 =?utf-8?B?aHAyZ2I4NEhRMUtQYng5MDBKY3Qwbm9Eb0xNUWorU2tmaFBxak9oSU0zaUg0?=
 =?utf-8?B?NUFpZll6SWdGZzZrRVBvQmgyTnRoVm9seCtMM1lxMUplY2x3citPSWtDRERx?=
 =?utf-8?B?TmtHdjI0blhpQnJucWdxM0YxbGlPQWFrMkhVbmFCdjFUblI1MmhaaFc1TDYz?=
 =?utf-8?B?SHdLQ29qR0FGY2xyTDVtV3J4OHBPUlpNRDZTUzZJaHdlbFN5Z2hNYlhBUHdu?=
 =?utf-8?B?cmwzWGw3ckt0RXlmRWdZM2FGazBzaFhsdVlvbTUxL05JNEdXNTcyVHBsNlNC?=
 =?utf-8?B?L3l4NkVsTi9DVlAxTDVLMTRiTHFzTjFrM0lrR2p0RDlSN2xLaThORndrZjVy?=
 =?utf-8?B?QlMzdHVzb1RUTmVQTVM2TUt0NzlsQUhkZEdDWEhpMDMzVzlscFRIOGJIQXll?=
 =?utf-8?B?QUw3ZEptaER4aGd6UVBQQktNWG5QTXZ4MzRieFByMDVsZGhkdGlCcFFrSk5y?=
 =?utf-8?B?QXZSMmU2bU1CbTJtckVicmYwYnBRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5730d0-f31e-40ff-a4f7-08d9c16d2777
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 14:54:40.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SL4kG8s2YB3Aq37Q1eIsVr6o2iEk/Wsbn5NZfkhllxfoofN66InyplYK8s8km2i6HhbKn2SPDSSHqNHoM5ykyZT1oBaA7C35ECNURYKxcKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2625
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-12-17 3:38 PM, Mark Brown wrote:
> On Fri, Dec 17, 2021 at 02:32:24PM +0100, Cezary Rojewski wrote:
>> On 2021-12-17 2:02 PM, Mark Brown wrote:
> 
>>> +	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++)
>>> +		if (!ctl_value_index_valid(ctl, val, i))
>>> +			valid = false;
> 
>> Correct me I'm wrong, but it seems a 'return false' would suffice. Is the
>> continuation of looping still needed once a single check found above
>> evaluates to true?

Just read my initial message and clearly an 'if' : (. Sorry for the 
confusion.

> It doesn't affect the result of the test but it will cause us to print a
> diagnostic message for each invalid value rather than just the first one
> we see (eg, if both channels in a stereo control have an invalid value)
> which seems like it's more helpful to people working with the output
> than just the first error.

So there is a good reason to do so. And I agree with such approach. 
Thanks for explaining, Mark!


Regards,
Czarek
