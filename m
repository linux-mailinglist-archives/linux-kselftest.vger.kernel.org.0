Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E597542A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 20:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbjGNSg3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 14:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbjGNSg2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 14:36:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651ABC6;
        Fri, 14 Jul 2023 11:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB+o2ySmh/MWUQlFZHrbrRMDZrHsmgxg1yiFWhvp7rwxHI752FylVkqFbkA+hYT1C9lPQTK7HpS7oOfI+MGRQMAliLWKyy0UK6Sil91asBE8Am/YVJIHGqhoUNJiovV5KfvYOtI6GeeUjVY/w7rPiIDwVORb3y3Vqp8XkRaLcqfmT743s32DVIXKT9a/5XwH/18y1DpcCbEh5TyRCgpPrtRH8LIvDw0RxX+Jqp/G2ZXD/tb3mAepHT2JIyxWdupqkbDr0AQ5KicnlrDLmQnVzbouoRUqu9tdMY0WVtQCuz9j5ebY7tAigF1OGUYuLyK5+sPYFcWVWS7d9hXRI9wSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeiY26Gr/0ZdN7UbwOkyeAZp4jheTHUCjbyjG0lSPgE=;
 b=BAf8YfYw6JZFpF6lmyctpzwTYa8vwN/Pc7fjWGHVmDtmgc+GRhgpuZeIhxUQOOGBaIenAQJLOXKUG3O5k8xaJ3rFjBQjI+ZyMfkqQloD6Ccl9GN1khkvoU0PcFhDcnFX+14KkiDqARQZe1/DlKattV9e+d9bb+nWNDsRTDmtVUIrfarqmBL+plKDuY//MIgAW4RiEswQAzTAU/qqn16zEq28DD/KRF30qfJSIQDKMHhVmgffBD0VwFJWk6iEuwy2Ow2n/IIoquPSZgtjdeLiiaTFtcUI+GBVoniLd7kKgacZuvVDncCvhklCgQL5WN3YBv/Tw7f6fStVmKvqka4cZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeiY26Gr/0ZdN7UbwOkyeAZp4jheTHUCjbyjG0lSPgE=;
 b=Z8vwxVB4eEROkDoNH+NEfBr6RWmNW3QSf9yFta1Cra7y4av1XxEyISyY2cE3lFCbfTLbrWNMSv1dWBXTJfg/yDDKTyOPgF9bOVaY7ZN1lJeXwzhbaYeud0zCs39uze+hp9+2DOEPJTORNWUNDfwN4MHP3GXj27L3nOfU25U7QcIk+SiYoIzojr0MpIGkCA5qYVga/w8KqspRasRziu0YnEHiHWGs0fsQARHaT0Ku3XGdg72WDTvDPGBtzi9rTwNUC21/fPYBN7xg08ZZb6936CMoWVifb7HSx12k3btIZ6InysVYsvDooqtoObBWNi+dzppYCwTpni0ZHjUGGmwf8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 18:36:22 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::a8da:fee3:b3db:432c]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::a8da:fee3:b3db:432c%6]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 18:36:22 +0000
Message-ID: <5e5bf5c0-bcda-ec2a-ba4c-5f35dcfbc373@nvidia.com>
Date:   Fri, 14 Jul 2023 11:36:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
 <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
 <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
 <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
 <f479b731-7782-0417-2d4c-31a7c3c9491c@nvidia.com>
 <20230714112653.0b42d3c9818b038d219b5e41@linux-foundation.org>
 <68ccfd77-ce2f-857a-37a7-e9b3edcd495d@linuxfoundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <68ccfd77-ce2f-857a-37a7-e9b3edcd495d@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d69634-dabb-4896-0e86-08db8499379f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G34IMuYZCP5Zpf9p1hmn3N1w64qimXyf4XelgwM6Zu6web8uEQ/pXPepFrYHyz7+OXOCynweA5hhuNL2TKhhYyi7ApCbikVgPWaHuOrhpgP7nw7t1m8f48AyMrQMiZYfPP+gGOaeyVzMeFVOYtRaznX5o/Zhqopv9oiGu6JLZWWZXgcQ4zrcMzo+fxepXNk0RjCXuM0VBbWdDNElF/0m59/My8LcEUQfOCFpvSmpOkUKWDM53Z9jV9qW2b0Ftbo10kdxRR7jRzxtJmF51AnzLu1zJGKH1hhetKVeyItr/i+efPQN2vITAjIXJVVaXKjdWwaVwp/AHzZLtN9ZYlo9DxaVYbiTwaoXLHlCEkp3nNgAErE8MHOVGzpnW6QwwwNsInqaTeSQIv0NU/d/qKFz+5fg3IrsH1qWIB4NncSBqxgHLni2Ch4vTkWS8s3RpQsuZvxuW0J93fGePNQLeXTy91mq2hgK2Fk77mHYXesih/OAkUo5nJTWd9/seaCHVdApWhHrWx7Im7eN/zM8wckpg2lySHgi8rEFTiLE6hSb4ArlmavIlxObJii8PBexj3gzkoILnVW7F/EIzBlWJ+vpuPgCERap3cyTmg4OCWi+r5hLS5XE+iBhTfs1MAH9syH6DBTnWTqwCahFKSAmxEsNkfLqETGoXaZIB9EAJwPeMcZJEFf/ZvRNsZl+TMr4qCQjqKWQHxEL0OXsC0pfQqgUCtU3mXLfNdSysuMEkonkQfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(2616005)(6486002)(6666004)(186003)(36756003)(83380400001)(6512007)(6506007)(26005)(53546011)(966005)(31696002)(66946007)(66476007)(66556008)(4326008)(478600001)(31686004)(110136005)(54906003)(316002)(41300700001)(38100700002)(5660300002)(8936002)(7416002)(8676002)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFhDSmZndE9HSytBakRuQzFWL3hYcFg0L0QwS0R5Zmd6dnFjUTRxWTNxeGdT?=
 =?utf-8?B?WUR5ZDI0MVBJZVBjK1llaEY3WVhMcVNZT2JHYm14UHR5clczVHQ4SWZ0WmxS?=
 =?utf-8?B?bEkvbTJaUUZ6UW0wYVVSMTRqcVI4TUt0c2JCcXF2UGU2cEpWWlFzQWlHL3Vx?=
 =?utf-8?B?WEtrSkVjUjhMQldpN1krT2JlVEtrZDdmWDlzZFFCc25FaVhIcC9KSTRXV2VW?=
 =?utf-8?B?V3FKVGVNYXRBT093S09HZzk1N1F5UDRLRElqcG5iemFIdGNBQ283Ry9HR0ZE?=
 =?utf-8?B?NjBNcFk0d3NYQVM5YURNVHR3c09PbFhVSGlsbnNsZDhVSDJNN0xobFVrcTdk?=
 =?utf-8?B?eVpWUERvSFBTRjZidEoxYlpjaDcrWVM3QTRLeW9aMHdwWkZqeWswaGNweEhL?=
 =?utf-8?B?dkpveVJkdUxYWHB3U1R5OFRIb2wwQ1FBaXNlb2lDWWEyc0UwWmsrNkc0QnVU?=
 =?utf-8?B?MVNkU0ZUQnpzVXVNOWVuTENIWmdZcXVBWUNCdVRsUE9oUjJFQzVMZmJTOUM0?=
 =?utf-8?B?d2xTdzhjRk5hM2kvM09vMG5xL1VyZXRjcms3QmlEWXdjU0Exei9hU2lrUHB6?=
 =?utf-8?B?bXNBTHROaUpzUzM3R3hRTW9kVjZzYXppcFR1c3dHZTNZb2xsd0VIWkVINFN3?=
 =?utf-8?B?d1ZTZnBMcDB2UnJaRFFEaDg2eTUxaXFXNDJ0b3IyeEljOStMVUdiZHJ1R0ZT?=
 =?utf-8?B?cUVQUVF2alN2WjhXWmdsZzBJZFpBRi80a1pDYVpISVEzV1N2NWNENWNvTkdM?=
 =?utf-8?B?Rjc4VTVDY2RrSVpiM1pzUGNRWXFwNHptb3pZa2l5bzFCZkpyTHpzNFI3OXVJ?=
 =?utf-8?B?NzFta25URFZkcDdFZjhLdnVkRHk4ZDFKd0t6R1hQdFhRVHBnN2NuNW02V3Nx?=
 =?utf-8?B?dW16TStKeGV3dnZwSGJKMzNNZDQxc2p6RzcxVC91ckNxZ2lUcDNUTXMzQWZa?=
 =?utf-8?B?dWV1alNaYnlpY3hDZ2FNRmkwdXpoV2dLQVJuMzAxWXZYVmdyeU4zcjhrWnZp?=
 =?utf-8?B?ejRpM0RTL25WOTJaNlZxUEZMVXBwVk8vWVBNd0lUb080ZVNGL0ltSzZnVGFE?=
 =?utf-8?B?dXMxcEFvYzFRbXoxejNrUXMwMWhGSWx5dlQwdnI2dEZ0MVFtYW54R1VHaHlM?=
 =?utf-8?B?WGdyMzgwZzZiRWNtK3ZRTmJJU0UxTHRVWjJtNTVoNUpVelpQaFlRaXJObnVD?=
 =?utf-8?B?S2NYMG5majJQVGJoMks5cXVVUS9ucTBZelJtc2lDQ245aWxpYklsRDFCZml1?=
 =?utf-8?B?ZGFRdjNWL2pRM0htSlVQL0YrTG9waEd4ZFhPODBJbks1WWI4dTF5MU5VQ2tw?=
 =?utf-8?B?bjMrV3g0UE4rYVp6M3lyZnpJNHpLUEw5YTh4ekpSU05RekRtWGZWQTlXbXQ0?=
 =?utf-8?B?aCtRcXZJZmVIbXlBZmVldjI2TTFOTENldkZBV0doamM5SHpoMXI4cWRVa3I4?=
 =?utf-8?B?eTI3S0VzeHZDbE9icFlsYmhBZ3ptQ2RRUXd3UzBkM0JiUVllZjVFSEtwSDlZ?=
 =?utf-8?B?Yi9KVjNVNFZqLytMUko0U1pZZ0wyd3N2VzYyRGR3Z1JiSWx3RjI4Smc5Yzdk?=
 =?utf-8?B?WEV2Qlh3MHp3MlpzQUhBN0xCTzJEVXQ1NVE5MjNLb0dxVysrNmFyRmdEOWJq?=
 =?utf-8?B?ZjJCWjkvODgrN0pBMXJieHNkWEh1b2twZ3hBdTlZQVNaUE9BTjlEcUdEWFQ3?=
 =?utf-8?B?dUhsT3J4aGd5NjFwSjN4c3hlNDJYdEpQUHNrYU1HN0tJM2FKV2M5ZkN0RkFD?=
 =?utf-8?B?N3gzZ2pkYkM4MXFQWTljZlRxZk9jQ05HNjVHTER0d2d2MlJiODNaVUJGblUv?=
 =?utf-8?B?RWwxdGsxSWFzeDFqNElUWkRIQXQ0M01wN1h0SUpsSXQ4NkVRaWNUdEpDZ1BN?=
 =?utf-8?B?WUFRSXg0blFjc1B1bnFHYjQwQnFKYnl0U3VxWDVhaXVzcy9OZ0NFeklaYzFE?=
 =?utf-8?B?V1FiQjZPSlhJL0FId05aZk9LeDJlVUQ1eXNCNU9oWG5wZVRyT2dEZE0rZ2tj?=
 =?utf-8?B?TlNvV09ZWDdOUDhXNEVnSjBZUlc5MXNCcEEzRmVVcFROekQ4VmlYSCtRZGMy?=
 =?utf-8?B?WXo1dHVjT3duaEV0bHFkbXRnZHFyV2tWbHVjc2VXM01CZWtHcUVEbjJGL2h4?=
 =?utf-8?Q?dMN7YNu1Znin+jw8Y2vmvf6yG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d69634-dabb-4896-0e86-08db8499379f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 18:36:22.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvcInNkeSnBJjTzvQmdy61/urHXm5gTCC3+JpQ/dtWtV8GtvVA2cPWJFc56OxcAELgJz0HCHm5GnielpQ4/pDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/14/23 11:32, Shuah Khan wrote:
> On 7/14/23 12:26, Andrew Morton wrote:
>> On Fri, 14 Jul 2023 11:19:11 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
>>
>>> On 7/14/23 11:09, Mark Brown wrote:
>>>> On Fri, Jul 14, 2023 at 11:48:51AM -0600, Shuah Khan wrote:
>>>>> On 7/13/23 14:16, John Hubbard wrote:
>>>>
>>>>>> Actually, I was hoping that my two fixes [1], [2] could be used, instead
>>>>>> of reverting the feature.
>>>>
>>>>> Mark! Are you good with taking these two - do these fix the
>>>>> problems you are seeing?
>>>>
>>>> I reviewed the one that's relevant to me already, the arm64 one, I'd not
>>>> seen or tested the RISC-V one but that looks fine too.  I'm pretty sure
>>>
>>> That riscv patch already has a Tested-by from Alexandre Ghiti:
>>>
>>> https://lore.kernel.org/f903634d-851f-af64-8d9a-6b13d813587c@ghiti.fr
>>>
>>>
>>>> Andrew queued it already though ICBW.  Either way it'd be good to get
>>>> this into -rc2, this is seriously disrupting arm64 CI and I'm guessing
>>>> the RISC-V CI too.
>>>
>>
>> I just dropped
>> selftests-arm64-fix-build-failure-during-the-emit_tests-step.patch and
>> selftests-fix-arm64-test-installation.patch, as Shuah is merging them.
>>
>> This is all rather confusing.  Perhaps a full resend of everything will
>> help.  I'll assume that Shuah will be handling them.
> 
> Yes. Andrew - I am applying both as we speak. I found the right versions
> with Tested-by tags.

Thanks, Shuah.

Just to be clear, when you say you're applying "both", I'm hoping you mean
both of these:


[1] https://lore.kernel.org/all/20230711005629.2547838-1-jhubbard@nvidia.com/
[2] https://lore.kernel.org/all/20230712193514.740033-1-jhubbard@nvidia.com/

?  (As opposed to both of the ones that Andrew lists above.)
thanks,
-- 
John Hubbard
NVIDIA

