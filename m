Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17DD5E69D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 19:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIVRoN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIVRoM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 13:44:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0DEF9603;
        Thu, 22 Sep 2022 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663868651; x=1695404651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2hTS9AYFrYZ4jQfcQkYNnrulUhQ7QNkWkFv8RY4I88c=;
  b=JhngZwImVqpt+Hg5qocqlTzSrp9C1JT/pTp+QbGUI2jfkhT6yXDPRsub
   cyBZ+RJ4HF5iiBflCguag70PEWZ7374/ybNRdlWlg2RIfqBozJpQ7oIKC
   QZtdalBkb3q/bqOr+Tpo3EgtTsnW6lqsaItB0qxxAcfy/fIzGvzmFFonC
   RJphihVXUz8jLaGADW5b0Ug+a5ULeB8Lf9ecQ0Fi6lGAG5LFeNvczG7Ga
   GzYlPXgQreJPNYEog+7RSgxy1INpOWdYU8X/nSR3tkYj1p8EnU7+/RLaJ
   lvqSz3yDDG56+oo63vTYqSFwI2uNDGUkmcSwN0oC2D54yRqu7dEabN5SC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301788057"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301788057"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="622192122"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2022 10:44:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:44:10 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:44:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 10:44:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 10:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHlU4v+c50FXJkHAhp14EB+sNPIjs9NexKaJnEnVRPijg9qDov9wLAX+jVbc0/2Gat/AY7Mn4o29faJXam9u153lRr2nYjyBWRwzoDJsLDAllYdLDNoIjdh5uEHny39FegL1clqXXgMiOu/uFNCE0IAIpEIiIVo3yvCGUge64s1/DuG5D45RWq5BlpNErAA6Jb+WhX2JOxdFgu0ZxtNHOyRZzgtmvCBqGROOOffS8LxvId808MW7PAAV3ifw9cvtJecRQS0dJaSF/ZP/370+XicX46ONkUcHPs4msP0JmwGccBN6ntlk/tdF66g8STii1fqBwXzS5cbp+yyGbRjZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lt4roIWf2zctnnvJWWlI1AVBbRLMM9s4QoFCDzylpq0=;
 b=l4mkGlKoY5mz5Gq6ujm6p8mCtWxWAyh6rAKePS7qRdv1Tee48q9I1TEZVNB6YP06Zml7TGPuLWSA9DLbergFMY281gl6L3ilG1t/YjnNOlVL0CR4ercfbBky0p462cjMcJ6samyjF9CTJjFGjuxpJ2DdKTj5BN3EO7X53XNqzbzR+subbunma48PwCoa4GkJBuMmKeYPbHHGa6ONdWBLQN2HkocdftDTktB4WgIttxB1OQtVO4/Vz7OydJHYcBtjOb94fKD7Ckiv8LuDzIOrHZ81explcsaI3IL7Wpf82hz1tlY8qGMVTrG8IPWd0Qux2Uc9H/bztBUaNpKXWqHRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Thu, 22 Sep
 2022 17:44:08 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%11]) with mapi id 15.20.5654.016; Thu, 22 Sep
 2022 17:44:08 +0000
Message-ID: <24cbb6e4-d853-6c7e-cffc-daa7412d1eab@intel.com>
Date:   Thu, 22 Sep 2022 10:44:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] selftests/resctrl: Clear unused initalization code in
 MBM tests
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-2-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220914015147.3071025-2-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:303:b9::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS7PR11MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a5fff0-d7d9-44d4-7530-08da9cc20cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrmZP4zHgRB0At5JvGh02yHBXI+gNV4uDpOcxurCw5b7LNSjsdhP72fU/ANjpyEjKq6LiBJ0VvEJIfxaSkMeNJ02n33jEAn5TmmXNTfLVcZNCXmddeMSLjE4XPfZkhRcWIic4jT8PFhZc/3nq6czm+HytnS6xw1z6WCnohjsNELLCkzh68lazgxbSCHdNvHxtGvYzADtIhMnrgQGFAei+QcRX+4wXa8rgWvQH0pe09N5UftUNzMbvBO37N7wBAwCQqSd69qGgG9ozos4hghRX00NDyTgehwfP7/wbMLBaZaPkFAZJRQ0mywlKtX5eiVeJL6lQhbLqHQKAqim9yBuEzhhB5K0O6du1igXSZP0kpKWeuF+Yy3+25EafTKiekn27hw4PMASK07R55/b3sdogQUtfARm/6IWd6bgUex4csNilOT5E/ghIibJs2cxwrBnnodwFb2QpOB5BJ1zujeFNxcwh1Y8LJQblyGIJtMtYgDXDR2grRuVg3yuabhrASdy0QODh8LtUWM6Xh5Mg5zk0ZMLIrfYh0oeCztRQb4FVNdC2SbaudpuzU3vXdtvcytDjBAZjiukNaP2xQ4ti6IANZdyfLbeSDlEJCRKucewWaDL+BuPyyQHqnSzUJKWPzpGnqOrgLQqRj4BpKyt+iu1Pc+nCvNkvWs/pS09sp5g/dX2l4iAkoaHsWMzgBTLKi9JBYJHSXYpHV8aMPujaHOuaTt7161wca6sg08Wa7nwwE797jYYtKJcfZ0KyVoELBL0BlJjYNiD/rElGSgRlpy3AzjvkNXir7v4FwE0cwRd6g0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(86362001)(8676002)(4326008)(110136005)(31696002)(36756003)(31686004)(316002)(38100700002)(6486002)(83380400001)(41300700001)(82960400001)(186003)(2616005)(2906002)(53546011)(478600001)(8936002)(66556008)(5660300002)(6512007)(6506007)(26005)(66476007)(6666004)(66946007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RQdWNTcDVXUGNjQUtGUTVHVFFJSEphRjE0d0tYUDhncVNsWmF6T0N5cUtI?=
 =?utf-8?B?d3RyTUFRbGJPU1RkUjd1MUplYXovLzNwQkkyY1BrelNvWDJmYUx1dVRIaVNT?=
 =?utf-8?B?SEJ3Rk5HNW9kN3Q4VDdZZ3Q1Zy83YmJzQ0ZKd0svK3ZNOEhmNFlGak1OVExn?=
 =?utf-8?B?aEo5M3hZR3ZxN0h3d1hqVDdNeFgzdDdvdXFLcHBuSi9LV20xREVJNE1yZ1JS?=
 =?utf-8?B?MFFLRk8weVZRZHNBMzljWkJBNlFKTHVTOGE5dTc1djhOUzZMRjVnd0hWL3g2?=
 =?utf-8?B?RlFHemE4SlgrZVpydGtITXZRVVpFUVN1OVN6TlNKdEFSc3lid2Nic0hDVk5y?=
 =?utf-8?B?NEZpK2U0L25QRnJQTWZVOHVwcDhCdmJzc2g2eWNDMzQ2WFBzTUdVYUNWTEUx?=
 =?utf-8?B?T3hMa09aZ0VZdElIaDMvVEVvd05RNEpEdXFEQno5bS84OEJFQjRtMlVRM1BS?=
 =?utf-8?B?QjVjUS8yY3dPSDNsRGp5dHhqU1Jyd1ZvZGVEa05oYkpNbDh6TTROaFFUakVB?=
 =?utf-8?B?RTFkamlXNEZsVkNyWHZicFVsK3JtcjZ2cWYwK3Z3VWxQS0FOMW5oY09PeGd1?=
 =?utf-8?B?dEZDS2Y5NEdXMFVEbTdlQW5vQzRjdlBKOWZWVXNqYWxtWGE0QTNhNXFWSlhY?=
 =?utf-8?B?NHhJc2JKQm1UWGVlVCtnWmZlK2duOEFQRVM2RVYvMHRYK0w5M3IvTjgrRndD?=
 =?utf-8?B?S2ZzMEliOFhtdkdFbStTdzlSTXJjZUVLUlhGV3dMRWtiUnNXN0RGMWlWZHBz?=
 =?utf-8?B?N2pOaEFFek51SSsvcnJvR085aUxrek1Uei9HcHRNUjQ5MUhNS2tCOGZnc3dl?=
 =?utf-8?B?Z3I1MStxOTdqOEU0K28zVmJCc0E4WDBKSGU1NU1MZUtCMEcwd296amFFMkNG?=
 =?utf-8?B?S0lrVWFrRnp0MlJJVy9xS1J5ak9EMTdGZGZpQVl5M0R0bTJ6Q2kvRmVGazZn?=
 =?utf-8?B?L1RSREFkOGVYQzlUTlRQazE1czIwNUxnOS91OHBVSFh1RGVWQXFnM0EyanQx?=
 =?utf-8?B?bEFSK0UwNU9vZndqTG55UW5oYlZIam8yZEFsTDJVWGFFdjc0LzlHY29HMVJV?=
 =?utf-8?B?SmtiTTRYZ3FwR0YvV2Vjbk9JZjhDYms0ejh2ZmNvRzBLa2NHMWlhbEovY0xu?=
 =?utf-8?B?ckRuVlRNWkJCcFVHeHVRYnZkOGRWdk0vR3JkUUlwZ2JBdEozSUtSRVFvZVBL?=
 =?utf-8?B?WlFxdm5raXU0b2pXNnFwbElrUUhxaHVZSFVEMkxUTjZMUEEzeFpINk1kTVM2?=
 =?utf-8?B?Rm1Pa1hIZlVETGQ2ZENqT0VhdDhFR3pPWlZNNFBGQlB2eG13SUlGNjFjMytX?=
 =?utf-8?B?NmJKS2VxeEgvYlN2U0k1ZlZRWGhpMWczY3ZUNVg5UU4wUEhCSkhzMzVwdEFR?=
 =?utf-8?B?TG9NRng5QmxKRCswc2JMNVp2UW1oc0NWYVZ2UDArUS9DcTJPL05MQUdTMFVq?=
 =?utf-8?B?K1lGTExFOWIvakNhS05NVVl4YXpjdkZ6cE5mOG1tdEVEUjZaZlYzRkwzSHJP?=
 =?utf-8?B?WUx3UjdlT1BrUEFLTjlvZndtOG5yWWJTZ05iTm51bFlCYVJBMnVyMTlYZFVy?=
 =?utf-8?B?ZDlJRFFXRVdkR2ZXRVcvcUFVcTI4Tkw5b3dBMDhBT1lOOXVZY3FYdjlYejBx?=
 =?utf-8?B?d21JTFVVVWdnRVIxWlR6STNaVHFtMTc2NnpZRkdvalpLOGlaTExKZHZDVExr?=
 =?utf-8?B?TUtMNUJNZFVKaHFaSG56djM2azZOZDdndmdMOXY2N2k2dklwUk9kTUhMK0NK?=
 =?utf-8?B?VGVGdjhEY3lsMDNMTkFab2lKdHdqV3J6ZjFrUEc4dWhVM0J1SGdnQkJ1bmlV?=
 =?utf-8?B?OEovZDI1aVBjTUhXeDVOeUJ2WWdCd01Pd1pJK0VNcmN4c0FLS3MrcklzWUFZ?=
 =?utf-8?B?NVQrY1M3aFNIU1BEbTdmVmV1L29uREI0UlhPM0FoSW1reGtHVldPWTBLM0o1?=
 =?utf-8?B?eTVIZndGNjVnRDRkT3JWYTJkeFYvSi84cHRSRU94MlpIam93U2IwcW9PUXAv?=
 =?utf-8?B?NXJjK1FtREVkUmFkNklWMDlNVVNHMERCSmxydkxqT1dyOWlxNlFYdGtCTnND?=
 =?utf-8?B?M29MY0IzKyttOFJZQWxGMFRqUXY0bmN0bEM2S2NiU2habmNDb2czUU1QcmRO?=
 =?utf-8?B?ZnNkVmd0NTVvMURMdVdTVmlNVXNSYUNQWmtvWEJHN2FFTFRoclJWZmNTc3Vx?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a5fff0-d7d9-44d4-7530-08da9cc20cb9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:44:07.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVULAEWgaTtp+uGsUYOiFRnzNtU412LDQ3OO0b9RTvYGs7gL5m1IwEAYPtk9XYw6ZkASsh7WSF92B9M1fpfBKdtloIlq6ms9mSckO6aRbAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6064
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

(typo in Subject: initalization -> initialization)

On 9/13/2022 6:51 PM, Shaopeng Tan wrote:
> There is a comment "Set up shemata with 100% allocation on the first run"
> in function mbm_setup(), but the condition "num_of_runs == 0" will
> never be met and write_schemata() will never be called to set schemata
> to 100%.

Thanks for catching this.

> 
> Since umount/mount resctrl file system is run on each resctrl test,
> at the same time the default schemata will also be set to 100%.

This is the case when a test is run with struct
resctrl_val_param->mum_resctrlfs == 1, but if the test is run with
struct
resctrl_val_param->mum_resctrlfs == 0 then resctrl filesystem will
not be remounted.

I do think that this setup function should support both cases.

> 
> Clear unused initialization code in MBM test, such as CMT test.

Could the initialization code be fixed instead to increment
the number of runs later, similar to cat_setup()?

> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/mbm_test.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 8392e5c55ed0..38a3b3ad1c76 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -89,24 +89,19 @@ static int check_results(int span)
>  static int mbm_setup(int num, ...)
>  {
>  	struct resctrl_val_param *p;
> -	static int num_of_runs;
>  	va_list param;
> -	int ret = 0;
> -
> -	/* Run NUM_OF_RUNS times */
> -	if (num_of_runs++ >= NUM_OF_RUNS)
> -		return -1;
>  
>  	va_start(param, num);
>  	p = va_arg(param, struct resctrl_val_param *);
>  	va_end(param);
>  
> -	/* Set up shemata with 100% allocation on the first run. */
> -	if (num_of_runs == 0)
> -		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
> -				     p->resctrl_val);
> +	/* Run NUM_OF_RUNS times */
> +	if (p->num_of_runs >= NUM_OF_RUNS)
> +		return -1;

You seem to be fixing two bugs in this patch, the first is described in the
commit message and the second is to use p->num_of_runs instead of the
local num_of_runs. Although, after a quick look I cannot see if 
struct resctrl_val_param->num_of_runs is used anywhere. Could you
please add description of these changes to the changelog?

> +
> +	p->num_of_runs++;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  void mbm_test_cleanup(void)

Thank you

Reinette
