Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2722F79BBED
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344775AbjIKVTJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243238AbjIKRAt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 13:00:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824B110;
        Mon, 11 Sep 2023 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694451643; x=1725987643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Z8TtV/mhy7KUds8cl2aTnRkwJNHuFx4QT0FXuUxEuI=;
  b=D8zGK2+e7AydjRLD7F263XgpIJE51mOYULv9xzBeecpk6ClkO+eMve8W
   yqGMtQPfsiW60OmURUdLzO//DUMdiCtY33cABtk1VI2dwUcHFBH1aRP35
   S4p9lnj25VNnWN+iNDVnlWjzAt0RJhylDGfVQ1WPL/C8Zu0MrDYhelaE8
   1GoG+TudFB6TnB1VcLEl9n6ywIU8VUWo0Qzj4Lab764kTfpUqqOcElvIF
   408OMk0PMfO3ccgU64BzVzN5IUneoEcCNOa+K0JTajytJpFBGsXt+D16g
   r+kaQsi2urwWlajhl+O5wgkaPGVceWIUDj7ttb6IzursLr5P6on7rwc9P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="377055111"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="377055111"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 09:59:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="778464871"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="778464871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 09:59:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 09:59:11 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 09:59:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 09:59:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 09:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGu0d6NJLJz1P+CbrTHS+TyO/xLHWir42P8lxjVUiHXAJPEMYh9tbCBA5VByJsIyNgrDWSRqIOkCd5JUXGCDANY4pR0vVasdM8fb7soj/+BEH5cpV/PIuVQuUotlJ0ji1QM5wZAKGNdRfe9tbuSFzxS3Vu4rXGfH7yXmvNuQd2Ic50ECPQhUvJWZ6yofOy6f+5s3mqUkh+xQ4h2VVBAkBEHbqU/jJjiFadfJSEVYcy8hiQz+x/fVCn1sSrwBrsfLsU81+AF/K0Q4QAYos/zjQKuKlYLygrNS+LsLvjHB9YUpj2Pub0L+a8j4zGD6asxSg27QRp8xCJzEAQ2sTfP/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q5tF4VvHpVHo4xmsfpGGphT2DQbSg8IRP9qO7+8u2o=;
 b=cEgdHHqaPqwvUSnBerLM60QDJSqddCOShjSXNlxRRdp8H6+F8vMG7877FTTVcEgYqC56LsFHR+Y2U4U7h0kQ0ceuTywSyS60VIGsV/zGS8PEuFBVysYkJZWQnXSpNtGG9jJ0tbBtEoo1HaputeYRyOzwlnhXmWt/FElgVmjB8aMQttFvPEcCu28jV4nC9EV8HTIBGfai2VvmUV9WWhcvZBm/n79Xng7vRgaK8fAyNvYwyPRPVDxU+nBSHcvAXYeahXr9uD1sm1z/1kPoDV23RHWFrQVXv4JWO368GjjQuw+iePj2e8anbG8qiyPJihMzkMPfY3oWzvkF0zzgOUOwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 16:59:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 16:59:09 +0000
Message-ID: <99eabc5c-f5e3-27dd-0a29-ad0cdb7b4239@intel.com>
Date:   Mon, 11 Sep 2023 09:59:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v3 1/2] selftests/resctrl: Fix schemata write error
 check
To:     Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
 <960b5302cee8e5bb0e83dcf20cd2ef4d353b7b0b.1693575451.git.maciej.wieczor-retman@intel.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <960b5302cee8e5bb0e83dcf20cd2ef4d353b7b0b.1693575451.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: c5359879-9de2-44cd-7f33-08dbb2e86a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUj9m1HnUk/Pl5yi79EwC9LaPFrB6vQvqP6Z/55mS9eJKv+7gTpnXj1mF/9Rvni5xNwmAxTAd/KPd3E5Ru4RCScaHYUF3rBiydjksXXaZLEPuz6scxD2i9lw1VDL/FMwj80/pn2y5frBPhF6aXieeDd0cu6pCHGHprL2TcJg1wlwOBU8m5RiAMJ28ebYqHjFqNqrzSgWaewzpfDUffmPBmdVWHdJ6pFB95/1+QZCzyej/q/ahmcdJ/KYRroJcoufYMfYOPkkHWDK+9VG6g1CVHSNAsWdF0hQOeFc/TDKOHPbhWDBiAUwJISRHnYpJKjdGHe++ZyOChUy4SU5LkGL9pBjsUQml0bvbiU+oObT4AftQ8zp22dW2J4wARryFjGIWonQXnlNvDabpm2+CWaw5XwKB3/C/ueJa+9qRrvPFR7MzheDgWnzRCBFzuN9unNNLyHJyq6vFS7KuBQLS6vjNKdAt8s0mUvNv9W9Cyaej/DXVNHTliCQLj8N479iT5lXqEQlIRYpzUl12K6Ny46yTqtIJedgOu0cmdjNXFoeYj92r48gCNt4rcin4Y9LLk5tYug2eOVaZF6cpi/5yLp5eD7673nlhGIqnZQAESUwPlU7eAfxZXYcgU5y3acJQ5bXMpN9O2KxLIeu2F+XL8XReg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199024)(1800799009)(186009)(4326008)(44832011)(478600001)(316002)(66476007)(8676002)(66556008)(110136005)(66946007)(41300700001)(5660300002)(31686004)(8936002)(2906002)(83380400001)(38100700002)(82960400001)(26005)(2616005)(86362001)(31696002)(36756003)(53546011)(6512007)(6486002)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmtYRE0xYjYybndIL3V0K05Fdlcyc3E5K0dvdklPUkdaMHpxSzcydFZDa05G?=
 =?utf-8?B?a1FxWUlzWTI5bUY1cW1sd1NWa3ZlUXRrUkRJQ0NBWlhJaElaeHNWd2FWcVpw?=
 =?utf-8?B?UldBSTFWMGE2Z1graG80bURmaGZzbm1XY1ZOelo5US92SGdON2prUjFTOFBz?=
 =?utf-8?B?V2pCL3B1Vlo1ZmxEeUVFbjNURjJyQkxuNDF0Wmc0YTlKTGNFV1RIQmNSa2xy?=
 =?utf-8?B?dmpWVnlVWHhqUzczVTg5cEdQT2R6OE5kRE1nalJtKzJkMnQ0b3BmMUkrbEpi?=
 =?utf-8?B?Mks1SVR1VGh0M1h3NDRtMXQvWStwUXV4Q1B6VnV4RElKdGtVRUh5ZjNzaHUv?=
 =?utf-8?B?VHRaL1Z5QjVjZnFUY1kzY2VJTG5DUStkR0pXNzMvUlBjWXBjNFl3MXVodHB2?=
 =?utf-8?B?QmhmOWxIQUJmRHcxS3BIWTc4NjcrWDY4aDk1V2Y3M0ptMGlTMFNHbFFTTjBk?=
 =?utf-8?B?QUFOa01OTkF0V1RwWDFzMFByT0Fab0hiYS9NL0g4M0FYb3V3Y0c5ZzNOSlFn?=
 =?utf-8?B?SlN5UGdQbnBraTVOSWpXTGQxQ1AzZUVNQ1ZReUFwUWZzR3NUVnF3dS82L2tU?=
 =?utf-8?B?cW1TWnJvbmVTM0VlUFZDVmgvTzdobjBLWmR2TXIzNEduaitET1htWTJXZFhi?=
 =?utf-8?B?elpGWjBSeTlGNUJaWE52N0hzUk4xUjdzSy9iK3I3OGViVjN1bnBHS3FhOTJr?=
 =?utf-8?B?cC9MWjZEL0lYNUtFZWY1cWljOGJubnFZRFMydmdRYXEySVdkTDJLeDRSdFh3?=
 =?utf-8?B?Y2tzZXlNbVR2NEFwdUpMRVVzOW5uT1NEUmV0NkM0dTBRZUNFNGQvcUNKTERO?=
 =?utf-8?B?dVN4RHBJY0V0anB5eDNiUlhqQis2SkhTeFRNMWsxTTZXdE1sUUxZRjdFQkxP?=
 =?utf-8?B?VnV1QmxXckJvSVRzK0NWajJKcTh0UUM5aUk0UW1UZEJPZS9NUENCYm1tamZR?=
 =?utf-8?B?L2c2MytJK3Jhdkl3RFJFdTVGdGtyOXZuL3pLQ2tmTWRja01BYnZYbktKUzMy?=
 =?utf-8?B?U0FPdGtiMjIvZE5BZG12NUIzc0U4VFd2aHk0eTZJVG0wT01ueWpuaGluMXYx?=
 =?utf-8?B?YUoyTC9UWW11MXlGaDJ2Tm5UZWlRWFRYdndnSU1teHlHSW9mQ3poOW1OREhN?=
 =?utf-8?B?Z2JLTXJSR2RuNTVzVmRKRjdEaGJLSWJzZWw3UUY1bVZ0TTRRaVpwSjh6MU1F?=
 =?utf-8?B?VlpNWHBWMmgxdVQwOTlSZ2puc1FRd1BXdURpaUtadjB2emwyaVBYV3J1Lzdy?=
 =?utf-8?B?THB1a2Y2cW0vWVN1aVpmUjN3RGhEeUlrSkNWbytnTnJyQ2dCUGJkS2lJcjlX?=
 =?utf-8?B?aDJ4NHAxN3ZQaDJwajBOdW9vYUwrRHNBRWlBc0x2UUR2Wk40bjlCUVMzOU5t?=
 =?utf-8?B?ckNueU1wYnprUUhITkU1c1NUeHZnWmdFOUZSdnlJNDFZbzRtU2ljNnZFRm91?=
 =?utf-8?B?TThSUVpUaHpzOWNEbzAvejQrSHZXUUtBbDlqT2VNc2hHeExUWHBMc1ZzeXY0?=
 =?utf-8?B?dE9yNVo2QlI4TERXT3RlVjFMc2NrcTEyWkdQMGsyZ3VSakJqaXFrdUVxQkpw?=
 =?utf-8?B?RG8vSU5lQ0lpT0lBSldxdW9wV3hwRDArM1dYaHRxS2NIWjBQMjh4Y1FybXRL?=
 =?utf-8?B?S0xYdENyMm5NV2FJSkg2dU5mQUFTZERqSlFocUNCWlFObHFUb29waS90Z3Rz?=
 =?utf-8?B?Q1M4VmZFSXFSa2VReDBqQlZUMjFYZ1B3aUY2TkpGU21aWDVHOGdudnh4ZUFx?=
 =?utf-8?B?aWM5WjAxNXIySlpNRHV1c0pvWDk4cEJoSDhwY1B4emJ2OFlNWnMrQzdNc3Qw?=
 =?utf-8?B?cktEWk5JV3FLSDVKRmNhQnBvd1RPWFladHhJcnNwczFFUEFPbkcxUFFEM3Iz?=
 =?utf-8?B?SnM2MzlxRE1abDlGenN2Y3l5elh1dnQxOHZPWng3aGpWV0hST0xvbVdlVzRP?=
 =?utf-8?B?VGFjSFE5OTlFZCtJN2dBUlNWYzJFQ21jdjQ4WnJqLzQwMG1hT3hHdFJOc3ZT?=
 =?utf-8?B?MlBTRjYvdHVvOWJleTVTRWwzU3VDSFF4Mk1LSmROZ3VWZXF1Zjl5VjgyYnFs?=
 =?utf-8?B?OWdWUlUvMS9vQXZUUEpCcy8yVks1aVUyb09HWEJMdkRndFNVc3NkSmdKWTdq?=
 =?utf-8?B?OW9saDZoU29DZEJPV0hjMHZXdU92dHJ2Y2Y2Z2I2c3VwWWJDN29NR21Kdkd1?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5359879-9de2-44cd-7f33-08dbb2e86a52
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 16:59:09.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoOUpJzUZuIN99PZBhXU67UGAXSrbjC+Yfo6BmSujVe4spWgmkNYR4xyTGNLXlzUPizEh8FmDlylM3ofDzGX+FaqmYqUTELtoIZKK4MR3A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 9/1/2023 6:42 AM, Wieczor-Retman Maciej wrote:
> Writing bitmasks to the schemata can fail when the bitmask doesn't
> adhere to constraints defined by what a particular CPU supports.
> Some example of constraints are max length or having contiguous bits.
> The driver should properly return errors when any rule concerning
> bitmask format is broken.
> 
> Resctrl FS returns error codes from fprintf() only when fclose() is
> called. Current error checking scheme allows invalid bitmasks to be
> written into schemata file and the selftest doesn't notice because the
> fclose() error code isn't checked.
> 
> Substitute fopen(), flose() and fprintf() with open(), close() and
> write() to avoid error code buffering between fprintf() and fclose().
> 
> Remove newline character from the schema string after writing it to
> the schemata file so it prints correctly before function return.
> 
> Pass the string generated with strerror() to the "reason" buffer so
> the error message is more verbose. Extend "reason" buffer so it can hold
> longer messages.
> 
> Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>

When I build the tests with this applied I encounter the following:

resctrlfs.c: In function ‘write_schemata’:
resctrlfs.c:475:14: warning: implicit declaration of function ‘open’; did you mean ‘popen’? [-Wimplicit-function-declaration]
  475 |         fd = open(controlgroup, O_WRONLY);
      |              ^~~~
      |              popen
resctrlfs.c:475:33: error: ‘O_WRONLY’ undeclared (first use in this function)
  475 |         fd = open(controlgroup, O_WRONLY);
      |                                 ^~~~~~~~
resctrlfs.c:475:33: note: each undeclared identifier is reported only once for each function it appears in

> ---
> Changelog v3:
> - Rename fp to fd (Ilpo)
> - Remove strlen, strcspn and just use the snprintf value instead (Ilpo)
> 
> Changelog v2:
> - Rewrite patch message.
> - Double "reason" buffer size to fit longer error explanation.
> - Redo file interactions with syscalls instead of stdio functions.
> 
>  tools/testing/selftests/resctrl/resctrlfs.c | 26 +++++++++++----------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index bd36ee206602..b0b14a5bcbf5 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -488,9 +488,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>   */
>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  {
> -	char controlgroup[1024], schema[1024], reason[64];
> -	int resource_id, ret = 0;
> -	FILE *fp;
> +	char controlgroup[1024], schema[1024], reason[128];
> +	int resource_id, fd, schema_len = -1, ret = 0;
>  
>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>  	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
> @@ -518,27 +517,30 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  
>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
>  	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> -		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
> +				      "L3:", resource_id, '=', schemata);
>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
> -		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
> +				      "MB:", resource_id, '=', schemata);
>  
> -	fp = fopen(controlgroup, "w");
> -	if (!fp) {
> +	fd = open(controlgroup, O_WRONLY);
> +	if (!fd) {
>  		sprintf(reason, "Failed to open control group");

It makes code easier to understand and maintain if it is kept
consistent. It is thus unexpected for open() error handling to
be untouched while write() error handling is modified. I think
the addition of errno in error handling of write() is helpful. 
Could you do the same for open()?

>  		ret = -1;
>  
>  		goto out;
>  	}
> -
> -	if (fprintf(fp, "%s\n", schema) < 0) {
> -		sprintf(reason, "Failed to write schemata in control group");
> -		fclose(fp);
> +	if (write(fd, schema, schema_len) < 0) {
> +		snprintf(reason, sizeof(reason),
> +			 "write() failed : %s", strerror(errno));
> +		close(fd);
>  		ret = -1;
>  
>  		goto out;
>  	}
> -	fclose(fp);
> +	close(fd);
> +	schema[schema_len - 1] = 0;
>  
>  out:
>  	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",

Reinette
