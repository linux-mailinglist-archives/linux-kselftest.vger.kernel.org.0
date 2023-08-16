Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8073D77EC2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 23:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346634AbjHPVrB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 17:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346659AbjHPVq5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 17:46:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB71B1FD0;
        Wed, 16 Aug 2023 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692222415; x=1723758415;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m0pvUiMx6RF9XLzh6+0Pszs5vCGeGF/GfSc/lHKgou4=;
  b=Gt9d+itUbsHVfJ8jGN8upelUcOR3kmQR9/uXEnw969Ltox77zS5V7uuH
   BOG4ZVftbJ3V/u9QkAzlk565Bmh/jBII7siBKZLi+5SG4K+qFdk0l9wOz
   dHKkStnvhHdneghEX9gG+BsIAqNm31qMXG+o90Jepl6KiGoqUJXXVD0qP
   qZiEqNh7zLXJSxT0FX0ePnBSb0yaDYAcCQGRlMNPbq9D4B2KuiN8XbOI0
   PNCOShfvnB7dC0V7Tms1YdDYlo2itvyXjG30TTKhP5RmKjCXw1uY5BK3D
   wu6STXMrpiKLQzmgOpg9L5hPpsUmJWCSqTHOjBhXoXfma38vX8fq2nG+D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371545567"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="371545567"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 14:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804389071"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="804389071"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2023 14:46:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 14:46:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 14:46:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 14:46:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 14:46:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/Fu+eYzaD/0DPlJr1pKpqisSbyvnXSo8ksS7GR+6MQfQKIAmPoZ7nmOb6HitX6MktF8Dm0cDCdkmffAVI2GKrt/fV8lvV0ANGnaU0ZPZU8o3JEFn6zzGOBhJzesvsxyRb+OyEuaUMZOdj9NVnF/EgqKy2xuqUuyoOFsC/8rS8gLBi1p5t1w0aJEmI/Kgwvh1Giz7sIUe7XZKD+VzDyZ+CGeNmaC1N+rE4l+iCRdO+ZqF1DrSKjqxS7eJzJEeQiy+fcphhw/pLSadB68ZnXHLwlnd14A+/+FaDjU1EvNSDVkp+ESir80M9qHseyEiN1CJiLdwj65jSiYJMyfGi726Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/rd3ttHbRxx1hdEy/z3iwQ+wGV3BoI/FWVrJ7jOtY8=;
 b=V0IqQ+l3n1xoOqKAv/qqJ2hUhi9w1TDQTwb/Zmtz/76L7K1xA3Sal+9aJvhht8F/PW4VzxpJ6a31iUI7K0PFHBmVPeP4dDx/qUUIVWPfgsDGkrA6hxO7aDvjypPhTABeKN0tJp4OfSuzVTlrlnQStbJYeqvG9laafD4n+Y69zMEvQ3CQtkqEg2JAKJZZlPh6hLLRt5kuMKIxbmCYRQFsF1G/o4l6KyEQWURtvlV+Q8157pfpP2qEYbBrekftgp9G4ULrfD0XH7eenBtU/MIUaMG1iO3WBpSYQV6E+VNt1URjGOrPSOAfvsXg/0I6Xyej5uUyUJLkXTGb2807u5Ax4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5505.namprd11.prod.outlook.com (2603:10b6:610:d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 21:46:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 21:46:50 +0000
Message-ID: <8b67c807-fa6a-19d9-15fc-a43c0d4aef8f@intel.com>
Date:   Wed, 16 Aug 2023 14:46:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 1/7] selftests/resctrl: Ensure the benchmark commands fits
 to its array
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-2-ilpo.jarvinen@linux.intel.com>
 <9e56779c-4df0-654f-08e1-b27e0dd6b2ac@intel.com>
 <12ce6b7a-292c-6f27-809e-a7cbb810f596@linux.intel.com>
 <a64114de-0a95-4ed8-aa06-b30a948fee6c@intel.com>
 <ff136876-449-2d6a-b4dd-13ece5f3e12@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ff136876-449-2d6a-b4dd-13ece5f3e12@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5505:EE_
X-MS-Office365-Filtering-Correlation-Id: 796aa7fd-e2e3-4e2c-7753-08db9ea24c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LncSQBB1wRWNLOPm6RLB6muYRICqWky8tPeq4sx/YoHu4Eyfo0RjEzgMkDLh5b+PYCHkwUvfcF/BaqA7hS1V5Hv6Vrm8ZjSOBAO1lkNzz+W8QGsZ1N5ij/Ibs4PBRWT9k/fv21HTHiX/0L8/C3FO5Ois8L5pvp26980W46WMBF/xUWPLaqgpP2WIEjR//sTKF4ioCuEsg4CC8+PBbkRs6zlHnUElQk73s6u95vXZTX50DgEhk2Ek0lYZBL5XqvdffGp5wjpD7YItjtyFo8sELRPltDxvgNM0aOkF+8iKmXWlXvKwHamoWBQ9Hw7g1FnzkflbzVJM7e0KixwuAqgWeBqPJBSwaIQ7Zl8NOeKaSb/3QZGHzVjXf8BR3ezvpqrjw0BspwbYD4l49OaDEus5PxtV5CiucD9P0w5niVp+RF4EAAgYAeWY616izLc01ZcemnCC3fvYCtlBDn3a3aSud3THJK/FYlZAV7J1q/s3H9epmDBjOBglpUap/0n7agO7VS03q2MXkFC2owkY5fMJIcSt7pCrvzsVYaduFkHjdL6qzTkFSZyFlI/EP/6FQH4wIDlqHl+DUk993J/X/z3NCCoTpbGRe3adMQfbXBJBbyB6e64+XKCf1fLAC2NpFoXPu9YktEYtLRzjsnAPT2NCGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(86362001)(478600001)(36756003)(6506007)(6486002)(2616005)(6666004)(6512007)(53546011)(31696002)(26005)(44832011)(5660300002)(41300700001)(54906003)(316002)(66946007)(66556008)(66476007)(6916009)(31686004)(8676002)(8936002)(4326008)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJBNHRPNG9hSUhaUnR1VmRpTTkzVDgzMzhnOVplK09HWG9xSE12ODRHaEdT?=
 =?utf-8?B?REZoM09nb3ErY1JjVk1obk5hdUZ0UWZXRW5ROFBCbjBIdXFJelpJUG1yNnVt?=
 =?utf-8?B?M1NMcFROaFhUZW5WRWtDSUpEa3pyeVZ1Q1A0a2hGU0lhRFhNQ2I1RUcrUExh?=
 =?utf-8?B?NzlFWnd3ZWJ2dEFUSmhudTVib3hOL2dZb3ZwQ0lodC9tcEdNK0U2VmRtNmcv?=
 =?utf-8?B?QWhUUStTWm9sL0Q2bkZUa1lxS284Q2hiSEh4bk1PaGhMM290dGk5ZFZudmVk?=
 =?utf-8?B?Tll1OGduSUt1UVlpdXBRakxFeTlPWEh1d1NxWHQvUmxkVEJhU2Z3bjNWekdY?=
 =?utf-8?B?Y2crSHRRb1hUNVBLNTgxQ2RKdEFkV1FTSjZka3Y3QW5NaGdrclNyUExUWms0?=
 =?utf-8?B?ZStZbXB0Zkt2MG5KeHcyZlkzQTAxc3BFOXRwMHZucnJkMXhrd2tmeThUL2du?=
 =?utf-8?B?bFd4ZHlhcTA4TVM0MFVucjhCUHZFN1dlSlA5Yko1d0FRTW00NmRqM3FGK0VK?=
 =?utf-8?B?WmRhVi9OODB4eVdNZm5ucHJyb3lETldBUzYvRDIyZEt0TTFEQ2MwbzBsVmEr?=
 =?utf-8?B?aE5peHdRYjhrN3NNV2EwUEQvbEVmQjdFUVNDZlFDQTlqU1Btei9HSURrNm9J?=
 =?utf-8?B?ZGZUTDU0a3NyYnAzNUxHOXR4eDZYNUorNmR2U09lRUh1MlNLUHRjeDMrL1pt?=
 =?utf-8?B?UTN1dm9qY0ZibGhxRG9uWUJIdEk1NExMNis3WGIwNUNFMmFtRktuMm5yd09L?=
 =?utf-8?B?TFM0RXZreEZUNm96OWNoVGpSbDdxUTRoS1NJR0IrR2NMU0daUkdYYTI1T0pr?=
 =?utf-8?B?dVA0Y1I5a3BDUDlYeDhZanp1bUg2ZVpxTER0RzZ6NHVEYlVYYTFPSjRHYnha?=
 =?utf-8?B?ZTJiWUwybENJSFNNU0RFVkFQdXVBMHliK21qbHE5TGgwRHcwdVFzVEVCQVMv?=
 =?utf-8?B?RVB2Rm9JUVo0NmNWN0pEdyt3bUhnZnhLUFJsUnJXa20wMGU1NzJzWitweTR0?=
 =?utf-8?B?Zmt2ZnBSOXd2anhXWVlUR284ZUNUc2w3UkJlVUl6UVVYRGUzRDd1NUxOaDdC?=
 =?utf-8?B?N3ZiQjFKQUdlempHeTlkV2FoZlZiQkpuQzhmRDNaS1ltV2xmZWd5MFJKRVBo?=
 =?utf-8?B?bXUzS0VvTk9ZampscHU2UGVmSThtWEtmLytKdExyRXhtY2tHc1dwQVcrY29J?=
 =?utf-8?B?SkdXTStwSDQxVXNhOWM3UDExYXJZaGpGK0s2T1paL2hYYTJlMGE1encyZE4r?=
 =?utf-8?B?cUY0aFJEMmk5SGxYZ3VuSlg0UWcyeWhnQjBTVTY5VjZyaTRSQlY5ZUVDbjY3?=
 =?utf-8?B?Q0cycUFVbzZ5aEoxbDN1b1cwY1hsK00zR0xLeVF1cGY4LzcrVW9ER29ZSkhW?=
 =?utf-8?B?VDFGR0RlWFRERzFhaDdpYkRYMjkvSDRRMmExaHl4RTZKdlBRYlBjT0g1cDF3?=
 =?utf-8?B?YjhmRXZXb0k2elVhSmxQKzFTeUFuWmh5VFZBbmI0VEFqV2lxMDhpVGxEU2x6?=
 =?utf-8?B?ZCtab29NeDcrZ2N5dVRjQ1BucnBWTjRpQXpDclVJcTJtRG1GSjBtSkM2Y3lW?=
 =?utf-8?B?MUhWY3c2MjVvVjRjWGxkWmJha2FjbFpyNGhOelNpWjhoNC9MY2tyVU1yK1Fy?=
 =?utf-8?B?UTUzbEhsWlFCL1o1S1Z0bUg1K0RCQnk5MHFaSjdjZDlPcW5KQXB1M2xHV29w?=
 =?utf-8?B?d1pQZ0tTMXRlMUhuNnRnbGR2YkNMTUhNQnRCNEJOVCtZREkwK3ZUMXM4Q2VZ?=
 =?utf-8?B?SjRjNEU5NGEwMEFUYVovYTh3MWhHWnlrMjNscENMdzVienZhQm9BMVRPOUk1?=
 =?utf-8?B?WmR6Y0hMMmUzaFpzODZsWnlURzdjNlRxN2ZRSTRzVkRZVTJOMmtnU0JxeU9V?=
 =?utf-8?B?d2poZERVenZhVk0reWNTS2lmNVNmVkZydGRhaEozcFRHUG5qaDFZN1dHdkhL?=
 =?utf-8?B?MzFJblBvbGZTV3ZaTUZuQ0MwSjZlK2ZnY29ZS2gvclNBeVBoK21EeGlHVk9z?=
 =?utf-8?B?R1ZPTzNVRDdtZ0tUK0hMZElhTUlyTmtnYjF4QnBDWkNacmhuZDUyMUZJcjhl?=
 =?utf-8?B?aDI0Nk9hUnVLR25WZnJRQVVISFhXc2J5bFFFSGt4eHhCclRVRVNhZHhKMzhC?=
 =?utf-8?B?WGpGWGVNYUxEZUQ3dVBOeU9NVFpCRDA2VmgyYkF0V2JwdE9kQlJWVGVLYTZx?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 796aa7fd-e2e3-4e2c-7753-08db9ea24c0c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:46:50.2250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43tjRDHrxg6aeTKnDzJzKMuEKy9t6qdRnji/ur/gGiQdgUhs7pUnQlmypufP0s8DMHHF+nT7Rpigk1OjLFDp2o1hnsfG5Oh+oFwe6YALS5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5505
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/15/2023 11:32 PM, Ilpo Järvinen wrote:
> Ah sorry, it is actually scripts/get_maintainer.pl automation I use with 
> git send-email to figure out where to send the patches besides the --to & 
> --cc entries I provided. For this patch, get_maintainer.pl returns this 
> list:
> 
> Fenghua Yu <fenghua.yu@intel.com> (supporter:RDT - RESOURCE ALLOCATION,blamed_fixes:1/1=100%)
> Reinette Chatre <reinette.chatre@intel.com> (supporter:RDT - RESOURCE ALLOCATION)
> Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK,blamed_fixes:1/1=100%)
> Babu Moger <babu.moger@amd.com> (blamed_fixes:1/1=100%)
> Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com> (blamed_fixes:1/1=100%)
> linux-kernel@vger.kernel.org (open list:RDT - RESOURCE ALLOCATION)
> linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
> 
> ...which includes Sai's address (not much I can do about that, it's 
> immutably crafted into git history that those lines were once touched by 
> Sai). I've thought of writing yet another wrapper to filter out known 
> failing addresses but until that's done, either I need to (remember to) 
> manually send the series w/o get_maintainer.pl automation or accept a few 
> failures here and there.
> 

You can append Sai's address to .get_maintainer.ignore.

Reinette
