Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9789D54B069
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiFNMTS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 08:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356752AbiFNMPz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 08:15:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB7326D1;
        Tue, 14 Jun 2022 05:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8Ar/a3WwzbHpgOytoNaFtoNHMugRY1lORlJjEQ6KIJPB8hfDscFE+BXtWOvN7Ow3dxIe2AqIhuaV8hLoC3HIFK0NVDSFgEY4HQC0QnIZf3c/WjH4XJInNMh7KK/FmwzdoVl6OjSKyzdLMF3VdzRgZN4f6QLjyYfhHL/AqNZYLK+hHxFsyIDhMnHsYMtv2pLv+eq3IYw7IF4D1Fnb/KDhK0+5w+5LH521Uybjc1ZhcpESsl86+XWo3AaysK70EAFtYewNWxkX/Bk3IENVNUsyC3PJ0d4GCEUokm66vy44lYoybvOOfyt1ZqMjOBTKSrwQhVlau7qRYcOIHgsHJeqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Bx1UivNzjf3mg/aro47NJr3P633/rSNCtPjp4HeUXo=;
 b=CRLiRnivYzmY/CJosDMB851Im9msBq+tQe8ySMNmH78ArSUDMcMTdQIETB0wJDBl1KMkWORlqjaU2bNNC/R1lTuP/HXSN/QAJ5+O3QPQ4vIzLomhRmGP7afQMIZp81MDgSKSW4lyDiCX/LPJT9tvMtgiimywBwWyL4xN35YKxF0GqTVcE+U5BE43vXqQfQw+KzWZ/Pu4ECKOPWFLNoT5qlv+/qU2JHLgKJ1N0Z644NGCcsxGQ4EzsYIp8cnFiIrR11qRmtTRKY/eJAdG+2yGsK3LOAZjiv31GEKdvvjIa2wZDPp4MRII6CYHouuuE5GeBn0F8+CWIRltEQfAGxyB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bx1UivNzjf3mg/aro47NJr3P633/rSNCtPjp4HeUXo=;
 b=wHAhw9LQtDICFJgT+G6gdBHfv/9aJNEBX4PnGIpRHXNiU2qaDKhRxxsF31By0mC9RSOWiDi52gQEh8tfG84CX59SI99uFpJMDlPBG1cqKPFf5tWfRuygbWdgWMy8GL0Te1jFwhkg8yjrnlNHMTV3//dnro2LVgKVx8nYG41MDs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 12:15:52 +0000
Received: from BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b]) by BL3PR12MB6449.namprd12.prod.outlook.com
 ([fe80::5552:c915:15f5:cb5b%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 12:15:52 +0000
Message-ID: <e1703fcf-c5e2-70b1-cae2-30330108ad26@amd.com>
Date:   Tue, 14 Jun 2022 17:45:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V2] selftests/vm: Add protection_keys tests to run_vmtests
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, akpm@linux-foundation.org,
        shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220610090704.296-1-kalpana.shetty@amd.com>
 <8e7fca3a-096c-7d6c-e43b-9292995ab970@linuxfoundation.org>
From:   "Shetty, Kalpana" <kalpana.shetty@amd.com>
In-Reply-To: <8e7fca3a-096c-7d6c-e43b-9292995ab970@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To BL3PR12MB6449.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e461d4ce-9ad9-409f-8584-08da4dffa012
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB542763DCFA062949F3EAA9C98CAA9@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkftFjrdvmJeZzOJi0I0dLfVckQRJlQhL0TgA9oUizEd1qf79136Ztmg3EGyfGJLHe+8EcwjI6+DijV6yYi5/wztSBBsa87Yklp4/DUuDbP1Ux74v0eqsqtTOstDA/JnhY5NQ/nBc05DqlGz9axk/ph2XoLFcMKZp9l4fFRewHZtZAX3mrWNp2boP5p5m0BcThv0yzf5bZKtIlimZC7Z16VkS82WoslT6PRvwyoSO9CljU2ZcNj7aQOqerKIEFUUGgbt/j5xcSOtRRLS5eHIliPLk7yFghXd+egHSrI1Dh5dOKNsky1QH7UyTs3ab2mfy0d43xgkwkTj4C2xSjeYP/OQyBytYITxdKKWA2KvV+v9smlECj7VZYZQ3Urh14gvv0+HYrC3kj0gJtGcapOw9eK82QtzWW4Nz32AyBmn34VWg2T8WtPBJzDRqaqffDQHA0KtUPMqORnUEM4Vq1H5ntv3QOUYMKnguUxhha9wNeAJTvJdyNda92/duXMyHEcRJeTeeWOd+slU7QU2tKOTT/Qikb2LqLeaQ1RkPCMtlyqA2i4lTgpf2Ujh85k8ADrZKg7UtPiTNeNMyn+z5MR6Q5JCJkAza1YyhsfW+xySEU6oum5qzVsq/wlaZW3bSirUxSPZUHajGYnSyfvdITPqVtM5YiLUDyQQi2P0EaxwJ7e7o7WJ77vm86w9R9iM58ydAmV0FKn4C2ljERZU+ACP26vmvnYsQCiyXJM4C0yB5fI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6449.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2906002)(26005)(6506007)(36756003)(53546011)(31686004)(38100700002)(6666004)(186003)(316002)(6512007)(4744005)(86362001)(66946007)(8676002)(31696002)(66556008)(66476007)(6486002)(508600001)(5660300002)(2616005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXNYcmpIRUtrdVdRWW1SbUYrS1crQ3RjdENXS1pMUzIxdEU2bDQ4Z1BJa2xk?=
 =?utf-8?B?Z3hrSWwzQm40UUxhK28rREw1TlE3aXJIcGs0TUtFcmdpaWZLcDN1RFFjbmxR?=
 =?utf-8?B?Sk1POENtQSt6azJRNXpBbmdvZSs4ZHpXMmJMS3JLcEJrOVk3TCtGN1NHYlh5?=
 =?utf-8?B?bFY2RVhBRUl5elE1MnlCSENHS0FBNTRSM3hrd0hOM1VFNW9nS2VIOFNvNG4y?=
 =?utf-8?B?S2poTjJtUWlQaGJ0MzRHRGZ3N3ZEVWhoT0ZCUWoySElMRUpRcTJNUU51UHc5?=
 =?utf-8?B?Z281QjYyY0djbEVpWEtpQ1EvTmprQUxwUjRiUUFsY3hBZzZUemcxU0F5ekg3?=
 =?utf-8?B?NzgvNjJ0SVpoODRwV0tUajhwVnhTeHVSM0wxUkcwalpPcFZxaE9qNDBvTGxj?=
 =?utf-8?B?ckQ3OXVkY3F3ZnRycWhITVlRYnN5aWZEc2xHVmZwQWhIK1dxQzB5TmR2QmVh?=
 =?utf-8?B?a1NTMXVKL3RpYnRuZ0Z6aC9WbVFBcU9EQ0Uvc1VvL2t6Y2pCRjV1V3pCNG41?=
 =?utf-8?B?QUN4TDBLS05jLzhoazNKaVFaZGNvcXZmcXNsS3ZIOVJpVlVYMTZCd3pnTnNL?=
 =?utf-8?B?eGFpREI3Y3Uyb1RwRkUyNGVxT05taVpaZ1greHFQN2lxZGlValJxR05QWERv?=
 =?utf-8?B?dytCaUVYV0pUSk5rZ1pmcTRVL1JENXVLaVN2VWFLMXI3Z0tLVWxOM21JSzZX?=
 =?utf-8?B?YWlUcTdjNHVnL3U4T0ZEZmRKbk1obG9ZNWxZNmI2WUVMdmRBQzJoaVFpYUFZ?=
 =?utf-8?B?dHBQblVGRTRhMlRqZGZva3NDT0J2WU15YWN6em9yeTJ2TG53TmJDdlVkZGZE?=
 =?utf-8?B?TlFkQzN6WjJWVDRTTVRKTEowUmdIdU90VWJRMUpDNVVwNy9RV2dWODhzWFBm?=
 =?utf-8?B?V2FhYSt1K2FiL2lqbHdiai9aZ0loN283YkZjd3EyVys3SzBOdXZBMnJFS0NI?=
 =?utf-8?B?cndvd0pmajQxTVJLYytkbFFGODRzUkFRays0eFlKNGg0aDZ6M1ZLcElsUHBh?=
 =?utf-8?B?ZmoxVzRaczlhdEFZdEthMGl4dlZPaFBCd1pUMWw2dzNQazkyQU5rNjVTQndV?=
 =?utf-8?B?RXl1c0NRa3MzSy9qemtJNVdqVEczb3Jxbjl4NHhuMWhyamZCaU1ZTjF5Q2U3?=
 =?utf-8?B?cjFSekhyWW9zZjdPWTkybTNvMGdIUWNadDBSUTQxMDRmSktHODVRQjJDTjR4?=
 =?utf-8?B?VDdveVVnSlgzaFhNM0NWdElwY1N0VU5Sa05qcG1SV3ptZS9WVFV3L0tEQkZM?=
 =?utf-8?B?VHpTdG1hWXRtMXhmaC9KeWg5ejhjeUJLREpjMldoemdTa2JUTzl0N1NIWmFo?=
 =?utf-8?B?a0RLMC9LdFc1QXZKTCt0aUxkd2FORGxrWTdmTGdVeVBhODhQSFpxZDdRenV3?=
 =?utf-8?B?YTZlSjI1Z0gyMHFHeHB5YXBNejdLL1dabDZJdWF0RlVMUlh4dVNZblhyR3Uw?=
 =?utf-8?B?QWFxcS9uOHJXSU9LM0NFUDgyRTdXQjhTSHNLUExneXRSTHpnTE9YVHlacldz?=
 =?utf-8?B?WDZJbW4xM1pOd1BydytjL2ljcXdTNm9oRmFYZmZ5RGpnOVZHRUNFMXpJQUcz?=
 =?utf-8?B?MXhkVytuTm5KOGVtbCszR0RpUmN1dXRINndER2pqd2Rlc1JxdTVQVDlLL29K?=
 =?utf-8?B?WFMrYWUxVnoyWlQ1RVlMcU42NlpOcUFjbVIzanoxYUxXcnBqdXpaa3M0dy9o?=
 =?utf-8?B?L2E3aGxvQ2pNYzg3SWFndVpVcFEweWE3LzVxdWl4U3JURUhqMjhVMUYzODZG?=
 =?utf-8?B?TmpKSjlqem00M2tGbklsaW1aLzhjTnJoK3daTDZQL0tQMS9VMkFJc0hCU3h3?=
 =?utf-8?B?NHV4MHNJRHgvYjhhY21nRzhraG41b1UwK1hsd2RRR3FEalVBZmVxZmZzc1Mw?=
 =?utf-8?B?bnJvb2xvUXQvNTR1NEdGcktVU2pQOU5RWlBWM3hUZHhoRGRaRXlNc255NVhR?=
 =?utf-8?B?OUhNVHFLRGE4VzFZc2cveHkzV2RXeXZDUnFqUEJ4b2dBTWFyNUp5ZG5HYlVT?=
 =?utf-8?B?MUtESnV4UHZrYmdHYnJDVzU5NnpRQURtZjlmc1MzaXNqUWlSVHFUMUtERjFq?=
 =?utf-8?B?a2owSTZnaWR3djcvcHlZYnA0Z0xnRjh1Z1BPdDVFdW9ub0FYbTVCTTM5S1hC?=
 =?utf-8?B?ditwaHZXZEdwTVB4S1VrQlE5MzBMVWJwVzZic2pHUXhhaWhMcXlicCt6YVkw?=
 =?utf-8?B?RndOakpzYXd6ejYyMDh3Y0pFT2c0a2dRTk0xSStENFkxekpZTnRhM0NyVGJv?=
 =?utf-8?B?cFpXd2Vld3pLaHdlc2JkdjZDNjdBUEZuT0g1MG1WS1pBalA5cVpScnBkamho?=
 =?utf-8?B?UlliamhJM3pOdDZlanQxLy8wbGw3dU4ydmYvTGJ3a1paWHVnMDF5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e461d4ce-9ad9-409f-8584-08da4dffa012
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6449.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 12:15:52.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxTvmYFE3uPhm+aVcBLd80mxHzAhvUxZyDQxc+fpJc9aJ2WPMszsTSpoR4CMNB92rBalslr+78rkx/U2jA3xvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/14/2022 3:14 AM, Shuah Khan wrote:
> On 6/10/22 3:07 AM, Kalpana Shetty wrote:
>> Adding "protected_keys" tests to "run_vmtests.sh" would help out to 
>> run all VM related tests
>> from a single shell script.
>>
>
> Makes sense - can you explain why you can't just run
> protection_keys_32 without checks? 

Yes; we can run protection_keys_32 without check.


> Why are you checking for VADDR64? 

The check is added to ensure if the system is in 64-bit mode before 
executing 64-bit binary.


> All of this information helps us review the
> patch and give you feedback and suggest a different approach.


Thanks,

Kalpana

>
>> Signed-off-by: Kalpana Shetty <kalpana.shetty@amd.com>
>> ---
>>   Changes in V2:
>>    * Added patch description.
>>
>
> thanks,
> -- Shuah
