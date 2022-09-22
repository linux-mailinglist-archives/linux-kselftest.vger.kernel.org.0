Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D105E69D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 19:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiIVRpI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIVRpG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 13:45:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1C4785AC;
        Thu, 22 Sep 2022 10:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663868704; x=1695404704;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jT7rjwcAvNIrK+41IODJutzUHZU4qsP4+/gOc+LXUzk=;
  b=c75+shqQIrkOCS/evXdDXoIsFmsJ4kq0XZq+S+wURUJOO8R4iyV1mo6x
   9zY0NoId7K0Ukzla5wE7NXMN2iQPsbpgHXq3TBPZO3HzfRm85G5XNJl5f
   PFtfSpcm7ZYmMg+whiDX40aUgP3WwyJ/1x45blKRcPeNYULxnyqGqtCWk
   p76dIYHL0evBB5qsJ2QpbSzyLTqpHgeoEJUxUjTuuwlD+sVrb4GAEzsLz
   ZAx7M6Zl1QGg8vQ/kYnJ4y9kZDiMXlke4BFn/xphsuRxGceiwGATvHvrL
   ySQ3Cy6zCxrm3QZnaPx7I7XThlwdHzfDRgRHtoEoSFQbW4VzHlk1RToge
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364362964"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364362964"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="708975650"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2022 10:44:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:44:54 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:44:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 10:44:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 10:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUdPFVPbDYqTzT2ny9ovQTW2DBbhFm7P/JhqRTMVJ4HlE9ZY+pExN4QxFRy+hetiDLJn8vVhI40E/a7ci9YIuJ4aF7tlufZub89Cv0gZbSGE/V4EvKkwEC2YwUdDjVQeCFv2OeUwIHDYeeysOIoEgsKUQq4l08iBHR4F+dHx9zuHDwur85h/ViLEJ72f3K8EisAGcy7Izi2NkNOjBUPgAf7dE3eM+9hF3mvHK4eiVlSWTIk5uTVEvS/Kasrcm3iUO2qztNDy4czbtoj1qcqHXWxypfpgrn6wJuY1I6eZ4bIoUARtTCn9srumi25v5fKmyqX5aXrm8RNHDO/VZCmQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srY2uzTZgC7BxpcDc/2LYpdkZF9dGGbwA8/UOpXH7X4=;
 b=Vod7EHNF7JIAIZXTS6Amzs/l37PdkoZuoIqzAmuURi6ZpDJsLQlyXHmH8hiE2Y2l3QMy6yWRJuT0fNvo5pE4SnMhAOGKZXARQP3WBdN+T9BBjS/MvZH1EY9pDxQkBjpUbrv8IHWEtflbPFD+FuYgmeFElcJOJC6wqwvs65U27DWmmtrDbmNuOH3VnlqIFq9WFWKTWGFnWFk9AZJKqDYJXQwR39lpEgzXBDSVisHMS4eMgKNTCQUQLSgGZJuH8xi1zKb4+OUgjDRoFxOcK/PX70/0okKuyOWpnkTHKgi+21Qu5RVTwuGXmE1RORcszhy+iaXgqDTiB41L2BcXA3SXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 17:44:52 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%11]) with mapi id 15.20.5654.016; Thu, 22 Sep
 2022 17:44:52 +0000
Message-ID: <56578d75-d5e9-a4e4-b1ee-a4dbecc167dc@intel.com>
Date:   Thu, 22 Sep 2022 10:44:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 2/5] selftests/resctrl: Clear unused common codes called
 by CAT/MBA tests
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-4-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220914015147.3071025-4-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:303:b9::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 158ad5c7-5bbc-48d9-21a5-08da9cc22714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzafvXVSDxzIzJCHIvFPnUqZx5AIt30foh6SKQSKr1ZjoB8CMBx2srj3lVZ3nyUztplbHK2O3P798KQpxD/U5JRBeV3L+MEr4hfKOChXM0nReZETT9c1hwnom82VFtjq2iX1NRftAJFGfQUmZfoMtgne8G3zOMTrBSwiEexlHx3Fk2bNEdgDZ1z6FpnXpSP0YDQuBIbV2RTDNVs7bmjGsAjiI1/PtDCJupwubY0O36JoZO/AzP0qx9ubD6I3+vwsuI1RT1Osdbo9IuYprbVHUYcwtNx9IMvQ3dm7dpnzPbmybg4TU9JKM7Oxsp7/JZg47cmZH9zjxvWUlOMcV9FuiOffeHMKrg5zMaHBXT58G1rKAb63ke8y+mk0oieNiEQfzAMf47HU6oF3psWHfz53upE+RCuN49XULmftksm905Eq1B5SROE4q0VNXJf2zqcet2Q0jsPBS6QpmUj304IsUbVVXM4brOik7+VUdFPzF2zg69qVZemnXV2/5I0IXHlZJ/MvCZAIPCxfPksmuX0QPyrVyphu4zo3HLlRijq3lVJTvuXQ6n41xwqF1gLG0qkUfHbalKxogCdOtjMeYysXKGNMgAHKzjUfu3bz9DfL2W1Ze07zLPqHK+Z24ltP4wAdsosCjLxuyzFDyVxbGzHJxJkl1Tq9bTh0CjWRBQgjtwt/IjBkxmhrkHx4jgPrKm2ev61SV+xMlGVWYgfbkAyyzrUw3LIVKznPrsDwJZEIxBkq2LFl3NdBpVOgt6NzAiLs2EYVmEOZgEJJaXHB+M8JMeDFV0u8f/06RK04NaKvJHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(6506007)(6666004)(36756003)(53546011)(26005)(31686004)(6512007)(66476007)(66556008)(86362001)(110136005)(66946007)(4326008)(8676002)(41300700001)(82960400001)(83380400001)(6486002)(186003)(478600001)(5660300002)(8936002)(31696002)(2616005)(38100700002)(316002)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEN0Y21CZDltbTM5UGNhSmxxUmpmdythTytDZDMvdHJxVUhaVW1pOHZwV0xl?=
 =?utf-8?B?eFh3ZHVzZ29RTmxXbzdwa01mZ2REOHRZRVU4RjhybUo1ak0yZm4zL3R0ZElN?=
 =?utf-8?B?YithMDB5VEV0Z1FzT01qUFg0Q1Q1KzRSVXJWTkRPbVhSODBmd1Y4bzVKWExv?=
 =?utf-8?B?YkVyYXBGTDBUWFdjSVYydkhxQ0xnZktzTkhiNHJhRlgvakRXUXI1TVRGNGtU?=
 =?utf-8?B?SXo4UDBUdnJvQU9SUUdBU1l5RnU2SnNuUWRDczVXK08rNzB5MDdMS1M1SmtE?=
 =?utf-8?B?MXJJUktFWnhZZG4vQ0s2QVNMOTdXaHBlVHh3cXdmVEg1Ynpsb0dMaDJmRFcw?=
 =?utf-8?B?WWNjdWFsM3RtTDVuY09mb3pzMHZMR0R5ZDEwZ29ZcWhpZTJOeGxFSXdHV05M?=
 =?utf-8?B?dEtzVWpFTzcrZ1FIRlRSaXRUUXZSWkNNcm9WTFVPTXFEUGswbmhzNFhXNEdy?=
 =?utf-8?B?ck81UmN2T1ZyZmxKdCtqb1kvbW02N3JHVC9uTlNDUVVOa1JhOTJ5Vm1RbzJx?=
 =?utf-8?B?QXh6ZGdTaHBSTldMN2laR2k2ZGtzQkw2YkhZVnJTSzVVT0ZQb00zVGZvckYr?=
 =?utf-8?B?VXNRSkdpNWRPdUxYakdsZkNJUVBIZGwxMURJaTZ5TFdZMkd5UEsrUFg0TTlE?=
 =?utf-8?B?aTZwTktNWjY3MWU2bVZqcno2elVQeUpMRkJrMzdQQ2VVQ1JOZWFCaTF0cVZx?=
 =?utf-8?B?MjBRaEYycWJwakVYREFmUmdwQXlrZ1hSK09FQXY0ZGtpWWtZN2tMN2xRelNB?=
 =?utf-8?B?NFVuSDN4MHcxYnFSQ2M2V3JERnlRRi9tWm1Kb2ljS21odFVOWEJLLzcvN1NJ?=
 =?utf-8?B?QXB0MjNhaGgxKzl2QzhkSG8vUEJKVnk4WlcyS1hEbzhRWmg2SHRWNGJxbjF4?=
 =?utf-8?B?cmVEenVmWklCc1NGOWRBVkZ0LzY1STh5MHdFM0hOc3o0dGlXNGFMRVNKQ0pX?=
 =?utf-8?B?UkFtWDk1RFVUeW5LaFAwbHdrZXBvVFFJZjlvYVBEaHFXRmxTU0tEUG15Sm1F?=
 =?utf-8?B?SkZJaGw4bWRwc1hLa3pPckh6cHIvWE5oYzdERWM0LzJCMVhYSjBzN29WYW5N?=
 =?utf-8?B?eGpSNWJCc0Q0eURkd1QwSVgvQjlsMk9pRzZHc09xc3hJQ1U2VGZ5MlJ6NzY0?=
 =?utf-8?B?Q05QTWZQTVczSkQzRUQxc0VDblJmWHJDb3Q2RDA0UjlWdGtjUG1DTmphRW1V?=
 =?utf-8?B?SnNSSGxua0pORElud1BjSjcvMVY4d2IwTGg3ckdGMTNWQVlaNys3TkxqaEFM?=
 =?utf-8?B?VHV0dENGNnlJL2V0ZC9jOUgySE9NVG1JcTYwQTdSZ0JCRmN1b0xoeHo4bEtn?=
 =?utf-8?B?SkkvK0x2UUpsbFVvUWIrZmFidEpMUnVTL1QyQ3lveXZOWm1neUZ1R3J1bFNM?=
 =?utf-8?B?Vi9RakxZRmRDTnFPbjRSQXpVR28vN3BzZkJuRC83SFBQK1ZKTkRqMTZ3YUo3?=
 =?utf-8?B?eGxTNUJRc0QzUWV5VW1JZmRxVmpFMUxyMThmUzJpMEFGWVFMbGh1eFg2Q2V1?=
 =?utf-8?B?eVFhdXQ0Rmc5S3A2TEU0WDdEUysxKzhKR1NlWnJJK2YwL2V0dERDaHFUcWlt?=
 =?utf-8?B?Z1NJaTVmd05odHBUTytYMjdMWEhTeTNlRlN1M1ljeTcvajcvZUc4ZmVsWE13?=
 =?utf-8?B?Njlmd2RFenVzanMwRG1iT0NONUVoMlBpQXB6RnlBK3plL3UybzRoQ3pYdEpL?=
 =?utf-8?B?bUl0N1ZOSk9zR2FhdVNtVzBPWUFKYmNDR1RmUVBrTXFqNTJYU2s4aUQ5azJ6?=
 =?utf-8?B?M2VzbEJoU1BqQUpQVmVsaHVKOXkzSVlmdExNNlFSK2I1a3dBNGlVM2ZxTVpz?=
 =?utf-8?B?SksvUjFZNnBvNEdDOW9VM0kwRVFTbTJCT3lZdGdFK09MWmlxekpMSEFNb1gr?=
 =?utf-8?B?QmtaY1Zpc3JET3dHQzFDbWZMQW9ScE9yLzNsTThsUmJMUVZ2UUtqQks4TTc3?=
 =?utf-8?B?MXZFbU9FS3VhNXJZcTVKQ3lUYU4vSXNOU0x1SmZrZmQydnQrMUo3WVI5K1lm?=
 =?utf-8?B?TGFtcXNXU2d2c2JVZ05pMTFaM3NkMmlXZHpBV3dCckhIdG1kZ1oyVWJrWUxF?=
 =?utf-8?B?eFBCL0VWT0xmTENvZi9LZDFQdW4wQzFuUFBUYTRLdklGT0dxSTliaHpOclRo?=
 =?utf-8?B?OTBOa3MzM1dmbVgvY2VOSGI1c21RWFBqQnIxLzFNYURjemFTU0s1SUsxTlhP?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 158ad5c7-5bbc-48d9-21a5-08da9cc22714
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:44:52.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xtt3nKw37C5CvS/IQSdn1MujBaZTuxsMgh1YgQEAN+rzsoXujgPbBxS/dwKqp5dCT9uP+0S1dUiZfcATKdOh/841JcMhqghbPfYMPqZmp/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
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

On 9/13/2022 6:51 PM, Shaopeng Tan wrote:
> In CAT/MBA(allocation) tests, function write_schemata() is used to
> change the percentage of schemata.
> In CMT/MBM(monitoring) tests schemata only need to be set 100% once,
> and the default value of schemata is 100% which is set by executing
> mount/umout resctrl filesystem.
> In addition, write_schemata() was not currently called from CMT.

While this is all accurate it is not clear to me that this
justifies the removal of the support for changing the
schemata as part of a CMT test. 

From what I can tell write_schemata() is a a generic function that
currently supports all possible tests. If a later update needs to use
this for a CMT test then it should work.

I do not see any harm in leaving these checks.

> 
> Clean up unused CMT-related processing in function write_schemata().
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/resctrlfs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 6f543e470ad4..349dce00472f 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -498,8 +498,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  	FILE *fp;
>  
>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
> -	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) &&
> -	    strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> +	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
>  		return -ENOENT;
>  
>  	if (!schemata) {
> @@ -520,8 +519,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  	else
>  		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
>  
> -	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
> -	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> +	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
>  		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)))
>  		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);

Reinette
