Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7086E77B4E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 10:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjHNI6Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbjHNI5n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 04:57:43 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D310F2;
        Mon, 14 Aug 2023 01:55:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B65CB6016E;
        Mon, 14 Aug 2023 10:55:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692003317; bh=VQy5c2/nDDbNkydVW9MBCgI4reVwpfLDVYXeXthZIdc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=e7DCEI/UOd6r521/7QGzvwjK/WqfjX+9opvAic4Dk78wQqmMwxJ3YY46BXZt/KuIO
         dyxNei5zN42Ilrzc3cZ0+ZOZc/dxoueuUDsrqBq6iBsM0UiO8iSbnNAjioI5XZRGN/
         XpUaIqCE/RqXOw+c96rZFklXf6VbOnLDBiJGZtPDpUQuNMnBbCCmoP/Z2dLxM7qCRt
         CyhLxTCt9PFmLRbqbr4DSD2B6enIzY0gD8pFjdCeDMV8KrjIspqSlK1G1gO9DZsLFn
         RsQLn2dRyFUyBpSb0Ge9hMBnAN+M0tcmVnZR+Xv0ItpExEwJqmYld/x5jFELS6f4Ne
         d7n0X9IWhadUA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WsHRS72meZ71; Mon, 14 Aug 2023 10:55:15 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 1E6A46015E;
        Mon, 14 Aug 2023 10:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692003315; bh=VQy5c2/nDDbNkydVW9MBCgI4reVwpfLDVYXeXthZIdc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=J9mdlWg+4NjgO7JfU1U0SkIn9qKTuEae7tsVyBM6r8a+4WzHB6xAMc3c28fWJfM6v
         QMHs86RQZiQwfrPkLNBrlRZpTePFuCJLk6Yy+O3Ki4/NYFE5P+qkFP4215hUd3WD2f
         7uB4XxbLS4M7M2HqOehnU+EJHbywJLU4RL7AzrZsfgZw3UPVT6gNGYwAK6bHlKObY0
         syX4mp6uuliZ9mg1hoTeZIWcMUNLEVwQc4QxN3Wow1lawVB21k6hnVRL812+gq8Tww
         8kA8xhctdSbuuCa/DDsNTCkCUEjCaT+TipAPSR7LJZHR1gCWnzhuUFnCoMPIyBEoGe
         Q0vo+yPU9i1lg==
Message-ID: <39ea7c85-c235-bc49-cd49-a2d7633eda4c@alu.unizg.hr>
Date:   Mon, 14 Aug 2023 10:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: selftests: net/af_unix test_unix_oob [FAILED]
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     alexander@mihalicyn.com, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, shuah@kernel.org
References: <abf98942-0058-f2ad-8e55-fbdd83b7c2d6@alu.unizg.hr>
 <20230807204648.50070-1-kuniyu@amazon.com>
 <ba4da366-b8cf-ca36-e2dc-cce7260cccf8@alu.unizg.hr>
 <25d01cd0-e6a1-1701-a066-f96a23767361@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <25d01cd0-e6a1-1701-a066-f96a23767361@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/23 10:53, Mirsad Todorovac wrote:
> On 8/8/23 01:09, Mirsad Todorovac wrote:
>> On 8/7/23 22:46, Kuniyuki Iwashima wrote:
>>> From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>> Date: Mon, 7 Aug 2023 21:44:41 +0200
>>>> Hi all,
>>>>
>>>> In the kernel 6.5-rc5 build on Ubuntu 22.04 LTS (jammy jellyfish) on a Ryzen 7950 assembled box,
>>>> vanilla torvalds tree kernel, the test test_unix_oob unexpectedly fails:
>>>>
>>>> # selftests: net/af_unix: test_unix_oob
>>>> # Test 2 failed, sigurg 23 len 63 OOB %
>>>>
>>>> It is this code:
>>>>
>>>>           /* Test 2:
>>>>            * Verify that the first OOB is over written by
>>>>            * the 2nd one and the first OOB is returned as
>>>>            * part of the read, and sigurg is received.
>>>>            */
>>>>           wait_for_data(pfd, POLLIN | POLLPRI);
>>>>           len = 0;
>>>>           while (len < 70)
>>>>                   len = recv(pfd, buf, 1024, MSG_PEEK);
>>>>           len = read_data(pfd, buf, 1024);
>>>>           read_oob(pfd, &oob);
>>>>           if (!signal_recvd || len != 127 || oob != '#') {
>>>>                   fprintf(stderr, "Test 2 failed, sigurg %d len %d OOB %c\n",
>>>>                   signal_recvd, len, oob);
>>>>                   die(1);
>>>>           }
>>>>
>>>> In 6.5-rc4, this test was OK, so it might mean we have a regression?
>>>
>>> Thanks for reporting.
>>>
>>> I confirmed the test doesn't fail on net-next at least, but it's based
>>> on v6.5-rc4.
>>>
>>>    ---8<---
>>>    [root@localhost ~]# ./test_unix_oob
>>>    [root@localhost ~]# echo $?
>>>    0
>>>    [root@localhost ~]# uname -r
>>>    6.5.0-rc4-01192-g66244337512f
>>>    ---8<---
>>>
>>> I'll check 6.5-rc5 later.
>>
>> Hi, Kuniyuki,
>>
>> It seems that there is a new development. I could reproduce the error with the failed test 2
>> as early as 6.0-rc1. However, the gotcha is that the error appears to be sporadically manifested
>> (possibly a race)?
>>
>> I am currently attempting a bisect.
> 
> Bisect had shown that the condition existed already at 5.11 torvalds tree.
> 
> It has to do with the configs chosen (I used the configs from seltests/*/config merged), but it
> is also present in the Ubuntu production build:
> 
> marvin@defiant:~$ cd linux/kernel/linux_torvalds
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> Test 2 failed, sigurg 23 len 63 OOB %
> marvin@defiant:~/linux/kernel/linux_torvalds$ uname -rms
> Linux 6.4.8-060408-generic x86_64
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> Test 1 failed sigurg 0 len 63
> marvin@defiant:~/linux/kernel/linux_torvalds$
> 
> It happens on rare occasions, so it seems to be a hard-to-spot race.
> 
> Normal test running test_unix_oob once never noticed that, save by accident, which brought the problem to attention ...
> 
> However, the problem seems to be config-driven rather than kernel-version-driven.
> 
> marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..100000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
> Test 3.1 Inline failed, len 1 oob % atmark 0
> Test 1 Inline failed, sigurg 0 len 63
> Test 1 Inline failed, sigurg 0 len 63
> Test 1 Inline failed, sigurg 0 len 63
> Test 2 Inline failed, len 63 atmark 1
> Test 3 Inline failed, sigurg 23 len 63 data x
> Test 3 Inline failed, sigurg 23 len 63 data x
> Test 3 Inline failed, sigurg 23 len 63 data x
> Test 3 Inline failed, sigurg 23 len 63 data x
> Test 2 Inline failed, len 63 atmark 1
> Test 3.1 Inline failed, len 1 oob % atmark 0
> Test 2 failed, sigurg 23 len 63 OOB %
> marvin@defiant:~/linux/kernel/linux_torvalds$ uname -rms
> Linux 6.5.0-060500rc4-generic x86_64
> marvin@defiant:~/linux/kernel/linux_torvalds$
> 
> At moments, I was able to reproduce with certain configs, but now something odd happens.
> 
> I will keep investigating.

Please not that the bug persisted in 6.5-rc6:

marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..100000}; do !!; done
for a in {0..100000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
Test 2 failed, sigurg 23 len 63 OOB %
Test 2 Inline failed, len 63 atmark 1
Test 3 Inline failed, sigurg 23 len 63 data x
Test 2 failed, sigurg 23 len 63 OOB %
Test 3.1 Inline failed, len 1 oob % atmark 0
Test 3 Inline failed, sigurg 23 len 63 data x
Test 1 Inline failed, sigurg 0 len 63
Test 1 Inline failed, sigurg 0 len 63
Test 3.1 Inline failed, len 1 oob % atmark 0
Test 1 Inline failed, sigurg 0 len 63
Test 2 failed, sigurg 23 len 63 OOB %
Test 1 Inline failed, sigurg 0 len 63
Test 2 failed, sigurg 23 len 63 OOB %
Test 3.1 Inline failed, len 1 oob % atmark 0
Test 3.1 Inline failed, len 1 oob % atmark 0
marvin@defiant:~/linux/kernel/linux_torvalds$

The bug can be triggered as a non-privileged user, but is not clear whether it is exploitable to elevate privileges.

Best regards,
Mirsad Todorovac
