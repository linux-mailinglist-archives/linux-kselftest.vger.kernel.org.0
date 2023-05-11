Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC686FFBF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 23:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjEKVii (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 17:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238993AbjEKVig (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 17:38:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAA076A0;
        Thu, 11 May 2023 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683841101; x=1715377101;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PPgZfOJlqg0PF6Tm43cZXPMCbbHpLh/1EIrF7/EQAb8=;
  b=nVC3+Q36r078mFEzJeeopPh5K9YRacczICeZdkhWxoswYJ+xyu+edXGs
   q44aDtQ8q96ydBSD7cSLrnFH6n90QPidLHaLmeBtQv3Os/u5G0GpTkiWn
   Z8EnV/1ZijgIMQtnhKTTTYhf2Qf9D5iczXHgGEUGILNleJKkMchx8fNvL
   1Eux0X6EPKnNemUdyd/TEQXA8FaOMYdEE4e8+uQrlM6mxI1f3rIKJoyIE
   Kb2jClQ7JbyEudfVwQ0iPtzCvgCdg0eDc1WyO0z1Vmijem8i6jxlGyNEX
   o5/lAKf0yrY0X9vt7qscrsqxzWkZRV48nokD9yAb+Zva2ldWQO9XxvLGe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="436973611"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="436973611"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 14:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="732770798"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="732770798"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2023 14:38:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:38:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:38:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 14:38:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 14:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1jw3+q13ql0rSmMSFcoPlwqxa8cJxwQG269s6mHef9a0MnuMHyWZ8qWLLthL/NVJxGspLYYydQCw4HZRdWKcmd+ysRO4tTgh4FBcTAflUlxSP0qFsb4oDrhM6cPP5b1mgIhaNofndGQNVepEDeMx+xhMW4NnhLi9yrJHLz8Rt8wkygz71XvNfIjIV87kHSMeXEwedLzZ3G/30JQqgLm3Tf4KLEUywjPOgK3zwXshVhFObars7kYg63mzYjyr7Zm2xR4ptKNCf+LjgIa0GiUT77vhiPhe/bwFswM4p/j1VfNkx2q1Rxuv1GoXbC/vUNoCQqO076rT1BCb/USPjVADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXpTWt0jluE0I0oNXo2RV7gHp1XyEQESMYLBBack/x8=;
 b=ZaUn0QQMfjpDZB2zwbMdoEriki9ntsZkcd8v9pRsdUjEApyMCackSVM3jD9mjzvy7zeynU5XExXmCO/zsPDIKxj0nGxbYnM+BkcgV/uOcA8rvFrtOrneLFxuw8BJJ1L5/V/BKOe4ceeiPcCoMXzxaWuK/KTfT/FDFBj2UV+GgggXIz5eRlpz2poMqlTETqmA5X7cytFHac9cw9m8mPcmUmjH92gGv6Q+YhGlnrSsAdto3FyijP3fHAlVo67mjIFTrFF8L93OiJFW5xW/JpJ7KlaRgEp8ergviQUHVvwYtsBOKLU0jpn4cYhOENqXmVYXJThMQw5YgwZm9EKLlM2PxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 21:38:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 21:38:16 +0000
Message-ID: <7f6c0fc4-abfa-4e73-7cff-ce04239bb54c@intel.com>
Date:   Thu, 11 May 2023 14:38:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v1 5/9] x86/resctrl: Call mon_event_count() directly for
 soft RMIDs
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-6-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230421141723.2405942-6-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: b919b084-65ff-4412-24ec-08db526807ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJa5tC8Eoz1/8NZIkhjeQg5im/dPeQ6qlK4GMHeFWxcZgQl1Uzz5urAwVlQSfH0iWdi8Z0YeKv8Lfx+AOTsh6/M68qz/fN5W1jfQc1TVD0TJ7Kj78TdauAT46PRghADiFAbUClhn4AtBs5fUFyiPuGUmf6wridwWGbC7CLcJT6KP0ka9QKscPuUjeeqJ61iyNVn34Ixaj8LfcRHuli7Cek0N3cDqCPkcmKRjtssavlBQec3HNI37jOk1FYDawTdF/H2JZRvFI/mhjoYUi0aKoKy0lsokibvfUIISD64og/NABJykyh917KPQnR+7hm+JyAm32yRcp6y5/MZnjsHUL0JMrRpXA08Tu4xKLkt4KltwQmnKv1mzAwHnLDb3al8mU1tOZa7GT0LDL0wt7Aqb3YAapvnAFgH6esyYIihNwzAJXKA+miAwlKaZmrWteYYYt5yuMT3joIIwLj5sR/4vRlfNvR6yu/JLKZEEI88atYPB9lIiWMu4fTKuvKCLH51+Eo4Nt+9uEPXU/oT6GUmDaseaUR//Z74ZbQMeaCKYqwYg9Cy7hIriJbBLvzMfqvvPYFX42Z3/xTkKt3evBUt71UuW0V8l41+Fn0xf/1KYO9IpCleN1xN7LZPF9FW4KRTOjWyxNLCJheZ+aHsM8J7Ibw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(5660300002)(44832011)(7416002)(8936002)(8676002)(83380400001)(4744005)(2616005)(2906002)(186003)(36756003)(82960400001)(38100700002)(31696002)(86362001)(6636002)(4326008)(26005)(6506007)(6512007)(41300700001)(31686004)(66476007)(66946007)(66556008)(478600001)(316002)(53546011)(6486002)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHRXdjdxYmFLVUs0WWFzc0dWMkFkSmZ6eWlEc3IrRmhUcWsxWjRUdWN2UmVW?=
 =?utf-8?B?RWZ4NGVZUnJNV3JqaENqczFidlA0a0JmalVmSm51bmpJUFZOdnlyNStpTDhT?=
 =?utf-8?B?cWVNWUV2RS9MeGpxSmlEOTBuS3FMRmhsa2hidGRKQXBUT1ZlbEVRcVNCN2tj?=
 =?utf-8?B?Y1dpMnB4L2dNL0MzV1diVUEwWkNRRzRiTFhYenZQNmpscFV6NDJKN29wN3NV?=
 =?utf-8?B?eFI2QytEbS8xYXFLdncxRTh0RTkyS0E2ZXExNDY5V3krMzdlTjNvWnpMVnkz?=
 =?utf-8?B?SzRwNGhuQnVEcUlWemxLb09CR01sVG1iVVlVaC9sYW9XSURlZjJqWWlqZjRR?=
 =?utf-8?B?ZjNDUys3STNsNHM2MEtUZWI0QUROUjlpOXNFWHIyTHhMc25mbzYvSlNJbDNv?=
 =?utf-8?B?TnNVZU1ZOE5SNUlnaDN2L0tnYjcxajl1dUEzaGozbUpuKy9lT2dYYUEvSW9V?=
 =?utf-8?B?Ym1EM21pS0lJMjhLRjc1QkVTUWxHRFFyeDhqNnl1WXE3Z3lDZzVvaGc4ZWZF?=
 =?utf-8?B?S2N2b1FMNi84bno4NExFcEo0SDR0bnFpV3ZQSXFwVUdTZTU2cDVTem1QU01G?=
 =?utf-8?B?K2NwWVVybkVHRFRDUUphdEp1UDF1WXlmcVQ0alVwa3dBWWJTdUM1VElrNVMw?=
 =?utf-8?B?aFE5aTdxNUoxNGFMakt6VlMyeDJiQlQxaEhGSjlyQzZlMnQ4aVUrdzlXeEk1?=
 =?utf-8?B?R0E0cHllckxFbGtmSWNacm9xcUdqcENucTFsT0xZb0R5WFQ2VmxhVEVNTFJa?=
 =?utf-8?B?NnRzNjk0eEdNQmxBM0VZamx6YjRFbFp2VWRnWWNnWUlyTjY4WVVQSWtvV1JL?=
 =?utf-8?B?V0wybWI0bDNFVFJrTFZLbWpkWGV4UVYvVDdndHVTTnMzbmZMVnQ5NEhVcVR4?=
 =?utf-8?B?WlpkS20yUVlFTHFCZi96ZmFQU3d5MTJKZjNMMEcvdUo3MHE3SnZoRFEzVHpj?=
 =?utf-8?B?L2lRRFZnNDVhQjM5L0s3K0thbWhuOXhCOFJDcFZlMFlVYjNZdEZZUWdOeHJs?=
 =?utf-8?B?d2JhK0x1VzV3TjJBdjJTNG9VUU0zT2FYZktzaWJRMUNPdUlXZk5MenFjT1Nl?=
 =?utf-8?B?Wm5nbnY0dDVZLzd5TzhhazBGaDJYaXh5Uk1SNUwxQkdLOXZtbVNTUVZGa2hY?=
 =?utf-8?B?QVNZMlZyd0hXVHJ5YnorSVBLazc5d2E0RDY5U0NEWTVNdzVBRDBoSjBtSVJp?=
 =?utf-8?B?aVB0bkVrVFR6cHdWS3JGdWRxemJIemlGaEZCQ2dsekd5OG5YZTZkbnJRSlp1?=
 =?utf-8?B?cmp3MDc4Ni9la0QvdEFJVWt4VnFRaE5FOXU0b3JtQjk3M3c0NUF1QzJycmFk?=
 =?utf-8?B?dXcxMm1wbE9IRnYzQ2M2UzFzT0lYSGZ0dkIrVjFVSVVoMFNYSkJsSzAwY1dF?=
 =?utf-8?B?WXMxaXpiOWFPZGVHQTd2MkVBVHJFTDYzVGx4aSsvd3ZWc3dPbEdIN2JBeVJT?=
 =?utf-8?B?emZNSlBvS0FLcC9oNWxHeFlla3liby9hTkVDb1dMclF3UzVxd2RuaVBnVVYr?=
 =?utf-8?B?U3d0NnRFSW9Tcmo0dm1XcnpvTjl1Y0ZDM2IzQTZZVU4yVUQ1U0h3Qmk4UmJn?=
 =?utf-8?B?Slh1cEF2dGR4OXVBTTEzTHY4YlVINzhLR2Q2WUk2amRPMDV2NGJZUnFVckkz?=
 =?utf-8?B?eGlqWERhc3cvOWpTNlk4bVlrVTBMVGU1L0VnbFJELzFocW91dWNkdHA3dzM3?=
 =?utf-8?B?NXhxSDRhSDdVZ3YrMERIVm9IQmdyVnMwTVljT083Ymt6U3ZwWS9TZVBna2JV?=
 =?utf-8?B?SC9XcXpDby8rZGdWRUwyWVA0U0NsQWVtSG9yVTNQQlJvQzFNVjlSRFBDdEVS?=
 =?utf-8?B?UnNzT3lkbFVMNWdpVk10VkE2aDQ5Q3A1bkk0NlNacEhHZTFpVmMrL2poVkdB?=
 =?utf-8?B?OVowVU9ZRnZiV1BySjUrek5UQzJleFl2c3ZJc1g0MWxacmtQUDRaQzZFZnd5?=
 =?utf-8?B?NCtpSmlIRFFhdzgrRENiYmFqUTNPM2Z2RU1CZ0lBczE5UEdFajJ1c1JIMnd1?=
 =?utf-8?B?Y0VMOWZKelpUY1Z4UE5PQzRYeDNQc1ZnNk5US2pLcVhRNVI0UnJSTHp6REZK?=
 =?utf-8?B?UzJvemEzL3poNGhRaVdydHhLVFRveXY2aFFBZ3VCYi9KN05zMmt2UHZFSGF2?=
 =?utf-8?B?RUV6YUVLamtseTVKZk83RkZwQ3BpL1RPaEluTTRraldjZ3pEdGRvMGNCZlpp?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b919b084-65ff-4412-24ec-08db526807ff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 21:38:16.8906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAPC+3W8hUfBfH/UPs585/0p+vR2h/hdKaiOuDrXquqGGKJTueSqAwejuoysTtnA6WQ9ZjttfHkpHvPkF+RUOmWFAwqUUFRwa2txw0MUSiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 4/21/2023 7:17 AM, Peter Newman wrote:
> There is no point in using IPIs to call mon_event_count() when it is
> only reading software counters from memory.
> 
> When RMIDs are soft, mon_event_read() just calls mon_event_count()
> directly.

From this patch forward the patch ordering is a bit confusing.
At this time mon_event_count() does not read software counters
from memory so I think this change should move to later.

Also, note that rdt_mon_soft_rmid is introduced here but 
the reader is left wondering how it is set until the final patch
in this series.

Reinette
