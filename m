Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475D05EAD5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Sep 2022 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIZQ6L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 12:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiIZQ5y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 12:57:54 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED94C559D;
        Mon, 26 Sep 2022 08:54:29 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1ocqR2-000DrH-9Y; Mon, 26 Sep 2022 17:54:20 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ocqR1-000UV1-VR; Mon, 26 Sep 2022 17:54:19 +0200
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix incorrect fcntl call
 (test_sockmap.c)
To:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Qiao Ma <mqaio@linux.alibaba.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <38269a1610deebf8d51127f15b1c55d00caa4283.1661392989.git.mqaio@linux.alibaba.com>
 <CAADnVQKm-TGJxjwByaMBcvFA_7g+wC2hB+cqkZKhSc83a2H0Pg@mail.gmail.com>
 <6308f39ddfecc_75c920884@john.notmuch>
 <CAEf4BzbqdDUY-1mpGUBk-CpMLAC7jvgRV7rNbgvxr=5nMOsj2Q@mail.gmail.com>
 <632cad99e05c2_3c2b22088@john.notmuch>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b25aae5e-2fdb-3b29-80e9-404002d316b9@iogearbox.net>
Date:   Mon, 26 Sep 2022 17:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <632cad99e05c2_3c2b22088@john.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26670/Mon Sep 26 10:00:52 2022)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/22/22 8:46 PM, John Fastabend wrote:
> Andrii Nakryiko wrote:
>> On Fri, Aug 26, 2022 at 9:24 AM John Fastabend <john.fastabend@gmail.com> wrote:
>>> Alexei Starovoitov wrote:
>>>> On Wed, Aug 24, 2022 at 7:11 PM Qiao Ma <mqaio@linux.alibaba.com> wrote:
>>>>>
>>>>> In test_sockmap.c, the testcase sets socket nonblock first, and then
>>>>> calls select() and recvmsg() to receive data.
>>>>> If some error occur, nonblock setting will make recvmsg() return
>>>>> immediately, rather than blocking forever.
>>>>>
>>>>> However, the way to call fcntl() to set nonblock is wrong.
>>>>> To set socket noblock, we need to use
>>>>>> fcntl(fd, F_SETFL, O_NONBLOCK);
>>>>> rather than:
>>>>>> fcntl(fd, O_NONBLOCK);
>>>>>
>>>>> Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
>>>>> ---
>>>>>   tools/testing/selftests/bpf/test_sockmap.c | 7 ++++++-
>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
>>>>> index 0fbaccdc8861..abb4102f33b0 100644
>>>>> --- a/tools/testing/selftests/bpf/test_sockmap.c
>>>>> +++ b/tools/testing/selftests/bpf/test_sockmap.c
>>>>> @@ -598,7 +598,12 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>>>>>                  struct timeval timeout;
>>>>>                  fd_set w;
>>>>>
>>>>> -               fcntl(fd, fd_flags);
>>>>> +               err = fcntl(fd, F_SETFL, fd_flags);
>>>>> +               if (err < 0) {
>>>>> +                       perror("fcntl failed");
>>>>> +                       goto out_errno;
>>>>> +               }
>>>>> +
>>>>
>>>> John, Jakub,
>>>>
>>>> Please review this.
>>>> Unfortunately test_sockmap (and sockmap kernel) is broken
>>>> before and after this patch,
>>>> so I'm hesitant to apply it not to make thing harder to debug.
>>>> Here is what I see:
>>>> # ./test_sockmap
> 
> [...]
> 
>>>> and test_sockmap 'hangs' (or doing something for long time) after
>>>> #31/ 6 sockhash:ktls:txmsg test drop:OK
>>>
>>> Thanks for spotting I'll take a look.
>>
>> Friendly ping. John, did you get a chance to look at this? This patch
>> is still marked as "Needs ACK" in Patchworks.
> 
> Yep thanks. We are tracking a couple fixes internally around this so should
> have something pop out soon. I think we want the fix and test to go in at
> the same time.

Ok, I'll mark it as 'awaiting upstream' assuming that you carry this fix forward
together with your series then.

Thanks,
Daniel
