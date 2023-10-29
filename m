Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD87DAE7F
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Oct 2023 22:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjJ2VXl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Oct 2023 17:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2VXk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Oct 2023 17:23:40 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2058.outbound.protection.outlook.com [40.92.75.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13197;
        Sun, 29 Oct 2023 14:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwBUCHu3Xg/cmieRr8RM3bIqXlJzMtkJ5CXUQrXvn1kt/dzP5mCoTDCJwyHh9h8kNUS52cIhvSQByRDVZ/dkuvmlxfODdnlpmXqIQ37MRcneikN4/tcdt9bPIQ29+gPdyDIp7BGQw0uh0mPmczp/B8k4LUCK9V8LZWasAwfAGDM4985nHOu8Q46kYd9LPVdVammrmsS++7Fqqxt7ZyXQzzZ891oy3VgNSgfeedA3h3MYkgj9rdyS1Thmp3SZoM3Ov2Jv9M8GdYnpcCgN4nZcI83x5JZP5n/k3cfXzohXQ4W30iGJWuSVBnSYbV1CScbb+vsP+zqyVxn2/pCWMiufqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M0B9NbUlgDJsAPGo584eNpJCi4+0ld3rxL+zjZdXFI=;
 b=JhV+WnxQmzSwrRKNcwR+AcpcbwKTO/CHgUD6Qbs8mnUTcoxJfj9m7XipoVVAFm+cz1y6yPZ/1NW/MWmHo4mKxbXQruond4InvpboI5PKkJbv8N1H8kaK1rLtpan8hC2ZYfskel/01bILnudzzR4L+Fe/0HA9hWBur0ChrQojgg+09kCQR0HtlD5RI+Tvcqacp+PwrVkfNEWxRPQ2ZlRi+vgy9fqC2Ql8+3TsAo1tOfVEdhm0ahUKHA5N27vEN9/CFU5qnwbCKw/SvlU60txEGACUlKir17zUz3WCJD8zP5STCfloGngtn7MI7C3OcvrH6DbVN7kI0yEoLK/d7ci3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M0B9NbUlgDJsAPGo584eNpJCi4+0ld3rxL+zjZdXFI=;
 b=e6FVjIVacPzOb624JMFzfESIvfwGGKlZDJcEhl5pXVcDC5ll0/qTV2Qf90RP4eTVWujG8wbPunpNFrVoJI/FlSLgBJ9+wqFgpNc3hutn+Pideha5XwQSH/ycwPjGYv8UkCKAOB5loITsQtKAuS58A+Fw4tRwIz6TLBBuB5ymAUTd/IgBO5pv19fEVhURmwLa7Fu0jpvw3HgAdFWV221fcO2c74hM/ZYov5fUizz7z1BW/gQG88hQIG+17GoMHdhY+GssoLCBfpmdf/cJ8eX7Z1MM9jRyn3b2ZZizolEsYOeSalNFKLoL6lqEqg2G6UZOucQ6PMjrwfYh3GnuLD5zjQ==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DB9P193MB1931.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:24e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Sun, 29 Oct
 2023 21:23:35 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::2db3:2c11:bb43:c6e]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::2db3:2c11:bb43:c6e%5]) with mapi id 15.20.6933.027; Sun, 29 Oct 2023
 21:23:35 +0000
Message-ID: <VI1P193MB0752CD67E1432A1CDE48F86D99A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Mon, 30 Oct 2023 05:23:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/cgroup: Fix awk usage in test_cpuset_prs.sh
 that may cause error
To:     Waiman Long <longman@redhat.com>, lizefan.x@bytedance.com,
        tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org
Cc:     cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <VI1P193MB07522BFC89B6B6DC5A89153999FCA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <ed2993f2-4bdc-19c5-5a0f-1e96da44fb24@redhat.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <ed2993f2-4bdc-19c5-5a0f-1e96da44fb24@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [zdfF4qpzxzr+6SiiYHdzaUZF2YASsHQ+]
X-ClientProxiedBy: CWLP123CA0111.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::27) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <d6daf8c0-c827-400f-87d8-5b69eae09e62@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DB9P193MB1931:EE_
X-MS-Office365-Filtering-Correlation-Id: a36c9e27-601f-4d41-6a56-08dbd8c54f37
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27CvvH7Z26NIY5nxCE8+eLM+zNYGonPlm5/329EfLOM0aMfZugofsKKL5BAnStSGipZJWNCM04CszHvQ2pFsujnl7e/MirMBW5aPFxVZLyjXxm6UDJMC8zIGSw0Sf7oDiGEkNsjLf9pqswOgB1eHIPr4xXyuXqKE4R6jF7Wgg4FzA3mwFkVhrgL67KjEul4p+BtcREd90t5ccyXnldUXi24cZt5endn0wq/4423NS3jKCw7ywGnQ8Gi9sTTVig+YMnJyE1c5cn+xRbuz7cM7HXU2mWMFfPp/cugdSc2YhMYAubrX4wDwaO9DJBm3Ty7RxZwiMOYLzdnCazE+/d6SoVcKH4xDExHEjYUuy3hoHcEKGaLoC7gN7NiA/nGamlVPIPaisfC/QL+49JMsnJEGBlsqkpmwfnuq56oDGnfydxuK7vVXm7STU34LdShEOiSZauTvKOO5eHYJwrYUTMu7dqmSaNXhFhFOTGCFMaug0o4xTMhMRvZj14KY0mVzARU/LXFoKx+xvEz4ODgYD9UrCpSfoAQXh2KXCeNP0ypiyaYcnxZeOJC0ugaLrKkls2W8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmlhMkhWd2N2MHVla0hNTWI1b2xuR0NjcTBXRFNTQ2FmOTBhVjY3Z1NtL2Zj?=
 =?utf-8?B?QXIweVF4cVFvdHJJM3dTUkUxR2EzajVxSGZRUTZWVEd5MElUaUVOQ3kvOUZS?=
 =?utf-8?B?elhqbGswMnZqTTR0UU8yQWNzREhXczhkRzJrZlRvcE5VQUFVTTJNUmVTTmVo?=
 =?utf-8?B?WGlzN2wzUjZJZjBldHlGSUNLZUZQczRJSHl3RFhlK3drdVRIRTdYcElOTmM0?=
 =?utf-8?B?ZU5XejN4OFFodjBxVG44TUIvUmVESFBENUcydmpaQkhwSWd0OUFEbjdYNnhK?=
 =?utf-8?B?dkdQaUFDSVYrMHFtTGZTL3VMVldlcTE5clZ2bWlINXZEYTRlK3BXQ2krVVJk?=
 =?utf-8?B?N3hGZ29YNTBLbkwwWUFobjYvQ2ZhZi9USjBkb29FbzNEb3RpVklEVWhQNGUy?=
 =?utf-8?B?OU9oUy9XWmw4eEtOdVZ0emlLc2JWZHM2V2hpbGZSamUzQkJ4TUR0WjJhNkZS?=
 =?utf-8?B?Zk5YTy83MDVuWEVaRDNkc084NE1PM0VCdVFVL1g2cG1xM1ErZWJqa3R4MnlC?=
 =?utf-8?B?L29TQ3RMdXJidTR0eWhUbFR5bkRyaXNOMDBKb1BVZGZabzVrUEZ1V2VIYmlL?=
 =?utf-8?B?U0prVFJsYVdNaW1Hckk3SFBGa1NvN2ZNUnE5cXJFNnVtc1BsL1BDTWVzRmZu?=
 =?utf-8?B?ZVpwM3J4WmdjMnl5bTVJcGVDR1VLWC9OMVdxWXh0eFRTbHd3b3AyUHJNeUpr?=
 =?utf-8?B?dXJHSXFsWXVySkQ2WWNTNmdBQXVDSlgwaENlMDVOblE3QXd6T3FlaHEvcHkz?=
 =?utf-8?B?cytqU3A3TzY5Z3BRSWtZMGFaTGZxQ1pPQ1I0THNQVVFINWpueWZIaHZ5Sjc3?=
 =?utf-8?B?cHJ2R1p5K2Rvc2lGWkplYXVlWDVMdmJXclNvRk9DS1FzL0xxMVZrWXR6NGx5?=
 =?utf-8?B?SGtJcDhOSDlOZDdXRmwwQ2U4SUI4cWZzYzNkbldJK1FYWU9zSUtiMWFRemRC?=
 =?utf-8?B?a21VTkRLYVNCeGZYV0ZHaTJBc09qcXppaVdZNVZEVFkzWVFnRThNY1J0Tll0?=
 =?utf-8?B?bk9qRVhRNHZWVldyMzhWeVRVTUNIbEJlbzhmK1JuWEFCR1Zrc3E0SlhPWmxL?=
 =?utf-8?B?TEZXN1F0ZEZSdGdKb0lRV29RaFhpKzhhTzEzWWxWdjByR3NSeDdGaUlhaExl?=
 =?utf-8?B?c3J5RGdIRnVINVlmbDNZc2xiNmtYRzdHMWlnYU9xMUhiZStQbXBMTStYbTI2?=
 =?utf-8?B?Mkxxb0pCaWdNdDI0MTdVb0pQbExSTGZET0kxS1FabEdzbU81aTN4MWsxdjZm?=
 =?utf-8?B?Z2tlajdTZFFJV3ZBWWxRTCtBc25FWU55a2llSkMxN2Z4WjZOU0xIMnVlem10?=
 =?utf-8?B?bG5UOG5rQnRmT283U3JldFdpWUVMcTI1Yk9NTDM5OHBXZE1IUkpHekgxckZX?=
 =?utf-8?B?Z2VHZzIvUDByNDhOR0FRbkNlT0RsaDdReGZxbTdJREF3RW52YzJzbDBSczY3?=
 =?utf-8?B?U3JOVllCMWdKazRtbC9JL3kvK2JGSjQvb2ZhUldtSjZKUzNVeXhBb2RHMEEr?=
 =?utf-8?B?V3BvV0RQTzlqWlM3RjlQTEJFUWM3VUJHMHAzZjlWdGtERk9HbGxEWjd4T0xk?=
 =?utf-8?B?S3djS0VBb1V3YmFjd3E4eHk3Zyt4Ny9WV0pyUHZ2Mko2bTNXM2ZrSzMzVG9p?=
 =?utf-8?Q?F/ZOhMeutXh5GCw9T/Fzr6vWR8y1WTK0IPkZ6TqzDg2s=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36c9e27-601f-4d41-6a56-08dbd8c54f37
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 21:23:35.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1931
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/26 20:18, Waiman Long wrote:
> On 9/25/23 15:38, Juntong Deng wrote:
>> According to the awk manual, the -e option does not need to be specified
>> in front of 'program' (unless you need to mix program-file).
>>
>> The redundant -e option can cause error when users use awk tools other
>> than gawk (for example, mawk does not support the -e option).
>>
>> Error Example:
>> awk: not an option: -e
>> Cgroup v2 mount point not found!
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   tools/testing/selftests/cgroup/test_cpuset_prs.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh 
>> b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> index 4afb132e4e4f..6820653e8432 100755
>> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> @@ -20,7 +20,7 @@ skip_test() {
>>   WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
>>   # Find cgroup v2 mount point
>> -CGROUP2=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
>> +CGROUP2=$(mount -t cgroup2 | head -1 | awk '{print $3}')
>>   [[ -n "$CGROUP2" ]] || skip_test "Cgroup v2 mount point not found!"
>>   CPUS=$(lscpu | grep "^CPU(s):" | sed -e "s/.*:[[:space:]]*//")
> 
> Yes, the -e option is redundant. Thanks for catching that.
> 
> Acked-by: Waiman Long <longman@redhat.com>
> 

Hi Shuah, this patch has been acked but does not seem to have been
applied yet.
