Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E935E69E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 19:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIVRvO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 13:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIVRvN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 13:51:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DBAF3718;
        Thu, 22 Sep 2022 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663869071; x=1695405071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c0xnCok+Xp5xdo+xlcUzS/2dfnDzquRaeF+84Cjw/ks=;
  b=Drux9B3Aum0W53VA2WbLccg39sPe1FnkH3lfaa1OwUD2SzhGehBXWjGh
   ri0GhPonZs/54+WmTRwHqCFWelA99/duqhHrlJv+o9SCrYy5XH+KNpQDY
   /jK358+mLh4iGoWHtAtJWkERmqK6MzUXPk3jBi24jlRjoGds6MdbSI/1U
   w3BKnhQD+eu5SnVmEdtU3q2nzj9GA1llhNzgh0jEFzQnWUZGHdlrQRoHv
   /BIGeq91JkzdvdKFpLrqtvd8ks6ycZzPxc0IkQIqwkTQROqDHTwXTYPlK
   0xQqK/mBg2xqq02Nf1fe56KMcZAaQPwdt3qIHcXj4gzxF8beIZ8jJE9vw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364364604"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364364604"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:51:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="688392589"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 10:51:10 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:51:08 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:51:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 10:51:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 10:51:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXHJdJtHy5dyrSvW3lqCiN3t8NZOjRm6KPU17wyOmL4+mMiAJArQ1l4t9HecXuTYRytxD7eAPNN8HP4nIRr7YbUmSH3/KjIMFqCHk9aVcNyaFTz9Fkfjp5L2adSqiaHxmZV7fUOJvL6f7x1o7zdtkQvOW4+71v7w0Q4A8icQIPOZvwAM4fZl4y7TtYeLJKiiXgknLP0r4bh4ynrjHVdHN2l2s9pLvsGH1scln+3NW45SczBJG/mz/gnpXnXFzSeEv6+ewgiXnu+i+ylJyZRnJR8AmfA2cV6f4yRBdaJ4ncYm7sdJIrt3+eSDVZ07r/y5qlq3nuMXnQlfNNXhb5p8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkzHuG9JtkUmjA5ZQ274yhZmdsQ6VARdujR8x1g2c8U=;
 b=l+c1Bfvyd5JB01gfwqYlhUqKbI7Dpv8usOffa4B2fE3hSIR5BceH5e7pK1HRQqYGfZyHD5TgVYaT/sS9eAmIvL+GvZW9JIPspBmF6V/6hGw60qokcaWXipCzx2BO3hmN2oEVbmYAzlImxEsgszk50nrIJGGltkKHA7N3z3Qb2ybBecvt3r6Bb3EP5KWjsp1K5IicFbO9eTmQZCCIw9GZuyz6Im9/i3Z2/ONRtDQCJCd5avJgPN0ZsaZ9ojMNoxjWgb7dlmZ8uZoSrZi/jViJxIxn7tY3YQNdDQr3DQFjfOVu3I9F0zOv6T+aMUb4wpSM5MIWyb+Tu44MRd3crI70MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 17:51:06 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%11]) with mapi id 15.20.5654.016; Thu, 22 Sep
 2022 17:51:06 +0000
Message-ID: <97522844-0b19-fcfa-dd39-c2c2c9ca37ca@intel.com>
Date:   Thu, 22 Sep 2022 10:51:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] selftests/resctrl: Return MBA check result and make it to
 output message
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-3-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220914015147.3071025-3-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::21) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA2PR11MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 16da703b-69e7-4ab7-75f4-08da9cc3061c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Di0hykKdeLrqsNWNhBVdOYCfMBdTvkJpRq5Ii7EyemIob2n7Hr79FK0M1TOSP73hXiCPwSRS785yOiJdGkAc1lQqfgcTV3yDFOkJWpN6Ov7uAqJwO2sxzgmwM6c2KmiuB4gzvoUe1hNBJ3FUSy/nTJw8Aegc8SSIzqP1QRcqgweWKwaC+OGDNQtTaGD+dkLpY45M7nTCaXaKRLROv0Mv+MJFMTzSi6a7/JMfjlZ8018TdKJU6wwCJipPCP2tdArAtDt9dJ1lxGv0iSk6xBZuX3Yk3HMu5FdZiZwZVAPbRduTUir11oTSf2qddm1gyBTsnBi5ktIEP9Ifzti3qLgaY3evIF9PbZ273OppONPj2i/JG8Q46ymcTaaZoQnu66gNyOv2Z7sFowgRn/GHUsrrEGjVOFrDz0cvcQyfFS1vD4w5AilPrQOQpGRb7cemb1e9bnCLiEhA7bLC9UHnXv6ubNvv4G68c4wDsFXh87uUf+tOFshFkax6L0DlRjamWIulk3qthdNwypUEByYmt2zIdTu0HERSfmjEmlXeP4xXGZyF9pvncABQ/yb/rtzT6lB7fueCGLJ3ia9RQdpf2ihAx8lJO+ZQTACUEWBpcuLwK2WNRsuiW70K63gOJisCEvQM9hL2YI5EtwAUjbYSkopYFC9NnyNWVfQLrDm0ShM3fvW37KFXFtepm//rUm5vutUYKUSgvgjj1fFbJhm3FyP6mOWRNG/HAIF/W2yktR/iZF2rnxcFVY12weR3ga2bM+8XYlp+kABZ1xNB++IBGPiSh5PDbndgkx2+0XeC3jALBPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(66476007)(110136005)(5660300002)(66946007)(86362001)(31696002)(66556008)(316002)(38100700002)(4326008)(8676002)(82960400001)(53546011)(2616005)(41300700001)(6486002)(6506007)(26005)(478600001)(186003)(6512007)(8936002)(83380400001)(6666004)(36756003)(44832011)(2906002)(31686004)(15650500001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmIxN1p0dCtZeExQL2NEcEY1WitVN0pVZCtLaDRiL0ZOeUhXNkx3Z0txWURa?=
 =?utf-8?B?c1FuQ2lHZ1dCOUZZdFdua1lLNzQycWpvbTZjd2VIakxqN0RtUUJIYVduU05m?=
 =?utf-8?B?cklMVHhZYStsN2NDdGt6ZWdWRXVEQUlhNDAvWFVUb0VqeksxbmVWd2dOdDFR?=
 =?utf-8?B?M1UrWDhhRkYycVIyeUFaeXp0emRjandMZmRFNGltSU9xQ2t1aWppdlYzTEtt?=
 =?utf-8?B?Ni80UDdxcVFENTVuK1c2MTNBb1FhY0c3OHM5WEhLRGFpRjR2YlQ4WUsxa1BJ?=
 =?utf-8?B?VHYwTVlaTUpTa2g3TFBxaHI1Q3A0MVpmN1FOQXNzUXZYbkxJLzI1ZndpQTRN?=
 =?utf-8?B?c2ZLdW1qYVBLaWhhQU9wOElSc25QWjRtYVI2NVJraWJwdTNDaHp5dnVBSXQ1?=
 =?utf-8?B?VXRNZitjeWllcXZ6Vk11VTVrSHZOc0llYklxZkl4dkFrVXdnTGo4OWdsWDgz?=
 =?utf-8?B?ZjFBTzNxbWRZMDZETkRwMlVKYldvNVlmbkNmL0JzTDM5WHZEdkdOZVRsemJW?=
 =?utf-8?B?SzFDYTJUUmN1aGpWQjM0MHZhK2VZVDBudHN4RTFMNlpFMlFCelhqUDgyTnhy?=
 =?utf-8?B?VWJyMFJzODJCQUFxZDlvNVBJSTRjWWJDRDZlZWlseGhpdWJVcE5ENHkyb3VT?=
 =?utf-8?B?ZHFiVjNrbkFSZERtTTdBTENGdE9UYjNrSklzemsrRDgxSTJQSDVKY2ROZnE3?=
 =?utf-8?B?ekppK2gvdjNSK2liMjJaZ2hXTnk3NXJ1a3hzdnlRcmFEVTVtSFphZHc0V2Z0?=
 =?utf-8?B?RjZNVFY3cnNyZjdYNDd5R3dhcXlOWmlLdkNoem1GZExaWTJjQU9naEtmbkJE?=
 =?utf-8?B?THc3cE93aGd1M2lWcVBDaUdGeG9naUR6VDdHc3lTOUFZQ2ZRWUJja3VPNXA0?=
 =?utf-8?B?aUp1bzV1bThNc3hhY3pWNkhFZ29La0kzTkozTGZHRXdlVmlWbzdsdXpvcjla?=
 =?utf-8?B?czU2TUlxNGhRTjUyMU1zQ2hVS1FqZEY1ekZDVW84Q3FMTHNEK1BWZ3NaU1U4?=
 =?utf-8?B?RFVPV1BXWHV4aTJ4NitKbW1DNDZlOUk3V0MrZWdTRWVianFPczFaMTY2dG5i?=
 =?utf-8?B?dTd0dVJRM21neTU5QnRWWlQxWWNIWjZxd3JVeEduYlpKbDBKT3BRT3B0cUww?=
 =?utf-8?B?MlNLazcvRG4xRlRNc3c3eFZmbnN4NzNtalNvSjVWK1pxYzBkRXU5WFNvRGZO?=
 =?utf-8?B?VEtXdFVsNlNqWVdtcHpOdFdhU0UxaGZWcWNxYzgyb2p4bnNSNnpEVjBhb2sz?=
 =?utf-8?B?dXh1Sk50eWNmSnZSejFiWnB2VzJTRGZxc0RNN2NiZmRtQ2tZRGJDNkZQNTE1?=
 =?utf-8?B?Z1Nmcmh1WjV1eEF5MmxJdmZjenl5TkFtUmJUNFNDK1FUcHRYaDh6L1FUTkNq?=
 =?utf-8?B?bWVQTjMwY1lNd09DdFBwcnRicVpiWEN2bzFkY0pEMXF3S2xhekJVeFQ2QXdD?=
 =?utf-8?B?UnkxM1Q1cG1vbGpaQWc3a1JLUHRhYW1GMGYzc3hBSnovaC9LNU5PakNFVFNL?=
 =?utf-8?B?QUJaUzR0Y25pN2g4QTlpcmcrOWYzc1JpbFlRQk5kcjAyN3EwSjlnSkJUN1gz?=
 =?utf-8?B?OG1yUEJ3eWl0RVlXV0E3MGtMa2E4QUxOcVJUSWpWbDVVRVpRakF2MlY2Rmxx?=
 =?utf-8?B?Myt1aWpxOG9uWVlwL1Fzd05pRE9QTUxDb3ZSK29TRjQ3dG5SdDRLTmF5Q2sw?=
 =?utf-8?B?RkdUMm5TMEE3S1VDTHRxSUd3U0IwZnJtWklMd0JRemRLNG9xU2hpSjZNenFY?=
 =?utf-8?B?bEc5MVo0MWcvOE9EYjhQbmU4M2toU0pIZE5rY08rVk12Y29VTkthK2hMUHlL?=
 =?utf-8?B?Y1RaZUpaSTBTN0tWaFhpY25zYlNhV2JYd3dMUGtKVCtpdHBVSnRIMW12dm9m?=
 =?utf-8?B?bFJWWmJDQkk3MFVTVE1FallqeEFjN2R4VmtpYUhPajJJazZGMlZVLy9ZQTVy?=
 =?utf-8?B?bXlOV0M5dEZtYkROMzIvV3dLNG81dTZ0dzdTdTU2RkJOZk92YkN3LzhlL3Ex?=
 =?utf-8?B?eTRDSHluWGhQN1AvUVNyZEtaR0hub3ptaTBmd3hvOFN6Nk5KZEZobW1CY1BG?=
 =?utf-8?B?SnBldzR2dHlWcGtaRzZydHJjekpENDhRbmxxQnJRTHVzTlRzdHJOQTVzbzBK?=
 =?utf-8?B?ZXNrbVp2d1plVk9TRHdBSzFWWlczV3loTjhnSDhxeDE5L3pkbDV1UVo1cXlF?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16da703b-69e7-4ab7-75f4-08da9cc3061c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:51:06.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1NBn2vL44UpJa3u3faj0eSWLlo/AES/cfFPzCurv8zAVlBXM+2NCEeesyGngaqhOwVsYAnLnbR4CYM0Ozf86tw3Wz+1XYfx3YM4KD/VBzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5018
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

On my side this patch arrived as an unnumbered sixth patch forming
part of a five patch series.

On 9/13/2022 6:51 PM, Shaopeng Tan wrote:
> Since MBA check result is not returned, the MBA test result message
> is always output as OK regardless of whether the MBA check result is
> true or fail.

fail -> false?

I think it should be either succeed/fail or true/false.

> 
> Make output message to be "not ok" if MBA check result is failed.
> 
> This patch is based on Linux v6.0-rc5

This should not be part of the changelog but instead be below the "---".

> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---

Thank you very much for catching this. The fix looks good,
I only have nitpicks about the changelog.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
