Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE387B3C9C
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Sep 2023 00:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjI2Wbq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 18:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Wbp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 18:31:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913571A5;
        Fri, 29 Sep 2023 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696026702; x=1727562702;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MZMAj/UlP8D5Nkgw2Dej1qi7sBuu8hQVQg7+pCS7Yxw=;
  b=ZPxKT+7vXDsE1Qp0GJkv4v2JbC32rFQU+Hs/6SXFV4eWwSdXbScwqPOo
   yPkp/h4oCGAaH5ih0wF5A+8HourToPP/IDKsGsfxqcWvW7Pzr+dqfQ69k
   SUV3qPv4RkjSL8qG06TDE7htQfQndDFTcVpUcAX0YPHBotI7kdh7PLVC4
   Z317RlQV9BJ2UJhLl01UKCa2wUq9DHoJUKnTwqnfuLe8ywgGkey+y4VBR
   e/HHav3qr4zhjvYAlklKT7tVvAz7KRhYmCNjlS5EQWDJXsziUlkZWK1QA
   fo3VUvbeBgYt1vmhKKmHV+hKjSWinUAmKMzsn0Q5glpmFGv4CvR+qcYgf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="361776574"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="361776574"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 15:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="779405400"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="779405400"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 15:31:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 15:31:40 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 15:31:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 15:31:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 15:31:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih0RnqOhFWVie5Hiyhd6T7xl2GEg22/+1J+HvB3Wu/rwHtZh+ZitW7Oc62JMOgQDw9tX40pdf4c9fq3q20uy51HZOBKlevErevqKuy26e3C917V0MUny92LE8Spm7P/RABswER571EO/BeCIfjP7dyQu7qqzxBln/3CK7vNELs75ClPB54cBS23AUEaGxLh+aGjVvEdaTiVn5+rDEnWHOQfDvoSmF9K+NhqLafnB+zVd+UFdtoCOvHNP7whlA1SupbmDfnnXLSQWXTPXOQinizPf70L6tutNAFtREWpxJC9pJm9Q2fsdbZ3qMdDfBZriaHOjmlczrYCZALbLJPQErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weTusGqt3ycER04dQvJS67AmGQc8cG2tl4KHj4PTWeQ=;
 b=eg1D3c7os1lMZfHuANHbyBDqSNpT4V1A5GXwlfVV2/LhOpH4VQ+Y/tU+Bzx5VFQasfSuYD9kJQIr1UPh5ptDOH26gssb2/nUYFYXXygRr5zutZHzG1cPZfzE8RIQlDgCKpIwGuHuCwq8MczYMcadY3H100aUCYsgKmqgOg2T4qb4NOpO4rMknR+0COJfHqo2xGB4gqILt307BQ3Pr0SsHKVg7lKRTEm/15kGBkMPDqR50azb9xUSRsd6y9rVFDPCS4HZ2/HTiRZXr62BzCIJ4BmAFv1GvCWJz/FRErJK8nRfJrDsIdf+Wvb3Z1ET9wjsFa9AmTsjS9BXnBvWLyHIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 22:31:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 22:31:39 +0000
Message-ID: <38ce7f36-a31f-8519-6a65-74d8d172ddf0@intel.com>
Date:   Fri, 29 Sep 2023 15:31:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/8] selftests: Add printf attribute to ksefltest
 prints
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <ilpo.jarvinen@linux.intel.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
 <c6031eeffeb5d5e3b0b639f4b2aaf7fefd75fde2.1695373131.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c6031eeffeb5d5e3b0b639f4b2aaf7fefd75fde2.1695373131.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa9e858-9af3-43f2-63c6-08dbc13bd8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4l50LFdqpM+9w6AJwcaRqsaHUN5ule/VJg1Bb7Nd1auDjItYqVFnNkVEQD7+1PRymlblDgl9KfoD2pWMeiBtqQRcz6bk+FfIR0w5/JnRGkiCpiPCILDS8sq6FO6gcbt1FwQt30PQ1A7pjxkDyAade1lurORCWBJace3ENIc8dVCLIFhu7QAp+AjmFSgsmmpL/3o0PRE1TcFizNJVf2eUGD5Pt++Xon3HjqzPsW15BfP/LPOnb4ty8R/zXb7UHhG5BRCL2abmhyYl+V70Ei3VuN1XQLqyOm/b5Oh95NyA994eEJmhI+nwZ32YGxyq/CXCktPREj2CMHOw8JIHl5j/OUjM8cdz6GNI1oN200dL5QWLIt1m0u72HL2xC7QRrOVOEXbBnGl/3dbn1iB2t1RIhzQDAw8Wl5f/jZUISFI+iAWfkmx3qcHJigwV/gg9OmsY8xT1Fx5MK3PnFupDk1aT88UCjlrvnJcu3GhAS7CV1iZTS6pTLEoEkat4a0dbuI+qCD3gtZLG6XNzocF14VnQaLbrZSYpxIlz5g+tdlAQ/+bcN2sdMm44rxq1P9HriD9NUw2L0Q+O3EpU9u+CeDwDATkuq5TsO+23clqi3Htws7q7AoxiXwiRRZgTOGI/te8MXCP2Bt/wy8E7h6LFJe7LDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(31686004)(4744005)(2906002)(110136005)(44832011)(5660300002)(6666004)(478600001)(66556008)(66476007)(6512007)(53546011)(66946007)(2616005)(26005)(6506007)(6486002)(8676002)(316002)(4326008)(8936002)(41300700001)(36756003)(86362001)(82960400001)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1NVbnlkNUtqL0lWQ3k4NW44TnJucVVWZm1sQlQxdlRwQ2xFNlRHRTM4N05O?=
 =?utf-8?B?THcrUVE2cUNNVzhzUHpnSHJTd0xCWUxmQXR4WnRPUXhyaThrNkRLUVdRRmIv?=
 =?utf-8?B?ZzNwY0VTb1MwTDBKYkk3dWhJcEtnMVlDWUppNm40Y2U1R3NLdVV4Wmd6ZzR1?=
 =?utf-8?B?Q28wcVJVbmVTM1QrNXgxK1UzUFMvMkRGd3llR05HY0dFdlVCZ2VTN1Y1b2ls?=
 =?utf-8?B?bEdWMkxTZ0NHbXdLYWRXaS9tS2xDR2h3S1RiU2cvMWxBOUxLeUREVk14V3ht?=
 =?utf-8?B?OUV6V05PMjVDL2JYd0tjMUVKVUl6d29tNC9rYlBGRDJHVTZpbEI5ZmlzRXpq?=
 =?utf-8?B?ZW5SNHdXVUJpcVBwb25PTEZTVlVxaUpJb3lyM29kUHpsbnM3c012S3JXT2RI?=
 =?utf-8?B?VURXWTVRS3d6cVBzVkpna2RER2FHZzVXbXI4Ty81RWE3dGozOTkrbDZDRkgv?=
 =?utf-8?B?c3hQSTg4dmdrWXlYZGtMMGkyTFdlc3UrUE13dmpVMTVyUUhJcG00c1l0ekY0?=
 =?utf-8?B?KzUyano3WmdqMFNZQktKNlcvNXRJQzJBTFFnUnkyQlFaSjBUSmN1V3gzVldt?=
 =?utf-8?B?RWo2bzc5OGpOOUw0cXd4RTB0NUs4ejhqckw0RU13empOWGxzdHdXSXR5UFpq?=
 =?utf-8?B?VkdhUjRMWTNuRW93VG02T2tYZWpReU9FSHNJdnQyZ1FnU2daVEU4M2xMazI3?=
 =?utf-8?B?QjdNRjNoMjlXMFppakY2emV0YW1BSDZQOWNCaVJqSG01T2h2ME9rM2VMYXg0?=
 =?utf-8?B?YU5NOEgzcTRrTHlTYkErRkY1QS9zUWRYU0NOWStGTjY2b1Q1UTV4WkhEZ1NV?=
 =?utf-8?B?dnRZN3BpOEdxZ0s3Y3BLZEJ4SnhmT1U0Sk40WUdYTG1yMkwrWXdLU3h2SmhL?=
 =?utf-8?B?cHlQUWhQTUx6YitmWFl6Rklqdk9uT24zVUNxQ1JxK0pQZUhDemNIWEVRaVpX?=
 =?utf-8?B?Z0hCOU8zREtNUlhFR0ZXRGc4TUV3OGs4SEFib3kxWjZPNDE3ZmlsT1dCTlVh?=
 =?utf-8?B?dXJTVFF0UHp6aHdNek45a2hxUVlMSWI0REpnL2loS0xmVHBjM3Y2ZU9hMnJp?=
 =?utf-8?B?OGt5N2hUdHd0MllCb2c1YWdsVFNoK1FIVGord3hZcm1nbGhTRjg5elJsZERN?=
 =?utf-8?B?YUF0RU1MTlE5b3NWWnBxWEFxVktQUkxPKzR3WmhoZmd0ZU16cWtJTWJIeUI1?=
 =?utf-8?B?RnVNblhQZEFMdExPRkRncEphWkdxUWp5OE0zN2llMjB4RmMrTGNZY0VsdG1n?=
 =?utf-8?B?YnFyWCtnNUZSOS85MENON0JNdzZpdHhwcGxmbG1HVFE2R0UvazN4NmVENFRy?=
 =?utf-8?B?MG1LLyt1aGlNc2FzWkdxVWhtL1paaVNLb2Y2WXBGZ0dybk5QbC93Z3lXZVE4?=
 =?utf-8?B?aFpRQXZZTTYrTmg1NmVBY3J5ZklYWEo1dkRGUTZOSm9xR3pZOTVHblgrQ2lj?=
 =?utf-8?B?ZkxjUm55NWE0aUE0YU0yeTBBNzNQTUx6LzZpODFhMUNIU0NQKzNJSjBFZFo2?=
 =?utf-8?B?enJiQWJ5M2owZWtBMDBuNjdsbmRWM3U0L2hKQmE1eEo5TDRqcmpiTFJFTGVL?=
 =?utf-8?B?M1cxdzFCZlNxZzhBQzVQb2VjTUtjMSs1RUU3MXRLK2x6OVZMNE02dTRCaTVL?=
 =?utf-8?B?UWkrWmJkcng5Z3NRYVB0UE9QZXlIZzNHZjNENStDMW1lM1l3Y1VmUU9PdEp3?=
 =?utf-8?B?NCt6UlZnTlZpQkhtbWRIY2tPa0pnbE5MTkNobFNrNTY2MUdZVzJKeWh6cHl4?=
 =?utf-8?B?OGZpUWkrd25RL3hZSS9oMXNSVjQ2QVRwcnVxcVlpUjcrcVhIZkV6M3ZsYkNB?=
 =?utf-8?B?QmdER2t2QVlBaVdFUnN1czY1aTRnQ2Z0bE9uamI5L01nOUJsWk95eTNFTk50?=
 =?utf-8?B?ekc2WmhiQXZ2QkhRK0kyOVZpSzRHc1pUMlZSOTBYZlJEcmJNUXNDSkp0cksy?=
 =?utf-8?B?YWtiMlRRMWFER3MwQlBOeVlGd3FmMTNyeC9aRlNqc1pVT3d0YjhxM1pXQUIx?=
 =?utf-8?B?eFNzQkpxL0RTcHM4Z21xeHRMTGVOd2MzNGx1dWZ3dWNDRklDMEhpNkxhUzBq?=
 =?utf-8?B?cW1TazRNT1lHVTN3aUFxRnZ3bTE4THZRZmN3eDVTamhONndHbkZvQnE3UUZY?=
 =?utf-8?B?RDQzMTJwbHNHcXBuUjBNaVB5QzFGcHlCN2dUM0taR0kvVk5lN0lkQzV6NzFP?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa9e858-9af3-43f2-63c6-08dbc13bd8aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 22:31:38.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p5ZmeVSl8zdeL8Ox9E/oHCVA4dB5CK2DND+EdfAOXSyxvQmy55574aUPnKcQwHmQ5RHQx7GWTtvU+0s5/sIBngVijYUG+a7d6MQLxEmbpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

In subject: ksefltest -> kselftest

On 9/22/2023 2:06 AM, Maciej Wieczor-Retman wrote:
> Kselftest header defines multiple variadic functions that use printf
> along with other logic.
> 
> There is no format checking for the variadic functions that use
> printing inside kselftest.h. Because of this the compiler won't
> be able to catch instances of mismatched printf formats and debugging
> tests might be more difficult.
> 
> Add the common __printf attribute macro to kselftest.h.
> 
> Add __printf attribute to every function using formatted printing with
> variadic arguments.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

With typo fixed:
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
