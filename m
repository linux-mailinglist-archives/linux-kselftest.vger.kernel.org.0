Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8340793E48
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbjIFOBm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 10:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241384AbjIFOBm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 10:01:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B47172C;
        Wed,  6 Sep 2023 07:01:37 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RgkVH39wbzMl7W;
        Wed,  6 Sep 2023 21:58:15 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 22:01:35 +0800
Message-ID: <77c3a142-0a03-8fa2-e5b5-cea9515065f4@huawei.com>
Date:   Wed, 6 Sep 2023 22:01:35 +0800
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
 <fcc5d688-9d58-3b4c-58de-472330160142@huawei.com>
 <20230906094306.67a51feb@gandalf.local.home>
 <20230906094553.388cd787@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230906094553.388cd787@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/9/6 21:45, Steven Rostedt wrote:
> On Wed, 6 Sep 2023 09:43:06 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> also can be reproduced with the newest:
>>> 65d6e954e378 ("Merge tag 'gfs2-v6.5-rc5-fixes' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2")
>>>
>>> And revert commit 27152bceea1d ("eventfs: Move tracing/events to
>>> eventfs"), the issue just seems gone.
>>
>> The reason I'm asking is that there could be something added that fixes it.
>> I'm testing Linus's tree at: cbb557ba92f08b945e2cb20b7ab37ef49ab53cdd
> 
> Never mind, I just noticed that your above sha includes this one.
> 
> Not sure why I can't reproduce this. I'm using qemu as well.
> 

Will the qemu version have an impact? Mine is:

$ qemu-system-x86_64 --version
QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.27)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

--

Thanks,
Zheng Yejian

> -- Steve
> 

