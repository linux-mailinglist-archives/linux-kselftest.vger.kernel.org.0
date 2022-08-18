Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9D598C25
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbiHRSzs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 14:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiHRSzr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 14:55:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666A6BFAA6;
        Thu, 18 Aug 2022 11:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P509bn2PtG3xtVX/w63HZatsRnLkwj0teFaTR4ePO17hBAu8Omwe9N3Acg77jMRynGyHeVJcy/SmV1oFP20sgQhi1YbnYlTQTiXqQH/QePKAldBeMZGlTLNHt6kz+FfyhusWr+XDduDIs7a702+t7/CaD8tG511nwWW7IYHyABcqIhv7aFQ93suuPUF0VgFBPmYZYdmwBYXXk+Fpe8BsIWQjixsFA+uFrl3EN6eLtrXZPQQL8yZBWb48mRYVTstamHvcFev+5VTrSnHzuoifYNf5PxZBo4Sk906pAp/IvdcytvxoDS5VfZL4yCpco3M1GqLt3xyvZjzt7xtCVhcXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfB21sXzxaLZiBdXgJI4q6xDHypQmirp5Rp5iExqf98=;
 b=c4YrtlixN1MFiLbcvJP+5GLhRQswJs8hhaa39EP1iGBJp7qDFeoWnaLw4nQLezJBOQJ2bFYctWSpqrO2wS0akyIfcSPVIr+MLPOCSig8gQND387xsMit1xk/3fhjIjDBAd7vluq9X1dZVuxNYYHl+cQWPWbldWnZ9nJNe4ftJyyA+jvEXxF1F/4/hmfNxNX7VcLtuakTtkIXaP8SYN0WJFgO+4oFlcEmlKWU7J+T7LxJrmxTgLKlRfj50aVa7ckkI140rrqu5Ysrm/gWMjd7RHyHXC8fYqtGPM4mbAPj2jA6BQh4g1Yq+9vtKshKjctRLXFmN/9Cdl/nmGpj6nNIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfB21sXzxaLZiBdXgJI4q6xDHypQmirp5Rp5iExqf98=;
 b=XZYnNCs7LY9PjmIHIIFoNRVTj9lDUdqHCJY2agJXo1J+VF96rA8xSa6LMkkEHe8NzuicyHhgvtnaIrANAgVnr/TJmqLsbTPFqwkzc0GdsF4hTMHz38LobUDxf8hcIAq/kerm7c7sTrxBG9JpNe7PthWb0IduCw9RwfsFUmeLUwDduGfnp42WLswZmNXE+pQvzjka9O99x+vvpiraPJnrcXC34eRelMoXsVR8zsflSP41WuoqQ4LEMylE8SppQ2j+LSqMiu5t3b5Co3ZBetKXxdRwCAB/GsDXJQYbx+fOw+LSKPt5LI1fDikLYCBBNLoRPx1+xS5SAzZ0CHNpeXbkzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 18:55:44 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 18:55:44 +0000
Message-ID: <251cf8bf-a649-2812-1aa6-39c7b23d5e03@nvidia.com>
Date:   Thu, 18 Aug 2022 11:55:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] selftests/vm: fix inability to build any vm tests
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220817211356.273019-1-axelrasmussen@google.com>
 <190edda8-1f37-0fa5-1cc1-ada97518698a@nvidia.com>
 <CAJHvVcgktSjo5CncC25+2j1amXvn3TjnsfOCV6CxNDp5joey9Q@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJHvVcgktSjo5CncC25+2j1amXvn3TjnsfOCV6CxNDp5joey9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b2ec4da-c607-491d-b888-08da814b413f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqbIC5w4zeMx4Kr7exBg4Eih7gVGsNk4F1LhXcJe0/Sop0wq4DLThCo0eXoOfcKpmVsFrbb8LHWwjaO9065P5bFaONSNMVjcDrfb4csCG3q9B/W0jFFcBpGxu13JPdK4UzBmENVYxg3/tTwuGPAMRPw1fG6B9Z2BOxhvtbY2dqWAKwEtFIvK+dxryy9QnlSsun9Dt3/czsB1/lEd7t0oO2Mrc4mTdmrJgxXzobeLO7HtMU3NW+EoOrEhgFlKPflxk5dc/gT8R1gKPxp46XaAv8umn+AWqFkrEeIYWq98plsnYnVVDjwc9TkaYc3g3lGj9ggYLpM8fkstyRjVSQWqH/zgE1F/VoefhUD4RfyfddAptxYzy24oZE449MW50/mg/ZZXiGwNsKlbq9jEM0j0fV99NvK1Z80i2wbFoRd3YdGGmnYd6y9ECte4gjSIxDNT2uVbBfP2bnYm2KHp00/8x3pVPmE9/8i7CpLlTj3072ZoGu8H6YO2S1Z9i2Py2MHloujH35XVBm16KosfrVg3hbTAp3cxNQeQuvKSBrnn5ZWFzx3oqXAvYpCjq4nwJqbfEI+R37B0D5vldF0qSNS8ZJR6krSIbGOv1hCc7cYdRLz6RIg4Hv+2ym/cvAwkoqglmIEfCMOHdRa32Y4eWO2bfwz1SLUJLpn4vHVfhPIHo6AeKYYdUVB+M9MG3RuIG+/RnWhfutaGw7VXLnEM6t+OWMj+cqlDW+0RN++7o6hRvHCuOVHXqBx4CLjHq7pS8sEquxtZ/i30lu6f+5jqcMXEJJEw3ESrLWBDWvBqqEPfhJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(54906003)(38100700002)(41300700001)(2616005)(186003)(53546011)(478600001)(6486002)(31696002)(6916009)(316002)(26005)(6666004)(86362001)(66556008)(8936002)(31686004)(6506007)(6512007)(2906002)(4326008)(66946007)(8676002)(5660300002)(66476007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0xVcmhTY2pwbzZaVytMdDdKWjlLNXRQNjdEMU1TUVQ4YWgzbDRPeGxnbUY3?=
 =?utf-8?B?NThBRFJoRlh6S0dqRE1YTG05d0lBNmVhMmIwYXVnWm9yWUJNakRJdmtCYTFW?=
 =?utf-8?B?OU5oTXkrY2NydHpLN2x5aWNKZHhqUkhzNXd6dk95QUd1WURKSElrS1lOMXFx?=
 =?utf-8?B?T2l6U2JjTjVDOFlKSUs0Y0NYMVBIeUF6eC9tZU9HREZsV0lSR05CNEFSYVE1?=
 =?utf-8?B?dm5QWFAvRiszYjB1clVGbVBCMDFlcW1iVWI1MFZBbVE2c3FqUUtzM0ozL1VK?=
 =?utf-8?B?VzR0NU5QZEIzQ0tRTjB2TUh2a056dU1uMkR3UlRzN2lWT0R1UEpJT2pSZUVi?=
 =?utf-8?B?NzdzVEM2bDh1OE5RSGZsNnN3U0F0RTJ1OGZYTGNyVExicE1MMDd0RUhWVlFX?=
 =?utf-8?B?OXQ0RjRRSTJ6cEZCZjR4dndsWkFiYlhPWTQ5anZMclVCbTA5UXgrcUErTjZj?=
 =?utf-8?B?WUtLT0FkNDFpeXd0a1JIYjVQR3lzZUxJY0FGb3FjU1NPcnRiYy9sc1BoeGhN?=
 =?utf-8?B?Z2xONWkxdmxsTldUNVdYL3MzTmZTc2t4SzgyR3RZTTZlRG1aNUxLdTdWY2pu?=
 =?utf-8?B?cHNSRk5YTVc0cTROdWVIdUdWelk0M2hndVcvaG5hNnNOaThPSi91TU5TSyt0?=
 =?utf-8?B?aGZOU29PTnovSXd1TWZXbVh5aDlrcHlPTkF3aDdaZFdlT3FNMTJhY1dNYXZH?=
 =?utf-8?B?QkIwWHo5TGlPVEZIeCt1TUl0RmVEUXFxMEd2Z3pINWxLZmtoNjUzYVhEQWls?=
 =?utf-8?B?MFprcWRlWFZpeXZPc0FObGQzVXBZQmxuMXVsbjlGVit1c1FvWDRRbG81RXFD?=
 =?utf-8?B?bXJPKzQvMEx3TUhMOFR6WVl0akl6WWZjejFTRjJ1K3hDVjROWkRITUlWUTlx?=
 =?utf-8?B?SDcxb3pxeVVTR3NRM0J4WGV0cFpFQmlMSStkNzV5c05VU3diQmgrVmVFTS8x?=
 =?utf-8?B?blgrcGhEK1Z2RTU0ckFnOTJSZUwwUUY4Sk1wRjUwVVBOcDFnaHVZb1N2KzdR?=
 =?utf-8?B?cEduRmRsUTF0Mjc5UU15emx2VnlNWXBXUDBzdkVIY3d5dUF0T0YzT0FJdGRQ?=
 =?utf-8?B?dStLNnlJTTBIWWdMeExkWkh5MWZXMDZpYWliSHFnazVHL2VwR04rNWxOZTVo?=
 =?utf-8?B?N05PMVlsSXo3azVzNmZLQlNKcjFxMnpueWsvWW1QOVppcG9lU1N5bGRMMVUy?=
 =?utf-8?B?bllCOUt6ZFkvTzlPSlVwWFlKRS9kWjJSTmhtT1NXR2xDazBUeE1zNEsxN3lO?=
 =?utf-8?B?Y1lacWNVOUJjVnFJQTk1aXhtZ2lKOTRZdm9BSVJtVDNoTW5TR3BSVFoxUTZP?=
 =?utf-8?B?OHZHNDQ5MXNqeEx5Y0x6TVhERThBSWMvQXNrYlhFdU5GZmFoSXpHZ1lENGd4?=
 =?utf-8?B?bzNqeDdDbTJhSzk0eFo2cXVaSFVZUWtodGF2MjVURmV4cmdqbDBwYjFnWHNT?=
 =?utf-8?B?U3VIRnJzL0h4eDlXM2g3YXpYb1oxRmg4R2pPTnZXeTYvdkk1dDcwWFVUa1Fq?=
 =?utf-8?B?ZVBiWVJ2UTZ3dHRja29uVFZVbFFIb2k3TC9VdzBockptb2pzbklPcksrdDlk?=
 =?utf-8?B?bFlnYTg3ajU1MEhZNjRwbGZMdFNZZDM1OGlTREZTR3hLN2tNZ0U4Qlh4WkMx?=
 =?utf-8?B?UWJMMWg5eFdldmxqaURTMUpnU25LK0pWazljT25iL0xKazBuNUZFT25MN1VB?=
 =?utf-8?B?eks0UWdIYnNycDJ1Vm5VTjdVOVIrem9uRUYybFl4MlFlWTlsOVNPcE1vZ2xZ?=
 =?utf-8?B?OEI2WXhBaDYybm5nMXZPWUZYemxqTDJvMUkyTmNKUDUzLzdaUkdsc3RwYTE0?=
 =?utf-8?B?MFlESUhZV1N0dEdBaU9NL0xuekJKdzF6QjlyeUtOQjJObHFxZHpxQ0ZPS0Va?=
 =?utf-8?B?U0d1WSt4Y3FORGdSbGFFZUFseGVPbHNlWGFZQjB2aVFzbUhnVFZnQWxKY1Yz?=
 =?utf-8?B?YWxnc3ZyWTRBUVBIdDBhMDlnQ3NxbnR5N1FpY21pNHJZalJ0ZjNnc1VvVkx2?=
 =?utf-8?B?ZHNxZ2t6cXZMNjBxaHNqaUZkd2NrZWRvRW01TG9hWjREVEFZNjZNNTZ4SGtN?=
 =?utf-8?B?N3E1N0tJSkJubmphNVRGQnp2eDJ4NmpoUDQraFk5eThFcklOYUxVVUhYblRK?=
 =?utf-8?Q?vfoBtMxzxxq6pEz9mDsN3Ap3C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2ec4da-c607-491d-b888-08da814b413f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 18:55:44.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG4erW98s4+gj9WNy8B8b+0hDLXKkWEXhLUPPIzC0OzyysUf6kMLOLjItYXl89tvEz21uOSGyP39IcoOg6hn0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/18/22 10:58, Axel Rasmussen wrote:
>> 1) I recalled that hmm-tests.c in the same directory also needs
>> gup_test.h, and wondered if that was covered. And it turns out the the
>> relative "up and over" include path is done in hmm-tests.c itself,
>> instead of in the Makefile, like this:
>>
>> /*
>>    * This is a private UAPI to the kernel test module so it isn't exported
>>    * in the usual include/uapi/... directory.
>>    */
>> #include "../../../../lib/test_hmm_uapi.h"
>> #include "../../../../mm/gup_test.h"
>>
>> It would be nice (maybe follow-up polishing for someone) if this were
>> done once, instead of twice (or more?) via different (source code vs.
>> Makefile) mechanisms.
> 
> Hmm, I suppose the way to clean this up would be to have the Makefile
> compute this once, and pass in "-I $(selfdir)/../../.." to the
> compiler so we could just "#include <mm/gup_test.h>" directly?

Yes, it's better to have the Makefile know where the include paths are,
rather than each source file, so that looks better.

But hold on, now I see that selftests/vm/Makefile already uses what is
effectively a src_topdir, anyway! Here:

CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)

...which makes me think that real fix for the original problem should be
simply this:

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 947fc72413e9..d44c72b3abe3 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -40,6 +40,7 @@ ifeq (0,$(MAKELEVEL))
      endif
  endif
  selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
+top_srcdir = $(selfdir)/../../..

  # The following are built by lib.mk common compile rules.
  # TEST_CUSTOM_PROGS should be used by tests that require


...and then the follow up cleanup can use top_srcdir to cleanup CFLAGS and
also pull the relative paths out of the source files and into the Makefile.


thanks,
-- 
John Hubbard
NVIDIA
