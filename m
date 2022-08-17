Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E411859735F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 17:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiHQPyE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 11:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiHQPyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 11:54:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E84F4D4DF;
        Wed, 17 Aug 2022 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660751640; x=1692287640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hbiefLoSQVZJKoVxcXdARJ82U8BYe1cCcZuXf3a/bT0=;
  b=UANe+iTN/c2ThpFFbJcVTYW6jGWCXVuI/IGf6plULf7VbwGSZzF8AM0y
   QJtAMPQYhJQNPfMU2d4Qk64bnX700BRm67Zri9qQNs+DQx+gdgJwbKeFF
   fusxVdzowS822TtEW+9gvH/i5dVWNcUrS0lW5gJc9Hm/ghk2LDQu/2jRe
   srJ1GYwUKb9lK1rcJzx0Kzt2FQ3mlTJx0yRSvM6eTLJuIGPEUxRffGQ5X
   6kYVL3F2wz/c6SfHRl9Heu/9chYgZvAoSgv+HWhJb0hORSATTq5KOsfUb
   Qu+GORfxTcpUyiUjGs82YetJ5lqB0JJik/nsaNP3kzBqaEqaNivpZhKoF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="356527898"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="356527898"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 08:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="783458734"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2022 08:46:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 08:46:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 08:44:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 08:44:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 08:44:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0dheDQUxqDhpmCq48/Pb9uiVyJI/6NQptJ0lZiGAxCDSkd6fvWVoEqQ7nSchUFdD9muzwSa5X7Glf7JFH7WYv/tj2ZXmZC3Muh4AnMQJyVL9u76+ESYVGy4NpYHHF0I4nzH7BhuEmznwhwNY7HVnxzlSdIapMdYAKQe/OA13vBab4m61rTqe7GCl01FEJTTY4nC1ujs8QVXGCyGRDyUMe2Bxm2gNoyO01xT1/eTHhb/Ggr5hTgp42ucqadCxzlCQZKU7JrP9nIjsAvAxNOGzDYZFh74dBxIvKe4XfbUQaX0RsQRE7AbgwaV7UAaNRUiVXuxTQ0jQUPBya7Ru46cVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXLaso18QC19rQUILKWyKOvOH92N1fyO6evH9NxM4eM=;
 b=QJMRUwNTz0FHEavvJytbwPIWJXIXcGF/4BFpVF4X4UaLupwpDrTooH3sTZg5zKhF/0sG1uQdds8VtwAsMMgkybHY4xlXlRzAc5NiFf+89hgXUZZA/al6TAtrm3D6L91EHrPbDH44ms5h+gZeD4R2DNQQ1dQ543gj26zGY59IhJbKxm88cGKASst1GvxPnCUxKKPOEqT/g+551B/acowOg3GWEcN020sxSiT+Nfn92uuT0piaz0ASkkB48QglLe6m4PLxCsYWznNKB2tTb83DUbSLGEDWC2pKAoUrUMvlNC0ZJLzt45pwkwf2P05p7pZaiB8uP5HPU6iNgKv9h6pw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN7PR11MB2866.namprd11.prod.outlook.com (2603:10b6:406:b5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Wed, 17 Aug
 2022 15:44:00 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::1cf8:26d2:e93a:9aad]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::1cf8:26d2:e93a:9aad%8]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 15:44:00 +0000
Message-ID: <69a5e350-ded9-30c9-dc41-d08c01dd05dc@intel.com>
Date:   Wed, 17 Aug 2022 08:43:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
 <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
 <YvwpX7pYOW3Jv+vJ@kernel.org>
 <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com>
 <Yvz+yxnxp8G6KzHi@kernel.org> <Yv0A5vjd0OIfxxfT@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yv0A5vjd0OIfxxfT@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:254::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e92c12a-b02d-4a25-b1a2-08da80674de2
X-MS-TrafficTypeDiagnostic: BN7PR11MB2866:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFjVAwybjK1o8pza+BqxY161m8L2Ywfzyvm8rweZ4/q9cvyXSCNTdDUJ/nPiJf/Lnehk9Ho+aAMJGsgVvwtLOtjKHXQCJEtUC05jXYgpa0WzkYk5E8hLYc+iud7nLXPToOyuPBr4ZDxbxNZJaRe88bODQS27ZYW9inI05M71DaxjYphg+VPuUA2WtPKEYdttzBOzukLhxC3p9rQNoDNLHJ8ytx+9cUihBfNjymJ2cosRD7ymfmcpyfpUkEy7/VU09rw6PaOKqjqh2loPW5AVREDhgljksZxWy1BqpvPJM6pon3yS8IYbjI80+f99Iy0lP1m/PidWcX5Vja021pzBAlguVrafzLMk2ngCpQ6JlDUDFiWdAw31cSR/KVWQmCql0hsxgh4zlnik0JKrCHAbWMV5T75ixmTPiVy5D8d8R6IlgjHwvDsmcni/bcij5vNTmXB6A83Il79ddcsnSbd8ZvixY35cFIi8q0PSFSE/WRTlFkdWkF4WPtu48X4W5FXcPtDsKGaFy7fTlT+gM5vzvMIAJeqgLPLYHlqGI4qFTsSitxKdHhHh3DShfqP3fNbJv5obl6/SCYuPam8k8oLcoKIVDgK+B+fud/jV8PMd+I6Sx3enk0hdZRrwUb3E5OuCSdIUGK85VlseB+9U3Qf1kKXuekJq45O5oSbmA+0btipx3VkPUsd6Xp9LUEaHg+WKZ7jMkf4gENnUZ9d55lSgWN14325S5OESzKq2NJtJZAeDqpAntxmy0lDhkkVNNCXiOdcT+yxU0oi0NYsxpsn5o8G3/4M3fr60wbYf72nhos5eJEc/GNUaytlcddC6uZc/aJCl7Ua7LGpKkbuqx64CbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(39860400002)(366004)(376002)(44832011)(31696002)(2906002)(41300700001)(6666004)(478600001)(66946007)(8676002)(4326008)(66476007)(53546011)(316002)(31686004)(6506007)(6486002)(66556008)(36756003)(26005)(86362001)(6512007)(54906003)(6916009)(82960400001)(2616005)(8936002)(5660300002)(83380400001)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elZ4ZUVMcDkvMEphb3BYYTFORnZBZVlLQk5FbnpyY1NqOFVmYVVSTWE5QWU0?=
 =?utf-8?B?UHllaThaV3NId0hGRSt0N0t5a1EvWitrSTBBaVhzbm5JWEtyTHlObHd5R0U1?=
 =?utf-8?B?emp4VUNnUXJOYkdjcEoyRGk4aFQ5QzZtZmpvZGNvQjRUS3l3SUlqbldRc2Zi?=
 =?utf-8?B?Wm5VQ0g4d0VLcTFxa0hSN1RYVEExQjEwOCtDZGRBMHBrZUZaejF5c3JEQllt?=
 =?utf-8?B?ZlRuNGI1WnNTcENYZXNGR0NMV2hXQS8wUFRSVnZXdVRtWG1lN200VmJRbUJw?=
 =?utf-8?B?aWRXMENZcWF5cnUzOUxCTGNuNlhNYkVzZUxnMFBpb0xOUUpDMDVMYUR5cjBC?=
 =?utf-8?B?cDhGMEVVT2dDQUlsV0t6WXdBSjEzUVBXT2VEMWtUSmhsL3c5M0djZU5RNjRz?=
 =?utf-8?B?Z0ZJOE4wSjcwdk5DV0xuZ1J6RU9qd2RuanVaem5DcUswU21NbzFwejVrM2M0?=
 =?utf-8?B?VmpYc3c5R1I4VlpGZUJPL2xyVE1uMFFMbWhxdHEwNHROYmRPYmZnVnZsRURV?=
 =?utf-8?B?WVU2MTdxKzg2YTM0dzVuUzFoc1ZmZE9SWXJkMTVLTUhsNVlPZG5yeEw0SHZM?=
 =?utf-8?B?UUprMFd6UkZHOHJXbWlraU1LODJINEpSaVJlYWxHVkczNk9CR1k4L0l6ellp?=
 =?utf-8?B?MlYyU3NTVFBKZFVWMVBZN3F2dEFDR1pzYW5oOWpscFBNWTZSWGZvb1hnOUdx?=
 =?utf-8?B?aW9TWkRVdVRaaXNMakJSdHh5QWR0Q2NqZTl1ZWFvQVVMdjhZVVYxbmZ6SFU2?=
 =?utf-8?B?Ky9jL055UWNxclFmdjZjQmNhN2plM0NQRC80SlI1TnRtbnVseUc0TWxheGwz?=
 =?utf-8?B?d2tBckl3TXpQZm1UaXRsb1d3YTRUTnpHa2E0aWJKVVdSZXZMeVhWbUlaNlJx?=
 =?utf-8?B?eTBBNEQ1cEVuMXlTdlJmdE1qN1VUMzRDTnMvMEFhM1MrM0tldG41bzh2bFhT?=
 =?utf-8?B?Qkx1SjhiTFZERHpJRVMzdGVJQVJGaUR0VnBoZHIvWjJNTnhDTGhHU3BMNVMr?=
 =?utf-8?B?dDYyVkNBYnBUb0orVXl2alhYNTVGd2l4OUZpVEJGaE9MMG1IeW1lblhMSktv?=
 =?utf-8?B?S3R3djUzSkRGaUJBeStNTyt1OXlsMTVmTzJDTnYyUEtqS2Z6WG9jemlGalpo?=
 =?utf-8?B?OVYyc3UxTElkVnZoLzhCNXlFZXVOMnJHeWsyUi9xdE85aEdlUmhuc0VESE5x?=
 =?utf-8?B?Tzdqa3ZWN3NHZmtRU1ZXbW5veFNzNjcrS3FaSE5nNDdzd3VQeWhlYmtiY1Iz?=
 =?utf-8?B?cC9lbW5DVlo3cGd5ekh1VVRMMEYxcmloR0VSU3JGclFGR1pNUktVUlV4RSs2?=
 =?utf-8?B?Y1Bwb01NTStZRzFNNW05WFgrUEJuak45ZlV2L1pmNXFiUVJFaFBjaCtIc3lV?=
 =?utf-8?B?Z2hDR2NGLy8rR0lRL2RTZUxTMkRCR2V2V0tkazUvbjAvU05tRXN4MHc2N3NI?=
 =?utf-8?B?RDJmUGdUMEpPODh0ZU5RNTFldTRoYTgyajRVaUIveERFcVFieUU4L09lVmZF?=
 =?utf-8?B?M1cvRXFNbVlIRHhKb3hMUnhBRTU2dUIxRnNBUENKMUxSZ1NqS2twRTlrbXdz?=
 =?utf-8?B?Z3VJa2U3RS9Lc2xwbHFFeHdBVVdYeDJHUUdteTRmcVBjbnBhaHBzQ2RNUTl5?=
 =?utf-8?B?VHdmVDhoUFJuR1ZjaForaEsxMlczNHhWbEx1OFNCMVRvV1N6T3NBNjlUOUlo?=
 =?utf-8?B?dmU3OVpUUmErbHROWlJqRDg2NDM2REUxalBVOUFwWFlNMExmUmFWaUpvd1c1?=
 =?utf-8?B?NXVHUUt3UUd1blRJQnY2YTRvTlZnenFqdGtEcmpCWFR1bDZMK0R4K3lRQWNN?=
 =?utf-8?B?YVdjUkt4akp4bVJlRFQ4VFR6SWJ1VUM3VEtSSUwzc1BFU0xxZVRUcmk4SFRn?=
 =?utf-8?B?VjRCSnNhQjQyRlFkRnFKWGpoVDBoYWErM3Bib1NSdmErb0t5cHNkc0NJR1lt?=
 =?utf-8?B?czMrRFhEdUJqM0dHNDNUcmFZRWlsYVh3clR1emMyQWdiK3ZEb3J1eXFBa1Mv?=
 =?utf-8?B?RElYbDZlWXh5V3RKdTBHeXN3bU4zeWZxOUxDOEt2dGNtSkdERzVRa0dGQWY3?=
 =?utf-8?B?anNTb2JmN0hLNENHQWNFTHRMTlVxR25wWGdwWlc3YXU3ZDJ1SW1UMHhURjFC?=
 =?utf-8?B?L09hVW82b3dtaXZ1czBrOXJGU2M1L1pWTDZMbUZNQ0ZzOHc3S2txTHN0MmhY?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e92c12a-b02d-4a25-b1a2-08da80674de2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 15:44:00.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKCLKTq8ilmJN3oqpcibKNphBDJxMDoEccDxfxUiUrhJ/HTx9KYfGHy1pY3CW6rxa7PRKEl5HFmGg2ZRidVhOia/6pbLrjWBhc0VEHkp8Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2866
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 8/17/2022 7:53 AM, Jarkko Sakkinen wrote:
> On Wed, Aug 17, 2022 at 05:44:31PM +0300, Jarkko Sakkinen wrote:
>> On Tue, Aug 16, 2022 at 09:35:27PM -0700, Reinette Chatre wrote:
>>>>>> This portion below was also copied from previous test and by only
>>>>>> testing a write to the first page of the range the purpose is not
>>>>>> clear. Could you please elaborate if the intention is to only test
>>>>>> accessibility of the first page and why that is sufficient?
>>>>>
>>>>> It is sufficient because the test reproduces the bug. It would have to be
>>>>> rather elaborated why you would possibly want to do more than that.
>>>
>>> That is fair. An accurate comment (currently an inaccurate copy&paste) would
>>> help to explain this part of the test.
>>
>> I would simply add something like:
>>
>> /* 
>>  * Define memory pool size big enough to trigger the reclaimer in the EAUG
>>  * path of the page reclaimer.
>>  */
>>
>> Suggestions/edits obviously welcome for the comment.

The comment seems to better match the code below than the area referred to above:
        static const unsigned long edmm_size = 8589934592; //8G

Even so, I think that raises the point that this is platform specific since
edmm_size of 8GB would not trigger reclaimer on all platforms.

How about adjusting it to:
/*
 * Define memory pool size big enough to trigger the reclaimer in the EAUG
 * path of the page reclaimer on some platforms. This constant has been
 * successful in triggering a bug on some platforms (independent of the
 * platforms where the reclaimer is triggered) and thus considered
 * appropriate for general use.
 */ 


Regarding the area referred to above, a comment like below may help:

/*
 * Pool of pages were successfully added to enclave. Perform sanity
 * check on first page of the pool only to ensure data can be written
 * to and read from a dynamically added enclave page.
 */

> 
> I wonder if we could put .bt files somewhere to make them available. In
> root causing this bug bpftrace scripting was the key so it would nice to
> have them available along with kselftest.
> 
> I could imagine that we end up also in future to bugs allocation so
> it would have the script when you clone the kernel tree, and possibly
> more scripts in future.
> 
> E.g. add bt/alloc-error.bt under tools/testing/selftests/sgx.

Thank you very much for helping to debug this issue. I also think
the scripts you created are very valuable and making them easily
accessible sounds great.

Reinette
