Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47122793DB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 15:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjIFNbs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 09:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbjIFNbr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 09:31:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C910D7;
        Wed,  6 Sep 2023 06:31:34 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RgjqC6vNQzNmjm;
        Wed,  6 Sep 2023 21:27:51 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 21:31:32 +0800
Message-ID: <fcc5d688-9d58-3b4c-58de-472330160142@huawei.com>
Date:   Wed, 6 Sep 2023 21:31:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ajay Kaher <akaher@vmware.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ye Weihua <yeweihua4@huawei.com>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
 <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
 <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
 <20230710183741.78f04c68@gandalf.local.home>
 <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
 <20230905183638.2b539fae@gandalf.local.home>
 <9cad73cd-1f8b-2f3f-cda4-99b89a87b931@huawei.com>
 <20230906072759.4e8bee1c@gandalf.local.home>
 <2667182e-691e-2ab4-4c2d-a47d76f38107@huawei.com>
 <20230906085621.6e20db28@gandalf.local.home>
 <20230906090252.36219543@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230906090252.36219543@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/6 21:02, Steven Rostedt wrote:
> On Wed, 6 Sep 2023 08:56:21 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Wed, 6 Sep 2023 19:57:24 +0800
>> Zheng Yejian <zhengyejian1@huawei.com> wrote:
>>
>>> BTW, I do reproduce with following testcase fix, then just run:
>>> ./ftracetest test.d/instances/instance-event.tc
>>> diff --git
>>> a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
>>> b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
>>> index 0eb47fbb3f44..42422e425107 100644
>>> --- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
>>> +++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
>>> @@ -39,7 +39,7 @@ instance_read() {
>>>
>>>    instance_set() {
>>>            while :; do
>>> -                echo 1 > foo/events/sched/sched_switch
>>> +                echo 1 > foo/events/sched/sched_switch/enable
>>>            done 2> /dev/null
>>>    }
>>
>> Ah thanks. I didn't have that on my test box :-p
>>
>> Although I'm still having issues reproducing it. Do you have anything
>> special on your kernel command line?
>>

I can reproduce it on qemu, boot command seems nothing special (replace
${kernel} with bzImage path and replace ${rootfs} with a ubuntu image):

qemu-system-x86_64 -M pc -m 8G -enable-kvm -smp cpus=12 -kernel 
${kernel} -drive file=${rootfs},if=virtio,format=raw,id=hd0 -fsdev 
local,security_model=passthrough,id=fsdev0,path=/home/test -nographic 
-append "rootwait root=/dev/vda rw console=ttyS0 rodata=off"

> 
> Also, which branch are you testing? What's the sha of the code you are testing?
>

I think it can be reproduced after any commit after commit
27152bceea1d ("eventfs: Move tracing/events to eventfs")

also can be reproduced with the newest:
65d6e954e378 ("Merge tag 'gfs2-v6.5-rc5-fixes' of 
git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2")

And revert commit 27152bceea1d ("eventfs: Move tracing/events to
eventfs"), the issue just seems gone.

--

Thanks,
Zheng Yejian

> -- Steve
> 

