Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2420C705BA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 02:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjEQAGl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 20:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjEQAGk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 20:06:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A70655A6;
        Tue, 16 May 2023 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684281997; x=1715817997;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fQNsDJh2/ldPNFQ6uS8H92azdCe2R9W7ur2Ss8el/i8=;
  b=mzS+cKUw0MwycfnQ2ArbtnuLKoXTnJtvlOc+FjaXsxc4/dRfsEK5hn3W
   /YfdB9tHxgwWfYHyO5HfFbUziGy6Yo70IvmKwwFZxuOdO/wqmJhxlod3k
   fR/ST6HZ0D9qTfeGOd93eALOqQOCmCMWNDB96UHJU573p06K7t6rH5wE5
   argDqjVdeG372sxa6dwRJsmeXQRA+oYP4ZhG9+rO5RuaIUx8huzKa/3vO
   Y1lYelQulBwRgSOyFx4FxJVIKNT0U7ktq6T7c7BPKYy1BB+Q32FPWCVOh
   FCYyaUHkY0hp78KLqki/sHO2zXcdgYifnUxJjtQMDVg4dlXjqfupx6S1g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="331982870"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="331982870"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="948051076"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="948051076"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 16 May 2023 17:06:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 17:06:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 17:06:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 17:06:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 17:06:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew0CHpW0h4GJ5/BzN9k/5mZ6hWy9cW9jGtK3rh0Nnd9YoOedrCbv6HesYpa+o0USfp/96U/u32T4afa8RYRwimF35dkvz4Br4govYNltm33BD38DmU8uNkRyEE3dZBV+LJttT/Sw8VYMe0PzrfWfcZU6Cth4QJ3IYMgn8Tp9GGCxrBAZ7HphsbZf6y5ijBGmOOpBqE9keQZzvgoCFL5PrZ/AZbVfVHpwCNy6WhvY9/3//OxyvUssb/n+rmViEajLVdyClDp5vkmJ1X/KTkN92M4gX1vMtJ59GkYdS5IEZAGo0O3Kzb81F4HjFdVogX5xaMms7L/Dj8THTzsPfyMJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVwj6FBpNi37jQpuimJwxE4P1QcDLATX4EmW+QIRONs=;
 b=i+Kc5YC6QuTJ0wN9F5A10M1L6ouCKNIzIftpkWoTvZGGiktk9+Y2X21VXMY7i+Jiay9JmmLuihZfS/q9xHLTajc7pr30e8esm/BGnzxM3c/00CGvpI/9Ohn9Q8h31UzUbrLl3o/Yur+2IZ54QwGpIARpskc1U08xAUKBsMKibKxjVziZPC3DW5NKGiGCOCtIKdtpMIWNX68k5uOWgVeEdAHCLfgsYcIxSGs+Ogt+4FJ+1vb6qaTs/WaIZVw91i48DeVGniELvkLfP/ntN6IaCZ6rdmjC3Emcv/FhbGiW6I7DORK4XGHBEwtiDZYqw+tu/c1FKc7iMNaUS6DtfoAyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7911.namprd11.prod.outlook.com (2603:10b6:208:40e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 00:06:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6387.028; Wed, 17 May 2023
 00:06:33 +0000
Message-ID: <00b0c70d-eed8-8dc1-8046-25764d991bf4@intel.com>
Date:   Tue, 16 May 2023 17:06:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 7/9] x86/resctrl: Assign HW RMIDs to CPUs for soft RMID
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-8-peternewman@google.com>
 <3816ccf6-4f74-6406-5ca0-580743efa2a1@intel.com>
 <CALPaoCj76eMTF+VPT8_52_D+fKpWt2ENcyavJ4aooCOo9TYKFw@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCj76eMTF+VPT8_52_D+fKpWt2ENcyavJ4aooCOo9TYKFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 8533b289-7258-4152-fe05-08db566a92bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjmuMKYBe/HctcHz38HzIgLbvtbXE4XPg+XSmm3+lhbtiG8ybCU8XryGP+k3ivIE8mrUW8K2DKmp2awQFjLhCpZFhxaQTd6uvEi1HnZAvPcrR3kjakD/wuJBmlV0shA9IikDYSAk/OWaXGVl8UisH+UqowvK97mQdQZtWbu8SyX7+IhelCPxkMVl86LsLHt8+SHtkQsJc7MYqrKhLYYtbTfXSsid0gMenys9c1Z9j9A/HinWxIgbJUmma7k1PgmIAzgwD7Od2SWY0SmqUdEVDe3wo2rjAuvpmDs27LXaKeGisto7uB4Clf8rivSjz9ky7O1PrPz6vGnOTy87ednv2Pfk2ImmXJeAeL/t+5e1HAO4JaQCr+wMv5MDPMnC1isM3V9hjkQUEUhNffLJc3uCrgb0MghVNxNJO3GwPv37hIbfB85+ADHhA/4WG+m2xc6VbAXmXbsyg1WyMtW/VrHJJBaR2rZVPlC2gHeyQ35ShZP+tOAheDpnysfy3G6kHYgouTdMMHvaahmXVuum4MG0Vzbb17p3a3NTobE2xWB+9Ov6juSD0NUzxsBllYqhpwUj2GYZ4j++hjPnqOFDcUyWeEuV80UkstJbSZGBZ6g0BRLI7GZAiWnesWNOL4y4nI/83qZTA9GGgLygWC22gQHSgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(31696002)(86362001)(54906003)(478600001)(36756003)(186003)(53546011)(6512007)(26005)(6506007)(7416002)(6486002)(316002)(38100700002)(41300700001)(66946007)(66476007)(66556008)(4326008)(6916009)(8676002)(31686004)(82960400001)(5660300002)(44832011)(83380400001)(2906002)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9HcjBUZWIvNVVjV0JUZWJ1Y2NrRGZMZVZpak5PNkN2T2FMZFRzVzd2blY4?=
 =?utf-8?B?STE5TWFIYS84LzdZbkg0aDhvdytxYy9rdzZ4aThLNWJ4K0ZTMHBMK2FBZDFC?=
 =?utf-8?B?N1VtRHVUR1c4QmNicHZtd2o4MnNrNnRmaUQ5S0FmOWg1VkJadkpCT1E2MUU2?=
 =?utf-8?B?a3hNMXFNVTBZK1UvS3V1M2drNUNwVklDa0FmTGtuREcvdU51YVpCTHJVNENx?=
 =?utf-8?B?d0tsQlYrMHZnZzJBbUNFRVY2ZHJ4R1NpMS91em1Sa2xYay8wRG92V1NyTW1N?=
 =?utf-8?B?QUVSeHhmZ01HbW8vYjVob1pWZUxra2FKelZ1bnZHVHlxSWdwYlpNOVlJNTBN?=
 =?utf-8?B?RkcxelRKdFJOd2VhWGtmZ1FvNmhaeHYyU01QWHh4QzV2QUNLK0t1RFllSEk1?=
 =?utf-8?B?SmlsTmpNYXZ1NjhyZTRCcEd3TzVTRDBNV2xKQzEvdG52MFhNSUY3eHVsNFB4?=
 =?utf-8?B?WHdaUFBYeHF0Mkk3Q0tNd3JkLzdaSVhWSHF0VnB3T2w2aFRhTS9EMENYSkNX?=
 =?utf-8?B?cmxIbDNNdnc5UW5OYVNUaXluN1dmS0hCTkEvWmtaZzhSWDNLS3ZPV3RNN0pE?=
 =?utf-8?B?b3pSUzZ4dWhJWVlsT0JBUEUrY25aTnhHbVBCNld4dllTK1lYOEt5QW5IbmRz?=
 =?utf-8?B?cU1Oc285MGZjRVRIblZ2TmdISDEzdzdLZ3N6ZkZuRDlmMVVRUi85a0NHRS8v?=
 =?utf-8?B?RnBwZ01rZzFXazQ3NEYxd0xaakVCQTQ3RkIzOTA2bm96YmVkRzI2b0Y3bmx5?=
 =?utf-8?B?R1JSZ0Z6RE5ET1BXUEJXQTJyRW95WWJvaGNUV0FYclRFUWpieENwV2w4YjZZ?=
 =?utf-8?B?NTJFQm1PT2E1WVVpOE82NjRTbytoT2luUzVTTWVhdTBUdFRxVDZHUlNrZVpD?=
 =?utf-8?B?WFIrZ2FOOGwzNWRSWVpCSW0xMmVwOVkwTDMyd3k3Z2ZOMkIrWmhOQWwzSk9w?=
 =?utf-8?B?R3p3R2p0dG01ZlBZNTFnWmZxRjVCM1ZCbWV2MkxzT2lTMER0bEcyQjYvb1pZ?=
 =?utf-8?B?WmJzQUtyVVZweWVaQU1qL3ZiYnhsUzZ1dUQ5M1dmdnpWUUtISHRhUTBWQUtY?=
 =?utf-8?B?ZTY1T1VwQUYrNHRYaEtnOTd0dkYyUDBJVEJ6aUFvTzROYVQ2Y0UydW9iZHBn?=
 =?utf-8?B?ZjVqenZJaVZmOEc0ai9vWE5wWW1TZE1MK1ZNWVoraVRCMStxVWI5RnNlaUxB?=
 =?utf-8?B?N2Q0aVczZzhnYTl4THRLcFVpYnMwVWY2S01LbkhpRDl2eW1QNm1WWXk0N1lJ?=
 =?utf-8?B?Q2oyQlYxckN5anBnWnVGQm1FL1Y3SWttcC9lb25mTTh2MWEyRzRJSlh6WXJu?=
 =?utf-8?B?elRsbWF5VWxIRjhiQ2NkNW1lMUFudzZGZk5JY1lSVEhiVTlla1pGeTdMeGxt?=
 =?utf-8?B?M2VHUFRrTjBrRm5hUTdrVzlZUzF2VGdVZllveHJKemdTWU1WMEx6YU5HK29N?=
 =?utf-8?B?ejIyTUJxVk43a0NEVzdmUjlZcnd4cW1YR0lZaWMxTlZpRjZkQ1FZS1ZkTXJZ?=
 =?utf-8?B?Lzd6RWZ4VFFMaUR2MllaNkYrSnZBQVlST2Y5Rm9WOUdScFpjVVJFNUIwMFFp?=
 =?utf-8?B?UWJMZXlSdTR4MmdxZzY5TXJBUWo1RVhVQjBsTWFqUUdYMnpRZ295K01KRWlq?=
 =?utf-8?B?bUg0Mm5kWTI4U2dHRDE2dFVmemtSZkM4U0hRTWU3QzM2dCtzSEMydjFESWkz?=
 =?utf-8?B?bjdDV3Jkb3FJcEhERGIrTm5UTFJRbG5WMVlCVmd1WkN1eHpVOHR3aWFSRklN?=
 =?utf-8?B?UjBnVmh6RDJ5eU5pZVhmZFg0dnBhdlQwWW9CS2s1bW5scFdMTmt4empSMk45?=
 =?utf-8?B?ZEF0M1paMjZKK3Z2dWJLeXNGcktUOGljTGdWQXFyYnhvMXNHQUJVTTgwYzFl?=
 =?utf-8?B?aWgySjBsREZwcGQ2TmduSkNNK3VucmNpOTFGYVpQSkVIN0NYaVFvcUlUTEFI?=
 =?utf-8?B?Rm5idkFhTjFidHV4NXE4bHVZTm9nQU4zZkd2NGJLT2JLdVVFT3JjN3Jyb0Vt?=
 =?utf-8?B?TUp2SllxMVErdmJ2OHdPSEVVYVJXK2ZJVkh0VmdCeFlYMm9rMkJTSEY0Ulhu?=
 =?utf-8?B?cVJpazBtZlZRckpxVWd3MTg3ME8wWHc2bzlRYkZQOFFadTRMcVBvNFQvL0xu?=
 =?utf-8?B?SmI3QU1BSU4wL2xRdEFLNlpJakl1Y0ovank4ZTV0RUVDNkFXbEt3bjBWSG5Q?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8533b289-7258-4152-fe05-08db566a92bf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 00:06:33.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4URbqEVDBN0iN8hMaKENXvHVttgN6HVCo0x+UgE8b0RxQ9m0ratY5/u7cKJG5beAodOpvGfq2MTacSLPRMxaZyB6sz3RFbimleJb+EoPL9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7911
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 5/16/2023 7:49 AM, Peter Newman wrote:
> On Thu, May 11, 2023 at 11:40 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 4/21/2023 7:17 AM, Peter Newman wrote:
>>> +     rmid = 0;
>>> +     for_each_cpu(i, &l3ci->shared_cpu_map) {
>>> +             if (i == cpu)
>>> +                     break;
>>> +             rmid++;
>>> +     }
>>> +
>>> +     return rmid;
>>> +}
>>
>> I do not see any impact to the (soft) RMIDs that can be assigned to monitor
>> groups, yet from what I understand a generic "RMID" is used as index to MBM state.
>> Is this correct? A hardware RMID and software RMID would thus share the
>> same MBM state. If this is correct I think we need to work on making
>> the boundaries between hard and soft RMID more clear.
> 
> The only RMID-indexed state used by soft RMIDs right now is
> mbm_state::soft_rmid_bytes. The other aspect of the boundary is
> ensuring that nothing will access the hard RMID-specific state for a
> soft RMID.
> 
> The remainder of the mbm_state is only accessed by the software
> controller, which you suggested that I disable.
> 
> The arch_mbm_state is accessed only through resctrl_arch_rmid_read()
> and resctrl_arch_reset_rmid(), which are called by __mon_event_count()
> or the limbo handler.
> 
> __mon_event_count() is aware of soft RMIDs, so I would just need to
> ensure the software controller is disabled and never put any RMIDs on
> the limbo list. To be safe, I can also add
> WARN_ON_ONCE(rdt_mon_soft_rmid) to the rmid-indexing of the mbm_state
> arrays in the software controller and before the
> resctrl_arch_rmid_read() call in the limbo handler to catch if they're
> ever using soft RMIDs.

I understand and trust that you can ensure that this implementation is
done safely. Please also consider how future changes to resctrl may stumble
if there are not clear boundaries. You may be able to "ensure the software
controller is disabled and never put any RMIDs on the limbo list", but
consider if these rules will be clear to somebody who comes along in a year
or more.

Documenting the data structures with these unique usages will help. 
Specific accessors can sometimes be useful to make it obvious in which state
the data is being accessed and what data can be accessed. Using WARN
as you suggest is a useful tool.

Reinette

