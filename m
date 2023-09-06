Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA5793370
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 03:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbjIFBmw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 21:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjIFBmv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 21:42:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4BCE2;
        Tue,  5 Sep 2023 18:42:46 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RgQ5n1ClzzMlCH;
        Wed,  6 Sep 2023 09:39:25 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 09:42:44 +0800
Message-ID: <9cad73cd-1f8b-2f3f-cda4-99b89a87b931@huawei.com>
Date:   Wed, 6 Sep 2023 09:42:44 +0800
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
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230905183638.2b539fae@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/6 06:36, Steven Rostedt wrote:
> On Tue, 5 Sep 2023 20:54:40 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> Hi, Steve, Ajay,
>>
>> After this patch and run this testcase, I got an use-after-free report
>> by KASAN. Short log see [1], full logs see attach "panic.log".
>>
>> And by simple bisect, I found it may be introduced by:
>>
>>     27152bceea1d ("eventfs: Move tracing/events to eventfs")
>>
>> Link:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=27152bceea1df27ffebb12ac9cd9adbf2c4c3f35
> 
> Hi Zheng,
> 
> Can you test:
> 
>     https://lore.kernel.org/all/20230905183332.628d7cc0@gandalf.local.home/
> 
> and see if it fixes the KASAN issue for you?

Hi, Steve, your new patch seems not fixes the KASAN issue.

I run the instance-event.tc with your patch again and get same KASAN 
report.

My config is in:
 
https://lore.kernel.org/all/da5495b5-cdb5-cb82-dd9b-37e7a87ed97d@huawei.com/

> 
> Thanks!
> 
> -- Steve
> 

