Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFA7734AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjHGXMc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjHGXMU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:12:20 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B83C33;
        Mon,  7 Aug 2023 16:10:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A89986016E;
        Tue,  8 Aug 2023 01:09:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691449765; bh=5kH3G7SOdJsK3v0zmGHR2YGa5sxralM4yYJ6vyKKQF8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MIZSO1E4Q9EAcqYFHs4xLh7tvjSBsVZ5cxD7d3uGFQBIBgiAcTuSsPS9BiRHw8eOJ
         BkFCwZEulYD164KZNT4R7tmjH+PG6WG87PvFrJPOhVMB7KTwcOAUmzWmIRiZkIez/4
         FpB0XlNtcUm3CxZAnEEM6Lq+CbxxQANKGCF6A5jij4yNvmx+/PUETdvafMhPDJFuac
         4tsA+H+ceofSjDP+FsQGYNKpfR5MEz3HL1oBuR/d9sQrD1sgYUZsEf6Z3lRJCYb7D+
         Z6nMEOuoTj8IhcvrejgeMMpbwMU4uWIwqLlSJVX5b8wzEEW6HDp0aXilgHaB+VbYn8
         fNNNkvxMVaVHQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hJz7glUKPKCV; Tue,  8 Aug 2023 01:09:23 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 8A7946015F;
        Tue,  8 Aug 2023 01:09:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691449763; bh=5kH3G7SOdJsK3v0zmGHR2YGa5sxralM4yYJ6vyKKQF8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=z51qnLKhhBZGiD0+HvaTrQsNIDgkAgAj2HRABb68liPOwvh3zfwwhMXC75gir+1lg
         n9QgWhaDdk6fJmo9ZhJLQryileun0o4rXRyHXtvypXZSjxacIOCCX8DAJWdqwRiU08
         +9G9sCZ1AJFsGvTMFNit1zYDeTKYKjihsTtQmx/UO5wc/O0uH6cY2OMXJBzRy9NiOG
         L76+hihzAm2XkvBtA7L0q82vwve+E0MxpPbl4BwN/zWVzp5eT7aLKMzzMXpFZ7MpGo
         JkrFIieEct8+pe1sXhXwKLNaIy2n04SydrM+zH1e7GN7q6Tm+AAscJEM4xFdDsq+9s
         +W97wZsxowuLw==
Message-ID: <ba4da366-b8cf-ca36-e2dc-cce7260cccf8@alu.unizg.hr>
Date:   Tue, 8 Aug 2023 01:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: selftests: net/af_unix test_unix_oob [FAILED]
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     alexander@mihalicyn.com, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, shuah@kernel.org
References: <abf98942-0058-f2ad-8e55-fbdd83b7c2d6@alu.unizg.hr>
 <20230807204648.50070-1-kuniyu@amazon.com>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230807204648.50070-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/7/23 22:46, Kuniyuki Iwashima wrote:
> From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Date: Mon, 7 Aug 2023 21:44:41 +0200
>> Hi all,
>>
>> In the kernel 6.5-rc5 build on Ubuntu 22.04 LTS (jammy jellyfish) on a Ryzen 7950 assembled box,
>> vanilla torvalds tree kernel, the test test_unix_oob unexpectedly fails:
>>
>> # selftests: net/af_unix: test_unix_oob
>> # Test 2 failed, sigurg 23 len 63 OOB %
>>
>> It is this code:
>>
>>           /* Test 2:
>>            * Verify that the first OOB is over written by
>>            * the 2nd one and the first OOB is returned as
>>            * part of the read, and sigurg is received.
>>            */
>>           wait_for_data(pfd, POLLIN | POLLPRI);
>>           len = 0;
>>           while (len < 70)
>>                   len = recv(pfd, buf, 1024, MSG_PEEK);
>>           len = read_data(pfd, buf, 1024);
>>           read_oob(pfd, &oob);
>>           if (!signal_recvd || len != 127 || oob != '#') {
>>                   fprintf(stderr, "Test 2 failed, sigurg %d len %d OOB %c\n",
>>                   signal_recvd, len, oob);
>>                   die(1);
>>           }
>>
>> In 6.5-rc4, this test was OK, so it might mean we have a regression?
> 
> Thanks for reporting.
> 
> I confirmed the test doesn't fail on net-next at least, but it's based
> on v6.5-rc4.
> 
>    ---8<---
>    [root@localhost ~]# ./test_unix_oob
>    [root@localhost ~]# echo $?
>    0
>    [root@localhost ~]# uname -r
>    6.5.0-rc4-01192-g66244337512f
>    ---8<---
> 
> I'll check 6.5-rc5 later.

Hi, Kuniyuki,

It seems that there is a new development. I could reproduce the error with the failed test 2
as early as 6.0-rc1. However, the gotcha is that the error appears to be sporadically manifested
(possibly a race)?

I am currently attempting a bisect.

Kind regards,
Mirsad

>> marvin@defiant:~/linux/kernel/linux_torvalds$ grep test_unix_oob ../kselftest-6.5-rc4-1.log
>> /net/af_unix/test_unix_oob
>> # selftests: net/af_unix: test_unix_oob
>> ok 2 selftests: net/af_unix: test_unix_oob
>> marvin@defiant:~/linux/kernel/linux_torvalds$
>>
>> Hope this helps.
>>
>> NOTE: the kernel is vanilla torvalds tree, only "dirty" because the selftests were modified.
>>
>> Kind regards,
>> Mirsad Todorovac
