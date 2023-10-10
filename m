Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0B7BF27C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 07:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379335AbjJJFxe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 01:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378119AbjJJFxd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 01:53:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975E39D;
        Mon,  9 Oct 2023 22:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696917211; x=1728453211;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=b5cWRD174cmcvkgF/QqgcL/E49AdrklTb9R1ZdhSlYk=;
  b=O+9T7CK/PEk9lA7U2CelLPQFda4/K67gtSeseixqsmabjc2FWHrfjsph
   vvIZRAhh0JHvQrZBljnPIa+wOcUFWOH2Q067BFvzqm+Uvxsw5AeqYfBUl
   27+jmGRGibfwg2spYb5KvUD0vxCmaAQbF3Mb3o939Vsc+3C52/PFP6+mk
   ilCTfXfsZbuUzTIp7y/vHSTcvR6iCEuVQv9D7ukiYRaARnJ4b22SajKoN
   QlCa+9+/QRpqRdgQjs7dT6XFkRlIEXVRaJ+oz4HxCrcNYehMDxr50/yl4
   ejUR9NbQyScJcIDcrmIYa2/Hye+XaffSTeNyWGRwqiOBC9vnCsBghB3W5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="381574768"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="381574768"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 22:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="843993154"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="843993154"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 22:53:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 22:53:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 22:53:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 22:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+hwFhMkPELWR3Ekry6x2FUjpHCXD8e5RlJ8hnt8a8RwuHS/gHgtsrFbay/l3mZRzn8VwzBAlIQKjO/qcwpXXZHUN+u8HlHVBL+YVxoLoaXujGOtU2WDNOg781Pbn9yhAlXW3IHLn5lOaoMNzAhoUPdkUC6dAPezfOX636AlcN3PsalfVe7USCOvGKtVDEv/GAPDv8zBm8jfO+i3VxjC60FPSwn8ZykFAGeW5xARmjPSoySyBY8LvYj9V5s4WHS/sINFGojLg4qcgz1nvI8kKKSAdwfZHyNI5TV5XEbhoMv3Yf7zC+mlUJbr8qtCwsgJoC9uD0t9V1zzLqlTt6uG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRMwN8bAqRioYmh+oBorn1dh5tpz8E/r5ocxm18MzdU=;
 b=eyeI+Cl2AsFVa9WGQ7sIakDLLMKklwhLctfK9gM2IS8u7ZFDs3tGrYMU836RyylWgk8RttwltKaP3SDIu/vF37HwcgGNyVEJkO2nXPLOiK1hn96pjoFLY2hlvM+KxHULbxjVmvZbDdXWbj3QWicFw8py4ZsCa1NFZcqHe+MN96COMKcnJKi9rFNossfPaF3nXIB6Wl6KNyCBzYOBEQGcL3eW1WTWsnsY5nd4KLsaDU6aSGZ2y4MWfybqbxF7cYPdP0GFfavBlJhnWDLu5MbWUjHfgMh4xx0///iCQYvdUUkOZtbUEx71sbdETZOPpO4r+7+8rwm+I/VC9CvPIaCPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SN7PR11MB7065.namprd11.prod.outlook.com (2603:10b6:806:298::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 05:53:27 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 05:53:27 +0000
Date:   Tue, 10 Oct 2023 07:53:18 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     <akpm@linux-foundation.org>, <christian@kellner.me>,
        <fenghua.yu@intel.com>, <keescook@chromium.org>,
        <ndesaulniers@google.com>, <coltonlewis@google.com>,
        <dmatlack@google.com>, <vipinsh@google.com>, <seanjc@google.com>,
        <brauner@kernel.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
        <hannes@cmpxchg.org>, <nphamcs@gmail.com>,
        <reinette.chatre@intel.com>, <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v4 0/8] Add printf attribute to kselftest functions
Message-ID: <fqfwpd5u3yjnnbojzwonvnesltves7pm6jx2cov5vaqyqsrael@m6bxnoskb6la>
References: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
 <cb1dfcc1-e03e-4517-8f77-d08f10aa507c@linuxfoundation.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb1dfcc1-e03e-4517-8f77-d08f10aa507c@linuxfoundation.org>
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SN7PR11MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: cda01329-381f-4068-d782-08dbc9553945
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMiTGLMDEXh3SzzAfCLjw8QlUICZGbR0l5v6bVNreC8CixGsr1hxZ00l8cWov7gjoQx+Zu31TBLZrvkI95hkDygdhFzAMRwceIjiy/wKSxH2q3Pcu13Vi5ZV4RShvALz9OuIWi+xoxL5G6Zxf3hxENM/8WYeGodKfbHWl+ZQxpSknUdHusZo/oeWVJL8OkBoo6mMzpeA1eztYRWY8khNTS1qIEn4oXwUyPpfd2fSLFfpkdx1VuMJotXZB3UnrHt4LAU5Fcuf+F0Vvgbumu/NLl105db+C8pE4SSaHGiSwO1sUUQuQYqw+E/BhD3zZc1jokB8UvArWfhSKahCQ3TotAZrGUcSKAdUu9dmkWjnOe9jLRAvlQkk03tLP8SJKmLJhRCory78NIJTuTwT/NMM8UFk2o+hbzp2nV1Cg4+6X38vd8yCfPoO3GhXYI7vwPIQswfJEMZxW9M1xJrg9/kiFhzjnY0IfOMRAliJTmco2VeyeaE4dPvD2finEhOWjkTBBApRnB8JJgXxbXB0Gdxt8l6Y1APqihrMW3Tfjnq9Qs/wiZmC/Y49gpIb6vHnHMxA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(26005)(66556008)(6916009)(66476007)(7416002)(2906002)(66946007)(33716001)(66574015)(83380400001)(86362001)(5660300002)(53546011)(6506007)(9686003)(478600001)(6486002)(6666004)(4326008)(8676002)(8936002)(316002)(41300700001)(6512007)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VAY4BTHnc3z7rUb3Usm2I1PbYLpBJ8C5RKO1TsFEGFfy+CXvjNiCRzvPOI?=
 =?iso-8859-1?Q?4Kt8yo3m4+4Dl2p23WJ0xOLdRfgqOzW1nlezqbd//2A7XdijewuP4NrVMK?=
 =?iso-8859-1?Q?EbQhYX7XK55/bYPau3AOBEws05BbknCnNXamOiIykYYEMqx67JQShxFxbG?=
 =?iso-8859-1?Q?dWSv7rPx1HTBNSJ9O3RiXkZY968K32S3pA0evHG4MRXN+tIeUZMmdubNvR?=
 =?iso-8859-1?Q?l9rlQpI02VQze4uvhJu5WGTrttG9UPMLi/pN7YX58S1hRNJ3clQ7nqPxxv?=
 =?iso-8859-1?Q?gB3CeW+iHmekox2ziJojq7NqxjxCxMjPNXH7r0FEaIeWD4awmoj9Kb3MHK?=
 =?iso-8859-1?Q?iC0gVrxCWmXe5jS4Oz4rsXAaQoxaxi+BaCBKLQGb5KzhXDCwm36jU0p4Yc?=
 =?iso-8859-1?Q?765lChMdl16TYpPmy7s8CNedyn5YGxbMNRzIpbySuGvrdey1Yi9TwsjQ5m?=
 =?iso-8859-1?Q?HNSbD6APHZXllmHufN6EHid0Aeyd08o3jrzGjzL7rn8n4D1vHZh8yvWtCY?=
 =?iso-8859-1?Q?M5J46jecBDCZsFcrHxmCTDtNkt5kRsjqxqeJRZ9infWj0gJdSdEPpT0WXq?=
 =?iso-8859-1?Q?cgZijQjG+xO92spTWzI1l4Wb8+ssnRHCjHeRhTD5CxvklzyfE+8naV2grJ?=
 =?iso-8859-1?Q?M4+uGEMKFMEi6jDUo7a7djTesYxFPmQkNFknBVQxlf3pgHESU4UOgkCp1t?=
 =?iso-8859-1?Q?NdwsQkeTQiUSAFJMvhYkhsn3W4Is0WmlLLriWs2LIpG2ydQPhsMicvb0qq?=
 =?iso-8859-1?Q?IV+NPYIK//1Bd6f/Qou6Ad9HhL6vTN+9G5gVJBT31Sukw0yqldlFUVzH63?=
 =?iso-8859-1?Q?vYqd5/fkD2eHJ/O9lgCaKbPGqVR5q7OoQixuRmZT/9wMRv2zox9ailFLJ9?=
 =?iso-8859-1?Q?NXEu8QnCU7pA9iOY4vjeYo7BaxnNpNnfTlGzm0UXbYpBX09HZ1WTtSUAM8?=
 =?iso-8859-1?Q?igAQk/ZnRpmRAmQUS0f9uSGjRZgMeCuWrrSot2QTbsQrZZ0QdLThCTcddm?=
 =?iso-8859-1?Q?NtezLU0ETx+lV6IkqGQzA52b18tXsvwlajnmMtg4OtbQMUHXtnXqgcmLGt?=
 =?iso-8859-1?Q?3k4ptD4dA88U0PCxoQRnVfFPp8gXN7Onzeki9cS8B9/X8UXla/4YE7eL+3?=
 =?iso-8859-1?Q?zbIAXqYpKvib1KgqZWLMJUhT+OwWVHjKg01CQG0L77I+c991zwWH0+K3nK?=
 =?iso-8859-1?Q?E1z8VCFYgBTCFeDJ1iuFu1zKZAxJP8Qszw21iPVzIB4IxTNXkROoR+x0k1?=
 =?iso-8859-1?Q?MozQWBLVarNxW+jxAKWvUT8cdxKnl7NQ6QYM20px8t9Yw5rya4rkjuvktC?=
 =?iso-8859-1?Q?uXvmckf3pEBIc2lB4bhyoJ8ImHijK2VP6y7LKng2nPL5QNbdV4+ZHKaIC4?=
 =?iso-8859-1?Q?KgqCKKbZ1Dy3vojWEBF51M3WG72RSOkCDWk/P+p6Oux0R8TPjxtGLl7sv4?=
 =?iso-8859-1?Q?zkaRukIN6XiMIqSXidFt2O30WdbM/GzvajblRUHvSa+IK6VAFmdE+kiqAd?=
 =?iso-8859-1?Q?HsUp9maEtCfAbA1XoeeivZaPH/STkZ/7jyBll20vNnNf5wvqSyHdfApERi?=
 =?iso-8859-1?Q?1oJm0R0zev9gKDW9ATNzOfHkCgDTV64lYbCdgUQerv0U4Tq4ARf8T9TEbB?=
 =?iso-8859-1?Q?/ut/6DiJZTyyH92ikE96SDsCoF4Ob6Zy0DBQJTJy2I4MMpFQycFOUyRZt6?=
 =?iso-8859-1?Q?YVfiXTljEjxyWNnoumY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cda01329-381f-4068-d782-08dbc9553945
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 05:53:27.5409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXuSaiYBn2gT08ypa9CYPEP0PwdJbcOw/rhyi8W86kjA0rPoB6VwAvyAC7AFYjCy5vkzuIGiUZ2fULnjbeKw0zgdZ67VsIW8KyDVaKfKJvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7065
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-09 at 11:28:30 -0600, Shuah Khan wrote:
>On 10/9/23 04:28, Maciej Wieczor-Retman wrote:
>> Kselftest.h declares many variadic functions that can print some
>> formatted message while also executing selftest logic. These
>> declarations don't have any compiler mechanism to verify if passed
>> arguments are valid in comparison with format specifiers used in
>> printf() calls.
>> 
>> Attribute addition can make debugging easier, the code more consistent
>> and prevent mismatched or missing variables.
>> 
>> Add a __printf() macro that validates types of variables passed to the
>> format string. The macro is similarly used in other tools in the kernel.
>> 
>> Add __printf() attributes to function definitions inside kselftest.h that
>> use printing.
>> 
>> Adding the __printf() macro exposes some mismatches in format strings
>> across different selftests.
>> 
>> Fix the mismatched format specifiers in multiple tests.
>> 
>> Series is based on kselftests next branch.
>
>How did you find these problems? I don't see any information
>how these problems are found in the commit logs.
>
>thanks,
>-- Shuah

I wrote the first patch that adds the check to functions with format
specifiers and I compiled all selftests. Then I just corrected any
warnings that were found by the __printf attribute.

Should I mention the methodology in the cover letter?

-- 
Kind regards
Maciej Wieczór-Retman
