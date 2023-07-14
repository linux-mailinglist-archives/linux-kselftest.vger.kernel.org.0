Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A175275408F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 19:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjGNRid (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 13:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjGNRib (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 13:38:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636AF35A8;
        Fri, 14 Jul 2023 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689356310; x=1720892310;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ol0kT3P+/MXewRMypmgXRdlG/W6yYiIraoRnp2rD8aA=;
  b=IHnz1DARnw0l4LbOtlz/ZZ5X9y7MgtheLvf4mJ/t2FNWJ4FeyxXMyoqf
   uwJH3eJfXyQrcEROZ6DLGXngshEyV2jpVmNq0m8M01ju+kpaLWk/QykK8
   X+AOICiJOZBA97gUQq5Dnon/Z42mx0mnGtfeRhh80fNN2LK4QIuFYNsfG
   3CLMz09wfVuukYUOMz91IQ+unE9cVVi5GA65T31pkQowY1pB3bGBioK0k
   ySx6oMH6JdGCn2ICWe06jtoqd+iZlXKIwxVb2EsC3E5F03R3I9I99UDFQ
   22rQSCGDsTpYYwHeSfR6foC8b19c3VFP0EQq+U15RZfZbykH0XkFoIocS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="355471607"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="355471607"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 10:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="699754891"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="699754891"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2023 10:38:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:38:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 10:38:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 10:38:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 10:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvpY5U3o4L1iVGSr1npFxBYTijoNpyTrjFlmSsQrtbJljGLWyems7sb+kQAgrNxsJJfwLdN70vvuaDOV/TajqbVWXOkw1gLrnAHqdXqV53xXDMUhP+V8dPYRbzFD+Xjt5YH5dhOFvEHeXvUOT85Qihc7eaBn2NNvxqmeFnq9ba+n7XTQxW92x32fJWMqXdy6PGBm88fgQKCeOHzpdA+hQraJYP4rySs+pb4X99Ta5SUwwOko0yEzWYI9L4W0eeexZKBtvqePse3v99/7S6zGSV9HJYKg06oAjjT/FWCIWtWqpsqhLt5NeLJihpbQiDEXYoRXw3msa13ibG6ZG+bKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zbQj9Ssl/jgxjGRu73uneLzIZ7k5L/8v1ZqnYUUO3Q=;
 b=BuTnsF+SYunmYDbp+NG2w7bDiTbpi9lqWhACJrgQWSPtPvtLZIuVQnCiJwM+Xule+N47fMC797YBkBt278Pb9LbAl31gs4WtIkZY3EZRDG/hykjPFRtP7CUlxIlUL/bSfF4WHmQ2dLTOZIo/pOsRgigTSWe/S/hJdxhmEhykKPo0evK+3tnU3JhX1ah98+7viniR1vOdj6knd3uMBASFxiXL/XMGyvApP+G5aDBtXlvPH6ycEPrqQW7pYaeN1ElP/4cqDzY3xHxAJOBA1k6hZhV/JUnndilgGvoXl3vm+HdaloujPi/EMWGcm6kMdDJGf0URqL0tfcu9RNAqrqufEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7398.namprd11.prod.outlook.com (2603:10b6:8:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 17:38:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 17:38:24 +0000
Message-ID: <f1233835-8c94-e110-531f-13712569b7c0@intel.com>
Date:   Fri, 14 Jul 2023 10:38:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/19] selftests/resctrl: Express span internally in
 bytes
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-11-ilpo.jarvinen@linux.intel.com>
 <1dd10447-b03d-937a-fe55-ff324864c358@intel.com>
 <0c94daef-3642-9e8e-0e8a-3f8eaa2953e3@intel.com>
 <fce81fed-592e-16ad-b833-735a7b3a186@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <fce81fed-592e-16ad-b833-735a7b3a186@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc996d1-ec15-4c8f-a548-08db84911fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yh8csiKMe1tpV2nPlrJpp9TO3BwJ6OWMo+hBABylY96CielXN9+UTOsqZBjMvmu7fnNXjVKhvK7MJXmM1osKDuiQZ9Rp7ezt+DXnh4eRD4sWoKUI6DR4LAnDPGWCHN9dgr7Vt7YzlhqIsn9OjWkocUBnWgNk0KgXbde+/YT0MevlcpmSqRzPXqe+OyTKei1oXEOnUhtDAEABEiuGQnb4wZoz8RI1NsadrVTSF4T1g24FBn6CWnwQIgivWdK2anZsd+8JCHtTqE39OciqhuNJ7vaJ6U9VeddatyX5qiwoHmURBwiko1feyZP/23IAs4Rfpt/+ZMJ1o703hVLiEHJ3l7vbLX6ps4vNIdPwfk29w32JTUEUkbmCAOvQ4U+WRYS57ddhF7WnH0bHd7i43z4AiTtjAELuFUgjufup2l/sdCWc34HsKQxdGdGNGqBo7tDiXm2FlPJu+dUJ3yMNuFPO9xxJV4XolzINw5kVUfe421YHqxNU1GCtK+6rMTjy6ZsKO0itSCNJAPalUIZD9lfsuTzVWpj3uMhvyE1DfOwt4wKCJ2aaNY3TRsFz2l+Q8PTToRwPSOWIgke8UI1xeD+Gz07lDby0THcrZ4u4+fhjW9ldZYpDl0Fc+mmCpn9mpTsESVNIdFIebDVP645zQep8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(6486002)(478600001)(6666004)(110136005)(54906003)(186003)(53546011)(6506007)(26005)(6512007)(2906002)(41300700001)(4326008)(66556008)(6636002)(5660300002)(66946007)(66476007)(44832011)(8936002)(316002)(8676002)(38100700002)(82960400001)(86362001)(31696002)(36756003)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmJnZkFlbUdQRHltNk50eVE4aFg4R2I1K1NvaG5TaWUwMVlYUlA0WFp1ejNu?=
 =?utf-8?B?c3ZsMEJwMDBQaExDQVZpSHdDTFFPSXVlc1Noa25LWFpMUWl6ZUFmZC9aQTl5?=
 =?utf-8?B?UGUvWGJ3ZEZIblQxTmkzNnZMSnNzUDNPbjdnUDJpckV5R3VDMWdYUVlkTW8z?=
 =?utf-8?B?d1J0UDhWY3dxYlRzUCthZFV6Z0tqd1pBZVhNOHJrOWJzNm90NGpCMWlacXZz?=
 =?utf-8?B?V1JzR21sWkwwRytTTWtMZ0lMa2NnTnJYTS9IVUVMQXU3c2NvRmdXQUEyY2pT?=
 =?utf-8?B?dFp5cXIyZ09TMFRtY1BERlFBU3dSTXc0TEd4dmFkbDV6LzFjQUd5b0U0cHVk?=
 =?utf-8?B?cFI4ckxud21nQlQrUWxwSmZna2Rqa0w3TUxuUXdvRGY2S09sQm1MY0xHYWlv?=
 =?utf-8?B?ZkE4eUkzRFZyVEgrdjlKb3BodTVrc2FDMHBMNGl2R0lzSTJQQ3c0YUJrVGNa?=
 =?utf-8?B?WW5NTjJxeDZ3VklCVkpiUTQxUldUSHFtTy9IeEQrTGFBRzRYUy9wSjI5eC9a?=
 =?utf-8?B?aTNWR2dHY0F0S1g5NXc1QnZnYlF3bEJFc0M4cWEvVk5YYWdydkllUnkxN1VD?=
 =?utf-8?B?UGFxVzJyd0syVW5XclhKWW9kUzh5VXBhUDA5OWUwZ1hoK0ZyNndVVlRNOEcz?=
 =?utf-8?B?QkFzdWVtKytkeTNoRnJsOXV5MkZZaFVCQjdJTlhKZ0Nma0VvMUJKbFY4V045?=
 =?utf-8?B?U3ZiWG0zL3k5RUlQT0Y2aERFUXp6R1Z3d1oyL29hVWxTSTZia1NMNXgzeGls?=
 =?utf-8?B?bDBjUFV6MkMydTVLUFA5WDNLekh4czBCR2x1SS9OQi9xUnhOUUZGM3NhSzE3?=
 =?utf-8?B?L25WWVYrelBVcXF3K0ZLM01sUFJFT2Jid3pxYlphRkc0aFBuU1d1UVBrY2hR?=
 =?utf-8?B?RnpML3UrcHlrQ0lnVWxhVC9yeldCbklyYTFtUDA2Ujd5TmxRYjFFcXdWQXBE?=
 =?utf-8?B?QzMrNmFlVVdRc1I2TDRZTVBLRGlaUEY4Vzc3WkhVTmp5UFFXM2JMNHoySU1u?=
 =?utf-8?B?cEFUdm5NT1Q4RmZOQ1ZUZGV0VUdubkduNnVRaFJYMGwybHhZaGhwTUJkY01P?=
 =?utf-8?B?MUNQVXFaRWxEYllDZnZJTkhiSXNoMnVlemxoNEU2eld2SUxGOWUxcjJWa1VE?=
 =?utf-8?B?OTFvVTg3WGJZcmFnMTUwTTNSdzltVjlVVmUxeTEwWExGejEwamthLzhmK0Rn?=
 =?utf-8?B?Mm5RSktYUHZJUXRRazA4d0NtbmlCaGlXOW1LcjRkamJlRWlGd1VWWlRCblpr?=
 =?utf-8?B?VVpETDUyR3EwQWIrUGx6SUZ1UlpCSXpxTU1hK0lPR1kwa01IOEVsRmc0K0ZQ?=
 =?utf-8?B?eFJOeHlMSjRXeDY0YnJ4U3IvWisyU0FnVm9lNm9rcVdzQXY4ekdFZXVBcGxX?=
 =?utf-8?B?SlJZb2pNaDJwd1VpVm9JQVNWS3lHd00wb2xsbWFVUlhYdVRCaHFiM3Roa1Mr?=
 =?utf-8?B?ajdmVmdnSWFkQTJrTjhFZlhhMlRqcytXS2EySkFXV0JiT212TzJTSndOaGdw?=
 =?utf-8?B?RXFYVU1nVjc5OHU2S0tEQmV0R1pPRlE3Zk0zYzJaeVpYMHZvQms0R1hjaXFH?=
 =?utf-8?B?NzZyQXR0eUtYVnBWSVptdjBGRkdjL09Nb3FtSFg2cldkNmNNcG0wOWowWFE3?=
 =?utf-8?B?UHpKSEtYc3hEZmRURC9EQXN4SXZQMGhpU2Fva0owVm0xdEdyOVNpWEkxdWNa?=
 =?utf-8?B?aFdmOEJzZ3d1YWVtVzkrWEdmMm9BQ3pmVFFac25ua1haaHNRWTJqaWwzUGV2?=
 =?utf-8?B?QldRR0tobXFmUkVlYzJ5Mlg4elYzZGlBV0xtTG5jS3BmQjY0QW5lVzFwMi9t?=
 =?utf-8?B?R0NwVHE1TXdLbTVteSs1R0tMTE1BY01ka3pQWnRjNnNEbXlsbzJKNkNDSmU0?=
 =?utf-8?B?RytiYW82aEZGd3FWMFhnTXl4ZmRDR3BDV2x4c0NCY2d2MFN6aG1PemRHRlhM?=
 =?utf-8?B?aHZpTldKM2RJOGZ3S1hZcmJnYThMQWJiN2FTR05QUTNoelZIQno5NTRTZERw?=
 =?utf-8?B?ZFRRZW1mVS96Nmc1c1oyODVINUxEZkx6UkE4bVJFSWlBSHUzSU0veFdqODdG?=
 =?utf-8?B?enhUR2MrRUJQa0hETVRtVmp4ZGZ6U0xnL1lLS1dtdUk0MEI2dVRZY25uNDQ4?=
 =?utf-8?B?ZlRFekpBNklOOVRDbTVQQlBKaEZXdldtUnhXN3N1L09FcFVKVDBFbHdSejg2?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc996d1-ec15-4c8f-a548-08db84911fd4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 17:38:24.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rQZLELNVmmF14Eu4irT8Z1L8KYVvcoxnciUNuPYre3+fFxnWm5P6FuJKrcs8HTELF+row4mZoxNDpzWPpTN+1ARj3QrC9dcVrPMgcvdIUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/14/2023 3:22 AM, Ilpo Järvinen wrote:
> On Fri, 14 Jul 2023, Wieczor-Retman, Maciej wrote:
>> On 14.07.2023 01:00, Reinette Chatre wrote:
>>> Hi Ilpo,
>>>
>>> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
>>>> MBA and MBM tests to use megabytes to represent span. CMT test uses
>>>> bytes. The difference requires run_benchmark() to size the buffer
>>>> differently based on the test name, which in turn requires passing the
>>>> test name into run_benchmark().
>>>>
>>>> Convert MBA and MBM tests to use internally bytes like CMT test to
>>>> remove the internal inconsistency between the tests. Remove the test
>>>> dependent buffer sizing from run_benchmark().
>>>
>>> If I understand correctly the intention is to always use bytes internally
>>> and only convert to megabytes when displayed to user space. The above
>>> implies that this takes care of the conversion but there still seems
>>> to be places that that do not follow my understanding. For example,
>>> resctrl_val.c:measure_vals() converts to megabytes before proceeding.
>>
>> Doesn't the use case inside resctrl_val.c:measure_vals() satisfy
>> the idea of only displaying data to the user space? From my
>> understanding it reads the number of bytes and only converts to
>> MB when printing the value. Or did I miss some detail there?
> 
> It's for printing there yes.
> 
> But it's not about span in the first place so I'm not sure why it is 
> related.
> 

If this change is just about how "span" is interpreted by the different
tests then the changelog could be more specific to not create expectation
that with this change there are no longer "bytes vs megabytes" internal
inconsistency between MBA, MBM, and CMT tests.

Reinette
