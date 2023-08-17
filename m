Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8FF77FB18
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 17:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348141AbjHQPpv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 11:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353302AbjHQPp0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 11:45:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3B830EE;
        Thu, 17 Aug 2023 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692287124; x=1723823124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SzS1mQYsXzU6D1JgL9LloEFaNbPJ1o0ruNq3erlyY4o=;
  b=I8kZDmC6cZEC+yX8pbT92LgRxTFWhCHqzM/qAN12j34ej/LaXXK8FUnV
   PxtTDaPdhPd3lD2gFtkRqs60WVs5zT0ymKp88ut7lNpkIbXT8iV7/J2vf
   oLC3TxnDYEmukUIRClmP8oEE2+i/CPNUFg7vE9JMg8Aq63vEu1tkkbscm
   AmfNLA7cqGVhHuZJ/srWtkmu5OFiZhbp6eGFjdS+3++oBEfqlX8yqfR5D
   51rdhiTYTQJ/HVPQzAXYaa6k/JudcoPxmxPlMgtxyDMUqZ/cVAws4gbBx
   lSpQAZZlKgiXWgfsr9/5mDluMxLKPxd0zAyrf0MSz8JxbVHbu7ovSsGuY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="459207600"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="459207600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800104154"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="800104154"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2023 08:45:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 08:45:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 08:45:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 08:45:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 08:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfCzYVMaXIOYRkayur06BXr8uNlu3NkDcm15DUVWHV1s+MrpIdVMjhdj/4wscOstcxh0xYclYhiDoG3oaV1f2OXrMHBqiOzTRLvgdaBufFtekbchbEF2Fd/Wkb9IB4mwRmMLntMF9FAbEPt22dKgQZZKNEyP9NM6bwpOpZVt18xGwwZ2xnJ3i+dMejJ89hmFA65F0XaPoKYDHOSJ+2lWPmtRoVl9xwFLcDDmsps0Ja8tfoEs9qFi9B7tqkJzW0ONYD/MOItVwLLEfJ4Ei52vBhVxhFpiTcMx57Ma59vGMMo17AR1ZvlhwWTvMsqeWzWc2kCd141WjhxpeJ0NwVx/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRUXchkZGNc5irjCPhiuiqYzwBlFm0AddfFOQj2a+Kw=;
 b=hWylbOs2CpBdtrwfxOMb6ay1Ko9FAq2khusyfyLPejeRns/FIeEVkjJTKej+vKOo4AklzrpvV6F4ePk1pmIp8AW8sp9EFG0tescxhMcOqTiDiPUnYyfP0waCHAkbsZHmI5TSjSS676AqWyoOr7EzpNAghtIOjP9dzfEqs5zeoCC3tfR4if5ZoeKSnqzCylHqQDEEPfZ3Gi7oHrQy3nx/uDFIHlQMoDgl/gPu5LiqCgTI80R6RNFqTaqJTLb9QQnMTQvyAoVafUNN2I3H4qZK20RL2dw4lRslbnrxNPwOupqttmzU1chDhT/IUXTrBviUGAsrSGh5ocDzmdR7iD35hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8324.namprd11.prod.outlook.com (2603:10b6:a03:538::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 17 Aug
 2023 15:45:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:45:21 +0000
Message-ID: <0587c078-306d-e3b4-ce5d-bcdfdeb66d27@intel.com>
Date:   Thu, 17 Aug 2023 08:45:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 5/7] selftests/resctrl: Use pointers to build benchmark
 cmd and make it const
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-6-ilpo.jarvinen@linux.intel.com>
 <f300a52c-d65f-fd74-18ce-7d37e76d144f@intel.com>
 <dd83f672-b9fc-cd79-10ff-70651d4822af@linux.intel.com>
 <87183b24-f343-2420-9bda-f1012e7195a1@intel.com>
 <f22efaf4-d87f-d3c4-b986-7d326c912a18@linux.intel.com>
 <bacc2e6f-f747-ec65-b23b-4275d1cac018@intel.com>
 <c8b7118c-5830-98a0-5ae-66072e384b3@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c8b7118c-5830-98a0-5ae-66072e384b3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:303:2a::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b107062-2307-4515-62af-08db9f38f6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOKiB/dSqqvekAD7qj6SDb/eL7pCyOjEkG7fiwk/3a/O8zqFNeZC6okiaFpS63Aa3QnONRUyEEq9UJ7UTXvh6Sa2VkuscAdhmes2gFcu3XerWcekdULIUmZSUsJ6GImIcJrKxQNjxHV/xiE9yTobyCoGz1BxWlBZO2N9SdprYFJmyCtjHal+X2jiG44rQ/nURzas9QtN2VCmlnEgNUqe1VOFyNnbH0Exs5dptjZxaobjsmIEKGOURQMOg9Y+j6gmwxCN35xb92k0M92eYS5i7u/riUVv39iwhkwYo9jHDx4EZIRulklu5JXWIWurjioKvbofvkj+dZDWuSb9dfE9VK/4tnxIdnH542cpJhrfxj4WRFc3CxfDlP+1PAsMTHexrLHwt6S/FTg3cvQ0aI/aGKXx9GYlqhrCwMiX+7JQtPeFZ+ZsV/B6cfXGgvCkcFL0mmSHFuo/ZY56hHJCyX8VWQkXWOUycEuL30QBD+IMqKNDOd9+pZ5EZFor6BZULgFn1K0yT52sYPk+3kxDEe281tIOzx4T+3RHqKPg0Vu2DKfBJeLI2ju3i9iBWWx70OAUGqK6tD68yKQwiR4AOrPAx/4jyIteRj7uNBVmnZhOuhvr7J21XMTfyozKodck2OQJUttjoTZOj9xDXSrqcpz2Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(31696002)(2906002)(26005)(86362001)(478600001)(6506007)(36756003)(6666004)(2616005)(6486002)(6512007)(53546011)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(6916009)(31686004)(4326008)(8676002)(8936002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dytFbVlsTHg1NlBwSDVtRjB4d2ZTVHkrSFg2WitVL3JyMnZPYWMrcTR1ZVJY?=
 =?utf-8?B?K0ZSMm4yRmJEWTZmREFleGlNRjlHZ09lalUzWVpMNjhxMnRNV1FrZGZSRHFX?=
 =?utf-8?B?SmZxM1ZoMitPOXFnRjNGNFlEaTZjeHdvbUg2eDFUb25Ia2tDaENPZlQzV1Zv?=
 =?utf-8?B?T0R3OUZlSkVRZldCdzdXTnRRUGlDVkVMdTJWNUp5YVBadXpqZ20wTU5ZRnlQ?=
 =?utf-8?B?YlZPNmxqUTZ4VnFQL0x5c2VPeDU1U1JnRVd5ZGF5Y2NaWDdMaEN6ZnoyRUp1?=
 =?utf-8?B?NlRVQVIzTVVsUUlVTFZIN1ZzNDJtSzlnZjhsU3BXZzE4K3E5TTRBRzNoS0Zq?=
 =?utf-8?B?NmJhaHcvd2dNMDdVT3puU1JKVmlJVUx1RUZMUEdqSEM2YmN3bG04OVkrbld5?=
 =?utf-8?B?allLL1ZWS0ZrY3hBWDg3YU9PTFBGOVYzTnZ1Y3dlZVB4cnV4TGhPU1FNMXQz?=
 =?utf-8?B?UitJRnh3K3gralpjVHVqaHM5a2tycUk1bVhLZ1A5cE9GT3RNSHVKYVAwa0gv?=
 =?utf-8?B?V1lhQm9WQjVSM0E3SCtlUWdFWk1HSkoxRE9lTlE4Tjc2bGRZTUEwem5FeWIw?=
 =?utf-8?B?NlZRQlNsMmd4eXFZb2dlMlRNSXFyVzBpQnBFNi9DSDVnOTFWSGtZR0ZjUnFw?=
 =?utf-8?B?SXZZS0l4dXJENG5zNFNsVCtvdHJTUmFYOVVYMWU2Q2xmVndYR2tlSHNDdXUx?=
 =?utf-8?B?eUhtdUUwWERlZGc5RVJNZVFKMlVxVXVqRTlCUDc4alNWaUh4V0dQTE16UzBn?=
 =?utf-8?B?a2FXcitiUEJqRkplRzZGK0c3Z2pnZEt2SjFmazZ5dFJCMnpjZW9rWXpyN0ph?=
 =?utf-8?B?Z0lCSXViN2pJaEdGN0dLZkdGS1dUZGoxL3N4SWZiVGVOT2lKbWF6aWRpdUtL?=
 =?utf-8?B?bXRHK3JkT3VTYWZKdjRFcTRMSmRpS09KekVrTllBYzd3TXg5dHFtR1Y1cXd3?=
 =?utf-8?B?dXhkd0djUmhuVDFTMlZ0RGdXS3RmZUNqY1VEemZWd3ZBQmF4UVRweEQ0cHNG?=
 =?utf-8?B?ekJoUlczdFNsMzg4YW9HM0xkRVRLajBQRjJWdk9oMU5xYmJVMkZVTEpqTU1T?=
 =?utf-8?B?cW1ZbllheDVEZ1ZEWk95WHhHa3U0T25GVm5uUXR4OWIvQTF2YlFqRFhhL1hK?=
 =?utf-8?B?eTlmc3BwSStPdUd1a1FBQ211MDNVM05hSDRaMzFHQnFQZldLUUFJdnRmOTZP?=
 =?utf-8?B?UlhtTGxCdEJqTXlxYlBxRThkVC9rbkJzUXc3NTJ3cGRJVndLRnVadllrZHhv?=
 =?utf-8?B?WkdFL09pTFBua2NjSmlvV3FxU253LzY5dnc4NitGbWxuZkU3V3NFVGxobWhG?=
 =?utf-8?B?eGNvb05CNkFPZVJRcnV3aEdGWnJlRGF3MXlzbEZGSnZ4N0hGL3JBYmx0d2dr?=
 =?utf-8?B?bTVHKzV2SWtIcTFrNDJLNUpUcjQwRUU1dWVUQWVIOWtqQWp0YlpDaE5TUGhr?=
 =?utf-8?B?Q3VuSHFjb29idUlyRngxbmpNbllvNitTeGhTYnE0RytmbDNxY3hjNWNaRW5K?=
 =?utf-8?B?dDRSTHd3QkZPNkJkclYwcXFRY0Q1NjdCSGJkOUxsWUxhZHZxK2lqbldLcS9q?=
 =?utf-8?B?MGdHZ2RaM2c0TkNCMHlrUWx3Um96L1pFSFFjOWNBL2ZaY0xFaVZOKzg1bGJY?=
 =?utf-8?B?Q09TMTVDcDlBRjl6WjhCSmZnRm9iK3ZqTWtxNndYYll4c0lCQkNkQzlrMDVY?=
 =?utf-8?B?azBldUtvcVc5YTFCNGVHZWhlNy83Mm02dVA3MnNuOWhCMnNFc1dxeWxCL1JB?=
 =?utf-8?B?UmpEa3lYZXVsVTE2cXRXN0hHYTZPVmVDd3hHYk81YUpwREI0bDFYa2lGbzdL?=
 =?utf-8?B?aUVRRWVSOEtWeU5TRmpXL3hEMUJSRHQ4TXBUUS9MZmJqN0UwamhnSzh4Wjhn?=
 =?utf-8?B?RkV4TlI5TGRNVlNjcThrSStUVUtPWUxxUWsrcEp1emlkL2FmYzA1MXV5Tzcw?=
 =?utf-8?B?Qmw2NU55c3JpdDMvV2Njb0Jha2g2ZWIzSEdaWTU3dW1wRU9wZHRMak1nQVhu?=
 =?utf-8?B?YVJFYjNSdWZueHI0RG5lRkNQcXI2L2YrcjdLYTlMNkdwWlp0WGlPNzRvV1BC?=
 =?utf-8?B?ZytXY0MwQVhiTjZJaDFpNTZ5SGRZNkFRL3FZVnhTTWhITXdVZXdleHVWTkhK?=
 =?utf-8?B?ckg5alBiWXpDUkJLSEZnL3A2eXBtMHlHRGNqOGZ5R0IvL0IxZXFyZVd5R1FK?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b107062-2307-4515-62af-08db9f38f6aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:45:20.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXKOz6l8r+cEtWABlLJhv0lKANt3ll6HbHkbxTVbysnkr9A9EGrYbNHyXHI6DXoxkZG/X4wGgU+7KNbDWbEfAjzPsQvcsPHDSX/NdlBjCaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8324
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/17/2023 1:32 AM, Ilpo Järvinen wrote:
> On Wed, 16 Aug 2023, Reinette Chatre wrote:
>> On 8/16/2023 12:13 AM, Ilpo Järvinen wrote:
>>> On Tue, 15 Aug 2023, Reinette Chatre wrote:
>>>> On 8/15/2023 2:42 AM, Ilpo Järvinen wrote:
>>>>> On Mon, 14 Aug 2023, Reinette Chatre wrote:
>>>>>>
>>>>>> On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
>>
>> ...
>>>>>>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>>>>>>> index bcd0d2060f81..ddb1e83a3a64 100644
>>>>>>> --- a/tools/testing/selftests/resctrl/resctrl.h
>>>>>>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>>>>>>> @@ -6,6 +6,7 @@
>>>>>>>  #include <math.h>
>>>>>>>  #include <errno.h>
>>>>>>>  #include <sched.h>
>>>>>>> +#include <stdint.h>
>>>>>>>  #include <stdlib.h>
>>>>>>>  #include <unistd.h>
>>>>>>>  #include <string.h>
>>>>>>> @@ -38,7 +39,14 @@
>>>>>>>  
>>>>>>>  #define END_OF_TESTS	1
>>>>>>>  
>>>>>>> +#define BENCHMARK_ARGS		64
>>>>>>> +
>>>>>>> +/* Approximate %zu max length */
>>>>>>> +#define SIZE_MAX_DECIMAL_SIZE	(sizeof(SIZE_MAX) * 8 / 3 + 2)
>>>>>>> +
>>>>>>> +/* Define default span both as integer and string, these should match */
>>>>>>>  #define DEFAULT_SPAN		(250 * MB)
>>>>>>> +#define DEFAULT_SPAN_STR	"262144000"
>>>>>>
>>>>>> I think above hardcoding can be eliminated by using asprintf()? This
>>>>>> does allocate memory though so I would like to understand why one
>>>>>> goal is to not dynamically allocate memory.
>>>>>
>>>>> Because it's simpler on the _free() side_. If there's no allocation, no 
>>>>> free() is needed.
>>>>>
>>>>> Only challenge that remains is the int -> string conversion for the 
>>>>> default span which can be either done like in the patch or using some 
>>>>> preprocessor trickery to convert the number to string. If you prefer the 
>>>>> latter, I can change to that so it's not hardcoded both as int and string.
>>>>>
>>>>
>>>> This manual int->string sounds like the trickery to me and can be avoided
>>>> by just using asprintf(). I understand that no free() is needed when no
>>>> memory is allocated but it looks to me as though these allocations can
>>>> be symmetrical - allocate the memory before the tests are run and free it
>>>> after?
>>>
>>> It could be symmetrical but that means I'll be doing unnecessary alloc if 
>>> -b is provided which I assume you're against given your comment on always 
>>> creating copy of cmd in CMT test's case.
>>
>> I seemed to have lost track here ... could you please elaborate where the
>> unnecessary alloc will be?
> 
> If there's what you call "symmetry", it implies the code always does 
> alloc. However, the logic in main() is such that when -b is provided, no 

No. Symmetry does not mean "always alloc" - what I attempted to covey was
that tracking allocations become easier if the memory is freed in code
that is symmetrical to where the memory is allocated. For example, if memory
is allocated at the beginning of main(), then it is freed on exit of main(),
or if there is a "test_resources_alloc()" that is called before a test is
run then there could be a "test_resources_free()" that is called
after a test is run.

> default benchmark command needs to be assigned, so no alloc for span is 
> necessary. Thus, there either is unnecessary alloc with -b or _no 
> symmetry_.
> 
> But I've already converted to asprintf() so no need to continue this 
> discussion.

Please note that asprintf() allocates memory that needs to be freed.

Reinette
