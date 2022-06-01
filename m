Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD053A021
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jun 2022 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbiFAJOU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jun 2022 05:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347283AbiFAJOS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jun 2022 05:14:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995563BFB9;
        Wed,  1 Jun 2022 02:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfeSHZe7ae5jNW0RSCODE/c17G/gUd3u5dOEWyI0Wbs1pwndmk9cQT0H9W8dAmnX/AVzgqFr2jNzBuVUojSJUwie8mVelSDgWo3PaiqZTOEfztn7kruILCLbHdOgOsHzi8TQNML8Z6x1Q4Fmdw/ZyNCP87O6AUcseXzpmS7ko/9Mrahgl6OX8sFuXc+EDUMqn7QQqnVG4Unw/K78RkSmRPy3f2/TbbtxlaBZk0Oewa4cElPbPgobSmIgP8EKy+6eKQQx0iIejXscI+fJeRDqNWUPWRPOIxkejHSlWbwMTwJuG300uGuINS0YeLSlr3lqg/7XhX/kfNnpbtU4nJm+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4hxh/Rz2Wpa2nDuJY/l38ZtYFFbGWJ6jto4hxhC/sM=;
 b=QRuFoDgsdp9Psgm4JdEHy9jQr8tBmMCtr4CKpP/BAi+dSuqeO93YSMFDD2Uk0BUqIyZHfeZ1B7FR4vcEJdsPupT6fB0DIg3DeOVsYqQDOWk8zCF/wMJtZBvW2azx9bndZByB/xBXvVDRb7OrcEaj5swGZmax9KQie2+xIE9vhi52c5/Qd1lZi/lqPspeKqaa/n3c1I/R1YEjj9+3wI4bGOXNiuRZrKsuu6ltQJ8ORP0xlT66gXPHP2wKuPO6QTAig16oKPHd+XkYz69tXARUbq5Rnw51SxNQpqKDvNcqCQCaK1TgOP6EbIqUYHwdBYjxKHQO9pqCzo3vCoqeJRV3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4hxh/Rz2Wpa2nDuJY/l38ZtYFFbGWJ6jto4hxhC/sM=;
 b=kdeypeviprKqP/jSLWCvKfIMCrhqShauw9x+eLL48DEuKFEaSKDsKRytELaJgWHXouoQX0hKLiMn2rxisvhfsqP7tsDuGsXBTM9NS8bygIDzaEj4XS+5FRSr1xpd55XDAF+lCgpNNiiPXfxUU+yLijKe1B/i0+QguqJKG4lBqPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 09:14:15 +0000
Received: from BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b]) by BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b%9]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 09:14:15 +0000
Message-ID: <ddc25a85-b2c1-c9e8-d907-159879afca48@amd.com>
Date:   Wed, 1 Jun 2022 14:44:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] selftests/vm: Add protection_keys tests to run_vmtests
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220531102556.388-1-kalpana.shetty@amd.com>
 <20220531114021.25a8ab92ad112a4b9f985ebe@linux-foundation.org>
From:   "Shetty, Kalpana" <kalpana.shetty@amd.com>
In-Reply-To: <20220531114021.25a8ab92ad112a4b9f985ebe@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::32) To BL3PR12MB6449.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 072d166b-c444-432b-d612-08da43af1903
X-MS-TrafficTypeDiagnostic: DM6PR12MB4300:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB43007E7316E2F807B7052DE38CDF9@DM6PR12MB4300.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdUVM7+rMuSS0R44M49C6ZnMJuJhDu45cEeTGPQWnfaS+g1gFs6INo7ZPZr3zLHg10uQLZDhleJXfQFslY/U8nr7QjUCtGPrDGWadZqx0jArO8ceTHIupH1TEyIQl5Jgh9PoaHu71SUqBdHbRYyqkbIkHdGxQ0slK4F3a85kx9qimwPre3IrxXUurrgnh2RPhma6a89H+fFKxDQYwytD5KR5CoNn7erK8I7UvQkrKqbr0BFULgGzx8S8PNOofp14hTcS6SGOChp2pf7pXvGkWnr7Jmy35Bc80vlESmc/1qlKEEygQGkccEudfywZ9UxSmBsUB1CSZl1Vqb1k1uVyDMaXuNE5w5fyGc4qgLqmRysTV+kcUYrfnxTYSAeJL7Bjk0T8Bt7C6CDbbWQgnqUDN6nopqEsVe6AeoRwhkvyAH3jZbdGPZ8jWxXraboD2zSL9AUGMZh4sAyKdvEl7uBKj/LIMB9c7JoQxmi1iPl79pxsX75t0dm0ibD4s9nt+C1oSZouTE88jZK/SBQgYTvG0lFbRqiS+4lLgHKt+axDcBkebghyXCtUjYcR2UuYOjCLA4PHQkzqOaQQAO2Ba66Ys4ZW/gJ9VMziqDlVa+XxKSnTtohFhU1Fo3RJVeGISoieNop0BfUcuaFtX0folq0KHpMf/WCvCMcdeIstgr4iTgaj4kXjZyB055jvR4foJyGTW3N2ZIH61Q6KrVuUr6dhEv0+DBaKo8Cbu8chbK8WPdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6449.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(38100700002)(8936002)(2906002)(8676002)(316002)(4326008)(6916009)(66476007)(36756003)(31686004)(66946007)(66556008)(6506007)(86362001)(31696002)(53546011)(6486002)(4744005)(5660300002)(508600001)(26005)(6666004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHNRT1MvdDMrU0s5VFlDVHJpRUdxdTEweDBoa05Gb3FZelZvcnQzWUIxNXA5?=
 =?utf-8?B?RzlKeVUrQlhUaGl1c2VqL0JaYmhXeTdWaERzTWd3NVUreHBCenk4VTlYZ3VK?=
 =?utf-8?B?TDNsby9EWEhpSEs3OGRwVVpEZUppZjZROVFXSmF0Rmc2NkQ5Um9KNHYyY1V4?=
 =?utf-8?B?WkJrN1E0MWY5VGhub1BrbVgwWFNlMWpjbVgvK3RKTVBEN2pwdUhHY0NyMGRt?=
 =?utf-8?B?VEViT3kvcHl2NEZRa2NyRG41TzlGMDZoVHp3M1NqYmhJMytHY0RZRU5oZ0F1?=
 =?utf-8?B?dTFubGt6eTNnMHRxRmMyRm1ZR0hZdFFSVktjaHp1eHVsRVRQYXo1bktqTXJt?=
 =?utf-8?B?K3Fyd2R2dTJuYW5WMUh6QUsyRUxjYU1FZkQ5NitscG9Gd3N0SGF4VU5VYlEv?=
 =?utf-8?B?d25VOWkzVktDeDNiWkRwR28vMmJmeU16V2xtSmhCb0wzaUp6OWNWd0p0bE90?=
 =?utf-8?B?WEVoZ1dVSjRNNG5ndkx4VWgyTE5mK0FKQnB3aUVRbFVIL3NPS2k1bDQrWjds?=
 =?utf-8?B?UzArUkdSTGs2L0paNFhnNDg2aFo1TXZLTUVCWUVWTDE1MkJLRE9ybGI1WXE0?=
 =?utf-8?B?VHVwa0Y4SVpkMnFFYVVGcS9PUGptTGdmVzlpOTVjMGFSNDJPaDhuTnFzUVkz?=
 =?utf-8?B?R3BmRm1WeEZubW82akhNQmRQLzYzRHdhMEdwMFFBeFRGNzFRbGFwU1VMYkhx?=
 =?utf-8?B?dTk4aUVBUzNNcTYrTm5SN05oZHo5clZPL3lWa0dTMlVacDBmR3lmckRDV25G?=
 =?utf-8?B?NjlyTVErTEorcHJpOVF2M0srYmtQd1ljOEVmand4YW5oVFk2MWEzRXYvamRO?=
 =?utf-8?B?UnRwbm9uS013Qjk4bUh3ZVdldnEwcHBUdktmbERsTjl5bVNBeGlXMXM4UFlS?=
 =?utf-8?B?TmxTcXJvK0Ezc0YzM1NsWk5KNmJLYXhmOTRUOGppZEhORm1Sc0VFcnJKZ0R4?=
 =?utf-8?B?SFJBYUo0RXVhN3VlUWtWLzAwU1dWcHRVeFpnRTB1VVhIYk9Hc2dYbVhrSmJa?=
 =?utf-8?B?cTFIQzg5OTI5S0kvVjQ1MW5sVmVOSVlJQjIyQllwOWMxeWk1ZCtmOVdmdHFG?=
 =?utf-8?B?d3Z5cmxGQy9pWUw1QnFKRWZGR1JzaGtnbmQrb1pHTmlhblkvNkJvUWREY2Jz?=
 =?utf-8?B?SHR3czdvVWZtWFI3RktkeWxpSHRJTzZ4MG52Y2hNd0t2RlQ5bEF5SVRzYzNK?=
 =?utf-8?B?WlJ5ZlF5VzlFZStGRWRVNzVQcWVlL05ETlloYmZ2cHZJYmFYc1hSOUJCVnRJ?=
 =?utf-8?B?dXdyejREREVlM01wZkxWUzFrRXVrWGhua2RvUFNYaXFmNmd4Yi83dVhseER1?=
 =?utf-8?B?Ny80cGpIaXdRQTRqVVdGeERIOWpEUE00cWxBbkd1elFNSmVmTUFVM2NEQklL?=
 =?utf-8?B?T1BWV21rLzR1ZWE5bDYvNUcxMkhWa2dhTlhiWHNtN25zSlVPam4vNmYzVWRC?=
 =?utf-8?B?OUZPTW52bzBJcGJrR1dyWmpsYlFTbVpMT1cwUThyenZyQnBjZjE0eHNaVFhz?=
 =?utf-8?B?OGd3c2NLR0xyejd0UGdmTHJQQUliQ3YyQmFkejBOYjdVTzBOY3p2NEQyRXlK?=
 =?utf-8?B?TXZlWXozOGgvTVd3U1hBSWVKajR4MGd6Uk80NWxMdktpdFpJeTBKdlNyblor?=
 =?utf-8?B?T3VmNGM0dDBUZkhCMUlFTVBRNDFxblRpM2dmb3ZLbk9OM21mS0llWWkzc0lv?=
 =?utf-8?B?eUZsdUQxTVRGVEZ2YUxVcTNDRk10UFVNWVdOaUUwM1hwd1V2MFFNa2VZOStq?=
 =?utf-8?B?enA2SGwvRzI5VFkxQ2tJSlhOTC9JSGYyVXF1ZWRndkVuVFh6Sk9VdmlQeWRy?=
 =?utf-8?B?YnE5cTN0UHk0TkJDVU1YdXhYelVmbzZWVE81K2NuWFVDQW53V0hrb29qdm5J?=
 =?utf-8?B?MVZwVk5rQUlNejU3ZzFQQU5zVTZIaHZlVHB6T1RTdDIxQTlFbzRDanVvTDdk?=
 =?utf-8?B?WFc4anFkOW5GMlJkMzdpbXFYWjc4cTFBODhlKzhlSWoyZVJEbUlXSlpaaGE1?=
 =?utf-8?B?cjBMTDkvRnlkODBhK1FDQXdSZFEzUVAvcEJhanJXVHU0OXJobUJmaEhCMmx4?=
 =?utf-8?B?Y2VScWNWcUVXZUJqeDhyenJVanFrdFluajVkS0wrTVhSL2lGQWFWYTFUT1I3?=
 =?utf-8?B?T29SUmEzTmR4RVZVV09sdy9ZbjY4b2Q3SDI4SDhiNFoyTUs3RHEvZXdRblFu?=
 =?utf-8?B?ZkFFdFFSYmRhNVZ1VTV1Vm5JZCtucUNLaW1MMHhsRlpiUk1YTDhvMUtTd0Z6?=
 =?utf-8?B?NGRIYTByd0wxYVNXMlcyemlvb21BeWQxSG03c1hVQW9CZnI3UFFOczFLNklU?=
 =?utf-8?B?VDg3aXdGeWdOekNXbTA0YlNXNUFCRUxvcWZWaTRZQ0FuRWVSRGpUUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072d166b-c444-432b-d612-08da43af1903
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6449.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:14:14.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6BGq+zkrBGB6D903K+WjjO0EbrpJ4nPL/Adjq2/2Z3jEUPzgAXeoPIpkVVm6vxFaTadsH7C8mN8cjcTD1gruA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/1/2022 12:10 AM, Andrew Morton wrote:
> On Tue, 31 May 2022 15:55:56 +0530 Kalpana Shetty <kalpana.shetty@amd.com> wrote:
>
>> --- a/tools/testing/selftests/vm/run_vmtests.sh
>> +++ b/tools/testing/selftests/vm/run_vmtests.sh
>> @@ -179,4 +179,11 @@ run_test ./ksm_tests -N -m 1
>>   # KSM test with 2 NUMA nodes and merge_across_nodes = 0
>>   run_test ./ksm_tests -N -m 0
>>   
>> +# protection_keys tests
>> +if [ $VADDR64 -eq 0 ]; then
>> +	run_test ./protection_keys_32
>> +else
>> +	run_test ./protection_keys_64
>> +fi
>> +
>>   exit $exitcode
> So we're presently not running this test at all, unless invoked by
> hand?
Yes.
>
> I'm thinking we should backport this fix - have you any idea when we
> broke it?
We didn't break it, just adding "protection_keys" test as part of 
run_vmtests.sh

Thanks,

Kalpana

