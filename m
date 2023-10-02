Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CDA7B5729
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbjJBPt1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 11:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjJBPt0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 11:49:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127AB93;
        Mon,  2 Oct 2023 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696261763; x=1727797763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9/Zd8EGIbtewjsL64q/yEBaT8KEMjxJ9IGtmcmeEoSk=;
  b=JGvqzBUiepoG7nt5MqDnpyAK4ZIv6pA3Np7rW157JZSPjtfSd3+e/uCq
   2H8PLqiggABV6IsH5LUnywZcgIjLiROHLPGtqaOzzJIhY2EziOXmWlE6x
   2nptrw3EUNnDj637upsvI6V3/hCXjzwEE75FNc+EnA4Vbel+2st5Yk/cQ
   kYR3QbSZfmd60Rpw2OObMP8nGsCrnwT6pLgupbhNn80ytOQuQ3GN/MldZ
   4bPb4ZkVveLF7lnWit7SNZ0kmqJSAqyscVrpNY5tRKmLhJw9CsRBVYxuR
   ymvtjfzu5+k0VT7i7kvHMvcdeNPEGiOCh8i5T7GfS2aOFvfDqja6gy73t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="446826245"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="446826245"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 08:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="744151122"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="744151122"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 08:49:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 08:49:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 08:49:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 08:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eazer41KqtRXTJIIlnxjuzm7d+ItlvgFLy2LQ4dV+tZx9G6e9kEMuAiewovDNOTO8ucrir7EbHIpjJrKI+m/pLv9nN3Ckg9ehmbFkrquZM7/SKOKWjdV9y2VR12iyfidbs+gxZpLT5L8SUzbTOD7lffqpgJCz2xAG39a2H5sKcMdFgwZ/LggVF1K0hnAhPEqzoe36Jdc4UtWzIjzLVe/EPxFL7bK9XpbLZXjSveraN0QDhySl/bKSr4POny3agHy5U3l5AxhqN5I7R3Hehq6wNt5+u7Y0hA2yKZ4hNjnJ2RBPi0mRt/uq456mScQkGgMtolV++URzSIk4uWQUEMbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djlyxZKV5j/BzOMhdZcV4IvIsWLu4YydxDjUNj9XUSc=;
 b=jeAkFxeDuVaDpsJZXlWDU9FilSU6YveLSFf6jBNEZyw1IS8g+cNy6Gjux5kT9qIAaSNWcEr9X8DhvOZK2KAAKQ1Lbneqsr+hcweX5RsZKdlIihoTXJYLsL2IpHCpc7QU1BxIxSWpuD8DaSLnX1FDVLZJExeI0HcZ4YA7C6ZEj6PioV1S5epnS0UtF+1fHJuc6/vsKahSgbEsS9vPSdCcJhZ/j/kysfu0Q0jXpZwHcKa53iIzXMUcY/F61NAHcGjNNVicCFebT+v5r/nig/S9bTqYuO9H2QvAqA86Dt+6vpcZBwvcDzWZPfcnmwbITS/hjNIq3ZS21YmkdioMtUYesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 15:49:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Mon, 2 Oct 2023
 15:49:17 +0000
Message-ID: <0010108d-baed-14f7-29e7-247d80c9d3b0@intel.com>
Date:   Mon, 2 Oct 2023 08:49:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 0/7] selftests/resctrl: Fixes to failing tests
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
 <6a826da8-a94d-261b-cfe8-c494d7237a0@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6a826da8-a94d-261b-cfe8-c494d7237a0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:303:8f::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: ea13b3d5-9f91-4891-4249-08dbc35f22a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbff8prvdN9buxmThaQvSXcnBIqll2mnHNuVaFzP2nSPrO6WYmUfsL4h+6Hs/ShWVwDpVNo8yNI4LNXQMWCsCuWepFLvhr75EHxQ5fRTtGTs9PBtT9B3yDZJZVIaraJ4ntjWjTAvUhTZmxPaGdzmrHee/xQAVxd6s30Y1eSoE7YNXRZmRIMBRAZOHciDO3M8KuNz3y0fuLClAo8e5pxezRu9nOuErk7P1xrO+F3xacin9VkU4fSXElEubckr1U4lNntpKnlfDkiypSMjfef7OlsqMFh10M61HAMK8Zatgiajv1CXe0Jcxcz+VQjqiymvVU36jVepB7M/ZCPYzFMdkwfTtXTGHPA9O/noj4x+kFzv+0OEt1jUgAXCWzxIiRSHZbNevUVwgb8Ug5E1cQvOs01nbvJsUIMU2dxzwMOOKbiwwyEw6hblU1WykOZuQwNwCjHjkSmeXYJRBwH6/bLv8NJRne3HlsUwMEq1iXBlTJuuFaXU/jUZZ1Pg+rqzRTtwCsdvQsTb0h0XbJylhmDWg2GMWB4XqZDLdUwiKEuI16zNwrKVyBj6PMYssZQe+wGEKjt3EqAb/QMHxGy/Ajc1HmkxV+faBQKcS7Iw5oSEbGqjm8P9H7ZVa1mT62gY+xk2Gvyn6cAmbK5Aw6S1bqQCvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66574015)(26005)(2616005)(82960400001)(86362001)(31696002)(36756003)(38100700002)(83380400001)(54906003)(478600001)(66476007)(316002)(31686004)(6512007)(8936002)(8676002)(4326008)(66556008)(44832011)(5660300002)(66946007)(966005)(110136005)(6486002)(6506007)(41300700001)(6666004)(53546011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWgrNEZXMFgway9tMTRBYTJubktEbjNvbXg0cEpYUERYVFVmVDFCTmMzKzFu?=
 =?utf-8?B?YUM0VjFqWnJhQzczZm1BcjhoaWh1QmpWckJpL2h1SytxZWdCTGZNS09NcEI3?=
 =?utf-8?B?SzkyRUxZV2dMRFBPRDBpOG0vekVtNHgyVHV6VG5URDdSYU9jdmlRR3RhWEdn?=
 =?utf-8?B?SWFjN3FPQnNibkgzSk0rUE5QUWlwQ2UxaElROER5VE8yWTI5aElTUW9DMDJF?=
 =?utf-8?B?andPWjFhSXNUaWVuSUQrQW1IdnFPVmYvQ1hKdzFuSjh4ajVVZElxMVIwbFMr?=
 =?utf-8?B?alhvL3FMeE1aQ3dtV3FVc0ZaUUJWVmNnVmxLbXRNQzZ3bmtOVW0rdkFra2x0?=
 =?utf-8?B?VUgwZndLU1c2c0gzR1Bnd3FtSzh5bjZXQWNwY213dEY2YkNDcmpzS3Z3Rjcy?=
 =?utf-8?B?TjdEekNZbzNOeHFNZzgycUMvYWM2cW04S2NBMVJuQVk4S3FwQWhTYWYwNkJH?=
 =?utf-8?B?dmRsZWZLLzhkUTMxaW40NFdwL3JWYWNib0FNKzZMRHJvcWlhTFFWV1A3UmYx?=
 =?utf-8?B?bUdLV1BxV0oxMzAxd2Y0OTViS2dUVDRWZnRhZmU0VDFLNkUrWnZ1L21mTFhE?=
 =?utf-8?B?NklVdDhoazFhQUVLV1hNZ2JwRXYxaERTQlB1d0tYUzdUeUJYQ2tZR2xSclB5?=
 =?utf-8?B?MjVzSytMTEJ3RGxOQThrUS9sZ1duRU1KdUY5NUJtVjduTlQwdWRBcUpKSG9E?=
 =?utf-8?B?UE5NVWRCaXRBdkFoemVmN2Qwb0xrWHFKZGpWWC8zakt1Q0ZPYlVSWkRqUVFC?=
 =?utf-8?B?dGdQckM4ZkNIMEEzbU1sUE5XaVhQQ0FrbldnVEtkVUI0aXJCd283bFhOaVRI?=
 =?utf-8?B?bUc2eGplR3FGVTJlWWMrZ1dYYUNlcUduenAwQVdJdnRXUXZrRHFYTXRYd285?=
 =?utf-8?B?OXZLd3dsYW1QVTRma3QyMzIrQ1F4VkRXcmlBenNvNEJaUm1JWmxuOHJsSVU2?=
 =?utf-8?B?RU45bjA1eGpYdGNycnRab0lBQnV1aHh4N3FwUWRndFBWWFdmck5FNzAyc1A5?=
 =?utf-8?B?NmNYNlFjNkl5bHE1eTQrUENYMWpmV2RXNm9QaG5GU1FvUnNRWWdCeTczYTZR?=
 =?utf-8?B?NE5qZEROY2lJTXpsdkkwS2FEdTRJUHA3R0pMMndwQlV2Y096dXVPRUxkcmQ5?=
 =?utf-8?B?YVI4VFVUOU5XZWo4K1ZsUG9FNEQyYlBzZ1NvNjNRd2pRVzEzZUpsbW51ZHJW?=
 =?utf-8?B?WkhZMHJTZllFTFRGamh5bnJYSXdGUEkreHJWakw3NG51ai9sWTVEM0JqdWtH?=
 =?utf-8?B?dkYzY1JXcUVKRVhJSGY0V0RwTnJscmNGNm96MUZ2aWl6ZmVDWFRseHdrbWdP?=
 =?utf-8?B?aTFWcjNicUxXZ2puRHJhMTJ5Z1pKWUgvQzhRc2dBek5YQlNKSWR6UkJ0RlIr?=
 =?utf-8?B?WUk1dUZNRUo3b0ZHa3FTMy9jUkxwMnN2bVBiUTFseTNjK0tkQ0FuYWwyVjhp?=
 =?utf-8?B?SjNPWmlSaUtRLzg5ZEQ4NnRocFllMVpqcGw0NjU3QkRLNk0vQWhuMGpZOUIv?=
 =?utf-8?B?TGJKMmlQTWRvN3FHUEtId041bXd3dWJTWGVGZDZWTHBYUHpRalJRL0ROc2NZ?=
 =?utf-8?B?U3JOWWgzRUJEdlJuVTVKRVBSenFxSmZjR1B4WHhFM1ptNDFFdmhZTGNIQnQ2?=
 =?utf-8?B?U05jM1R1SnJsNnRXT0xVV3hzZEZJUnlTb3BQQnR6b2RFaks4TmxoU1o3RUhD?=
 =?utf-8?B?VHp3NGJySnlkeU9MKzhUYWlBMG1VS01odDNnNE9nL2lrOVc3Z1FDUFpFUURs?=
 =?utf-8?B?b1NNd2lGWmF4ZHFmdHB3M0hSZkZQZ1diS0xpSUpUcWh0QjdDSEo1N1dvMUZQ?=
 =?utf-8?B?TFNmTVdRQkdDMXZ4T0hrMG1POGd2c2gwTmFkYzJVa1FzUzdBdHluWWs3MXV2?=
 =?utf-8?B?U3M2Yk1uUWNuVzFBSU9hb2NBTm1ONUJkL3o0NFBaVEVLSDNxbjlLY1RuRUZ1?=
 =?utf-8?B?ZTJHZDJSSkJPTEx3bzVvYmJrQ1FXVHNTL1hOc1U3TVpYSVdrSllZZzZzUURN?=
 =?utf-8?B?K1pnekhKVDBhZzdRZzQ5SVFiQ3o2bHBjY2EzVmMzK0gzSmM3c3IzT0E1eVN1?=
 =?utf-8?B?TVpWWlZheURndXpodHEzdDJSQ2NtY0xNelhEbDJZTEo3RjZkeXc0Z3Y3Y1A1?=
 =?utf-8?B?b0dPdmc1dWN5ZXVZeXk0b0R3a0FuSWlUdzZtUklndno1aFhpTzRON3pqUDhw?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea13b3d5-9f91-4891-4249-08dbc35f22a9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:49:17.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzGwrHFviggHkBSlcH/J7wgDcRd0+naj6SVPfi4af4/Q3a1PPgYJhHoOpxWfqZtR8T3L46s6L9/LiU9MzK+PItUnyP8RH1MEyEYeHQKZBe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/2/2023 4:31 AM, Ilpo Järvinen wrote:
> On Mon, 2 Oct 2023, Ilpo Järvinen wrote:
> 
>> Fix four issues with resctrl selftests.
>>
>> The signal handling fix became necessary after the mount/umount fixes
>> and the uninitialized member bug was discovered during the review.
>>
>> The other two came up when I ran resctrl selftests across the server
>> fleet in our lab to validate the upcoming CAT test rewrite (the rewrite
>> is not part of this series).
>>
>> These are developed and should apply cleanly at least on top the
>> benchmark cleanup series (might apply cleanly also w/o the benchmark
>> series, I didn't test).
> 
> LKP seems to no longer happy to apply this cleanly without the benchmark 
> rework series as the signal handling fix got now a bigger footprint 
> (maybe LKP didn't build v3 at all as the changes from v3->v4 were really 
> small and I did not get error out of v3).
> 
> Shuah, would you want me to reorganize this such that it goes in before 
> the benchmark series? In any case, I'll wait until Reinette has had time 
> to look at the first patch if I'm to send the series reordered.

That sounds unnecessary to me because I assume that doing such reorganization
would require a new version of the benchmark series [1] that has been ready for
a while now.

Both series look good to me. I just added my "Reviewed-by" to the first patch of
this series and it (this series) applies cleanly on top of the benchmark series.

Reinette

[1] https://lore.kernel.org/lkml/20230904095339.11321-1-ilpo.jarvinen@linux.intel.com/


