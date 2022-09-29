Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD85EF8B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 17:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiI2P27 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiI2P24 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 11:28:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D578B15D66E;
        Thu, 29 Sep 2022 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664465335; x=1696001335;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ymVMs9YQAEHrUsOFD4p3QpRHL5ugTKg2ApMBGil5TDo=;
  b=jutOxllCQVA4yvDbozvM3uVJH+g9mY17rWCEyn/tdKa6HFqrYUYV+yv1
   sJyHHZYwdJ/4Z1phYzlSOxBeDKkvek0wRTFtqA8iQgeVQ6o2zqmjGyjed
   WnZ/GX5CN2RHIBWyODi5DKcali08gourjcMGJUuBBHYnVM+ZGLCWqm5gG
   iBXT0TC3pDQiZw9yi6JMDrkDp7mHgE+tlWoOXcg4qeL6zcXtIZ6Hg9j7I
   zfOoUinGejUQ0Gsy99wMw+JeH+x3nYUejHk5dEznTToVhTQddkl88T/iq
   FhFa6cp8sbdS7Za4sZVkuU+BUNM1BxS3jIWjGb6Ews4MRliMWl5g7OzHA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="299526479"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="299526479"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 08:28:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="867432644"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="867432644"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 29 Sep 2022 08:28:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 08:28:55 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 08:28:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 29 Sep 2022 08:28:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 29 Sep 2022 08:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD3HFEl5+pRH7YsKxTo9Oj0pIqQxf4VtyqSzUcirp8Kl7E/ah9ho5eIJ9znI4sxSQ/0fB7cmNZH0GlcGEGOaQOhoG10rSPfwMwBuKVQSi0VJIK+4EHM8YGEkwbpHV5NWHuqn43aDf49NqVozD8rYsAljRikhCEXN7R0Acz1UjT6XtwL4NseIbgMGeyGKRKFbj67fPjiDeAw/oiI7VPnfcgG/QFmnI7eDd1CtWhurFh1B0ryAZReRzgXaW+eAw3BVF2XruDXw59Tay0u9zMv9iB4aPLUN8LPhSXacKkCgQWeSgWVYT9KAE2ENwpbMr0Nd57jvpQybARtQzjsbZqkikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ENedHNF14K3f1nXrGOAAroR4D6UItq1bzc5qgCMWco=;
 b=JGwovjr+HDT3xG2G02tE4EVKuVdlmpKVL9/rEg9JZ+Ygpxcms4F3YXMuXZ0vbWvfgKKQLKz374A7XoBVEclpn6NjBSDAGd91xx+imwT2XgzpCTjPnjAsmZ8MoXEfpBt5DKj3tyMsBeXdX+nyne9ur+a6OwD/s2ES4XJkDZg4KH5+Gbkbq3Zl+6KYxKzGXH8TlswQ59MhlrAO1Tb0bz2/crP2ic4KaWMbbQoMOjAaDbXigrlSaZlG920dYYW9zgVrFFM7k/Odt8srTZeJnBUpnXFU9RBgC5kJyQJm+gabviZxX13TApNcza2QkAnFAIZkqko0xk/1RRprswEF/PRXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7191.namprd11.prod.outlook.com (2603:10b6:8:139::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 15:28:53 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.015; Thu, 29 Sep
 2022 15:28:53 +0000
Message-ID: <c1ab0387-ff56-a7a5-bfd5-93e53293a97b@intel.com>
Date:   Thu, 29 Sep 2022 08:28:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH 3/5] selftests/resctrl: Remove duplicate codes that clear
 each test result file
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-5-tan.shaopeng@jp.fujitsu.com>
 <bdb19cf6-dd4b-2042-7cda-7f6108e543aa@intel.com>
 <TYAPR01MB6330988D96E4CD00C9A03DAA8B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <a0841d1f-fcc1-f307-7e2d-b9cce534455d@intel.com>
 <TYAPR01MB6330E178F0D86ED8ACE075378B579@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB6330E178F0D86ED8ACE075378B579@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::19) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: d883bacd-f9e0-42a5-57a5-08daa22f50b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlzafGhHLvbpKD3HmjHfrqH0mjTAx1lTl3ReSDeH5p3t5t1bODvDSamkY+UGxd9xHK8Lfqw8XcP+k2O1tKynjIFByS1gj05Ot9dHh49sYYx4jeCJHALK+lzYG3Mus3d4O/wn10bVj0uIKho3+RWTNrsTRlyalAsmnWhrvDe46W/nVGhMDTmLa/1j6htTMFWRbe2y63dfbDFX/ZUkJaikDLJzmCcnc9ymzY8YRpzJvLmt1kHhHS4Ay86k8eC+g46pHeMuSm1uasgbGhclQZjOcxOJHlxD2DxdRCZ0hVxedHev1jVL6r7wb060rqXyiqa5vkozYGSKQfXe1TyKgjBxG137vcKOmJyEXniDI/b1r+v8M5zaKeBRTJFVK06Azc+pMWpznpBRdJqCHUXFvkNHKhredsQXCSavhnnBBvwCH/Vpc9cgVkZVDdiDxRq3lczBhAvbs5/HNvRrYZ8ZgH14CJm1RPEQyFjP65q94P/gSWFXMomA8/TdEVQx6keZQcgcI7YWsNF18wvWhnbTHMwQ5pF4L3IM5Ohrdq2lDEJdKXpZKYMNr6zFLmX0aejDrBfH7d8aOp9Jp19R/rBWS8Igx4JNT8Baqc7aHeJjhfoDFrYXwFnBswrlE4sct2gSlUH5WKEmoj75WmsQYqtO/Yup7k3zdDzGM/KEjuMAzSd3DKUz4Tm2MonuvRoIYv8wT2OdAN08LOsY88lYzxyi+XY5+iEcuD9+DmgjE6l/tKeepLr/d4uSmGkzybt4O/4s9C5jyZEHKb4hlt4QvepYqswiZsMKi/g/AZbBBOf2o9w4TiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(66946007)(316002)(8936002)(6486002)(31686004)(41300700001)(110136005)(54906003)(6512007)(44832011)(6506007)(26005)(53546011)(5660300002)(2906002)(2616005)(82960400001)(36756003)(38100700002)(186003)(66556008)(4326008)(8676002)(31696002)(66476007)(86362001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFNJWGx6RlhUdm1xZGx6dTFzQmYzekVmQktLeit4SmJGMHpiaElxUUEraTd3?=
 =?utf-8?B?NEhHekF6U29VTXkxbmhCcmMwc2E0V3gra3hTc3REM2dBMURZV0lzaFFlSUsz?=
 =?utf-8?B?a3BUSE1Eam5YaE5OUHY0WGcrTEFnR3Q5bnVUeEJhZGNIM3JXVXB5RDB2MHhu?=
 =?utf-8?B?bDhFaXlZemYrNW1aYVo1S2FsQklQbHVXWmh0cmkwOVZ4OFFtV2E5bEErZG9M?=
 =?utf-8?B?SHorSlpQUitBRVFXMUM5ZmViamZrUTlEVzZzRnBDTXMxb1RTRkFPcmZDTVd4?=
 =?utf-8?B?aG82WFliS1NuSmtsMFgxYXZ2eDZPREZTNWpSOFp2VXVvMTIwdGRTRDNKUUc5?=
 =?utf-8?B?Q0NHYVUwamFKVUZqc3lXNHUwcXo4SVJZeW91a3NQTUduMkRzKzg5d2p5anJC?=
 =?utf-8?B?aXoxMGpJVzZhVTFmc0pIUUlZQm5zUnVzS0NRVnVBWXYreXNrQkszbWRjSWFS?=
 =?utf-8?B?eHo1Y3d6a0hhLzlIblVHOWR0S3JHclBTeWozMDBCU1JIdnk1eG5jYWlJazNh?=
 =?utf-8?B?RHBveUJra1J2UlVUV2cyRGFveXVsbnNJdlRFc0YrMUMzNlU3eWk1YVNGZzJQ?=
 =?utf-8?B?VXZNR0k4M0RSd3RmTUR4VUNPbjV2cXRKRHhIZ2dZOStPcHZMNVRoSkN1bEp4?=
 =?utf-8?B?SU80aHFlakJHdE9oejB0OFpJbk5mQ3RpTFo2dFNkRFlaMTlaeDNkM3pYSHEz?=
 =?utf-8?B?aUIwTXJub0htcFF5MUNROFNObHFkaFhMb0k1ejhMcVNxWDE4MjFVbmJSNmdQ?=
 =?utf-8?B?UjdNQlRuVGlMaGl5S0wzbE1naXpyaHF4azdIV0pmQkIybnlKMnlpd010VUZ0?=
 =?utf-8?B?WXdvTGRBamp0U0dkY3NtU1pJazZoei9OZDdpVEdGYzlqMEFma1JudmE3K1cr?=
 =?utf-8?B?MWk1SUsvSnJYYWtoUjlNaWtqYU9FVVdjbWtIYUU1ZDhaeUgySlVsaWxoMW9Y?=
 =?utf-8?B?L2hzYU9MVVlOZVNHbjJXVlY1M3orTVh0eFpLcmFYcnBDUXFDUWhoYmJzNGU5?=
 =?utf-8?B?U3NIT3UzYSs2R1FySXJjQmpGZkxOU2VJUDk2WFpFMkJ5K3JvZW5yUUllTkx0?=
 =?utf-8?B?NmowK3JubUwyWGRqbTBPRkFDL3FBKzlweFgrV0xySDRFMXBWekZLTENwUmJT?=
 =?utf-8?B?L29YNU5VdTd0b1NucDk0ajhwMmlUZDVCVDY2TTFuNmY4ODVXdVZYRHUzeVBx?=
 =?utf-8?B?WkovZENTbXg5R0NRdDQ4SU9pcUVQT1FnSW1qTWZiQWpsQjg1NHNOMHI3ZUgw?=
 =?utf-8?B?RHA3VlgwQlMxVElRVXVXTGUvVFQzLzl6TjROYm1odU9sQVZYQWNaR0ZZbmlC?=
 =?utf-8?B?ck9OcjBYTjhZbENVYWRZVlFNbnpzMnVTbzlvZVBWU0d3MVQ4bmJDU3g2dHlN?=
 =?utf-8?B?TG5UUEg4bUZyNzhWQitsc2lsTVpubVlYT0N0ck1XckgxOEd2OTdraUhiQ3Zp?=
 =?utf-8?B?TE5ndi95WjhWR0lOMkdlaUxxZnAybTljcGdRbld4Vk5LTTlxSkxJUWdUQk5H?=
 =?utf-8?B?Tk9wZ21LNGxOczBHRGltZFRKNkF4SFNDZXJPUDdOcUpqbjNZcHJaOXcvWUg2?=
 =?utf-8?B?Ym9KdklLOXFyQkFXK1d5V3JuVW53K1EvZ0xPZmFyMm02ckZFRUF2T2I1WUJK?=
 =?utf-8?B?UVl2V01HMmN1ODcyK1BOSUNsQ1R4Q2tucXQvWTN6ak5IWVRsa25PdE90Ullr?=
 =?utf-8?B?cnBtZFBlSDV6Nlg1ZVFvNHRYNVFVN2lyU3pDbjdwNEw2akNuVzFSemcvbmNY?=
 =?utf-8?B?ZW1BRkx5bFB2cXUvZ2t2a0FLNlJHd1RPY3grL3dtc2doNHdHbTh5cWV0RHBL?=
 =?utf-8?B?UmZjR2RTRFIwbld3VzhJRVFHNE5qY1pTVitzb0dqUXV5ZzRhYmJGT2dXVEdt?=
 =?utf-8?B?VnlUWjRyd1ZGek8zbE5XS1FPQnE0T25sTFZpQkVlV1ljOU85eHl0TmVKTFFG?=
 =?utf-8?B?Y0ZjNWtNOG56ZnAwZWNQT0JxL2tvUWE1WDhpWUN2ZTVmMWw1QWJFd1ZFOFFV?=
 =?utf-8?B?VlpNQ1lNbEZzTTNVbS9rdkFhZk5Vcnl3ejd3bW81NXpQR1BKaDlxZGRHTWhW?=
 =?utf-8?B?Y2hpdlNtZFhZVzA3M29NamJWU1YwYWV4b3VHM2w0THBMUkNmTG9ac2N6Z1ZC?=
 =?utf-8?B?cnlJT3JwVy9QVWNmWTdLSkJnb29ualJIaUtMTndqUVFmMml2cUtuN29ZT1Yv?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d883bacd-f9e0-42a5-57a5-08daa22f50b9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:28:52.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDQ3Zmb1OMH8Jlt9Yq/qdlHvYxKiyfZhrmVwACSC9JBZUUlQpE94ZWJiF5d6PZWu5xzstt0LmIQfGTwnfK1hXtHq+iMg4SBdKXSpjqYQYMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 9/28/2022 10:28 PM, tan.shaopeng@fujitsu.com wrote:
>> On 9/27/2022 2:01 AM, tan.shaopeng@fujitsu.com wrote:
>>>> On 9/13/2022 6:51 PM, Shaopeng Tan wrote:
>>>>> Before exiting each test function(run_cmt/cat/mbm/mba_test()),
>>>>> test results are printed by ksft_print_msg() and then temporary
>>>>> result files are cleaned by function cmt/cat/mbm/mba_test_cleanup().
>>>>> However, before running ksft_print_msg(), function
>>>>
>>>> before -> after?
>>>
>>> I think it is "before".
>>
>> hmmm ... if cmt/cat/mbm/mba_test_cleanup() was run before
>> ksft_print_msg() then there would be no test results to print, no?
>> The current implementation runs cmt/cat/mbm/mba_test_cleanup() after
>> ksft_print_msg() ... albeit twice.
> 
> 
> I am sorry I made a mistake in changelog.
> It should be ksft_test_result() instead of ksft_print_msg().
> 
> Changelog:
> Before exiting each test function(run_cmt/cat/mbm/mba_test()),
> test results (“ok”/”not ok”) are printed by ksft_test_result() and then temporary result
> files are cleaned by function cmt/cat/mbm/mba_test_cleanup().
> However, before running ksft_test_result(), function cmt/cat/mbm/mba_test_cleanup()
> has been run in each test function as follows:
>   cmt_resctrl_val()
>   cat_perf_miss_val()
>   mba_schemata_change()
>   mbm_bw_change()
> 
> Remove duplicate codes that clear each test result file.

This is clear, thank you very much.

Reinette
