Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5F792CCB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 19:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjIERzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 13:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbjIERyl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 13:54:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666891AF07;
        Tue,  5 Sep 2023 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693932161; x=1725468161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uCq/9VnZrTTsdT9iapatpAKf5TtOehTLv2Y+xaBPZmo=;
  b=Kg1BubajZGVXZ9ol/cSCH+et8T90jNbLXS9mBouCGO7ixJMDSue7We0v
   Sb7+tdVJwJqymk3iqxEyWC72EbTMslQ8rxUWjrDQ0vZuXsXaOst2tgac3
   bugJ6M8owXTS7LnJK8tnqh+0Iqbd2BIOQRG3OOIQSEVTr2NnA7f+okTHU
   ocx+y6ILoBpkHRI5umLNHcvS01pedFccog2b98xls+AzTxh53TqWqnrD/
   BvITfkTlT2ur3nmJbDigYyahQlXQrjmwSpVD1oTI/3jvB+JyNB6je+GW5
   55J2Px1mhKaYqD8NcSB95uX2s1S1UV4kocDcqG/nFX7l4o6js758KYfMd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443232580"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="443232580"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 09:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="690979073"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="690979073"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 09:41:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 09:41:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 09:41:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 09:41:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 09:41:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW2Dak+nFDUZQfTt01FMd05r5VNVuLzc2K+gaiwF8Ff8y3pO0k5bkjoqWdQKMXXk+lCA118rj5lZ8EftNsm8OGClmDKg5UP2nYs8/ByhCaOFcsvVBtaFnDR0c8PmakDYGsj/qIOljbvrvzubaB31I+rFjOVp3qn/X97cPDAZALvj0rIZx+DY1F0Fq1EQesjaI5EWBALMLhEW6TyC+cBL8GG6ZUL8+mMJqghTdBMTn1wrLh08GCkRfVZBZmLhRwPxskbnMW1qInrG6h/J1pEenOzvJQUtlJaD9oLtm02gMAy7Wv8yC8QnWcNKhWsvEtvDBOeMWd0wrB7eEcyx7DoAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjwRvIU9y3Zoa0IDkSVyRQChL7fS4UjlukosWspnVKI=;
 b=bGRSXgqI245fFXlqIClVhjrl2OdEBIZswKVNJgol1yWnxxuyySqgY75hPIz3K9OPMy+rOGg+x1vKTZjPiIpx77/kQcnR/FGX/f/OHawE7lDWuFC9qBVmvbdX1w4X08dk0p6YspDC9XMwNuLfKV+Gz+NHcvZPTZNp5AE6JVDIh92qO39UOwZtnor6oIRltPxIuRvnwLBVRULu7cA3yi5aY+xNr3JrL3SXNYRXn6fdU58CLxdpPFnbbFXF0yDpW53ZVGvCpplIJPCrs9VQUQiyllLux4NsjCvOcAYy+c12bIuGgFPMT73pGo6+HRH4sXA0Erf2hGdv/cO+ssVSr/HlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:41:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 16:41:26 +0000
Message-ID: <359da41a-813a-1fac-bfa2-8c0044c042cf@intel.com>
Date:   Tue, 5 Sep 2023 09:41:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v5 1/8] selftests/resctrl: Ensure the benchmark commands
 fits to its array
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
 <20230904095339.11321-2-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230904095339.11321-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d988b9-f0c8-46a7-bd30-08dbae2ef235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wH7dEeXm/fjS5g+GFbRs0U3FVvyjZr8QLZnp8aCFn3ixx7CDkw6est/hsDA02qHaUnzC4qwaj84ozzo1JMNhMl3fwc2stsSP86vY/Lyb6Fj0nV1/ekXFfnkl4Jh1i9nj22EpH4pTm0vZcqC5Hb8teunNQXs7hnxOqr0KxWblzk3q1kFxCkqWWMPR4NDZGZtEtSMDhYFNnPxRRDQ/SksvRcE7tUQKyPYGu3ynUtYKUxgl8CbcG1Zo5wdLLKGght3eN/JUUiOJXG2CsgvHLdysU9RVoifO+rFfHe/c5+dlIkQB4CrtcifaArtXokHOMv3y1L7nunjG3nVS5yNuVUqnfY+NOJaqdvEcvCmVdhIUGTWPg0vEMmaC4lIkKqUEi+GPtDTM41pplgeZXAUe6i28gjo/BmcSxJx2f6u/C/tdDvX82pIRIIjAKKyhU/wl7lwqCizYJVFL+tsp2sEgG7Zf3AyrfDwYRFfBMu8SYz/TX0LIzAYM8lrUDUqQHFtN6/tr45MnOKeDjesGsBCR+wR3EMxhaILc48lGj8GTZy2fFFGPXi1jWxfIDJ5eZJDvFdj4ZsGxOIDk6BUlBLfl+fQxzJD/3PfhSEnrDpgsLEA3/fYeAdEanf/ZkrWGtUhW2Hfs4/WMHbkEuWw2l8VJfgzOpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(186009)(1800799009)(451199024)(41300700001)(82960400001)(38100700002)(6666004)(31696002)(86362001)(478600001)(2616005)(26005)(6512007)(53546011)(6506007)(6486002)(66476007)(54906003)(2906002)(110136005)(36756003)(6636002)(316002)(66946007)(66556008)(4744005)(8676002)(5660300002)(31686004)(44832011)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1VmVHZ1bHRURTBKaURYM2dROExvY2MyRnNrOTRyb0lLVDFBSThCaVJJV0Y4?=
 =?utf-8?B?Y0NJbzdQMGdROWJHa2tXRlBuV3BGbmdLaTRtY045czVQUkorbUg2WjlKTEtU?=
 =?utf-8?B?bS9UMExKMUJtd1pRZTZEcGtWVjJDZ2JFUnZ1N0dsdlVVMENjcytIMGtOcXBZ?=
 =?utf-8?B?cWM1UDZ6KzRlcVQzRUpzT1lOZElxZFNIdFFaVmo2bUkxU0dTTSt2RXU2UklK?=
 =?utf-8?B?K1VQaGtPeTJqb0RsNjNIbURkY3JXWStOWGxUbmdKL0tXcEZnaWRETlc3eVYx?=
 =?utf-8?B?TzBZSU9XUWc2c1Z0TEVxOFVKU0Y4Y3lKcW1MOG1ndU9LWmNNT1JzK0RZMG9q?=
 =?utf-8?B?Y3plVzIrQkp3RG1pa29LT0ZMQTZUcUw1UFFmenVLMG5kQ3dVdW9YU1p6M0o1?=
 =?utf-8?B?Mi8wSjJrMVJaeENudTlkZm9TNExMREw5Z0ovbzhLeDhuQjhOZHQ1bXBKK0pY?=
 =?utf-8?B?UnZ4LytjZVU0b2t5aW5BeXZidWlhRXZNM2x4RG5UL3RiQnM0R3hjRVZ6VkpT?=
 =?utf-8?B?ZjUwMVFrZUtTOTRiSVo3SnZZZXRIU2l5ZXNXRTRHNUs4T0lyOURKeXNyQnhR?=
 =?utf-8?B?RXJaMXZ3VkJ2aFY0T0JBT2JaOHJWL0R0QVlMeWh0Q1Vhbzk3cmJCalJncmgy?=
 =?utf-8?B?b0xJWk50NlU2eEZyU05JUTNyZ0NQcGdWdTh2YkhPQWtRTGNqeGJxMW1ESGRE?=
 =?utf-8?B?U1pnV1hOdGFiMEdJYlJhUSthYndVTXVpNmlRVW5qbVo3K3Z2dVE5YS9XWHMw?=
 =?utf-8?B?UHYwdFZ1MVFvSFZteG1taXNGR2V3aG9kWHZ6Z3Y2a3Vtc29YK0RIK2huQUdy?=
 =?utf-8?B?cjFxRjQxRWxEWHVKc3hNUW5LYlIrUHBUT2V5VkZveWVNeUcxYXB2OXMrM3R3?=
 =?utf-8?B?MEFmK0tpWlVwK1lhdWFYaE5Ya0hOdTZmSVNsV3U2NFpQeXJDa3JUdWpyM3hJ?=
 =?utf-8?B?N0J0Z2grbVRScTVtczNocFRUVDg1SUNsbUxJczY4TUJGYUlZbDhobFVITzRU?=
 =?utf-8?B?QzhMUFZMTFNhRmNRMFpJUzYzK1E4a1JYK0FxdExIMUl4TE9MR1o1ZGMwellT?=
 =?utf-8?B?QkdGVmRPQ0dQcDlWblR0RmZKT0pWQUVnVVAzZjZPZHZUTGFaN1FrUldPeEtK?=
 =?utf-8?B?b3llUnlZcEdmVGlSR1RjaEMwNnN0R20ybmFBaHFRVFNMbStpYngxWjdJcnhv?=
 =?utf-8?B?a1l3enA1Q1NyTWpQRHpQOVBmMmV3L29OZzRFQWVJTzRPN29aczBPWU1uR3lO?=
 =?utf-8?B?QlIxRlJBQzBDOXhTY0FZcE5LMWdQQU5lMGJoN2s2dmE5UXdPYlIxaE9UR0h2?=
 =?utf-8?B?ME1MbFdQYTZTaE95SWFsQkszVjBzbDdBc0tiTGU4M0tyOHVKWm1GY2VHNU9Z?=
 =?utf-8?B?WHVRWXJSVGoycUU3VW13UDZNSGZRbFNUcy9ZMkZvazJLZVhWWDR2NEhjOUhh?=
 =?utf-8?B?Zno2bFljZnd6TElsNGF1M2Y4TTluT3ltMjExMTFiZ1dwUTN0cE81SCs2WUpJ?=
 =?utf-8?B?ZHBKVHliL01zbjFNQ3YwODRzQ09vd0R1QVJveXphaU9XMkF6QlljazlGQ1BV?=
 =?utf-8?B?VVFhYktKSFpWc1FsS3RGRmxKR3FCNTlwRS9XbGNuZldiQTQ3b3JIblNBWjdr?=
 =?utf-8?B?eDdwYmtMYVJmaXBhWVJhQ2t6WExVMnpYdXl3SW9pOUExYU40Tzh3ZDB3NjJa?=
 =?utf-8?B?MG0za1grRzdwVFZmR0sySTFicjlrY1dQeWhMWUtqL1JXdHkxckRqRUxaOSsy?=
 =?utf-8?B?cXZvWi9JbldnWXVJckwvTEpCWk80bTBlak5LcGlsdUI4K0JHalZLU0l4Tis3?=
 =?utf-8?B?L0hxdmlPUGxmL1Rxb3pERDZYNVpteWxkRFZXdzlZeWJaR2MvOTRIcjJxdmtM?=
 =?utf-8?B?ZEV0Q0ZrVXFkZzBjQkFTSDRCcDF4L2M0V1NDZmQ4UG51a2oweGJCd2k3WHdu?=
 =?utf-8?B?SEluc0hyVU1jRUhVM3pWTjU4cVlIc0xyRGRTTEJBWVpHaEZSbGFaK3F0dnRV?=
 =?utf-8?B?VFBqV2RJcEZFbzAwWTl3M1ZWemFUazYyZDBnZzJNaHBZWWZCcXBPbEhiRzl2?=
 =?utf-8?B?Q3RpQ1RYVWNXcE9LbnEyQ1ErNEJ0VHhYeG1jeFlad0NCd3JicFB6ZVRUMEdS?=
 =?utf-8?B?aG45SnMrWkRmdmJoaFFZemwxS0VXbEhHODRZenZUcjVjcENaUGZtTEEvd0dN?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d988b9-f0c8-46a7-bd30-08dbae2ef235
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:41:26.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFxZjB/hEtRoa6r2PvfO/vY7bgoJeblNffKK+rYtivTwAOhuRR6EsLbHZ9lO3LZ32YKrVJpyB+7zyN0Srja1eNOYd+o3098KBr2sT9h1dpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/4/2023 2:53 AM, Ilpo Järvinen wrote:
> Benchmark command is copied into an array in the stack. The array is
> BENCHMARK_ARGS items long but the command line could try to provide a
> longer command. Argument size is also fixed by BENCHMARK_ARG_SIZE (63
> bytes of space after fitting the terminating \0 character) and user
> could have inputted argument longer than that.
> 
> Return error in case the benchmark command does not fit to the space
> allocated for it.
> 
> Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
