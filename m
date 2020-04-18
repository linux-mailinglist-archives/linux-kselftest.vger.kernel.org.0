Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7411AEA17
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 07:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgDRF6v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 01:58:51 -0400
Received: from mail.loongson.cn ([114.242.206.163]:37840 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgDRF6v (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 01:58:51 -0400
Received: from [10.130.0.79] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxXesVl5pe00YpAA--.21S3;
        Sat, 18 Apr 2020 13:58:47 +0800 (CST)
Subject: Re: [PATCH 3/4] kmod: Return directly if module name is empty in
 request_module()
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
 <1587187200-13109-3-git-send-email-yangtiezhu@loongson.cn>
 <20200418054519.GX11244@42.do-not-panic.com>
 <CAB=NE6XD7XCmsTAg3+mw=b8WZnKJiwha5t4DBJFt5w+b_DsNkg@mail.gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b9c6e6e6-571a-b957-755f-72f2b0f538c5@loongson.cn>
Date:   Sat, 18 Apr 2020 13:58:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAB=NE6XD7XCmsTAg3+mw=b8WZnKJiwha5t4DBJFt5w+b_DsNkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxXesVl5pe00YpAA--.21S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18Jr1UJF4fWw17Aw13Arb_yoW8Jw15pF
        W8tFWvqF18tr129FZxt3Z3WFyI9395JF48Wa1Yqr12qrn0qrnaq3WUua1Uu34FvF4fGryI
        yr4kZa1a9343JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
        6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/18/2020 01:48 PM, Luis Chamberlain wrote:
> On Fri, Apr 17, 2020 at 11:45 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>> On Sat, Apr 18, 2020 at 01:19:59PM +0800, Tiezhu Yang wrote:
>>> If module name is empty, it is better to return directly at the beginning
>>> of request_module() without doing the needless call_modprobe() operation.
>>>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> ---
>>>   kernel/kmod.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/kernel/kmod.c b/kernel/kmod.c
>>> index 3cd075c..5851444 100644
>>> --- a/kernel/kmod.c
>>> +++ b/kernel/kmod.c
>>> @@ -28,6 +28,8 @@
>>>
>>>   #include <trace/events/module.h>
>>>
>>> +#define MODULE_NOT_FOUND 256
>>> +
>>>   /*
>>>    * Assuming:
>>>    *
>>> @@ -144,6 +146,9 @@ int __request_module(bool wait, const char *fmt, ...)
>>>        if (ret >= MODULE_NAME_LEN)
>>>                return -ENAMETOOLONG;
>>>
>>> +     if (strlen(module_name) == 0)
>>> +             return MODULE_NOT_FOUND;
>> I'd rather we just use something standard like -EINVAL.
>> What do we return if its not found? Then use that value.
> Also, are we testing for this condition yet? If not can we add one?

Yes, kmod_test_0001_driver() in tools/testing/selftests/kmod/kmod.sh tests
this case and expects result MODULE_NOT_FOUND which is 256.

