Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D366572200
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiGLRy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGLRyz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 13:54:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4962C13E0B;
        Tue, 12 Jul 2022 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657648495; x=1689184495;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I6axTZti0Agbl7Q5HIyLKikfCQ6sz4AlrGfaSkBZ754=;
  b=N7x4wzJlCf58xoYc3ND34ydILy/DSvgO2hbyU/9wKwSvs4YCdbfo6DcI
   zmKkP/aCTqMTEuuwnJD4O7nLSwZwtu8w0eIJzWGcYMTj+Ltx+MG8+yWFb
   kxDc4+2oclB6+zyuRUCayPWkvXJz0+4ss2yaRIDgZtoLsWzNfkmJERJBq
   2HTziRIUiHeu5PRIPax2g+6Yrw82sFWhRytpGtYhi3AKpLe9keOSSeo1o
   b65O2jF71bndx7NeBh2IbmjHeLBv+T8L8zoNwkHRGpsWI8Tjz+UVY7ZbG
   Fit3O7hCmMqeui1/+WvPBrKOqc1EVURlhoGwzMh8tOd3HrtyO+o0GMuLn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265416894"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="265416894"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 10:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="698107464"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2022 10:54:54 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Jul 2022 10:54:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Jul 2022 10:54:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Jul 2022 10:54:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Jul 2022 10:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mktYp0mpXONKZaEQvWtft1Wnp0YPdcmaC86badbecF3Tfu9mVjh5oaTNONbNejOuU1wyiYH1is4Sf7r1h2928qLiUobKNcj/Ip7VpAY/rFfuXPL7vvd1j32P6WhxrDw+VOWNwgEhs4K3+LDK3M5bQBq1PuEWNbaBTrfxpzAeIgLJIHz1khnUR9fAbyljrODh0QW6Ka1dbitOlSc6I6jRF1jYn5syamfWdJyQ+ibn/lH59dZhBSfLv8H3RUtoXZ6S0qp57z7v2lYwPxJKs+7VFbJxw74E6Tk6Mjx5id0hH9O8oGJJsWhtlpzZBJDDeNh3KxniiewMZwIoudlDNHKdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5opj3bWTcb3+ScJcT8b2xfK1K/vNYfApIc6jX6Nd1kE=;
 b=B3yrDwAwplzSZrScVyb9jdD8bbboOrah3KJeDetglmNA3nl97X87W01gpdZO6l9+8vHFA6O4zPlJLR49OyVE4uQcRFXYqu4cXCOOwsDK581MyEucFxQGv8JnfZJrH9wycayF2CSJc/ZePPYCRG9j67rsxXyRifhPeeH/JlsnUbf91lSddWXZk0JkTMMBrDHlHHzZ9kDwiz43HaPA6etd1yn4JIDIFmU6aV5pupE6vXNtn9Hb/UfPhL7ZvvTzrk2Fr9BbDKRaJiXDj4m0C6335nAcjsXqIJK8aD7zMEC6lUqchzHUtQgBsrFxods2gBIIluNCFhblEavMpt1tbFA0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by CO6PR11MB5587.namprd11.prod.outlook.com (2603:10b6:303:139::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 17:54:52 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 17:54:52 +0000
Message-ID: <db39a1c0-45e5-7458-00c5-87ebd56f3894@intel.com>
Date:   Wed, 13 Jul 2022 01:54:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] kunit: executor: Fix a memory leak on failure in
 kunit_filter_tests
Content-Language: en-US
To:     David Gow <davidgow@google.com>
CC:     <kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
References: <20220712095627.1770312-1-davidgow@google.com>
From:   Yujie Liu <yujie.liu@intel.com>
In-Reply-To: <20220712095627.1770312-1-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f44017d7-ec97-4c6e-27e4-08da642f9efd
X-MS-TrafficTypeDiagnostic: CO6PR11MB5587:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcyAcpn1UnJwZWvOpcfOr7rMWw2uUAAU0cyCcqYPJtdpC5wwgR+t0nRUDbaFoDXZ6j+Tjkk3SBTl6Px3S7skHrzH4Ur7iyC+mUPqWkhKs1tXFJT5Of+20wELboQ50WF9GRnmDmDVAawr6vx1aIqfjCn3LTJwB0W4XQPLenfCVSBY1Mb49Sid7cDYJmW7TBcLEvaqqkO1m7KVBU/zrh3lPSw+PuoWms4DACz5PsnxrATvcmHkkhPlwVGVeBwK5Wdm9cz3IV+5ugwcyWyKGNsEspYU3HZHfXND1pmGh/r3W9nIt96L54NDr91QFjH8S7k890Y/Wtzaaz686Sr+Jf0Q9bXmFEqQBfqXJq7xphbDOvP/g4Wn+Rmjuz8qvy9ODTAylx1Yeo+cKr0fKGvDG4H1z7+IukiWB6y2p1zKqAS3NnVH5wO36KuX5Pa14CCUnuSPfnykTi4yMstog7PvpfEaSRcHUuSrLtmHXIHuUu/VKAOFMJdpI/U0eQL5yV00r9tRjqd8HpIv5X3qGn3mW+yepNYd7BLYWuQ93FjTty9TFaO71q53jTpfC5gV4HmSTHgPrygWOnhvrSPZ55v5aCS/d4UW545mIePi1tbUN/eFNiAeYZYl04M0Qpeu1OL53CB54C5yUJUZxWmj9Khppz9Dn8UbZ7JNkv2GDf/W1maImM17a0bKANb0hWRtqOi9zg/d6viLRpJNNhKaothve6CBFjnt5+corNgEeZSRyfUqQJ4FsRIz51Rwwj5/DGaCYXGQL9O2Nu2W1cxPQiYsxaXXzwZuyk6P25LeyMmqsjIipyBCqeWPyME0rtszKVg71ZkQW5s5njQHwzFuNxwmT++K1LgHHCIL5pfKlFLcunvmBQnRUKh8vg2fwIN4suugoTJr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(346002)(136003)(39860400002)(38100700002)(82960400001)(31696002)(5660300002)(44832011)(8676002)(8936002)(66476007)(66946007)(86362001)(66556008)(83380400001)(316002)(2906002)(2616005)(966005)(478600001)(6506007)(54906003)(4326008)(53546011)(31686004)(41300700001)(186003)(6512007)(6916009)(26005)(6486002)(36756003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm80UEFoNGhmTjgyeDNWQ2c1emdPUm1rL2Ivd0tXQ1gxOC91SFBCZlo2THBz?=
 =?utf-8?B?RHBDNWtGL1ZYdTNNVDFHeGRLYUZKZ1V4d0tLcmFCbHZJdVRieDVLbzBoeGtu?=
 =?utf-8?B?YU5Wb1JjZEFYekZQYmNoVnpCTFlLS25HOW1GRkkyU3NRQzY1ZVVrVXVUUExP?=
 =?utf-8?B?QU9KQ1hEZG5lTWJZWkRxOXJHdnNBcXNuVkZqNDc0L2w3Zm9RdGhBOW5aWFU0?=
 =?utf-8?B?NnJYTld2Zk9VVnJia0xFbGZBMllrbkkzUVN6akI2RGlvMjlKZWV6MXRUNUpx?=
 =?utf-8?B?VWQ5SEttZHErSDM0M2FuSVRFMVFsVEppWVFaVitiR1ZPbG9pWVJicjF2aW5Q?=
 =?utf-8?B?ZmVHMkVFTmk5azM2amlrRGEwSkIyeVJhREZrSlQ0K012a0VXMkN4cmswQk9h?=
 =?utf-8?B?TEs1bEE5bVRmbG94bWlia1QxRmJndHVsOVd4UGtDWWpNMWZYU2x6cWZwN2dR?=
 =?utf-8?B?RU5IQk5SUDRjL3kyZG4wZ0xlMk5YS2FPaTVqVGV6OHRBdW8xMGRZSzF2aWx0?=
 =?utf-8?B?K25oVW1JVnBrcFROM0VyQXpYVWQvd0xKU0t0V0RJaUg5TGFrQll2UGtMVk5u?=
 =?utf-8?B?QzdNS3U1MHA1UGZoNFIvL2lkMUdubllkU0JMNG5naHZxRGxaRUQxbzNGRTFy?=
 =?utf-8?B?eUdBaWFOaU1CdE94QUlFOG5IODdRaVQrZHE5Vll2ZU4xTEM4SVBkRnZXbkE3?=
 =?utf-8?B?NDZwcEFMQmFyZnA5UmxteHNKVDN5a0IwRXBGbDdNbGdyZndMVHFlOWtSYjdy?=
 =?utf-8?B?UmRLRUVWY3VkczZBdFB3ZDhCN09xNWEzdFdnam9QVFlTdFF3SXBUNk50Lzk2?=
 =?utf-8?B?Zm5iZjdGU3F4Y1BjSzRlaUN5Z1IreXRGUy83UjNWeHB1Vm8yZi9NRHg5YUtN?=
 =?utf-8?B?U0hXdFVKOTdQeldHdHFWQ01kMWdUZ2w4MTR6aFJrTGxpRzZvMlJjYWQ0S3J2?=
 =?utf-8?B?ajBxSU1SQk0ybkhCVFNMWnVJL3Y4cHNMSTBjRkp4OFJCUkF5TVk4dEd0ZEY4?=
 =?utf-8?B?WUkwYkE4clNaRzhGT3hneXR2WHJmdTA1L3ZNV3hIeVhDRHNnUDJ1bXBkL3gz?=
 =?utf-8?B?NzNVOGR3SlFRRFJZaVduT2RwSUQzblAySzVGRnZGOVNrellMQTNGRWdGcHIy?=
 =?utf-8?B?Kzg5bDJBN3VLM3NkNmd1MFFVTVMvR1FOekhuKzBNN1BYbitqMm5jU2JoM1d1?=
 =?utf-8?B?L25tQkFvVkJlay9pcGlvZUhqbnN4bkEwR0R5Z3IzMFNubzdERzJBWnBQUXF6?=
 =?utf-8?B?WWhTSy9wMEd3U0hZem1FcXY4bEMwWWczYmoxNk5EU2lpdjIvWWxvTmI1c015?=
 =?utf-8?B?Y3NYM0YwSE4zQld0UmRGOWlQZEdpeHhqbWwvbnhGSE9BVHV5TTJmckVkcXhl?=
 =?utf-8?B?Ry91QzhOOTljNUkvOXpOUnRhUG5CTytHejIwbzB6Z0U0elNPWXA3ZGs5R0k4?=
 =?utf-8?B?T2RtSDhZOER6dTJSZVNuMEtQQjVSdWtSbUpENld0cE5RY2F5SGZDTVdSYWEx?=
 =?utf-8?B?K2dibGU3UUVxWGpoMHhnS2dpcDFWcVlhVWZYd3M2MWdUclh3MXA2WmxkQ1hK?=
 =?utf-8?B?NFhueS90Y2RNYzVWM1c0Z2JTRTl3UUVjN0JSV25pbWtkZlpVNXJ6eDc3enZh?=
 =?utf-8?B?UFR0U0E3bUY3K1lZMWg3SWc3Vm9XUmIyRUZoMUJmWXFXMWhkc041RGdkOTlF?=
 =?utf-8?B?RHdZSVBSZkRmZ29sQUZ6bzZiRlZubjNYQ001ZS96ak1yUTVaV1Y0STNReTRG?=
 =?utf-8?B?dlBnd1R4MXJkKzE4T2dPazhsNVcvNW9vaWlQNkdLZnlmbG9CcmdXM2xmWlhv?=
 =?utf-8?B?TmdabExrREJ1eW9zbTZWS1BOUTRER2s1ckJINnArcE1JY09tUEhTQ2pFVWlQ?=
 =?utf-8?B?dGhQNGpEWm4zcjlRbDFQcHNMeUNoRUJZNUxvRjZlc0M2bUJzUTJBc3Nudmda?=
 =?utf-8?B?b3h4eXg0OEp4dmtNZy9WZ3JrYTFta3lkMUNDS1p4aXJQL1luUlo1Zm1XTG1y?=
 =?utf-8?B?QU1TUGFoc29JVHVPYjJtT3YzcDhTVS9KZ0ZTa3RPVHByOWFla2Z4ODRISSt5?=
 =?utf-8?B?VmhWTGQzQjNPemE1eXlGUjE1K2RTNlh3VnZWMGd0SlFHRmVMME1wZk5DZTBt?=
 =?utf-8?Q?HcX0eZcGNknta4c9+JNnpFt53?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f44017d7-ec97-4c6e-27e4-08da642f9efd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 17:54:52.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcrYeGkjocRk5Q8RC5o7zGtJDcYH76r/TI/TuSSWwzXsO/etaM46LF61MCrgEC1Nu2QlaOCyx67UFudESx9aVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5587
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On 7/12/2022 17:56, David Gow wrote:
> It's possible that memory allocation for the copy will fail, but for the

I think it is "for the _filtered_ will fail". Maybe a typo?

Thanks,
Yujie

> copy of the suite to succeed. In this case, the copy could be leaked.
> 
> Properly free 'copy' in the error case for the allocation of 'filtered'
> failing.
> 
> Note that there may also have been a similar issue in
> kunit_filter_subsuites, before it was removed in "kunit: flatten
> kunit_suite*** to kunit_suite** in .kunit_test_suites".
> 
> This was reported by clang-analyzer via the kernel test robot, here:
> https://lore.kernel.org/all/c8073b8e-7b9e-0830-4177-87c12f16349c@intel.com/
> 
> Fixes: a02353f49162 ("kunit: bail out of test filtering logic quicker if OOM")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   lib/kunit/executor.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 6c489d6c5e5d..5e223327196a 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -74,8 +74,10 @@ kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
>   		return ERR_PTR(-ENOMEM);
>   
>   	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
> -	if (!filtered)
> +	if (!filtered) {
> +		kfree(copy);
>   		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	n = 0;
>   	kunit_suite_for_each_test_case(suite, test_case) {
