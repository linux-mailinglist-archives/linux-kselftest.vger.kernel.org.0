Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9ED796E42
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 03:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjIGBBi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 21:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjIGBBh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 21:01:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE4EE8;
        Wed,  6 Sep 2023 18:01:33 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rh19V427qz1M8v6;
        Thu,  7 Sep 2023 08:59:42 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 7 Sep 2023 09:01:30 +0800
Message-ID: <eb050960-b2bb-4dbe-7879-a0dd3935556e@huawei.com>
Date:   Thu, 7 Sep 2023 09:01:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: "[PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc"
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     <akaher@vmware.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <shuah@kernel.org>, <skhan@linuxfoundation.org>,
        <yeweihua4@huawei.com>
References: <b62e6539-7b25-c8ab-6b6c-47e723023297@huawei.com>
 <20230906142652.191866-1-naresh.kamboju@linaro.org>
 <20230906103718.0405ccb4@gandalf.local.home>
 <20230906173706.7aeb8716@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230906173706.7aeb8716@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/7 05:37, Steven Rostedt wrote:
> On Wed, 6 Sep 2023 10:37:18 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> Log details,
>>> -------------
>>> # ok 45 ftrace - test tracing error log support
>>> <47>[ 1373.662292] systemd-journald[90]: Sent WATCHDOG=1 notification.
>>> # ok 46 Test creation and deletion of trace instances while setting an event
>>
>> It's definitely a race with the creation and deletion of instances.
>>
>> I'm going to run it on my laptop VM and see if that reproduces it. My other
>> VM is on a pretty powerful machine, and perhaps that's keeping it from
>> hitting the race.
> 
> Putting in a while loop of:
> 
>    # while :; do ./ftracetest test.d/instances/instance-event.tc ; done
> 

In test.d/instances/instance-event.tc, concurrently create/delete/access
intances just about 1 second and then killed them, it may cause missing
the race.

No longer sleep and kill, following testcase can also reproduce:
```
#!/bin/bash

cd /sys/kernel/tracing/instances

instance_slam() {
   while :; do
           mkdir foo 2> /dev/null
           rmdir foo 2> /dev/null
   done
}

instance_set() {
         while :; do
                 echo 1 > foo/events/sched/sched_switch/enable
         done 2> /dev/null
}

instance_slam &
p1=$!
echo $p1

instance_set &
p2=$!
echo $p2
```

--

Thanks,
Zheng Yejian

> eventually triggered the bug. Looks like this is really an existing bug not
> related to the eventfs, but the eventfs code actually opened up the window
> of this race.
> 
> Hopefully I'll have a fix shortly.
> 
> -- Steve
> 

