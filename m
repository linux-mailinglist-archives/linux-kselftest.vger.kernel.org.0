Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1FC7A5B1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjISHhE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 03:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjISHhD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 03:37:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F33E118;
        Tue, 19 Sep 2023 00:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb2D7eMo01qlRDLogSiInHPrP87Vt/Ff2GIPUxI96oYUqClqHmCVV7SwRt5bgNbgW+17IHGnqDoFyOe7u2pjX69DtjYsw9ovcvLTQqCrYNHEXjNbmmclP5F2pGxhn+ap0LX9WDY8258zHPlrxG2Zg0ki4/XikkcFgH2cCP8sCXrUh5Hlru1i5WjE+Srb4l0Rd51hsANoSjVoUQkpBUqUxbcwqzPC7M76axQ8GWowUblciAQbk3xW+n3YVnRdDMGGuQzQ2uTXeRAUgFw9YQG0jPcEOB/4ImM9PfIXwqK0Z0+WMAPcIo+bAwpDxa9iIWvRl4vlLnN2M9J3Eh1nzs2uXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWbJiy/z7Z1GjnxZ6/LuiaNXwtNYqgAbdKiGcWuQhcc=;
 b=oRxs1UkJMKt83lFu+vTezqYEqFBWuZVKEqzaRjXNKxT4etDgZ8u89wOmsRN/rFDGAB4fgrymI6SoMZM9PH51zRiS3ZiRV3JiePTqibrFbEeNbwrwKI05Lg6y3S6Rj2Vis2h36zNDsqQUHTP0384QRioniBZD0ZmACshRlkoi0R7jnMSgUbgIuNGzTv5Rryg7Ipvqs5qL10Mz1pThf3v164ReKssQLHRKeqyQTHJsP0ZFKrE2X4AZ7Tv3Hq/uLrskJ0W7AHnuMGk7z5wgJOd/VwPH+CiU4lyCxdDGjXmRzCh+S0OC56z8X28E4kbuQyvgivtJ8l7JkuRNE+yGHZQUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWbJiy/z7Z1GjnxZ6/LuiaNXwtNYqgAbdKiGcWuQhcc=;
 b=OhHdWMqxo0SBrMhmB6N9400m1U0C+xaGii/8EdylEpaDrvwB3SrZvSmBcSvi5afjlYobzgTBlIOpVUrUrqnWQU7foJyRvkP4o94HHxi/+zIYvfCpejIlZzgQA+LXMUeU/spWZj540wPfGRIuWK1mb5xOWImaqa2HAa7cMavk64Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 19 Sep
 2023 07:36:53 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::208c:3910:f2d8:e43a]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::208c:3910:f2d8:e43a%2]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 07:36:53 +0000
Message-ID: <d4635a1b-2a50-5858-62f0-c58f5b59b0a2@amd.com>
Date:   Tue, 19 Sep 2023 13:06:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] tools/power/x86/intel_pstate_tracer: Use pygnuplot
 package for Gnuplot
Content-Language: en-US
To:     Doug Smythies <dsmythies@telus.net>,
        'Mario Limonciello' <mario.limonciello@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com, li.meng@amd.com,
        shuah@kernel.org, sukrut.bellary@gmail.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, zwisler@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
References: <20230915104057.132210-1-swapnil.sapkal@amd.com>
 <20230915104057.132210-3-swapnil.sapkal@amd.com>
 <00b201d9e819$b2447e80$16cd7b80$@telus.net>
 <2fd025a9-52f3-4922-99cf-82355b0e35fe@amd.com>
 <CAAYoRsUhusVzOnaGHjPoMWYy2_iPFAjFLoCrj6vSX26EHNWGiw@mail.gmail.com>
 <001c01d9e9b0$073fadf0$15bf09d0$@telus.net>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <001c01d9e9b0$073fadf0$15bf09d0$@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::23) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d2c3c2-e896-4b21-359d-08dbb8e33122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbSg27FTtCKaqeLhiuq/et5tj0W7gyGe5KSBxhwYOh77MbeRWFzK/s/uJcC9JmT6h6H0rWyf9hjYT4afmYgU8bMfKnVPv9dM430k029UAQC8SmRQYEcntCFoMp7lGBU2DvXnkM2dRzBcnaN2Jilgt2PJxzZO0F+P0gS0eC0huIs6KgPlxvXuph9cqz+jQkQUhmJn510XbRvZmR9L3jmVRo1WQ4PXKZ1vpSDXcxzK9l3eOD/RpzDkgoKcm1CL7acx0lSZs3pJrjgH+frotD3JmonKp5Gx3zH8D3yK0BxHaLVrT2t1S21/9TvBrLVPU8H5A8W3StYteubC0w2JJ/vArStG/O/pVm7V9PzqO0v1uuQjdgJzaSctGtRNZAm9VaRdVxT8PQeL99jgjF+mkB8eP+HawZfKntFGtCfEnlgLRlzRXeaVup/c/+BhvUjLZu4r0KXrkedn/hpQv9eNoU10EoCOsZRt0tDZ/UkRCyOpXySQIdbduXsk0uyxZx6XkDClYTIUeuR/NiEZlIl26wer6nLPGzcL0ZlO/uCmFsNG0II6/iCeD19JrbYkMVLm9jtzT8Os4/BxR08vngcAJreBbh7Wy6bd/bTYZInMNzy4qab7l0+2q0Rh69MkJLT1ejzEEwbNR5eNdeyhdqnrr0jZtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(1800799009)(451199024)(186009)(4326008)(316002)(41300700001)(8676002)(6636002)(66946007)(66556008)(110136005)(66476007)(2906002)(5660300002)(8936002)(53546011)(6506007)(6666004)(26005)(6486002)(38100700002)(36756003)(2616005)(31696002)(6512007)(86362001)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXpGdENUYm05WXMyeDIwL2pjRW9UMkFITnQzRGM5TWVPSkFXaEdOOENVYnU0?=
 =?utf-8?B?WThvMjhoeGxyelhWNjRkalB4UVRZR0V4Mm1vN3RJaVNUdWRyZkkyaVcvUTEv?=
 =?utf-8?B?U2x2alJpRjZpbDM2MWh4ekxUQUQ4akVBRjlqWmEzZEltUmxJTTNCYldvN1pp?=
 =?utf-8?B?MWZCVzJrbU5DWTVIRGRlRFlyc3BkSnlTNkxZYmdrZVJnU2xJaGlIcE5NOG9j?=
 =?utf-8?B?S2h4dTRxZkErT0dnazB0ZHFwb3FTMGxJK0pJaDVVS2pPY0Z0YnVRWmh2eGt1?=
 =?utf-8?B?UHF0TkpzMjJ4U1hVbUZJdnZlYlJmeGRUUlM3S05La0o3ZGZIQUpDOXRZS2Z1?=
 =?utf-8?B?TGxPSmFPTkt1cENWQTI5QnRFM2ZjSTRkN25uU25MMml5SnJsV2hEdThuM3hG?=
 =?utf-8?B?YWQ3Rlh0ZlNXM3FySDVwbEpPVk94TWpUdm1oakpscVdRRlc1NzBJRFB5MEgv?=
 =?utf-8?B?OWpiQ2t2S015ZVlpVVpMY0JNQVRYY0lFL05GWnNuWXVlTzRjNjJPQXNmTXd4?=
 =?utf-8?B?UjZlRzgva1UvcmRSYnZkU2lQQ3RYcnpIeTVoRHdSTjN6eXVoaWJUVElJQzdN?=
 =?utf-8?B?QndVU1ROK01zSXFHVTE2V0kzTXFBTkFGeUxZdWdTR3F3M3BxR2FpOEF3Z09I?=
 =?utf-8?B?aGRsSmRnbW5EbVNpVWR5N29iNVl0NUhBdjBydUhzR1Z2YVVlcjJzd2RYWFY4?=
 =?utf-8?B?bnF1bks4MFptR0RDSXM0aUlQajZRQTVyNzVvblZybytUdEN4dXQyZW5PamNT?=
 =?utf-8?B?UlR3SUJoZS83R21kczByY29GbGJuc1Z2dFRYNklCL2k5eDNnNXhuUUpvaXRI?=
 =?utf-8?B?TThHSkZicmZlc0l4ZFZYVTJmdi91UVFsRVB4ZDFiTVprMGpCeXpIZ3l5aEJE?=
 =?utf-8?B?eU5OSGtJaEhON1k0b1FMaDM5NkpRcVpmaWlVL1k3czZsdklwWnlDeTVQMEsv?=
 =?utf-8?B?RXBvTGE0cmhlSlVEcUQyMFJTN2NNbHEvRXpKMTZ6OWM3WElFT3k2M3QwZVFD?=
 =?utf-8?B?V1UrYjRqY2QrZTJDQUdNWUJpKzU1Z0xDd3UxOWVBUkMvdEtiWUNpZlhvY0Uz?=
 =?utf-8?B?NnZKUHpTMXJlcGJiS2pua0lYS3pKSEtiSkpuZ3UySmFyTGxmcDd5QUhMb1Zr?=
 =?utf-8?B?cmpZSW5paFREdCtOVnlIYXRZY1hEbXZDa1pFcjhHRS9laUc1anYzRE9GUTNL?=
 =?utf-8?B?UE5xUXdkUFBWZlk3bENqUDRuSEVZYkxHVEY2bjlEVW13VHNDVC95a0RLQzVZ?=
 =?utf-8?B?TEhaVEd1L0FMd2ttYWc3c0NxYzZmMVEzbkE0U2R0bm9NNXJFTFpVZFY3ZEUz?=
 =?utf-8?B?L05uSXNFN2Q3eTJXZDhFN2F6MTJKOUhoWmFlSlcrekF0NlpjUGJSZks0L3lD?=
 =?utf-8?B?R1FxVUNJQkx5LzJEZUo3bXlaeWhya1pvQ2JXZ20vbXVGVjdmbjRNbkUwa0xI?=
 =?utf-8?B?dWdGeTdNS212RTJmeitRcVBvdnhrSDUrdGN5TXgzQnFaSjQ3dnpjMXV6ZFNT?=
 =?utf-8?B?MXNtTmwybHRGb1RHUDN0TXZkMlFodXBLTmlhaVVEQXlsaVR3ZERkVkVzb2tD?=
 =?utf-8?B?OUhMaWFETXozck14NUtmTTcrVXFLbTYvaGhNSmVwUEFQQ00raHdXb3kxd04y?=
 =?utf-8?B?V09JSTdMQW53M3JsVlYvbUpCK2xiWCtJbVl0ZTgrdU5PQ0tWd2w2Rm5PRWxl?=
 =?utf-8?B?Y2ZhR3VXbll5ditZMHFEVThTRkJGYjhVMDNaYjhOcWszQjVvTHdvWUNacHFa?=
 =?utf-8?B?K0dOa1ZjeW0wQ1VzOUFDaTNISU9aaHphK1RIZWUvdVMwTTNlS1ptZncrczVJ?=
 =?utf-8?B?MVZLc3lKVEdxU0QxYlVjTlplUmZOR2xiQi9FODFxSndMcXppMUpNQlFaS3pv?=
 =?utf-8?B?Kzg2RFlaK3hvNHM1TFRKUjg4UGsxSFQ2dzVlOG92YnpYMndoa2liSUgyR1Q4?=
 =?utf-8?B?alNZL1h1c2E2RndaRE4ydDFxUjNyMy9CKys0Q0NEdEU4b2pJZCtBd1B4ZEhF?=
 =?utf-8?B?UlpTMzJ2bk1lRk8wNGpkRkYySUlDL0RDVVJiMjNMZk50U04xWXZVL3B1eGFJ?=
 =?utf-8?B?QnQ2RE50dXJLZEpYSE9Fc2pHSVl1M1NXdndyeXRhRUlwOGR0QmhoMG1hMzBQ?=
 =?utf-8?Q?Ge9JfyEvjrmg+bz9BU77pW5By?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d2c3c2-e896-4b21-359d-08dbb8e33122
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 07:36:52.8421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dpw3r+763tZLqCoYwrGG43aJq/A128gXp0IYUNBI+lY7NQ8A6aRPLCMKnD66GQMR5bivcMdCHA67ryBtFYn0Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Doug,

Sorry for delay in response.

On 9/18/2023 3:13 AM, Doug Smythies wrote:
> On 2023.09.17 15:17 Doug wrote:
>> On Fri, Sep 15, 2023 at 2:31 PM Mario Limonciello
>>> On 9/15/2023 16:15, Doug Smythies wrote:
>>>> On 2023.09.15 03:41 Swapnil Sapkal wrote:
> ...
>>>> Not really related, but for a few years now I have been meaning to
>>>> change the minimum python version prerequisite to >= 3.0 and
>>>> to change the shebang line.
> ...
>>>   Besides the shebang, you should also
>>> use a helper like 2to3 to look for any other changes.
> 
> Hi Mario,
> 
> I was not aware of the 2to3 helper.
> Thank you mentioning it.
> The 2to3 helper only changed one line,
> which I included in the minimum python version
> patch I just submitted.
>
I tried with installing python3-gnuplot and it worked for me. Initially I
tried with other packages in prerequisites and it didn't worked for me.

I will send v2 removing this patch.

>> I already did the python 3 patch in January, 2020:
>> commit e749e09db30c38f1a275945814b0109e530a07b0
>> tools/power/x86/intel_pstate_tracer: changes for python 3 compatibility
>>
>> I haven't had any issues since, shebang aside.
> 
> ... Doug
> 
> 
--
Thanks and Regards,
Swapnil
