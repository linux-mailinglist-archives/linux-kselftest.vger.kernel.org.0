Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06347B57A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjJBPkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 11:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbjJBPkM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 11:40:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223CBB3;
        Mon,  2 Oct 2023 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696261209; x=1727797209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6lnVo055axIJDu67KEJHxbZubNA2n9ehEqp8StK68qQ=;
  b=KR79RYY31q8QapsViKjOyIAeKnt/gvp+FFiRvHb3260++l6AP6jDGhcx
   r+2KsIF82BM4Fb0QxQTdDBMf82gegyPvPGWFc+4fZn7uo6NDlQgQ3sRtA
   oXy//XFlhxuSWu/mQvC1BcFhvrPvHlgUU/pDrS1jEhIZvxk6AmWRdS7Qm
   kMvEPlIMm4g38x5MoCihlE/j+yHjMoRCHoWF7LB6yammT94W7AMLHlSsR
   lZMNiPtDRQpHDoA/gJDgShr1+95Y/TJ2R5LNASxToqHY58lu5D/q2TG8Y
   H3USQhrbZtUlvBCw1AamgkQLp7tWJ/mOPUiSl7WMqM70ZTMl5BVirC/wZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382575944"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382575944"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 08:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="997653162"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997653162"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 08:40:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 08:40:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 08:40:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 08:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfFeSSNUMxpQ8CTzsHX3yqF0IuYAsSTgQWklGjzNqgpmPsvbdrscB5Gyi4ON8FUeyN5PQO3KoiMyy4+rAKWarFQCzhPJvWw+LFbnsxD9daNrrVcnCwCcFgwfO5hjgmzAMPvFK/V6aKu4xzuvuvDNPzuIOd6fYuNc/6m6yJN+VYfAsvCaivNAcx+6tVpoc6gUU0QRriN09DDbk1n3ofEJDjt6SN92IhDlaPOMjca5MwzqH40Pg9YzaTBuRoo/OVcs3gbZdtZYH6RwISAeLYG6n5yjRIRne8a2/VFd6/eWB+tgkv3u1+0aNNk0d6goz86uaMT+qwUYnwuHjuTfgGX4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nS5oRiX6gph9+6xXjb8W23/V1LOC2TWE5OYJLPB5xjo=;
 b=T6kGAudOAFd5HvsAodS7EGM7DLB1YmkweptKk4gHUy2sbwyaF2wNAhecMX3EH6vvKP0lQs87lRS+sppfCGiCAuuhCTpakcPflMRACcBcWGWD6SKdQ/UOgKUY1SQu9M2Y94Xaauf/D7wluVx+x+Lmqf2wvlbI2M5BhyOVVsW/Bnr01SI395J1xBxEwIO7uND3f8S0ZhK89hqK3zm5fLyizZb+im7ve/w3rKBFk6oAMetHZtl1PKb3+OKXELnmJJVKKA69wkSgfWXM+zRJougmsmSgwIvG88pFxX8GtL3Ua+tNO5bwN3Quz5rXtvRlnGK+6oHKEezltAYyvvA93V31iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 15:40:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Mon, 2 Oct 2023
 15:40:05 +0000
Message-ID: <402ba5fd-c773-f352-5f57-2dc8703a7b72@intel.com>
Date:   Mon, 2 Oct 2023 08:40:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/7] selftests/resctrl: Fix uninitialized .sa_flags
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
 <20231002094813.6633-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231002094813.6633-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:303:85::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd01501-dad5-4aea-8e7a-08dbc35dd98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ibfce/XlIlpL9W0UDlvo5IJsF+AvtoVJc7iJjkYGdO0+7z/50++oHInKuOeq2TETEZHcGnRxa+lElZHMb+pWR+7Jj92XUJ24Frezb6RXEt0zBvEYhhHSFL1yE9696MNtmhyfSIWGwfDz2rku8sI6Y/Fsc73RVC2M+i07aWQsD9GcRi5Q49SCsfEHt6HBNHB0y4k5s8/4zhAS+XiZAvXuKcx/gMiFOSlMBSnjw+FsrWq4AOJwVozMZwKNrdTydthzJ8L3mxS2GIDVSq7fMlb6wPoKAg5+xC02pAS3HSmYCT18+hS3ZOpGb3bUFzp1qIgp7UmHXwHOxKao61sGLL+XZPv6Ow+P+mtVZoYsPh5P1KuDaxyoMEzUWwKtqQ6HWvrg7CFRYnLcsG8Xo/R/mLj8ZWodSVclui8VOoNRWkSfq/OeGnNOr88z4fXXUJtLCkdv/4sA5J9uJTMrrz6A5+ngucS3UkW/C4Ek75dovxuY/PFwwPhnv7D7vx2Kd3kE8Ggj3RFdDziLbm1+3+4EkbELnoxrwpMSScOP8SJ/xmRHIcIPQIeI/HQ/xOG4EYPekNVLMVCEkyJf4/8sRBNhegIUK5S0lJWCVDw9Iq8nRXm90wjo3RSHZcJnSVlDpI+TgCFLPWYwew+ttlXLPaUzlKStyGTJ5+0VLuhfpysNlOkkzS+hfWtcwQvRMOqU1dBVMz7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8936002)(2616005)(26005)(53546011)(6512007)(6506007)(82960400001)(38100700002)(86362001)(31696002)(36756003)(66476007)(316002)(8676002)(66946007)(66556008)(4326008)(5660300002)(41300700001)(110136005)(31686004)(2906002)(4744005)(478600001)(44832011)(6666004)(6486002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEVsYk5QT0NqQlJEWXFRcEJzc1ZkWTlGVmdoS0phcm5tYWVpbTBUOUtDRys1?=
 =?utf-8?B?bEJLV0oveTUraXJuUHQrMlZ0Sk5CeEEwa2o1KzRrbUtjUm5NaXNWaVNXb0lN?=
 =?utf-8?B?MmNyV2paWjM0QWl2aXhpSUxCaWUxcGFlaTJWRUo3WkxaTlQ2dkQ1ZWJEMTRw?=
 =?utf-8?B?LzVwNlErNWhDZFFkNlZmbkRZTDNkNW9ZeGxxWTJNaVN6QkFmSnZ3OXFwMEpz?=
 =?utf-8?B?VWljUG1wWjNwRzNybU0wQXRybDkyUXhqNWNiUzM4azNLcGJXaGZjd1c1TFRE?=
 =?utf-8?B?akJKTlNWa0c4OFRYYnBDVUNBZHlYTndDMUtCQVVNV1dmYy9OUnR6ZmdNNmpm?=
 =?utf-8?B?RU84elBycGE5ZGN4SGt5aEowTHNaQjg0b2FZMXNITDc0Q2hQYndFbzY2N0pr?=
 =?utf-8?B?YU9mWG02aWZYT2dYMXhXWnJvczg3VXVnRUNMRGx3UldFRjM3akhXWGhYOUdz?=
 =?utf-8?B?MkN2dVFHOUhiWE9jaG5aZEI2bDdVcTF0UFBIWHFFMjlFQ2FPUDFIUlNwMzhh?=
 =?utf-8?B?Z3JBeldFQVMxUnZXSlBIWTcvL0xXd09zOUZVM3BoZkkrUndLTTBNWVNMTjB0?=
 =?utf-8?B?emdtbTkxdUY3NEtMS3hrQnlTUXkzQ0xZbis5WVI4VUc3SDEyTkFWTVc2UTVS?=
 =?utf-8?B?S1V2YkRFdjVPR25UK2x1eWxic0ttR1JGbEFreVhpc2t4N1A2U0tiZXhOTHZZ?=
 =?utf-8?B?cTNHS2hlMGZpN29MUTcyWis4OVVua1dzL0FTOXVEVXhCNlJDcnJqZnlqMnlv?=
 =?utf-8?B?NHdpVmptOTl2TTNXYlhmZ0ZZSjBVVFQ4ZkV4NDZycEY3VFAwWDhkbFZDSUxV?=
 =?utf-8?B?dlNhUE5UVnVza0l5UFlTSTBBZ0VtYzdFYUM0c3M3MkJhN0poa2craGQ5elhM?=
 =?utf-8?B?ZldQcm5CeGN5N29QTERuQTdYc1J1cVJ6d05NTnZ4bmpSbXdiZ0VBOFBFcEpO?=
 =?utf-8?B?NEJQbE5MNlpWbFhqdWp5OFZiV2U5ZGovN2Mrd3lGQ21IVWxMZlRlTVZNRnVq?=
 =?utf-8?B?YUovLzJ6M1VmWlNwcUFzNU1Mb1Y2ZHNlTTROY0lkREJTR2RxWXFBcklweTJU?=
 =?utf-8?B?b1FPUHVwcUo0MEppWDk0M1Z4UDYxTWh2azJPRkRyQlZkYkEyelFZOGdiZVAr?=
 =?utf-8?B?N0R0VHljbnBadWlWbjRIZHJrdldGM1RydmFqNFFFR3VqR3lORHRNanBlQW9L?=
 =?utf-8?B?aDQxL2xlY2s4T1RLc1B0NjN0Wk9EZVRXZy9RM01pTnNySWJVbzdMcUxVOCtC?=
 =?utf-8?B?SXE4VEtBNFU5Mzc1N1FyWmZRb1ZYNndpZVR4NzhDYkdrajFBNDd5MzJOSEd5?=
 =?utf-8?B?YUdVRWRGbmdtaU93bFhVcWJWcHVwNUc3bytqVWl2ZE95ZnRQQllXT21sSnU2?=
 =?utf-8?B?aXBmV0xoZDA0aEtrS1dDL0p5eVpxY21hSWZmYjFwZVdsc09zQzJWaWVxeFlY?=
 =?utf-8?B?MFQ0VG1kZkZ0dmc4K0NXakQ1STRobWM1cXBLV2RPRW0yQXdrZzZPOGhKR0FB?=
 =?utf-8?B?ZlY5VlRuY3k1UUtIbmIwRzRsNkZYSXFRNFZkV3A0d2JvQTFnUVp4YXpXcnZI?=
 =?utf-8?B?dE1Wb0dpcmxZSERoeW5vdktJQkFpR2xvREVrUjhIY3RFc2dkUWU3TlNFNDY4?=
 =?utf-8?B?TlJZK2FzZkZTN1ZETDFvaXN1QXphbU9YaTB3VGVObTB4OWJOdzlYNWpRSDVk?=
 =?utf-8?B?ai9lN1o0dzRJMWtic3JMZWZFS2NwRlRha1k2VmhvZG40bUdhUlF5VERXR00v?=
 =?utf-8?B?cngzOURkamRBYktZK0Q5OWExdXpNc3EwL0hpRnU2MGFCeExuU1ltb1F5cUtu?=
 =?utf-8?B?WGZmdkhoeFUrQ1RrQlhkcU0rQ3hURGlCSzlGQlRXdnBaU0pWRjJFMUhFeENa?=
 =?utf-8?B?Kzh3TE5oVUE3eXUrc0d0LzRtb1IwVWRKT0taWUFFQmVVT3lSQWdQejJNekln?=
 =?utf-8?B?MCtWb0V2cXNLR05KMEJkT3IrWmdseStxdERlN1ZROS93RlVOZkJlU2tpN25W?=
 =?utf-8?B?YUI5eGx4eG4rUUV5NUV3K0FuQkVZdWt4ZW5XZjliKzFDdWxxOGZsYjNjSFl2?=
 =?utf-8?B?cXZnU1NVdGM2ZHJPb0w2ckFZZUt5MWh0a1M3WDIxQ0IxNE9LMkVIaTlrL2pj?=
 =?utf-8?B?WWppa3BPQ1Y4U1JMNEI2RGh3ZWozckhUWmxLNXl4anFCak0rcGIwSitUYkJH?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd01501-dad5-4aea-8e7a-08dbc35dd98e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:40:05.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucVlTSJEk63Ebmn5r1y565gkATd5KqVJjM9Lee1CrRZgB6MGDFGowDXYXsEXPudYjUiI6BBskRPKT/0JSXlJRKJxv/cshO6QmlYoE7pNGEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 10/2/2023 2:48 AM, Ilpo Järvinen wrote:
> signal_handler_unregister() calls sigaction() with uninitializing
> sa_flags in the struct sigaction.
> 
> Make sure sa_flags is always initialized in signal_handler_unregister()
> by initializing the struct sigaction when declaring it. Also add the
> initialization to signal_handler_register() even if there are no know
> bugs in there because correctness is then obvious from the code itself.
> 
> Fixes: 73c55fa5ab55 ("selftests/resctrl: Commonize the signal handler register/unregister for all tests")
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
