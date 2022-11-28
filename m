Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0042563A256
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 08:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiK1H4Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 02:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK1H4P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 02:56:15 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2099.outbound.protection.outlook.com [40.92.73.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A506646C;
        Sun, 27 Nov 2022 23:56:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7Xj0IBPYz/kiytDZg+Xh2iAyLqFRn9awrFp8BsentERkXEGYY0ntG6Bzp4iakf6LkTox8v3SVO45TN8Efmyl4CIosFVuaJU6gaTx0Bsjkyg91F6ek0nOAN8R4yDXO1el0kU24JFHHBDCyBmDNdjFBUXMbc4USQ9eLCP43gNgiXQdoQJ9AwhtA6bm5g//PtjO0zX05i7VlHbNwhk0tcPSxBkJCmnmSDO+ewDSiWc59oGEwlxKl2/knuH0HGUgi/KTHYGp/AbtohKbDd/tj3GNem5IshUtHz4GUBJ0tDusNG0MkE40kaS/atzuGx5Ht8zMRX0ajtMuQ/Xxx0gSZz90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tsHljprj5zD9ccwwLy+InwUIFJemVV1hzmHZqo8RA4=;
 b=Tgn/Wce2X+nMTmr1vVQorLH2T5Y/MiaciOjOzwQJjRWiyM/YQtUf+6aAC8i+8Q/y14jhb1kojF8m6NlPeKpHJfgyavVaAMv/2LIROkKNEhN5dwJvaz7mcqB+YI1v824Vjk2rei4nL2Dl4Oz3UB0l8PybjZG9kpj6haffX0jfL2QPhvEAJUF2yFRb8zu2rjgTewMVe5279tq9xIumR3yCWCFkdTqLci4GGBUGaaZ5dAso9uxYj2p5u5o5rjFk2kB9khKcjUGpT6/cXCWGok/cPRmNaSvvzwmGH7fDi3eKppnmJFF+M5bpp4iiajYgyaoebc/AM/Y+yiq32EdwP++gdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by PAXP193MB2059.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:223::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 07:56:11 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::aaea:aa68:4795:2d10]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::aaea:aa68:4795:2d10%9]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 07:56:11 +0000
Subject: Re: [PATCH -next] selftests/ptrace: Fix Test terminated by timeout in
 ptrace_attach
To:     limin <limin100@huawei.com>, shuah@kernel.org,
        keescook@chromium.org, ebiederm@xmission.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     songmuchun@bytedance.com, lizefan.x@bytedance.com
References: <20221128070454.1850273-1-limin100@huawei.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AS8P193MB1285BCEDA342A074F6A837FDE4139@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date:   Mon, 28 Nov 2022 08:56:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <20221128070454.1850273-1-limin100@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [WLtgMc0FqNRqx/ZaU4hmR7HlcfEQ4deikcVK2aAJExMb9LM2TjzztTmJ8+N64q0L]
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID: <aa00592b-658c-2eae-78da-6e6a59ad976b@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|PAXP193MB2059:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bce4ae7-1a1d-4011-c6c3-08dad11603aa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmwDLhqT4n5n0p5dNIjndWfjL2PgGdL8rOm9tyySns4m2hla93KVq+uyp/CFzLdzLNXgnwM2tfjApuFMXGFL0XGFZ+97AXPFsNikQCRul3x87j88yi+igOWmsw1YCfT5QZ8AsU9y5iKv7yeLlOLXgOFAxWuhWBExaquD3s3IHZIpB6agkzg3LDRMoJElSQEsYX2UDqKOkh8YR1X6xnibqEe9Ohn7fGIX5CIIOGkVz1khDuqhfXMJ//whxaNXBZdVTcEY4/D/lioCbFmzw9YBmeQP+IwCeloDgbO+E2gKSkdpFQLztlE42DH4Wm2sG7DE2AdQduDOrbtHHGInEfV5ySGcokXTkKvGAr5O5YkMUJRUBcTZ5PmYIN+pBmUwprdqeE3u9rXLKDLZssVuND2fCkdxik8KQpXWxz+n7SJNDGfbcpqK8Rij21JE5ZiswVedAMolOz0f/e2VucfF5b63evOnLsC7PHEE5baHxf8vR+4lJqlJ4Dc0fpuNWZBMdwYg+ggyJXlQu8dvqCcYDsJfL9HMD/Mgfw61sQik/1L9+hM93eW/0nNUgtQkD5Y7Ge84OE8W1Anbpa03xe6mUIxp0xCZ2LThndehnhgZxY6kio4bTuKIaKvHEBLIrh0uUvEj9RDixykGZvInh4To/aQPOA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?oPaGm68cZhG56M9u50fq5Qn2a1PiU+HjZGCOb67H+Dz9WqdydvYl5uLt?=
 =?Windows-1252?Q?8kgggoM6Gj/2yUiqsIaj5YhHJg5QbIJ1bSI/YzY4OutsAkoQjmH7iUCz?=
 =?Windows-1252?Q?KVmLM69KgpNVmD1/DddExr39p+sL0y92jWbWjwgxHeN7wAdg/pePtUc1?=
 =?Windows-1252?Q?AQzc3Eugt82RIMzVT6hFG5T4gKw4ywRu6/9+lpk0zCW7kU7JfrZn1W6N?=
 =?Windows-1252?Q?OvsnM4S7mKzyNvQaiPsHVG1AO5RmRMfOjSYsuBqhq5UuUSztSYNJpQUo?=
 =?Windows-1252?Q?1ZveX/geiHqpZtUPA4uVQ5Zn9pwX9POW1RsJtFwBGP5p2Kd+oFLmKXuX?=
 =?Windows-1252?Q?LfPPOIzlZnTD2AVbFdneCp8bVUrEhFEebxXmWH5e6tWZQaoq80zMVdgb?=
 =?Windows-1252?Q?C7oG7fNQMoz/Wk8MT/mvSl6lJ+q7IB+y2COUn+wGnBV5dNqs9rDHvy5K?=
 =?Windows-1252?Q?+WtCsn1BP/r7aO7wCGE40dcWCj1EaREu+R6OtCEk8Ws7Sgd+j1KhN0LM?=
 =?Windows-1252?Q?9W0/jHHXMQePeGJ77XZn62r960hBl20K+h3oaGKTbGjq8WmnNEIYnRUM?=
 =?Windows-1252?Q?ngmIqut1ARNuc4WuLuMpte35GyktFXAT3co6GJZHDgYieXCu2bpzoPhJ?=
 =?Windows-1252?Q?hNjYqpRxf0A3qhfZanSEpU49QO9CB2fmuKlTUn9jeUtKYp4gk4zRed2a?=
 =?Windows-1252?Q?S0My1m9ye/QS54ngNqkTOWpeeKLh6wWp/zLvGkl6SctLgWWKJlc7qWYv?=
 =?Windows-1252?Q?iycvfDhu78lQfRzIl5IToCLUyXUQuDgJMt9WDTb9mulcxLHrzyHXndQs?=
 =?Windows-1252?Q?9ApUnH4TYutAtkWKGcRywZz81YPmYrWiPhz/pWu4LA60w0wtqiCavPBB?=
 =?Windows-1252?Q?CDFZOwEUTAPWB45LXV67/ih3N11GxClvleZWfeXyT0nRwE1WTlLuw0sA?=
 =?Windows-1252?Q?L/ZWfTpy/s3WRP7TztPHgK6SAfH5qPC5oa1+yqwJXwFY5G3y+CzI7WN+?=
 =?Windows-1252?Q?7L092jVVe+GCrWmqAumXkfR47iKIg2KEPN/TPY8yACKN+s9I/gYLHo+g?=
 =?Windows-1252?Q?KjTsiiCiR3IEs3rA7XP7kfpEYG8T9/j4Y13tMVXHiusiVP68Q9EWjbwo?=
 =?Windows-1252?Q?2Ts2n+5ftAgBk3r2yKo+OKQI637p8baJFZx5TQI06a/q+bWsH0JO0S0T?=
 =?Windows-1252?Q?4T1hsPzBYzy896/+2NobY6E2SGSSQTpkjlo6lvYavjNmCFzPD7WJCw7o?=
 =?Windows-1252?Q?w+hsfxabFOIAp2zs6ZbQmJRtWygAdBqficXmf6ilcd1e+arl2tx1Fceq?=
 =?Windows-1252?Q?SfGDYoPmBVBkMuZN3OLkVm5yZLzC86yg0yZhkzEvF/0bLGRg3AyVNK5/?=
 =?Windows-1252?Q?zIG0TgTPcA5UTk5FPMWnKGQmUu5sitYVm1L+w8QdQbpSXLiVgReGDJSr?=
 =?Windows-1252?Q?VGjNdub0WdRzdRNPgb+41A6QiTyxccb0sHI7BZlAKZA=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bce4ae7-1a1d-4011-c6c3-08dad11603aa
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 07:56:11.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2059
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,


thanks for cleaning this up.

Just for completenes:

I have actually two patches submitted a while ago, but did not get any response so far,
one that would make the test case work as it is:

[PATCH v10] exec: Fix dead-lock in de_thread with ptrace_attach
https://lore.kernel.org/lkml/AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM/

and my favorite one, that would fix the dead-lock altogether (and adjust the test case accordingly):

[PATCH v11] exec: Fix dead-lock in de_thread with ptrace_attach
https://lore.kernel.org/lkml/AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM/

Note: I got actually one response from an automatic checker to the v11 patch,
(that I just discovered today, when I searched in my in-box:)

https://lore.kernel.org/lkml/202107121344.wu68hEPF-lkp@intel.com/

which is complaining about:

>> kernel/ptrace.c:425:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *real_cred @@

   417			struct linux_binprm *bprm = task->signal->exec_bprm;
   418			const struct cred *old_cred;
   419			struct mm_struct *old_mm;
   420	
   421			retval = down_write_killable(&task->signal->exec_update_lock);
   422			if (retval)
   423				goto unlock_creds;
   424			task_lock(task);
 > 425			old_cred = task->real_cred;

probably no big issue, I guess I would just have to add a __rcu to the declaration of old_cred.
But similar warnings appear to be everywhere.


Thanks
Bernd.

On 11/28/22 8:04 AM, limin wrote:
> That is an open issue
> Bernd Edlinger wrote the test case in anticipation that all of
> patch series got accepted,but the last patch was not picked up
> for inclusion in the linux kernel.
> How to reproduce warning:
> $ make -C tools/testing/selftests TARGETS=ptrace run_tests
> Example vmaccess from 6.1.0-next source tree run fail on bare metal
>   RUN global.attach ...
>   attach: Test terminated by timeout
>   FAIL  global.attach
> 
> Link:https://lore.kernel.org/all/AM8PR10MB4708E6FF0E155261455064C2E4209@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM/
> Fixes: 2de4e82318c7 ("selftests/ptrace: add test cases for dead-locks")
> Signed-off-by: limin <limin100@huawei.com>
> ---
>  tools/testing/selftests/ptrace/vmaccess.c | 37 ++++++++---------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
> index 4db327b44586..751a41f1163c 100644
> --- a/tools/testing/selftests/ptrace/vmaccess.c
> +++ b/tools/testing/selftests/ptrace/vmaccess.c
> @@ -45,42 +45,31 @@ TEST(vmaccess)
>  
>  TEST(attach)
>  {
> -	int s, k, pid = fork();
> +	int k;
> +	int s;
>  
> +	pid_t pid = fork();
>  	if (!pid) {
> -		pthread_t pt;
> -
> -		pthread_create(&pt, NULL, thread, NULL);
> -		pthread_join(pt, NULL);
> +		ptrace(PTRACE_TRACEME, 0, NULL, NULL);
>  		execlp("sleep", "sleep", "2", NULL);
>  	}
>  
>  	sleep(1);
>  	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
> -	ASSERT_EQ(errno, EAGAIN);
> +	printf("k1:%d\n", k);
> +	ASSERT_EQ(k, -1);
> +	waitpid(pid, &s, WNOHANG);
>  	ASSERT_EQ(k, -1);
> -	k = waitpid(-1, &s, WNOHANG);
> -	ASSERT_NE(k, -1);
>  	ASSERT_NE(k, 0);
>  	ASSERT_NE(k, pid);
> -	ASSERT_EQ(WIFEXITED(s), 1);
> -	ASSERT_EQ(WEXITSTATUS(s), 0);
> -	sleep(1);
> -	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
> -	ASSERT_EQ(k, 0);
> -	k = waitpid(-1, &s, 0);
> -	ASSERT_EQ(k, pid);
> +	if (WIFEXITED(s))
> +		ASSERT_EQ(WEXITSTATUS(s), 0);
> +	if (WIFSTOPPED(s))
> +		ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
>  	ASSERT_EQ(WIFSTOPPED(s), 1);
> -	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
> -	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
> -	ASSERT_EQ(k, 0);
> -	k = waitpid(-1, &s, 0);
> -	ASSERT_EQ(k, pid);
> -	ASSERT_EQ(WIFEXITED(s), 1);
> -	ASSERT_EQ(WEXITSTATUS(s), 0);
> -	k = waitpid(-1, NULL, 0);
> +	sleep(1);
> +	ptrace(PTRACE_CONT, pid, NULL, NULL);
>  	ASSERT_EQ(k, -1);
> -	ASSERT_EQ(errno, ECHILD);
>  }
>  
>  TEST_HARNESS_MAIN
> 
