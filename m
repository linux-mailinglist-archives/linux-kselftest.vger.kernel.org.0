Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFF277CF83
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbjHOPsd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbjHOPsa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:48:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B84610C6;
        Tue, 15 Aug 2023 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114509; x=1723650509;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=enVH6122cHgpEJbEvUdiOa6EuDcfAkD9L8gOqTycCWc=;
  b=KN4qRpdf6B98uTtwxIc36KTWr0q9YdjqbnedXJtM/AOp2rUc7HEw2Rqr
   3QSKRgd4Kn3JqMqW74ozxoYJa8kqE3lsWdG/KviKx16ca5wtgTUPLd6Rg
   oQm6lC08s6ytE1mvw65dSH7fvZEsLd5iFj8asf7WQ99YDTmzYOx72ACKR
   +SXuqoP543dZh+WN2J5bNbKP8/JXoihaE3b5CXYFjppYvjKqoTrKWS1nI
   8i/fNOQl9gEcCdvcSDhjQ/yKBS8//zgFu87418efajbjLFz0WRfzzQe+l
   hEIFnI6xeYoNtApcTEEhGdXshL42dMlW+V586SluwhpdSGxIJiSoVDh2r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362459877"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362459877"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="733883814"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733883814"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 08:47:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 08:47:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 08:47:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 08:47:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib2fiI5JThk3lCh9yx3tCqPuQXQPQgkzDmwoEDh8CD/VutawCZhLQnXVly5juZba7KEFa8rns8M2bD5ujUrtUM6QlSefGiTvManvEG3/ByimOZsKkvYEju7zbq/FmSQVNMG3eqgQC/Vm1pQ03Le/zG0JUTnaQzBeURYjwKoJmmSQzFGndJ6XsQlKSf71NXY5QQw+fnYUKfOlRAQEmw6Kq8+RrnMM3mDs0I2Lnxhh3TY66eflGrJVjx9E44WBjnFWmE4xnujH3etJA31f7gOvxHkHS4gofkaRUiy6W116psGbuKV1FsxyBxq9SMOU+vQr63jRO2OGbBGhKCUJKMsEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc94wIQnrGEdPRW7uoiCqWeLHNYgtu3VETfy6tEvHDc=;
 b=YwaCbEWUDL+C9FpNHWXyW+p/peOmRYb31iSKiANz9OgTfsIXR+Ob8zbmTO780K4C8QqGylMfOfkX4idF+2aEvo0faZ7Nz10ER5TWU7l3XW2z4zkqlHiCxVZeHLZuGrjzcBT11s8wtEnxzbysGx7TWe1LnH7EhaA6iZ1/0WxxJqmU07vMLWIegRxNAuSw5n/0c9MS+uIYcb9DUASMwRkDGgLNgw9R2LQg+Qk9wJ1dNi43cuE/1FKavkmW0pO7OCk9rYugNhgvwPkh3TITIK55HbT+ItknBSLw0QIXhM3dRL5CbNnMw2DmFwAWS1ElnpeRh+Q66MygK4GbbMnvrPBj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7508.namprd11.prod.outlook.com (2603:10b6:8:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:47:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:47:37 +0000
Message-ID: <a64114de-0a95-4ed8-aa06-b30a948fee6c@intel.com>
Date:   Tue, 15 Aug 2023 08:47:34 -0700
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
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-2-ilpo.jarvinen@linux.intel.com>
 <9e56779c-4df0-654f-08e1-b27e0dd6b2ac@intel.com>
 <12ce6b7a-292c-6f27-809e-a7cbb810f596@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <12ce6b7a-292c-6f27-809e-a7cbb810f596@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:303:85::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8ff360-2840-4796-e2da-08db9da6f301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fo5SLM+VxVv9Keixao/pQucanqk1egUya8D6cDW8lTbdIzZ7hJsypO/XAwe5EHtGhNvzTgCxWJK9odmAd2baS8vMiXaORM4PN9PQFqbZxozKc4IC6PRhQgxWtOkkrWTAiEPzx3asGS+j/I76/ri5Y81oel+3OAt5mIGXW7UWcekxnBa8S3VFyYxoGDwUdsi2wbzNUTzlbu5cPp8GUXweJaGr5495wiIPlM9385W59IfK71p3hYO0nkhAJAyeeU3r1i8Fcn08WrQ8QorY/AwkNWN8iQxKfKoMNHyiHV1BWvDvbUt0v4VWHlKFDkQrWZyDQxikdSbzgbnuNwfEtkLF0OxGS2/cz61b5ws/1R+d7bLYZNrjczEJ54D2OO4yskBmVWhGEgKtj3wfEFn+HT5RXDnB+AghiaYpZPd+PgJxBgNjcF2dsSTKOeA10qSaXtShB4NWpvJQeNzsxAhtquUIptvxOvYLihuo2RStbyd/lHesRIzRmAzd9BYNXuPjoaMJCcMNiOhtQ1BGiJh+W7hTD4PbRimUEV2Js3mbWHm/LPCw0Ncu9+dvlAqVKC4TdfgKL6g1IIC/7t9o3+9XDxtRMhGpH50gHTdPP5C2j0FjvWY8nLFBQz1VmTXrP6ln2pP05cPUc2pk/kVrGe7DEGauJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199024)(1800799009)(186009)(6666004)(4326008)(6512007)(86362001)(31696002)(44832011)(2906002)(36756003)(4744005)(6916009)(66476007)(66556008)(66946007)(316002)(6486002)(53546011)(26005)(6506007)(8676002)(2616005)(478600001)(83380400001)(82960400001)(5660300002)(54906003)(38100700002)(31686004)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZ4QUdnaXNtemFaWnJleTdIdXFlZkRmKzdWdU1ic2YzKzd1MFNtRFlGM25U?=
 =?utf-8?B?Nk9pUUIzMXA5QU84R0l5TmYxN3VYOFVrZTNCanpNQW5DOFZrRDhRWDhXSmE3?=
 =?utf-8?B?ejU3S1VlQVgreUZiQVZnTVBqN0RHM1RBUXJPU3VmbHRicVREMWhJYi83MS9Z?=
 =?utf-8?B?ditwNUs5emN2R1ZXakFLQ04yTVNVbmFEbnZRZXdDdUduMkU1aXhTUGgvZGY5?=
 =?utf-8?B?c3BGdCtDUXM1Tm9hWkRuM3N1WndyM2M1TmhQd2tlZWhVOTJlb2pFb0huaHBF?=
 =?utf-8?B?TEJhd0p0MlhoMzUvQzA2cFZocHdjcTU4QWJhM29SUjIzait2Q1psRWYxRXZF?=
 =?utf-8?B?emNTTU5UaFY2Rm5CKzRQZmM2SlhKRFlWZDlVUHdhOGNxTS9vQURUY2hSa3dV?=
 =?utf-8?B?M1NZVGkva01RY0dKYzJlVW1aMnl2N1BXdTZjdWFzTks1MmNDVEIzMncwL2lB?=
 =?utf-8?B?UWFDWjZBQ0dSbGd1VmhIRmdaV3FDbEJqUEdYUjd0Y0M0WDRaUDVub0ZzZDZD?=
 =?utf-8?B?WGdoZFpJbXF3cGdKMGdXUXl0dTZtMHRSRjhmQ01zM0cyejYyQm91cmV1VGJw?=
 =?utf-8?B?Y0VMUGVBTjZueHk2NlVHdlo0MXE4WFFkWW5lVmlnZTk5Z2k0MklkVzFacVFM?=
 =?utf-8?B?SzRuSlRBTmRPelAybnBDeTBaNStGM0xlcGx2ZnpaSWVhUk16aFdMQTNVMXZE?=
 =?utf-8?B?Wm1mdytkRUNlZmtVdVplZGdRNE11KzNrTXJGa3lBcWxVSmgwVU9kLzE5UHBN?=
 =?utf-8?B?YzlKd2l2cHR2dVRlZDNiWDU4QkF0b2Q4TGxHTnlTTWdwcEtXbnpJTFpUSEMr?=
 =?utf-8?B?OWZpR0dqb2xHbVdRQUlxVFU4Ym1iS00wbU9SWkJNVTBNeGQxZFpCa1ZvOHRB?=
 =?utf-8?B?b3h4UUJ0c0xtMjU3QUJpclRxTGxRRnEwT2pOLytKb25rUE5VVGh2aTRLbHZG?=
 =?utf-8?B?RDk4WTQ1bE1INVlTdW5zVzJncW9LTEVabGEya3JRZTdxZmdhU1N2MXEwUmJo?=
 =?utf-8?B?VlBvMFQzdHdFSFpOdFhDNTA3Z0hYOEhHUk9udDBxZTdkTUpIQStWdG1NYUpB?=
 =?utf-8?B?UGw4K1pjc3Bmc05JdmtkZURkVFdrNkt6OHJVcEZIdmVTdm1zRXZBTXRqSVNB?=
 =?utf-8?B?cGxtZmxXTURJd0RDazZvSUFYbkdrMFRlRnNwY3NPVmtjallEc1ZVV1hXVXhs?=
 =?utf-8?B?RFFKS1JENDFqR1VPTkVLSk9ReXAyc2RJd0dwVDR5YzRPVE11bzc2MUtOQnhx?=
 =?utf-8?B?aGxqSDM0ZkFhNVdDY25hUE1EWDkxbjFQaVNyWVd3WWsxYnVPZXJMOVZEQU5n?=
 =?utf-8?B?WnlKTkhBcEZucnZtUnJocUE2RXBKR3R5a3ViQ3lSWlV3elE5SG9zbTdsM2Qy?=
 =?utf-8?B?MGVSRFNxRTFFSUQ1RFZmNnNRd1MvUUJUVnJJaUpzS2UyTkJTRVd4dVRFZEkx?=
 =?utf-8?B?Zk9XQTRRdUYyV25keWZKenJTVlpVeVEzbHk2amMwamlZR1pUaTRNL0FaU1dw?=
 =?utf-8?B?cWxUS2o3bjJGMTZmZzR4VmJmZXlQVWRHSVZMOVZlaEd1NnNhckptWTIwUUwy?=
 =?utf-8?B?cWxtRHltVnFCZU1UNTI0WDViaHVoTHRCaDg5UkttOFVyZnRVc0FEOUxVMlA0?=
 =?utf-8?B?bUVPZVBERU9RdUF3Wi9uQ2g0bkRQcUd1MnlGTXhJTkx2aUE4d1RYNWRlYUN3?=
 =?utf-8?B?bis3Uk5OV2RpZ0FIQUdRQWkvSm92MklpNHBvcVVnNFpNTjFUdE9HaUVFcmdo?=
 =?utf-8?B?ZjFpSzBxalBIYTk3TUp1NkdwYmsvMEQzR1VvaGFmdTlVM1NBSEtTTGNOdnQy?=
 =?utf-8?B?Y2lJN1k5UVIvWlhyRzE5ZmVhV25rOFJSRlVOa3dnMjhqRFU1aEd4b1JEcTlB?=
 =?utf-8?B?cVJVMU9MQ0JiU0UyVmlEMHJJZlNxMXdyZkc5em5GNkdBVmVBTzFsZkl0eDZV?=
 =?utf-8?B?SXlUeUwyOGJQbExMZnZQZFE2UnFZd2ZhZnZPR1lNcm84NGVIOENrc2N4MXV0?=
 =?utf-8?B?YklmeUZ1TFAxM1diMnBMdmxidlFCN1pqRy9pRGdDeC9vQkFJZUpjVTZ5TFpC?=
 =?utf-8?B?ZExyVEJpUjJvR1BiSEI5Yk15L2htY0VweUNybitSL1B6dS92VjlLK0hodTAz?=
 =?utf-8?B?em8zTUkvSm5kZUJjUDVBeTUyRHpxN0FEc1R4bkhMdC9kVk1GWHlhaEJBRjk1?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8ff360-2840-4796-e2da-08db9da6f301
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:47:37.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/FV210mSqmAG6Xt2AKQhvfnr9gZvKR+DCad1TOz93zbALRM9SDMxgwqY8PReGFRxncQSBk6wcD4m61e2o+9E10fjYolmAts/THHLKV1I2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hi Ilpo,

On 8/15/2023 2:10 AM, Ilpo Järvinen wrote:
>> ps. Unless you have an updated email address that works, could you please
>> remove Sai's email from future submissions?
> 
> It's auto-added by git send-email machinery. I guess I can try to make 
> an exception to my usual workflow by sending only to manually specified To 
> addresses (if I remember). Perhaps one day I'll write a tool to filter out
> the addresses from git send-email generated ones but as is I don't have 
> one.
> 

Which git send-email machinery are you referring to? If I understand correctly
it does not automatically pick addresses but you can provide custom commands to
it that can do it.

Reinette
