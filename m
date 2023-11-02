Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4617DF92A
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbjKBRtI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344079AbjKBRtH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:49:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F46199;
        Thu,  2 Nov 2023 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947342; x=1730483342;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=56GFYeW++JYMaQ/1HpOd5JdL5srLYbbFUmwkaEx036w=;
  b=RSiCrYhF2zfrPtHve9lEvXnID0rCzBfavBYK5PEVWwD7YVuJi6zTRM5v
   FunR4TqOujhMK+B5e/tDA2pGpx+ktq+k8EVeapZ4fftjt2ktYGaIAYfOV
   7tZc7wlIloDJxEG5nrpgvnGLSnSVsRabg7E7/3UVvLi7TrR2XEaHQxvki
   a+wbjTCBvkaghaOFCyUQT8zeKdquD94IRXx6t1W+JMHS+DeQoF4+h06kx
   WVVvzj10Kt1OGsaxJvD+56uCIVAfc4CamVh4Xte3STgUIWAse9BKG5Hkx
   B64h01cAe8rbBFs0TIQkEC7trQhuEHJ90rTbjveVayEAzmpVumWGpQBlF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1650222"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1650222"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:49:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878337198"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="878337198"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:49:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:48:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:48:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4XPeso51GhPPb/DdSDzeUEMF1z5mqKV+uDOG4j1dEkZV8viGJedm8dB9/odqkxcrRrd3KmSBDTza9Tsn7K0CTSC0GKNqYQ8kGcm6BmgzL5+np/+fKNqKGO0kFu/dQT23fA/11MaIuysos+2Y+KdQSGibMlKHh8yT5I0X8FJXYaSYrUtcvG/QDf+kytlMbkVn1nYAcLTO1hR5CYPRboY57PfyzIYybDIV8RCX15MV1Oqn/71ZX4+pF5UhF4MaMe3/LJwtbm2K4HEF+pESyT4LQK75TX+Bf4SkZulaZ0JqOx2uLnHvnPTj/ZDsg9aa16ov6bRCxb26GGJFDKiD7pY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPt3en17FlZyotXiigLVjpbTE6vZY+YfNYkLxo4NiGc=;
 b=W7YM1ICh8U05zrglaRADCDrjx0Hwd/MCHwwqXt7gnJMog6aqQ0a6eLFUrq0SHUW9skjotc003S/17gRUQdlOlPnawJTQpJFGxqwbUGBDhAaJcyM/SD6OiJz8LJtGEZoIK0c8iJpygFvpBP5ZlkqnsCdkA/1wwfGD7A+Dc9zsm66fpRhODD5WWUmrRnDR2LytQvPsAqDVikudiaRv7VhfgtBCtVdevJi0SvKNj7N9hUWgN1myYmA0IDmK0004t6kLxY/rG6HDxrp7OsVeiNrCSjEWwlBeBWtcQGCoCftAbXX5NQO19Jcg2JwZhgDQEpZjF5o+RghF1rm7XA5PTxViFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7949.namprd11.prod.outlook.com (2603:10b6:8:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:48:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:48:58 +0000
Message-ID: <f0252e2b-e3c3-4ad0-b622-53e38f5ea3ae@intel.com>
Date:   Thu, 2 Nov 2023 10:48:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/24] selftests/resctrl: Remove unnecessary __u64 ->
 unsigned long conversion
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-10-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 81204193-4572-4108-1cbc-08dbdbcbfd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjHzNZrKV2zSy2uRUHTNNx0DN+Y4hj9MPI42wRLDEeBKVdaapFoRXWs3B5uEkkinDWvR3zjdmXOhh6Py7kRghiAwPuPcYmeeW7WCV7+IWGbb01U2dg3AR+VG36jx0beN3fqQA9wH+1lpfOTbjJs5tCju0FyiBLJF05UiA+twNfCpJYSkwQ+dKtek3ST2Tjs+FqqYyqW1omj0Mj6wFdhSoFecET20Y2Pu6x0SclO5Fxzv7eCayZznDpbFBzcGWen8HR344axdIcbuov9+3Uq6Eu/eNKEYe7K/G0dMtVIfY1oAJ4ImsOaWhXVqU2hEeOkg+2oYFGVjIIXnye3obuAswMr0SG9Ex8wRAX0ewlhk3wujNjA0eYTSvxg/Rd9ASeiGfm1xB5fzayUUB0obyunqM6O83amqFDY0qZVjcR3PvxmOqpKg98LLG6yveUk0PLitPBaLrCLf5/zcYJXOrBVouK+PXt3s8rCXvP3c7+UDRt3attaBmpjhZQvg1k1/V7SPO2NDBHpuhxKS4TXj1qs+TuOyrx7SjuNhumfhHVXVF7RyihiBV057iLaeEGjGdXaK/cvxUQEJfFQQKfRCEK4HvfzP1yvbtumrvkcWggWM9IN2pfcfkbLBwsj6AIY8tyI1z8i68Vpdo795IVGp/h08Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6506007)(2616005)(53546011)(6512007)(26005)(66574015)(82960400001)(5660300002)(36756003)(31696002)(31686004)(66556008)(66946007)(110136005)(66476007)(316002)(6636002)(86362001)(44832011)(4744005)(8936002)(6486002)(2906002)(38100700002)(8676002)(41300700001)(4326008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEEzbVM1RGt3eU5SSVNOVVN2WXMvMUE5T0ZubXhSYkJpeXdxNzd4ekI1dlJM?=
 =?utf-8?B?R0ZLeWJOWGxvQ0hHdlJBQVIwanZuSSt2SjZPdk04T2lGcmxYNHJIOUxJUElY?=
 =?utf-8?B?VkUzOUlkYTY3M3pwMjhMQW9MV3B1VnFpeTdWdkc2SDFJdkNwdXdMNERGR3Nw?=
 =?utf-8?B?T200Vnl2Ymp4aXU1dHNJNnpkSS9rMzBueE4vVTFnS0NFTy9zbE5yNHQrS3lj?=
 =?utf-8?B?Z1ZuZGdzNHRZQ2ZMYWQ4NkpyOEhVRmJHeHl0c1dFSFdCSmpySEY1WGpsS0xi?=
 =?utf-8?B?WE94WGNkWEswK3B2WDZCdXBxMTY4RExIME5LTzVMREcxWStQaFdwRzJtQklZ?=
 =?utf-8?B?RVB3UWJjMVB5SGFnY0NFbnZYa1EwYU1rT2pwdEovUXdId1pob0JBa0RISHls?=
 =?utf-8?B?OHBlQjhUTXFjejdBVWhXWk03NGI3LysxTFR4THFaY09UeWZlTEUvQWlIdk0w?=
 =?utf-8?B?a2UyeHdlY0hqa1dFRi90TEhxUjFRT05xTjFJWUhKbENSSElpTHFmNHZ3alBv?=
 =?utf-8?B?b2FsbjhrdHd2RTdzK1lpMm9rbjdzOERiUWZkbWFTZWkvYjRaZ2N0eHV0SFhS?=
 =?utf-8?B?M29wMEFlMlVQVkludjA2Q0Q1aHRmZ0oxMktGeFJvaWg5T2p0UGo1SzFnK25i?=
 =?utf-8?B?R1NheWl5dExqNTFNYWdZaGNpdUI1bGlQN2hKa3E2Mk15elBrUEFoeVJZNjM1?=
 =?utf-8?B?YU10Y3hocXBla2tJWi9kUVVHY1JxTEdUZW9oQ3NXcklNUW0xYWN3RFgyN0M5?=
 =?utf-8?B?T25YMnVvazFzNUN5NHdzWjh3MnAxR2JyYStIZ0YyQlZ0bkE0U2xsU21vYjZk?=
 =?utf-8?B?aU5HNm45d08vSUthNmVMV2RWdlcvejl5azRRbERROGJDYjFtenpudGVRanVa?=
 =?utf-8?B?QWN3UlZqNm1UTFhwR21zTS81VGg0UWV4MXpDbVNPbmZMWURxcCtyVVhFUDhs?=
 =?utf-8?B?Nyt3bzcwVjg4WGFPaUFsdzI2OUpmZkZQaXhnSm1nL1hmMTVVclZYakQ4dkZU?=
 =?utf-8?B?eFFaUTJrV09mQVcxWXIvZlhqU3liRktKRTRHclNjbncrOUxTaWxndVRiTjFB?=
 =?utf-8?B?aXBrVGRtaDUxdW82bCtDRnFTSSt3NzNtR3UrR09KM0diRFhPS3AzY0tQV2JI?=
 =?utf-8?B?bXl2T0NCZVYrWnRVbHptNW54ekIvVXVsWDgwR3VkY01ENmhobkxobEZReWNU?=
 =?utf-8?B?MytxQUhYb1pIUGJKWjhsYTJGbWpyTzV6MlVlUUFGa09oK3dVdGVSUVN0dTdJ?=
 =?utf-8?B?dUo2NnBEc3ZiOXZ2ekxxVnU3ZFNwUzB2RXp4ekE3RWdjNlJDVGlSYjJ6MmF2?=
 =?utf-8?B?QVVYRE5tZ3NuMXNDRXl1Zm9QV2MvNTVyc1FHaEE4S05iMmtERFI0dXRjVWxa?=
 =?utf-8?B?NUV5bmE5MDgzQThlNkQ5WXJSRnBFNjZwbm03Q0h5T2U2TEVsN014dXUwM1NO?=
 =?utf-8?B?Q1FISU5QU2srdEttUy8vbjI3dFVVc09LVkx5V1lyT2htNUJrZ3BPV0RqbFNu?=
 =?utf-8?B?a09ZdW1WRGJBbmREajBON293d0kvK0lFTExBc1NsQzVTQmxkRkwwWjU0bEpM?=
 =?utf-8?B?b2FFVnNrSXRtVnRVQ1luMkpSTm84VVIwQXczRiswMUNvN3d2dG4rOVVHdk1N?=
 =?utf-8?B?YXJleWhTbU9WUjVTaEMzK3o1NFpuMFFseGM5M3NGeW5KTFdNQ25wQzlOamww?=
 =?utf-8?B?dmhrWS9kRXg3SUVjd1lRRDdoL3FqcTZtMFcvaWRuQmZOOTRRTjZ5WVdIV1hh?=
 =?utf-8?B?ZTVuLy9SQy9pSlFaRTNLVU1oOXJvVjZlb0dyOWRlTFcycWpwTUViOHBqQ2Jz?=
 =?utf-8?B?UkhzOGRjVVhHRUpIWkRzTzRzdkRxcm5qSmtsNDh5MndXeGRzazlIcU8wQlU4?=
 =?utf-8?B?aVNkYkExTFFtT244UXQ4OGFqTitVRWlXOXFpUGUwbVpmTVdDRnFjSFdLbmhk?=
 =?utf-8?B?TXYwNUFHQk5ZdU9hbU15U2RwanZST2NhK0xUZzdFK1UyYlBBNGFsTGt1dlFl?=
 =?utf-8?B?NGQ0RkFIRlBtYzFuaVk0aEtNL2xEZTZiMmRsSlRGay8vc2dqejJhY3BiZFVY?=
 =?utf-8?B?ZFBjNkd2d0xkcWkwQzVtRHB3NHA0WWhkTEFHMVJUYjBhQzUya3d3Sjh6dGV4?=
 =?utf-8?B?M1VvR1MwdHcrT3hSKzEyNUplNEdDK2FhWHRHczBvM2JCa3NBdThINHB4N1VZ?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81204193-4572-4108-1cbc-08dbdbcbfd70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:48:58.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fH7bbug6hT3UgImoYT9GWt98WtST2wXIRqJ2zinygD+9n/UhGsH04LTsb5Jzs2Mz+CMea3teKNXdWiymgdw15cZAFZ+Q0R5JB6+fzNuRtI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> Perf counters are __u64 but the code converts them to unsigned long
> before printing them out.
> 
> Remove unnecessary type conversion and the potential loss of meaningful
> bits due to different sizes of types.

This motivation is not clear to me. Is this work done in
preparation for 32 bit testing? This raises a lot more topics if
this is the case.

Reinette
