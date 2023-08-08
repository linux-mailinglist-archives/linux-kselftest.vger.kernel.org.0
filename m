Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E8B774068
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 19:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjHHRCr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjHHRBs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 13:01:48 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0D258F8D;
        Tue,  8 Aug 2023 09:01:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A6E1660173;
        Tue,  8 Aug 2023 10:53:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691484837; bh=tkIdjaCIZxuCMCril+uMFLD30L4EwBbIMx25+pZyiFc=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=VTLtJO2lgounct7FeM0VWk10tM5AnVCMV4tbccq2a60ZGpktif0DKBZ+jtTIYUQVA
         +sUNTnfJBLIF1h/vs9TR07doW69kzMxWd+yVYtw50SZrAcie/VngdXdI56CLL1XL8H
         reHAb/5NnPHwdM5y2jE51baWzrLXsTZQitqxN+wlzg4OMqFaiuKyy8hzb90a4DrAsB
         ifMFQ06sOhXA1VgtuXViMuNwkuybVEhnHL3IVeFOrUNoqy3zewvwXoRpf/nXEM4VuK
         9kpMBrRhvNWkUtbQ0qBzzj/a1I2eqZYy2frVrRgl27TPT8Hexu97JN7tMCbZyHEhOz
         CGZz1dJREIXyA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mWdK7oF-jwBA; Tue,  8 Aug 2023 10:53:55 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id BB78A6015F;
        Tue,  8 Aug 2023 10:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691484835; bh=tkIdjaCIZxuCMCril+uMFLD30L4EwBbIMx25+pZyiFc=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=0PBv/ik5TAMYekzrraheXTmOBkzHPVfCKFbBTr4cLyaU/wGwFwV+Qk/h4kUe9Nj3W
         irzHthPYuUUrelWzDSrSF2uG9OJbth6JsfP69OzdWtsgchBQdXXERWOGHCfZYIzeUs
         nMsTZi+vXGBXIadoE9ZL/SIKI/XYBYsPgba6W4OQRVGE0g22SOPa1gUUiKiXx4YHrh
         GLDbdmUPvt9qF2w6glJL3BgwpRj/E2MIfS49cRaPJhhaCDFu35H9UqfOseyumD3OJ5
         8/Tjzdgp4gR/eCoZfrFsgDyxqwT96XKx/HrEuIB+VjWYuj9vjFz1y6u697+Q8ys18/
         NHxw6XzrbPsww==
Message-ID: <25d01cd0-e6a1-1701-a066-f96a23767361@alu.unizg.hr>
Date:   Tue, 8 Aug 2023 10:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: selftests: net/af_unix test_unix_oob [FAILED]
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     alexander@mihalicyn.com, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, shuah@kernel.org
References: <abf98942-0058-f2ad-8e55-fbdd83b7c2d6@alu.unizg.hr>
 <20230807204648.50070-1-kuniyu@amazon.com>
 <ba4da366-b8cf-ca36-e2dc-cce7260cccf8@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <ba4da366-b8cf-ca36-e2dc-cce7260cccf8@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/23 01:09, Mirsad Todorovac wrote:
> On 8/7/23 22:46, Kuniyuki Iwashima wrote:
>> From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Date: Mon, 7 Aug 2023 21:44:41 +0200
>>> Hi all,
>>>
>>> In the kernel 6.5-rc5 build on Ubuntu 22.04 LTS (jammy jellyfish) on a Ryzen 7950 assembled box,
>>> vanilla torvalds tree kernel, the test test_unix_oob unexpectedly fails:
>>>
>>> # selftests: net/af_unix: test_unix_oob
>>> # Test 2 failed, sigurg 23 len 63 OOB %
>>>
>>> It is this code:
>>>
>>>           /* Test 2:
>>>            * Verify that the first OOB is over written by
>>>            * the 2nd one and the first OOB is returned as
>>>            * part of the read, and sigurg is received.
>>>            */
>>>           wait_for_data(pfd, POLLIN | POLLPRI);
>>>           len = 0;
>>>           while (len < 70)
>>>                   len = recv(pfd, buf, 1024, MSG_PEEK);
>>>           len = read_data(pfd, buf, 1024);
>>>           read_oob(pfd, &oob);
>>>           if (!signal_recvd || len != 127 || oob != '#') {
>>>                   fprintf(stderr, "Test 2 failed, sigurg %d len %d OOB %c\n",
>>>                   signal_recvd, len, oob);
>>>                   die(1);
>>>           }
>>>
>>> In 6.5-rc4, this test was OK, so it might mean we have a regression?
>>
>> Thanks for reporting.
>>
>> I confirmed the test doesn't fail on net-next at least, but it's based
>> on v6.5-rc4.
>>
>>    ---8<---
>>    [root@localhost ~]# ./test_unix_oob
>>    [root@localhost ~]# echo $?
>>    0
>>    [root@localhost ~]# uname -r
>>    6.5.0-rc4-01192-g66244337512f
>>    ---8<---
>>
>> I'll check 6.5-rc5 later.
> 
> Hi, Kuniyuki,
> 
> It seems that there is a new development. I could reproduce the error with the failed test 2
> as early as 6.0-rc1. However, the gotcha is that the error appears to be sporadically manifested
> (possibly a race)?
> 
> I am currently attempting a bisect.

Bisect had shown that the condition existed already at 5.11 torvalds tree.

It has to do with the configs chosen (I used the configs from seltests/*/config merged), but it
is also present in the Ubuntu production build:

marvin@defiant:~$ cd linux/kernel/linux_torvalds
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
Test 2 failed, sigurg 23 len 63 OOB %
marvin@defiant:~/linux/kernel/linux_torvalds$ uname -rms
Linux 6.4.8-060408-generic x86_64
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..1000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
Test 1 failed sigurg 0 len 63
marvin@defiant:~/linux/kernel/linux_torvalds$

It happens on rare occasions, so it seems to be a hard-to-spot race.

Normal test running test_unix_oob once never noticed that, save by accident, which brought the problem to attention ...

However, the problem seems to be config-driven rather than kernel-version-driven.

marvin@defiant:~/linux/kernel/linux_torvalds$ for a in {0..100000}; do tools/testing/selftests/net/af_unix/test_unix_oob ; done
Test 3.1 Inline failed, len 1 oob % atmark 0
Test 1 Inline failed, sigurg 0 len 63
Test 1 Inline failed, sigurg 0 len 63
Test 1 Inline failed, sigurg 0 len 63
Test 2 Inline failed, len 63 atmark 1
Test 3 Inline failed, sigurg 23 len 63 data x
Test 3 Inline failed, sigurg 23 len 63 data x
Test 3 Inline failed, sigurg 23 len 63 data x
Test 3 Inline failed, sigurg 23 len 63 data x
Test 2 Inline failed, len 63 atmark 1
Test 3.1 Inline failed, len 1 oob % atmark 0
Test 2 failed, sigurg 23 len 63 OOB %
marvin@defiant:~/linux/kernel/linux_torvalds$ uname -rms
Linux 6.5.0-060500rc4-generic x86_64
marvin@defiant:~/linux/kernel/linux_torvalds$

At moments, I was able to reproduce with certain configs, but now something odd happens.

I will keep investigating.

Kind regards,
Mirsad
