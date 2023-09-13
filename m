Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF979F35A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 22:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjIMU7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 16:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjIMU7D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 16:59:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD51BCA;
        Wed, 13 Sep 2023 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694638739; x=1726174739;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BA3KhmxqaQdNlZshxPBRqLKuXgRchnm3Tb0PIeMD0Is=;
  b=C3FH7D7FiGKpaSUXvH8Pn9Jux55hdAzRQqGhXnQ1bIniOXwXDqcbYKY1
   S3tx0DEI2AqfyNDvXL3M+HTzx0+yPeNokCfPRzqqUFSEgX5FVT9Adk6Py
   YLs10QMkjLjoFjMGajD0AamMj3T09DgJINMTkEZVKTaE6XSeHPkTazwD8
   kN8wvBCa1PfSwppZR2hAJqJsVA7txF2t7IZ7jdt6mtSa5DI4vEzpsE6Dc
   gdVdxQSowNvkdxxXzp4NwtTdGgkV5EqdFKbTYjbW94l+MagPy+0xruMEs
   hCn4Pc/BRMfqudGUGUeAD27DMkZrf25w3s2riJETUN8zUuvvxYQnIM8Ph
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378707590"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="378707590"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 13:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="867962481"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="867962481"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 13:58:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 13:58:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 13:58:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 13:58:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 13:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fC4NjKVCIc1hjvuswQuEqvdPPlCDE2qbFpj+rJ0dfGW6scm5VNFlCAU7TwvbH4de8KbqEH6R14cAuXvM7AcoEayvUlxo1XiuzoLQeoqu1TnaoaTPpIk7ZSDLj+Ok0cNAOx6c4uKFB3aP1wg+z5Dc6iX8+fR1Q6gTJAF5P+btUbW1U/KGDVyRj61fr7KQKsqx2bgdJxgbc7XRZ4cxfwUIO6dN9AaEjW7K7l0tCfQa1Rx9uupHDrHgIhB59zISjUZkcp06M9vvaG4LcgGFcd5nQnYIMEgVRyAdinYhKKFitClnIDxZrinkI7GtMtwoLZuum5+PDE5v1o+bZs33OYpaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BYF42J7fxc52W9wx3FZh1bnibgTFysEQoxUrC2MnkY=;
 b=lCiZr0H5cPMD1LxWdTL+ooNVG0fZzRImGvTYiGOHAsoVAQ1ruHxA7IFxFlVwoiXVs46cKY1BtVJK/vEwvDvlru/bt31P0RvG5CxnE0kGEwX7UR1detwuG1/hwNfZbABwlewaQhku/FEVVM6KGF+TbvS4sDAaulFjnf8bgIpFEh08F2QbwH1cBo1YAagk0RcUWaZsuoirPpYA6PdqLEnAgDEzB7ZCb5Gy03QWA0Q75OSBNM1WlILecTYGuC4fyxfruBd7F38iYcL44+N3WAWV18QHPyNHgG4qIXCAfmoGPww+Qm4PGpjuoP2sM2Dhr21xUj9MfsjoKu+eseP7XArQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 13 Sep
 2023 20:58:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 20:58:26 +0000
Message-ID: <fb32abc8-4381-00bf-c07e-b28066f51cdb@intel.com>
Date:   Wed, 13 Sep 2023 13:58:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 2/5] selftests/resctrl: Remove duplicate feature check
 from CMT test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
 <20230911111930.16088-3-ilpo.jarvinen@linux.intel.com>
 <40ba8890-32d1-e440-29fd-b8f8db69acc5@intel.com>
 <80695068-4a6-b8e9-107f-8d29ab3543be@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <80695068-4a6-b8e9-107f-8d29ab3543be@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0242.namprd04.prod.outlook.com
 (2603:10b6:303:88::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 4394be81-91b6-47f4-91b0-08dbb49c2cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRDDr7bjie4UchUPv+XlESsDFwLe5UtWkjmxbAx5DxdKJ1ORiTXMTxBHUOIE7DXwRDaEOKhO0pis1gWIKEkjMWv3W+M7xc6/Kij4INHdI5l6fivgTOs2ysN3FQiz30nkbnbVJMlU+dLWhttpeu7VfxbOYRoIw2celE/f7rQuwU1Gd58zfP6Y63A2WesMqOoB/RqsFPZKVSnQnBASnxO2rY7X/7mYVQDqbmDiuvm1sG21BXd1Xy6HLk4xmNVlwg8ntXxNFGlR7x6rfGZEg8hDyS+9wy83BiaX6QCQxiHERqQ3KYxw+JnU05Z5YCZHvddHwIWK8afqY5si2K1LgGprOfVnAWgLXYBlGSl4/EldFDMwk90+jepZTlM4BLRxrMiRbm2si4Db+odBHtwAKJDqE/qwizLe5JjyZOKwfSXwGGxtGKssnjqb5yf78pd1V2iFucXB0M32dckYLf8Z0id9aeMXHAo8vpyXcjWfhxtvYMPyatsTqNUIydigVLgY3jyVn0Bv+JrFpdgv+W2gbRLAD2w8DTOf3FV99gIobWOK5KzU6V9cS4mvgFb2lUiNBMKCJWKhykPZn0o3+AiT++ePreJ+pmBIavIraL1Y2i4qip0rbGkZ2OX9mpYL5lgp/8YF/fcX4BXY3xorWKpUIdPVuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(4326008)(66946007)(66556008)(66476007)(8936002)(8676002)(478600001)(2616005)(82960400001)(41300700001)(316002)(6916009)(6506007)(53546011)(6486002)(6512007)(54906003)(83380400001)(5660300002)(26005)(44832011)(31686004)(66574015)(2906002)(86362001)(31696002)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnA3c3lmN09jZ3ZwQ0w2SU5FV013MENTOEFvK0E3K3RteE1vMW9nZVdaaHZT?=
 =?utf-8?B?Y2orZG4vd2dwcGYxZ2xIZWtIcENQcGRNckFCZWtNL09HWStRSTJVWFdSVVNn?=
 =?utf-8?B?V25rcVV5SlhJeGJ0STFsdkg4alV2a0dPdVNBZWFINVZOTVBQQkpJNXBwVTg5?=
 =?utf-8?B?ZTlYRmRCZmlmUmNhejFkaktOUWpRVEM1aFVCcTV4Y2hPL3MxRFJocjZYWkFQ?=
 =?utf-8?B?UDZVMVNTdnphZktIa0kwYmJBTnJCZEZSZG0wd043a3g2ak9vdjNJN2ZZOElv?=
 =?utf-8?B?UnhMY3FyUXBLZ2xSZitZSjFvOGJYckVMNWVIdkVuMy9OMkJxZXh0dWdwWTVW?=
 =?utf-8?B?VVVaQ1NrNWpDOUNyS2JOcG50VFVrQk54S2hiVkViTUR3dm9ETEt4b095dDNt?=
 =?utf-8?B?OEduOG1Ud0lkQ0FXWEowN3p2SWtzR3Bod1owbEgwOVlqM0FOZXBRQWQ3K0h2?=
 =?utf-8?B?TzEzL2VaZ0xxTE4zTWJGNnh0VmVKeXBDcmxWNUNJcCsrc3hKalZwaktDcWxR?=
 =?utf-8?B?aFdIci9rNlRZUnZyMjM1U0VUTXZYVjVVb21kenh1TFRMc0didndRdU9MaGJP?=
 =?utf-8?B?OUVOY204SVhlOHNoeEhGS3dGVEFoUUZsb25hV2RLK0pSQ3VKQlozUGFyTkFQ?=
 =?utf-8?B?VHlXN3JYYkNPWUhERzNMbnh1c29JNGpQWVBMM24yVXBtaWlocUZJSDNEVFdU?=
 =?utf-8?B?bXJJZ1pJRHZoMTIrWEN4WHpBQ3JJVm9YYUl2YkFJUVFDRW01bnVMQ040czFQ?=
 =?utf-8?B?aDg5dHRBUkY0WUJ2bXdLa1U5cm05cyt3MjdmRzI5RHNoNmpVcUlKM0wra0Va?=
 =?utf-8?B?b2pDZ0twZERxK1lHSlFzQWV6aUcxM0dqK2lrUDAwZmdqT0NNUGVxNkpLSXVW?=
 =?utf-8?B?U1hPNEpHWmRTNEk0elI5bXk1azB5R25mSjRscWNjck9CcVFwbGlRbzY2YklD?=
 =?utf-8?B?UVJSenlUV0NCZk13Z3h6cUN2a2doUTUzaGk0cm43UC9EOHppdkJEMTUzVkt0?=
 =?utf-8?B?RkphRVJYVVZuZEcxUG1pbGpTSWY4VmNacUNOVVljV3UrcmRNS1dndDlpNGFF?=
 =?utf-8?B?aFBUcW4yNWxNM3F5Z0tIL0d6YTB1ODV6anp0VUNydmxQcFBZT1ZPanFVWmhv?=
 =?utf-8?B?MUpqbmFUVERNSTBSWUtjejViNEFHLzFLYXBUaHVyMWpyTThLZitBWjBUTDJH?=
 =?utf-8?B?cDR4SjBCaHlwdVN6K0JCajUxVmhrbTgwZXo2c1hQOVNuaWI0QUIvQUZLMGVH?=
 =?utf-8?B?OWczenVJQ1lPZ0syM0tjaDZWc01xcDlVWjJ4eU56OGFhZGhqM0FJdGt5dzFG?=
 =?utf-8?B?b0xaYkovekYwRTVKWDN0ZDU1eVhHM1BzbUI0bHc3UVVMYnZQbS9TT3d6dnFH?=
 =?utf-8?B?TUlmczc1OXpOOUNGNFprUFZZdVpYMy9CWWxITjRZR2hXbnQ5VjRpRThSdFBa?=
 =?utf-8?B?UWlIMUFsakYwdE9wKzUrMnJ3T3g2SlVYeVhXN2x4Um5wVmErU2lCY0p5bjFo?=
 =?utf-8?B?OUF6S08zSjhZc3owcXBvVHdpZ281eUtaZVg0UEkySEZLR0hkWXRvTE55QlZy?=
 =?utf-8?B?VmZEWTdHb2RWQjBPbDVvYi9aYVBPZ0thbVB0ODVRZVBZWFVFeFdvR2lML0FE?=
 =?utf-8?B?MURMR2JjVVJVL21rblUxVVlUZzZsUzAzWHRBS3lsVzc0dnJ0c1NqaGRaU2Vs?=
 =?utf-8?B?ZGpNRTdtZ2FscG4rZC9PN25yd0o1cHE0Rkh1cU4ySjh0NUdXZWFSZTRrai9S?=
 =?utf-8?B?NzROR080VVNlMFdoRXJxS3d0VHBhRjQwU1pGanhQbnI2SFJ5N1J0Ymx4alRO?=
 =?utf-8?B?TGp2VURjVlk0Qk91NWJJTkwzS1Y3VWMyUnF3Ti9sZWJDVEh2SUgwbDY4MC9U?=
 =?utf-8?B?cEcwOHdRKzRENkYyQ3pKanozdUZFUVFHZEwvVkpxZ0lvTkJBcjJKVi9Wbmtq?=
 =?utf-8?B?VDZxVGs2YkZtUUIxcWJ0WXd1c2xlM0o3clJ1OEtrcVNZSmJCNnBPYXVVSFFI?=
 =?utf-8?B?ZHJmMWtpNzNvZEFuWE9ucU9DbDRuUWVaRVd5cmM0S05GN3kvZ2k4SGd5ekh5?=
 =?utf-8?B?YmZOT3habXFoN3g1eGM3UnNydjMvQzRqNGJRMm5iR2xPTWxzN1o0UTNWLzJL?=
 =?utf-8?B?VGdvcVU3NFdyUDJjNm5xb01Fb1dFYjFzTEJxOEZYTk9QcUJhK2JCUzI3TStW?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4394be81-91b6-47f4-91b0-08dbb49c2cf4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 20:58:26.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qwTbSEvI9fAoEjwegy8jxCMFAljL9fdYGfn0hP3KCAq0Q6nBEehg3SkdZB4WvFZmJWorS0/HgiQF0TXFxKqBYGU/hIiZ8anQwU4e1atsNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/13/2023 4:11 AM, Ilpo Järvinen wrote:
> On Tue, 12 Sep 2023, Reinette Chatre wrote:
>> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
>>> The test runner run_cmt_test() in resctrl_tests.c checks for CMT
>>> feature and does not run cmt_resctrl_val() if CMT is not supported.
>>> Then cmt_resctrl_val() also check is CMT is supported.
>>>
>>> Remove the duplicated feature check for CMT from cmt_resctrl_val().
>>>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> Cc: <stable@vger.kernel.org>
>>
>> This does not look like stable material to me. 
> 
> I know but when constructing this series I had 2 options:
> 
> Either convert also this when changing validate_resctrl_feature_request() 
> or remove this call entirely.
> 
> Given it's duplicate of the other CMT check, I chose to just remove it 
> (which I'd do anyway). As patch 4/5 requires 3/5 which in turn requires 
> this, this has to go stable if 4/5 goes too.
> 

Understood. This makes it a dependency of an actual fix, which is addressed
in 4/5's sign-off area. This notation is new to me but it is not clear to me
that the dependency should also be tagged as stable material (without a 
fixes tag). Since it is not an actual fix by itself yet is sent to @stable
I think it may cause confusion. Is just listing it as a dependency of the
actual fix not sufficient (as you already do in 4/5)? Perhaps as compromise
this patch can also get a note to the stable team. Something like:

	Cc: <stable@vger.kernel.org> # dependency of "selftests/resctrl: Fix feature checks"

I am not sure though - I would like to avoid confusion and not burden
the stable team. If this is a flow you have used before successfully I'd
defer to your experience.

Reinette
