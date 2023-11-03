Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF77E0B4A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 23:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjKCWvR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 18:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjKCWvQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 18:51:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F785D75;
        Fri,  3 Nov 2023 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699051872; x=1730587872;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BD+Y4mCsjKyo7xqQAgQFjsm32pK64fr4l4+O85u6pgE=;
  b=MYf5OwicP7igNAlyv8tH2UyJ+/P17w+M08fbG6ncho84RSLYBjlElMlb
   ZOsoAV4pRqY7mUai6xxxqOU830HDrdIq5kiXW4GY5+7EJYCdx2c7GSoRv
   2Pv6oV0se9qO/cyadDWRi0dxp1/1vAwPZsEgKJVD//4Xfhc4qFWjd4Xnb
   HZvSoabxXDBU1qMbuNqoJQBjBf93Czoj+Pge9tKGFWQuGm/ConTx3pim7
   QQwA9BfQXSNfPh2PRNTCjFqcNWcDYsUyWBtLjF9Im0qayyDmqUiyjV6fP
   wK7ysG2uW+DVm89Yuo8XZn7Jki73zhVXNgeQlaInz8tbX+/AtAa3jT5A4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="386209257"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="386209257"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="9522803"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 15:50:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 15:50:54 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 15:50:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 15:50:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 15:50:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgY5qCUFvHKJk1BkVogBAv+S3camlfZl3AqPmq74lhoeCyWyHFwVR1LYzL6S337uiNPDV4kedFqGXAUmLl3JueJB/oRTU+TTfry4XWNTQHyuOuozJ4B373Kvsk/s20Yrg6k5MS6e2CjZKCKO/tiF6THRd2+xdSdABK9tcYFLAlfDVJ/rX3UJyDoHh7fuPCNB+ia9R0iQpb2UIepnPeq8dYXb3tB538T3M9D1F1gLm106670HanO19zdZHKLxQtrPvYmYYeeWRxwZ32gFWhwnBKr0HXRj48yM3607z8r7qeL2Ugk/nwmko0T1dIJR9I+iY7tmvE2bKW1Z2HvSsSofZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7wF3h8ll1qBXVZuyFZuOnrkd/94qdKL0PcwKEGz5Ok=;
 b=gdoMAUQLT1qHayOdfeHxwBy4ljfSCos5gQ3ZvcIbzbb0lKluNsCwfr0MSPf33UEgOP6VWFCiXGrxxAQx8cl9SNn9jnLWwt9fLB40tWSpsDhgaIg21T/7pHV7xXmdgt5Lyh6jzzg5twF+CGxdAfdxetbrRN2yzKzQ2LrWaYSP80RbUkyUzPIub9Fr8pegdo1SYb2btOCCiPujOUJ2t/CFojQul91vRuAi6yLn5LXA7oXbXIsfre9Uxs+LnuUSU8re/aYvcTBI/TTAsGSTKAiw6+0EIJf1kOgWjLzhXoudkcNF9ZK0PDbRd73Z+0ZgehpxIGS/jxOQuat738/2x3W/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 22:50:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 22:50:50 +0000
Message-ID: <81b3a379-f815-48b9-a126-19b12ff63e17@intel.com>
Date:   Fri, 3 Nov 2023 15:50:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] selftests/resctrl: Introduce generalized test
 framework
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-19-ilpo.jarvinen@linux.intel.com>
 <56769c01-e21d-4775-94f0-ef9f863c1e92@intel.com>
 <ffdeb9a9-c066-19c-9898-c2bdf632cef1@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ffdeb9a9-c066-19c-9898-c2bdf632cef1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a398ad0-9d7c-4ce8-e02a-08dbdcbf53bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9JnHq9Jfz2e1HNe3cW+7CiKKAGZgK+NfB+7UY1wEl6ZY++6eD5Zt+RAyESmqcBemh/MTAUfBEefa2OQPKPAtees7QHD1m9iUnhPoegIcTeECaaSa1p4pV9YE+eksQ/MDa/nQsS9IcrqCFppfUUp2hjtKTULF8mem8e8jQwGwEjPOC6E68tjMPn1jguKUFz352GqmbPszmac3G2vg2a6bhJvDbNXmqiiCTHi35s0dFQ7r9BYL41Dj4BjWN+kDpMXEZaRrThRUieL8wd9BfmIr7/tNg1LgqJa+/be+dpKhS7tIPTXVgzQsEsUiDsWMuHlsPJ6rmgO28g31wF3+HtQQK/pU2QMOND99R52iT8d5r/1HJDJpWPVms+CA+nqunCSCbz8EE27eulwwVn76muykMDjbO6dvUCZPnR73p8LFejwgSmn75CoOxVIdwlAcKYLtm4cbJhXD2+5qSO6TDDoywPALldpOCTNq1WLsD1ZWkznwVAGTpULlj0wkbDd23r0k3QvKlbYIz24Tf9QrJQDALHxNRzjgh+yXyKMzl5zN4TZDFz1TjvTyeOaNOF4U2Xin/Ibof2OtDeWlZGRnKzE2ZhxeMDTkNhl/ibDu5lvxPA50FWQPaHNzkt5CKWbFEJ/0r9UxbSwYYK7HfCJOEw5uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(53546011)(6506007)(478600001)(54906003)(26005)(6486002)(31696002)(2906002)(66556008)(66946007)(66476007)(2616005)(31686004)(82960400001)(36756003)(6512007)(38100700002)(66574015)(41300700001)(316002)(44832011)(5660300002)(6916009)(83380400001)(86362001)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWUvK24ra2ZzMlNkL2hiNGU5ak9DVE5zMUdwcDRnVVAzNDhDTUd6UnhRS0pD?=
 =?utf-8?B?U1VnQ0Q5MzBVejErekV0cTQyYTJVZU1UL0E1YjFZKzJVNFZFczRWT2ZZamRK?=
 =?utf-8?B?S2gxMllFcG01WHBJMmV5NDdtL2Q3MzZSRmY0SjRxOGhzSWRmdHpnNG4xVG4v?=
 =?utf-8?B?QTR3OG1UWnZwbFA3bng1UFg1MkNCNitkOFpRK3BEc3V4UjFwZU9sbFZxMzB3?=
 =?utf-8?B?RFBkNWx1b1ZBZG1IVjVVb240QTB0b0xwekFLL3N1NW5abktzS2pyM1NMdytT?=
 =?utf-8?B?ZEtvbkg2VXJlTWNnblpacTViWkRneEN4Z0czUHV3b1owcVpuaGNFeWNWQ0V2?=
 =?utf-8?B?eTJxSEc5YjFmdExWbmNNYm9BSmhuK0lRSWVDQnVrUTVHRFR5SEJXREx1d3cw?=
 =?utf-8?B?WW93ZUhkNDZCdzhZV2NhdGllWityVmhIY3dLc1JIMlgrYTZWZDFyMEFhUmV0?=
 =?utf-8?B?Z1k4Qitpc0ZwUENGVEVYWFEvSkFjYjZIRGNCUi9IYXJwMTNsWjJ4SjhNY0tK?=
 =?utf-8?B?ZmFpc3JqV2lROXpBYmlTRW13TjJldGpJTDJkWUVqNElXSUtFMTFCdFlKNmNr?=
 =?utf-8?B?R1pkSEs5dWlvY1RlSGRtRFFBTGRMdmpKZVkyWjlXbkJwNklhZXhwN2xyWC85?=
 =?utf-8?B?V2U1OGZja0dENDBIcHlXekdZZFZUMUFDaWtRVFBnYmxTRDNNVkU5clZGNjR6?=
 =?utf-8?B?Z3J0U0E3eG9iQUxBejNOaTVOa1R5NHNoV2ZLWjVyczdiS0lFU29DTFByMWtr?=
 =?utf-8?B?Nm5rUzZiK2taUHBabWYrbkNURFNIT2VIS09sakRZZ3pBdUZSTU9RQkZxaGVE?=
 =?utf-8?B?RlBRVGxMSjNhZDZYclVLOElFaFpBTzNEV2JadEhNZitxUFVYbUNpbGttNGs1?=
 =?utf-8?B?SEJMeFRrazhQMG1ROUNpUDVLU2RHK2JheGJPSW5CUnk2SVdSdEpZcG05c3No?=
 =?utf-8?B?U3pRTzRGWTloVGFFam5ldHJzd2hsS1RVT285M0xIOTlrK2ZrcXlsa2FHajE4?=
 =?utf-8?B?NGo5aFNraXJVak1KSnhuRFdEUVJIU2EwQ0JoaFloSnNuY0htNU9XWHNEZGV5?=
 =?utf-8?B?ZnFVTm1WQW83SCtieDFoWDBCSmJtUE15dDI5Z3kydmE0aVg1RlRDL3N1L0xu?=
 =?utf-8?B?MUo2V0JDZ21RUDQvTUYzQWhFblY2STFWZS82YWpKcW9rTXk3c3dWS2dRUkd0?=
 =?utf-8?B?QmVJSnhWbjM0c29vaXFid3IwUmFBVk5KRXErZkw5eG1tN2k1MG8vZ0VQQjRt?=
 =?utf-8?B?M1ZTNzZNVTNZOUY0K0xrNTFUTjZGSEZsOTZyR3Jsd3FFU0hQMWtKMXduamRB?=
 =?utf-8?B?VWNpcGRrR0pUTFVMdlFMVUZZTTUvajQ0Q1RwK2lGN1ZGbmVLNlJsZmw3K2Zt?=
 =?utf-8?B?STJUUmRJSmhad0RJSDVyQmlKUFp6L3NPN1ZPbytka1pvbFdVVm8yVGx0ZFJ5?=
 =?utf-8?B?RHNDVm5sTjBFSlY1Yk42dHMzZG5CSE03c3dVbXMzWGJiTTFWa1hsdDNlNDF3?=
 =?utf-8?B?V2NaUzRiOWdpRzVjQ3NFcjFrcm5KVXRKczR6OVFkaGdpeGRpZWpxWUhhMVBw?=
 =?utf-8?B?N2dQWVpKRThMUkgyTUZJeFp4QTFtSlJBTHZkQVd5R0htTVlmMkUwUWZkQW44?=
 =?utf-8?B?OE12NUpjUlN0a3ZJSFFBZjZJL0F2N1ZPUjhUekR2WFZFeUxxYktHcnh2S3hE?=
 =?utf-8?B?eGdJODFFYktiVUpWMjRFZklBbEVXYTFVNERPUUZCMVBJemQ5aHNlQ013N2Q3?=
 =?utf-8?B?RFZnNEtXcThCeXUyS1VpV2ZjaXBLZ2lIRThEWnpWUFBURCtQaFVUZlJRQkJk?=
 =?utf-8?B?N1BURXRYcFBlTVhvRGowS3ptSEdnVndCbjJBK1ZseStBWk4zTUhCd0lvR3BE?=
 =?utf-8?B?WFYxdXRadGpxSTN0QXRrL3FUYXdNUUJZMWVENG9DVkgxNUlDQndMRTJVS2do?=
 =?utf-8?B?TkkwS2F3dEdYY2Uwb3JDY1ljV2tsZlZtR0t5Tk9MM244WmNJdnk2VWtCbnRH?=
 =?utf-8?B?M1dtNEhpVnQ1TGFrZWZjVFEzVm9HcG9TdUFCeVdnVGtQR0g1Y1hEUVJnanlx?=
 =?utf-8?B?TWhiYVZpWTZnOHpwWmZVN0tpaktMME5wTys5b0gvdldDaW9xZ3FuUUl3TXAv?=
 =?utf-8?B?bVdtckdwbFpFTVlLNUkwSmxoZk9IYm5NUzU2R2tWZlFzNFcvYnh4Z2pqU1pt?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a398ad0-9d7c-4ce8-e02a-08dbdcbf53bc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 22:50:50.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xlxch1TeAR5aXroeZMgDJl8dugooy6AHgBlCN7t0omGszYwNQNLI9bTlzjATACj0+YVRTHcxZkp4EaA6hkhwR89+zWOXdQj/tmoOn79+KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8723
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 11/3/2023 2:54 AM, Ilpo Järvinen wrote:
> On Thu, 2 Nov 2023, Reinette Chatre wrote:
>> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
>> ...
>>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>>> index ec6efd36f60a..e017adf1390d 100644
>>
>>> @@ -233,25 +183,26 @@ int main(int argc, char **argv)
>>>  		case 't':
>>>  			token = strtok(optarg, ",");
>>>  
>>> -			mbm_test = false;
>>> -			mba_test = false;
>>> -			cmt_test = false;
>>> -			cat_test = false;
>>> +			if (!test_param_seen) {
>>> +				for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
>>> +					resctrl_tests[i]->disabled = true;
>>> +				tests = 0;
>>> +				test_param_seen = true;
>>> +			}
>>>  			while (token) {
>>> -				if (!strncmp(token, MBM_STR, sizeof(MBM_STR))) {
>>> -					mbm_test = true;
>>> -					tests++;
>>> -				} else if (!strncmp(token, MBA_STR, sizeof(MBA_STR))) {
>>> -					mba_test = true;
>>> -					tests++;
>>> -				} else if (!strncmp(token, CMT_STR, sizeof(CMT_STR))) {
>>> -					cmt_test = true;
>>> -					tests++;
>>> -				} else if (!strncmp(token, CAT_STR, sizeof(CAT_STR))) {
>>> -					cat_test = true;
>>> -					tests++;
>>> -				} else {
>>> -					printf("invalid argument\n");
>>> +				bool found = false;
>>> +
>>> +				for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++) {
>>> +					if (!strcasecmp(token, resctrl_tests[i]->name)) {
>>> +						if (resctrl_tests[i]->disabled)
>>> +							tests++;
>>> +						resctrl_tests[i]->disabled = false;
>>> +						found = true;
>>> +					}
>>> +				}
>>
>> Could providing multiple "-t" result in the test count not
>> matching the number of tests run?
> 
> bool test_param_seen covers the case with more than one -t parameter.
> Because of it, the code above resets tests and ->disabled only when the 
> first -t is encountered. tests++ is only done when ->disabled is set from 
> true to false.
> 
> I don't see how they could get out of sync but if you had a more specific 
> case in mind, just let me know.
> 

Thank you for your detailed explanation. I can now see how this is safeguarded.

Reinette
